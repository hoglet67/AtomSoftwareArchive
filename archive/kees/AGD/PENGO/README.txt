Pengo Quest:
------------

The ZX Spectrum is one of our most popular systems for new homebrews, especially as they come out nearly every week by different developers, containing lovely colour clashes and bleep and blop sound effects. Thus we have another ZX Spectrum game this week and this time it's from Gabriele Amore with ' Pengo's Quest '; an arcade like game, whereby you play as a Penguin and must clear the correct amount of ice from the screen to open the way to the exit!

Be warned though it isn't as easy as just clearing Ice blocks, as throughout the game enemies are moving fast and if they touch you, or the time runs out, you spin around and die. There is an upside though, because if you move the blocks at the right time, you can squash the enemies for good! A lovely game indeed even from my short play through, it's just a shame it's only 90% complete with missing music and a decent ending screen.

Controls:

Q - Up
A - Down
O - Left
P - Right
2 - Pause

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

  PENGO.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  PENGO.DSK, Diskfile for emulators, to start the game, type *RUN"PENRUN"

AtoMMC version:

  PENRUN  = Basic introscreen
  PENSCR  = Titlescreen
  PENCODE = Gamecode

  To start the game, type: *PENRUN


