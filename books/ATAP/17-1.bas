   10 REM Replace
   20 DIM LL(4),R(20),S(20),T(20)
   40 FOR N=1 TO 2; DIM P(-1)
   50[
   60:LL0 LDX @0
   70:LL1 LDY @0; LDA R,X
   80 CMP @#D; BNE LL3; RTS finished
   90:LL2 INY
  100:LL3 LDA S,Y
  110 CMP @#D; BEQ LL4
  120 CMP R,X; BNE LL2
  130 LDA T,Y; STA R,X replace char
  140:LL4 INX; JMP LL1 next char
  150]
  160 NEXT N
  200 END


