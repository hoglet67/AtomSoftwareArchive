CODE ZERO
=========
(c) Paul Jenkinson 2017
Version 1.1

2077: The human race has stripped the planet clean.
All power is now supplied by a single conglomerate – DCR Inc.
Renewable energies were not enough to cope with demand.
Nuclear energy became mainstream and a new isotope was identified and quickly introduced into production.
By the time DCR realised the danger it was too late.
The single test station, now deserted, is in danger of imploding, taking the planet along with it.
Now clear of radiation, there is only a limited amount of time before disaster strikes.
The main computers must be shut down by injecting a virus to circumvent the cyber protection.
With all personal dead or in hospital, a Code Zero alert is sent out to all suitable agents.
You are the closest.
Areas of the station are separated by electronic doors that require key cards. These have been left by the fleeing staff. Use these to gain access to the main computers and shut down the reactor before it’s too late.

Controls
---------
Q - Up
A - Down
O - Left
P - Right
SPACE - Exit lift

You can also use Kempston Joystick.

This game has been created with Arcade Games Designer by Jonathan Cauldwell.


NOTES:
======
This game will work on 48k machines/emulators, but will not have sound.
Emulators that support AY emulation in 48k mode should use that setting, or use 128,+2 or +3 modes.
Real 128,+2,+3 machines should work fine.

DISTRIBUTION
===========
This game may NOT be included in any CD, DVD or other media without the express written permission of the author.

Primary download sites: 
http://www.thespectrumshow.co.uk
http://www.worldofspectrum.org

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

  CODEZERO.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  CODEZERO.DSK, Diskfile for emulators, to start the game, type *RUN"CZRUN"

AtoMMC version:

  CZRUN  = Basic introscreen
  CZSCR  = Titlescreen
  CZCODE = Gamecode

  To start the game, type: *CZRUN

