
0 REM THE BEST OF INTERFACE PAGE 11-12
10 REM FRUIT MACHINE BY I. SMITH
20 GOSUB 750
30 @=0;T=50;B=0;Q=0;R=0;L=0;DIM AA(12);FOR Z=1 TO 12;DIM A(1)
40 AA(Z)=A;NEXT Z;DIM BB(3);FOR Z=1 TO 3;DIM A(1);BB(Z)=A
50 $BB(Z)=" ";N.Z;$AA(1)="*";$AA(2)="|";$AA(3)="<";$AA(4)="{"
60 $AA(5)="/";$AA(6)="\";$AA(7)="#";$AA(8)="}";$AA(9)="$"
70 $AA(10)="^";$AA(11)=")";$AA(12)="o";PRINT $21
80 DIM VV(2),LL(0),P(-1);J=#B002;[
90:LL0 JSR #FFE6;STA #80;RTS;];[;:VV0 LDA J;BNE VV1;LDY #81
100:VV1 LDX #80;;:VV2 DEX;BNE VV2;EOR @4;STA J;DEY;BNE VV1;RTS
110];PRINT $6;?#81=30;PRINT $12''';CLEAR 0;FOR Z=0 TO 12
120 PRINT" ";NEXT Z;PRINT"COMBINATON  SCORES"
130 GOSUB y;PRINT" $ $ $     100"'
140 GOSUB y;PRINT"| | |      80"'
150 GOSUB y;PRINT"* * *      70"'
160 GOSUB y;PRINT") ) )      60"'
170 GOSUB y;PRINT"\ \ \      50"'
180 GOSUB y;PRINT"  \ \      40"'
190 GOSUB y;PRINT"# # #      30"'
200 GOSUB y;PRINT"  # #      25"'
210 GOSUB y;PRINT"  } }      20"'
220 GOSUB y;PRINT"    }      15"'
230 GOSUB y;PRINT"    /      10"'
240 F=ABSRND%12+1;G=ABSRND%12+1;H=ABSRND%12+1
250 $BB(1)=$AA(F);$BB(2)=$AA(G);$BB(3)=$AA(H)
260 PRINT $30"       fruit machine"''"PAY OUT : "T
270 PRINT'''"  1   2   3"''"  "
280 PRINT $BB(1)"   "$BB(2)"   "$BB(3)''';?#E1=0
290 PRINT"PAY 10 P."'"PRESS SHIFT"'"TO START."'
300 DO UNTIL ?#B001=127
305IFT<10;T=0
306IFT>=10;T=T-10
310 PRINT $11$11$11"          "'"            "'"         "
320 PRINT $30''"PAY OUT :     "$8$8$8$8,T''''''
330 C=ABSRND%100+20;D=ABSRND%100+20;E=ABSRND%100+20
340 IF C>=D AND C>=E;Y=C;GOTO 370
350 IF D>=E;Y=D;GOTO 370
360 Y=E
370 FOR O=0 TO Y;B=B+1;GOSUB a;Q=Q+1;GOSUB b;R=R+1;GOSUB c
380 $BB(1)=$AA(F);$BB(2)=$AA(G);$BB(3)=$AA(H)
390 PRINT $11"  "$BB(1)"   "$BB(2)"   "$BB(3)';NEXT O
400 L=L+1;IF L=3 THEN GOTO z
410 PRINT''"HOLD 1 ";LINK LL0;IF ?#80=#59;C=1;B=0;GOTO 430
420 C=ABSRND%100+10;B=0
430 PRINT'"HOLD 2 ";LINK LL0;IF ?#80=#59;D=1;Q=0;GOTO 450
440 D=ABSRND%100+10;Q=0
450 PRINT'"HOLD 3 ";LINK LL0;IF ?#80=#59;E=1;R=0;GOTO 470
460 E=ABSRND%100+10;R=0
470 PRINT'$11$11$11"         "'"         "'"         "'
480 IF C=1 AND D=1 AND E=1;PRINT $11$11$11;GOTO z
490 PRINT $11$11$11$11$11;GOTO340
500aIF B>=C THEN RETURN
510 F=F+1;IF F>12 THEN F=1
520 ?#80=50;LINK VV0;RETURN
530bIF Q>=D THEN RETURN
540 G=G+1;IF G>12 THEN G=1
550 ?#80=70;LINK VV0;RETURN
560cIF R>=E THEN RETURN
570 H=H+1;IF H>12 THEN H=1
580 ?#80=90;LINK VV0;RETURN
590z L=0;B=0;Q=0;R=0
600 IF $BB1="$"A.$BB2="$"A.$BB3="$";T=T+100;G.720
610 IF $BB1="|"A.$BB2="|"A.$BB3="|";T=T+80;G.720
620 IF $BB1="*"A.$BB2="*"A.$BB3="*";T=T+70;G.720
630 IF $BB1=")"A.$BB2=")"A.$BB3=")";T=T+60;G.720
640 IF $BB1="\"A.$BB2="\"A.$BB3="\";T=T+50;G.720
650 IF $BB2="\"A.$BB3="\";T=T+40;G.720
660 IF $BB1="#"A.$BB2="#"A.$BB3="#";T=T+30;G.720
670 IF $BB2="#"A.$BB3="#";T=T+25;G.720
680 IF $BB2="}"A.$BB3="}";T=T+20;G.720
690 IF $BB3="}";T=T+15;G.720
700 IF $BB3="/";T=T+10;G.720
710 ?#80=250;LINK VV0;LINK VV0;GOTO 260
720 FOR Z=0 TO 10;?#80=130;LINK VV0;FOR M=0 TO 3;WAIT;NEXT M
730 NEXT Z;GOTO 260
740y FOR Z=0 TO 16;PRINT" ";NEXT Z;RETURN
750 PRINT $12
760 PRINT"      ********************"'
770 PRINT"      *** FRUITMACHINE ***"'
780 PRINT"      ********************"''
790 PRINT"ON THE QUESTION : HOLD 1,2,3 JUST TYPE Y OR N, DEPEN"
800 PRINT"DING ON WHETHER YOU WANT TO HOLD OR NOT."'
810 PRINT"FOR THE REST FOLLOW THE INSTRUCTIONS, GIVEN BY THE "
820 PRINT"PROGRAM."''"PRESS ANY KEY TO START";LINK #FFE3;RETURN
