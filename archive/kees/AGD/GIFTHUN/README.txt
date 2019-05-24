********************************************
           CHRISTMAS GIFT HUNT
           ZX Spectrum Version
              ------------
        (C)2015 Stephen Nichol
          All Rights Reserved
           Made with AGD v4.6

NOTICE: It is the author's intention
that the ZX Spectrum and ZX Spectrum Vega/ULA
Plus versions of the game CHRISTMAS GIFT HUNT 
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
similarities to persons, animals, or surreal 
patrolling snowmen living or dead are purely 
coincidental.


STORY:
It's Christmas Eve, and Santa Claus is on his
rounds. Unfortunately, he ran into some high
winds and all his presents were spread around
Felliblanch Island. Now he has to find them
all and save Christmas.

INSTRUCTIONS:
Explore Felliblanch Island, and search for the
80 Christmas Presents. Avoid the evil snowmen,
and look out for Jack Frost - he's the smartest
enemy of them all.

The game ends when you have found all of the
scattered presents.

LOADING:
Follow these steps
1.Insert and rewind tape or virtual tape
2.Reset the ZX Spectrum then
3.48k - type Load "" (press J and symbol shift/ctrl and P)
4.128k/+2/+3 - select "Tape Loader"
5.Press play on the real or emulated tape drive.

Please note - on a real tape deck, it may be necessary
to adjust the volume manually to find the correct setting.


CONTROLS:

On the start menu, choose:

1. For Keyboard control

2. For Sinclair Joystick

3. For Kempston (Atari type) Joystick

The keyboard controls are:

Q = Up

A = Down 

O = Left

P = Right


OTHER GAMES BY STEPHEN NICHOL
 
Cap'n Rescue (2014/ZX Spectrum/Platform)
Cap'n Rescue: The Escape (2015/ZX Spectrum/Platform)
When Alex Didn't Do It (2014/ZX Spectrum/Graphical Text Adventure)
Christmas Gift Hunt (2015/ZX Spectrum/Collect-'Em-Up)

CURRENTLY UNDER DEVELOPMENT
Cap'n Rescue (2014/Windows PC/Platform)

Follow my blog at www.stephennichol81.wix.com/loading screech


POSSIBLE FAQ's
Since this game is new, no questions have been
asked yet so, here's some possible Q and A's.


Q: When was CHRISTMAS GIFT HUNT written?

A: Autumn to Winter 2015.


Q: Who is Stephen Nichol?

A: A kid who got a ZX Spectrum + 48k in 1992,
   which may not have been the best timing
   ever given the collapse of the 8-bit industry,
   that was by then in progress but, he didn't mind 
   too much as his first system was a wood panelled
   console and didn't have a keyboard to program
   with.


Q: Have I seen this game anywhere before?

A: From the start this has fully been intended to
   be a new title, despite the vintage of the 8-bit
   computers it is intended to run on.


Q: Which version of AGD was used to make CHRISTMAS
   GIFT HUNT?

A: Version 4.6. It's quite stable and AGD and the 
   extra features of AGD 4.6 were appealing.

Q. What is different about the ULA Plus version
   when compared to the standard ZX version?

A. The ULA Plus version uses a clever technique
   developed by the ZX Spectrum community to
   give more colours than were on the original
   Spectrum hardware - up to 64 colours in total.


Q. I'm stuck, are there any cheats?

A. There are no built in cheats to find, sorry.
   Someone might well find a POKE some day.


Q. Seen as how Jonathan Cauldwell wrote AGD, any
   favourite games by the man himself?

A. Haunted House - it was on one of the 1992 Your
   Sinclair covertapes and the graphics were lush.
   Also Albatrossity - it was the first game I ever
   completed every level of on the ZX Spectrum 
   without pokes or a walkthrough.

TESTING
-------
The ZX Spectrum homebrew title CHRISTMAS GIFT HUNT 
has been extensively tested in emulator, mainly 
ZX Spin 0.7q for Windows. Additional testing has
been carried out on a real ZX Spectrum Vega.


CHANGES IN VERSION 1.0
----------------------
This version makes the following improvements over
the beta version.

*Santa (Player) sprite designs changed.

*Jack Frost now has AI and can track the player.

*Some buildings can be entered.

*AY Sound Effects added to 128k version.

*ULA Plus version created.

*ZX Spectrum Vega keymap made to accompany ULA Plus
 version.

CHANGES IN VERSION 1.1
----------------------

*Inaccessible gift near smoking chimney made
 accessible by moving house down one character cell.

*Extra life added to game area as a result of glitch
 in bottom left of map area preventing definite
 collection of one existing extra life.


Known issues:
One building with a yellow door, cannot be entered
unless the player loses a life and respawns outside
the aforementioned building.

CHANGES IN VERSION 2.0
----------------------

*Clockwork soldier enemies added.

*Pallette changes (ULA Plus and Vega only).


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

  GHUNT.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  GHUNT.DSK, Diskfile for emulators, to start the game, type *RUN"GHRUN"

AtoMMC version:

  GHRUN  = Basic introscreen
  GHSCR  = Titlescreen
  GHCODE = Gamecode

  To start the game, type: *GHRUN
