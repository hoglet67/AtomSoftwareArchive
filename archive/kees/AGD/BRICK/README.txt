As many of you are aware by now going by our write up today, the Internet Archive has added many new handheld games to their playable line up going right back to the early 80's such as Donkey Kong, Pac-Man and even Q*Bert! Well it looks as if another handheld has made an appearance as Dave Clarke has contacted us regarding his in development Brick Racer for the ZX Spectrum!

If you've never heard of this device before ( I haven't ), according to the wiki page for this handheld, "devices like Brick Game (E-Star E-23) include games using the block grid as a crude, low resolution dot matrix screen. Such devices often have many variations of Tetris and sometimes even other kinds of games like racing or even space shooters, such as Space Invaders, where one box projects boxes at the enemy boxes". As such Dave Clarke aims to bring one of the better games from the Brick Game handheld over to the ZX Spectrum with the possibility of a 'modern' version included with AY music. Sadly that's pretty much all we have on this game so far, but Dave has gone on to say that other brick games may be converted too!

Controls:
-----------
O - Left
P - Right

You can also use Kempston or Sinclair Joysticks.

This game has been created with Arcade Games Designer by Jonathan Cauldwell.

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

  BRICK.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  BRICK.DSK, Diskfile for emulators, to start the game, type *RUN"BRRUN"

AtoMMC version:

  BRRUN  = Basic introscreen
  BRSCR  = Titlescreen
  BRCODE = Gamecode

  To start the game, type: *BRRUN

