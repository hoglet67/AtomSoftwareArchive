    1 REM Invert String
    5 DIM Q(64)
   10 INPUT $Q
   20 FOR N=0 TO LEN(Q)-1
   30 Q?N=Q?N | #20
   40 NEXT N
   50 PRINT $Q
   60 RUN

