
	WaitUntilVSync = $FE66
	OSRDCH = $FFE3
	
	SortTableBase = $3600
	TitleSortPtr = SortTableBase;
	PublisherSortPtr = SortTableBase + 2;
	GenreSortPtr = SortTableBase + 4;
	CollectionSortPtr = SortTableBase + 8;

	MenuTableBase = $8200	
	TitleTablePtr = MenuTableBase;	
		
	CountBuffer = $100;

	SearchBuffer = $140;

	CountOffset = 0
	PubIdOffset = 2
	TitleNameOffset = 4
	
	; This should point to the first row in the sort index
	Sort = $80

	; This should point to the index of the row to search for (starting at 0) 
    StartRow = $82 

    ; The Address to store the found rows, so that the basic program can access them
    RowRet = $84

	; The annotation to show: 0 = Short Publisher, 1 = Publisher, 2 = Genre, 3 = Collection, 255 = Count
    Annotation = $86

    ; The filter key: 1 = Genre, 2 = Publisher, 3 = Collection
    Filter = $87

	; The filter value
    FilterVal = $88

	; The value used to return InKey
	Key = $89

	; The row address to highlight
	Row = $89


	; These are working values
	Title = $90
	AnnotationPtr = $92
	AnnotationString = $94
	Screen = $96
	TmpY = $98    
	RowCount =$99
	
	; For the Decimal Output routines
	BinBuffer = $9A
	BcdBuffer = $9C
	SuppressFlag = $9E
	
	; Copies of some of the input params so they are not modified
	CurrentRow = $A0
	CurrentSort = $A2
	

	; Location that count annotation is written out to	
	CountString = $100
	
	; Miscellaneous constants
	Space = $20
	Return = $0d
	Dot = $2e
	ScreenStart = $8000
	CharsPerLine = 32
	StartLine = 2
	LinesPerPage = 13 

	Base = $3300

	org     Base - 22

.STARTOFHEADER

; 22 byte ATM header

	EQUS    "MENUMC"

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

	JMP WritePage
	JMP Inkey
	JMP HighlightRow
	JMP Search
	

.AnnotationIdMap
	EQUB 	2 ; Short Publisher
	EQUB 	2 ; Publisher
	EQUB 	1 ; Genre
	EQUB 	3 ; Collection

.AnnotationOffset
	EQUB 	0 ; Short Publisher
	EQUB 	4 ; Publisher
	EQUB 	4 ; Genre
	EQUB 	4 ; Collection

.WritePage

	LDA StartRow
	STA CurrentRow
	LDA StartRow + 1
	STA CurrentRow + 1

	LDA Sort
	STA CurrentSort
	LDA Sort + 1
	STA CurrentSort + 1


	; Calculate a pointer to the requested annotation table, skipping the length field
    LDA Annotation
    ASL A
    TAX
    CLC
	LDA MenuTableBase + 2,X
	ADC #2
	STA AnnotationPtr
	LDA MenuTableBase + 3,X
	ADC #0
	STA AnnotationPtr + 1
	
	LDA #<(ScreenStart + StartLine * CharsPerLine)
	STA Screen
	LDA #>(ScreenStart + StartLine * CharsPerLine)
	STA Screen + 1

	LDA #0
	STA RowCount
	
.WriteLines

	LDX #0

	; Follow the sort pointer to the title record, and increment the sort pointer
	LDA (CurrentSort, X)
	STA Title
	INC CurrentSort
	BNE IncSort1
	INC CurrentSort + 1		
.IncSort1
	LDA (CurrentSort, X)
	STA Title + 1
	INC CurrentSort
	BNE IncSort2
	INC CurrentSort + 1		
.IncSort2
	
	; Test if we have run off the end of the list
	CMP #$FF
	BEQ WritePageEndOfList
	
.FilterLoop

	; If there is no filter, we move on to compare the search (if there is one)
	LDY Filter
	BEQ SearchCompare

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Start of loop that needs to be *very efficient*
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	; Otherwise compare what's the the title record with the filter value
	LDA (Title), Y

	; Genre is packed into byte 1 with index, so we need to shift by two places
	CPY #1
	BNE FilterCompare
	LSR A
	LSR A	

	;; Do the filter comparison, skip to next row if no match
.FilterCompare
	CMP FilterVal
	BNE NextRow

	; Do the search comparison 
.SearchCompare
	LDY #4
.SearchCompare1
	LDA SearchBuffer - 4,Y
	CMP #Return
	BEQ MatchingRow
	CMP (Title),Y
	BNE NextRow
	INY
	BNE SearchCompare1

.MatchingRow

	;; Have we reached the required start row yet?
	LDA CurrentRow
	BNE DecRow
	LDA CurrentRow + 1
	BEQ FoundRow

	;; Decrement the start row count by one
.DecRow
	SEC
	LDA CurrentRow
	SBC #1
	STA CurrentRow
	BCS NextRow
	DEC CurrentRow + 1
	
	; Move to the next row in the sort table
.NextRow
	LDA (CurrentSort, X)
	STA Title
	INC CurrentSort
	BNE IncSort3
	INC CurrentSort + 1		
.IncSort3
	LDA (CurrentSort, X)
	STA Title + 1
	INC CurrentSort
	BNE IncSort4
	INC CurrentSort + 1		
.IncSort4

	; Test if we have run off the end of the list
	CMP #$FF
	BNE FilterLoop
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; End of loop that needs to be *very efficient*
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	BEQ WritePageEndOfList

	
.FoundRow

	; Write the line at (Title) to the screen
	JSR WriteLine
	
	; Store Title so that the basic program knows what's on each line
	LDA RowCount
	ASL A
	TAY
	LDA Title
	STA (RowRet),Y
	INY
	LDA Title + 1
	STA (RowRet),Y
	
	LDA RowCount
	INC RowCount
	CMP #LinesPerPage-1
	BEQ FoundAll
	JMP WriteLines
	
.FoundAll
	RTS

.WritePageEndOfList
	LDX #CharsPerLine
.WritePageEndOfList1
	LDA #Space
	JSR WriteToScreen
	DEX
	BNE WritePageEndOfList1
	INC RowCount
	LDA RowCount
	CMP #LinesPerPage
	BNE WritePageEndOfList
	RTS

.WriteLine
	
	; Keep track of how many chars we have available
	
	LDX #CharsPerLine - 3
	; Prepare the Annotation first (so we know how long it is...) 
	
    LDA Annotation
    BPL NormalAnnotation

	LDY #CountOffset
	LDA (Title),Y
	STA BinBuffer
	INY
	LDA (Title),Y
	STA BinBuffer + 1		
	JSR WriteDecimal

	LDA #<CountString
	STA AnnotationString
	LDA #>CountString
	STA AnnotationString + 1
	
	JMP LengthOfAnnotation

.NormalAnnotation
	LDY Annotation
	LDA AnnotationOffset,Y
	PHA
	LDA AnnotationIdMap,Y
	TAY
	LDA (Title),Y
	CPY #1
	BNE NotGenre
	LSR A
	LSR A
.NotGenre	
	ASL A
	TAY
	PLA
	CLC
	ADC (AnnotationPtr),Y
	STA AnnotationString
	INY
	LDA #0
	ADC (AnnotationPtr),Y
	STA AnnotationString + 1

.LengthOfAnnotation
	LDY #0

.LengthOfAnnotationLoop
	LDA (AnnotationString),Y
	CMP #Return
	BEQ WriteLetter
	INY
	DEX
	BNE LengthOfAnnotationLoop

.WriteLetter
	CLC
	LDA #65
	ADC RowCount
	JSR WriteToScreen
	LDA #Dot
	JSR WriteToScreen
	LDY #TitleNameOffset

.WriteTitle
	LDA (Title),Y
	CMP #Return
	BEQ WriteSeperator
	JSR WriteToScreen
	INY
	DEX
	BNE WriteTitle

.WriteSeperator
	LDA #Space

.WriteSeperatorLoop
	JSR WriteToScreen
	DEX
	BPL WriteSeperatorLoop

	LDY #0
.WriteAnnotation
	LDA (AnnotationString),Y
	CMP #Return
	BEQ WriteLineExit
	JSR WriteToScreen 
	INY
	BNE WriteAnnotation

.WriteLineExit
	RTS

.Inkey
	JSR $FE71
	BCC Inkey1
	LDY #$ff
.Inkey1
	STY Key
	RTS
	
.HighlightRow
	
	LDA #<(ScreenStart)
	STA Screen	
	LDA #>(ScreenStart)
	STA Screen+1
	LDA Row
	ASL A
	ASL A
	ASL A
	ASL A
	ASL A
	BCC HighlightRow1
	INC Screen+1
.HighlightRow1	
	CLC
	ADC Screen
	STA Screen
	
	LDY #2
.HighlightRow2
	JSR WaitUntilVSync
	DEY
	BNE HighlightRow2
	
	LDY #$1F
.HighlightRow3
	LDA (Screen),Y
	EOR #$80
	STA (Screen),Y
	DEY
	BPL	HighlightRow3
	RTS

.WriteToScreen
	STY TmpY
	LDY #0

	AND #$3F
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
	RTS


	; Converts the 16-bit value in $BinBuffer to "(" <Decimal String> ")" <CR> at Buffer

.WriteDecimal:
	TXA
	PHA
	SED
	LDA #0
	STA BcdBuffer
	STA BcdBuffer+1
	STA BcdBuffer+2
	; Handle the binary bits one at a time
	LDY #16        
.BcdLoop:
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
	BNE BcdLoop
	CLD

	; Set the flag to support suppression of leading zeros
	STY SuppressFlag

	; Output the BcdBuffer digits, MS first
	LDA #'('
	STA CountString
	LDX #1
	LDY #2
.DecLoop
	LDA BcdBuffer,Y
	JSR WriteHex
	DEY
	BPL DecLoop
	LDA #')'
	STA CountString,X
	INX
	LDA #Return
	STA CountString,X
	PLA
	TAX
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
	

	
.Search

	; Returns with Y being the end of the search buffer
	LDA #$A0
	JSR ShowCurrentSearch
	
	; Read a character
	JSR OSRDCH

	; Return terminates the search
	CMP #$0d
	BEQ SearchExit

	CMP #$7F
	BNE SearchRefreshPage
	
	; Delete at the beginning of the line also terminates the search
	CPY #0
	BEQ SearchExit

	DEY
	LDA #Return
	
.SearchRefreshPage

	STA SearchBuffer,Y
	INY
	LDA #Return
	STA SearchBuffer,Y

	JSR WritePage

	JMP Search
	
.SearchExit
	CPY #0
	BNE ShowCurrentSearchNoCursor
	
	LDA #Space
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
	CMP #Return
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
	EQUS "  SEARCH: "
	EQUB 0

	


	
.Test
	JSR OSRDCH
	STA $80
	RTS

.ENDOF


SAVE "MENUMC",STARTOFHEADER, ENDOF
