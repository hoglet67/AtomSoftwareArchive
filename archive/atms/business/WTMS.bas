
10 DIM P(120),S(64),AA(40),A(64),K(5)
20 FDIM %AA(40);%R=0.5;@=1
30 FOR N=1 TO 40;DIM J(5);AA(N)=J;NEXT;PRINT"WAIT"'
40 $A="MM/CM/ME/KM//GM/KG/TONN//CC/LI//MM/CM/ME/HE/KM//"
50 N=1;M=0;GOSUB 2000
60 $A="//IN/F/Y/MI//OZ/LB/TONS//PT/GA//IN/F/Y/AC/MI////"
70 N=19;M=0;GOSUB 2000
80 $A="1/10/1000/1E+6//1/1000/1E+6//1/1000//1E-6/1E-4/1/1E+4/"
90 N=1;M=1;GOSUB 2000
100 $A="1E+6////25.4/304.8/914.4/1609344//28.35/453.6/1016064/"
110 N=17;M=1;GOSUB 2000
120 $A="/568.26/4546.09//6.451E-4/.09290/.8361/4046.72/"
130 N=29;M=1;GOSUB 2000
140 $A="2589903.3////"
150 N=37;M=1;GOSUB 2000
200 PRINT $12
210aINPUT"ENTER NUMBER THEN UNITS "$A;%X=VALA
220 FIF%X=0 THEN PRINT "UNITS FIRST"';G.a
230 DO $A=$A+1;UNTIL CHA>64 OR CHA=13
240 IF LENA=0 THEN PRINT"WHAT ARE THE UNITS?"';G.a
250 $K="SQ";P!0=A;P!4=K;GOSUB 1000
260 M=1;IFP!0<>0 THEN M=13
270 N=M
280bP!0=A;P!4=AA(N);GOSUB 1000
290 IF N=20 AND M=13 THEN N=32
300 N=N+1;IF N=41 THEN PRINT"UNITS NOT FOUND"';G.a 
310 IF P!0=0 THEN G.b
320 N=N-1;M=N+20;IF M>40 THEN M=M-40
330 FOR X=1 TO 2
340 FIF%AA(M)=0 THEN G.c
350 %Y=%X*%AA(N)*100/%AA(M)
360 Y=%(%Y+%R);PRINT Y/100,".";Y=Y%100;IF Y<10 THEN PRINT"0"
370 PRINT Y,"  ",$AA(M)';M=M+1
380cNEXT
390 G.a
400 END
1000 P!8=LEN(P!0)-LEN(P!4)
1010 IF P!8<0 THEN P!0=0;R.
1020 P!12=P+16;IF $P!4="" THEN P!0=0;R.
1030 W=0
1040 $P!12=$P!0+W
1050 $(P!12)+LEN(P!4)=""
1060 IF $P!12=$P!4THEN P!0=W+1;R.
1070 W=W+1;IF W<=P!8 THEN G.1040
1080 P!0=0;R.
2000 $S=$A
2010 P!0=S;$K="/";P!4=K
2020 GOSUB 1000;IF P!0=0 THEN R.
2030 $S+(P!0)-1=""
2040 IF M=0 THEN $AA(N)=$S
2050 IF M=1 THEN %AA(N)=VALS
2060 $S=$A+(P!0);$A=$S;IF LENS=0 THEN R.
2070 N=N+1;G.2010
