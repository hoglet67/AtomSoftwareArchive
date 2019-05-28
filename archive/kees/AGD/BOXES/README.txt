Puzzle Boxes:
-------------

So the Boxes puzzle came out , which we wrote about in November. Alexey Kashkarov once again pleases us with not the most standard operation of the AGD engine - that would have been learned by all the other users!

Recall that in Boxes you manage the loader, who settled for a trial period in some kind of company. To get a contract, he needs to show himself from the best side, and for this at several levels it is necessary to make boxes the way the boss shows. The difficulty is that the boxes move all at once, and in one direction - the volume that you specify. Another problem is that if one box falls on the one that stands against the wall, then the squeezed box is immediately broken.


Each warehouse is given a certain time, during which it is necessary to solve the problem. Three times in one warehouse this time can be extended (with the “T” button), but no more. And for the whole game, there are exactly three attempts; you can’t do it - you will be fired after you have paid your earned salary. Actually, the goal of the game is to work hard on all warehouses, without exception, and successfully complete your career.

With the gameplay in Boxes, as expected, the full order - puzzles at times difficult, but doable. You can download the game from our site: version for 128K ( TRD and TAP ) or for 48K ( TAP ).

Controls:

  Q   - Up
  A   - Down
  O   - Left
  P   - Right
SPACE - Check
  T   - Extra time

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

  BOXES.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  BOXES.DSK, Diskfile for emulators, to start the game, type *RUN"BOXRUN"

AtoMMC version:

  BOXRUN  = Basic introscreen
  BOXSCR  = Titlescreen
  BOXCODE = Gamecode

  To start the game, type: *BOXRUN

