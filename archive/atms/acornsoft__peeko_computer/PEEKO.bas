
1REM // PEEKO //V3
2P.$12"INITIALISING";G.400
10BRK
12GOS.g;G.k
20LDA
22GOS.m
24GOS.f;?A=?N;?X=?A;G.p
30STA
32GOS.m
34GOS.i;?N=?A;?X=?N;GOS.i;GOS.b;G.p
40CLC
42?C=48;G.p
50ADC
52GOS.m;?A=?A+?N+?C-96;?C=48;IF?A>57A?0=?A-10;?C=49
56?X=?A;G.p
60DEC
62GOS.m;?N=?N-1;IF?N<48N?0=?N+10
66?X=?N;GOS.b;G.p
70INC
72GOS.m;?N=?N+1;IF?N>57N?0=?N-10
76?X=?N;GOS.b;G.p
80LDA @
82GOS.t;?A=?M-128;?X=?A;G.p
90JMP
92GOS.m;GOS.i;M=N;GOS.i;G.q
100JNE
102GOS.m;IF?X=48GOS.i;M=N;GOS.i;G.q
106G.p
110SEC
112?C=49;G.p
120SBC
122GOS.m;?A=?A-?N+?C-1;?C=49;IF?A<48A?0=?A+10;?C=48
128?X=?A;G.p
130CMP @
132GOS.t;?X=49;IF?A=?M-128?X=48
134G.p
140JCC
142GOS.m;IF?C=48GOS.i;M=N;GOS.i;G.q 
146G.p
150JCS
152GOS.m;IF?C=49GOS.i;M=N;GOS.i;G.q
156G.p
160JEQ
162GOS.m;IF?X=49GOS.i;M=N;GOS.i;G.q
166G.p
170DECA
172?A=?A-1;IF?A<48A?0=?A+10 
174?X=?A;G.p
180INCA
182?A=?A+1;IF?A>57A?0=?A-10
184?X=?A;G.p
190LDA (
192GOS.m;J=M;M=N;GOS.i;GOS.5805;GOS.i;M=J;G.24
200STA (
202GOS.m;J=M;M=N;GOS.i;GOS.5805;GOS.i;M=J;G.34
400C=#8071;A=C+13;S=C+50;E=#81BE;X=C+7;@=1
410G=#80;K=#B000;U=0;I=#3BC0;Y=I+20;O=Y+10;G?1=0;G?3=0
420?35=0;?36=40;DIMAA19;F.D=0TO19;DIMJ6;AAD=J;N.
430F.D=0TO9;Y?D=D*10+12;N.
440D=#2900;P=0;DOP=P+10;DOD=D+1;U.?D=13A.D?2=P;T=P/10-1
460$AAT=$D+3;D=D+17;U.P=200
490!O=#20200;O!4=#1020202;O!8=#2000202;O!14=O!4;O!18=O!8
495O!10=!O;O!22=#2020201;O!26=#3030000
670Z=#3B80;B=#B800;B?2=15;B?3=0;T=C-69;R=T+14;P=176
690P.$12;?#E1=0;P."READY  INPUT PORT   OUTPUT PORT"'
700P."PROG     98            99"'"RUN"'
720P."           CARRY   ZERO   ACC"'
730M=S-3;FORD=0TO4;M?(D*64)=48+D;N.
750M=E+37;F.D=0TO9;M?(D*3)=48+D;N.;M=T;GOS.x;?T=48;M=C;GOS.x
770?C=48;M=A;GOS.x;M=R;GOS.x;?R=48;M=X;GOS.x;?X=48
780F.D=0TO4;F.F=0TO9;M=S+D*64+F*3;GOS.x;N.;N.;F=#8000
790M=S;GOS.i
800kGOS.1800;J=0
809DOU=0;GOS.w;Q=0;DOQ=Q+1;LI.Z;U.?G<255ORQ=10
810U.?G<255;IFV P.$30"READY";V=0
820GOS.c;F=C-81;D=?G;IFK?1<128G.r
830IFD>15IFD<26G.1500
840J=0;IFD=6GOS.t;G.k 
850IFD=7G.u
870IFD=50G.690
880IFD=0W=1;G.s
890IFD=39W=0;G.s
900IFD=44G.6500
910IFD=41G.9000
920IFD=38U=1;W=0;G.s
930IFD=34P.$12;E.
940IFD=51G.6600
950IFD=48G.9400
960IFD=47G.12
970IFD=46G.8700
990G.k
1000sGOS.c;F=C-49;GOS.i;M=S;GOS.i;G.q
1010pIF?X<>48;?X=49
1011?X=?X:1;?A=?A&#7F;GOS.t
1020qIFW GOS.1800;DOGOS.w;LI.Z;U.?G<255
1040LI.Z;IF?G=37G.12
1050IF?G=38U=1;W=0;IF?F>128GOS.v
1060IF?G=39W=0;U=0
1070G.(Y?(?M-P))
1500LI.#3B9F;?M=32+D;GOS.n;GOS.i;IFJ>0G.1600
1520GOS.1850;D=D-16;L=AA(Y?D/10-1);P.$L;J=O?D;H=C-17+L.L+J
1530IFJ=3H=H-1;H?2=41;J=J-1
1540IFJ>0;?H=35;IFJ=2H?-1=35
1550G.809
1600?H=D+32;J=J-1;H=H-1;G.809
1800L=M;GOS.1850;D=?M-176;P.$AA(Y?D/10-1);IFO?D=0G.1840
1815IFM>E-O?D*2G.1840
1820P." ";GOS.n;IFO?D=1P.?M-48;G.1840
1830H=?M-48;GOS.n;P.?M-48,H
1840IFO?D=3P." )"
1845M=L;R.
1850!#DE=C-17;P."           ";?#E0=0;R.
2000rIFD=7G.d
2010IFD=6G.l
2013IFD=30G.8000
2017IFD=28G.8500
2020G.k
3000eGOS.c;P.$7$30"ERROR";F=#8000;V=1;G.k
4000x?M=48+A.R.%10;M?-1=#D5;M?1=#EA;M?31=#D0;M?32=#F0;M?33=#E0
4010R.
4200nIFM=E R.
4210M=M+3;IFM?1<>#EA M=M+34
4220R.
4400iWAIT;?M=?M:128;R.
4600wIFU R.
4610vF.D=0TO4;WAIT;F?D=F?D:128;N.;R.
5000jGOS.i;M=M+J;GOS.i;G.k
5200uIFM<S+64G.k
5210J=-64;G.j
5300dIFM>E-64G.k
5310J=64;G.j
5400lIFM=S;G.k
5410IFM&15=3J=-37;G.j
5420J=-3;G.j
5800mGOS.t;IFM>E-4N=90;M=E;R.
5805L=?M-176;GOS.t;H=?M-176;N=S+L*3+H*64;IFN=S+603N=R;R.
5820IFN=S+600N=T;R.
5830IFH>4V=1;?20=?20-1;G.e
5840R.
6000tGOS.i;GOS.n;GOS.i;GOS.w;R.
6010cIF?F>128GOS.w
6020R.
6100bIFN<>R R.
6110D=?N-48;IFB?1<255D=D+3
6120?B=D;R.
6200fIFN<>T;R.
6210?N=?B/16+48;?C=48;IF?N>57;?N=?N-10;?C=49
6220R.
6300gGOS.c;F=#8000;GOS.i;M=S;GOS.i;R.
6410zLI.#3B86;D=2*?G-92;IFD<4ORD>22G.z
6420R.
6500F=#8045;!F=#84818F8C;GOS.z;G?4=G;G?2=G+D;G.6700
6600F=#8045;!F=#85968193;GOS.z;G?2=G;G?4=G+D
6700!F=#20202020;GOS.g;IF?(G!1)<>18G.e
6710LI.#3B8C;GOS.w;G.k
8000D=0
8001GOS.i;GOS.8800;P.$12';IN."FILE"$I;L=#83E0;F.J=0TO9
8005?L=O?J;L?10=Y?J;L=L+1;N.;J=256;$J="SAVE""";IFD$J="LOAD"""
8015$J+5=$I;$J+L.J=""" 82A0";IFD=0$J+L.J=" 8400"
8020LI.#FFF7
8026L=#83E0;F.J=0TO9;O?J=?L;Y?J=L?10;L=L+1;N.
8027F.L=#83E0TO#83FF;?L=32;N.;J=#83E3;F.L=0TO9;J?(L*3)=48+L;N.
8030GOS.8850;?#E1=0;G.790
8500D=1;G.8001
8700J=O?(?M-P);IFJ=3J=2
8710F.L=0TOJ;GOS.t;N.;G.k
8800G!1=#82008000
8810LI.#3B8C;R.
8850G!1=#80008200;G.8810
9000GOS.i;GOS.8800;P.$12"PRESENT SET"'';H=#E0;H?1=0
9010aP.$30'';F.D=0TO9;P.D" "$AA(Y?D/10-1);P."  "';N.
9100GOS.y;IN."CHANGE ANY"$I
9110IF?I=13OR?I=78GOS.8850;M=S;GOS.i;G.k
9115IF?I=83F.D=0TO9;Y?D=D*10+12;O?D=O?(D+10);N.;G.a
9120IF?I=89GOS.y;IN."WHICH"$I
9130GOS.9350;D=F;IFD<0ORD>9P.$7;G.a
9140IF?X<>32G.o
9145P.$30;?H=16;P."CHOOSE FROM:-"''
9150F.F=0TO19;?H=11*(1+F%2);P.F" "$AAF;IFF%2P.'
9160N.
9165oGOS.y;P."WHAT SHOULD "D" BE";IN.$I;GOS.9350
9180IFF<0ORF>19P.$7;G.o
9190Y?D=F*10+12;O?D=O?(F+10);G.a
9300y!#DE=#81A0;F.F=0TO22S.4;F!#81A0=#20202020;N.;R.
9350F=0;DOIF?I<48OR?I>57F=30;I?1=13
9360F=10*F+?I-48;$I=$I+1;U.?I=13;R.
9400P.$2$21$14;GOS.i;F.H=0TO511;L=H?#8000;IFL<#80L=L:96
9403L=L-32;IFL=#B5L=#7B
9404IFL=#CAL=#7D
9405IFL>127L=32
9408IFH%32=0P.'
9410P.$L;N.;P.'$15$3$6;GOS.i;G.k
0 (C) ACORNSOFT 1981
