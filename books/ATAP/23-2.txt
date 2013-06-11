
   10 REM Two-Pass Assembly
   20 DIM M(3),JJ(2)
   30 FOR N=1 TO 2
   40 PRINT '"PASS "N
   50 DIM P(-1)
   55[
   60:JJ0 INC M
   70 BNE JJ1
   80 INC M+1
   90:JJ1 RTS
  100]
  110 NEXT N
  120 INPUT L
  130 !M=L
  140 LINK JJ0
  150 P. &!M
  160 END

