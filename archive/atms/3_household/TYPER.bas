
0REM // TYPER \\ V2
4?35=0;?36=#32
5DIMKK6,U65,Z0,B31,D1;W=2500;V=#8040;@=5;F=0;A=#3100
20DOA=A+1;U.?A=CH"z"A.A?1=CH"z";A=A+2;P.$21;GOS.q;P.$6
250$U="Yf��jIlnpSrtv��UWEKhMQ�G�O�z[|< �$&(*,.024:x�8��6$&("
257$U+#34="*,.024:x�8��";G.t
310cP.$12;?#E1=0;?V=32
320F.J=V+34TOV+65S.31;GOS.370;?J=#CF;N.
330I=0;J=V+98;GOS.380;GOS.390;GOS.380;J=J+12;GOS.390;GOS.380
340I=I+4;J?I=#CF;J=V+#83;GOS.370
350J=V+#A9;F.I=0TO12S.4;J!I=#C3C3C3C3;N.;J?(I-1)=32;R.
370F.I=0TO24S.4;GOS.380;N.;R.
380J!I=#20CF20CF;R.
390F.I=4TO8S.4;J!I=#204F204F;N.;R.
600eS=0;H=0;P.$30E/4'''''''''';F.I=0TO31;B?I=?(A.R.%(E+2)+A)
615R=0;N.;B?I=13;P.$B;J=#8140;F.I=0TO31;C=J?I
635X=V?(U?C);WAIT;V?(U?C)=C
637IFC>32IFC<39V?#9B=#8F;F=1
638IF(C>38 A.C<44)OR(C>59 A.C<64)V?#85=#8F;F=2;L=0
645gLI.KK0;IF?Z=31 WAIT;L=L+1;G.g
650IFL>600 L=600
660Y=?Z;H=H+L;IFY=#EF I=99;N.;G.p
665IFY<>B?I R=R+1;P.$7$126$8;GOS.h;L=0;G.g
670P.$Y;S=S+1;WAIT;V?(U?C)=X;IFF=1V?#9B=#CF;G.672
671IFF=2V?#85=#CF
672F=0;GOS.h;N.;O=O+R;Q=Q+S;M=M+H;P.$11;LI.#FE22
690hL=0
692iLI.KK6;IF?Z<>31 WAIT;L=L+1;G.i
694IFL>600 L=600
695H=H+L;R.
900bP.$12';IN."EXERCISE DIFFICULTY (1-9)"$D;IF?D<49OR?D>57;G.b
930E=(?D-48)*4;R.
950pP.$12"PRESENT DIFFICULTY ="E/4'';?#E1=0
955P."CORRECT KEYSTROKES ="Q''"ERROR KEYSTROKES   ="O''
965IFO+Q=0G.975
970P."ERROR/TOTAL        ="O*100/(O+Q)"%"''"KEYBOARD TIME USED"
975P." ="M/60/60" MIN."';@=25;P.(M/60)%60" SECS."'';@=5
980IFM=0G.988
985P."KEYSTROKES PER HR. ="Q*3600/(M/60)''
988P.''"*TYPE ~ TO RETURN TO EXERCISES*";DOLI.KK0;U.?Z<>31
992IF?Z<>#EF G.988
994DOLI.KK0;U.?Z=31
1000tGOS.b;O=0;Q=0;M=0;GOS.c
1030GOS.e
1040IFR>5 G.1030
1050IFH<W E=E+2;G.1070
1060E=E-1;IFE<0 E=0
1065G.1030
1070IFE<44 G.1030
1078P.$12'''''"YOU HAVE SUCCESSFULLY COMPLETED"'"   THE COURSE"
1081IN.".DO YOU WANT TO     IMPROVE YOUR SPEED? (Y OR N)"$D
1085IF?D=CH"N";P.$12;E.
1090IF?D<>89 G.1081
1095W=W*3/4;G.t
1200qF.I=0TO1;P=#80;[:KK6LDA#B002;EOR@4;STA#B002
1215:KK0LDY@#5B;LDA@32;LDX@0;STX#B000;:KK1LDX@10
1225:KK2BIT#B001;BEQKK3;INC#B000;DEY;DEX;BNEKK2;LSRA
1230:KK3PHP;LDX@0;STX#B000;PLP;BNEKK1;TYA;CMP@31;BEQKK5
1232CMP@#24;BNEP+4;LDA@#FF
1235BIT#B001;PHP;CMP@60;BCCKK4;CMP@64;BCSKK4;PLP;BPLKK5
1240AND@#EF;BNEKK5;:KK4PLP;BMIKK5;AND@#EF
1250:KK5STAZ;LDX@15;STX#B000;RTS;];N.;R.
2000zzASDFJKL; GHWEIOM,XCNVBYTRUQZP.6758493201:?-/
0 (C) ACORNSOFT 1981
