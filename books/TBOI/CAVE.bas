
0 REM THE BEST OF INTERFACE PAGE 32-33-34
10 REM DOOMSWATCH CAVE
20 REM (c) HARTNELL 1982
30 GOSUB 1280
40 DIM AA(100),Z(4);T=0;R=0;Q=0
50 FOR B=1 TO 100
60 AA(B)=0
70 IF B<12 OR B>90 THEN AA(B)=9
80 IF 10*(B/10)=B THEN AA(B)=9
90 IF B=21 OR B=31 OR B=41 OR B=51 OR B=61 THEN AA(B)=9
100 IF B=71 OR B=81 THEN AA(B)=9
110 NEXT B
120 REM NO EXIT
130 FOR B=1 TO 6
140 AA(A.R.%76+12)=9
150 REM TROLLS
160 AA(A.R.%76+12)=1
170 REM MONSTERS
180 AA(A.R.%76+12)=2
190 REM PITS
200 AA(A.R.%76+12)=3
210 REM MONEY
220 AA(A.R.%76+12)=5;AA(A.R.%76+12)=5
230 NEXT B
240 @=0
250 REM HUMAN LOCATION
260 X=55
270 AA(X)=4
280 Q=ABSRND%8
290 IF Q=0 THEN GOSUB 1140
300 PRINT $12;?#E1=0
310 Q=1
320 PRINT"YOU ARE IN CAVE NUMBER "X'
330 IF R>0 THEN PRINT"WITH $"R'
340 GOSUB 920;PRINT'
350 IF T>1 PRINT"YOU HAVE SURVIVED "T" ROUNDS"'
360 PRINT'"WHICH DIRECTION DO YOU WANT"'"TO MOVE (N, S, E, W)"
370 INPUT $Z
380 IF $Z="N" AND AA(X-10)=9 PRINT"NO EXIT";GOTO 370
390 IF $Z="S" AND AA(X+10)=9 PRINT"NO EXIT";GOTO 370
400 IF $Z="E" AND AA(X+1)=9 PRINT"NO EXIT";GOTO 370
410 IF $Z="W" AND AA(X-1)=9 PRINT"NO EXIT";GOTO 370
420 AA(X)=0
430 IF $Z="N" THEN X=X-10
440 IF $Z="S" THEN X=X+10
450 IF $Z="E" THEN X=X+1
460 IF $Z="W" THEN X=X-1
470 Y=X
480 IF AA(Y)=1 THEN GOSUB 550
490 IF AA(Y)=2 THEN GOSUB 640
500 IF AA(Y)=3 THEN GOSUB 760
510 IF AA(Y)=5 THEN GOSUB 810
520 T=T+1
530 IF T=100 THEN Q=9;GOTO 1080
540 GOTO 270
550 REM TROLLS
560 PRINT"UH OH, YOU HAVE LANDED ON"'
570 PRINT"A TROLL..."'
580 PRINT''
590 PRINT"YOU WILL BE MOVED TO ANOTHER"'
600 PRINT"PART OF THE CAVE...BY MAGIC"'
610 FOR J=1 TO 100;WAIT;NEXT J
620 AA(X)=0;X=ABSRND%76+12
630 RETURN
640 REM MONSTERS
650 PRINT"HORRORS, YOU HAVE BLUNDERED"'
660 PRINT"INTO THE MONSTERS DEN"'
670 PRINT"**********STAND BY*************"
680 PRINT''
690 FOR J=1 TO 100;WAIT;NEXT J
700 IF ABSRND%3=0 THEN PRINT"IT HAS NOT SEEN YOU";GOTO 740
710 PRINT"IT HAS SEEN YOU AND"
720 IF ABSRND%2=0 PRINT"EATS YOU";GOTO 1080
730 PRINT" DECIDES TO IGNORE YOU"
740 FOR J=1 TO 100;WAIT;NEXT J
750 RETURN
760 REM PITS
770 PRINT"A BOTTOMLESS PIT!!!"'
780 PRINT"AAAAAAAAARRGHHHHH!!!!"
790 FOR J=1 TO 100;WAIT;NEXT J
800 GOTO 1080
810 REM MONEY
820 PRINT'"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
830 PRINT"* * * * treasure!!!!!! * * * *"
840 PRINT'"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
850 W=ABSRND%100+100
860 PRINT''
870 PRINT"YOU HAVE FOUND $"W"!!"'
880 R=R+W
890 PRINT">>>>>>>>YOU NOW HAVE $"R
900 FOR J=1 TO 100;PRINT"$";WAIT;NEXT J
910 RETURN
920 REM CLUES
930 K=0
940 IF AA(X-11)<>0 THEN K=AA(X-11)
950 IF AA(X-10)<>0 THEN K=AA(X-10)
960 IF AA(X-9)<>0 THEN K=AA(X-9)
970 IF AA(X-1)<>0 THEN K=AA(X-1)
980 IF AA(X+1)<>0 THEN K=AA(X+1)
990 IF AA(X+9)<>0 THEN K=AA(X+9)
1000 IF AA(X+10)<>0 THEN K=AA(X+10)
1010 IF AA(X+11)<>0 THEN K=AA(X+11)
1020 IF K=0 THEN RETURN
1030 IF K=1 THEN PRINT"WARNING - TROLLS NEARBY"
1040 IF K=2 THEN PRINT"NASTY...A MONSTER IS CLOSE"
1050 IF K=3 THEN PRINT"DANGER, YOU ARE NEAR"'"A BOTTOMLESS PIT"
1060 FOR J=1 TO 230;WAIT;NEXT J
1070 RETURN
1080 REM END
1090 PRINT $12
1100 IF Q=9 THEN GOTO 9015
1110 PRINT"END OF GAME, YOU ARE DEAD"
1120 AA(Y)=4
1130 PRINT''"YOU SURVIVED "T" ROUNDS"'
1140 PRINT'
1150 PRINT"**CAVE SYSTEM**"'
1160 FOR J=1 TO 100
1170 IF AA(J)=9 THEN PRINT"W"
1180 IF AA(J)=1 THEN PRINT"t"
1190 IF AA(J)=2 THEN PRINT"M"
1200 IF AA(J)=3 THEN PRINT"P"
1210 IF AA(J)=0 THEN PRINT"."
1220 IF AA(J)=4 THEN PRINT"H"
1230 IF AA(J)=5 THEN PRINT"$"
1240 IF 10*(J/10)=J THEN PRINT'
1250 NEXT J
1260 IF Q<>0 THEN END
1270 RETURN
1280 PRINT $12
1290 PRINT"    ***********************"'
1300 PRINT"    *** doomswatch cave ***"'
1310 PRINT"    ***********************"''
1320 PRINT"IN THIS GAME YOU ARE IN A 10X10 CAVE SYSTEM, TRYING"
1330 PRINT" TO ACCUMULATE MONEY. FROM TIME TO TIME, YOU'LL BE "
1340 PRINT"GIVEN A BRIEF GLIMPSE OF THE CAVE SYSTEM FROM ABOVE"
1350 PRINT". TO MAKE THE BEST USE OF THIS PROGRAM, YOU SHOULD "
1360 PRINT"DRAW UP A BLANK 10X10 GRID, NUMBERING THE SQUARES "
1370 PRINT"1 TO 100, THEN INSERT THINGS LIKE WALLS AND BOTTOM"
1380 PRINT"LESS PITS AS YOU ARE GIVEN CLUES AS TO WHEREABOUTS."
1390 PRINT"PRESS ANY KEY TO CONTINUE";LINK#FFE3;PRINT $12
1400 PRINT"YOU DIE IF A MONSTER EATS YOU OR YOU FALL DOWN A "
1410 PRINT"PIT. STUMBLING INTO A CAVE WHICH HOLDS A TROLL WILL"
1420 PRINT" MOVE YOU TO A RANDOM PART OF THE DOOMSWATCH CAVE"
1430 PRINT"SYSTEM. THE CAVE IS EMPTIED, IN THIS CASE, BEFORE "
1440 PRINT"YOU ARRIVE. EACH CAVE IS EMPTIED AFTER YOU LEAVE IT"
1450 PRINT", SO YOU CAN NOT RETURN TO  A TREASURE CAVE TIME "
1460 PRINT"AND TIME AGAIN. NOTE THAT YOU ARE GIVEN CLUES ONLY "
1470 PRINT"TO ONE OF THE SURROUNDING SQUARES, SO YOU MAY WELL "
1480 PRINT"NOT BE AWARE OF ALL THAT IS AROUND YOU. PRESS ANY "
1490 PRINT"KEY TO CONTINUE";LINK #FFE3;PRINT $12
1500 PRINT"THE KEY TO THE CAVE PRINTOUT:"''
1510 PRINT"W - WALLS        P - BOTTOMLESS PITS"'
1520 PRINT"$ - TREASURE     t - TROLLS"'
1530 PRINT"H - YOU(HUMAN)   M - MONSTER"''
1540 PRINT"PRESS ANY KEY TO START";LINK#FFE3;PRINT $12;RETURN