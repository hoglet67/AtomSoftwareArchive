Terrapins:
----------

Main code and graphics by Allan Turvey
Additional code by David Saphier
Additional graphics by Craig Howard

Control Keys
Standard Joysticks or
QAOP for movement, M or Space to drop a bomb.
pressing Z and M together will reset the game.

Instructions
Mama Terrapin's babies have been kidnapped by the evil bugs and are scattered throughout an eight storey building. Guide mama through the mazes to recover her children.

Search the boxes in each maze to find the baby terrapins, and bring them home. Beware however, as some boxes contain extra bugs!

Mama can defend herself using  a supply of bug bombs. These will temporarily disable a bug, rendering it harmless for Mama to pass through. Only one bomb can be dropped at a time however.

A supply of three extra bombs can be collected in the middle of the maze, but Mama can only carry a maximum of fifteen. An alarm will sound when Mama is out of bombs. Bombs which are not triggered will eventually disappear.

There are three types of bug – yellow, purple and blue. Yellow bugs are slow and stupid and are easy to avoid or trap. As time progresses however, they will evolve into the more intelligent purple bugs, and the very fast blue bugs. When you bomb a purple or blue bug, it will be downgraded. Later levels feature purple and blue bugs from the outset.

Tips
Build up your supply of bombs in early levels.
Yellow bugs are fairly easy to avoid and control as long as they don't gang up on you, so try to downgrade blue and purple bugs to yellow as quickly as possible.
Some boxes contain bugs so it's a good idea to lay a bomb as soon as they appear.

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

  TERRAPINS.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  TERRAPINS.DSK, Diskfile for emulators, to start the game, type *RUN"TPRUN"

AtoMMC version:

  TPRUN  = Basic introscreen
  TPSCR  = Titlescreen
  TPCODE = Gamecode

  To start the game, type: *TPRUN

