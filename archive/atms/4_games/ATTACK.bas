
0REM // ATTACK \\ V1
1?35=0;?36=#2D
2P=#2800;P.$21;?#E1=0;@=0
3[LDA#B002;EOR@4;STA#B002;JMP#F6E2;]
5DIMAA4,WW4,BB4;AA0=#8001;AA1=#801E;AA2=#81E1;AA3=#81FE
7WW0=34;WW1=30;WW2=-30;WW3=-34;A=0
8CLEAR0;!#3FE=#2800
10X=#80EF;BB1=X+1;BB2=#810F;BB3=BB2+1;BB0=X;?X=28;?BB1=175
15?BB2=175;?BB3=156;?X=28
20P=#90;[JSR#FE71;STY#322;RTS;];P.$6;Q=0;Z=0;L=0
30dIFA=#3A;?X=?X+128;X=BB2;?X=?X+128;G.z
40IFA=#1F;?X=?X+128;X=BB3;?X=?X+128;G.x
50IFA=#21;?X=?X+128;X=BB0;?X=?X+128;G.a
60IFA=1;?X=?X+128;X=BB1;?X=?X+128;G.s
70U=10-Z/40
75F.I=0TOU;LI.#90;IFA<#FF;F.J=0TOU*2;N.;I=U
77N.;IFQ;P."							"Z
80IFQ;?L=64;L=L+Q;?L=255;Z=Z+1
90IFQ;IFL=BBV;GOS.n;P.$30"YOU SCORED "Z;LI.-29;RUN
95IFL<#8000 ORL>#8200;Q=0
100IFQ=0;IFR.%(3)>1;V=A.R.%4;L=AAV;Q=WWV
999G.d
1000aMOVE0,43;DRAW30,27;PLOT7,0,43;IFX=BBV;?L=64;Q=0
1010G.60
1100sMOVE63,47;DRAW34,27;PLOT7,63,47;IFX=BBV;?L=64;Q=0
1110G.75
1200zMOVE0,0;DRAW30,20;PLOT7,0,0;IFX=BBV;?L=64;Q=0
1210G.40
1300xMOVE63,0;DRAW34,21;PLOT7,63,0;IFX=BBV;?L=64;Q=0
1310G.50
2000nF.R=0TO50;IFR.%2;?#B002=?#B002:4
2010N.;R.
0 (C) ACORNSOFT 1981
