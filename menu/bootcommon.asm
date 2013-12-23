	Base = $3300


	KnownRTS = $ff37
	Oscli = $fff7
	Oswrch = $fff4
	OsWriteString = $f7d1
	OsWriteHex = $f802
	OsCrLf = $ffed
	
	DirectMode = $c2d5
	UpdateTop = $cdbc
	
	OscliBuffer = $100
	DirectModeBuffer = $100
	Stack = $100
	Tmp = $80
	Return = $0d
	
	Top = $0d
	Page = $12
	
	org     Base

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


IF (rom = 1)
	; If this is the ROM Boot Loader, determine check whether there is ROM present...
	
	; Handle Phill's RAMROM board by remapping the RAM at 7000-7FFF to A000
	LDA #1
	STA $BFFE
	
	; Search for the first RAM bank

	LDX #0

.ramSearch
	; Now select ROM0 
	STX $BFFF
	; Now test for RAM at A000
	LDA $A000
	EOR #$FF
	STA $A000
	CMP $A000
	BNE ramNotFound
	EOR #$FF
	STA $A000
	CMP $A000
	BEQ ramFound
	
.ramNotFound
	INX
	CPX #$10
	BNE ramSearch

	JSR OsWriteString	
	EQUS "NO #A000 RAM FOUND", 10, 13	
	NOP
	LDA $FD
	STA $BFFF
	JMP DirectMode		
	
.ramFound	
	
	JSR OsWriteString	
	EQUS "#A000 RAM FOUND AT BANK "	
	NOP
	TXA
	
	ORA #$40
	STA $FD
	STA $BFFF
	
	TXA
	JSR OsWriteHex	
	JSR OsCrLf
	
ENDIF


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

;IF (rom = 1)
;	; Restore the original ROM bank from the shadow
;	LDA $FD
;	STA $BFFF
;ENDIF
	
	JMP DirectMode

.ENDOF
