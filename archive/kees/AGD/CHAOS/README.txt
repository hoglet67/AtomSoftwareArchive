The Adventure of Amy: Episode Zero
A Prelude to Chaos

This is a prototype of a game I am (sort of) working on. Its an adventure style game, where you need to collect 30 energy jewels scattered around the map. There are various items and obstacles to help and hinder your progress. 

This is essentially the start of the full game, with the first main dungeon. I had to sacrifice a few things due to the limitations of AGD, such as there is no actual boss, just stronger regular enemies. But I think it's turned out well considering.

Controls are Q,A,O,P to move
Space to Shoot (when activated)
1 to use items (unlocks doors and deactivates force fields when able)
2 to drink potion when low on energy.

Read more: http://arcadegamedesigner.proboards.com/thread/239/new-game-prelude-chaos#ixzz5ciIuIWCr

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

  CHAOS.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  CHAOS.DSK, Diskfile for emulators, to start the game, type *RUN"CHRUN"

AtoMMC version:

  CHRUN  = Basic introscreen
  CHSCR  = Titlescreen
  CHCODE = Gamecode

  To start the game, type: *CHRUN
