
5PROGRAM I.T.
10PROCNT
15F.I=#8200TO#9800S.8;!I=0;I!4=0;N.
20PEND
25PROCEO
30$U=" "
35PEND
40PROCCL
45P.$12
50PEND
55PROCCR
60P.$10$13
65PEND
70PROCSP
75P.$9$9$9$9
80PEND
85PROCTX
90LI.#2AFD;REM?N=V+12
95F.N=T TO T+L.T
100I.?N<#23G.v
105V=A.R.%88;V=88-V;?N=(?N-#23+V)%88+#23
110vN.;I.N.R;P.$T
115LI.#2F5F;REM?N=V-12
120PEND
125FUNCTION LT(M,N)
130I.N<0 OR L.M>64;EO
135$#140=$M;N?#141=13;LT=#140
140FEND
145FUNCTION FNRD(Z)
150FNRD=(((A.R.%1)*Z)+1)
155FEND
160GOS.b;A=8;B=0;G.a
165fGOS.c;REM� ��	���E)�`
170aGOS.d;GOS.e
175I.C<6;G.f
180kCR;CR;$T="3OE6U'iV\M;E ! L [^A= EfAS'fLRX !";TX;CR;CR;CR;E.
185cB=0;A=0;$T="       n4, >hW 0' ";TX;IN.$U
190F.I=1TO14;$T=$MMI;R=-1;TX;NN1=T
195I.$LT(NN1,(L.U)-1)=$U;A=I;I=14
200N.I;R=0;I.A>6;CR;CR;R.
205I.A=0;CR;$T="+IA 0r E'q1qSq L /*X] 5O;";TX;CR;CR;G.c
210B=RR(D,A);I.B<>0;CL;R.
215CR;$T="0kcY rX0& l vRfk )&XW !!";TX;CR;CR;G.c
220e$T="A lgU# L0 n$ ";TX;$T=$CCD;TX;$T="r";TX;CR;CR
225I.(D<25A.(N.E OR TT1>0A.TT1<>D));$T="4ov Pz K+o1 lXob&3y";TX;CR;CR;G.g
230F.I=1TO12
235I.TTI=D;$T="4sgY sL)& ";TX;XIF I=2 OR I=6;$T=$BBI;TX;$T="r�;TX;CR;CR
240ELSE XIF I=9 OR I=10;$T="Tov ";TX;$T=$BBI;TX;$T="r";TX;CR;CR
245ELSE $T="Qop ";TX;$T=$BBI;TX;$T="r";TX;CR;CR
250N.I;I.(E A.F>75);$T="A) nHtS +% 4q]h\(zTW$";TX;CR;E=0
255I.(E A.F>60);$T="0o dH#W'$(rNo mz/ H` bqiq M*srx ++=LQ";TX;CR;CR
260gF.I=1TO6;I.RR(D,I)<>0;$T="A uwU# ";TX;$T=$MMI;TX;$T=" SkcU5";TX;CR
265N.I;R=0;CR;R.
270dI.B<>0;D=B
275G=0;F.I=1TO12;I.TTI=D;G=I;I=12
280N.I;H=0;F.I=1TO6;I.HH(I,1)=D;H=I;I=6
285N.I;I.D<12A.J<>8;GOS.h
290F=F+E;I.A<7;G.i
295ON A-6 GOS.310,385,395,425,475,490,505,545
300iON H GOS.545,600,645,670,690,725
305R.;REM�����4�	�V�
�x�`
310I.H=0ORH>4;$T="A uwU# K+o1 iUm\&/ WN jyfe ?8lrxE";TX;CR;CR;R.
315K=7;GOS.j;I.L=0;$T="9ov IsR6o 'iWe\/ X2  !! -W, et 5fTSWfm*) !!";TX;CR;G.k
320$T="A &tHjK6 ";TX;XIF H=1;$T=$AAH;TX
325ELSE XIF H=2;$T="Tov ";TX;$T=$AAH;TX
330ELSE $T="Po ";TX;$T=$AAH;TX
335$T=" `o fVkH08";TX;CR;CR;$T="A (cS# K'w xiW n\5 nj cmq]s?O";TX;CR
340oI.(H=1 OR H=2)A.(HH(H,2)=6 OR HH(H,2)=5);G.l
345I.A.R.%10<5;$T="9kcY oL, y-$`ja,5 [JdtehaO6";TX;CR;G.m
350l$T="1x W NlH(& 'mV f\/ &aXh%a lG*x !!";TX;CR;HH(H,3)=(HH(H,3)-1)
355mI.A.R.%10>2;G.n
360$T="0sv Pz 89 uxv\ ! V b6/g ]euom<*v +y.8<F? %WG #ZQS ewu'k^xif";TX;CR;CR;$T="Csn[ \ G#& rRpOT";TX;IN.$U;CR
365I.$U="J";$T="A rgM# Z'n$zXn L8 ;jJW*`/";TX;CR;G.o
370nI.HH(H,3)>1;R.
375I.HH(H,3)=1;$T="A) uShF*&.nOfi *4 m`Wqn h@@w#nE";TX;CR;CR;R.
380$T="A rgLmW *o, oNef0%y";TX;CR;CR;HH(H,1)=0;TT(H+8)=D;H=0;R.
385CL;$T="9YI,S,dU\ K8NDZg78uc6";TX;CR;CR;CR;F.I=1TO14
390$T=$MMI;SP;TX;CR;N.I;R=0;CR;CR;$T="n4 U3H (_X kW.UJ ZZA kx";TX;CR;LI.#FE94;CL;R.
395I.((TT1=0 OR TT1=D)A.E) OR D>24;G.p
400$T="A ,kL# J'o- pJo[ 70b[ ewao_ 5in& 2:9F9 &SQt `[ Xbw wq e^yZN !!";TX;CR;CR;R.
405pI.G=0;$T="1$ kZ oL'$ -qNuj %zg > cua lP7$ #o,+Fk";TX;CR;CR;R.
410$T="A zcR# ";TX;XIF G<4ORG>10;$T="Po ";TX;$T=$BBG;TX;$T="r";TX;CR;CR
415ELSE $T="Tov ";TX;$T=$BBG;TX;$T="r";TX;CR;CR
420PPO=G;O=O+1;TTG=0;G=0;R.
425I.O=1;$T="A rgLmW 0s$$\ !";TX;CR;CR;R.
430r$T="Ckv ^pO6 _ -mNsc&(ZNd O";TX;CR;CR;IN.$U;CR;K=0;F.I=1TO12
435$T=$BBI;R=-1;TX;NN1=T;I.$LT(NN1,(L.U)-1)=$U;K=I;I=12
440N.I;R=0;I.K=0;$T="+IA 0r E'q1qSq L /*X] 5O;";TX;CR;CR;R.
445GOS.j;I.L=0;$T="A rgLmW *o+mVbX- (XNd ";TX;$T=$BBK;TX;CR;CR;G.q
450$T="A rgLmW ";TX;XIF K<4ORK>10;$T="Po ";TX;$T=$BBK;TX
455ELSE $T="Tov ";TX;$T=$BBK;TX
460$T=" ZogYnH.o&lo";TX;CR;CR;G=PPL;TTG=D;O=O-1;PPL=PPO
465q$T="Csn[ \ Q1q (m]t e&&eU[wcfI `";TX;CR;CR;IN.$U;CR;IF$U="J";G.r
470R.
475I.O=1;$T="A lgapW #v+mNo b-&eNd>";TX;CR;CR;G.s
480$T="A rgLmWT";TX;CR;CR;F.I=1TO O-1;$T=$BB(PPI);TX;CR;N.I;CR
485s@=2;$T="A uwU# Q1q";TX;P.5-C;$T=" cypKlQ 1($zUfm&/y";TX;CR;CR;R.
490K=6;;GOS.j;I.L=0;$T="A uwU# G#& -qNu [0&a ce&`fM ?m'lx4<k";TX;CR;CR;R.
495$T="4ov apH4 o1 vRfk #&f] kyp/ $4 prl x2DJ> +]AjXt";TX;CR
500$T="3ygK3 G#& 9iU x\- &iNd xkv?.v;";TX;CR;CR;C=0;O=O-1;PPL=PPO;R.
505I.TT1>0A.TT1<>D;$T="FypKlU .k-$Jbi/ ;XT[* ;!";TX;CR;CR;R.
510I.F>75;$T="A) dH#W'$(rNo q*+a U[uc !";TX;CR;CR;R.
515E=N.E;I.E;$T="5u fVl G' vxv]bX3/ TJd>";TX;CR;CR;R.
520$T="5u fVl G' vxv]bX3/ hRj>";TX;CR;CR;R.
525K=4;GOS.j;I.L=0A.TT4<>D;$T="4yg ^pO6 _ +mcfe z-f > ]uao =8mx r$+>Y b!";TX;CR;CR;R.
530I.N.EA.D<25;$T="4ov Pz W' n.vTfi 0. gN buvfIO";TX;CR;R.
535$T="1$ u[hD6 o$v Tp\,*X\#*ad@9$ vx #/L G:zYc";TX;CR;$T="1$ u[hD6 q$#Lii&7XW0";TX;CR
540$T=":ogT lH0 R$tUf_0/W Nd /]u #*#w";TX;CR;$T="Qx iVvL *o3 qW e\ #zeK[sqfa";TX;CR;$T="0kv Pz D.v$#o";TX;CR;CR;R.
545I.G=3;HH(1,2)=3;TTG=0;G=0
550ON HH(1,2) G.555,565,570,590,595
555$T="     n4 Km[i D4";TX;CR;$T="0o K5[5[7kM;S<lmE27\ et C2m'8";TX;CR
560$T="4sl WyD#& 'mNm f1(X`e&`fIM unk1 s :J2/WGqe VPj (lqk'";TX;CR;CR;HH(1,2)=2;R.
565$T="58Vm sD#& ,m[l\/ %T] ^yf fM0m qy19L M0zTQ/";TX;CR;$T="4sl RpM-& 5m[un*+YNbt*";TX;CR;CR;R.
570$T="58Vm kU+x*$ Jmj0' [R` -euB.l'y.-< N>C";TX;CR;$T=":k gLu S1y2rN c\(*a] ^yf x@.z )o /89Y0+t";TX;CR;$T=":' m\uW o r$u `fc 7&e\jq]o!!";TX;CR;$T="4sl alJ6D";TX;CR
575$T="3k qUkH4q1wWej &/ mX[# `f )vTYSkw]G:*t";TX;CR;$T="1op RyD0u9qWo`(& c[evatN8z ,s+ 'DQ0 )SSf_ S]jwh *\kz^EIn%ti!";TX;CR
580$T="5u jLi P'& 'm] nf/4gNh wawJ,p)o- *9Y /z PLn SSb^sn(#";TX;CR;$T="YkcY pN $o- v^ wf--XM_w qjO0m%'3L";TX;CR
585$T="0'um5i 0' ,wNu L 13bK[*ao ?. in$#+ LJ =zRAf_t";TX;CR;$T="0kp ahN6 SE\o je&&ao";TX;CR;CR;HH(1,2)=4;R.
590$T="58Vm pV $v(rTcXz3 \W Y'iba";TX;CR;$T=":' oVlW o k+tNt X--XNd tkfI !!";TX;CR;$T="!! n4 X,L/ m_ZK.T yC !!";TX;CR;CR;HH(1,2)=5;R.
595$T="58Vm pV *s$zo";TX;CR;$T="4sl Pz L0 m.uJ/";TX;CR;CR;R.
600I.G=8;HH(2,2)=5;TTG=0;G=0
605ON HH(2,2) G.610,615,620,625,630,640
610$T="1$ kZ oL'$ $mW fe03` Ve&ou@;6";TX;CR;$T="4ov YvO6 w$$ c(e 0(XW$";TX;CR;$T="4ov IyX.&Q J.O Abc 8.D [KF&jM L!";TX;CR;CR;HH(2,2)=2;R.
615$T="4ov TvQ5&$z Ksl-5 f][u`t C*zqo1X r*q _3 zF? 9:B]LQ 6!!";TX;CR;CR;HH(2,2)=3;R.
620$T="4ov TvQ5&$z Km`+'g Kh-hm@7 m# ).8<Y ,$`BtdWPc@";TX;CR;CR;HH(2,2)=4;R.
625$T="4ov TvQ5&$z Pf\'5 H N[& rfM<ku$(1CJ7&XHf \ZLm@";TX;CR;$T="A) jVvI& &.t]/";TX;CR;CR;C=C+1;HH(2,2)=(FNRD(3)+1);R.
630$T="4ov TvQ5&$z cf^5 7X[hqoum lWRU`c+ $!";TX;CR;$T="4ov IlJ+x3 uNu\&/ gN [,aoa";TX;CR
635$T="1op LuR4w$  ! ! J 8 O > ! !  &/ [Nj .]mO 2v (vx'Hk";TX;CR;CR;RR(16,6)=1;HH(2,2)=6;R.
640$T="4ov TvQ5&$z \mXz1go";TX;CR;CR;R.
645$T="1$ kZ oL'$ $mW HCb[5.HYCF .mI[QE";TX;CR;CR;I.A.R.%10<4;R.
650I.O=1 OR A.R.%10<5;G.w
655P=FNRD(O-1);TT(PP(P))=12+FNRD(12);O=O-1;PPP=PPO;$T="?vkUrV ,k3 pRk `&5fo";TX;CR
660w$T="4sl NsL2& 6mP/";TX;CR;CR;HH(3,1)=(HH(3,1)+3);I.HH(3,1)>24;HH(3,1)=(HH(3,1)-8)
665R.
670ON HH(4,2) G.675,680,685
675$T="1$ kZ oL'$ $mW s\64TL^,eh@ imyv$.GS/C";TX;CR;$T="4ov SpM-& $zXq [z5 [R` e sjG 8xr&$4^";TX;CR;CR;HH(4,2)=2;R.
680$T="0o JLsO'r.vM wX-5 TJd>*/ @7 jvt3 s @F=yt";TX;CR;CR;C=C+1;HH(4,2)=3;R.
685$T="0o JLsO'r.vM hi0.g Nd +pb<= sykx8 NT:/ SBo _WPr1h mXg*VL[";TX;CR;CR;HH(4,2)=1+FNRD(2);R.
690$T="0o P<S/c^p5Kpd *4 [R[*!!";TX;CR;$T="1$ $PqQ &$(m MsX%&a M_u `f =8u zo3 +=S ?&XAl]]V swun`gpZNg";TX;CR
695$T="     q ogU I5oSeM iCx";TX;CR;$T="     q ogU N(fO   ?Oj";TX;CR;$T="     q ogU Y2^O   ?Zj";TX;CR
700$T="A wqL# H4 &6mN mf4.TT[& kn ?. $vt#1DT6 1S Pu`^[b(1";TX;CR
705CR;$T="ConRl D.% $m[tk& ";TX;IN.$X;$T="ConRl D.% 3'Nf[& ";TX;IN.$Y;A=CH$X;B=CH$Y;I.(A*B=5412);G.t
710CL;$T="n4 G5V5gO \`9MFlb8 kx";TX;CR;$T="   !! >YV:I/iUbM7 !!";TX;CR;$T="   !! ?^Q-^2fU\V  !!";TX;CR;CR
715$T="A lgU# P1o#qP h\8&X\j>";TX;CR;$T="9kcY oH.kx#m V Y&/g W_up h@<tnk&*^kQ";TX;CR;CR;E.
720tCL;SP;$T="n4, .L)_V`K2U<^k7 kx:";TX;CR;CR;$T="A lgU# J'%+iJh[ 8zT[ W&`fM.v skx2<J9 !!!";TX;CR;CR;E.
725I.TT2=D A.TT12=D;G=8;TTG=D;TT2=0;TT12=0;HH(6,2)=2
730ON HH(6,2) G.735,740,745
735$T="1$ kZ oL'$ $mW hi05X +7b>FvvM zo3 +=S 1zZ Svf` Po)qp\k:";TX;CR;CR;R.
740$T="1op LuR4w$ nUjk4 7X[by_iO -m $w&+NN9$t";TX;CR;$T="1op KvR4n1qWh\/%X \jqjl Q.z(z1+AI? 7W@iw";TX;CR;CR;HH(6,2)=3;R.
745$T="-vnLz L5 x4 z^tk*(. c[$bt ?. &vo9+ KY,+Y Ft hSR+";TX;CR;CR;HH(6,2)=1;R.
750jL=0;F.I=1TO O-1;I.PPI=K;L=I;I=O-1
755N.I;R.
760hS=S+1;I.D=SSS;J=J+1
765I.S<8;R.
770I.J=8;G.u
775$T="4ov Pz V6s*lXob&3 XW ^up mD3s) k+9GK 4zbP V `^_f&w:";TX;CR;$T="1(gU iH0& l j^jk&/ UNm-ouU2r#8";TX;CR;CR;S=1;J=1;D=1;R.
780u$T="A rqVyW 'o- &[f\.% ZNb-eeaO6; k+9GK 0/ WBud dPo-ftfoqc WDwz+)";TX;CR;PA.1500;CR;CR;$T="-vnLz L5 )$m[ tk*-y";TX;CR;CR;RR(2,1)=3;R.
785bCL;V.12;H.28;P."** EVEN GEDULD A.U.B. **";V.21;NT;?#23=#00;?#24=#82;DIM RR(36,6),HH(6,3),TT12,PP12,SS8,AA6,BB12,CC36,MM14,NN14,Z-1;?#23=#00;?#24=#90;DIM X1,Y1,U20,M20,T80
790F.I=1TO36;F.J=1TO6;RR(I,3)=0;N.J;N.I
795F.I=1TO36;RR(I,1)=I+1;RR(I,2)=I-1;RR(I,3)=I+4;RR(I,4)=I-4;N.I
800F.I=0TO24S.12;F.J=1TO9S.4;RR(I+J+3,1)=0;RR(I+J,2)=0;N.J;F.J=1TO4;RR(I+J+8,3)=0;RR(I+J,4)=0;N.J;N.I
805RR(1,5)=16;RR(7,5)=15;RR(32,6)=13;RR(13,5)=32;RR(35,6)=18;RR(18,5)=35
810F.I=1TO15;READ D;READ A;RR(D,A)=0;N.I;D=36;L=1;O=1;F=0;E=0;C=0;S=0;J=0;R=-1
815F.I=1TO14;READ$Z;MMI=Z;Z=Z+L.Z+1;N.I;F.I=1TO12;READ$Z;BBI=Z;Z=Z+L.Z+1;N.I;F.I=1TO6;READ$Z;AAI=Z;Z=Z+L.Z+1;N.I;F.I=1TO36;READ$Z;CCI=Z;Z=Z+L.Z+1;N.I
820F.I=1TO12;READ TTI;N.I;F.I=1TO6;READ HH(I,1),HH(I,3);HH(I,2)=1;N.I;F.I=1TO8;READ SSI;N.I;R=0;R.
825DATA21,1,22,2,22,1,23,2,18,1,19,2,16,3,20,4,11,1,12,2,7,1,8,2,7,4,3,3,2,1
830DATA";YU;  ","COU;  ",":YQ9K ","F_K+  ",";WJ6V*",";WN(H*","0YF,U","4ON7","9OG5L0_X",":OG9S(aQ\V","?^C;\6","BOT)H1^","8KP;H$lX","8O\,U"
835DATA"8KP;H$lX","4KU1","CKV,Y=[U","7YQ2I2_U","<KO-S(n","BOT)H1^","FaC(Y'","7YG2Q(","8SE/H$g `XV 2/KG","8SE/H$g `XV 1FK fhA<JUN","3OJ(R7_ ]cI7H","0YF, O2hN"
840DATA"58Vm","9YP:[(l","?VC5N","4ON3L+iX[",".KT)L&oO",".YO",">OU,[*lYk",":7I9V7","3OJ,P0_ ^lV7FC","/YP;Y2fObI6FI","37I9V7","17I9V7","<7I9V7"
845DATA"FaC9[( cKdM;","-7I9V7","4YN3L *lYk",";7I9V7","8OG.[(","7VG0U( a\f\",">YV:N5i^","?^C5R*lYk","0\C2L1a\f\","?VC5N(hQiW=","3ON, N5i^","FKP+I$hU"
850DATA"3VK)I(lQiW=","BYG+Z(fQiW=","1SP+L*lYk","3\Q;L *lYk","BSU.Y2n",";ZG5 W/_U",".YU:L1",".YU:L1",".YU:L1",".YU:L1",".YU:L1",".YU:L1"
855DATA".YU:L1",".YU:L1",".YU:L1",".YU:L1",".YU:L1",34,30,28,21,14,15,13,0,0,0,0,0,34,2,16,15,17,4,29,2,8,1,25,1,1,5,9,10,11,7,6,2
