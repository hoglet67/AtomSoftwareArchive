********************************************
              CAP'N RESCUE
                 v 3.0
              ------------
         (c)2014 Stephen Nichol
           Made with AGD v4.6

NOTICE: It is the author's intention
that the ZX Spectrum and ZX Spectrum Vega
versions of the game CAP'N RESCUE be freely
distributable with the stipulation that
the author's copyright remains
in effect. 
Recording, playback,and broadcast of play 
events ARE permitted.
Unauthorised ports of the game to other
systems are NOT permitted.
The ZX Spectrum and ZX Spectrum Vega versions
of this game may NOT be sold for profit.
The author can accept no liability for
loss or damage incurred by use of this
video game.
All characters are completely fictional. 
Any similarities to persons, animals, or
surreal patrolling objects living or dead are 
purely coincidental.


STORY:
You are Captain Robert Goode, well respected 
and recognised around the globe for your
many achievements. Seperated from your
crew, and captured by an evil witch from the
future named Mortyna, your soul has been placed 
in the body of your pet monkey.

No longer perceived as a threat in your
simian form you have been left to wander
in Mortyna's fortress, but memories of 
your human life drive you to find your 
body, and the potion that will return you
to it.

INSTRUCTIONS:
Move around Mortyna's fortress avoiding the 
enemies and collecting as much of the treasure
as you can to improve your final ranking.

The game ends when you find the room
containing Captain Goode's human body and
collect the potion.

Collecting the eleven bonus items will give you 
a higher rank.

Touching enemies or falling too far can kill
you, as can colliding with static spikes - 
collect the boxes marked +1 to gain extra
lives.


CONTROLS:

Joystick
Kempston or Sinclair Joystick can be selected
from the menu.


KEYS
Q or N = Jump
O = Left
P = Right


Possible FAQ's
Since this game is new, no questions have been
asked yet so, here's some possible Q and A's.


Q: When was CAP'N RESCUE written?

A: Autumn to Winter 2014.


Q: Who is Stephen Nichol?

A: A kid who got a ZX Spectrum + 48k in 1992,
   which may not have been the best timing
   ever given the collapse of the 8-bit industry,
   that was by then in progress but, he didn't mind 
   too much as his first system was a wood panelled
   console and didn't have a keyboard to program
   with.


Q: What other games has Stephen written?

A: The sequel to Cap'n Rescue, CR2: The Escape,
   a text adventure with graphics entitled
   When Alex Didn't Do It, and a demo of a
   Cap'n Rescue PC remake.


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


Q. Seen as how Jonathan Cauldwell wrote AGD, any
   favourite games by the man himself?

A. Haunted House - it was on one of the 1992 Your
   Sinclair covertapes and the graphics were lush.
   Also Albatrossity - it was the first game I ever
   completed every level of on the ZX Spectrum 
   without pokes or a walkthrough.


TESTING
The ZX Spectrum homebrew title CAP'N RESCUE has been
extensively tested in emulator, mainly ZX Spin 0.7q
 for Windows and Spectaculator for Android.

The game has also been tested on a ZX Spectrum +2B
 physical computer.

CHANGES IN VERSION 2.1
----------------------
*Version 2.1 removes all known technical problems with 
 Cap'n Rescue.

CHANGES IN VERSION 3.0
----------------------
*New design loading screen added.

*In-game graphics changed to match sequel CR2: The Escape
 graphical style.

*Top floor section of waterfall moved slightly, so
 as to be in-line with waterfall on other floors.

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

  CAPSRES1.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  CAPSRES1.DSK, Diskfile for emulators, to start the game, type *RUN"CR1RUN"

AtoMMC version:

  CR1RUN  = Basic introscreen
  CR1SCR  = Titlescreen
  CR1CODE = Gamecode

  To start the game, type: *CR1RUN
