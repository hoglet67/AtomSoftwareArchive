#ifndef __RELOC_H
#define __RELOC_H

#include <stdint.h>
#include <assert.h>

#define RELEASE "1.0"

/* Represent bytes as 8-bit values tagged with meta-information. */
/* List nodes (struct source) are arena-allocated; no need to track the references. */

struct source {
	struct source	*next;
	uint16_t	offset;
	uint8_t		used;
};

typedef struct {
	uint8_t		value;
	struct source	*src;
} value_t;

struct core {
	value_t		memory[65536];
	uint8_t		read[65536];		// These (read/written) are booleans, but
	uint8_t		written[65536];		// kept separate for performance reasons.
};

struct progbyte {
	uint8_t			flags;
	uint8_t			zpaddr[32];	// one bit per address, little-endian
	struct constraintlist	*constr;
};

#define PBF_DONT_RELOC	0x01
#define PBF_RELOC	0x02
#define PBF_USED_IN_ZP	0x04
#define PBF_USED_IN_MSB	0x08

enum {
	RET_SUCCESS,
	RET_HEADER,
	RET_RSID,
	RET_MUS,
	RET_BASIC,
	RET_PSID,
	RET_PARAM,
	RET_IO,
	RET_CONSTR,
	RET_ZPFULL,
	RET_VERIFY,
	RET_PLAYADDR,
	RET_RANGE,
	RET_CYCLES,
};

enum {
	ERR_OK,
	ERR_BRK,
	ERR_INTERNAL,
	ERR_ILLEGAL,
	ERR_CYCLES,
};

extern char *emulate_err[];

extern struct progbyte *progbytes;
extern int progsize;

extern uint16_t reloc_start, reloc_end;
extern int add_constraints;
extern int verbose;
extern int do_zp_reloc;

struct source *cons_src(uint16_t car, struct source *cdr);
void check_reloc_range(uint16_t addr, struct source *lsb1, struct source *lsb2, struct source *msb);
void reloc_alike(value_t v1, value_t v2);
void used_for_zp_addr(struct source *src1, struct source *src2, uint8_t zpaddr);
void init_progbytes(uint16_t loadaddr, uint16_t loadsize);
int trivially_inconsistent();
int solver();
void free_arena();
void gc_arena(struct core *core);
void reloc_map(struct core *oldcore, uint16_t reloc_offs);
int emulate(struct core *core, uint16_t start_addr, uint8_t acc, int max_cycles);
void finalise_constraints(struct core *core);
void prealloc_cons_cells();

#if 1
static inline void dont_reloc_at(uint16_t offset) {
	assert(offset != 1);
	assert(offset < progsize + 2);
	progbytes[offset].flags |= PBF_DONT_RELOC;
}

static inline void dont_reloc(struct source *src) {
	if(add_constraints) {
		while(src) {
			dont_reloc_at(src->offset);
			assert(src);
			src = src->next;
		}
	}
}
#else
void dont_reloc_at(uint16_t offset);
void dont_reloc(struct source *src);
#endif

#endif
