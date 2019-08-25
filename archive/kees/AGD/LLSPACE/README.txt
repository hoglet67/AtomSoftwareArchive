Lost Little Spaceman
We had announced Lost Little Spaceman as being a new game for the ZX Spectrum. It turns out that by testing we realize that it's only the first level, a kind of demo , of a game that is available on Google Play, Apple Store and Kindle Fire. The author had informed us that this was the first level, but by mistake we did not realize this information.
Let's hope the author converts it in full to the ZX Spectrum, since it has a lot of potential in terms of innovation and game mechanics. Anyone who wants to test the full version can access  the author's page  and download the game in the desired system. 

About the Spectrum version: 

Lost Little Spaceman is a  demo  for the ZX Spectrum 48K, created in AGD and later retouched in AGDX. It is a platform and adventure game in which we control an astronaut lost in a labyrinth, where we have to find the exit. It may seem, but it is not the generic platform game, since the author has created a little twist to add the concept of gravity, something that gives a very original touch in this first foray into Spectrum.

Controls:

Q - Up 
A - Down
O - Left
P - Right

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

  LLSPACEMAN.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  LLSPACEMAN.DSK, Diskfile for emulators, to start the game, type *RUN"LLSRUN"

AtoMMC version:

  LLSRUN  = Basic introscreen
  LLSSCR  = Titlescreen
  LLSCODE = Gamecode

  To start the game, type: *LLSRUN

