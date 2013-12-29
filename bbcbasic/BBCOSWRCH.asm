
L009E   = $009E
L009F   = $009F
L00A0   = $00A0

L00B3   = $0083
L00B4   = $0084
L00B5   = $0085
L00B6   = $0086
L00B7   = $0087
L00B8   = $0088
L00BA   = $008A
L00BB   = $008B
L00BC   = $008C
L00BD   = $008D
L00BE   = $008E
L00BF   = $008F
L00C0   = $0090
L00C1   = $0091
L00C2   = $0092

L00DE   = $00DE
L00DF   = $00DF
L00E0   = $00E0

L00EB   = $00EB

L0300   = $0300
L0305   = $0305
L0306   = $0306
L0307   = $0307
L0308   = $0308
L0309   = $0309
L030A   = $030A
L030E   = $030E
L030F   = $030F
L0310   = $0310
L0311   = $0311
L0312   = $0312
L0313   = $0313
L0314   = $0314
L0316   = $0316

L032A   = $032A
L032B   = $032B
L032C   = $032C
	
\ ORIGINAL MOS EXTENSION ROM FORMAT
\
\ $C000        = $BE
\ $C001 MERES  = Jump to initialisation routine MOS-EXT
\ $C004 MEMES  = MOS Extension Messages
\ ..
\ $CFFA MEMCLI = Extra *-interpreter
\ $CFFC MEVPOS = POS + VPOS for MOS-EXT VDU
\ $CFFE MEWRCH = MOS Extension Write Character routine

FOLDCASE = 1
MOSEXT1 = &6000
SCREEN = &8000
IO8255_0 = &B000

.OSWRCH
    JMP LF54F

.AtomInit
 LDX #$19
 LDA #$00
.AtomInit1
 STA L0300,X
 DEX
 BPL AtomInit1
 RTS


LFE2B = $fe52
LFFEE = OSWRCH
LFD1D = $fd44

	
.LF1FE
        LDX     #$03
.LF200
        LDA     L030F,X
        STA     L00B3,X
        DEX
        BPL     LF200

        LDA     L030E
        AND     #$04
        BNE     LF222

        LDX     #$02
.LF211
        CLC
        LDA     L00BB,X
        ADC     L00B3,X
        STA     L00BB,X
        LDA     L00BC,X
        ADC     L00B4,X
        STA     L00BC,X
        DEX
        DEX
        BPL     LF211

.LF222
        LDX     #$03
.LF224
        LDA     L00BB,X
        STA     L030F,X
        DEX
        BPL     LF224

        LDA     L030E
        AND     #$03
        BEQ     LF23F

        STA     L00BF
        LDA     L030E
        AND     #$08
        BEQ     LF240

        JSR     LF301

.LF23F
        RTS

.LF240
        LDX     #$02
.LF242
        SEC
        LDA     L00BB,X
        SBC     L00B3,X
        LDY     L00B3,X
        STY     L00BB,X
        STA     L00B3,X
        LDY     L00B4,X
        LDA     L00BC,X
        SBC     L00B4,X
        STY     L00BC,X
        STA     L00B4,X
        STA     L00B7,X
        BPL     LF268

        LDA     #$00
        SEC
        SBC     L00B3,X
        STA     L00B3,X
        LDA     #$00
        SBC     L00B4,X
        STA     L00B4,X
.LF268
        DEX
        DEX
        BPL     LF242

        LDA     L00B5
        CMP     L00B3
        LDA     L00B6
        SBC     L00B4
        BCC     LF2A5

        LDA     #$00
        SBC     L00B5
        STA     L00B8
        LDA     #$00
        SBC     L00B6
        SEC
        ROR     A
        STA     L00BA
        ROR     L00B8
.LF286
        JSR     LF301

        LDA     L00BD
        CMP     L0311
        BNE     LF298

        LDA     L00BE
        CMP     L0312
        BNE     LF298

.LF297
        RTS

.LF298
        JSR     LF2DE

        LDA     L00BA
        BMI     LF286

        JSR     LF2CD

        JMP     LF286

.LF2A5
        LDA     L00B4
        LSR     A
        STA     L00BA
        LDA     L00B3
        ROR     A
        STA     L00B8
.LF2AF
        JSR     LF301

        LDA     L00BB
        CMP     L030F
        BNE     LF2C0

        LDA     L00BC
        CMP     L0310
        BEQ     LF297

.LF2C0
        JSR     LF2CD

        LDA     L00BA
        BPL     LF2AF

        JSR     LF2DE

        JMP     LF2AF

.LF2CD
        SEC
        LDA     L00B8
        SBC     L00B5
        STA     L00B8
        LDA     L00BA
        SBC     L00B6
        STA     L00BA
        LDX     #$00
        BEQ     LF2ED

.LF2DE
        CLC
        LDA     L00B8
        ADC     L00B3
        STA     L00B8
        LDA     L00BA
        ADC     L00B4
        STA     L00BA
        LDX     #$02
.LF2ED
        LDA     L00B7,X
        BPL     LF2FA

        LDA     L00BB,X
        BNE     LF2F7

        DEC     L00BC,X
.LF2F7
        DEC     L00BB,X
.LF2F9
        RTS

.LF2FA
        INC     L00BB,X
        BNE     LF2F9

        INC     L00BC,X
        RTS

.LF301
        JMP     (L0313)

.LF304
        LDY     #$00
        LDA     #$07
        AND     L00B3
        STA     L00B3
        STA     L032A
        LDA     #$07
        SEC
        SBC     L00B3
        BEQ     LF34A

        CMP     #$05
        BMI     LF31C

        LDA     #$04
.LF31C
        LDX     #>SCREEN
        STX     L00B5
        STY     L00B4
        STA     L00B3
        TAX
        LDA     LF357 - 1,X
        TAX
        TYA
.LF32A
        STA     (L00B4),Y
        DEY
        BNE     LF32A

        INC     L00B5
        CPX     L00B5
        BNE     LF32A

        LDY     L00B3
.LF337
        LDA     LF360,Y
        STA     L0314
        LDA     LF35B,Y
        STA     L0313
        LDA     LF365,Y
        STA     IO8255_0
        RTS

.LF34A
        LDA     #$40
.LF34C
        STA     SCREEN,Y
        STA     SCREEN+256,Y
        DEY
        BNE     LF34C

.LF355
        BEQ     LF337

.LF357
        EQUB (>SCREEN) + &04 \ mode 6 = clear 1
        EQUB (>SCREEN) + &06 \ mode 5 = clear 2
        EQUB (>SCREEN) + &0c \ mode 4 = clear 3
        EQUB (>SCREEN) + &18 \ mode 3..0 = clear 4

.LF35B
        EQUB <LF36A
        EQUB <LF3C3
        EQUB <LF3DC
        EQUB <LF3F5
        EQUB <LF432

.LF360
        EQUB >LF36A
        EQUB >LF3C3
        EQUB >LF3DC
        EQUB >LF3F5
        EQUB >LF432

.LF365
        EQUB &00
        EQUB &30
        EQUB &70
        EQUB &B0
        EQUB &F0

 \ mode 7 = clear 0
.LF36A
        LDA     L00BC
        ORA     L00BE
        BNE     LF3C2

        LDA     L00BB
        CMP     #$40
        BCS     LF3C2

        LSR     A
        STA     L00C0
        LDA     #$2F
        SEC
        SBC     L00BD
        CMP     #$30
        BCS     LF3C2

        LDX     #$FF
        SEC
.LF385
        INX
        SBC     #$03
        BCS     LF385

        ADC     #$03
        STA     L00C2
        TXA
        ASL     A
        ASL     A
        ASL     A
        ASL     A
        ASL     A
        ORA     L00C0
        STA     L00C0
        LDA     #>SCREEN
        ADC     #$00
        STA     L00C1
        LDA     L00BB
        LSR     A
        LDA     L00C2
        ROL     A
        TAY
        LDA     LF451 + 2,Y
.LF3A8
        LDY     #$00
        LDX     L00BF
        DEX
        BEQ     LF3BE

        DEX
        BEQ     LF3B9

        EOR     #$FF
        AND     (L00C0),Y
        STA     (L00C0),Y
        RTS

.LF3B9
        EOR     (L00C0),Y
        STA     (L00C0),Y
        RTS

.LF3BE
        ORA     (L00C0),Y
        STA     (L00C0),Y
.LF3C2
        RTS

.LF3C3
        LDA     L00BC
        ORA     L00BE
        BNE     LF3C2

        LDA     L00BB
        BMI     LF3C2

        LSR     A
        LSR     A
        LSR     A
        STA     L00C0
        LDA     #$3F
        SEC
        SBC     L00BD
        CMP     #$40
        BCC     LF40D

        RTS

.LF3DC
        LDA     L00BC
        ORA     L00BE
        BNE     LF3C2

        LDA     L00BB
        BMI     LF3C2

        LSR     A
        LSR     A
        LSR     A
        STA     L00C0
        LDA     #$5F
        SEC
        SBC     L00BD
        CMP     #$60
        BCC     LF40D

.LF3F4
        RTS

.LF3F5
        LDA     L00BC
        ORA     L00BE
        BNE     LF3C2

        LDA     L00BB
        BMI     LF3C2

        LSR     A
        LSR     A
        LSR     A
        STA     L00C0
        LDA     #$BF
        SEC
        SBC     L00BD
        CMP     #$C0
        BCS     LF3C2

.LF40D
        LDY     #$00
        STY     L00C1
.LF411
        ASL     A
        ROL     L00C1
        ASL     A
        ROL     L00C1
        ASL     A
        ROL     L00C1
        ASL     A
        ROL     L00C1
        ADC     L00C0
        STA     L00C0
        LDA     L00C1
        ADC     #>SCREEN
        STA     L00C1
        LDA     L00BB
        AND     #$07
        TAY
        LDA     LF451,Y
        JMP     LF3A8

.LF432
        LDA     L00BC
        ORA     L00BE
        BNE     LF3F4

        LDA     L00BB
        LSR     A
        LSR     A
        LSR     A
        STA     L00C0
        LDA     #$BF
        SEC
        SBC     L00BD
        CMP     #$C0
        BCS     LF3F4

        LDY     #$00
        STY     L00C1
        ASL     A
        ROL     L00C1
        BPL     LF411

.LF451
        EQUB    $80, $40, $20,$10,$08,$04,$02,$01

.LF483
        PHA
        LDA     MOSEXT1
        CMP     #$BE
        BEQ     LF48F

        PLA
        JMP     LFE2B

.LF48F
        PLA
        JMP     (MOSEXT1 + &FFE)

.LF50D
        LDA     MOSEXT1
        CMP     #$BE
        BEQ     LF517

        JMP     LF791

.LF517
        LDY     L0306
        JSR     LF529

        LDY     L0307
        JSR     LF526

        JMP     LF57D

.LF526
        LDA     #$0D

\ TODO: UNDERSTAND THIS

        EQUB    $2C
.LF529
        LDA     #$1E
        JSR     LFFEE

        AND     #$0B
.LF530
        DEY
        BMI     LF538

        JSR     LFFEE

        BPL     LF530

.LF538
        RTS

.LF54F
        STY     L00A0
        STX     L009F
        STA     L009E
        LDX     L0316
        BEQ     LF584

        STA     L0305,X
        DEX
        STX     L0316
        BNE     LF57D

        LDA     L0305
        CMP     #$16
        BEQ     LF5B0

        CMP     #$19
        BEQ     LF574

        CMP     #$1F
        BEQ     LF50D

        BNE     LF57D

.LF574
        JMP     LF614

.LF577
        STX     L0316
        STA     L0305
.LF57D
        LDY     L00A0
        LDX     L009F
        LDA     L009E
        RTS

.LF584
        LDX     #$01
        CMP     #$16
        BEQ     LF577

        INX
        CMP     #$1F
        BEQ     LF577

        LDX     #$05
        CMP     #$19
        BEQ     LF577

        CMP     #$10
        BEQ     LF5AA

        JSR     LF57D

        CMP     #$61
        BMI     LF5A7

        CMP     #$7B
        BPL     LF5A7

        SEC
        SBC     L00EB
.LF5A7
        JMP     LF483

.LF5AA
        LDA     L032A
        STA     L0306
.LF5B0
        JSR     LF57D

        PHA
        TYA
        PHA
        TXA
        PHA
        LDA     L0306
        PHA
        LDY     #$06
.LF5BE
        LDA     LF5D3,Y
        JSR     LFFEE

        DEY
        BPL     LF5BE

        PLA
        STA     L00B3
        JSR     LF304

        PLA
        TAX
        PLA
        TAY
        PLA
        RTS

.LF5D3
        EQUB    $00

.LF5D4
        EQUB    $00,$00,$00,$04,$19,$1E

.LF614
        LDA     L030A
        CMP     #$40
        BCC     LF61D

        SBC     #$38
.LF61D
        AND     #$1F
        STA     L030E
        LDA     #$00
        STA     L032B
        LDA     L0308
        BPL     LF636

        LDX     #$03
        JSR     LF6FA

        LDA     #$FF
        STA     L032B
.LF636
        LDA     #$00
        STA     L00BB
        STA     L00BC
        LDA     L0309
.LF63F
        SEC
        SBC     #$05
        BCS     LF649

        DEC     L0308
        BMI     LF651

.LF649
        INC     L00BB
        BNE     LF63F

        INC     L00BC
        BNE     LF63F

.LF651
        LDA     IO8255_0
        AND     #$F0
        CMP     #$F0
        BEQ     LF666

        CMP     #$20
        BCS     LF662

        LSR     L00BC
        ROR     L00BB
.LF662
        LSR     L00BC
        ROR     L00BB
.LF666
        LDA     L032B
        BPL     LF670

        LDX     #$08
        JSR     LF70C

.LF670
        LDA     #$00
        STA     L032C
        LDA     L0306
        BPL     LF684

        LDX     #$01
        JSR     LF6FA

        LDA     #$FF
        STA     L032C
.LF684
        LDA     IO8255_0
        AND     #$F0
        CMP     #$10
        BEQ     LF695

        CMP     #$30
        BEQ     LF695

        CMP     #$50
        BNE     LF6AA

.LF695
        LDA     L0307
        STA     L00BD
        LDA     L0306
        STA     L00BE
        LSR     L00BE
        ROR     L00BD
        LSR     L00BE
        ROR     L00BD
        JMP     LF6E2

.LF6AA
        LDA     L0307
        ASL     A
        STA     L00BD
        LDA     L0306
        ROL     A
        STA     L00BE
        CLC
        LDA     L00BD
        ADC     L0307
        STA     L00BD
        LDA     L00BE
        ADC     L0306
        STA     L00BE
        LSR     L00BE
        ROR     L00BD
        LSR     L00BE
        ROR     L00BD
        LSR     L00BE
        ROR     L00BD
        LSR     L00BE
        ROR     L00BD
        LDA     IO8255_0
        AND     #$F0
        CMP     #$A0
        BCS     LF6EA

        CMP     #$00
        BNE     LF6E6

.LF6E2
        LSR     L00BE
        ROR     L00BD
.LF6E6
        LSR     L00BE
        ROR     L00BD
.LF6EA
        LDA     L032C
        BPL     LF6F4

        LDX     #$0A
        JSR     LF70C

.LF6F4
        JSR     LF1FE

        JMP     LF57D

.LF6FA
        SEC
        LDA     #$00
        SBC     L0306,X
        STA     L0306,X
        LDA     #$00
        SBC     L0305,X
        STA     L0305,X
        RTS

.LF70C
        SEC
        LDA     #$00
        SBC     L00B3,X
        STA     L00B3,X
        LDA     #$00
        SBC     L00B4,X
        STA     L00B4,X
        RTS

.LF791
        LDX     L0307
        CPX     #$20
        BCS     LF7B6

        LDA     L0306
        CMP     #$10
        BCS     LF7B6

        LDY     L00E0
        JSR     LFD1D

        STX     L00E0
        LSR     L00DF
        ASL     A
        ASL     A
        ASL     A
        ASL     A
        ASL     A
        STA     L00DE
        ROL     L00DF
        LDY     L00E0
        JSR     LFD1D

.LF7B6
        JMP     LF57D
