// Variable Usage
//
// A - the annotation to show on the RHS (0 = Short Publisher, 1 = Publisher, 2 = Genre, 3 = Collection, 255 = Count)
// B - the load address of the MENUMC file
// C - the load address of the SORTDAT file
// D - the load address of the MENUDAT file
// E - current filter record address
// F - page state variable (0=Normal title selection, F=1,2,3 showing the filter selection pages)
// G - current filter (0=No filter; 1=Publisher, 2=Genre, 3=Collection)
// H - current filter value (as an integer)
// I - A temporary variable
// K - The index number of the program about to be *RUN
// L - The number of lines per page
// M - The current number of pages
// P - The current page (1..M)
// Q - The constant #8f 
// R - The address of a buffer into which the machine code stores the rendered row addresses
// S - The current sort order (0=Title,1=Publisher,2=Genre,3=Collection)
// Y - The currently highlighted row (0..L-1)
// Z - The currently base address of the current sort index or filter pointer table)

// ?#80,#81 - Set from Z just before calling "WritePage" machine code
// ?#82,#83 - Set from P,M,L just before calling machine code
// ?#84,#85 - The value of R being passed to the "WritePage" machine code
// ?#86     - Set from A just before calling machine code
// ?#87     - The currently active filter (0=Title,1=Genre,2=Publisher,3=Collection) (different order reflects data layout of title records_
// ?#88     - The currently active filter value
// ?#89     - Whether to enable search filtering (0 = Yes, >0 = No)
// ?#8A     - Current Page
// ?#8B,#8C - Set to D just before calling  "WritePage" machine code
// ?#8F     - Value set by "InKey" machine code (from calling #FE71)
// ?#8F     - Row to highlight, used by "Highlight" machine code

 10 *NOMON
 20 CLEAR 4
 30 *LOAD MNU/SCREEN3
 40 *LOAD MNU/MENUMC
 50 B=!#CD&#FFFF
 60 *LOAD MNU/SORTDAT
 70 C=!#CD&#FFFF
 80 FOR I=1TO60;WAIT;N.
 90 CLEAR 0
100 *LOAD MNU/MENUDAT
110 D=!#CD&#FFFF

    // Initialize the variables
120 L=13;S=0;F=0;A=1;G=0;R=#021C;Q=#8F

    // Initialize the search buffer to empty
125 ?#120=13

    // Turn off the cursor and refresh the screen
130a?#E1=0;GOS.x

    // Refresh rows, page number and total number of pages
200bGOS.j
260 LINK B;M=(!R&#FFFF+L-1)/L
270 LINK (B+12)
    // 270 ?#801B=P/10+176;?#801C=P%10+176
    // 280 ?#801E=M/10+176;?#801F=M%10+176
290 GOS.i

    // Shift Key is pressed (scroll up)
300cIF ?#B001&128>0 G.d
310 IF Y>0 GOS.i;Y=Y-1;GOS.i;G.c
320 IF P>1 P=P-1;GOS.i;Y=L-1;G.b

    // Control Key is pressed (scroll down)
400dIF?#B001&64>0 G.e
410 IF Y<>L-1 AND ?(#8060+Y*32)<>32 GOS.i;Y=Y+1;GOS.i;G.c
420 IF P<M P=P+1;GOS.i;Y=0;G.b

    // Repeat Key is pressed (next annotation)
500eIF?#B002&64=0 AND F=0 A=(A+1)&3;GOS.i;Y=0;G.b

    // Call InKey()
510 LINK (B+3)

    // No key pressed
520 IF ?Q=255 G.c

    // < key pressed (previous page)
600 IF ?Q=28 IF M>1 P=P-1+(P=1)*M;GOS.i;Y=0;G.b

    // > key pressed (next page)
610 IF ?Q=30 IF M>1 P=P+1-(P=M)*M;GOS.i;Y=0;G.b

	// ? key pressed (help)
615 IF ?Q=31 GOS.h;G.a

    // 1..4 key pressed (change sort)
620 IF ?Q>16 AND ?Q<21 S=?Q-17;F=0;A=A&127;G.a

    // 5 key pressed (clear filter>
630 IF ?Q=21 F=0;G=0;A=A&127;G.a

    // 6..8 key pressed (filter by publisher, genre or connection)
640 IF ?Q>21 AND ?Q<25 F=?Q-21;G=0;A=A|128;G.a

    // <Return> or <Space> pressed (select current item)
650 IF ?Q=0 OR ?Q=13 G.f 

    // S key pressed (start search)
655 IF ?Q=51 AND F=0 GOS.i;P=1;GOS.j;LINK(B+9);G.a

    // A..M key pressed (select an item)
660 IF ?Q<33 OR ?Q>45 G.c 

    // Make sure that the row is not blank
670 Y=?Q-33;IF ?(#8040+Y*32)=32 G.c

    // Get the address of the record selected
680fI=R!(Y*2 + 2)

    // Handle selection of a filter item
690 IF F>0 G=F;F=0;A=A&127;E=I+4;H=(P-1)*L+Y;G.a

    // Handle *RUN of a title - K is the title index
800 K=(!I)&#3FF
810 P=#100
820 $P="RUN MNU/"
830 P=P+LEN(P)
840 IF K>99 P?0=48+(K/100)%10;P=P+1
850 IF K>9 P?0=48+(K/10)%10;P=P+1
860 ?P=48+K%10;P?1=13;P?2=13
870 P.$12;LINK #FFF7
880 END

    // Subroutine to show the help
890h*LOAD MNU/HELP 8000
895 LINK#FFE3;P.$12;R.

    // Subroutine to invert line 2+Y on the screen 
900i?Q=Y+2;LINK(B+6);R.

   // Subroutine to set the zero page locations prior to calling machine code 
950j!#80=Z
951 !#82=1+(P-1)*L
952 !#84=R
953 ?#86=A
954 ?#87=(G&1)*2+(G&2)/2
955 ?#88=H
956 ?#89=F
957 ?#8A=P
958 !#8B=D
959 R.

    // Subroutine to update the page header

    // Inputs
    //   F=0 indicates titles should be shown
    //   F (1..3) indicates one of the filter selection pages should be selected
    //   S is the sort order - valid only when F=0
    //   G (0..3) indicates the filter type (none, publisher, genre, collection) - valid only when F=0
    //   E is the filter value string - valid only when G>0
    //   L is the number of lines per page to show (typically 13)
    // Outputs
    //   Z is updated to point to the appropriate record pointer table
    //   Y is set to 0, which will select the first row
    //   P is set to 1, which will select the first page
    
1000xP.$30'"                                "$30
1010 IF F=0 P."ATOMMC";I=S;Z=!(C+S*2)&#FFFF
1020 IF F>0 P."FILTER";I=F;Z=!(D+F*2+2)&#FFFF
1030 P." BY ";GOS.y;P."  PAGE   /  "
1040 IF G>0 I=G;P."  ";GOS.z;P."="$E'
1050 Z=Z+2
1060 Y=-2;GOS.i;Y=0;P=1;R.


    // Subroutine to print the filter name padded with spaces to 10 chars
1200yGOS.z
1220 IF I=1 P." "
1230 IF I=2 P."     "
1240 R.

    // Subroutine to print the filter name not padded at all
1500zIF I=0 P."TITLE     "
1510 IF I=1 P."PUBLISHER"
1520 IF I=2 P."GENRE"
1530 IF I=3 P."COLLECTION"
1540 R.

