
0REM /// DESIGN /// V3
10 J=#80;Q=TOP;!Q=#85FFE320;Q!4=#6080;B=#2800
25 DOCLEAR1
30MOVE7,7;DRAW16,7;DRAW16,16;DRAW7,16;DRAW7,7
40 T=#8301;PLOT13,8,8
50 DO LINKQ;X=0;Y=0
55 IF?J=CH"^"GOS.p;LINKQ;F.N=0TO7;T?(N*16)=N?(?J*8+B);N.;?J=0
60 IF?J=CH"H"X=1
65 IF?J=CH"T"Y=1
70 IF?J=CH"B"Y=-1
80 IF?J=CH"F"X=-1
85 IF?J=CH"I"F.N=0TO7;T?(N*16)=T?(N*16):-1;N.;U.0
95 IF?J=CH"Q"P.$12;F.N=#80TO#FF;P.$N;N.;E.
100 GOS.p;U.?J=13
110 LINKQ;A=?J*8+B
120 F.N=0TO7;N?A=T?(N*16);N.
125 U.0
130pPLOT2,X,Y;R.
0                   
