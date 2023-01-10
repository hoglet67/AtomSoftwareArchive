   Base = $2800

include "renderer_header.asm"

	PlotDriverLS = $f6d3
	PlotDriverMS = $f6d8
	GraphicsCtrl = $f6dd
	KernelOsrdch = $fe94
	RDCVEC       = $20a

IF (sddos = 1)
	RowReturnBuf = $3200         ; A temporary work around as SDDOS uses $22B,$22C

	TmpPtr       = $78
	DerefTmp     = $7a
	SortTablePtr = $7c
	PageState    = $7e
	NumPages     = $7f
	Item         = $97
	SortType     = $8c
	FilterType   = $8d
	FilterString = $8e
	AutoRepeat   = $8f

	ExecAddr     = $9e ; don't change this, it's what SDDOS uses

ELIF (econet = 1)

	RowReturnBuf = $3200

	TmpPtr       = $78
	DerefTmp     = $7a
	SortTablePtr = $7c
	PageState    = $7e
	NumPages     = $7f
	Item         = $97
	SortType     = $8c
	FilterType   = $8d
	FilterString = $8e
	AutoRepeat   = $8f

	ExecAddr     = $d0 ; don't change this, it's what ECONET uses

ELSE
	RowReturnBuf = $021c

	TmpPtr       = $70
	DerefTmp     = $72
	SortTablePtr = $74
	PageState    = $76
	NumPages     = $77
	Item         = $78
	SortType     = $79
	FilterType   = $7a
	FilterString = $7b
	AutoRepeat   = $7d

	ExecAddr     = $cd ; don't change this, it's what AtoMMC uses

ENDIF

IF (econet = 1)
   DirSep = '.'
ELSE
   DirSep = '/'
ENDIF

	AutoRepeat1  = -$200
	AutoRepeat2  = -$20

; Basic -> Machine Code Variable Mapping
;
; A -> Annotation      - the annotation to show on the RHS
; B -> n/a             - the load address of the MENUMC file
; C -> SortTablePtr    - the load address of the SORT data file
; D -> MenuTablePtr    - the load address of the MENU data file
; E -> FilterString    - current filter record address
; F -> PageState       - page state variable (0=Normal title selection, F=1,2,3 showing the filter selection pages)
; G -> FilterType      - current filter (0=No filter; 1=Publisher, 2=Genre, 3=Collection)
; H -> FilterVal       - current filter value (as an integer)
; I -> TmpI            - A temporary variable
; K                    - The index number of the program about to be *RUN
; L -> LinesPerPage    - (CONSTANT) The number of lines per page
; M -> NumPages        - The current number of pages
; P -> Page            - The current page (1..M)
; Q -> n/a             - The constant #8f
; R -> RowReturnBuf - (CONSTANT) The address of a buffer into which the machine code stores the rendered row addresses
; S -> SortType        - The current sort order (0=Title,1=Publisher,2=Genre,3=Collection)
; Y -> Item            - The currently highlighted row (0..L-1)
; Z -> Sort            - The currently base address of the current sort index or filter pointer table)

	org Base - 22

.STARTOFHEADER

; 22 byte ATM header

	EQUS    "MENU"

	EQUB    $00
	EQUB    $00
	EQUB    $00
	EQUB    $00
	EQUB    $00
	EQUB    $00
	EQUB    $00
	EQUB    $00
	EQUB    $00
	EQUB    $00
	EQUB    $00
	EQUB    $00

	EQUB    <Base
	EQUB    >Base

	EQUB    <Base
	EQUB    >Base

	EQUW	ENDOF - STARTOF

.STARTOF


.Menu
	; Work around for issue with older versions of AtomMMC on some titles (e.g. SUB HUNT)
	LDA #<KernelOsrdch
	STA RDCVEC
	LDA #>KernelOsrdch
	STA RDCVEC + 1

	; Quick test for memory beyond 0x3C00
	LDY #0
	STY TmpPtr
	LDA #$3C
	STA TmpPtr + 1
.MemWrLoop
	LDA TmpPtr + 1
	EOR #$FF
	STA (TmpPtr),Y
	INC TmpPtr + 1
	BPL MemWrLoop

	LDA #$3C
	STA TmpPtr + 1
.MemRdLoop
	LDA TmpPtr + 1
	EOR #$FF
	CMP (TmpPtr),Y
	BNE MemTestFail
	INC TmpPtr + 1
	BPL MemRdLoop
	BMI MemTestDone

.MemTestFail
   INC SplashNum
	DEC MenuMaxKey + 1

.MemTestDone

IF (econet = 1)
	JSR OscliString
	EQUS "DIR $.ASA", Return
	;JSR OscliString
	;EQUS "LIB $.ATOMLIB", Return
ELSE
	; 10 *NOMON
	JSR OscliString
	EQUS "NOMON", Return
ENDIF

.MenuSplash

	; 20 CLEAR 4
	LDY #4
	JSR Clear

	; 30 *LOAD SPLASH
	JSR OscliString
	EQUS "LOAD SPLASH"

.SplashNum
   EQUB '1', Return

.MenuMain
	JSR Osrdch
	CMP #'A'
	BCC MenuMain
.MenuMaxKey
	CMP #'G' + 1
	BCC MenuNext
	; Check for special system key for Rolands system
	CMP #'R'
	BNE MenuMain

	LDY #0
	JSR Clear
	JSR OscliString
IF (econet = 1)
	EQUS "DIR SYS", Return
ELSE
	EQUS "CWD SYS", Return
ENDIF
	JSR OscliString
	EQUS "INIT", Return

	; Don't expect to return, but just in case....
	JMP $c2b2

.MenuNext

IF (sddos = 1)
	ADC #<(1016 - 'A')
	STA BinBuffer
	LDA #>(1016 - 'A')
	STA BinBuffer + 1
	LDA #'1'
	JSR LoadDisk
	JSR OscliString
	EQUS "DRIVE 1", Return
ELSE
   STA MenuDirChunk
	JSR OscliString
   IF (econet = 1)
	   EQUS "DIR MNU"
   ELSE
	   EQUS "CWD MNU"
   ENDIF
   .MenuDirChunk
   EQUS " ", Return
ENDIF

	; 90 CLEAR 0
	LDY #0
	JSR Clear
	LDA #12
	JSR Oswrch

	;100 *LOAD MNU/MENU1
	JSR OscliString
	EQUS "LOAD MENU1", Return

	;110 D=!#CD&#FFFF
	LDA ExecAddr
	STA MenuTablePtr
	LDA ExecAddr + 1
	STA MenuTablePtr + 1

	;115 *LOAD MNU/MENU2
	JSR OscliString
	EQUS "LOAD MENU2", Return

	; // Initialize the variables
	; 120 L=13;S=0;F=0;A=1;G=0;R=#2880;Q=#8F
	LDY #0
	STY SortType    ; S=0
	STY PageState   ; F=0
	STY FilterType  ; G=0
	INY
	STY Annotation  ; A=1

	JSR LoadSortTable

	; // Initialize the search buffer to empty
	; 125 ?#120=13
	LDA #0
	STA SearchBuffer

.LabelA
	; // Turn off the cursor and refresh the screen
	; 130a?#E1=0;GOS.x
	; ?#E1=0 Not needed as we do our own screen output driver
	JSR LabelX

.LabelB
	; // Refresh rows, page number and total number of pages
	; 200bGOS.j
	JSR LabelJ

	; 260 LINK B;M=(!R&#FFFF+L-1)/L
	JSR WritePage
	JSR CalculateNumPages
	STY NumPages

	; 270 ?#801B=P/10+176;?#801C=P%10+176
	; 280 ?#801E=M/10+176;?#801F=M%10+176
	JSR UpdateTotalPages

	; 290 GOS.i
	JSR LabelI

.ReleaseKey
	JSR HandleAutoRepeat

.LabelC
	; // Check for original Atom
	LDA $bd00
	CMP #$bf
	BNE HandleUpKeyOriginal

	; // Shift Key is pressed emulator (scroll up)
	; 300cIF ?#B001&128>0 G.d
	BIT $b001
	BMI LabelD
	JMP LabelC2

.HandleUpKeyOriginal
	; // Ctrl Key is pressed Original Atom (scroll up)
	; 300cIF ?#B001&64>0 G.d
	BIT $b001
	BVS LabelD

.LabelC2
	; 310 IF Y>0 GOS.i;Y=Y-1;GOS.i;G.c
	LDA Item
	BEQ LabelC1
	JSR LabelI
	DEC Item
	JSR LabelI
	BMI ReleaseKey ; Always

.LabelC1
	; 320 IF P>1 P=P-1;GOS.i;Y=L-1;G.b
	LDA Page
	CMP #1
	BEQ LabelD
	DEC Page
	JSR LabelI
	LDA #(LinesPerPage - 1)
	STA Item
	JMP LabelB

.LabelD
	; // Check for original Atom
	LDA $bd00
	CMP #$bf
	BNE HandleDownKeyOriginal

	; // Control Key is pressed emulator (scroll down)
	; 400dIF?#B001&64>0 G.e
	BIT $b001
	BVS LabelE
	JMP LabelD2

.HandleDownKeyOriginal
	; // Shift Key is pressed Original Atom (scroll down)
	; 300cIF ?#B001&128>0 G.d
	BIT $b001
	BMI LabelE

.LabelD2
	; 410 IF Y<>L-1 AND ?(#8060+Y*32)<>32 GOS.i;Y=Y+1;GOS.i;G.c
	LDA Item
	CMP #(LinesPerPage - 1)
	BEQ LabelD1
	CLC
	ADC #1
	JSR TestRowActive
	BEQ LabelD1
	JSR LabelI
	INC Item
	JSR LabelI
	JMP ReleaseKey

.LabelD1
	; 420 IF P<M P=P+1;GOS.i;Y=0;G.b
	LDA Page
	CMP NumPages
	BEQ LabelE
	INC Page

.SetItemToZero
	JSR LabelI
	LDA #0
	STA Item
	JMP LabelB

.LabelE
	; 500eIF?#B002&64=0 AND F=0 A=(A+1)&3;GOS.i;Y=0;G.b
	BIT $b002
	BVS CallInkey
	LDA PageState
	BNE CallInkey
	INC Annotation
	LDA Annotation
	AND #3
	STA Annotation
	JMP SetItemToZero

.CallInkey
	; // Call InKey()
	; 510 LINK (B+3)
	JSR Inkey

    ; // No key pressed
    ; 520 IF ?Q=255 G.c
	CPY #$FF
	BNE TestForPrevPage
	JMP LabelC

.TestForPrevPage
    ; // < key pressed (previous page)
    ; 600 IF ?Q=28 IF M>1 P=P-1+(P=1)*M;GOS.i;Y=0;G.b
    CPY #28
    BNE TestForNextPage
    LDA NumPages
    CMP #1
    BEQ TestForNextPage
    DEC Page
    BNE PrevPageNoWrap
 	STA Page
.PrevPageNoWrap
 	JMP SetItemToZero

.TestForNextPage
    ; // > key pressed (next page)
	; 610 IF ?Q=30 IF M>1 P=P+1-(P=M)*M;GOS.i;Y=0;G.b
	CPY #30
	BNE TestForHelp
    LDA NumPages
    CMP #1
    BEQ TestForHelp
	INC Page
	LDA NumPages
	CMP Page
	BCS NextPageNoWrap
	LDA #1
	STA Page
.NextPageNoWrap
	JMP SetItemToZero

.TestForHelp
	; // ? key pressed (help)
	; 615 IF ?Q=31 GOS.h;G.a
	CPY #31
	BNE	TestForChangeSort
	JSR LabelH
	JMP LabelA

.TestForChangeSort
    ; // 1..4 key pressed (change sort)
	; 620 IF ?Q>16 AND ?Q<21 S=?Q-17;F=0;A=A&127;G.a
	CPY #17
	BCC TestForClearFilter
	CPY #21
	BCS TestForClearFilter
	TYA
	SBC #16
	STA SortType

	; Page in the appropriate sort table
	JSR LoadSortTable

.PageStateZero
	LDA #0
	STA PageState
	LDA Annotation
	AND #$7f
	STA Annotation
	JMP LabelA

.TestForClearFilter
    ; // 5 key pressed (clear filter>
	; 630 IF ?Q=21 F=0;G=0;A=A&127;G.a
	CPY #21
	BNE TestForChangeFilter
	LDA #0
	STA FilterType
	BEQ PageStateZero

.TestForChangeFilter
    ; // 6..8 key pressed (filter by publisher, genre or connection)
	; 640 IF ?Q>21 AND ?Q<25 F=?Q-21;G=0;A=A|128;G.a
	CPY #22
	BCC TestForSelect
	CPY #25
	BCS TestForSelect
	TYA
	SBC #20
	STA PageState
	LDA #0
	STA FilterType
	LDA Annotation
	ORA #$80
	STA Annotation
	JMP LabelA

.TestForSelect
    ; // <Return> or <Space> pressed (select current item)
	; 650 IF ?Q=0 OR ?Q=13 G.f
	CPY #0
	BEQ LabelF
	CPY #Return
	BEQ LabelF

    ; // S key pressed (start search)
	; 655 IF ?Q=51 AND F=0 GOS.i;P=1;GOS.j;LINK(B+9);G.a
	CPY #51
	BNE TestForAtoM
	LDA PageState
	BNE TestForAtoM
	JSR LabelI
	LDA #1
	STA Page
	JSR LabelJ
	JSR Search

	JMP LabelA

.JumpToLabelC
	JMP LabelC

.TestForAtoM
    ; // A..M key pressed (select an item)
	; 660 IF ?Q<33 OR ?Q>45 G.c
	CPY #32
	BCC JumpToLabelC
	CPY #46
	BCS JumpToLabelC

    ; // Make sure that the row is not blank
	; 670 Y=?Q-33;IF ?(#8040+Y*32)=32 G.c
	TYA
	SBC #32
	TAY
	JSR TestRowActive
	BEQ JumpToLabelC
	TYA
	STA Item

.LabelF

    ; // Get the address of the record selected
	; 680fI=R!(Y*2 + 2)
	LDA Item
	ASL A
	ADC #2
	TAY
	LDA #<(RowReturnBuf)
	STA TmpPtr
	LDA #>(RowReturnBuf)
	STA TmpPtr + 1
	LDA (TmpPtr),Y
	PHA
	INY
	LDA (TmpPtr),Y
	STA TmpPtr + 1
	PLA
	STA TmpPtr

    ; // Handle selection of a filter item
	; 690 IF F>0 G=F;F=0;A=A&127;E=I+4;H=(P-1)*L+Y;G.a
	LDA PageState
	BEQ BootProgram
	LDA PageState
	STA FilterType
	CLC
	LDA TmpPtr
	ADC #4
	STA FilterString
	LDA TmpPtr + 1
	ADC #0
	STA FilterString + 1

	; Assume the filter item is an 8 bit value
	LDA Item
	LDY Page
.LabelF1
	DEY
	BEQ LabelF2
	CLC
	ADC #LinesPerPage
	BCC LabelF1
.LabelF2
	STA FilterVal
	JMP PageStateZero

.BootProgram

    ; // Handle *RUN of a title - K is the title index
	; 800 K=(!I)&#7FF
	LDX #TmpPtr
	JSR Dereference
	LDA TmpPtr
	STA BinBuffer
	LDA TmpPtr + 1
	AND #$7
	STA BinBuffer + 1

	; 810 P=#100
	; 820 $P="RUN MNU/"
	; 830 P=P+LEN(P)
	; 840 IF K>99 P?0=48+(K/100)%10;P=P+1
	; 850 IF K>9 P?0=48+(K/10)%10;P=P+1
	; 860 ?P=48+K%10;P?1=13;P?2=13

	; CountString and OscliBuffer are the same ($100)

	; 870 P.$12;LINK #FFF7
	; 880 END
	LDA #12
	JSR Oswrch

IF (sddos = 1)

	LDA #'2'
	JSR LoadDisk

	JSR OscliString
	EQUS "DRIVE 2", Return

	JSR OscliString
	EQUS "RUN BOOT", Return

.LoadDisk
	STA RunCommand + 4

ELIF (econet = 1)

	JSR ChangeDirectory

	JSR OscliString
	EQUS "BOOT", Return

.ChangeDirectory

ENDIF

.RunCommand0
	LDX #0
.RunCommand1
	LDA RunCommand, X
	BEQ RunCommand2
	STA OscliBuffer, X
	INX
	BNE RunCommand1
.RunCommand2
IF (econet = 1)
	JSR WritePath
ELSE
	JSR WriteDecimal
ENDIF
	LDA #Return
	STA OscliBuffer, X
	INX
	STA OscliBuffer, X
	JMP Oscli

IF (sddos = 1)

.RunCommand
	EQUS "DIN  ,",0

ELIF (econet = 1)

.RunCommand
	EQUS "DIR $.ASA.",0

ELSE

.RunCommand
	EQUS "RUN ", 0

ENDIF


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Translated Basic Subroutines
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; Subroutine to show the help
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.LabelH

	;900h*LOAD HELP 8000

	JSR OscliString
	EQUS "LOAD HELP", Return

	;895 LINK#FFE3;P.$12;R.

	JSR Osrdch
	LDA #12
	JSR Oswrch
	RTS

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; Subroutine to invert line 2+Y on the screen
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.LabelI

	;900i?Q=Y+2;LINK(B+6);R.

	LDY Item
	INY
	INY
	STY Row
	JMP HighlightRow

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; Subroutine to set the zero page locations prior to calling machine code
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.LabelJ

	;950j!#80=Z
	;not needed as these are collapsed

	;951 !#82=1+(P-1)*L
	LDY #0
	STY StartRow + 1
	INY
	STY StartRow
.LabelJ1
	CPY Page
	BEQ LabelJ3
	CLC
	LDA StartRow
	ADC #LinesPerPage
	STA StartRow
	BCC LabelJ2
	INC StartRow + 1
.LabelJ2
	INY
	BNE	LabelJ1

.LabelJ3
	;952 !#84=R
	LDA #<RowReturnBuf
	STA RowRet
	LDA #>RowReturnBuf
	STA RowRet+1

	;953 ?#86=A
	;not needed as these are collapsed

	;954 ?#87=(G&1)*2+(G&2)/2
	LDA #0
	STA Filter
	LDA FilterType
	LSR A
	ROL Filter
	LSR A
	ROL Filter

	;955 ?#88=H
	;not needed as these are collapsed

	;956 ?#89=F
	LDA PageState
	STA SearchMode

	; 957 ?#8A=P
	;not needed as these are collapsed

	;958 R.
	RTS


    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; Subroutine to update the page header
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	; 1000xP.$30'"                                "$30
	; 1010 IF F=0 P."ATOMMC";I=S;Z=!(C+S*2)&#FFFF
	; 1020 IF F>0 P."FILTER";I=F;Z=!(D+F*2 + 2)&#FFFF
	; 1030 P." BY ";GOS.y;P."  PAGE   /  "
	; 1040 IF G>0 I=G;P."  ";GOS.z;P."="$E'
	; 1050 Z=Z+2
	; 1060 Y=-2;GOS.i;Y=0;P=1;R.


.LabelX

	;1000xP.$30'"                                "$30
	LDA #32
	LDY #64
.LabelX1
	STA ScreenStart,Y
	DEY
	BNE LabelX1

	LDA #<ScreenStart
	STA Screen
	LDA #>ScreenStart
	STA Screen + 1

	LDA PageState
	BNE LabelX2
	; F is zero
	;1010 IF F=0 P."ATOMMC";I=S;Z=!(C+S*2)&#FFFF
	LDA #<LabelXString1
	STA TmpPtr
	LDA #>LabelXString1
	STA TmpPtr + 1

	LDA SortType
	PHA
	LDA SortTablePtr
	STA Sort
	LDA SortTablePtr + 1
	STA Sort + 1

	BNE LabelX3

.LabelX2
	; F is not zero
	;1020 IF F>0 P."FILTER";I=F;Z=!(D+F*2 + 2)&#FFFF
	LDA #<LabelXString2
	STA TmpPtr
	LDA #>LabelXString2
	STA TmpPtr + 1
	LDA PageState
	PHA
	ASL A
	ADC #2
	ADC MenuTablePtr
	STA Sort
	LDA MenuTablePtr + 1
	ADC #0
	STA Sort + 1

	LDX #Sort
	JSR Dereference

.LabelX3

	;1030 P." BY ";GOS.y;P."  PAGE   /  "
	JSR ScreenString
	PLA
	JSR LabelY
	LDA #<LabelXString3
	STA TmpPtr
	LDA #>LabelXString3
	STA TmpPtr + 1
	JSR ScreenString

	;1040 IF G>0 I=G;P."  ";GOS.z;P."="$(E+4)'
	LDA FilterType
	BEQ LabelX4
	LDA #' '
	JSR WriteToScreen
	JSR WriteToScreen
	LDA FilterType
	JSR LabelZ
	LDA #'='
	JSR WriteToScreen
	LDA FilterString
	STA TmpPtr
	LDA FilterString + 1
	STA TmpPtr + 1
	JSR ScreenString

.LabelX4
	;1050 Z=Z+2
	CLC
	LDA Sort
	ADC #2
	STA Sort
	BCC LabelX5
	INC Sort + 1

.LabelX5
	;1060 Y=-2;GOS.i;Y=0;P=1;R.
	LDA #$fe
	STA Item
	JSR LabelI
	LDY #$00
	STY Item
	INY
	STY Page
	RTS

.LabelXString1
	EQUS "ATOMMC BY ", 0

.LabelXString2
	EQUS "FILTER BY ", 0

.LabelXString3
	EQUS "  PAGE   /  ", 0

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; Subroutine to print the filter name padded with spaces to 10 chars
	; I is passed in as the accumulator
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.LabelY

	;1200yGOS.z
	PHA
	JSR LabelZ
	PLA

	;1220 IF I=1 P." "
	;1230 IF I=2 P."     "
	;1240 R.
	TAY
	LDA LabelYNumSpaces,Y
	TAY
	LDA #' '
.LabelYLoop
	DEY
	BMI LabelYExit
	JSR WriteToScreen
	BNE LabelYLoop

.LabelYExit
	RTS

.LabelYNumSpaces
	EQUB 0, 1, 5, 0

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; Subroutine to print the filter name not padded at all
	; I is passed in as the accumulator
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


.LabelZ

	;1500zIF I=0 P."TITLE     "
	;1510 IF I=1 P."PUBLISHER"
	;1520 IF I=2 P."GENRE"
	;1530 IF I=3 P."COLLECTION"
	;1540 R.

	CLC
	ASL A
	ADC #<LabelZJumpTable
	STA TmpPtr
	LDA #0
	ADC #>LabelZJumpTable
	STA TmpPtr + 1
	LDX #TmpPtr
	JSR Dereference
	JMP ScreenString

.LabelZJumpTable
	EQUW LabelZ0
	EQUW LabelZ1
	EQUW LabelZ2
	EQUW LabelZ3

.LabelZ0
	EQUS "TITLE     ", 0

.LabelZ1
	EQUS "PUBLISHER", 0

.LabelZ2
	EQUS "GENRE", 0

.LabelZ3
	EQUS "COLLECTION", 0


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Machine Code Subroutines
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.TestRowActive
	ASL A
	ASL A
	ASL A
	ASL A
	ASL A
	PHP
	ADC #<(ScreenStart + CharsPerLine * 2)
	STA TmpPtr
	LDA #>(ScreenStart + CharsPerLine * 2)
	ADC #0
	PLP
	ADC #0
	STA TmpPtr + 1
	LDX #0
	LDA (TmpPtr,X)
	CMP #' '
	RTS


.Clear
	LDA PlotDriverLS,Y
	STA $3FE
	LDA PlotDriverMS,Y
	STA $3FF
	LDA GraphicsCtrl,Y
	PHA
	LDA GraphicsLastPage,Y
	TAX
	LDA #>ScreenStart
	STA TmpPtr + 1
	LDA #0
	STA TmpPtr
	CPY #0
	BNE NotClear0
	ORA #$20
.NotClear0
	LDY #0
.ClearLoop
	STA (TmpPtr),Y
	INY
	BNE ClearLoop
	INC TmpPtr + 1
	CPX TmpPtr + 1
	BNE ClearLoop
	PLA
	STA $B000
	RTS

.GraphicsLastPage
	EQUB $82, $84, $86, $8c, $98

.OscliString
	PLA
	STA TmpPtr
	PLA
	STA TmpPtr + 1
	LDX #0
	LDY #0
.OscliString1
	INC	TmpPtr
	BNE OscliString2
	INC TmpPtr + 1
.OscliString2
	LDA (TmpPtr),Y
	STA OscliBuffer,X
	INX
	CMP #Return
	BNE OscliString1
	JSR Oscli
	INC	TmpPtr
	BNE OscliString3
	INC TmpPtr + 1
.OscliString3
	JMP (TmpPtr)

.ScreenString
	LDY #0
.ScreenString1
	LDA (TmpPtr),Y
	BEQ ScreenString2
	JSR WriteToScreen
	INY
	BNE ScreenString1
.ScreenString2
	RTS


	; Dereferences the pointer at zero page location X,X+1
.Dereference
	LDA 0,X
	STA DerefTmp
	LDA 1,X
	STA DerefTmp + 1
	LDY #0
	LDA (DerefTmp),Y
	STA 0,X
	INY
	LDA (DerefTmp),Y
	STA 1,X
	RTS

.HandleAutoRepeat
	LDA AutoRepeat
	STA TmpPtr
	LDA AutoRepeat + 1
	STA TmpPtr + 1
.HandleAutoRepeatLoop
	JSR Inkey
	CPY #255
	BNE HandleAutoRepeatPressed
	BIT $b001
	BPL HandleAutoRepeatPressed
	BVC HandleAutoRepeatPressed
	BIT $b002
	BVS HandleAutoRepeatKeyReleased
.HandleAutoRepeatPressed
	INC TmpPtr
	BNE HandleAutoRepeatLoop
	INC TmpPtr + 1
	BNE HandleAutoRepeatLoop
	; Key was not released
	; Update the auto repeat timer to the repeat value
	LDA #<AutoRepeat2
	STA AutoRepeat
	LDA #>AutoRepeat2
	STA AutoRepeat + 1
	RTS
.HandleAutoRepeatKeyReleased
	; Key was released
	; Update the auto repeat timer to the delay value
	LDA #<AutoRepeat1
	STA AutoRepeat
	LDA #>AutoRepeat1
	STA AutoRepeat + 1
	RTS

.LoadSortTable
	; 60 *LOAD MNU/SORT
	LDA SortType
	ORA #'0'
	STA SortDatNum
	JSR OscliString

	EQUS "LOAD SORT"
.SortDatNum
	EQUS " ", Return

.LoadSortTable1
	; 70 C=!#CD&#FFFF
	LDA ExecAddr
	STA SortTablePtr
	LDA ExecAddr + 1
	STA SortTablePtr + 1
	RTS


include "renderer_body.asm"

IF (econet = 1)
.WritePath
	SEC
	ROR SuppressFlag
	LDA BinBuffer + 1
	JSR WriteHex1
	LDA #DirSep
	STA OscliBuffer, X
	INX
	LDA BinBuffer
	PHA
	LSR A
	LSR A
	LSR A
	LSR A
	JSR WriteHex1
	LDA #DirSep
	STA OscliBuffer, X
	INX
	PLA
	JMP WriteHex1
ENDIF

.ENDOF
