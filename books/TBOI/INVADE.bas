
0 REM THE BEST OF INTERFACE PAGE 14
10 REM INVADE BY I. SMITH
20 DIM VV(2),P(-1);L=#B002;PRINT $21;[
30:VV0 LDA L;LDY #81;:VV1 LDX #80;:VV2 DEX;BNE VV2;EOR @4
40 STA L;DEY;BNE VV1;RTS;];PRINT $6
50 ?#81=25;A=0;B=A+1;C=A+2;Z=#8000;E=0;F=-1;D=0;H=0;@=0;I=-1
60 PRINT $12"YOU ARE ABOVE AN ALIEN CASTLE INYOUR SHIP."'
70 PRINT"YOU HAVE 150 BOMBS TO DESTROY"'"THE WHOLE BUILDING."'
80 PRINT"EACH BOMB CAN DESTROY ONLY ONE"'"BRICK."'
90 PRINT"THE BOMBS FALL FROM THE MIDDLE"'"OF YOUR SHIP."'
100 PRINT"TO FIRE PRESS G."'"TO MOVE RIGHT PRESS 3."'
110 PRINT"TO MOVE LEFT PRESS Q."'"BE CAREFUL!! THE ENEMY AIMS"'
120 PRINT"MISSILES AT YOU WHICH YOU MUST"'"AVOID."''
130 PRINT"PRESS G TO START.";DO UNTIL ?#B001=247;PRINT $12''
140 CLEAR 0;Q=5;FOR T=Q TO 27;T?#81E0=#A0;NEXT T
150 FOR T=Q TO 27;T?#81C0=#A0;NEXT T
160 FOR T=Q TO 27;T?#81A0=#A0;NEXT T
170 FOR T=Q TO 27;T?#8180=#A0;NEXT T;FOR T=Q TO 27 STEP 3
180 T?#8160=#A0;S=T+1;S?#8160=#A0;N.T;C?Z=#FF;A?Z=#FF;B?Z=#CC
190 IF ?#B001=247 AND F=-1 THEN F=B+32;F?Z=42;E=E+1
200 IF ?#B001=239 THEN D=-1;C?Z=#20
210 IF ?#B001=253 THEN D=1;A?Z=#20
220 A=A+D;B=B+D;C=C+D;D=0;IF A<0 THEN A=0;B=1;C=2
230 IF C>30 THEN A=29;B=30;C=31
240 A?Z=#FF;B?Z=#CC;C?Z=#FF;IF I=-1 THEN I=B+480
250 J=I;I=I-32;IF I<=0 THEN J?Z=#20;I=-1;GOTO 300
260 IF I?Z=#FF OR I?Z=#CC THEN GOTO 380
270 IF I?Z=#A0 THEN GOTO 300
280 I?Z=33;IF J?Z=#A0 THEN GOTO 300
290 J?Z=#20
300 IF F<>-1 THEN F?Z=#20;F=F+32;GOTO a
310 GOTO 190
320a IF F?Z=#A0;F?Z=#20;F=-1;H=H+1;?#80=200;LINK VV0;GOTO 350
330 IF F>512 THEN F=-1;?#80=170;LINK VV0;GOTO 360
340 F?Z=42;GOTO 190
350 IF H=108;P."CASTLE DESTROYED WITH "E" BOMBS.";GOTO 430
360 IF E=150 THEN GOTO 420
370 GOTO 190
380 ?#80=250;FOR Y=0 TO 5;LINK VV0;FOR U=0 TO 10;WAIT;NEXT U
390 LINK VV0;FOR U=0 TO 5;WAIT;NEXT U;NEXT Y;A?Z=#20;B?Z=#20
400 C?Z=#20;J?Z=#20;PRINT"YOU HAVE BEEN SHOT DOWN."
410 FPRINT'"YOU HIT "(H/108)*100" % OF IT.";GOTO 430
420 PRINT"OUT OF AMMUNITION."
430 INPUT''"ANOTHER GAME (Y OR N) "$K
440 IF ?K=CH"Y" THEN PRINT $12;GOTO 50
450 PRINT $12'''''''"       THANK YOU A LOT"''';END