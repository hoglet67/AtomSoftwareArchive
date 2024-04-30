The Unicycle Adventure:
-----------------------

Hi all.  Welcome to my first ever video game!  What we have here is something incredibly basic that I made while learning how to use AGD 4.7.  It's a bit of a pot of ideas, and each screen is basically me learning how do things.  I will follow this up at some point with a proper version once I learn how to do loading screens, music etc, but for now this is more a proof of concept than anything else.

Controls:

Move left = O
Move right = P
Jump = Space
Move up a rope = Q
Move down a rope = A

Feedback is welcome, although I suspect most people won't be very impressed.  We've all got to start somewhere though, right?

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

  UNICYCLE.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  UNICYCLE.DSK, Diskfile for emulators, to start the game, type *RUN"UCRUN"

AtoMMC version:

  UCRUN  = Basic introscreen
  UCSCR  = Titlescreen
  UCCODE = Gamecode

  To start the game, type: *UCRUN

