Rescue Lander:
--------------

The city is bombarded by meteors. It could be the prelude to an alien invasionn so do your best to save as many souls as possible. Fly your rescue lander through the city and beyond collecting as many men, women and children as you possible can.
Collect 3 pockets of people per screen to advance to the next level, but be careful, don't land anywhere other than on the landing platforms, everything else will danage your ship.
Don't run out of fuel either as that will cost you a life.

Controls:

O - Left
P - Right
Q - Thurst

(c) David Pagett (2015)

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

  RESCUE.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  RESCUE.DSK, Diskfile for emulators, to start the game, type *RUN"RESRUN"

AtoMMC version:

  RESRUN  = Basic introscreen
  RESSCR  = Titlescreen
  RESCODE = Gamecode

  To start the game, type: *RESRUN

