   10 REM Chequebook-Balancing Program
   20 PRINT "ENTER CREDITS"'
   30 GOSUB 2000
   40 C=D
   50 PRINT "ENTER DEBITS"'
   60 GOSUB 2000
   70 PRINT "TOTAL IS "
   80 GOSUB 3000
   90 END

 2000 REM Sum Debits in D
 2010 REM Changes D,J
 2020 D=0
 2030 DO INPUT J; D=D+J
 2040 UNTIL J=0
 2050 RETURN

 3000 REM Print Total in T
 3010 REM Changes T; Uses C,D
 3020 T=C-D; @=5
 3030 PRINT T/100," POUNDS",T%100," PENCE"
 3040 RETURN


