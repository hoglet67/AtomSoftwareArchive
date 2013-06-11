   10 REM Recursive Stars
   20 P=10; GOSUB p
   30 END

  100pREM Print P stars
  110 IF P=0 RETURN
  120 P=P-1
  130 GOSUB p; REM Print P-1 stars
  140 PRINT "*"
  150 RETURN
