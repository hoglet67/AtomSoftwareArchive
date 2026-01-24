The day before the day the earth stood still:
---------------------------------------------

Go down to Earth eviting Zx-81 spaceships, go through the meteor belt, avoid contact with misiles, boats and planes from the army and descend over Washington.
Finally land on the platform to save the world.

Keys: OPQ

azimov2019
Music by AsteroideZX
A.G.D. by Jonathan Caldwell
Tested by DenimMSX

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
  A   - DOWN  
  O   - LEFT
  P   - RIGHT
SPACE - FIRE

  M   - Switch between SNOWBALLS and FLAMETHROWER
  H   - PAUSE GAME

===================================================================
Tape/Disk and AtoMMC version:
===================================================================

Tape version:

  EARTHSTILL.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  EARTHSTILL.DSK, Diskfile for emulators, to start the game, type *RUN"DERUN"

AtoMMC version:

  DERUN  = Basic introscreen
  DESCR  = Titlescreen
  DECODE = Gamecode

  To start the game, type: *DERUN

