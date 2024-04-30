Manbus Mania:
=============

A game for ZX Spectrum and Amstrad CPC
Mabus comes home after a hard day's work ready to play his favorite video games, but his wife has decided to clean up and has taken all his retro video games out of the house.
Help Mabus get them all back before it's too late.

CONTROLS:

O: Left
P: Right
Space: Jump

The game has two different endings, can you beat them?

CREDITS:

A game by Hicks 2021
Code, graphics  and  original concept: Oscar Llamas (Hicks)
Loading Screen Spectrum: Oscar Llamas (Hicks)
Loading Screen Amstrad CPC: Javy Fernandez (Defecto Digital)
Music: Jorge Antonio Mateo Teruel (McRaymond)
Music support cpc version: Fran Gallego (Profesor Retroman)
Spectrum +3 Dsk conversión: Rafael Pardo (Spirax) using zx0 compressor Einar Saukas.

Game testing:

Miguel Angel Castillo (Mabus)
Juan Pablo Mena (Indelain)

Special thanks to Angel Colaso (Roolandoo) for his patience xD

Game created with AGD 4.7
Dedicated to my son Oscar jr

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

  MABUS.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  MABUS.DSK, Diskfile for emulators, to start the game, type *RUN"MMRUN"

AtoMMC version:

  MMRUN  = Basic introscreen
  MMSCR  = Titlescreen
  MMCODE = Gamecode

  To start the game, type: *MMRUN

