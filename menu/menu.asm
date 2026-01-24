	KernelOsrdch = $fe94
	RDCVEC       = $20a

	Base =? $2800

include "sysvars.asm"

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
	; Work around for issue with older versions of AtomMMC on some titles (e.g. SUB HUNT)
	LDA #<KernelOsrdch
	STA RDCVEC
	LDA #>KernelOsrdch
	STA RDCVEC + 1

	; Quick test for memory beyond 0x3C00
	LDY #0
	STY TmpPtr
	LDA #$3C
	STA TmpPtr + 1
.MemWrLoop
	LDA TmpPtr + 1
	EOR #$FF
	STA (TmpPtr),Y
	INC TmpPtr + 1
	BPL MemWrLoop

	LDA #$3C
	STA TmpPtr + 1
.MemRdLoop
	LDA TmpPtr + 1
	EOR #$FF
	CMP (TmpPtr),Y
	BNE MemTestFail
	INC TmpPtr + 1
	BPL MemRdLoop
	BMI MemTestDone

.MemTestFail
	INC SplashNum
	DEC MenuMaxKey + 1

.MemTestDone

IF (econet = 1 OR gosdc = 1)
	JSR OscliString
	EQUS "DIR $.ASA", Return
	;JSR OscliString
	;EQUS "LIB $.ATOMLIB", Return
ELSE
IF (sddos = 0)
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

.MenuMain
	JSR Osrdch
	CMP #'A'
	BCC MenuMain
.MenuMaxKey
	CMP #'G' + 1
	BCC MenuNext
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

.MenuNext

IF (sddos = 1)
	ADC #<(1016 - 'A')
	STA BinBuffer
	LDA #>(1016 - 'A')
	STA BinBuffer + 1
	LDA #'1'
	JSR LoadDisk
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

IF (sddos = 1)

.LoadDisk
	STA LoadDiskString + 4
.LoadDisk0
	LDX #0
.LoadDisk1
	LDA LoadDiskString, X
	BEQ LoadDisk2
	STA OscliBuffer, X
	INX
	BNE LoadDisk1
.LoadDisk2
	JSR WriteDecimal
	LDA #Return
	STA OscliBuffer, X
	INX
	STA OscliBuffer, X
	JMP Oscli

.LoadDiskString
	EQUS "DIN  ,",0

ENDIF

include "common.asm"

.ENDOF

SAVE STARTOFHEADER, ENDOF
