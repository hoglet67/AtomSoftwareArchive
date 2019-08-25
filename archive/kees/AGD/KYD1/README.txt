KYD CADET
=========
By Paul Jenkinson

This game will only work on 48k machines.
For 128 machines, use 48k mode.

Kyd, the intrepid young Space Cadet, was on his way to his very first
mission when he suddenly realised that he hadn?t refuelled before
leaving the space port.
 
Glancing at his short range scanners, he picked out a small moon and
set his coordinates.
 
According to the databanks, the moon was a peaceful ore mining
satellite that strangely didn?t show any life forms.
 
His scanner picked up enough fuel held in their stores to enable him to
get back to the space port and so he set about landing.
 
Once down, he suddenly realised that the mining operation had ceased
long ago, but no one had decommissioned the droids.
 
Our hero must now search the dangerous complex for the required amount
of fuel without upsetting the crazed droids; his life depended on it.

Controls:
========
A = Left
S = Right
SPACE = Jump

Written using the Arcade Game Designer by Jonathan Cauldwell.

Version
-------
1.0 - Original release.
1.1 - Fix for Spelling correction and No going back to start when killed.
1.2 - Fix loading screen and sound bug when killed.

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

  KYD1.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  KYD1.DSK, Diskfile for emulators, to start the game, type *RUN"K1RUN"

AtoMMC version:

  K1RUN  = Basic introscreen
  K1SCR  = Titlescreen
  K1CODE = Gamecode

  To start the game, type: *K1RUN

