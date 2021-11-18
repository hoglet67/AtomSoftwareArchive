Vampire Vengeance
-----------------

Plot:

Long ago, an army of knights known as the Order of the Silver Cross attacked count Orlack's castle.
The mission was to annihilate the lord of shadows and all his subjects.
The battle was fierce, leaving a large number of victims on both sides.
But finally, a few knights managed to access the main crypt and confront Orlack.
The count managed to defeat a dozen warriors before being cornered by the invaders. The end had come. However, he managed to transform once again into his vampiric form, escaping between spears and arrows into the dark night of Transylvania.
Years passed and the wounds of war were healing. Earl Orlack made the lonely return home and only one word kept him alive. Vengeance.

KEYS:

O - Left
P - Right
Q - Up & Vampiric Form 
A - Down & Count Aspect
SPACE - Attack

Staff:

Code + Graphics: Ariel Endaraues
Intro + Loading Screen: Juan Antonio Fernandez (F3M0)
Music: Beyker
Testing: Javi Ortiz + Alexis Vorian

Tools:

AGD  by  Jonathan Cauldwell
AGDx  by Allan Turvey
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

  VAMPIRE.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  VAMPIRE.DSK, Diskfile for emulators, to start the game, type *RUN"VVRUN"

AtoMMC version:

  VVRUN  = Basic introscreen
  VVSCR  = Titlescreen
  VVCODE = Gamecode

  To start the game, type: *VVRUN

