    1 REM Greatest Common Divisor
   80 INPUT A,B
   90 DO A=A%B
  100 IFABS(B)>ABS(A) THEN T=B; B=A; A=T
  120 UNTIL B=0
  130 PRINT "GCD =" A '
  140 END


