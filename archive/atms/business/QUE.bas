
10 FDIM %PP(28),%FF(61),%AA(61)
20 DIM P(64),QQ(15)
30 FOR X=1 TO 15;QQ(X)=0;NEXT
40 PRINT $12;INPUT"THINK OF A NUMBER "A
50 !8=A;REM INIT SEED
60 PRINT"SHOP OPENS AT-";GOSUB 2800
70 T=A
80 PRINT"NOW SET SERVICE TIME IN MINS"'
90bFINPUT"AVERAGE "%M;IF %M<0 THEN G.b
100cFINPUT"STANDARD DEVIATION"%S;IF%S<0 THEN G.c
110 PRINT "WAIT"';GOSUB 5000
200dPRINT "ARRIVALS PER HR FOR NEXT PERIOD"'
210 FINPUT"ENTER NUMBER"%Z
220 IF %Z<0 OR (%Z/60)>20 THEN PRINT "USE DIFFERENT UNITS";G.d
230 %Z=%Z/60;GOSUB 4000;REM INIT%PP
240 PRINT "CURRENT POSITION SETTINGS ARE "'
250 FOR X=1 TO 15 STEP 3
260 PRINT X/3+1
270 IF QQ(X)=0THEN PRINT "  SHUT"'
280 IF QQ(X)=-2 THEN PRINT "  OPEN"'
290 NEXT
300 PRINT "WHICH ONES TO CHANGE"'
310eINPUT "POSITION-0 TO END"A
320 IF A<0 OR A>5 THEN G.e
330 IF A=0 THEN G.f
340 INPUT"NEW STATE"$P
350 IF CHP=79 THEN QQ((A-1)*3+1)=-2
360 IF CHP=83 THEN QQ((A-1)*3+1)=0
370 G.e
380fPRINT "TIME OF NEXT CHANGE"'
390 GOSUB 2800
400 IF A<T THEN PRINT "MUST BE LATER THAN"T';G.f
410 U=A
500 CLEAR 4;MOVE 200,15;STR T,P;GOSUB 6000
510 FOR X=1 TO 13 STEP 3
520 MOVE 0,((X/3+1)*35);PLOT 1,5,0
525 PLOT (4-(QQ(X)+3)),0,-10;PLOT 1,-5,0
530 Y=QQ(X+1);Z=1;PLOT 0,20,10;M=1
540 IF Y=0 THEN G.g
550 GOSUB 3000;Y=Y-1;Z=Z+1
560 IF Z=23 THEN PLOT 0,-230,15;Z=0
570 G.540
580gNEXT
600 GOSUB 2700;STR T,P;MOVE 200,15;GOSUB 6000
610 FOR Y=1 TO 13 STEP 3
620 IF QQ(Y+1)<=0 THEN G.h
630 QQ(Y+2)=QQ(Y+2)-1
640 IF QQ(Y+2)>0 THEN G.h
650 GOSUB 2500
660 M=3
670 GOSUB 3000;QQ(Y+1)=QQ(Y+1)-1;QQ(Y+2)=0
680 IF QQ(Y+1)>0 THEN GOSUB 5200;QQ(Y+2)=X
690hNEXT
700 GOSUB 4200
710jIF X=0 THEN G.i
720 A=999;B=0
730 FOR Y=1 TO 13 STEP 3
740 IF QQ(Y)<>0 AND QQ(Y+1)<A THEN A=QQ(Y+1);B=Y
750 NEXT
760 QQ(B+1)=QQ(B+1)+1
765 IF QQ(B+1)=1 THEN GOSUB 5200;QQ(B+2)=X
770 X=X-1;Y=B
780 GOSUB 2500;M=1;GOSUB 3000
790 G.j
800iIF T<U THEN G.600
810 PRINT $6;FOR W=1 TO 16;PRINT';NEXT
820 G.d
2500 A=QQ(Y+1)%23;B=QQ(Y+1)/23;A=A-1
2510 A=20+A*10;B=(15*B)+((Y/3+1)*35)
2520 MOVE A,B;R.
2700 T=T+1;IF T%100>59 THEN T=T+100;T=T/100*100
2710 R.
2800 INPUT "TIME " A
2810 IF A<0 THEN G. 2800
2820 H=A/100;M=A%100;IF H>24 OR M>59 THEN G.2800
2830 R.
3000 WAIT;PLOT M,6,0;WAIT;PLOT M,0,-10
3010 WAIT;PLOT M,-6,0;WAIT;PLOT M,0,10
3020 WAIT;PLOT 0,0,-4;WAIT;PLOT M,6,0
3030 WAIT;PLOT 0,-8,-3;WAIT;PLOT M,4,0
3040 WAIT;PLOT 0,0,-6;WAIT;PLOT M,0,3
3050 WAIT;PLOT 0,2,0;WAIT;PLOT M,0,-3
3060 WAIT;PLOT 0,-2,11;WAIT;PLOT(M+8),0,0
3070 WAIT;PLOT 0,8,2;R.
4000 %E=2.7183
4010 %PP(0)=%E^(-%Z)
4020 %PP(1)=(%PP(0)*%Z)+%PP(0)
4030 %T=%Z;%F=1;%X=1;X=1
4040 DO %X=%X+1;X=X+1
4050 %T=%T*%Z;REM ->Z^2,Z^3ETC
4060 %F=%F*%X;REM ->2!,3!ETC
4070 %PP(X)=(%T/%F*%PP(0))+%PP(X-1)
4080 IF X>28 THEN 4100
4090 FUNTIL %PP(X)>.99
4100 FOR Y=0 TO X;%PP(Y)=%PP(Y)*100;NEXT
4110 R.
4200 REM GET ARRIVALS
4210 X=ABSRND%99;A=-1
4220 A=A+1
4230 IF %PP(A)>=X THEN X=A;R.
4240 IF A<>28 THEN G.4220
4250 X=0;R.
5000 %T=-3.0;%E=2.7183;%K=1/(SQR(2*PI))
5010 FOR X=1 TO 61
5020 %FF(X)=%K*%E^(-(%T*%T)/2)
5030 %AA(X)=%M+(%S*%T)
5040 %FF(X)=%FF(X)*%M/%S
5050 IF X<>1 THEN %FF(X)=%FF(X)+%FF(X-1)
5060 %T=%T+0.1;NEXT
5070 R.
5200 REM GET SERVICE TIME
5210 A=%FF(61);X=ABSRND%A;A=0
5220 A=A+1
5230 IF %FF(A)>=X THEN %X=%AA(A)+.5;X=%X;R.
5240 IF A<>61 THEN G.5220
5250 X=%AA(30);R.
6000 IF LENP>10 THEN R.
6010 P!12=#6E3E4477;P!16=#467B6B4D
6020 P!20=#00004F7F
6030 P!36=4
6040 DO P!32=CH$P
6050 $P=$P+1;P!32=(P!32)-48
6060 IF (P!32)<0 OR (P!32)>9 THEN PLOT 0,5,0;G.6120
6065 P!32=P?((P!32)+12)
6070 FOR A=1 TO 7
6080 P!24=(2-A%6)%2;P!28=(2-(A-1)%4)%2
6085 M=1;IF ((P!32)&1)=0 THEN M=3
6090 PLOT M,((P!28)*3),((P!24)*3)
6100 P!32=(P!32)/2
6110 NEXT A;PLOT 0,2,0
6120 P!36=(P!36)-1
6130 UNTIL P!36=0
6140 R.
