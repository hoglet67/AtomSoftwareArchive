
0 REM THE BEST OF INTERFACE PAGE 22-23-24
10 REM DEATHSTAR DRAUGHTS BY HARTNELL 1982
20 P.$12
30 GOS.1140
40 GOS.960
50 M=0
60 P.$7
70 P.';P."LAST MOVE "$G'
80 F.I=1 TO 2
90 IF I=1 INPUT"FROM"$E
100 IF I=2 INPUT"TO"$E;$G=$E
110 IF $E="A2" FF(I)=72
120 IF $E="A4" FF(I)=71
130 IF $E="A6" FF(I)=70
140 IF $E="A8" FF(I)=69
150 IF $E="B1" FF(I)=66
160 IF $E="B3" FF(I)=65
170 IF $E="B5" FF(I)=64
180 IF $E="B7" FF(I)=63
190 IF $E="C2" FF(I)=59
200 IF $E="C4" FF(I)=58
210 IF $E="C6" FF(I)=57
220 IF $E="C8" FF(I)=56
230 IF $E="D1" FF(I)=53
240 IF $E="D3" FF(I)=52
250 IF $E="D5" FF(I)=51
260 IF $E="D7" FF(I)=50
270 IF $E="E2" FF(I)=46
280 IF $E="E4" FF(I)=45
290 IF $E="E6" FF(I)=44
300 IF $E="E8" FF(I)=43
310 IF $E="F1" FF(I)=40
320 IF $E="F3" FF(I)=39
330 IF $E="F5" FF(I)=38
340 IF $E="F7" FF(I)=37
350 IF $E="G2" FF(I)=33
360 IF $E="G4" FF(I)=32
370 IF $E="G6" FF(I)=31
380 IF $E="G8" FF(I)=30
390 IF $E="H1" FF(I)=27
400 IF $E="H3" FF(I)=26
410 IF $E="H5" FF(I)=25
420 IF $E="H7" FF(I)=24
430 NEXT I
440 AA(FF(2))=AA(FF(1));AA(FF(1))=B
450 IF W<73;AA(W)=B
460 W=43+A.R.%11;IF (W>46) AND (W<50) GOTO 460
470 IF AA(W)=C;T=T+1
480 IF AA(W)=H;S=S+1
490 AA(W)=119
500 IFABS(FF(1)-FF(2))>7;M=1;AA(FF(1)+((FF(2)-FF(1))/2))=B
510 IF((AA(Z)=C)&(Z>23)&(Z<28));AA(Z)=H
520 GOS.960
530 AA(W)=B
540 F.Z=24 TO 72
550 IF ((AA(Z)=C)&(Z>23)&(Z<28));AA(Z)=H
560 IF((AA(Z)=H AND (Z>68) AND (Z<73)));AA(Z)=C
570 NEXT Z
580 Q=0;Z=24;D=1
590 REM RESPOND
600 IF AA(Z)=H;GOTO 690
610 IF AA(Z)=9;GOTO 690
620 IF AA(Z)=B;GOTO 690
630 IF AA(Z)=W;GOTO 690
640 U=0
650 IF (AA(Z+XX(D))=H);U=7
660 IF ((U=7)&(AA(Z+2*XX(D))=B));Q=XX(D)
670 IF Q<>0;GOTO 710
680 IF (D<2);D=D+1;GOTO 640
690 IF(Z<72);Z=Z+1;D=1;GOTO 590
700 IF Q=0;GOTO 730
710 AA(Z+2*Q)=AA(Z);S=S+1;AA(Z+Q)=B;AA(Z)=B
720 GOTO 40
730 Z=72;U=0
740 IF (AA(Z)<>C);GOTO 820
750 IF (AA(Z-13)=H);GOTO 820
760 IF (AA(Z-12)=H);GOTO 820
770 IF (AA(Z-14)=H);GOTO 820
780 IF (AA(Z-6)=B)&(AA(Z-12)=C);U=-6
790 IF U=-6&AA(Z-18)=H;Q=Z-6
800 IF (AA(Z-7)=B)&(AA(Z-14)=C);U=-7
810 IF U=-7&AA(Z-21)=H;Q=Z-7
820 IF (Q=0)&(Z>23);Z=Z-1;GOTO 740
830 Y=0
840 Z=24+A.R.%48;Y=Y+1;IF Y>400;GOTO 940
850 IF (AA(Z)<>C);GOTO 840
860 IF Y>200;GOTO 900
870 IF (AA(Z-13)=H);GOTO 840
880 IF (AA(Z-14)=H);GOTO 840
890 IF (AA(Z-12)=H);GOTO 840
900 D=1
910 IF AA(Z+XX(D))=B;Q=XX(D);GOTO 950
920 IF D<2;D=D+1;GOTO 910
930 GOTO 840
940 IF Y>400;$E="Z";GOTO 960
950 AA(Z+Q)=AA(Z);AA(Z)=B;GOTO 40
960 P.$30;@=0;?#E1=0
970 IF M=1;T=T+1
980 M=0
990 P."ATOM "S"    HUMAN "T'
1000P."      *12345678*"'
1010P."     A* "$AA72" "$AA71" "$AA70" "$AA69"*A"'
1020 P."     B*"$AA66" "$AA65" "$AA64" "$AA63" *B"'
1030P."     C* "$AA59" "$AA58" "$AA57" "$AA56"*C"'
1040 P."     D*"$AA53" "$AA52" "$AA51" "$AA50" *D"'
1050P."     E* "$AA46" "$AA45" "$AA44" "$AA43"*E"'
1060 P."     F*"$AA40" "$AA39" "$AA38" "$AA37" *F"'
1070P."     G* "$AA33" "$AA32" "$AA31" "$AA30"*G"'
1080 P."     H*"$AA27" "$AA26" "$AA25" "$AA24" *H"'
1090P."      *12345678*"'
1100 IF $E="Z";T=10
1110 IF (T=10);P."you win";?#E1=128;END
1120 IF (S=10);P."i win";?#E1=128;END
1130 RETURN
1140 DIM AA(86),XX(2),L(1),FF(2);XX(1)=-6;XX(2)=-7
1150 H=72;C=67;B=46;Q=0
1160 DIM G(2),E(2)
1170 F.Z=1 TO 86;AA(Z)=9
1180IF((Z<73)&(Z>55))&(Z<>67)&(Z<>68)&(Z<>61);AA(Z)=C
1190IF((Z<54)&(Z>42))&(Z<>47)&(Z<>48)&(Z<>49);AA(Z)=B
1200IF((Z<41)&(Z>23))&(Z<>34)&(Z<>35)&(Z<>36)&(Z<>28);AA(Z)=H
1210 NEXT Z;AA(62)=9;AA(29)=9;AA(60)=9;AA(71)=C
1220 $E="";S=0;T=0;M=0;$G="?";W=R.
1230 Z=A.R.%2+57;Q=A.R.%2+6;AA(Z)=B;AA(Z-Q)=C
1240 RETURN
