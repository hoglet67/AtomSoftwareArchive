
 10 REM HEXPAWN
 20 DIM A(8),S(200),I(10);C=1;H=2
 30 FOR L=0 TO 200;S?L=0;NEXT L
100 FOR R=1 TO 54321;P.$12;?#E1=0
110 A?0=C;A?1=0;A?2=H;A?3=C;A?4=0;A?5=H;A?6=C;A?7=0;A?8=H
120 P."        C C C      1 4 7"''
130 P."        * * *      2 5 8"''
140 P."        H H H      3 6 9"''''
200 REM YOUR MOVE
210 T=H;FOR M=10 TO 87
220 IF M%10<9 GOSUB b;IF E=0 GOTO 240
230 NEXT M;GOTO 800
240 GOSUB a;INPUT"YOUR MOVE (FROM TO) "$I
250 IF ?I<CH"1" OR ?I>CH"9" GOTO 240
260 IF I?1<CH"1" OR I?1>CH"9" GOTO 240
270 M=(?I-CH"1")*10+I?1-CH"1"
280 GOSUB b;IF E>0 GOTO 240
290 GOSUB c
300 REM COMPUTERS MOVE; FIRST LOOK THROUGH S()
310 GOSUB a;T=C;U=0;P."MY MOVE ..."'
320 X=A?0+4*(A?1)+16*(A?2)+64
330 Y=A?3+4*(A?4)+16*(A?5)+64
340 Z=A?6+4*(A?7)+16*(A?8)+64
350 V=S
355e IF ?V>128 GOTO f
360 IF ?V=0 GOTO 400
370 IF ?V=X IF V?1=Y IF V?2=Z GOTO 500
380 IF ?V=Z IF V?1=Y IF V?2=X U=1;GOTO 500
385 V=V+2
390f IF V<S+200 V=V+1;GOTO e
395 P.'''"S() TOO SMALL";END
400 REM ADD NEW ENTRY TO S()
410 ?V=X;V?1=Y;V?2=Z;W=V+3;?W=0
420 FOR M=1 TO 78;IF M%10<9 GOSUB b
430 IF E=0 W?0=M+128;W?1=0;W=W+1
440 NEXT M
500 REM SELECT MOVE IF POSSIBLE
510 V=V+3;IF ?V<128 GOTO 700
520 M=?V-128; IF U=0 GOTO 600
530 IF M/10<3 M=M+60
540 IF M/10>5 M=M-60
550 IF M%10<3 M=M+6
560 IF M%10>5 M=M-6
600 REM DO COMPUTER'S MOVE
610 GOSUB c;L=V;GOTO 200
700 REM DELETE LOSING MOVE & QUIT
710 FOR V=L TO S+199;?V=V?1;NEXT V
720 P.'"OK - YOU WIN"'';GOTO 900
800 P."YOU CAN'T MOVE - I WIN"''
900 INPUT"ANOTHER GAME "$I;IF ?I=CH"N" THEN ?#E1=#80;END
910 NEXT R
1000a REM CLEAR LINE
1010 P.$11"                                "$11;RETURN
2000 REM CHECK MOVE, E=0 IF OK
2010b E=1;F=M/10;G=M%10;IF A?F<>T OR A?G=T RETURN
2020 IF A?G>0 GOTO g
2030 IF G=F-2*T+3 IF G/3=F/3 E=0
2040 RETURN
2050g IF G-F=4*T-6 IF G/3<>F/3 E=0;RETURN
2060 IF G-F=12-8*T IF F<>2 IF F<>6 E=0
2070 RETURN
3000 REM MOVE PIECE
3010c P=M/10;GOSUB d;?P=#2A
3020 P=M%10;GOSUB d;?P=5*T-2
3030 A?(M/10)=0;A?(M%10)=T;RETURN
3100d P=#8008+P/3*2+P%3*64
3110 ?P=?P+#80
3120 FOR K=1 TO 30;WAIT;NEXT K;RETURN
