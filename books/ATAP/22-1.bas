    1 REM Sine and Tangent
    5 PRINT $30 ; CLEAR 0
    7 PRINT"PLOT OF SIN AND TAN FUNCTIONS"
    9 %I=2*PI/64
   10 %V=0
   12 FOR Z=0 TO 64
   15 %V=%V+%I
   20 PLOT13,Z,(22+%(22*SIN%V))
   25 PLOT13,Z,(22+TAN%V)
   30 NEXT
  100 END
