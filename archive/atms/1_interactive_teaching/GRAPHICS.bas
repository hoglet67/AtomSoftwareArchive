
1?#E=51;?#D=#FD;G.500
2�(�L��
10 V=46
20 INPUT"STEP SIZE "J
30 IF J=0 GOTO 20
40 CLEAR 0
50 FOR Z=0 TO V STEP J
60 Y=V-Z
70 MOVE 0,Z
80 DRAW Y,0
90 MOVE Y,V
100 DRAW V,Z
110 NEXT Z
120R.
130 FOR N=1 TO 20
140 CLEAR 1
150 FOR I=1 TO N
160 X=ABSRND%128
170 Y=ABSRND%64
180 DRAW X,Y
190 NEXT I
200 FOR J=0 TO 60
210 WAIT
220 NEXT J
230 NEXT N
240 PRINT$12
250R.
500B=256;;E=T.-17;C=E-33;M=C-26;S=M-13;G=T.-122;W=60
510?16=E;?17=E&#FFFF/256
520P.$12;GOS.d;P."GRAPHICS"';GOS.d;P.';T=#300D
540GOS.p;P."CLEAR N"'"MOVE X,Y"'"DRAW X,Y"'';GOS.p;GOS.a
550CLEAR0;DRAW63,0;DRAW0,0;DRAW0,47;DRAW63,47
560MOVEW,44;DRAWW,35;DRAW54,35;DRAW54,44;DRAWW,44;P.$8$8
570P.$S$11$11$11"ACORNSOFT"$S$10" 4A MARKET HILL"$S$10$8$8$8$8
580P."CAMBRIDGE";GOS.t;P.'$12;GOS.p;GOS.p;GOS.s
590GOS.p;GOS.p;GOS.s;GOS.p;P.$G'$C'
600R=600;O=10;L=120;F=0;GOS.h;P.'$12"HERE IS THAT PROGRAM:"'
610GOS.l;GOS.p;GOS.s;GOS.l;GOS.p;GOS.s
630GOS.p;P.'$G'$C';O=130;L=250;F=120;GOS.h;P.'$12
640IN."DO YOU WANT TO REPEAT THIS"'"LESSON "$B;IF?B=89G.500
900P."GOODBYE !"';END
1100dF.I=1TO32;P.$172;N.I;R.
1300pI=0;DOB?I=T?I;I=I+1;U.T?I=32ORT?I=13
1310B?I=13;IFT?I=13;T=T+2
1320IFC.+I>31;P.'
1330I=I+1;IF$B="^"G.q
1335P.$B" ";T=T+I;G.p
1340qT=T+I;P.'';R.
1500rA=CH">";LINK#CD0F;R.
1600x@=5;P.'"ERROR"?0';@=8
1610IF?0=29;P.'"YOU MUST TYPE A NUMBER IF ASKED"'
1620G.R
1700lN=#2800;@=5;DON=N+1;U.?N=13A.N?1=O/256A.N?2=O&#FF
1720DOP.'(N?1*256+N?2)-F;N=N+3;P.$N;N=N+L.N
1730U.N?1=L/256A.N?2=L&#FF;P.'(N?1*256+N?2)-F
1740P." END"'';@=8;R.
1800hGOS.r;I=-1;DO I=I+1;U.B?I<>32;P=B+I
1810IF?P=13;G.h
1840IF$P="RUN";GOS.O;G.h
1850IF$P="LIST";GOS.l;G.h
1855IF$P="C";R.
1860P."SORRY I AM ONLY DEALING WITH"'"SIMPLE VERSIONS OF LIST"
1861P." AND RUN"';G.h
1890aP.'"PRESS SPACE TO START"'
1900GOS.t;CLEAR0;?#E1=0
1910F.I=0TO5;P.$11$9;N.;;P."    CLEAR 0"$S
1920GOS.t;P."   MOVE 0,47"$S;MOVE0,47;GOS.t;DRAW63,47
1925P." DRAW 63,47"$S;GOS.t;DRAW63,0
1927P."DRAW 63,0 "$S;GOS.t
1930DRAW0,0;P."DRAW 0,0  "$S;GOS.t;DRAW0,47;P."DRAW 0,47 "
1935P.$S;GOS.t;DRAW31,24;P."DRAW 31,24"$S;GOS.t
1940DRAW63,47;P."DRAW 63,47"$S;GOS.t;P."PRESS SPACE"$S$10
1945P.$8"TO TURN OVER";GOS.t;R.
2000s?#E1=0;P.$M;GOS.t;P.'$12;R.
2100tLINK#FFE3;R.
5000THE ATOM HAS 3 SIMPLE GRAPHICS COMMANDS THESE ARE: ^
5005THE FOLLOWING PROGRAM WILL DISPLAY THE COMMAND BEING
5007EXECUTED AND ITS EFFECT. PRESS SPACE TO STEP THROUGH THE
5008PROGRAM. ^
5010'CLEAR 0' WILL CLEAR THE SCREEN AND SETS UP GRAPHICS MODE
5020ZERO. THIS HAS A RESOLUTION OF 64 BY 48. ^
5030'CLEAR 1' WILL SET UP GRAPHICS MODE 1. THE RESOLUTION IN
5040THIS MODE IS 128 BY 64. ^
5050MOVE X,Y WILL MOVE TO THE POINT X,Y. THE POINT 0,0 IS
5060AT THE BOTTOM LEFT OF THE SCREEN. ^
5070DRAW X,Y DRAWS A LINE FROM THE CURRENT POSITION TO X,Y. ^
5080'FOR...NEXT' LOOPS ARE OFTEN VERY USEFUL IN GRAPHICS
5090PROGRAMS. THE NEXT PROGRAM READS IN A 'STEP SIZE'
5100THEN DRAWS A PATTERN. STEP SIZES BETWEEN 2 AND 6 WORK BEST.
5110^ LINE 30 ENSURES THAT THE STEP SIZE IS NOT ZERO. ^
5120THE LOOP BETWEEN 50 AND 110 DRAWS THE PATTERN. ^
5130FINALLY A MYSTERY PROGRAM.
5140THE WAIT STATEMENT GIVES A 1/60 OF A SECOND DELAY. ^
8000LIST THIS PROGRAM THEN RUN IT.
8065
8070PRESS SPACE TO CONTINUE
8080TYPE C TO RETURN CONTROL TO ME
8090?18=40;P.$7;G.x
