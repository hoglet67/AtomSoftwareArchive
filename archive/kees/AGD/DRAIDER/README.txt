DUNGEON RAIDERS

:
----------------

A game for ZX Spectrum 48K by Andy McDermott

Written in Arcade Game Designer


For generations, the necromancer Skulvort has sent his minions from the depths of his dungeon fortress to loot the surrounding lands. But now, four brave adventurers seek to destroy the evil lord once and for all, and claim his treasures for themselves!

Three of the adventurers set out into the dungeon's 20 levels to battle its perils face to face. The fourth is the powerful wizard Zpectru, who uses his powers to watch over his comrades from afar, guiding them to the riches - and protecting them from the necromancer's many deadly minions and traps.

You control Zpectru's Eye of Force. By guiding it to a spot and pressing Fire, the adventurers will make their way to that point as best they can. If the Eye is passed over an enemy, the wizard's magic will destroy them. Be warned, though; many enemies will soon be revived by Skulvort's malign power, and some cannot be harmed at all - only briefly stopped.

The controls are Q/A (Up and Down), O/P (Left and Right) and Space (Fire). 
Can you find all 60 pieces of treasure and defeat the necromancer?

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

  DRAIDER.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  DRAIDER.DSK, Diskfile for emulators, to start the game, type *RUN"DRRUN"

AtoMMC version:

  DRRUN  = Basic introscreen
  DRCODE = Gamecode

  To start the game, type: *DRRUN

