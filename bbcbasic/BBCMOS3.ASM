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
L1EA9   = $1EA9
L3FE0   = $3FE0
L4000   = $4000
L40E0   = $40E0
L4100   = $4100
L6000   = $6000
L6001   = $6001
L6004   = $6004
L6FFA   = $6FFA
L6FFC   = $6FFC
L6FFE   = $6FFE
L7000   = $7000
L7001   = $7001
L7002   = $7002
L7003   = $7003
L7801   = $7801
L7803   = $7803
L7804   = $7804
L7805   = $7805
L780B   = $780B
L780C   = $780C
L780D   = $780D
L780E   = $780E
L8000   = $8000
L8015   = $8015
LC000   = $C000
LC001   = $C001

        org     $F000
.BeebDisStartAddr
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
        LDA     L6000
        CMP     #$BE
        BNE     LF0CF

        PLA
        JMP     (L6FFC)

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
.LF0EF
        EQUB    $FF

.LF0F0
        EQUS    "Not implemented"

.LF0FF
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
        CMP     #$40
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
        LDA     L7000
        PHA
        AND     #$F0
        STA     L7000
        LDA     L7001
        AND     #$20
        BEQ     LF191

        LDA     #$00
        BEQ     LF193

.LF191
        LDA     #$FF
.LF193
        STA     L00FF
        PLA
        STA     L7000
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
        LDA     L7804
        LDA     L00FC
        RTI

.LF1B6
        TAX
        DEX
        TXA
        BNE     LF1B6

        LDA     L7002
        EOR     #$04
        STA     L7002
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
        LDA     #$08
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
        LDX     #$40
        STX     L00B5
        STY     L00B4
        STA     L00B3
        TAX
        LDA     LF356,X
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
        STA     L7000
        RTS

.LF34A
        LDA     #$40
.LF34C
        STA     L4000,Y
        STA     L4100,Y
        DEY
        BNE     LF34C

.LF355
        BEQ     LF337

        LF356   = LF355+1
.LF357
        EQUB    $44

.LF358
        EQUB    $46,$4C,$58

.LF35B
        EQUB    $6A,$C3,$DC,$F5,$32

.LF360
        EQUB    $F3,$F3,$F3,$F3,$F4

.LF365
        EQUB    $00,$30,$70,$B0,$F0

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
        LDA     #$40
        ADC     #$00
        STA     L00C1
        LDA     L00BB
        LSR     A
        LDA     L00C2
        ROL     A
        TAY
        LDA     LF453,Y
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
        ADC     #$40
        STA     L00C1
        LDA     L00BB
        AND     #$07
        TAY
        LDA     LF451,Y
        JMP     LF3A8

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
        EQUB    $80

.LF452
        EQUB    $40

.LF453
        EQUB    $20,$10,$08,$04,$02,$01

.LF459
        JSR     LFFD4

        LDX     #$04
        STX     L7002
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
        LDA     L6000
        CMP     #$BE
        BEQ     LF48F

        PLA
        JMP     LFE2B

.LF48F
        PLA
        JMP     (L6FFE)

.LF493
        LDA     L8015
        CMP     #$31
        BEQ     LF4B2

        CMP     #$32
        BEQ     LF4B2

        JSR     LF7C0

.LF4A1
        EQUB    $06

.LF4A2
        EQUB    $0C

.LF4A3
        EQUS    "Language?"

.LF4AC
        EQUB    $0D,$0A

.LF4AE
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
        LDA     L8015
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
        LDA     L6000
        CMP     #$BE
        BNE     LF4EC

        JSR     L6004

.LF4EC
        JSR     LFFE7

        JSR     LFF6D

        LDA     #$01
        CLI
        JMP     L8000

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
        LDA     L6000
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
.LF528
        BIT     L1EA9
        LF529   = LF528+1
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
        EQUS    "C"

.LF5EA
        EQUS    "AT"

.LF5EC
        EQUB    $FA

.LF5ED
        EQUB    $00

.LF5EE
        EQUS    "LOAD"

.LF5F2
        EQUB    $F9

.LF5F3
        EQUB    $32

.LF5F4
        EQUS    "SAVE"

.LF5F8
        EQUB    $FA

.LF5F9
        EQUB    $91

.LF5FA
        EQUS    "RUN"

.LF5FD
        EQUB    $F9

.LF5FE
        EQUB    $F6

.LF5FF
        EQUS    "MON"

.LF602
        EQUB    $F9

.LF603
        EQUB    $F0

.LF604
        EQUS    "NOMON"

.LF609
        EQUB    $F9

.LF60A
        EQUB    $EF

.LF60B
        EQUS    "FLOAD"

.LF610
        EQUB    $F9

.LF611
        EQUB    $2F

.LF612
        EQUB    $F8

.LF613
        EQUB    $B6

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
        LDA     L7000
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
        LDA     L7000
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
        LDA     L7000
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

        LDA     L6000
        CMP     #$BE
        BEQ     LF8C0

        JMP     LF8FA

.LF8C0
        JMP     (L6FFA)

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
        LDA     LF5EA,X
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

        DEX
        JSR     LFA4C

        STX     L00EA
.LF9F5
        RTS

        JSR     LF932

        BIT     L00DD
        BVS     LFA49

        JMP     (L00D6)

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

        LDX     #$04
.LFB4D
        STX     L7002
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
        BIT     L7001
        BPL     LFB61

        BVC     LFB61

.LFB68
        LDY     #$00
        STA     L00C3
        LDA     #$10
        STA     L00C2
.LFB70
        BIT     L7001
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
        LDY     L7002
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
        STX     L7002
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
        STX     L7002
        LDX     #$01
        JSR     LFCAF

        BMI     LFC84

.LFC73
        LDA     #$04
        STA     L7002
        JSR     LFCAD

        INC     L7002
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
        LDY     L7002
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
        LDA     L7002
        TAY
        EOR     L00C5
        AND     #$20
        RTS

.LFCAD
        LDX     #$00
.LFCAF
        LDA     #$10
.LFCB1
        BIT     L7002
        BEQ     LFCB1

.LFCB6
        BIT     L7002
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
        STX     L7000
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
        STA     L7003
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
        INY
        CPY     #$20
        BCC     LFD1B

        JSR     LFDC5

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

        JSR     LFE0E

        LDA     #$20
        JSR     LFE44

        STA     (L00DE),Y
        BPL     LFD1B

        JSR     LFE0E

        JMP     LFD1B

        JSR     LFDC5

.LFD3E
        LDY     L00E0
        BPL     LFD1B

        LDY     #$80
        STY     L00E1
        LDY     #$00
        STY     L7000
        LDA     #$20
.LFD4D
        STA     L4000,Y
        STA     L4100,Y
        INY
        BNE     LFD4D

        LDA     #$40
        LDY     #$00
        STA     L00DF
        JMP     LF5E0

        NOP
        JSR     LFE13

        JMP     LFD1B

        CLC
        LDA     #$10
        STA     L00E6
        LDX     #$08
        JSR     LFCE8

        JMP     LFD1D

        LDA     L00E7
        EOR     #$60
        STA     L00E7
        BCS     LFD84

        AND     #$05
        ROL     L7001
        ROL     A
        JSR     LFCBF

.LFD84
        JMP     LFE73

        LDY     L00E0
        JSR     LFE44

        LDA     (L00DE),Y
        EOR     L00E1
        BMI     LFD94

        EOR     #$60
.LFD94
        SBC     #$20
        JMP     LFDC2

        LDA     #$5F
        EOR     #$20
        BNE     LFDC2

        EOR     L00E7
.LFDA1
        BIT     L7001
        BMI     LFDA8

        EOR     #$60
.LFDA8
        JMP     LFDB8

        ADC     #$39
        BCC     LFDA1

        EOR     #$10
        BIT     L7001
        BMI     LFDB8

        EOR     #$10
.LFDB8
        CLC
        ADC     #$20
        BIT     L7001
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
        CPY     #$41
        BCC     LFE05

        CMP     #$E0
        BCC     LFE05

        LDY     #$20
        JSR     LFE3F

.LFDE6
        LDA     L4000,Y
        STA     L3FE0,Y
        INY
        BNE     LFDE6

        JSR     LFE44

.LFDF2
        LDA     L4100,Y
        STA     L40E0,Y
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
        CPX     #$40
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
        BIT     L7002
        BPL     LFE3F

.LFE44
        BIT     L7002
        BMI     LFE44

        RTS

.LFE4A
        LDY     #$3B
        CLC
        LDA     #$20
.LFE4F
        LDX     #$0A
.LFE51
        BIT     L7001
        BEQ     LFE5E

        INC     L7000
        DEY
        DEX
        BNE     LFE51

        LSR     A
.LFE5E
        PHP
        PHA
        LDA     L7000
        AND     #$F0
        STA     L7000
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
        BIT     L7002
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
        LDA     #$FD
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
        EQUB    $1D,$35,$11,$3B,$60,$42,$19,$66
        EQUB    $6B,$56,$29,$B8,$AB,$73,$7B,$BB
        EQUB    $87,$99,$B8,$B1,$AF,$A1,$9F,$9B

.LFED4
        PHA
        CMP     #$02
        BEQ     LFF00

        CMP     #$03
        BEQ     LFF11

        CMP     L00FB
        BEQ     LFF0F

        LDA     L780C
        AND     #$0E
        BEQ     LFF0F

        PLA
.LFEE9
        BIT     L7801
        BMI     LFEE9

        STA     L7801
        PHA
        LDA     L780C
        AND     #$F0
        ORA     #$0C
        STA     L780C
        ORA     #$02
        BNE     LFF0C

.LFF00
        LDA     #$7F
        STA     L7803
        LDA     L780C
        AND     #$F0
        ORA     #$0E
.LFF0C
        STA     L780C
.LFF0F
        PLA
        RTS

.LFF11
        LDA     L780C
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
        STA     L7003
        LDA     #$07
        STA     L7002
        LDA     #$20
        STA     L00EB
        LDA     #$0E
        STA     L7804
        LDA     #$27
        STA     L7805
        LDA     #$40
        STA     L780B
        LDA     #$C0
        STA     L780E
        LDA     #$0E
        STA     L00FD
        LDA     #$80
        STA     L00FE
        LDA     L6000
        CMP     #$BE
        BNE     LFF6A

        JSR     L6001

.LFF6A
        JMP     LF493

.LFF6D
        LDA     LC000
        CMP     #$AA
        BNE     LFF77

        JSR     LC001

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
        EQUW    BeebDisStartAddr
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
        LDA     L780D
        AND     #$40
        BEQ     LFFC8

        JMP     LF19A

.LFFC8
        JMP     (L0206)

.LFFCB
        EQUB    $00

.LFFCC
        EQUB    $00,$00

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
SAVE "BBCMOS3.ASM.bin",BeebDisStartAddr,BeebDisEndAddr


; F000 C9 00 F0 15 C9 01 F0 0B C9 02 F0 73 C9 07 F0 06 -----------s----
; F010 4C EE F0 4C 90 F0 4C A1 F0 86 A2 84 A3 A0 04 B1 L--L--L---------
; F020 A2 99 A4 00 88 10 F8 C8 10 07 A9 07 88 C8 20 EE -------------- -
; F030 FF 20 E0 FF C9 7F D0 07 C0 00 F0 F5 88 B0 EF C9 - --------------
; F040 15 D0 0D 98 F0 EB A9 7F 20 EE FF 88 D0 FA F0 E1 -------- -------
; F050 C9 1B F0 21 91 A4 C9 0D F0 14 C4 A6 B0 CC C5 A7 ---!------------
; F060 90 06 C5 A8 F0 C7 90 C5 C9 20 90 C2 B0 C3 20 E7 --------- ---- -
; F070 FF A2 00 18 60 A2 FF 86 FF 60 A9 83 4C F4 FF 86 ----`----`--L---
; F080 9E 84 9F A0 04 B1 9E 99 00 03 88 10 F8 A4 9F 60 ---------------`
; F090 86 9E 84 9F A0 04 B9 00 03 91 9E 88 10 F8 A4 9F ----------------
; F0A0 60 86 9E 84 9F A0 07 B1 9E 8D 18 03 88 B1 9E 8D `---------------
; F0B0 17 03 88 88 B1 9E 8D 19 03 A8 08 78 20 B6 F1 28 -----------x --(
; F0C0 A4 9F 60 48 AD 00 60 C9 BE D0 04 68 6C FC 6F 4C --`H--`----hl-oL
; F0D0 3A F5 C9 7E F0 2B C9 81 F0 51 C9 82 F0 22 C9 83 :--~-+---Q---"--
; F0E0 F0 22 C9 84 F0 21 C9 86 F0 D9 C9 DA F0 12 00 FF -"---!----------
; F0F0 4E 6F 74 20 69 6D 70 6C 65 6D 65 6E 74 65 64 00 Not implemented-
; F100 60 4C 72 F1 4C D7 F1 48 20 7A F0 84 9F A9 00 AA `Lr-L--H z------
; F110 A8 B1 9E 49 FF 91 9E D1 9E D0 0C 49 FF 91 9E E6 ---I-------I----
; F120 9F A5 9F C9 40 90 EA A4 9F 68 60 8E 1B 03 8C 1C ----@----h`-----
; F130 03 A2 00 8E 1F 03 8E 1E 03 8E 1D 03 A0 04 18 BD ----------------
; F140 00 03 7D 1B 03 9D 20 03 E8 88 10 F3 20 4A FE 90 --}--- ----- J--
; F150 11 A2 04 BD 20 03 DD 00 03 30 0F D0 EF CA 10 F3 ---- ----0------
; F160 30 08 20 6E F1 AA A0 00 18 60 A0 FF 38 60 08 4C 0- n-----`--8`-L
; F170 8A FE A5 FF 10 06 20 7D F1 4C 72 F1 60 AD 00 70 ------ }-Lr-`--p
; F180 48 29 F0 8D 00 70 AD 01 70 29 20 F0 04 A9 00 F0 H)---p--p) -----
; F190 02 A9 FF 85 FF 68 8D 00 70 60 86 A1 20 7D F1 A2 -----h--p`-- }--
; F1A0 00 FE 00 03 E8 E0 05 F0 05 BD FF 02 F0 F3 A6 A1 ----------------
; F1B0 AD 04 78 A5 FC 40 AA CA 8A D0 FB AD 02 70 49 04 --x--@-------pI-
; F1C0 8D 02 70 CE 17 03 F0 03 98 D0 EB AD 18 03 F0 06 --p-------------
; F1D0 CE 18 03 98 D0 E0 60 48 A9 00 A8 AA 85 9E A9 08 ------`H--------
; F1E0 85 9F B1 9E 49 FF 91 9E D1 9E F0 0A E6 9F E6 9F ----I-----------
; F1F0 E6 9F E6 9F D0 EC 49 FF 91 9E A4 9F 68 60 A2 03 ------I-----h`--
; F200 BD 0F 03 95 B3 CA 10 F8 AD 0E 03 29 04 D0 13 A2 -----------)----
; F210 02 18 B5 BB 75 B3 95 BB B5 BC 75 B4 95 BC CA CA ----u-----u-----
; F220 10 EF A2 03 B5 BB 9D 0F 03 CA 10 F8 AD 0E 03 29 ---------------)
; F230 03 F0 0C 85 BF AD 0E 03 29 08 F0 04 20 01 F3 60 --------)--- --`
; F240 A2 02 38 B5 BB F5 B3 B4 B3 94 BB 95 B3 B4 B4 B5 --8-------------
; F250 BC F5 B4 94 BC 95 B4 95 B7 10 0D A9 00 38 F5 B3 -------------8--
; F260 95 B3 A9 00 F5 B4 95 B4 CA CA 10 D6 A5 B5 C5 B3 ----------------
; F270 A5 B6 E5 B4 90 2F A9 00 E5 B5 85 B8 A9 00 E5 B6 -----/----------
; F280 38 6A 85 BA 66 B8 20 01 F3 A5 BD CD 11 03 D0 08 8j--f- ---------
; F290 A5 BE CD 12 03 D0 01 60 20 DE F2 A5 BA 30 E7 20 -------` ----0- 
; F2A0 CD F2 4C 86 F2 A5 B4 4A 85 BA A5 B3 6A 85 B8 20 --L----J----j-- 
; F2B0 01 F3 A5 BB CD 0F 03 D0 07 A5 BC CD 10 03 F0 D7 ----------------
; F2C0 20 CD F2 A5 BA 10 E8 20 DE F2 4C AF F2 38 A5 B8  ------ --L--8--
; F2D0 E5 B5 85 B8 A5 BA E5 B6 85 BA A2 00 F0 0F 18 A5 ----------------
; F2E0 B8 65 B3 85 B8 A5 BA 65 B4 85 BA A2 02 B5 B7 10 -e-----e--------
; F2F0 09 B5 BB D0 02 D6 BC D6 BB 60 F6 BB D0 FB F6 BC ---------`------
; F300 60 6C 13 03 A0 00 A9 07 25 B3 85 B3 8D 2A 03 A9 `l------%----*--
; F310 07 38 E5 B3 F0 34 C9 05 30 02 A9 04 A2 40 86 B5 -8---4--0----@--
; F320 84 B4 85 B3 AA BD 56 F3 AA 98 91 B4 88 D0 FB E6 ------V---------
; F330 B5 E4 B5 D0 F5 A4 B3 B9 60 F3 8D 14 03 B9 5B F3 --------`-----[-
; F340 8D 13 03 B9 65 F3 8D 00 70 60 A9 40 99 00 40 99 ----e---p`-@--@-
; F350 00 41 88 D0 F7 F0 E0 44 46 4C 58 6A C3 DC F5 32 -A-----DFLXj---2
; F360 F3 F3 F3 F3 F4 00 30 70 B0 F0 A5 BC 05 BE D0 52 ------0p-------R
; F370 A5 BB C9 40 B0 4C 4A 85 C0 A9 2F 38 E5 BD C9 30 ---@-LJ---/8---0
; F380 B0 40 A2 FF 38 E8 E9 03 B0 FB 69 03 85 C2 8A 0A -@--8-----i-----
; F390 0A 0A 0A 0A 05 C0 85 C0 A9 40 69 00 85 C1 A5 BB ---------@i-----
; F3A0 4A A5 C2 2A A8 B9 53 F4 A0 00 A6 BF CA F0 0F CA J--*--S---------
; F3B0 F0 07 49 FF 31 C0 91 C0 60 51 C0 91 C0 60 11 C0 --I-1---`Q---`--
; F3C0 91 C0 60 A5 BC 05 BE D0 F9 A5 BB 30 F5 4A 4A 4A --`--------0-JJJ
; F3D0 85 C0 A9 3F 38 E5 BD C9 40 90 32 60 A5 BC 05 BE ---?8---@-2`----
; F3E0 D0 E0 A5 BB 30 DC 4A 4A 4A 85 C0 A9 5F 38 E5 BD ----0-JJJ---_8--
; F3F0 C9 60 90 19 60 A5 BC 05 BE D0 C7 A5 BB 30 C3 4A -`--`--------0-J
; F400 4A 4A 85 C0 A9 BF 38 E5 BD C9 C0 B0 B5 A0 00 84 JJ----8---------
; F410 C1 0A 26 C1 0A 26 C1 0A 26 C1 0A 26 C1 65 C0 85 --&--&--&--&-e--
; F420 C0 A5 C1 69 40 85 C1 A5 BB 29 07 A8 B9 51 F4 4C ---i@----)---Q-L
; F430 A8 F3 A5 BC 05 BE D0 BC A5 BB 4A 4A 4A 85 C0 A9 ----------JJJ---
; F440 BF 38 E5 BD C9 C0 B0 AC A0 00 84 C1 0A 26 C1 10 -8-----------&--
; F450 C0 80 40 20 10 08 04 02 01 20 D4 FF A2 04 8E 02 --@ ----- ------
; F460 70 60 20 B5 FB A5 D9 4C 6F F4 20 4D FB A5 D0 24 p` ----Lo- M---$
; F470 EA 30 EE 48 20 C0 F7 08 08 08 EA 68 4C E9 F7 48 -0-H ------hL--H
; F480 6C 00 02 48 AD 00 60 C9 BE F0 04 68 4C 2B FE 68 l--H--`----hL+-h
; F490 6C FE 6F AD 15 80 C9 31 F0 18 C9 32 F0 14 20 C0 l-o----1---2-- -
; F4A0 F7 06 0C 4C 61 6E 67 75 61 67 65 3F 0D 0A EA 4C ---Language?---L
; F4B0 AF F4 20 C0 F7 06 0C 0F 42 42 43 20 42 61 73 69 -- -----BBC Basi
; F4C0 63 20 49 73 73 75 65 20 AD 15 80 20 EE FF 20 C0 c Issue --- -- -
; F4D0 F7 0D 0A 0A 4D 4F 53 20 52 4F 4D 20 56 33 2E 30 ----MOS ROM V3.0
; F4E0 0D 0A AD 00 60 C9 BE D0 03 20 04 60 20 E7 FF 20 ----`---- -` -- 
; F4F0 6D FF A9 01 58 4C 00 80 24 DB 50 0D 24 EA 30 06 m---XL--$-P-$-0-
; F500 20 C0 F7 08 3C EA 4C BE F9 4C C9 F9 FF AD 00 60  ---<-L--L-----`
; F510 C9 BE F0 03 4C 91 F7 AC 06 03 20 29 F5 AC 07 03 ----L----- )----
; F520 20 26 F5 4C 7D F5 A9 0D 2C A9 1E 20 EE FF 29 0B  &-L}---,-- --)-
; F530 88 30 05 20 EE FF 10 F8 60 00 46 DF 08 26 DF A5 -0- ----`-F--&--
; F540 DE 28 6A 4A 4A 4A 4A A8 A5 E0 29 7F AA 68 60 84 -(jJJJJ---)--h`-
; F550 A0 86 9F 85 9E AE 16 03 F0 2A 9D 05 03 CA 8E 16 ---------*------
; F560 03 D0 1A AD 05 03 C9 16 F0 46 C9 19 F0 06 C9 1F ---------F------
; F570 F0 9B D0 09 4C 14 F6 8E 16 03 8D 05 03 A4 A0 A6 ----L-----------
; F580 9F A5 9E 60 A2 01 C9 16 F0 ED E8 C9 1F F0 E8 A2 ---`------------
; F590 05 C9 19 F0 E2 C9 10 F0 11 20 7D F5 C9 61 30 07 --------- }--a0-
; F5A0 C9 7B 10 03 38 E5 EB 4C 83 F4 AD 2A 03 8D 06 03 -{--8--L---*----
; F5B0 20 7D F5 48 98 48 8A 48 AD 06 03 48 A0 06 B9 D3  }-H-H-H---H----
; F5C0 F5 20 EE FF 88 10 F7 68 85 B3 20 04 F3 68 AA 68 - -----h-- --h-h
; F5D0 A8 68 60 00 00 00 00 04 19 1E 20 AB F8 4C 9E FE -h`------- --L--
; F5E0 84 DE 20 AB F8 4C 1B FD 00 43 41 54 FA 00 4C 4F -- --L---CAT--LO
; F5F0 41 44 F9 32 53 41 56 45 FA 91 52 55 4E F9 F6 4D AD-2SAVE--RUN--M
; F600 4F 4E F9 F0 4E 4F 4D 4F 4E F9 EF 46 4C 4F 41 44 ON--NOMON--FLOAD
; F610 F9 2F F8 B6 AD 0A 03 C9 40 90 02 E9 38 29 1F 8D -/------@---8)--
; F620 0E 03 A9 00 8D 2B 03 AD 08 03 10 0A A2 03 20 FA -----+-------- -
; F630 F6 A9 FF 8D 2B 03 A9 00 85 BB 85 BC AD 09 03 38 ----+----------8
; F640 E9 05 B0 05 CE 08 03 30 08 E6 BB D0 F2 E6 BC D0 -------0--------
; F650 EE AD 00 70 29 F0 C9 F0 F0 0C C9 20 B0 04 46 BC ---p)------ --F-
; F660 66 BB 46 BC 66 BB AD 2B 03 10 05 A2 08 20 0C F7 f-F-f--+----- --
; F670 A9 00 8D 2C 03 AD 06 03 10 0A A2 01 20 FA F6 A9 ---,-------- ---
; F680 FF 8D 2C 03 AD 00 70 29 F0 C9 10 F0 08 C9 30 F0 --,---p)------0-
; F690 04 C9 50 D0 15 AD 07 03 85 BD AD 06 03 85 BE 46 --P------------F
; F6A0 BE 66 BD 46 BE 66 BD 4C E2 F6 AD 07 03 0A 85 BD -f-F-f-L--------
; F6B0 AD 06 03 2A 85 BE 18 A5 BD 6D 07 03 85 BD A5 BE ---*-----m------
; F6C0 6D 06 03 85 BE 46 BE 66 BD 46 BE 66 BD 46 BE 66 m----F-f-F-f-F-f
; F6D0 BD 46 BE 66 BD AD 00 70 29 F0 C9 A0 B0 0C C9 00 -F-f---p)-------
; F6E0 D0 04 46 BE 66 BD 46 BE 66 BD AD 2C 03 10 05 A2 --F-f-F-f--,----
; F6F0 0A 20 0C F7 20 FE F1 4C 7D F5 38 A9 00 FD 06 03 - -- --L}-8-----
; F700 9D 06 03 A9 00 FD 05 03 9D 05 03 60 38 A9 00 F5 -----------`8---
; F710 B3 95 B3 A9 00 F5 B4 95 B4 60 85 9E 86 9F 84 A0 ---------`------
; F720 A2 A9 A0 03 B1 9F 99 A9 00 88 10 F8 A0 06 A5 9E ----------------
; F730 F0 10 A9 00 85 AD B1 9F D0 02 C6 AD 20 45 F9 4C ------------ E-L
; F740 64 F7 B1 9F 85 AD C8 B1 9F 85 AE A0 0A B1 9F 85 d---------------
; F750 AF C8 B1 9F 85 B0 A0 0E B1 9F 85 B1 C8 B1 9F 85 ----------------
; F760 B2 20 B8 FA A5 9E A6 9F A4 A0 60 FF 85 C6 86 C7 - --------`-----
; F770 84 C8 A0 00 A2 FF B1 C7 C9 2A D0 01 C8 E8 B1 C7 ---------*------
; F780 9D 00 01 C9 0D D0 F5 20 C3 F8 A4 C8 A6 C7 A5 C6 ------- --------
; F790 60 AE 07 03 E0 20 B0 1E AD 06 03 C9 10 B0 17 A4 `---- ----------
; F7A0 E0 20 1D FD 86 E0 46 DF 0A 0A 0A 0A 0A 85 DE 26 - ----F--------&
; F7B0 DF A4 E0 20 1D FD 4C 7D F5 C9 00 F0 D3 4C 0B FC --- --L}-----L--
; F7C0 68 85 E8 68 85 E9 A0 00 E6 E8 D0 02 E6 E9 B1 E8 h--h------------
; F7D0 30 06 20 EE FF 4C C6 F7 6C E8 00 A2 D4 20 E0 F7 0- --L--l---- --
; F7E0 B5 01 20 F1 F7 E8 E8 B5 FE 20 F1 F7 A9 20 4C EE -- ------ --- L-
; F7F0 FF 48 4A 4A 4A 4A 20 FA F7 68 29 0F C9 0A 90 02 -HJJJJ --h)-----
; F800 69 06 69 30 4C EE FF 20 63 F8 A2 00 C9 22 F0 06 i-i0L-- c----"--
; F810 E8 D0 1B 4C 53 FA C8 B9 00 01 C9 0D F0 F5 9D 40 ---LS----------@
; F820 01 E8 C9 22 D0 F0 C8 B9 00 01 C9 22 F0 E8 A9 0D ---"-------"----
; F830 9D 3F 01 A9 40 85 C9 A9 01 85 CA A2 C9 60 A0 00 -?--@--------`--
; F840 B5 00 99 C9 00 E8 C8 C0 0A 90 F5 A0 FF A9 0D C8 ----------------
; F850 C0 0E B0 07 D1 C9 D0 F7 C0 00 60 00 DD 4E 61 6D ----------`--Nam
; F860 65 00 C8 B9 00 01 C9 20 F0 F8 60 C9 30 90 0F C9 e------ --`-0---
; F870 3A 90 08 E9 07 90 07 C9 40 B0 02 29 0F 60 38 60 :-------@--)-`8`
; F880 A9 00 95 00 95 01 95 02 20 63 F8 B9 00 01 20 6B -------- c---- k
; F890 F8 B0 15 0A 0A 0A 0A 94 02 A0 04 0A 36 00 36 01 ------------6-6-
; F8A0 88 D0 F8 B4 02 C8 D0 E3 B5 02 60 48 A5 E6 30 04 ----------`H--0-
; F8B0 A9 10 85 E6 68 60 AD 00 60 C9 BE F0 03 4C FA F8 ----h`--`----L--
; F8C0 6C FA 6F A2 FF D8 A0 00 84 DD 20 63 F8 88 C8 E8 l-o------- c----
; F8D0 BD E9 F5 30 18 D9 00 01 F0 F4 CA E8 BD E9 F5 10 ---0------------
; F8E0 FA E8 B9 00 01 C9 2E D0 DD C8 CA B0 E3 85 CA BD ------.---------
; F8F0 EA F5 85 C9 18 A2 00 6C C9 00 00 FE 42 61 64 20 -------l----Bad 
; F900 63 6F 6D 6D 61 6E 64 00 00 20 61 FB 50 EC F0 F9 command-- a-P---
; F910 20 FE FB A0 00 20 D7 FF 91 CB E6 CB D0 02 E6 CC  ---- ----------
; F920 A2 D4 20 DE F9 D0 EE 38 66 DD 18 66 DD 28 60 38 -- ----8f--f-(`8
; F930 66 DD 20 07 F8 A2 CB 20 80 F8 F0 04 A9 FF 85 CD f- ---- --------
; F940 20 4C FA A2 C9 08 78 20 3E F8 08 20 13 FC 28 F0  L----x >-- --(-
; F950 B8 A9 00 85 D0 85 D1 20 79 F9 90 CC E6 D0 E6 CC ------- y-------
; F960 D0 F5 18 90 C3 20 EE FF C8 B9 ED 00 C9 0D D0 F5 ----- ----------
; F970 C8 20 EC F7 C0 0E 90 F8 60 A9 00 85 DC 20 61 FB - ------`---- a-
; F980 50 8A D0 F5 20 9C FB 08 20 62 F4 28 F0 10 A5 DB P--- --- b-(----
; F990 29 20 05 EA D0 E3 20 69 F9 20 E7 FF D0 DB A2 02 ) ---- i- ------
; F9A0 A5 DD 30 13 B5 CF D5 D8 B0 08 A9 05 20 15 FC 20 --0--------- -- 
; F9B0 13 FC D0 C5 CA D0 ED 20 FE FB 4C F8 F4 EA 88 C8 ------- --L-----
; F9C0 20 D7 FF 91 CB C4 D8 D0 F6 A5 DC 85 CE 20 D7 FF  ------------ --
; F9D0 C5 CE F0 07 00 D8 53 75 6D 3F 00 26 DB 60 F6 00 ------Sum?-&-`--
; F9E0 D0 02 F6 01 B5 00 D5 02 D0 04 B5 01 D5 03 60 CA --------------`-
; F9F0 20 4C FA 86 EA 60 20 32 F9 24 DD 70 4C 6C D6 00  L---` 2-$-pLl--
; FA00 08 20 84 FF 20 13 FC 20 61 FB 70 02 28 60 F0 0A - -- -- a-p-(`--
; FA10 A0 00 20 70 F9 20 DB F7 D0 19 20 9C FB 20 B5 FB -- p- ---- -- --
; FA20 20 69 F9 20 DB F7 26 DB 10 09 E8 20 E0 F7 B5 FD  i- --&---- ----
; FA30 20 F1 F7 20 E7 FF D0 CF 4C E7 FF 20 80 F8 F0 13  -- ----L-- ----
; FA40 60 A2 CB 20 3B FA 20 4C FA 6C CB 00 20 63 F8 C9 `-- ;- L-l-- c--
; FA50 0D F0 A2 00 DC 53 79 6E 74 61 78 00 38 A5 D1 E5 -----Syntax-8---
; FA60 CF 48 A5 D2 E5 D0 A8 68 18 65 CB 85 CD 98 65 CC -H-----h-e----e-
; FA70 85 CE A0 04 B9 CA 00 20 D4 FF 88 D0 F7 B1 CF 20 ------- ------- 
; FA80 D4 FF E6 CF D0 02 E6 D0 A2 CB 20 DE F9 D0 EE 28 ---------- ----(
; FA90 60 20 07 F8 A2 CB 20 3B FA A2 D1 20 3B FA A2 CD ` ---- ;--- ;---
; FAA0 20 80 F8 08 A5 CB A6 CC 28 D0 04 85 CD 86 CE 85  -------(-------
; FAB0 CF 86 D0 20 4C FA A2 C9 08 78 20 3E F8 08 A9 06 --- L----x >----
; FAC0 20 15 FC A2 07 20 4D FB 28 F0 91 A2 04 B5 CE 95  ---- M-(-------
; FAD0 D2 CA D0 F9 86 D0 86 D1 A5 D5 D0 02 C6 D6 C6 D5 ----------------
; FAE0 18 66 D2 38 A2 FF A5 D5 E5 D3 85 CF A5 D6 E5 D4 -f-8------------
; FAF0 08 66 D2 28 90 06 18 F0 03 86 CF 38 66 D2 E8 20 -f-(-------8f-- 
; FB00 0E FB E6 D0 E6 D4 E6 CC 26 D2 B0 D5 28 60 A2 07 --------&---(`--
; FB10 20 6A F4 86 DC A0 04 A9 2A 20 D4 FF 88 D0 F8 B1  j------* ------
; FB20 C9 20 D4 FF C8 C9 0D D0 F6 A0 08 B9 CA 00 20 D4 - ------------ -
; FB30 FF 88 D0 F7 20 5D FB 24 D2 50 0B 88 C8 B1 D3 20 ---- ]-$-P----- 
; FB40 D4 FF C4 CF D0 F6 A5 DC 4C 59 F4 A2 04 8E 02 70 --------LY-----p
; FB50 A2 3C D0 02 A2 1E 20 3F FE CA D0 FA 60 A2 06 D0 -<---- ?----`---
; FB60 F5 2C 01 70 10 FB 50 F9 A0 00 85 C3 A9 10 85 C2 -,-p--P---------
; FB70 2C 01 70 10 0F 50 0D 20 92 FC B0 EC C6 C3 D0 F0 ,-p--P- --------
; FB80 C6 C2 D0 EC 70 01 60 A0 04 08 20 B7 FB 28 A0 04 ----p-`--- --(--
; FB90 A9 2A D9 D3 00 D0 03 88 D0 F8 60 C8 20 D7 FF 99 -*--------`- ---
; FBA0 ED 00 C9 0D D0 F5 A0 FF C8 B1 C9 D9 ED 00 D0 EA ----------------
; FBB0 C9 0D D0 F4 60 A0 08 20 D7 FF 99 D3 00 88 D0 F7 ----`-- --------
; FBC0 60 86 EC 84 C3 08 78 A9 7E 85 C0 20 92 FC 90 F7 `-----x-~-- ----
; FBD0 E6 C0 10 F7 A9 14 85 C4 A2 00 AC 02 70 20 A2 FC ------------p --
; FBE0 F0 00 F0 01 E8 C6 C4 D0 F4 E0 03 66 C0 90 E5 A5 -----------f----
; FBF0 C0 28 A4 C3 A6 EC 48 18 65 DC 85 DC 68 60 A5 CD -(----H-e---h`--
; FC00 30 08 A5 D4 85 CB A5 D5 85 CC 60 C9 80 D0 04 A9 0---------`-----
; FC10 06 D0 02 A9 04 A2 07 8E 02 70 24 EA D0 2D C9 05 ---------p$-----
; FC20 F0 16 B0 09 20 C0 F7 50 6C 61 79 D0 15 20 C0 F7 ---- --Play-- --
; FC30 52 65 63 6F 72 64 D0 0A 20 C0 F7 52 65 77 69 6E Record-- --Rewin
; FC40 64 EA 20 C0 F7 20 74 61 70 65 EA 20 E0 FF 4C E7 d- -- tape- --L-
; FC50 FF 86 EC 84 C3 08 78 48 20 F6 FB 85 C0 20 AD FC ------xH ---- --
; FC60 A9 0A 85 C1 18 90 0C A2 07 8E 02 70 A2 01 20 AF -----------p-- -
; FC70 FC 30 11 A9 04 8D 02 70 20 AD FC EE 02 70 20 AD -0-----p ----p -
; FC80 FC EA EA EA 38 66 C0 C6 C1 D0 DA A4 C3 A6 EC 68 ----8f---------h
; FC90 28 60 A2 00 AC 02 70 E8 F0 07 20 A2 FC F0 F8 E0 (`----p--- -----
; FCA0 08 60 84 C5 AD 02 70 A8 45 C5 29 20 60 A2 00 A9 -`----p-E-) `---
; FCB0 10 2C 02 70 F0 FB 2C 02 70 D0 FB CA 10 F3 60 C9 -,-p--,-p-----`-
; FCC0 06 F0 1D C9 15 F0 1F A4 E0 30 23 C9 1B F0 11 C9 ---------0#-----
; FCD0 07 F0 1C 20 1D FD A2 0A 20 9E FE D0 25 4C 90 FE --- ---- ---%L--
; FCE0 18 A2 00 8E 00 70 A2 02 08 16 DE 28 76 DE 60 08 -----p-----(v-`-
; FCF0 78 A9 05 A8 8D 03 70 CA D0 FD 49 01 C8 10 F5 28 x-----p---I----(
; FD00 60 EA C9 20 90 17 69 1F 30 02 49 60 20 44 FE 91 `-- --i-0-I` D--
; FD10 DE C8 C0 20 90 05 20 C5 FD A0 00 84 E0 48 20 44 --- -- ------H D
; FD20 FE B1 DE 45 E1 91 DE 68 60 20 0E FE A9 20 20 44 ---E---h` ---  D
; FD30 FE 91 DE 10 E6 20 0E FE 4C 1B FD 20 C5 FD A4 E0 ----- --L-- ----
; FD40 10 D9 A0 80 84 E1 A0 00 8C 00 70 A9 20 99 00 40 ----------p- --@
; FD50 99 00 41 C8 D0 F7 A9 40 A0 00 85 DF 4C E0 F5 EA --A----@----L---
; FD60 20 13 FE 4C 1B FD 18 A9 10 85 E6 A2 08 20 E8 FC  --L--------- --
; FD70 4C 1D FD A5 E7 49 60 85 E7 B0 09 29 05 2E 01 70 L----I`----)-.-p
; FD80 2A 20 BF FC 4C 73 FE A4 E0 20 44 FE B1 DE 45 E1 * --Ls--- D---E-
; FD90 30 02 49 60 E9 20 4C C2 FD A9 5F 49 20 D0 23 45 0-I`- L---_I -#E
; FDA0 E7 2C 01 70 30 02 49 60 4C B8 FD 69 39 90 F2 49 -,-p0-I`L--i9--I
; FDB0 10 2C 01 70 30 02 49 10 18 69 20 2C 01 70 70 02 -,-p0-I--i ,-pp-
; FDC0 29 1F 4C 39 FE A4 E6 30 0C 88 D0 07 20 4A FE B0 )-L9---0---- J--
; FDD0 FB A0 0F 84 E6 A5 DE A4 DF C0 41 90 28 C9 E0 90 ----------A-(---
; FDE0 24 A0 20 20 3F FE B9 00 40 99 E0 3F C8 D0 F7 20 $-  ?---@--?--- 
; FDF0 44 FE B9 00 41 99 E0 40 C8 D0 F7 A0 1F A9 20 91 D---A--@------ -
; FE00 DE 88 10 FB 60 69 20 85 DE D0 02 E6 DF 60 88 10 ----`i ------`--
; FE10 19 A0 1F A5 DE D0 0B A6 DF E0 40 D0 05 68 68 4C ----------@--hhL
; FE20 3E FD E9 20 85 DE B0 02 C6 DF 60 20 D4 FE 08 48 >-- ------` ---H
; FE30 D8 84 E5 86 E4 20 BF FC 68 A6 E4 A4 E5 28 60 2C ----- --h----(`,
; FE40 02 70 10 FB 2C 02 70 30 FB 60 A0 3B 18 A9 20 A2 -p--,-p0-`-;-- -
; FE50 0A 2C 01 70 F0 08 EE 00 70 88 CA D0 F4 4A 08 48 -,-p----p----J-H
; FE60 AD 00 70 29 F0 8D 00 70 68 28 D0 E3 60 08 D8 86 --p)---ph(--`---
; FE70 E4 84 E5 2C 02 70 50 05 20 4A FE 90 F6 20 79 FF ---,-pP- J--- y-
; FE80 20 4A FE B0 FB 20 4A FE B0 F6 98 A2 17 20 DA F5  J--- J------ --
; FE90 BD BC FE 85 E2 A9 FD 85 E3 98 6C E2 00 CA DD A4 ----------l-----
; FEA0 FE 90 FA 60 00 08 09 0A 0B 0C 0D 0E 0F 1E 7F 00 ---`------------
; FEB0 01 05 06 08 0E 0F 10 11 1C 20 21 3B 1D 35 11 3B --------- !;-5-;
; FEC0 60 42 19 66 6B 56 29 B8 AB 73 7B BB 87 99 B8 B1 `B-fkV)--s{-----
; FED0 AF A1 9F 9B 48 C9 02 F0 27 C9 03 F0 34 C5 FB F0 ----H---'---4---
; FEE0 2E AD 0C 78 29 0E F0 27 68 2C 01 78 30 FB 8D 01 .--x)--'h,-x0---
; FEF0 78 48 AD 0C 78 29 F0 09 0C 8D 0C 78 09 02 D0 0C xH--x)-----x----
; FF00 A9 7F 8D 03 78 AD 0C 78 29 F0 09 0E 8D 0C 78 68 ----x--x)-----xh
; FF10 60 AD 0C 78 29 F0 B0 F4 A2 19 BD 88 FF 9D 04 02 `--x)-----------
; FF20 A9 00 9D 00 03 CA 10 F2 85 EA 85 E7 85 FF 9A 20 --------------- 
; FF30 7B FF A9 0A 85 FB A9 8A 8D 03 70 A9 07 8D 02 70 {---------p----p
; FF40 A9 20 85 EB A9 0E 8D 04 78 A9 27 8D 05 78 A9 40 - ------x-'--x-@
; FF50 8D 0B 78 A9 C0 8D 0E 78 A9 0E 85 FD A9 80 85 FE --x----x--------
; FF60 AD 00 60 C9 BE D0 03 20 01 60 4C 93 F4 AD 00 C0 --`---- -`L-----
; FF70 C9 AA D0 03 20 01 C0 60 71 A2 64 A0 C7 88 D0 FD ---- --`q-d-----
; FF80 CA D0 F8 60 78 4C 4C FA BE FF EE F0 6C F7 D2 F0 ---`xLL-----l---
; FF90 00 F0 4F F5 6D FE 1A F7 EE F0 C1 FB 51 FC EE F0 --O-m-------Q---
; FFA0 B9 F7 85 FC 68 48 29 10 D0 03 6C 04 02 28 58 D8 ----hH)---l--(X-
; FFB0 68 38 E9 01 85 FD 68 E9 00 85 FE 6C 02 02 AD 0D h8----h----l----
; FFC0 78 29 40 F0 03 4C 9A F1 6C 06 02 00 00 00 6C 1C x)@--L--l-----l-
; FFD0 02 6C 1A 02 6C 18 02 6C 16 02 6C 14 02 6C 12 02 -l--l--l--l--l--
; FFE0 6C 10 02 C9 0D D0 07 A9 0A 20 EE FF A9 0D 6C 0E l-------- ----l-
; FFF0 02 6C 0C 02 6C 0A 02 6C 08 02 7F F4 18 FF A2 FF -l--l--l--------
; 10000 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 UUUUUUUUUUUUUUUU

