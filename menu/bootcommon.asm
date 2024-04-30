	Base = $3300


	Oscli = $fff7
	Oswrch = $fff4
	OsWriteString = $f7d1
	OsWriteHex = $f802
	OsCrLf = $ffed

	DirectModeExit = $c2cf
	DirectMode = $c2d5
	UpdateTop = $cdbc

	OscliBuffer = $100
	DirectModeBuffer = $100
	Stack = $100
	Tmp = $80
	RomSrc = $82
	RomDst = $84
	Return = $0d

	Top = $0d
	Page = $12

	; TODO somehow determine this dynamically
	ShadowL1 = $FD
	ShadowL2 = $23F

	org     Base

.STARTOF

	; Determine where the boot loader is running from
	SEI
	; John Kortinkt asked for a tweak to support his Atom version of GoSDC
	; (KnownRTS was $ff37 but John has changed this in his GoSDC Kernal ROM)
	; JSR KnownRTS
	LDA #$60 ; RTS
	STA Tmp
.MYJSR
	JSR Tmp
	TSX
	DEX
	CLC
	LDA Stack,X
	ADC #<(ENDOF - MYJSR - 2)
	STA Tmp
	LDA Stack + 1,X
	ADC #>(ENDOF - MYJSR - 2)
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
	CMP #$04
	BEQ CmdDirect

IF (rom = 1)
	CMP #$05
	BEQ CmdPrint
	CMP #$06
	BEQ CmdRomCopy
ENDIF

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

IF (rom = 1)
.CmdPrint
	INY
.CmdPrintLoop
	LDA (Tmp),Y
	BEQ CmdPrintDone
	JSR Oswrch
	INY
	BNE CmdPrintLoop
.CmdPrintDone
	INY
	BNE ProcessNextCommand
ENDIF

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

.CmdDirect
	LDX #0
	INY
.CmdDirectLoop
	LDA (Tmp),Y
	STA DirectModeBuffer,X
	INY
	INX
	CMP #Return
	BNE CmdDirectLoop
	JMP DirectMode

IF (rom = 1)

.CmdRomCopy

	; Handle Phill's RAMROM board by remapping the RAM at 7000-7FFF to A000
	LDA #1
	STA $BFFE

	; Save the old ROM Latch Shadow Register
	LDA ShadowL1
	PHA

	; Search for the first RAM bank
	LDX #0

.RamSearch
	; Now select ROM0
	STX $BFFF
	STA ShadowL1
	STA ShadowL2
	; Now test for RAM at A000
	LDA $A000
	EOR #$FF
	STA $A000
	CMP $A000
	BNE RamNotFound
	EOR #$FF
	STA $A000
	CMP $A000
	BEQ RamFound

.RamNotFound
	INX
	CPX #$10
	BNE RamSearch

	JSR OsWriteString
	EQUS "NO RAM BANKS FOUND AT #A000", 10, 13
	NOP

	PLA
	STA ShadowL1
	STA ShadowL2
	STA $BFFF

	JMP DirectModeExit

.RamFound

	; Discard saved ROM Latch Value
	PLA

	JSR OsWriteString
	EQUS "RAM FOUND AT #A000 BANK "
	NOP
	TXA

	PHA
	JSR OsWriteHex
	JSR OsCrLf
	PLA

	; Switch to the new bank and lock it
	ORA #$40
	STA ShadowL1
	STA ShadowL2
	STA $BFFF

	LDX #$10
	LDY #$00
	STY RomSrc
	LDA #$88
	STA RomSrc + 1
	STY RomDst
	LDA #$A0
	STA RomDst + 1
.RamCopy
	LDA (RomSrc),Y
	STA (RomDst),Y
	INY
	BNE RamCopy
	INC RomSrc + 1
	INC RomDst + 1
	DEX
	BNE RamCopy

	JSR OsWriteString
	EQUS "ROM COPIED TO #A000", 10, 13
	NOP


	LDX #$10
	LDY #$00
	STY RomSrc
	LDA #$88
	STA RomSrc + 1
	STY RomDst
	LDA #$A0
	STA RomDst + 1
.RamVerify
	LDA (RomSrc),Y
	CMP (RomDst),Y
	BNE RamVerifyFailed
	INY
	BNE RamVerify
	INC RomSrc + 1
	INC RomDst + 1
	DEX
	BNE RamVerify

	JSR OsWriteString
	EQUS "ROM VERIFY AT #A000 SUCCEEDED", 10, 13
	NOP

	JMP DirectModeExit

.RamVerifyFailed

	JSR OsWriteString
	EQUS "ROM VERIFY AT #A000 FAILED", 10, 13
	NOP

	JMP DirectModeExit

ENDIF


.ENDOF
