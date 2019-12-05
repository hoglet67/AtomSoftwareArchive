Space Disposal:
===============

(c) Paul Jenkinson 2011

A game for the ZX Spectrum.

This game will work on all models of the ZX Spectrum, although to hear sound you will need an AY chip (128, +2, +3). If you are playing via an emulator, switch on 48k AY support.
This game was created with Arcade Games Designer by Jonathan Cauldwell.

The Game
========
The amount of space junk floating around has become a major concern, especially the huge amounts that manage to get through planetary atmospheres without burning up. This debris is largely ignored by the planets responsible and so out of this mess grew a new lucrative industry.

Space Disposal Corporation was set up to clear away unwanted and potentially dangerous space waste for those planets rich enough to pay for its services.

Travelling around systems can be a huge drain on resources, but this is where SDC?s technicians came to the rescue. By collecting and harvesting the junk, enough power can be generated not only to drive the collection ships, but also to pay the fees for inter-planetary portal transport.

As a new pilot, you are given four planets to clear. Your ship can withstand collisions with the planet surface and foliage, but cannot take hits from moving hazards like meteors or rouge cleaner droids. You have quad-laser canons that can be used to destroy any moving hazards.

Some planets opted for a cheaper alternative cleaning operation prior to calling SDC. This usually involved a pack of cleaner droid manufacturing pods being dropped onto the planet. Unfortunately, contaminated waste interfered with their circuits and the droids are left to roam about without actually removing any debris. Many droids are unpredictable, changing directions randomly, so be careful.

These droids are self-repairing and any hit will destroy the current unit, however, the pods will generate a new replacement straight away. It is useful to locate these pods, as destroying droids can be useful, despite them being re-generated. The pods cannot be destroyed.

By collecting all junk from one planet, enough power will be created to allow the blue portal to be activated, allowing you to travel to the next designated planet.

Once all four planets have been clear you will be allowed to enter the final portal for transport back to SDC. 

Any SDC pilot will learn that his laser canons are not weapons but mechanisms to manipulate the environment. By destroying a droid it will be regenerated in its pod, by blasting a meteor it will clear the way long enough to move, but more meteors are always on the way. Keep this in mind.

Controls:
=============
Q-Up
A-Down
O-Left
P-Right
SPACE-Fire

You can also use a Sinclair joystick or a Cursor joystick.


More games at: http://randomkak.blogspot.com/

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

  SPACEDISPOSAL.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  SPACEDISPOSAL.DSK, Diskfile for emulators, to start the game, type *RUN"SDRUN"

AtoMMC version:

  SDRUN  = Basic introscreen
  SDSCR  = Titlescreen
  SDCODE = Gamecode

  To start the game, type: *SDRUN

