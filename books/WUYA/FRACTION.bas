
1@=2;DIMZ(20) 
10P."PRESS RETURN";LINK#FFE3;P.$12;?#E1=0
11IN."FIRST NUMERATOR"A;IN."FIRST DENOMINATOR"B
15IN."SECOND NUMERATOR"C;IN."SECOND DENOMINATOR"D
20G.2010
30P."1=ADD"'"2=MINUS"'"3=DIVIDE"'"4=MULTIPLY"'
40IN.G
50IFG=1;G.100
60IFG=2;G.200
70IFG=3;G.400
80IFG=4;G.500
100F=A+C;G=B
105IFF=G;P.$12"1"';G.10
106STRF,Z;F.N=1TOLEN(Z);IFN?Z=CH".";$Z+N=""
107N.N
108F.M=0TO5;F.N=2TO10
109FIFFLT(F/N)=F/N;FIFFLT(G/N)=G/N;F=F/N;G=G/N
110N.N;N.M
113P.$12F"/"'
114F.N=1TOLEN(Z);P." ";N.N;P."/"G
115IFG<F;GOS.3000
116P.'
120G.10
200F=A-C;G=B
205IFF=G;P.$12"1"';G.10
210G.105
400F=A*B;G=B*C
405IFF=G;P.$12"1";G.10
410G.105
500F=A*C;G=B*B
505IFF=G;P.$12"1"';G.10
510G.105
2010IFB<>D;A=A*D
2020IFB<>D;C=C*B
2030IFB<>D;B=B*D
2031F.M=0TO5
2032F.N=2TO10
2033FIFFLT(A/N)=A/N;FIFFLT(B/N)=B/N;FIFFLT(C/N)=C/N;G.2036
2035N.N;N.M;G.2040
2036A=A/N;B=B/N;C=C/N;G.2035
2040P.A" OVER "B';P.C" OVER "B'
2050G.30
3000STRF,Z;F.N=1TOLEN(Z);IFN?Z=CH".";$Z+N=""
3010N.N
3020F.M=0TO5;F.N=2TO10
3030FIFFLT(F/N)=F/N;FIFFLT(G/N)=G/N;F=F/N;G=G/N
3040N.N;N.M
3050P.$12F/G" AND "F%G"/"'
3060F.N=1TOLEN(Z)+5;P." ";N.N;P."/"G 
3100R.
