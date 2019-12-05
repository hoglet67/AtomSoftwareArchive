Operation Labyrinth Fall:
-------------------------

The year is 2199 and with the overpopulation and ever decreasing supply of available resources on Earth, the future of the Human Race is in doubt.

A world coalition project was formed to assess planets offering a viable alternative home for the Human Race. Probes were sent out to numerous planets. Only one planet met all of the requirements to provide the cradle for this new civilazation - 'GJ1214b', also known as Waterworld or, more simply, 'Earth 2'.

Technological breakthroughs allowed for an expensive but sustainable energy source which would allow the coalition to setup the first base on what would be Humanity's future home - Energy Gems. Operation Labyrinth was the first manned mission to 'Earth 2', carrying 50 Energy Gems with the aim of setting up this initial colony.

A few months before arriving at 'Earth 2' an unknown incident occured on the Operation Labyrinth vessel, resulting in a crash landing on the planet 'Kepler-413b'.
Mission Control reported that the crash was significant, causing severe damage to the vessel. It's possible there were survivors but no communications have been received. All Operation Labyrinth crew members are now presumed dead.

The economic impact of the failed mission was significant due to the high costs of producing more Energy Gems. Given that the Energy Gems are stored in a resillient shell, it was agreed by the coalition the the probabillity of them remaining intact following the crash was significant enough to warrent a salvage mission.

As the commander of Operation Labyrinth Fall, your mission is to travel to Kepler-413b and retreive the 50 Energy Gems. Be warned, the cause of the death of te previous crew is unknown. Consider the planet extrememly dangerous.

Controls:
  O   - Left
  P   - Right
SPACE - Jump
  Q   - Jetpack
  N   - Drill

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

  OPLABFALL.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  OPLABFALL.DSK, Diskfile for emulators, to start the game, type *RUN"OLFRUN"

AtoMMC version:

  OLFRUN  = Basic introscreen
  OLFSCR  = Titlescreen
  OLFCODE = Gamecode

  To start the game, type: *OLFRUN

