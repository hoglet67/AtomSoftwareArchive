
 1 REM BOUNCING BALL
10 CLEAR 0;X=1;Y=24;H=-1;V=1
20 MOVE 0,0
30 PLOT 1,63,0;PLOT 1,0,47
40 PLOT 1,-63,0;PLOT 1,0,-47
50aWAIT;IF X=1 OR X=62 WAIT;H=-H
60 WAIT;IF Y=1 OR Y=46 WAIT;V=-V
70 WAIT;PLOT 15,X,Y
80 WAIT;X=X+H;Y=Y+V
90 WAIT;PLOT 13,X,Y;GOTO a
