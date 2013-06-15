   10 REM Random Noise
   20 DIM L(2),NN(1),P(-1)
   30 C=#B002
   40[
   50:NN0 LDA L; STA C
   60 AND @#48; ADC @#38
   70 ASL A; ASL A
   80 ROL L+2; ROL L+1; ROL L
   90 JMP NN0
  100]
  110 LINK NN0

