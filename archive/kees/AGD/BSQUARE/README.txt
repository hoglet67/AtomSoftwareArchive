B-SQUARED
=========
(c) copyright Paul Jenkinson 2017

THE GAME
========

Welcome to B-Squared. A game of fun and squareness.

Guide your square around 31 screens to complete the game.

Avoid the nasties, watch out for moving floors and use the switches to help you.

Your square can only jump upwards, so watch out of the evil spikes above!




Controls:
-----------
O - Left
P - Right
Q - Bounce Up

You can also use Kempston or Sinclair Joysticks.

This game has been created with Arcade Games Designer by Jonathan Cauldwell.

NOTES:
======
This game will work on 48k machines/emulators, but will not have music.
Emulators that support AY emulation in 48k mode should use that setting, or use 128,+2 or +3 modes.
Real 128,+2,+3 machines should work fine.

MUSIC
=====
The music was very kindly implimented by David Saphier.
Music (c) Sergey Nilov.

DISTRIBUTION
===========
This game may NOT be included in any CD, DVD or other media without the express written permission of the author.

Primary download sites: 
http://www.thespectrumshow.co.uk
http://spectrumcomputing.co.uk/
http://www.worldofspectrum.org

More of my games can be download from my website: http://www.thespectrumshow.co.uk

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

  BSQUARE.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  BSQUARE.DSK, Diskfile for emulators, to start the game, type *RUN"BSRUN"

AtoMMC version:

  BSRUN  = Basic introscreen
  BSSCR  = Titlescreen
  BSCODE = Gamecode

  To start the game, type: *BSRUN

