10 REM SCREENS
50 DIMG8,Z-1;GOS.9000
100 S=-1;X=#8000;C=#20202020;W=0
110 DOX?512=#AA;X?513=#55
120 F.I=0TO511STEP4;X!I=C;N.
130 X=X+512;S=S+1
140 U.?X<>#AAORX?1<>#55
200 P.$12;@=2;P."ENTER ;"''
210 P."1-"S" TO EDIT SCREENS"'
220 P." P   TO PLAY SCREENS"'
230 P." S   TO SAVE ON ON TAPE'"'
240 P." L   TO LOAD FROM TAPE"'
250 P." E   TO END"''
260 IN.$Z
265 IF$Z="P"G.2000
270 IF$Z="S"G.3000
275 IF$Z="L"G.4000
280 IF$Z="E"E.
285 GOS.6000
288 IFT>0AND T<(S+1)G.1000
290 P.$11;G.260
1000 D=512*T;W=1
1010 F.I=#8000TO#81FFSTEP4;!I=I!D;N.
1020 !#DE=#80008000;?#8000=(?#8000+#80)&#FF
1030aLI.#FFE6;G.a
2000 IN."SCREENS 1-"$Z;GOS.6000
2010 IFT<1ORT>S P.$11$11;G.2000
2020 E=T
2030 IN."TIME FOR EACH (SECONDS) "$Z
2040 GOS.6000
2050 K=T
2060 IN."NUMBER OF CYCLES "$Z
2070 GOS.6000
2100 F.L=1TO T
2110 F.F=1TO E;D=512*F
2120 F.I=#8000TO#81FFSTEP4;!I=I!D;N.
2130 F.H=0TO60*K;WAIT;N.
2140 N.F
2150 N.L;G.200
3000 IN.'"SCREENS 1-"$Z;GOS.6000
3010 IFT<1ORT>S P.$11$11;G.3000
3020 IN."FILENAME "$Z
3030 T=#8200+512*T;X=#A0
3040 !X=Z;X!2=#8200;X!6=#8200
3050 X?8=T;X?9=T/256
3060 LI.#FFDD;G.200
4000 IN."FILENAME "$Z
4010 T=#8200+512*T;X=#A0;!X=Z;X!2=#8200
4020 LI.#FFE0;G.200
6000 T=0;J=0
6010bIFZ?J<CH"0"ORZ?J>CH"9"R.
6020 T=10*T+Z?J-CH"0";J=J+1;G.b
8000 D=?#DE+?#DF*256+?#E0;?D=(?D+#80)&#FF
8020 D=512*T
8030 F.I=#8000TO#81FFSTEP4;I!D=!I;N.
8040 W=0;G.200
9000 P=#80;P.$21
9010[;LDA@0;STA#B000;JSR#FE94
9020 PHA;LDA@#A;STA#B000;PLA
9030 CMP@#1B;BEQP+3;RTS;BRK
9040]
9050 P.$6;?#20A=#80;?#20B=0
9060 $G="GOTO8000";?16=G&#FF;?17=G&#FFFF/256
9070 R.
