
1 REM HANGMAN
10 DIM W(20),R(1);N=10
20 CLEAR 0;GOTO 100
50a*CAMBRIDGE*ATOM*FIEND*SLAYS
51 *FOREIGN*MICRO*DURING*PIZZA
52 *EATING*COMPETITION
100 X=?18*256;D=#D;Y=CH"a"
110 DO DO X=X+1;UNTIL ?X=D;UNTIL X?3=Y
120 X=X+3;Y=CH"*"
130 FOR P=1 TO ABSRND%N
140 DO X=X+1;IF ?X=D X=X+3
150 UNTIL ?X=Y;X=X+1
160 NEXT P;Z=0
170 DO W?Z=X?Z;Z=Z+1
180 UNTIL X?Z=D OR X?Z=Y OR X?Z=CH" "
190 W?Z=D
200 FOR X=1 TO LEN(W);X?#80F0=#2E;NEXT
210 MOVE 0,9;DRAW 24,9
220 E=0
300 DO !#DE=#81C0
310 P."LETTER     "$8$8$8;INPUT $R
320 UNTIL ?R>CH"@" AND ?R<CH"["
400 X=1
410 IF X?#80F0=#2E IF ?R=W?(X-1) GOTO 600
420 IF X<LEN(W) X=X+1;GOTO 410
430 GOSUB (1000+100*E);E=E+1
440 IF E<10 GOTO 300
500 !#DE=#8111;P.$W
510 !#DE=#81C0;P."<** YOU ARE dead !!! **"
520 ?#E1=#80;END
530 END
600 X?#80F0=?R-#40;C=0
610 FOR X=1 TO LEN(W)
620 IF X?#80F0=#2E C=1
630 NEXT X;IF C=1 GOTO 300
700 CLEAR 0;MOVE 16,40
710 GOSUB 1400;GOSUB 1500;GOSUB 1600
720 GOSUB 1700;GOSUB 1800
730 MOVE 16,32;DRAW 24,40
740 MOVE 0,8;DRAW 63,8
750 !#DE=#80F1;P.$W
760 !#DE=#81C0;P."<** A REPRIEVE !! ** "
770 ?#E1=#80;END
1000 MOVE 0,6;DRAW 0,47;RETURN
1100 MOVE 0,38;DRAW 9,47;RETURN
1200 MOVE 0,47;DRAW 16,47;RETURN
1300 DRAW 16,40;RETURN
1400 DRAW 14,40;DRAW 14,36;DRAW 18,36
1410 DRAW 18,40;DRAW 16,40;RETURN
1500 MOVE 16,36;DRAW 16,24;RETURN
1600 DRAW 8,10;RETURN
1700 MOVE 16,24;DRAW 24,10;RETURN
1800 MOVE 16,32;DRAW 8,40;RETURN
1900 MOVE 3,9;PLOT 7,24,9
1910 MOVE 8,10;PLOT 6,16,24;PLOT 6,24,10
1920 MOVE 14,8;DRAW 16,24;MOVE 18,8;DRAW 16,24
1930 MOVE 8,40;PLOT 6,16,32;DRAW 13,22
1940 MOVE 16,32;DRAW 19,22;RETURN
