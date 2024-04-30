Last Escape:
------------

Plot:

During the Second World War, Colditz Castle was a maximum security prison, where high-ranking military personnel and officers known for their escape attempts were held. You are the captain of the Royal Air Force, Rick "Smasherman" Reid and your mission will be the one that no one accomplished before; escape Colditz and return home safely.

Keys:

  O   - Left
  P   - Right
  Q   - Up & Hide 
  A   - Down
SPACE - Use & Drop Objects

Tips:

. You can carry a maximum of two objects at the same time. 
. Dogs can always detect you, but they can only catch you if you are on
  the same level.
. You can hide by pressing "Up" in the dark areas. 
. Objects can only be traded or left in the areas marked with the down arrow.
. You must carry the 2 correct objects to achieve a successful escape.

Staff:

Code + Graphics: Ariel Endaraues
Intro + Loading Screen: Juan Antonio Fernández (F3M0)
Music: Mr. Rancio
Illustration: Leonardo Fernández(León)
Testing: Alexis Vorian + Javi Ortiz + H Beroldo
Thanks to: Allan Turvey + Sergio "The Pope"

Tools:

AGD by Jonathan Cauldwell
AGDx by Allan Turvey
Musicizer by David Saphier

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

  LASTESCAPE.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  LASTESCAPE.DSK, Diskfile for emulators, to start the game, type *RUN"LERUN"

AtoMMC version:

  LERUN  = Basic introscreen
  LESCR  = Titlescreen
  LECODE = Gamecode

  To start the game, type: *LERUN

