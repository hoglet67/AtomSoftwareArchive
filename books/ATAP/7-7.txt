   10 A=TOP; B=A+40
   90 P=A; GOSUB p; REM Output A
   94 P=B; GOSUB p; REM Output B
   98 END

  100pREM Print 10 Elements of array P
  105 @=8; PRINT '
  110 FOR J=0 TO 39 STEP 4
  120   PRINT P!J
  130 NEXT J
  140 PRINT '
  150 RETURN


