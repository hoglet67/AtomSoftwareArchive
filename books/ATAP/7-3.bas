    5 REM Powers of Two
   10 DIM AA(31)
   20 @=1; P=0
   30 AA(0)=1
   40 FOR J=1 TO 31
   50   AA(J)=0
   60 NEXT J
   70 DO J=31
   80   DO J=J-1; UNTIL AA(J)<>0
   85   PRINT'"2^" P "="
   90   FOR K=J TO 0 STEP -1
   94     PRINT AA(K)
   96   NEXT K
  110   C=0
  120   FOR J=0 TO 31
  130     A=AA(J)*2+C
  140     C=A/10
  150     AA(J)=A%10
  160   NEXT J
  170   P=P+1
  180 UNTIL AA(31)<>0
  190 END


