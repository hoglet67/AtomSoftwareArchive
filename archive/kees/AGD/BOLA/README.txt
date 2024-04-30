Bola ke Ase:
------------

Title:Bola ke Ase
Release Date:		2022/Oct
Original Publisher:	Amebatron Software (Spain)
Creators:
Authored with:		Arcade Game Designer
Availability:
Message Language:	English
Machine Type:		ZX-Spectrum 48K
Genre:Arcade Game: 	Action
Maximum Players:	1

First test of crappy-game development for ZX Spectrum with AGD.

Sorry, there is no story, no good script, no cohesion in the game, you are just a ball that goes up or down 😎

---

Bola ke ase fulfills 2 functions:

-Learn the AGD engine, to be able to do something more decent after this game

-Finish a game that I started as a child in my +2A in BASIC (!!!!). The idea was the same as this one, with an 8x8 ball going up screens, but obviously the BASIC was too short for me, it was all very slow, and I left it.

----

CONTROLS: OPC

PENDING: points (I don't know how to do it yet) and add some music AY

THANK YOU FOR TRYING IT, any comment is welcome!

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

  BOLA.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  BOLA.DSK, Diskfile for emulators, to start the game, type *RUN"BORUN"

AtoMMC version:

  BORUN  = Basic introscreen
  BOSCR  = Titlescreen
  BOCODE = Gamecode

  To start the game, type: *BORUN

