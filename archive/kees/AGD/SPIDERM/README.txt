Spider Mami:
------------

Platforms: ZX SPECTRUM

Plot:

The life of a little spider is very difficult, every day you have to go out to look for bread for your children. And if you also have a hundred children, it goes without saying that things are going uphill. Fortunately the world is full of soft and juicy little flies.
Spider-Mami is a game about overcoming stages, designed to compete with friends and seek the highest score. In each phase you can find ten flies that you can catch in various ways: catching them, jumping on them, spitting out a net... each one gives a different score.
And be careful, the world is very dangerous and in some places there are bugs more dangerous than you.

Keys:

 Q - Up
 A - Lower
 O - Left
 P - Right
 M - Shoot

Thanks:

Sergio thEp0pE - Routine to control Vortex Tracker and AY sound (Creative Commons).
Jonathan Cauldwell - AGD
Allan Turvey - AGDX

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

  Q   - UP
  O   - LEFT
  P   - RIGHT
SPACE - FIRE

===================================================================
Tape/Disk and AtoMMC version:
===================================================================

Tape version:

  SPIDERMAMI.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  SPIDERMAMI.DSK, Diskfile for emulators, to start the game, type *RUN"SMRUN"

AtoMMC version:

  SMRUN  = Basic introscreen
  SMSCR  = Titlescreen
  SMCODE = Gamecode

  To start the game, type: *SMRUN

