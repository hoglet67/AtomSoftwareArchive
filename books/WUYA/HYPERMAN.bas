
1Z=272;T=#3C;Q=0;@=0;S=0;R=32;C=1;A=66;B=66;G=0;U=0;K=0;V=0
2X=Z+R.%10+10;O=Z+R.%10;Y=0;M=#24;DIM AA0;AA0=1
3!#21C=#84FE7120;!#220=#6080;!#222=#A4B002AD;!#226=#CA81A682
4!#22A=#0449FDD0;!#22E=#C6B0028D;!#232=#83C4C881;!#236=#60EFD0
6GOS.2000
10?#B002=8;P.$12;?#E1=0
70F.N=#8021TO#803E;?N=#43;N.N;F.N=#8021TO#81E1S.32;?N=#55;N.N
90F.N=#81E1TO#81FE;?N=#70;N.N;F.N=#805F TO#81DF S.32;?N=#6A;N.N
110?#8021=#41;?#803F=#42;?#81FF=#60;?#81E1=#50
120F.N=#8063TO#806F;?N=#7F;N.N;F.N=#8071TO#807C;?N=#7F;N.N
130F.N=#81A3TO#81AF;?N=#7F;N.;F.N=#81B1TO#81BE;?N=#7F;N.
140F.N=#8063TO#80E3S.32;?N=#7F;N.;F.N=#8123TO#81A3S.32
150?N=#7F;N.
155F.N=#807D TO#80FD S.32;?N=#7F;N.;F.N=#8165TO#817B;?N=#7F;N.
170F.N=#80A5TO#80BB;?N=#7F;N.;F.N=#813D TO#81BD S.32;?N=#7F;N.
190F.N=#8125TO#812F;?N=#7F;N.;F.N=#80E5TO#80EF;?N=#7F;N.
200F.N=#8131TO#813B;?N=#7F;N.;F.N=#80F1TO#80FB;?N=#7F;N.
210?#8108=#7F;?#8118=#7F;F.N=#8042TO#805E;?N=#2E;N.
230F.N=#8062TO#81B2S.32;?N=#2E;N.;F.N=#81C2TO#81DE;?N=#2E;N.
250F.N=#807E TO#819E S.32;?N=#2E;N.
260F.N=#8084TO#809C;?N=#2E;N.;F.N=#80C4TO#80DC;?N=#2E;N.
270F.N=#8144TO#815C;?N=#2E;N.;F.N=#8184TO#819C;?N=#2E;N.
275F.N=#8084TO#8164S.32;?N=#2E;N.;F.N=#809C TO#817C S.32;?N=#2E
280N.;F.N=#8103TO#8105;?N=#2A;N.;F.N=#811B TO#8110;?N=#2A;N.
290?#8070=#2A;?#81B0=#7F;?#8106=#2A;?#8107=#2A;?#811A=#2A
295?#8119=#2A;?#8117=#0F;?#8109=#0F;?#8116=#0F;?#810A=#0F
300?#810B=#2A;?#810C=#2A;?#8115=#2A;?#8114=#2A
310F.N=#810D TO#8113;?N=#2E;N.;?#80F0=#2E;?#8130=#2E
330F.N=#81DA TO#81DE;?N=#0F;N.;F.N=#81D3TO#81D9;?N=#2A;N.
340IF X?#8000<62;X=X+32;G.340
345IF X?#8000>448;X=X-32;G.340
346IF O?#8000>448;O=O-32;G.340
350IF O?#8000<62;O=O+32;G.340
450Z?#8000=32;LI.#21C;IF?#80=52;Q=-32;T=#3C
460IF?#80=54;Q=32;T=#3C
470IF?#80=40;Q=1;T=#3C
480IF?#80=38;Q=-1;T=#3E
485IF?#80=51;G.1020
500Z=Z+Q;IF Z?#8000=#7F;Z=Z-Q
505IF Z?#8000=#2E;S=S+10
510IF Z?#8000=#2A;S=S+30
520IF Z?#8000=#0F;S=S+50
521IF Z?#8000=#A4;IF AA0<4;AA0=AA0+1
525IF Z?#8000=#80;G.1100
530IF Z?#8000=#6A;Z=Z-Q
540IF Z?#8000=#55;Z=Z-Q
550IF Z?#8000=#70;Z=Z-Q
560IF Z?#8000=#43;Z=Z-Q
561?#81=(Z?#8000*-5);?#83=?#81;LI.#222;Z?#8000=T
564P=O;I=P?#8000;W=X;R=W?#8000;X?#8000=#23;O?#8000=#23
570L=A.R.%4;IF L=0;E=-32;F=1
580IF L=1;E=32;F=-1
590IF L=2;E=1;F=-32
600IF L=3;E=-1;F=32
605X=X+E;O=O+F
610IF X?#8000=#7F OR X?#8000=#6A OR X?#8000=#70;X=X-E;G.610
615IF O?#8000=#7F OR O?#8000=#6A OR O?#8000=#70;O=O-F;G.610
620IF O?#8000=#55 OR O?#8000=#43;O=O-F;G.610
625IF X?#8000=#55 OR X?#8000=#43;X=X-E;G.610
630IF X=Z OR O=Z;G.1000
640W?#8000=R;P?#8000=I;A?#8000=M;IF K=1 OR V=1;G.750
685IF Z>A;G.905
686IF Z<A;G.925
690IF A=Z;G.1000
750U=U+1;IF U=2 OR U=4;A?#8000=#08
755?#81=0;?#83=5;?#82=2;LI.#222;IF U=1 OR U=3;A?#8000=#88
765IF V=1;G.790
770IF U=5;A?#8000=#A4
771IF U=5;IF R.%10<7;A?#8000=#80
774IF U=5;D=((A.R.%5+2)*Y);A=A+D
775IF A?#8000=#6A;A=A-1;B=A;G.775
776IF A?#8000=#7F;A=A+Y;B=A;G.775
777IF A?#8000=#70;A=A-32;B=A;G.775
778IF A?#8000=#43;A=A+32;B=A;G.775
779IF A?#8000=#55;A=A+1;B=A;G.775
780IF U=5;B=A;U=0;V=1
787IF A<66;A=A+128;B=A;G.774
788IF A>480;A=A-128;B=A;G.774
790IF(A+1)?#8000=#55;A=A+2;B=A;G.775
795IF(A-1)?#8000=#6A;A=A-2;B=A;G.775
796IF U=5;K=0;V=0;U=0
800IF(A-1)?#8000=#6A;A=A-2;B=A;G.780
880P.$30"SCORE:"S"   LIVES:"AA0;IF A?#8000=#55;A=A-J;K=1;Y=1
882IF A?#8000=#6A;A=A-J;K=1;Y=-1
883IF A?#8000=#43;A=A-J;K=1;Y=32
884IF A?#8000=#70;A=A-J;K=1;Y=-32
885IF A<66;A=A+32;Y=32;G.750
886IF A>478;A=A-32;Y=-32;G.750
887H=A?#8000;B?#8000=H;B=A
888IF S>(C*4000);C=C+1;X?#8000=#23;O?#8000=#23;G.70
890Z?#8000=T;Q=0;G.450
905IF Q=32;IF(A+32)?#8000<>#7F;A=A+32;J=32;G.880
910IF Q=32;IF(A+1)?#8000<>#7F;A=A+1;J=1;G.880
914IF Q=1;IF(A+1)?#8000<>#7F;A=A+1;J=1;G.880
915IF Q=1;IF(A+32)?#8000<>#7F;A=A+32;J=32;G.880
917IF Q=-1;IF(A-1)?#8000<>#7F;A=A-1;J=-1;G.880
918IF Q=-1;IF(A+32)?#8000<>#7F;A=A+32;J=32;G.880
919IF Q=-32;IF(A+32)?#8000<>#7F;A=A+32;J=32;G.880
920IF Q=-32;IF(A+1)?#8000<>#7F;A=A+1;J=1;G.880
921IF(Z-A)>32;Y=32;K=1;G.750
922Y=1;K=1;G.750
925IF Q=-32;IF(A-32)?#8000<>#7F;A=A-32;J=-32;G.880
930IF Q=-32;IF(A-1)?#8000<>#7F;A=A-1;J=-1;G.880
931IF Q=32;IF(A+32)?#8000<>#7F;A=A+32;J=32;G.880
932IF Q=32;IF(A+1)?#8000<>#7F;A=A+1;J=1;G.880
935IF Q=-1;IF(A-1)?#8000<>#7F;A=A-1;J=-1;G.880
936IF Q=-1;IF(A-32)?#8000<>#7F;A=A-32;J=-32;G.880
937IF Q=1;IF(A-1)?#8000<>#7F;A=A-1;J=-1;G.880
938IF Q=1;IF(A-32)?#8000<>#7F;A=A-32;G.880
940IF(A-Z)>=32;Y=-32;K=1;G.750
941Y=-1;K=1;G.750
950IF(A+1)?#8000=#7F;IF(A+32)?#8000<>#7F;A=A+32;J=32;G.880
960K=1;G.880
970IF(A-1)?#8000=#7F;IF(A-32)?#8000<>#7F;A=A-32;J=-32;G.880
980K=1;G.880
1000AA0=AA0-1;IF AA0=0;END
1010Z=272;A=66;B=66;X=Z+(R.%10)+10;O=Z+(R.%10);G.70
1020N=61;DO;N=N+1
1025U.N?#8000=#2E OR N?#8000=#2A OR N?#8000=#0F OR N=499
1030IF N<>481;G.70
1040P.$12''''''"           SORRY";F.N=0TO50;WAIT;N.;?#E1=0;G.70
1100F.N=100TO50S.-1;?#83=N;?#81=N;LI.#222;N.N
1101IF Q=32 OR Q=-32;Z=Z+((A.R.%5)*32)
1102IF Q=1 OR Q=-1;Z=Z+(R.%5)
1105IF Z?#8000=#7F OR Z?#8000=#55 OR Z?#8000=#6A;G.1101
1120IF Z?#8000=#43 OR Z?#8000=#70;G.1101
1130IF(Z-1)?#8000=#6A;Z=Z-2;G.1105
1135IF(Z+1)?#8000=#55;Z=Z+2;G.1105
1136IF Z>480;Z=Z-128;G.1101
1137IF Z<62;Z=Z+128;G.1101
1140G.530
2000P.$12"*********** hyperman ***********"
2010IN.'"DO YOU WANT INSTRUCTIONS (Y/N)"$#2800
2011IF?#2800=CH"N";RETURN
2020P."TO MOVE USE THE KEYS: t-UP"'
2030P."                f-LEFT   h-RIGHT"
2035P."                      v-DOWN"''
2040P."THE POINTS:    CHARACTERS:"'
2045P." .=10 POINTS    �=EXTRA LIFE"'
2050P." *=30 POINTS    #=MONSTER"'
2055P." O=50 POINTS    $=HYPER MONSTER"'
2056P."                `=ZAP OFF"''
2057P."PRESS ANY KEY TO START"
2060LINK#FFE3;RETURN
