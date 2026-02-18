.ClearFilters
{
	LDA #0
	STA FilterType
	STA FilterVal
	LDY #CollectionsByteOffset
.loop
	STA FacetMasks, Y
	STA FacetValues, Y
	DEY
	BPL loop
	RTS
}

; Y = Filter Type
; A = Filter Value
.AddFilter
{
	; FilterVal and FilterType are just used for display purposes
	; as it's hard (but not impossible) to invert the data in
	; in FacetMasks/FacetValues
	STA FilterVal   ; Now just used for display purposes
	STY FilterType	; Now just used for display purposes

	; Shift the value to the right bit position
	LDX FacetBitOffsetTable - 1, Y
.shift_loop
	CPX #7
	BEQ shift_done
	ASL A
	INX
	BCC shift_loop  ; should be branch always
.shift_done
	PHA		; save the shifted valte

	; make X = byte offset into FacetMasks/Values for the required filter
	LDX FacetByteOffsetTable - 1, Y

	; Update the FacetValues table with the (shifted) value
	LDA FacetMaskTable - 1, Y
	EOR #&FF
	AND FacetValues, X
	STA FacetValues, X
	PLA
	ORA FacetValues, X
	STA FacetValues, X

	; Update the FacetMasks table with the mask
	LDA FacetMaskTable - 1, Y
	ORA FacetMasks, X
	STA FacetMasks, X

	RTS
}

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

.WritePage

IF properAnnotationCounts

	LDA DisplayMode
	AND #DisplayModeMask
	BNE WritePage1
	JSR ClearAnnotationCounts
.WritePage1

ENDIF

	LDA SearchBuffer
	STA SearchFirst

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
	; CLC		; pretty sure this is not needed, as annotation is small
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

	; Default to assuming we are on a facet page
	LDA #FacetTitleOffset
	STA TitleNameOffset

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Start of loop that needs to be efficient
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.NextRow

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

	; Bypass search/filter code when in one of the filter pages
	LDA DisplayMode
	AND #DisplayModeMask
	BNE MatchingRowFastPath

	; Find the offset to the title, by skipping over all the collections
	LDY #CollectionsByteOffset - 1
.FindTitle
	INY
	LDA (Title),Y
	BMI FindTitle
	STY TitleNameOffset

	; Bypass search/filter/update counts code if no search and no filter
	LDA SearchFirst
	ORA FilterType
	BEQ MatchingRowFastPath

.SearchCompare
{
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

.FilterCompare
{
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
	BEQ FilterMatch	   ; If No Collections Filter we have a match
.CatFilterLoop
	LDA (Title), Y
	BPL NextRow
	EOR CollectionsFacetValue
	AND CollectionsFacetMask
	BEQ FilterMatch
	INY
	BNE CatFilterLoop   ; Branch always
.FilterMatch
}

IF properAnnotationCounts
	JSR AccumulateAnnotationCounts
ENDIF

.MatchingRowFastPath
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
	BCS FoundRow
	JMP NextRow

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; End of loop that needs to be *very efficient*
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; Found a row that matches all filter and search

.FoundRow
	; Have we displayed the requested number of rows
	LDA RowCount
	CMP #LinesPerPage
	BNE FoundRow1
	JMP NextRow

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
	JMP NextRow

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

	LDY #FacetCountOffset

IF properAnnotationCounts
	LDA SearchFirst
	BEQ NoSearch
	LDY #FacetWorkingOffset
.NoSearch
ENDIF
	LDA (Title),Y
	AND #&7F
	STA BinBuffer + 1
	INY
	LDA (Title),Y
	STA BinBuffer
	JSR WriteCount

	LDA #<CountString
	STA AnnotationString
	LDA #>CountString
	STA AnnotationString + 1

	JMP LengthOfAnnotation


;; Maps annotation to Table ID type

; 0 = Short Publisher -> 1
; 1 = Publisher       -> 1
; 2 = Genre           -> 2
; 3 = Chunk           -> 3
; 4 = Ram      	      -> 4
; 5 = Rom      	      -> 5
; 6 = Version         -> 6
; 7 = Joystick        -> 7
; 8 = Collection      -> 8

.AnnotationIdMap
	EQUB 	1 ; Short Publisher
	EQUB 	1 ; Publisher
	EQUB 	2 ; Genre
	EQUB 	3 ; Chunk
	EQUB 	4 ; Ram
	EQUB 	5 ; Rom
	EQUB 	6 ; Version
	EQUB 	7 ; Joyctick
	EQUB 	8 ; Collection

; Offset of first record in the annotation
; (depends on whether the table was build against a sort index)
; Always 0 or 4

.AnnotationOffset
	EQUB 	0 ; Short Publisher
	EQUB 	4 ; Publisher
	EQUB 	4 ; Genre
	EQUB 	4 ; Chunk
	EQUB 	4 ; Ram
	EQUB 	4 ; Rom
	EQUB 	4 ; Version
	EQUB 	4 ; Joystick
	EQUB 	4 ; Collection

.NormalAnnotation
	LDY Annotation
	LDA AnnotationOffset,Y
	PHA
	LDA AnnotationIdMap,Y
	TAY
	JSR ExtractTableValue

	BPL NotNullCollection

	; CollectionIDs always have bit 7 set
	; If bit 7 is clear, there is no collection
	PLA
	LDA #<NullCollectionMessage
	STA AnnotationString
	LDA #>NullCollectionMessage
	STA AnnotationString + 1
	BNE LengthOfAnnotation

.NullCollectionMessage
	; Currently just blank, a string like "NO COLLECTION" could be put here
	EQUB &ff

.NotNullCollection
	; Currently the MSB of the annotation is lost, which limits secondary tables to 7 bit values
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
	BMI WriteLetter
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

	LDA DisplayMode
	BPL WriteTitle1
	LDA SearchFirst
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
	BMI WriteLineExit
	JSR WriteToScreen
	INY
	BNE WriteAnnotation

.WriteLineExit
	RTS

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
	JSR $FE71
	BCC Inkey1
	LDY #$ff
.Inkey1
	STY Key
	RTS


.FacetByteOffsetTable
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
	EQUB GenreMask
	EQUB ChunkMask
	EQUB RamMask
	EQUB RomMask
	EQUB VersionMask
	EQUB JoystickMask
	EQUB CollectionsMask

.FacetXorTable
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
	EQUB 7 - GenreBitOffset
	EQUB 7 - ChunkBitOffset
	EQUB 7 - RamBitOffset
	EQUB 7 - RomBitOffset
	EQUB 7 - VersionBitOffset
	EQUB 7 - JoystickBitOffset
	EQUB 7 - CollectionsBitOffset

;; Extract Filter/Annotation ID from title table and nomalize
.ExtractTableValue
{
	LDA FacetBitOffsetTable - 1, Y
	STA shift + 1
	LDA FacetMaskTable - 1, Y
	STA mask + 1
	LDA FacetXorTable - 1, Y
	STA xor + 1
	LDA FacetByteOffsetTable - 1, Y
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

	LDA #$80
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
	LDY #0
	SEC
	LDA (RowRet),Y
	SBC #1
	STA BinBuffer
	INY
	LDA (RowRet),Y
	SBC #0
	STA BinBuffer+1
	BCC CalculateNumPages2
	DEY
	TYA
.CalculateNumPages1
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
	BCS CalculateNumPages1
	RTS
.CalculateNumPages2
	TYA
	RTS


IF properAnnotationCounts

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Accumulate the annotation counts
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.AccumulateAnnotationCounts

	LDX #NumFacets
.AnnotationTypeLoop
	LDA AnnotationIdMap,X
	TAY
	CPY #CollectionsFilterNum
	BNE AnnotationNotCollection

	LDY #CollectionsByteOffset
.AnnotationNextCollection
	LDA (Title),Y
	BPL AnnotationNextType
	AND #$7F
	STY TmpY
	JSR IncAnnotationCounts
	LDY TmpY
	INY
	BNE AnnotationNextCollection

.AnnotationNotCollection
	JSR ExtractTableValue
	JSR IncAnnotationCounts
.AnnotationNextType
	DEX
	BNE AnnotationTypeLoop
	RTS

	; Offset into the MenuTable of the pointer to the secondary
	; table for the annotation type

.MenuTableIndex
FOR i, 0, NumFacets - 1, 1
	EQUB 4 + 2 * i
NEXT

	; X=Annotation type (1 = Long Publisher, 2 = Genre, 3 = Collection)
	; A=Annotation id value (7 bits)
.GetAnnotationRecord
	CLC
	ADC #1		; Skip over the secondary table length field
	ASL A
	LDY MenuTableIndex - 1, X
	ADC (MenuTablePtr),Y
	STA Tmp
	INY
	LDA (MenuTablePtr),Y
	ADC #0
	STA Tmp + 1	; Tmp the address of the pointer to the facet record
	LDY #0
	LDA (Tmp),Y
	STA AnnotationString
	INY
	LDA (Tmp),Y
	STA AnnotationString + 1
	RTS

	; Increment an annotation count
.IncAnnotationCounts
	JSR GetAnnotationRecord
	LDY #3		; count is stored at offset 3 (LSB) and 2 (MSB)
	SEC
.loop
	LDA (AnnotationString),Y
	ADC #0
	STA (AnnotationString),Y
	DEY
	BCS loop	; skip back in the rare case of carry
	RTS 		; (you only get this if you search for <space>)

	; Clear the 2nd and 3rd byte of each annotation record
	; We will use these to store counts of the number of search filtered items
.ClearAnnotationCounts
	LDY #4		;  skip over title and short pub tables
.ClearAnnotationCounts1
	CLC
	LDA (MenuTablePtr),Y
	ADC #2
	STA Tmp
	INY
	LDA (MenuTablePtr),Y
	ADC #0
	STA Tmp + 1
	JSR ClearAnnotationCounts2
	INY
	CPY #4 + NumFacets * 2
	BNE ClearAnnotationCounts1
	RTS
.ClearAnnotationCounts2
	TYA
	PHA
	LDX #0
	LDY #$FF
.ClearAnnotationCounts3
	INY
	LDA (Tmp),Y
	STA AnnotationString
	INY
	LDA (Tmp),Y
	STA AnnotationString + 1
	BEQ ClearAnnotationCounts6
	TYA
	PHA
	LDY #2
	TXA
	STA (AnnotationString),Y
	INY
	STA (AnnotationString),Y
	PLA
	TAY
	BNE ClearAnnotationCounts3
.ClearAnnotationCounts6
	PLA
	TAY
	RTS

ENDIF
