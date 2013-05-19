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

	LDA Sort
	STA CurrentSort
	LDA Sort + 1
	STA CurrentSort + 1


	; Calculate a pointer to the requested annotation table, skipping the length field
    LDA Annotation
    ASL A
    TAY
    INY
    INY
    CLC
	LDA (MenuTablePtr),Y
	ADC #2
	STA AnnotationPtr
	INY
	LDA (MenuTablePtr),Y
	ADC #0
	STA AnnotationPtr + 1
	
	LDA #<(ScreenStart + StartLine * CharsPerLine)
	STA Screen
	LDA #>(ScreenStart + StartLine * CharsPerLine)
	STA Screen + 1

	LDA #0
	STA RowCount
	STA CurrentRow
	STA CurrentRow + 1
	
.NextRow

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
	LDA SearchMode
	AND #3
	BNE MatchingRow
	
	LDY #3
	STY TmpY
.SearchCompare1
	LDY TmpY
	INY
	STY TmpY
	LDA (Title),Y
	CMP #Return
	BEQ NextRow
	LDX #0
.SearchCompare2
	LDA SearchBuffer,X
	CMP #Return
	BEQ MatchingRow
	CMP (Title),Y
	BNE SearchCompare1
	INX
	INY
	BNE SearchCompare2

.MatchingRow
	INC CurrentRow
	BNE MatchingRow1
	INC CurrentRow + 1
	
	;; Have we reached the required start row yet?
.MatchingRow1
	SEC
	LDA CurrentRow
	SBC StartRow
	LDA CurrentRow + 1
	SBC StartRow+1
	BCC NextRow
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; End of loop that needs to be *very efficient*
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	; Found a row that matches all filter and search

.FoundRow

	; Have we displayed the requested number of rows
	LDA RowCount
	CMP #LinesPerPage
	BEQ NextRow

.FoundRow1

	; Increment the count of the number of rows displayed
	INC RowCount

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
	BNE NextRow
	
.WritePageEndOfList
	; We have hit the end of the sort list
	LDA RowCount
	CMP #LinesPerPage
	BEQ UpdateTotalRows		
	LDX #CharsPerLine
.WritePageEndOfList1
	LDA #Space
	JSR WriteToScreen
	DEX
	BNE WritePageEndOfList1
	INC RowCount
	BNE WritePageEndOfList

.UpdateTotalRows
	LDY #0
	LDA CurrentRow
	STA (RowRet), Y
	INY
	LDA CurrentRow + 1
	STA (RowRet), Y	
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
	JSR WriteCount

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
	LDA #64
	ADC RowCount
	JSR WriteToScreen
	LDA #Dot
	JSR WriteToScreen
	
.WriteTitle
	
	LDA SearchMode
	BPL WriteTitle1
	LDA SearchBuffer
	CMP #Return
	BEQ WriteTitle1
	
	; There is an active search filter, so try to highlight
	JSR WriteTitleHighlight
	JMP WriteSeperator

.WriteTitle1
	; There is no active search filter, so don't try to highlight
	JSR WriteTitleNoHighlight

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

.WriteTitleNoHighlight
	LDY #TitleNameOffset
.WriteTitleNoHighlight1
	LDA (Title),Y
	CMP #Return
	BEQ WriteTitleNoHighlight2
	JSR WriteToScreen
	INY
	DEX
	BNE WriteTitleNoHighlight1
.WriteTitleNoHighlight2
	RTS

.WriteTitleHighlight
	STX TmpX
	LDY #TitleNameOffset	
.WriteTitleHighlight1
	LDA (Title),Y
	CMP #Return
	BEQ WriteTitleHighlight3
	CMP SearchBuffer
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
	CMP #Return
	BEQ Match
	LDA (Title),Y
	CMP #Return
	BEQ NoMatch
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
	LDA #')'
	STA CountString,X
	INX
	LDA #Return
	STA CountString,X
	PLA
	TAX
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

	LDA #$80
	STA SearchMode
	
	; Update current results set and number of pages
	JSR WritePage
	JSR UpdateTotalPages

	; Returns with Y being the end of the search buffer
	LDA #$A0
	JSR ShowCurrentSearch
	
	; Read a character
	JSR Osrdch

	; Return terminates the search
	CMP #$0d
	BEQ SearchExit

	CMP #$7F
	BNE Search1
	
	; Delete at the beginning of the line also terminates the search
	CPY #0
	BEQ SearchExit

	DEY
	LDA #Return
	
.Search1

	STA SearchBuffer,Y
	INY
	LDA #Return
	STA SearchBuffer,Y

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
	LDY	#$FF
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
.UpdateTotalPages2
	LDA CountString,X
	AND #$3F
	ORA #$80
	STA ScreenStart + CharsPerLine - 5,X
	INX
	CPX #5
	BNE UpdateTotalPages2
	RTS
	

	; Reads the total number of filtered rows returned
	; Inefficiently divide number of rows by the rows per page
	; Returns the number of pages in BCD in A
	; Returns the number of pages in Binary in Y	
.CalculateNumPages
	LDY #0
	LDA (RowRet),Y
	STA BinBuffer
	INY
	LDA (RowRet),Y
	STA BinBuffer+1
	LDA #0
	TAY
.UpdateTotalPages1
	INY
	SED
	CLC
	ADC #1
	CLD
	PHA
	SEC
	LDA BinBuffer
	SBC #LinesPerPage
	STA BinBuffer
	LDA BinBuffer+1
	SBC #0
	STA BinBuffer+1
	PLA
	BCS UpdateTotalPages1
	RTS
	

	
	