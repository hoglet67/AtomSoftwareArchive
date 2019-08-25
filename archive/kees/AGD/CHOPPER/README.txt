CHOPPER DROP 1.1:
-----------------

Written By Paul Jenkinson ©2011

LOADING INSTRUCTIONS

Choppa Drop will load on any Spectrum however when using through an emulator in 48k mode, please ensure you have AY emulation turned on.
Alternatively load in 128, +2 or +3 mode.


THE GAME

It’s a tough life being a chopper pilot. Day in, day out, you have to pick up crates and drop them onto the lorry ready for delivery. Time is short however, and you only get so long for each load. Don’t take too long or you’ll be fired.

Avoid the WOS blimps, mad balloonist and seagulls to get your drops on time and maybe someone will take notice of your flying skills and give you the job you always wanted.

CONTROLS

Control your chopper using:

Q: Up
A: Down
O: Left
P: Right

To collect a crate, just fly into it. To drop the crate, make sure you are over the lorry and the crate will automatically be released. 

Changes from original 1.0 release
---------------------------------
Crates now auto release
Early levels are easier
Additional levels (now a total of 24)
Fixed bug when landing on lorry
Amended the loader to display correct name.
 

This game was written using Arcade Games Designer by Jonathan Cauldwell

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

  CHOPPERDROP.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  CHOPPERDROP.DSK, Diskfile for emulators, to start the game, type *RUN"CDRUN"

AtoMMC version:

  CDRUN  = Basic introscreen
  CDSCR  = Titlescreen
  CDCODE = Gamecode

  To start the game, type: *CDRUN

