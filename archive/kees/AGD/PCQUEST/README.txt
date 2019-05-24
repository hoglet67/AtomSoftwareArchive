Page's Castle Quest:
--------------------

An alien spaceship has crashed into the castle and scattered the treasurre around the castle and beyond.
It's our hero's job to collect as much of the hoard as possible before finding his way out. Beyond the castle lies an unfriendly Jungle, maybe he can find safety in the caves which lie beyond ... but don't go too deppp, there are tales of terrible things lurking deep below the ground!

Controls:
  Q   - Left
  W   - Right
SPACE - Jump

David Pagett (2014)

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

  PCQUEST.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  PCQUEST.DSK, Diskfile for emulators, to start the game, type *RUN"PCQRUN"

AtoMMC version:

  PCQRUN  = Basic introscreen
  PCQSCR  = Titlescreen
  PCQCODE = Gamecode

  To start the game, type: *PCQRUN

