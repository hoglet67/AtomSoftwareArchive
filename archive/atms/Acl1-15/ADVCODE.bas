
40P.$12;?#E1=0;B=72;GOS.a;B=260;GOS.a;P.'
50O=#9300;P=#9400;I=128;F.A=0TO#FF;P?A=O?A;N.;K=100;N=#90
100F.A=I TO#AF;?A=0;N.;!#8C=0;Z=#2800;X=#8C00;W=K*K;J=12600
510Q=#94;F=565;G=64;GOS.p;G=P?-1;Y=G;GOS.s;L=0
560oGOS.g;IF(C<64ORC>95)G.F
561IFC=74G.F
562@=4*C?O
563IF@=I OR@=G+I;G.F
564P."I SEE NO ";B=C-48;GOS.a;G.o
565IFC=109B=256;GOS.a;G.o
566GOS.r;IFS<64GOS.(W*2+S*K);G.o
569IFE>63B=102;GOS.e;G.o
570GOS.(W+E*K);G.o
1010aA=#8200;D=539
1020F.@=1TOB;A=A+?A;N.;F.@=1TO?A
1035D?@=A?@;N.;D?(@-1)=13;P.$(D+1)$9;R.
1500bIF?C=0R.
1520B=?C;GOS.a;C=C+1;G.b
2005cIFG=63R.
2006IFG>15B=G;G.e
2010vC=256;F.A=0TO9;C?A=0;N.
2030?C=1;C?2=6+A.R.%7;C?1=2
2040C?3=6+A.R.%7;IF(C?2)&6=(C?3)&6;G.2040
2060IF(C?2&14=6ORC?3&14=6)C?4=V+14+R.%2;G.2080
2070C?4=V+6+A.R.%2;C?5=V+14+R.%2
2080C?2=C?2+V;C?3=C?3+V;G.b
2510dA=G*4?(Z+L);A=A&63
2515IFA;Y=G;G=A;G.p
2517B=258;G.a
3000eC=X;F.@=1TOB;C=C+?C;N.;C=C+1;G.b
3510fC=0;@=#FFFFFF;IFD?2=32ORD?2=13@=@/256
3520DO;IF@&!A=@&!D;C=A?3;A=#97FC
3540A=A+4;U.A=#9800;R.
4005g!#8C=!#8C+1;GOS.j;D=540;F.A=0TO20;D?A=32;N.;IN.'$D
4020A=#9500;GOS.f;E=C
4040DOD=D+1;U.(?D=32OR?D=13)
4050IF?D=13;C=0;G.4070
4060D=D+1;A=#95FC;GOS.f
4070@=4;R.
4500jIF!#8C<K;R.
4505P.';IFP?104=I+G;B=162;GOS.e;G.z
4509B=0;@=R.%50;IF@=1B=112
4510IF@=5P?104=I+G;B=143
4525IF@=0B=159
4526IF@=2B=87
4527IF@=3B=147
4528IF@=4B=110;GOS.e;LINK#FE94;B=111
4530IFB;G.e
4531R.
5010mS=O+4*M;IFM>63IFM<96G.5040
5030!#87=0
5040?I=?S;T=256;F.R=1TO8;T=T/2;R?I=T&(S?1);N.;!#87=!S;R.
5510nF.M=64TO92;GOS.m
5520IF?I>127IFG=63&?I;B=M+53;P.';GOS.e
5530N.
5535IFG=33B=93;GOS.e
5536IFG=35IFP?K;B=94;GOS.e
5540P.';IFP?96=I+G;B=66;GOS.e
5541IFP?K=I+G;IFP?101=1B=67;GOS.e
5550IFP?36=I+G;IF?Q;P.';B=127;G.e
5590R.
6500rS=64;U=E+C*256
6520F.H=0TO21;IFU=#FFFF&!(P+2+H*4);S=H;H=63
6540N.;R.
6999pIFG=58B=G;GOS.e;G.z
7000P.';IFG=63V=206;G.v
7010IFG-52G.7600
7515IFY-50R.
7520B=1;GOS.e;GOS.q
7521IFR;IFI-P?32B=167;G.a
7522IFR=0IFI=P?32B=179;G.a
7523IFR=0B=83;G.e
7599R.
7600IFG-64R.
7640B=2;GOS.e;GOS.q;IFR=0R.
7642B=4;GOS.e;GOS.g;B=3;GOS.e;G.z
8000qR=0;GOS.g
8010IFE=39R.
8020IFE=34R=1;R.
8030B=126;GOS.a;G.q
9000kP."YOU CANNOT "$540';R.
9500iB=49;G.a
9600uB=102;G.e
10000B=48;IF?540=13B=50
10005G.a
10100B=13;G.e
10199zP.'
10200GOS.J;E.
10300B=124;G.a
10400IFC=106IFG=Y;B=70;G.e
10401IFC=106G=Y;R.
10406IFC=105G.12100
10407IFC=104G.12000
10408IFC<56IFC>49E=C;G.(W+K*C)
10409G.k
10411hL=3&L
10420GOS.d;G.s
10500M=C;GOS.m
10502IFC=90IFI-P?48B=95;G.e
10505IFC=85B=157;G.e
10510IFI=I?8;?(M*4+O)=0;R.
10520B=259;G.a
10600IFG=33IFP?K;IFQ?1=1Y=G;G=35;P?K=163;G.s
10610IFG=35IFP?K;Y=G;G=33;P?K=161;G.s
10620IFP?K;B=68;G.e
10625IFG=33B=49;G.a
10630G.u
10700G.11000
10800IFG=32IFP?125B=151;G.e
10805IFG=32G.12100
10810G.k
10900IF(C<64ORC>84)G.k
10905M=C;GOS.m;IF(63&?I=0);B=74;GOS.e;B=M-48;G.a
10906IF?#8B>5B=101;G.e
10910C=O+C*4;?C=#C0&?C
10930x?#8B=?#8B+1;R.
11000GOS.l;IFC=0R.
11005IFC=70B=15;P?24=0;G.e
11010R.
11090y?#8B=?#8B-1;R.
11100 
11130lM=C;E=C*4+O;IF(C<64)OR(C>84);B=48;G.a
11150IF(63&?E)B=73;GOS.e;B=M-48;GOS.a;C=0;R.
11151GOS.y
11152?E=G|?E
11160IFC=71B=72;P?28=162;G.e
11199R.
11200B=161;G.e
11300IF(G=42ORG=54OR(?Q ANDP?36=I));B=158;G.e
11310B=153;G.e
11400G.11200
11500B=48;G.a
11600B=5;GOS.e;E.
11700B=52;G.a
11800P?89=0
11900IFG=32IFI=P?68P?89=0;B=244;G.a
11910IFG=32B=154;G.e
11920G.u
12000IFG=48Y=G;G=49;G.s
12005IFG=30Y=G;G=24;G.s
12010IFG=51B=86;G.e
12020IFG=61IFP?84=0Y=G;G=62;R.
12030IFG=61B=92;G.e
12090G.k
12100IFG=49Y=G;G=48;R.
12101IFG=24G=30;R.
12104IFG=52Y=G;G=51;R.
12105IFG=32IFP?89B=151;G.e
12106IFG=32Y=G;G=33;G.s
12107IFG=62Y=G;G=61;R.
12110G.u
12200 
12300G.k
12400B=49;G.a
12500B=257;GOS.a;P.';@=1
12510F.C=0TO20;E=P+C*4
12520IF#BF&?E=I;IF(63&?E=0);B=C+16;GOS.a;P.';@=0
12530N.;IF@;B=142;G.a 
12535IFI=P?36IF?Q;B=127;G.e
12540R.
12600P."YOUR SCORE IS "
12610!N=0;F.M=64TO71;GOS.m;IF?I=I;!N=50+!N
12611IF?I=177;!N=K+!N
12613N.
12615V=K+!N-!#8C;IFV<0V=0
12617IFV>!Z;!Z=V
12620P.V'"HI-SCORE IS"!Z;R.
12800B=52;G.a
12900 
13000 
13100G.u
13200G.W
13300IF(G=54ORG=42)P."OK: NOW WHAT?";R.
13310G.i
13400G.W
13500G.u
13600P."OK:"""$D""" "
13610IFR.%3=2B=71;G.e
13620R.
13700G.h
13800B=12;G.e
13900G.W
13999s
14000IFG*4?Z>127B=11;IFP?33=0IFG-32G.14050
14001IFG=63&?#945C;P?92=136+R.%6;B=90;GOS.e;P.'
14005V=0;GOS.c
14010IFG=56G.z
14045G.n
14050IFR.%3G.e
14055B=99;GOS.e;G.z
14100 
14200 
14300G.u
14400IFP?92<I;B=71;G.e
14410E=G*4?Z
14420IF(E<I OR33?P);B=88;G.e
14430B=89;GOS.e;P?92=I+G
14440IFG=61IFP?84P?84=0;B=91;G.e
14450R.
14500IFP?33P?33=0;B=79;GOS.e
14505GOS.g
14506IFE=48B=116;GOS.e;B=155;GOS.e;G.14500
14510IFE=46P."OK";R.
14520B=80;GOS.e;G.14500
14600G.u
14700IFC=25G.12500
14710IFC=26G.J
14720G.k
14800G.u
14900IF(C<64ORC>70ORG=32)G.10900
14910G=32;Y=G;B=85;GOS.e;P.';G.s
15000 
15100 
15200 
15300L=E-50;G.h
15400L=L-2
15500L=L+1;G.h
20000B=9;GOS.e;GOS.q
20010IFR;B=10;P?112=0;G.e
20020B=107;GOS.e;B=79;GOS.a;G.z
20100B=85;G=32;Y=G;P?68=0;P?89=1;G.e
20200B=8;P?52=0;P?28=157;G.e
20300Y=G;B=115;IFG=28G=46;G.e
20310IFG=46G=28;G.e
20320B=64;G.e
20400B=6;GOS.e;G.z
20500B=7;G.e
20600B=77;P?33=64;G.e
20700B=78;P?33=0;G.e
20800IFG=51G=52;B=82;GOS.e;GOS.s;G.p
20810B=64;G.e
20900GOS.w
20905IFC;B=160;G.e
20910P?96=0;P?K=161;B=65;?Q=0;G.e
21000P?36=P?60;P?60=0;B=97;G.e
21100IF?Q;B=109;G.e
21110IFG=42ORG=54;?Q=1;R.
21120G.k
21200GOS.w
21202IFC;G.20905
21203?Q=0;IFQ?1B=98;P?K=0;G.e
21210Q?1=1;B=69;G.e
21400G.12500
21600G.21700
21650wIFI=P?36IF?Q;C=0;R.
21660C=1;R.
21700IF(G-42 AND G-54 AND(P?36<>G+I OR ?Q=0));B=153;G.e
21705IFI-P?36B=103;G.e
21710G.21100
21800 
21900 
22000IFI-P?36OR?Q=0B=160;G.e
22010?Q=0;R.
22100IF?Q;?Q=0
22110B=108;G.e