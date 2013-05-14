
	SortTableBase = $3600
	TitleSortPtr = SortTableBase;
	PublisherSortPtr = SortTableBase + 2;
	GenreSortPtr = SortTableBase + 4;
	CollectionSortPtr = SortTableBase + 8;

	MenuTableBase = $8200	
	TitleTablePtr = MenuTableBase;	
	ShortPublisherTablePtr = MenuTableBase + 2;	
	PublisherTablePtr = MenuTableBase + 4;	
	GenreTablePtr = MenuTableBase + 6;	
	CollectionTablePtr = MenuTableBase + 8;	

	PubIdOffset = 2
	TitleNameOffset = 4
	
	; Value to set on input

	; This should point to the first row in the sort index
	Sort = $80

	; This should point to the index of the row to search for (starting at 0) 
    StartRow = $8e 

	; The annotation to show: 0 = Publisher, 255 = Nothing
    Annotation = $8b

    ; The filter key: 1 = Genre, 2 = Publisher, 3 = Collection
    Filter = $8c

	; The filter value
    FilterVal = $8d
    
    ; The Address to store the found rows, so that the basic program can access them
    RowRet = $92


	; These are working values
	Title = $82
	ShortPub = $84
	ShortPubName = $86
	Screen = $88
	TmpY = $8a    
	RowCount =$90
	Key = $80


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


.WritePage

    CLC
	LDA ShortPublisherTablePtr
	ADC #2
	STA ShortPub
	LDA ShortPublisherTablePtr + 1
	ADC #0
	STA ShortPub + 1
	LDA #<(ScreenStart + StartLine * CharsPerLine)
	STA Screen
	LDA #>(ScreenStart + StartLine * CharsPerLine)
	STA Screen + 1

	LDA #0
	STA RowCount


	LDY Filter
	BNE WriteLines
	
	; if no filtering, calculate index into sort table directly
	ASL StartRow
	ROL StartRow + 1
	LDA Sort
	ADC StartRow
	STA Sort
	LDA Sort + 1
	ADC StartRow + 1
	STA Sort + 1
	
.WriteLines

	LDX #0

	; Follow the sort pointer to the title record, and increment the sort pointer
	LDA (Sort, X)
	STA Title
	INC Sort
	BNE IncSort1
	INC Sort + 1		
.IncSort1
	LDA (Sort, X)
	STA Title + 1
	INC Sort
	BNE IncSort2
	INC Sort + 1		
.IncSort2
	
	; Test if we have run off the end of the list
	CMP #$FF
	BEQ WritePageEndOfList
	
	; If there is no filter, we've found the row
	LDY Filter
	BEQ FoundRow

.FilterLoop

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

	;; Have we reached the required start row yet?
	LDA StartRow
	BNE DecRow
	LDA StartRow + 1
	BEQ FoundRow

	;; Decrement the start row count by one
.DecRow
	SEC
	LDA StartRow
	SBC #1
	STA StartRow
	BCS NextRow
	DEC StartRow + 1
	
	; Move to the next row in the sort table
.NextRow
	LDA (Sort, X)
	STA Title
	INC Sort
	BNE IncSort3
	INC Sort + 1		
.IncSort3
	LDA (Sort, X)
	STA Title + 1
	INC Sort
	BNE IncSort4
	INC Sort + 1		
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
	BNE WriteLines
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
	CLC
	LDA #65
	ADC RowCount
	JSR WriteToScreen
	LDA #Dot
	JSR WriteToScreen
	LDX #CharsPerLine - 2
	LDY #TitleNameOffset

.WriteLine2
	LDA (Title),Y
	CMP #Return
	BEQ WriteLine3
	JSR WriteToScreen
	DEX
	INY
	BNE WriteLine2

.WriteLine3
    LDA Annotation
    BMI WriteLine5
	LDY #PubIdOffset
	LDA (Title),Y
	CLC
	ASL A
	TAY
	LDA (ShortPub),Y
	STA ShortPubName
	INY
	LDA (ShortPub),Y
	STA ShortPubName + 1
	LDY #0

.WriteLine4
	LDA (ShortPubName),Y
	CMP #Return
	BEQ WriteLine5
	DEX
	INY
	BNE WriteLine4

.WriteLine5
	LDA #Space

.WriteLine6
	JSR WriteToScreen
	DEX
	BNE WriteLine6
	LDA Annotation
	BMI WriteLine8
	LDY #0

.WriteLine7
	LDA (ShortPubName),Y
	CMP #Return
	BEQ WriteLine8
	JSR WriteToScreen 
	INY
	BNE WriteLine7
.WriteLine8	
	RTS

.Inkey
	JSR $FE71
	BCC Inkey1
	LDY #0
.Inkey1
	STY Key
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
	LDA Screen + 1
	
.WriteToScreen1
	LDY TmpY
	RTS




.ENDOF


SAVE "MENUMC",STARTOFHEADER, ENDOF
