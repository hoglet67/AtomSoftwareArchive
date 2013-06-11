    1 REM Print Inverted String
   10 DIM LL(2),S(64),P(-1)
   20 W=#FFF4
   30[
   40:LL0 LDX @0
   50:LL1 LDA S,X
   60 CMP @#D
   70 BEQ LL2
   80 ORA @#20
   90 JSR W
  100 INX
  110 BNE LL1
  120:LL2 RTS
  130]
  140 END


