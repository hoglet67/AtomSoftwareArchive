
0REM // BREAKOUT \\ V1
5?35=0;?36=#30
10DIMVV3;!#90=0;;!#94=#FFFFFF;!#98=#55000000
15!#9C=#5555;!#A0=#AAAA0000;!#A4=#AA
17F.I=0TO1
20P=#2880;P.$21;[LDY@0;LDA#82A0,Y;STA#82B0,Y;DEY;BNE#2882
25:VV2LDA#81A0,Y;STA#81B0,Y;DEY;BNEVV2
30:VV1LDA#80A0,Y;STA#80B0,Y;DEY;BNEVV1;LDX#88;LDA#90,X;INC#88
40:VV0STA#80A1,Y;INY;CPY@14;BNEVV0;CPX@20;BNEVV3;LDA@0;STA#88
50:VV3RTS;];P.$6;F=#2800;S=0
55N.
60F!0=#3333333F;F!4=#C0C0C3F
70F!8=#33F0C0C;F!12=#3F3F303F
80F!16=#3F033F03;F!20=#33F3333
90F!24=#3F303F03;F!28=#303F3F03
100F!32=#3F3F333F;F!36=#3030303
110F!40=#333F333F;F!44=#3F333F3F
120F!48=#333F0303;F!52=#303033333F
130F!56=#3F333F30;F!60=#3030303F
140F!64=#3F03033F;F!68=#303F3F33
150F!72=#3F3F303C;F!76=#30303C30
160F!80=#3333303F;F!84=#3F33333F
170F!88=#3333
180gC=0;?#88=0;O=0;Z=0;A=#FF;D=#B001;G=3
190fLI.#FB7D;CLEAR1;D?-1=16;GOS.q;FORI=#8070TO#83F0S.16
200?I=1;I?15=64;N.;FORI=#8071TO#807E;?I=85;N.
205!#8036=#202020
210F.J=0TO2;F.I=1TO14;I?(#80A0+C+16*J)=#AA;I?(#8110+C+16*J)=85
220I?(#8180+C+16*J)=#FF;N.;N.
230yX=12+A.R.%29*2;IFG=0;G.g
240Y=9;PLOT13,X,Y;V=2;W=1;B=#83E9;?B=A;B?1=A;GOS.s
250eIF?D<>127ORB<#83E2G.a
260B?1=0;B=B-1;?B=A;G.b
270aIFD?1&64-0ORB>#83ECG.b
280?B=0;B=B+1;B?1=A
290bP=#8000+(X+V)/8+(63-Y-W)*16
300IFY=54;GOS.n;G.c
310IFX<11ORX>115V=-V;GOS.n;G.m
320IF?P;W=-W;GOS.n;G.h
330IFY<63G.d
340cW=-W;IFZ%120=0C=C+32;G.f
350dIFY<1;G=G-1;G?#8036=0;LI.#FB7D;PLOT15,X,Y;!B=0;G.y
360IF?P;IFY>5;Z=Z+1;?P=0;GOS.s
370pPLOT15,X,Y;X=X+V;Y=Y+W;IFO=100;LI.#2880;O=0
380PLOT14,X,Y;O=O+1;G.e
390nJ=A;A=5;K=Y;Y=120;LINK #FD1D;Y=K;A=J;R.
400sH=Z;FORI=#8004TO#8001S.-1
410xN=H%10*5+F;FORQ=0TO4;I?(Q*16)=N?Q;N.
420H=H/10;IFH=0;I=0
430N.;IFZ>S;S=Z
440R.
450qH=S;FORI=#800DTO#800AS.-1;G.x
460hIFY<5IFP=B+(2-V)/4;V=-V
470G.d
480mIF?P>64;W=-W
490G.p
0 (C) ACORNSOFT 1981
