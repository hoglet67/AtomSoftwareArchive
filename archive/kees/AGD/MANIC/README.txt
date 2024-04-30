Manic Mulholland:
-----------------

Sloanysoft is proud to present our first ever ZX Spectrum game.  In the style of those platformer games from the golden age of the 80s.  To be played on a Spectrum emulator, or on a real Spectrum (48k & above) through one of those .tap converters such as Play ZX.

Plot

The events portrayed in this game are all true. The names are real names of real people and real organizations
The year is 199X and with just one week to go before his history assignment is due, Mulholland has decided to embark upon a 72 hour Final Fantasy VII session to clear his mind. Upon completing his quest however he has fallen into the sleep of the century.
Your mission is to guide him through his nightmare sleep and wake him in time to complete his assignment. The fate of future generations of history students is in your hands, good luck… you’ll need it!!!

Controls:

 O  - Left
 P  - Right
SPC - Jump
 Y  - Pause

Credits:

Written and directed by: Dave Sloan
Starring: RetroHitch
Splendid ideas & splendid people: Mr Kola, DazzaJ73, Pinkemma, Pixelsatdawn, Hicks, Eddhorse, Hoffman, Beanhed, FZ_Berz, WorldofMrGrey, AmigaFormortals and Mike Richmond
Special thanks to: Bruce Groves, Kees van Oss and Jonathan Cauldwell

Atom version done by Kees van Oss.

===================================================================
System requirements:
===================================================================

- Standard Acorn Atom
- 32 KB RAM
- 8 KB video RAM (#8000-#9FFF)
- Joystick connected to keyboard matrix (Optional)
- Joystick connected to PORTB AtoMMC interface (Optional)
11
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

  MANIC.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  MANIC.DSK, Diskfile for emulators, to start the game, type *RUN"MMRUN"

AtoMMC version:

  MMRUN  = Basic introscreen
  MMSCR  = Titlescreen
  MMCODE = Gamecode

  To start the game, type: *MMRUN

