
 1%A=0;%B=0;REM FORUMLA ONE by C.G.Johnson
 2 P.$12"now the game you've been waitin'"
 3 P."for"'"FROM cj products..."';B=0
 4 F.B=0 TO 120;WAIT;N.;B=0
 5  DO B=B+1;P.$7"***FORMULA*one***";U.B=16
 6 F.B=1 TO 50;WAIT;N.;P.$12"          instructtions"' 
 7 P." YOU ARE DRIVING A CAR ROUND A  RACING TRACK."'
 8 P." THE OBJECT OF THE GAME IS TO"'"SURVIVE THE MOST "
 9 P."NO. OF LAPS."
10 P.'"          'SHIFT' =LEFT"'"          'REPT.' =RIGHT"'''
11 IN."COLOUR OF CAR:WHITE 1;BLACK:2"T
12 IF T=1 R=2
13 IF T=2 R=1
14 P."PRESS 'SHIFT' WHEN YOU'VE FOUND THE CIRCUIT YOU WANT"
15 P.";THEN PRESS SPACE TO START THE RACE."'
18 P."press return";LINK#FFE3
19 DO
20 CLEAR 3
21 Q=0;S=1;O=0
25 COLOUR(R)
30 REM the course
50 H=A.R.%(65-40)+40;I=A.R.%(30-3)+3;J=A.R.%(94-70)+70
52 K=A.R.%(110-(I+70))+(I+70);L=A.R.%(60-20)+20
60 MOVE 1,1
70 DRAW 1,H;DRAW I,H;DRAWI,J
72 DRAW K,J;DRAW K,(H+5);DRAW 125,(H+5)
73 DRAW 125,10;DRAW L,10;DRAWL,1;DRAW1,1
74 REM
75 MOVE 16,23
77 DRAW 16,(H-17);DRAW(I+16),(H-17) 
79 DRAW(I+16),(J-17);DRAW(K-17),(J-17)
81 DRAW(K-17),(H-7);DRAW 108,(H-7)
83 DRAW108,27;DRAW(L+27),27
85 DRAW(L+27),23
87 DRAW 16,23
89 REM
90 GOS.t
93 X=(K-50);Y=(J-8)
95 REM 
96 GOS.q
101 COLOUR(T)
145 F.U=0TO30;WAIT;N.
150U.?#B001&#80=0
200LINK#FFE3
299 REM
300Z=13;U=12;V=5;W=15;A=1;B=1;C=1;E=#B001;F=#B002;G=#40
301N=#80
350aPLOTU,(X-2),(Y+2);PLOTV,(X-2),(Y-2);PLOTU,(X-1),(Y+3)
360 PLOTV,(X-1),(Y-3);PLOTU,X,(Y+1);PLOTV,X,(Y-1)
370 PLOTU,(X+1),(Y+2);PLOTV,(X+1),(Y-2);PLOTU,(X+2),(Y+1)
380 PLOTV,(X+2),(Y-1);PLOTW,X,Y
394 GOS.z
395 IFA=1 A=2;Z=15;V=7;G.a
397 IFA=2 A=1;Z=13;V=5
500 IF?F&G=0;Y=Y-2;X=X+2;B=B+1;C=2
510 IF?E&N=0;Y=Y+2;X=X+2;C=C+1;B=2
515 IF?F&G<>0 AND ?E&N<>0;X=X+4;C=1;B=1
520 IF B=6 G.b
530 IF C=6 G.c
550 G.a
600 REM
610bPLOTU,(X-2),(Y+3);PLOTV,(X+2),(Y+3);PLOTU,(X-3),(Y+2)
620 PLOTV,(X+3),(Y+2);PLOTU,(X-1),(Y+1);PLOTV,(X+1),(Y+1)
630 PLOTU,(X-1),Y;PLOTV,(X+1),Y;PLOTW,X,Y
640PLOTU,(X-2),(Y-1);PLOTV,(X+2),(Y-1);PLOTU,(X-1),(Y-2)
650 PLOTV,(X+1),(Y-2)
655 GOS.z
660 IFA=1 A=2;Z=15;V=7;G.b
670 IFA=2 A=1;Z=13;V=5
700 IF?F&G=0;Y=Y-2;X=X-2;B=B+1;C=2
710 IF?E&N=0;Y=Y-2;X=X+2;C=C+1;B=2
720 IF?F&G<>0 AND ?E&N<>0;Y=Y-4;C=1;B=1
730 IFB=6 G.d
740 IFC=6 G.a
750 G.b
800 REM
810cPLOTU,(X-2),(Y-3);PLOTV,(X+2),(Y-3);PLOTU,(X-3),(Y-2)
820 PLOTV,(X+3),(Y-2);PLOTU,(X-1),(Y-1);PLOTV,(X+1),(Y-1)
830 PLOTU,(X-1),Y;PLOTV,(X+1),Y;PLOTW,X,Y
840 PLOTU,(X-2),(Y+1);PLOTV,(X+2),(Y+1);PLOTU,(X-1),(Y+2)
850 PLOTV,(X+1),(Y+2)
855 GOS.z
860 IFA=1 A=2;Z=15;V=7;G.c
870 IFA=2 A=1;Z=13;V=5
880 IF?F&G=0;Y=Y+2;X=X+2;B=B+1;C=2
885 IF?E&N=0;Y=Y+2;X=X-2;C=C+1;B=2
890 IF?F&G<>0 AND?E&N<>0;Y=Y+4;C=1;B=1
895 IFC=6 G.d
897 IFB=6 G.a
898 G.c
900 REM
950dPLOTU,(X+2),(Y+2);PLOTV,(X+2),(Y-2);PLOTU,(X+1),(Y+3)
960 PLOTV,(X+1),(Y-3);PLOTU,X,(Y+1);PLOTV,X,(Y-1)
970 PLOTU,(X-1),(Y+2);PLOTV,(X-1),(Y-2);PLOTU,(X-2),(Y+1)
980 PLOTV,(X-2),(Y-1);PLOTW,X,Y
994 GOS.z
995 IFA=1 A=2;Z=15;V=7;G.d
997 IFA=2 A=1;Z=13;V=5
1000 IF?F&G=0;Y=Y+2;X=X-2;B=B+1;C=2
1010 IF?E&N=0;Y=Y-2;X=X-2;C=C+1;B=2
1015 IF?F&G<>0 AND ?E&N<>0;X=X-4;C=1;B=1
1020 IFB=6 G.c
1030 IFC=6 G.b
1040 G.d
2000zREM
2010 IFX<5 G.y
2020 IF X>(L-2) AND Y<14 G.y
2040 IF Y>(J-4) G.y
2050 IFY>(H+3) AND X>(K-3) G.y
2055 IFY>(H+3) AND X>(K+2);G.y
2060 IF X>121 G.y
2081 IF Y<5 G.y
2082 IF Y>(H-3) AND X<(I+4) G.y
2085 IF((X>(K-15))&(X<(K+3))&(Y<(H+6))&(Y>(H-10)))G.r 
2090 G.x
2095mF.D=1 TO 6;?F=?F&3100:4;N.;O=O+1
2096 IF((X>16)&(Y>(J-18))&(S=0))Q=Q+1;S=1
2097 IF((X<16)&(S=1)&(Y>23))S=0
2099 R.
2200xREM
2201 IF((X>(I+13))&(X<(K-13))&(Y<(J-12))&(Y>25))G.y
2204 IFX>110 G.m
2205 IF((X<112)&(X>(K-19))&(Y<(H-3))&(Y>23))G.y
2210 IF Y>(J-14) G.m
2220 IF X<14 G.m 
2230 IF X>(K-17) AND Y>(H-5);G.m
2240 IF X>105 G.m
2250 IF X> (L+30) ANDY<25 G.m
2260 IF X>(I+16) AND Y>(H-17) G.m
2270 IF Y<20 G.m
2280 IFY>(H-14) AND X<(I+14) G.m
2999 REM
3000yCOLOUR(R)
3001 F.D=1 TO 15;?F=?F&RND:4;N.
3030 MOVE X,Y
3040 DRAW (X-3),(Y-3);MOVEX,Y;DRAW(X+3),(Y-3);MOVE X,Y
3050 DRAW(X+3),(Y+3);MOVEX,Y;DRAW(X-3),(Y+3)
3060 MOVEX,Y;DRAW(X+4),(Y+5)
3065 F.D=1TO20;?F=?F&RND:4;N.
3070 MOVE X,Y;DRAW (X-6),(Y+5)
3080 MOVEX,Y;DRAW(X+6),(Y-3)
3090 F.D=1 TO 90;?F=?F&RND:4;N.
3999 REM
4000 P.$12;@=0
4010P."TIJD = "O'
4020P."AANTAL RONDES = "Q'
4028 FIFQ=%A G.4040
4030 FIFQ<%A G.4040
4031 %A=Q
4032 %B=O
4040 P."THE MOST NUMBER OF LAPS = "%A" IN "%B'
4050 P."PRSS RETURN TO START AGAIN";LI.#FFE3;G.19
5000qREM
5005 GOS.t;REM 
5010 COLOUR 2
5020 F.P=(H+8)TO(H-7) S.-1
5030 MOVEK,P;DRAW(K-17),P
5040 N.P;COLOUR(T);R.
5999 REM
6000rGOS.q;IFX>(K-4) G.2090
6005 IFR.%8=0 GOS.s
6010 G.2090
6050sF.D=0TO180;?F=?F&R.:4;N.
6060 X=X+(A.R.%10);Y=Y+(R.%4);R.
7000tREM
7010 COLOUR(T);MOVE(K-50),J;F.M=(J-17)TO (J)S.2
7020 PLOT13,(K-50),M;N.M;RETURN
