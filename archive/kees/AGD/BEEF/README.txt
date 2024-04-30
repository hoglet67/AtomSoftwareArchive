Beef!:
------

Title:			[CSSCGC] Beef!
Release Date:		2015
Original Publisher:	Lee Prince (UK) - within compilation "CSSCGC Crap Games Competition 2015"
Creators:		unclechicken
Authored with:		Arcade Game Designer
Availability:		Available
Message Language:	English
Machine Type:		ZX-Spectrum 48K
Genre:Arcade Game: 	Platform
Maximum Players:	1
Copyright Status:	Freeware (free but copyrighted)
Competitions:		CSSCGC Crap Games Contest 2015

Controls:

O - LEFT
P - RIGHT
Q - JUMP

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

  BEEF.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  BEEF.DSK, Diskfile for emulators, to start the game, type *RUN"BERUN"

AtoMMC version:

  BERUN  = Basic introscreen
  BESCR  = Titlescreen
  BECODE = Gamecode

  To start the game, type: *BERUN

