Aunt Rose:
----------

- © 2021 FRANCESCO FORTE - ALL RIGHTS RESERVED - THIS IS A FREE GAME - EVERY COMMERCIAL DISTRIBUTION WITHOUT THE EXPRESS CONSENT OF ITS AUTHOR IS STRICTLY FORBIDDEN
- AUTHORED WITH ARCADE GAME DESIGNER 4.8 - © 2018 JONATHAN CAULDWELL
- THANKS:
JONATHAN CAULDWELL (AGD)
PAUL JENKINSON (AGD TUTORIAL)
ALESSANDRO GRUSSU (TECHNICAL SUGGESTIONS)
DANIELE ZAMBRINI AND LUIGI SERRANTONI ("ZIA ROSA" GAME AUTHORS)

INTRODUCTION
------------
In 1986 Daniele Zambrini and Luigi Serrantoni created the first italian text adventure, "Zia Rosa". This is the arcade version (with some modifications...) of that game.

THE GAME
--------
Your aunt Rose is dead. You, her nephew, want to steal her four treasures: 
 
- the insurance policy 
- the pearl necklace 
- the gold bracelet
- the diamonds 
 
The treasures are hidden in her house, but be careful.
You may not be alone...

GAME CONTROLS
-------------
It's possible to redefine the game controls.
Default controls are:

I - LEFT
O - RIGHT
Q - UP / ENTER DOORS
A - DOWN
P - TAKE /LEAVE OBJECTS (you can carry a maximum of four objects at a time)
N - SELECT: you can select one of the objects you are carrying (to use or leave it) or the "OPEN/PUSH" option
M - OPEN/PUSH/USE:
 - to use the selected object (you can use objects individually or on another object you aren't carrying or on furnitures etc.)
 - to open cabinets, push buttons etc. if "OPEN/PUSH" option is selected

Good luck!

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

  AUNTROSE.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  AUNTROSE.DSK, Diskfile for emulators, to start the game, type *RUN"ARRUN"

AtoMMC version:

  ARRUN  = Basic introscreen
  ARSCR  = Titlescreen
  ARCODE = Gamecode

  To start the game, type: *ARRUN

