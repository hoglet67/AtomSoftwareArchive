Knight Hero:
------------

THE GAME

This is an action arcade/platform game for Spectrum 48K (without music)/128K (with AY music) made using Arcade Game Designer 4.7 and AGDMusicizer II.
The main character - the player - is a Black Knight chess piece.
But this is not a chess board game.
He was the only one of the white pieces that didn't get caught by the black pieces.
So he went to the black pieces domains to free the other imprisoned white pieces.

PLAYING THE GAME

The game has 17 playable screens.
In the first screen, the black knight has to pick his clone figure (has if it's a small tutorial).
In screens 2 to 16, the black knight has to release the black piece imprisoned in each one.
In the last screen, the black knight has to pick the chess board to finish the game.

On each screen he as to avoid getting caught by the white pieces:
- Some of them patrolling the screen in linear movements, like up and down or left and right;
- Some of them are bouncing in the screen;
- Some of them are patrolling the screen using the ladders.
The black knight has to avoid also the embers and the falling rocks.
Touching the embers or being caught by the falling rocks or the white pieces means losing a life.

In the bottom of the game screen are:
- The score;
- The message space;
- The numbers of lives remaining;
- The number of paws released;
- The figures of the black pieces as they're being released.

The game starts with 5 lives. Losing all of them means GAME OVER.

CONTROLS

The character can be moved using Keyboard, Kempston Joystick or Sinclair. Select the desired control scheme by pressing 1, 2 or 3 in the Menu.

The Keyboard controls are as follow:

Q for UP
A for DOWN
O for LEFT
P for RIGHT
SPACE for JUMP
H for PAUSE

CREDITS

Game made by Jaime Grilo using:
- Arcade Game Designer (AGD) 4.7 by Jonathan Cauldwell
- AGDMusicizer II by David Saphier
  Loading screen by Andy Green
  Music by Riskej
  Font (charcters): Defender

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

  KNIGHT.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  KNIGHT.DSK, Diskfile for emulators, to start the game, type *RUN"KHRUN"

AtoMMC version:

  KHRUN  = Basic introscreen
  KHSCR  = Titlescreen
  KHCODE = Gamecode

  To start the game, type: *KHRUN

