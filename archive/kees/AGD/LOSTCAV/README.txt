Lost cavern:
------------

You are the treasure hunter Jimmy Jones. What do you hope will accompany him on his first adventure?
Two version easy and normal.
New version 1.1 with graphical improvements and corrections in the code.

Controls / Controls
You can use Sinclair or Kempston joysticks, or the keyboard:

O: Left P: Right Q: Up A: Down M: Jump

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

  LOSTCAVERN.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  LOSTCAVERN.DSK, Diskfile for emulators, to start the game, type *RUN"LCRUN"

AtoMMC version:

  LCRUN  = Basic introscreen
  LCSCR  = Titlescreen
  LCCODE = Gamecode

  To start the game, type: *LCRUN

