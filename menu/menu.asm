
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

	Sort = $80
	Title = $82
	ShortPub = $84
	ShortPubName = $86
	Screen = $88
	TmpY = $8a

	Key = $80


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
	LDA ShortPublisherTablePtr
	STA ShortPub
	LDA ShortPublisherTablePtr + 1
	STA ShortPub + 1
	LDA #<(ScreenStart + StartLine * CharsPerLine)
	STA Screen
	LDA #>(ScreenStart + StartLine * CharsPerLine)
	STA Screen + 1
	LDY #0

.WritePage1
	LDA (Sort),Y
	STA Title
	INY
	LDA (Sort),Y
	STA Title + 1
	INY
	CMP #$FF
	BEQ WritePageEndOfList
	TYA
	PHA
	CLC
	LSR A
	ADC #64
	JSR WriteToScreen
	LDA #Dot
	JSR WriteToScreen
	LDX #CharsPerLine - 2
	LDY #TitleNameOffset

.WritePage2
	LDA (Title),Y
	CMP #Return
	BEQ WritePage3
	JSR WriteToScreen
	DEX
	INY
	BNE WritePage2

.WritePage3
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

.WritePage4
	LDA (ShortPubName),Y
	CMP #Return
	BEQ WritePage5
	DEX
	INY
	BNE WritePage4

.WritePage5
	LDA #Space

.WritePage6
	JSR WriteToScreen
	DEX
	BNE WritePage6
	LDY #0

.WritePage7
	LDA (ShortPubName),Y
	CMP #Return
	BEQ WritePage8
	JSR WriteToScreen 
	INY
	BNE WritePage7

.WritePage8
	PLA
	TAY
	CPY #LinesPerPage * 2
	BNE WritePage1

.WritePage9
	RTS

.WritePageEndOfList
	CPY #LinesPerPage * 2 + 2
	BEQ WritePage9
	LDX #CharsPerLine
.WritePageEndOfList1
	LDA #Space
	JSR WriteToScreen
	DEX
	BNE WritePageEndOfList1
	INY
	INY
	BNE WritePageEndOfList


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
.WriteToScreen1
	LDY TmpY
	RTS




.ENDOF


SAVE "MENUMC",STARTOFHEADER, ENDOF
