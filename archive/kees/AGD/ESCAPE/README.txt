                                        *****SPACE ESCAPE***** 

                                   by amcgames for the ZX Spectrum
                                        version 1.2, oct 2017


**THE STORY**

While on a routine scouting mission in an empty sector of space, you are suddenly ambushed by a squadron of ships. 
A bright flash of light seems like it might be the end, but incredibly you wake up to discover yourself in an alien
base. While robots are distracted sorting through items from your ship, you realize they have carelessly left 
an EMP grenade within your reach. Quickly using it to dispatch with your captors, you put on your space suit and
look around for your launch key and laser, but they are nowhere to be found. You soon have bigger problems,
however -- a loud banging on the door of the examination room. Seeing no other option, you jump into a teleporter 
as you hear the door break down. If the teleporter doesn't kill you, you'll have to find your launch key, laser, and 
fuel up your ship... and hope there isn't anything else to keep you from escaping and warning Space Fleet about this 
new hostile species.


**CONTROLS**

Q - up/jump
A - down
I - left
O - right
SPACE - fire

The game also supports Kempston and Sinclair joysticks.


**CHANGELOG**

From version 1.1:

-Fixed correct starting sprite after acquiring the laser
-Fixed laser direction after dying
-Created easy version with fewer baddies in later levels
-Fixed a bug which allowed the player to become stuck in solid areas accessible from neighbouring screens to the left or right
-Made the exit object clearer on the second-to-last screen

Known issues:

-Randonly getting stuck in solid areas after falling multiple screens


**SPECIAL THANKS**

Jonathan Cauldwell for AGD (http://arcadegamedesigner.proboards.com/)
Paul Jenkinson for AGD tutorials (http://www.thespectrumshow.co.uk/AGD.aspx)
AGDMusicizer for AY music and load screen code
Music: "Time and Space" by DJ Serg (http://zxart.ee/eng/music/)
Playtesters from the AGD Facebook group
All of the Spectrum homebrew coders and enthusiasts for inspiring me to learn how to make games!


**NOTES**

Though the rights remain with the author, this game is free to distribute and share. It may not be sold, alone or as 
part of a package, without the author's permission.

The game and this file are available at: https://www.dropbox.com/sh/9udhoim0r2zkz15/AAACMp3kUhTBVnrhG2BX5Jkza

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

  ESCAPE.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  ESCAPE.DSK, Diskfile for emulators, to start the game, type *RUN"ESRUN"

AtoMMC version:

  ESRUN  = Basic introscreen
  ESSCR  = Titlescreen
  ESCODE = Gamecode

  To start the game, type: *ESRUN

