    1 REM Linear Interpolation
    5 S=1000; @=0; I=1
   10 INPUT "X1",A,"X2",B
   20 A=A*S; B=B*S
   30 X=A; GOSUB y; C=Y
   40 X=B; GOSUB y; D=Y
   50 IF C*D<0 GOTO 80
   60 PRINT "ROOT NOT BRACKETED"
   70 END
   80 DO I=I+1
   90 X=B-(B-A)*D/(D-C); GOSUB y
  100 IF C*Y<0 THEN A=X; C=Y; GOTO 120
  110 B=X; D=Y
  120 UNTIL ABS(A-B)<2 OR ABS(Y)<2
  130 PRINT"ROOT IS X="
  140 IF X<0 PRINT "-"
  145 PRINT ABS(X)/S,"."
  150 DO X=ABS(X)%S; S=S/10
  155 PRINT X/S; UNTIL S=1
  160 PRINT'"NEEDED ",I," ITERATIONS."'
  170 END
  200yY=X*X/S-X-1*S
  210 RETURN

