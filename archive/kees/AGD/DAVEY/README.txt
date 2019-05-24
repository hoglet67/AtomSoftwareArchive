Graham Blake made his first game on the AGD engine and, of course, shared it with the world. It is called Davey-Dudds Loves Peas and is a clone of Pac-Man, although much more primitive. Oh yes, do not pay attention to the menu items - they are confused. In fact, the situation is as follows:

1. KEYBOARD OPQA
2. Kempton
3. SINCLAIR

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

  DAVEY.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  DAVEY.DSK, Diskfile for emulators, to start the game, type *RUN"DDRUN"

AtoMMC version:

  DDRUN  = Basic introscreen
  DDSCR  = Titlescreen
  DDCODE = Gamecode

  To start the game, type: *DDRUN

