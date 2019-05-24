Aeon is a game for the ZX Spectrum, given away free in issue 5 of the online e-zine ZX Spectrum Gamer.

It's made by Sunteam, in case you wondered. The music is by Sergey Letyagin and was sourced from http://zxtunes.com/author.php?id=638&ln=eng

The games were created in Jonathan Cauldwell's Arcade Game Designer, also using the AGD-musiczer utility by David Saphier.

You can get the magazine free from www.sunteam.co.uk/zxgamer and if you click the link back 
to the homepage, there's also a bunch of other retro related goodness to take a gander at.

The game has a whole bunch of TAP files. If you emulate, then turn off high speed loading for the story sections, otherwise you'll miss everything. The games have a bit of blurb on the loading screens but nothing vital to playing, so you can speed-load those just fine.

You can freely distribute this game to friends but don't sell it.
If you run a Spectrum software cataloguing site (i.e. WOS or similar), then you have permission 
to host it for download, but otherwise please just link back to the magazine page for downloads.

That's all really.

Todle pip.

sunteam_paul

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

  AEON1.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  AEON1.DSK, Diskfile for emulators, to start the game, type *RUN"A1RUN"

AtoMMC version:

  A1RUN  = Basic introscreen
  A1SCR  = Titlescreen
  A1CODE = Gamecode

  To start the game, type: *A1RUN

