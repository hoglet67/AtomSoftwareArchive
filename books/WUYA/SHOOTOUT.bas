
1REM SHOOT-OUT
4P.$21;GOS.2000
5G=0;H=0;I=0;@=0;B=0;D=0
25P.$12"**********shoot-out*************"
30IN."DO YOU WANT INSTRUCTIONS"$B;IF $B="Y" G.3000
40IN."SKILL LEVEL 1-3 (1=HARDEST)"J;IF J=2 J=4
41IF J=3 J=7
42IF J=1 J=0
45E=5;Z=70;U=24
46M=A.R.%2+1
47Q=A.R.%40+10
50CLEAR1
60COLOUR1
65G.115
70aF.Y=20TO44;MOVE0,Y;DRAW64,Y;N.Y
90COLOUR2;F.Y=20TO45S.5;MOVE0,Y;DRAW64,Y;N.Y
100F.X=0TO128S.7;MOVEX,20;DRAWX,45;N.X
110F.W=10TO(A.R.%70);WAIT;N.W;IF M=1 GOS.1000
111IF M=2 GOS.1200
114R.
115GOS.a
120F.T=0TO J;F.N=1TO30;WAIT;N.N;?#B002=?#B002:4
130IF?#B001=127 AND I<>6;I=I+1;G.700
135IF I=6 G.2500
140N.T
150PLOT4,(Q+3),46;PLOT7,(Q+3),51;PLOT4,(Q+3),51
155PLOT5,(Q+3),51
160COLOUR1;PLOT4,(Q+3),51;PLOT5,(Q+3),51
165IF M=2 G.45
170F.N=1TO5;WAIT;N.N
180A=0
190O=#B002;?O=?O:8
200F.B=2TO4;F.C=0TO50S.B;?#B002=C
210N.;N.;A=A+1;IF A<6 G.190
220P.$12"YOU ARE DEAD!!!!"'
230P."BUT YOU DID KILL "G" SPIES,"'"AND "H" FRIENDS!"'
240END
700COLOUR1;PLOT4,Q,U;PLOT5,Q,U
705?#80=Z;LINK VV0;Z=Z-1
710PLOT4,Q,U;PLOT7,Q,U;U=U+1;IF U<58 G.700
715GOS.a
720IF M=1;F.N=1TO5;?#80=10;LINK VV0;WAIT;WAIT;WAIT;WAIT
725IF M=1;?#80=90;LI.VV0;N.N;G=G+1;IFG=5;G.4000 
726IFM=1;G.45
730IF M=2;F.N=1TO10;?#80=150;LI.VV0;N.N;H=H+1;G.45
740IF G+H=20 G.2500
890END
960F.N=1TO60;WAIT;LINK#21C;N.N;G.45
1000PLOT4,Q,46;PLOT5,Q,54
1010PLOT4,(Q-1),54;PLOT5,(Q+1),54
1020PLOT4,(Q-1),58;PLOT5,(Q+1),58
1030PLOT4,(Q-1),54;PLOT5,(Q-1),58;PLOT4,(Q+1),54
1035PLOT5,(Q+1),58
1040PLOT4,(Q-3),51;PLOT5,(Q+3),51
1050PLOT4,(Q-2),58;PLOT5,(Q-2),58;PLOT4,(Q-1),58
1055PLOT5,(Q-1),60
1060PLOT4,(Q-1),60;PLOT5,(Q+1),60;PLOT4,(Q+1),60
1065PLOT5,(Q+1),58
1070PLOT4,(Q-1),59;PLOT5,(Q+1),59
1080PLOT4,(Q-1),46;PLOT5,(Q-1),52
1090PLOT4,(Q+1),46;PLOT5,(Q+1),52
1100PLOT4,(Q-3),51;PLOT5,(Q-3),48;PLOT4,(Q+3),51
1101PLOT5,(Q+3),48
1102F.S=(Q-2)TO(Q+2);MOVES,0;DRAWS,9;N.S
1105F.R=(Q-1)TO(Q+1);MOVER,9;DRAWR,23;N.R
1110R.
1200PLOT4,Q,46;PLOT5,Q,54
1210PLOT4,(Q-1),54;PLOT5,(Q+1),54
1220PLOT4,(Q-1),58;PLOT5,(Q+1),58
1230PLOT4,(Q-1),54;PLOT5,(Q-1),58;PLOT4,(Q+1),54
1235PLOT5,(Q+1),58
1240PLOT4,(Q-3),51;PLOT5,(Q+3),51
1250PLOT4,(Q-2),58;PLOT5,(Q+2),58;PLOT4,(Q-1),58
1255PLOT5,(Q-1),60
1260PLOT4,(Q-1),60;PLOT5,(Q+1),60;PLOT4,(Q+1),60
1265PLOT5,(Q+1),58
1270PLOT4,(Q-1),59;PLOT5,(Q+1),59
1280PLOT4,(Q-1),46;PLOT5,(Q-1),52
1290PLOT4,(Q+1),46;PLOT5,(Q+1),52
1300PLOT4,(Q-3),51;PLOT5,(Q-3),54;PLOT4,(Q+3),51
1305PLOT5,(Q+3),54
1310F.V=(Q-2)TO(Q+2);MOVEV,0;DRAWV,9;N.V
1315F.A=(Q-1)TO(Q+1);MOVEA,9;DRAWA,23;N.A
1320R.
2000DIMVV4,A(5),B(5),P-1
2005L=#B002
2010[;:VV0 LDA L;:VV1 LDX #80;:VV2 DEX
2020BNE VV2;EOR@4;STA#B002;DEY;BNE VV1;RTS;]
2025P.$6
2030R.
2500F.N=0TO5;?#80=5;LINKVV0;N.N
2505P.$12
2510P."YOU HAVE USED ALL YOUR BULLETS."'
2520P."YOU KILLED "G" SPIES,"'"AND "H" OF YOUR FRIENDS!"'
2540END
3000P.$12"**********instructions**********"
3010P."YOU ARE A BRITISH SECRET AGENT"'
3020P."AND YOUR MISSION IS TO KILL AS"'
3030P."MANY FOREIGN SPIES AS POSSIBLE"
3040P.". BUT be careful BECAUSE SOME"'
3050P."OF YOUR MEN MIGHT POP UP FROM"'
3060P."BEHIND THE WALL. THEY WILL HAVE"'
3070P."THEIR HANDS UP, THE ENEMY WON'T!"
3075P."PRESS shift TO FIRE YOUR PISTOL."
3076P."REMEMBER, YOU ONLY HAVE SIX"'"SHOTS."'
3080P."PRESS return.";LI.#FFE3;P.$12;?#E1=0
3090P."A NOISE WILL BE MADE IF YOU HIT"'
3095P."A PERSON. PRESS 'G' FOR THE"'
3100P."NOISE WHICH IS MADE WHEN YOU HIT"
3105P."A SPY AND 'Q' FOR THE NOISE"'
3110P."WHICH IS MADE WHEN YOU HIT A"'
3115P."FRIEND."'
3120IF?#B001<>239;G.3130
3122F.N=1TO5;?#80=10;LI.VV0;WAIT;WAIT;WAIT;WAIT
3125?#80=90;LI.VV0;N.N;B=1
3130IF?#B001=247;F.N=1TO10;?#80=150;LI.VV0;N.N;D=1
3140IF B=0 OR D=0;G.3120
3150P."PRESS A KEY TO START"';LI.#FFE3;P.$12;?#E1=0;G.40
4000P.$12"WELL DONE! YOU SHOT ALL THE     SPIES WITH "I
4010P." BULLETS!"';END 
