   10 DIM BB(3),P(-1)
   20 W=#FFF4
   30[
   40:BB0 LDA #80
   50 BEQ BB1 if zero go to BB1
   60 LDA @#2A star
   70 JSR W print it
   80 RTS return
   90:BB1 LDA @#21 exclamation mark
  100 JSR W print it
  110 RTS return
  120]
  130 END

