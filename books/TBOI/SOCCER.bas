
0 REM THE BEST OF INTERFACE PAGE 6-7-8
10 REM SOCCER BY I. SMITH
20 GOSUB 730;PRINT $12
30 DIM AA(2);Z=#8020;T=(6*32)+4;U=(6*32)+27;@=5
40 E=ABSRND%11;IF E>5 THEN G=33
50 IF E<6 THEN G=-31
60 H=34+(32*E);FOR A=0 TO 1;AA(A)=0;NEXT A;PRINT $21;P=#21C;[
70 JSR#FE71;BCS P+9;JSR P+11;STA#32C;RTS;LDA@#FF;BNE P-6;PHP
80 JMP#FEA7;];PRINT $6;K=0;?#E1=0;CLEAR 0;PRINT $30
90 PRINT AA1,"       SOCCER     "AA0
100 FOR A=1 TO 30;A?Z=204;NEXT A
110 FOR A=((14*32)+1) TO ((14*32)+29);A?Z=204;NEXT A
120 FOR A=1 TO 2;B=(A*32)+1;B?Z=213;NEXT A
130 FOR A=12 TO 13;B=(A*32)+1;B?Z=213;NEXT A
140 FOR A=2 TO 12;B=A*32;B?Z=60;NEXT A
150 FOR A=1 TO 2;B=(A*32)+30;B?Z=234;NEXT A
160 FOR A=12 TO 13;B=(A*32)+30;B?Z=234;NEXT A
170 FOR A=2 TO 12;B=(A*32)+31;B?Z=62;NEXT A
180 A=1;A?Z=197;A=30;A?Z=202;A=449;A?Z=212;A=478;A?Z=232
190 FOR P=0 TO 100;WAIT;NEXT P
200 FOR A=6 TO 7;B=(A*32)+4;B?Z=106;NEXT A
210 FOR A=6 TO 7;B=(A*32)+27;B?Z=106;NEXT A;H?Z=42
220 IF ?#B001=127;T=T+32;Q=1;IF T>388;T=388
230 IF ?#B001=239;T=T-32;Q=2;IF T<36;T=36
240 IF Q=1;Q=0;C=T-32;C?Z=32;C=T+32;C?Z=106
250 IF Q=2;Q=0;T?Z=106;C=T+64;C?Z=32
260 LINK#21C
270 IF K=#50;U=U-32;R=2;IF U<59;U=59
280 IF K=#2E;U=U+32;R=1;IF U>411;U=411
290 IF K=#FF GOTO 320
300 IF R=1;R=0;C=U-32;C?Z=32;C=U+32;C?Z=106
310 IF R=2;R=0;U?Z=106;C=U+64;C?Z=32
320 H?Z=32;H=H+G
330 IF H?Z=60;AA0=AA0+1;PRINT $7$7$7;GOTO a
340 IF H?Z=62;AA1=AA1+1;PRINT $7$7$7;GOTO b
350 IF H?Z=204;GOSUB c
360 IF H?Z=106 OR H?Z=213 OR H?Z=234;GOSUB d
370 IF H?Z=197 OR H?Z=202 OR H?Z=212 OR H?Z=232;G=-G;H=H+G
380 H?Z=42;GOTO 220
390a E=ABSRND%11;IF E>5;G=31
400 IF E<6;G=-33
410 H=61+(32*E);GOTO 450
420b E=ABSRND%11;IF E>5;G=33
430 IF E<6;G=-31
440 H=34+(32*E)
450 FOR A=0 TO 32 STEP 32;B=A+T;B?Z=32;B=A+U;B?Z=32;NEXT A
460 T=(6*32)+4;U=219;FOR P=0 TO 50;WAIT;NEXT P
470 PRINT $30,AA1,"       SOCCER     "AA0
480 IF AA0=15 OR AA1=15;?#E1=#80;GOTO 860
490 GOTO 200
500c IF G=33;G=-31;H=H+G;RETURN
510 IF G=-31;G=33;H=H+G;RETURN
520 IF G=-33;G=31;H=H+G;RETURN
530 IF G=31;G=-33;H=H+G;RETURN
540d E=ABSRND%2
550 IF G=31 AND E=0;G=33;H=H+G;GOTO 710
560 IF G=31;G=1;H=H+G;GOTO 710
570 IF G=-33 AND E=0;G=-31;H=H+G;GOTO 710
580 IF G=-33;G=1;H=H+G;GOTO 710
590 IF G=-31 AND E=0;G=-33;H=H+G;GOTO 710
600 IF G=-31;G=-1;H=H+G;GOTO 710
610 IF G=33 AND E=0;G=31;H=H+G;GOTO 710
620 IF G=33;G=-1;H=H+G;GOTO 710
630 IF G=1;E=ABSRND%3;GOTO 680
640 IF G=-1;E=ABSRND%3
650 IF E=0;G=-31;H=H+G;GOTO 710
660 IF E=1;G=33;H=H+G;GOTO 710
670 IF E=2;G=1;H=H+G;GOTO 710
680IF E=0;G=-33;H=H+G;GOTO 710
690 IF E=1;G=31;H=H+G;GOTO 710
700 IF E=2;G=-1;H=H+G
710 IF H?Z=204;GOSUB c;RETURN
720 RETURN
730 PRINT $12
740 PRINT"         **************"'
750 PRINT"         *** SOCCER ***"'
760 PRINT"         **************"''
770 PRINT"THIS PROGRAM ACTS AS A TV-GAME, WITH TWO PLAYERS "
780 PRINT"MOVING"'"THEIR BATS TO HIT THE BALL."''
790 PRINT"PRESS ANY KEY TO CONTINUE";LINK #FFE3;PRINT $12
800 PRINT"CONTROLS:"''
810 PRINT"       PLAYER 1    PLAYER 2"'
820 PRINT"UP        Q           P"'
830 PRINT"DOWN    SHIFT         ."''
840 PRINT"THE FIRST PERSON TO SCORE 15"'"GOALS WINS."''
850 PRINT"PRESS ANY KEY TO START";LINK #FFE3;RETURN
860 PRINT $12"THE WINNER WAS:"''"player";IF AA0=15 PRINT" 2"'
870 IF AA1=15 PRINT" 1"'
880 INPUT''''"ANOTHER GAME (Y OR N)"$M
890 IF ?M=CH"Y" GOTO 30
900 IF ?M=CH"N" PRINT $12''''''"      THANK YOU"''';END
910 GOTO 880
