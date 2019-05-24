Doodle Bug:
-----------

Doodlebug is perhaps the most interesting game among all that comes with Woot magazine. It looks stylish, it plays perfectly, it doesn’t go away in five minutes - ah yes well done Dave Hughes! In Doodlebug, you need to control the ball, which jumps on the level drawn in a notebook, avoiding enemies and red crosses and trying to jump to the green check mark, and then to the exit to the next level. This game is most deserving of a separate release - even a little pity that it was lost in the midst of this Christmas treasure. 

Controls:

O - Left
P - Right
Z - Pause

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

  DBUG.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  DBUG.DSK, Diskfile for emulators, to start the game, type *RUN"DBRUN"

AtoMMC version:

  DBRUN  = Basic introscreen
  DBSCR  = Titlescreen
  DBCODE = Gamecode

  To start the game, type: *DBRUN


