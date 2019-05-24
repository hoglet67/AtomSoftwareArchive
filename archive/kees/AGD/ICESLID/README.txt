Ice Slider Z:
-------------

EgoTrip of CPC has decided to give up waiting for AGD bug fixes and joined the dark side of the ZX Spectrum, creating his own fantastic arcade release in the form of 'Ice Slider Z'. Classed in his words as a Collect-em-up, you are tasked with collecting 12 jewels on many great levels that should keep you occupied for ages.

There is a bit of a trick to this fine game though as once you start moving, only brick walls can stop you and bouncing blocks will make you bounce back. There are also fires and guardian bubbles to hinder your progress, in addition to a time limit. A worthy homebrew indeed and brings back memories of screaming tape sounds with the supplied tape file!

Controls are Q = Up, A = Down, O = Left, P = Right.

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

  ICESLIDER.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  ICESLIDER.DSK, Diskfile for emulators, to start the game, type *RUN"ISRUN"

AtoMMC version:

  ISRUN  = Basic introscreen
  ISSCR  = Titlescreen
  ISCODE = Gamecode

  To start the game, type: *ISRUN

