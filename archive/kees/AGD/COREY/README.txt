Corey Coolbrew:
---------------

Corey Coolbrew has been trapped in a robot laboratory. 
Help him escape by completing all of the levels.  Collect the microchips to gain extra lives, pick up the key to open the door to exit to the next level.
Use the boosters to help Corey jump higher. Watch out for the electrified floors!
Some of the robots wander back and forth or up and down. Others have some intelligence and will chase Corey down.
30 levels of platforming fun!
Spectrums with AY sound chips can experience an awesome tune while they play. The tune was created by Mike Richmond.

Keys: QAOP for up/down/left/right and M to jump! Joysticks are also supported.

Game created with the "Multi-Platform Arcade Game Designer" with help from Kees. Playtesting by Vinny Mainolfi of Freeze64.
Programming and Design by Jason Oakley of Blue Bilby.  Music and loading screen created with Musicizer by David Saphier.

(C) 2020 Jason Oakley.

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

 Q - Up
 A - Down
 O - Left
 P - Right
 M - Jump

===================================================================
Tape/Disk and AtoMMC version:
===================================================================

Tape version:

  COREY.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  COREY.DSK, Diskfile for emulators, to start the game, type *RUN"CCRUN"

AtoMMC version:

  CCRUN  = Basic introscreen
  CCSCR  = Titlescreen
  CCCODE = Gamecode

  To start the game, type: *CCRUN

