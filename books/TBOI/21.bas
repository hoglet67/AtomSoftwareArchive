
0REM THE BEST OF INTERFACE PAGE 36
10 REM TWENTY ONE
20 PRINT $7$12;GOSUB 300
30 T=0;M=0;FOR Z=1 TO 5;E=0;F=0;GOSUB a;R=RND;S=RND
40 PRINT $12;@=0;?#E1=0
50 GOSUB w
60 IF E>0 P."YOU ROLLED A "Q';GOSUB w;PRINT"    TOTAL IS "E'
70 IF E=0 PRINT"R TO ROLL, S TO STAND"'
80 INPUT $A;IF $A="R" THEN Q=ABSRND%6+1;E=E+Q
90 IF $A="S" THEN GOTO 130
100 IF E>21 THEN GOTO 200
110 IF E<21 THEN GOTO 60
120 GOSUB a
130 PRINT"O.K. YOU STAND ON "E'
140 G=ABSRND%6+1;F=F+G;PRINT'"I ROLLED A "G". MY TOTAL IS "F'
150 GOSUB w;IF (F<17) OR (F<E) & (E<22) THEN GOTO 140
160 IF (F<E);IF (E>21) THEN GOTO 200
170 IF F>18;IF ((E<>20)OR(E<>21)) THEN GOTO 190
180 PRINT"YOU STOOD ON "E'''
190 PRINT"I STAND ON "F'''
200 IF ((F>E)&(F<22)) OR (E>21) PRINT"  I WIN"';T=T+1
210 IF (F>21) OR ((E>F)&(E<22)) PRINT"  YOU WIN"';M=M+1
220 IF (E=F);IF (E<22) PRINT"  DEAD HEAT"'
230 NEXT Z
240 IF T>M PRINT"I WIN"';GOTO 240
250 IF M>T PRINT"YOU WIN"';GOTO 250
260 PRINT"WE BOTH WIN"';GOTO 260
270a PRINT"round "$128$(144+Z)$128''"YOU "M"   ME "T'
280 FOR Y=1 TO 40;WAIT;NEXT Y
290w FOR Y=1 TO 40;WAIT;NEXT Y;RETURN
300 PRINT"      ******************"'
310 PRINT"      *** TWENTY-ONE ***"'
320 PRINT"      ******************"''
330 PRINT"YOU AND THE ATOM TAKE IT IN TURNS TO THROW A SINGLE "
340 PRINT"DIE, TRYING TO GET AS CLOSE AS POSSIBLE TO 21, WITHO"
350 PRINT"UT EXCEEDING 21. THERE ARE 5 ROUNDS TO A GAME."''
360 PRINT"PRESS ANY KEY TO START ";LINK #FFE3;PRINT$12;RETURN
