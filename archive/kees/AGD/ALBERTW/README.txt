Albert The Wolf:
----------------

The Game

Albert The Wolf is a platform game, in which you must position bricks in the most convenient way in order to steal an egg from the hen and put it in the basket. White bricks can be moved using the crosshair; pink ones cannot be moved. The game is ten mini-games which can be played in sequence, or you can just pick the one you like the most!
The dog or the bats can break your white bricks or steal your egg, but cannot do anything if you drop them on the ground.
Be careful with the egg: if you drop it from too high you will crack it! You can also use the white brick or the egg to neutralize the dog for a while. Neither dogs nor bats can kill you; however, they can steal precious seconds from your time. On the later levels you will find an alarm clock to get 50 seconds bonus.
In the early levels you get a "brick bonus" for parsimonious use of the white bricks.
Some levels are two screens wide. The last level is three screens wide.
This is an open AGD game, so you can modify it at will: I hope you do that and if if you do, please save a .szx or whatever with your name in the file name.

Game Controls
O - Left, P - Right, SPACE - Jump, Q - Pick Up Brick, A - Drop Brick

Hold down M and use the O, P, Q and A keys to move the crosshair around. Take it to the position where you want to throw a block and release M. Albert will then throw the brick.

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

  ALBERTWOLF.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  ALBERTWOLF.DSK, Diskfile for emulators, to start the game, type *RUN"AWRUN"

AtoMMC version:

  AWRUN  = Basic introscreen
  AWSCR  = Titlescreen
  AWCODE = Gamecode

  To start the game, type: *AWRUN

