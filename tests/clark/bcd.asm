; Verify decimal mode behavior
;
; Returns:
;   ERROR = 0 if the test passed
;   ERROR = 1 if the test failed
;
; This routine requires 17 bytes of RAM -- 1 byte each for:
;   AR, CF, DA, DNVZC, ERROR, HA, HNVZC, N1, N1H, N1L, N2, N2L, NF, VF, and ZF
; and 2 bytes for N2H
;
; Variables:
;   N1 and N2 are the two numbers to be added or subtracted
;   N1H, N1L, N2H, and N2L are the upper 4 bits and lower 4 bits of N1 and N2
;   DA and DNVZC are the actual accumulator and flag results in decimal mode
;   HA and HNVZC are the accumulator and flag results when N1 and N2 are
;     added or subtracted using binary arithmetic
;   AR, NF, VF, ZF, and CF are the predicted decimal mode accumulator and
;     flag results, calculated using binary arithmetic
;
; This program takes approximately 1 minute at 1 MHz (a few seconds more on
; a 65C02 than a 6502 or 65816)
;

CPU 1

TARGET_ATOM = 0
TARGET_BEEB = 1
	
TARGET = TARGET_BEEB

LOAD = $2900
	
AR    = $80
CF    = $81
DA    = $82
DNVZC = $83
ERROR = $84
HA    = $85
HNVZC = $86
N1    = $87
N1H   = $88
N1L   = $89
N2    = $8A
N2L   = $8B
NF    = $8C
VF    = $8D
ZF    = $8E
N2H   = $8F
TMP   = $91
AVEC  = $93
SVEC  = $95	

if (TARGET = TARGET_ATOM)

OSWRCH = $FFF4

        org    LOAD - 22
        
.TESTSTART

        EQUS    "BCDTEST"

        org TESTSTART + 16

        EQUW	TEST
        EQUW    TEST
        EQUW	TESTEND - TEST

ELSE

OSWRCH = $FFEE

        org    LOAD

.TESTSTART
	
ENDIF
	
	
.TEST
	LDA #0
	INC A
	CMP #1
	BCC NMOS

.CMOS
	JSR STROUT
	EQUS "DETECTED CMOS 65C02...", 10, 13
	NOP
	LDA #<A65C02
	STA AVEC
	LDA #>A65C02
	STA AVEC + 1
	LDA #<S65C02
	STA SVEC
	LDA #>S65C02
	STA SVEC + 1
	JMP TEST1

.NMOS
	JSR STROUT
	EQUS "DETECTED NMOS 6502...", 10, 13
	NOP	
	LDA #<A6502
	STA AVEC
	LDA #>A6502
	STA AVEC + 1
	LDA #<S6502
	STA SVEC
	LDA #>S6502
	STA SVEC + 1

.TEST1	
	JSR STROUT
	EQUS "TESTING ADC...", 10, 13
	NOP
	LDY #1    ; initialize Y (used to loop through carry flag values)
        STY ERROR ; store 1 in ERROR until the test passes
	LDA #0    ; initialize N1 and N2
        STA N1
        STA N2
.ALOOP1 LDA N2    ; N2L = N2 & $0F
        AND #$0F  ; [1] see text
        STA N2L
        LDA N2    ; N2H = N2 & $F0
        AND #$F0  ; [2] see text
        STA N2H
        ORA #$0F  ; N2H+1 = (N2 & $F0) + $0F
        STA N2H+1
.ALOOP2 LDA N1    ; N1L = N1 & $0F
        AND #$0F  ; [3] see text
        STA N1L
        LDA N1    ; N1H = N1 & $F0
        AND #$F0  ; [4] see text
        STA N1H
        JSR ADD
        JSR ADDVEC
        JSR COMPARE
        BNE DONE
        INC N1    ; [5] see text
        BNE ALOOP2 ; loop through all 256 values of N1
        INC N2    ; [6] see text
        BNE ALOOP1 ; loop through all 256 values of N2
        DEY
        BPL ALOOP1 ; loop through both values of the carry flag

	JSR STROUT
	EQUS "TESTING SBC...", 10, 13
	NOP
	LDY #1    ; initialize Y (used to loop through carry flag values)
        STY ERROR ; store 1 in ERROR until the test passes
	LDA #0    ; initialize N1 and N2
        STA N1
        STA N2
.SLOOP1 LDA N2    ; N2L = N2 & $0F
        AND #$0F  ; [1] see text
        STA N2L
        LDA N2    ; N2H = N2 & $F0
        AND #$F0  ; [2] see text
        STA N2H
        ORA #$0F  ; N2H+1 = (N2 & $F0) + $0F
        STA N2H+1
.SLOOP2 LDA N1    ; N1L = N1 & $0F
        AND #$0F  ; [3] see text
        STA N1L
        LDA N1    ; N1H = N1 & $F0
        AND #$F0  ; [4] see text
        STA N1H
        JSR SUB
        JSR SUBVEC
        JSR COMPARE
        BNE DONE
        INC N1    ; [5] see text
        BNE SLOOP2 ; loop through all 256 values of N1
        INC N2    ; [6] see text
        BNE SLOOP1 ; loop through all 256 values of N2
        DEY
        BPL SLOOP1 ; loop through both values of the carry flag
	
        LDA #0    ; test passed, so store 0 in ERROR
        STA ERROR

.DONE
	LDA ERROR
	BNE FAIL
	JSR STROUT
	EQUS "PASSED", 13, 10
	NOP
	RTS
.FAIL	TYA
	PHA
	JSR STROUT
	EQUS "INPUTS:", 10, 13, "     ACC = "
 	NOP
	LDA N1
	JSR HEXOUT
	JSR STROUT
	EQUS 10, 13, " OPERAND = "
 	NOP
	LDA N2
	JSR HEXOUT
	JSR STROUT
	EQUS 10, 13, "CARRY IN = "
	NOP
	PLA
	JSR HEXOUT
	JSR STROUT
	EQUS 10, 13
	NOP
	RTS

; Calculate the actual decimal mode accumulator and flags, the accumulator
; and flag results when N1 is added to N2 using binary arithmetic, the
; predicted accumulator result, the predicted carry flag, and the predicted
; V flag
;
.ADD     SED       ; decimal mode
        CPY #1    ; set carry if Y = 1, clear carry if Y = 0
        LDA N1
        ADC N2
        STA DA    ; actual accumulator result in decimal mode
        PHP
        PLA
        STA DNVZC ; actual flags result in decimal mode
        CLD       ; binary mode
        CPY #1    ; set carry if Y = 1, clear carry if Y = 0
        LDA N1
        ADC N2
        STA HA    ; accumulator result of N1+N2 using binary arithmetic

        PHP
        PLA
        STA HNVZC ; flags result of N1+N2 using binary arithmetic
        CPY #1
        LDA N1L
        ADC N2L
        CMP #$0A
        LDX #0
        BCC A1
        INX
        ADC #5    ; add 6 (carry is set)
        AND #$0F
        SEC
.A1      ORA N1H
;
; if N1L + N2L <  $0A, then add N2 & $F0
; if N1L + N2L >= $0A, then add (N2 & $F0) + $0F + 1 (carry is set)
;
        ADC N2H,X
        PHP
        BCS A2
        CMP #$A0
        BCC A3
.A2      ADC #$5F  ; add $60 (carry is set)
        SEC
.A3      STA AR    ; predicted accumulator result
        PHP
        PLA
        STA CF    ; predicted carry result
        PLA
;
; note that all 8 bits of the P register are stored in VF
;
        STA VF    ; predicted V flags
        RTS

; Calculate the actual decimal mode accumulator and flags, and the
; accumulator and flag results when N2 is subtracted from N1 using binary
; arithmetic
;
.SUB     SED       ; decimal mode
        CPY #1    ; set carry if Y = 1, clear carry if Y = 0
        LDA N1
        SBC N2
        STA DA    ; actual accumulator result in decimal mode
        PHP
        PLA
        STA DNVZC ; actual flags result in decimal mode
        CLD       ; binary mode
        CPY #1    ; set carry if Y = 1, clear carry if Y = 0
        LDA N1
        SBC N2
        STA HA    ; accumulator result of N1-N2 using binary arithmetic

        PHP
        PLA
        STA HNVZC ; flags result of N1-N2 using binary arithmetic
        RTS

; Calculate the predicted SBC accumulator result for the 6502 and 65816

;
.SUB1    CPY #1    ; set carry if Y = 1, clear carry if Y = 0
        LDA N1L
        SBC N2L
        LDX #0
        BCS S11
        INX
        SBC #5    ; subtract 6 (carry is clear)
        AND #$0F
        CLC
.S11     ORA N1H
;
; if N1L - N2L >= 0, then subtract N2 & $F0
; if N1L - N2L <  0, then subtract (N2 & $F0) + $0F + 1 (carry is clear)
;
        SBC N2H,X
        BCS S12
        SBC #$5F  ; subtract $60 (carry is clear)
.S12     STA AR
        RTS

; Calculate the predicted SBC accumulator result for the 6502 and 65C02

;
.SUB2    CPY #1    ; set carry if Y = 1, clear carry if Y = 0
        LDA N1L
        SBC N2L
        LDX #0
        BCS S21
        INX
        AND #$0F
        CLC
.S21     ORA N1H
;
; if N1L - N2L >= 0, then subtract N2 & $F0
; if N1L - N2L <  0, then subtract (N2 & $F0) + $0F + 1 (carry is clear)
;
        SBC N2H,X
        BCS S22
        SBC #$5F   ; subtract $60 (carry is clear)
.S22     CPX #0
        BEQ S23
        SBC #6
.S23     STA AR     ; predicted accumulator result
        RTS

; Compare accumulator actual results to predicted results
;
; Return:
;   Z flag = 1 (BEQ branch) if same
;   Z flag = 0 (BNE branch) if different
;
.COMPARE LDA DA
        CMP AR
        BEQ C1

	JSR STROUT
	EQUS "ACCUMULATOR CHECK FAILED", 10, 13, "EXPECTED: "
	NOP
	LDA AR
	JSR HEXOUT
	JSR STROUT
	EQUS "; ACTUAL: "
	NOP
	LDA DA
	JSR HEXOUT
	JSR STROUT
	EQUS 10,13
	NOP
	LDA #1
	RTS

.C1     LDA DNVZC ; [7] see text
        EOR NF
        AND #$80  ; mask off N flag
        BEQ C2

	JSR STROUT
	EQUS "N FAILED", 10, 13, "EXPECTED: "
	NOP
	LDA NF
	AND #$80
	JSR HEXOUT
	JSR STROUT
	EQUS "; ACTUAL: "
	NOP
	LDA DNVZC
	AND #$80
	JSR HEXOUT
	JSR STROUT
	EQUS 10,13
	NOP
	LDA #1
	RTS


.C2     LDA DNVZC ; [8] see text
        EOR VF
        AND #$40  ; mask off V flag
        BEQ C3    ; [9] see text
	
	JSR STROUT
	EQUS "V FAILED", 10, 13, "EXPECTED: "
	NOP
	LDA VF
	AND #$40
	JSR HEXOUT
	JSR STROUT
	EQUS "; ACTUAL: "
	NOP
	LDA DNVZC
	AND #$40
	JSR HEXOUT
	JSR STROUT
	EQUS 10,13
	NOP
	LDA #1
	RTS

.C3     LDA DNVZC
        EOR ZF    ; mask off Z flag
        AND #2
        BEQ C4    ; [10] see text

	JSR STROUT
	EQUS "Z FAILED", 10, 13, "EXPECTED: "
	NOP
	LDA ZF
	AND #2
	JSR HEXOUT
	JSR STROUT
	EQUS "; ACTUAL: "
	NOP
	LDA DNVZC
	AND #2
	JSR HEXOUT
	JSR STROUT
	EQUS 10,13
	NOP
	LDA #1
	RTS

.C4     LDA DNVZC
        EOR CF
        AND #1    ; mask off C flag
	BEQ C5

	JSR STROUT
	EQUS "C FAILED", 10, 13, "EXPECTED: "
	NOP
	LDA CF
	AND #1
	JSR HEXOUT
	JSR STROUT
	EQUS "; ACTUAL: "
	NOP
	LDA DNVZC
	AND #1
	JSR HEXOUT
	JSR STROUT
	EQUS 10,13
	NOP
	LDA #1
.C5	RTS


.ADDVEC
	JMP (AVEC)

.SUBVEC
	JMP (SVEC)
	
; These routines store the predicted values for ADC and SBC for the 6502,
; 65C02, and 65816 in AR, CF, NF, VF, and ZF

.A6502   LDA VF
;
; since all 8 bits of the P register were stored in VF, bit 7 of VF contains
; the N flag for NF
;
        STA NF
        LDA HNVZC
        STA ZF
        RTS

.S6502   JSR SUB1
        LDA HNVZC
        STA NF
        STA VF
        STA ZF
        STA CF
        RTS

.A65C02  LDA AR
        PHP
        PLA
        STA NF
        STA ZF
        RTS

.S65C02  JSR SUB2
        LDA AR
        PHP
        PLA
        STA NF
        STA ZF
        LDA HNVZC
        STA VF
        STA CF
        RTS

.A65816  LDA AR
        PHP
        PLA
        STA NF
        STA ZF
        RTS

.S65816  JSR SUB1
        LDA AR
        PHP
        PLA
        STA NF
        STA ZF
        LDA HNVZC
        STA VF
        STA CF
        RTS

.HEXOUT
	PHA
	LSR A
	LSR A
	LSR A
	LSR A
	JSR HEXOUT1
	PLA
.HEXOUT1
	AND #$0F
	CMP #$0A
	BCC HEXOUT2
	ADC #$06
.HEXOUT2
	ADC #$30
	JMP OSWRCH
	
.STROUT
	PLA
	STA TMP
	PLA
	STA TMP + 1
.STROUT1
	LDY #$00
	INC TMP
	BNE STROUT2
	INC TMP+1
.STROUT2
	LDA (TMP), Y
	BMI STROUT3
	JSR OSWRCH
	JMP STROUT1
.STROUT3
	JMP (TMP)
	
.TESTEND

SAVE "BCDTEST",TESTSTART,TESTEND
