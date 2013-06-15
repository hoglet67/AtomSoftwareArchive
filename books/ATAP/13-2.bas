   10 DIM P(-1)
   20[
   30 LDA #80 low byte of one number
   40 CLC
   50 ADC #82 low byte of other number
   60 STA #84 low byte of result
   70 LDA #81 high byte of one number
   80 ADC #83 high byte of other number
   90 STA #85 high byte of result
  100 RTS
  110]
  120 END

