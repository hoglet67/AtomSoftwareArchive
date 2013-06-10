.LFFE3
.OSASCI
	PHA
IF  UpperCaseOnly
	JSR TOUPPER
ENDIF
	JSR	$FFE9
	PLA
	CLC
	RTS

.LFFEE
.OSWRCH
	PHA
IF  UpperCaseOnly
	JSR TOUPPER
ENDIF
	JSR	$FE55
	PLA
	CLC
	RTS

.TOUPPER
	CMP #'a' - 1
	BCC TOUPPER1
	CMP #'z'
	BCS TOUPPER1
	AND	#$DF	
.TOUPPER1
	RTS

.LFFE0
.OSRDCH
	JSR $FFE3
	CMP #$1B
	BEQ ESCAPE
	CLC
	RTS
.ESCAPE
	SEC
	RTS
	
.LFFF1
.READLINE
	LDA #$00
	JSR $CD0F
	TYA
	PHA
.READLINE1
	LDA $100,Y
	STA $0,Y
	DEY
	BPL READLINE1
	PLA
	TAY
	CLC
	RTS
	
.LFFF4
.OSBYTE
	CMP #$91
	BNE OSBYTERTS
	JSR OSRDCH
	TAY
	CLC
.OSBYTERTS
	RTS
	
.LFFF7
.OSCLI
	RTS
	
.LFFDD
.OSFILE
	PHA
	STX     $A0
	STY     $A1
	
;   Filename is at offset 0
	LDY     #$00
	LDA     ($A0),Y
	STA     $A2
	INY
	LDA     ($A0),Y
	STA     $A3
	DEY
.OSFILE1
	LDA     ($A2),Y
	STA     $140,Y
	INY
	CMP	    #$0D
	BNE     OSFILE1
	LDA     #$40
	STA     $A4
	LDA     #$01
	STA     $A5

; 	Load Address is at offset $02 on the BBC
	
	LDY     #$02
	LDA     ($A0),Y
	STA     $A6
	INY
	LDA     ($A0),Y
	STA     $A7
	
; 	Exec Address is at offset $06 on the BBC
	LDY     #$06
	LDA     ($A0),Y
	STA     $A8
	INY
	LDA     ($A0),Y
	STA     $A9

; 	Start Address is at offset $0A on the BBC
	LDY     #$0A
	LDA     ($A0),Y
	STA     $AA
	INY
	LDA     ($A0),Y
	STA     $AB

; 	End Address is at offset $0E on the BBC
	LDY     #$0E
	LDA     ($A0),Y
	STA     $AC
	INY
	LDA     ($A0),Y
	STA     $AD

	LDX     #$A4
	LDY     #$00
	PLA
	BEQ     OSFILE2
	SEC
	JSR	    $FFE0
	LDA 	#$01
	RTS
.OSFILE2
	SEC
	JSR     $FFDD
	LDA 	#$01
	RTS
