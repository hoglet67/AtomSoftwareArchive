Payndz is new to creating games on the Spectrum and Cybermania is his first attempt at writing a game in AGD. From the thread on WoS, Payndz mentions that the game is a cross between Robotron, Berzerk and Pac-Man. We had a little play and we think this is a great little game to pass some time, especially for a first attempt! You play at what looks like a Cyber Robot and you have to rescue the humans from bigger and very angry red robots! (Also different types as you progress). Download the game from the link below. There is no in-game music but it does have some sound effects that are sufficient enough.

Game controls:

left - O
right- P
up   - Q
down - A
fire - Z

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

  CYBER.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  CYBER.DSK, Diskfile for emulators, to start the game, type *RUN"CYBRUN"

AtoMMC version:

  CYBRUN  = Basic introscreen
  CYBCODE = Gamecode

  To start the game, type: *CYBRUN

