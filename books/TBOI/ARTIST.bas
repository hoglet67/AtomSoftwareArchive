
0REM THE BEST OF INTERFACE PAGE 47
10 REM *ARTIST BY KEN NORTH*
20 GOSUB 370
30 PRINT $21;FOR Z=1 TO 2;P=#3400;GOSUB a;NEXT Z;PRINT $6
40 !#5A=#00600080;?#AF=#0D;!#AB=0;!#A8=0;!#80=0;?#A7=#0F
50 CLEAR 4
60 X=?#5A;Y=?#5C
70 PLOT ?#A7,?#5A,?#5C
80 IF ?#AE THEN GOSUB 160;?#AE=0
90 PLOT ?#AF,?#5A,?#5C
100 IF ?#AC THEN GOSUB 180;?#AC=0
110 IF ?#AA THEN CLEAR 4;?#AA=0;!#5A=#00600080
120 IF ?#A8 THEN MOVE ?#80,?#81;DRAW X,Y;?#A8=0
130 IF ?#AB THEN MOVE ?#80,?#81;PLOT 7,X,Y;?#AB=0
140 LINK #3400
150 GOTO 60
160 FOR Z=#8000 TO #97FF;N=?Z;WAIT;BPUT A,N;NEXT Z
170 FOR Z=1 TO 5;PRINT $7;WAIT;NEXT N;?#AE=0;RETURN
180 FOR Z=#8000 TO #97FF;N=BGET A;?Z=N;NEXT Z
190 FOR Z=1 TO 5;PRINT $7;WAIT;NEXT Z;?#AC=0;RETURN
200a [
210 LDA@#F2;STA#B000;LDA#B001;CMP@239;BNEP+4;INC#5C
220 LDA@#F5;STA#B000;LDA#B001;CMP@239;BNEP+4;DEC#5C
230 LDA@#F1;STA#B000;LDA#B001;CMP@251;BNEP+4;DEC#5A
240 LDA@#F9;STA#B000;LDA#B001;CMP@247;BNEP+4;INC#5A
250 LDA@#F3;STA#B000;LDA#B001;CMP@247;BNEP+6;LDA@1;STA#AE
260 LDA@#F8;STA#B000;LDA#B001;CMP@239;BNEP+10
270 LDA@13;STA#A7;LDA@15;STA#AF
280 LDA@#F2;STA#B000;LDA#B001;CMP@247;BNEP+6;LDA@1;STA#AC
290 LDA@#F1;STA#B000;LDA#B001;CMP@239;BNEP+10
300 LDA@15;STA#A7;LDA@13;STA#AF
310 LDA@#F4;STA#B000;LDA#B001;CMP@247;BNEP+6;LDA@1;STA#AA
320 LDA@#F1;STA#B000;LDA#B001;CMP@247;BNEP+10;LDA#5A;STA#80
330 LDA#5C;STA#81
340 LDA@#F0;STA#B000;LDA#B001;CMP@247;BNEP+6;LDA@1;STA#A8
350 LDA@#F3;STA#B000;LDA#B001;CMP@239;BNEP+6;LDA@1;STA#AB
360 RTS;];RETURN
370 PRINT $12
380 PRINT"         **************"'
390 PRINT"         *** artist ***"'
400 PRINT"         **************"''
410 PRINT"THIS PROGRAM ALLOWS YOU TO DRAW PICTURES IN MODE 4 "
420 PRINT"ON THE ATOM AND SAVE THEM ON TAPE."''"SAVING DATA:"'
430 PRINT'"THERE IS NO INDICATION OF SAVING. YOU START THE "
440 PRINT"RECORDER AND AFTER 2 SECONDS PRESS 'D'. WHEN FINISH"
450 PRINT"ED SAVING YOU GET 5 BLEEPS."'
460 PRINT"PRESS KEY TO CONTINUE";LINK #FFE3;PRINT $12
470 PRINT"LOADING DATA:"''
480 PRINT"TO LOAD A PICTURE, START THE TAPE RUNNING, WHEN YOU "
490 PRINT"HEAR THE HIGH TONE LEADER PRESS 'E'."'
500 PRINT"AGAIN THERE IS NO INDICATION, LOAD IS FINISHED WHEN "
510 PRINT"YOU GET 5 BLEEPS."'"THE PROGRAM STARTS IN PLOT-MODE."
520 PRINT''"PRESS KEY TO CONTINUE";LINK #FFE3;PRINT $12
530 PRINT"CONTROL KEYS:"''
540 PRINT"O - MOVE CURSOR UP"'"L - MOVE CURSOR DOWN"'
550 PRINT"< - MOVE CURSOR LEFT"'"> - MOVE CURSOR RIGHT"'
560 PRINT"P - PLOT MODE"'"I - INVERSE MODE"'
570 PRINT"F - FILE CURSOR POSITION"'"G - DRAW MODE"'
580 PRINT"N - INVERSE DRAW MODE"'"C - CLEAR SCREEN"'
590 PRINT"D - DATA SAVE MODE"'"E - ENTER DATA MODE"''
600 PRINT"PRESS KEY TO START";LINK #FFE3;PRINT $12;RETURN