  1 REM .. FRACTIONS .. 
 10 DIM P(1),S(1),E(100)
 20 @=0;?16=E;?17=E/256;$E="PRINT ""WHAT?""';G.s"
 30 DO INPUT'"PROPER (P) OR IMPROPER (I)"$P
 40 UNTIL $P="P" OR $P="I"
 50sDO %E=9E-8
 70 PRINT"EVALUATE"; FINPUT %X; PRINT $320" = "
 80 $S="+";FIF%X<0 $S="-"
 90 %X=ABS%X;I=%X;%R=%X-I
 95 IF I<>0 THEN %E=%X*%E
100 FIF %R<=%E GOTO i
101 IF I=0 THEN %E=%E*%R
102 FIF ABS(%R-1)>%E GOTO r
104 I=I+1
110iIF $S="-"PRINT $S
112 PRINT I;UNTIL 0
120rIF $S="-" PRINT $S
130 IF I<>0 AND $P="P" PRINT I,$S; I=0; %X=%R
180 $E="PRINT ""IRRATIONAL""'; GOTO s"
190 K=1;L=1;M=0;J=I
200 DO %R=1/%R; I=%R
204 %R=%R-I
210 N=J; J=J*I+K; K=N
220 N=L; L=L*I+M; M=N
230 FUNTIL %E>=ABS(%X-J/L)
240 FIF ABS(J*L)*ABS(%X-J/L)/%X >0.0033 PRINT "IRRATIONAL"; UNTIL 0
250 PRINT J"/"L;UNTIL 0