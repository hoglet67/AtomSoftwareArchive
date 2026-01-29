	KernelOsrdch = $fe94
	RDCVEC       = $20a

	Base =? $2800

include "sysvars.asm"

; Some local variables

EndPage = TmpPtr + 2
KeyFlag = TmpPtr + 3

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

.MeetsMinimum

	; Work around for issue with older versions of AtomMMC on some titles (e.g. SUB HUNT)
	LDA #<KernelOsrdch
	STA RDCVEC
	LDA #>KernelOsrdch
	STA RDCVEC + 1

	LDA #&C0                ; Bit 6 = AGD; Bit 7 = ALL
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
	LDA #&80
	STA KeyFlag             ; Disable AGD chapter
	BNE ChecksDone

.DisableAllChapter
	INC SplashNum
	LDA #0
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
	EQUS "LOAD SPLASH"

.SplashNum
	EQUB '1', Return

	; Visibly strike out the AGD chapter
	; This is a bit of a hack, but saves another SPLASH screen
 	LDA KeyFlag
	CMP #&80            ; All enabled, AGD disabled
	BNE DontStrikeAGD
	LDA #0
	LDY #19
.StrikeAGD
	STA ScreenStart + 32 * 130 + 4, Y
	STA ScreenStart + 32 * 131 + 4, Y
	DEY
	BPL StrikeAGD
.DontStrikeAGD

.MenuMain
	JSR Osrdch
	CMP #&1B
	BEQ MenuExit
	CMP #'A'
	BCC MenuMain
.MenuMaxKey
	CMP #'E' + 1
	BCC MenuNext
	; Check for Shift F (Override checks)
	CMP #'f'
	BEQ MenuNext
	; Check for F (AGD chapter)
	CMP #'F'
	BNE KeyNotF
	BIT KeyFlag
	BVS MenuNext
	LDA #7
	JSR Oswrch
	JMP MenuMain

.KeyNotF
	; Check for G (All chapter)
	CMP #'G'
	BNE KeyNotG
	BIT KeyFlag
	BMI MenuNext
.KeyNotG
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
	; A-H -> Disks 1->N
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

.ENDOF

SAVE STARTOFHEADER, ENDOF
