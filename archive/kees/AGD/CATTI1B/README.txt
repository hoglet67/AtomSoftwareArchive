CATTIVIK
========

A game for the 128K/+2/+3/+2A ZX Spectrum, authored in April 2013 with Arcade Games Designer and inspired by the character of Cattivik created by Franco "Bonvi" Bonvicini.

Authors
=======

- Gabriele Amore: game design, graphics, screens, sound effects and tunes; AGD programming; testing (emulation).
- Alessandro Grussu: BASIC programming; menu sound effects; data blocks setting and arrangement; Italian and English documentation; testing (emulation, real hardware).


Controls
========
Redefinable keys. Default keys are: Q - up, A - down, O - left, P - right, M - fire, SPACE - jump, N - pause.


Tools used
==========

- Arcade Games Designer 3.0 (Jonathan Cauldwell)
- Spectaculator 8.0 (Jonathan Needle)
- Tapir release 09/06/07 19:50 (Mikie et al.)
- ZX Paintbrush 2.3 (Claus Jahn)
- ZX Editor SE 2.2 (Claus Jahn)
- Beepola 1.06.01 (Chris Cowley)
- DK’Tronics Sound FX
- Smart-RCS/ZX7 data compression algorithm (Einar Saukas)

Fan and diamond graphics by Paul Jenkinson.


Disclaimer
==========

"Cattivik" is a tribute to Franco Bonvicini's creative genius and in no way it is intended as an attempt to exploit the main character. The game is completely free and distributed for personal, non-commercial use only.


The game
========

SHIVERS! FEAR! HORROR!

Cattivik, a clumsy thief who always wears black overalls and has the sewers of a city as his hideout, wants to rob a countess and opera singer of her family treasures: a cup, a cross and a diamond. He must then accomplish several tasks in each of the three levels of the game.

In the first level you must come out of the sewer by defeating the mouse armed with a cannon placed in the fifth screen on the right. In order to do this you must:

1) pick up the bucket in the second screen (beware the mud monsters!);
2) push the red button in the fourth screen, so that mobile platforms will be activated;
3) collect some sewage in the first screen;
4) go back to the fifth screen and throw the sewage from the mobile platform towards the mouse. This operation must be carried out at least twice, until the mouse's life-counter reaches zero.

In the second level you have to collect enough money to buy a suit in the last screen, which costs $150. You must then:
1) activate the mobile platforms by operating the lever inside the "Jack's Tools" shop;
2) take the sleeping orphans' money (in "The Good Nuns" orphanage) by jumping from under them and making the coins spring from down of their beds (beware the nuns!). You must follow an anticlockwise path while inside the orphanage;
3) buy the hammer in Jack's shop;
4) exit from the window on the right and reach the "Gold Years" retirement home;
5) rob the elderly ladies of their money by hitting them with the hammer, keeping an eye on the man going around in a wheelchair and armed with a rifle. For every lady you earn $10;
6) get the suit on the top of the last screen paying attention to the lightning bolts coming out from the electric generator, operated by the little dog, which gives power to the TV.
Note: Every time Cattivik dies, he loses one coin.

In the third level, it is time to steal the three treasures kept in the countess's house and go back to the sewer. It is therefore necessary to:
1) enter the natural history museum, activate the fans in the countess's house by switching the lever in the museum storing area (top-left of the entrance);
2) take some bones, which are the weapons for this level. In order to do this you must first drop the crate on the heads of the skeletons which have been re-animated by the scientist. You can also earn some other bones by knocking out the workmen in the museum, but remember that they will get up after a while. You can freely go in and out of the museum, but must follow a clockwise path;
3) go inside the countess's house and use the fans to push yourself up to the platforms where the showcases containing the three treasures lie (use the Jump key). If you do not possess some bones you will be unable to break the showcases and take the treasures;
4) collect the treasures to activate the toilet in the last screen on the right hosting the crazy discharged marines (it will show a flashing "HOME" caption) and return to the sewer from there.

Tip: in many screens there is a point where enemies disappear, subsequently appearing again at the top of the screen, so pay attention to their position.

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

  CATTIVIK1B.CSW, Tapefile for Atomulator, to start the game, type: *RUN"AGD"

Disk version:

  CATTIVIK1B.DSK, Diskfile for emulators, to start the game, type *RUN"C1BRUN"

AtoMMC version:

  C1BRUN  = Basic introscreen
  C1BSCR  = Titlescreen
  C1BCODE = Gamecode

  To start the game, type: *C1BRUN

