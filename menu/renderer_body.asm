.ClearFilters
{
	LDA #0
	STA FilterType
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
	LDA FilterType
	ORA mask - 1, Y
	STA FilterType
	RTS

.mask
	EQUB &01, &02, &04, &08
	EQUB &10, &20, &40, &80
}

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

IF properAnnotationCounts
	BIT DisplayMode
	BPL SkipClearCounts
	JSR ClearAnnotationCounts
.SkipClearCounts
ENDIF
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
IF properAnnotationCounts
	BIT DisplayMode
	BPL MatchingRow1
	JSR AccumulateAnnotationCounts
	JMP NextRow
ENDIF

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
	LDA #Space
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

	LDA Annotation
	BPL NormalAnnotation

IF properAnnotationCounts
	LDY #FacetWorkingOffset
ELSE
	LDY #FacetCountOffset
ENDIF
	LDA (Title),Y
	AND #&7F
	STA BinBuffer + 1	; MSB first (i.e. cound is stored big endian)
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
	LDA #Dot
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
	LDA #Space

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

IF properAnnotationCounts

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

; Clear the 2nd and 3rd byte of each annotation record
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
	LDA #0
	STA (Tmp),Y
	INY
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
ENDIF
