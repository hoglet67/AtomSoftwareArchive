
10 FDIM %NN(100);X=0;%T=0
20 FOR N=1 TO 100;%NN(N)=0;NEXT
30bFINPUT"NUMBER - 0 TO END"%A
40 FIF%A=0 THEN G.a
50 X=X+1;%T=%T+%A;%NN(X)=%A
60 G.b
70a%M=%T/X
80 FPRINT"AVERAGE=",%M'
90 %T=0
100 FOR N=1 TO X
110 %NN(N)=%NN(N)-%M
120 %T=%T+%NN(N)*%NN(N)
130 NEXT
140 %T=%T/X
150 %S=SQR%T
160 FPRINT"STANDARD DEVIATION=",%S'
200 END
