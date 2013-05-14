// Variable Usage
//
// A - the annotation to show on the RHS (0 = ShortPublisher, 255 = None)
// F - a state variable, 0=Normal title selection, F=1,2,3 showing the filter selection pages
// I - A temporary loop variable
// K - The index number of the program about to be *RUN
// L - The number of lines per page
// M - The current number of pages
// N - The total number of unfiltered titles
// P - The current page (1..M)
// R - The address of a buffer into which the machine code stores the rendered row addresses
// S - The current sort order (0=Title,1=Publisher,2=Genre,3=Collection)
// X - Temporary screen address for highlighting current row
// Y - the currently highlighted row (0..L-1)
// Z - The currently base address of the current sort index or filter pointer table)
// ?#80,#81 - Set from Z just before calling "RenderPage" machine code
// ?#80 - Value set by "InKey" machine code (from calling #FE71)
// ?#8E,#8F - Set from P,M,L just before calling machine code
// ?#8B - Set from A just before calling machine code
// ?#8C - The currently active filter (0=Title,1=Genre,2=Publisher,3=Collection) (different order reflects data layout of title records_
// ?#8D - The currently active filter value
// ?#92 - The value of R being passed to the "RenderPage" machine code
 10 *NOMON
 20 CLEAR 4
 30 *LOAD MNU/SCREEN2
 32 *LOAD MNU/SORTDAT
 34 *LOAD MNU/MENUMC
 40 FOR I=1TO60;WAIT;N.
 50 CLEAR 0
 60 *LOAD MNU/MENUDAT
110 REM GENERAL SETTINGS
120 P=1;L=13;S=0;F=0;A=0;R=#2880
125 N=!!#3600&#FFFF;M=(N+L-1)/L
130 ?#8C=0;!#92=R
170 REM PAGE HEADER
180 P.$12;?#E1=0
190 GOS.y
200 ?#801B=P/10+176;?#801C=P%10+176
210 ?#801E=M/10+176;?#801F=M%10+176
230 REM BUILD MENUPAGE
240 P.$30''
250 !#80=Z
251 ?#8B=A
252 !#8E=(P-1)*L
260 LINK #3300
270 GOS.i
290 REM SHIFT-KEY
300 IF ?#B001&128>0 G.370
310 IF Y>0 G.340
320 IF P=1 G.300
330 P=P-1;GOS.i;Y=L-1;G.200
340 GOS.i;Y=Y-1;GOS.i;G.300
360 REM CTRL-KEY
370 IF?#B001&64>0 G.440
380 IF Y<>L-1 G.410
390 IF P=M G.300
400 P=P+1;GOS.i;Y=0;G.200
410 IF ?(#8060+Y*32)=32 G.440
415 GOS.i;Y=Y+1;GOS.i;G.300
430 REM REPT-KEY
440 IF?#B002&64>0 G.480
450 P=(P%M)+1;GOS.i;Y=0;G.200
470 REM KEY HANDLING
480 LINK #3303
490 IF ?#80=0 G.300
495 IF ?#80=21 F=0;GOS.z;G.200
500 IF ?#80>21 AND ?#80<25 F=?#80-21;GOS.x;G.200
510 IF ?#80>16 AND ?#80<21 S=?#80-17;GOS.y;G.200
580 IF ?#80>32 AND ?#80<46 Y=?#80-33
585 IF ?(#8040+Y*32)=32 G.300
590 J=R!(Y*2)
605 IF F>0 THEN GOS.z;G.200
606 REM BOOTLOAD PROGRAM
610 K=(!J)&#3FF
620 P=#100
630 $P="RUN MNU/"
640 P=P+LEN(P)
650 IF K>99 THEN ?P=48+(K/100)%10;P=P+1
670 IF K>9 THEN ?P=48+(K/10)%10;P=P+1
680 ?P=48+K%10;P?1=13;P?2=13
710 P.$12;LINK #FFF7
720 END
730iX=#8040+Y*32
740 F.I=0TO31S.4;I!X=I!X:#80808080;N.
750 R.
760xP.$30
770 IF F=1 P." FILTER/PUBLISHER     PAGE   /  "'
780 IF F=2 P." FILTER/GENRE         PAGE   /  "'
790 IF F=3 P." FILTER/COLLECTION    PAGE   /  "'
800 Z=!(#8202+F*2)&#FFFF;A=255;?#8C=0
805 M=!Z&#FFFF;M=(M+L-1)/L;Z=Z+2
810 Y=-2;GOS.i;Y=0;P=1;R.
820yP.$30
830 IF S=0 P." ATOMMC BY TITLE      PAGE   /  "'
840 IF S=1 P." ATOMMC BY PUBLISHER  PAGE   /  "'
850 IF S=2 P." ATOMMC BY GENRE      PAGE   /  "'
860 IF S=3 P." ATOMMC BY COLLECTION PAGE   /  "'
870 Z=2+!(#3600+S*2)&#FFFF;A=0
900 Y=-2;GOS.i;Y=0;P=1;R.
920z?#8D=(P-1)*L+Y; GOS.y
930 P.$30'"                                "$30
935 ?#8C=0
940 IF F=1 P.'"  PUBLISHER="$(J+4)';?#8C=2
950 IF F=2 P.'"  GENRE="$(J+4)';?#8C=1
960 IF F=3 P.'"  COLLECTION="$(J+4)';?#8C=3
970 IF F>0 F=0;M=!J&#FFFF;M=(M+L-1)/L; R.
980 M=(N+L-1)/L;R.
