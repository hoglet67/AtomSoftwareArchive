
0 REM THE BEST OF INTERFACE PAGE 31
10 REM TABLET-BY R HEARD & R HIENS
20 DIM P(-1);PRINT $21;[;JSR #FE71;STY #80;RTS;];PRINT $6
30 PRINT $12"     TABLET"''
40 PRINT"THIS PROGRAM CONVERTS THE ATOM"'"SCREEN TO THAT OF "
50 PRINT"AN"'"ETCHA-SKETCH."''
60 PRINT"KEY:  P - TO GO UP"'
70 PRINT"      L - TO GO LEFT"'
80 PRINT"      ; - TO GO RIGHT"'
90 PRINT"      . - TO GO DOWN"'
100 PRINT"TO MOVE DIAGONALLY PRESS O OR @ OR , OR /."'
110 PRINT"PRESS RETURN TO CONTINUE";LINK #FFE3;PRINT $12
120 PRINT"AT ANY TIME YOU CAN PRESS E TOBLANK THE"
130 PRINT" SCREEN TO START AGAIN."'"WHERE ON THE SCREEN DO "
140 PRINT"YOU WISH TO START:"''
150 INPUT"X CO-ORD. (0-256) "X,"Y CO-ORD. (0-192) "Y;CLEAR 4
160 MOVE X,Y;DO LINK TOP;UNTIL ?#80<>#FF
170 IF ?#80=37 THEN PRINT $12;GOTO 150
180 IF ?#80=48 THEN GOSUB a
190 IF ?#80=44 THEN GOSUB b
200 IF ?#80=27 THEN GOSUB c
210 IF ?#80=30 THEN GOSUB d
220 IF ?#80=47 THEN GOSUB e
230 IF ?#80=32 THEN GOSUB f
240 IF ?#80=28 THEN GOSUB h
250 IF ?#80=31 THEN GOSUB i
260 GOTO 160
270a Y=Y+2;PLOT 1,0,2;RETURN
280b X=X-2;PLOT 1,-2,0;RETURN
290c X=X+2;PLOT 1,2,0;RETURN
300d Y=Y-2;PLOT 1,0,-2;RETURN
310e X=X-1;Y=Y+1;PLOT 1,-1,1;RETURN
320f X=X+1;Y=Y+1;PLOT 1,1,1;RETURN
330h X=X-1;Y=Y-1;PLOT 1,-1,-1;RETURN
340i X=X+1;Y=Y-1;PLOT 1,1,-1;RETURN
