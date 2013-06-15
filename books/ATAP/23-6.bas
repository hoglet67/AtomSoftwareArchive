   10 REM Print Hex Digits
   20 DIM GG(3),P(-1)
   30 IF D=0 GOTO m
   50[
   55 \ print hex digit
   60:GG1 AND @#F
   70 CMP @#A; BCC P+4
   80 ADC @6; ADC @#30
   90 JMP #FFF4
   95 \ print A in hex
  100:GG2 PHA; PHA; LSRA; LSRA
  110 LSRA; LSRA; JSR GG1
  120 PLA; JSR GG1; PLA; RTS
  130]
  140mREM main program
  150[
  170:GG0 CLC; ADC @#40;]
  190 IF D [ JSR GG2;]
  200[
  210 BEQ GG3; SBC @#10;]
  220 IF D [ JSR GG2;]
  230[
  240:GG3 RTS;]
  250 END

