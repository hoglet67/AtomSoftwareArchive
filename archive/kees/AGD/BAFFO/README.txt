New game from Italy by Gabriele Amore made in AGD editor - Baffo Jones . Collect all the items on the screen and move on. You can can fall through emerging circles in the ground . On something green like a snake that is in the trees, you can catch on and fly over to the other side. In the water, the main thing is not to fall into enemies. 

Control: Q, A, O, P, M - jump.  

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

  BAFFO.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  BAFFO.DSK, Diskfile for emulators, to start the game, type *RUN"BAFRUN"

AtoMMC version:

  BAFRUN  = Basic introscreen
  BAFSCR  = Titlescreen
  BAFCODE = Gamecode

  To start the game, type: *BAFRUN