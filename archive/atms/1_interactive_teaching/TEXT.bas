
1G.50
10A�(�L��
50?#E=#33;?#D=#C5
100B=256;A=T.-17;Q=T.-26;G=T.-63;Y=T.-50
110P.$12;GOS.l;P."TEXT   "';GOS.l;P.';?16=A;?17=A&#FFFF/256
130T=T.;DOT=T-1;U.T?-1=122
140GOS.p;GOS.p;$B=$Q;Z=B+6;$Z="""THIS IS A STRING""";P.'$G
150GOS.s
155P.'';GOS.p;$B=$Q;$Z="""!!^\*'&%$#="""
160P.';GOS.s;P.''$Y'
170P.';R=170;GOS.t;P.$12;P.';GOS.p;GOS.p;P.'$G
180P.';$B=$Q;$Z="""HE ATE"",???,"" FISH""";GOS.s
190$Z="?,?,?";GOS.s
200$Z="""5+44="",5+44";GOS.s;P.''
210GOS.p;GOS.w;P.'';P.$Y';R=220
220GOS.t;P.$12;GOS.p;P.'$G;$B=$Q
230$Z="'""SINGLE QUOTE GIVES"",',""A NEW LINE""'";GOS.s
240P.''"USUALLY YOU CAN OMIT THE COMMAS"
250$Z="""NOT EVEN""1"" COMMA HERE""";GOS.s
260$Z="""LOTS""''""OF""''""NEWLINES""'";GOS.s;P.$Y'
280R=280;GOS.t;P.'$12;GOS.p;P.'$G';$B=$Q
290$Z="""HE SAID """"HELLO"""" """;GOS.s;$B=$Q;$Z=""""""""""
300GOS.s;P.'$Y';R=310
310GOS.t;P.'$12;GOS.p;$B=$Q;$Z="$24?";P.'$G';GOS.s;$Z="$16?"
320GOS.s;P.''$Y';K=160;L=255;@=4
330R=330;GOS.h;P.'$12;GOS.p;GOS.p
340P.'"$7 BLEEP"''"CURSOR MOVEMENT"'"$8 LEFT"'"$9 RIGHT"'
350P."$10 DOWN"'"$11 UP"''"$12 CLEAR SCREEN"';W=20;GOS.w
360R=370;P.'"TRY PRINTING SOME OF THESE NOW"';K=7;L=12;@=3
370GOS.h;P.'$12;@=8
800IN."DO YOU WANT TO REPEAT THIS"'"LESSON"$B
810IF?B=89G.100
820P.'"GOODBYE !"'';END
1100lF.I=0TO31;P.$172;N.;R.
1200wF.I=0TO10*W;WAIT;N.I;R.
1300pI=0;DOB?I=T?I;I=I+1;U.T?I=32ORT?I=13
1310B?I=13;IFT?I=13;T=T+2
1320IFC.+I>31;P.'
1330I=I+1;IF $B="^" G.q
1335P.$B" ";T=T+I;G.p
1340q T=T+I;W=10;GOS.w;R.
1400eJ=#8200;?J=13;J?1=0;J?2=0;J=J+3;$J=$B;J=J+L.J+1;?J=0
1420J?1=0;$J+2="R.";J=J+L.J+1;?J=#FF;?18=#82;GOS.0;?18=40;R.
1500rA=CH">";LINK#CD0F;R.
1540hGOS.r;@=4;IF$B="C";@=8;R.
1550I=-1;DOI=I+1;U.B?I=36 ORI>L.B
1555IF?B=13;G.h
1560IFI>L.B;P."YOU FORGOT THE $"';G.h
1570I=I+1;J=0;DOJ=J*10+B?I-48;I=I+1;U.B?I=13ORB?I<48ORB?I>57
1580IFJ<K ORJ>L;P."THAT NUMBER WAS NOT BETWEEN"K'"AND"L';G.h
1590@=8;GOS.e;G.h
1600t GOS.r;IF$B="C"R.
1601IF$B="RUN"G.o
1602IF$B="LIST"G.o
1610GOS.e;G.t
1620oP.'"SORRY I'M NOT HANDLING THAT"'"COMMAND"';G.t
1700x@=5;P.'"ERROR"?0';@=8
1755IF?0=159P."THE NUMBER OF QUOTES IN A STRINGMUST BE EVEN"
1760P.''"FOR MORE INFORMATION ABOUT THIS ERROR LOOK IN THE "
1770P."ATOM MANUAL"''"TYPE C WHEN YOU WANT TO RETURN  CONTROL"
1780P." TO ME"';G.R
2000sP.'">";F.J=0TOL.B-1;IFB?J=63B?J=49+A.R.%8
2010W=1+A.R.%2;GOS.w;P.$B?J;N.J;W=10;GOS.w;P.';GOS.e;P.">"
2020GOS.w;R.
5000zA STRING IS A SEQUENCE OF CHARACTERS ENCLOSED IN QUOTES. ^
5010YOU CAN PRINT A STRING ^ STRINGS CAN CONTAIN ANY CHARACTER.
5015^ YOU CAN PRINT LOTS OF THINGS WITH
5020A SINGLE PRINT STATEMENT. ^ USE , TO SEPARATE ITEMS. ^
5030THE CHARACTERS INSIDE THE QUOTES ARE PRINTED OUT EXACTLY AS
5040THEY APPEAR IN THE PRINT STATEMENT. ^
5050YOU CAN PRINT THINGS ON DIFFERENT LINES WITH ONE PRINT
5060STATEMENT ^ TO PRINT A DOUBLE QUOTE IN A STRING USE TWO
5065DOUBLE QUOTES ^ NOT ALL THE CHARACTERS THAT CAN BE
5070DISPLAYED ARE ON THE KEYBOARD. TO PRINT THESE USE $
5080FOLLOWED BY A NUMBER IN THE RANGE 160 TO 255 ^
5090THE NUMBERS BETWEEN 7 AND 12 HAVE
5100SPECIAL FUNCTIONS. ^ THESE ARE GIVEN BELOW. ^
5110USEFUL CODES ARE GIVEN BELOW ^
8000LIKE THIS:
8010NOW TRY THAT YOURSELF
8020PRINT 
8030?18=40;P.$7;G.x