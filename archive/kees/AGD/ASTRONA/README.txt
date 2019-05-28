Astronaut Labyrinth:
--------------------

THE GAME

This is an action arcade/adventure game for Spectrum 48K (without music)/128K (with AY music) made using AGDX (a modified version of Arcade Game Designer 4.7) and AGDMusicizer II.

The main character - the payer - is Brian Bentley, a space explorer who was sucked into an intergalactic portal and landed inside a sort of astronaut-shaped labyrinth when he was traveling in his spacecraft.

So Brian must collect the 6 parts of an astronaut draw to activate the way out.

Unfortunately, the parts are scattered amongst the labyrinth.

But that is not enought.
He also has to find the power battery to make the exit works.

The battery is in an hidden place and to access that Brian has to find the teleport key first.

After that, Brian can finally escape from the Astronaut Labyrinth.


PLAYING THE GAME

The game has 30 playable screens.

The spacecraft can carry 1 part of the astronaut draw at a time.

The flashing [AL] at the meddle top the screen indicates that you are carrying 1 part of the draw.

When carrying a part, the spacecraft must return to the starting screen and place it in a kind of screenboard.

On his way, Brian will find many hazards:
- Aliens that take energy and can be shot down.
- Aliens that take energy and can be shot down and spawned again.
- Aliens that take energy but can't be shot down;
- Aliens that can't be shot down but destroy the spacecraft at once;
- Presses that destroy the spacecraft;
- A STOP/GO system doors (STOP can destroy spacecraft / GO allows spacecraft go through it);
- Deadly walls hat destroy the spacecraft.

When the spacecraft energy runs out, the player loses a life.

On restart, the energy is recovered.

The spacecraft can also collect the 19 characters that form ASTRONAUT LABYRINTH (space between the words included).
This will increase the score.

It's essential that Brian finds the teleport key (only available when all the 6 draw parts are in the screen board) that allows the player uses the teleporter to access to the level where is an enemy spacecraft wich has to be destroyed for Brian picks up the power battery.

In the top of the game screen we can see:


- The actual score;
- The number of lives remaining;
- The flashing target to indicate that the player have the teleport key;
- The flashing [AL] when spacecraft is carrying a draw part;
- The flashing spark to indicate that the player have the power battery;
- The letters picked up that form the ASTRONAUT LABYRINTH expression;
- The flashing Pause Game indicator.

In the bottom of the game screen we can see:


- The Energy bar.

The game starts with 9 lives. During the gameplay, you can pick up an extra life.
Losing all of them means GAME OVER.


CONTROLS

The character can be moved using Keyboard, Kempston Joystick or Sinclair. 
Select the desired control scheme by pressing 1, 2 or 3 in the Menu.
You can REDEFINE KEYS pressing R in the Menu.


The Keyboard controls are as follow:

Q for UP
A for DOWN
O for LEFT
P for RIGHT
M for FIRE
SPACE for TELEPORT
H for PAUSE

CREDITS

Game made by Jaime Grilo using:
- Arcade Game Designer eXpert (AGDX) by AGDLabs (a mod version of Arcade Game Designer (AGD) 4.7 by Jonathan Cauldwell)
- AGDMusicizer II by David Saphier
Loading screen by Andy Green
Original image by STARDER
Music by Visual
Font by Damien Guard: Datel Tribute 
Game tested by André Luna Leão

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

  ASTTRONAUT.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  ASTRONAUT.DSK, Diskfile for emulators, to start the game, type *RUN"ASTRUN"

AtoMMC version:

  ASTRUN  = Basic introscreen
  ASTSCR  = Titlescreen
  ASTCODE = Gamecode

  To start the game, type: *ASTRUN

