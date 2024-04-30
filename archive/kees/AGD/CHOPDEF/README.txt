Chopper Defense:
----------------

Aliens are invading! Again! You've been given the job of flying the space defence chopper to keep them from taking over the planet. It's equipped with the latest state of the art weaponry (lasers!) and it's Earth's only hope!

Save the parachuting human pilots in your defence chopper and defeat each wave of enemies to progress to the next level. 

Keyboard controls (redefinable from main menu):

  Q   - Fly up
  O   - Left
  P   - Right
SPACE - Fire (hold it down if you like)
  H   - Toggle pause

Made by me, PsychicParrot (Jeff Murray), in 2022. Thanks to Damien Guard for the awesome Standstill font, Jonathan Cauldwell for MPAGD, Quantum Sheep and YOU for keeping the Speccy dream alive!

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

  CHOPPER.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  CHOPPER.DSK, Diskfile for emulators, to start the game, type *RUN"CDRUN"

AtoMMC version:

  CDRUN  = Basic introscreen
  CDSCR  = Titlescreen
  CDCODE = Gamecode

  To start the game, type: *CDRUN

