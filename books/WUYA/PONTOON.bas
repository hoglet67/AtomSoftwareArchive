
0GOS.4000;G.10
2a*AH*2H*3H*4H*5H*6H*7H*8H*9H*TH*JH*QH*KH
3*AD*2D*3D*4D*5D*6D*7D*8D*9D*TD*JD*QD*KD
4*AC*2C*3C*  *5C*6C*7C*8C*9C*TC*JC*QC*KC
5*AS*2S*3S*4S*5S*6S*7S*8S*9S*TS*JS*QS*KS
10R=0;G=52;I=0;J=0;A=0;Q=0;H=0;S=0;DIMBB5;BB1=0;BB4=100000
15?#B002=8;CLEAR4;BB3=0;DIML1,W6;T=0;BB2=100000;BB5=0;G.500
125Z=#8081;E=0
126F.M=0TO4;F.N=0TO3;?Z=255;Z=Z+1;N.N;F.N=0TO52;?Z=64;Z=Z+32;N.
136Z=Z-1;F.N=0TO3;?Z=255;Z=Z-1;N.N;F.N=0TO52;?Z=1;Z=Z-32;N.N
146Z=Z+7;N.M;R.
500O=0;BB0=0;GOS.125;Z=#9081;GOS.126;B=1;K=1
510T=T+1;GOS.2050;IFB=1;IFW?0=65;H=1;G.517
515IFB=1;IFW?0<65;A=A+((W?0)-48);G.517
516IFB=1;IFW?0<>65;A=A+10
517IFR=1;T=1
518IFR=3;U=1
519IFB=2;IFW?0=65;Q=1;G.530
520IFB=2;IFW?0<65;J=J+((W?0)-48);G.530
521IFB=2;IFW?0<>65;J=J+10
530D=W?0;GOS.6000;IFE=4;E=14
536IFR=3;O=O+294
540Z=#80C1+O+BB0;GOS.5000;BB0=BB0+739;Z=Z+BB0;GOS.5000
550BB0=BB0-739;D=W?1;Z=Z+64;GOS.6000;F=#81E1+O+BB0
590Z=F;GOS.5000;BB0=BB0+288;F=F+BB0
600IFF=#81E1+O+BB0;F=#84A4+O+BB0;G.590
601BB0=BB0-288*2;IFI=1;G.660
610IFBB5<>1;BB5=1;G.1037
620GOS.7000;P.$21,$30;IN.$L;P.$6;?#B000=#F0;BB1=VAL(L)
625IFBB1>BB2;G.620
630F.M=0TO((LENL)-1);D=?(L+M);IFD<58;GOS.6000;G.636
635F.N=#87A0TO#88A0;?N=0;N.N;N.M;G.620
636Z=#87A7+M;GOS.5000;N.M;O=6;I=1;B=1;K=K+1;G.510
660Z=#88E0;GOS.7050;F.N=#88E7TO#89E7S.32;?N=0;N.N;IFB=2;G.9020
670G.8000
1000IFA=10;IFH=1;BB2=BB2+BB1;BB4=BB4-BB1;G.9500
1001IFJ=10;IFQ=1;BB2=BB2-BB1;BB4=BB4+BB1;G.9550
1002IFJ+Q>21;BB2=BB2+BB1;BB4=BB4-BB1;G.9500
1003IFA+H>21;BB2=BB2-BB1;BB4=BB4+BB1;G.9550
1004IFJ+Q>21;BB2=BB2+BB1;BB4=BB4-BB1;G.9500
1005IFA+H>J+Q;BB2=BB2+BB1;BB4=BB4-BB1;G.9500
1010IFH=1;IFQ<>1;IFA+11>J;BB2=BB2+BB1;BB4=BB4-BB1;G.9500
1015IFQ=1;IFH<>1;IFJ+11>A;BB2=BB2-BB1;BB4=BB4+BB1;G.9550
1020IFA+H<J+Q;BB2=BB2-BB1;BB4=BB4+BB1;G.9550
1021IFBB3=1;IFL<>1;BB2=BB2+BB1;BB4=BB4-BB1;G.9500
1022IFL=1;IFBB3<>1;BB2=BB2-BB1;BB4=BB4+BB1;G.9550
1023IFBB3=1;IFL=1;IFA+H<J+Q;BB2=BB2+BB1;BB4=BB4-BB1;G.9500
1024IFBB3=1;IFL=1;IFA+H>J+Q;BB2=BB2-BB1;BB4=BB4+BB1;G.9550
1030IFBB4<=0;G.1034
1031IFBB2<=0;G.1033
1032BB5=0;G.1037
1033P.$12''''"YOU'VE RUN OUT OF MONEY!!!!!!!!!"';G.1036 
1034P.$12''''"I'VE RUN OUT OF MONEY!!!!!!!!!!!"'
1035P.'"YOU'RE TOO GOOD FOR ME!"'
1036P."bye-bye"';E.
1037Z=#8B21;E=26;GOS.5000;Z=#8B22;E=13;GOS.5000;Z=#8B23
1040E=27;GOS.5000;Z=#8B24;E=28;GOS.5000;Z=#8B25;E=22;GOS.5000
1045STR BB2,W;F.N=0TO9;IFN?W=CH".";$W+N=""
1050N.N;F.M=0TO((LENW)-1);D=?(W+M);GOS.6000
1060Z=(#8B25+M+1);GOS.5000;N.M
1075Z=#8C41;E=29;GOS.5000;Z=#8C42;E=20;GOS.5000;Z=#8C44
1080E=28;GOS.5000;Z=#8C45;E=22;GOS.5000
1081STR BB4,W;F.N=0TO9;IFN?W=CH".";$W+N=""
1084N.N;F.M=0TO((LENW)-1);D=?(W+M);GOS.6000;Z=(#8C45+M+1)
1090GOS.5000;N.M;IFBB5=1;G.620
1095R=0;G=52;I=0;J=0;A=0;Q=0;H=0;S=0;BB5=0
1100LINK#FFE3;T=0;CLEAR4;GOS.4000;G.500
2050X=?18*256;D=#D;Y=CH"a";DO DO X=X+1;U.?X=D;U.X?3=Y
2070X=X+3;Y=CH"*";F.P=1TO1+A.R.%G;DO X=X+1;IF?X=D;X=X+3
2095U.?X=Y;X=X+1;N.P;V=0;DO IFX?V<48;?#13=0;G.2050
2125W?V=X?V;X?V=32;V=V+1;U.X?V=D OR X?V=Y OR X?V=CH" ";R.
4000$#2915="AH*2H*3H*4H*5H*6H*7H*8H*9H*TH*JH*QH*KH"
4010$#293F="AD*2D*3D*4D*5D*6D*7D*8D*9D*TD*JD*QD*KD"
4020$#2969="AC*2C*3C*4C*5C*6C*7C*8C*9C*TC*JC*QC*KC"
4030$#2993="AS*2S*3S*4S*5S*6S*7S*8S*9S*TS*JS*QS*KS";R.
5000C=E;IFC>3;IFC<9;C=#2800+15+((C-1)*8)
5005IFC<4;G.5040
5010IFC>8;C=#2800+14+((E-1)*8)
5021F.N=C+1 TO C+8;?Z=?N;Z=Z+32;N.N;R.
5040IFC=0;F.N=#2800TO#2808;?Z=?N;Z=Z+32;N.N;R.
5050C=C+(10*(C-1))+9-E+#2800;F.N=C TO C+9;?Z=?N;Z=Z+32;N.N;R.
6000IFD=CH"H";E=0
6010IFD=CH"D";E=1
6020IFD=CH"S";E=2
6030IFD=CH"C";E=3
6060IFD>=49;IFD<=57;E=D-45
6130IFD=CH"0";E=13
6140IFD=CH"A";E=14
6150IFD=CH"J";E=15
6160IFD=CH"Q";E=16
6170IFD=CH"K";E=17
6180IFD=CH"T";E=18
6250IFD=CH"N";E=25
6260IFD=CH"Y";E=26
6500R.
7000E=19;Z=#87A1;GOS.5000;Z=#87A2;E=20;GOS.5000;Z=#87A3;E=18
7010GOS.5000;Z=#87A4;E=21;GOS.5000;?#8864=0
7020Z=#87A5;E=22;GOS.5000;R.
7050E=18;GOS.5000;Z=#88E1;E=23;GOS.5000;Z=#88E2;E=4;GOS.5000
7060Z=#88E3;E=24;GOS.5000;Z=#88E4;E=18;GOS.5000;Z=#88E5
7070E=21;GOS.5000;R.
8000IFA+H>21;G.1000
8005GOS.7000;P.$21,$30;IN.$L;P.$6;?#B000=#F0
8010IF$L="N";T=0;G.9000
8015IF$L="Y";G.8017
8016G.8000
8017E=26;Z=#88E7;GOS.5000
8018O=(6*T);B=1
8020IFA=10;IFH=1;BB5=0;G.9000
8030IFT=5;T=0;BB3=1;G.9000
8040G.510
9000B=2;O=4096;G.510
9020IFJ=10;IFQ=1;G.1000
9025O=4096+(6*T)
9026IFT=5;L=1;G.1000
9030IF(J+Q)<=15;G.510
9040IF(J+Q)<18;IFR.<100;G.510
9050IF(J+Q)<20;IFR.<-10000;G.510
9100G.1000
9500Z=#88E0;F.N=0TO7;?Z=0;Z=Z+32;N.N
9505Z=#88E1;E=26;GOS.5000;Z=#88E2;E=13;GOS.5000;Z=#88E3;E=27
9510GOS.5000;Z=#88E4;GOS.10000
9520Z=#88E6;E=20;GOS.5000;Z=#88E8;E=23;GOS.5000;Z=#88E9
9530E=13;GOS.5000;Z=#88EA;E=25;GOS.5000;G.1030
9550Z=#88E0;F.N=0TO7;?Z=0;Z=Z+32;N.N
9555Z=#88E1;E=26;GOS.5000;Z=#88E2;E=13;GOS.5000;Z=#88E3;E=27
9560GOS.5000;Z=#88E4;GOS.10000
9570Z=#88E6;E=20;GOS.5000;Z=#88E8;F.N=0TO6;?Z=16;Z=Z+32;?Z=31
9580N.N;Z=#88E9;E=13;GOS.5000;Z=#88EA;?Z=28;Z=Z+32;?Z=34
9585Z=Z+32;?Z=32;Z=Z+32;?Z=28;Z=Z+32;?Z=2;Z=Z+32;?Z=2;Z=Z+32
9586?Z=34;Z=Z+32;?Z=28;Z=#88EB;E=18;GOS.5000;G.1030
10000?Z=6;Z=Z+32;?Z=6;Z=Z+32;?Z=8;F.N=0TO4;Z=Z+32;?Z=0;N.N
10010Z=#88E5;F.N=0TO5;?Z=17;Z=Z+32;N.N;?Z=10;Z=Z+32;?Z=4;R.
