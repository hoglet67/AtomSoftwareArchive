QBox:
-----

Year 2525, you do not remember how or what way, but you have appeared in the universe Qbox Everything you remember about your world It is full of curves; it's more, your essence It is spherical, and fragile. But here everything is cubic.
Somehow you must reach the Transport pyramid, picking up the WHAT, and avoiding enemies and traps who watch and guard this universe.

Objects:
qBITos - You must collect them all in order
Pyramid - Allows you to escape from the universe Qbox once you have collected all the qBITos
Medical kit - Allows you to recover part of your strength
Traps - Sometimes they open and they close, be careful not to fall when they are open
Cracks - If you fall from high places

You can cause cracks in the tiles. If you fall in a crack you can cause a hole.
Sliding platforms - When you place yourself on them they drag you in the sense that indicate
Bombs - Start a countdown until that explode, leaving on the tile a hole.
Enemies - They have different routes, but all they patrol the universe. Some take you away energy, and others can also stun you, making your movements slow. 

Controls
Use the standard Kempston or Sinclair joystick to move.

You can also use the keyboard:
L - Left down
Q - Left up
P - Right up
S - Right down

Developing
Idea, code and graphics
Sergio Llata ??(aka thEpOpE)
Loading screen and graphic retouching:
Igor Errazkin (aka Errazking)
Music 128kb:
menu - Branislav Bekes (aka z00m)
game - Sergei Nemo (aka SERGEant)
with the express permission of their authors
Music 48kb: SERGEant (adaptation of thEpOpE)
AGD engine: Jonathan Cauldwell

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

  QBOX.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  QBOX.DSK, Diskfile for emulators, to start the game, type *RUN"QBRUN"

AtoMMC version:

  QBRUN  = Basic introscreen
  QBSCR  = Titlescreen
  QBCODE = Gamecode

  To start the game, type: *QBRUN

