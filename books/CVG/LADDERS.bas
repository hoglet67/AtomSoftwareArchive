
10CLEAR0;P.$12;P."     SNAKES & LADDERS"'';GOS.y
20DIM AA70,GG6;P=#81;?#80=160
30F.N=1TO6;DIMB(8);GG(N)=B;N.
40GOS.x;GOS.w
50F.Q=40TO120 S.10;MOVE(95+(Q/5)),Q;GOS.c;N.
60P.$21
70[;LDA#B002;LDY@#FF;LDX#80;DEX;BNEP-1
80EOR@4;STA#B002;DEY;BNEP-11;RTS;];P.$6
90CLEAR4;F.N=#8000TO#9800 S.4;!N=-1;N.
100MOVE10,0
110F.N=1TO12;PLOT2,0,167;PLOT0,24,0;PLOT2,0,-167;PLOT0,24,0;N.
120MOVE10,0
130F.N=0TO10;PLOT2,238,0;PLOT0,0,24;PLOT2,-238,0;PLOT0,0,24;N.
140MOVE10,50;GOS.z
150F.N=1TO M;BBN=0;N.
160F.R=1TO M;GOS.v
170F.N=0TO6;U=N*32;U?#8010=-(N?GGR)+290;N.
180GOS.a;GOS.s;GOS.u
190IF(BB(R)+O)>70 G.260
200BBR=BBR+O
210GOS.t
220F.J=1TO M
230IF J=R G.250
240IF BBR=BBJ;BBJ=0;P.$7$7$7$7$7
250N.
260GOS.v
270IF BBR=70;GOS.s;GOS.310
280IF O=6 G.170
290N.
300GOS.z;G.160
310F.I=0TO25;?#80=R.;LI.#81;WAIT;N.
320CLEAR0;@=0;P.''"SPELER "R" IS DE WINNAAR !"'';GOS.s
322P."DRUK spatiebalk VOOR EEN NIEUW  SPEL !"'
323LI.#FFE3;RUN
326E.
330zF.Q=5TO60 S.10;MOVE(46+(Q/5)),Q;GOS.b;N.
340F.Q=40TO120 S.10;MOVE(105+(Q/5)),Q;GOS.b;N.
350F.Q=10TO100 S.10;MOVE(160+(Q/5)),Q;GOS.b;N.
360F.Q=40TO120 S.10;MOVE(105-(Q/5)),Q;GOS.c;N.
370F.Q=70TO144 S.10;MOVE(230-(Q/5)),Q;GOS.c;N.
380F.Q=10TO50 S.10;MOVE(250-(Q/5)),Q;GOS.c;N.
390F.Q=10TO50 S.10;MOVE(150-(Q/5)),Q;GOS.c;N.
400Q=35;MOVE100,15;GOS.d
410Q=30;MOVE99,90;GOS.e;Q=20;MOVE90,10;GOS.e
420Q=15;MOVE120,100;GOS.e;Q=33;MOVE150,87;GOS.d
430R.
440REMaF.I=0TO A.R.%5+1;F.N=0TO20
441aP.$7;LI.#FFE3;F.I=0TO A.R.%5+1;F.N=0TO20
450O=N*32;O?#8000=255;O?#8001=255;N.
460O=A.R.%6+1
470IFO=1ORO=3ORO=5;?#8140=254;?#8141=127;?#8160=254;?#8161=127
480IFO=2ORO=3ORO=5;?#8020=159;?#8261=249;?#8040=159;?#8241=249
490IF O=4;?#8020=159;?#8261=249;?#8040=159;?#8241=249
500IF O=4ORO=5ORO=6;?#8021=249;?#8041=249;?#8260=159;?#8240=159
510IF O<>6 G.540
520?#8020=159;?#8261=249;?#8040=159;?#8241=249
530?#8140=159;?#8141=249;?#8160=159;?#8161=249
540N.
550R.
560bPLOT3,2,10;PLOT3,8,0;PLOT3,-1,-5;PLOT3,-8,0;PLOT0,8,0
570PLOT3,-1,-5
580R.
590yIN."HOEVEEL SPELERS(1-6) "M;IF M>6 OR M<1;P.$11;G.y
600DIM BB(M)
610P.'"INDIEN U OP EEN PLAATS TERECHT"'
620P."KOMT WAAR AL IEMAND STAAT,"'"DAN MOET DEZE TERUG NAAR "
625P."ZIJN   STARTPOSITIE."'"zesGEEFT RECHT OP EEN EXTRA WORP"
630P."DRUK spatie VOOR WORP"'
640P."DRUK return VOOR START";LI.#FFE3;R.
650cPLOT3,-2,10;PLOT3,-8,0;PLOT3,1,-5;PLOT3,8,0;PLOT0,-8,0
660PLOT3,1,-5
670R.
680dX=50;Y=50
690F.N=0TO Q
700PLOT3,3,1;PLOT3,(Y/10),1;X=X+Y/3;Y=Y-X/3;N.;R.
710eX=50;Y=50
720F.N=0TO Q
730PLOT3,-3,1;PLOT3,(-Y/10),1;X=X+Y/3;Y=Y-X/3;N.;R.
740xQ=#95DF;F=3
750F.N=1TO70
760Q=Q+F;AAN=Q
770IF N%10=0;N=N+1;Q=Q-#300;F=-F;AAN=Q
780N.
790AA0=#95E0
800R.
810w$GG1="%%%%%%%";$GG2="B4$%'3B";$GG3="B$$B$$B"
820$GG4="335B%%%";$GG5="B33B$$B";$GG6="333B44B"
830R.
840vF.N=0TO6;U=N*32;U?AA(BB(R))=-(N?GGR)+290;N.;R.
850uF.N=0TO6;U=N*32;U?AA(BB(R))=255;N.;R.
860tIF BBR=2;BBR=23;GOS.j
870IF BBR=6;BBR=26;GOS.j
880IF BBR=10;BBR=30;GOS.j
890IF BBR=7;BBR=48;GOS.j
900IF BBR=16;BBR=55;GOS.j
910IF BBR=17;BBR=58;GOS.j
920IF BBR=29;BBR=68;GOS.j
930IF BBR=21;BBR=4;GOS.i
940IF BBR=33;BBR=4;GOS.i
950IF BBR=62;BBR=37;GOS.i
960IF BBR=69;BBR=35;GOS.i
970IF BBR=57;BBR=45;GOS.i
980R.
990jF.I=1TO10;LI.#81;?#80=?#80-8;WAIT;N.;?#80=160;R.
1000iF.I=1TO10;LI.#81;?#80=?#80+8;WAIT;N.;?#80=160;R.
1010sF.S=0TO100;WAIT;N.;R.
