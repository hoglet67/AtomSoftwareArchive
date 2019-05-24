********************************************
        CAP'N RESCUE: REPRISAL
         ZX Spectrum Edition
            --------------
        (C)2016 Stephen Nichol
          All Rights Reserved
          Made with AGD v4.6

NOTICE: It is the author's intention
that the ZX Spectrum and ZX Spectrum Vega 
versions of the game CAP'N RESCUE REPRISAL 
be freely distributable with the stipulation 
that the author's copyright remains in effect. 
Recording, playback, and broadcast of play 
events ARE permitted.
Unauthorised ports of the game to other systems
are NOT permitted. The ZX Spectrum and 
ZX Spectrum Vega versions of this game may NOT 
be sold for profit.
The author can accept no 
liability for loss or damage incurred by use 
of this video game. 
All characters are completely fictional. Any 
similarities to persons, animals or surreal 
patrolling objects living or dead are purely 
coincidental.

------------------------------------------------------
Author's blog and other games at
www.loadingscreech.wixsite.com/loadingscreech

ZX Spectrum
-----------
Cap'n Rescue (Platformer)
Cap'n Rescue: The Escape (Platformer)
Christmas Gift Hunt (Collect-'em-up)
When Alex Didn't Do It (Text Adventure)

Windows PC
----------
Cap'n Rescue for PC (Platformer)
------------------------------------------------------

STORY:
Since discovering the lair of an evil witch
from the future, classical period Captain 
Robert Goode has survived his soul being 
placed in the body of the ship's monkey,
and fought his way out from deep underground
to rejoin his crew. 

Now he's out to undo Mortyna's damage to the
timeline by finding her magical Time Device,
hidden on an island and guarded by an array
of strange creatures and technology.

INSTRUCTIONS:
-------------
Move around the island lair avoiding the 
enemies. Dotted around are laser power-ups which 
may assist in your escape, but the supply is limited 
to 8 laser shots per crate and if you are touched by 
an enemy you will lose your ammunition. 

Other power-ups provide temporary invincibility. 
You can use lasers to break through forcefields.

Touching enemies or falling too far can kill you, 
as can colliding with static spikes or forcefields.
Collect the boxes marked +1 to gain extra lives.

Laser Ammo Bar - you start each turn with 8 laser
shots. Each shot removes an ammo symbol. If you gain 
more than 8 the bar changes colour and again if
you have more than 16 shots. If there are 8 or less
shots, the used laser shots change to 'X' symbols.


-------------------------------------------------------
CONTROLS:
---------

On the start menu, choose:

1. For Keyboard control

2. For Sinclair Joystick

3. For Kempston (Atari type) Joystick

The keyboard controls are:

Q = Jump

O = Left

P = Right

M = Fire

N = Jump (Same as Q)



-------------------------------------------------------
TESTING
-------
The ZX Spectrum homebrew title CAP'N RESCUE: REPRISAL 
has been extensively tested in emulator, mainly 
ZX Spin 0.7q for Windows.

Version 1-0b replaces the test version released on
WoS on 11th July 2016.

Changes in Version 1-0b (14th July 2016)
----------------------------------------
(Thanks to forum member for error feedback)

1.Jump table returned to AGD default.
2.Laser no longer fires backwards on respawn.
3.Overlapping objects no longer overlap. No
  player death from obscured enemy.
4.Forcefield no longer leaves a non-bright
  area behind.

Changes in Version 1-1b (17th July 2016)
----------------------------------------
1.Player sprite now bobs up and down while walking.
2.Added a rucksack to player in order to fill
  grid better and improve collision detection.

Forum Suggestions - Issues
--------------------------
1.Spawn at original room entry point (AGD seems
  to override attempts to do this).
2.Edges of hat bob up and down - removed changes
  as I believe hat looks like it's trying to fly
  away on it's own.

Changes in Version 1-2b (22nd July 2016)
----------------------------------------
1.Added a ship graphic to first screen.
2.Put hat 'bobbing' back in.
3.Added ammo graphic from 0 to 8 laser shots.

Changes in Version 1-3b (24nd July 2016)
----------------------------------------
1.Laser ammo bar now changes colour if
  over 8 or over 16 laser shots.
2.Minor colour tweaks - changed to 
  bright yellow platforms where left right 
  ground enemies pass.
3.Laser is now unavailable when the player
  is invincible (removes 'frozen/sticky laser' 
  glitch).
4.Made 48k version with BEEPer sounds.

Further changes in Version 1-3b(24th Aug 2016)
----------------------------------------------
1.ULA Plus pallette added.
2.Vega Keymap added.

Known issues in Version 1-3b
----------------------------
1.The glitch is back -in some rooms the laser 'sticks',     
  possibly because of too many sprites on the same line.
2.Due to low editor RAM, it has not been possible
  to implement a changing laser ammo bar except for
  when ammo is below one round.
3.Colour/attribute clash - short of reinventing the ZX     
  Spectrum there's not much I can do about it.

Changes in Version 1-4 (25th Aug 2016)
----------------------------------------
1.Number of sprite enemies and sprite forcefields in 
  some rooms reduced to prevent 'sticky' laser.
2.Design of room containing final object changed.
3.48k version remade from 128k V1-4, thus removing
  same bugs. BEEP for all sound.
4.ULA Plus/Vega version exported with extra colours
  and AY sound.

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

  CAPSRES3.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  CAPSRES3.DSK, Diskfile for emulators, to start the game, type *RUN"CR3RUN"

AtoMMC version:

  CR3RUN  = Basic introscreen
  CR3SCR  = Titlescreen
  CR3CODE = Gamecode

  To start the game, type: *CR3RUN
