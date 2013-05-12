	Base = $3300


	KnownRTS = $ff37
	Oscli = $fff7
	DirectMode = $c2d5
	UpdateTop = $cdbc
	
	OscliBuffer = $100
	DirectModeBuffer = $100
	Stack = $100
	Tmp = $80
	Return = $0d
	
	Top = $0d
	Page = $12
	
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

	; Determine where the boot loader is running from
	SEI
	JSR KnownRTS
	TSX
	DEX
	CLC
	LDA Stack,X
	ADC #<(ENDOF - STARTOF - 3)
	STA Tmp
	LDA Stack + 1,X
	ADC #>(ENDOF - STARTOF - 3)
	STA Tmp + 1
	CLI
	; Tmp,Tmp + 1 now Contain the address of the command block following the boot loader

	LDY #$0
.ProcessNextCommand
	; READ NEXT CMD
	LDA (Tmp),Y
	BEQ CmdUpdateTopThenRun
	CMP #$01
	BEQ CmdRun
	CMP #$02
	BEQ CmdReturn
	CMP #$03
	BEQ CmdPage

	; Implement the default command: Pass to Oscli

.CmdDefault	
	LDX #$0
.CopyOscliLoop
	LDA (Tmp),Y
	STA OscliBuffer,X
	INY
	INX
	CMP #Return
	BNE CopyOscliLoop
	
	; Work around for the SYN? 135 error in AtomMMC
	STA OscliBuffer,X
	
	; Call Oscli, preserving Y
	TYA
	PHA
	JSR Oscli
	PLA
	TAY
	BNE ProcessNextCommand

	; Implement Command 03: Set Page (?18=XX)

.CmdPage
	INY
	LDA (Tmp),Y
	STA Page
	INY
	BNE ProcessNextCommand

	; Implement Command 02: Return

.CmdReturn
	RTS

	; Implement Command 00: Update TOP then RUN

.CmdUpdateTopThenRun
	LDA Page
	STA Top + 1
	LDY #$0
	STY Top
	DEY

.CmdUpdateTopThenRun1
	INY
	LDA (Top),Y
	CMP #Return
	BNE CmdUpdateTopThenRun1
	JSR UpdateTop
	LDA (Top),Y
	BMI CmdUpdateTopThenRun2
	INY
	BNE CmdUpdateTopThenRun1

.CmdUpdateTopThenRun2
	INY
	JSR UpdateTop

.CmdRun
	; CMP 01: RUN
	LDA #'R'
	STA DirectModeBuffer
	LDA #'U'
	STA DirectModeBuffer + 1
	LDA #'N'
	STA DirectModeBuffer + 2
	LDA #Return
	STA DirectModeBuffer + 3
	JMP DirectMode

.ENDOF


SAVE "BOOT",STARTOFHEADER, ENDOF