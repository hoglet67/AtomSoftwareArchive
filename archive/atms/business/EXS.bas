
10 DIM P(64);V=15;REM VAT RATE
20 @=1
30aFINPUT "AMOUNT"%A 
40 %A=%A*100;A=%A 
50 B=(A*100)/(100+V)
60 C=A-B
70 D=(A*V)/100
80 PRINT "  GOODS    VAT INC    VAT EXC"
90 P!0=B;P!4=0;GOSUB 1200 
100 P!0=C;P!4=10;GOSUB 1200
110 P!0=D;P!4=20;GOSUB 1200
120 PRINT';G.a
1200 DO PRINT " ";UNTIL COUNT>=P!4
1210 P!4=0;P!8=ABS(P!0)
1220 DO P!4=(P!4)+1;P!8=(P!8)/10
1230 UNTIL P!8<100
1240 P!4=6-(P!4);P!8=ABS(P!0)
1250 DO P!4=(P!4)-1;PRINT " ";UNTIL P!4<=0
1260 PRINT (P!8)/100,".";P!8=(P!8)%100
1270 IF P!8<10 THEN PRINT "0"
1280 PRINT P!8
1290 IF (P!0)<0 THEN PRINT "CR"
1300 R.
