
10 DIM W(64),T(64),P(8)
20cPRINT $12;X=1;Y=0;%T=0
30dPRINT $30,"                   ",$13
40 INPUT" AMOUNT "$W;%W=VALW;PRINT $30
42 IF $W="E"THEN FPRINT%T;G.c
45 FIF%W=0THEN PRINT$7;G.d
50 %T=%T+%W
60 STR%T,T;GOSUBb
70 P!0=#8000+19;P!4=T
80 GOSUBa
90 P!0=#8000+X*32+Y;P!4=W
100 GOSUBa
110 X=X+1
120 IF X>15 THEN X=1;Y=Y+11
130 IF Y<31 THEN G.d
140 PRINT$7
150 INPUT "PAGE FULL-OK?"$W
160 IF $W= "Y"THEN G.c
170 X=1;Y=0;G.d
1000aFOR A=0TOLEN(P!4)-1
1010 ?(P!0+A)=((P!4)?A)&#3F
1020 NEXT
1030 RETURN
2000bA=LENT-1
2010 DO P!0=CH$T+A
2020 IF P!0=48 THEN $T+A=""
2030 IF P!0=46 THEN $T+A+1="0"
2040 A=A-1;UNTIL A=0 OR P!0<>48
2050 R.
2060 END
