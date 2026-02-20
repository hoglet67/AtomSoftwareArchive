	Base =? $2800

include "sysvars.asm"

include "chaptervars.asm"

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

.Menu

	;; vvvvvvvv IMPORTANT: This code gets clobbered by the row return buffer

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

	;; ^^^^^^^^ IMPORTANT code gets clobbered by the row return buffer

	; // Initialize the variables
	; 120 L=13;S=0;F=0;A=1;G=0;R=#2880;Q=#8F
	LDY #0
	STY SortType    ; S=0
	STY PageState   ; F=0
	INY
	STY Annotation  ; A=1

	; Load the default sort table (sort by title)
	JSR LoadSortTable

	; Initialize the search buffer to empty
	LDY #0
	STY SearchBuffer

	; Clear all filters
	JSR ClearFilterY	; Y=0 clears all filters

.LabelA

	;1060 Y=-2;GOS.i;Y=0;P=1;R.
	LDY #$00
	STY Item
	INY
	STY Page

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

.LabelA1
	; Calculate LinesPerPage and StartLine from FilterType
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
	JSR TestRowXActive
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
	; // 0 (16) = title; 1..N = filter
	CPY #16
	BCC TestForPrevSort
	CPY #16+NumFacets+1
	BCS TestForPrevSort
	TYA
	SBC #15
	; At the point A=0, or 1..N

	BNE ChangeFilter
	LDY PageState
	JSR ClearFilterY	; Y=0 clears all filters
	JMP LabelA

.ChangeFilter
	; Filter 1..8
	STA PageState
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
{
	; Test if we are already in Page State 0 (to avoid flicki
	LDA PageState
	BNE change
	JMP LabelB
.change
	LDA #0
	STA PageState
	JMP LabelA
}
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
	TAX
	JSR TestRowXActive
	BEQ JumpToLabelC
	STX Item

.LabelF
	LDY PageState
	BEQ BootProgram

	; Add the filter
	LDX Item
	LDA RowReturnLSB, X
	JSR AddFilterY		; Y = FilterType, A = FilterValue

	JMP PageStateZero

.BootProgram

	JSR GetItemAddress

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
	LDY Item		; Item starts at 0
	LDA RowReturnLSB, Y	; RowReturnBuffer stores the item index
	ASL A
	STA Title
	LDA RowReturnMSB, Y
	ROL A
	STA Title + 1		; Title now (item << 1)

	CLC			; Now indirect through the sort table
	LDA Title
	ADC Sort
	STA Title
	LDA Title + 1
	ADC Sort + 1
	STA Title + 1

	LDX #Title
	JMP Dereference
}
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; Subroutine to show the help
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

IF (info_option = 1)

.LabelInfo
{
	JSR OscliString
	EQUS "LOAD INFO", Return

	; Metata starts on line 4
	LDA #<(ScreenStart + 4 * CharsPerLine)
	STA Screen
	LDA #>(ScreenStart + 4 * CharsPerLine)
	STA Screen + 1

	LDX #1
.loop1
	JSR WriteFacetToScreen
	INX
	CPX #CollectionsFilterNum
	BNE loop1

.loop2
	LDY #CollectionsByteOffset
	LDA (Title), Y
	BPL PrintTitle
	JSR WriteFacetToScreen
	INC Title
	BNE loop2
	INC Title + 1
	BNE loop2

; Finally go back and print the title (centred)
.PrintTitle
	LDX #&20
	LDY #CollectionsByteOffset
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

	LDY #CollectionsByteOffset
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
	LDY #&0F
	LDA #&FF
.LabelJ4
	STA RowReturnMSB, Y
	DEY
	BPL LabelJ4
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
	LDA FilterType
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Machine Code Subroutines
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.TestRowXActive
{
	LDA RowReturnMSB, X
	CMP #&FF
	RTS
}

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

.ClearFilterY
{
	CPY #0
	BNE clear_y
	LDY #CollectionsFilterNum
.loop
	JSR clear_y
	DEY
	BNE loop
	RTS
.clear_y
	LDA FilterTypeMask, Y
	EOR #&FF
	AND FilterType
	STA FilterType
	LDX FacetByteOffsetTable, Y
	LDA FacetMaskTable, Y
	EOR #&FF
	AND FacetMasks, X
	STA FacetMasks, X
	; Note, the FacetValue is irrelevant when the mask is zero
	RTS
}

; Y = Filter Type
; A = Filter Value
.AddFilterY
{
	; Shift the value to the right bit position
	LDX FacetBitOffsetTable, Y
.shift_loop
	CPX #7
	BEQ shift_done
	ASL A
	INX
	BCC shift_loop  ; should be branch always
.shift_done
	PHA		; save the shifted valte

	; make X = byte offset into FacetMasks/Values for the required filter
	LDX FacetByteOffsetTable, Y

	; Update the FacetValues table with the (shifted) value
	LDA FacetMaskTable, Y
	EOR #&FF
	AND FacetValues, X
	STA FacetValues, X
	PLA
	ORA FacetValues, X
	STA FacetValues, X

	; Update the FacetMasks table with the mask
	LDA FacetMaskTable, Y
	ORA FacetMasks, X
	STA FacetMasks, X

	; Maintain the bit-per-filter FilterType map for expendiency
	LDA FilterTypeMask, Y
	ORA FilterType
	STA FilterType
	RTS
}

.FilterTypeMask
	EQUB &01, &02, &04, &08
	EQUB &10, &20, &40, &80

.ListFilters
{
	LDA #<FacetValues
	STA Title
	LDA #>FacetValues
	STA Title + 1
	LDX #1
.loop
	LDY FacetByteOffsetTable, X
	LDA FacetMaskTable, X
	AND FacetMasks, Y
	BEQ next
	JSR WriteFacetToScreen	; preserves X
.next
	INX
	CPX #CollectionsFilterNum + 1
	BNE loop
	RTS
}

; X = facet number
; Facet Value read from (Title)
.WriteFacetToScreen
{
 	JSR GetAnnotationTable	; Preserves X

	LDY PadTable, X
	JSR YSpaces		; preserves X

	JSR ScreenStringX	; preserves X

	LDA #':'
	JSR WriteToScreen	; preserves A, X, Y
	LDA #' '
	JSR WriteToScreen	; preserves A, X, Y

	TXA
	TAY
	JSR ExtractTableValue   ; Preserves X, result in A

	JSR GetAnnotationString ; Preserves X, result in TmpPtr

	JSR ScreenString
	;; Fall through to PadToEOL
}

.PadToEOL
{
.loop
	LDA Screen
	AND #&1F
	BEQ done
	LDA #' '
	JSR WriteToScreen
	BNE loop
.done
	RTS
}

.YSpaces
{
	LDA #' '
.loop
	DEY
	BMI done
	JSR WriteToScreen	; preserves A, X, Y
	BNE loop
.done
	RTS
}

; Filter  Start  Lines
; Count	  Line	 Per Page
; 0	  2	 13
; 1	  2	 13
; 2	  3	 12
; 3	  4	 11
; ...

.CalculateTextWindow
{
	LDA FilterType
	LDX #$FF
.loop1
	INX
.loop2
	ASL A
	BCS loop1
   	BNE loop2
	TXA
	BNE notzero
	SEC
.notzero
	ADC #1
	STA StartLine
	LDA #16
	SBC StartLine		; C=1
	STA LinesPerPage
	RTS
}

.ScreenLineY
{
	LDA #<(ScreenStart)
	STA Screen
	LDA #>(ScreenStart)
	STA Screen+1
	TYA
	ASL A
	ASL A
	ASL A
	ASL A
	ASL A
	BCC nocarry
	INC Screen+1
.nocarry
	CLC
	ADC Screen
	STA Screen
	RTS
}

.ScreenStringX
{
	LDA StringTableLSB, X
	STA TmpPtr
	LDA StringTableMSB, X
	STA TmpPtr + 1
	; fall through to
}

.ScreenString
{
	LDY #0
.loop
	LDA (TmpPtr),Y
	BMI done
	BEQ done
	JSR WriteToScreen
	INY
	BNE loop
.done
	RTS
}

.StringTableLSB
	EQUB <String0
	EQUB <String1
	EQUB <String2
	EQUB <String3
	EQUB <String4
	EQUB <String5
	EQUB <String6
	EQUB <String7
	EQUB <String8
	EQUB <String9
	EQUB <String10
	EQUB <String11

.StringTableMSB
	EQUB >String0
	EQUB >String1
	EQUB >String2
	EQUB >String3
	EQUB >String4
	EQUB >String5
	EQUB >String6
	EQUB >String7
	EQUB >String8
	EQUB >String9
	EQUB >String10
	EQUB >String11

.String0
	EQUS "TITLE", 0

.String1
	EQUS "PUBLISHER", 0

.String2
	EQUS "GENRE", 0

.String3
	EQUS "CHAPTER", 0

.String4
	EQUS "RAM NEEDED", 0

.String5
	EQUS "ROM NEEDED", 0

.String6
	EQUS "UPDATED", 0

.String7
	EQUS "JOYSTICK", 0

.String8
	EQUS "COLLECTION", 0

.String9
	EQUS "FILTER BY ", 0

.String10
	EQUS "SORTED BY ", 0

.String11
	EQUS "  PAGE   /  ", 0

; Padding for the first 9 strings

.PadTable
	EQUB 5, 1, 5, 3, 0, 0, 3, 2, 0

.FacetMasks
FOR i, 0, CollectionsByteOffset - 1, 1
	EQUB &00
NEXT
.CollectionsFacetMask
	EQUB &00

.FacetValues
FOR i, 0, CollectionsByteOffset - 1, 1
	EQUB &00
NEXT
.CollectionsFacetValue
	EQUB &00


; Display Mode controls behaviour
; Bit 7 - 1=disable rendering (i.e. count only)
; Bit 6 - 1=disable search/filtering
; Bit 5 - 1=highlight search matches

.WritePage
	LDA SearchBuffer
	STA SearchFirst

	LDA Sort
	STA CurrentSort
	LDA Sort + 1
	STA CurrentSort + 1

	BIT DisplayMode
	BPL SkipClearCounts
	JSR ClearAnnotationCounts

.SkipClearCounts
	LDX Annotation
	JSR GetAnnotationTable

	LDY StartLine
	JSR ScreenLineY

	LDX #0
	STX RowCount
	STX TotalItems
	STX TotalItems + 1

	DEX
	STX CurrentItem
	STX CurrentItem + 1

	; Default to assuming we are on a facet page
	LDA #FacetTitleOffset
	STA TitleNameOffset

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Start of loop that needs to be efficient
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.NextRow

	INC CurrentItem
	BNE GetTitle
	INC CurrentItem + 1

.GetTitle
	LDY #0

	; Follow the sort pointer to the title record, and increment the sort pointer
	LDA (CurrentSort),Y
	STA Title
	INY
	LDA (CurrentSort),Y
	STA Title + 1

	; Test if we have run off the end of the list
	BNE NotEndOfList
	JMP WritePageEndOfList
.NotEndOfList

	; Increment CurrentSort to point to the next title
	CLC
	LDA CurrentSort
	ADC #$02
	STA CurrentSort
	BCC IncSort
	INC CurrentSort + 1
.IncSort
	; Test if we are rendering one of the filter pages
	BIT DisplayMode
	BVC FindTitle

	; Yes, so the match now becomes a non-zero facet count
	LDY #FacetWorkingOffset
	LDA (Title), Y
	AND #&7F
	BNE MatchingRow
	INY
	LDA (Title), Y
	BNE MatchingRow

	; The facet count is zero, so move to the next row
	BEQ NextRow ; Branch always

.FindTitle
	; Find the offset to the title, by skipping over all the collections
	LDY #CollectionsByteOffset - 1
.FindTitleLoop
	INY
	LDA (Title),Y
	BMI FindTitleLoop
	STY TitleNameOffset

{
.SearchCompare
	LDA SearchFirst
	BEQ SearchMatch
	DEY
.SearchCompare1
	INY
	LDA (Title),Y
	BMI NextRow
.SearchCompare2
	CMP SearchFirst
	BNE SearchCompare1
	STY TmpY
	LDX #0
.SearchCompare3
	INX
	INY
	LDA SearchBuffer,X
	BEQ SearchMatch
	CMP (Title),Y
	BEQ SearchCompare3
	LDY TmpY
	BNE SearchCompare1
.SearchMatch
}

; Attempt to match against the currently compiled filter set
;
; If the filter includes a collections, there are is a list to try to
; match against This list is terminated by a non-negative value (the
; first char of the title name)

{
.FilterCompare
	LDA FilterType
	BEQ FilterMatch
	LDY #0
.FilterCompareLoop
	;; TODO could code this differently and optimize Mask=0
	LDA (Title), Y
	EOR FacetValues, Y
	AND FacetMasks, Y
	BNE NextRow
	INY
	CPY #CollectionsByteOffset
	BNE FilterCompareLoop

	LDA CollectionsFacetMask
	BEQ FilterMatch		; If No Collections Filter we have a match
.CatFilterLoop
	LDA (Title), Y
	BPL NextRow
	EOR CollectionsFacetValue
	AND #&7F		; TODO: Fix hard-coded mask
	BEQ FilterMatch
	INY
	BNE CatFilterLoop	; Branch always
.FilterMatch
}

.MatchingRow
	BIT DisplayMode
	BPL MatchingRow1
	JSR AccumulateAnnotationCounts
	JMP NextRow

.MatchingRow1
	INC TotalItems
	BNE MatchingRow2
	INC TotalItems + 1

	;; Have we reached the required start row yet?
.MatchingRow2
	SEC
	LDA TotalItems
	SBC StartRow
	LDA TotalItems + 1
	SBC StartRow+1
	BCS FoundRow
	JMP NextRow

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; End of loop that needs to be *very efficient*
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; Found a row that matches all filter and search

.FoundRow
	; Have we displayed the requested number of rows
	LDA RowCount
	CMP LinesPerPage
	BNE FoundRow1
	JMP NextRow

.FoundRow1
	; Store current item so that the basic program knows what's on each line
	LDY RowCount
	LDA CurrentItem
	STA RowReturnLSB, Y
	LDA CurrentItem + 1
	STA RowReturnMSB, Y

	; Increment the count of the number of rows displayed
	INC RowCount

	; Write the line at (Title) to the screen
	JSR WriteLine

	JMP NextRow

.WritePageEndOfList
	BIT DisplayMode
	BMI WritePageExit

	; We have hit the end of the sort list
	LDA RowCount
	CMP LinesPerPage
	BEQ WritePageExit
	LDX #CharsPerLine
.WritePageEndOfList1
	LDA #' '
	JSR WriteToScreen
	DEX
	BNE WritePageEndOfList1
	INC RowCount
	BNE WritePageEndOfList

.WritePageExit
	RTS

.WriteLine

	; Keep track of how many chars we have available

	LDX #CharsPerLine - 3
	; Prepare the Annotation first (so we know how long it is...)

	BIT DisplayMode
	BVC NormalAnnotation

	LDY #FacetWorkingOffset
	LDA (Title),Y
	AND #&7F
	STA BinBuffer + 1	; MSB first (i.e. count is stored big endian)
	INY
	LDA (Title),Y
	STA BinBuffer		; LSB last
	JSR WriteCount

	LDA #<CountString
	STA TmpPtr
	LDA #>CountString
	STA TmpPtr + 1

	JMP LengthOfAnnotation

.NormalAnnotation
	LDY Annotation
	JSR ExtractTableValue

	BPL NotNullCollection

	; CollectionIDs always have bit 7 set
	; If bit 7 is clear, there is no collection
	LDA #<(NullCollectionMessage)
	STA TmpPtr
	LDA #>(NullCollectionMessage)
	STA TmpPtr + 1
	BNE LengthOfAnnotation

.NullCollectionMessage
	; Currently just blank, a string like "NO COLLECTION" could be put here
	EQUB &ff

.NotNullCollection
	; Currently the MSB of the annotation is lost, which limits secondary tables to 7 bit values
	JSR GetAnnotationString

.LengthOfAnnotation
	LDY #0
.LengthOfAnnotationLoop
	LDA (TmpPtr),Y
	BMI WriteLetter
	INY
	DEX
	BNE LengthOfAnnotationLoop

.WriteLetter
	CLC
	LDA #64
	ADC RowCount
	JSR WriteToScreen
	LDA #'.'
	JSR WriteToScreen

.WriteTitle
	LDA SearchFirst
	BEQ WriteTitle1
	LDA DisplayMode
	AND #DMHighlightMatches
	BEQ WriteTitle1

	; There is an active search filter, so try to highlight
	JSR WriteTitleHighlight
	JMP WriteSeperator

.WriteTitle1
	; There is no active search filter, so don't try to highlight
	JSR WriteTitleNoHighlight

.WriteSeperator
	LDA #' '

.WriteSeperatorLoop
	JSR WriteToScreen
	DEX
	BPL WriteSeperatorLoop

	JMP ScreenString

.WriteTitleNoHighlight
	LDY TitleNameOffset
.WriteTitleNoHighlight1
	LDA (Title),Y
	BMI WriteTitleNoHighlight2
	JSR WriteToScreen
	INY
	DEX
	BNE WriteTitleNoHighlight1
.WriteTitleNoHighlight2
	RTS

.WriteTitleHighlight
	STX TmpX
	LDY TitleNameOffset
.WriteTitleHighlight1
	LDA (Title),Y
	BMI WriteTitleHighlight3
	CMP SearchFirst
	BEQ PossibleMatch
.WriteTitleHighlight2
	JSR WriteToScreen
	INY
	DEC TmpX
	BNE WriteTitleHighlight1
.WriteTitleHighlight3
	LDX TmpX
	RTS


.PossibleMatch
	PHA
	TYA
	PHA
	LDX #0
.PossibleMatchTestNext
	INX
	INY
	LDA SearchBuffer,X
	BEQ Match
	LDA (Title),Y
	BMI NoMatch
	CMP SearchBuffer,X
	BEQ PossibleMatchTestNext

.NoMatch
	PLA
	TAY
	PLA
	JMP WriteTitleHighlight2

.Match
	PLA
	TAY
	PLA
.Match1
	LDA (Title),Y
	ORA #$80
	JSR WriteToScreen
	INY
	DEC TmpX
	BEQ WriteTitleHighlight3
	DEX
	BEQ WriteTitleHighlight1
	BNE Match1

.Inkey
{
	JSR $FE71
	BCC done
	LDY #$ff
.done
	RTS
}

.FacetByteOffsetTable
	EQUB PubByteOffset
	EQUB PubByteOffset
	EQUB GenreByteOffset
	EQUB ChunkByteOffset
	EQUB RamByteOffset
	EQUB RomByteOffset
	EQUB VersionByteOffset
	EQUB JoystickByteOffset
	EQUB CollectionsByteOffset

.FacetMaskTable
	EQUB PubMask
	EQUB PubMask
	EQUB GenreMask
	EQUB ChunkMask
	EQUB RamMask
	EQUB RomMask
	EQUB VersionMask
	EQUB JoystickMask
	EQUB CollectionsMask

.FacetXorTable
	EQUB PubXor
	EQUB PubXor
	EQUB GenreXor
	EQUB ChunkXor
	EQUB RamXor
	EQUB RomXor
	EQUB VersionXor
	EQUB JoystickXor
	EQUB CollectionsXor

;; This is a table of branch offsets used in some self modifyinf code
;; to avoid the cost of a loop:
;;     vvvvvv is modified based on the table value
;; BNE offset
;; LSR A        ; offset 0 shifts 7 bits
;; LSR A	; offset 1 shifts 6 bits
;; LSR A	; offset 2 shifts 5 bits
;; LSR A	; offset 3 shifts 4 bits
;; LSR A	; offset 4 shifts 3 bits
;; LSR A	; offset 5 shifts 2 bits
;; LSR A	; offset 6 shifts 1 bits
;; RTS 		; offset 7 shifts 0 bits

.FacetBitOffsetTable
	EQUB 7 - PubBitOffset
	EQUB 7 - PubBitOffset
	EQUB 7 - GenreBitOffset
	EQUB 7 - ChunkBitOffset
	EQUB 7 - RamBitOffset
	EQUB 7 - RomBitOffset
	EQUB 7 - VersionBitOffset
	EQUB 7 - JoystickBitOffset
	EQUB 7 - CollectionsBitOffset

;; Extract Filter/Annotation ID from title table and nomalize

;; TODO: the self modification could be done less often
;; i.e. when ever Annotation is updated

.ExtractTableValue
{
	LDA FacetBitOffsetTable, Y
	STA shift + 1
	LDA FacetMaskTable, Y
	STA mask + 1
	LDA FacetXorTable, Y
	STA xor + 1
	LDA FacetByteOffsetTable, Y
	TAY
	LDA (Title), Y
.mask
	AND #&00
.xor
	EOR #&00
.shift
	BNE P%+2
	LSR A
	LSR A
	LSR A
	LSR A
	LSR A
	LSR A
	LSR A
	RTS
}

.WriteToScreen
	PHA
	STY TmpY
	LDY #0

	AND #$BF
	STA (Screen),Y
	INC Screen
	BNE WriteToScreen1
	INC Screen + 1

	; Ensure we don't overwrite the tables!
	LDA Screen + 1
	AND #$81
	STA Screen + 1

.WriteToScreen1
	LDY TmpY
	PLA
	RTS
	; Converts the 16-bit value in $BinBuffer to "(" <Decimal String> ")" <CR> at Buffer

.WriteCount:
	TXA
	PHA
	LDA #'('
	STA CountString
	LDX #1
	JSR WriteDecimal
	CPX #1
	BNE NotZero
	LDA #'0'
	STA CountString,X
	INX
.NotZero
	LDA #')'
	STA CountString,X
	INX
	LDA #&80
	STA CountString,X
	PLA
	TAX
	RTS


.BinToDecimal8
	LDA #0
	STA BcdBuffer
	STA BcdBuffer+1
	SED
	LDY #8
.BinToDecimal8Loop:
	; Handle the binary bits one at a time
	ASL BinBuffer
	; Add into the BCD accumulator
	LDA BcdBuffer
	ADC BcdBuffer
	STA BcdBuffer
	LDA BcdBuffer+1
	ADC BcdBuffer+1
	STA BcdBuffer+1
	DEY
	BNE BinToDecimal8Loop
	CLD
	LDA BcdBuffer
	RTS

.Search

	LDA DisplayMode
	ORA #DMHighlightMatches
	STA DisplayMode

	; Update current results set and number of pages
	JSR WritePage
	JSR UpdateTotalPages

	; Returns with Y being the end of the search buffer
	LDA #$A0
	JSR ShowCurrentSearch

	; Read a character
	JSR Osrdch

	; Return cancels the search
	CMP #&1B
	BNE NotEscape
	LDY #0
	STY SearchBuffer
	JMP SearchExit

.NotEscape
	; Return returns with the seach in place
	CMP #Return
	BEQ SearchExit

	CMP #$7F
	BNE Search1

	; Delete at the beginning of the line also terminates the search
	CPY #0
	BEQ SearchExit

	DEY
	LDA #0

.Search1

	STA SearchBuffer,Y
	INY
	LDA #0
	STA SearchBuffer,Y

	JMP Search

.SearchExit
	CPY #0
	BNE ShowCurrentSearchNoCursor

.ClearSearchLine
	LDA #' '
	LDY #CharsPerLine - 1
.SearchExit2
	STA ScreenStart + $1E0,Y
	DEY
	BPL SearchExit2
	RTS

.ShowCurrentSearchNoCursor
	LDA #$20

.ShowCurrentSearch
	; Save the cursor
	PHA

	LDA #<(ScreenStart + $1E0)
	STA Screen
	LDA #>(ScreenStart + $1E0)
	STA Screen + 1

	LDY #0
.ShowCurrentSearch1
	LDA SearchString,Y
	BEQ ShowCurrentSearch2
	JSR WriteToScreen
	INY
	BNE ShowCurrentSearch1

.ShowCurrentSearch2
	LDY #0
.ShowCurrentSearch3
	LDA SearchBuffer,Y
	CMP #0
	BEQ ShowCurrentSearch4
	JSR WriteToScreen
	INY
	BNE ShowCurrentSearch3

.ShowCurrentSearch4
	STY TmpY
	PLA
	LDY #0
	STA (Screen),Y
	INY
	LDA #$20
	STA (Screen),Y
	LDY TmpY
	RTS

.SearchString
	EQUS "  SEARCH="
	EQUB 0

.UpdateTotalPages


	; Write Page to the CountString
	LDA Page
	STA BinBuffer
	LDA #0
	STA BinBuffer+1

	JSR BinToDecimal8

	; X is used as the index into CountString
	LDX #0

	; Make sure that we don't suppress zeros
	LDY #$FF
	STY SuppressFlag

	JSR WriteHex

	; Write the page separator into CountString
	LDA #'/'
	LDX #2
	STA CountString, X

	JSR CalculateNumPages

	; Write the number of pages into to the CountString
	LDX #3
	JSR WriteHex

	LDX #0
.UpdateTotalPages1
	LDA CountString,X
	AND #$3F
	ORA #$80
	STA ScreenStart + CharsPerLine - 5,X
	INX
	CPX #5
	BNE UpdateTotalPages1
	RTS

	; Reads the total number of filtered rows returned
	; Inefficiently divide number of rows by the rows per page
	; Returns the number of pages in BCD in A
	; Returns the number of pages in Binary in Y
.CalculateNumPages
{
	SEC
	LDA TotalItems
	SBC #1
	STA BinBuffer
	LDA TotalItems + 1
	SBC #0
	STA BinBuffer+1
	BCC return_one_page

	LDY #0
	TYA
.loop
	INY
	SED
	CLC
	ADC #1
	CLD
	PHA
	SEC
	LDA BinBuffer
	SBC LinesPerPage
	STA BinBuffer
	LDA BinBuffer+1
	SBC #0
	STA BinBuffer+1
	PLA
	BCS loop
	RTS

.return_one_page
	LDY #1
	TYA
	RTS
}

; Calculate a pointer to the requested annotation table, skipping the length field
; Get the address of the relevant secondary table for annotations
; - in normal mode (DisplayMode bit 7 = 0) this is used for rendering the annotation
; - in update counts mode (DisplayMode bit 7 = 1) this is where the current filter counts are maintained

; X=Annotation type
.GetAnnotationTable
{
	TXA
	ASL A
	TAY
	INY
	INY
	LDA (MenuTablePtr),Y
	STA AnnotationTable
	INY
	LDA (MenuTablePtr),Y
	STA AnnotationTable + 1
	RTS
}

; A=Annotation id value (7 bits)
.GetAnnotationRecord
{
	ASL A
	TAY
	LDA (AnnotationTable), Y
	STA AnnotationPtr
	INY
	LDA (AnnotationTable), Y
	STA AnnotationPtr + 1
	RTS
}

; A=Annotation id value (7 bits)
.GetAnnotationString
{
	JSR GetAnnotationRecord
	CLC
	LDA Annotation
	BEQ isShortPub
	LDA #FacetTitleOffset
.isShortPub
	ADC AnnotationPtr
	STA TmpPtr
	LDA #0
	ADC AnnotationPtr + 1
	STA TmpPtr + 1
	RTS
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Accumulate the annotation counts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.AccumulateAnnotationCounts
{
	LDY Annotation
	CPY #CollectionsFilterNum
	BEQ collection

	JSR ExtractTableValue

.update_count
	JSR GetAnnotationRecord
	LDY #FacetWorkingOffset + 1 ; count is stored at offset 3 (LSB) and 2 (MSB)
	SEC
.update_loop
	LDA (AnnotationPtr),Y
	ADC #0
	STA (AnnotationPtr),Y
	DEY
	BCS update_loop	; skip back in the rare case of carry
	RTS 		; (you only get this if you search for <space>)

.collection
	LDY #CollectionsByteOffset
.collection_loop
	LDA (Title),Y
	BPL done
	AND #&7F		; TODO: Fix hard-coded mask
	STY TmpY
	JSR update_count
	LDY TmpY
	INY
	BNE collection_loop
.done
	RTS
}

; Set the first two bytes of each annotation record to 0x80, 0x00
; We will use these to store counts of the number of search filtered items
.ClearAnnotationCounts
{
	LDX Annotation
	JSR GetAnnotationTable
.loop
	LDY #0
	LDA (AnnotationTable), Y
	STA Tmp
	INY
	LDA (AnnotationTable), Y
	STA Tmp + 1
	BEQ done
	LDY #FacetWorkingOffset
	LDA #&80
	STA (Tmp),Y
	INY
	LDA #&00
	STA (Tmp),Y
	CLC
	LDA AnnotationTable
	ADC #&02
	STA AnnotationTable
	BCC loop
	INC AnnotationTable + 1
	BNE loop
.done
	RTS
}

include "common.asm"

.ENDOF

SAVE STARTOFHEADER, ENDOF
