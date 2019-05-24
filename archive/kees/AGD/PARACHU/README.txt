PARACHUTE:
----------

Free conversion based on the Atari classic "Parachute".
Our mission is to reach the base avoiding all the dangers that lie in wait for us: helicopters, birds, antiaircraft batteries, explosive balloons, guardians, traps, etc.
You will be thrown in different scenarios and with the sole help of your parachute you will have to arrive safely at the end of your mission.
You have Fuel, which helps you descend faster, but be careful, the fuel runs out, you must manage it wisely. In some places you can refuel.
Luck! You will need it.

Controls:
O - Left
P - Right
Q - Ascend
A - Descend

Credits:
Miguel Ángel Tejedor (aka Miguetelo)
Realized during December of 2017 and January of 2018 for the ZXDEV2017.
Made with AGD.

Thanks:
To David Saphier for AGDmusicizerII.
To Jonathan Cauldwell.

System:
ZX Spectrum 48K (with sound).
ZX Spectrum 128K (with Music).

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

  PARACHUTE.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  PARACHUTE.DSK, Diskfile for emulators, to start the game, type *RUN"PARRUN"

AtoMMC version:

  PARRUN  = Basic introscreen
  PARSCR  = Titlescreen
  PARCODE = Gamecode

  To start the game, type: *PARRUN

