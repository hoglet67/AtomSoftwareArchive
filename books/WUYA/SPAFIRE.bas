
0REM SPACEFIRE
5DIM VV5,A2,BB0,AA5,W20,P-1;P.$21;AA0=0;BB0=0;G.2000
6@=0;Y=495;A=14;B=15;C=16;X=A.R.%7;D=#40;E=D;F=D;T=0;V=0;I=0
7AA1=0;P.$12;P."DO YOU WANT INSTRUCTIONS   (Y/N)";DO LINK VV0
8U.?#80=57 OR ?#80=46;IF?#80=57;G.6000
9IF?#80<>46;G.7
10@=0;Y=495;A=14;B=15;C=16;X=A.R.%7;D=#40;E=D;F=D;T=0;V=0;I=0
11J=300;K=364;L=333;M=331;R=332;$W="MR.X"
12U=#40;O=U;P=U;Q=U;S=U
15AA3=R.%5;A=A+AA3;B=A+1;C=B+1;AA5=X;IF AA5=0;X=32
16IF AA5=1;X=31
17IF AA5=2;X=33
18IF AA5=3;X=34
19IF AA5=4;X=30
20IF AA5=5;X=35
21IF AA5=6;X=29
22H=X;IF AA1=1;R.
50P.$12;?#E1=0
70F.N=0TO185;Z=A.R.%416+64;Z?#8000=#A0;N.N
80F.N=0TO15;N?#8000=#A0;N.N;?#8010=#AA;F.N=17TO31;N?#8000=#A0
85N.N
90Y?#8000=#01;Y?#8000=#40
100LINK VV0;IF?#80=50;IF Y>16;IF(Y-32)?#8000<>#A0;Y=Y-32
110IF?#80=39;IF(Y+1)?#8000<>#A0;Y=Y+1
120IF?#80=36;IF(Y-1)?#8000<>#A0;Y=Y-1
130IF?#80=35;IF Y<480;IF(Y+32)?#8000<>#A0;Y=Y+32
140Y?#8000=#01
150IF(Y-32)?#8000=#AA;G.300
190F.N=1TO5;WAIT;N.N
200T=T+1;IF T=7;T=0;AA0=AA0+1;P.$30"time"AA0;?#B002=?#B002:4
205IF AA0=200;G.5010
210G.90
300?#14=0;P.$12;?#E1=0;F.N=0TO200;Z=A.R.%512;Z?#8000=#2E;N.N
301F.N=0TO8;Z=A.R.%512
302Z?#8000=#23;IF Z=J OR Z=K;Z?#8000=32;IF Z=M;Z?#8000=32
303N.N;P.$30'"TIME:"AA0;T=0
304G=0;LINK VV0;IF?#80=38;GOS.1015
305J?#8000=#09;K?#8000=#09;L?#8000=#2D;M?#8000=#2D;R?#8000=#30
306T=T+1;IF T=3;T=0;AA0=AA0+1;P.$30'"TIME:"AA0;?#B002=?#B002:4
307IF AA0=200;G.5010
310A?#8000=#29;B?#8000=#2D;C?#8000=#28
315F.N=0TO8;WAIT;N.N
316J?#8000=U;K?#8000=O;L?#8000=P;M?#8000=Q;R?#8000=S
320A?#8000=D;B?#8000=E;C?#8000=F
350A=A+H;B=B+H;C=C+H;D=A?#8000;E=B?#8000;F=C?#8000
360IF A>=481;A=14;B=15;C=16;AA1=1;X=A.R.%5;D=#40;E=D;F=E;GOS.12
790LINK VV0
800IF?#80=50;J=J-32;M=M-32;R=R-32;L=L-32;K=K-32;H=0
810IF?#80=39;J=J+1;M=M+1;R=R+1;L=L+1;K=K+1
820IF?#80=36;J=J-1;M=M-1;R=R-1;L=L-1;K=K-1
830IF?#80=35;J=J+32;M=M+32;R=R+32;L=L+32;K=K+32;H=0
835IF?#80<>50;IF?#80<>35;H=X
840IF?#80=38;GOS.1015
850U=J?#8000;O=K?#8000;P=L?#8000;Q=M?#8000;S=R?#8000
860IF J<=0;J=J+32;K=K+32;L=L+32;M=M+32;R=R+32
870IF K>=512;K=K-32;J=J-32;L=L-32;M=M-32;R=R-32
871IF U>#40 OR U<1;U=#40
872IF O>#40 OR O<1;O=#40
873IF P>#40 OR P<1;P=#40
874IF Q>#40 OR Q<1;Q=#40
875IF S>#40 OR S<1;S=#40
890P.$30"SCORE:"V
891IF J?#8000=#23 OR L?#8000=#23 OR K?#8000=#23;G.4000
892IF M?#8000=#23;G.4000
895J?#8000=#09;K?#8000=#09;L?#8000=#2D;M?#8000=#2D;R?#8000=#30
900G.304
1015IF C=R OR A=R OR C=M OR A=L OR R=B OR K=B;G=5
1020IF R=B;G=10
1050V=V+G
1055F.N=100TO50 S.-5;?#81=N;LINK VV1;N.N
1060IF G=10 OR G=5;G.3000
1070R.
2000[:VV0 JSR#FE71;STY#80;RTS;]
2050[:VV1 LDA#B002;:VV2 LDX#81;:VV3 DEX;BNE VV3;EOR@4;STA#B002
2055DEY;BNE VV2
2060RTS;];P.$6;G.6
3000P.$12;?#E1=0
3010P."oooooo oooooo o  o  o o o o"'
3020P."o    o o    o o  o  o o o o"'
3030P."o    o o    o o  o  o o o o"'
3040P."o    o o    o o  o  o o o o"'
3050P."oooooo o    o o  o  o o o o"'
3060P."o      o    o o  o  o o o o"'
3070P."o      o    o o  o  o o o o"'
3080P."o      o    o o  o  o      "'
3090P."o      oooooo ooooooo o o o"'
3091P.'''"YOU HAVE HIT AN ALIEN SPACESHIP"'
3092F.N=0TO255S.5;?#81=N;LINK VV1;N.N
3095F.N=0TO70;WAIT;N.N;A=14;B=15;C=16;AA1=1;X=A.R.%7;GOS.15
3100G.300
4000P.$12;?#E1=0
4010P."ooooo ooooo o      o ooooo o o"'
4020P."o   o o   o oo     o o     o o"'
4030P."o   o o   o o o    o o     o o"'
4040P."ooooo ooooo o  o   o o  oo o o"'
4050P."o   o o   o o   o  o o   o o o"'
4060P."o   o o   o o    o o o   o    "'
4070P."ooooo o   o o     oo ooooo o o"'
4071P.''"YOU HAVE HIT A MINE AND LOST A"'
4072P."LIFE. YOU NOW HAVE "2-I" LIVES LEFT."
4073F.N=255TO0S.-7;?#81=N;LINK VV1;N.N
4075F.N=0TO180;WAIT;N.N
4080I=I+1;IF I=3;P.$12;G.5000
4090A=14;B=15;C=16;X=A.R.%7;AA1=1;GOS.11;G.300
5000P."YOU ARE DEAD!!!!"';G.5020
5010P.$12"YOU HAVE RUN OUT OF TIME!"'
5020P."BUT YOU DID SCORE "V" POINTS!!!"'
5030IF V>BB0;BB0=V;IN."WHAT IS YOUR NAME"$W
5040P."HIGHEST SCORE="BB0" BY:-"$W'
5050?#E1=128
5060P."DO YOU WANT ANOTHER GAME (Y/N)";DO LINK VV0
5070U.?#80=46 OR ?#80=57;IF?#80=57;AA0=0;G.7
5080IF?#80<>46;G.5060
5090END
6000P.$12"***********spacefire************"
6010P."::::::::::INSTRUCTIONS::::::::::"
6020P."THIS IS A TWO-PART GAME WITH A"'
6025P."TIME LIMIT OF 200 SECONDS!"'
6030P."THE FIRST PART OF THE GAME IS A"'
6035P."MAZE WHICH YOU MUST GET THROUGH"'
6040P."TO REACH THE SECOND PART OF THE"'
6045P."GAME!"'"THE SECOND PART IS A STAR WARS"'
6050P."TYPE GAME. YOU MUST MOVE YOUR"'
6055P."SIGHTS AROUND THE SCREEN AND"'
6060P."SHOOT AT THE ALIEN SPACESHIPS"'
6065P."FLYING ACROSS THE SCREEN!"'
6066P."PRESS A KEY TO CONTINUE"';LINK#FFE3;P.$12
6070P."IF YOU HIT AN ALIEN SHIP WITH"'
6075P."EDGE OF THE SIGHTS YOU SCORE 5"'
6080P."POINTS. YOU GET 10 POINTS IF YOU"
6085P."HIT WITH THE CENTRE OF YOUR"'
6090P."SIGHTS!!!"'
6095P."TO MOVE AND FIRE USE:-"''
6100P."R=UP       C=DOWN"'
6105P."    F=FIRE"'
6110P."D=LEFT     G=RIGHT"''
6120P."           R"'"         D F G"'
6125P."           C"'
6130P."TO START PRESS 'S'"';DO LINK VV0;U.?#80=51;G.11
