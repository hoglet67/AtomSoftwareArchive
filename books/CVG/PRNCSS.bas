
10 D=#84;E=#2A;H=#88;L=#8B;M=#F;N=#B002
11 REM DOWNSTAIR,ENEMY,HIDING,KEY,ME,L/SPEAKER
15 O=#FF;Q=9999;S=#8020;U=#95;Y=0;Z=#81FF
16 REM OBSTRUCTION,SCREEN 2ND LINE,SCREEN END
20 DIM EE(10),G9,HH(3),KK0,W3
21 REM KEYS GOT,ADDRESS OF HIDES,ASSEMBLER LABEL
22 REM CONTENTS OF HIDES,ASSEMBLER ADDRESS
30 DIM P-1;P.$21;[;:KK0 JSR #FE71;STY #80;RTS;];P.$6
31 REM INKEY$ SUB
35 T=0;V=0;GOS.5000;REM INSTRUCTIONS
40 A=S+A.R.%(Z-S);B=9;F=0;P=0;REM NEW GAME
41 REM ME POSITION,BOLTS,FLOOR,NO P/CESS
50 F.I=0TO9;G?I=I+48;N.I;G.62;NO KEYS YET
59 REM START NEW FLOOR AT 60,NEW MOVE AT 100
60 P.$7;F.I=1TO60;WAIT;N.I
62 P.$12"KEYS             BOLTS    FLOOR ";?(S-9)=B+48
65 F.I=1TO5*F+15;S?(A.R.%(Z-S))=O;N.I;REM OBSTRUCTIONS
70 F.I=0TO10;EE(I)=S+A.R.%(Z-S);N.I;REM ENEMY POS.
72 F.I=0TO F;?EE(I)=E;N.I;REM PLACE ENEMY
75 F.I=1TO2;S?(A.R.%(Z-S))=D;S?(A.R.%(Z-S))=U;N.I
76 REM PLACE STAIRS
80 F.I=0TO3;HH(I)=S+A.R.%(Z-S);?HH(I)=H;N.I;REM HIDE
82 F.I=0TO3;W?I=32;N.I;W?(A.R.%4)=E;W?(A.R.%4)=L
83 REM ENEMY, KEY HIDDEN
85 ?A=M;?(S-1)=48+F;F.I=0TO9;S?(I-27)=G?I;N.I
86 REM KEYS GOT ON SCREEN
87 ?(S-1)=G?F;P.$7;REM INVERT FLOOR NO.
100 LINK KK0;K=?#80;REM SCAN KEYBOARD
110 IF K>40;IF K<46;GOS.(80+K);G.130
120 G.300
121 C=-32;R.
122 C=-1;R.
123 C=0;R.
124 C=1;R.
125 C=32;R.
130 IF A+C>=S;IF A+C<=Z;G.145; STAY ON SCREEN
145 IF ?#B001&64=0;G.4000;FIRE
150 IF A?C=32;G.250;MOVE OK
160 I=0;IF A?C<>H;G.200;NOT HIDE
170 IF HH(I)<>A+C;I=I+1;IF I<4;G.170;REM ADDRESS?
180 A?C=W?I;IF A?C=E;P.$7$7;EE(F+1)=A+C;G.100
185 REM ENEMY HIDING
190 IF A?C<>L;G.200;NOT KEY
195 G?F=F+176;S?(F-27)=G?F;?(S-1)=G?F;G.(100+F/9*2900)
200 IF A?C=U;F=F+1;G.2000;UP ONE FLOOR
210 IF A?C=D;F=F-1;G.1000;DOWN ONE
240 G.300
250 ?A=32;A=A+C;?A=M;REM MOVE ME
300 REM MOVE ENEMY
310 F.I=0TO10;C=EE(I)+32*(A>EE(I))-32*(A<EE(I))
312 IF C<S;G.330
315 IF C>Z;G.330;KEEP ON SCREEN
320 IF A=C;IF?EE(I)=E;P.$30$7'"SPLAT-YOURE DEAD"';M=0
325 IF?C=32;IF?EE(I)=E;?C=E;?EE(I)=32;EE(I)=C
330 N.I;?N=?N:4;T=T+1;REM MOVE ONE ROW, CLICK
340 IF M=0;M=#F;?A=#AB;LINK #FE94;G.35;MARK GRAVE
350 G.100
1000 IF F>0;G.60;DOWN STAIR
1010 P.$12"YOU ARE OUT OF THE CASTLE"';IF P;G.1030
1020 P."WITHOUT THE PRINCESS!"'"GO BACK YOU COWARD";F=0;G.60
1030 P."IN"T" SECONDS WITH "V"KILLS"
1040 P."BEST IS"Q"AND"Y;IF T<Q;T=Q;Y=V
1050 P."WELL DONE THOU BRAVE KNIGHT!";LINK #FE94;G.35
2000 IF F<10;G.60;UP STAIR
2010 P.$12"YOU ARE ON THE ROOF!"'"WHO DO YOU THINK YOU ARE?"
2020 P.'"BATMAN?";F=9;G.60
3000 I=0;REM KEY HIDDEN
3010 IF G?I>128;IFI<9;I=I+1;G.3010
3020 IF I<9;P.$12$7"YOU MUST COLLECT ALL KEYS";G?9=H;G.60
3030 P.$12$7"THE PRINCESS";P=1;G.60
4000 B=B-1;I=0;IF B<0;G.100;FIRE BOLTS
4010 I=I+1;?N=?N:4;IF A?(I*C)=32;A?(I*C)=#2E;G.4010;DOTS
4020 I=0;IF A?(I*C)=E;V=V+1
4025 I=O
4030 I=I+1;?N=?N:4;IF A?(I*C)=#2E;A?(I*C)=32;G.4030
4040 A?(I*C)=32;?(S-9)=B+48;G.100
5000 P.$12''"SAVE THE PRINCESS"'"BY G.E.TAYLOR"''
5010 P."FORWARD   = I"'
5020 P."LEFT   = J      L = RIGHT"'
5030 P."BACKWARD  = M"'
5040 P."FIRE = CTRL"'
5050 P.$(D-32)$(U-32)" STAIRS  "$(O-32)" OBSTRUCTIONS"'
5060 P.$(M+64)" YOU  "$E" ENEMY"'
5070 P."PRESS RETURN";LINK #FE94;R.
