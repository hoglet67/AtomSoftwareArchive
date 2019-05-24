Droid Buster:
-------------

The games just keep on coming, as after already mentioning The Last Ninja (1) possibly coming to the ZX Spectrum, we are here to shout out that the C64 version of 'Mandroid' is being remade as ' Droid Buster ' for the ZX Spectrum via the ZX-Dev-MIA-Remakes competition. According to the developer of this remake, Mandroid was originally going to come to the ZX Spectrum as Cyborg but with it being never released, the developer is remaking the game in his own image, both the graphics and mechanics.

Developed by Ariel Endaraues and using AGD, Droid Buster looks to be a fab game for those of you who like a bit of action in their Spectrum way of life. As from the look of the video above, you can move around and punch enemies in the face for each screen to made accessible for further enemy punching fun!

Controls:

  Q   - Up
  A   - Down
  O   - Left
  P   - Right
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

  DBUG.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  DBUG.DSK, Diskfile for emulators, to start the game, type *RUN"DBRUN"

AtoMMC version:

  DBRUN  = Basic introscreen
  DBSCR  = Titlescreen
  DBCODE = Gamecode

  To start the game, type: *DBRUN

