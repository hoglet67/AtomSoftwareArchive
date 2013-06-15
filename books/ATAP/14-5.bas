   10 DIM LL(2),P(-1)
   20 W=#FFF4
   30[
   40:LL0 LDX @#41 start at A
   50:LL1 TXA put it in A
   60 JSR W print it
   70 INX next one
   80 CPX @#5B done Z?
   90 BNE LL1 if so - continue
  100 RTS else - return
  110]
 120 END

