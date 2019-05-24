Night Stalker ZX:
-----------------

for the ZX Spectrum, by AMCgames (Aleisha Cuff) 2018

Night Stalker ZX is a port of Night Stalker, a maze shooter released in 1982 for the Intellivision game console. 

For more information on enemies, the history of the game, and credits, please read the deluxe PDF manual (NightStalkerZX-Manual.pdf), found in the same directory as this ReadMe. 

CONTROLS

On the menu screen: 1 for Keyboard, 2 for Kempston joystick, 3 for Sinclair
 
Keys:

Q	up
A	down
O	left
P	right
Space	fire
M	fire

NOTICE

This game may be shared for free as is. All rights to the Night Stalker property are owned by Intellivision Entertainment. This port is an educational project and makes no claim to ownership of the original game.

MORE AMCGAMES

For the entire AMCgames roster, go here: https://goo.gl/xzQCZR

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

  NIGHTSTALK.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  NIGHTSTALK.DSK, Diskfile for emulators, to start the game, type *RUN"NSRUN"

AtoMMC version:

  NSRUN  = Basic introscreen
  NSSCR  = Titlescreen
  NSCODE = Gamecode

  To start the game, type: *NSRUN

 