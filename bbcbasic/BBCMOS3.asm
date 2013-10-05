L0000   = $0000
L0001   = $0001
L0002   = $0002
L0003   = $0003
L009E   = $009E
L009F   = $009F
L00A0   = $00A0
L00A1   = $00A1
L00A2   = $00A2
L00A3   = $00A3
L00A4   = $00A4
L00A6   = $00A6
L00A7   = $00A7
L00A8   = $00A8
L00A9   = $00A9
L00AD   = $00AD
L00AE   = $00AE
L00AF   = $00AF
L00B0   = $00B0
L00B1   = $00B1
L00B2   = $00B2
L00B3   = $00B3
L00B4   = $00B4
L00B5   = $00B5
L00B6   = $00B6
L00B7   = $00B7
L00B8   = $00B8
L00BA   = $00BA
L00BB   = $00BB
L00BC   = $00BC
L00BD   = $00BD
L00BE   = $00BE
L00BF   = $00BF
L00C0   = $00C0
L00C1   = $00C1
L00C2   = $00C2
L00C3   = $00C3
L00C4   = $00C4
L00C5   = $00C5
L00C6   = $00C6
L00C7   = $00C7
L00C8   = $00C8
L00C9   = $00C9
L00CA   = $00CA
L00CB   = $00CB
L00CC   = $00CC
L00CD   = $00CD
L00CE   = $00CE
L00CF   = $00CF
L00D0   = $00D0
L00D1   = $00D1
L00D2   = $00D2
L00D3   = $00D3
L00D4   = $00D4
L00D5   = $00D5
L00D6   = $00D6
L00D8   = $00D8
L00D9   = $00D9
L00DB   = $00DB
L00DC   = $00DC
L00DD   = $00DD
L00DE   = $00DE
L00DF   = $00DF
L00E0   = $00E0
L00E1   = $00E1
L00E2   = $00E2
L00E3   = $00E3
L00E4   = $00E4
L00E5   = $00E5
L00E6   = $00E6
L00E7   = $00E7
L00E8   = $00E8
L00E9   = $00E9
L00EA   = $00EA
L00EB   = $00EB
L00EC   = $00EC
L00ED   = $00ED
L00FB   = $00FB
L00FC   = $00FC
L00FD   = $00FD
L00FE   = $00FE
L00FF   = $00FF
L0100   = $0100
L013F   = $013F
L0140   = $0140
L0200   = $0200
L0202   = $0202
L0204   = $0204
L0206   = $0206
L0208   = $0208
L020A   = $020A
L020C   = $020C
L020E   = $020E
L0210   = $0210
L0212   = $0212
L0214   = $0214
L0216   = $0216
L0218   = $0218
L021A   = $021A
L021C   = $021C
L02FF   = $02FF
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
L0317   = $0317
L0318   = $0318
L0319   = $0319
L031B   = $031B
L031C   = $031C
L031D   = $031D
L031E   = $031E
L031F   = $031F
L0320   = $0320
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

\ This will compile Roland Boers' original rom for the BBC Conversion Card
type_original = 1

\ This will compile for a native ATOM, located at &F000, basic in RAM at &4000
type_f000 = 2

\ This will compile for a native ATOM, located at &7000, basic in ROM at &C000
type_7000 = 3

\ This will compile for a native ATOM, located at &0800, basic in ROM at &C000
type_0800 = 3

type = type_7000

IF (type = type_original)
    INCLUDE_ATM_HEADER = 0
    LOAD = &F000
    BBCBASICENTRY = &8000
    MOSEXT1 = &6000
    MOSEXT2 = &C000
    SCREEN = &4000
    IO8255_0 = &7000
    IO6522_0 = &7800
    RAM_BOT = &0800
    RAM_TOP = SCREEN
ELIF (type = type_f000)
    INCLUDE_ATM_HEADER = 0
    LOAD = &F000
    BBCBASICENTRY = &4000
    MOSEXT1 = &A000
    MOSEXT2 = &C000
    SCREEN = &8000
    IO8255_0 = &B000
    IO6522_0 = &B800
    RAM_BOT = &0800
    RAM_TOP = BBCBASICENTRY
ELIF (type = type_7000)
    INCLUDE_ATM_HEADER = 1
    LOAD = &7000
    BBCBASICENTRY = &C000
    MOSEXT1 = &6000
    MOSEXT2 = &A000
    SCREEN = &8000
    IO8255_0 = &B000
    IO6522_0 = &B800
    RAM_BOT = &0800
    RAM_TOP = LOAD
ELSE
    INCLUDE_ATM_HEADER = 1
    LOAD = &0800
    BBCBASICENTRY = &C000
    MOSEXT1 = &6000
    MOSEXT2 = &A000
    SCREEN = &8000
    IO8255_0 = &B000
    IO6522_0 = &B800
    RAM_BOT = &1800
    RAM_TOP = SCREEN
ENDIF

\ these are correct for BBC Basic
BBCBASICCOPYRIGHT = BBCBASICENTRY + &0E
BBCBASICVERSION = BBCBASICENTRY + &15

IO8255_1 = IO8255_0 + 1
IO8255_2 = IO8255_0 + 2
IO8255_3 = IO8255_0 + 3

IO6522_1 = IO6522_0 + 1
IO6522_2 = IO6522_0 + 2
IO6522_3 = IO6522_0 + 3
IO6522_4 = IO6522_0 + 4
IO6522_5 = IO6522_0 + 5
IO6522_6 = IO6522_0 + 6
IO6522_7 = IO6522_0 + 7
IO6522_8 = IO6522_0 + 8
IO6522_9 = IO6522_0 + 9
IO6522_A = IO6522_0 + 10
IO6522_B = IO6522_0 + 11
IO6522_C = IO6522_0 + 12
IO6522_D = IO6522_0 + 13
IO6522_E = IO6522_0 + 14
IO6522_F = IO6522_0 + 15


 IF (INCLUDE_ATM_HEADER)

	org LOAD - 22
.AtmHeader
        EQUS    "ATMOS3"
        org AtmHeader + 16
        EQUW	BeebDisStartAddr
        EQUW    BeebDisStartAddr
        EQUW	BeebDisEndAddr - BeebDisStartAddr

ENDIF
        org     LOAD

.BeebDisStartAddr

.LF000
        CMP     #$00
        BEQ     LF019

        CMP     #$01
        BEQ     LF013

        CMP     #$02
        BEQ     LF07F

        CMP     #$07
        BEQ     LF016

        JMP     LF0EE

.LF013
        JMP     LF090

.LF016
        JMP     LF0A1

.LF019
        STX     L00A2
        STY     L00A3
        LDY     #$04
.LF01F
        LDA     (L00A2),Y
        STA     L00A4,Y
        DEY
        BPL     LF01F

        INY
        BPL     LF031

.LF02A
        LDA     #$07
        DEY
.LF02D
        INY
.LF02E
        JSR     LFFEE

.LF031
        JSR     LFFE0

        CMP     #$7F
        BNE     LF03F

        CPY     #$00
        BEQ     LF031

        DEY
        BCS     LF02E

.LF03F
        CMP     #$15
        BNE     LF050

        TYA
        BEQ     LF031

        LDA     #$7F
.LF048
        JSR     LFFEE

        DEY
        BNE     LF048

        BEQ     LF031

.LF050
        CMP     #$1B
        BEQ     LF075

        STA     (L00A4),Y
        CMP     #$0D
        BEQ     LF06E

        CPY     L00A6
        BCS     LF02A

        CMP     L00A7
        BCC     LF068

        CMP     L00A8
        BEQ     LF02D

        BCC     LF02D

.LF068
        CMP     #$20
        BCC     LF02E

        BCS     LF031

.LF06E
        JSR     LFFE7

        LDX     #$00
        CLC
        RTS

.LF075
        LDX     #$FF
        STX     L00FF
        RTS

.LF07A
        LDA     #$83
        JMP     LFFF4

.LF07F
        STX     L009E
        STY     L009F
        LDY     #$04
.LF085
        LDA     (L009E),Y
        STA     L0300,Y
        DEY
        BPL     LF085

        LDY     L009F
        RTS

.LF090
        STX     L009E
        STY     L009F
        LDY     #$04
.LF096
        LDA     L0300,Y
        STA     (L009E),Y
        DEY
        BPL     LF096

        LDY     L009F
        RTS

.LF0A1
        STX     L009E
        STY     L009F
        LDY     #$07
        LDA     (L009E),Y
        STA     L0318
        DEY
        LDA     (L009E),Y
        STA     L0317
        DEY
        DEY
        LDA     (L009E),Y
        STA     L0319
        TAY
        PHP
        SEI
        JSR     LF1B6

        PLP
        LDY     L009F
        RTS

.LF0C3
        PHA
        LDA     MOSEXT1
        CMP     #$BE
        BNE     LF0CF

        PLA
        JMP     (MOSEXT1 + &FFC)

.LF0CF
        JMP     LF53A

.LF0D2
        CMP     #$7E
        BEQ     LF101

        CMP     #$81
        BEQ     LF12B

        CMP     #$82
        BEQ     LF100

        CMP     #$83
        BEQ     LF104

        CMP     #$84
        BEQ     LF107

        CMP     #$86
        BEQ     LF0C3

        CMP     #$DA
        BEQ     LF100

.LF0EE
        BRK
        EQUB    $FF
        EQUS    "Not implemented"
        EQUB    $00
.LF100
        RTS

.LF101
        JMP     LF172

.LF104
        JMP     LF1D7

.LF107
        PHA
        JSR     LF07A

        STY     L009F
        LDA     #$00
        TAX
        TAY
.LF111
        LDA     (L009E),Y
        EOR     #$FF
        STA     (L009E),Y
        CMP     (L009E),Y
        BNE     LF127

        EOR     #$FF
        STA     (L009E),Y
        INC     L009F
        LDA     L009F
        CMP     #>RAM_TOP
        BCC     LF111

.LF127
        LDY     L009F
        PLA
        RTS

.LF12B
        STX     L031B
        STY     L031C
        LDX     #$00
        STX     L031F
        STX     L031E
        STX     L031D
        LDY     #$04
        CLC
.LF13F
        LDA     L0300,X
        ADC     L031B,X
        STA     L0320,X
        INX
        DEY
        BPL     LF13F

.LF14C
        JSR     LFE4A

        BCC     LF162

        LDX     #$04
.LF153
        LDA     L0320,X
        CMP     L0300,X
        BMI     LF16A

        BNE     LF14C

        DEX
        BPL     LF153

        BMI     LF16A

.LF162
        JSR     LF16E

        TAX
        LDY     #$00
        CLC
        RTS

.LF16A
        LDY     #$FF
        SEC
        RTS

.LF16E
        PHP
        JMP     LFE8A

.LF172
        LDA     L00FF
        BPL     LF17C

        JSR     LF17D

        JMP     LF172

.LF17C
        RTS

.LF17D
        LDA     IO8255_0
        PHA
        AND     #$F0
        STA     IO8255_0
        LDA     IO8255_1
        AND     #$20
        BEQ     LF191

        LDA     #$00
        BEQ     LF193

.LF191
        LDA     #$FF
.LF193
        STA     L00FF
        PLA
        STA     IO8255_0
        RTS

.LF19A
        STX     L00A1
        JSR     LF17D

        LDX     #$00
.LF1A1
        INC     L0300,X
        INX
        CPX     #$05
        BEQ     LF1AE

        LDA     L02FF,X
        BEQ     LF1A1

.LF1AE
        LDX     L00A1
        LDA     IO6522_4
        LDA     L00FC
        RTI

.LF1B6
        TAX
        DEX
        TXA
        BNE     LF1B6

        LDA     IO8255_2
        EOR     #$04
        STA     IO8255_2
        DEC     L0317
        BEQ     LF1CB

        TYA
        BNE     LF1B6

.LF1CB
        LDA     L0318
        BEQ     LF1D6

        DEC     L0318
        TYA
        BNE     LF1B6

.LF1D6
        RTS

.LF1D7
        PHA
        LDA     #$00
        TAY
        TAX
        STA     L009E
        LDA     #>RAM_BOT
        STA     L009F
.LF1E2
        LDA     (L009E),Y
        EOR     #$FF
        STA     (L009E),Y
        CMP     (L009E),Y
        BEQ     LF1F6

        INC     L009F
        INC     L009F
        INC     L009F
        INC     L009F
        BNE     LF1E2

.LF1F6
        EOR     #$FF
        STA     (L009E),Y
        LDY     L009F
        PLA
        RTS

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

.LF459
        JSR     LFFD4

        LDX     #$04
        STX     IO8255_2
.LF461
        RTS

.LF462
        JSR     LFBB5

        LDA     L00D9
        JMP     LF46F

.LF46A
        JSR     LFB4D

        LDA     L00D0
.LF46F
        BIT     L00EA
        BMI     LF461

        PHA
        JSR     LF7C0

        PHP
        PHP
        PHP
        NOP
        PLA
        JMP     LF7E9

.LF47F
        PHA
        JMP     (L0200)

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

.LF493
        LDA     BBCBASICVERSION
        CMP     #$31
        BEQ     LF4B2

        CMP     #$32
        BEQ     LF4B2

        JSR     LF7C0
        EQUB    $06
        EQUB    $0C
        EQUS    "Language?"
        EQUB    $0D,$0A
        NOP

.LF4AF
        JMP     LF4AF

.LF4B2
        JSR     LF7C0

.LF4B5
        EQUB    $06

.LF4B6
        EQUB    $0C,$0F

.LF4B8
        EQUS    "BBC Basic Issue "

.LF4C8
        LDA     BBCBASICVERSION
        JSR     LFFEE

        JSR     LF7C0

.LF4D1
        EQUB    $0D

.LF4D2
        EQUB    $0A,$0A

.LF4D4
        EQUS    "MOS ROM V3.0"

.LF4E0
        EQUB    $0D,$0A

.LF4E2
        LDA     MOSEXT1
        CMP     #$BE
        BNE     LF4EC

        JSR     MOSEXT1 + 4

.LF4EC
        JSR     LFFE7

        JSR     LFF6D

        LDA     #$01
        CLI
        JMP     BBCBASICENTRY

.LF4F8
        BIT     L00DB
        BVC     LF509

        BIT     L00EA
        BMI     LF506

        JSR     LF7C0

.LF503
        EQUB    $08

.LF504
        EQUB    $3C

.LF505
        NOP
.LF506
        JMP     LF9BE

.LF509
        JMP     LF9C9

.LF50C
        EQUB    $FF

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

        BRK
.LF53A
        LSR     L00DF
        PHP
        ROL     L00DF
        LDA     L00DE
        PLP
        ROR     A
        LSR     A
        LSR     A
        LSR     A
        LSR     A
        TAY
        LDA     L00E0
        AND     #$7F
        TAX
        PLA
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

.LF5DA
        JSR     LF8AB

        JMP     LFE9E

.LF5E0
        STY     L00DE
        JSR     LF8AB

        JMP     LFD1B

        BRK
.LF5E9
        EQUS    "CAT"
        EQUB    >LFA00
        EQUB    <LFA00
        EQUS    "LOAD"
        EQUB    >LF932
        EQUB    <LF932
        EQUS    "SAVE"
        EQUB    >LFA91
        EQUB    <LFA91
        EQUS    "RUN"
        EQUB    >LF9F6
        EQUB    <LF9F6
        EQUS    "MON"
        EQUB    >LF9F0
        EQUB    <LF9F0
        EQUS    "NOMON"
        EQUB    >LF9EF
        EQUB    <LF9EF
        EQUS    "FLOAD"
        EQUB    >LF92F
        EQUB    <LF92F
        EQUB    >LF8B6
        EQUB    <LF8B6

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

.LF71A
        STA     L009E
        STX     L009F
        STY     L00A0
        LDX     #$A9
        LDY     #$03
.LF724
        LDA     (L009F),Y
        STA     L00A9,Y
        DEY
        BPL     LF724

        LDY     #$06
        LDA     L009E
        BEQ     LF742

        LDA     #$00
        STA     L00AD
        LDA     (L009F),Y
        BNE     LF73C

        DEC     L00AD
.LF73C
        JSR     LF945

        JMP     LF764

.LF742
        LDA     (L009F),Y
        STA     L00AD
        INY
        LDA     (L009F),Y
        STA     L00AE
        LDY     #$0A
        LDA     (L009F),Y
        STA     L00AF
        INY
        LDA     (L009F),Y
        STA     L00B0
        LDY     #$0E
        LDA     (L009F),Y
        STA     L00B1
        INY
        LDA     (L009F),Y
        STA     L00B2
        JSR     LFAB8

.LF764
        LDA     L009E
        LDX     L009F
        LDY     L00A0
        RTS

.LF76B
        EQUB    $FF

.LF76C
        STA     L00C6
        STX     L00C7
        STY     L00C8
        LDY     #$00
        LDX     #$FF
        LDA     (L00C7),Y
        CMP     #$2A
        BNE     LF77D

.LF77C
        INY
.LF77D
        INX
        LDA     (L00C7),Y
        STA     L0100,X
        CMP     #$0D
        BNE     LF77C

        JSR     LF8C3

        LDY     L00C8
        LDX     L00C7
        LDA     L00C6
.LF790
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

.LF7B9
        CMP     #$00
        BEQ     LF790

        JMP     LFC0B

.LF7C0
        PLA
        STA     L00E8
        PLA
        STA     L00E9
.LF7C6
        LDY     #$00
        INC     L00E8
        BNE     LF7CE

        INC     L00E9
.LF7CE
        LDA     (L00E8),Y
        BMI     LF7D8

        JSR     LFFEE

        JMP     LF7C6

.LF7D8
        JMP     (L00E8)

.LF7DB
        LDX     #$D4
        JSR     LF7E0

.LF7E0
        LDA     L0001,X
        JSR     LF7F1

        INX
        INX
        LDA     L00FE,X
.LF7E9
        JSR     LF7F1

.LF7EC
        LDA     #$20
        JMP     LFFEE

.LF7F1
        PHA
        LSR     A
        LSR     A
        LSR     A
        LSR     A
        JSR     LF7FA

        PLA
.LF7FA
        AND     #$0F
        CMP     #$0A
        BCC     LF802

        ADC     #$06
.LF802
        ADC     #$30
        JMP     LFFEE

.LF807
        JSR     LF863

        LDX     #$00
        CMP     #$22
        BEQ     LF816

        INX
        BNE     LF82E

.LF813
        JMP     LFA53

.LF816
        INY
        LDA     L0100,Y
        CMP     #$0D
        BEQ     LF813

        STA     L0140,X
        INX
        CMP     #$22
        BNE     LF816

        INY
        LDA     L0100,Y
        CMP     #$22
        BEQ     LF816

.LF82E
        LDA     #$0D
        STA     L013F,X
        LDA     #$40
        STA     L00C9
        LDA     #$01
        STA     L00CA
        LDX     #$C9
        RTS

.LF83E
        LDY     #$00
.LF840
        LDA     L0000,X
        STA     L00C9,Y
        INX
        INY
        CPY     #$0A
        BCC     LF840

        LDY     #$FF
        LDA     #$0D
.LF84F
        INY
        CPY     #$0E
        BCS     LF85B

        CMP     (L00C9),Y
        BNE     LF84F

        CPY     #$00
        RTS

.LF85B
        BRK
.LF85C
        EQUB    $DD

.LF85D
        EQUS    "Name"

.LF861
        EQUB    $00

.LF862
        INY
.LF863
        LDA     L0100,Y
        CMP     #$20
        BEQ     LF862

        RTS

.LF86B
        CMP     #$30
        BCC     LF87E

        CMP     #$3A
        BCC     LF87B

        SBC     #$07
        BCC     LF87E

        CMP     #$40
        BCS     LF87D

.LF87B
        AND     #$0F
.LF87D
        RTS

.LF87E
        SEC
        RTS

.LF880
        LDA     #$00
        STA     L0000,X
        STA     L0001,X
        STA     L0002,X
        JSR     LF863

.LF88B
        LDA     L0100,Y
        JSR     LF86B

        BCS     LF8A8

        ASL     A
        ASL     A
        ASL     A
        ASL     A
        STY     L0002,X
        LDY     #$04
.LF89B
        ASL     A
        ROL     L0000,X
        ROL     L0001,X
        DEY
        BNE     LF89B

        LDY     L0002,X
        INY
        BNE     LF88B

.LF8A8
        LDA     L0002,X
        RTS

.LF8AB
        PHA
        LDA     L00E6
        BMI     LF8B4

        LDA     #$10
        STA     L00E6
.LF8B4
        PLA
        RTS

.LF8B6
        LDA     MOSEXT1
        CMP     #$BE
        BEQ     LF8C0

        JMP     LF8FA

.LF8C0
        JMP     (MOSEXT1 + &FFA)

.LF8C3
        LDX     #$FF
        CLD
.LF8C6
        LDY     #$00
        STY     L00DD
        JSR     LF863

        DEY
.LF8CE
        INY
        INX
.LF8D0
        LDA     LF5E9,X
        BMI     LF8ED

        CMP     L0100,Y
        BEQ     LF8CE

        DEX
.LF8DB
        INX
        LDA     LF5E9,X
        BPL     LF8DB

        INX
        LDA     L0100,Y
        CMP     #$2E
        BNE     LF8C6

        INY
        DEX
        BCS     LF8D0

.LF8ED
        STA     L00CA
        LDA     LF5E9 + 1,X
        STA     L00C9
        CLC
        LDX     #$00
        JMP     (L00C9)

.LF8FA
        BRK
.LF8FB
        EQUB    $FE

.LF8FC
        EQUS    "Bad command"

.LF907
        EQUB    $00,$00

.LF909
        JSR     LFB61

.LF90C
        BVC     LF8FA

        BEQ     LF909

        JSR     LFBFE

        LDY     #$00
.LF915
        JSR     LFFD7

        STA     (L00CB),Y
        INC     L00CB
        BNE     LF920

        INC     L00CC
.LF920
        LDX     #$D4
        JSR     LF9DE

        BNE     LF915

        SEC
.LF928
        ROR     L00DD
        CLC
        ROR     L00DD
        PLP
        RTS

.LF92F
        SEC
        ROR     L00DD
.LF932
        JSR     LF807

        LDX     #$CB
        JSR     LF880

        BEQ     LF940

        LDA     #$FF
        STA     L00CD
.LF940
        JSR     LFA4C

        LDX     #$C9
.LF945
        PHP
        SEI
        JSR     LF83E

        PHP
        JSR     LFC13

        PLP
        BEQ     LF909

        LDA     #$00
        STA     L00D0
        STA     L00D1
.LF957
        JSR     LF979

        BCC     LF928

        INC     L00D0
        INC     L00CC
        BNE     LF957

        CLC
        BCC     LF928

.LF965
        JSR     LFFEE

        INY
.LF969
        LDA     L00ED,Y
        CMP     #$0D
        BNE     LF965

.LF970
        INY
        JSR     LF7EC

        CPY     #$0E
        BCC     LF970

        RTS

.LF979
        LDA     #$00
        STA     L00DC
        JSR     LFB61

        BVC     LF90C

        BNE     LF979

        JSR     LFB9C

        PHP
        JSR     LF462

        PLP
        BEQ     LF99E

        LDA     L00DB
        AND     #$20
        ORA     L00EA
        BNE     LF979

        JSR     LF969

        JSR     LFFE7

        BNE     LF979

.LF99E
        LDX     #$02
        LDA     L00DD
        BMI     LF9B7

.LF9A4
        LDA     L00CF,X
        CMP     L00D8,X
        BCS     LF9B2

        LDA     #$05
        JSR     LFC15

        JSR     LFC13

.LF9B2
        BNE     LF979

        DEX
        BNE     LF9A4

.LF9B7
        JSR     LFBFE

        JMP     LF4F8

        NOP
.LF9BE
        DEY
.LF9BF
        INY
        JSR     LFFD7

        STA     (L00CB),Y
        CPY     L00D8
        BNE     LF9BF

.LF9C9
        LDA     L00DC
        STA     L00CE
        JSR     LFFD7

        CMP     L00CE
        BEQ     LF9DB

        BRK
.LF9D5
        EQUB    $D8

.LF9D6
        EQUS    "Sum?"

.LF9DA
        EQUB    $00

.LF9DB
        ROL     L00DB
        RTS

.LF9DE
        INC     L0000,X
        BNE     LF9E4

        INC     L0001,X
.LF9E4
        LDA     L0000,X
        CMP     L0002,X
        BNE     LF9EE

        LDA     L0001,X
        CMP     L0003,X
.LF9EE
        RTS

.LF9EF
        DEX
.LF9F0
        JSR     LFA4C

        STX     L00EA
.LF9F5
        RTS

.LF9F6
        JSR     LF932

        BIT     L00DD
        BVS     LFA49

        JMP     (L00D6)

.LFA00
        PHP
        JSR     LFF84

        JSR     LFC13

.LFA07
        JSR     LFB61

        BVS     LFA0E

        PLP
        RTS

.LFA0E
        BEQ     LFA1A

        LDY     #$00
        JSR     LF970

        JSR     LF7DB

        BNE     LFA33

.LFA1A
        JSR     LFB9C

        JSR     LFBB5

        JSR     LF969

        JSR     LF7DB

        ROL     L00DB
        BPL     LFA33

        INX
        JSR     LF7E0

        LDA     L00FD,X
        JSR     LF7F1

.LFA33
        JSR     LFFE7

        BNE     LFA07

        JMP     LFFE7

.LFA3B
        JSR     LF880

        BEQ     LFA53

        RTS

\ TODO UNREACHABLE

        LDX     #$CB
        JSR     LFA3B

        JSR     LFA4C

.LFA49
        JMP     (L00CB)

.LFA4C
        JSR     LF863

        CMP     #$0D
        BEQ     LF9F5

.LFA53
        BRK
.LFA54
        EQUB    $DC

.LFA55
        EQUS    "Syntax"

.LFA5B
        EQUB    $00

.LFA5C
        SEC
        LDA     L00D1
        SBC     L00CF
        PHA
        LDA     L00D2
        SBC     L00D0
        TAY
        PLA
        CLC
        ADC     L00CB
        STA     L00CD
        TYA
        ADC     L00CC
        STA     L00CE
        LDY     #$04
.LFA74
        LDA     L00CA,Y
        JSR     LFFD4

        DEY
        BNE     LFA74

.LFA7D
        LDA     (L00CF),Y
        JSR     LFFD4

        INC     L00CF
        BNE     LFA88

        INC     L00D0
.LFA88
        LDX     #$CB
        JSR     LF9DE

        BNE     LFA7D

        PLP
        RTS

 .LFA91
        JSR     LF807

        LDX     #$CB
        JSR     LFA3B

        LDX     #$D1
        JSR     LFA3B

        LDX     #$CD
        JSR     LF880

        PHP
        LDA     L00CB
        LDX     L00CC
        PLP
        BNE     LFAAF

        STA     L00CD
        STX     L00CE
.LFAAF
        STA     L00CF
        STX     L00D0
        JSR     LFA4C

        LDX     #$C9
.LFAB8
        PHP
        SEI
        JSR     LF83E

        PHP
        LDA     #$06
        JSR     LFC15

        LDX     #$07
        JSR     LFB4D

        PLP
        BEQ     LFA5C

        LDX     #$04
.LFACD
        LDA     L00CE,X
        STA     L00D2,X
        DEX
        BNE     LFACD

        STX     L00D0
        STX     L00D1
        LDA     L00D5
        BNE     LFADE

        DEC     L00D6
.LFADE
        DEC     L00D5
        CLC
.LFAE1
        ROR     L00D2
        SEC
        LDX     #$FF
        LDA     L00D5
        SBC     L00D3
        STA     L00CF
        LDA     L00D6
        SBC     L00D4
        PHP
        ROR     L00D2
        PLP
        BCC     LFAFC

        CLC
        BEQ     LFAFC

        STX     L00CF
        SEC
.LFAFC
        ROR     L00D2
        INX
        JSR     LFB0E

        INC     L00D0
        INC     L00D4
        INC     L00CC
        ROL     L00D2
        BCS     LFAE1

        PLP
        RTS

.LFB0E
        LDX     #$07
        JSR     LF46A

        STX     L00DC
        LDY     #$04
.LFB17
        LDA     #$2A
        JSR     LFFD4

        DEY
        BNE     LFB17

.LFB1F
        LDA     (L00C9),Y
        JSR     LFFD4

        INY
        CMP     #$0D
        BNE     LFB1F

        LDY     #$08
.LFB2B
        LDA     L00CA,Y
        JSR     LFFD4

        DEY
        BNE     LFB2B

        JSR     LFB5D

        BIT     L00D2
        BVC     LFB46

        DEY
.LFB3C
        INY
        LDA     (L00D3),Y
        JSR     LFFD4

        CPY     L00CF
        BNE     LFB3C

.LFB46
        LDA     L00DC
        JMP     LF459

\ TODO UNREACHABLE

        LDX     #$04
.LFB4D
        STX     IO8255_2
        LDX     #$3C
        BNE     LFB56

        LDX     #$1E
.LFB56
        JSR     LFE3F

        DEX
        BNE     LFB56

        RTS

.LFB5D
        LDX     #$06
        BNE     LFB56

.LFB61
        BIT     IO8255_1
        BPL     LFB61

        BVC     LFB61

.LFB68
        LDY     #$00
        STA     L00C3
        LDA     #$10
        STA     L00C2
.LFB70
        BIT     IO8255_1
        BPL     LFB84

        BVC     LFB84

        JSR     LFC92

        BCS     LFB68

        DEC     L00C3
        BNE     LFB70

        DEC     L00C2
        BNE     LFB70

.LFB84
        BVS     LFB87

        RTS

.LFB87
        LDY     #$04
        PHP
        JSR     LFBB7

        PLP
        LDY     #$04
        LDA     #$2A
.LFB92
        CMP     L00D3,Y
        BNE     LFB9A

        DEY
        BNE     LFB92

.LFB9A
        RTS

.LFB9B
        INY
.LFB9C
        JSR     LFFD7

        STA     L00ED,Y
        CMP     #$0D
        BNE     LFB9B

        LDY     #$FF
.LFBA8
        INY
        LDA     (L00C9),Y
        CMP     L00ED,Y
        BNE     LFB9A

        CMP     #$0D
        BNE     LFBA8

        RTS

.LFBB5
        LDY     #$08
.LFBB7
        JSR     LFFD7

        STA     L00D3,Y
        DEY
        BNE     LFBB7

        RTS

.LFBC1
        STX     L00EC
        STY     L00C3
        PHP
        SEI
.LFBC7
        LDA     #$7E
        STA     L00C0
.LFBCB
        JSR     LFC92

        BCC     LFBC7

        INC     L00C0
        BPL     LFBCB

.LFBD4
        LDA     #$14
        STA     L00C4
        LDX     #$00
        LDY     IO8255_2
.LFBDD
        JSR     LFCA2

        BEQ     LFBE2

.LFBE2
        BEQ     LFBE5

        INX
.LFBE5
        DEC     L00C4
        BNE     LFBDD

        CPX     #$03
        ROR     L00C0
        BCC     LFBD4

        LDA     L00C0
        PLP
        LDY     L00C3
        LDX     L00EC
.LFBF6
        PHA
        CLC
        ADC     L00DC
        STA     L00DC
        PLA
        RTS

.LFBFE
        LDA     L00CD
        BMI     LFC0A

        LDA     L00D4
        STA     L00CB
        LDA     L00D5
        STA     L00CC
.LFC0A
        RTS

.LFC0B
        CMP     #$80
        BNE     LFC13

        LDA     #$06
        BNE     LFC15

.LFC13
        LDA     #$04
.LFC15
        LDX     #$07
        STX     IO8255_2
        BIT     L00EA
        BNE     LFC4B

        CMP     #$05
        BEQ     LFC38

        BCS     LFC2D

        JSR     LF7C0

.LFC27
        EQUS    "Play"

.LFC2B
        BNE     LFC42

.LFC2D
        JSR     LF7C0

.LFC30
        EQUS    "Record"

.LFC36
        BNE     LFC42

.LFC38
        JSR     LF7C0

.LFC3B
        EQUS    "Rewind"

.LFC41
        NOP
.LFC42
        JSR     LF7C0

.LFC45
        EQUS    " tape"

.LFC4A
        NOP
.LFC4B
        JSR     LFFE0

        JMP     LFFE7

.LFC51
        STX     L00EC
        STY     L00C3
        PHP
        SEI
        PHA
        JSR     LFBF6

        STA     L00C0
        JSR     LFCAD

        LDA     #$0A
        STA     L00C1
        CLC
.LFC65
        BCC     LFC73

        LDX     #$07
        STX     IO8255_2
        LDX     #$01
        JSR     LFCAF

        BMI     LFC84

.LFC73
        LDA     #$04
        STA     IO8255_2
        JSR     LFCAD

        INC     IO8255_2
        JSR     LFCAD

        NOP
        NOP
        NOP
.LFC84
        SEC
        ROR     L00C0
        DEC     L00C1
        BNE     LFC65

        LDY     L00C3
        LDX     L00EC
        PLA
        PLP
        RTS

.LFC92
        LDX     #$00
        LDY     IO8255_2
.LFC97
        INX
        BEQ     LFCA1

        JSR     LFCA2

        BEQ     LFC97

        CPX     #$08
.LFCA1
        RTS

.LFCA2
        STY     L00C5
        LDA     IO8255_2
        TAY
        EOR     L00C5
        AND     #$20
        RTS

.LFCAD
        LDX     #$00
.LFCAF
        LDA     #$10
.LFCB1
        BIT     IO8255_2
        BEQ     LFCB1

.LFCB6
        BIT     IO8255_2
        BNE     LFCB6

        DEX
        BPL     LFCB1

        RTS

.LFCBF
        CMP     #$06
        BEQ     LFCE0

        CMP     #$15
        BEQ     LFCE6

        LDY     L00E0
        BMI     LFCEE

        CMP     #$1B
        BEQ     LFCE0

        CMP     #$07
        BEQ     LFCEF

        JSR     LFD1D

        LDX     #$0A
        JSR     LFE9E

        BNE     LFD02

        JMP     LFE90

.LFCE0
        CLC
        LDX     #$00
        STX     IO8255_0
.LFCE6
        LDX     #$02
.LFCE8
        PHP
        ASL     L00DE,X
        PLP
        ROR     L00DE,X
.LFCEE
        RTS

.LFCEF
        PHP
        SEI
        LDA     #$05
        TAY
.LFCF4
        STA     IO8255_3
.LFCF7
        DEX
        BNE     LFCF7

        EOR     #$01
        INY
        BPL     LFCF4

        PLP
        RTS

        NOP
.LFD02
        CMP     #$20
        BCC     LFD1D

        ADC     #$1F
        BMI     LFD0C

        EOR     #$60
.LFD0C
        JSR     LFE44

        STA     (L00DE),Y
.LFD11
        INY
        CPY     #$20
        BCC     LFD1B

        JSR     LFDC5

.LFD19
        LDY     #$00
.LFD1B
        STY     L00E0
.LFD1D
        PHA
        JSR     LFE44

        LDA     (L00DE),Y
        EOR     L00E1
        STA     (L00DE),Y
        PLA
        RTS

.LFD29
        JSR     LFE0E

        LDA     #$20
        JSR     LFE44

        STA     (L00DE),Y
        BPL     LFD1B

.LFD35
        JSR     LFE0E

        JMP     LFD1B

.LFD3B
        JSR     LFDC5

.LFD3E
        LDY     L00E0
        BPL     LFD1B

.LFD42
        LDY     #$80
        STY     L00E1
        LDY     #$00
        STY     IO8255_0
        LDA     #$20
.LFD4D
        STA     SCREEN,Y
        STA     SCREEN+256,Y
        INY
        BNE     LFD4D

.LFD56
        LDA     #>SCREEN
        LDY     #$00
        STA     L00DF
        JMP     LF5E0

        NOP
.LFD60
        JSR     LFE13

        JMP     LFD1B

.LFD66
        CLC
        LDA     #$10
        STA     L00E6

.LFD6B
        LDX     #$08
        JSR     LFCE8

        JMP     LFD1D

.LFD73
        LDA     L00E7
        EOR     #$60
        STA     L00E7
        BCS     LFD84

.LFD7B
        AND     #$05
        ROL     IO8255_1
        ROL     A
        JSR     LFCBF

.LFD84
        JMP     LFE73

.LFD87
        LDY     L00E0
        JSR     LFE44

        LDA     (L00DE),Y
        EOR     L00E1
        BMI     LFD94

        EOR     #$60
.LFD94
        SBC     #$20
        JMP     LFDC2

.LFD99
        LDA     #$5F
.LFD9B
        EOR     #$20
        BNE     LFDC2

.LFD9F
        EOR     L00E7
.LFDA1
        BIT     IO8255_1
        BMI     LFDA8

        EOR     #$60
.LFDA8
        JMP     LFDB8

.LFDAB
        ADC     #$39
        BCC     LFDA1

.LFDAF
        EOR     #$10
.LFDB1
        BIT     IO8255_1
        BMI     LFDB8

        EOR     #$10
.LFDB8
        CLC
        ADC     #$20
.LFDBB
        BIT     IO8255_1
        BVS     LFDC2

        AND     #$1F
.LFDC2
        JMP     LFE39

.LFDC5
        LDY     L00E6
        BMI     LFDD5

        DEY
        BNE     LFDD3

.LFDCC
        JSR     LFE4A

        BCS     LFDCC

        LDY     #$0F
.LFDD3
        STY     L00E6
.LFDD5
        LDA     L00DE
        LDY     L00DF
        CPY     #(>SCREEN)+1
        BCC     LFE05

        CMP     #$E0
        BCC     LFE05

        LDY     #$20
        JSR     LFE3F

.LFDE6
        LDA     SCREEN,Y
        STA     SCREEN-32,Y
        INY
        BNE     LFDE6

        JSR     LFE44

.LFDF2
        LDA     SCREEN+256,Y
        STA     SCREEN+224,Y
        INY
        BNE     LFDF2

        LDY     #$1F
        LDA     #$20
.LFDFF
        STA     (L00DE),Y
        DEY
        BPL     LFDFF

        RTS

.LFE05
        ADC     #$20
        STA     L00DE
        BNE     LFE0D

        INC     L00DF
.LFE0D
        RTS

.LFE0E
        DEY
        BPL     LFE2A

        LDY     #$1F
.LFE13
        LDA     L00DE
        BNE     LFE22

        LDX     L00DF
        CPX     #>SCREEN
        BNE     LFE22

        PLA
        PLA
        JMP     LFD3E

.LFE22
        SBC     #$20
        STA     L00DE
        BCS     LFE2A

        DEC     L00DF
.LFE2A
        RTS

.LFE2B
        JSR     LFED4

        PHP
        PHA
        CLD
        STY     L00E5
        STX     L00E4
        JSR     LFCBF

        PLA
.LFE39
        LDX     L00E4
        LDY     L00E5
        PLP
        RTS

.LFE3F
        BIT     IO8255_2
        BPL     LFE3F

.LFE44
        BIT     IO8255_2
        BMI     LFE44

        RTS

.LFE4A
        LDY     #$3B
        CLC
        LDA     #$20
.LFE4F
        LDX     #$0A
.LFE51
        BIT     IO8255_1
        BEQ     LFE5E

        INC     IO8255_0
        DEY
        DEX
        BNE     LFE51

        LSR     A
.LFE5E
        PHP
        PHA
        LDA     IO8255_0
        AND     #$F0
        STA     IO8255_0
        PLA
        PLP
        BNE     LFE4F

        RTS

.LFE6D
        PHP
        CLD
        STX     L00E4
        STY     L00E5
.LFE73
        BIT     IO8255_2
        BVC     LFE7D

        JSR     LFE4A

        BCC     LFE73

.LFE7D
        JSR     LFF79

.LFE80
        JSR     LFE4A

        BCS     LFE80

        JSR     LFE4A

        BCS     LFE80

.LFE8A
        TYA
        LDX     #$17
        JSR     LF5DA

.LFE90
        LDA     LFEBC,X
        STA     L00E2
        LDA     #>LFD1B
        STA     L00E3
        TYA
        JMP     (L00E2)

.LFE9D
        DEX
.LFE9E
        CMP     LFEA4,X
        BCC     LFE9D

        RTS

.LFEA4
        EQUB    $00

.LFEA5
        EQUB    $08,$09,$0A,$0B,$0C,$0D,$0E,$0F
        EQUB    $1E,$7F,$00,$01,$05,$06,$08,$0E
        EQUB    $0F,$10,$11,$1C,$20,$21,$3B

.LFEBC
        EQUB <LFD1D
        EQUB <LFD35
        EQUB <LFD11
        EQUB <LFD3B
        EQUB <LFD60
        EQUB <LFD42
        EQUB <LFD19
        EQUB <LFD66
        EQUB <LFD6B
        EQUB <LFD56
        EQUB <LFD29
        EQUB <LFDB8
        EQUB <LFDAB
        EQUB <LFD73
        EQUB <LFD7B
        EQUB <LFDBB
        EQUB <LFD87
        EQUB <LFD99
        EQUB <LFDB8
        EQUB <LFDB1
        EQUB <LFDAF
        EQUB <LFDA1
        EQUB <LFD9F
        EQUB <LFD9B

.LFED4
        PHA
        CMP     #$02
        BEQ     LFF00

        CMP     #$03
        BEQ     LFF11

        CMP     L00FB
        BEQ     LFF0F

        LDA     IO6522_C
        AND     #$0E
        BEQ     LFF0F

        PLA
.LFEE9
        BIT     IO6522_1
        BMI     LFEE9

        STA     IO6522_1
        PHA
        LDA     IO6522_C
        AND     #$F0
        ORA     #$0C
        STA     IO6522_C
        ORA     #$02
        BNE     LFF0C

.LFF00
        LDA     #$7F
        STA     IO6522_3
        LDA     IO6522_C
        AND     #$F0
        ORA     #$0E
.LFF0C
        STA     IO6522_C
.LFF0F
        PLA
        RTS

.LFF11
        LDA     IO6522_C
        AND     #$F0
        BCS     LFF0C

.LFF18
        LDX     #$19
.LFF1A
        LDA     LFF88,X
        STA     L0204,X
        LDA     #$00
        STA     L0300,X
        DEX
        BPL     LFF1A

        STA     L00EA
        STA     L00E7
        STA     L00FF
        TXS
        JSR     LFF7B

        LDA     #$0A
        STA     L00FB
        LDA     #$8A
        STA     IO8255_3
        LDA     #$07
        STA     IO8255_2
        LDA     #$20
        STA     L00EB
        LDA     #$0E
        STA     IO6522_4
        LDA     #$27
        STA     IO6522_5
        LDA     #$40
        STA     IO6522_B
        LDA     #$C0
        STA     IO6522_E
        LDA     #<BBCBASICCOPYRIGHT
        STA     L00FD
        LDA     #>BBCBASICCOPYRIGHT
        STA     L00FE
        LDA     MOSEXT1
        CMP     #$BE
        BNE     LFF6A

        JSR     MOSEXT1 + 1

.LFF6A
        JMP     LF493

.LFF6D
        LDA     MOSEXT2
        CMP     #$AA
        BNE     LFF77

        JSR     MOSEXT2+1

.LFF77
        RTS

.LFF78
        EQUB    $71

.LFF79
        LDX     #$64
.LFF7B
        LDY     #$C7
.LFF7D
        DEY
        BNE     LFF7D

        DEX
        BNE     LFF7B

        RTS

.LFF84
        SEI
        JMP     LFA4C

.LFF88
        EQUW    LFFBE
        EQUW    LF0EE
        EQUW    LF76C
        EQUW    LF0D2
        EQUW    LF000
        EQUW    LF54F
        EQUW    LFE6D
        EQUW    LF71A
        EQUW    LF0EE
        EQUW    LFBC1
        EQUW    LFC51
        EQUW    LF0EE
        EQUW    LF7B9

.LFFA2
        STA     L00FC
        PLA
        PHA
        AND     #$10
        BNE     LFFAD

        JMP     (L0204)

.LFFAD
        PLP
        CLI
        CLD
        PLA
        SEC
        SBC     #$01
        STA     L00FD
        PLA
        SBC     #$00
        STA     L00FE
        JMP     (L0202)

.LFFBE
        LDA     IO6522_D
        AND     #$40
        BEQ     LFFC8

        JMP     LF19A

.LFFC8
        JMP     (L0206)

        EQUB    $00,$00,$00

.LFFCE
        JMP     (L021C)

        JMP     (L021A)

.LFFD4
        JMP     (L0218)

.LFFD7
        JMP     (L0216)

        JMP     (L0214)

        JMP     (L0212)

.LFFE0
        JMP     (L0210)

        CMP     #$0D
        BNE     LFFEE

.LFFE7
        LDA     #$0A
        JSR     LFFEE

        LDA     #$0D
.LFFEE
        JMP     (L020E)

        JMP     (L020C)

.LFFF4
        JMP     (L020A)

        JMP     (L0208)

.LFFFA
        EQUW    LF47F
        EQUW    LFF18
        EQUW    LFFA2

.BeebDisEndAddr

IF (INCLUDE_ATM_HEADER)
    SAVE "BBCMOS3",AtmHeader,BeebDisEndAddr
ELSE
    SAVE "BBCMOS3",BeebDisStartAddr,BeebDisEndAddr
ENDIF