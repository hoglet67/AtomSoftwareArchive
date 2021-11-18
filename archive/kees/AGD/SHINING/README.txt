The Shining:
------------

- © 2020 FRANCESCO FORTE - ALL RIGHT RESERVED - THIS IS A FREE GAME - EVERY COMMERCIAL DISTRIBUTION WITHOUT THE EXPRESS CONSENT OF ITS AUTHOR IS STRICTLY FORBIDDEN
- AUTHORED WITH ARCADE GAME DESIGNER 4.8 - © 2019 JONATHAN CAULDWELL
- BASED ON STEPHEN KING'S NOVEL "THE SHINING" (© 1977 STEPHEN KING) AND STANLEY KUBRICK'S "THE SHINING" (© 1980 WARNER BROS PICTURES)
- THANKS:
  JONATHAN CAULDWELL (AGD)
  PAUL JENKINSON (AGD TUTORIAL)
  ALESSANDRO GRUSSU (TECHNICAL SUGGESTIONS)

THE GAME
--------
Jack Torrance, winter caretaker of the Overlook Hotel, suffered its evil influence and decided to exterminate his family.
His wife Wendy helped their son Danny escape through a small window and Danny hid in the big maze outside the hotel. Jack has locked the front door and is now looking for Danny in the maze. Wendy has to find a way out of the hotel, find Danny before Jack and return to the maze entrance. Halloran, the cook, is coming to take them away.

FIRST PART: THE HOTEL
---------------------
Jack has lost a box containing the keys to the rooms on one of the hotel's three floors.
Wendy must find this box. Then she must look for the keys to the rooms on the other two floors and, subsequently, the key to the front door. These keys are all hidden in the closets of the bedrooms or in those of the bathrooms.
The keys have different colors:

First floor: green keys
Second floor: red keys
Third floor: yellow keys
Front door: white key

Ghosts
------
The Overlook Hotel is haunted by ghosts. Wendy must avoid contact with them or will lose energy (value at start: 200). If Wendy runs out of energy, she'll die.

SECOND PART: THE MAZE
---------------------
Wendy must find Danny in the maze and return to its entrance where Halloran is waiting for them to escape together. But Jack is hunting for them...

GAME CONTROLS
-------------
It is possible to redefine the game controls.
Default controls are:

O - LEFT
P - RIGHT
Q - UP
A - DOWN

Enjoy yourselves!

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

  SHINING.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  SHINING.DSK, Diskfile for emulators, to start the game, type *RUN"SHRUN"

AtoMMC version:

  SHRUN  = Basic introscreen
  SHSCR  = Titlescreen
  SHCODE = Gamecode

  To start the game, type: *SHRUN

