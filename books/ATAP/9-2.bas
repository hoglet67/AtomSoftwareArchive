   10 DIM VV(20)
   20 A=FIN""; N=BGET A
   30 FOR M=0 TO N
   40 VV(M)= GET A
   50 NEXT M
   60 REM X=Maximum, Y=Minimum
   70 X=VV(0); Y=VV(0)
   80 FOR M=1 TO N
   90 IF X<VV(M) THEN X=VV(M)
  100 IF Y>VV(M) THEN Y=VV(M)
  110 NEXT M
  120 S=(X-Y+63)/64
  130 REM Plot Histogram
  135 CLEAR 0
  140 FOR M=0 TO N
  150 MOVE 0,M
  160 DRAW ((VV(M)-Y)/S),M
  170 NEXT M
  180 GOTO 180

