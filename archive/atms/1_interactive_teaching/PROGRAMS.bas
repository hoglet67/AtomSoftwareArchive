
50?#E=51;?#D=#F6
90U=T.-133;V=U+25;M=V+10
100B=256;G=T.-18;Q=T.-6;R=T.-42;S=1;C=T.-75;H=C-65
110P.$12;GOS.d;P."PROGRAMS"';GOS.d;P.'
120T=#2F51;GOS.p;GOS.l;GOS.p;GOS.p
130GOS.c;P.'$G;$B=$Q;GOS.s;P.';GOS.l;GOS.p;GOS.p
140P.'$C';GOS.h;P.$12;GOS.p;P.'$G;$B="RUN";GOS.s;P.';GOS.7010
170P."NOW TRY THAT YOURSELF"'$C'';GOS.h
200P.$12;GOS.p;P.'$G';$B=$Q;GOS.s;P.';GOS.l;$B="NEW";GOS.s
210P.'">";GOS.w;$B=$Q;GOS.s;P.'">";W=10;GOS.w;P.''
220GOS.p;W=30;GOS.w;P.';GOS.p;P.$G;$B="OLD";GOS.s;$B=$Q;GOS.s
230P.';GOS.l;GOS.p;P.$C';GOS.h
240P.'$12;GOS.p;P.'$G';$B="NEW";GOS.s;$B=$U;GOS.s;$B=$V;GOS.s
250$B=$Q;GOS.s;P.'$H$U'$H$V'">";W=20;GOS.w
260GOS.c;P.$G'
270$B=$M;GOS.s;$B=$Q;GOS.s;P.'$H$U'$H$M'$H$V'">";W=20
280GOS.w;P.';GOS.p;$B="15";GOS.s;$B=$Q;GOS.s
290P.'$H$U'$H$V'">";W=20;GOS.w;GOS.c;P.$G';$B=$Q;GOS.s
300P.'$H$U'$H$V';$B="10 PRINT $7";GOS.s;$B=$Q;GOS.s
310P.'"   10 PRINT $7"'$H$V'">";W=20;GOS.w;P.';GOS.c
800P.''$R;IN." THIS"'"LESSON"$B
810IF?B=89G.100
820P.''"GOOD LUCK !"'$7;?#2800=#D;?#2801=#FF;END
937(�L��[
1000cP.'"PRESS SPACE TO CONTINUE"';LINK#FFE3;P.$12;GOS.p;R.
1100dF.I=1TO32;P.$172;N.I;R.
1200wF.I=0TO10*W;WAIT;N.I;R.
1300pI=0;DOB?I=T?I;I=I+1;U.T?I=32ORT?I=13
1310B?I=13;IFT?I=13;T=T+2
1320IFC.+I>31;P.'
1330I=I+1;IF $B="^" G.q
1335P.$B" ";T=T+I;G.p
1340qT=T+I;W=10;GOS.w;P.';R.
1500rA=CH">";LINK#CD0F;R.
1700lA=7010;L=7050;F=7000;N=T.-300;@=5
1710DON=N+1;U.?N=13A.N?1=A/256A.N?2=A&#FF
1720DOP.'(N?1*256+N?2)-F;N=N+3;P.$N;N=N+L.N
1730U.N?1=L/256A.N?2=L&#FF;P.'(N?1*256+N?2)-F
1740P." END"'';@=8;R.
1800hGOS.r;I=-1;DO I=I+1;U.B?I<>32;P=B+I
1810IF?P=13;G.h
1820IF$P="NEW";S=0;G.h
1830IF$P="OLD";S=1;G.h
1840IF$P="RUN";G.e
1850IF$P=$Q;G.t
1855IF$P="C";R.
1860P."SORRY I AM ONLY DEALING WITH"'"SIMPLE VERSIONS OF LIST,"
1861P."RUN,NEW AND OLD"';G.h
1920eIF S;GOS.7010;G.h
1930P.'$7,"ERROR 94"'"YOU CANNOT RUN A PROGRAM THAT IS"
1940P."NOT THERE !"';G.h
1950tIFS;GOS.l;G.h
1960G.h
2000sP.'">";F.J=0TOL.B-1;W=2+A.R.%2;GOS.w;P.$B?J;N.;W=9;GOS.w
2010R.
5000zHERE IS A VERY SIMPLE PROGRAM ^ A PROGRAM CONSISTS OF A
5005SERIES OF STATEMENTS EACH WITH A LINE NUMBER. ^ PROGRAMS
5007ARE STORED IN
5010MEMORY. ^ TO SEE THE PROGRAM IN MEMORY TYPE LIST. ^
5020WHEN THE END STATEMENT IS EXECUTED THE PROGRAM WILL STOP. ^
5040TRY LISTING THIS PROGRAM YOURSELF. ^
5060TO RUN A PROGRAM TYPE RUN ^ IF YOU TYPE NEW THE PROGRAM
5065IN MEMORY IS REMOVED ^
5070NOW NOTHING APPEARS WHEN YOU TYPE LIST SINCE THE PROGRAM 
5080 HAS BEEN REMOVED BY NEW ^ TYPING OLD WILL RECOVER THE
5090PROGRAM ^ NOW TRY EXPERIMENTING WITH LIST, RUN, NEW AND OLD
5100YOURSELF ^ TO ENTER A PROGRAM FIRST TYPE NEW TO CLEAR THE
5110MEMORY. THEN TYPE A NUMBER FOLLOWED BY A STATEMENT. ^
5120LINES TO BE STORED AS A PROGRAM ARE SORTED INTO ORDER. ^
5130SIMPLY BY TYPING A LINE NUMBER YOU CAN DELETE A LINE ^
5140YOU CAN CHANGE A LINE BY TYPING A LINE NUMBER THEN THE
5150NEW LINE ^ THIS PROGRAM WILL NOW END AND LET YOU TRY TO
5160ENTER AND RUN A PROGRAM OF YOUR OWN. ^
7010 PRINT $12 $7 $7 "HELLO"'
7020 PRINT"I'M VERY SIMPLE"'
7030 PRINT"THAT'S ALL I DO"'
7040 PRINT"BYE !"'$7 $7 '
7050R.
7090   
8000 10 PRINT"NEW PROGRAM"
8010 20 END
8020 15 PRINT"STORE THIS"
8080TYPE C TO RETURN CONTROL TO ME
8090DO YOU WANT TO REPEAT
9000LIKE THIS
9010LIST