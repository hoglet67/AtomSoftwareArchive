Flype:
------

Charming little Arcade Puzzler for the ZX Spectrum
After all those C64 releases it's time for a charming little ZX Spectrum game that's fun for all ages! This is 'Flype' by Repixel8; an arcade puzzle game inspired by 'Cool Croc Twins', and created mainly with AGD.  In 'Flype' your task is to fill up each bubble with water to complete the level while avoiding deadly spiked traps and enemies. Your character can flip in different directions to reach a platform but be careful how you flip as you may end up painfully spiked.
Flype is completely free to play and available in TZX format and for anyone wanting to play a new ZX Spectrum title that's charmingly fun, play this game!

Controls:

 O - Left
 P - Right
 M - Jump

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

  FLYPE.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  FLYPE.DSK, Diskfile for emulators, to start the game, type *RUN"FLRUN"

AtoMMC version:

  FLRUN  = Basic introscreen
  FLSCR  = Titlescreen
  FLCODE = Gamecode

  To start the game, type: *FLRUN

