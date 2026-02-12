.OscliString
	PLA
	STA TmpPtr
	PLA
	STA TmpPtr + 1
	LDX #0
	LDY #0
.OscliString1
	INC TmpPtr
	BNE OscliString2
	INC TmpPtr + 1
.OscliString2
	LDA (TmpPtr),Y
	STA OscliBuffer,X
	INX
	CMP #Return
	BNE OscliString1
	JSR Oscli
	INC TmpPtr
	BNE OscliString3
	INC TmpPtr + 1
.OscliString3
	JMP (TmpPtr)
