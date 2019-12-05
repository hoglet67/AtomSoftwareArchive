PROSPECTOR:
-----------

FOR THE  ZX SPECTRUM 48K
©2018  AMCGAMES
THE STORY

The townsfolk had warned us against the old, abandoned mine. “It's cursed!” they told us, and crossed themselves when they did. But we were too greedy, too foolish to listen...
My men went ahead to do some preliminary scouting of the mine, and I stayed back at our base camp to prepare supplies for our exploration. When they didn't return on time I didn't think much of it. They often lost track of time. But when the sun went down, and then the moon rose in the cold night sky, I began to worry.
Staring out at the night from the safety of the cabin, I heard a chilling sound in the distance. It sounded like a large animal, but somehow different. When it roared I heard... screams? I tried to tell myself it could have been the wind. But hearing the sound sent a chill down my spine, and I knew it had something to do with the disappearance of my men.
Collecting my pistol and some rope, I crossed myself before I set out into the night...
P., January 23, 1912

(From an unnamed prospector's journal, found by skiiers in 1970, frozen in the ice of northern British Columbia, Canada.)
THE GAME

PROSPECTOR is the exciting new action platformer from AMCGames for the Sinclair ZX Spectrum 48k. Features over 30 screens and multiple enemies!

CONTROLS

	Q / A	up or jump / down
	O / P	left / right
	SPACE	fire pistol

As well as keyboard control, Kempston and Sinclair joysticks are supported. 

CREDITS

Coding, design, and concept by Aleisha M. Cuff (Dec 2017-Jul 2018)
This game was made with AGDx

SPECIAL THANKS

Jonathan Cauldwell for Arcade Game Designer (AGD)
Allan Turvey and David Saphier for AGDx
Dave Clarke for code suggestion
Ariel Endaraues for playtesting 
Facebook's AGD Homebrew group for support and inspiration


THIS GAME MAY BE DISTRUBUTED FOR FREE 
IN ITS ORIGINAL FORM 
THOUGH ALL RIGHTS REMAIN WITH THE CREATOR

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

  PROSPECTOR.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  PROSPECTOR.DSK, Diskfile for emulators, to start the game, type *RUN"PRORUN"

AtoMMC version:

  PRORUN  = Basic introscreen
  PROSCR  = Titlescreen
  PROCODE = Gamecode

  To start the game, type: *PRORUN

