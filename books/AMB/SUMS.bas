
10 REM SUMS TESTER
100 DIM B(8),I(-1);S=0;T=60
110 GOSUB a;!#80=-(T*60)
120 $B="GOTO 700";?16=B;?17=B/256
130 P.$12"YOU HAVE 10 QUESTIONS"'
140 @=0;P."TO ANSWER IN "T" SECONDS"''
200 FOR Q=1 TO 10;P."QUESTION "Q" IS ;"''
300 GOSUB (1000+ABSRND%4*100)
400 INPUT $I;IF $I="" P.$7;GOTO 400
410 Z=0
420 FOR P=0 TO LEN(I)-1
430 IF I?P<CH"0" OR I?P>CH"9" P.$7;GOTO 400
440 Z=I?P-CH"0"+10*Z
450 NEXT P
500 IF Z=R P.'"THAT'S RIGHT !";S=S+1;GOTO 520
510 P.'"SORRY, BUT IT WOULD BE "R
520 FOR A=1 TO 60;WAIT;NEXT
530 P.$12;@=0
540 NEXT Q
600 P."YOUR SCORE WAS"'S" OUT OF 10"''
610 E=T+(!#80)/60;P."IN "E" SECONDS"''
620 IF S>8 P."CONGRATULATIONS ARE DUE"'
630 IF S*T/E>10 P."WELL DONE"'
640 ?#20A=?#A0;?#20B=?#A1;END
700 P.&7$12;@=0;P."* NO MORE TIME *"'
710 !#80=0;GOTO 600
1000 X=2+ABSRND%98;Y=2+ABSRND%98
1010 R=X+Y;P."WHAT IS "X" + "Y" ";RETURN
1100 X=2+ABSRND%98;Y=2+ABSRND%98
1110 IF Y+2>X GOTO 1100
1120 R=X-Y;P."WHAT IS "X" - "Y" ";RETURN
1200 X=2+ABSRND%11;X=2+ABSRND%11
1210 R=X*Y;P."WHAT IS "X" TIMES "Y" ";RETURN
1300 X=2+ABSRND%11;R=2+ABSRND%11
1310 Y=X*R;P."WHAT IS "Y" DEVIDED BY "X" ";RETURN
9000a P.$21;P=#84
9010[ PHP;CLD;STX #E4;STY #E5
9020 BIT #B002;BVC #94;JSR #21C;BCC #8A
9030 JSR #FB8A;JSR #21C;BCS #97;JMP #FEA7;]
9040 P=#21C
9050[ JSR #FE66;INC #80;BNE #228
9060 INC #81;BNE #228;BRK;JMP #FE71;]
9070 ?#A0=?#20A;?#A1=?#20B
9080 ?#20A=#84;?#20B=0;P.$6;RETURN
