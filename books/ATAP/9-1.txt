    1 REM Data to Cassette
   10 DIM VV(20)
   20 N=0
   30 DO INPUT J
   40 VV(N)=J; N=N+1
   50 UNTIL J=0 OR N>20
   60 A=FOUT""
   70 BPUT A,(N-1)
   80 FOR M=0 TO N-1
   90 PUT A,VV(M)
  100 NEXT M
  110 END

