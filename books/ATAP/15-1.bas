   10 DIM VV(4),P(-1)
   20 L=#B002
   30[
   40:VV0 LDA L
   50:VV1 LDX #80
   60:VV2 DEX
   70 BNE VV2
   80 EOR @4
   90 STA L
 100 JMP VV1
 110]
 120 END