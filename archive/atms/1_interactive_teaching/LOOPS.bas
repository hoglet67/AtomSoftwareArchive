
4?#E=51;?#D=#44
5G.500;�(�L��
10 S=0
20 DO
30 INPUT"ENTER NUMBER "N
40 S=S+N
50 UNTIL N=0
60 PRINT"TOTAL IS"S'
70R.
80R.
90 I=0
100jI=I+1
110 PRINT I'
120 IF I<10 GOTOj
130R.
140 FOR I=0 TO 10
150 PRINT I'
160 NEXT I
170R.
180 INPUT"STEP SIZE "J
190 IF J=0 J=J+1
200 FOR I=0 TO 50 STEP J
210 PRINT I
220 NEXT I
230R.
240 FOR I=0 TO 10
250 FOR J=0 TO I*2
260 PRINT$172
270 NEXT J
280 PRINT '
290 NEXT I
300R.
310 I=0
320 DO I=I+1
330 PRINT I
340 UNTIL I=10
350R.
500B=256;G=T.-18;Q=T.-6;E=T.-36;C=T.-69;M=T.-81;X=T.-55
510?16=E;?17=E&#FFFF/256
520P.$12;GOS.d;P."LOOPS"';GOS.d;P.'
530T=T.;DOT=T-1;U.T?-1=CH"|"
540O=90;L=130;F=80;GOS.p;GOS.l;R=550;P.$X''
550;GOS.h;GOS.a;O=140;L=170;F=130;P.$G;GOS.l;GOS.s;GOS.a;P.$X'
560R=560;GOS.h;P.'$12;GOS.p;P.$G''"FOR I=0 TO 20 STEP 2"''
570GOS.s;GOS.p;O=180;L=230;F=170;GOS.l;P.$X'
580R=580;GOS.h;P.'$12;GOS.a;P.';GOS.s;GOS.p;O=240;L=300;F=230
590P.$G';GOS.l;P.$X';GOS.h;GOS.a;GOS.s;GOS.p;O=310;L=350;F=300
600GOS.l;P.$X';GOS.h;P.'$12;GOS.p;O=10;L=70;F=0;GOS.l;P.$X'
610R=610;GOS.h;GOS.a;GOS.s
900IN."DO YOU WANT TO REPEAT THIS"'"LESSON "$B;IF?B=89;G.500
910P.'"GOODBYE !"';END
1100dF.I=1TO32;P.$172;N.I;R.
1200wF.I=0TO10*W;WAIT;N.I;R.
1300pI=0;DOB?I=T?I;I=I+1;U.T?I=32ORT?I=13
1310B?I=13;IFT?I=13;T=T+2
1320IFC.+I>31;P.'
1330I=I+1;IF$B="^"G.q
1335P.$B" ";T=T+I;G.p
1340qT=T+I;W=10;GOS.w;P.';R.
1400aP.'$12;P."HERE IS THAT PROGRAM AGAIN"';GOS.l;GOS.p;R.
1500rA=CH">";LINK#CD0F;R.
1600x@=5;P.'"ERROR"?0';@=8
1610IF?0=29;P.'"YOU MUST TYPE A NUMBER IF ASKED"'
1620G.R
1700lN=#2800;@=5
1710DON=N+1;U.?N=13A.N?1=O/256A.N?2=O&#FF
1720DOP.'(N?1*256+N?2)-F;N=N+3;P.$N;N=N+L.N
1730U.N?1=L/256A.N?2=L&#FF;P.'(N?1*256+N?2)-F
1740P." END"'';@=8;R.
1800hGOS.r;I=-1;DO I=I+1;U.B?I<>32;P=B+I
1810IF?P=13;G.h
1840IF$P="RUN";GOS.O;G.h
1850IF$P=$Q;GOS.l;G.h
1855IF$P="C";R.
1860P."SORRY I AM ONLY DEALING WITH"'"SIMPLE VERSIONS OF LIST"
1861P." AND RUN"';G.h
2000s?#E1=0;P.$M;LINK#FFE3;P.'$12;R.
3100DO INPUT"ENTER NUMBER "N
5000|IT IS OFTEN USEFUL TO BE ABLE TO REPEAT SOME
5010STATEMENTS A FIXED NUMBER OF TIMES. THIS COULD BE DONE
5020WITH AN 'IF' AND A 'GOTO'. ^ ANOTHER WAY IS TO USE A
5025'FOR...NEXT' LOOP. ^
5030THE STATEMENTS BETWEEN 'FOR' AND 'NEXT' ARE REPEATED
5040FOR EACH VALUE OF I FROM 0 TO 10. ^
5050THE VARIABLE USED FOR COUNTING DOES NOT HAVE TO INCREASE
5055IN STEPS
5060OF ONE. YOU CAN SPECIFY THE STEP SIZE. ^ THIS PROGRAM
5070HAS A VARIABLE J THAT GIVES THE STEP SIZE. ^
5080LINE 20 MAKES SURE THAT THE STEP SIZE IS NOT ZERO.
5090IF IT WAS THE PROGRAM WOULD NEVER STOP. ^
5100YOU CAN HAVE A LOOP INSIDE ANOTHER LOOP. ^ THE LOOP BETWEEN
5110LINES 20 AND 40 PRINTS A LINE. THIS IS REPEATED 10 TIMES. ^
5120ATOM BASIC ALLOWS 'DO...UNTIL' LOOPS.
5130THIS PROGRAM DEMONSTRATES THEIR USE. ^
5140THIS PROGRAM WILL READ IN NUMBERS UNTIL YOU ENTER A ZERO.
5150IT WILL THEN PRINT THE TOTAL. ^ THE STATEMENTS BETWEEN 'DO'
5160AND 'UNTIL' ARE REPEATED UNTIL THE CONDITION AFTER 'UNTIL'
5170IS TRUE. ^
8070PRESS SPACE TO CONTINUE
8080TRY RUNNING THIS
8090?18=40;P.$7;G.x
9000LIKE THIS
9010LIST
