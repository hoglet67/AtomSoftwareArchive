Speccy Pong:
------------

Again the ZX-DEV brings us another nice conversion of recreational, in this case by the hand of Julian Urbano Muñoz, where recreates us in a quite pleasant and faithful recreational Pong de Atari. The game allows options of one or two players, 5 levels of difficulty, score points to get, color changes, etc ... and is as basic as addictive (like the original). Note that it is the first work of Julian and is made with AGD with some routines in ASM. You can download the game from the ZXDEV forum in TZX format with various extras like the cover, inlays, etc ...

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

  SPECCYPONG.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  SPECCYPONG.DSK, Diskfile for emulators, to start the game, type *RUN"PONRUN"

AtoMMC version:

  PONRUN  = Basic introscreen
  PONSCR  = Titlescreen
  PONCODE = Gamecode

  To start the game, type: *PONRUN

