
0 REM***WORM***A.P.M.***          27*2*81***
10bK=#B000;L=K+1;X=16;Y=8;C=272;B=#8000;D=0;P.$12;@=0;?#E1=0
100aZ=0;DOZ=Z+1;?K=3;IF?L<255Z=20;Y=Y-1;IFY<0Y=15
110?K=1;IF?L<255Z=20;X=X+1;IFX>31X=0
120?K=5;IF?L<255Z=20;Y=Y+1;IFY>15Y=0
130?K=2;IF?L<255Z=20;X=X-1;IFX<0X=31
140U.Z=20
150A=(Y*32)+X;IFB?A=#52ORB?A=255G.c
160B?A=42;B?C=#52;C=A
170R=A.R.%512;IFR?B<>32G.170
180B?R=255;D=D+1;P.$30D;F.Z=1TO10;WAIT;N.;G.a 
190cP.$7$7$7;LINK#FFE3;G.b
200END
