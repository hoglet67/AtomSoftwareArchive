  5 REM ... CAR MAZE ...
 10 H=0;I=6;L=32
 20 DIM W(I*L)
 22 $W=    " *         *         *         *"
 23 $W+ 32="      *         *         *     "
 24 $W+ 64="      ******    *    ******     "
 25 $W+ 96=" ******    ******    ******     "
 26 $W+128=" *    ******    ******    ******"
 27 $W+160=" *    *    ******    *    *    *"
 28 FORN=0TO L*I;IF W?N=#2A W?N=#FF 29 NEXT
 30sPRINT$12;?#E1=0;PRINT'''''''''''''''
 35 Y=16;@=6;G=0;E=200;V=0
 40 X=#81E0;B=#81E0
 50zIFY?X<>L GOTO x
 60 Y?X=160;FOR J=0TO E;NEXT
 61 IF G&1 GOTO v
 62 PRINT$10;X=X-L
 63 IF V=0 C=ABSRND%4+2; D=ABSRND%2;$B=$(W+C*L);V=4; GOTO v
 65 $B=$(W+D*L);V=V-1
100v?#81FF=L;G=G+1;IFE>0E=E-1
105 Y?X=L
110 IF?#B001<128 Y=(Y-1)&31 
120 IF?#B002&#40=0 Y=(Y+1)&31 
130 IF?#B001&#40<>0 GOTO z
140 IFY?X<>L GOTO x
150 IFX<B X=X+L
160 GOTO z
200xY?X=152;PRINT$7$30"score"G"   highscore"H;IF G>H H=G
210 LINK#FFE3;GOTO s
