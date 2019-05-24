Monty's Honey Run:
------------------

Way back in the 1980's Gremlin Graphics released the very first Monty Mole game in the series for the ZX Spectrum and C64. This lovable character that looked like a cross between a human and a mole, star'd in his very own adventure as ' Wanted : Monty Mole ' , which from then on spawned a number of other famous sequels on different 8-bit systems such as Monty on the Run and Auf Wiedersehen Monty. But today as a fan game of that classic series and his first game using AGD, Andy John has released ' Montys Honey Run ' for the ZX Spectrum.

Just as Dizzy has his very own adventures so does Monty, and in this one Monty has bought a Honey Shop which annoyingly was going really well up until some Bee's attacked him and stole the honey pots. So using your bravery and skills it's down to you to help poor Monty and get his honey back, or he will probably end up back in those coal mines from the first game.

Montys Honey Run is a very good game indeed and to be honest if I had just downloaded it without any knowledge about its development, I would never have believed it was Andy Johns very first game. The graphics are lovely and vibrant with clear details between vine and ledge, the animations are very well done more especially Monty's movement, the gameplay is challenging without the frustrating difficulty found in the earlier games, and the controls are very responsive. The only down side however is the hit detection which can be a little unforgiving at times!

Controls:

  O   - Left 
  P   - Right
  Q   - Up
  A   - Down
SPACE - Jump

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

  MONTY1.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  MONTY1.DSK, Diskfile for emulators, to start the game, type *RUN"MM1RUN"

AtoMMC version:

  MM1RUN  = Basic introscreen
  MM1SCR  = Titlescreen
  MM1CODE = Gamecode

  To start the game, type: *MM1RUN

