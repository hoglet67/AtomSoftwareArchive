1 REM WAMPUS. BY T.MABBS
5 P.$15
10 P.$12"hunt the wampus"''"YOU ARE IN A NETWORK OF 20 CAVES"'
20 P."THE WAMPUS IS IN ONE CAVE, YOU"'
30 P."HAVE 5 ARROWS TO SHOOT AT HIM,"'
35 P."YOU MAY THROUGH 1 OR 2"'"CAVES PER SHOT."''
40 P."ALSO IN THE CAVES ARE A COLONY"'
45 P."OF SUPERBATS, AND A BOTTOMLESS  PIT!!"''
50 P."any key to continue";LINK #FFE3;P.$12
55 P."IF THE SUPERBATS GET YOU, THEY"'
60 P."TAKE YOU TO ANOTHER CAVE."''
65 P."IF YOU FALL INTO A PIT, YOU LOSE"''
70 P."IF YOU MEET THE WAMPUS, HE MAY"'
72 P."MOVE TO THE NEXT CAVE, OR HE"'"MAY EAT YOU."''
75 P."any key to continue";LINK #FFE3;P.$12
77 P."""I SMELL THE WAMPUS"" MEANS THE"'
78 P."WAMPUS IS IN THE NEXT CAVE."''
79 P."""I FEEL A DRAFT"" MEANS A"'"BOTTOMLESS PIT."''
80 P."""I HEAR WINGFLAPS"" MEANS"'"SUPERBATS."''
85 P."GOOD LUCK!!!!"''"press any key to start";LINK #FFE3
90 DIM AA(6),BB(20),Q(5);D=5
100 X=ABSRND%19+1;Y=ABSRND%19+1;Z=ABSRND%19+1;P.$12;@=0;F=5
105 IF X=Y OR X=Z X=ABSRND%19+1;G.105
106 IF Y=Z Y=ABSRND%19+1;G.106
110 W=ABSRND%19+1
120 FOR T=1 TO 32;P."-";N.;P."YOU ARE IN CAVE "W'
125 GOS.130;G.230
130 S=W-1;IF S=0 S=20
140 U=W+1;IF U=21 U=1
150 V=W+10;IF V>20 V=V-20
225 R.
230 P."YOU CAN MOVE INTO CAVES"'S", "U", OR "V'
231 P."SHOOT(1) OR MOVE(2)"'
235 ?#B000=2;IF ?#B001=#FD THEN T=1;G.250
240 ?#B000=1;IF ?#B001=#FD THEN T=2;G.250
245 G.235
250 IF T=1 P."shoot"';G.600
260 P."move"'
270 IN."MOVE TO"T;IF T<>S IF T<>U IF T<>V G.270
280 W=T;GOS.130
290 IF X=S OR X=U OR X=V P."I SMELL A WAMPUS!!"'
300 IF Y=S OR Y=U OR Y=V P."I HEAR WINGFLAPS!!"'
310 IF Z=S OR Z=U OR Z=V P."I FEEL A DRAFT!!"'
320 IF Z=W P.$12"AAAAHHHHHHHH!!"';FOR T=1 TO 100;WAIT;N.;G.5000
330 IF Y=W G.340
335 G.400
340 T=ABSRND%5+15;P.$12;?#E1=0;?#8000=#20
345 FOR P=1 TO T
350 L=ABSRND%#1FF+#8000;?#DE=L;?#DF=(L/255)
351 BB(P)=L;N=0
352 FOR M=1 TO 8;IF ?(BB(P)+M)<>#20 M=8;N.;N.;N=1;G.354
353 N.
354 P."FLAP!!";WAIT;WAIT;WAIT;WAIT;WAIT;WAIT;WAIT
355 IF N=1 G.360
356 N.
360 F.T=1 TO 100;WAIT;N.;P.$12;F.T=1 TO 6;P.$10;N.;W=ABSRND%8+1
370 ?#E1=#80;P."        SUPERBATSNATCHED!!"';G.110
400 IF X<>W G.120
410 P."YOU HAVE DISTURBED THE WAMPUS!!"';T=ABSRND%10
420 IF T=1 OR T=4 X=S;IF X=Y OR X=Z X=X+1;G.500
430 IF T=2 OR T=5 X=U;IF X=Y OR X=Z X=X+1;G.500
440 IF T=3 OR T=6 X=V;IF X=Y OR X=Z X=X+1;G.500
445 IF T<>5 G.120
450 P.$12"THE WAMPUS HAS EATEN YOU!!";FOR T=1 TO 100;WAIT;N.
460 G.5000
500 G.120
600 IN."THROUGH HOW MANY CAVES"C;IFC<1ORC>2P."MUSCLES"';G.600
601 E=W
602 F.T=1 TO C;P."SHOOTING THROUGH CAVE"'S", "U" OR "V
603 IN.G;AA(T)=G
605 IFAA(T)<>U IFAA(T)<>V IFAA(T)<>S P."I'M NOT BIONIC!"';G.603
607 W=G;GOS.130
618 N.
619 W=E
620 FOR T=1 TO C;G=AA(T)
630 IF X=G THEN T=11;N.;G.700
640 IF W=G THEN T=11;N.;G.800
650 P."********BOIIIING!!*****"';N.;D=D-1;IF D=0 G.900
660 G.120
700 P.$12"YOU GOT THE WAMPUS,"'
710 P."BUT THE WAMPUS'LL GETCHA NEXT"'"TIME!!!!!!!!"';G.5030
800 P.$12"UUNNNNNGGGHH!!!!"'"YOU SHOT YOURSELF!!";F.T=1 TO 100
810 WAIT;N.;G.5000
900 P.$12"YOU EXHAUSTED YOUR SUPPLIES"'"OF ARROWS!!!!"'
910 FOR T=1 TO 100;WAIT;N.;G.5000
5000 P.$12"YOU LOST!"';IN."AGAIN(YES OR NO)"$Q
5010 IF $Q="NO" OR $Q="N" E.
5020 IF $Q="YES" OR $Q="Y" G.5040
5030 IN."AGAIN(YES OR NO)"$Q;G.5010
5040 IN."SAME SETUP(YES OR NO)"$Q
5045 IF $Q="YES" OR $Q="Y" P.$12;G.110
5050 IF $Q="NO" OR $Q="N" G.100
5060 G.5040
