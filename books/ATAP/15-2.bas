    5 REM Bleep
   10 DIM VV(4),P(-1)
   20 L=#B002
   30[ 
   40:VV0 LDA L
   45 LDY #81
   50:VV1 LDX #80
   60:VV2 DEX
   70 BNE VV2
   80 EOR @4
   90 STA L
   95 DEY
  100 BNE VV1
  105 RTS
  110]
  120 END
