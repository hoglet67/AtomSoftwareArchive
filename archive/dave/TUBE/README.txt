Atom Tube Host
--------------

David Banks
dave@hoglet.com

Atom Tube Host files:
---------------------

TUBE/TUBE                   - Atom Tube Host
TUBE/TUBED1                 - Atom Tube Host with level 1 debugging (log unsupported OS calls)
TUBE/TUBED2                 - Atom Tube Host with level 2 debugging (additionally log R1/R2 protocol)
TUBE/TUBED3                 - Atom Tube Host with level 3 debugging (additionally log R4 protocol and OSWORD 7F/FF)
TUBE/ATOMMC/AVR/ATMMC3A     - AtoMMC 3, for AVR hardware, #A000 version, .ATM format
TUBE/ATOMMC/AVR/ATMMC3A.rom - AtoMMC 3, for AVR hardware, #A000 version, raw binary format
TUBE/ATOMMC/AVR/ATMMC3E     - AtoMMC 3, for AVR hardware, #E000 version, .ATM format
TUBE/ATOMMC/AVR/ATMMC3E.rom - AtoMMC 3, for AVR hardware, #E000 version, raw binary format
TUBE/ATOMMC/PIC/ATMMC3A     - AtoMMC 3, for PIC hardware, #A000 version, .ATM format
TUBE/ATOMMC/PIC/ATMMC3A.rom - AtoMMC 3, for PIC hardware, #A000 version, raw binary format
TUBE/ATOMMC/PIC/ATMMC3E     - AtoMMC 3, for PIC hardware, #E000 version, .ATM format
TUBE/ATOMMC/PIC/ATMMC3E.rom - AtoMMC 3, for PIC hardware, #E000 version, raw binary format

Installation:

Unpack the zip file onto an AtoMMC SD Card

Install the appropriate version of AtoMMC 3.x from AtoMMC/AVR or AtoMMC/PIC.

>VGA80                      - optional but use it if you have it available
>*CWD TUBE
>*TUBE N

The parameter N selects the Co Processor number. If N is ommitted, the
Co Processor remains unchanged.

For the values of N, see:
https://github.com/hoglet67/CoPro6502/wiki
https://github.com/hoglet67/PiTubeDirect/wiki

Build In Commands:
------------------

*DIN    <drive> <filename>  - mount an disk image to drive
*DOUT   <drive>             - unmount a drive
*DDISKS                     - list the current mounts
*COPRO  <N>                 - change Co Pro number (must be followed by a *RESET)
*SPEED  <N>                 - change Co Pro speed (must be followed by a *RESET)
*MEM    <N>                 - change Co Pro memory size (must be followed by a *RESET)
*RESET                      - reset the Co Pro

6502 files:
-----------

TUBE/BASIC2                 - Acorn Basic 2
TUBE/HIBASIC                - Acorn HiBasic 2
TUBE/CLOCKSP                - JGH's BBC Basic ClockSP benchmark
TUBE/COLOSS                 - Level 9 Colossal Adventure

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

TUBE/CPM1.dsd               - Disc image for CPM
TUBE/INFOCOM.dsd            - Disc image for InfoCom adventure
TUBE/Z80BAS                 - Z80 BBC Basic (Standalone version)
TUBE/Z80ROM                 - Z80 BBC Basic (ROM version)
TUBE/CLOCKSP                - JGH's BBC Basic ClockSP benchmark

From the Z80 tube * prompt, you should be able to
*RUN Z80ROM
>CHAIN "CLOCKSP"

or

*RUN Z80BAS
>CHAIN "CLOCKSP"

These both end up loading the same version of Z80 BBC Basic.

Here's how you get CP/M running:

>VGA80                      - if you have it
>*CWD TUBE
>*TUBE 4                    - if using PiTubeDirect
>*TUBE 7                    - if using Matchbox
*DIN 0 CPM1.DSD
*DIN 1 INFOCOM.DSD
*CPM
A>DIR
A>B:
B>DIR
B>HITCH2

Known issue 1: The slowest Z80 Co Pro hangs loading files. Select one
of the faster ones.

Known issue 2: The Z80 Co Pro Error Handler might be unreliable.

6809 files:
-----------

TUBE/FLEX                   - Flex boot loader
TUBE/BBCFLEX6.DSD           - Disc Image for Flex

Here's how you get CP/M running (a bit more fiddly):

>VGA80                      - if you have it
>*CWD TUBE
>*TUBE 9
*DIN 0 BBCFLEX6.DSD
*FLEX

PDP11 files:
------------

TUBE/PDPRM21                - PDP 11 BBC Basic version 0.20A
TUBE/PDPRM22                - PDP 11 BBC Basic version 0.22
TUBE/PDPRM23                - PDP 11 BBC Basic version 0.22 (later build)
TUBE/CLOCKSP                - JGH's BBC Basic ClockSP benchmark

From the PDP tube * prompt, you should be able to

>VGA80                      - if you have it
>*CWD TUBE
>*TUBE 11
*RUN PDPRM23
>CHAIN "CLOCKSP"

This will eventually give a syntax error at line 520, because floating
point is not implemented in this version of BBC Basic.
