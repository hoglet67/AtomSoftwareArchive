    1 REM Fractional Multiplication
    5 J=#80; DIM P(-1)
   10 C=#AA
   20 GOSUBm
   30 [STA J;RTS;]
   40 INPUT A
   50 LINK TOP
   60 P.&A,&?J
   70 END
 2000mREM macro - multiply by constant
 2010 REM A = A * C/256
 2020 REM uses J
 2030 B=#80
 2040 [STA J;LDA @0;]
 2050 DO [LSR J;]
 2060 IF C&B<>0 [CLC;ADC J;]
 2070 C=(C*2)&#FF; UNTIL C=0
 2080 RETURN
