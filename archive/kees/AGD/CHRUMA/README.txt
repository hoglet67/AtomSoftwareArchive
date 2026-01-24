a_e W Kopalni Złota Króla Chruma:
---------------------------------

Overview

a_e W Kopalni Zlota Krola Chruma is a classic platformer game released in 2014 for the ZX Spectrum 48K. Created and published by Lukasz Kur, the game immerses players in a pixelated world where they explore the gold mines of King Chrum. The game is available in Polish and English languages.
Players navigate through levels filled with various obstacles and enemies, collecting treasures and avoiding traps. The distinct visual style, characterized by vibrant colors and simple graphics, is a nod to the classic platformers of the 1980s. Miesko Taranczewski contributed to the game's loading screen design.
The player takes on the role of a treasure hunter whose task is to collect all the gold on the board while avoiding encounters with hostile creatures and spikes. There are 12 rooms to go through.

Keys:

 Q - Up/jump
 A - Down
 O - Left
 P - Right

Author: Łukasz Kur

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

 Q - Up/jump
 A - Down
 O - Left
 P - Right

===================================================================
Tape/Disk and AtoMMC version:
===================================================================

Tape version:

  CHRUMA.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  CHRUMA.DSK, Diskfile for emulators, to start the game, type *RUN"CHRUN"

AtoMMC version:

  CHRUN  = Basic introscreen
  CHSCR  = Titlescreen
  CHCODE = Gamecode

  To start the game, type: *CHRUN

