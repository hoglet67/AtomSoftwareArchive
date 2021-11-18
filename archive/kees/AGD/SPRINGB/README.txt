Springbot:
----------

A Game For The 48k ZX Spectrum
A mining facility on the planet Mars has been invaded by hostile aliens known as the Geonauts. Collect fuel cells to power up the reactor, cause an explosion to destroy the invaders, then escape back to the ship

Collect keys to open doors 

Pick up gems for bonus points

Credits
Copyright Andy Farrell 2020

Powered By
AGDX - Copyright Jonathan Cauldwell / AGD Labs

Additional Code By
Mr Travis Highrise

Special Thanks To 
Alessandro Grussu

Controls:

  Q  - Jump
  A  - Down
  O  - Left
  P  - Right
FIRE - Hit

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

  AMONGBAD.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  AMONGBAD.DSK, Diskfile for emulators, to start the game, type *RUN"ABRUN"

AtoMMC version:

  ABRUN  = Basic introscreen
  ABSCR  = Titlescreen
  ABCODE = Gamecode

  To start the game, type: *ABRUN

