 10 REM SCRAMBLE
100 REM SET UP BOARD
110 DIM DD(3),A(-1)
120 DD(0)=-32;DD(1)=-1;DD(2)=1;DD(3)=32
130 P.$12;X=#800D
140 FOR I=1 TO 24;?X=I;X=X+1
150 IF I%5=0 X=X+27
160 NEXT;?X=#20
200 REM INSTRUCTIONS
210 FOR I=1 TO 6;P.$10;NEXT
220 P."THIS PATTERN WILL BE SCRAMBLED."'
230 P."YOU HAVE TO PUT IT BACK IN ORDER"
240 P."BY MOVING ONE LETTER AT A TIME"'
250 P."INTO A BLANK SQUARE."'
260 P."YOU CAN ONLY MOVE A LETTER WHICH"
270 P."IS VERTICALLY OR HORIZONTALLY"'
280 P."NEXT TO THE BLANK SQUARE."''
300 REM SCRAMBLE BOARD
310 INPUT"DIFFICULTY (1-9) "D
320 GOSUB a;P=0
330 FOR R=1 TO D*5
340 DO J=X+DD(ABSRND%4)
350 UNTIL ?J<25 AND J<>P
360 WAIT;?X=?J;?J=#20;P=X;X=J
370 NEXT R
400 REM GET MOVE
410 FOR M=1 TO 9999
420 DO P.$11"WHICH LETTER WILL YOU MOVE    "$8$8
430 INPUT $A;B=?A-#40;P=0
440 FOR I=0 TO 3;IF X?DD(I)=B P=X+DD(I)
450 NEXT
460 UNTIL P>0 AND B>0 AND B<26
470 ?P=?P+#80
475 FOR I=1 TO 30;WAIT;NEXT
480 ?P=#20;?X=B+#80
485 FOR I=1 TO 30;WAIT;NEXT
490 ?X=B;X=P
500 REM GAME OVER ?
510 B=#800C
520 FOR I=1 TO 24;IF B?I<>I GOTO 600
530 IF I%5=0 B=B+27
540 NEXT I
550 GOSUB a;@=0
560 P."AT LAST; YOU MADE IT"'
570 P."IN "M" MOVES"'
580 END
600 NEXT M
900a REM CLEAR BOTTOM OF SCREEN
905 P.$30;B=#20202020
920 FOR I=#80A0 TO #81FC STEP 4;!I=B;NEXT
930 FOR I=1 TO 7;P.$10;NEXT;RETURN