
1G.5
2�(�L��
5?#E=#33;?#D=#F9
10GOS.i;GOS.p;P.'
20$B=$Q;$B+6="?";GOS.s;Z=B+6;$Z="??";GOS.s;P.'';GOS.p
30P.'$Y'';R=30;GOS.t;P.'$12
35GOS.p;GOS.p
36P.''$Y';R=36;GOS.t;P.'$12
40GOS.p;P.';$B=$Q;Z=B+6;$Z="?+?";GOS.s;$Z="??-?";GOS.s
45P.''"TRY TO DO SOME CALCULATIONS"
46P.'$Y'';R=46;GOS.t;P.'$12
50GOS.p;?#E1=0;P." "''"+ PLUS";GOS.w
60P.'"- MINUS";GOS.w;P.'"* MULTIPLY";GOS.w;P.'"/ DIVIDE";GOS.w
70P.'"% REMAINDER";GOS.w;P.''"PRESS SPACE TO CONTINUE"
80LINK#FFE3;P.'$12;GOS.p;P.'
85$B=$Q;$Z="?/?";GOS.s;Z?1=37;$B+30=$B;P.'';GOS.p;$B=$B+30
95P.';GOS.s;P.''"NOW TRY THAT YOURSELF"''$Y';R=100
100GOS.t;P.$12;GOS.p;$B=$Q;$Z="?/?+?";GOS.s;Z?7=13;Z?6=CH")"
101Z?5=Z?4;Z?4=Z?3;Z?3=Z?2;Z?2=CH"(";GOS.s
102P.''"EXPRESSIONS INSIDE THE BRACKETS ARE EVALUATED FIRST."
103P.''"NOW TRY THAT YOURSELF"''
104R=104;GOS.t
106P.$12;GOS.p;P.';$B=$Q;$Z="??";GOS.s;P.'"<------> @ IS 8. "
107P.''"THE NUMBER AND SPACES FILL 8"'"POSITIONS"''
108P."PRESS SPACE TO CONTINUE"';LINK#FFE3;P.'$12
110P.'"YOU CAN CHANGE @ LIKE THIS"';$B="@=3";GOS.s
120$B=$Q;$Z="??";GOS.s;P.'"<-> NOW @=3";GOS.w;P.'';GOS.p;P.'
140R=140;GOS.t;IN.'"DO YOU WANT TO REPEAT THIS"'"LESSON"$B
145@=8
150IF?B=89G.10
160P.'"GOODBYE !!!"$7$7''';END
1000iQ=T.-74;B=#100;A=T.-17;Y=T.-65;
1010P.$12;GOS.l;P."NUMBERS"';GOS.l;P.'
1030T=T.;DOT=T-1;U.T?-1=CH"z"
1050?16=A;?17=A&#FFFF/256;R.
1100lF.I=1TO32;P.$172;N.I;R.
1200wF.I=0TO10*W;WAIT;N.I;R.
1300pI=0;DOB?I=T?I;I=I+1;U.T?I=32ORT?I=13
1310B?I=13;IFT?I=13;T=T+2
1320IFC.+I>31;P.'
1330I=I+1;IF$B="^"G.q
1335P.$B" ";T=T+I;G.p
1340q T=T+I;W=10;GOS.w;R.
1400eJ=#8200;?J=13;J?1=0;J?2=0;J=J+3;$J=$B;J=J+L.J+1;?J=0
1420J?1=0;$J+2="R.";J=J+L.J+1;?J=#FF;?18=#82;GOS.0;?18=#28;R.
1500rA=62;LINK#CD0F;R.
1600tGOS.r;IF$B="C";R.
1605IF$B="RUN"OR$B="LIST"P."SORRY I'M NOT HANDLING THAT"';G.t
1610GOS.e;G.t
1700x@=5;P.'"ERROR"?0';@=8
1710IF?0=29P.'"UNKNOWN FUNCTION"'"PROBABLY A TYPING MISTAKE"
1720IF?0=94P."DID YOU TYPE PRINT ?"'
1730IF?0=94P."THE STATEMENT YOU HAVE TYPED IS NOT VALID BASIC"
1740IF?0=109P."NUMBER TOO LARGE"
1755IF?0=129P.'"YOU CAN NOT DIVIDE BY ZERO"
1760P.''"FOR MORE INFORMATION ABOUT THIS ERROR LOOK IN THE "
1770P."ATOM MANUAL"'';G.R
2000s P.'">";F.J=0TOL.B-1;IF B?J=63B?J=49+A.R.%8
2010W=A.R.%5;GOS.w;P.$B?J;N.J;W=9;GOS.w;P.';GOS.e;P.">";R.
3000zTO PRINT A NUMBER YOU TYPE PRINT FOLLOWED BY THE NUMBER
3100THEN PRESS RETURN. ^ NOW TRY TO PRINT SOME NUMBERS YOURSELF
3200^ THE ATOM WORKS IN INTEGERS. THESE ARE NUMBERS
3300WITHOUT A DECIMAL POINT OR FRACTION PART. ^ SEE IF YOU FIND
3400THE LARGEST NUMBER THAT CAN BE PRINTED. ^
3500YOU CAN DO SIMPLE CALCULATIONS USING PRINT. TYPE PRINT
3550FOLLOWED BY AN EXPRESSION THEN PRESS RETURN. ^
3600THE FOLLOWING SIGNS CAN BE USED IN CALCULATIONS. ^
3700THE SIGN / GIVES YOU THE WHOLE PART OF A DIVISION. ^
3800THE SIGN % GIVES YOU THE
3900REMAINDER THAT IS LOST WHEN DOING DIVISION. ^
4000BRACKETS CAN ALTER THE ORDER IN WHICH
4100CALCULATIONS ARE DONE.
5010^ YOU CAN CONTROL HOW MANY SPACES ARE PRINTED BEFORE A
5020NUMBER BY USING @. USUALLY @ HAS THE VALUE 8. ^
5030NOW TRY CHANGING @ AND SEE HOW THIS EFFECTS THE WAY NUMBERS
5040ARE PRINTED. ^
5800PRINT 
5900TYPE C WHEN YOU WANT TO RETURN  CONTROL TO ME
6000?18=40;P.$7;G.x
