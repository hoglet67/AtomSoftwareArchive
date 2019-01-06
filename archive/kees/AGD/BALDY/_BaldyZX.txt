BALDY ZX
========
(c) Paul Jenkinson 2015

Some nasty person has stolen Baldy's games, but realising they were not modern, they threw them away as they ran off.

Help Baldy recover his games through 20 action packed levels, avoid the spikes and moving projectiles.


Controls:
-----------
Q - Stand Up
A - Crouch down (essential for dodging things)
O - Jump left
P - Jump right
SPACE - Teleport.

You can also use Kempston or Sinclair Joysticks.

This game has been created with Arcade Games Designer by Jonathan Cauldwell.
Thanks to Jason Bullough for testing.

NOTES:
======
This game will work on 48k machines/emulators, but will not have sound.
Emulators that support AY emulation in 48k mode should use that setting, or use 128,+2 or +3 modes.
Real 128,+2,+3 machines should work fine.

This game is the Spectrum version of my 1992 Amiga PD game of the same name.
The first ten level are identical to the Amiga, however, the last ten I made some changes.
You can find out more details about that on my blog.(http://randomkak.blogspot.com)

DISTRIBUTION
===========
This game may NOT be included in any CD, DVD or other media without the express written permission of the author.

Primary download sites: 
http://www.worldofspectrum.org
http://randomkak.blogspot.com


Visit my blog for more games:
http://randomkak.blogspot.com

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

  BALDY.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  BALDY.DSK, Diskfile for emulators, to start the game, type *RUN"BALRUN"

AtoMMC version:

  BALRUN  = Basic introscreen
  BALSCR  = Titlescreen
  BALCODE = Gamecode

  To start the game, type: *BALRUN

