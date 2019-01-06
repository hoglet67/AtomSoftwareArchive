GRUMPY SANTA
==============
(c) copyright Paul Jenkinson 2017

THE GAME
========

Santa wants to get on with the present delivery so he can get back and get drunk.
His wife though has other ideas, and sends him to the get the presents stolen by the evil Snowmen and their sidekicks, the nasty evles.

This makes Santa very grumpy.. and he sets off in search of these stolen presents across snowy landscapes, through evil forests, into a haunted tower and eventually the land of the snowmen.

There are two batches to collect before he can get back to delivering them, and finally return to get drunk!

Each screen has four presents to collect, after which a portal appears allowing Santa to move on.


Controls:
-----------
Q - Left
W - Right
SPACE - Jump

You can also use Kempston or Sinclair Joysticks.

This game has been created with Arcade Games Designer by Jonathan Cauldwell.

The game took three days to write, so don't expect anything ground-breaking!

NOTES:
======
This game will work on 48k machines/emulators, but will not have music.
Emulators that support AY emulation in 48k mode should use that setting, or use 128,+2 or +3 modes.
Real 128,+2,+3 machines should work fine.


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

  GRUMPY.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  GRUMPY.DSK, Diskfile for emulators, to start the game, type *RUN"GSRUN"

AtoMMC version:

  GSRUN  = Basic introscreen
  GSSCR  = Titlescreen
  GSCODE = Gamecode

  To start the game, type: *GSRUN
