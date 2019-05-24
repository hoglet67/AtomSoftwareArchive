Page and the Curse of the Pharaoh:
----------------------------------

Near to Page's castle their lives en evil Pharaoh, his treasure has been scattered throughout the land and he has ordered you to retreive it for him. 
But Page has different ideas and decides to collect the treasure and keep it for himself.
Help Page through 30 levels, solves puzzles, collect treasure and find the exit and an end to this misery.
Powerfull amulets hidden throughout the land will give you extra lives.

Controls:
  Q   - Up
  A   - Down
  O   - Left
  P   - Right
SPACE - Jump

David Pagett (2015)

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

  PHARAOH.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  PHARAOH.DSK, Diskfile for emulators, to start the game, type *RUN"PHARUN"

AtoMMC version:

  PHARUN  = Basic introscreen
  PHASCR  = Titlescreen
  PHACODE = Gamecode

  To start the game, type: *PHARUN

