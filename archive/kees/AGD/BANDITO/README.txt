BANDITO

For the ZX Spectrum

© 2020 Andy McDermott
Made with AGDX

----------

THE AMERICAN WEST, 1848

Ay-yi-yi! It used to be such an easy life, being a Mexican bandit. You would cross the border into the United States, rob the gringo settlers, then race back into Mexico with your loot before their lawmen could catch you.

But Mexico just lost a war with the United States - and now your beloved Alta California has been stolen by the stinking gringos! Their sheriffs and marshals are everywhere. And worse, the loot you hid in what were safe places within Mexico is now deep inside American territory!

There are 20 sacks of loot to find. Cross the border and recover your riches. The desert is a dangerous place, but as the toughest hombre west of the Mississippi, you know how to deal with trouble...

SHOOT EVERYTHING THAT MOVES!

----------

Controls
Q: Up
A: Down
O: Left
P: Right
Space: Fire

----------

(And yes, I know that the Spanish word is actually "bandido", but "bandito" is funnier!)

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

  BANDITO.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  BANDITO.DSK, Diskfile for emulators, to start the game, type *RUN"BARUN"

AtoMMC version:

  BARUN  = Basic introscreen
  BASCR  = Titlescreen
  BACODE = Gamecode

  To start the game, type: *BARUN

