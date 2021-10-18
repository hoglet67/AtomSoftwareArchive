Gnoni 2020:
-----------

Azimov is an author who always surprises with developments that may seem conceptually simple but that turn out to be very well thought out and carefully executed. In this case, the proposal is the most interesting: making a second part of Gnoni , a game that Juan Pablo Cassain published in MicroHobby magazine number 183 in 1987.
For this sequel Azimov has decided to turn the original platform arcade into an open map game, where we must move in search of the necessary elements to repair our UFO. If we compare them side by side, the graphical similarity will undoubtedly draw attention, but there are also many nods to the original game and sections of the map where it returns to the platform mechanics.
In short, a beautiful tribute to the original game, which we hope reaches the ears of its author.

Controls:

O - Left
P - Right
Q - Up
A - Down
R - Reset

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

  GNONI.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  GNONI.DSK, Diskfile for emulators, to start the game, type *RUN"GNRUN"

AtoMMC version:

  GNRUN  = Basic introscreen
  GNSCR  = Titlescreen
  GNCODE = Gamecode

  To start the game, type: *GNRUN

