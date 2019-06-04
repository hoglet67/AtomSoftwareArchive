Donkey Kong jr:
---------------

Finally after many months of waiting a playable version of the arcade port of Donkey Kong Jr, has been released by Gabriele Amore for the ZX Spectrum! Originally released in 1982 for Arcades and later released for home systems such as the Atari 2600, Atari 7800, Atari 8-bit with a C64 overhauled version by Mr Sid and an Atari 8-bit Arcade HACK released earlier this year. Has been in development for some time for the ZX and features many enemies on screen, lovely ZX Speccy art and is free to play today!

In this game you play as Donkey Kong Junior and must rescue your father Donkey Kong who has been imprisoned by Mario in his only appearance as an antagonist in a video game. The game was developed using AGD and works on both real hardware and under emulation, however as it is still an early release, music has yet to be added.

Controls:

Q - Up
A - Down
O - Left
P - Right
M - Jump

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

  DKJR.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  DKJR.DSK, Diskfile for emulators, to start the game, type *RUN"DKJRUN"

AtoMMC version:

  DKJRUN  = Basic introscreen
  DKJSCR  = Titlescreen
  DKJCODE = Gamecode

  To start the game, type: *DKJRUN

