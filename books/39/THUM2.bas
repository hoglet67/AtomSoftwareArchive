
0 REM THE BEST OF INTERFACE PAGE 24
10 REM HUMBLE STRUMMER BY AMALIA BRIDGE
20 GOSUB 210
30 PRINT $12,$21;Y=RND
40 DIM VV(4),P(-1);L=#B002
50[;:VV0 LDA L;LDY #81;:VV1 LDX #80;:VV2 DEX;BNE VV2
60 EOR @4;STA L;DEY;BNE VV1;RTS;]
70 PRINT $6;?#E1=0;@=0
80 A=ABSRND%10+1;C=ABSRND%10+1
90 FOR J=1 TO 10;PRINT"THIS IS GUESS "J'
100 INPUT"WHERE AM I HIDING"D,E
110 FOR Z=1 TO 10;?#80=ABS(A-D)*5;LINK VV0;NEXT Z
120 FOR Z=1 TO 10;?#80=ABS(C-E)*5;LINK VV0 ;NEXT Z
130 IF (A=D)&(C=E) THEN GOTO 160
140 NEXT J
150 GOTO 170
160 PRINT"YES, YOU GUESSED IT"'
170 PRINT"I WAS HIDING AT "A,C'
180 PRINT"ENTER Y FOR ANOTHER GO"'
190 INPUT C;IF C=Y;GOTO 80
200 ?#E1=128;END
210 PRINT $12
220 PRINT"    ************************"'
230 PRINT"    *** THUMBLE STRUMMER ***"'
240 PRINT"    ************************"''
250 PRINT"THE COMPUTER THINKS OF A PLACE IN A GRID OF 10 X 10"
260 PRINT" AND RESPONDS TO YOUR GUESS BY SOUNDING A MUSICAL "
270 PRINT"NOTE. THE HIGHER THE PITCH THE CLOSER TO THE CORREC"
280 PRINT"T PLACE YOU ARE."''"PRESS ANY KEY TO START"
290 LINK #FFE3;RETURN
