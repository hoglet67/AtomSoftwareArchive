    1 REM Conditional Assembly
   10 DIM P(-1)
   20 H=#B800; D=#80
  300[ LDA D;]
  310 IF V=2 [ EOR #FF invert;]
  320[ STA H to port
  330 LDA @#80
  340 STA H+1
  360 NOP strobe delay;]
  370 IF V=1 [ NOP; NOP extra delay;]
  380[ LDA @0
  390 STA H+1
  400]
  410 END

