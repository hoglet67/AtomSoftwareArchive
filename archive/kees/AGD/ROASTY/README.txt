Roasty:
--------

You are Roasty - the potato that wants to be eaten.
Your task is to flick the switch which turns on the oven, and then get inside to get cooked and become the golden crispy delight you were destined to be!

Initially, you can walk and jump, but when the oven is on you get so excited that you can't stop jumping and getting giddy!

CONTROLS

 O = LEFT 
 P = RIGHT 
 Q = JUMP 
 
Written by Dave Hughes 2023 using AGD and asm.

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

  Q   - UP
  O   - LEFT
  P   - RIGHT
SPACE - FIRE

===================================================================
Tape/Disk and AtoMMC version:
===================================================================

Tape version:

  ROASTY.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  ROASTY.DSK, Diskfile for emulators, to start the game, type *RUN"RORUN"

AtoMMC version:

  RORUN  = Basic introscreen
  ROSCR  = Titlescreen
  ROCODE = Gamecode

  To start the game, type: *RORUN

