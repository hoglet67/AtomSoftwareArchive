
0REM THE BEST OF INTERFACE PAGE 37-38-39
10 REM YATHZEE BY I. SMITH
20 GOSUB 920
30 @=3;A=0;B=0;C=0;O=0;K=0
40 DIM AA15,BB15;FOR Z=1 TO 15;AAZ=0;BBZ=0;NEXT Z
50 DIM GG6;FOR Z=1 TO 6;GGZ=0;NEXT Z
60 DIM DD5;DIM Q2
70 PRINT $12
80 DIM FF5;FOR Z=1 TO 5;FFZ=0;NEXT Z
90 PRINT $30;?#E1=0;@=3
100 PRINT"1.ACES  "AA1"   7.3 OF A KIND "AA7'
110 PRINT"2.TWOS  "AA2"   8.4 OF A KIND "AA8'
120 PRINT"3.THREES"AA3"   9.FULL HOUSE  "AA9'
130 PRINT"4.FOURS "AA4"  10.SMALL STR.  "AA10'
140 PRINT"5.FIVES "AA5"  11.LARGE STR.  "AA11'
150 PRINT"6.SIXES "AA6"  12.YAHTZEE     "AA12'
160 PRINT"  BONUS "AA14"  13.CHANCE      "AA13''
170 PRINT"   G R A N D  T O T A L  "AA15
180 K=K+1;IF K=14 THEN GOTO 900
190 PRINT''"   1   2   3   4   5"'
200 PRINT"                          "'$11
210 FOR Z=0 TO 20;DDZ=ABSRND%6+1
220 NEXT Z;@=2
230 FOR Z=1 TO 5;PRINT"  "DDZ;NEXT Z;PRINT''
240 C=C+1
250 IF C=3 THEN C=0;GOTO a
260 FOR Z=1 TO 5
270 PRINT"HOLD "Z;INPUT $Q
280 IF $Q="Y" THEN E=E+1;FFZ=1;GOTO 310
290 IF $Q="N" THEN GOTO 310
300 PRINT $11"           "'$11;GOTO 270
310 PRINT $11"           "'$11;NEXT Z
320 IF E=5 THEN GOTO a
330 PRINT $11$11;GOTO 200
340a IF DD1=DD2A.DD2=DD3A.DD3=DD4A.DD4=DD5A.BB12=1 THEN GOSUB g
350 INPUT"WHICH SECTION"Y
360 IF BBY=1 OR Y>13 PRINT $11"                "'$11;GOTO 350
370 PRINT $11"                "'
380 FOR Z=1 TO 5;FFZ=0;NEXT Z
390 BBY=1
400 IF Y<7 THEN GOTO b
410 IF Y=13 THEN GOTO c
420 FOR Z=1 TO 5
430 GG(DDZ)=GG(DDZ)+1
440 NEXT Z
450 IF Y=7 THEN GOTO d
460 IF Y=8 THEN GOTO e
470 IF Y=9 THEN GOTO f
480 IF Y=12 THEN GOTO 590
490 IF Y=11 THEN GOTO 550
500 IF GG1>=1 A. GG2>=1 A. GG3>=1 A. GG4>=1 THEN GOTO 540
510 IF GG2>=1 A. GG3>=1 A. GG4>=1 A. GG5>=1 THEN GOTO 540
520 IF GG3>=1 A. GG4>=1 A. GG5>=1 A. GG6>=1 THEN GOTO 540
530 GOTO 870
540 AA10=30;AA15=AA15+30;GOTO 870
550 IF GG1=1 A. GG2=1 A. GG3=1 A. GG5=1 A. GG5=1 THEN GOTO 580
560 IF GG2=1 A. GG3=1 A. GG4=1 A. GG5=1 A. GG6=1 THEN GOTO 580
570 GOTO 870
580 AA11=40;AA15=AA15+40;GOTO 870
590 IF GG1=5ORGG2=5ORGG3=5ORGG4=5ORGG5=5ORGG6=5 THEN GOTO 610
600 GOTO 870
610 AA12=50;AA15=AA15+50;GOTO 870
620b
630 FOR Z=1 TO 5
640 IF DDZ=Y THEN AAY=AAY+Y;AA15=AA15+Y
650 NEXT Z
660 B=B+1;IF B=6 THEN GOTO 680
670 GOTO 90
680 IF AA1+AA2+AA3+AA4+AA5+AA6>=63 THEN AA15=AA15+35;AA14=35
690 GOTO 90
700cAA13=DD1+DD2+DD3+DD4+DD5;AA15=AA15+AA13;GOTO 90
710dIF GG1>=3ORGG2>=3ORGG3>=3ORGG4>=3ORGG5>=3ORGG6>=3;GOTO 730
720 GOTO 870
730 AA7=DD1+DD2+DD3+DD4+DD5;AA15=AA15+AA7;GOTO 870
740eIF GG1>=4ORGG2>=4ORGG3>=4ORGG4>=4ORGG5>=4ORGG6>=4;GOTO 760
750 GOTO 870
760 AA8=DD1+DD2+DD3+DD4+DD5;AA15=AA15+AA8;GOTO 870
770f
780 FOR Z=1 TO 6
790 IF GGZ=3 THEN GGZ=0;O=1
800 NEXT Z
810 IFO<>1 THEN GOTO 870
820 FOR Z=1 TO 6
830 IF GGZ=2 THEN O=2
840 NEXT Z
850 IF O<>2 THEN GOTO 870
860 AA9=25;AA15=AA15+25
870 FOR Z=1 TO 6;GGZ=0;NEXT Z;C=0;GOTO 90
880gIF AA12=50 THEN PRINT $7;AA15=AA15+100
890 RETURN
900 PRINT''"                      "'"
910 PRINT';?#E1=#80;END
920 PRINT $12
930 PRINT"        ***************"'
940 PRINT"        *** yahtzee ***"'
950 PRINT"        ***************"''
960 PRINT"THE RULES WILL BE KNOWN I PRESUME."'
970 PRINT"YOU HAVE THREE ROLLS OF A DIE. YOU MAY HOLD AS MANY "
980 PRINT"AS YOU LIKE ON EACH ROLL. THEN AFTER THREE ROLLS, "
990 PRINT"YOU MUST FILL IN ONE OF THE BLANKS IN THE SCOREBOARD"
1000 PRINT". ONCE A BLANK IS FILLED, IT CANOT BE USED AGAIN."
1010 PRINT''"PRESS ANY KEY TO CONTINUE";LINK #FFE3;PRINT $12
1020 PRINT"IF YOUR TOTAL OF 1-6 IS GREATER THAN OR EQUAL TO "
1030 PRINT"63, YOU GET 35 BONUS POINTS. A FULL HOUSE IS THREE "
1040 PRINT"OF ONE NUMBER AND TWO OF ANOTHER. A SMALL STRAIGHT "
1050 PRINT"IS A PROGRESSION OF FOUR NUMBERS E.G. 14326. "
1060 PRINT"A LARGE STRAIGHT IS THE SAME, BUT THERE MUST BE "
1070 PRINT"FIVE NUMBERS IN PROGRESSION."''
1080 PRINT"PRESS ANY KEY TO START";LINK #FFE3;PRINT $12;RETURN
