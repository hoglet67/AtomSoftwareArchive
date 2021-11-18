TOOFY'S NUTTY NIGHTMARE
=========================
(c) Paul Jenkinson 2020

Toofy is asleep, surrounded by his collection of nuts. Suddenly they all vanish, and evil monsters start throwing them away.
He jumps out of bed, and has to collect them as they fall.
Toofy was in a nightmare.. and to get out of it, he had to collect enough nuts and find his way home.

Controls:
-----------
O - Left
P - Right
SPACE - Jump

You can also use Kempston joystick.
This game has been created with Arcade Games Designer by Jonathan Cauldwell.

NOTES:
======
This game will work on 48k machines/emulators, but will not have sound.
Emulators that support AY emulation in 48k mode should use that setting, or use 128,+2 or +3 modes. Real 128,+2,+3 machines should work fine.

THE HISTORY
===========
Back in 2015, the Vega+ was being crowfunded via Indigogo.. many of you will know the story of that disaster. But at the time, I approached Retro Computers and asked if they would be interested in some of my games to be included on the new device. This was before that whole thing fell apart.. and backers still had hope. They replied with a simple.. “Yes Please”.
I then offered to provide at least one exclusive title for the device and the reply came back, 
“The more the merrier.”
I set about writing a game, which was the third in the Toofy series. I designed it for the small screen and simple controls, and made it a simple collect and avoid affair.
I heard nothing back from Retro Computers… ever..

The game was completed though but left on my hard drive destined to languish away. I recently came across it by accident in April 2020 and though I might as well release it.
It isn’t anything revolutionary.. it is a simple game for a small screen, with a pick up and play feel.

DISTRIBUTION
===========
This game may NOT be included in any CD, DVD or other media without the express written permission of the author.

Primary download sites: 
http://www.thespectrumshow.co.uk
https://spectrumcomputing.co.uk

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

  TOOFY3.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  TOOFY3.DSK, Diskfile for emulators, to start the game, type *RUN"TO3RUN"

AtoMMC version:

  TO3RUN  = Basic introscreen
  TO3SCR  = Titlescreen
  TO3CODE = Gamecode

  To start the game, type: *TO3RUN

