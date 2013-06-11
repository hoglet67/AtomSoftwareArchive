    1 REM Curve Stitching in a Square
   10 V=46
   20 INPUT Q
   30 CLEAR 0
   40 FOR Z=0 TO V STEP Q; Y=V-Z
   50   MOVE 0,Z; DRAW Y,0
   60   MOVE Y,V; DRAW V,Z
   70 NEXT Z
   80 END
