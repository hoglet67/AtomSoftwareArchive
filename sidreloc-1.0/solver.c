/* Copyright (c) 2012 Linus Akesson
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <err.h>
#include <getopt.h>

#include "reloc.h"

#define HASHSIZE 8192

#define C_EXACTLY_ONE	1
#define C_ALIKE		2

struct constraint {
	uint8_t			check_needed;
	uint8_t			kind;
	uint16_t		n1, n2;
	uint16_t		vars[];
};

struct constraintlist {
	struct constraintlist	*next;
	struct constraint	*c;
};

struct progbyte *progbytes;
int progsize;
uint16_t progbyte_org;

int add_constraints;

static struct constraintlist *hashconstr[HASHSIZE], *zpconstr[0x100];

#define ARENASIZE	32768
static struct arena {
	struct arena	*next;
	struct source	data[ARENASIZE];
} *arena;
static int arena_index = ARENASIZE;

static struct source prealloc[0x10000];

static int cmp_offset(const void *avoid, const void *bvoid) {
	const uint16_t *a = (const uint16_t *) avoid;
	const uint16_t *b = (const uint16_t *) bvoid;
	return *a - *b;
}

static void print_constraint(struct constraint *constr) {
	int i;

	if(constr->kind == C_EXACTLY_ONE) {
		fprintf(stderr, "Exactly one reloc: {");
		for(i = 0; i < constr->n1; i++) {
			fprintf(stderr, "%s$%04x", (i? ", " : ""), constr->vars[i] + progbyte_org);
		}
		fprintf(stderr, "}\n");
	} else if(constr->kind == C_ALIKE) {
		fprintf(stderr, "Reloc alike: {");
		for(i = 0; i < constr->n1; i++) {
			fprintf(stderr, "%s$%04x", (i? ", " : ""), constr->vars[i] + progbyte_org);
		}
		fprintf(stderr, "}, {");
		for(i = 0; i < constr->n2; i++) {
			fprintf(stderr, "%s$%04x", (i? ", " : ""), constr->vars[constr->n1 + i] + progbyte_org);
		}
		fprintf(stderr, "}\n");
	} else {
		fprintf(stderr, "Unknown constraint!\n");
	}
}

static void add_constraint_ref(uint16_t offset, struct constraint *c) {
	struct progbyte *pb = &progbytes[offset];
	struct constraintlist *cl = malloc(sizeof(struct constraintlist));

	cl->c = c;
	cl->next = pb->constr;
	pb->constr = cl;
}

static int constrainthash(struct constraint *c) {
	int i, h = 0;

	for(i = 0; i < c->n1 + c->n2; i++) {
		h += c->vars[i];
		h %= HASHSIZE;
	}
	return h;
}

static void add_or_free_constraint(struct constraintlist **list, struct constraint *constr) {
	struct constraintlist *cl;
	int for_real = 0;
	int h;

	if(constr->n1 > 1) qsort(constr->vars, constr->n1, sizeof(uint16_t), cmp_offset);
	if(constr->n2 > 1) qsort(constr->vars + constr->n1, constr->n2, sizeof(uint16_t), cmp_offset);

	if(!list) {
		h = constrainthash(constr);
		list = &hashconstr[h];
		for_real = 1;
	}

	for(cl = *list; cl; cl = cl->next) {
		if(cl->c->kind == constr->kind
		&& cl->c->n1 == constr->n1
		&& cl->c->n2 == constr->n2) {
			if(!memcmp(
				cl->c,
				constr,
				sizeof(struct constraint) + sizeof(uint16_t) * (constr->n1 + constr->n2)))
			{
				free(constr);
				return;
			}
		}
	}

	if(for_real && verbose >= 2) {
		fprintf(stderr, "Adding constraint: ");
		print_constraint(constr);
	}

	cl = malloc(sizeof(struct constraintlist));
	cl->c = constr;
	cl->next = *list;
	*list = cl;
}

void finalise_constraints(struct core *core) {
	int i, zp, h;
	struct constraintlist *cl, *nextcl;
	struct constraint *constr;

	for(zp = 0; zp < 0x100; zp++) {
		if(core->written[zp]) {
			for(cl = zpconstr[zp]; cl; cl = nextcl) {
				nextcl = cl->next;
				add_or_free_constraint(0, cl->c);
				free(cl);
			}
		} else {
			for(cl = zpconstr[zp]; cl; cl = nextcl) {
				nextcl = cl->next;
				free(cl->c);
				free(cl);
			}
		}
	}

	for(h = 0; h < HASHSIZE; h++) {
		for(cl = hashconstr[h]; cl; cl = cl->next) {
			constr = cl->c;
			for(i = 0; i < constr->n1 + constr->n2; i++) {
				add_constraint_ref(constr->vars[i], constr);
			}
		}
	}
}

static int enforce_dont(uint16_t offset) {
	struct constraintlist *cl;

	if(progbytes[offset].flags & PBF_RELOC) {
		return 1;
	} else if(!(progbytes[offset].flags & PBF_DONT_RELOC)) {
		progbytes[offset].flags |= PBF_DONT_RELOC;
		for(cl = progbytes[offset].constr; cl; cl = cl->next) {
			cl->c->check_needed = 1;
		}
	}
	return 0;
}

static int enforce_do(uint16_t offset) {
	struct constraintlist *cl;

	if(progbytes[offset].flags & PBF_DONT_RELOC) {
		return 1;
	} else if(!(progbytes[offset].flags & PBF_RELOC)) {
		progbytes[offset].flags |= PBF_RELOC;
		for(cl = progbytes[offset].constr; cl; cl = cl->next) {
			cl->c->check_needed = 1;
		}
	}
	return 0;
}

static int propagate(struct constraint *c) {
	c->check_needed = 0;

	if(c->kind == C_EXACTLY_ONE) {
		int i, n_do = 0, n_dont = 0, n_unknown = 0;
		int last_do = 0, last_unknown = 0;

		for(i = 0; i < c->n1; i++) {
			struct progbyte *pb = &progbytes[c->vars[i]];

			if(pb->flags & PBF_RELOC) {
				n_do++;
				last_do = i;
			} else if(pb->flags & PBF_DONT_RELOC) {
				n_dont++;
			} else {
				n_unknown++;
				last_unknown = i;
			}
		}

		if(n_do == 1) {
			for(i = 0; i < c->n1; i++) {
				if(i != last_do) {
					if(enforce_dont(c->vars[i])) return 1;
				}
			}
			return 0;
		} else if(n_do > 1) {
			return 1;
		} else {
			// n_do == 0, exactly one of the unknown vars must be reloced
			if(n_unknown == 0) {
				return 1;
			} else if(n_unknown == 1) {
				return enforce_do(c->vars[last_unknown]);
			} else {
				// We cannot propagate; leave the rest to search.
				return 0;
			}
		}
	} else if(c->kind == C_ALIKE) {
		int i, n1_do = 0, n2_do = 0;

		for(i = 0; i < c->n1; i++) {
			struct progbyte *pb = &progbytes[c->vars[i]];

			if(pb->flags & PBF_RELOC) {
				n1_do++;
			}
		}

		for(i = 0; i < c->n2; i++) {
			struct progbyte *pb = &progbytes[c->vars[i]];

			if(pb->flags & PBF_RELOC) {
				n2_do++;
			}
		}

		if(n1_do > 1 || n2_do > 1) return 1;
		return n1_do != n2_do;
	} else {
		return 1;
	}
}

int trivially_inconsistent() {
	int i;

	for(i = 0; i < progsize + 2; i++) {
		struct progbyte *pb = &progbytes[i];

		if((pb->flags & (PBF_USED_IN_ZP | PBF_USED_IN_MSB)) == (PBF_USED_IN_ZP | PBF_USED_IN_MSB)) {
			// If a byte contributes to both a zero-page address and an msb, it cannot
			// be relocatable.
			pb->flags |= PBF_DONT_RELOC;
		}

		if((pb->flags & (PBF_RELOC | PBF_DONT_RELOC)) == (PBF_RELOC | PBF_DONT_RELOC)) {
			fprintf(stderr,
				"Inconsistency detected! Byte at $%04x can't be both relocated and not relocated at the same time.\n",
				i + progbyte_org);
			return 1;
		}
	}

	return 0;
}

int solver() {
	struct constraintlist *cl;
	struct constraint *c;
	int done;
	int h, i, j;
	struct progbyte *pb = 0;
	int pboffs = 0;

	/* Propagate. */

	do {
		done = 1;
		for(h = 0; h < HASHSIZE; h++) {
			for(cl = hashconstr[h]; cl; cl = cl->next) {
				c = cl->c;
				if(c->check_needed) {
					done = 0;
					if(propagate(c)) return 1;
				}
			}
		}
	} while(!done);

	/* Search -- select a variable */

	for(h = 0; h < HASHSIZE && !pb; h++) {
		for(cl = hashconstr[h]; cl && !pb; cl = cl->next) {
			c = cl->c;
			for(i = 0; i < c->n1 + c->n2; i++) {
				if(!(progbytes[c->vars[i]].flags & (PBF_RELOC | PBF_DONT_RELOC))) {
					pboffs = c->vars[i];
					pb = &progbytes[pboffs];
					break;
				}
			}
		}
	}

	if(pb) {
		/* Search -- select a value */

		int btsize = progsize + 2;
		uint8_t *backtrack = malloc(btsize);

		for(j = 0; j < btsize; j++) {
			backtrack[j] = progbytes[j].flags;
		}

		if(verbose >= 2) {
			fprintf(stderr,
				"Guessing that $%04x should not be relocated.\n",
				pboffs + progbyte_org);
		}

		if(enforce_dont(pboffs) || solver()) {
			if(verbose >= 2) {
				fprintf(stderr, "Backtracking.\n");
			}
			for(j = 0; j < btsize; j++) {
				progbytes[j].flags = backtrack[j];
			}
			free(backtrack);
			if(verbose >= 2) {
				fprintf(stderr,
					"Assuming that $%04x should be relocated.\n",
					pboffs + progbyte_org);
			}
			return enforce_do(pboffs) || solver();
		} else {
			free(backtrack);
			return 0;
		}
	} else return 0;
}

/* Fast routines that are called during analysis (emulation). Contradictions are not
 * checked at this stage. */

#if 0
void dont_reloc_at(uint16_t offset) {
	assert(offset < progsize + 2);
	progbytes[offset].flags |= PBF_DONT_RELOC;
}

void dont_reloc(struct source *src) {
	if(add_constraints) {
		while(src) {
			dont_reloc_at(src->offset);
			assert(src);
			src = src->next;
		}
	}
}
#endif

static void do_reloc_at(uint16_t offset) {
	progbytes[offset].flags |= PBF_RELOC;
}

static void progbyte_for_zp(uint16_t offset, uint8_t zpaddr) {
	progbytes[offset].flags |= PBF_USED_IN_ZP;
	progbytes[offset].zpaddr[zpaddr >> 3] |= 1 << (zpaddr & 7);
}

static void progbyte_for_msb(uint16_t offset) {
	progbytes[offset].flags |= PBF_USED_IN_MSB;
}

void prealloc_cons_cells() {
	int i;

	for(i = 0; i < 0x10000; i++) {
		prealloc[i].offset = i;
		prealloc[i].next = 0;
	}
}

struct source *cons_src(uint16_t offset, struct source *cdr) {
	struct source *s;

	if(add_constraints) {
		if(progbytes[offset].flags & PBF_DONT_RELOC) {
			// This progbyte can't possibly be relocatable, so
			// there's no need to add it to the list.
			return cdr;
		}

		if(!cdr) {
			return &prealloc[offset];
		}

		for(s = cdr; s; s = s->next) {
			if(s->offset == offset) {
				for(s = s->next; s; s = s->next) {
					if(s->offset == offset) {
						// No need to add the same program byte more
						// than twice to a list.
						return cdr;
					}
				}
				break;
			}
		}

		if(arena_index >= ARENASIZE) {
			struct arena *a = calloc(sizeof(struct arena), 1);
			a->next = arena;
			arena = a;
			arena_index = 0;
		}
		s = &arena->data[arena_index++];

		s->offset = offset;
		s->next = cdr;
		return s;
	} else {
		return 0;
	}
}

void gc_arena(struct core *core) {
	struct arena *a, **aptr;
	struct source *s;
	int i, count = 0;

	if(arena) {
		for(a = arena->next; a; a = a->next) {
			for(i = 0; i < ARENASIZE; i++) {
				a->data[i].used = 0;
			}
		}

		for(i = 0; i < 65536; i++) {
			for(s = core->memory[i].src; s; s = s->next) {
				s->used = 1;
			}
		}

		for(aptr = &arena->next; *aptr; ) {
			a = *aptr;
			for(i = 0; i < ARENASIZE; i++) {
				if(a->data[i].used) break;
			}
			if(i == ARENASIZE) {
				count++;
				*aptr = a->next;
				free(a);
			} else {
				aptr = &a->next;
			}
		}
	}

	if(verbose >= 3) {
		fprintf(stderr, "Reclaimed %d arenas.\n", count);
	}
}

void free_arena() {
	struct arena *a;
	int count = 0;

	while((a = arena)) {
		arena = a->next;
		free(a);
		count++;
	}
	arena_index = ARENASIZE;
	if(verbose >= 3) fprintf(stderr, "Freed %d arenas.\n", count);
}

static void reloc_exactly_one(struct source *src, uint8_t zpaddr) {
	int n_unknown = 0, n_dont = 0, n_do = 0;
	struct source *s, *s2;
	uint16_t last_do = 0, last_unknown = 0;

	for(s = src; s; s = s->next) {
		for(s2 = s->next; s2; s2 = s2->next) {
			if(s->offset == s2->offset) {
				// The same progbyte contributes more than
				// once. It cannot be relocated.
				if(verbose >= 2) {
					fprintf(stderr,
						"Byte at $%04x contributes more than once to a sum and won't be relocated.\n",
						s->offset + progbyte_org);
				}
				dont_reloc_at(s->offset);
			}
		}
	}

	for(s = src; s; s = s->next) {
		if(progbytes[s->offset].flags & PBF_DONT_RELOC) {
			n_dont++;
		} else if(progbytes[s->offset].flags & PBF_RELOC) {
			n_do++;
			last_do = s->offset;
		} else {
			n_unknown++;
			last_unknown = s->offset;
		}
	}

	if(zpaddr) {
		struct constraint *constr;
		int pos = 0;

		constr = malloc(sizeof(struct constraint) + sizeof(uint16_t) * (n_do + n_unknown));
		constr->check_needed = 1;
		constr->kind = C_EXACTLY_ONE;
		constr->n1 = n_do + n_unknown;
		constr->n2 = 0;
		for(s = src; s; s = s->next) {
			if(!(progbytes[s->offset].flags & PBF_DONT_RELOC)) {
				constr->vars[pos++] = s->offset;
			}
		}
		assert(pos == n_do + n_unknown);

		add_or_free_constraint(&zpconstr[zpaddr], constr);
	} else {
		if(n_do) {
			// n_do is typically 1 here.
			// If n_do > 1, this will introduce an inconsistency which we can detect later.
			for(s = src; s; s = s->next) {
				if(s->offset != last_do) dont_reloc_at(s->offset);
			}
		} else {
			// n_do is 0, so one of the unknown vars must be relocated.
			if(n_unknown == 1) {
				do_reloc_at(last_unknown);
			} else if(n_unknown == 0) {
				fprintf(stderr, "Inconsistency: Want to relocate one of {");
				for(s = src; s; s = s->next) {
					fprintf(stderr, "$%04x%s", s->offset + progbyte_org, s->next? ", " : "");
				}
				fprintf(stderr, "} but this would contradict other equations.\n");
				exit(RET_CONSTR);
			} else {
				struct constraint *constr;
				int pos = 0;

				constr = malloc(sizeof(struct constraint) + sizeof(uint16_t) * n_unknown);
				constr->check_needed = 1;
				constr->kind = C_EXACTLY_ONE;
				constr->n1 = n_unknown;
				constr->n2 = 0;
				for(s = src; s; s = s->next) {
					if(!(progbytes[s->offset].flags & (PBF_RELOC | PBF_DONT_RELOC))) {
						constr->vars[pos++] = s->offset;
					}
				}
				assert(pos == n_unknown);

				add_or_free_constraint(0, constr);
			}
		}
	}
}

void reloc_alike(value_t v1, value_t v2) {
	struct source *s;

	if(add_constraints) {
		if(v1.value >= (reloc_start >> 8) && v1.value <= (reloc_end >> 8)
		&& v2.value >= (reloc_start >> 8) && v2.value <= (reloc_end >> 8)) {
			struct constraint *constr;
			int n1 = 0, n2 = 0;
			int pos = 0;

			for(s = v1.src; s; s = s->next) n1++;
			for(s = v2.src; s; s = s->next) n2++;
			constr = malloc(sizeof(struct constraint) + sizeof(uint16_t) * (n1 + n2));

			constr->check_needed = 1;
			constr->kind = C_ALIKE;
			constr->n1 = n1;
			constr->n2 = n2;
			for(s = v1.src; s; s = s->next) {
				constr->vars[pos++] = s->offset;
			}
			for(s = v2.src; s; s = s->next) {
				constr->vars[pos++] = s->offset;
			}
			assert(pos == n1 + n2);

			add_or_free_constraint(0, constr);
		}
	}
}

void used_for_zp_addr(struct source *src1, struct source *src2, uint8_t zpaddr) {
	struct source *s, *list;

	if(add_constraints) {
		for(s = src1; s; s = s->next) progbyte_for_zp(s->offset, zpaddr);
		for(s = src2; s; s = s->next) progbyte_for_zp(s->offset, zpaddr);

		if(do_zp_reloc) {
			list = src1;
			for(s = src2; s; s = s->next) list = cons_src(s->offset, list);
			reloc_exactly_one(list, zpaddr);
		}
	}
}

void check_reloc_range(uint16_t addr, struct source *lsb1, struct source *lsb2, struct source *msb) {
	if(add_constraints) {
		struct source *s;

		for(s = msb; s; s = s->next) {
			progbyte_for_msb(s->offset);
		}
		if(addr >= reloc_start && addr <= reloc_end) {
			dont_reloc(lsb1);
			if(lsb2) dont_reloc(lsb2);
			reloc_exactly_one(msb, 0);
		} else if(addr < 0x100) {
			dont_reloc(msb);
			used_for_zp_addr(lsb1, lsb2, addr);
		} else {
			dont_reloc(msb);
			dont_reloc(lsb1);
			if(lsb2) dont_reloc(lsb2);
		}
	}
}

void init_progbytes(uint16_t loadaddr, uint16_t loadsize) {
	progbyte_org = loadaddr - 2;
	progsize = loadsize;
	progbytes = calloc(sizeof(struct progbyte), progsize + 2);
	progbytes[0].flags = PBF_DONT_RELOC;
	progbytes[1].flags = PBF_RELOC | PBF_USED_IN_MSB;
}

void reloc_map(struct core *oldcore, uint16_t reloc_offs) {
	int n_reloc = 0, n_zp = 0, n_dont = 0, n_unused = 0, n_unknown = 0;
	int i;
	int addr;
	uint16_t org;

	fprintf(stderr, "Program map:");
	org = progbyte_org + 2;
	for(addr = org & 0xffc0; addr <= ((org + progsize - 1) | 0x003f); addr++) {
		if(!(addr & 0x3f)) {
			fprintf(stderr, "\n%04x, %04x:  ", addr, (addr + reloc_offs) & 0xffff);
		}
		if(addr < org || addr >= org + progsize) {
			fprintf(stderr, " ");
		} else {
			i = addr - progbyte_org;
			if(progbytes[i].flags & PBF_RELOC) {
				if(progbytes[i].flags & PBF_USED_IN_MSB) {
					fprintf(stderr, "R");
					n_reloc++;
				} else if(progbytes[i].flags & PBF_USED_IN_ZP) {
					fprintf(stderr, "Z");
					n_zp++;
				} else {
					fprintf(stderr, "e");	// internal error
				}
			} else if(progbytes[i].flags & PBF_DONT_RELOC) {
				fprintf(stderr, "=");
				n_dont++;
			} else if(!(oldcore->read[addr] | oldcore->written[addr])) {
				fprintf(stderr, ".");
				n_unused++;
			} else {
				fprintf(stderr, "?");
				n_unknown++;
			}
		}
	}
	fprintf(stderr, "\n");
	fprintf(stderr, "MSB relocations       (R): %d\n", n_reloc);
	fprintf(stderr, "Zero-page relocations (Z): %d\n", n_zp);
	fprintf(stderr, "Static bytes          (=): %d\n", n_dont);
	fprintf(stderr, "Status undetermined   (?): %d\n", n_unknown);
	fprintf(stderr, "Unused bytes          (.): %d\n", n_unused);
}

