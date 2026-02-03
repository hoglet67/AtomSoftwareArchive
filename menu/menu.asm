	KernelOsrdch = $fe94
	RDCVEC       = $20a

	Base =? $2800

	BannerScroll =? 1

include "sysvars.asm"

; Some local variables

EndPage  = TmpPtr + 2
KeyFlag  = TmpPtr + 3
NumLines = TmpPtr + 4
Cycle    = TmpPtr + 5
TxtPtr   = TmpPtr + 7
FontPtr  = TmpPtr + 9

MinChapter = 0			; A
MaxChapter = 6			; G
AGDChapter = 2			; C
ALLChapter = 6			; G

ChapterLineStart = 70		; Y pixel row to strike in Chapter A
ChapterLineWidth = 12		; Y pixels between adjacent text lines

ScrollWindowStart  = 150	; for now needs to be a multiple of 8
ScrollWindowHeight = 24

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
	; Minimum checks for a 12K Atom
	LDX #>TextBuffer        ; Test 2C00-3BFF
	LDY #&3B+1
	JSR MemTest
	BCS Bail

	LDX #&80                ; Test 8000-97FF
	LDY #&97+1
	JSR MemTest
	BCC MeetsMinimum

.Bail
	LDX #0
.BailLoop
	LDA BailMessage, X
	BEQ BailExit
	JSR Oswrch
	INX
	BNE BailLoop
.BailExit
	JMP $c2b2

.BailMessage
	EQUB 12
	EQUS "THE ATOM SOFTWARE ARCHIVE NEEDS "
	EQUS "A MINIMUM OF 12K OF RAM TO RUN! "
	EQUB 0

.StrikeLenTable
	EQUB 13
	EQUB 19
	EQUB 23
	EQUB 17
	EQUB 22
	EQUB 15
	EQUB 13
	EQUB 0

.MeetsMinimum

	; Work around for issue with older versions of AtomMMC on some titles (e.g. SUB HUNT)
	LDA #<KernelOsrdch
	STA RDCVEC
	LDA #>KernelOsrdch
	STA RDCVEC + 1

	LDA #0			; All chapters enabled
	STA KeyFlag

	LDX #&10                ; Test 1000-1FFF
	LDY #&1F+1
	JSR MemTest
	BCS DisableAllChapter

	LDX #&22                ; Test 2200-27FF
	LDY #&27+1
	JSR MemTest
	BCS DisableAllChapter

	LDX #&3C                ; Test 7C00-7FFF
	LDY #&7F+1
	JSR MemTest
	BCS DisableAllChapter

	; Enough memory for ALL chapter, now test for AGD

	LDX #&03                ; Test 0300-0FFF
	LDY #&0F+1
	JSR MemTest
	BCS DisableAGDChapter

	LDX #&98                ; Test 9800-9FFF
	LDY #&9F+1
	JSR MemTest
	BCC ChecksDone

.DisableAGDChapter
	LDA #(1<<AGDChapter)
	STA KeyFlag             ; Disable AGD chapter
	BNE ChecksDone

.DisableAllChapter
	LDA #(1<<AGDChapter + 1<<ALLChapter)
	STA KeyFlag

.ChecksDone

IF (econet = 1 OR gosdc = 1)
	JSR OscliString
	EQUS "DIR $.ASA", Return
	;JSR OscliString
	;EQUS "LIB $.ATOMLIB", Return
ELSE
IF (atommc = 1)
	JSR OscliString
	EQUS "CWD ASA", Return
ENDIF
	; 10 *NOMON
	JSR OscliString
	EQUS "NOMON", Return
ENDIF

	; 20 CLEAR 4
	LDY #4
	JSR Clear

	; 30 *LOAD SPLASH
	JSR OscliString
	EQUS "LOAD SPLASH", Return

	; Visibly strike out disabled chapters
	; This is a bit of a hack, as it depends on hard coded line lengths
	LDX #MaxChapter
	LDA #<(ScreenStart + (ChapterLineStart + MaxChapter * ChapterLineWidth) * 32)
	STA TmpPtr
	LDA #>(ScreenStart + (ChapterLineStart + MaxChapter * ChapterLineWidth) * 32)
	STA TmpPtr+1
.StrikeLoop1
	LDA KeyMask, X
	AND KeyFlag
	BEQ StrikeNext
	LDY StrikeLenTable, X
.StrikeLoop2
	TYA
	ORA #&20
	TAY
	LDA #0
	STA (TmpPtr), Y
	TYA
	AND #&DF
	TAY
	LDA #0
	STA (TmpPtr), Y
	DEY
	BNE StrikeLoop2
.StrikeNext
	LDA TmpPtr
	SEC
	SBC #<(ChapterLineWidth * 32)
	STA TmpPtr
	LDA TmpPtr + 1
	SBC #>(ChapterLineWidth * 32)
	STA TmpPtr + 1
	DEX
	BPL StrikeLoop1

IF (BannerScroll = 1)
	LDA #0
	STA Cycle
	STA Cycle+1
	JSR PrintRamTest
ENDIF

.MenuMain
IF (BannerScroll = 1)
	JSR &FE66
	LDX #ScrollWindowStart
	LDY #ScrollWindowHeight
	JSR Scroll
	JSR ScanKeyboard
	BCS MenuMain
ELSE
	JSR Osrdch
ENDIF
	CMP #&1B
	BEQ MenuExit

	; Shifted A-G bypass all checks, buyer beware!
	CMP #MinChapter + 'a'
	BCC KeyNotShiftedAtoG
	CMP #MaxChapter + 'a' + 1
	BCC MenuNext

.KeyNotShiftedAtoG
	; Unshifed A-G subject to mask in KegFLag
	CMP #MinChapter + 'A'
	BCC MenuMain
	CMP #MaxChapter + 'A' + 1
	BCS KeyNotAtoG

	; Test appropriate mask bit
	PHA
	AND #&F			; A = 1, B = 2, C = 3, ...
	TAX
	DEX			; A = 0; B = 1, C = 2, ...
	LDA KeyMask, X
	AND KeyFlag
	BEQ ChaptedEnabled
	PLA
	LDA #7			; Beep
	JSR Oswrch
	BNE MenuMain		; Branch always

.ChaptedEnabled
	PLA
	BNE MenuNext		; Branch alwats

.KeyMask
	EQUB &01
	EQUB &02
	EQUB &04
	EQUB &08
	EQUB &10
	EQUB &20
	EQUB &40
	EQUB &80

.KeyNotAtoG
	; Check for special system key for Rolands system
	CMP #'R'
	BNE MenuMain

	LDY #0
	JSR Clear
	JSR OscliString
IF (econet = 1 OR gosdc = 1)
	EQUS "DIR SYS", Return
ELSE
	EQUS "CWD SYS", Return
ENDIF
	JSR OscliString
	EQUS "INIT", Return

	; Don't expect to return, but just in case....
	JMP $c2b2

.MenuExit
IF (econet = 1 OR gosdc = 1)
	JSR OscliString
	EQUS "DIR $", Return
ELIF (atommc = 1)
	JSR OscliString
	EQUS "CWD /", Return
ENDIF
	LDA #&0C
	JSR Oswrch
	JMP $c2b2

.MenuNext
	AND #&DF                ; force lower case
IF (sddos2 = 1)
	; A-G -> Disks 1->N
	AND #&0F
	ORA #'0'
	STA chunk
	JSR OscliString
	EQUS "DIN 1,"
.chunk
	EQUS "X", Return
	JSR OscliString
	EQUS "DRIVE 1", Return
ELIF (sddos3 = 1)
	STA chunk
	JSR OscliString
	EQUS "DIN 1,MNU"
.chunk
	EQUS "X.DSK", Return
	JSR OscliString
	EQUS "DRIVE 1", Return
ELSE
	STA MenuDirChunk
	JSR OscliString
	IF (econet = 1 OR gosdc = 1)
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

	; Load/run the chapter menu
	JSR OscliString
	EQUS "RUN CHAP", Return

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

; Simple destructive memory test

; X = Start Page
; Y = End Page + 1

.MemTest
	STY EndPage

	; Y never changes
	LDY #0
	STY TmpPtr

; write the first byte of page with the page number EOR 255
	STX TmpPtr + 1
.MemWrLoop
	LDA TmpPtr + 1
	EOR #$FF
	STA (TmpPtr),Y
	INC TmpPtr + 1
	LDA TmpPtr + 1
	CMP EndPage
	BNE MemWrLoop

; test the first byte of page with the page number EOR 255
	STX TmpPtr + 1
.MemRdLoop
	LDA TmpPtr + 1
	EOR #$FF
	CMP (TmpPtr),Y
	BNE MemTestFail
	INC TmpPtr + 1
	LDA TmpPtr + 1
	CMP EndPage
	BNE MemRdLoop

.MemTestDone
	CLC
	RTS

.MemTestFail
	SEC
	RTS

include "common.asm"

IF (BannerScroll = 1)

; X = start line
; Y = number of lines

.Scroll
{
	STY NumLines	;
	LDA Cycle+1
	AND #&01
	BNE active
	JMP exit
.active
	LDA Cycle
	LSR A
	LSR A
	LSR A
	TAY
	TXA		; bits 7..3 indicate the PAGE
	LSR A		; ADD to
	LSR A
	LSR A
	CLC
	ADC #>ScreenStart
	STA unroll+2
	TXA		; bits 2..0 are the line
	ASL A
	ASL A
	ASL A
	ASL A
	ASL A
	TAX
	LDA #<TextBuffer
	STA TmpPtr
	LDA #>TextBuffer
	STA TmpPtr+1
.loop1
	LDA unroll + 2
FOR I, 1, 29
    	STA unroll + I * 3 + 2
NEXT
.loop2
	LDA (TmpPtr),Y
	ROL A
.unroll
FOR I, 0, 29
	ROL ScreenStart + &1E - I, X
NEXT
	LDA (TmpPtr),Y
	ROL A
	STA (TmpPtr),Y
	DEC NumLines
	BEQ exit
	TXA
	CLC
	ADC #&20
	TAX
	BNE next
	INC unroll + 2
.next
	LDA TmpPtr
	CLC
	ADC #&20
	STA TmpPtr
	LDA TmpPtr + 1
	ADC #&00
	STA TmpPtr + 1
	JMP loop1
.exit
	INC Cycle
	LDA Cycle
	CMP #30*8
	BNE exit2
	LDA #0
	STA Cycle
	INC Cycle+1
.exit2
	RTS
}

.ScanKeyboard
{
	JSR &FE71
	BCS return
	JSR convert
	CLC
.return
	RTS
.convert
	PHP
	JMP &FEB1
}


.PrintRamTest
{
	JSR ClearTextBuffer

	LDX #&00
.loop
	LDA RamTestString, X
	BEQ exit
	JSR TextPrintChar
	INX
	BNE loop
.exit
	RTS

.RamTestString
	EQUS "Lower Text RAM: 0000-0000       "
	EQUS "Upper Text RAM: 0000-0000       "
	EQUB 0
}

.ClearTextBuffer
{
	JSR HomeTxtPtr

	LDX #ScrollWindowHeight
.loop1
	LDY #&1F
	LDA #&FF
.loop2
	STA (TxtPtr),Y
	DEY
	BPL loop2
	LDA TxtPtr
	CLC
	ADC #&20
	STA TxtPtr
	LDA TxtPtr + 1
	ADC #&00
	STA TxtPtr + 1
	DEX
	BNE loop1
}

.HomeTxtPtr
{
	LDA #<TextBuffer
	STA TxtPtr
	LDA #>TextBuffer
	STA TxtPtr+1
	RTS
}


.AddTmpPtrToFontPtr
	LDA FontPtr	; FontPrtr += TmpPtr
	CLC
	ADC TmpPtr
	STA FontPtr
	LDA FontPtr+1
	ADC TmpPtr+1
	STA FontPtr+1
	RTS

.TextPrintChar
{
	PHA
	TXA
	PHA
	TYA
	PHA

	; FontPtr = FontData + ((A-32) & 127)*12

	LDA #<FontData
	STA FontPtr
	LDA #>FontData
	STA FontPtr+1

	LDA #0
	STA TmpPtr+1

	TSX
	LDA &103, X

	SEC
	SBC #&20
	AND #&7F

	ASL A
	ROL TmpPtr+1
	ASL A
	ROL TmpPtr+1
	STA TmpPtr

	JSR AddTmpPtrToFontPtr

	ASL TmpPtr
	ROL TmpPtr+1

	JSR AddTmpPtrToFontPtr

	LDA TxtPtr
	PHA
	LDA TxtPtr+1
	PHA

	LDX #0
	LDY #0
.loop
	LDA (FontPtr), Y
	EOR #&FF
	STA (TxtPtr, X)
	LDA TxtPtr
	CLC
	ADC #&20
	STA TxtPtr
	LDA TxtPtr + 1
	ADC #&00
	STA TxtPtr + 1
	INY
	CPY #12
	BNE loop

	LDA TxtPtr
	AND #&1F
	CMP #&1F
	BEQ endofline

	PLA
	STA TxtPtr+1
	PLA
	CLC
	ADC #1
	STA TxtPtr
	JMP exit

.endofline
	PLA
	PLA
	LDA TxtPtr
	AND #&E0
	STA TxtPtr

.exit
	PLA
	TAY
	PLA
	TAX
	PLA
	RTS
}


.FontData
	EQUB &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00		; &20
	EQUB &00, &00, &00, &08, &08, &08, &08, &08, &00, &08, &00, &00
	EQUB &00, &00, &00, &14, &14, &00, &00, &00, &00, &00, &00, &00
	EQUB &00, &00, &00, &14, &14, &3E, &14, &3E, &14, &14, &00, &00
	EQUB &00, &00, &00, &08, &1E, &20, &1C, &02, &3C, &08, &00, &00
	EQUB &00, &00, &00, &32, &32, &04, &08, &10, &26, &26, &00, &00
	EQUB &00, &00, &00, &10, &28, &28, &10, &2A, &24, &1A, &00, &00
	EQUB &00, &00, &00, &0C, &0C, &0C, &00, &00, &00, &00, &00, &00
	EQUB &00, &00, &00, &04, &08, &10, &10, &10, &08, &04, &00, &00
	EQUB &00, &00, &00, &10, &08, &04, &04, &04, &08, &10, &00, &00
	EQUB &00, &00, &00, &00, &08, &2A, &1C, &2A, &08, &00, &00, &00
	EQUB &00, &00, &00, &00, &08, &08, &3E, &08, &08, &00, &00, &00
	EQUB &00, &00, &00, &00, &00, &00, &0C, &0C, &04, &08, &00, &00
	EQUB &00, &00, &00, &00, &00, &00, &3E, &00, &00, &00, &00, &00
	EQUB &00, &00, &00, &00, &00, &00, &00, &00, &0C, &0C, &00, &00
	EQUB &00, &00, &00, &02, &02, &04, &08, &10, &20, &20, &00, &00
	EQUB &00, &00, &00, &1C, &22, &26, &2A, &32, &22, &1C, &00, &00		; &30
	EQUB &00, &00, &00, &08, &18, &08, &08, &08, &08, &1C, &00, &00
	EQUB &00, &00, &00, &1C, &22, &02, &1C, &20, &20, &3E, &00, &00
	EQUB &00, &00, &00, &1C, &22, &02, &0C, &02, &22, &1C, &00, &00
	EQUB &00, &00, &00, &04, &0C, &14, &3E, &04, &04, &04, &00, &00
	EQUB &00, &00, &00, &3E, &20, &3C, &02, &02, &22, &1C, &00, &00
	EQUB &00, &00, &00, &1C, &20, &20, &3C, &22, &22, &1C, &00, &00
	EQUB &00, &00, &00, &3E, &02, &04, &08, &10, &20, &20, &00, &00
	EQUB &00, &00, &00, &1C, &22, &22, &1C, &22, &22, &1C, &00, &00
	EQUB &00, &00, &00, &1C, &22, &22, &1E, &02, &02, &1C, &00, &00
	EQUB &00, &00, &00, &00, &0C, &0C, &00, &0C, &0C, &00, &00, &00
	EQUB &00, &00, &00, &0C, &0C, &00, &0C, &0C, &04, &08, &00, &00
	EQUB &00, &00, &00, &04, &08, &10, &20, &10, &08, &04, &00, &00
	EQUB &00, &00, &00, &00, &00, &3E, &00, &3E, &00, &00, &00, &00
	EQUB &00, &00, &00, &20, &10, &08, &04, &08, &10, &20, &00, &00
	EQUB &00, &00, &00, &18, &24, &04, &08, &08, &00, &08, &00, &00
	EQUB &00, &00, &00, &1C, &22, &2E, &2A, &2E, &20, &1C, &00, &00		; &40
	EQUB &00, &00, &00, &08, &14, &22, &22, &3E, &22, &22, &00, &00
	EQUB &00, &00, &00, &3C, &12, &12, &1C, &12, &12, &3C, &00, &00
	EQUB &00, &00, &00, &1C, &22, &20, &20, &20, &22, &1C, &00, &00
	EQUB &00, &00, &00, &3C, &12, &12, &12, &12, &12, &3C, &00, &00
	EQUB &00, &00, &00, &3E, &20, &20, &38, &20, &20, &3E, &00, &00
	EQUB &00, &00, &00, &3E, &20, &20, &3C, &20, &20, &20, &00, &00
	EQUB &00, &00, &00, &1E, &20, &20, &26, &22, &22, &1E, &00, &00
	EQUB &00, &00, &00, &22, &22, &22, &3E, &22, &22, &22, &00, &00
	EQUB &00, &00, &00, &1C, &08, &08, &08, &08, &08, &1C, &00, &00
	EQUB &00, &00, &00, &02, &02, &02, &02, &22, &22, &1C, &00, &00
	EQUB &00, &00, &00, &22, &24, &28, &30, &28, &24, &22, &00, &00
	EQUB &00, &00, &00, &20, &20, &20, &20, &20, &20, &3E, &00, &00
	EQUB &00, &00, &00, &22, &36, &2A, &2A, &22, &22, &22, &00, &00
	EQUB &00, &00, &00, &22, &32, &2A, &26, &22, &22, &22, &00, &00
	EQUB &00, &00, &00, &1C, &22, &22, &22, &22, &22, &1C, &00, &00
	EQUB &00, &00, &00, &3C, &22, &22, &3C, &20, &20, &20, &00, &00		; &50
	EQUB &00, &00, &00, &1C, &22, &22, &22, &2A, &24, &1A, &00, &00
	EQUB &00, &00, &00, &3C, &22, &22, &3C, &28, &24, &22, &00, &00
	EQUB &00, &00, &00, &1C, &22, &10, &08, &04, &22, &1C, &00, &00
	EQUB &00, &00, &00, &3E, &08, &08, &08, &08, &08, &08, &00, &00
	EQUB &00, &00, &00, &22, &22, &22, &22, &22, &22, &1C, &00, &00
	EQUB &00, &00, &00, &22, &22, &22, &22, &14, &14, &08, &00, &00
	EQUB &00, &00, &00, &22, &22, &22, &2A, &2A, &36, &22, &00, &00
	EQUB &00, &00, &00, &22, &22, &14, &08, &14, &22, &22, &00, &00
	EQUB &00, &00, &00, &22, &22, &14, &08, &08, &08, &08, &00, &00
	EQUB &00, &00, &00, &3E, &02, &04, &08, &10, &20, &3E, &00, &00
	EQUB &00, &00, &00, &1C, &10, &10, &10, &10, &10, &1C, &00, &00
	EQUB &00, &00, &00, &20, &20, &10, &08, &04, &02, &02, &00, &00
	EQUB &00, &00, &00, &1C, &04, &04, &04, &04, &04, &1C, &00, &00
	EQUB &00, &00, &00, &08, &14, &22, &00, &00, &00, &00, &00, &00
	EQUB &00, &00, &00, &00, &00, &00, &00, &00, &00, &FF, &00, &00
	EQUB &00, &00, &00, &10, &08, &00, &00, &00, &00, &00, &00, &00		; &60
	EQUB &00, &00, &00, &00, &00, &1C, &02, &3E, &22, &1E, &00, &00
	EQUB &00, &00, &00, &20, &20, &3C, &22, &22, &22, &3C, &00, &00
	EQUB &00, &00, &00, &00, &00, &1C, &20, &20, &20, &1C, &00, &00
	EQUB &00, &00, &00, &02, &02, &0E, &12, &12, &12, &0E, &00, &00
	EQUB &00, &00, &00, &00, &00, &1C, &22, &3E, &20, &1C, &00, &00
	EQUB &00, &00, &00, &1C, &20, &20, &3C, &20, &20, &20, &00, &00
	EQUB &00, &00, &00, &00, &00, &1E, &22, &22, &22, &1E, &02, &1C
	EQUB &00, &00, &00, &20, &20, &3C, &22, &22, &22, &22, &00, &00
	EQUB &00, &00, &00, &08, &00, &18, &08, &08, &08, &1C, &00, &00
	EQUB &00, &00, &00, &00, &04, &00, &04, &04, &04, &04, &14, &08
	EQUB &00, &00, &00, &20, &20, &24, &28, &30, &28, &22, &00, &00
	EQUB &00, &00, &00, &18, &08, &08, &08, &08, &08, &1C, &00, &00
	EQUB &00, &00, &00, &00, &00, &34, &2A, &2A, &2A, &2A, &00, &00
	EQUB &00, &00, &00, &00, &00, &3C, &22, &22, &22, &22, &00, &00
	EQUB &00, &00, &00, &00, &00, &1C, &22, &22, &22, &1C, &00, &00
	EQUB &00, &00, &00, &00, &00, &3C, &22, &22, &22, &3C, &20, &20		; &70
	EQUB &00, &00, &00, &00, &00, &1C, &22, &22, &22, &1E, &02, &02
	EQUB &00, &00, &00, &00, &00, &2C, &32, &20, &20, &20, &00, &00
	EQUB &00, &00, &00, &00, &00, &1C, &20, &1C, &02, &1C, &00, &00
	EQUB &00, &00, &00, &00, &10, &38, &10, &10, &14, &08, &00, &00
	EQUB &00, &00, &00, &00, &00, &22, &22, &22, &22, &1E, &00, &00
	EQUB &00, &00, &00, &00, &00, &22, &22, &14, &14, &08, &00, &00
	EQUB &00, &00, &00, &00, &00, &2A, &2A, &2A, &2A, &14, &00, &00
	EQUB &00, &00, &00, &00, &00, &22, &14, &08, &14, &22, &00, &00
	EQUB &00, &00, &00, &00, &00, &22, &22, &22, &22, &1E, &02, &1C
	EQUB &00, &00, &00, &00, &00, &3E, &04, &08, &10, &3E, &00, &00
	EQUB &00, &00, &00, &04, &08, &08, &10, &08, &08, &04, &00, &00
	EQUB &00, &00, &00, &08, &08, &08, &08, &08, &08, &08, &00, &00
	EQUB &00, &00, &00, &10, &08, &08, &04, &08, &08, &10, &00, &00
	EQUB &00, &00, &00, &00, &00, &0A, &14, &00, &00, &00, &00, &00
	EQUB &00, &00, &00, &3E, &3E, &3E, &3E, &3E, &3E, &3E, &00, &00
ENDIF

align &100

.TextBuffer

.ENDOF



SAVE STARTOFHEADER, ENDOF
