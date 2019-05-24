**************************************************
                 ROBOPROBE/48
             ZX Spectrum Edition
             -------------------   
            (C)2017 Stephen Nichol
              All Rights Reserved
              (Made with AGD 4.7)

              //////////\\\\\\\\\\
            Arcade Game Designer 4.7 
              (C)2017 J.Cauldwell
              \\\\\\\\\\//////////
         

***************************************************

NOTICE: It is the author's intention
that the ZX Spectrum versions of the game 
ROBOPROBE/48 be freely distributable 
with the stipulation that the author's 
copyright remains in effect. 
Recording, playback, and broadcast of play 
events ARE permitted.
Unauthorised ports of the game to other systems
are NOT permitted. The ZX Spectrum and 
ZX Spectrum Vega versions of this game may NOT 
be sold for profit.
The author can accept no liability for loss or 
damage incurred by use of this video game. 
All characters are completely fictional. Any
resemblance to real robotic drones is purely coincidental.
------------------------------------------------
Author's blog and other games at
www.loadingscreech.wixsite.com/loadingscreech

ZX Spectrum
-----------
Cap'n Rescue (Platformer)
Cap'n Rescue: The Escape (Platformer)
Cap'n Rescue: Reprisal (Platformer)
Christmas Gift Hunt (Collect-'em-up)
When Alex Didn't Do It (Text Adventure)
Air Apparent (Shoot-'em-up)
Tunes 2016 (Beeper Tunes)
Takeout Freakout (Room Escape)


Windows PC
----------
Cap'n Rescue for PC (Platformer)
3711 A.D. (Classic Space Shooter)
------------------------------------------------------

ROBOPROBE/48 STORY:
-----------------------
Emergency! Space Station AZ-101-D1 has been
infilitrated by a traitor. The spy has 
set the station on a collision course with
the Planet Zircliv 48 and destroyed the
engine controls. Station drones have been
reprogrammed to work for the enemy.

If you fail, the station and it's food
supplies will be destroyed. 

INSTRUCTIONS:
-------------
Control your repair droid, blasting past the
drones with your lasers, and collecting the 55 
parts necessary to repair the station engines.

Once you have all the parts, the game will end.

-------------------------------------------------------
CONTROLS:
---------

The keyboard controls are:

Q = UP

O = LEFT

P = RIGHT

M = LASER 

The Sinclair and Kempston Joystick controls are:
LEFT, RIGHT, UP, and FIRE to shoot lasers.


-------------------------------------------------------
TESTING
-------
The ZX Spectrum homebrew title ROBOPROBE/48
has been extensively tested in emulator, mainly 
ZX Spin 0.7q for Windows.

---------------------------------------------------
UPDATES
-------
Changes in v1-1
---------------
Additional BEEPER and AY sound effects added.

Changes in v1-2
---------------
Enemy drone sprites animated.
(Speeding up drones with doubled commands 
e.g.SPRITEUP SPRITEUP etc proved far too fast - changes removed).

Changes in v1-3
---------------
Enemy drones need shooting more than once to defeat.
Repair stations now top up laser ammo.
Random drones spawn ammo power-up when defeated.

Changes in v1-4
---------------
More repair stations added.
Repair stations only top up laser ammo if player
has less than one round of 24 shots.

Known issues (v1-4)
-------------------
Glitches with numbers on damage meter.
HUD has no indication of laser ammo amount.

Changes in v1-6
---------------
Damage numbers replaced with static colour bar.
Slight graphical changes to some locations in game.

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

  ROBOPROBE.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  ROBOPROBE.DSK, Diskfile for emulators, to start the game, type *RUN"RPRUN"

AtoMMC version:

  RPRUN  = Basic introscreen
  RPSCR  = Titlescreen
  RPCODE = Gamecode

  To start the game, type: *RPRUN

