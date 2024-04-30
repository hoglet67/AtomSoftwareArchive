Forward to the Past:
--------------------

Story:

The year is 2021 and thanks to AGD; lots of really helpful folk on the internet and his son Nate, Dave Sloan has fulfilled a decades long dream of making a game on the ZX Spectrum, Manic Mulholland.
After some supportive comments and general good feeling about the game, Dave longs to go back to the 80s, to a time when he was more creative, imaginative and had way more free time, so he can give his younger self the tools to make some fun little Speccy platform games.
Dave being Dave however, gets a little bit obsessive about this notion & sets about building a time machine, once again with the help of Nate & some useful online guides.  The fabric of time is not something to be trifled with however and  Dave being Dave, the time machine goes a little wonky.
Owing to a misunderstanding relating to the metric system or something, on the first test run Dave & Nate get sucked into the time vortex.
For reasons unknown the only thing that will save the father & son team is collecting 42 MacGuffinanium crystals.

This is where you come in, can you save our intrepid duo and prevent an irreparable tear in the space-time continuum? There's only one way to find out!!!

Controls:

 Q  - Up
 A  - Down
 O  - Left
 P  - Right
SPC - DOWN

Credits:

Design/Graphics/Music/Loading Screen by Dave Sloan & Nate Sloan
Developed using Jonathan Cauldwell’s MPAGD
Cover Illustration by Ric Lumb
Addition Art by Jamie Battison & Darren Doyle
Playtesting: Peter Mulholland
Huge thanks everyone on the MPAGD fourms who have helped by answering our stupid questions, too many to mentionGame controls

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

  FORWARD.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  FORWARD.DSK, Diskfile for emulators, to start the game, type *RUN"FWRUN"

AtoMMC version:

  FWRUN  = Basic introscreen
  FWSCR  = Titlescreen
  FWCODE = Gamecode

  To start the game, type: *FWRUN

