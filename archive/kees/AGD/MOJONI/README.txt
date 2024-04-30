Mojoni in the Sewer World:
--------------------------

Suddenly one day Jimmy Jones was in the bathroom and Mojoni was born.
You must go through the dangers of the sewers, dodging enemies and save your friends, the mini mojonis.

Two versions with different difficulty.

Controls:
 O : Left 
 P : Right 
 Q : Up 
 A : Down 
 M : Fire

Code: Isaías Díaz Toledano
Music: Jimmy Devesa

Thanks to  Sergio thEpOpE for The Perilla, Jonathan Cauldwell  for AGD and David Saphier for AGD Musicizer II 
Thanks to Juan Carlos González Amestoy (Retrovirtual Virtual Machine) for making it possible to play it from the web.
Update to 1.1, fixed a screen bug.

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

  MOJONI.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  MOJONI.DSK, Diskfile for emulators, to start the game, type *RUN"MORUN"

AtoMMC version:

  MORUN  = Basic introscreen
  MOSCR  = Titlescreen
  MOCODE = Gamecode

  To start the game, type: *MORUN

