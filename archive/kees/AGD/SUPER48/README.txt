Super 48K Box:
--------------

- Action platformer demake appears on the ZX Spectrum

With the recent opening of the WorldofSpectrum forums after a long downtime, it's no wonder we are now seeing a rush of ZX Spectrum titles to grace our retro gaming screens. From the incredible Stormfinch, to the latest release of the Hobbit 128K, there hasn't been a period this week we haven't had a great homebrew title to play. So without further-ado it's time to announce another ZX Spectrum Demake in the form of 'Super 48K Box' by andrewvanbeck ; an unofficial demake of Super Crate Box by Vlambeer.

Just like the original game but in that speccy style, the goal of the game is to survive as long as possible by using the different weapons obtained from crates to kill enemies that appear at the top of the level. With more crates collected you'll get different weapons ranging from revolvers to missle launchers. Be warned though, with every crate collection comes more enemies and if they touch you it's instant death.

For what it's worth this is a fine remake with quality game play, set with an ever increasing challenge. It's also great to see so many developers now stepping forward and demaking modern games for 8bit systems.

.TAP
https://www.dropbox.com/s/l71phof5bz1ksas/Super%2048k%20Box.tap?dl=0

.TZX
https://www.dropbox.com/s/mq7hszpiemno1m3/Super%2048k%20Box.tzx?dl=0

Forum Discussion

 51 20Reddit0 0Tumblr1StumbleUpon0 0 

at Friday, May 22, 2015 2 Comments 
Labels: Andrew Vanbeck, Arcade, demake, GAMING, HOMEBREW, Platformer, Retro Gaming, Retrogaming, Super 48K Box, Zx Spectrum

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

  SUPER48KBOX.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  SUPER48KBOX.DSK, Diskfile for emulators, to start the game, type *RUN"SBRUN"

AtoMMC version:

  SBRUN  = Basic introscreen
  SBSCR  = Titlescreen
  SBCODE = Gamecode

  To start the game, type: *SBRUN

