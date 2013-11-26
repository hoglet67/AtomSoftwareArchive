CC=gcc
PROFILE=
CFLAGS=-Wall -std=c99 -O3 -DNDEBUG ${PROFILE}
LDFLAGS=-lm ${PROFILE}

all:		sidreloc

.PHONY:		all install clean

sidreloc:	sidreloc.o solver.o cpu.o
		gcc -o $@ $^ ${LDFLAGS}

clean:
		rm -rf *.o reloc

install:	all
		mkdir -p /usr/local/bin
		cp sidreloc /usr/local/bin/
		mkdir -p /usr/local/man/man1
		cp sidreloc.1 /usr/local/man/man1/
