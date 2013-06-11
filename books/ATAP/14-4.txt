   10 DIM LL(2),P(-1)
   20 W=#FFF4
   30[
   40:LL0 LDX @0 start at zero
   50:LL1 LDA @#2A code for star
   60 JSR W output it
   70 INX next X
   80 CPX @8 all done?
   90 BNE LL1
  100 RTS return
  110]
  120 END

