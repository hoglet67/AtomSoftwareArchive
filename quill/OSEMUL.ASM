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

.LFFE7
.OSNEWL
        JMP     $FFED

.LFFEE
.OSWRCH
	PHA
IF  UpperCaseOnly
	JSR TOUPPER
ENDIF
	JSR	$FFF4
	PLA
	CLC
	RTS

.TOUPPER
	CMP #'a'
	BCC TOUPPER1
	CMP #'z' + 1
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


; A=0 READ LINE
; A=1 READ SYSTEM CLOCK
; A=7 SOUND

.LFFF1
.OSWORD
        CMP #$00
        BEQ READLINE
        CMP #$01
        BEQ READCLOCK
        CMP #$07
        BEQ BEEP
        RTS

.READLINE
	LDA #$00
	JSR $CD0F
	TYA
	PHA
.READLINE1
	LDA $100,Y
	STA $600,Y
	DEY
	BPL READLINE1
	PLA
	TAY
	CLC
	RTS

.READCLOCK
        RTS

.BEEP
        LDA #$07
        JSR OSWRCH
        JSR OSWRCH
        JSR OSWRCH
        RTS


; A=04 Enable/Disable Cursor Editing
; A=0C Set keyboard auto repeat rate
; A=0F Flush selected buffer type
; A=15 Flush specific buffer
; A=86 Read Text Cursor Position
; A=F7 Read/Write first byte of break intercept code
; A=FD Read/Write last break type

.LFFF4
.OSBYTE
	CMP #$86
        BNE OSBYTERTS

.READCURSOR
        LDX $E0
        LDY #$00

.OSBYTERTS
	RTS


.LFFF7
.OSCLI

      STX $80
      STY $81
      LDY #$00
.OSCLI1
       LDA ($80),Y
       STA $100,Y
       CMP #$0D
       BEQ OSCLI2
       INY
       BNE OSCLI1
.OSCLI2
       JMP $FFF7


.MyRDCH
	LDA $B000
        AND #$F0
	STA $B000
	JSR $FE94
	CMP #$1B
	BNE NotEscape
	LDA #$20
.NotEscape
	PHA
	LDA $B000
        AND #$F0
	ORA #$0A
	STA $B000
	PLA
	RTS

.InitOsEmul
	LDA #<MyRDCH
	STA $020A
	LDA #>MyRDCH
	STA $020B
	JMP NotEscape


