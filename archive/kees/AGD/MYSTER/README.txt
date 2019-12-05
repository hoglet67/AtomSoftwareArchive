HOOY-PROGRAM presents: 

an arcade-platform game "Magical Dimensions" for ZX Spectrum 128 computers' series. 


YERZMYEY: 
- idea, 
- script, 
- graphic, 
- levels, 
- fonts, 
- chiptune music
- digital music
- AGD parts of code

HELLBOJ: 
- Assembler coding
- hacking
- linking

MisterIOUS BEEP:
- 1-bit / BEEPER music

- Jonathan Cauldwell was traditionally a great moral and intellectual support. :) 


The game has 4 pretty vast levels (11 chambers each, which gives in total 44 screens to overcome).


It has been originally based on AGD. 

(C) 09.2016 by H-PRG
http://hooyprogram.republika.pl/

TR-DOS version by Lord Vader (thanks! :) ).


SoundTrack can be found here: 
https://soundcloud.com/mister_beep/mister-beep-battlefield-insanity-zx48
https://soundcloud.com/yerzmyey/yerzmyey-evelynn
https://soundcloud.com/yerzmyey/yerzmyey-orch-or
http://yerzmyey.i-demo.pl/Yerzmyey-Taiyou.mp3

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

  MYSTERIOUS.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  MYSTERIOUS.DSK, Diskfile for emulators, to start the game, type *RUN"M1RUN"

AtoMMC version:

  M1RUN  = Basic introscreen
  M1PAN  = Panelscreen
  M1SCR  = Titlescreen
  M1CODE = Gamecode

  To start the game, type: *M1RUN

