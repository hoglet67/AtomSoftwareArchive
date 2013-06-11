    1 REM Cycloid
   10 %Z=60
   20 CLEAR2
   30 FORQ=0TO359
   40 %S=RAD Q
   50 %R=%Z*SIN(%S*2)
   60 PLOT13,%(%R*SIN%S+64.5),%(%R*COS%S+48.5)
   70 NEXT
   80 END
