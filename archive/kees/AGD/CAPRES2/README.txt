********************************************
        CAP'N RESCUE: THE ESCAPE
     Spectrum 48k and 128k Editions
              ------------
        (C)2015 Stephen Nichol
          All Rights Reserved
           Made with AGD v4.6

NOTICE: It is the author's intention
that the ZX Spectrum and ZX Spectrum Vega 
versions of the game CAP'N RESCUE THE ESCAPE 
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


STORY:
Following on directly from where Cap'n Rescue left
off, you are now back in your human body, and must
escape Mortyna's Lair.

INSTRUCTIONS:
Move around Mortyna's fortress avoiding the 
enemies. Dotted around are laser power-ups which 
may assist in your escape, but the supply is limited 
and if you are touched by an enemy you will lose your
ammunition.

The game ends when you have escaped the fortress and
met up with the waiting members of your crew.

Touching enemies or falling too far can kill
you, as can colliding with static spikes - 
collect the boxes marked +1 to gain extra
lives.


CONTROLS:

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


POSSIBLE FAQ's
Since this game is new, no questions have been
asked yet so, here's some possible Q and A's.


Q: When was CAP'N RESCUE written?

A: Autumn to Winter 2014.


Q: When was CAP'N RESCUE: THE ESCAPE written?

A: Summer 2015.


Q: Who is Stephen Nichol?

A: A kid who got a ZX Spectrum + 48k in 1992,
   which may not have been the best timing
   ever given the collapse of the 8-bit industry,
   that was by then in progress but, he didn't mind 
   too much as his first system was a wood panelled
   console and didn't have a keyboard to program
   with.


Q: What other games has Stephen written?

A: The first Cap'n Rescue game, this sequel,
   a Graphic Text Adventure called When Alex
   Didn't Do It, and a playable PC remake demo 
   of the first Cap'n Rescue game.


Q: Have I seen this game anywhere before?

A: The intention is that this is an original
   game, although the Manic Miner control template 
   in AGD was used and obviously 2D platform games
   have a long, well established history. 


Q: Which version of AGD was used to make CAP'N RESCUE?

A: Version 4.6. It's quite stable and AGD and the 
   extra features of AGD 4.6 were appealing.


Q. I'm stuck, are there any cheats?

A. There are no built in cheats to find, sorry.
   Someone might well find a POKE some day.


Q. Seen as how Jonathan Cauldwell wrote AGD, any
   favourite games by the man himself?

A. Haunted House - it was on one of the 1992 Your
   Sinclair covertapes and the graphics were lush.
   Also Albatrossity - it was the first game I ever
   completed every level of on the ZX Spectrum 
   without pokes or a walkthrough. There is a nod to
   Haunted House early on in Cap'n Rescue: The Escape.
   Hint - something to do with the portraits.

Q. How does the Vega version of The Escape differ to the
   standard 48k and 128k ZX Spectrum version?

A. It has 128k-style AY sounds and extra colours, 
   utilising the 64 colour ULA plus upgrade
   developed by the ZX Spectrum community (The
   original Spectrums had 15 colours (or 16 if
   you count BRIGHT Black)). The map has been adjusted
   to accurately fit around the map of he first
   game, whilst still adding new rooms.


TESTING
-------
The ZX Spectrum homebrew title CAP'N RESCUE: THE ESCAPE 
has been extensively tested in emulator, mainly 
ZX Spin 0.7q for Windows and Spectaculator for Android.


CHANGES IN VERSION 3.3
----------------------

*Sound effect added for power up near end of game

*Map adjusted to wrap around the first game's locations.
(This was intended from the start but earlier versions
 are one-room out of place in some map areas).

Known issues:
The end sequence is one-way and can only be played from
left to right. Trying to reverse your course can cause 
the game to work incorrectly.

CHANGES IN VERSION 3.4
----------------------

*The loading screen has been colourised.

CHANGES IN VERSION 3.5
----------------------

*Version 3.4 unintetionally made the dark red blocks 
 bright and vice versa. This has been corrected.

*128k version with AY sound released.

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

  CAPSRES2.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  CAPSRES2.DSK, Diskfile for emulators, to start the game, type *RUN"CR2RUN"

AtoMMC version:

  CR2RUN  = Basic introscreen
  CR2SCR  = Titlescreen
  CR2CODE = Gamecode

  To start the game, type: *CR2RUN


