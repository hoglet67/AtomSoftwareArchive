ROBOT - The Impossible Mission.

The back story:

ROBOT finds itself in a strange place near a security guard.  ROBOT checks the memory banks and finds a mission brief, but the details are a bit hazy.  ROBOT just knows that the ultimate goal is to get out of there.

ROBOT has 5 lives, and moving around uses up precious battery power.  As ROBOT moves around the mini-map will be updated to indicate the current screen.  The map is an eight by eight grid of locations.  I will leave it up to you to figure out if all 64 locations are used or not.

There are multiple objects that will be useful along the way.  Some of these objects have to be used in specific places (indicated on the screen), while others may have a use that isn't so obvious to figure out.

I have provided two tape snapshots.  They use the following keys:

1) UP=Q, DOWN=A, LEFT=O, RIGHT=P, COLLECT=SPACE, USE=U, TERMINATE CURRENT LIFE=5
2) UP=K, DOWN=M, LEFT=Z, RIGHT=X, COLLECT=SPACE, USE=U, TERMINATE CURRENT LIFE=Q

The game asks you to select your controls, then prompts you to choose the difficulty level.

The EASY level is really for kids.  You don't die by touching enemies, the objects are in quite simple places (and you only need so many of them to get to complete the game), and you don't use up so much battery power as you move around.

The MEDIUM level is a bit more tricky, but probably once you know where you are supposed to be going you'll find it pretty simple.

The real tough choice is the HARD level.  I've been play testing for some time and I only completed the game once on that level so far!

Enjoy!
Feel free to email me about the game:

simon@needanother.co.uk

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

  ROBOT.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  ROBOT.DSK, Diskfile for emulators, to start the game, type *RUN"ROBRUN"

AtoMMC version:

  ROBRUN  = Basic introscreen
  ROBSCR  = Titlescreen
  ROBCODE = Gamecode

  To start the game, type: *ROBRUN

