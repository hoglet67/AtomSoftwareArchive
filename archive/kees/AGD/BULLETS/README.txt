Bulletstorm:
------------

This is 1984. A terrible alien invasion has put mankind against the ropes. Only one hope: YOU! Take control of the most advanced spacecraft fighter and flight on Earth, outer space and Mars, the alien's home planet.

Bullet Storm needs a bit of strategy: the ammunition is spent! Use it with care! 30 levels and 3 final bosses need all your survival instinct... Reload, increase your speed and get extra lives, of course.

The war is controlled by keyboard:

S -- Start   O -- Left       P -- Right
Q -- Up      A -- Down   SPACE -- Fire

Credits:
Code, level design and graphics by Volatil.
Music by Mr Rancio

Special thanks to the testers (Perretes Team), the Spectrum Makers group and my loving family.

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

  BULLETSTORM.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  BULLESTORM.DSK, Diskfile for emulators, to start the game, type *RUN"BSRUN"

AtoMMC version:

  BSRUN  = Basic introscreen
  BSSCR  = Titlescreen
  BSCODE = Gamecode

  To start the game, type: *BSRUN

