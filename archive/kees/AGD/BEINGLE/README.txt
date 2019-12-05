BEING LEFT IS NOT RIGHT:
------------------------

Are you good at videogames? enough to play two of them at the same time? Dare to beat a platform and a "shoot'em up" at once (or look for a friend if you can't do it)

==== HOW TO PLAY ====

Pick up your favourite Spectrum emulator, open a 128k session and insert the file named "BeingLeftIsNotRight.tap". Use Tape Loader or LOAD "" to load the game, you're only a key press away to start to play the game. It also works in 48k but you won't hear the music from artist EA (https://zxart.ee/eng/authors/e/ea/)

What ?!? You don't know what an emulator is !? They are programs that emulate classic computers in a very reliable way, and you can load games like this one. I recommend you to download one of these totally free ones:

- RetroVirtualMachine, https://www.retrovirtualmachine.org/ 
- FUSE, https://sourceforge.net/projects/fuse-emulator/

==== STORY ====
Being Left behind is not right.

Some of your friends have been abandoned in distant planets with no chance of coming home. Get into your ship and travel through 15 worlds to help your stranded fellows. Complete the objectives of each level that are shown at the bottom of your screen, the path to the ship will open and your partners can go aboard. For example, in Level 01 the man only has to touch the switch in the upper section (half of the barrier dissppears), but unless you shoot ten enemies with the ship the other half of the barrier won't disappear. And you have to do this without losing a life because the screen and objectives reset from start every time one of your characters die. And watch your jump, your friends can jump high but will pass away if they fall too far.


Every time you complete a level, you will get an extra life. Gather enough for the hardest screens.

Are you ready to save them all on your own? or will you need a friend to give you a hand?

==== CONTROLS ====
Professional gamepads or ergonomic joysticks won't be useful this tame, you only have your old and reliable friend: the keyboard. You move the ship with one hand while the other is for moving the man, you must join both to go to the next level.

"W" (up), "S" (down), "A" (left), "D" (Right) is for moving the ship. The LEFT part of the screen
"O" (left), "P" (Right), "SPACE" (Jump) is for moving the man. The RIGHT part of the screen

To make things easier, the ship shoots automatically; but beware, the ammo is limited in some levels.

==== CREDITS ====
2019 - Created by AGD & Carlos Pérezgrín
Music by EA (https://zxart.ee/eng/authors/e/ea/)

Intro Theme: EA - "Away from home" 	https://zxart.ee/eng/authors/e/ea/away-from-home/
Main Theme: EA - "Hrenagment"      	https://zxart.ee/eng/authors/e/ea/hrenagment/
Boss Theme: EA - "Surprize"   		https://zxart.ee/eng/authors/e/ea/surprize/


==== ACKNOWLEDGEMENTS ====
Jonathan Cauldwell (AGD v4.7), Paul Jenkinson (AGD Tutorial), David Saphier (AGD Musicizer II v1.7), Luca Bordoni (freeing space for extra code), and Rafa Vico, GreenWeb Sevilla & Azimov (for helping me building the final .tap)

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

  BEINGLEFT.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  BEINGLEFT.DSK, Diskfile for emulators, to start the game, type *RUN"BLRUN"

AtoMMC version:

  BLRUN  = Basic introscreen
  BLSCR  = Titlescreen
  BLCODE = Gamecode

  To start the game, type: *BLRUN

