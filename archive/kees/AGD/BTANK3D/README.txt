Battle Tank 3D and some crazy Aliens:
-------------------------------------

The ZX Spectrum has been getting quite a bit of love from homebrew developers lately.  Take Battle Tank 3D for example which is basically a 3rd person take on the classic Battlezone game.  Gabriele Amore has taken the daunting task of making something original on the Spectrum (think just how hard that is) and came up with Battle Tank 3D. 

Par for the course in these games, you are the only hope for the planet Earth against the impending alien threat.  Equipped with the most powerful tank on the planet you are tasked with eliminating every alien in your path and in the process, saving us puny humans.  Hey, it is an original game on a platform that has had nearly everything possible already done on it, I think we can overlook the story on this one.  The point is, there are aliens and you have firepower, go introduce the two to each other.

Battle Tank 3D features a funny, animated in the classic Maniac Mansion style of extremely choppiness, cut scenes that setup the proceedings quite well.  In the opening cut scene not only the situation is laid out but also what to expect as far as resources in the levels.

Battle Tank 3D is quite a small game therefore some sacrifices had to be made.  The music is non-existent here so you are left with beeps and boops- nothing spectacular.  If you really need music in your game, turn on your favorite MP3’s in the background and jam out to whatever you want.  This is a Spectrum game, no one is expecting it to have awesome music or sound effects.
Battle Tank 3D was created using Arcade Game Designer (AGD).  AGD is a development engine/language for the ZX Spectrum that allows complex games to be created without having to understand machine language or C++.

Head over to World of Spectrum to get your copy of Battle Tank 3D which is available in Tape and z80 formats.

Source: Indie Retro News

Controls:

Q - Speed up
A - Slow down
O - Left
P - Right
M - Fire

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

  BTANK3D.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  BTANK3D.DSK, Diskfile for emulators, to start the game, type *RUN"BT3RUN"

AtoMMC version:

  BT3RUN  = Basic introscreen
  BT3SCR  = Titlescreen
  BT3CODE = Gamecode

  To start the game, type: *BT3RUN

