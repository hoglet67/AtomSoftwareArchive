KYD CADET II  The Rescue Of Pobbleflu
======================================

(c) Paul Jenkinson 2010

As Kyd blasts off after refuelling on the abandoned mining planet, he can at last continue with his first mission.
An important space dignitary, Pobbleflu, has been kidnapped and taken to a nearby planet by his captors.
As they bargain for higher and higher ransoms, Kyd is sent in to rescue him unseen.
The only intel he has is that Pobbleflu has been locked in the flight tower, and that the key has been hidden somewhere on the planet.
To hinder any rescue attempts, further security doors around the planet have been sealed and can only be opened by one key each.
Kyd has to find the required keys to allow him to continue his search for the final key that will set free Pobbleflu, and give Kyd his first successful mission.
Good luck.

NOTES:
======
This game will work on 48k machines/emulators, but will not have sound.
Emulators that support AY emulation in 48k mode should use that setting, or use 128,+2 or +3 modes.
Real 128,+2,+3 machines should work fine.


Controls:
=========
A=Left
S=right
SPACE=Jump


This game has been created with Arcade Games Designer by Jonathan Cauldwell.

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

  KYD2.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  KYD2.DSK, Diskfile for emulators, to start the game, type *RUN"K2RUN"

AtoMMC version:

  K2RUN  = Basic introscreen
  K2SCR  = Titlescreen
  K2CODE = Gamecode

  To start the game, type: *K2RUN

