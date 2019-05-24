Ooze:
-----

Regular visitors will have seen Andy Johns' latest Spectrum homebrew previewed here over the last few weeks; well, the Ooze is out of the jar now and all over my Spectrum - but that's another story. What's important here is that the game has just been released, and it turns out to be quite an entertaining way to pass an hour on a chilly Sunday afternoon.

Ooze is a sort of flip-screen maze-em-up in the style of many a Sinclair classic from days gone by, in which you play Ooze, some kind of intelligent blob of goo, who must escape from an underground lair patrolled by the usual motley crew of predictable but annoyingly efficient killer robots. Ooze, however, has a weirdly sticky twist: being a blob of goo, rather than the traditional method of jumping over baddies, you just stick yourself to the ceiling until they've passed. Indeed, you can walk - well, ooze, I suppose - around on the ceilings too, which makes for an interesting and unusual game dynamic.

It took a few rounds to get used to controlling the Ooze in flight; your platforming doesn't have to be pixel perfect, but in places timing is everything. Even so, I was soon zipping through the first few screens with relative ease; there is a network of key operated force fields which I have yet to start opening and exploring beyond, and I suspect a very large game map may be awaiting discovery later on.

First impressions are that this is a nice looking game, right from the colourful text on the main menu screen; but this is merely a taster, as Andy Johns really has mastered the art of the Spectrum and beaten its colour issues into submission. The killer robots are fun, ranging from the sputnik-on-speed to the steampunk Zebedee, but your progress is further hampered by unpleasant green gas escaping from broken pipes, and some rather neat looking electrical faults (albeit ones that sound more... organic, shall we say).

It's not just a pretty face either; Ooze is a 128k game which, as well as hinting at potential vastness, allows for not one, but two AY tunes to accompany you on your journeys. With its top-notch graphics and tunes, and original twist on a classic 8-bit game format, Ooze could easily have been a commercial release 25 years ago. But it's not the 90s any more, which means you can get the game for free - hurrah!

Controls:

  O   - Left
  P   - Right
SPACE - Flip

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

  OOZE.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  OOZE.DSK, Diskfile for emulators, to start the game, type *RUN"OOZRUN"

AtoMMC version:

  OOZRUN  = Basic introscreen
  OOZSCR  = Titlescreen
  OOZCODE = Gamecode

  To start the game, type: *OOZRUN

