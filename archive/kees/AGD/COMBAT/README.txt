Combat Wombat:
--------------

Hey! Thank you for backing Hex Loader! In this folder you'll find your copy of Combat Wombat, the ZX Spectrum game featured in the graphic novel.

The game is in a .TAP file, which can be loaded using the free FUSE emulator. Versions of this for both PC and Mac are also included in the folder. For more information on FUSE and any troubleshooting please refer to the website: http://fuse-emulator.sourceforge.net/

In order to play Combat Wombat...

1. Install FUSE on your computer.
2. Run FUSE.
3. Select File > Open > and then navigate to the Combat Wombat .TAP file.
4. The game will then load.

INSTRUCTIONS

Help Combat Wombat in his battle against evil! Guide him through each scene, defeating Crossley Hill High School bully Buzzer Boyd, and collecting bowls of Angel Delight for extra points. Once you have completed one loop of the game, you will start again only now The Fugue will also try to attack Combat Wombat. Each loop adds another Fugue demon to the screen. How far can you get and how many points can you earn?

By default, FUSE will load and play the game immediately. If you wish to experience the full loading sequence, just as it was on original hardware, go to Options > Media and uncheck "fastloading".

CONTROLS

O - Left
P - Right
Z - Jump
X - Fire

CREDITS

Sprites by Dillon Whitehead
Game by MrTomFTW (https://beebush.itch.io/)
Loading screen by Andy Green (https://twitter.com/AndyMGreen68)

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

  COMBAT.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  COMBAT.DSK, Diskfile for emulators, to start the game, type *RUN"CORUN"

AtoMMC version:

  CORUN  = Basic introscreen
  COSCR  = Titlescreen
  COCODE = Gamecode

  To start the game, type: *CORUN

