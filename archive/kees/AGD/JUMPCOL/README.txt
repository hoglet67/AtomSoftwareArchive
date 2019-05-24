JumpCollision:
--------------

Another new ZX Spectrum homebrew this week and a recent update to last months Raul "Gamer80" entry for the ZX Dev 2015 competition, is the action, shooter of ' Jumpcollision '. In this game you play as a big yellow ship, that has the ability to jump about and blast enemies like a crazy thing! For what is a highly addictive and enjoyable game spanning 80 levels, comes with high difficulty as you will die many many times from fast moving enemies!

Although the game isn't in English at least not the version we used through Spectaculator, it's still pretty easy to understand game play wise just hard to master. So don't expect 80 levels to be completed any time soon.

Controls:

  O   - Left
  P   - Right
  Q   - Up
  A   - Down
SPACE - Fire

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

  JUMPCOL.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  JUMPCOL.DSK, Diskfile for emulators, to start the game, type *RUN"JCRUN"

AtoMMC version:

  JCRUN  = Basic introscreen
  JCSCR  = Titlescreen
  JCCODE = Gamecode

  To start the game, type: *JCRUN

