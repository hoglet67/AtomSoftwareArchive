  1 REM ..ROTATION..
 10 CLEAR4
 20 A=128;B=A*A;C=96
 30 FOR X=0 TO A
 40 S=X*X; %P=SQR(B-S); %I=-%P
 60 DO %R=SQR(S+%I*%I)/A
 80 %Q=(%R-1)*SIN(24*%R)
 90 %Y=%I/3+%Q*C
 95 FIF %I=-%P %M=%Y;GOTOb
100 FIF %Y>%M %M=%Y;GOTOa
105 FIF %Y>=%N GOTOc
110b%N=%Y
115a%Y=C+%Y
120 PLOT13,(A-X),%Y; PLOT13,(A+X),%Y
135c%I=%I+4; FUNTIL %I>=%P
145 NEXT X
150 END
