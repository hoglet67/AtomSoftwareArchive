
1   REM - calendar
2   REM - J.B.Pickles 1981
3   @ = 0;PRINT$12"THIS PROGRAM WILL PRINT A"' 
4PRINT"CALENDAR FOR ANY MONTH IN THE"'"20TH. CENTURY"'';DIM Q8
5e  INPUT"MONTH NO(1 TO 12)"M
16  IFM <1 ORM>12;PRINT"NO SUCH MONTH"';GOTOe
20f INPUT"YEAR"A;Y= A -1900
21  IFY<0 OR Y>99;PRINT"20TH CENT.ONLY"';GOTOf 
30  REM - SET UP DAYS IN MONTH
40  IFM=2;GOSUBc;$Q="FEBRUARY";GOTOg 
45  IFM=4 OR M=6 OR M=9 OR M=11;D=30;GOSUBa;GOTOg 
50  D=31;GOSUBa
59  REM - CALCULATE DAY OF 1ST OF MONTH 
60g IFM>2;M=M-2;GOTOh
65  Y=Y-1;M=M+10 
70h E=(26*M-2)/10+1+Y+Y/4+19/4-2*19;E=ABS(E%7) 
79  REM - PRINT HEADERS
80  CLEAR0;PRINT$30;?224=10;PRINT"calendar"'
85  PRINT"MONTH:"$Q;?224 = 23;PRINT"YEAR:"A 
87  FOR X=1 TO 32;PRINT"*";NEXT X 
90  PRINT"  SUN  M   T   W  TH   F  SAT"';IFE<>0;GOSUBb
100@=4;FOR X=1 TO D;PRINT X;E=E+1;IFE=7;E= 0;PRINT ''
105      NEXT X;IFE=0;GOTOd
109      REM - FORMAT PRINT END
110      DO;E=E+1;PRINT"  **";UNTIL E=7;P.'
120d     INPUT"ANOTHER"$TOP;IF?TOP=CH"Y";RUN 
125      PRINT $12;END
199      REM -FIND MONTH STRING
200a     GOTO(200 +M*5)
205      $Q="JANUARY";RETURN
215      $Q="MARCH";RETURN
220      $Q="APRIL";RETURN
225      $Q="MAY";RETURN
230      $Q="JUNE";RETURN
235      $Q="JULY";RETURN 
240      $Q="AUGUST";RETURN
245      $Q="SEPTEMBER";RETURN
250      $Q="OCTOBER";RETURN
255      $Q="NOVEMBER";RETURN
260      $Q="DECEMBER";RETURN
264      REM- FORMAT PRINT START
265b     FOR X=1TOE;PRINT"   *";NEXT X;RETURN
269      REM- CHECK FOR LEAP YEARS
270c FORX=0 TO 100 STEP 4;IF Y=X;D=29;X=101;GOTOz
275      D=28
280z     NEXT X;RETURN
