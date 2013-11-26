/* Heavily modified 6510 emulator by Linus Akesson.
 *
 * Based on a proper 6502 emulator by Ian Piumarta, with the original copyright
 * notice below. My modifications to this file are hereby provided under the
 * same license.
 */

/* Copyright (c) 2005 Ian Piumarta
 * 
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the 'Software'),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, provided that the above copyright notice(s) and this
 * permission notice appear in all copies of the Software and that both the
 * above copyright notice(s) and this permission notice appear in supporting
 * documentation.
 *
 * THE SOFTWARE IS PROVIDED 'AS IS'.  USE ENTIRELY AT YOUR OWN RISK.
 */

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

#include "reloc.h"

typedef uint8_t  byte;
typedef uint16_t word;

enum {
	flagN= (1<<7),	/* negative	*/
	flagV= (1<<6),	/* overflow 	*/
	flagX= (1<<5),	/* unused	*/
	flagB= (1<<4),	/* irq from brk	*/
	flagD= (1<<3),	/* decimal mode	*/
	flagI= (1<<2),	/* irq disable	*/
	flagZ= (1<<1),	/* zero		*/
	flagC= (1<<0)	/* carry	*/
};

char *emulate_err[] = {
	"BRK instruction",
	"Internal CPU emulator error",
	"Illegal opcode",
	"Max cycles exhausted (infinite loop?)",
};

#define getN()	(P & flagN)
#define getV()	(P & flagV)
#define getB()	(P & flagB)
#define getD()	(P & flagD)
#define getI()	(P & flagI)
#define getZ()	(P & flagZ)
#define getC()	(P & flagC)

#define setNVZC(N,V,Z,C)	(P= (P & ~(flagN | flagV | flagZ | flagC)) | (N) | ((V)<<6) | ((Z)<<1) | (C))
#define setNZC(N,Z,C)		(P= (P & ~(flagN |         flagZ | flagC)) | (N) |            ((Z)<<1) | (C))
#define setNZ(N,Z)		(P= (P & ~(flagN |         flagZ        )) | (N) |            ((Z)<<1)      )
#define setZ(Z)			(P= (P & ~(                flagZ        )) |                  ((Z)<<1)      )
#define setC(C)			(P= (P & ~(                        flagC)) |                             (C))

#define tick(n) if(max_cycles < n) return ERR_CYCLES; max_cycles -= n
#ifdef ACCURATE_TIMING
#define tickIf(p) if(p) { tick(1); }
#else
#define tickIf(p)
#endif

/* memory access -- ARGUMENTS ARE EVALUATED MORE THAN ONCE! */

#define putMemory(ADDR, VALUE)		\
	memory[ADDR] = (VALUE);		\
	core->written[ADDR] = 1;

#define getMemory(ADDR)	(core->read[ADDR] = 1, memory[ADDR])

/* stack access (always direct) */

#define push(VALUE)	(memory[0x0100 + S--] = (VALUE))
#define pop()		(memory[++S + 0x0100])

/* adressing modes (memory access direct) */

#define implied(ticks)				\
  tick(ticks);

#define immediate(ticks)			\
  tick(ticks);					\
  src_ea_msb = src_pc_msb;			\
  ea = PC++;

#define abs(ticks)					\
  tick(ticks);						\
  core->read[PC] = 1;					\
  core->read[PC + 1] = 1;				\
  src_ea_msb = memory[PC + 1].src;			\
  ea = memory[PC].value + (memory[PC + 1].value << 8);	\
  check_reloc_range(ea, memory[PC].src, 0, src_ea_msb);	\
  PC += 2;

#define relative(ticks)				\
  tick(ticks);					\
  core->read[PC] = 1;				\
  dont_reloc(memory[PC].src);			\
  src_ea_msb = src_pc_msb;			\
  ea = memory[PC++].value;			\
  if (ea & 0x80) ea -= 0x100;			\
  tickIf((ea >> 8) != (PC >> 8));

#define indirect(ticks)							\
  tick(ticks);								\
  {									\
    word tmp;								\
    core->read[PC] = 1;							\
    core->read[PC + 1] = 1;						\
    tmp = memory[PC].value + (memory[PC + 1].value << 8);		\
    check_reloc_range(tmp, memory[PC].src, 0, memory[PC + 1].src);	\
    core->read[tmp] = 1;						\
    core->read[tmp + 1] = 1;						\
    src_ea_msb = memory[tmp + 1].src;					\
    ea = memory[tmp].value + (memory[tmp + 1].value << 8);		\
    check_reloc_range(ea, memory[tmp].src, 0, src_ea_msb);		\
    PC += 2;								\
  }

#define absx(ticks)							\
  tick(ticks);								\
  core->read[PC] = 1;							\
  core->read[PC + 1] = 1;						\
  src_ea_msb = memory[PC + 1].src;					\
  ea = memory[PC].value + (memory[PC + 1].value << 8);			\
  tickIf((ticks == 4) && ((ea >> 8) != ((ea + X.value) >> 8)));		\
  ea += X.value;							\
  check_reloc_range(ea, memory[PC].src, X.src, src_ea_msb);		\
  PC += 2;

#define absy(ticks)							\
  tick(ticks);								\
  core->read[PC] = 1;							\
  core->read[PC + 1] = 1;						\
  src_ea_msb = memory[PC + 1].src;					\
  ea = memory[PC].value + (memory[PC + 1].value << 8);			\
  tickIf((ticks == 4) && ((ea >> 8) != ((ea + Y.value) >> 8)));		\
  ea += Y.value;							\
  check_reloc_range(ea, memory[PC].src, Y.src, src_ea_msb);		\
  PC += 2;

#define zp(ticks)					\
  tick(ticks);						\
  core->read[PC] = 1;					\
  src_ea_msb = 0;					\
  ea = memory[PC].value;				\
  used_for_zp_addr(memory[PC].src, 0, ea);		\
  PC++;

#define zpx(ticks)					\
  tick(ticks);						\
  core->read[PC] = 1;					\
  src_ea_msb = 0;					\
  ea = memory[PC].value + X.value;			\
  ea &= 0x00ff;						\
  used_for_zp_addr(memory[PC].src, X.src, ea);		\
  PC++;

#define zpy(ticks)					\
  tick(ticks);						\
  core->read[PC] = 1;					\
  src_ea_msb = 0;					\
  ea = memory[PC].value + Y.value;			\
  ea &= 0x00ff;						\
  used_for_zp_addr(memory[PC].src, Y.src, ea);		\
  PC++;

#define indx(ticks)							\
  tick(ticks);								\
  {									\
    byte tmp = memory[PC].value + X.value;				\
    core->read[PC] = 1;							\
    used_for_zp_addr(memory[PC].src, X.src, tmp);			\
    used_for_zp_addr(memory[PC].src, X.src, tmp + 1);			\
    core->read[tmp] = 1;						\
    core->read[tmp + 1] = 1;						\
    src_ea_msb = memory[tmp + 1].src;					\
    ea = memory[tmp].value + (memory[tmp + 1].value << 8);		\
    check_reloc_range(ea, memory[tmp].src, 0, src_ea_msb);		\
    PC++;								\
  }

#define indy(ticks)							\
  tick(ticks);								\
  {									\
    byte tmp = memory[PC].value;					\
    core->read[PC] = 1;							\
    used_for_zp_addr(memory[PC].src, 0, tmp);				\
    used_for_zp_addr(memory[PC].src, 0, tmp + 1);			\
    PC++;								\
    core->read[tmp] = 1;						\
    core->read[tmp + 1] = 1;						\
    src_ea_msb = memory[tmp + 1].src;					\
    ea = memory[tmp].value + (memory[tmp + 1].value << 8);		\
    tickIf((ticks == 5) && ((ea >> 8) != ((ea + Y.value) >> 8)));	\
    ea += Y.value;							\
    check_reloc_range(ea, memory[tmp].src, Y.src, src_ea_msb);		\
  }

/* insns */

#define adc(ticks, adrmode)											\
  adrmode(ticks);												\
  {														\
    value_t B = getMemory(ea);											\
    if (!getD())												\
      {														\
        struct source *src;											\
	int c = A.value + B.value + getC();									\
	int v = (int8_t) A.value + (int8_t) B.value + getC();							\
	fetch();												\
	A.value = c;												\
	for(src = B.src; src; src = src->next) A.src = cons_src(src->offset, A.src);				\
	setNVZC((A.value & 0x80), (((A.value & 0x80) > 0) ^ (v < 0)), (A.value == 0), ((c & 0x100) > 0));	\
	goto_next();												\
      }														\
    else													\
      {														\
	int l, h, s;												\
	/* inelegant & slow, but consistent with the hw for illegal digits */					\
	l = (A.value & 0x0F) + (B.value & 0x0F) + getC();							\
	h = (A.value & 0xF0) + (B.value & 0xF0);								\
	if (l >= 0x0A) { l -= 0x0A;  h += 0x10; }								\
	if (h >= 0xA0) { h -= 0xA0; }										\
	fetch();												\
	s = h | (l & 0x0F);											\
	/* only C is valid on NMOS 6502 */									\
	setNVZC(s & 0x80, !(((A.value ^ B.value) & 0x80) && ((A.value ^ s) & 0x80)), !s, !!(h & 0x80));		\
	A.value = s;												\
	A.src = 0;												\
	tick(1);												\
	goto_next();												\
      }														\
  }

#define sbc(ticks, adrmode)										\
  adrmode(ticks);											\
  {													\
    value_t B = getMemory(ea);										\
    if (!getD())											\
      {													\
	int b = 1 - (P &0x01);										\
	int c = A.value - B.value - b;									\
	int v = (int8_t) A.value - (int8_t) B.value - b;						\
	fetch();											\
	A.value = c;											\
	setNVZC(A.value & 0x80, ((A.value & 0x80) > 0) ^ ((v & 0x100) != 0), A.value == 0, c >= 0);	\
	goto_next();											\
      }													\
    else												\
      {													\
	/* this is verbatim ADC, with a 10's complemented operand */					\
	int l, h, s;											\
	B.value = 0x99 - B.value;									\
	l = (A.value & 0x0F) + (B.value & 0x0F) + getC();						\
	h = (A.value & 0xF0) + (B.value & 0xF0);							\
	if (l >= 0x0A) { l -= 0x0A;  h += 0x10; }							\
	if (h >= 0xA0) { h -= 0xA0; }									\
	fetch();											\
	s = h | (l & 0x0F);										\
	/* only C is valid on NMOS 6502 */								\
	setNVZC(s & 0x80, !(((A.value ^ B.value) & 0x80) && ((A.value ^ s) & 0x80)), !s, !!(h & 0x80));	\
	A.value = s;											\
	A.src = 0;											\
	tick(1);											\
	goto_next();											\
      }													\
  }

#define cmpR(ticks, adrmode, R)			\
  adrmode(ticks);				\
  fetch();					\
  {						\
    value_t B = getMemory(ea);			\
    byte d = R.value - B.value;			\
    reloc_alike(B, R);				\
    setNZC(d & 0x80, !d, R.value >= B.value);	\
  }						\
  goto_next();

#define cmp(ticks, adrmode)	cmpR(ticks, adrmode, A)
#define cpx(ticks, adrmode)	cmpR(ticks, adrmode, X)
#define cpy(ticks, adrmode)	cmpR(ticks, adrmode, Y)

#define dec(ticks, adrmode)			\
  adrmode(ticks);				\
  fetch();					\
  {						\
    value_t B = getMemory(ea);			\
    --B.value;					\
    putMemory(ea, B);				\
    setNZ(B.value & 0x80, !B.value);		\
  }						\
  goto_next();

#define decR(ticks, adrmode, R)			\
  fetch();					\
  tick(ticks);					\
  --R.value;					\
  setNZ(R.value & 0x80, !R.value);		\
  goto_next();

#define dex(ticks, adrmode)	decR(ticks, adrmode, X)
#define dey(ticks, adrmode)	decR(ticks, adrmode, Y)

#define inc(ticks, adrmode)			\
  adrmode(ticks);				\
  fetch();					\
  {						\
    value_t B = getMemory(ea);			\
    ++B.value;					\
    putMemory(ea, B);				\
    setNZ(B.value & 0x80, !B.value);		\
  }						\
  goto_next();

#define incR(ticks, adrmode, R)			\
  fetch();					\
  tick(ticks);					\
  ++R.value;					\
  setNZ(R.value & 0x80, !R.value);		\
  goto_next();

#define inx(ticks, adrmode)	incR(ticks, adrmode, X)
#define iny(ticks, adrmode)	incR(ticks, adrmode, Y)

#define bit(ticks, adrmode)					\
  adrmode(ticks);						\
  fetch();							\
  {								\
    value_t B = getMemory(ea);					\
    P = (P & ~(flagN | flagV | flagZ))				\
      | (B.value & (0xC0)) | (((A.value & B.value) == 0) << 1);	\
  }								\
  goto_next();

#define eor(ticks, adrmode)			\
  adrmode(ticks);				\
  fetch();					\
  {						\
    value_t b = getMemory(ea);			\
    reloc_alike(A, b);				\
    A.value ^= b.value;				\
    A.src = 0;					\
  }						\
  setNZ(A.value & 0x80, !A.value);		\
  goto_next();

#define bitwise(ticks, adrmode, op)		\
  adrmode(ticks);				\
  fetch();					\
  {						\
    value_t b = getMemory(ea);			\
    A.value op##= b.value;			\
    A.src = 0;					\
  }						\
  setNZ(A.value & 0x80, !A.value);		\
  goto_next();

#define and(ticks, adrmode)	bitwise(ticks, adrmode, &)
#define ora(ticks, adrmode)	bitwise(ticks, adrmode, |)

#define asl(ticks, adrmode)			\
  adrmode(ticks);				\
  {						\
    value_t b = getMemory(ea);			\
    unsigned int i = b.value << 1;		\
    b.value = i;				\
    b.src = 0;					\
    putMemory(ea, b);				\
    fetch();					\
    setNZC(i & 0x80, !i, i >> 8);		\
  }						\
  goto_next();

#define asla(ticks, adrmode)			\
  tick(ticks);					\
  fetch();					\
  {						\
    int c = A.value >> 7;			\
    A.value <<= 1;				\
    A.src = 0;					\
    setNZC(A.value & 0x80, !A.value, c);	\
  }						\
  goto_next();

#define lsr(ticks, adrmode)			\
  adrmode(ticks);				\
  {						\
    value_t b = getMemory(ea);			\
    int c= b.value & 1;				\
    fetch();					\
    b.value >>= 1;				\
    b.src = 0;					\
    putMemory(ea, b);				\
    setNZC(0, !b.value, c);			\
  }						\
  goto_next();

#define lsra(ticks, adrmode)			\
  tick(ticks);					\
  fetch();					\
  {						\
    int c = A.value & 1;			\
    A.value >>= 1;				\
    A.src = 0;					\
    setNZC(0, !A.value, c);			\
  }						\
  goto_next();

#define rol(ticks, adrmode)			\
  adrmode(ticks);				\
  {						\
    value_t v = getMemory(ea);			\
    word b = (v.value << 1) | getC();		\
    v.value = b;				\
    v.src = 0;					\
    fetch();					\
    putMemory(ea, v);				\
    setNZC(b & 0x80, !(b & 0xFF), b >> 8);	\
  }						\
  goto_next();

#define rola(ticks, adrmode)			\
  tick(ticks);					\
  fetch();					\
  {						\
    word b = (A.value << 1) | getC();		\
    A.value = b;				\
    A.src = 0;					\
    setNZC(A.value & 0x80, !A.value, b >> 8);	\
  }						\
  goto_next();

#define ror(ticks, adrmode)			\
  adrmode(ticks);				\
  {						\
    int c = getC();				\
    value_t m = getMemory(ea);			\
    value_t n;					\
    byte b = (c << 7) | (m.value >> 1);		\
    fetch();					\
    n.value = b;				\
    n.src = 0;					\
    putMemory(ea, n);				\
    setNZC(b & 0x80, !b, m.value & 1);		\
  }						\
  goto_next();

#define rora(ticks, adrmode)			\
  adrmode(ticks);				\
  {						\
    int ci = getC();				\
    int co = A.value & 1;			\
    fetch();					\
    A.value = (ci << 7) | (A.value >> 1);	\
    A.src = 0;					\
    setNZC(A.value & 0x80, !A.value, co);	\
  }						\
  goto_next();

#define tRS(ticks, adrmode, R1, R2)		\
  fetch();					\
  tick(ticks);					\
  R2 = R1;					\
  setNZ(R2.value & 0x80, !R1.value);		\
  goto_next();

#define tax(ticks, adrmode)	tRS(ticks, adrmode, A, X)
#define txa(ticks, adrmode)	tRS(ticks, adrmode, X, A)
#define tay(ticks, adrmode)	tRS(ticks, adrmode, A, Y)
#define tya(ticks, adrmode)	tRS(ticks, adrmode, Y, A)

#define tsx(ticks, adrmode)			\
  fetch();					\
  tick(ticks);					\
  X.value = S;					\
  X.src = 0;					\
  setNZ(S & 0x80, !S);				\
  goto_next();

#define txs(ticks, adrmode)			\
  fetch();					\
  tick(ticks);					\
  dont_reloc(X.src);				\
  S = X.value;					\
  goto_next();

#define ldR(ticks, adrmode, R)			\
  adrmode(ticks);				\
  fetch();					\
  R = getMemory(ea);				\
  setNZ(R.value & 0x80, !R.value);		\
  goto_next();

#define lda(ticks, adrmode)	ldR(ticks, adrmode, A)
#define ldx(ticks, adrmode)	ldR(ticks, adrmode, X)
#define ldy(ticks, adrmode)	ldR(ticks, adrmode, Y)

#define stR(ticks, adrmode, R)			\
  adrmode(ticks);				\
  fetch();					\
  putMemory(ea, R);				\
  goto_next();

#define sta(ticks, adrmode)	stR(ticks, adrmode, A)
#define stx(ticks, adrmode)	stR(ticks, adrmode, X)
#define sty(ticks, adrmode)	stR(ticks, adrmode, Y)

#define branch(ticks, adrmode, cond)		\
  if (cond)					\
    {						\
      adrmode(ticks);				\
      PC += ea;					\
      tick(1);					\
    }						\
  else						\
    {						\
      tick(ticks);				\
      PC++;					\
    }						\
  fetch();					\
  goto_next();

#define bcc(ticks, adrmode)	branch(ticks, adrmode, !getC())
#define bcs(ticks, adrmode)	branch(ticks, adrmode,  getC())
#define bne(ticks, adrmode)	branch(ticks, adrmode, !getZ())
#define beq(ticks, adrmode)	branch(ticks, adrmode,  getZ())
#define bpl(ticks, adrmode)	branch(ticks, adrmode, !getN())
#define bmi(ticks, adrmode)	branch(ticks, adrmode,  getN())
#define bvc(ticks, adrmode)	branch(ticks, adrmode, !getV())
#define bvs(ticks, adrmode)	branch(ticks, adrmode,  getV())

#define jmp(ticks, adrmode)			\
  adrmode(ticks);				\
  PC = ea;					\
  src_pc_msb = src_ea_msb;			\
  fetch();					\
  goto_next();

#define jsr(ticks, adrmode)			\
  PC++;						\
  {						\
    value_t v;					\
    v.src = src_pc_msb;				\
    v.value = PC >> 8;				\
    push(v);					\
    v.src = 0;					\
    v.value = PC & 0xff;			\
    push(v);					\
  }						\
  PC--;						\
  adrmode(ticks);				\
  PC = ea;					\
  src_pc_msb = src_ea_msb;			\
  fetch();					\
  goto_next();

#define rts(ticks, adrmode)				\
  tick(ticks);						\
  if(S >= 0xfe) return ERR_OK;				\
  {							\
    value_t lsb = pop();				\
    value_t msb = pop();				\
    PC = lsb.value | (msb.value << 8);			\
    src_pc_msb = msb.src;				\
    check_reloc_range(PC, lsb.src, 0, msb.src);		\
  }							\
  PC++;							\
  fetch();						\
  goto_next();

#define brk(ticks, adrmode)			\
  tick(ticks);					\
  return ERR_BRK;

#define rti(ticks, adrmode)				\
  tick(ticks);						\
  if(S >= 0xfd) return ERR_OK;				\
  {							\
    value_t status = pop();				\
    value_t lsb = pop();				\
    value_t msb = pop();				\
    P = status.value;					\
    PC = lsb.value | (msb.value << 8);			\
    src_pc_msb = msb.src;				\
    dont_reloc(status.src);				\
    check_reloc_range(PC, lsb.src, 0, msb.src);		\
  }							\
  fetch();						\
  goto_next();

#define nop(ticks, adrmode)			\
  adrmode(ticks);				\
  fetch();					\
  goto_next();

#define ill(ticks, adrmode)			\
  goto illegal_instr;

#define pha(ticks, adrmode)			\
  fetch();					\
  tick(ticks);					\
  push(A);					\
  goto_next();

#define php(ticks, adrmode)			\
  fetch();					\
  tick(ticks);					\
  {						\
    value_t v;					\
    v.value = P;				\
    v.src = 0;					\
    push(v);					\
  }						\
  goto_next();

#define pla(ticks, adrmode)			\
  fetch();					\
  tick(ticks);					\
  if(S >= 0xff) return ERR_OK;			\
  A = pop();					\
  setNZ(A.value & 0x80, !A.value);		\
  goto_next();

#define plp(ticks, adrmode)			\
  fetch();					\
  tick(ticks);					\
  if(S >= 0xff) return ERR_OK;			\
  {						\
    value_t v = pop();				\
    dont_reloc(v.src);				\
    P = v.value;				\
  }						\
  goto_next();

#define clF(ticks, adrmode, F)			\
  fetch();					\
  tick(ticks);					\
  P &= ~F;					\
  goto_next();

#define clc(ticks, adrmode)	clF(ticks, adrmode, flagC)
#define cld(ticks, adrmode)	clF(ticks, adrmode, flagD)
#define cli(ticks, adrmode)	clF(ticks, adrmode, flagI)
#define clv(ticks, adrmode)	clF(ticks, adrmode, flagV)

#define seF(ticks, adrmode, F)			\
  fetch();					\
  tick(ticks);					\
  P |= F;					\
  goto_next();

#define sec(ticks, adrmode)	seF(ticks, adrmode, flagC)
#define sed(ticks, adrmode)	seF(ticks, adrmode, flagD)
#define sei(ticks, adrmode)	seF(ticks, adrmode, flagI)

/* Beware! Instruction timing is wrong for the undocumented nops. */

#define do_insns(_)												\
  _(00, brk, implied,   7);  _(01, ora, indx,      6);  _(02, ill, implied,   2);  _(03, ill, implied, 2);      \
  _(04, nop, zp,        3);  _(05, ora, zp,        3);  _(06, asl, zp,        5);  _(07, ill, implied, 2);      \
  _(08, php, implied,   3);  _(09, ora, immediate, 3);  _(0a, asla,implied,   2);  _(0b, ill, implied, 2);      \
  _(0c, nop, abs,       4);  _(0d, ora, abs,       4);  _(0e, asl, abs,       6);  _(0f, ill, implied, 2);      \
  _(10, bpl, relative,  2);  _(11, ora, indy,      5);  _(12, ill, implied,   3);  _(13, ill, implied, 2);      \
  _(14, nop, zpx,       3);  _(15, ora, zpx,       4);  _(16, asl, zpx,       6);  _(17, ill, implied, 2);      \
  _(18, clc, implied,   2);  _(19, ora, absy,      4);  _(1a, nop, implied,   2);  _(1b, ill, implied, 2);      \
  _(1c, nop, absx,      4);  _(1d, ora, absx,      4);  _(1e, asl, absx,      7);  _(1f, ill, implied, 2);      \
  _(20, jsr, abs,       6);  _(21, and, indx,      6);  _(22, ill, implied,   2);  _(23, ill, implied, 2);      \
  _(24, bit, zp,        3);  _(25, and, zp,        3);  _(26, rol, zp,        5);  _(27, ill, implied, 2);      \
  _(28, plp, implied,   4);  _(29, and, immediate, 3);  _(2a, rola,implied,   2);  _(2b, ill, implied, 2);      \
  _(2c, bit, abs,       4);  _(2d, and, abs,       4);  _(2e, rol, abs,       6);  _(2f, ill, implied, 2);      \
  _(30, bmi, relative,  2);  _(31, and, indy,      5);  _(32, ill, implied,   3);  _(33, ill, implied, 2);      \
  _(34, nop, zpx,       4);  _(35, and, zpx,       4);  _(36, rol, zpx,       6);  _(37, ill, implied, 2);      \
  _(38, sec, implied,   2);  _(39, and, absy,      4);  _(3a, nop, implied,   2);  _(3b, ill, implied, 2);      \
  _(3c, nop, absx,      4);  _(3d, and, absx,      4);  _(3e, rol, absx,      7);  _(3f, ill, implied, 2);      \
  _(40, rti, implied,   6);  _(41, eor, indx,      6);  _(42, ill, implied,   2);  _(43, ill, implied, 2);      \
  _(44, nop, zp,        2);  _(45, eor, zp,        3);  _(46, lsr, zp,        5);  _(47, ill, implied, 2);      \
  _(48, pha, implied,   3);  _(49, eor, immediate, 3);  _(4a, lsra,implied,   2);  _(4b, ill, implied, 2);      \
  _(4c, jmp, abs,       3);  _(4d, eor, abs,       4);  _(4e, lsr, abs,       6);  _(4f, ill, implied, 2);      \
  _(50, bvc, relative,  2);  _(51, eor, indy,      5);  _(52, ill, implied,   3);  _(53, ill, implied, 2);      \
  _(54, nop, zpx,       2);  _(55, eor, zpx,       4);  _(56, lsr, zpx,       6);  _(57, ill, implied, 2);      \
  _(58, cli, implied,   2);  _(59, eor, absy,      4);  _(5a, nop, implied,   3);  _(5b, ill, implied, 2);      \
  _(5c, nop, absx,      2);  _(5d, eor, absx,      4);  _(5e, lsr, absx,      7);  _(5f, ill, implied, 2);      \
  _(60, rts, implied,   6);  _(61, adc, indx,      6);  _(62, ill, implied,   2);  _(63, ill, implied, 2);      \
  _(64, nop, zp,        3);  _(65, adc, zp,        3);  _(66, ror, zp,        5);  _(67, ill, implied, 2);      \
  _(68, pla, implied,   4);  _(69, adc, immediate, 3);  _(6a, rora,implied,   2);  _(6b, ill, implied, 2);      \
  _(6c, jmp, indirect,  5);  _(6d, adc, abs,       4);  _(6e, ror, abs,       6);  _(6f, ill, implied, 2);      \
  _(70, bvs, relative,  2);  _(71, adc, indy,      5);  _(72, ill, implied,   3);  _(73, ill, implied, 2);      \
  _(74, nop, zpx,       4);  _(75, adc, zpx,       4);  _(76, ror, zpx,       6);  _(77, ill, implied, 2);      \
  _(78, sei, implied,   2);  _(79, adc, absy,      4);  _(7a, nop, implied,   4);  _(7b, ill, implied, 2);      \
  _(7c, nop, absx,      6);  _(7d, adc, absx,      4);  _(7e, ror, absx,      7);  _(7f, ill, implied, 2);      \
  _(80, nop, immediate, 2);  _(81, sta, indx,      6);  _(82, nop, immediate, 2);  _(83, ill, implied, 2);      \
  _(84, sty, zp,        2);  _(85, sta, zp,        2);  _(86, stx, zp,        2);  _(87, ill, implied, 2);      \
  _(88, dey, implied,   2);  _(89, nop, immediate, 2);  _(8a, txa, implied,   2);  _(8b, ill, implied, 2);      \
  _(8c, sty, abs,       4);  _(8d, sta, abs,       4);  _(8e, stx, abs,       4);  _(8f, ill, implied, 2);      \
  _(90, bcc, relative,  2);  _(91, sta, indy,      6);  _(92, ill, implied,   3);  _(93, ill, implied, 2);      \
  _(94, sty, zpx,       4);  _(95, sta, zpx,       4);  _(96, stx, zpy,       4);  _(97, ill, implied, 2);      \
  _(98, tya, implied,   2);  _(99, sta, absy,      5);  _(9a, txs, implied,   2);  _(9b, ill, implied, 2);      \
  _(9c, ill, implied,   4);  _(9d, sta, absx,      5);  _(9e, ill, implied,   5);  _(9f, ill, implied, 2);      \
  _(a0, ldy, immediate, 3);  _(a1, lda, indx,      6);  _(a2, ldx, immediate, 3);  _(a3, ill, implied, 2);      \
  _(a4, ldy, zp,        3);  _(a5, lda, zp,        3);  _(a6, ldx, zp,        3);  _(a7, ill, implied, 2);      \
  _(a8, tay, implied,   2);  _(a9, lda, immediate, 3);  _(aa, tax, implied,   2);  _(ab, ill, implied, 2);      \
  _(ac, ldy, abs,       4);  _(ad, lda, abs,       4);  _(ae, ldx, abs,       4);  _(af, ill, implied, 2);      \
  _(b0, bcs, relative,  2);  _(b1, lda, indy,      5);  _(b2, ill, implied,   3);  _(b3, ill, implied, 2);      \
  _(b4, ldy, zpx,       4);  _(b5, lda, zpx,       4);  _(b6, ldx, zpy,       4);  _(b7, ill, implied, 2);      \
  _(b8, clv, implied,   2);  _(b9, lda, absy,      4);  _(ba, tsx, implied,   2);  _(bb, ill, implied, 2);      \
  _(bc, ldy, absx,      4);  _(bd, lda, absx,      4);  _(be, ldx, absy,      4);  _(bf, ill, implied, 2);      \
  _(c0, cpy, immediate, 3);  _(c1, cmp, indx,      6);  _(c2, nop, immediate, 2);  _(c3, ill, implied, 2);      \
  _(c4, cpy, zp,        3);  _(c5, cmp, zp,        3);  _(c6, dec, zp,        5);  _(c7, ill, implied, 2);      \
  _(c8, iny, implied,   2);  _(c9, cmp, immediate, 3);  _(ca, dex, implied,   2);  _(cb, ill, implied, 2);      \
  _(cc, cpy, abs,       4);  _(cd, cmp, abs,       4);  _(ce, dec, abs,       6);  _(cf, ill, implied, 2);      \
  _(d0, bne, relative,  2);  _(d1, cmp, indy,      5);  _(d2, ill, implied,   3);  _(d3, ill, implied, 2);      \
  _(d4, nop, zpx,       2);  _(d5, cmp, zpx,       4);  _(d6, dec, zpx,       6);  _(d7, ill, implied, 2);      \
  _(d8, cld, implied,   2);  _(d9, cmp, absy,      4);  _(da, nop, implied,   3);  _(db, ill, implied, 2);      \
  _(dc, nop, absx,      2);  _(dd, cmp, absx,      4);  _(de, dec, absx,      7);  _(df, ill, implied, 2);      \
  _(e0, cpx, immediate, 3);  _(e1, sbc, indx,      6);  _(e2, nop, immediate, 2);  _(e3, ill, implied, 2);      \
  _(e4, cpx, zp,        3);  _(e5, sbc, zp,        3);  _(e6, inc, zp,        5);  _(e7, ill, implied, 2);      \
  _(e8, inx, implied,   2);  _(e9, sbc, immediate, 3);  _(ea, nop, implied,   2);  _(eb, ill, implied, 2);      \
  _(ec, cpx, abs,       4);  _(ed, sbc, abs,       4);  _(ee, inc, abs,       6);  _(ef, ill, implied, 2);      \
  _(f0, beq, relative,  2);  _(f1, sbc, indy,      5);  _(f2, ill, implied,   3);  _(f3, ill, implied, 2);      \
  _(f4, nop, zpx,       2);  _(f5, sbc, zpx,       4);  _(f6, inc, zpx,       6);  _(f7, ill, implied, 2);      \
  _(f8, sed, implied,   2);  _(f9, sbc, absy,      4);  _(fa, nop, implied,   4);  _(fb, ill, implied, 2);      \
  _(fc, nop, absx,      2);  _(fd, sbc, absx,      4);  _(fe, inc, absx,      7);  _(ff, ill, implied, 2);

int emulate(struct core *core, uint16_t start_addr, uint8_t acc, int max_cycles)
{
	static void *itab[256] = {
		&&_00, &&_01, &&_02, &&_03, &&_04, &&_05, &&_06, &&_07, &&_08, &&_09, &&_0a, &&_0b, &&_0c, &&_0d, &&_0e, &&_0f,
		&&_10, &&_11, &&_12, &&_13, &&_14, &&_15, &&_16, &&_17, &&_18, &&_19, &&_1a, &&_1b, &&_1c, &&_1d, &&_1e, &&_1f,
		&&_20, &&_21, &&_22, &&_23, &&_24, &&_25, &&_26, &&_27, &&_28, &&_29, &&_2a, &&_2b, &&_2c, &&_2d, &&_2e, &&_2f,
		&&_30, &&_31, &&_32, &&_33, &&_34, &&_35, &&_36, &&_37, &&_38, &&_39, &&_3a, &&_3b, &&_3c, &&_3d, &&_3e, &&_3f,
		&&_40, &&_41, &&_42, &&_43, &&_44, &&_45, &&_46, &&_47, &&_48, &&_49, &&_4a, &&_4b, &&_4c, &&_4d, &&_4e, &&_4f,
		&&_50, &&_51, &&_52, &&_53, &&_54, &&_55, &&_56, &&_57, &&_58, &&_59, &&_5a, &&_5b, &&_5c, &&_5d, &&_5e, &&_5f,
		&&_60, &&_61, &&_62, &&_63, &&_64, &&_65, &&_66, &&_67, &&_68, &&_69, &&_6a, &&_6b, &&_6c, &&_6d, &&_6e, &&_6f,
		&&_70, &&_71, &&_72, &&_73, &&_74, &&_75, &&_76, &&_77, &&_78, &&_79, &&_7a, &&_7b, &&_7c, &&_7d, &&_7e, &&_7f,
		&&_80, &&_81, &&_82, &&_83, &&_84, &&_85, &&_86, &&_87, &&_88, &&_89, &&_8a, &&_8b, &&_8c, &&_8d, &&_8e, &&_8f,
		&&_90, &&_91, &&_92, &&_93, &&_94, &&_95, &&_96, &&_97, &&_98, &&_99, &&_9a, &&_9b, &&_9c, &&_9d, &&_9e, &&_9f,
		&&_a0, &&_a1, &&_a2, &&_a3, &&_a4, &&_a5, &&_a6, &&_a7, &&_a8, &&_a9, &&_aa, &&_ab, &&_ac, &&_ad, &&_ae, &&_af,
		&&_b0, &&_b1, &&_b2, &&_b3, &&_b4, &&_b5, &&_b6, &&_b7, &&_b8, &&_b9, &&_ba, &&_bb, &&_bc, &&_bd, &&_be, &&_bf,
		&&_c0, &&_c1, &&_c2, &&_c3, &&_c4, &&_c5, &&_c6, &&_c7, &&_c8, &&_c9, &&_ca, &&_cb, &&_cc, &&_cd, &&_ce, &&_cf,
		&&_d0, &&_d1, &&_d2, &&_d3, &&_d4, &&_d5, &&_d6, &&_d7, &&_d8, &&_d9, &&_da, &&_db, &&_dc, &&_dd, &&_de, &&_df,
		&&_e0, &&_e1, &&_e2, &&_e3, &&_e4, &&_e5, &&_e6, &&_e7, &&_e8, &&_e9, &&_ea, &&_eb, &&_ec, &&_ed, &&_ee, &&_ef,
		&&_f0, &&_f1, &&_f2, &&_f3, &&_f4, &&_f5, &&_f6, &&_f7, &&_f8, &&_f9, &&_fa, &&_fb, &&_fc, &&_fd, &&_fe, &&_ff
	};

	value_t	*memory = core->memory;

	void	**itabp = itab;
	void	*tpc;

#if 0
#define dump()	if(dump_enabled) fprintf(stderr, "pc=%04x op=%02x\n", PC, v.value)
#else
#define dump()
#endif

# define fetch()	{ value_t v = memory[PC]; core->read[PC] = 1; dump(); PC++; dont_reloc(v.src); opcode = v.value; tpc = itabp[opcode]; }
# define goto_next()				goto *tpc
# define dispatch(num, name, mode, cycles)	_##num: name(cycles, mode) return ERR_INTERNAL;

	word	PC;
	word	ea;
	value_t	A, X, Y;
	byte	P, S;
	byte	opcode;

	struct source *src_pc_msb = cons_src(1, 0);
	struct source *src_ea_msb;

	PC = start_addr;
	A.value = acc;
	A.src = 0;
	X.value = 0;
	X.src = 0;
	Y.value = 0;
	Y.src = 0;
	P = 0;
	S = 0xff;

	fetch();
	goto_next();

	do_insns(dispatch);

illegal_instr:
	fprintf(stderr, "Illegal opcode: $%02x (PC = $%04x)\n", opcode, PC);
	return ERR_ILLEGAL;
}
