// Variable Usage
//
// A - the annotation to show on the RHS (0 = ShortPublisher, 255 = None)
// B - the load address of the SORTDAT file
// C - the load address of the MENUDAT file
// E - current filter record address
// F - 0=Normal title selection, F=1,2,3 showing the filter selection pages
// G - current filter 0=No filter; 1=Publisher, 2=Genre, 3=Collection
// H - current filter value (as an int)
// I - A temporary loop variable
// J
// K - The index number of the program about to be *RUN
// L - The number of lines per page
// M - The current number of pages
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
 40 *LOAD MNU/MENUMC
 50 *LOAD MNU/SORTDAT
 60 B=!#CD&#FFFF
 70 FOR I=1TO60;WAIT;N.
 80 CLEAR 0
 90 *LOAD MNU/MENUDAT
100 C=!#CD&#FFFF

    // Initialize the variables
110 L=13;S=0;F=0;A=1;G=0;R=#2880;!#92=R

    // Turn off the cursor and refresh the screen
120 ?#E1=0;GOS.x

    // Refresh page number and the rows
200a?#801B=P/10+176;?#801C=P%10+176
210 ?#801E=M/10+176;?#801F=M%10+176
220 !#80=Z
230 ?#8B=A
240 ?#8C=(G&1)*2+(G&2)/2
250 ?#8D=H
260 !#8E=(P-1)*L
270 LINK #3300
280 GOS.i

    // Shift Key is pressed (page down)
300bIF ?#B001&128>0 G.c
310 IF Y>0 GOS.i;Y=Y-1;GOS.i;G.b
320 IF P>1 P=P-1;GOS.i;Y=L-1;G.a

    // Control Key is pressed (page up)
400cIF?#B001&64>0 G.d
410 IF Y<>L-1 AND ?(#8060+Y*32)<>32 GOS.i;Y=Y+1;GOS.i;G.b
420 IF P<M P=P+1;GOS.i;Y=0;G.a

    // Repeat Key is pressed (next annotation)
500dIF?#B002&64=0 AND F=0 A=(A+1)&3;GOS.i;Y=0;G.a

    // Call InKey()
510 LINK #3303

    // No key pressed
520 IF ?#80=0 G.b

    // < key pressed (previous page)
600 IF ?#80=28 P=P-1+(P=1)*M;GOS.i;Y=0;G.a

    // > key pressed (next page)
610 IF ?#80=30 P=P+1-(P=M)*M;GOS.i;Y=0;G.a

    // 1..4 key pressed (change sort)
620 IF ?#80>16 AND ?#80<21 S=?#80-17;F=0;A=A&127;GOS.x;G.a

    // 5 key pressed (clear filter>
630 IF ?#80=21 F=0;G=0;A=A&127;GOS.x;G.a

    // 6..8 key pressed (filter by publisher, genre or connection)
640 IF ?#80>21 AND ?#80<25 F=?#80-21;G=0;A=A|128;GOS.x;G.a

    // A..M key pressed (select an item)
650 Y=0;IF ?#80>32 AND ?#80<46 Y=?#80-33

    // Make sure that the row is not blank
660 IF ?(#8040+Y*32)=32 G.b

    // Get the address of the record selected
670 J=R!(Y*2)

    // Handle selection of a filter item
680 IF F>0 G=F;F=0;A=A&127;E=J;H=(P-1)*L+Y;GOS.x;G.a

    // Handle *RUN of a title - K is the title index
800 K=(!J)&#3FF
810 P=#100
820 $P="RUN MNU/"
830 P=P+LEN(P)
840 IF K>99 THEN ?P=48+(K/100)%10;P=P+1
850 IF K>9 THEN ?P=48+(K/10)%10;P=P+1
860 ?P=48+K%10;P?1=13;P?2=13
870 P.$12;LINK #FFF7
880 END

    // Subroutine to invert line 2+Y on the screen 
900iX=#8040+Y*32
910 F.I=0TO31S.4;I!X=I!X:#80808080;N.
920 R.

    // Subroutine to update the page header

    // Inputs
    //   F=0 indicates titles should be shown
    //   F (1..3) indicates one of the filter selection pages should be selected
    //   S is the sort order - valid only when F=0
    //   G (0..3) indicates the filter type (none, publisher, genre, collection) - valid only when F=0
    //   E is the filter value string - valid only when G>0
    //   L is the number of lines per page to show (typically 13)
    // Outputs
    //   M is updated with the number of pages
    //   Z is updated to point to the appropriate record pointer table
    //   Y is set to 0, which will select the first row
    //   P is set to 1, which will select the first page
1000xP.$30'"                                "$30
1010 IF F=0 P."ATOMMC";I=S
1020 IF F>0 P."FILTER";I=F
1030 P." BY ";GOS.y;P."  PAGE   /  "
1040 IF G>0 I=G;P."  ";GOS.z;P."="$(E+4)'
1050 IF F>0 Z=!(C+F*2 + 2)&#FFFF
1060 IF F=0 Z=!(B+S*2)&#FFFF
1070 IF G>0 M=!E&#FFFF;
1080 IF G=0 M=!Z&#FFFF;
1090 M=(M+L-1)/L;Z=Z+2
1100 Y=-2;GOS.i;Y=0;P=1;R.

    // Subroutine to print the filter name padded with spaces to 10 chars
1200yGOS.z;
1220 IF I=1 P." "
1230 IF I=2 P."     "
1240 R.

    // Subroutine to print the filter name not padded at all
1500zIF I=0 P."TITLE     "
1510 IF I=1 P."PUBLISHER"
1520 IF I=2 P."GENRE"
1530 IF I=3 P."COLLECTION"
1540 R.
