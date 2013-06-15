   10 REM Read Text
   20 DIM A(40); L=CH"t"
   25 GOSUB f
   30 FOR J=1 TO 20; GOSUB r
   40 FPRINT VAL A
   50 NEXT J
   60 END
  500fREM point Q to text
  510 Q=?18*256
  520 DO Q=Q+1
  530 UNTIL ?Q=#D AND Q?3=L
  540 Q=Q+4; RETURN
  550*
  600rREM read next entry into A
  605 REM changes: A,Q,R
  610 R=-1
  620 DO R=R+1; A?R=Q?R
  630 UNTIL A?R=CH"," OR A?R=#D
  640 IF A?R=#D Q=Q+3
  650 Q=Q+R+1; A?R=#D; RETURN
  660*
  800t1,2,3,4,1E30,27,66
  810 91,1.2,1.3,1.4,1.5
  820 13,14,15,16,17
  830 18,19,20
