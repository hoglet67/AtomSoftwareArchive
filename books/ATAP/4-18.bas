    1 REM Cubic Curve
   10 CLEAR 0
   20 MOVE 0,24; DRAW 63,24
   30 MOVE 32,0; DRAW 32,47
   40 MOVE -1,-1
   50 X=-33
   55 Y=(X*X*X-600*X)/400
   60 DRAW (32+X),(24+Y)
   70 X=X+1
   80 IF X<33 THEN GOTO 55
   90 END


