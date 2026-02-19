	Base =? $2800

include "sysvars.asm"

include "renderer_header.asm"

; info_option = atommc

info_option = 1

	KernelOsrdch = $fe94
	RDCVEC       = $20a

IF (econet = 1 OR gosdc = 1)
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
; F -> PageState       - page state variable (0=Normal title selection, F=1,2,3,4,5,6,7,8 showing the filter selection pages)
; G -> FilterType      - current filter (0=No filter; 1=Publisher, 2=Genre, 3=Chunk, 4=Ram, 5=Rom, 6=Version, 7=Joystick, 8=Collection)
; H -> FilterVal       - current filter value (as an integer)
; I -> TmpI            - A temporary variable
; K                    - The index number of the program about to be *RUN
; L -> LinesPerPage    - (CONSTANT) The number of lines per page
; M -> NumPages        - The current number of pages
; P -> Page            - The current page (1..M)
; Q -> n/a             - The constant #8f
; R -> RowReturnBuf    - (CONSTANT) The address of a buffer into which the machine code stores the rendered row addresses
; S -> SortType        - The current sort order (0=Title,1=Publisher,2=Genre,3=Collection)
; Y -> Item            - The currently highlighted row (0..L-1)
; Z -> Sort            - The currently base address of the current sort index or filter pointer table)

	org Base - 22

	guard Base + &B00

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

;; This needs 26 bytes; to save space we just allow it to overlap the
;; startup code, which is run just once.

.RowReturnBuf
;;	SKIP LinesPerPage * 2

.Menu

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
	INY
	STY Annotation  ; A=1
	JSR ClearFilters
	JSR LoadSortTable

	; // Initialize the search buffer to empty
	; 125 ?#120=13
	LDA #0
	STA SearchBuffer

.LabelA

	;1060 Y=-2;GOS.i;Y=0;P=1;R.
	LDY #$00
	STY Item
	INY
	STY Page

IF properAnnotationCounts
	; Update the annotation to point to this facet
	LDY PageState
	BEQ LabelA1
	LDA Annotation
	PHA
	STY Annotation
	; Make sure the title table is used, not the facet table
	LDA SortTablePtr
	STA Sort
	LDA SortTablePtr + 1
	STA Sort + 1
	; Recalculate Annotation counts the new filter screen
	LDA #DMUpdateCounts
	STA DisplayMode
	JSR WritePage
	; Restore the original annotation the user has chose (to see on the title page)
	PLA
	STA Annotation
ENDIF

.LabelA1
	; Calculate LinesPerPage and StartLine from FilterCount
	JSR CalculateTextWindow

	; Render the header, including the filter list
	JSR RenderHeader

	JSR ClearSearchLine

	LDA PageState		; Only show SEARCH= in title page state
	BNE LabelB
	LDA SearchBuffer	; Only show SEARCH= when there is an active search
	BEQ LabelB
	JSR ShowCurrentSearchNoCursor

.LabelB
	; // Refresh rows, page number and total number of pages
	; 200bGOS.j
	JSR LabelJ

	; 260 LINK B;M=(!R&#FFFF+L-1)/L
	LDA PageState
	BEQ LabelB1
	LDA #DMDisableSearchFilter
.LabelB1
	STA DisplayMode
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
	BPL LabelC2

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
	BMI ReleaseKey		; Branch always

.LabelC1
	; 320 IF P>1 P=P-1;GOS.i;Y=L-1;G.b
	LDA Page
	CMP #1
	BEQ LabelD
	DEC Page
	JSR LabelI
	LDX LinesPerPage
	DEX
	STX Item
	BNE LabelB		; Branch always

.LabelD
	; // Check for original Atom
	LDA $bd00
	CMP #$bf
	BNE HandleDownKeyOriginal

	; // Control Key is pressed emulator (scroll down)
	; 400dIF?#B001&64>0 G.e
	BIT $b001
	BVS CallInkey
	BVC LabelD2		; Branch always

.HandleDownKeyOriginal
	; // Shift Key is pressed Original Atom (scroll down)
	; 300cIF ?#B001&128>0 G.d
	BIT $b001
	BMI CallInkey

.LabelD2
	; 410 IF Y<>L-1 AND ?(#8060+Y*32)<>32 GOS.i;Y=Y+1;GOS.i;G.c
	LDX Item
	INX
	CPX LinesPerPage
	BEQ LabelD1
	TXA
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
	BEQ CallInkey
	INC Page

.SetItemToZero
	JSR LabelI
	LDA #0
	STA Item
	JMP LabelB		; Branch always

.CallInkey
	; Call InKey to scan the keyboard
	JSR Inkey

	CPY #$FF
	BEQ LabelC		; Branch of no key pressed

	CPY #&3B		; Escape
	BNE TestForFilter

	; Escape pressed, if on filter page, return to title page
	LDA PageState
	BNE PageStateZero

	; Really exit, changing back to the "root" directory
	JSR OscliString
IF (sddos2 = 1 OR sddos3 = 1)
	EQUS "DRIVE 0", Return
ELIF (econet = 1 OR gosdc = 1)
	EQUS "DIR $", Return
ELSE
	EQUS "CWD /", Return
ENDIF
	JSR OscliString
	EQUS "RUN MENU", Return
	; never returns

.TestForFilter
	; // 0 = clear; 1..N = filter
	CPY #16
	BCC TestForPrevSort
	CPY #16+NumFacets+1
	BCS TestForPrevSort
	TYA
	SBC #15
	; At the point A=0..5

	; Filter 0 = clear filters
	; 630 IF ?Q=21 F=0;G=0;A=A&127;G.a
	CMP #0
	BNE ChangeFilter
	JSR ClearFilters
	JMP PageStateZero

.ChangeFilter
	; Filter 1..8
	; // 1..8 key pressed
	; 640 IF ?Q>21 AND ?Q<25 F=?Q-21;G=0;A=A|128;G.a
	STA PageState
	LDA Annotation
	; Set bit 7 of the annotation to switch to "show counts" mode
	ORA #$80
	STA Annotation
	JMP LabelA

.TestForPrevSort
	LDX SortType
	CPY #1	; [
	BNE TestForNextSort
	DEX
	BPL ChangeSort
	LDX #NumFacets
	BNE ChangeSort

.TestForNextSort
	CPY #3	; ]
	BNE TestForPrevPage
	INX
	CPX #NumFacets+1
	BNE ChangeSort
	LDX #0

.ChangeSort
	STX SortType
	BNE ChangeAnnotation
	INX			; Title sort defaults to long publisher
.ChangeAnnotation
	STX Annotation

	; Page in the appropriate sort table
	JSR LoadSortTable

.PageStateZero
	LDA #0
	STA PageState
	LDA Annotation
	AND #$7f
	STA Annotation
	JMP LabelA

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
	BNE TestForPrevTag
	LDA NumPages
	CMP #1
	BEQ TestForPrevTag
	INC Page
	LDA NumPages
	CMP Page
	BCS NextPageNoWrap
	LDA #1
	STA Page
.NextPageNoWrap
	JMP SetItemToZero


.TestForPrevTag
	LDA PageState		; Tags not use in filter pages
	BNE TestForHelp

	; The followimg commands work only in thw  title page (PageState=0
	;     PrevTag (Z), Next Tag (X) and Info (@)
	LDX Annotation
	CPY #58			; Z
	BNE TestForNextTag
	DEX
	BPL ChangeTag
	LDX #NumFacets
	BNE ChangeTag

.TestForNextTag
	CPY #56			; X
	BNE TestForHelp
	INX
	CPX #NumFacets + 1
	BNE ChangeTag
	LDX #0
.ChangeTag
	STX Annotation
	JMP SetItemToZero

.TestForHelp
	; // ? key pressed (help)
	; 615 IF ?Q=31 GOS.h;G.a
	CPY #31
	BNE TestForSelect
	JSR LabelH
	JMP LabelA1

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
	CPY #33
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
	JSR GetItemAddress

	; // Handle selection of a filter item
	; 690 IF F>0 G=F;F=0;A=A&127;E=I+4;H=(P-1)*L+Y;G.a
	LDA PageState
	BEQ BootProgram

	CLC
	LDA Title
	ADC #FacetTitleOffset
	STA FilterString
	LDA Title + 1
	ADC #0
	STA FilterString + 1

	; Assume the filter item is an 8 bit value
	LDA Item
	LDY Page
.LabelF1
	DEY
	BEQ LabelF2
	CLC
	ADC LinesPerPage
	BCC LabelF1
.LabelF2
	LDY PageState
	JSR AddFilter	; Y = FilterType, A = FilterValue
	JMP PageStateZero

.BootProgram

IF (info_option = 1)
   	JSR LabelInfo
	CMP #&1B
	BNE BootContinue
	JSR ClearScreen
	JMP LabelA1
.BootContinue
	JSR GetItemAddress
ENDIF

	; // Handle *RUN of a title - K is the title index
	; 800 K=(!I)&#7FF
	LDX #Title
	JSR Dereference
	; For SDDOS we pack two games per disk
	LDA Title
	AND #$7
IF (sddos2 = 1)
	LSR A
ENDIF
	STA BinBuffer + 1
	LDA Title+1
IF (sddos2 = 1)
	ROR A
ENDIF
	STA BinBuffer
IF (sddos2 = 1)
	LDA #'0'
	ADC #0
	STA bootnum
ENDIF
	; 810 P=#100
	; 820 $P="RUN MNU/"
	; 830 P=P+LEN(P)
	; 840 IF K>99 P?0=48+(K/100)%10;P=P+1
	; 850 IF K>9 P?0=48+(K/10)%10;P=P+1
	; 860 ?P=48+K%10;P?1=13;P?2=13

	; CountString and OscliBuffer are the same ($100)

	; 870 P.$12;LINK #FFF7
	; 880 END
	JSR ClearScreen

IF (sddos2 = 1 )

	; SDDOS2 has a *RUNME bug, where only drive 0 is
	; searched for the file RUNME

	LDA #'0'
	JSR LoadDisk

	JSR OscliString
	EQUS "DRIVE 0", Return

	JSR OscliString
	EQUS "RUN BOOT"
.bootnum
	EQUS "0", Return

.LoadDisk
	STA RunCommand + 4

ELIF (sddos3 = 1)

	; SDDOS3 is less messy if we use three different drives
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

ELIF (gosdc = 1)

	JSR ChangeDirectory

	JSR OscliString
	EQUS "RUN BOOT", Return

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
IF (econet = 1 OR gosdc = 1)
	JSR WritePath
ELSE
	JSR WriteDecimal
ENDIF
IF (sddos3 = 1)
	LDY #0
.RunCommand3
	LDA DskSuffix, Y
	BEQ RunCommand4
	STA OscliBuffer, X
	INX
	INY
	BNE RunCommand3
.DskSuffix
	EQUS ".DSK", 0
.RunCommand4
ENDIF
	LDA #Return
	STA OscliBuffer, X
	INX
	STA OscliBuffer, X
	JMP Oscli

IF (sddos2 = 1 OR sddos3 = 1)

.RunCommand
	EQUS "DIN  ,",0

ELIF (econet = 1 OR gosdc = 1)

.RunCommand
	EQUS "DIR $.ASA.",0

ELSE

.RunCommand
	EQUS "RUN ", 0

ENDIF


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Translated Basic Subroutines
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.GetItemAddress
{
	LDA Item
	ASL A
	ADC #2	; Item starts at 0, row return buffer starts at 1
	TAY
	LDA #<(RowReturnBuf)
	STA Title
	LDA #>(RowReturnBuf)
	STA Title + 1
	LDA (Title),Y
	PHA
	INY
	LDA (Title),Y
	STA Title + 1
	PLA
	STA Title
	RTS
}
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; Subroutine to show the help
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

IF (info_option = 1)

.LabelInfo
{
	JSR OscliString
	EQUS "LOAD INFO", Return

	LDA #<(ScreenStart + 4 * CharsPerLine)
	STA Screen
	LDA #>(ScreenStart + 4 * CharsPerLine)
	STA Screen + 1

	LDA #CollectionsByteOffset
	STA TitleNameOffset

	LDX #&00
.loop1
	INX
	JSR GetAnnotationTable

.loop2
	; Indent to right-justify the facet names
	JSR LabelY1

	; Print the the facet name
	; On entry: A = facet number (1..8)
	; Preserves: nothing!
	TXA
	PHA
	JSR LabelZ
	LDA #':'
	JSR WriteToScreen
	LDA #' '
	JSR WriteToScreen
	PLA
	TAX

	CPX #CollectionsFilterNum
	BNE NotCollection

	; Setup a default value string of NONE for no collections
	LDA #<NoneString
	STA TmpPtr
	LDA #>NoneString
	STA TmpPtr + 1

	LDY TitleNameOffset
	LDA (Title), Y
	BPL DefaultValue
	AND #&7F
	BPL GetRecord	; branch always

.NotCollection
	; Extract the facet value from the title table
	; On entry: Y = facet number (1..8)
	; On exit:  A = facet value
	; Preseves X
	TAY
	JSR ExtractTableValue

.GetRecord
	; Get the address of the facet string
	; On entry: X = facet number (1..8), A = facet valye
	; On exit:  (AnnotationString) points to the start of the record
	; Preseves X
	JSR GetAnnotationString

	; Print the facet string
	; On Entry: (tmpPtr) points to the string
	; Preseves X
.DefaultValue
	JSR ScreenString

	; Pad to end of line
	JSR PadToEOL

	; Move to the next facet, but don't go beyond
	CPX #CollectionsFilterNum
	BCC loop1
	; Check for the loop terminating condition
	LDY TitleNameOffset
	LDA (Title), Y
	BPL PrintTitle
	INY
	STY TitleNameOffset
	LDA (Title), Y
	BMI loop2

; Finally go back and print the title (centred)
.PrintTitle
	LDX #&20
	LDY TitleNameOffset
.TitleLoop1
	LDA (Title),Y
	BMI TitleDone1
	INY
	DEX
	BNE TitleLoop1
.TitleDone1
	TXA
	LSR A
	ORA #<(ScreenStart + 2 * CharsPerLine)
	STA Screen
	LDA #>(ScreenStart + 2 * CharsPerLine)
	STA Screen + 1

	LDY TitleNameOffset
.TitleLoop2
	LDA (Title),Y
	BMI TitleDone
	JSR WriteToScreen
	INY
	BNE TitleLoop2

.TitleDone
	LDY #2
	JSR HighlightRowY
	JMP Osrdch

.NoneString
	EQUS "NONE", -1
}

ENDIF
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; Subroutine to show the help
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.LabelH

	;900h*LOAD HELP 8000

	JSR OscliString
	EQUS "LOAD HELP", Return

	;895 LINK#FFE3;P.$12;R.

	JSR Osrdch
.ClearScreen
	LDA #12
	JMP Oswrch

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; Subroutine to invert line 2+Y on the screen
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.LabelI
	;900i?Q=Y+2;LINK(B+6);R.
	LDA Item
	CLC
	ADC StartLine
	TAY
	JMP HighlightRowY

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
	ADC LinesPerPage
	STA StartRow
	BCC LabelJ2
	INC StartRow + 1
.LabelJ2
	INY
	BNE LabelJ1

.LabelJ3
	LDA #<RowReturnBuf
	STA RowRet
	LDA #>RowReturnBuf
	STA RowRet+1
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

.RenderHeader
{
	; Clear the top half of the screen
	LDY #0
	LDA #' '
.loop
	STA ScreenStart,Y
	INY
	BNE loop

	; Setup the screen pointer to top left
	LDA #<ScreenStart
	STA Screen
	LDA #>ScreenStart
	STA Screen + 1

	; Title page or Filter page?
	LDA PageState
	BEQ title_page

.filter_page
	; Filter page, print FILTER BY
	LDX #9
	JSR ScreenStringX

	; Set Sort to the start of the pointer list in the secondary table
	LDA PageState
	ASL A
	ADC #2
	ADC MenuTablePtr
	STA Sort
	LDA MenuTablePtr + 1
	ADC #0
	STA Sort + 1
	LDX #Sort
	JSR Dereference

	; Prepare for printing the filter facet name
	LDX PageState
	BNE facet	; branch always

.title_page
	; Title page, print SORTED BY
	LDX #10
	JSR ScreenStringX

	; Set Sort to the start of the pointer list in the sort table
	LDA SortTablePtr
	STA Sort
	LDA SortTablePtr + 1
	STA Sort + 1

	; Prepare for printing the sort facet name
	LDX SortType

.facet
	; Print the facet name
	JSR ScreenStringX

	; Pad with spaces
	LDY PadTable, X
	JSR YSpaces

	; Print PAGE  OF
	LDX #11
	JSR ScreenStringX

	; Test if there is an active filter
	LDA FilterCount
	BEQ done

	; Display the set of active filters
	JSR ListFilters

.done
	LDY #0
	;; Fall through to highlight the top trop
}

.HighlightRowY
{
	JSR ScreenLineY
	LDY #2
.loop1
	JSR WaitUntilVSync
	DEY
	BNE loop1

	LDY #$1F
.loop2
	LDA (Screen),Y
	EOR #$80
	STA (Screen),Y
	DEY
	BPL loop2
	RTS
}

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; Subroutine to print the filter name padded with spaces to 10 chars
	; I is passed in as the accumulator
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.LabelY

	;1200yGOS.z
	PHA
	JSR LabelZ
	PLA
	TAX

	;1220 IF I=1 P." "
	;1230 IF I=2 P."     "
	;1240 R.
.LabelY1
	LDY LabelYNumSpaces,X
	LDA #' '
.LabelYLoop
	DEY
	BMI LabelYExit
	JSR WriteToScreen
	BNE LabelYLoop

.LabelYExit
	RTS

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
	EQUW LabelZ4
	EQUW LabelZ5
	EQUW LabelZ6
	EQUW LabelZ7
	EQUW LabelZ8


.LabelYNumSpaces
	EQUB 5, 1, 5, 3, 0, 0, 3, 2, 0


.LabelZ0
	EQUS "TITLE", 0

.LabelZ1
	EQUS "PUBLISHER", 0

.LabelZ2
	EQUS "GENRE", 0

.LabelZ3
	EQUS "CHAPTER", 0

.LabelZ4
	EQUS "RAM NEEDED", 0

.LabelZ5
	EQUS "ROM NEEDED", 0

.LabelZ6
	EQUS "UPDATED", 0

.LabelZ7
	EQUS "JOYSTICK", 0

.LabelZ8
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


	; Dereferences the pointer at zero page location X,X+1
.Dereference
{
	LDA (0,X)
	PHA
	INC 0,X
	BNE skip
	INC 1,X
.skip
	LDA (0,X)
	STA 1,X
	PLA
	STA 0,X
	RTS
}

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

include "common.asm"


.WriteDecimal:
	JSR BinToDecimal16
	; Set the flag to support suppression of leading zeros
	STY SuppressFlag
	LDY #2
	; Output the BcdBuffer digits, MS first
.DecLoop
	LDA BcdBuffer,Y
	JSR WriteHex
	DEY
	BPL DecLoop
	RTS

.BinToDecimal16
	LDA #0
	STA BcdBuffer
	STA BcdBuffer+1
	STA BcdBuffer+2
	SED
	LDY #16
.BinToDecimal16Loop:
	; Handle the binary bits one at a time
	ASL BinBuffer
	ROL BinBuffer+1
	; Add into the BCD accumulator
	LDA BcdBuffer
	ADC BcdBuffer
	STA BcdBuffer
	LDA BcdBuffer+1
	ADC BcdBuffer+1
	STA BcdBuffer+1
	LDA BcdBuffer+2
	ADC BcdBuffer+2
	STA BcdBuffer+2
	DEY
	BNE BinToDecimal16Loop
	CLD
	RTS

.WriteHex
	PHA
	LSR A
	LSR A
	LSR A
	LSR A
	JSR WriteHex1
	PLA
.WriteHex1
	AND #$0f
	BNE WriteHex2
	; Suppress leading zero
	BIT SuppressFlag
	BPL WriteHex4
.WriteHex2
	; Make sure bit 7 of SuppressFlag is set, so we don't suppress further zeros
	SEC
	ROR	SuppressFlag
	CMP #$0a
	BCC WriteHex3
	ADC #$06
.WriteHex3
	ADC #$30
	STA CountString,X
	INX
.WriteHex4
	RTS

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

ELIF (gosdc = 1)
.WritePath
	SEC
	ROR SuppressFlag
	LDA #'E'
	STA OscliBuffer, X
	INX
	LDA BinBuffer + 1
	JSR WriteHex1
	LDA BinBuffer
	PHA
	LSR A
	LSR A
	LSR A
	LSR A
	JSR WriteHex1
	PLA
	JMP WriteHex1
ENDIF


.ENDOF

SAVE STARTOFHEADER, ENDOF
