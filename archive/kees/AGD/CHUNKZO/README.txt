Chunk Zone:
-----------

Putting aside the NES Rom hacks, Gabriele Amore has released another ZX Spectrum game, and this time it's a third person Tank like shooter called ' Chunk Zone '. In this game you control what looks like a giant Tank and must blast evil green chunks that are constantly appearing and heading towards you at speed which will damage your vehicle. Also as an added extra challenge to the game there are at times evil white chunks which will need to be taken out. To complete each stage a set amount of blocks will need to be destroyed.

Regarded as a simple game and a mindless shooter, I would have to agree. It isn't one of Gabriele's better games as there's really not much to do other than move the vehicle left or right, speed up or down and shoot at green blocks which keep appearing again and again. It didn't do enough for me to keep coming back for more, but what I did like was the impression of speed driving across a red landscape and into the distance. But as was said it is supposed to be simple and mindless and this game is exactly that.

Controls:

Q - Up
A - Down
O - Left
P - Right
M - Fire

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

  CHUNKZONE.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  CHUNKZONE.DSK, Diskfile for emulators, to start the game, type *RUN"CZRUN"

AtoMMC version:

  CZRUN  = Basic introscreen
  CZSCR  = Titlescreen
  CZCODE = Gamecode

  To start the game, type: *CZRUN

