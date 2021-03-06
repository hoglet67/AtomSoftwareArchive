
10 REM DUCKSHOOT
20 REM BY TIM JACKSON, DEC 81
30 REM USES PROGRAMMERS'S TOOLBOX FOR SOUND EFFECTS
40 REM AVAILABLE FROM PROGRAM POWER, 5 WENSLEY ROAD, LEEDS 7
50 REM OTHERWISE, DELETE LINES 740,940 & 980 TO 1080
60 DIM X3,Y3,R3,B25,LL10,V8,W8
70 FOR N=0 TO 10;LL10=#FFFF;NEXT
80 PRINT $12"          DUCKSHOOT"'
90 PRINT"          ---------"''''
100 PRINT"PRESS SHIFT TO AIM LEFT"'
110 PRINT"PRESS REPT  TO AIM RIGHT"'
120 PRINT"PRESS SPACE BAR TO FIRE"'
130 PRINT $21
140 GOSUB 1100;GOSUB 1100
150 PRINT $6
160 REM SET DUCK SHAPES
170 !B=#3E7FC000;B!4=#81C
180 B!6=#3E7FDC08;B!10=0
190 B!12=#7CFE0300;B!16=#1038
200 B!18=#7CFE3B10;B!22=0
210 REM SET VECTORS TO DUCK SHAPE
220 !#A0=B;!#A2=B+6
230 !#A4=B+12;!#A6=B+18
240 REM SET GUN & BULLET DIRECTON VECTORS
250 !V=#3020100;V!4=#7060504;V?8=8
260 !W=#6060504;W!4=#5060606;W?8=4
270 REM G IS CURRENT GUN DIRECTION (0-8)
280 REM ACCESSED BY V?G FOR HORIZONTAL;W?G FOR VERTICAL
290 REM S&T ARE CURRENT X&Y OF BULLET
300 REM K&L GIVE INCREMENTS TO S&T(FROM I&J OF GUN WHEN FIRED)
310hPRINT'''''"PRESS SPACEBAR WHEN YOU'RE READY"
320 LINK#FFE3
330 T=0;REM BULLET
340 FOR N=0 TO 3;Y?N=200;NEXT
350 CLEAR 2
360 Q=#8000
370 FOR N=0 TO #5FF STEP 2
380 Q?N=-1;Q?(#5FF)=-1
390 NEXT N
400 REM INITIAL GUN
410 G=4;GOSUB g
420 ?#B000=?#B000|9;REM SET KEYBD TO DETECT SPACEBAR
430 H=0;REM ZERO SCORE
440 FOR A=1 TO 10
450 FOR E=0 TO 3
460 IF Y?E<200 Z=0;GOTO f
470 REM CREATE DUCK
480 REM HEIGHT (48 TO 90)
490 Y?E=RND&7*6+48
500 REM R?E IS +1 IF MOVING RIGHT, -1 FOR LEFT
510 R?E=RND&2-1
520 REM X?E IS 0 OR 15 TO START
530 X?E=(1-R?E)&#FF/2*15
540 REM INSERT IT
550 D=E;LINK LL0
560 Z=-(RND&7+2)
570 REM MOVE EVERYTHING
580fFOR F=Z TO 0
590 FOR D=0 TO 3
600 LINK LL6;REM MOVE DUCK D
610 Q=1
620 REM GUN TO LEFT IF SHIFT PRESSED
630 IF ?#B001<128;IF G>0;GOSUB g;G=G-1;GOSUB g;Q=0
640 REM GUN TO RIGHT IF REPT PRESSED
650 IF ?#B002&#40=0;IFG<8;GOSUB g;G=G+1;GOSUB g;Q=0
660 REM CHECK FIRE BUTTON (SPACEBAR) & CREATE BULLET
670 IF T=0;IF ?#B001&1=0;S=I+67;T=J;K=I/2;L=J/2;PLOT 14,S,T
680 REM MOVE BULLET
690 IF T GOSUB p;Q=0
700 IF Q;FOR N=0 TO 100;NEXT
710dNEXT D
720 NEXT F
730 NEXT E
740 NEXT A
750 GOSUB 1000;REM PLAY TUNE
760 PRINT $12"           DUCKSHOOT"'
770 PRINT"           ---------"'''''
780 PRINT"YOUR SCORE WAS",H
790 GOTO h
800 REM INSERT/DELETE GUN
810gI=V?G*2-8;J=W?G*2
820 MOVE 66,0;WAIT;PLOT 2,I,J
830 MOVE 68,0;WAIT;PLOT 2,I,J
840 RETURN
850 REM MOVE BULLET
860pWAIT;PLOT 14,S,T
870 S=S+K;T=T+L
880 IF S&#FF>127 OR T&#FF>95;T=0;RETURN
890 FOR C=0 TO 3
900 IF Y?C=T/6*6;IF X?C=S/8;GOSUB q;C=3;NEXT;RETURN
910 NEXT
920 WAIT;PLOT 14,S,T
930 RETURN
940qREM A HIT!
950 FOR N=0 TO 7;BEEP 80,1;BEEP 50,1;NEXT
960 U=X;X=C;LINK LL10;X=U;REM DELETE DUCK
970 Y?C=200;T=0;F=0;H=H+1
980 RETURN
990 REM COLONEL BOGEY
1000 RESTORE
1010 FOR N=1 TO 11
1020 READ P,Q
1030 BEEP P,Q
1040 NEXT N
1050 RETURN
1060 DATA #A1,10,#C0,10,0,10
1070 DATA #C0,10,#B5,10,#A1,10
1080 DATA #60,15,0,5,#60,15
1090 DATA 0,5,#79,20
1100 DIM P(-1)
1110[
1120:LL5 BIT#B002;BMI LL5 WAIT FOR TV FLY BACK
1130 RTS
1140\GET SCREEN ADDRESS IN #A8
1150:LL0 LDX#325 GET D
1160:LL10 LDA@#20;STA#A9
1170 LDA@95
1180 SEC
1190 SBC Y,X GET 95-Y?D
1200 BCC LL5 OFF SCREEN
1210 ASLA;ASLA TIMES 16
1220 ASLA;ROL #A9
1230 ASLA;ROL #A9
1240 ORA X,X GET X?D
1250 STA#A8
1260\INSERT/DELETE DUCK
1270 LSRA CARRY FLAGS WINGS UP OR DOWN
1280 LDA R,X GET R?D
1290 BPL LL2 GET 0 IF GOING LEFT,ELSE 1
1300 LDA@0
1310:LL2 ROLA;ASLA NOW HAVE OFFSET FROM #A8 FOR SHAPE
1320 TAX
1330 LDA #A0,X
1340 STA #AA
1350 LDA #A1,X
1360 STA #AB
1370 LDX @0
1380 LDY @5
1390:LL1 BIT #B002;BMI LL1 WAIT FOR TV FLY BACK
1400:LL3 LDA(#AA),Y GET PATTERN
1410 EOR(#A8,X) INVERT SCREEN
1420 STA(#A8,X)
1430 LDA #A8;SEC
1440 SBC @16 NEXT SCREEN ADDRESS
1450 STA #A8
1460 BCS LL4
1470 DEC #A9
1480:LL4 DEY
1490 BPL LL3
1500 RTS
1510\MOVE DUCK D
1520:LL6 JSR LL0 DELETE IT
1530 LDX #325 GET D
1540 LDA X,X GET X?D
1550 CLC
1560 ADC R,X INC. OR DEC. IT
1570 STA X,X
1580 CMP @16;BCC LL7
1590 LDA @200;STA Y,X Y?D=200 IF OFF SCREEN
1600 RTS
1610\CHECK FOR DUCK COLLISIONS
1620:LL7 LDY @3
1630:LL8 CPY #325 EQUALS D?
1640 BEQ LL9
1650 LDA Y,Y;CMP Y,X
1660 BNE LL9
1670 LDA X,Y;CMP X,X
1680 BNE LL9
1690\COLLISION,SO DELETE OTHER DUCK
1700 TYA;PHA SAVE Y
1710 TAX AND USE IN LACE OF D
1720 JSR LL10 DELETE DUCK
1730 LDX #325 GET D
1740 PLA;TAY GET Y
1750 LDA @200 PUT BOTH DUCKS OFF SCREEN
1760 STA Y,Y;STA Y,X
1770 LDA @0;STA #327;STA #342;STA #35D;STA #378 ZERO F
1780 RTS
1790:LL9 DEY CONTINUE LOOP
1800 BPL LL8
1810 JMP LL0 INSERT DUCK AND RETURN
1820];RETURN
