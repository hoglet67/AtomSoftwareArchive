Even more speccy news now, as after much teasing during the development stage, Gabriele Amore has finally released a brand new ZX Spectrum game called ' CASTLE CAPERS ' for playable on real hardware and online. Once again developed using AGD and again a platformer, you are on a mighty rescue mission to rescue the Dream Fairies who have been kidnapped by an evil mouse king and his menacing acolytes.

Throughout the game you must use your magic to make great Ice blocks to reach the fairies trapped on each platform. But along the way you must also use these blocks to make holes to get back down, because if you don't you'll be trapped and at worse eaten by the great king himself. And that's all there is to it, but be warned this is one of the hardest games you'll play from Gabriele Amore, as getting past the difficulty of level 2 is a huge task in itself.

Keys: O-P-M-1

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

  CAPERS.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  CAPERS.DSK, Diskfile for emulators, to start the game, type *RUN"CAPRUN"

AtoMMC version:

  CAPRUN  = Basic introscreen
  CAPSCR  = Titlescreen
  CAPCODE = Gamecode

  To start the game, type: *CAPRUN