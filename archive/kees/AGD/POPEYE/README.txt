Popeye:
-------

All the way into 2018 we've had countless conversions and ports either released or announced as coming to a specific system. Games such as Knightlore on the C64 is one such fine game. But now with the end of the year fast approaching there's another game that's been announced, but this time it's the turn of the ZX Spectrum with Gabriele Amore's arcade conversion of ' Popeye Arcade 2018 '; a new game which is hoping to win a prize during the ZX-DEV MIA Remakes competition.

The first version of this arcade conversion was released back in 2016 as a port of the Nintendo Arcade platformer originally released way back in 1983. This latest update however, has been done
with AGDx-Sprite Magic and may be a more featured packed game compared to the one in 2016.  So watch this space!

Controls:

Press 
  Q   - Up
  A   - Down
  O   - Left
  P   - Right
SPACE - Hit

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

  POPEYE.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  POPEYE.DSK, Diskfile for emulators, to start the game, type *RUN"POPRUN"

AtoMMC version:

  POPRUN  = Basic introscreen
  POPSCR  = Titlescreen
  POPCODE = Gamecode

  To start the game, type: *POPRUN

