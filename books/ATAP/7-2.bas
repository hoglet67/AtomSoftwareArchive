    1 REM Sorting
    5 DIM AA(20)
   10 FOR N=1 TO 20; INPUT J
   20 AA(N)=J; NEXT N
   30 N=20; GOSUB s
   40 FOR N=1 TO 20; PRINT AA(N)'
   50 NEXT N
   60 END
  100sM=N
  110 DO M=(M+2)/3
  120   FOR I=M+1 TO N
  130     FOR J=I TO M+1 STEP -M
  140       IF AA(J)>=AA(J-M) GOTO b
  150       T=AA(J); AA(J)=AA(J-M); AA(J-M)=T
  160     NEXT J
  170b  NEXT I
  180 UNTIL M=1; RETURN


