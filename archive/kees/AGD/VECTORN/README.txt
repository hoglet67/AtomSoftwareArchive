The Vectornauts:
----------------

The Vectornauts is another new AGD game hits the streets, not much is known about this game at the moment, the dev has completed 23 rooms at this time, he aims to add a few more and a little more content and then it should see a full release.

Controls:

  Q   - Up
  A   - Down
  O   - Left
  P   - Right
SPACE - Fire

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

  VECTORNAUTS.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  VECTORNAUTS.DSK, Diskfile for emulators, to start the game, type *RUN"VECRUN"

AtoMMC version:

  VECRUN  = Basic introscreen
  VECSCR  = Titlescreen
  VECCODE = Gamecode

  To start the game, type: *VECRUN

