Papyrus:
--------

PAPYRUS is an old classic platform game, powered with AGD, for ZX Spectrum.

You are Wayne Coleman, the adventurer/explorer, and your mission is to collect the nine Papyri hidden along the pyramid. Take care on the way!

CONTROLS

 Q = JUMP 
 O = LEFT 
 P = RIGHT 
 
The game is writtten by packobilly.

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

  Q   - UP
  O   - LEFT
  P   - RIGHT
SPACE - FIRE

===================================================================
Tape/Disk and AtoMMC version:
===================================================================

Tape version:

  PAPYRUS.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  PAPYRUS.DSK, Diskfile for emulators, to start the game, type *RUN"PARUN"

AtoMMC version:

  PARUN  = Basic introscreen
  PASCR  = Titlescreen
  PACODE = Gamecode

  To start the game, type: *PARUN

