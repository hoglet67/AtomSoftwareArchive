 10 INPUT "DEGREE"N
 15 T=TOP;DO T=T-1; UNTIL ?T=CH"e"
 20 T=T+3;INPUT "SIMPLIFY"$T
 25 T=T+LENT;$T=";R.";T?4=#FF
 30 DIM T(64),XX(N);@=0
 40 FOR X=0 TO N; GOSUB e; XX(X)=Y; NEXT
 50 FOR C=1 TO N
 60 FOR J=N TO C STEP -1
 70 XX(J)=(XX(J)-XX(J-1))/C 
 80 NEXT J;NEXT C
 90 FOR C=N-1 TO 0 STEP -1
100 FOR J=C TO N-1
110 XX(J)=XX(J)-XX(J+1)*C
120 NEXT J;NEXT C
125 S=0
130 FOR C=N TO 0 STEP -1;IF XX(C)=0 GOTO z
135 IF XX(C)<0 PRINT " - "; GOTO s
137 IF S PRINT " + "
140sIF ABS XX(C)>1 OR C=0 PRINT ABS XX(C)
145 IF C>1 PRINT "X^" C
148 IF C=1 PRINT "X"
150 S=1
155zNEXT C;PRINT ''
170 END
200eY=X;RETURN