   10 REM Roman Numerals
   20 DIM LL(4),Q(50)
   30 DIM R(20),S(20),T(20)
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
  200 $S="IVXLCDM"; $T="XLCDM??"
  210 $Q=""; $Q+5="I"; $Q+10="II"
  220 $Q+15="III"; $Q+20="IV"; $Q+25="V"
  230 $Q+30="VI"; $Q+35="VII"
  240 $Q+40="VIII"; $Q+45="IX"
  250 DO $R="";D=10000
  255 INPUT A
  260 DO LINK LL0
  270 $R+LEN(R)=$(Q+A/D*5)
  280 A=A%D; D=D/10; UNTIL D=0
  290 PRINT $R; UNTIL 0
