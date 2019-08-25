The Dragon with the Wagon:
--------------------------

Bearsden Primary School P6 Coding Games
The pupils in P6 (10-11 year olds) at Bearsden Primary have been learning to code zx Spectrum games using AGD.

Each pupil has created their own platform game using the coding skills they have developed this year.

They have designed and animated their own sprites and put a great deal of effort into their level design and storylines. They have enjoyed the challenge  (but not the debugging) and are very excited that their games will be shared with the world. 

I am releasing their games firstly to share and celebrate just how incredible their work is but also hopefully to inspire others to learn to code on this wonderful machine which is still provoking joy and awe in children 37 years after its release.

Dougie mcg

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

  DRAGNWAG.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  DRAGNWAG.DSK, Diskfile for emulators, to start the game, type *RUN"DRARUN"

AtoMMC version:

  DRARUN  = Basic introscreen
  DRASCR  = Titlescreen
  DRACODE = Gamecode

  To start the game, type: *DRARUN

