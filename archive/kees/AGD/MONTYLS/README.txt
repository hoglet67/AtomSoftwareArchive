Monty's Last Strike:
--------------------

STORY:
When Monty was locked away in her majesty's prison he was told about the legend of the queen's missing gold. After many adventures around the world Monty has returned to the UK and when sat watching TV he finds himself thinking once again about the gold.

The mines have been closed by Margaret Thatcher during the 1980's therefore they should be empty so Monty decides to go on another adventure.

Welcome to Monty's Last Strike!

KEYS:
q,a,o,p and space or joystick

INSTRUCTIONS:
Collect as many objects as possible and find the gold then make it out alive.

THANKS:
Binman For Help with release, Jonathan for AGD, Paul J for the AGD video tutorials, Dominic and Lily for putting up with me doing this and testing, Luca and Binman for Land of the Miremare as the attention to detail inspired me.

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

  MONTYLS.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  MONTYLS.DSK, Diskfile for emulators, to start the game, type *RUN"MLSRUN"

AtoMMC version:

  MLSRUN  = Basic introscreen
  MLSCODE = Gamecode

  To start the game, type: *MLSRUN

