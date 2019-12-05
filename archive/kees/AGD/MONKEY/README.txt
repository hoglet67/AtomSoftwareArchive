MONKEY J: The treasure of the gold temple:
------------------------------------------

Monkey J was lost in the forest until he (or she?) found it, A Fantastic New AGD Game by Gabriele Amore!
by Kitty · Published July 8, 2017 · Updated July 8, 2017

 Tweet Reddit Email
Hot off the press! Gabriele Amore (Donkey Kong Jr, Crazy Kong City, Castle Capers) has just given us the heads up about a brand new game which he released today.

“MONKEY J: The treasure of the gold temple that was lost in the forest until he (or she?) found it”, (takes a breath, phew!) is a gorgeous new platformer starring “Monkey J”, a cute little Monkey with a red jumpsuit on! Your mission is to find the “Lost Gold Temple” with least amount of lives lost, however this is no easy task and there are many enemies and obstacles to test your skills as you progress throughout the game. Green Monkey eating Snakes (yes they actually eat you!), Evil Cyborg Monkeys and floating Voodoo Heads are just a few of the many nasties that will try their hardest to kill you. While on your travels, keep an eye out for a torch.. this will help you find the entrance to the secret temple. Poor Monkey J has a lot on his plate, but with patience and persistence, he will be triumphant!

As you can see from the video below, the game looks beautiful (as do many of Gabriele’s games). Gameplay is fluent, controls are the usual qaopm, Kempston and Sinclair, and there’s also a lovely catchy tune, which fits really well within the game. Thanks to David Saphier, everyone making AGD games can now easily add music to their masterpiece. I had a quick chat with David regarding the music engine he coded called ‘AGD-musiczer’, here’s a little snippet of info.

I wrote the builder that lets people easily add music to AGD games. So I wrote some assembly that stitches the vortex tracker player with music, compresses it, sticks in a spare ram bank, then an interrupt routine to play the music. It then stitches it all together into a final tap ready for release.

So overall this is a fantastic game and well worth adding to your ZX Spectrum Homebrew collection. Download it now! ??


Music in this video is from “Crazy Kong City”, final music is in the download below.

Download: MONKEY_J_The_treasure_of_the_gold temple.tap
Read more in-depth details about the game on Gabriele’s Facebook Group: GabAm’s Zx Spectrum Games

Controls:

Q - Up
A - Down
O - Left
P - Right
M - Jump

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

  MONKEY.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  MONKEY.DSK, Diskfile for emulators, to start the game, type *RUN"MJRUN"

AtoMMC version:

  MJRUN  = Basic introscreen
  MJCODE = Gamecode

  To start the game, type: *MJRUN

 
