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

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <err.h>
#include <getopt.h>
#include <math.h>

#include "reloc.h"

struct sidheader {
	uint8_t			rsid;
	uint8_t			nsubtune;
	uint8_t			defsubtune;
	uint16_t		version;
	uint16_t		dataoffset;
	uint16_t		loadaddr;
	uint16_t		loadsize;
	uint16_t		initaddr;
	uint16_t		playaddr;
	char			title[32];
	char			author[32];
	char			released[32];
};

static struct zeropage {
	uint8_t			link;
	uint8_t			reloc;
	uint8_t			free;
} zeropage[256];

#define RETF_OUTOFBOUNDS 0x20
#define RETF_TOLERANCE 0x40

static int cycles_init = 1000000;
static int cycles_play = 20000;
static int play_calls = 100000;
static int nmi_calls = 200;
static int cycles_nmi = 1000;

int do_zp_reloc = 1;
int verbose = 0;
int quiet = 0;
int force = 0;

uint16_t reloc_start;
uint16_t reloc_end;

static int exitbits;
static int nmi_reported;

static struct core oldcore, newcore;

static int readheader(struct sidheader *head, uint8_t *data, int filesize) {
	if(filesize <= 0x80) return 1;
	if(data[0] == 'P') {
		head->rsid = 0;
	} else if(data[0] == 'R') {
		head->rsid = 1;
	} else return 1;
	if(data[1] != 'S') return 1;
	if(data[2] != 'I') return 1;
	if(data[3] != 'D') return 1;
	head->version = (data[4] << 8) | data[5];
	if(head->version < 1 || head->version > 2) return 1;
	head->dataoffset = (data[6] << 8) | data[7];
	if(head->version == 1 && head->dataoffset != 0x76) return 1;
	if(head->version == 2 && head->dataoffset != 0x7c) return 1;
	head->loadaddr = (data[8] << 8) | data[9];
	if(!head->loadaddr) {
		head->loadaddr = data[head->dataoffset] | (data[head->dataoffset + 1] << 8);
		head->dataoffset += 2;
	}
	head->loadsize = filesize - head->dataoffset;
	if(head->loadaddr < 0x7e8 && head->rsid) errx(RET_RSID, "RSID standard violation");
	head->initaddr = (data[0x0a] << 8) | data[0x0b];
	if(!head->initaddr) head->initaddr = head->loadaddr;
	head->playaddr = (data[0x0c] << 8) | data[0x0d];
	head->nsubtune = (data[0x0e] << 8) | data[0x0f];
	head->defsubtune = (data[0x10] << 8) | data[0x11];
	memcpy(head->title, &data[0x16], sizeof(head->title));
	memcpy(head->author, &data[0x36], sizeof(head->author));
	memcpy(head->released, &data[0x56], sizeof(head->released));
	head->title[31] = 0;
	head->author[31] = 0;
	head->released[31] = 0;
	if(head->version > 1) {
		uint16_t flags = (data[0x76] << 8) | data[0x77];
		if(flags & 1) errx(RET_MUS, "MUS format not supported");
		if(head->rsid && (flags & 2)) errx(RET_BASIC, "BASIC tunes not supported");
		if(!head->rsid && (flags & 2)) errx(RET_PSID, "PSID tunes not supported");
	}
	return 0;
}

static void init_core(struct core *core, uint8_t *data, uint16_t loadaddr, uint16_t loadsize) {
	int i;

	memset(core->memory, 0, sizeof(core->memory));

	for(i = 0xea31; i <= 0xea86; i++) {
		core->memory[i].value = 0x68;	// pla
	}

	for(i = 0; i < loadsize; i++) {
		core->memory[loadaddr + i].value = data[i];
		core->memory[loadaddr + i].src = cons_src(i + 2, 0);
	}
}

static uint16_t get_from_vector(struct core *core, uint16_t fallback, uint16_t vaddr) {
	uint16_t vector = core->memory[vaddr].value | (core->memory[vaddr + 1].value << 8);
	if(vector) {
		check_reloc_range(vector, core->memory[vaddr].src, 0, core->memory[vaddr + 1].src);
		return vector;
	} else return fallback;
}

static void init_tune(struct core *core, uint16_t initaddr, int tune) {
	int errcode = emulate(core, initaddr, tune, cycles_init);
	if(errcode == ERR_CYCLES) errx(RET_CYCLES | exitbits, "Max cycles exhausted during init routine. Infinite loop?");
	if(errcode) fprintf(stderr, "%s\n", emulate_err[errcode - 1]);
}

static int play_step(struct core *core, uint16_t playaddr, char *errprefix) {
	int errcode;
	uint16_t digiaddr;
	int i;
	int allow_digi = 1;

	playaddr = get_from_vector(core, playaddr, 0x0314);
	playaddr = get_from_vector(core, playaddr, 0xfffe);

	if(!playaddr) {
		playaddr = get_from_vector(core, playaddr, 0x0318);
		playaddr = get_from_vector(core, playaddr, 0xfffa);
		allow_digi = 0;
	}

	if(!playaddr) errx(RET_PLAYADDR, "%sCouldn't determine address of playroutine.", errprefix);

	errcode = emulate(core, playaddr, 0, cycles_play);
	if(errcode == ERR_CYCLES && !force) {
		errx(RET_CYCLES | exitbits, "Max cycles exhausted during playroutine. Infinite loop?");
	}
	if(errcode) {
		fprintf(stderr, "%s%s\n", errprefix, emulate_err[errcode - 1]);
	} else if(allow_digi) {
		digiaddr = get_from_vector(core, 0, 0x0318);
		digiaddr = get_from_vector(core, digiaddr, 0xfffa);
		if(digiaddr) {
			if(!nmi_reported) {
				fprintf(stderr, "Use of digis detected. NMI routine will also be relocated.\n");
				nmi_reported = 1;
			}
			for(i = 0; i < nmi_calls; i++) {
				errcode = emulate(core, digiaddr, 0, cycles_nmi);
				if(errcode == ERR_CYCLES && !force) {
					errx(RET_CYCLES | exitbits, "Max cycles exhausted during NMI routine. Infinite loop?");
				}
				if(errcode) break;
			}
		}
	}

	return errcode;
}

static void verify_sidstate(value_t *oldmem, value_t *newmem, int frame, int *n_badpitch, int *n_badpw) {
	int i;
	int badp[3] = {0, 0, 0}, badpw[3] = {0, 0, 0};

	for(i = 0; i < 29; i++) {
		if(oldmem[0xd400 + i].value != newmem[0xd400 + i].value) {
			if(i < 21 && (i % 7) < 2) {
				badp[i / 7] = 1;
			} else if(i < 21 && (i % 7) < 4) {
				badpw[i / 7] = 1;
			} else {
				fprintf(stderr, "Wrong SID state! ");
				if(frame >= 0) {
					fprintf(stderr, "At time %d, ", frame); 
				} else {
					fprintf(stderr, "After the init routine, ");
				}
				fprintf(stderr, "$d4%02x should be $%02x, but the relocated code has written $%02x.\n",
					i,
					oldmem[0xd400 + i].value,
					newmem[0xd400 + i].value);
				if(!force) exit(RET_VERIFY | exitbits);
			}
		}
	}
	*n_badpitch += badp[0] + badp[1] + badp[2];
	*n_badpw += badpw[0] + badpw[1] + badpw[2];
}

static void zeropage_map() {
	int i;

	fprintf(stderr, "Old zero-page addresses:  ");
	for(i = 2; i < 256; i++) {
		if(oldcore.written[i]) fprintf(stderr, " %02x", i);
	}
	fprintf(stderr, "\nNew zero-page addresses:  ");
	for(i = 2; i < 256; i++) {
		if(oldcore.written[i]) fprintf(stderr, " %02x", (i + zeropage[i].reloc) & 0xff);
	}
	fprintf(stderr, "\n");
}

static void version() {
	printf("sidreloc " RELEASE "\n");
	printf("Created in 2012 by Linus Akesson.\n");
	printf("Contains a 6510 emulator based on lib6502 by Ian Piumarta.\n");
	printf("Project homepage: http://www.linusakesson.net/software/sidreloc/\n");
}

static void usage() {
	printf("sidreloc " RELEASE " by Linus Akesson\n");
	printf("\n");
	printf("Usage: sidreloc [OPTIONS] input.sid output.sid\n");
	printf("\n");
	printf("Options:\n");
	printf("Short name  Long name      Default     Description\n");
	printf("\n");
	printf("  -p        --page         10          First memory page (in hex) to be occupied by\n");
	printf("                                       the relocated SID.\n");
	printf("  -z        --zp-reloc     80-ff       Range of free zero-page addresses that the\n");
	printf("                                       relocated SID can use.\n");
	printf("  -k        --no-zp-reloc              Keep all zero-page addresses as they appear\n");
	printf("                                       in the original SID.\n");
	printf("  -r        --reloc        (from SID)  Range to relocate, e.g. \"50-5f\" for a 4 kB\n");
	printf("                                       SID originally located at $5000. Must include\n");
	printf("                                       the entire loading range of the SID.\n");
	printf("\n");
	printf("  -t        --tolerance    2           Tolerance (in percent) for wrong pitches.\n");
	printf("  -s        --strict                   Verify pulse widths.\n");
	printf("  -f        --force                    Write output file even if verification fails.\n");
	printf("\n");
	printf("  -v        --verbose                  Output some statistics and a nice map of all\n");
	printf("                                       the relocations.\n");
	printf("  -q        --quiet                    Don't whine about writing out of bounds.\n");
	printf("\n");
	printf("            --frames       100000      Number of times to call the playroutine of\n");
	printf("                                       each subtune. The default corresponds to\n");
	printf("                                       approximately 33 minutes of a PAL tune.\n");
	printf("            --nmi-calls    200         Number of times to call the NMI routine per\n");
	printf("                                       frame (the CIA2 timer setting is ignored).\n");
	printf("            --init-cycles  1000000     Max number of clock cycles for init routine.\n");
	printf("            --play-cycles  20000       Max number of clock cycles for playroutine.\n");
	printf("            --nmi-cycles   1000        Max number of clock cycles for NMI routine.\n");
	printf("\n");
	printf("  -h        --help                     Display this information.\n");
	printf("  -V        --version                  Display brief version information and credits.\n");
	printf("\n");
	printf("Project homepage: http://www.linusakesson.net/software/sidreloc/\n");
	exit(0);
}

static int readfile(uint8_t *data, char *filename) {
	int filesize;
	FILE *f = fopen(filename, "rb");
	if(!f) err(RET_IO, "%s", filename);
	filesize = fread(data, 1, 65536, f);
	fclose(f);
	return filesize;
}

static void writefile(uint8_t *data, char *filename, int filesize) {
	FILE *f = fopen(filename, "wb");
	if(!f) err(RET_IO | exitbits, "%s", filename);
	if(fwrite(data, 1, filesize, f) != filesize) err(RET_IO | exitbits, "fwrite");
	fclose(f);
}

static void report_oob(uint16_t first, uint16_t last) {
	if(!quiet && first != 0xd400) {
		if(first == last) {
			fprintf(stderr, "Warning: Write out of bounds at address $%04x\n", first);
		} else {
			fprintf(stderr, "Warning: Write out of bounds at address $%04x-$%04x\n", first, last);
		}
	}
}

enum {
	OPT_FRAMES = 256,
	OPT_NMI_CALLS,
	OPT_INIT_CYCLES,
	OPT_PLAY_CYCLES,
	OPT_NMI_CYCLES
};

int main(int argc, char **argv) {
	uint8_t data[65536], newdata[65536];
	int filesize;
	int i, j, k, errcode, opt;
	struct sidheader head;
	uint16_t reloc_offset;
	uint8_t page_used[256];
	int n_check = 0, n_badpitch = 0, n_badpw = 0;
	int perc_badpitch, perc_badpw;
	uint16_t ooblast, oobchunk;

	struct option longopts[] = {
		{"page", 1, 0, 'p'},
		{"zp-reloc", 1, 0, 'z'},
		{"no-zp-reloc", 0, 0, 'k'},
		{"reloc", 1, 0, 'r'},
		{"tolerance", 1, 0, 't'},
		{"strict", 0, 0, 's'},
		{"force", 0, 0, 'f'},
		{"verbose", 0, 0, 'v'},
		{"quiet", 0, 0, 'q'},
		{"frames", 1, 0, OPT_FRAMES},
		{"init-cycles", 1, 0, OPT_INIT_CYCLES},
		{"play-cycles", 1, 0, OPT_PLAY_CYCLES},
		{"nmi-cycles", 1, 0, OPT_NMI_CYCLES},
		{"nmi-calls", 1, 0, OPT_NMI_CALLS},
		{"help", 0, 0, 'h'},
		{"version", 0, 0, 'V'},
		{0, 0, 0, 0}
	};
	char *filename;
	char *outputname;
	int first_zp = 0x80, last_zp = 0xff;
	int given_reloc_start = -1, given_reloc_end = -1;
	int dest_page = 0x10;
	int tolerance = 2;
	int strictpw = 0;

	/* Parse the command line options. */

	do {
		opt = getopt_long(argc, argv, "p:z:kr:t:sfvqF:I:P:hV", longopts, 0);
		switch(opt) {
			case 0:
			case '?':
			case 'h':
				usage();
				break;
			case 'V':
				version();
				exit(0);
				break;
			case 'p':
				if(!(1 == sscanf(optarg, "%x", &dest_page)
				&& dest_page >= 0x00
				&& dest_page <= 0xff)) {
					errx(RET_PARAM, "Invalid page number (should be a hexadecimal number in the range 00-ff)");
				}
				break;
			case 'z':
				if(!(2 == sscanf(optarg, "%x-%x", &first_zp, &last_zp)
				&& first_zp >= 0x02
				&& first_zp <= 0xff
				&& last_zp >= 0x02
				&& last_zp <= 0xff
				&& first_zp <= last_zp)) {
					errx(RET_PARAM, "Invalid zero-page address range (should be two hexadecimal numbers in the range 02-ff)");
				}
				break;
			case 'k':
				do_zp_reloc = 0;
				break;
			case 'r':
				if(!(2 == sscanf(optarg, "%x-%x", &given_reloc_start, &given_reloc_end)
				&& given_reloc_start >= 0x01
				&& given_reloc_start <= 0xff
				&& given_reloc_end >= 0x01
				&& given_reloc_end <= 0xff
				&& given_reloc_start <= given_reloc_end)) {
					errx(RET_PARAM, "Invalid relocation range (should be two hexadecimal numbers in the range 01-ff)");
				}
				break;
			case 't':
				if(!(1 == sscanf(optarg, "%d", &tolerance)
				&& tolerance >= 0
				&& tolerance < 100)) {
					errx(RET_PARAM, "Invalid tolerance percentage (should be an integer in the range 0-100)");
				}
				break;
			case 's':
				strictpw = 1;
				break;
			case 'f':
				force = 1;
				break;
			case 'v':
				verbose++;
				break;
			case 'q':
				quiet = 1;
				break;
			case OPT_FRAMES:
				if(!(1 == sscanf(optarg, "%d", &play_calls)
				&& play_calls >= 0)) {
					errx(RET_PARAM, "Invalid number of calls to the playroutine.");
				}
				break;
			case OPT_NMI_CALLS:
				if(!(1 == sscanf(optarg, "%d", &nmi_calls)
				&& nmi_calls >= 0)) {
					errx(RET_PARAM, "Invalid number of calls to the NMI routine.");
				}
				break;
			case OPT_INIT_CYCLES:
				if(!(1 == sscanf(optarg, "%d", &cycles_init)
				&& cycles_init >= 0)) {
					errx(RET_PARAM, "Invalid cycle limit for the init routine.");
				}
				break;
			case OPT_PLAY_CYCLES:
				if(!(1 == sscanf(optarg, "%d", &cycles_play)
				&& cycles_play >= 0)) {
					errx(RET_PARAM, "Invalid cycle limit for the playroutine.");
				}
				break;
			case OPT_NMI_CYCLES:
				if(!(1 == sscanf(optarg, "%d", &cycles_nmi)
				&& cycles_nmi >= 0)) {
					errx(RET_PARAM, "Invalid cycle limit for the NMI routine.");
				}
				break;
		}
	} while(opt >= 0);

	argc -= optind;
	argv += optind;

	if(argc != 2) usage();

	filename = argv[0];
	outputname = argv[1];

	/* Read the SID file. */

	filesize = readfile(data, filename);
	if(readheader(&head, data, filesize)) errx(RET_HEADER, "Bad SID file header");
	if(verbose >= 0) {
		fprintf(stderr, "%s, %s, %s, $%04x-$%04x, %d subtunes\n",
			head.title,
			head.author,
			head.released,
			head.loadaddr,
			head.loadaddr + head.loadsize - 1,
			head.nsubtune);
	}

	/* Determine the relocation area. */

	reloc_start = head.loadaddr & 0xff00;
	reloc_end = (head.loadaddr + head.loadsize - 1) | 0x00ff;

	for(i = 0; i < 64 && reloc_end != 0xcfff && reloc_end != 0xffff; i++) {
		reloc_end += 0x100;
	}

	if(given_reloc_start >= 0) {
		reloc_start = given_reloc_start << 8;
		reloc_end = (given_reloc_end << 8) | 0xff;
		if(reloc_start > head.loadaddr
		|| reloc_end < (head.loadaddr + head.loadsize - 1)) {
			errx(RET_RANGE,
				"Relocation range (-r) must contain all the SID data! (SID loads at $%04x-$%04x)",
				head.loadaddr,
				head.loadaddr + head.loadsize - 1);
		}
	}

	reloc_offset = (dest_page << 8) - reloc_start;

	fprintf(stderr, "Relocating from $%04x-$%04x to $%04x-$%04x\n",
		reloc_start,
		reloc_end,
		(reloc_start + reloc_offset) & 0xffff,
		(reloc_end + reloc_offset) & 0xffff);

	if(reloc_start < 0x100 || reloc_end < reloc_start
	|| ((reloc_start + reloc_offset) & 0xffff) < 0x100
	|| ((reloc_end + reloc_offset) & 0xffff) < ((reloc_start + reloc_offset) & 0xffff)) {
		errx(RET_RANGE, "Neither the source nor the destination relocation range may overlap with the zero-page.");
	}

	prealloc_cons_cells();

	/* Visit all subtunes. */

	init_progbytes(head.loadaddr, head.loadsize);
	add_constraints = 1;

	for(i = 0; i < head.nsubtune; i++) {
		fprintf(stderr, "Analysing subtune %d\n", i + 1);
		nmi_reported = 0;
		init_core(&oldcore, &data[head.dataoffset], head.loadaddr, head.loadsize);
		init_tune(&oldcore, head.initaddr, i);
		for(j = 0; j < play_calls; j++) {
			if(play_step(&oldcore, head.playaddr, "")) break;
		}
		gc_arena(&oldcore);
	}

	/* Report bad memory accesses, possibly remove some zero-page addresses from the constraints. */

	oobchunk = ooblast = 0xd400;
	for(i = 0; i < 65536; i++) {
		if(i >= head.loadaddr && i < head.loadaddr + head.loadsize) {
			/* Inside tune, ok */
		} else if(i >= 0xd400 && i <= 0xd41f) {
			/* SID register area, ok */
		} else if(i >= 2 && i < 0x100) {
			if(oldcore.read[i] && !oldcore.written[i]) {
				if(!quiet) {
					fprintf(stderr,
						"Warning: Zero-page address $%02x read but never written.%s\n",
						i,
						(do_zp_reloc? " Not relocating it." : ""));
				}
				for(j = 0; j < progsize; j++) {
					struct progbyte *pb = &progbytes[j + 2];
					if((pb->flags & PBF_USED_IN_ZP) && pb->zpaddr[i >> 3] & (1 << (i & 7))) {
						pb->zpaddr[i >> 3] &= ~(1 << (i & 7)); 
						for(k = 0; k < 32; k++) if(pb->zpaddr[k]) break;
						if(k == 32) pb->flags &= ~(PBF_RELOC | PBF_USED_IN_ZP);
					}
				}
			}
		} else {
			if(oldcore.written[i]) {
				exitbits |= RETF_OUTOFBOUNDS;
				if(ooblast != i - 1) {
					report_oob(oobchunk, ooblast);
					oobchunk = i;
				}
				ooblast = i;
			}
		}
	}
	report_oob(oobchunk, ooblast);

	finalise_constraints(&oldcore);

	/* Find a solution to the set of constraints. */

	if(trivially_inconsistent() || solver()) errx(RET_CONSTR | exitbits, "No solution found");

	/* Map the zero-page addresses to new locations. */

	for(i = 0; i < 256; i++) {
		zeropage[i].link = i;
		zeropage[i].free = (i >= first_zp && i <= last_zp);
	}

	for(i = 0; i < progsize; i++) {
		struct progbyte *pb = &progbytes[i + 2];
		if((pb->flags & (PBF_RELOC | PBF_USED_IN_ZP)) == (PBF_RELOC | PBF_USED_IN_ZP)) {
			int first = -1;
			for(j = 0; j < 256; j++) {
				if(pb->zpaddr[j >> 3] & (1 << (j & 7))) {
					if(first != -1) {
						// One relocated program byte contributes to
						// several zero-page addresses. Link them.
						if(zeropage[j].link > zeropage[first].link) {
							zeropage[j].link = zeropage[first].link;
						} else {
							zeropage[first].link = zeropage[j].link;
						}
					} else {
						first = j;
					}
				}
			}
		}
	}

	for(i = 0; i < 256; i++) {
		if(zeropage[i].link != zeropage[zeropage[i].link].link) {
			zeropage[i].link = zeropage[zeropage[i].link].link;
		}
	}

	if(do_zp_reloc) {
		int chunk, dest;

		for(chunk = 2; chunk < 0x100; chunk++) {
			if(oldcore.written[chunk] && (zeropage[chunk].link == chunk)) {
				// We have a chunk to place somewhere.
				for(dest = first_zp; dest <= last_zp; dest++) {
					// Try to put it at dest.
					for(i = chunk; i < 0x100; i++) {
						if(zeropage[i].link == chunk) {
							if(!zeropage[(dest + i - chunk) & 0xff].free) {
								break;
							}
						}
					}
					if(i == 0x100) {
						// It fits!
						for(i = chunk; i < 0x100; i++) {
							if(zeropage[i].link == chunk) {
								zeropage[i].reloc = dest - chunk;
								zeropage[dest + i - chunk].free = 0;
							}
						}
						break;
					}
				}
				if(dest > last_zp) {
					errx(RET_ZPFULL | exitbits,
						"Can't fit all zero-page addresses into specified range ($%02x-$%02x).",
						first_zp,
						last_zp);
				}
			}
		}
	}

	/* Draw a map. */

	if(verbose >= 1) {
		reloc_map(&oldcore, reloc_offset);
		zeropage_map();
	}

	/* Perform the relocation. */

	memcpy(newdata, data, sizeof(newdata));
	for(i = 0; i < progsize; i++) {
		struct progbyte *pb = &progbytes[i + 2];
		if(pb->flags & PBF_RELOC) {
			if(pb->flags & PBF_USED_IN_MSB) {
				newdata[head.dataoffset + i] += reloc_offset >> 8;
			} else {
				for(j = 2; j < 256; j++) {
					if(pb->zpaddr[j / 8] & (1 << (j & 7))) {
						break;
					}
				}
				if(j < 256) {
					newdata[head.dataoffset + i] += zeropage[j].reloc;
				}
			}
		}
	}

	/* Verify the relocated subtunes. */

	free_arena();
	free(progbytes);
	progbytes = 0;
	add_constraints = 0;

	for(i = 0; i < head.nsubtune; i++) {
		fprintf(stderr, "Verifying relocated subtune %d\n", i + 1);
		init_core(&oldcore, &data[head.dataoffset], head.loadaddr, head.loadsize);
		init_core(&newcore, &newdata[head.dataoffset], (head.loadaddr + reloc_offset) & 0xffff, head.loadsize);

		init_tune(&oldcore, head.initaddr, i);

		reloc_start += reloc_offset;
		reloc_end += reloc_offset;

		init_tune(&newcore, (head.initaddr + reloc_offset) & 0xffff, i);

		n_check += 3;
		verify_sidstate(oldcore.memory, newcore.memory, -1, &n_badpitch, &n_badpw);

		for(j = 0; j < play_calls; j++) {
			reloc_start -= reloc_offset;
			reloc_end -= reloc_offset;

			errcode = play_step(&oldcore, head.playaddr, "Old version: ");
			if(errcode) break;

			reloc_start += reloc_offset;
			reloc_end += reloc_offset;

			errcode = play_step(&newcore, (head.playaddr? ((head.playaddr + reloc_offset) & 0xffff) : 0), "New version: ");
			if(errcode) {
				if(force) {
					break;
				} else {
					errx(RET_VERIFY | exitbits, "Verification failed");
				}
			}

			n_check += 3;
			verify_sidstate(oldcore.memory, newcore.memory, j, &n_badpitch, &n_badpw);
		}

		reloc_start -= reloc_offset;
		reloc_end -= reloc_offset;
	}

	if(!n_check) n_check = 1;
	perc_badpitch = round(n_badpitch * 100.0 / n_check);
	perc_badpw = round(n_badpw * 100.0 / n_check);
	fprintf(stderr, "Bad pitches:               %d, %d%%\n", n_badpitch, perc_badpitch);
	fprintf(stderr, "Bad pulse widths:          %d, %d%%\n", n_badpw, perc_badpw);
	if(n_badpitch || n_badpw) {
		exitbits |= RETF_TOLERANCE;
		if(!force) {
			if(n_badpitch && (!tolerance || (perc_badpitch > tolerance))) {
				errx(RET_VERIFY | exitbits, "Relocation failed; too many mismatching pitches.\n");
			} else if(n_badpw && strictpw) {
				errx(RET_VERIFY | exitbits, "Relocation failed; mismatching pulse widths and strict flag given.\n");
			}
		}
	}
	if(n_badpitch) {
		fprintf(stderr, "Relocation successful with some mismatching pitches.\n");
	} else if(n_badpw) {
		fprintf(stderr, "Relocation successful with some mismatching pulse widths.\n");
	} else {
		fprintf(stderr, "Relocation successful.\n");
	}

	/* Relocate all pointers in the header. */

	if(newdata[0x08] | newdata[0x09]) {
		newdata[0x08] += reloc_offset >> 8;
	} else {
		newdata[head.dataoffset - 1] += reloc_offset >> 8;
	}
	if(newdata[0x0a] | newdata[0x0b]) {
		newdata[0x0a] += reloc_offset >> 8;
	}
	if(newdata[0x0c] | newdata[0x0d]) {
		newdata[0x0c] += reloc_offset >> 8;
	}

	/* Determine where replayer code could go. */

	memset(page_used, 0, sizeof(page_used));
	if(head.version > 1) {
		int best_start, best_n, curr_start, curr_n;

		for(i = 0; i < 256; i++) {
			if((i >= 0x00 && i <= 0x03)
			|| (i >= 0xa0 && i <= 0xbf)
			|| (i >= 0xd0 && i <= 0xff)
			|| (i >= (((head.loadaddr + reloc_offset) & 0xffff) >> 8)
			&& i <= (((head.loadaddr + head.loadsize - 1 + reloc_offset) & 0xffff) >> 8))) {
				page_used[i] = 1;
			} else {
				for(j = 0; j < 256; j++) {
					if(newcore.read[(i << 8) | j]
					|| newcore.written[(i << 8) | j]) {
						page_used[i] = 1;
						break;
					}
				}
			}
		}
		best_start = curr_start = 0;
		best_n = curr_n = 0;
		for(i = 0; i < 256; i++) {
			if(page_used[i]) {
				if(curr_n > best_n) {
					best_start = curr_start;
					best_n = curr_n;
				}
				curr_start = i + 1;
				curr_n = 0;
			} else {
				curr_n++;
			}
		}
		if(curr_n > best_n) {
			best_start = curr_start;
			best_n = curr_n;
		}
		if(best_n) {
			if(verbose >= 1) {
				fprintf(stderr,
					"Largest unused region:     $%02x00-$%02xff\n",
					best_start,
					best_start + best_n - 1);
			}
			newdata[0x78] = best_start;
			newdata[0x79] = best_n;
		} else {
			if(verbose >= 1) {
				fprintf(stderr, "No space left for replay routine!\n");
			}
			newdata[0x78] = 0xff;
			newdata[0x79] = 0;
		}
	}

	/* Write the relocated SID file. */

	writefile(newdata, outputname, filesize);

	return RET_SUCCESS | exitbits;
}
