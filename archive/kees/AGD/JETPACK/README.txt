Jet Pack Neo:
-------------

PLAYING THE GAME

The game has 25 playable screens, representing 5 different planets with 5 distinct zones each.
In the first level of each Planet, Neo must assemble his new rocket (which is divided into 3 parts spread across the screen).
Then,  he must collect 6 fuel container to refill the rocket and then take off to the next location.
After the first level, the rocket stays assembled and just requires refuelling.
Neo also will find some planet souvenirs that increases the score.

But Neo don't have easy work...
Neo's gun fire system only allows firing one shot at the time (not continuously like in JetPac game). 
To increase the difficulty, each time Neo accidentally hits a fuel container, it explodes and Neo also loses a fuel container already collected and placed on the rocket. 
Ah! And occasionally Neo's gun become overloaded and momentarily stops firing.  
The local creatures became hostile to our hero and just a touch with Neo to both explode and the player lose a life.
Careful with the deadly beams too. One touch and there goes another life.
The game starts with 5 lives.
Assembling a rocket add 1 extra life.
Losing all of them means GAME OVER.

ADDITIONAL INFORMATION:

There's a 2 mode game:
- a normal one (like Jetman in JetPac, Neo flies faster than walks);
- a slow one (Neo flies and walks slowly).

CONTROLS

The character can be moved using only Keyboard:

  Q   for UP
  O   for LEFT
  P   for RIGHT
SPACE FIRE
  X   for QUIT 

CREDITS

Game made by Jaime Grilo using:

- Arcade Game Designer eXpert (AGDX) by AGDLabs 
 (a mod version of Arcade Game Designer (AGD) 4.7 by Jonathan Cauldwell)
- AGDMusicizer II by David Saphier
- Loading screen by José Silva
- Font by Paul Van Der Laan
- Music by Fatal Snipe
- Game tested by André Luna Leão

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

  JETPACKNEO.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  JETPACKNEO.DSK, Diskfile for emulators, to start the game, type *RUN"JPNRUN"

AtoMMC version:

  JPNRUN  = Basic introscreen
  JPNSCR  = Titlescreen
  JPNCODE = Gamecode

  To start the game, type: *JPNRUN

