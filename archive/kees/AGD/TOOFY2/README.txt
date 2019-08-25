TOOFY’S WINTER NUTS:
--------------------

Brrrrr it’s getting cold and winter is racing towards us.
Toofy needs to collect enough nuts to make it through but the nasty squirrels have raided his store and stolen them.
Guide Toofy as he tries to reclaim his nuts and survive the winter.

Controls
O-Left
P-Right
Q-Up
A-Down
SPACE Jump
You can also use a Kempston joystick.

Version 1.2
-----------
Changes.
Fixed a bug (AGD based) that caused Toofy to get stuck in room 21 wall.
Chnaged collect nut sound from AY to beeper.


Notes
-----
This game should load and run on any standard ZX Spectrum with 48k or more memory.

This game has been created with AGD (Arcade Games Designer) written by Jonathan Cauldwell.

Toofy’s Winter Nuts - Copyright 2013 Paul Jenkinson
See more of my games at www.randomkak.blogspot.com

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

  TOOFY2.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  TOOFY2.DSK, Diskfile for emulators, to start the game, type *RUN"TO2RUN"

AtoMMC version:

  TO2RUN  = Basic introscreen
  TO2SCR  = Titlescreen
  TO2CODE = Gamecode

  To start the game, type: *TO2RUN

