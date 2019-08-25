Lost in my Spectrum:
--------------------

The game is compatible with all ZX Spectrums as separate 48K and 128K versions,
and is available in the following formats:

TZX tape image files saved with SetoLOAD turbo loading scheme, for generic
emulation and loading on real hardware via PC or multimedia reader;

TAP tape image files, for those emulators which do not support TZX files or use
with a DivIDE interface and FATware 0.12 and derivates (0.12a, Velesoft etc.);

multi-language TRD disk image files for use with the Beta Disk or similar (e.g.
Arcade AR-20, IDS-91, CBI-95) disk interfaces, or with a DivIDE/DivMMC and
ESXDOS 0.8.5 and newer; must be left in the drive during play.

Please note: if your interface runs ESXDOS 0.8.5 as its operative system, you
must highlight the LIMS-48-EN.TAP or LIMS-128-EN.TAP file name in the ESXDOS
menu, press I then SPACE and load the game by entering the usual LOAD ""
command. Otherwise, when typing your name for the high scores table you will be
unable to enter anything other than numbers and symbols (with SYMBOL SHIFT).
This is due to a bug of the operative system, which has been corrected in
ESXDOS 0.8.6 beta 4.

Atom version done by Kees van Oss.

===================================================================
System requirements:
===================================================================

- Standard Acorn Atom
- 32 KB RAM
- 8 KB video RAM (#8000-#9FFF)
- Joystick connected to keyboard matrix (Optional)
- Joystick connected to PORTB AtoMMC interface (Optional)

===================================================================
Joystick (optional JOYMMC):
===================================================================

The joystick is connected to PORTB of the AtoMMC interface with 
softwareversion 2.9. The connections are like this:

AtoMMC  Joystick
-----------------
 PB0  -  Right
 PB1  -  Left
 PB2  -  Down
 PB3  -  Up
 PB4  -  Jump
 PB5  -  nc
 PB6  -  nc
 PB7  -  nc

 GND  -  GND

If direction is active, bit = 1

===================================================================
Joystick (optional JOYKEY):
===================================================================

The joystick is connected parallel to row 1 of the keyboard matrix.

    nokey - fire
	G - Right
	3 - Left
	- - Down
	Q - Up

===================================================================
Tape/Disk and AtoMMC version:
===================================================================

Tape version:

  LOSTSPECTRUM.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  LOSTSPECTRUM.DSK, Diskfile for emulators, to start the game, type *RUN"LISRUN"

AtoMMC version:

  LISRUN  = Basic introscreen
  LISSCR  = Titlescreen
  LISCODE = Gamecode

  To start the game, type: *LISRUN

