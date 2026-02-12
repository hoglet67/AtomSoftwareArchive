Trees and Tents:
----------------

About the game 

On my vacation I solved some puzzles in a puzzlebook. 
One of my favourite puzzles was Trees and Tents so I thought this would be a nice game for the Acorn Atom.
I found some inspiration on the internet at: https://www.puzzle-tents.com/
You can also find some algoritms for the games on: https://www.chiark.greenend.org.uk/~sgtatham/puzzles/

After doing some tests with a grid algoritm, I wrote the code in assembler and used it in MPAGD.
The game is written in MPAGD because then you have sprites and fonts.

Controls 

The keys for the game are: 

   Q - Up 
   A - Down 
   O - Left 
   P - Right
   X - Exit game 
 Space - Toggle Mark field, Tent, Empty field 
 

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
  A   - DOWN  
  O   - LEFT
  P   - RIGHT
  X   - Exit game 
SPACE - Toggle Mark field, Tent, Empty field

===================================================================
Tape/Disk and AtoMMC version:
===================================================================

Tape version:

  TENTS.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  TENTS.DSK, Diskfile for emulators, to start the game, type *RUN"TTRUN"

AtoMMC version:

  TTRUN  = Basic introscreen
  TTSCR  = Titlescreen
  TTCODE = Gamecode

  To start the game, type: *TTRUN

