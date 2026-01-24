AI made me do it:
-----------------

AI Made me do it: The Awful Adventures of [Insert Protagonist's Name] A Typical Sloanysoft Game
This is an entry for the 2023 C.S.S Crap Games Competition.  Further info about this and other entries can be found & downloaded here: https://csscgc23.blogspot.com/

Recently I have become utterly terrified of the power of AI and the fact that it is now inevitable that it will one day be harnessed to destroy our lovely planet and every one of it’s miserable inhabitants.

So how do I respond to this frankly unsettling scenario? Well, I cope just like every kid who grew up in the 80s would, by repressing those fears & making a stupid joke out of it.

So, with that cheery introduction aside, I present to you, the product of a  weekend spent obeying our new AI Overlord’s commands to make a ZX Spectrum game with my son.

This is what AI told us to do so this is what we did...

Keys:

 O - Left
 P - Right
 M - Jump
 Y - Pause

Author: Sloanysoft

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

  O   - LEFT
  P   - RIGHT
  Y   - Pause 

===================================================================
Tape/Disk and AtoMMC version:
===================================================================

Tape version:

  AI.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  AI.DSK, Diskfile for emulators, to start the game, type *RUN"AIRUN"

AtoMMC version:

  AIRUN  = Basic introscreen
  AISCR  = Titlescreen
  AICODE = Gamecode

  To start the game, type: *AIRUN

