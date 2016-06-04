Atom Tube Host
--------------

David Banks
dave@hoglet.com

Atom Tube Host files:
---------------------

TUBE/TUBE               - Atom Tube Host
TUBE/TUBED1             - Atom Tube Host with level 1 debugging (log unsupported OS calls)
TUBE/TUBED2             - Atom Tube Host with level 2 debugging (additionally log R1/R2 protocol)
TUBE/TUBED3             - Atom Tube Host with level 3 debugging (additionally log R4 protocol and OSWORD 7F/FF)
TUBE/MMC2MHZ.ROM        - AtoMMC 3 (beta release, with Tube support)

Installation:

Unpack the zip file onto an AtoMMC SD Card

Install MMC2MHZ.ROM as your version of AtoMMC

>VGA80          ;; optional but use it if you have it available
>*CWD TUBE
>*TUBE

Hints:

From Atom Basic you can change the Co Processor
?#BEE6=N
where N is between 0 and 15, followed by BREAK.

For the value of N, see https://github.com/hoglet67/CoPro6502/wiki

6502 files:
-----------

TUBE/BASIC2             - Acorn Basic 2
TUBE/HIBASIC            - Acorn HiBasic 2
TUBE/CLOCKSP            - JHG's BBC Basic ClockSP benchmark
TUBE/COLOSS             - Level 9 Colossal Adventure

From the 6502 tube * prompt, you should be able to

*RUN BASIC2
>CHAIN "CLOCKSP"

or

*RUN HIBASIC
>CHAIN "CLOCKSP"

or

*RUN COLOSS

Z80 files:
----------

TUBE/CPM1.dsd           - Disc image for CPM
TUBE/INFOCOM.dsd        - Disc image for InfoCom adventure
TUBE/Z80BAS             - Z80 BBC Basic (Standalone version)
TUBE/Z80ROM             - Z80 BBC Basic (ROM version)
TUBE/CLOCKSP            - JHG's BBC Basic ClockSP benchmark

From the Z80 tube * prompt, you should be able to
*RUN Z80ROM
>CHAIN "CLOCKSP"

or

*RUN Z80BAS
>CHAIN "CLOCKSP"

These both end up loading the same version of Z80 BBC Basic.

Here's how you get CP/M running (a bit fiddly):

>VGA80
>*CWD TUBE
>*LOAD TUBE
>SDDOS
>*DIN 0 CPM1.DSD
>*DIN 1 INFOCOM.DSD
>LINK #3000
*CPM
A>DIR
A>B:
B>DIR
B>HITCH2

Known issue 1: The slowest Z80 Co Pro hangs loading files. Select one
of the faster ones.

Known issue 2: The Z80 Co Pro Error Handler hangs.

6809 files:
-----------

TUBE/FLEX               - Flex boot loader
TUBE/BBCFLEX6.DSD       - Disc Image for Flex

Here's how you get CP/M running (a bit more fiddly):

>*CWD TUBE
>*TUBE
*LOAD FLEX

<Hit Break>

>VGA80
>*CWD TUBE
>SDDOS
>*DIN 0 BBCFLEX6.DSD
>LINK #3000
*GO C120

PDP11 files:
------------

TUBE/PDPRM21            - PDP 11 BBC Basic version 0.20A
TUBE/PDPRM22            - PDP 11 BBC Basic version 0.22
TUBE/PDPRM23            - PDP 11 BBC Basic version 0.22 (later build)
TUBE/CLOCKSP            - JHG's BBC Basic ClockSP benchmark

From the PDP tube * prompt, you should be able to

*RUN PDPRM23
>CHAIN "CLOCKSP"

This will eventually give a syntax error at line 520, because floating
point is not implemented in this version of BBC Basic.
