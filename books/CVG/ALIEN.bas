
1GOS.c
10DIM FF0,KK9,MM0,PP0,ZZ15,SS5
11P.$12;M=24;MM0=-1;PP0=-1;KK8=-1;T=#B002
12F.N=1TO 2;DIM P-1;P.$21
16[
17:FF0 LDA@128;BIT#B002;BNE FF0;LDA #82;RTS
20:KK0 LDA @3;STA#B000;LDA#B001;CMP@#FE;BNE KK1
22LDA#AA;CMP@13;BEQ ZZ2;LDA#87;STA#81;LDA#86;STA#80
24LDY@0;LDX@#20;STX#85;JSR MM0;LDY@0;LDA(#80),Y;CMP@24;BEQ ZZ2
26LDA#81;STA#87;LDA#80;STA#86;LDA@127;STA#82;JSR FF0
27STA(#86),Y
28LDX#AA;INX;STX#AA;RTS
30:ZZ2 JMP KK8
70:KK1 LDA@3;STA#B000;LDA#B001;CMP@#7E;BNE KK2
72LDA#AA;CMP@13;BEQ ZZ2
74LDA#87;STA#81;LDA#86;STA#80;LDX@#20;STX#85;JSR MM0
76LDY@0;LDA(#80),Y;CMP@24;BEQ ZZ4;LDA#81;STA#87;LDA#80;STA#86
78LDA@64;STA#82;JSR FF0;STA(#86),Y;LDX#AA;INX;STX#AA;RTS
80:ZZ4 JMP KK8
120:KK2 LDA@2;STA#B000;LDA#B001;CMP@#FE;BNE KK3
122LDA#AA;CMP@0;BEQ ZZ6;LDA#87;STA#81;LDA#86;STA#80;LDX@#20
124LDY@0;STX#85;JSR PP0;LDA(#80),Y;CMP@24;BEQ ZZ6
126LDA#81;STA#87;LDA#80;STA#86;LDA@127;STA#82;JSR FF0
127STA(#86),Y;LDX#AA;DEX;STX#AA;RTS
130:ZZ6 JMP KK8
170:KK3 LDA@2;STA#B000;LDA#B001;CMP@#7E;BNE KK4
172LDA#AA;CMP@0;BEQ ZZ6;LDA#87;STA#81;LDA#86;STA#80;LDX@#20
174STX#85;JSRPP0;LDA(#80),Y;CMP@24;BEQZZ8
176LDA#81;STA#87;LDA#80;STA#86;LDA@64;STA#82;JSRFF0
177LDY@0;STA(#86),Y;LDX#AA;DEX;STX#AA;RTS
178:ZZ8 JMPKK8
220:KK4 LDA@6;STA#B000;LDA#B001;CMP@#FE;BNEKK5
222LDA#90;CMP@1;BEQZZ10;LDA#87;STA#81;LDA#86;STA#80;LDX@1
224STX#85;JSRMM0;LDY@0;LDA(#80),Y;CMP@24;BEQZZ10
226LDA#81;STA#87;LDA#80;STA#86;LDA@127;STA#82;JSRFF0
228LDY@0;STA(#86),Y;LDX#90;DEX;STX#90;RTS
230:ZZ10 JMPKK8
270:KK5 LDA@6;STA#B000;LDA#B001;CMP@#7E;BNEKK6
272LDA#90;CMP@1;BEQZZ12;LDA#87;STA#81;LDA#86;STA#80;LDX@1
274STX#85;JSRMM0;LDY@0;LDA(#80),Y;CMP@24;BEQZZ12;LDA#81
275STA#87
276LDA#80;STA#86;LDA@64;STA#82;JSRFF0;STA(#86),Y;LDX#90
278DEX;STX#90;RTS
300:ZZ12 JMPKK8
320:KK6 LDA@6;STA#B000;LDA#B001;CMP@#FD;BNEKK7
321LDY@0
322LDA#90;CMP@30;BEQZZ13;LDA#87;STA#81;LDA#86;STA#80;LDX@1
324STX#85;JSRPP0;LDA(#80),Y;CMP@24;BEQZZ13;LDA#81;STA#87
330LDA#80;STA#86;LDA@127;STA#82;JSRFF0;STA(#86),Y
335LDX#90;INX;STX#90;RTS
340:ZZ13 JMPKK8
370:KK7 LDA@6;STA#B000;LDA#B001;CMP@#7D;BNEKK8
372LDA#90;CMP@30;BEQKK8;LDA#87;STA#81;LDA#86;STA#80
373LDY@0;LDX@1
374STX#85;JSRPP0;LDA(#80),Y;CMP@24;BEQKK8;LDA#81;STA#87
376LDA#80;STA#86;LDA@64;STA#82;JSRFF0;STA(#86),Y
378LDX#90;INX;STX#90;RTS
420:KK8 RTS
1300:MM0 SEC;LDA#80;SBC#85;STA#80;LDA#81;SBC@0;STA#81;RTS
1310:PP0 CLC;LDA#80;ADC#85;STA#80;LDA#81;ADC@0;STA#81;RTS
1311:SS0 STY#83
1312:SS1 LDAT;LDY#84
1313:SS2 LDX#85
1314:SS3 DEX;BNESS3;EOR@4;STAT;DEY;BNESS2;LDY#83;RTS
1318]
1319N.N;P.$6
1320CLEAR0;S=0
1321F.N=32768TO32799;LINKFF0;?N=127;N.
1322F.N=33248TO33279;LINKFF0;?N=127;N.
1323F.N=32800TO33216S.32;LINKFF0;?N=127;N.
1324F.N=32831TO33247S.32;LINKFF0;?N=127;N.
1330?#86=#8F;?#87=#81
1332?#AA=2;?#90=15
1333F.N=1TO26;?#818F=#2A;LINKFF0;?#8021=#3C;?#8022=#2D;LINKFF0
1334?#8023=#2D;?#8024=#14;?#8025=#12;?#8026=1;?#8027=#10
1335LINKFF0;?#818F=127;WAIT;?#818F=#2B;F.G=#8021TO#8027;?G=64
1336N.;LINKFF0;N.;?#818F=127
1339X=A.R.%(33278-33088)+33088
1340IF?X<>#40G.1339
1370?X=M
1375GOS.r
1377IFX?D<>#40 G.1375
1379?X=64;LINKFF0;X?D=M;X=X+D;S=S+1
1380LINK KK0
1390IFX=#8021 AND?#8022=127 AND?#8041=127 G.10000
1400IFX?1=127ANDX?-1=127ANDX?-#20=127ANDX?#20=127 G.l
2005G.1375
3000rA=(A.R.%4)+1
3001IFA=1 D=-32;R.
3002IFA=2 D=32;R.
3003IFA=3 D=-1;R.
3004IFA=4 D=1;R.
10000F.N=1TO40;?#83=66;?#84=66;LINKSS0
10020?#84=32;?#83=32;LINKSS0;N.
11000P.$12"THE ALIEN IS IN THE TRAP!!!"
15030F.N=1TO80;WAIT;N.
18948P.$12"YOUR SCORE IS..."S'''''
18958GOS.v;G.1320
20001lF.A=1TO39;LINKFF0;?X=63;LINKFF0;?X=24;N.
20002P.$12"YOUR SCORE IS  "S+2985"!!!!"''
20003F=100;D=100
20004F.O=1TO44;?#84=D;?#85=F;LINKSS0;D=D-2;F=F-1;N.
20005F.I=1TO44;?#84=D;?#85=F;LINKSS0;D=D+2;F=F+1;N.;P.$7
20006P."YOU'VE CRASHED"'
20007P."THE ALIEN !!"''';?#E1=0
20010F.N=1TO93;WAIT;N.;G.1320
32000cP.$12"*******alien trap *******"'
32101P."TRAP THE""ALIEN""IN THE TOP"'
32102P."L.H. CORNER OF THE SCREEN"'
32103P."USING THE FOLLOWING KEYS:"'''
32104P."] ..............IS FOR LEFT"''
32105P."RETURN ........IS FOR RIGHT"''
32106P."UP/DOWN ARROW ..IS FOR DOWN"''
32107P."AND L/R ARROW ....IS FOR UP"'';F.J=1TO5;GOS.b;N.
32108P."[USE ""SHIFTED"" KEYS TO ERASE]"'';F.N=1TO10;GOS.b;N.
32109P."press shift to continue"
32110DOWAIT;U.?#B001<>#FF
32111F.N=#8000TO#81FF;?N=32;N.;R.
32112bF.N=1TO60;WAIT;N.;R.
32120v?#E1=0;IFS<=100P."    EXCELLENT";G.32130
32121IFS<=175P."GOOD";G.32130
32122IFS<=210P."GOOD";G.32130
32123IFS<=245P."AVERAGE";G.32130
32124IFS<=300P."POOR";G.32130
32125IFS<=400P."BAD";G.32130
32126IFS<=500P.VERY BAD";G.32130
32130GOS.b;R.
