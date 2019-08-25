BINARY by Mulder
================

SCENARIO
========

You play a space station employee who is the last to leave during an evacuation
from the space station.  You get your gear, go to the landing deck and realise
you've lost the launch code for your mini-shuttle.  You need to hunt down and
collect the 5 parts of the binary code.  Watch out for the space stations cargo
droids which have malfunctioned and caused the evacuation, they can kill you if
touched.  Normally, they just collect incoming supplies to the station and put
it into storage, but they have started to flail around wildly and unpredictably
causing a lot of danger to the crew.  They occasionally drop some supply crates
if shot, which can be collected for extra points.  Some of the security systems
employed in the space station can also be hazardous, such as the spikes which
you must jump over and the acid baths which have been known to leak and cause a
lot of damage.  These security systems would normally only be employed if an
intruder was found to be wandering the space station, but they have been put
into action to protect the station from space pirates whilst the crew are
evacuated.  Once all the parts are found, return to your shuttle to win the
game.


CONTROLS
========

To control the main character in the game, use the keys OPQA and M.  O and P are
left and right, Q and A are up and down.  M is fire.

Thanks to Jonathan Cauldwell for making AGD and thus making this game possible!  Also thanks to Mister Beep for the beeper tune and Pavero, Binman and Tom-Cat for helping out with some pokes that made the game slightly better.

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

  BINARY.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  BINARY.DSK, Diskfile for emulators, to start the game, type *RUN"BINRUN"

AtoMMC version:

  BINRUN  = Basic introscreen
  BINSCR  = Titlescreen
  BINCODE = Gamecode

  To start the game, type: *BINRUN

