	KernelOsrdch = $fe94
	RDCVEC       = $20a

	Base =? $2800

	BannerScroll =? 1

include "sysvars.asm"

; Some local variables

EndPage = TmpPtr + 2
KeyFlag = TmpPtr + 3

MinChapter = 0		; A
MaxChapter = 6		; G
AGDChapter = 2		; C
ALLChapter = 6		; G

ChapterLineStart = 70	; Y pixel row to strike in Chapter A
ChapterLineWidth = 12	; Y pixels between adjacent text lines

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
	LDX #&2C                ; Test 2C00-3BFF
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

.MenuSplash

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

.MenuMain
IF (BannerScroll = 1)
	JSR &FE66
	LDX #8		; Scroll window starts on line 8
	LDY #52	   	; Scroll window is 52 line high block
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

IF (BannerScroll = 1)

; X = start line
; Y = number of lines

.Scroll
{
	TXA		; bits 7..3 indicate the PAGE
	LSR A		; ADD to
	LSR A
	LSR A
	CLC
	ADC #>ScreenStart
	STA loop2+2
	TXA		; bits 2..0 are the line
	ASL A
	ASL A
	ASL A
	ASL A
	ASL A
	TAX
.loop1
	LDA loop2+2
FOR I, 0, 29
    	STA unroll + I * 3 + 2
NEXT
.loop2
	LDA ScreenStart + &01, X
	ROL A
.unroll
FOR I, 0, 29
	ROL ScreenStart + &1E - I, X
NEXT
	DEY
	BEQ exit
	TXA
	CLC
	ADC #&20
	TAX
	BNE loop2
	INC loop2+2
	JMP loop1
.exit
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

ENDIF

include "common.asm"

.ENDOF

SAVE STARTOFHEADER, ENDOF
