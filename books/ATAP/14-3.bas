   10 DIM LL(4),P(-1)
   20 W=#FFF4
   30[
   40:LL0 LDX @8 initialise X
   50:LL1 LDA @#2A code for star
   60:LL2 JSR W output it
   70 DEX count it
   80 BNE LL2 all done?
   90 RTS
  100]
  110 END

