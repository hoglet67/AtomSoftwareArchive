UpperCaseOnly = 1
LineWidth = $20

L0010   = $0010
L0011   = $0011
L0014   = $0014
L0015   = $0015
L0018   = $0018
L0019   = $0019
L001A   = $001A
L001B   = $001B
L001C   = $001C
L001D   = $001D
L001E   = $001E
L001F   = $001F
L0020   = $0020
L0021   = $0021
L0022   = $0022
L0023   = $0023
L0024   = $0024
L0025   = $0025
L0026   = $0026
L0027   = $0027
L0028   = $0028
L0029   = $0029
L002A   = $002A
L002B   = $002B
L002C   = $002C
L002D   = $002D
L002E   = $002E
L002F   = $002F
L0030   = $0030
L0031   = $0031
L0032   = $0032
L0033   = $0033
L0034   = $0034
L0035   = $0035
L0048   = $0048
L0049   = $0049
L004A   = $004A
L004B   = $004B
L004C   = $004C
L004D   = $004D
L004E   = $004E
L004F   = $004F
L0050   = $0050
L0051   = $0051
L00FD   = $00FD
L00FE   = $00FE
L0202   = $0202
L0203   = $0203
L020E   = $020E
L0400   = $0400
L0401   = $0401
L04FE   = $04FE
L04FF   = $04FF
L7C25   = $7C25

        org     $08C0 - 22
        
.AtmHeader

        EQUS    "MAGIK"

        org AtmHeader + 16

        EQUW	BeebDisStartAddr
        EQUW    L1B00 + 6
        EQUW	BeebDisEndAddr - BeebDisStartAddr

.BeebDisStartAddr
        JMP     L0A40

.L08C3
        EQUB    LineWidth - 1

.L08C4
        EQUB    $00,$04,$06,$07,$01,$08,$02,$03
        EQUB    $05,$0A,$09,$0C,$0B,$FF,$FF,$0F

.L08D4
        EQUB    $00

.L08D5
        EQUB    $00

.L08D6
        EQUB    $00

.L08D7
        EQUB    $00,$00,$00

.L08DA
        EQUB    $00

.L08DB
        EQUB    $00

.L08DC
        EQUB    $00

.L08DD
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00

.L08E8
        EQUB    $00

.L08E9
        EQUB    $00

.L08EA
        EQUB    $00

.L08EB
        EQUB    $00

.L08EC
        EQUB    $20

.L08ED
        EQUB    $20

.L08EE
        EQUB    $20

.L08EF
        EQUB    $20,$20,$20,$20,$20,$20,$20,$20
        EQUB    $20,$20,$20,$20,$20,$20,$20,$20
        EQUB    $20,$20,$20,$20,$20,$20,$20,$20
        EQUB    $20,$20,$20,$20,$20,$20,$20,$20
        EQUB    $20,$20,$20,$20,$20,$20,$20,$20
        EQUB    $20,$20,$20,$20,$20,$20,$20,$20
        EQUB    $20,$20,$20,$20,$20,$20,$20,$20
        EQUB    $20,$20,$20,$20,$20,$20,$20,$20
        EQUB    $20,$20,$20,$20,$20,$20,$20,$20
        EQUB    $20,$20,$20,$20,$20,$20,$20

.L093E
        EQUB    $20,$20,$20,$20,$20,$20,$20,$20
        EQUB    $20,$20

.L0948
        EQUB    $20

.L0949
        EQUB    $20,$20,$20,$20,$20,$20,$20,$20
        EQUB    $20,$20,$20,$20,$20,$20,$20,$20
        EQUB    $20,$20,$20,$20,$20,$20,$20,$20
        EQUB    $20,$20,$20,$20,$20,$20,$20,$20
        EQUB    $20,$20,$20,$20,$20,$20,$20,$20
        EQUB    $20,$20,$20,$20,$20,$20,$20,$20
        EQUB    $20,$20,$20,$20,$20,$20,$20,$20
        EQUB    $20,$20,$20,$20,$20,$20,$20,$20
        EQUB    $20

.L098A
        EQUB    $20,$20,$20,$20,$20,$20,$20,$20
        EQUB    $20,$20,$20,$20,$20,$20,$20,$20
        EQUB    $20,$20,$20,$20,$20,$20,$20,$20
        EQUB    $20,$20,$20,$20,$20,$20,$20,$20
        EQUB    $20

.L09AB
        EQUB    $00

.L09AC
        EQUB    $00

.L09AD
        EQUB    $00

.L09AE
        EQUB    $00

.L09AF
        EQUB    $00

.L09B0
        EQUB    $00

.L09B1
        EQUB    $00

.L09B2
        EQUB    $00

.L09B3
        EQUB    $00,$00

.L09B5
        EQUB    $00

.L09B6
        EQUB    $00

.L09B7
        EQUB    $00

.L09B8
        EQUB    $00

.L09B9
        EQUB    $00

.L09BA
        EQUB    $00

.L09BB
        EQUB    $00

.L09BC
        EQUB    $00

.L09BD
        EQUB    $00

.L09BE
        EQUB    $00

.L09BF
        EQUB    $00

.L09C0
        EQUB    $00

.L09C1
        EQUB    $00

.L09C2
        EQUB    $00

.L09C3
        EQUB    $00

.L09C4
        EQUB    $00

.L09C5
        EQUB    $00

.L09C6
        EQUB    $00

.L09C7
        EQUB    $00

.L09C8
        EQUB    $00

.L09C9
        EQUB    $00

.L09CA
        EQUB    $00

.L09CB
        EQUB    $00

.L09CC
        EQUB    $00

.L09CD
        EQUB    $00

.L09CE
        EQUB    $00

.L09CF
        EQUB    $00

.L09D0
        EQUB    $00

.L09D1
        EQUB    $00

.L09D2
        EQUB    $00

.L09D3
        EQUB    $00,$00

.L09D5
        EQUB    $00,$00

.L09D7
        EQUB    $00,$00,$00,$31,$32,$33

.L09DD
        EQUB    $00

.L09DE
        EQUB    $00

.L09DF
        EQUB    $00

.L09E0
        EQUB    $00

.L09E1
        EQUB    $00

.L09E2
        EQUB    $00

.L09E3
        EQUB    $00

.L09E4
        EQUB    $20,$20,$20,$20,$20,$20,$20,$20
        EQUB    $20,$20,$20,$20,$20,$20,$20,$20
        EQUB    $20,$20,$20,$20,$20,$20,$20,$20
        EQUB    $20,$20,$20,$20,$20,$20,$20,$20
        EQUB    $20,$20,$20,$20,$20,$20,$20,$20
        EQUB    $20,$20,$20,$20,$20,$20,$20,$20
        EQUB    $20,$20,$20,$20,$20,$20,$20,$20
        EQUB    $20,$20,$20

.L0A1F
        EQUB    $20

.L0A20
        EQUB    $20,$20,$20,$20,$20,$20,$20,$20
        EQUB    $20,$20,$20,$20,$20,$20,$20,$20
        EQUB    $20,$20,$20,$20,$20,$20,$20,$20
        EQUB    $20,$20,$20,$20,$20,$20,$20,$20

.L0A40
        CLD
        LDA     #$00
        JSR     L1B00

        LDA     #$01
        STA     L09AB
        JSR     L0B21

        LDX     #$00
        LDY     #$0E
.L0A52
        LDA     L1E12,X
        CLC
        ADC     #$00
        STA     L08D4,X
        LDA     L1E13,X
        ADC     #$1E
        STA     L08D5,X
        LDA     L1E13,X
        CMP     #$7E
        BCC     L0A85

        CMP     #$8F
        BCS     L0A85

        SEC
        SBC     #$80
        STA     L08D5,X
        LDA     L1E12,X
        CLC
        ADC     #$10
        STA     L08D4,X
        LDA     L08D5,X
        ADC     #$05
        STA     L08D5,X
.L0A85
        INX
        INX
        DEY
        BNE     L0A52

        LDA     L1E02
        CLC
        ADC     #$00
        STA     L09C3
        LDA     L1E03
        ADC     #$1E
        STA     L09C4
        LDA     L09C3
        CLC
        ADC     L1E04
        STA     L09C5
        LDA     L09C4
        ADC     L1E05
        STA     L09C6
        LDA     L1E06
        CLC
        ADC     #$05
        STA     L0029
        LDA     L1E07
        ADC     #$1E
        STA     L002A
        LDA     L1E08
        CLC
        ADC     L0029
        STA     L09C7
        LDA     L1E09
        ADC     L002A
        STA     L09C8
        LDA     L08DA
        STA     L19F8
        LDA     L08DB
        STA     L19F9
        LDA     L08DC
        STA     L1A55
        LDA     L08DD
        STA     L1A56
        LDA     L08EA
        STA     L0027
        LDA     L08EB
        STA     L0028
        JSR     L14CB

        LDA     #$00
        STA     L001F
        STA     L0020
.L0AF9
        LDA     #$0A
        PHA
        LDA     #$F8
        PHA
        JSR     L0E6E

        BMI     L0B1E

        TAX
        AND     #$40
        STA     L09CF
        TXA
        AND     #$20
        STA     L09D0
        TXA
        AND     #$1F
        ASL     A
        TAY
        LDA     L100E,Y
        PHA
        LDA     L100D,Y
        PHA
        RTS

.L0B1E
        JMP     L0E00

.L0B21
        LDA     #$00
        STA     L08EC
        LDA     #$1E
        STA     L08ED
        LDA     L1E00
        CLC
        ADC     #$00
        STA     L08EE
        LDA     L1E01
        ADC     #$1E
        STA     L08EF
        LDY     #$08
        LDX     #$EC
        LDA     #$01
        JSR     L1B00

        LDA     L08EC
        BNE     L0B4B

        RTS

.L0B4B
        LDA     #$45
.L0B4D
        JSR     L10BA

        LDA     #$3F
        JMP     L10BA

        LDA     #$41
        JSR     L0B4D

        LDA     #$04
        JSR     L1B00

        JMP     L0A40

.L0B62
        JSR     L0E6E

        ASL     A
        TAX
        LDA     L0400,X
        RTS

        JSR     L0BB7

        BEQ     L0BDD

.L0B70
        LDA     L09D0
        BNE     L0B78

        JSR     L0E6E

.L0B78
        JMP     L0E6E

        JSR     L0BB7

        BNE     L0BDD

        JMP     L0B70

        JSR     L0BB7

        BCC     L0B70

        BEQ     L0B70

        JMP     L0BDD

        JSR     L0BB7

        BCS     L0B70

        JMP     L0BDD

        JSR     L0BD0

        BNE     L0B70

        JMP     L0BDD

        JSR     L0BD0

        BEQ     L0B70

        JMP     L0BDD

        JSR     L0BD0

        BEQ     L0B70

        BCC     L0B70

        JMP     L0BDD

        JSR     L0BD0

        BCS     L0B70

        JMP     L0BDD

.L0BB7
        JSR     L0B62

        TXA
        TAY
        JSR     L0B62

.L0BBF
        SEC
        LDA     L0401,X
        SBC     L0401,Y
        BNE     L0BCF

        SEC
        LDA     L0400,X
        SBC     L0400,Y
.L0BCF
        RTS

.L0BD0
        JSR     L0B62

        JSR     L0E7F

        TXA
        TAY
        LDX     #$FE
        JMP     L0BBF

.L0BDD
        LDA     L09D0
        BNE     L0BF8

        JSR     L0E6E

        CLC
        ADC     L08EA
        PHA
        PHP
        JSR     L0E6E

        PLP
        ADC     L08EB
        STA     L0028
        PLA
        STA     L0027
        RTS

.L0BF8
        LDX     #$00
        LDA     L0027
        STA     L002A
        LDA     L0028
        STA     L09CD
        JSR     L0E6E

        BPL     L0C0A

        LDX     #$FF
.L0C0A
        CLC
        ADC     L002A
        STA     L0027
        TXA
        ADC     L09CD
        STA     L0028
        RTS

        PLA
        STA     L002E
        PLA
        STA     L002F
        LDY     #$02
        LDX     L09D0
        BEQ     L0C24

        DEY
.L0C24
        TYA
        CLC
        ADC     L0027
        PHA
        LDA     L0028
        ADC     #$00
        PHA
        LDA     L002F
        PHA
        LDA     L002E
        PHA
        JMP     L0BDD

        PLA
        PLA
        PLA
        STA     L0028
        PLA
        STA     L0027
        JMP     L0AF9

.L0C42
        LDX     #$00
        TXA
.L0C45
        STA     L0400,X
        DEX
        BNE     L0C45

        RTS

.L0C4C
        PLA
        TAY
        PLA
        LDX     #$FF
        TXS
        PHA
        TYA
        PHA
        RTS

.L0C56
        LDA     #$0A
        SEC
        SBC     L09CB
        STA     L04FE
        LDA     L09CB
        SBC     L09CC
        STA     L04FF
        CLC
        ROL     L04FE
        ROL     L04FF
        CLC
        ROL     L04FE
        ROL     L04FF
        LDA     L04FE
        SEC
        ADC     L09CB
        STA     L09CB
        LDA     L04FF
        ADC     L09CC
        STA     L09CC
        LDA     L09CB
        JMP     L10EC

        JSR     L0B62

        TAY
        LDA     L0401,X
        TAX
        JMP     L0F8E

        JSR     L0B62

        STA     L04FE
        LDA     L0401,X
        STA     L04FF
        JMP     L110D

        JSR     L0E7F

        JMP     L110D

        JSR     L0B62

        TXA
        TAY
        JSR     L0B62

        CLC
        LDA     L0400,Y
        ADC     L0400,X
        STA     L0400,X
        LDA     L0401,Y
        ADC     L0401,X
        STA     L0401,X
        RTS

        JSR     L0B62

        TXA
        TAY
        JSR     L0B62

        SEC
        LDA     L0400,X
        SBC     L0400,Y
        STA     L0400,X
        LDA     L0401,X
        SBC     L0401,Y
        STA     L0401,X
        RTS

        RTS

.L0CE8
        ASL     A
        TAX
        LDA     L08D6,X
        STA     L0032
        LDA     L08D7,X
        STA     L0033
        RTS

        INC     L0018
        BNE     L0CFB

        INC     L0019
.L0CFB
        RTS

.L0CFC
        EQUB    $00

.L0CFD
        EQUB    $1E,$48,$0E,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00

.L0E00
        BRK
.L0E01
        EQUB    $00

        BRK
.L0E03
        EQUB    $00

        BRK
.L0E05
        EQUB    $00

        BRK
.L0E07
        EQUB    $00

        BRK
.L0E09
        EQUB    $00

        BRK
.L0E0B
        EQUB    $00

        BRK
.L0E0D
        EQUB    $00

        BRK
.L0E0F
        EQUB    $00

        BRK
.L0E11
        EQUB    $00

        BRK
.L0E13
        EQUB    $00

        BRK
.L0E15
        EQUB    $00

        BRK
.L0E17
        EQUB    $00

        BRK
.L0E19
        EQUB    $00

        BRK
.L0E1B
        EQUB    $00

        BRK
.L0E1D
        EQUB    $00

        BRK
.L0E1F
        EQUB    $00

.L0E20
        BRK
.L0E21
        EQUB    $00

        BRK
.L0E23
        EQUB    $00

        BRK
.L0E25
        EQUB    $00

        BRK
.L0E27
        EQUB    $00

        BRK
.L0E29
        EQUB    $00

        BRK
.L0E2B
        EQUB    $00

        BRK
.L0E2D
        EQUB    $00

        BRK
.L0E2F
        EQUB    $00

        BRK
.L0E31
        EQUB    $00

        BRK
.L0E33
        EQUB    $00

        BRK
.L0E35
        EQUB    $00

        BRK
.L0E37
        EQUB    $00

        BRK
.L0E39
        EQUB    $00

        BRK
.L0E3B
        EQUB    $00

        BRK
.L0E3D
        EQUB    $00

.L0E3E
        BRK
.L0E3F
        EQUB    $00

        BRK
.L0E41
        EQUB    $00

        BRK
.L0E43
        EQUB    $00

        BRK
.L0E45
        EQUB    $00

        BRK
.L0E47
        EQUB    $00

        BRK
.L0E49
        EQUB    $00

        BRK
.L0E4B
        EQUB    $00

        BRK
.L0E4D
        EQUB    $00

        BRK
.L0E4F
        EQUB    $00

        BRK
.L0E51
        EQUB    $00

        BRK
.L0E53
        EQUB    $00

        BRK
.L0E55
        EQUB    $00

        BRK
.L0E57
        EQUB    $00

        BRK
.L0E59
        EQUB    $00

        BRK
.L0E5B
        EQUB    $00

        BRK
.L0E5D
        EQUB    $00

.L0E5E
        BRK
.L0E5F
        EQUB    $00

        BRK
.L0E61
        EQUB    $00

        BRK
.L0E63
        EQUB    $00

        BRK
.L0E65
        EQUB    $00

        BRK
.L0E67
        EQUB    $00

        BRK
.L0E69
        EQUB    $00

        BRK
.L0E6B
        EQUB    $00

        BRK
.L0E6D
        EQUB    $00

.L0E6E
        BRK
.L0E6F
        EQUB    $00

        BRK
.L0E71
        EQUB    $00

        BRK
.L0E73
        EQUB    $00

        BRK
.L0E75
        EQUB    $00

        BRK
.L0E77
        EQUB    $00

        BRK
.L0E79
        EQUB    $00

        BRK
.L0E7B
        EQUB    $00

        BRK
.L0E7D
        EQUB    $00

        BRK
.L0E7F
        EQUB    $00

        BRK
.L0E81
        EQUB    $00

        BRK
.L0E83
        EQUB    $00

        BRK
.L0E85
        EQUB    $00

        BRK
.L0E87
        EQUB    $00

        BRK
.L0E89
        EQUB    $00

        BRK
.L0E8B
        EQUB    $00

        BRK
.L0E8D
        EQUB    $00

        BRK
.L0E8F
        EQUB    $00

        BRK
.L0E91
        EQUB    $00

        BRK
.L0E93
        EQUB    $00

        BRK
.L0E95
        EQUB    $00

        BRK
.L0E97
        EQUB    $00

        BRK
.L0E99
        EQUB    $00

        BRK
.L0E9B
        EQUB    $00

        BRK
.L0E9D
        EQUB    $00

        BRK
.L0E9F
        EQUB    $00

        BRK
.L0EA1
        EQUB    $00

        BRK
.L0EA3
        EQUB    $00

        BRK
.L0EA5
        EQUB    $00

        BRK
.L0EA7
        EQUB    $00

        BRK
.L0EA9
        EQUB    $00

        BRK
.L0EAB
        EQUB    $00

        BRK
.L0EAD
        EQUB    $00

        BRK
.L0EAF
        EQUB    $00

        BRK
.L0EB1
        EQUB    $00

        BRK
.L0EB3
        EQUB    $00

        BRK
.L0EB5
        EQUB    $00

        BRK
.L0EB7
        EQUB    $00

        BRK
.L0EB9
        EQUB    $00

        BRK
.L0EBB
        EQUB    $00

        BRK
.L0EBD
        EQUB    $00

        BRK
.L0EBF
        EQUB    $00

        BRK
.L0EC1
        EQUB    $00

        BRK
.L0EC3
        EQUB    $00

        BRK
.L0EC5
        EQUB    $00

        BRK
.L0EC7
        EQUB    $00

        BRK
.L0EC9
        EQUB    $00

        BRK
.L0ECB
        EQUB    $00

        BRK
.L0ECD
        EQUB    $00

.L0ECE
        BRK
.L0ECF
        EQUB    $00

        BRK
.L0ED1
        EQUB    $00

        BRK
.L0ED3
        EQUB    $00

        BRK
.L0ED5
        EQUB    $00

        BRK
.L0ED7
        EQUB    $00

        BRK
.L0ED9
        EQUB    $00

        BRK
.L0EDB
        EQUB    $00

        BRK
.L0EDD
        EQUB    $00

        BRK
.L0EDF
        EQUB    $00

        BRK
.L0EE1
        EQUB    $00

        BRK
.L0EE3
        EQUB    $00

        BRK
.L0EE5
        EQUB    $00

        BRK
.L0EE7
        EQUB    $00

        BRK
.L0EE9
        EQUB    $00

        BRK
.L0EEB
        EQUB    $00

        BRK
.L0EED
        EQUB    $00

        BRK
.L0EEF
        EQUB    $00

        BRK
.L0EF1
        EQUB    $00

        BRK
.L0EF3
        EQUB    $00

        BRK
.L0EF5
        EQUB    $00

        BRK
.L0EF7
        EQUB    $00

        BRK
.L0EF9
        EQUB    $00

.L0EFA
        BRK
.L0EFB
        EQUB    $00

        BRK
.L0EFD
        EQUB    $00

        BRK
.L0EFF
        EQUB    $00

        BRK
.L0F01
        EQUB    $00

        BRK
.L0F03
        EQUB    $00

        BRK
.L0F05
        EQUB    $00

        BRK
.L0F07
        EQUB    $00

        BRK
.L0F09
        EQUB    $00

        BRK
.L0F0B
        EQUB    $00

        BRK
.L0F0D
        EQUB    $00

        BRK
.L0F0F
        EQUB    $00

        BRK
.L0F11
        EQUB    $00

        BRK
.L0F13
        EQUB    $00

        BRK
.L0F15
        EQUB    $00

        BRK
.L0F17
        EQUB    $00

        BRK
.L0F19
        EQUB    $00

        BRK
.L0F1B
        EQUB    $00

        BRK
.L0F1D
        EQUB    $00

        BRK
.L0F1F
        EQUB    $00

        BRK
.L0F21
        EQUB    $00

        BRK
.L0F23
        EQUB    $00

        BRK
.L0F25
        EQUB    $00

        BRK
.L0F27
        EQUB    $00

        BRK
.L0F29
        EQUB    $00

        BRK
.L0F2B
        EQUB    $00

        BRK
.L0F2D
        EQUB    $00

        BRK
.L0F2F
        EQUB    $00

        BRK
.L0F31
        EQUB    $00

        BRK
.L0F33
        EQUB    $00

        BRK
.L0F35
        EQUB    $00

        BRK
.L0F37
        EQUB    $00

        BRK
.L0F39
        EQUB    $00

        BRK
.L0F3B
        EQUB    $00

        BRK
.L0F3D
        EQUB    $00

        BRK
.L0F3F
        EQUB    $00

        BRK
.L0F41
        EQUB    $00

        BRK
.L0F43
        EQUB    $00

        BRK
.L0F45
        EQUB    $00

        BRK
.L0F47
        EQUB    $00

        BRK
.L0F49
        EQUB    $00

        BRK
.L0F4B
        EQUB    $00

        BRK
.L0F4D
        EQUB    $00

        BRK
.L0F4F
        EQUB    $00

        BRK
.L0F51
        EQUB    $00

        BRK
.L0F53
        EQUB    $00

        BRK
.L0F55
        EQUB    $00

        BRK
.L0F57
        EQUB    $00

        BRK
.L0F59
        EQUB    $00

        BRK
.L0F5B
        EQUB    $00

        BRK
.L0F5D
        EQUB    $00

        BRK
.L0F5F
        EQUB    $00

        BRK
.L0F61
        EQUB    $00

        BRK
.L0F63
        EQUB    $00

        BRK
.L0F65
        EQUB    $00

        BRK
.L0F67
        EQUB    $00

        BRK
.L0F69
        EQUB    $00

        BRK
.L0F6B
        EQUB    $00

        BRK
.L0F6D
        EQUB    $00

        BRK
.L0F6F
        EQUB    $00

        BRK
.L0F71
        EQUB    $00

        BRK
.L0F73
        EQUB    $00

        BRK
.L0F75
        EQUB    $00

        BRK
.L0F77
        EQUB    $00

        BRK
.L0F79
        EQUB    $00

.L0F7A
        BRK
.L0F7B
        EQUB    $00

        BRK
.L0F7D
        EQUB    $00

        BRK
.L0F7F
        EQUB    $00

        BRK
.L0F81
        EQUB    $00

        BRK
.L0F83
        EQUB    $00

        BRK
.L0F85
        EQUB    $00

        BRK
.L0F87
        EQUB    $00

        BRK
.L0F89
        EQUB    $00

        BRK
.L0F8B
        EQUB    $00

        BRK
.L0F8D
        EQUB    $00

.L0F8E
        BRK
.L0F8F
        EQUB    $00

        BRK
.L0F91
        EQUB    $00

        BRK
.L0F93
        EQUB    $00

        BRK
.L0F95
        EQUB    $00

        BRK
.L0F97
        EQUB    $00

        BRK
.L0F99
        EQUB    $00

        BRK
.L0F9B
        EQUB    $00

        BRK
.L0F9D
        EQUB    $00

        BRK
.L0F9F
        EQUB    $00

        BRK
.L0FA1
        EQUB    $00

        BRK
.L0FA3
        EQUB    $00

        BRK
.L0FA5
        EQUB    $00

        BRK
.L0FA7
        EQUB    $00

        BRK
.L0FA9
        EQUB    $00

        BRK
.L0FAB
        EQUB    $00

.L0FAC
        BRK
.L0FAD
        EQUB    $00

        BRK
.L0FAF
        EQUB    $00

        BRK
.L0FB1
        EQUB    $00

        BRK
.L0FB3
        EQUB    $00

        BRK
.L0FB5
        EQUB    $00

        BRK
.L0FB7
        EQUB    $00

        BRK
.L0FB9
        EQUB    $00

        BRK
.L0FBB
        EQUB    $00

        BRK
.L0FBD
        EQUB    $00

        BRK
.L0FBF
        EQUB    $00

        BRK
.L0FC1
        EQUB    $00

        BRK
.L0FC3
        EQUB    $00

        BRK
.L0FC5
        EQUB    $00

        BRK
.L0FC7
        EQUB    $00

        BRK
.L0FC9
        EQUB    $00

        BRK
.L0FCB
        EQUB    $00

        BRK
.L0FCD
        EQUB    $00

        BRK
.L0FCF
        EQUB    $00

        BRK
.L0FD1
        EQUB    $00

        BRK
.L0FD3
        EQUB    $00

        BRK
.L0FD5
        EQUB    $00

        BRK
.L0FD7
        EQUB    $00

        BRK
.L0FD9
        EQUB    $00

        BRK
.L0FDB
        EQUB    $00

        BRK
.L0FDD
        EQUB    $00

        BRK
.L0FDF
        EQUB    $00

        BRK
.L0FE1
        EQUB    $00

        BRK
.L0FE3
        EQUB    $00

        BRK
.L0FE5
        EQUB    $00

        BRK
.L0FE7
        EQUB    $00

        BRK
.L0FE9
        EQUB    $00

        BRK
.L0FEB
        EQUB    $00

        BRK
.L0FED
        EQUB    $00

        BRK
.L0FEF
        EQUB    $00

        BRK
.L0FF1
        EQUB    $00

        BRK
.L0FF3
        EQUB    $00

        BRK
.L0FF5
        EQUB    $00

        BRK
.L0FF7
        EQUB    $00

        BRK
.L0FF9
        EQUB    $00

        BRK
.L0FFB
        EQUB    $00

        BRK
.L0FFD
        EQUB    $00

        BRK
.L0FFF
        EQUB    $00

        BRK
.L1001
        EQUB    $00

        BRK
.L1003
        EQUB    $00

        BRK
.L1005
        EQUB    $00

        BRK
.L1007
        EQUB    $00

        BRK
.L1009
        EQUB    $00

        BRK
.L100B
        EQUB    $00

        BRK
.L100D
        EQUB    $00

.L100E
        BRK
.L100F
        EQUB    $00

        BRK
.L1011
        EQUB    $00

        BRK
.L1013
        EQUB    $00

        BRK
.L1015
        EQUB    $00

        BRK
.L1017
        EQUB    $00

        BRK
.L1019
        EQUB    $00

        BRK
.L101B
        EQUB    $00

        BRK
.L101D
        EQUB    $00

        BRK
.L101F
        EQUB    $00

        BRK
.L1021
        EQUB    $00

        BRK
.L1023
        EQUB    $00

        BRK
.L1025
        EQUB    $00

        BRK
.L1027
        EQUB    $00

        BRK
.L1029
        EQUB    $00

        BRK
.L102B
        EQUB    $00

        BRK
.L102D
        EQUB    $00

        BRK
.L102F
        EQUB    $00

        BRK
.L1031
        EQUB    $00

        BRK
.L1033
        EQUB    $00

        BRK
.L1035
        EQUB    $00

        BRK
.L1037
        EQUB    $00

        BRK
.L1039
        EQUB    $00

        BRK
.L103B
        EQUB    $00

        BRK
.L103D
        EQUB    $00

        BRK
.L103F
        EQUB    $00

        BRK
.L1041
        EQUB    $00

        BRK
.L1043
        EQUB    $00

        BRK
.L1045
        EQUB    $00

        BRK
.L1047
        EQUB    $00

        BRK
.L1049
        EQUB    $00

        BRK
.L104B
        EQUB    $00

        BRK
.L104D
        EQUB    $00

        BRK
.L104F
        EQUB    $00

        BRK
.L1051
        EQUB    $00

        BRK
.L1053
        EQUB    $00

        BRK
.L1055
        EQUB    $00

        BRK
.L1057
        EQUB    $00

        BRK
.L1059
        EQUB    $00

        BRK
.L105B
        EQUB    $00

        BRK
.L105D
        EQUB    $00

        BRK
.L105F
        EQUB    $00

        BRK
.L1061
        EQUB    $00

        BRK
.L1063
        EQUB    $00

        BRK
.L1065
        EQUB    $00

        BRK
.L1067
        EQUB    $00

        BRK
.L1069
        EQUB    $00

        BRK
.L106B
        EQUB    $00

        BRK
.L106D
        EQUB    $00

        BRK
.L106F
        EQUB    $00

        BRK
.L1071
        EQUB    $00

        BRK
.L1073
        EQUB    $00

        BRK
.L1075
        EQUB    $00

        BRK
.L1077
        EQUB    $00

        BRK
.L1079
        EQUB    $00

        BRK
.L107B
        EQUB    $00

        BRK
.L107D
        EQUB    $00

        BRK
.L107F
        EQUB    $00

        BRK
.L1081
        EQUB    $00

        BRK
.L1083
        EQUB    $00

        BRK
.L1085
        EQUB    $00

        BRK
.L1087
        EQUB    $00

        BRK
.L1089
        EQUB    $00

        BRK
.L108B
        EQUB    $00

        BRK
.L108D
        EQUB    $00

        BRK
.L108F
        EQUB    $00

        BRK
.L1091
        EQUB    $00

        BRK
.L1093
        EQUB    $00

        BRK
.L1095
        EQUB    $00

        BRK
.L1097
        EQUB    $00

        BRK
.L1099
        EQUB    $00

        BRK
.L109B
        EQUB    $00

        BRK
.L109D
        EQUB    $00

        BRK
.L109F
        EQUB    $00

        BRK
.L10A1
        EQUB    $00

        BRK
.L10A3
        EQUB    $00

        BRK
.L10A5
        EQUB    $00

        BRK
.L10A7
        EQUB    $00

        BRK
.L10A9
        EQUB    $00

        BRK
.L10AB
        EQUB    $00

        BRK
.L10AD
        EQUB    $00

        BRK
.L10AF
        EQUB    $00

        BRK
.L10B1
        EQUB    $00

        BRK
.L10B3
        EQUB    $00

        BRK
.L10B5
        EQUB    $00

        BRK
.L10B7
        EQUB    $00

        BRK
.L10B9
        EQUB    $00

.L10BA
        BRK
.L10BB
        EQUB    $00

        BRK
.L10BD
        EQUB    $00

        BRK
.L10BF
        EQUB    $00

        BRK
.L10C1
        EQUB    $00

        BRK
.L10C3
        EQUB    $00

        BRK
.L10C5
        EQUB    $00

        BRK
.L10C7
        EQUB    $00

        BRK
.L10C9
        EQUB    $00

        BRK
.L10CB
        EQUB    $00

        BRK
.L10CD
        EQUB    $00

        BRK
.L10CF
        EQUB    $00

.L10D0
        BRK
.L10D1
        EQUB    $00

.L10D2
        BRK
.L10D3
        EQUB    $00

        BRK
.L10D5
        EQUB    $00

        BRK
.L10D7
        EQUB    $00

        BRK
.L10D9
        EQUB    $00

        BRK
.L10DB
        EQUB    $00

        BRK
.L10DD
        EQUB    $00

        BRK
.L10DF
        EQUB    $00

        BRK
.L10E1
        EQUB    $00

        BRK
.L10E3
        EQUB    $00

        BRK
.L10E5
        EQUB    $00

        BRK
.L10E7
        EQUB    $00

.L10E8
        BRK
.L10E9
        EQUB    $00

        BRK
.L10EB
        EQUB    $00

.L10EC
        BRK
.L10ED
        EQUB    $00

        BRK
.L10EF
        EQUB    $00

        BRK
.L10F1
        EQUB    $00

        BRK
.L10F3
        EQUB    $00

        BRK
.L10F5
        EQUB    $00

        BRK
.L10F7
        EQUB    $00

        BRK
.L10F9
        EQUB    $00

.L10FA
        BRK
.L10FB
        EQUB    $00

        BRK
.L10FD
        EQUB    $00

        BRK
.L10FF
        EQUB    $00

        BRK
.L1101
        EQUB    $00

.L1102
        BRK
.L1103
        EQUB    $00

        BRK
.L1105
        EQUB    $00

        BRK
.L1107
        EQUB    $00

        BRK
.L1109
        EQUB    $00

        BRK
.L110B
        EQUB    $00

        BRK
.L110D
        EQUB    $00

        BRK
.L110F
        EQUB    $00

.L1110
        BRK
.L1111
        EQUB    $00

        BRK
.L1113
        EQUB    $00

        BRK
.L1115
        EQUB    $00

        BRK
.L1117
        EQUB    $00

        BRK
.L1119
        EQUB    $00

        BRK
.L111B
        EQUB    $00

        BRK
.L111D
        EQUB    $00

        BRK
.L111F
        EQUB    $00

        BRK
.L1121
        EQUB    $00

        BRK
.L1123
        EQUB    $00

        BRK
.L1125
        EQUB    $00

        BRK
.L1127
        EQUB    $00

        BRK
.L1129
        EQUB    $00

        BRK
.L112B
        EQUB    $00

        BRK
.L112D
        EQUB    $00

        BRK
.L112F
        EQUB    $00

        BRK
.L1131
        EQUB    $00

        BRK
.L1133
        EQUB    $00

        BRK
.L1135
        EQUB    $00

        BRK
.L1137
        EQUB    $00

        BRK
.L1139
        EQUB    $00

        BRK
.L113B
        EQUB    $00

        BRK
.L113D
        EQUB    $00

        BRK
.L113F
        EQUB    $00

        BRK
.L1141
        EQUB    $00

        BRK
.L1143
        EQUB    $00

        BRK
.L1145
        EQUB    $00

        BRK
.L1147
        EQUB    $00

        BRK
.L1149
        EQUB    $00

        BRK
.L114B
        EQUB    $00

        BRK
.L114D
        EQUB    $00

        BRK
.L114F
        EQUB    $00

.L1150
        BRK
.L1151
        EQUB    $00

        BRK
.L1153
        EQUB    $00

        BRK
.L1155
        EQUB    $00

        BRK
.L1157
        EQUB    $00

        BRK
.L1159
        EQUB    $00

        BRK
.L115B
        EQUB    $00

        BRK
.L115D
        EQUB    $00

        BRK
.L115F
        EQUB    $00

        BRK
.L1161
        EQUB    $00

        BRK
.L1163
        EQUB    $00

        BRK
.L1165
        EQUB    $00

        BRK
.L1167
        EQUB    $00

        BRK
.L1169
        EQUB    $00

        BRK
.L116B
        EQUB    $00

        BRK
.L116D
        EQUB    $00

        BRK
.L116F
        EQUB    $00

        BRK
.L1171
        EQUB    $00

        BRK
.L1173
        EQUB    $00

        BRK
.L1175
        EQUB    $00

        BRK
.L1177
        EQUB    $00

        BRK
.L1179
        EQUB    $00

        BRK
.L117B
        EQUB    $00

        BRK
.L117D
        EQUB    $00

        BRK
.L117F
        EQUB    $00

        BRK
.L1181
        EQUB    $00

        BRK
.L1183
        EQUB    $00

        BRK
.L1185
        EQUB    $00

        BRK
.L1187
        EQUB    $00

        BRK
.L1189
        EQUB    $00

        BRK
.L118B
        EQUB    $00

        BRK
.L118D
        EQUB    $00

        BRK
.L118F
        EQUB    $00

        BRK
.L1191
        EQUB    $00

        BRK
.L1193
        EQUB    $00

        BRK
.L1195
        EQUB    $00

        BRK
.L1197
        EQUB    $00

        BRK
.L1199
        EQUB    $00

        BRK
.L119B
        EQUB    $00

        BRK
.L119D
        EQUB    $00

        BRK
.L119F
        EQUB    $00

        BRK
.L11A1
        EQUB    $00

        BRK
.L11A3
        EQUB    $00

        BRK
.L11A5
        EQUB    $00

        BRK
.L11A7
        EQUB    $00

        BRK
.L11A9
        EQUB    $00

        BRK
.L11AB
        EQUB    $00

        BRK
.L11AD
        EQUB    $00

        BRK
.L11AF
        EQUB    $00

        BRK
.L11B1
        EQUB    $00

        BRK
.L11B3
        EQUB    $00

        BRK
.L11B5
        EQUB    $00

        BRK
.L11B7
        EQUB    $00

        BRK
.L11B9
        EQUB    $00

        BRK
.L11BB
        EQUB    $00

        BRK
.L11BD
        EQUB    $00

        BRK
.L11BF
        EQUB    $00

        BRK
.L11C1
        EQUB    $00

        BRK
.L11C3
        EQUB    $00

        BRK
.L11C5
        EQUB    $00

        BRK
.L11C7
        EQUB    $00

        BRK
.L11C9
        EQUB    $00

        BRK
.L11CB
        EQUB    $00

        BRK
.L11CD
        EQUB    $00

        BRK
.L11CF
        EQUB    $00

        BRK
.L11D1
        EQUB    $00

        BRK
.L11D3
        EQUB    $00

        BRK
.L11D5
        EQUB    $00

        BRK
.L11D7
        EQUB    $00

        BRK
.L11D9
        EQUB    $00

        BRK
.L11DB
        EQUB    $00

        BRK
.L11DD
        EQUB    $00

        BRK
.L11DF
        EQUB    $00

        BRK
.L11E1
        EQUB    $00

        BRK
.L11E3
        EQUB    $00

        BRK
.L11E5
        EQUB    $00

.L11E6
        BRK
.L11E7
        EQUB    $00

        BRK
.L11E9
        EQUB    $00

        BRK
.L11EB
        EQUB    $00

        BRK
.L11ED
        EQUB    $00

        BRK
.L11EF
        EQUB    $00

        BRK
.L11F1
        EQUB    $00

        BRK
.L11F3
        EQUB    $00

        BRK
.L11F5
        EQUB    $00

        BRK
.L11F7
        EQUB    $00

        BRK
.L11F9
        EQUB    $00

        BRK
.L11FB
        EQUB    $00

        BRK
.L11FD
        EQUB    $00

        BRK
.L11FF
        EQUB    $00

.L1200
        LDA     L09D1
        BPL     L1225

        LDA     L09AC
        AND     #$02
        BEQ     L120F

        JSR     L14DB

.L120F
        LDA     #$02
        STA     L09AD
        LDA     L09D1
        JSR     L1500

        LDA     L09AC
        AND     #$01
        BEQ     L1224

        JSR     L14DB

.L1224
        RTS

.L1225
        LDA     L09AD
        CMP     #$01
        BNE     L122F

        JSR     L14DB

.L122F
        LDA     #$01
        STA     L09AD
        LDA     L09D2
        AND     #$0F
        STA     L09D2
        JSR     L1415

.L123F
        LDA     L04FF
        ORA     L04FE
        BEQ     L12AE

        LDA     L0021
        PHA
        CLC
        ADC     #$03
        STA     L0021
        LDA     L0022
        PHA
        ADC     #$00
        STA     L0022
        LDY     #$00
        LDA     (L0021),Y
        CMP     L09D2
        BEQ     L1264

        BCS     L12A8

        JMP     L127A

.L1264
        LDA     L0021
        SEC
        SBC     #$01
        STA     L0021
        LDA     L0022
        SBC     #$00
        STA     L0022
        LDA     (L0021),Y
        CMP     L09D1
        BEQ     L127A

        BCS     L12A8

.L127A
        PLA
        STA     L0022
        PLA
        STA     L0021
        LDY     #$00
        LDA     (L0021),Y
        STA     L09AF
        JSR     L1327

        LDA     (L0021),Y
        STA     L09B0
        JSR     L1327

        LDA     (L0021),Y
        STA     L09B1
        JSR     L1327

        LDA     (L0021),Y
        STA     L09B2
        JSR     L1327

        JSR     L1335

        JMP     L123F

.L12A8
        PLA
        STA     L0022
        PLA
        STA     L0021
.L12AE
        LDA     L09D1
        SEC
        SBC     L09B1
        STA     L09D1
        LDA     L09D2
        SBC     L09B2
        STA     L09D2
        LDX     L09AF
        LDY     L09B0
        JSR     L139E

        LDX     #$00
        JMP     L12D6

.L12CF
        JSR     L13D6

        STA     L098A,X
        INX
.L12D6
        JSR     L13B1

        CMP     #$1C
        BCC     L12CF

        AND     #$03
        TAX
        LDA     L09D1
        BNE     L12ED

        ORA     L09D2
        BEQ     L12F3

        DEC     L09D2
.L12ED
        DEC     L09D1
        JMP     L12D6

.L12F3
        TXA
        LDX     #$00
.L12F6
        CMP     #$00
        BEQ     L1308

        PHA
        LDA     L098A,X
        JSR     L14DF

        INX
        PLA
        SEC
        SBC     #$01
        BNE     L12F6

.L1308
        JSR     L13B1

        CMP     #$1B
        BCS     L1318

        JSR     L13D6

        JSR     L14DF

        JMP     L1308

.L1318
        RTS

.L1319
        LDA     L001B
        CLC
        ADC     #$01
        STA     L001B
        LDA     L001C
        ADC     #$00
        STA     L001C
        RTS

.L1327
        LDA     L0021
        CLC
        ADC     #$01
        STA     L0021
        LDA     L0022
        ADC     #$00
        STA     L0022
        RTS

.L1335
        LDA     L04FE
        SEC
        SBC     #$01
        STA     L04FE
        LDA     L04FF
        SBC     #$00
        STA     L04FF
        RTS

.L1347
        LDA     #$00
        STA     L002E
        STA     L002F
.L134D
        LDY     #$00
        LDA     (L002C),Y
        PHA
        JSR     L1397

        PLA
        AND     #$3F
        BNE     L136A

        LDA     L002E
        CLC
        ADC     #$3F
        STA     L002E
        LDA     L002F
        ADC     #$00
        STA     L002F
        JMP     L134D

.L136A
        TAY
        DEY
        TYA
        CLC
        ADC     L002E
        STA     L002E
        LDA     L002F
        ADC     #$00
        STA     L002F
        RTS

.L1379
        JSR     L1347

        LDA     L002C
        CLC
        ADC     L002E
        STA     L002C
        LDA     L002D
        ADC     L002F
        STA     L002D
        RTS

.L138A
        LDA     L002D
        CMP     L09C6
        BNE     L1396

        LDA     L002C
        CMP     L09C5
.L1396
        RTS

.L1397
        INC     L002C
        BNE     L139D

        INC     L002D
.L139D
        RTS

.L139E
        TXA
        CLC
        ADC     #$00
        STA     L0010
        TYA
        ADC     #$1E
        STA     L0011
        LDA     #$08
        STA     L09B3
        JMP     L1405

.L13B1
        TXA
        PHA
        LDA     L09B3
        CMP     #$08
        BNE     L13BD

        JSR     L1445

.L13BD
        PHA
        CLC
        ADC     #$01
        STA     L09B3
        PLA
        ADC     #$B5
        STA     L0029
        LDA     #$09
        ADC     #$00
        STA     L002A
        LDY     #$00
        PLA
        TAX
        LDA     (L0029),Y
        RTS

.L13D6
        CMP     #$1A
        BCS     L13DE

        CLC
        ADC     #$61
        RTS

.L13DE
        JSR     L13B1

        CMP     #$10
        BNE     L13F0

        LDA     #$01
        STA     L09AE
        JSR     L13B1

        JMP     L13D6

.L13F0
        ROL     A
        ROL     A
        ROL     A
        ROL     A
        ROL     A
        AND     #$E0
        PHA
        JSR     L13B1

        AND     #$1F
        STA     L0029
        PLA
        ORA     L0029
        ORA     #$80
        RTS

.L1405
        LDA     #$00
.L1407
        AND     #$03
        CLC
        ADC     #$8A
        STA     L001B
        LDA     #$09
        ADC     #$00
        STA     L001C
        RTS

.L1415
        LDA     #$00
        STA     L09B1
        STA     L09B2
        LDA     L1E06
        STA     L09AF
        LDA     L1E07
        STA     L09B0
        LDA     L1E0A
        CLC
        ADC     #$00
        STA     L0021
        LDA     L1E0B
        ADC     #$1E
        STA     L0022
        LDA     L1E0C
        STA     L04FE
        LDA     L1E0D
        STA     L04FF
        RTS

.L1445
        LDY     #$00
        LDA     (L0010),Y
        ROR     A
        ROR     A
        ROR     A
        AND     #$1F
        STA     L09B5
        LDA     (L0010),Y
        STA     L0029
        JSR     L14C4

        LDA     (L0010),Y
        ROL     A
        ROL     L0029
        ROL     A
        ROL     L0029
        LDA     L0029
        AND     #$1F
        STA     L09B6
        LDA     (L0010),Y
        STA     L0029
        ROR     A
        AND     #$1F
        STA     L09B7
        JSR     L14C4

        LDA     L0029
        ROR     A
        LDA     (L0010),Y
        ROR     A
        ROR     A
        ROR     A
        ROR     A
        AND     #$1F
        STA     L09B8
        LDA     (L0010),Y
        STA     L0029
        JSR     L14C4

        LDA     (L0010),Y
        ROL     A
        ROL     L0029
        LDA     L0029
        AND     #$1F
        STA     L09B9
        LDA     (L0010),Y
        STA     L0029
        JSR     L14C4

        LDA     (L0010),Y
        ROR     L0029
        ROR     A
        ROR     L0029
        ROR     A
        TAY
        LDA     L0029
        AND     #$1F
        STA     L09BA
        TYA
        ROR     A
        ROR     A
        ROR     A
        AND     #$1F
        STA     L09BB
        LDY     #$00
        LDA     (L0010),Y
        AND     #$1F
        STA     L09BC
        JSR     L14C4

        LDA     #$00
        RTS

.L14C4
        INC     L0010
        BNE     L14CA

        INC     L0011
.L14CA
        RTS

.L14CB
        LDA     #$00
        STA     L09AD
        STA     L09BF
        LDA     #$2E
        STA     L09BD
        JMP     L15DE

.L14DB
        LDA     #$20
        BNE     L1500

.L14DF
        CMP     #$80
        BCS     L1500

        STA     L0029
        LDA     L09AE
        BNE     L14FB

        LDA     L09AC
        CMP     #$06
        BCS     L14F6

        LDA     L0029
        JMP     L1500

.L14F6
        LDA     #$00
        STA     L09AC
.L14FB
        LDA     L0029
        JSR     L15F5

.L1500
        PHA
        CMP     #$80
        BCS     L1521

        CMP     #$21
        BEQ     L150D

        CMP     #$2A
        BCC     L1530

.L150D
        LDA     L09BD
        CMP     #$21
        BEQ     L151C

        CMP     #$3F
        BEQ     L151C

        CMP     #$2E
        BNE     L1521

.L151C
        PLA
        JSR     L15F5

        PHA
.L1521
        PLA
        AND     #$7F
        CMP     #$21
        BEQ     L152C

        CMP     #$29
        BCC     L152F

.L152C
        STA     L09BD
.L152F
        PHA
.L1530
        CMP     #$20
        BNE     L153F

        JSR     L1593

        LDA     #$FF
        STA     L09BE
        JMP     L155F

.L153F
        CMP     #$0D
        BNE     L154E

        JSR     L1593

        LDA     #$0D
        JSR     L1561

        JMP     L155F

.L154E
        LDY     #$00
        STA     (L0034),Y
        LDA     L0034
        CLC
        ADC     #$01
        STA     L0034
        LDA     L0035
        ADC     #$00
        STA     L0035
.L155F
        PLA
        RTS

.L1561
        CMP     #$0D
        BNE     L157B

        LDA     L09BF
        BEQ     L158A

        LDA     L08C3
        CMP     L09BF
        BCC     L1577

        LDA     #$0D
        JSR     L158B

.L1577
        LDA     #$00
        BEQ     L1587

.L157B
        JSR     L158B

        LDA     L09BF
        CLC
        ADC     #$01
        STA     L09BF
.L1587
        STA     L09BF
.L158A
        RTS

.L158B
        STA     L1101
        LDA     #$02
        JMP     L10FA

.L1593
        LDA     L09BE
        BEQ     L15C8

        JSR     L15EC

        LDA     L09BF
        STA     L09CD
.L15A1
        LDA     L0029
        CMP     L0034
        BCS     L15B6

        JSR     L1869

        LDA     L09CD
        CLC
        ADC     #$01
        STA     L09CD
        JMP     L15A1

.L15B6
        LDA     L08C3
        CMP     L09CD
        BCS     L15C3

        LDA     #$0D
        JMP     L15C5

.L15C3
        LDA     #$20
.L15C5
        JSR     L1561

.L15C8
        JSR     L15EC

.L15CB
        LDA     L0029
        CMP     L0034
        BCS     L15DE

        LDY     #$00
        LDA     (L0029),Y
        JSR     L1561

        JSR     L1869

        JMP     L15CB

.L15DE
        LDA     #$00
        STA     L09BE
        LDA     #$69
        STA     L0034
        LDA     #$09
        STA     L0035
        RTS

.L15EC
        LDA     #$69
        STA     L0029
        LDA     #$09
        STA     L002A
        RTS

.L15F5
        CMP     #$61
        BCC     L1600

        CMP     #$7B
        BCS     L1600

        CLC
        ADC     #$E0
.L1600
        RTS

.L1601
        CMP     #$41
        BCC     L160C

        CMP     #$5B
        BCS     L160C

        CLC
        ADC     #$20
.L160C
        RTS

        LDA     L001F
        ORA     L0020
        BNE     L1626

        JSR     L1593

        JSR     L14CB

        LDX     #$EC
        STX     L001F
        LDY     #$08
        STY     L0020
        LDA     #$04
        JSR     L1B00

.L1626
        LDA     #$48
        STA     L0029
        LDA     #$09
        STA     L002A
.L162E
        LDY     #$00
        LDA     (L001F),Y
        BNE     L164B

        JSR     L184C

        LDA     #$00
        STA     (L0023),Y
        STA     L001F
        STA     L0020
.L163F
        JSR     L0E6E

        JSR     L0E6E

        JSR     L0E6E

        JMP     L0E6E

.L164B
        JSR     L18B3

        BEQ     L1675

        LDY     #$00
        LDA     (L001F),Y
        PHA
        JSR     L1862

        PLA
        CMP     #$20
        BEQ     L162E

        PHA
        STA     L0948
        JSR     L184C

        LDA     #$20
        STA     L0949
        LDA     #$FF
        STA     L09C9
        STA     L09CA
        PLA
        JMP     L17F6

.L1675
        LDY     #$00
        LDA     (L001F),Y
        CMP     #$2D
        BEQ     L169F

        JSR     L18B3

        BEQ     L1689

.L1682
        LDA     #$20
        STA     (L0029),Y
        JMP     L16A5

.L1689
        LDA     (L001F),Y
        JSR     L1601

        STA     (L0029),Y
        JSR     L1869

        LDA     L002A
        CMP     #$09
        BNE     L169D

        LDA     L0029
        CMP     #$67
.L169D
        BCS     L1682

.L169F
        JSR     L1862

        JMP     L1675

.L16A5
        LDA     #$FF
        STA     L09C0
        STA     L09C1
        STA     L09C9
        STA     L09CA
        LDA     L08E8
        STA     L0023
        LDA     L08E9
        STA     L0024
        JSR     L1415

        LDA     L0948
        SEC
        SBC     #$61
        BCS     L16DF

        LDA     L1E06
        STA     L09AF
        LDA     L1E07
        STA     L09B0
        LDA     #$00
        STA     L09B1
        STA     L09B2
        JMP     L1742

.L16DF
        CMP     #$1A
        BCC     L16E8

        LDA     #$67
        JMP     L1702

.L16E8
        STA     L0029
        ASL     L0029
        ASL     L0029
        LDA     L0949
        CMP     #$20
        BEQ     L1702

        SEC
        SBC     #$61
        ROR     A
        ROR     A
        ROR     A
        AND     #$03
        CLC
        ADC     L0029
        STA     L0029
.L1702
        LDA     L0029
        CMP     L1E0C
        BCC     L170C

        JMP     L17F1

.L170C
        LDA     #$00
        CLC
        ROL     L0029
        ROL     A
        ROL     L0029
        ROL     A
        STA     L002A
        LDA     L0029
        ADC     L0021
        STA     L0029
        LDA     L002A
        ADC     L0022
        STA     L002A
        LDY     #$00
        LDA     (L0029),Y
        STA     L09AF
        JSR     L1869

        LDA     (L0029),Y
        STA     L09B0
        JSR     L1869

        LDA     (L0029),Y
        STA     L09B1
        JSR     L1869

        LDA     (L0029),Y
        STA     L09B2
.L1742
        LDX     L09AF
        LDY     L09B0
        JSR     L1870

.L174B
        JSR     L1878

        BCS     L1753

        JMP     L17E7

.L1753
        LDX     #$00
        LDY     #$00
.L1757
        LDA     L098A,Y
        AND     #$7F
        JSR     L1601

        CMP     L0948,X
        BNE     L1769

        INX
        INY
        JMP     L1757

.L1769
        LDA     L0948,X
        CMP     #$20
        BNE     L1792

        LDA     L098A,Y
        BEQ     L17B3

        LDA     L09C0
        AND     L09C1
        CMP     #$FF
        BNE     L17F1

        CPX     #$04
        BCS     L17B3

        LDA     L09B1
        STA     L09C0
        LDA     L09B2
        STA     L09C1
        JMP     L179C

.L1792
        LDA     L09C0
        AND     L09C1
        CMP     #$FF
        BNE     L17A7

.L179C
        INC     L09B1
        BNE     L174B

        INC     L09B2
        JMP     L174B

.L17A7
        LDA     L09C0
        STA     L09B1
        LDA     L09C1
        STA     L09B2
.L17B3
        LDA     L09B1
        STA     L09C9
        LDA     L09B2
        STA     L09CA
        JSR     L18D0

        LDA     #$FF
        STA     L09C0
        STA     L09C1
        LDA     L0023
        CMP     L08E8
        BNE     L17D8

        LDA     L0024
        CMP     L08E9
        BEQ     L179C

.L17D8
        LDA     #$00
        TAY
        STA     (L0023),Y
        JSR     L185B

        LDA     #$00
        STA     (L0023),Y
        JMP     L163F

.L17E7
        LDA     L09C0
        AND     L09C1
        CMP     #$FF
        BNE     L17A7

.L17F1
        JSR     L184C

        LDA     #$80
.L17F6
        STA     (L0023),Y
        JSR     L185B

        JMP     L17D8

        LDY     #$00
        LDA     (L002E),Y
        STA     L0029
        CLC
        ROL     A
        STA     L0029
        STA     L09CD
        LDA     #$00
        ADC     #$00
        STA     L002A
        STA     L09CE
        JSR     L1846

        JSR     L1846

        LDA     L0029
        CLC
        ADC     L09CD
        STA     L0029
        LDA     L002A
        ADC     L09CE
        STA     L002A
        LDA     L0029
        CLC
        ADC     L09D1
        STA     (L002E),Y
        LDA     L002A
        ADC     #$00
        STA     L09D1
        LDA     L002E
        CLC
        ADC     #$01
        STA     L002E
        LDA     L002F
        ADC     #$00
        STA     L002F
        RTS

.L1846
        CLC
        ROL     L0029
        ROL     L002A
        RTS

.L184C
        LDA     L08E8
        STA     L0023
        LDA     L08E9
        STA     L0024
        LDA     #$00
        TAY
        STA     (L0023),Y
.L185B
        INC     L0023
        BNE     L1861

        INC     L0024
.L1861
        RTS

.L1862
        INC     L001F
        BNE     L1868

        INC     L0020
.L1868
        RTS

.L1869
        INC     L0029
        BNE     L186F

        INC     L002A
.L186F
        RTS

.L1870
        JSR     L139E

        LDA     #$1C
        STA     L09C2
.L1878
        LDA     L09C2
        CMP     #$1B
        BEQ     L1895

        JSR     L1407

.L1882
        JSR     L13B1

        PHA
        LDA     L09C7
        CMP     L0010
        BNE     L1897

        LDA     L09C8
        CMP     L0011
        BNE     L1897

        PLA
.L1895
        CLC
        RTS

.L1897
        PLA
        CMP     #$1B
        BCS     L18A9

        JSR     L13D6

        LDY     #$00
        STA     (L001B),Y
        JSR     L1319

        JMP     L1882

.L18A9
        STA     L09C2
        LDA     #$00
        TAY
        STA     (L001B),Y
        SEC
        RTS

.L18B3
        JSR     L15F5

        CMP     #$27
        BEQ     L18CD

        CMP     #$30
        BCC     L18CA

        CMP     #$3A
        BCC     L18CD

        CMP     #$41
        BCC     L18CA

        CMP     #$5B
        BCC     L18CD

.L18CA
        LDA     #$01
        RTS

.L18CD
        LDA     #$00
.L18CF
        RTS

.L18D0
        LDA     #$00
        STA     L0014
        STA     L0015
        JSR     L1102

        JMP     L18DF

.L18DC
        JSR     L0ECE

.L18DF
        JSR     L138A

        BCS     L18CF

        LDY     #$00
        LDA     (L002C),Y
        PHA
        JSR     L1397

        PLA
        BMI     L18FC

        AND     #$40
        BNE     L190A

        JSR     L1990

        JSR     L1379

        JMP     L18DC

.L18FC
        AND     #$7F
        SEC
        ADC     L0014
        STA     L0014
        BCC     L18DF

        INC     L0015
        JMP     L18DF

.L190A
        JSR     L1990

        JSR     L1347

        LDX     L002E
        LDY     L002C
        LDA     #$00
        STA     L002C
        JMP     L1931

.L191B
        INY
        BNE     L1920

        INC     L002D
.L1920
        TXA
        BNE     L1925

        DEC     L002F
.L1925
        DEX
.L1926
        INY
        BNE     L192B

        INC     L002D
.L192B
        TXA
        BNE     L1930

        DEC     L002F
.L1930
        DEX
.L1931
        TXA
        ORA     L002F
        BEQ     L1989

        LDA     (L002C),Y
        BPL     L1926

        CMP     #$90
        BCC     L191B

        AND     #$0F
        CMP     L09B2
        BNE     L191B

        LDA     (L002C),Y
        STA     L09D1
        INY
        BNE     L194F

        INC     L002D
.L194F
        TXA
        BNE     L1954

        DEC     L002F
.L1954
        DEX
        TXA
        BNE     L195A

        DEC     L002F
.L195A
        DEX
        LDA     (L002C),Y
        INY
        BNE     L1962

        INC     L002D
.L1962
        CMP     L09B1
        BNE     L1931

        STY     L002C
        LDY     #$00
        LDA     L09D1
        CLC
        ROL     A
        AND     #$E0
        ORA     L0015
        STA     (L0023),Y
        JSR     L185B

        LDA     L0014
        STA     (L0023),Y
        JSR     L185B

        LDY     L002C
        LDA     #$00
        STA     L002C
        JMP     L1931

.L1989
        STY     L002C
        LDY     #$00
        JMP     L18DC

.L1990
        LDA     L002C
        BNE     L1996

        DEC     L002D
.L1996
        DEC     L002C
.L1998
        RTS

        LDA     L09C9
        AND     L09CA
        CMP     #$FF
        BNE     L19BC

        LDA     #$48
        STA     L002C
        LDA     #$09
        STA     L002D
.L19AB
        LDY     #$00
        LDA     (L002C),Y
        CMP     #$20
        BEQ     L1998

        JSR     L1500

        JSR     L1397

        JMP     L19AB

.L19BC
        LDA     L09C9
        STA     L09D1
        LDA     L09CA
        STA     L09D2
        JMP     L11E6

        JSR     L0B62

        STA     L09E3
        JSR     L0B62

        STA     L001D
        STX     L001E
        JSR     L0B62

        STA     L09DE
        STX     L002B
.L19E0
        ORA     L001D
        BNE     L19E7

        JMP     L1AB7

.L19E7
        LDA     L09E0
        BNE     L19F1

        LDA     L001D
        STA     L09E1
.L19F1
        INC     L09DF
        LDX     L09DF
.L19F7
        LDA     L08DA,X
        L19F8   = L19F7+1
        L19F9   = L19F7+2
        CMP     L09DE
        BEQ     L1A51

        CPX     L09E3
        BCC     L19F1

        LDA     L09E1
        CMP     #$1F
        BNE     L1A2D

        TAX
        LDA     #$00
        STA     L0A20,X
        STA     L001D
.L1A13
        LDX     L001D
        LDA     L0A20,X
        BEQ     L1A25

        LDA     L09DE
        JSR     L1AD7

        LDA     L001D
        JSR     L1AD7

.L1A25
        INC     L001D
        LDA     L001D
        CMP     #$1F
        BCC     L1A13

.L1A2D
        JSR     L1AE7

        STA     L001D
        JSR     L1AE7

        STA     L09DE
        LDA     #$00
        STA     L09E0
        LDA     L001D
        CMP     #$1F
        BNE     L1A46

        INC     L09DD
.L1A46
        JSR     L1AC6

        LDA     L09DE
        BEQ     L1A8C

        JMP     L19E0

.L1A51
        LDX     L09DF
.L1A54
        LDA     L08DC,X
        L1A55   = L1A54+1
        L1A56   = L1A54+2
        AND     #$1F
        STA     L09E2
        CMP     L001D
        BEQ     L1A7B

        CMP     #$00
        BEQ     L19F1

        LDA     L001D
        BEQ     L19F1

        CMP     #$1F
        BEQ     L1A76

        LDX     L09E2
        TXA
        STA     L0A20,X
        JMP     L19F1

.L1A76
        LDA     L09E2
        STA     L001D
.L1A7B
        INC     L09E0
        LDA     L09DF
        JSR     L1AD7

        LDA     #$1F
        JSR     L1AD7

        JMP     L1A96

.L1A8C
        LDA     #$00
        STA     L09DF
        STA     L09DE
        STA     L001D
.L1A96
        LDA     L001D
        LDX     L001E
        STA     L0400,X
        LDA     L09DE
        LDX     L002B
        STA     L0400,X
        LDA     L09DF
        JSR     L10EC

        LDA     L09E0
        JSR     L10EC

        LDA     L09DD
        JMP     L10EC

.L1AB7
        LDA     #$00
        STA     L001A
        LDA     #$00
        STA     L09DD
        JSR     L1AC6

        JMP     L1A96

.L1AC6
        LDA     #$00
        STA     L09E0
        STA     L09DF
        LDX     #$1F
.L1AD0
        STA     L0A1F,X
        DEX
        BNE     L1AD0

        RTS

.L1AD7
        LDX     L001A
        STA     L09E4,X
        INX
        STX     L001A
        CPX     #$3C
        BEQ     L1AE7

        RTS

.L1AE4
        LDA     #$00
        RTS

.L1AE7
        LDX     L001A
        BEQ     L1AE4

        DEX
        STX     L001A
        LDA     L09E4,X
        RTS

.L1AF2
        EQUB    $32

.L1AF3
        EQUB    $0D,$18,$2E,$1D,$20,$4C,$44,$41
        EQUB    $20,$23,$30,$3A,$84

.L1B00
        JMP     L1B89

        JMP     L1C36

        JMP     L1B29

.L1B09
        EQUB    $50

.L1B0A
        EQUB    $4F,$53,$49,$54,$49,$4F,$4E,$0D

.L1B12
        EQUB    $00

.L1B13
        EQUB    $00

.L1B14
        EQUB    $00

.L1B15
        EQUB    $00,$00,$00

.L1B18
        EQUB    $00

.L1B19
        EQUB    $00,$00,$00

.L1B1C
        EQUB    $00

.L1B1D
        EQUB    $00,$00,$00

.L1B20
        EQUB    $00

.L1B21
        EQUB    $00,$00,$00

.L1B24
        EQUB    $00

.L1B25
        EQUB    $00

.L1B26
        EQUB    $00

.L1B27
        EQUB    $00

.L1B28
        EQUB    $00

.L1B29
        JSR     L1B39

        LDA     #$16
        JSR     L1CC0

        LDA     #$07
        JSR     L1CC0

        JMP     BeebDisStartAddr

.L1B39
        LDA     #$00
        STA     L004E
        STA     L0050
        LDA     #$78
        STA     L0051
        LDA     #$0E
        STA     L004F
.L1B47
        JSR     L1CE9

        CMP     #$7C
        BNE     L1B47

        LDA     L1B24
        AND     #$01
        STA     L1B24
        RTS

.L1B57
        LDA     L1B24
        ORA     #$02
        STA     L1B24
        LDA     #$00
        STA     L004E
        STA     L0050
        LDA     #$0E
        STA     L0051
        LDA     #$78
        STA     L004F
.L1B6D
        JSR     L1CE9

        CMP     #$12
        BNE     L1B6D

        LDA     #$00
        STA     L004E
        LDA     #$0E
        STA     L004F
.L1B7C
        LDA     #$00
        TAY
        STA     (L004E),Y
        JSR     L1CCD

        CMP     #$12
        BNE     L1B7C

        RTS

.L1B89
        PHA
        PHP
        STY     L004B
        STX     L004A
        CMP     #$07
        BCC     L1B9C

        LDA     #$01
        LDY     #$00
        STA     (L004A),Y
        JMP     L1BB5

.L1B9C
        ASL     A
        TAX
        LDA     L1BB8,X
        STA     L0048
        LDA     L1BB9,X
        STA     L0049
        LDA     #$1B
        PHA
        LDA     #$B4
        PHA
        LDY     #$00
        LDA     (L004A),Y
        JMP     (L0048)

.L1BB5
        PLP
        PLA
        RTS

.L1BB8
        EQUB    $37

.L1BB9
        EQUB    $1C,$C6,$1B,$AC,$1C,$95,$1C,$02
        EQUB    $1D,$62,$1D,$72,$1D

.L1BC6
        LDY     #$02
        LDA     (L004A),Y
        LDY     #$00
        SEC
        SBC     (L004A),Y
        STA     L1B26
        LDY     #$03
        LDA     (L004A),Y
        LDY     #$01
        SBC     (L004A),Y
        STA     L1B27
        LDA     L1B26
        CLC
        ADC     #$01
        STA     L1B26
        LDA     L1B27
        ADC     #$00
        STA     L1B27
        LDA     #$00
        STA     L0048
        LDY     #$00
        LDA     (L004A),Y
        STA     L004C
        LDY     #$01
        LDA     (L004A),Y
        STA     L004D
.L1BFE
        LDA     L1B26
        ORA     L1B27
        BEQ     L1C30

        LDY     #$00
        LDA     (L004C),Y
        CLC
        ADC     L0048
        STA     L0048
        LDA     L004C
        CLC
        ADC     #$01
        STA     L004C
        LDA     L004D
        ADC     #$00
        STA     L004D
        LDA     L1B26
        SEC
        SBC     #$01
        STA     L1B26
        LDA     L1B27
        SBC     #$00
        STA     L1B27
        JMP     L1BFE

.L1C30
        LDA     L0048
        LDY     #$00
        STA     (L004A),Y
.L1C36
        RTS

        LDA     #$C8
        LDX     #$02
        JSR     LFFF4

        LDA     #$00
        STA     L1B24
        LDA     #$52
        STA     L0202
        LDA     #$1C
        STA     L0203
        LDA     #$0C
        JMP     L1CC0

.L1C52
        LDA     L00FD
        CLC
        ADC     #$01
        STA     L00FD
        LDA     L00FE
        ADC     #$00
        STA     L00FE
        LDY     #$00
        LDA     (L00FD),Y
        BEQ     L1C6B

        JSR     L1CC0

        JMP     L1C52

.L1C6B
        LDA     L1B24
        AND     #$02
        BEQ     L1C75

        JSR     L1B39

.L1C75
        JSR     L1C9D

        BEQ     L1C75

        LDA     #$0D
        JSR     L1CC0

        LDA     L1B24
        PHA
        LDA     #$00
        STA     L1B24
        PLA
        AND     #$01
        BEQ     L1C92

        LDX     L1B25
        TXS
        RTS

.L1C92
        JMP     BeebDisStartAddr

        JSR     L1C9D

        LDY     #$00
        STA     (L004A),Y
        RTS

.L1C9D
        LDA     #$91
        LDX     #$00
        JSR     LFFF4

        BCC     L1CA8

        LDY     #$00
.L1CA8
        TYA
        CMP     #$00
        RTS

        LDY     #$00
        LDA     (L004A),Y
        CMP     #$02
        BEQ     L1CCC

        CMP     #$03
        BEQ     L1CCC

        CMP     #$0E
        BEQ     L1CCC

        CMP     #$0F
        BEQ     L1CCC

.L1CC0
        CMP     #$0D
        BNE     L1CC9

        JSR     L1CC9

        LDA     #$0A
.L1CC9
        JMP     OSWRCH

.L1CCC
        RTS

.L1CCD
        LDA     L004E
        CLC
        ADC     #$01
        STA     L004E
        LDA     L004F
        ADC     #$00
        STA     L004F
        RTS

        LDA     L0050
        CLC
        ADC     #$01
        STA     L0050
        LDA     L0051
        ADC     #$00
        STA     L0051
        RTS

.L1CE9
        LDY     #$00
.L1CEB
        LDA     (L0050),Y
        STA     (L004E),Y
        INY
        TYA
        BNE     L1CEB

        LDA     L004F
        CLC
        ADC     #$01
        STA     L004F
        LDA     L0051
        CLC
        ADC     #$01
        STA     L0051
        RTS

        LDY     #$00
        STY     L1B28
.L1D07
        JSR     L1C9D

        CMP     #$7F
        BEQ     L1D20

        CMP     #$61
        BCC     L1D18

        CMP     #$7B
        BCS     L1D07

        AND     #$DF
.L1D18
        CMP     #$0D
        BEQ     L1D4B

        CMP     #$08
        BNE     L1D32

.L1D20
        LDY     L1B28
        CPY     #$00
        BEQ     L1D07

        DEC     L1B28
        LDA     #$7F
        JSR     L1CC0

        JMP     L1D07

.L1D32
        CMP     #$20
        BCC     L1D07

        LDY     L1B28
        CPY     #$1E
        BCS     L1D07

        LDY     L1B28
        STA     (L004A),Y
        INC     L1B28
        JSR     L1CC0

        JMP     L1D07

.L1D4B
        LDA     #$0D
        JSR     L1CC0

        LDY     L1B28
        LDA     #$20
        STA     (L004A),Y
        INY
        LDA     #$00
        STA     (L004A),Y
        RTS

.L1D5D
        EQUS    "TAPE"

.L1D61
        EQUB    $0D

.L1D62
        TSX
        STX     L1B25
        LDA     L1B24
        ORA     #$01
        STA     L1B24
        LDA     #$00
        BEQ     L1D74

        LDA     #$FF
.L1D74
        PHA
        JSR     L1D9A

        LDA     #$09
        STA     L1B12
        LDA     #$1B
        STA     L1B13
        PLA
        LDX     #$12
        LDY     #$1B
        JSR     LFFDD

        LDA     #$00
        TAY
        STA     (L004A),Y
        LDA     L1B24
        AND     #$02
        STA     L1B24
        JMP     L1B39

.L1D9A
        JSR     L1B57

        LDY     #$1D
        LDX     #$5D
        JSR     LFFF7

        LDX     #$00
.L1DA6
        LDA     #$FF
        STA     L1B12,X
        INX
        TXA
        CMP     #$12
        BNE     L1DA6

        LDY     #$00
        LDA     (L004A),Y
        STA     L1B14
        STA     L1B18
        STA     L1B1C
        LDY     #$01
        LDA     (L004A),Y
        STA     L1B15
        STA     L1B19
        STA     L1B1D
        LDY     #$02
        LDA     (L004A),Y
        STA     L1B20
        LDY     #$03
        LDA     (L004A),Y
        STA     L1B21
        RTS

.L1DDA
        EQUB    $15

.L1DDB
        LDA     #$20
        BNE     L1E00

        CMP     #$80
        BCS     L1E00

        STA     L0029
        LDA     L09AE
        BNE     L1DFB

        LDA     L09AC
        CMP     #$06
        BCS     L1DF6

        LDA     L0029
        JMP     L1500

.L1DF6
        LDA     #$00
        STA     L09AC
.L1DFB
        LDA     L0029
        JSR     L15F5

.L1E00
        EQUB    $71

.L1E01
        EQUB    $56

.L1E02
        EQUB    $28

.L1E03
        EQUB    $04

.L1E04
        EQUB    $D0

.L1E05
        EQUB    $16

.L1E06
        EQUB    $F8

.L1E07
        EQUB    $1A

.L1E08
        EQUB    $DE

.L1E09
        EQUB    $0A

.L1E0A
        EQUB    $D6

.L1E0B
        EQUB    $25

.L1E0C
        EQUB    $66

.L1E0D
        EQUB    $00

.L1E0E
        EQUB    $6E

.L1E0F
        EQUB    $27,$32,$32

.L1E12
        EQUB    $2A

.L1E13
        EQUB    $00,$00,$00,$7E,$02,$00,$80,$96
        EQUB    $80,$9C,$03,$A2,$03,$2C,$81,$C4
        EQUB    $81,$3E,$82,$4E,$82,$71,$28,$5B
        EQUB    $9C,$99,$05,$93,$01,$93,$02,$96
        EQUB    $7B,$99,$06,$99,$07,$99,$08,$99
        EQUB    $09,$97,$77,$80,$00,$80,$00,$80
        EQUB    $00,$80,$00,$80,$00,$80,$00,$80
        EQUB    $00,$80,$00,$91,$13,$97,$15,$94
        EQUB    $15,$97,$16,$97,$17,$91,$18,$93
        EQUB    $D9,$80,$00,$92,$1B,$93,$1C,$93
        EQUB    $1D,$9B,$CA,$01,$38,$95,$1F,$95
        EQUB    $28,$17,$27,$92,$26,$13,$28,$96
        EQUB    $23,$98,$27,$14,$29,$98,$20,$96
        EQUB    $29,$92,$1E,$95,$21,$92,$25,$96
        EQUB    $24,$18,$22,$96,$29,$91,$26,$80
        EQUB    $00,$92,$1D,$15,$38,$94,$2E,$9A
        EQUB    $A5,$92,$BA,$11,$36,$94,$32,$99
        EQUB    $32,$94,$34,$95,$C1,$93,$33,$91
        EQUB    $37,$91,$35,$88,$C5,$13,$A2,$94
        EQUB    $B7,$94,$AB,$94,$3C,$91,$AB,$97
        EQUB    $AD,$93,$94,$12,$53,$94,$C8,$80
        EQUB    $00,$80,$00,$93,$7B,$22,$7B,$23
        EQUB    $43,$A4,$81,$07,$42,$93,$7D,$92
        EQUB    $7D,$93,$8B,$91,$45,$93,$48,$14
        EQUB    $A1,$95,$3D,$94,$4A,$16,$97,$94
        EQUB    $98,$94,$4C,$B4,$B0,$97,$AF,$13
        EQUB    $BC,$92,$4F,$15,$BF,$93,$50,$92
        EQUB    $33,$97,$BD,$91,$C4,$91,$12,$91
        EQUB    $DD,$91,$54,$94,$77,$29,$7A,$95
        EQUB    $04,$93,$88,$80,$00,$80,$00,$11
        EQUB    $6F,$97,$5F,$0A,$57,$11,$70,$97
        EQUB    $5B,$0A,$9A,$91,$5A,$0A,$49,$11
        EQUB    $72,$97,$5D,$0A,$50,$11,$73,$97
        EQUB    $5E,$0A,$1A,$11,$5B,$97,$64,$0A
        EQUB    $1E,$11,$5C,$97,$60,$0A,$B6,$11
        EQUB    $5D,$97,$61,$0A,$BB,$11,$5E,$97
        EQUB    $62,$0A,$01,$11,$5F,$97,$63,$0A
        EQUB    $C7,$11,$60,$97,$69,$0A,$52,$11
        EQUB    $61,$97,$65,$0A,$03,$11,$62,$97
        EQUB    $66,$0A,$A8,$11,$63,$97,$67,$0A
        EQUB    $31,$11,$64,$97,$68,$0A,$3E,$11
        EQUB    $65,$97,$6E,$0A,$D9,$11,$66,$97
        EQUB    $6A,$0A,$AA,$11,$67,$97,$6B,$0A
        EQUB    $B4,$11,$68,$97,$6C,$0A,$C0,$11
        EQUB    $69,$97,$6D,$0A,$C9,$11,$6A,$97
        EQUB    $73,$0A,$3C,$11,$6B,$97,$6F,$0A
        EQUB    $4D,$11,$6C,$97,$70,$0A,$BB,$11
        EQUB    $6D,$97,$71,$0A,$12,$11,$6E,$97
        EQUB    $72,$9A,$80,$97,$74,$96,$75,$97
        EQUB    $76,$91,$77,$98,$75,$8A,$57,$86
        EQUB    $42,$98,$04,$92,$7C,$91,$7D,$97
        EQUB    $7E,$93,$81,$15,$86,$81,$42,$92
        EQUB    $83,$95,$84,$96,$88,$97,$84,$11
        EQUB    $44,$94,$84,$97,$86,$92,$84,$95
        EQUB    $8A,$94,$8B,$92,$8C,$95,$8E,$97
        EQUB    $48,$94,$8D,$94,$8E,$21,$91,$95
        EQUB    $8F,$84,$90,$98,$91,$94,$92,$99
        EQUB    $7F,$19,$80,$94,$96,$94,$97,$94
        EQUB    $2D,$95,$9A,$96,$98,$92,$9E,$94
        EQUB    $9A,$98,$9A,$97,$9A,$91,$A0,$97
        EQUB    $9E,$98,$A1,$80,$00,$93,$9C,$01
        EQUB    $A4,$95,$4C,$81,$A5,$8A,$A6,$84
        EQUB    $A7,$05,$AA,$86,$A3,$91,$A7,$81
        EQUB    $A5,$01,$A9,$96,$AB,$98,$AC,$94
        EQUB    $3A,$9A,$C1,$12,$4C,$98,$AB,$91
        EQUB    $B1,$81,$4C,$91,$B2,$96,$4C,$95
        EQUB    $B5,$94,$B5,$95,$B8,$91,$B5,$95
        EQUB    $2F,$91,$B7,$96,$B7,$98,$B9,$81
        EQUB    $1A,$95,$BD,$91,$BF,$92,$BD,$93
        EQUB    $C0,$95,$51,$80,$00,$95,$C3,$92
        EQUB    $C9,$92,$C3,$91,$C3,$97,$C5,$98
        EQUB    $52,$86,$37,$95,$3E,$9A,$CB,$9A
        EQUB    $CC,$9A,$CD,$96,$CF,$94,$CF,$80
        EQUB    $00,$97,$CF,$94,$D3,$98,$D1,$94
        EQUB    $D4,$94,$D5,$95,$D7,$98,$D4,$94
        EQUB    $D8,$DC,$D9,$93,$14,$57,$DC,$92
        EQUB    $DB,$94,$DD,$98,$D3,$94,$54,$95
        EQUB    $55,$00,$00,$00,$00,$00,$8F,$07
        EQUB    $64,$00,$46,$05,$49,$00,$04,$00
        EQUB    $00,$04,$39,$00,$78,$00,$03,$00
        EQUB    $02,$00,$00,$07,$00,$00,$9D,$00
        EQUB    $00,$00,$42,$00,$00,$00,$2A,$00
        EQUB    $00,$00,$00,$00,$93,$00,$00,$00
        EQUB    $48,$00,$8E,$00,$76,$00,$51,$07
        EQUB    $14,$00,$00,$00,$9C,$07,$66,$00
        EQUB    $47,$00,$00,$0B,$1B,$09,$75,$00
        EQUB    $00,$01,$74,$04,$4C,$00,$00,$01
        EQUB    $60,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$01
        EQUB    $74,$00,$FE,$00,$00,$04,$3C,$04
        EQUB    $00,$00,$00,$00,$00,$00,$C9,$00
        EQUB    $DA,$00,$55,$00,$A5,$00,$35,$07
        EQUB    $61,$00,$FC,$00,$55,$00,$DE,$01
        EQUB    $76,$00,$2E,$00,$7A,$00,$9E,$00
        EQUB    $D9,$00,$00,$00,$41,$00,$AD,$00
        EQUB    $4E,$00,$00,$00,$B7,$00,$00,$00
        EQUB    $98,$00,$4B,$00,$A8,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$03,$00
        EQUB    $03,$00,$04,$07,$00,$00,$85,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$80,$49,$80,$52,$80,$30,$00
        EQUB    $7A,$00,$82,$00,$9A,$00,$8B,$00
        EQUB    $90,$00,$88,$00,$2C,$00,$87,$00
        EQUB    $00,$00,$00,$00,$00,$00,$31,$00
        EQUB    $77,$00,$CE,$00,$57,$01,$5F,$00
        EQUB    $4E,$00,$87,$00,$79,$00,$56,$80
        EQUB    $51,$02,$78,$80,$02,$00,$A0,$00
        EQUB    $01,$00,$7C,$00,$7E,$00,$B6,$06
        EQUB    $60,$00,$00,$00,$00,$00,$38,$00
        EQUB    $39,$00,$3A,$00,$3B,$00,$3C,$00
        EQUB    $3D,$00,$00,$00,$01,$00,$00,$00
        EQUB    $01,$11,$88,$00,$00,$00,$00,$00
        EQUB    $00,$00,$B7,$B9,$BA,$2F,$00,$00
        EQUB    $32,$03,$64,$00,$4B,$05,$1E,$00
        EQUB    $00,$14,$32,$00,$00,$14,$32,$00
        EQUB    $00,$14,$32,$88,$00,$0A,$5A,$00
        EQUB    $1E,$0A,$32,$00,$00,$05,$14,$88
        EQUB    $00,$28,$C8,$88,$00,$14,$64,$88
        EQUB    $00,$0A,$1E,$88,$00,$0A,$5A,$88
        EQUB    $5F,$05,$05,$88,$1E,$14,$32,$88
        EQUB    $1E,$05,$FF,$88,$1E,$0A,$14,$88
        EQUB    $14,$06,$0A,$00,$0A,$06,$1E,$88
        EQUB    $14,$0A,$1E,$00,$46,$04,$14,$88
        EQUB    $14,$05,$0A,$88,$1E,$0A,$14,$88
        EQUB    $28,$0A,$1E,$88,$3C,$03,$0F,$88
        EQUB    $0A,$05,$0A,$00,$0A,$05,$0F,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$5B,$24,$14,$00,$D0,$16,$E4
        EQUB    $16,$DE,$0A,$C2,$21,$66,$00,$5A
        EQUB    $23,$32,$32,$00,$00,$80,$02,$00
        EQUB    $02,$65,$03,$0D,$00,$03,$05,$00
        EQUB    $03,$8F,$8D,$03,$18,$00,$04,$05
        EQUB    $8F,$8D,$04,$14,$8F,$8D,$03,$05
        EQUB    $00,$05,$80,$F9,$13,$00,$07,$0C
        EQUB    $80,$F8,$81,$A3,$00,$05,$00,$70
        EQUB    $06,$3A,$06,$00,$70,$0C,$58,$3A
        EQUB    $04,$00,$18,$00,$05,$25,$2D,$12
        EQUB    $00,$80,$09,$8F,$8D,$83,$60,$82
        EQUB    $03,$14,$00,$03,$65,$00,$02,$0A
        EQUB    $03,$06,$00,$03,$07,$00,$03,$0C
        EQUB    $00,$03,$1D,$00,$05,$08,$80,$70
        EQUB    $2E,$44,$B2,$12,$00,$43,$B3,$30
        EQUB    $43,$B0,$44,$81,$48,$81,$59,$57
        EQUB    $8F,$80,$B0,$32,$47,$B1,$84,$8F
        EQUB    $80,$B1,$8C,$45,$81,$59,$B1,$29
        EQUB    $46,$10,$8F,$80,$B3,$6D,$80,$03
        EQUB    $80,$2B,$04,$81,$C3,$12,$04,$82
        EQUB    $A6,$12,$04,$80,$93,$19,$04,$81
        EQUB    $04,$19,$80,$02,$09,$02,$09,$02
        EQUB    $09,$04,$09,$80,$77,$03,$09,$52
        EQUB    $02,$09,$02,$09,$02,$09,$02,$13
        EQUB    $02,$09,$02,$09,$81,$02,$09,$02
        EQUB    $09,$94,$04,$13,$2D,$12,$81,$03
        EQUB    $82,$23,$03,$13,$52,$80,$03,$13
        EQUB    $10,$83,$05,$13,$81,$C3,$12,$05
        EQUB    $13,$82,$A6,$12,$43,$B2,$0B,$43
        EQUB    $B3,$35,$43,$B0,$D4,$43,$B3,$17
        EQUB    $43,$B2,$1F,$85,$47,$91,$FC,$8F
        EQUB    $80,$91,$EF,$47,$91,$FD,$8F,$80
        EQUB    $91,$F2,$47,$90,$E5,$8F,$80,$90
        EQUB    $E3,$47,$92,$BA,$8F,$80,$92,$73
        EQUB    $47,$92,$BB,$8F,$80,$92,$87,$47
        EQUB    $92,$BC,$8F,$80,$92,$E9,$47,$93
        EQUB    $5F,$8F,$80,$93,$44,$47,$91,$FE
        EQUB    $8F,$80,$92,$05,$49,$93,$36,$8F
        EQUB    $80,$93,$2C,$93,$35,$49,$90,$D5
        EQUB    $8F,$80,$90,$B9,$90,$D4,$4B,$91
        EQUB    $84,$8F,$80,$91,$8B,$90,$F0,$91
        EQUB    $8C,$47,$92,$21,$8F,$80,$92,$1F
        EQUB    $80,$43,$90,$92,$47,$91,$94,$8F
        EQUB    $80,$91,$6D,$82,$49,$92,$27,$8F
        EQUB    $80,$91,$06,$92,$FF,$80,$47,$90
        EQUB    $0A,$8F,$80,$90,$05,$43,$91,$8D
        EQUB    $80,$43,$92,$50,$47,$92,$63,$8F
        EQUB    $80,$91,$B8,$43,$92,$7C,$43,$92
        EQUB    $81,$43,$93,$3C,$43,$90,$61,$47
        EQUB    $93,$46,$8F,$80,$93,$45,$80,$43
        EQUB    $92,$12,$43,$92,$0B,$81,$43,$91
        EQUB    $64,$83,$4B,$90,$33,$8F,$80,$91
        EQUB    $97,$90,$5F,$92,$B0,$43,$91,$BB
        EQUB    $43,$91,$B5,$80,$49,$90,$F5,$8F
        EQUB    $80,$92,$52,$92,$89,$43,$90,$B7
        EQUB    $82,$43,$91,$9A,$43,$90,$79,$87
        EQUB    $43,$91,$34,$47,$92,$F0,$8F,$80
        EQUB    $91,$34,$43,$93,$55,$43,$90,$DC
        EQUB    $43,$92,$4D,$43,$92,$5C,$43,$93
        EQUB    $11,$43,$91,$3D,$43,$92,$CD,$43
        EQUB    $91,$AF,$43,$92,$A5,$43,$90,$2E
        EQUB    $80,$43,$92,$18,$80,$47,$91,$B1
        EQUB    $8F,$80,$90,$67,$43,$90,$FC,$49
        EQUB    $92,$47,$8F,$80,$92,$4C,$93,$1C
        EQUB    $43,$92,$4A,$81,$43,$92,$66,$43
        EQUB    $91,$0D,$43,$90,$E6,$43,$90,$C6
        EQUB    $43,$92,$72,$43,$90,$6B,$43,$91
        EQUB    $8A,$43,$92,$7D,$43,$92,$33,$43
        EQUB    $92,$C5,$43,$90,$D6,$81,$43,$93
        EQUB    $0E,$43,$90,$D7,$47,$92,$3D,$8F
        EQUB    $80,$90,$4F,$47,$93,$7B,$8F,$80
        EQUB    $93,$68,$43,$93,$80,$43,$91,$F7
        EQUB    $43,$90,$51,$E3,$43,$C1,$4E,$43
        EQUB    $C2,$30,$45,$C1,$0A,$C1,$AA,$45
        EQUB    $C2,$A1,$C1,$CC,$45,$C3,$39,$C2
        EQUB    $39,$80,$43,$C3,$26,$43,$C2,$49
        EQUB    $45,$C0,$EB,$C0,$AD,$43,$C0,$72
        EQUB    $45,$C1,$B7,$C1,$D3,$45,$D0,$B3
        EQUB    $C0,$3B,$43,$C0,$63,$43,$C0,$2D
        EQUB    $43,$C3,$63,$43,$C0,$8F,$45,$D0
        EQUB    $50,$C0,$5C,$43,$C2,$C6,$80,$43
        EQUB    $C0,$3A,$43,$C0,$3C,$43,$C0,$57
        EQUB    $43,$C0,$59,$43,$C0,$6F,$43,$C0
        EQUB    $AF,$43,$C1,$45,$43,$C1,$9C,$43
        EQUB    $C2,$46,$43,$C2,$29,$45,$C2,$3B
        EQUB    $C0,$29,$80,$43,$C2,$66,$43,$C2
        EQUB    $68,$46,$C2,$36,$1E,$C2,$76,$43
        EQUB    $C2,$85,$43,$C2,$95,$43,$C2,$A8
        EQUB    $43,$C2,$F3,$8A,$43,$C1,$99,$43
        EQUB    $C0,$38,$43,$C2,$EE,$43,$C0,$90
        EQUB    $43,$C2,$44,$81,$45,$C2,$D9,$C0
        EQUB    $88,$45,$C2,$D9,$C1,$7F,$43,$C1
        EQUB    $30,$45,$C1,$CE,$C2,$D1,$45,$C1
        EQUB    $39,$C0,$4E,$43,$C1,$0C,$43,$C1
        EQUB    $DB,$43,$C1,$DE,$43,$C1,$ED,$45
        EQUB    $C1,$39,$C2,$C2,$45,$C1,$39,$C2
        EQUB    $AF,$43,$C0,$3E,$43,$C3,$5E,$45
        EQUB    $C0,$1C,$C0,$2A,$45,$C0,$BD,$C2
        EQUB    $BE,$43,$C1,$38,$43,$C1,$46,$43
        EQUB    $C1,$E6,$43,$C1,$36,$43,$C2,$A7
        EQUB    $80,$43,$C3,$69,$43,$C3,$77,$43
        EQUB    $C3,$8B,$83,$43,$C1,$CD,$43,$C0
        EQUB    $FE,$45,$C3,$6F,$C2,$39,$45,$D0
        EQUB    $4B,$C0,$3B,$43,$C2,$99,$45,$C2
        EQUB    $D9,$C1,$14,$82,$43,$C1,$6B,$43
        EQUB    $C0,$11,$43,$C0,$11,$43,$C0,$53
        EQUB    $43,$C0,$46,$47,$C0,$8A,$8F,$80
        EQUB    $C0,$89,$45,$C1,$49,$C0,$95,$43
        EQUB    $C0,$B6,$43,$C0,$C2,$47,$C1,$89
        EQUB    $12,$07,$C0,$7E,$45,$C1,$C9,$C1
        EQUB    $9F,$43,$C1,$AD,$82,$43,$C2,$3A
        EQUB    $43,$C1,$D3,$43,$C2,$65,$43,$C2
        EQUB    $6E,$45,$D2,$58,$C1,$DD,$43,$C2
        EQUB    $7B,$45,$C2,$EE,$C2,$41,$43,$C2
        EQUB    $EF,$43,$C3,$4C,$43,$C3,$58,$45
        EQUB    $C2,$B6,$C1,$F1,$43,$C3,$73,$45
        EQUB    $C2,$EE,$C1,$68,$43,$C3,$41,$43
        EQUB    $C3,$4D,$43,$C2,$F6,$43,$C2,$B2
        EQUB    $43,$C3,$5A,$81,$43,$C2,$34,$43
        EQUB    $C2,$34,$43,$C2,$34,$43,$C2,$34
        EQUB    $43,$C2,$34,$43,$C2,$34,$80,$47
        EQUB    $C3,$84,$8F,$80,$C1,$D0,$43,$C1
        EQUB    $14,$43,$C0,$D2,$43,$C0,$FF,$47
        EQUB    $C2,$26,$8F,$80,$C2,$24,$43,$C0
        EQUB    $D2,$A5,$47,$C0,$F4,$8F,$80,$C0
        EQUB    $0D,$45,$C0,$F6,$C0,$6C,$49,$C1
        EQUB    $8F,$8F,$80,$C3,$01,$C3,$07,$03
        EQUB    $83,$0C,$03,$83,$07,$43,$A3,$08
        EQUB    $45,$A3,$0B,$A2,$B3,$82,$47,$D0
        EQUB    $4B,$8F,$80,$C0,$89,$47,$D0,$64
        EQUB    $8F,$80,$C0,$89,$47,$D2,$58,$8F
        EQUB    $80,$C0,$89,$47,$D2,$1B,$8F,$80
        EQUB    $C0,$89,$47,$D3,$7E,$8F,$80,$C0
        EQUB    $89,$47,$D1,$4C,$8F,$80,$C0,$89
        EQUB    $47,$D0,$50,$8F,$80,$C0,$89,$47
        EQUB    $D3,$42,$8F,$80,$C0,$89,$47,$D1
        EQUB    $4D,$8F,$80,$C0,$89,$47,$D3,$66
        EQUB    $8F,$80,$C0,$89,$94,$43,$C1,$C4
        EQUB    $43,$C0,$D3,$43,$C2,$8B,$43,$C1
        EQUB    $0E,$43,$C1,$15,$43,$C1,$96,$43
        EQUB    $C0,$55,$43,$C3,$7A,$43,$C0,$C3
        EQUB    $43,$C2,$C4,$43,$C3,$8A,$43,$C0
        EQUB    $F3,$43,$C1,$20,$43,$C3,$89,$43
        EQUB    $C0,$BF,$43,$C2,$77,$43,$C1,$7D
        EQUB    $43,$C1,$78,$8A,$43,$C3,$4F,$47
        EQUB    $C3,$43,$8F,$80,$C1,$ED,$47,$C1
        EQUB    $52,$8F,$80,$C1,$1E,$47,$C3,$48
        EQUB    $8F,$80,$C3,$49,$47,$C2,$A9,$8F
        EQUB    $80,$C2,$E6,$AD,$0E,$0F,$29,$08
        EQUB    $81,$E9,$80,$3F,$81,$C5,$19,$83
        EQUB    $37,$21,$04,$37,$80,$D3,$43,$C3
        EQUB    $1F,$48,$C2,$A1,$C2,$80,$37,$81
        EQUB    $0E,$45,$06,$21,$C1,$65,$80,$43
        EQUB    $C1,$D1,$04,$37,$83,$7A,$43,$C3
        EQUB    $72,$43,$C2,$F5,$43,$C0,$8D,$43
        EQUB    $C1,$CA,$43,$C2,$1C,$43,$C2,$1C
        EQUB    $43,$C0,$0E,$43,$C3,$3E,$04,$37
        EQUB    $81,$7D,$43,$C3,$71,$80,$43,$C0
        EQUB    $73,$43,$C0,$98,$43,$C1,$74,$08
        EQUB    $81,$71,$19,$80,$A4,$81,$6A,$46
        EQUB    $06,$C0,$4A,$C0,$6F,$43,$C1,$D1
        EQUB    $43,$C3,$3A,$43,$C1,$74,$04,$24
        EQUB    $83,$21,$05,$83,$28,$83,$8A,$43
        EQUB    $C1,$D1,$80,$45,$42,$06,$C0,$C4
        EQUB    $45,$C1,$CA,$C0,$98,$43,$C2,$1C
        EQUB    $18,$80,$78,$1C,$0D,$8F,$8D,$80
        EQUB    $78,$1C,$80,$31,$82,$F7,$0D,$8F
        EQUB    $8D,$79,$80,$78,$1C,$80,$C8,$05
        EQUB    $43,$C2,$1C,$43,$C1,$74,$43,$C1
        EQUB    $CA,$8A,$43,$C2,$93,$43,$C2,$93
        EQUB    $43,$C2,$93,$43,$C2,$93,$43,$C2
        EQUB    $93,$81,$44,$06,$C2,$D1,$47,$80
        EQUB    $02,$8F,$BB,$C2,$D9,$43,$C3,$2D
        EQUB    $04,$37,$82,$C4,$43,$C1,$73,$43
        EQUB    $C3,$2D,$43,$C0,$5D,$43,$C3,$2D
        EQUB    $43,$C0,$14,$43,$C3,$2D,$43,$C2
        EQUB    $AD,$43,$C3,$2D,$43,$C1,$55,$43
        EQUB    $C3,$3E,$43,$C2,$FD,$43,$C3,$2D
        EQUB    $43,$C1,$D1,$43,$C0,$14,$43,$C3
        EQUB    $1F,$43,$C0,$58,$80,$43,$C3,$1F
        EQUB    $43,$C3,$1F,$43,$C2,$AD,$83,$46
        EQUB    $06,$C3,$40,$C3,$59,$08,$82,$72
        EQUB    $0F,$36,$1F,$80,$FF,$02,$33,$02
        EQUB    $31,$02,$33,$02,$33,$83,$05,$83
        EQUB    $2F,$07,$7C,$43,$C1,$CA,$45,$C2
        EQUB    $71,$C0,$53,$80,$43,$C2,$06,$43
        EQUB    $C0,$1F,$48,$C0,$A8,$07,$83,$5F
        EQUB    $C3,$48,$45,$C2,$E4,$C2,$06,$80
        EQUB    $45,$C0,$62,$C3,$4F,$45,$10,$07
        EQUB    $C1,$1E,$81,$43,$C2,$F4,$05,$82
        EQUB    $53,$82,$77,$48,$C0,$A8,$07,$82
        EQUB    $BA,$C3,$48,$28,$0A,$81,$EB,$81
        EQUB    $05,$09,$31,$0D,$8F,$8D,$81,$EB
        EQUB    $81,$E6,$83,$34,$05,$8F,$8D,$81
        EQUB    $7B,$80,$E2,$10,$81,$67,$82,$37
        EQUB    $0D,$8F,$8D,$18,$43,$07,$81,$37
        EQUB    $81,$D8,$0A,$43,$C2,$E4,$43,$C0
        EQUB    $62,$44,$06,$C0,$9A,$48,$C2,$D6
        EQUB    $6D,$70,$07,$C1,$1E,$04,$37,$81
        EQUB    $C4,$43,$C1,$CB,$43,$C2,$D7,$80
        EQUB    $47,$C2,$54,$39,$06,$C1,$10,$47
        EQUB    $82,$E2,$10,$07,$C0,$7E,$47,$4E
        EQUB    $06,$C2,$DF,$C3,$27,$05,$32,$07
        EQUB    $82,$2D,$45,$32,$06,$C1,$5F,$43
        EQUB    $C1,$16,$04,$6B,$81,$63,$81,$44
        EQUB    $32,$C2,$DA,$49,$32,$06,$83,$3E
        EQUB    $C0,$BD,$C2,$BE,$44,$32,$C1,$DF
        EQUB    $45,$32,$06,$C1,$38,$45,$32,$06
        EQUB    $C3,$5E,$44,$32,$C1,$ED,$80,$46
        EQUB    $06,$C1,$CA,$C2,$BF,$05,$06,$4C
        EQUB    $83,$25,$04,$37,$80,$F3,$43,$C1
        EQUB    $4D,$43,$C3,$71,$43,$C3,$71,$FF
        EQUB    $FF,$82,$46,$06,$C3,$6B,$C0,$D8
        EQUB    $44,$06,$C3,$74,$46,$06,$C1,$65
        EQUB    $C1,$2F,$46,$06,$C2,$6B,$C1,$2F
        EQUB    $44,$06,$C3,$41,$44,$06,$C3,$41
        EQUB    $46,$07,$C3,$41,$C3,$1B,$46,$06
        EQUB    $C2,$AE,$C2,$6B,$44,$06,$C2,$6B
        EQUB    $87,$46,$06,$C1,$4A,$C2,$38,$46
        EQUB    $06,$C1,$4A,$C2,$38,$44,$1D,$C2
        EQUB    $D5,$44,$1D,$C2,$D5,$44,$1D,$C2
        EQUB    $D5,$44,$1D,$C2,$D5,$44,$1D,$C2
        EQUB    $D5,$80,$46,$06,$C2,$69,$C2,$20
        EQUB    $46,$06,$C1,$4A,$C2,$38,$46,$06
        EQUB    $C2,$D9,$C2,$20,$46,$06,$C1,$4A
        EQUB    $C2,$38,$46,$06,$C2,$CE,$C2,$D9
        EQUB    $46,$06,$C2,$CE,$C2,$D9,$46,$06
        EQUB    $C2,$CE,$C2,$D9,$46,$06,$C2,$CE
        EQUB    $C2,$D9,$46,$06,$C2,$CE,$C2,$D9
        EQUB    $46,$06,$C2,$CE,$C2,$D9,$46,$06
        EQUB    $C2,$CE,$C2,$D9,$44,$06,$C2,$35
        EQUB    $44,$06,$C2,$35,$44,$06,$C2,$35
        EQUB    $44,$06,$C2,$35,$44,$06,$C2,$35
        EQUB    $44,$06,$C2,$2E,$80,$46,$06,$C1
        EQUB    $9F,$C2,$97,$46,$06,$C3,$7E,$C2
        EQUB    $67,$46,$06,$C2,$AC,$C2,$AB,$46
        EQUB    $06,$C2,$AC,$C2,$6C,$46,$06,$C0
        EQUB    $BB,$C0,$7C,$46,$06,$C2,$67,$C0
        EQUB    $43,$44,$07,$C2,$67,$44,$06,$C0
        EQUB    $52,$46,$07,$C1,$A0,$C2,$C7,$46
        EQUB    $06,$C3,$50,$C3,$29,$46,$06,$C3
        EQUB    $50,$C3,$29,$44,$06,$C0,$52,$46
        EQUB    $06,$C2,$6A,$C2,$6C,$46,$06,$C0
        EQUB    $BD,$C2,$6C,$46,$06,$C2,$A2,$C2
        EQUB    $6C,$48,$06,$C0,$BD,$C0,$BE,$C0
        EQUB    $EE,$46,$06,$C3,$6B,$C0,$A6,$44
        EQUB    $06,$C1,$56,$46,$06,$C0,$DF,$C1
        EQUB    $2D,$81,$48,$06,$C2,$13,$C1,$47
        EQUB    $C2,$6C,$46,$06,$C1,$D6,$C0,$A6
        EQUB    $48,$80,$48,$06,$C1,$73,$C1,$2E
        EQUB    $46,$07,$C2,$31,$C2,$6C,$44,$06
        EQUB    $C2,$78,$46,$0C,$C1,$86,$C2,$78
        EQUB    $46,$0C,$C0,$E7,$C0,$B2,$46,$06
        EQUB    $C0,$56,$C0,$80,$47,$0C,$C0,$1E
        EQUB    $66,$C0,$0C,$47,$0C,$C0,$1E,$66
        EQUB    $C0,$82,$46,$06,$C2,$59,$C2,$6C
        EQUB    $44,$0C,$C0,$11,$46,$0C,$C2,$11
        EQUB    $C0,$80,$46,$06,$C1,$CE,$C3,$3B
        EQUB    $44,$06,$C3,$18,$44,$06,$C1,$E1
        EQUB    $45,$C3,$58,$C0,$7D,$44,$06,$C2
        EQUB    $FA,$46,$06,$C1,$41,$C1,$33,$46
        EQUB    $0C,$C1,$7E,$C2,$6C,$46,$07,$C1
        EQUB    $DD,$C2,$6C,$46,$06,$C2,$8F,$C0
        EQUB    $0C,$46,$07,$81,$FC,$C3,$1E,$46
        EQUB    $06,$C0,$BE,$80,$EE,$80,$47,$07
        EQUB    $C1,$D5,$1E,$C3,$16,$98,$44,$06
        EQUB    $C1,$A0,$46,$07,$C0,$35,$C0,$F8
        EQUB    $46,$07,$83,$5F,$C0,$35,$46,$07
        EQUB    $80,$E5,$C0,$35,$44,$06,$C2,$57
        EQUB    $44,$0C,$C2,$0C,$44,$06,$C0,$45
        EQUB    $46,$06,$C1,$CE,$C1,$56,$46,$06
        EQUB    $C2,$EF,$C2,$6C,$45,$06,$4C,$C1
        EQUB    $A0,$46,$06,$C1,$EA,$C1,$56,$46
        EQUB    $06,$C2,$C3,$C2,$C8,$44,$06,$C2
        EQUB    $C9,$48,$0C,$C2,$06,$C2,$25,$C0
        EQUB    $A6,$44,$06,$C0,$7F,$48,$0C,$82
        EQUB    $10,$C2,$88,$C2,$6C,$48,$06,$C3
        EQUB    $66,$C3,$71,$C0,$A6,$46,$06,$C2
        EQUB    $DD,$C2,$6C,$48,$0C,$C2,$06,$C2
        EQUB    $25,$C0,$A6,$46,$06,$C2,$DD,$C2
        EQUB    $6C,$46,$0C,$C0,$24,$C0,$A6,$44
        EQUB    $06,$C1,$9D,$44,$06,$C2,$B4,$46
        EQUB    $06,$C0,$9C,$C1,$95,$46,$06,$C2
        EQUB    $74,$C0,$A6,$46,$06,$C2,$5F,$C2
        EQUB    $6C,$44,$06,$C1,$AE,$44,$06,$C1
        EQUB    $AE,$44,$06,$C2,$E3,$46,$06,$C0
        EQUB    $E1,$C1,$6B,$46,$06,$C0,$9B,$C2
        EQUB    $6C,$44,$06,$C3,$22,$44,$0C,$C0
        EQUB    $0C,$44,$06,$C1,$6B,$46,$06,$C0
        EQUB    $49,$C1,$6B,$44,$06,$C1,$95,$43
        EQUB    $C2,$FC,$46,$06,$C2,$DD,$C2,$6C
        EQUB    $46,$0C,$C0,$F2,$C1,$56,$44,$0C
        EQUB    $C0,$0C,$46,$0C,$C0,$F2,$C1,$56
        EQUB    $46,$06,$C0,$63,$C0,$B4,$46,$0C
        EQUB    $C0,$EC,$C0,$A6,$44,$06,$C0,$B4
        EQUB    $46,$06,$C2,$25,$C0,$A6,$46,$06
        EQUB    $C2,$70,$C3,$29,$44,$06,$C2,$2B
        EQUB    $46,$06,$C2,$DD,$C2,$6C,$46,$06
        EQUB    $C2,$DD,$C2,$6C,$44,$1D,$C2,$D5
        EQUB    $46,$06,$C0,$8D,$C2,$6C,$46,$06
        EQUB    $C2,$31,$C2,$6C,$46,$06,$C3,$23
        EQUB    $C2,$6C,$46,$06,$C2,$DD,$C2,$6C
        EQUB    $46,$06,$C2,$DD,$C2,$6C,$46,$06
        EQUB    $82,$58,$C2,$6C,$46,$06,$81,$4C
        EQUB    $C2,$6C,$44,$1D,$C2,$D5,$46,$06
        EQUB    $C2,$AE,$C2,$6C,$46,$06,$81,$BF
        EQUB    $C0,$7F,$46,$0C,$81,$85,$C2,$6C
        EQUB    $46,$06,$82,$98,$C0,$A6,$44,$06
        EQUB    $C0,$94,$46,$06,$C2,$DD,$C2,$6C
        EQUB    $44,$06,$C2,$28,$44,$06,$C1,$95
        EQUB    $46,$06,$C0,$9B,$C2,$DD,$44,$06
        EQUB    $C2,$86,$44,$06,$C0,$A6,$46,$06
        EQUB    $C3,$15,$C0,$A6,$46,$06,$C3,$13
        EQUB    $C2,$C5,$46,$06,$C2,$D9,$C0,$26
        EQUB    $46,$06,$C2,$D9,$C0,$7C,$46,$06
        EQUB    $C2,$D9,$C2,$3C,$46,$06,$C2,$6F
        EQUB    $C2,$6C,$44,$06,$C0,$7D,$44,$06
        EQUB    $C1,$51,$44,$1D,$C2,$D5,$44,$06
        EQUB    $C1,$9D,$46,$06,$C0,$65,$C1,$95
        EQUB    $46,$06,$C1,$40,$C0,$7C,$46,$06
        EQUB    $C2,$98,$C0,$A6,$44,$06,$C2,$DE
        EQUB    $46,$06,$C1,$D6,$C2,$6C,$46,$06
        EQUB    $C1,$40,$C2,$6C,$47,$07,$C1,$56
        EQUB    $1E,$C2,$D2,$44,$06,$C2,$35,$44
        EQUB    $1D,$C2,$D5,$44,$1D,$C2,$D5,$44
        EQUB    $1D,$C2,$D5,$46,$06,$C2,$69,$C0
        EQUB    $65,$46,$06,$C2,$69,$C0,$65,$46
        EQUB    $06,$C2,$69,$C0,$65,$46,$0C,$C0
        EQUB    $24,$C0,$A6,$46,$06,$C0,$4B,$C2
        EQUB    $6C,$46,$0C,$C0,$24,$C0,$A6,$46
        EQUB    $0C,$C0,$24,$C0,$A6,$46,$0C,$C0
        EQUB    $24,$C0,$A6,$46,$06,$C1,$92,$C2
        EQUB    $6C,$49,$06,$C2,$D1,$66,$C1,$B4
        EQUB    $C2,$6C,$46,$0C,$C0,$F2,$C1,$56
        EQUB    $44,$06,$C2,$45,$48,$06,$81,$73
        EQUB    $C1,$56,$C1,$D4,$46,$06,$C0,$B8
        EQUB    $C0,$80,$46,$06,$C2,$D9,$C2,$6C
        EQUB    $46,$07,$C1,$4B,$C0,$80,$47,$07
        EQUB    $C3,$18,$1E,$C1,$ED,$CD,$4A,$00
        EQUB    $82,$21,$06,$C1,$CA,$81,$2A,$3A
        EQUB    $06,$00,$10,$07,$82,$EA,$C9,$08
        EQUB    $00,$43,$81,$20,$09,$83,$79,$BA
        EQUB    $08,$00,$43,$82,$8B,$09,$83,$79
        EQUB    $85,$05,$00,$10,$07,$31,$08,$00
        EQUB    $43,$80,$C3,$09,$83,$79,$FF,$FF
        EQUB    $FF,$FF,$A9,$04,$25,$12,$00,$04
        EQUB    $25,$10,$00,$80,$06,$08,$11,$83
        EQUB    $37,$00,$05,$00,$81,$B3,$17,$06
        EQUB    $4D,$2A,$83,$31,$00,$83,$04,$80
        EQUB    $E9,$14,$04,$08,$11,$2E,$04,$08
        EQUB    $2A,$30,$04,$08,$41,$30,$82,$05
        EQUB    $1A,$34,$71,$04,$81,$07,$2A,$80
        EQUB    $3F,$82,$A0,$04,$04,$82,$09,$04
        EQUB    $06,$81,$71,$82,$E0,$04,$86,$07
        EQUB    $81,$A7,$0F,$80,$0F,$04,$06,$81
        EQUB    $26,$2B,$0F,$04,$05,$81,$81,$0F
        EQUB    $04,$08,$46,$81,$3D,$0C,$82,$07
        EQUB    $04,$08,$46,$81,$3D,$0C,$82,$07
        EQUB    $04,$05,$46,$80,$EA,$04,$04,$20
        EQUB    $5B,$04,$81,$06,$81,$7C,$80,$A0
        EQUB    $04,$81,$04,$08,$11,$00,$80,$04
        EQUB    $08,$11,$00,$03,$17,$04,$83,$03
        EQUB    $11,$04,$03,$11,$04,$03,$11,$04
        EQUB    $07,$0F,$9F,$BF,$68,$9F,$BF,$80
        EQUB    $05,$8F,$A8,$82,$5D,$03,$24,$07
        EQUB    $06,$81,$13,$8F,$A9,$05,$81,$04
        EQUB    $80,$E9,$14,$05,$80,$E9,$9F,$BF
        EQUB    $05,$27,$80,$A0,$04,$05,$27,$82
        EQUB    $4E,$04,$05,$27,$80,$19,$04,$05
        EQUB    $27,$80,$2B,$04,$04,$80,$DE,$00
        EQUB    $04,$82,$F2,$00,$04,$81,$3E,$00
        EQUB    $04,$82,$19,$00,$07,$08,$81,$61
        EQUB    $06,$82,$83,$08,$00,$83,$70,$81
        EQUB    $AB,$08,$04,$08,$4E,$06,$81,$11
        EQUB    $81,$50,$04,$0A,$07,$74,$81,$3E
        EQUB    $06,$73,$81,$BB,$04,$85,$04,$81
        EQUB    $F5,$04,$06,$83,$68,$34,$9F,$BF
        EQUB    $04,$82,$0D,$04,$04,$82,$0D,$04
        EQUB    $8F,$5B,$83,$5B,$19,$07,$82,$48
        EQUB    $1E,$81,$C8,$03,$80,$A5,$AF,$A8
        EQUB    $80,$6E,$9F,$A9,$80,$00,$24,$C1
        EQUB    $AC,$80,$03,$04,$04,$08,$11,$2E
        EQUB    $04,$08,$2A,$30,$04,$08,$41,$30
        EQUB    $08,$08,$11,$2E,$17,$81,$66,$04
        EQUB    $80,$06,$08,$82,$23,$20,$04,$80
        EQUB    $04,$1A,$31,$04,$04,$20,$5B,$04
        EQUB    $04,$20,$5B,$04,$04,$20,$5B,$04
        EQUB    $03,$33,$04,$04,$00,$20,$04,$09
        EQUB    $08,$11,$81,$42,$17,$83,$53,$04
        EQUB    $07,$08,$81,$69,$07,$3A,$04,$08
        EQUB    $07,$3A,$80,$97,$80,$44,$00,$05
        EQUB    $1A,$41,$58,$04,$80,$04,$08,$81
        EQUB    $0F,$07,$08,$11,$81,$E3,$17,$04
        EQUB    $07,$0F,$80,$CE,$80,$66,$04,$07
        EQUB    $0F,$83,$70,$81,$E3,$04,$08,$08
        EQUB    $11,$82,$4D,$0F,$71,$04,$80,$08
        EQUB    $08,$11,$81,$42,$71,$9F,$A1,$08
        EQUB    $46,$80,$DC,$0F,$81,$13,$04,$07
        EQUB    $08,$11,$80,$92,$17,$04,$80,$05
        EQUB    $83,$62,$9F,$A1,$06,$4D,$11,$2E
        EQUB    $0F,$04,$06,$25,$12,$0F,$9F,$A1
        EQUB    $04,$68,$9F,$BF,$04,$43,$9F,$BF
        EQUB    $06,$25,$52,$0F,$9F,$A1,$0C,$46
        EQUB    $83,$28,$64,$03,$82,$7E,$68,$42
        EQUB    $9F,$BF,$06,$83,$65,$82,$14,$14
        EQUB    $04,$40,$68,$14,$80,$05,$09,$81
        EQUB    $2B,$04,$81,$07,$08,$11,$83,$55
        EQUB    $17,$04,$07,$08,$11,$82,$51,$0F
        EQUB    $04,$05,$2A,$80,$5B,$04,$05,$2A
        EQUB    $80,$5B,$04,$05,$2A,$80,$5B,$04
        EQUB    $06,$25,$41,$52,$17,$04,$07,$08
        EQUB    $2A,$81,$F4,$19,$04,$0A,$07,$80
        EQUB    $F8,$80,$97,$80,$44,$08,$04,$04
        EQUB    $82,$F1,$04,$04,$80,$DD,$04,$04
        EQUB    $83,$75,$04,$03,$49,$04,$05,$83
        EQUB    $82,$9F,$A1,$06,$83,$16,$82,$2C
        EQUB    $04,$04,$82,$75,$04,$04,$81,$D7
        EQUB    $04,$81,$07,$83,$7F,$79,$81,$F6
        EQUB    $00,$8A,$07,$81,$F8,$83,$4B,$17
        EQUB    $04,$03,$49,$04,$03,$49,$04,$06
        EQUB    $81,$71,$82,$43,$04,$03,$49,$04
        EQUB    $8C,$03,$8F,$A8,$04,$8F,$A9,$04
        EQUB    $87,$07,$82,$55,$82,$61,$14,$00
        EQUB    $08,$8F,$8D,$82,$47,$82,$BD,$04
        EQUB    $07,$82,$55,$82,$63,$14,$00,$0B
        EQUB    $8F,$8D,$46,$80,$1B,$83,$7F,$79
        EQUB    $81,$F6,$81,$0D,$08,$13,$80,$BE
        EQUB    $04,$08,$81,$48,$19,$80,$3F,$00
        EQUB    $05,$80,$A3,$14,$00,$08,$1F,$82
        EQUB    $7A,$09,$82,$90,$04,$0C,$8F,$8D
        EQUB    $83,$2B,$82,$62,$79,$82,$60,$65
        EQUB    $00,$A7,$04,$0C,$80,$25,$04,$06
        EQUB    $81,$C6,$04,$06,$83,$6E,$04,$06
        EQUB    $81,$C7,$04,$06,$82,$B8,$04,$06
        EQUB    $82,$C1,$04,$06,$82,$92,$04,$06
        EQUB    $82,$B7,$04,$06,$80,$A1,$04,$0C
        EQUB    $80,$22,$04,$06,$82,$01,$FF,$EE
        EQUB    $09,$07,$7F,$09,$10,$07,$81,$52
        EQUB    $04,$06,$07,$7F,$82,$84,$04,$0C
        EQUB    $83,$0D,$81,$01,$24,$80,$2B,$28
        EQUB    $82,$6D,$04,$06,$07,$7F,$82,$9F
        EQUB    $04,$07,$1A,$80,$68,$83,$54,$04
        EQUB    $08,$07,$80,$72,$80,$69,$3F,$04
        EQUB    $07,$07,$83,$73,$80,$69,$04,$07
        EQUB    $08,$11,$81,$B1,$0F,$04,$08,$08
        EQUB    $80,$70,$2E,$80,$49,$04,$0A,$07
        EQUB    $81,$D3,$09,$10,$07,$83,$53,$04
        EQUB    $05,$82,$B0,$9F,$A1,$09,$08,$80
        EQUB    $B7,$48,$06,$80,$8B,$04,$07,$08
        EQUB    $30,$4A,$81,$10,$04,$08,$07,$81
        EQUB    $F1,$82,$17,$3F,$04,$08,$07,$80
        EQUB    $72,$81,$43,$48,$04,$03,$49,$04
        EQUB    $80,$07,$07,$3A,$80,$AC,$58,$04
        EQUB    $81,$07,$08,$81,$61,$81,$FA,$04
        EQUB    $08,$07,$81,$FA,$13,$81,$BE,$04
        EQUB    $0D,$80,$04,$81,$F0,$81,$6F,$82
        EQUB    $17,$82,$2D,$9F,$A1,$08,$07,$81
        EQUB    $FA,$80,$C5,$3F,$04,$86,$07,$1A
        EQUB    $81,$E2,$80,$6A,$04,$08,$83,$0A
        EQUB    $6B,$4C,$81,$A9,$04,$85,$0A,$07
        EQUB    $3E,$81,$35,$08,$07,$83,$63,$04
        EQUB    $09,$08,$83,$24,$57,$06,$83,$63
        EQUB    $04,$0B,$08,$11,$81,$0F,$0F,$10
        EQUB    $07,$81,$D4,$04,$08,$1D,$78,$82
        EQUB    $B9,$81,$6C,$04,$08,$07,$78,$82
        EQUB    $B9,$81,$FB,$04,$07,$07,$78,$82
        EQUB    $EC,$51,$04,$07,$80,$C7,$80,$D1
        EQUB    $9F,$A1,$83,$07,$07,$22,$09,$80
        EQUB    $9D,$00,$08,$07,$80,$8A,$13,$80
        EQUB    $9D,$00,$07,$07,$22,$80,$FB,$9F
        EQUB    $A1,$05,$1A,$80,$96,$04,$06,$03
        EQUB    $83,$65,$09,$58,$05,$1A,$80,$ED
        EQUB    $04,$83,$06,$1A,$6F,$81,$67,$04
        EQUB    $06,$82,$53,$81,$78,$04,$08,$1A
        EQUB    $82,$D8,$6F,$81,$67,$04,$81,$07
        EQUB    $07,$72,$80,$DE,$3F,$04,$05,$80
        EQUB    $76,$9F,$A1,$09,$07,$81,$68,$10
        EQUB    $07,$80,$7E,$04,$81,$0A,$07,$80
        EQUB    $B6,$09,$10,$07,$83,$53,$04,$08
        EQUB    $07,$21,$80,$B6,$80,$C9,$04,$82
        EQUB    $08,$08,$80,$C6,$06,$4C,$3D,$04
        EQUB    $07,$08,$81,$0D,$0F,$64,$04,$05
        EQUB    $08,$83,$11,$00,$05,$36,$07,$3D
        EQUB    $04,$0B,$81,$13,$81,$0D,$10,$1F
        EQUB    $81,$A1,$3D,$04,$0A,$83,$0F,$81
        EQUB    $52,$09,$6F,$81,$5B,$04,$08,$08
        EQUB    $81,$F4,$06,$82,$99,$04,$08,$08
        EQUB    $80,$B7,$06,$82,$C6,$04,$9A,$07
        EQUB    $07,$3E,$81,$1B,$48,$04,$07,$07
        EQUB    $3E,$27,$83,$76,$04,$0A,$07,$3E
        EQUB    $80,$85,$07,$80,$4E,$3F,$04,$06
        EQUB    $07,$3E,$80,$CC,$04,$09,$07,$3E
        EQUB    $09,$82,$15,$4C,$9F,$A1,$05,$07
        EQUB    $4F,$11,$04,$07,$08,$11,$81,$50
        EQUB    $0F,$04,$82,$08,$06,$80,$95,$3C
        EQUB    $81,$F3,$04,$09,$07,$80,$95,$81
        EQUB    $43,$80,$55,$04,$06,$07,$83,$16
        EQUB    $09,$00,$04,$00,$80,$12,$04,$00
        EQUB    $82,$40,$0B,$07,$82,$76,$80,$DA
        EQUB    $07,$82,$AF,$3F,$04,$0B,$80,$BF
        EQUB    $09,$37,$43,$07,$7C,$83,$4E,$04
        EQUB    $07,$25,$83,$86,$64,$9F,$A1,$05
        EQUB    $82,$1E,$9F,$A1,$80,$08,$0C,$80
        EQUB    $38,$81,$02,$12,$08,$08,$08,$81
        EQUB    $61,$06,$82,$83,$04,$82,$07,$81
        EQUB    $A4,$80,$08,$18,$00,$0A,$81,$B9
        EQUB    $24,$07,$81,$03,$82,$9E,$04,$82
        EQUB    $0A,$29,$03,$0A,$80,$1A,$07,$82
        EQUB    $65,$0A,$80,$0B,$29,$03,$0A,$83
        EQUB    $83,$81,$CF,$82,$2A,$0A,$86,$08
        EQUB    $07,$80,$20,$80,$4D,$08,$04,$09
        EQUB    $08,$81,$21,$57,$07,$80,$20,$04
        EQUB    $82,$0B,$07,$3B,$82,$91,$80,$2C
        EQUB    $08,$80,$23,$04,$08,$08,$81,$61
        EQUB    $06,$80,$91,$04,$08,$18,$07,$3B
        EQUB    $80,$AB,$5D,$04,$0B,$08,$82,$8D
        EQUB    $80,$BC,$18,$81,$A5,$51,$04,$08
        EQUB    $07,$3B,$82,$5B,$82,$E8,$04,$08
        EQUB    $07,$3B,$80,$B1,$07,$63,$04,$0A
        EQUB    $07,$3B,$09,$81,$59,$57,$07,$63
        EQUB    $04,$09,$07,$3B,$09,$12,$07,$81
        EQUB    $52,$04,$81,$08,$25,$83,$12,$70
        EQUB    $82,$BD,$04,$11,$07,$80,$4B,$80
        EQUB    $3B,$80,$07,$07,$1C,$18,$80,$B0
        EQUB    $19,$80,$E0,$04,$82,$27,$9F,$8D
        EQUB    $8F,$8D,$83,$5C,$80,$D0,$03,$08
        EQUB    $30,$80,$C0,$35,$9F,$A1,$71,$13
        EQUB    $83,$2A,$83,$3F,$1E,$1F,$81,$2C
        EQUB    $04,$5E,$08,$83,$4A,$07,$81,$47
        EQUB    $82,$14,$9F,$BF,$2B,$08,$80,$E2
        EQUB    $10,$06,$81,$C2,$80,$7A,$03,$82
        EQUB    $FB,$81,$57,$18,$81,$24,$5F,$81
        EQUB    $C0,$82,$8E,$18,$83,$38,$1F,$21
        EQUB    $83,$6C,$04,$08,$30,$80,$40,$07
        EQUB    $82,$48,$1E,$81,$C8,$9F,$A1,$2B
        EQUB    $07,$82,$4F,$39,$21,$4E,$80,$D9
        EQUB    $08,$81,$C5,$04,$08,$13,$81,$B9
        EQUB    $10,$06,$81,$DA,$80,$30,$03,$80
        EQUB    $75,$39,$5F,$82,$04,$83,$67,$81
        EQUB    $75,$1F,$82,$08,$42,$80,$81,$81
        EQUB    $3A,$04,$86,$1D,$07,$81,$46,$29
        EQUB    $03,$0A,$83,$83,$80,$70,$30,$07
        EQUB    $81,$CC,$81,$80,$08,$81,$0F,$81
        EQUB    $D0,$55,$81,$E0,$80,$9F,$0A,$04
        EQUB    $0D,$07,$81,$46,$81,$3E,$08,$07
        EQUB    $82,$A1,$81,$CC,$04,$09,$0A,$81
        EQUB    $7C,$34,$52,$17,$0E,$0A,$86,$09
        EQUB    $25,$34,$81,$C5,$80,$EF,$9F,$A1
        EQUB    $0A,$08,$80,$83,$83,$1D,$07,$81
        EQUB    $32,$04,$11,$06,$83,$43,$29,$03
        EQUB    $0A,$81,$12,$81,$3D,$55,$19,$35
        EQUB    $05,$9F,$A2,$09,$0A,$17,$83,$70
        EQUB    $5E,$05,$9F,$A2,$0C,$0A,$4D,$82
        EQUB    $E7,$17,$83,$6A,$5E,$05,$9F,$A2
        EQUB    $05,$00,$80,$C9,$04,$0C,$0A,$82
        EQUB    $14,$81,$3B,$83,$6A,$5E,$05,$9F
        EQUB    $A2,$82,$0B,$06,$5A,$80,$DE,$82
        EQUB    $16,$1F,$51,$9F,$A1,$12,$83,$0A
        EQUB    $06,$81,$BD,$80,$AA,$03,$55,$81
        EQUB    $02,$18,$07,$5A,$81,$19,$04,$0A
        EQUB    $07,$5A,$09,$80,$93,$6F,$83,$14
        EQUB    $04,$07,$08,$82,$D0,$82,$96,$04
        EQUB    $07,$07,$5A,$09,$82,$96,$04,$06
        EQUB    $1F,$53,$80,$86,$04,$0A,$82,$03
        EQUB    $07,$81,$DC,$53,$80,$86,$04,$82
        EQUB    $08,$0A,$81,$58,$59,$7B,$61,$0A
        EQUB    $0E,$07,$81,$0C,$29,$03,$0A,$81
        EQUB    $3C,$81,$D0,$55,$0A,$04,$09,$0A
        EQUB    $49,$04,$81,$6D,$10,$0A,$04,$09
        EQUB    $07,$61,$81,$E4,$82,$D4,$12,$04
        EQUB    $0D,$81,$5E,$82,$4B,$07,$61,$82
        EQUB    $16,$07,$82,$97,$04,$80,$08,$08
        EQUB    $81,$94,$36,$07,$44,$04,$08,$08
        EQUB    $81,$1F,$36,$07,$44,$04,$0D,$08
        EQUB    $11,$82,$D3,$83,$2F,$44,$39,$6B
        EQUB    $81,$BA,$04,$0B,$08,$81,$17,$2B
        EQUB    $03,$81,$31,$39,$44,$04,$13,$0A
        EQUB    $82,$0E,$9F,$A1,$4A,$80,$AE,$80
        EQUB    $F6,$5F,$83,$33,$81,$9E,$0E,$9F
        EQUB    $A2,$88,$09,$83,$0A,$06,$81,$08
        EQUB    $1E,$21,$04,$06,$83,$1A,$83,$1A
        EQUB    $04,$0B,$07,$83,$58,$81,$02,$12
        EQUB    $07,$82,$C2,$04,$0B,$07,$81,$DE
        EQUB    $81,$19,$24,$28,$82,$5A,$04,$FF
        EQUB    $FF,$89,$04,$80,$CD,$20,$05,$09
        EQUB    $34,$80,$09,$04,$09,$83,$2E,$86
        EQUB    $03,$5E,$20,$05,$13,$34,$80,$09
        EQUB    $04,$13,$83,$2E,$D6,$04,$50,$80
        EQUB    $17,$05,$81,$53,$80,$16,$92,$03
        EQUB    $80,$8C,$03,$82,$ED,$03,$83,$78
        EQUB    $8F,$09,$06,$82,$8A,$80,$F8,$81
        EQUB    $A3,$00,$92,$05,$80,$41,$06,$4F
        EQUB    $05,$80,$42,$06,$4F,$06,$80,$42
        EQUB    $06,$15,$4F,$90,$05,$50,$83,$5D
        EQUB    $64,$05,$27,$6B,$81,$60,$05,$09
        EQUB    $81,$76,$51,$90,$04,$50,$80,$17
        EQUB    $05,$80,$84,$40,$08,$91,$05,$13
        EQUB    $41,$80,$36,$03,$20,$5B,$80,$06
        EQUB    $83,$02,$41,$80,$D0,$0D,$69,$18
        EQUB    $80,$DE,$07,$83,$26,$80,$2C,$0F
        EQUB    $81,$19,$02,$69,$02,$69,$02,$69
        EQUB    $05,$1A,$41,$80,$36,$81,$19,$0F
        EQUB    $80,$9E,$19,$81,$B0,$04,$08,$2E
        EQUB    $35,$80,$33,$07,$80,$A7,$03,$82
        EQUB    $9B,$83,$89,$18,$81,$96,$04,$08
        EQUB    $07,$81,$5F,$81,$E7,$81,$15,$47
        EQUB    $25,$82,$E5,$36,$C2,$DA,$0A,$06
        EQUB    $31,$82,$BE,$81,$A6,$24,$07,$2F
        EQUB    $0C,$07,$81,$DF,$80,$A9,$3F,$24
        EQUB    $80,$E4,$82,$1D,$09,$06,$81,$38
        EQUB    $81,$A6,$24,$07,$2F,$06,$07,$83
        EQUB    $5E,$81,$72,$08,$81,$EE,$2F,$82
        EQUB    $F8,$08,$04,$0C,$0F,$80,$60,$06
        EQUB    $80,$8F,$12,$07,$81,$28,$04,$04
        EQUB    $13,$34,$21,$04,$1A,$34,$21,$06
        EQUB    $83,$03,$39,$07,$00,$04,$00,$1C
        EQUB    $04,$04,$1A,$80,$18,$04,$1A,$80
        EQUB    $18,$03,$1A,$21,$8C,$04,$50,$83
        EQUB    $76,$92,$05,$08,$2E,$05,$04,$03
        EQUB    $20,$04,$91,$07,$83,$83,$13,$83
        EQUB    $20,$04,$92,$05,$08,$2E,$20,$04
        EQUB    $0B,$1F,$80,$2F,$80,$54,$81,$1D
        EQUB    $48,$05,$04,$09,$25,$82,$15,$0C
        EQUB    $81,$83,$9F,$A1,$09,$08,$82,$64
        EQUB    $19,$1F,$80,$54,$04,$8F,$04,$81
        EQUB    $1C,$6C,$04,$82,$A3,$5D,$04,$13
        EQUB    $81,$22,$81,$04,$81,$1D,$6C,$04
        EQUB    $82,$A4,$5D,$80,$05,$82,$5B,$82
        EQUB    $D8,$04,$81,$1D,$6C,$05,$09,$81
        EQUB    $22,$04,$05,$0F,$82,$EB,$04,$80
        EQUB    $0D,$07,$5C,$09,$82,$B3,$80,$9B
        EQUB    $08,$81,$A5,$51,$04,$85,$07,$13
        EQUB    $81,$69,$5F,$81,$B2,$07,$09,$81
        EQUB    $69,$5F,$81,$B2,$07,$35,$81,$77
        EQUB    $81,$B2,$04,$90,$0A,$80,$0D,$81
        EQUB    $F3,$21,$82,$DC,$9F,$A1,$0F,$81
        EQUB    $EE,$21,$82,$DC,$9F,$A1,$81,$5E
        EQUB    $80,$B0,$19,$80,$E0,$91,$06,$80
        EQUB    $41,$82,$79,$04,$08,$54,$10,$82
        EQUB    $79,$81,$6F,$04,$91,$04,$50,$82
        EQUB    $FE,$04,$27,$82,$FE,$04,$13,$82
        EQUB    $FE,$90,$06,$11,$81,$79,$83,$88
        EQUB    $08,$4E,$4A,$81,$D2,$19,$81,$79
        EQUB    $03,$81,$A2,$03,$81,$A2,$04,$27
        EQUB    $80,$FA,$05,$81,$82,$08,$04,$04
        EQUB    $27,$73,$04,$B4,$04,$80,$33,$00
        EQUB    $04,$80,$34,$00,$04,$42,$06,$00
        EQUB    $03,$00,$1C,$05,$03,$80,$7B,$00
        EQUB    $07,$00,$76,$1E,$80,$BA,$04,$0B
        EQUB    $1A,$80,$BE,$18,$28,$80,$54,$80
        EQUB    $C9,$04,$07,$00,$76,$1E,$80,$BA
        EQUB    $04,$81,$08,$04,$07,$80,$4F,$3C
        EQUB    $1F,$00,$08,$04,$07,$80,$4F,$3C
        EQUB    $28,$00,$07,$04,$07,$1C,$3C,$1F
        EQUB    $00,$07,$04,$07,$1C,$3C,$28,$00
        EQUB    $06,$03,$82,$94,$0F,$04,$05,$07
        EQUB    $1C,$3C,$00,$07,$00,$1C,$83,$57
        EQUB    $59,$04,$08,$00,$80,$6C,$08,$80
        EQUB    $CB,$04,$08,$00,$80,$6C,$0F,$80
        EQUB    $CC,$04,$08,$08,$2A,$81,$9B,$17
        EQUB    $1C,$04,$03,$30,$00,$03,$4E,$00
        EQUB    $06,$00,$82,$CB,$76,$04,$07,$81
        EQUB    $97,$0C,$80,$1C,$04,$07,$81,$98
        EQUB    $0C,$80,$1C,$04,$06,$03,$83,$65
        EQUB    $4E,$00,$08,$00,$82,$CB,$76,$81
        EQUB    $A9,$04,$08,$08,$2A,$81,$9B,$2B
        EQUB    $21,$04,$0A,$08,$80,$C5,$1E,$82
        EQUB    $10,$80,$0B,$04,$04,$07,$80,$F7
        EQUB    $06,$07,$81,$36,$1E,$00,$05,$80
        EQUB    $21,$9F,$A1,$87,$06,$80,$F0,$24
        EQUB    $07,$00,$06,$80,$F1,$24,$07,$00
        EQUB    $07,$81,$A7,$03,$81,$44,$00,$07
        EQUB    $81,$A8,$03,$81,$44,$00,$85,$05
        EQUB    $17,$1C,$82,$5E,$07,$00,$80,$2C
        EQUB    $81,$23,$04,$09,$08,$81,$E9,$80
        EQUB    $3F,$83,$2F,$00,$06,$00,$82,$32
        EQUB    $82,$79,$07,$07,$1C,$80,$CD,$20
        EQUB    $04,$07,$83,$03,$4A,$1C,$9F,$A1
        EQUB    $07,$00,$83,$7D,$82,$10,$04,$04
        EQUB    $18,$50,$00,$05,$18,$81,$0B,$00
        EQUB    $8A,$0B,$29,$03,$0A,$82,$3E,$80
        EQUB    $6B,$7B,$60,$0A,$15,$29,$03,$0A
        EQUB    $4D,$83,$00,$83,$05,$03,$80,$6C
        EQUB    $07,$81,$93,$09,$83,$81,$83,$32
        EQUB    $0A,$0C,$29,$03,$0A,$82,$02,$4D
        EQUB    $80,$70,$82,$5F,$0A,$80,$0B,$29
        EQUB    $03,$0A,$81,$12,$80,$6B,$7B,$60
        EQUB    $0A,$07,$06,$81,$36,$80,$21,$04
        EQUB    $97,$03,$82,$82,$03,$80,$B5,$03
        EQUB    $83,$7C,$03,$82,$82,$03,$82,$2F
        EQUB    $05,$80,$3D,$28,$53,$04,$7D,$2B
        EQUB    $60,$04,$81,$18,$2B,$04,$80,$DB
        EQUB    $12,$05,$81,$3F,$80,$E8,$05,$82
        EQUB    $91,$07,$5C,$05,$81,$C1,$81,$27
        EQUB    $05,$80,$CE,$81,$E3,$04,$83,$78
        EQUB    $2B,$05,$80,$3D,$28,$53,$05,$81
        EQUB    $3F,$40,$08,$04,$54,$80,$16,$04
        EQUB    $82,$9D,$2B,$03,$83,$78,$04,$82
        EQUB    $56,$6D,$03,$81,$72,$05,$81,$4F
        EQUB    $28,$53,$05,$82,$9C,$80,$E8,$06
        EQUB    $81,$1A,$28,$81,$E8,$04,$82,$9D
        EQUB    $2B,$06,$82,$CC,$28,$81,$09,$03
        EQUB    $82,$9D,$06,$82,$91,$80,$C1,$60
        EQUB    $08,$3C,$81,$6F,$36,$1F,$81,$62
        EQUB    $05,$81,$70,$57,$08,$05,$80,$99
        EQUB    $40,$08,$04,$7D,$81,$6E,$04,$81
        EQUB    $C1,$2B,$C2,$04,$82,$AA,$12,$05
        EQUB    $09,$73,$81,$00,$04,$80,$CD,$20
        EQUB    $05,$27,$73,$81,$00,$04,$81,$82
        EQUB    $08,$03,$81,$54,$09,$81,$3E,$08
        EQUB    $06,$80,$5E,$81,$BB,$03,$81,$53
        EQUB    $05,$82,$B1,$81,$6E,$04,$54,$40
        EQUB    $08,$08,$83,$52,$28,$80,$FD,$82
        EQUB    $CA,$04,$80,$87,$51,$03,$81,$72
        EQUB    $04,$81,$81,$08,$03,$80,$47,$05
        EQUB    $82,$CA,$81,$27,$03,$82,$B1,$02
        EQUB    $7D,$02,$7D,$04,$54,$40,$08,$80
        EQUB    $03,$82,$9C,$03,$82,$9C,$03,$81
        EQUB    $E5,$CB,$03,$80,$8E,$02,$54,$03
        EQUB    $81,$B6,$AE,$05,$80,$CE,$80,$74
        EQUB    $04,$81,$82,$08,$03,$83,$7C,$03
        EQUB    $80,$4C,$03,$81,$F9,$03,$81,$B6
        EQUB    $03,$83,$7C,$03,$81,$54,$04,$27
        EQUB    $80,$5A,$03,$80,$A2,$07,$83,$51
        EQUB    $83,$06,$80,$1D,$A6,$45,$C3,$80
        EQUB    $C3,$7B,$45,$C1,$F7,$C1,$EF,$43
        EQUB    $C1,$64,$45,$C2,$12,$C1,$B1,$45
        EQUB    $C2,$0B,$C0,$FC,$49,$C2,$27,$8F
        EQUB    $80,$C1,$06,$C2,$FF,$DD,$5F,$C3
        EQUB    $04,$C3,$01,$C2,$B5,$C0,$05,$C0
        EQUB    $15,$C2,$0A,$C1,$42,$C0,$06,$C1
        EQUB    $7A,$C3,$0B,$C0,$12,$C3,$17,$C2
        EQUB    $0A,$C2,$12,$C1,$EC,$E6,$83,$1D
        EQUB    $07,$3A,$0E,$34,$1B,$73,$41,$9E
        EQUB    $83,$4E,$68,$36,$D0,$6B,$A0,$E3
        EQUB    $9A,$0E,$77,$E6,$84,$1E,$03,$A1
        EQUB    $75,$27,$E9,$3A,$21,$97,$45,$17
        EQUB    $4A,$5D,$29,$48,$29,$90,$7D,$30
        EQUB    $10,$DF,$13,$7D,$E0,$16,$27,$54
        EQUB    $9E,$5F,$DD,$8F,$39,$A4,$F4,$48
        EQUB    $01,$E3,$D3,$04,$7A,$CE,$B7,$C2
        EQUB    $41,$1B,$3F,$0F,$C6,$8A,$17,$8F
        EQUB    $C7,$1E,$43,$01,$32,$0F,$CD,$76
        EQUB    $08,$3E,$68,$41,$6C,$AC,$48,$F0
        EQUB    $0D,$95,$89,$1F,$4F,$E4,$6B,$40
        EQUB    $4F,$A3,$E8,$85,$09,$F9,$75,$EF
        EQUB    $20,$23,$2F,$C4,$8D,$9A,$04,$4F
        EQUB    $C5,$C0,$11,$F6,$E0,$22,$23,$90
        EQUB    $7F,$3B,$00,$62,$7C,$F6,$06,$39
        EQUB    $A1,$86,$24,$E0,$22,$4F,$31,$D4
        EQUB    $8F,$F1,$E7,$51,$A3,$EC,$BC,$72
        EQUB    $4B,$CA,$F4,$E2,$05,$FB,$0B,$A3
        EQUB    $39,$A1,$07,$42,$A7,$01,$3F,$4C
        EQUB    $02,$57,$C0,$25,$4B,$E8,$17,$6C
        EQUB    $05,$13,$F8,$ED,$C9,$B5,$E0,$40
        EQUB    $25,$78,$DE,$5A,$FC,$D1,$80,$C4
        EQUB    $97,$A2,$49,$7A,$7D,$27,$81,$32
        EQUB    $37,$C2,$73,$09,$F7,$30,$92,$F0
        EQUB    $FC,$74,$34,$7E,$59,$63,$8F,$AF
        EQUB    $EB,$75,$A5,$F7,$5B,$D3,$99,$23
        EQUB    $B7,$E0,$51,$11,$F5,$60,$12,$BC
        EQUB    $86,$AA,$5E,$70,$95,$F7,$0E,$CE
        EQUB    $8B,$3F,$6F,$50,$9D,$70,$22,$3F
        EQUB    $C4,$76,$02,$D5,$F9,$F8,$78,$E6
        EQUB    $84,$2D,$09,$FA,$13,$78,$17,$34
        EQUB    $9F,$24,$BF,$8F,$39,$52,$F4,$48
        EQUB    $3F,$4C,$E4,$8F,$AF,$BF,$E0,$62
        EQUB    $09,$4B,$F2,$96,$3C,$40,$2B,$E0
        EQUB    $54,$BC,$82,$17,$E6,$3C,$FC,$E7
        EQUB    $33,$F6,$6F,$68,$10,$AC,$9E,$19
        EQUB    $89,$E8,$B7,$ED,$43,$4D,$F6,$CB
        EQUB    $ED,$9F,$F1,$E9,$EF,$E0,$71,$B9
        EQUB    $E6,$84,$3E,$08,$06,$27,$9B,$FD
        EQUB    $04,$F3,$F8,$D6,$4F,$D4,$12,$F4
        EQUB    $49,$F2,$0F,$E4,$2D,$17,$F8,$E1
        EQUB    $0D,$37,$34,$21,$E8,$41,$D0,$A7
        EQUB    $A1,$53,$82,$04,$A7,$F9,$AC,$9E
        EQUB    $A4,$90,$D3,$7A,$A4,$F9,$22,$DE
        EQUB    $91,$0B,$43,$4D,$E5,$AC,$11,$E9
        EQUB    $C0,$C0,$92,$3F,$6C,$D0,$D3,$7D
        EQUB    $E4,$5F,$E2,$62,$7E,$26,$24,$BF
        EQUB    $22,$4B,$F3,$99,$23,$E2,$11,$F2
        EQUB    $FC,$68,$1F,$CA,$7F,$94,$E5,$BF
        EQUB    $E0,$91,$11,$2C,$9F,$12,$C9,$2F
        EQUB    $8A,$8B,$04,$7A,$B0,$4E,$64,$8C
        EQUB    $BF,$6F,$E1,$8E,$89,$3C,$81,$2B
        EQUB    $EC,$0F,$DA,$64,$34,$DE,$70,$15
        EQUB    $17,$39,$9F,$12,$BF,$22,$0F,$F2
        EQUB    $24,$BF,$33,$FA,$93,$11,$C9,$2E
        EQUB    $B8,$A5,$43,$7C,$B1,$FD,$60,$7C
        EQUB    $90,$D3,$7D,$D4,$89,$07,$E6,$12
        EQUB    $5F,$2B,$A3,$30,$05,$64,$F3,$4B
        EQUB    $49,$10,$7F,$4D,$22,$E8,$FE,$48
        EQUB    $19,$23,$2F,$CD,$0D,$A1,$3C,$E5
        EQUB    $79,$F8,$8A,$0C,$79,$FA,$31,$40
        EQUB    $DD,$1F,$51,$A2,$42,$FD,$52,$46
        EQUB    $5E,$B1,$23,$B2,$E0,$A2,$01,$2B
        EQUB    $F2,$39,$25,$E2,$01,$52,$F3,$A5
        EQUB    $2F,$CA,$48,$69,$BF,$60,$82,$3E
        EQUB    $A3,$02,$B2,$4B,$F2,$39,$25,$EC
        EQUB    $3E,$7F,$94,$C0,$BE,$D1,$E1,$70
        EQUB    $22,$3F,$46,$44,$97,$E6,$04,$37
        EQUB    $D3,$DF,$E0,$B0,$B4,$34,$71,$40
        EQUB    $80,$BD,$B4,$E0,$FA,$06,$00,$C4
        EQUB    $FB,$FC,$D3,$12,$3E,$8A,$BA,$40
        EQUB    $0F,$9A,$11,$34,$22,$E8,$44,$E0
        EQUB    $C8,$52,$02,$64,$1F,$99,$E9,$2B
        EQUB    $9A,$11,$34,$22,$E8,$54,$D9,$E0
        EQUB    $D0,$06,$39,$A3,$F1,$3C,$6F,$34
        EQUB    $DE,$89,$05,$34,$39,$BE,$90,$1E
        EQUB    $F2,$02,$32,$EB,$BC,$33,$13,$E6
        EQUB    $24,$BC,$49,$7E,$4D,$D0,$4F,$3F
        EQUB    $37,$41,$3C,$FE,$4F,$9B,$CE,$8F
        EQUB    $34,$22,$68,$4F,$D0,$AF,$C1,$BA
        EQUB    $CD,$FB,$6C,$08,$8E,$5B,$E0,$E2
        EQUB    $49,$4B,$C8,$6A,$BF,$52,$7E,$A4
        EQUB    $6F,$EA,$49,$79,$CD,$24,$BE,$FF
        EQUB    $BD,$E4,$1F,$DF,$2F,$63,$B4,$94
        EQUB    $FF,$3C,$76,$C4,$5A,$F7,$E1,$3A
        EQUB    $01,$1F,$D2,$9F,$A7,$D1,$1D,$C8
        EQUB    $69,$BA,$48,$A1,$78,$E6,$84,$53
        EQUB    $ED,$E1,$16,$00,$BA,$20,$99,$3C
        EQUB    $32,$47,$CC,$EB,$1F,$3C,$75,$A3
        EQUB    $F3,$A8,$63,$FA,$64,$8F,$C9,$19
        EQUB    $7E,$20,$68,$89,$B9,$E6,$84,$5D
        EQUB    $0A,$7A,$14,$38,$4A,$92,$38,$99
        EQUB    $D0,$D3,$76,$E0,$62,$1A,$4F,$08
        EQUB    $8F,$9F,$91,$29,$A1,$A6,$FC,$FF
        EQUB    $39,$79,$E4,$14,$C0,$D9,$FD,$6E
        EQUB    $19,$25,$E9,$A1,$A6,$A2,$24,$7D
        EQUB    $A1,$E1,$30,$4F,$86,$28,$31,$E7
        EQUB    $F9,$6E,$E1,$40,$22,$0F,$CB,$5F
        EQUB    $D7,$2F,$47,$D2,$99,$1A,$41,$FA
        EQUB    $67,$24,$7A,$40,$47,$C4,$5F,$D6
        EQUB    $86,$9B,$F3,$F2,$C7,$27,$82,$3F
        EQUB    $9F,$A3,$1C,$30,$0D,$DF,$E1,$50
        EQUB    $B5,$F3,$42,$36,$84,$9D,$09,$DC
        EQUB    $2A,$1A,$3F,$44,$9F,$67,$34,$23
        EQUB    $22,$32,$9F,$0A,$88,$CA,$7E,$91
        EQUB    $F9,$A1,$1B,$42,$4E,$85,$8E,$15
        EQUB    $60,$56,$3E,$FF,$BE,$5E,$21,$25
        EQUB    $FB,$92,$5E,$41,$25,$E7,$02,$7F
        EQUB    $04,$E5,$F7,$47,$EF,$E6,$84,$6D
        EQUB    $09,$9A,$16,$78,$55,$E3,$E8,$69
        EQUB    $BA,$E1,$52,$5E,$74,$FD,$1F,$98
        EQUB    $93,$FD,$81,$11,$CB,$73,$E1,$62
        EQUB    $06,$13,$CE,$67,$DB,$3E,$D1,$6B
        EQUB    $F4,$E9,$12,$6D,$E1,$80,$B5,$92
        EQUB    $38,$FA,$DD,$69,$7A,$23,$23,$7E
        EQUB    $67,$61,$64,$F4,$9E,$86,$9B,$D3
        EQUB    $27,$C9,$60,$63,$A4,$9F,$E5,$D3
        EQUB    $BA,$53,$FC,$A7,$2F,$D1,$7B,$E1
        EQUB    $90,$06,$CF,$C1,$09,$22,$89,$1F
        EQUB    $C5,$9F,$34,$23,$A2,$A4,$E1,$91
        EQUB    $52,$7C,$92,$EA,$C1,$12,$4B,$F2
        EQUB    $97,$9D,$64,$34,$DD,$77,$89,$2F
        EQUB    $21,$A6,$F2,$C7,$F2,$33,$CE,$1F
        EQUB    $A7,$B2,$E1,$A2,$06,$8D,$8E,$99
        EQUB    $C9,$1F,$CA,$58,$F1,$01,$3F,$91
        EQUB    $BF,$C7,$90,$C7,$22,$24,$FB,$47
        EQUB    $2F,$BF,$CE,$9C,$DD,$FA,$34,$7F
        EQUB    $B2,$E5,$EA,$36,$72,$DA,$E1,$C0
        EQUB    $88,$E3,$CB,$5F,$9A,$3E,$68,$48
        EQUB    $03,$47,$2E,$1C,$0D,$32,$1A,$6F
        EQUB    $3D,$E4,$6C,$BD,$11,$FA,$5E,$A9
        EQUB    $3A,$4F,$01,$64,$8F,$D7,$33,$E3
        EQUB    $F1,$FC,$67,$FA,$E3,$CB,$5B,$BD
        EQUB    $10,$FC,$9B,$E1,$D0,$63,$F9,$73
        EQUB    $F4,$FA,$E0,$85,$13,$97,$96,$4F
        EQUB    $AD,$D6,$F3,$FD,$18,$A0,$2B,$C7
        EQUB    $E2,$E8,$FA,$A4,$8C,$BD,$6F,$AE
        EQUB    $5B,$E1,$E8,$62,$79,$80,$6F,$DD
        EQUB    $48,$FA,$2B,$20,$FE,$B9,$6E,$E6
        EQUB    $84,$8D,$0B,$3A,$14,$38,$7C,$3D
        EQUB    $AE,$9A,$24,$4D,$BD,$E6,$84,$9E
        EQUB    $23,$9A,$12,$74,$13,$B3,$BA,$10
        EQUB    $B4,$26,$F1,$02,$27,$46,$E5,$F4
        EQUB    $BD,$33,$5D,$12,$7D,$D1,$24,$B7
        EQUB    $E2,$18,$03,$13,$AD,$F0,$88,$D9
        EQUB    $13,$CD,$24,$7C,$FA,$4F,$D2,$14
        EQUB    $50,$12,$0F,$E2,$8A,$1F,$34,$39
        EQUB    $BF,$24,$67,$F4,$0C,$9E,$9B,$BD
        EQUB    $52,$36,$6E,$8E,$37,$E2,$25,$D9
        EQUB    $FB,$41,$3C,$BD,$2D,$FB,$E2,$40
        EQUB    $32,$6F,$E2,$5C,$1D,$EF,$E2,$68
        EQUB    $C7,$F9,$A2,$9A,$1C,$DD,$F9,$E6
        EQUB    $84,$BD,$09,$3A,$13,$38,$A4,$2D
        EQUB    $7F,$5C,$BA,$D4,$14,$9E,$70,$95
        EQUB    $FB,$7A,$82,$52,$C8,$17,$34,$9B
        EQUB    $E2,$C0,$17,$44,$13,$74,$71,$F7
        EQUB    $52,$3E,$51,$3C,$D1,$A1,$A6,$F4
        EQUB    $A7,$EA,$18,$F2,$E9,$00,$39,$7D
        EQUB    $B2,$FB,$FE,$F9,$7E,$A4,$FD,$49
        EQUB    $2F,$16,$7E,$6C,$BD,$3E,$68,$4C
        EQUB    $25,$48,$BE,$2C,$95,$24,$76,$E2
        EQUB    $D0,$18,$82,$38,$F1,$3C,$52,$78
        EQUB    $C7,$9F,$CF,$36,$A1,$A6,$F2,$89
        EQUB    $E6,$90,$7E,$94,$C8,$DF,$CC,$8D
        EQUB    $97,$A7,$35,$93,$AE,$00,$FC,$25
        EQUB    $10,$7E,$69,$BC,$E5,$7D,$52,$F5
        EQUB    $07,$F1,$92,$3E,$B7,$B0,$05,$EE
        EQUB    $E2,$E8,$C0,$92,$32,$F5,$E9,$14
        EQUB    $3A,$92,$DD,$E2,$F0,$86,$9B,$72
        EQUB    $E6,$84,$DD,$08,$3A,$11,$38,$C0
        EQUB    $0F,$C6,$27,$D0,$24,$01,$BC,$D0
        EQUB    $9A,$03,$21,$5C,$60,$0C,$85,$7D
        EQUB    $A8,$2A,$04,$46,$CF,$C7,$71,$80
        EQUB    $DC,$79,$0B,$F3,$47,$10,$28,$9E
        EQUB    $88,$56,$4F,$63,$A4,$F4,$C0,$B5
        EQUB    $A0,$5B,$E3,$10,$D1,$FA,$31,$74
        EQUB    $7D,$29,$FE,$72,$FC,$F1,$D6,$75
        EQUB    $C0,$6F,$DB,$2F,$0C,$91,$6F,$9A
        EQUB    $A2,$63,$EA,$26,$34,$13,$CB,$CE
        EQUB    $6F,$DA,$12,$02,$53,$FB,$42,$40
        EQUB    $4A,$72,$F4,$49,$F3,$50,$9E,$94
        EQUB    $D7,$8F,$54,$9F,$24,$B7,$E3,$28
        EQUB    $C0,$AC,$92,$FB,$31,$E8,$B2,$91
        EQUB    $97,$A4,$25,$92,$5F,$9F,$E7,$8D
        EQUB    $92,$E6,$84,$DC,$71,$98,$E6,$84
        EQUB    $DC,$19,$60,$8F,$D6,$08,$E8,$27
        EQUB    $96,$D6,$E3,$7A,$06,$11,$64,$94
        EQUB    $BD,$29,$E3,$A4,$F0,$22,$1C,$78
        EQUB    $83,$F5,$49,$1D,$F8,$E6,$84,$ED
        EQUB    $09,$FC,$6B,$BC,$17,$0F,$1E,$1C
        EQUB    $BC,$89,$12,$5E,$8B,$00,$BF,$CC
        EQUB    $FF,$99,$C8,$09,$4F,$F3,$3D,$89
        EQUB    $29,$FA,$7F,$3A,$1A,$6F,$55,$02
        EQUB    $27,$34,$27,$3A,$DC,$6B,$AD,$B7
        EQUB    $E3,$69,$19,$12,$5D,$B6,$E9,$E3
        EQUB    $80,$AE,$85,$24,$14,$FD,$22,$4A
        EQUB    $48,$73,$7A,$31,$F4,$BE,$2F,$D0
        EQUB    $22,$73,$42,$79,$F6,$E6,$84,$F4
        EQUB    $77,$42,$5F,$1C,$B1,$F5,$88,$6B
        EQUB    $A9,$2E,$B7,$C2,$27,$89,$E5,$E3
        EQUB    $D3,$77,$5D,$92,$4B,$AF,$23,$7E
        EQUB    $D9,$6F,$E3,$A3,$E0,$34,$C4,$F0
        EQUB    $D0,$D0,$47,$1D,$99,$C9,$1E,$68
        EQUB    $4F,$A0,$8F,$C7,$52,$7F,$14,$5C
        EQUB    $FF,$C9,$03,$27,$6A,$48,$F6,$CD
        EQUB    $DF,$E3,$C0,$D2,$2F,$E4,$5A,$C8
        EQUB    $3F,$91,$72,$FA,$05,$F9,$C7,$1E
        EQUB    $88,$8E,$C2,$36,$7E,$94,$BF,$20
        EQUB    $18,$9F,$91,$25,$F9,$F4,$83,$24
        EQUB    $A6,$05,$F8,$8F,$97,$9A,$3A,$2E
        EQUB    $8C,$FC,$C0,$67,$34,$0B,$F4,$44
        EQUB    $46,$CF,$6B,$E3,$D0,$25,$7E,$74
        EQUB    $89,$3C,$B5,$82,$3E,$68,$8F,$D5
        EQUB    $80,$44,$97,$D0,$DF,$B6,$7F,$85
        EQUB    $09,$F9,$93,$F3,$2B,$A2,$CF,$E3
        EQUB    $9A,$14,$16,$40,$48,$9C,$7A,$C8
        EQUB    $09,$13,$AC,$EB,$90,$D9,$FD,$B3
        EQUB    $97,$96,$89,$93,$CD,$40,$22,$3F
        EQUB    $46,$68,$13,$BD,$29,$88,$11,$1E
        EQUB    $FD,$E3,$E2,$49,$4B,$9A,$14,$22
        EQUB    $81,$13,$8F,$8A,$24,$CE,$D1,$6B
        EQUB    $FA,$E5,$E9,$1F,$D3,$F6,$72,$B2
        EQUB    $0F,$73,$E4,$28,$49,$4F,$C8,$9E
        EQUB    $E8,$E4,$48,$01,$1F,$E3,$F8,$E5
        EQUB    $F1,$E3,$EB,$5E,$3F,$19,$78,$44
        EQUB    $94,$BC,$3F,$15,$64,$14,$D0,$D3
        EQUB    $7D,$64,$14,$D0,$E6,$F9,$80,$43
        EQUB    $65,$F7,$54,$9F,$75,$50,$D3,$7A
        EQUB    $14,$44,$49,$2F,$4A,$7C,$D0,$A5
        EQUB    $A1,$17,$42,$9E,$85,$4D,$08,$3A
        EQUB    $14,$B4,$2A,$72,$24,$94,$C1,$19
        EQUB    $F3,$42,$96,$84,$5D,$0A,$7A,$15
        EQUB    $34,$27,$E8,$52,$D0,$8B,$C8,$92
        EQUB    $53,$74,$49,$E9,$D2,$2D,$DC,$E4
        EQUB    $50,$31,$AC,$9E,$69,$BD,$52,$47
        EQUB    $AE,$09,$25,$E1,$2B,$EA,$D0,$5B
        EQUB    $60,$2D,$64,$1F,$9C,$5F,$B3,$F3
        EQUB    $97,$9E,$4F,$4E,$68,$69,$BD,$43
        EQUB    $1F,$D6,$43,$4D,$B3,$E4,$68,$1D
        EQUB    $9F,$E4,$BA,$03,$19,$0D,$37,$90
        EQUB    $3F,$2E,$7C,$D0,$A7,$A1,$07,$42
        EQUB    $77,$24,$06,$8A,$74,$67,$C9,$F4
        EQUB    $4F,$1E,$88,$9C,$F3,$80,$D4,$97
        EQUB    $AA,$4F,$63,$E8,$69,$BF,$2E,$88
        EQUB    $0B,$24,$BC,$E8,$93,$D1,$04,$C4
        EQUB    $72,$4B,$E4,$03,$3E,$40,$32,$5F
        EQUB    $72,$D7,$EA,$2D,$64,$8E,$3A,$4F
        EQUB    $03,$F1,$11,$FC,$28,$92,$7C,$D0
        EQUB    $A7,$A1,$17,$42,$2F,$24,$42,$79
        EQUB    $B2,$27,$A3,$50,$36,$72,$E9,$C0
        EQUB    $37,$5B,$1F,$51,$1B,$F5,$12,$5F
        EQUB    $60,$1B,$F8,$BF,$F3,$99,$22,$86
        EQUB    $9B,$C8,$22,$C7,$FA,$92,$28,$69
        EQUB    $BC,$E8,$93,$F1,$9F,$EA,$45,$FE
        EQUB    $C8,$69,$BD,$14,$11,$48,$69,$BE
        EQUB    $82,$2A,$5E,$A1,$4A,$B2,$4B,$7E
        EQUB    $E4,$90,$32,$78,$C7,$97,$96,$BC
        EQUB    $7E,$A4,$8F,$EA,$48,$E3,$CD,$57
        EQUB    $D5,$2F,$4F,$F3,$43,$4D,$D5,$11
        EQUB    $64,$9B,$9B,$EA,$2D,$7E,$C7,$56
        EQUB    $42,$3E,$5E,$40,$C9,$F6,$13,$EC
        EQUB    $C7,$9C,$F4,$34,$DE,$A1,$BA,$C0
        EQUB    $48,$FE,$42,$C9,$2E,$B5,$D6,$EB
        EQUB    $BC,$B0,$45,$14,$67,$98,$4F,$92
        EQUB    $67,$43,$4D,$E7,$4C,$F2,$06,$09
        EQUB    $1F,$44,$44,$89,$23,$EA,$34,$7F
        EQUB    $99,$FF,$33,$90,$12,$9F,$E6,$7B
        EQUB    $12,$53,$EB,$C0,$22,$7E,$CD,$F1
        EQUB    $04,$86,$11,$BF,$5A,$FE,$B5,$85
        EQUB    $0D,$19,$23,$E4,$0C,$91,$FC,$40
        EQUB    $BE,$68,$53,$D0,$A1,$A1,$67,$73
        EQUB    $E4,$A1,$42,$13,$24,$EC,$C0,$52
        EQUB    $FC,$C4,$FA,$23,$F4,$46,$C0,$C7
        EQUB    $D6,$A9,$7D,$88,$68,$3E,$C7,$CB
        EQUB    $ED,$1F,$DA,$34,$34,$DF,$89,$25
        EQUB    $F8,$CF,$F3,$A1,$3F,$3A,$12,$5F
        EQUB    $C7,$88,$01,$A1,$78,$FB,$E5,$E4
        EQUB    $09,$52,$F8,$95,$8F,$AD,$7E,$73
        EQUB    $49,$CD,$0A,$73,$73,$48,$72,$34
        EQUB    $C4,$E4,$A6,$E6,$E3,$EF,$97,$E2
        EQUB    $4F,$C4,$91,$73,$99,$E8,$81,$06
        EQUB    $3C,$FE,$06,$98,$9F,$42,$89,$2F
        EQUB    $50,$4A,$F8,$F1,$F8,$8F,$1D,$A0
        EQUB    $94,$41,$F9,$BE,$7B,$DD,$22,$7A
        EQUB    $4F,$23,$46,$41,$F6,$DE,$03,$1F
        EQUB    $FC,$4B,$C8,$69,$BE,$D3,$4B,$CE
        EQUB    $88,$F6,$E4,$C0,$15,$93,$CA,$27
        EQUB    $C8,$DF,$92,$5E,$5A,$24,$C0,$37
        EQUB    $EB,$FA,$DD,$6F,$3C,$92,$9C,$71
        EQUB    $E8,$98,$93,$F5,$1B,$39,$74,$84
        EQUB    $99,$FC,$C7,$AC,$9E,$68,$C8,$3F
        EQUB    $CC,$02,$59,$25,$E8,$C5,$01,$59
        EQUB    $3F,$14,$15,$04,$1F,$E2,$E8,$F4
        EQUB    $E0,$6A,$BF,$3E,$68,$54,$38,$27
        EQUB    $A0,$9E,$5C,$99,$C1,$3D,$04,$F2
        EQUB    $F1,$3E,$4F,$A2,$3F,$67,$DB,$F8
        EQUB    $93,$F1,$26,$82,$79,$7E,$24,$2B
        EQUB    $A2,$4F,$E3,$C8,$69,$A5,$F6,$AB
        EQUB    $F2,$F4,$5D,$43,$1F,$EE,$B7,$DD
        EQUB    $66,$EF,$E4,$D0,$63,$CF,$E7,$9A
        EQUB    $F1,$E5,$90,$7E,$61,$3A,$EF,$30
        EQUB    $3E,$77,$E7,$E7,$FA,$82,$3F,$AC
        EQUB    $08,$8E,$5F,$24,$76,$E4,$E2,$06
        EQUB    $C9,$74,$11,$1B,$3F,$B6,$4F,$74
        EQUB    $66,$41,$F3,$42,$A4,$40,$D9,$61
        EQUB    $75,$03,$50,$0E,$4E,$24,$04,$A9
        EQUB    $1C,$79,$00,$69,$A8,$B0,$47,$EF
        EQUB    $F3,$A9,$3F,$51,$8F,$24,$FE,$D5
        EQUB    $7B,$1D,$A3,$5A,$45,$F6,$CE,$DB
        EQUB    $E6,$85,$4C,$3C,$9B,$E5,$3A,$65
        EQUB    $E3,$7B,$E5,$1A,$23,$81,$A6,$20
        EQUB    $FC,$32,$47,$E4,$8B,$48,$09,$9F
        EQUB    $E4,$8C,$A6,$06,$8F,$EE,$69,$3C
        EQUB    $87,$37,$CA,$6B,$AC,$DE,$BF,$D6
        EQUB    $04,$47,$2D,$BF,$E5,$24,$4F,$21
        EQUB    $A6,$DD,$E5,$40,$B2,$45,$00,$6F
        EQUB    $E8,$00,$AC,$9E,$A2,$E7,$D2,$44
        EQUB    $2E,$91,$3F,$8D,$C4,$E5,$50,$24
        EQUB    $3A,$92,$F1,$2D,$2F,$2C,$9E,$69
        EQUB    $3C,$E5,$92,$7D,$72,$04,$4D,$92
        EQUB    $E5,$BA,$0F,$22,$7E,$51,$25,$E5
        EQUB    $AF,$EB,$97,$9B,$3F,$CE,$5E,$88
        EQUB    $E2,$E0,$93,$E6,$03,$09,$E9,$7A
        EQUB    $64,$8F,$C9,$1C,$7A,$A4,$F9,$25
        EQUB    $EC,$74,$80,$52,$F1,$F8,$FE,$28
        EQUB    $69,$BF,$19,$78,$3E,$20,$FC,$83
        EQUB    $1E,$7C,$D0,$AE,$45,$89,$CC,$27
        EQUB    $D7,$CB,$11,$6B,$F4,$49,$67,$2C
        EQUB    $BE,$94,$F9,$A1,$5C,$E0,$9F,$2C
        EQUB    $70,$4F,$C4,$27,$C8,$BF,$C4,$9E
        EQUB    $40,$8F,$F9,$93,$CE,$F6,$37,$E5
        EQUB    $90,$63,$CF,$CB,$5F,$9A,$34,$34
        EQUB    $DE,$91,$17,$8F,$4C,$FE,$C8,$22
        EQUB    $3E,$B9,$65,$90,$40,$D2,$79,$BA
        EQUB    $09,$E7,$E7,$0F,$E3,$23,$7E,$37
        EQUB    $A1,$64,$F8,$E4,$72,$0F,$D1,$6F
        EQUB    $E2,$82,$0F,$71,$E5,$A2,$04,$4C
        EQUB    $FE,$41,$8C,$B2,$4B,$F3,$99,$1B
        EQUB    $B2,$E6,$85,$8D,$08,$3A,$13,$77
        EQUB    $E6,$3A,$0B,$36,$5D,$20,$23,$2F
        EQUB    $2D,$6E,$B7,$34,$2C,$E8,$45,$D0
        EQUB    $A7,$CC,$12,$5E,$9F,$A8,$23,$EE
        EQUB    $E6,$85,$97,$53,$98,$75,$3F,$A0
        EQUB    $9E,$24,$FB,$4D,$F8,$FE,$32,$22
        EQUB    $CB,$B8,$E6,$85,$AD,$08,$3A,$14
        EQUB    $3B,$A1,$17,$42,$76,$FB,$E6,$5C
        EQUB    $C0,$A3,$62,$0E,$1B,$04,$00,$27
        EQUB    $1B,$0C,$00,$6F,$1B,$24,$00,$A9
        EQUB    $1B,$39,$00,$A9,$1B,$39,$00,$D4
        EQUB    $1B,$4A,$00,$09,$1C,$5D,$00,$30
        EQUB    $1C,$6D,$00,$33,$1C,$6E,$00,$8B
        EQUB    $1C,$8B,$00,$F7,$1C,$AA,$00,$25
        EQUB    $1D,$B8,$00,$2E,$1D,$B9,$00,$52
        EQUB    $1D,$C4,$00,$89,$1D,$D6,$00,$A9
        EQUB    $1D,$E3,$00,$A9,$1D,$E3,$00,$BC
        EQUB    $1D,$EA,$00,$D8,$1D,$F3,$00,$04
        EQUB    $1E,$FD,$00,$0D,$1E,$00,$01,$31
        EQUB    $1E,$0D,$01,$81,$1E,$28,$01,$8F
        EQUB    $1E,$2D,$01,$8F,$1E,$2D,$01,$B2
        EQUB    $1E,$39,$01,$DD,$1E,$49,$01,$01
        EQUB    $1F,$55,$01,$01,$1F,$55,$01,$2E
        EQUB    $1F,$67,$01,$4C,$1F,$73,$01,$5A
        EQUB    $1F,$78,$01,$68,$1F,$7A,$01,$83
        EQUB    $1F,$83,$01,$A8,$1F,$8E,$01,$B1
        EQUB    $1F,$92,$01,$B1,$1F,$92,$01,$B5
        EQUB    $1F,$93,$01,$B9,$1F,$94,$01,$C2
        EQUB    $1F,$96,$01,$C2,$1F,$96,$01,$C2
        EQUB    $1F,$96,$01,$DB,$1F,$9D,$01,$DB
        EQUB    $1F,$9D,$01,$DB,$1F,$9D,$01,$0A
        EQUB    $20,$AE,$01,$3B,$20,$C1,$01,$46
        EQUB    $20,$C3,$01,$4B,$20,$C4,$01,$7D
        EQUB    $20,$D2,$01,$B1,$20,$E5,$01,$C4
        EQUB    $20,$EB,$01,$D5,$20,$EF,$01,$E8
        EQUB    $20,$F6,$01,$13,$21,$04,$02,$1A
        EQUB    $21,$06,$02,$1A,$21,$06,$02,$30
        EQUB    $21,$0E,$02,$4D,$21,$1A,$02,$6C
        EQUB    $21,$24,$02,$6C,$21,$24,$02,$9E
        EQUB    $21,$33,$02,$DC,$21,$47,$02,$F5
        EQUB    $21,$4F,$02,$F5,$21,$4F,$02,$F5
        EQUB    $21,$4F,$02,$F5,$21,$4F,$02,$FC
        EQUB    $21,$51,$02,$FC,$21,$51,$02,$52
        EQUB    $22,$65,$02,$78,$22,$72,$02,$7C
        EQUB    $22,$73,$02,$7C,$22,$73,$02,$03
        EQUB    $23,$9E,$02,$7B,$23,$C5,$02,$F5
        EQUB    $23,$EF,$02,$F5,$23,$EF,$02,$5D
        EQUB    $24,$13,$03,$78,$24,$1F,$03,$AB
        EQUB    $24,$2B,$03,$B0,$24,$2C,$03,$B5
        EQUB    $24,$2E,$03,$D7,$24,$37,$03,$DD
        EQUB    $24,$39,$03,$DD,$24,$39,$03,$F0
        EQUB    $24,$3E,$03,$03,$25,$44,$03,$03
        EQUB    $25,$44,$03,$03,$25,$44,$03,$5A
        EQUB    $25,$69,$03,$87,$25,$77,$03,$94
        EQUB    $25,$7A,$03,$94,$25,$7A,$03,$9B
        EQUB    $25,$7B,$03,$9B,$25,$7B,$03,$9B
        EQUB    $25,$7B,$03,$9B,$25,$7B,$03,$B3
        EQUB    $25,$83,$03,$C5,$25,$89,$03,$C5
        EQUB    $25,$89,$03,$C5,$25,$89,$03,$D1
        EQUB    $25,$8B,$03,$0F,$A0,$2F,$A2,$1F
        EQUB    $BA,$1F,$AC,$1F,$AE,$0F,$AE,$00
        EQUB    $05,$03,$04,$03,$84,$01,$8E,$0F
        EQUB    $A2,$02,$6C,$00,$13,$0F,$AC,$0F
        EQUB    $A1,$01,$8F,$01,$84,$00,$71,$02
        EQUB    $12,$00,$28,$0F,$BF,$02,$D9,$00
        EQUB    $A6,$03,$01,$00,$15,$03,$17,$01
        EQUB    $90,$0F,$A5,$02,$C0,$02,$B5,$02
        EQUB    $0A,$03,$87,$02,$00,$01,$C9,$00
        EQUB    $89,$0F,$DF,$01,$29,$03,$85,$02
        EQUB    $D5,$01,$BC,$01,$91,$02,$7F,$00
        EQUB    $CF,$00,$06,$02,$DD,$02,$CE,$02
        EQUB    $8C,$02,$34,$01,$5D,$00,$BD,$02
        EQUB    $9A,$02,$1C,$01,$FF,$01,$ED,$01
        EQUB    $8C,$01,$88,$01,$56,$01,$25,$00
        EQUB    $D2,$03,$5A,$02,$E1,$01,$6B,$00
        EQUB    $3E,$00,$37,$00,$32,$00,$10,$03
        EQUB    $6D,$03,$64,$03,$4F,$03,$2D,$02
        EQUB    $3F,$02,$35,$02,$1F,$02,$0F,$01
        EQUB    $F7,$01,$CA,$01,$B7,$01,$7A,$01
        EQUB    $5C,$01,$14,$01,$07,$00,$39,$03
        EQUB    $56,$02,$F9,$02,$CF,$02,$B6,$02
        EQUB    $93,$02,$22,$02,$18,$02,$0B,$01
        EQUB    $DB,$01,$5A,$01,$1E,$00,$D4,$00
        EQUB    $CA,$00,$6D,$00,$57,$00,$53,$00
        EQUB    $24,$00,$11,$00,$0A,$0F,$BA,$0F
        EQUB    $AD,$03,$71,$03,$61,$03,$47,$03
        EQUB    $41,$03,$3D,$03,$36,$03,$35,$03
        EQUB    $1F,$03,$19,$03,$10,$03,$09,$02
        EQUB    $EE,$02,$DB,$02,$D1,$02,$69,$02
        EQUB    $42,$02,$38,$02,$26,$02,$1A,$02
        EQUB    $06,$01,$EC,$01,$DD,$01,$D9,$01
        EQUB    $D1,$01,$CD,$3F,$02,$2E,$00,$D4
        EQUB    $11,$48,$00,$26,$01,$19,$13,$01
        EQUB    $88,$19,$78,$2A,$01,$0A,$05,$3C
        EQUB    $08,$48,$00,$33,$15,$01,$02,$01
        EQUB    $FA,$18,$01,$15,$0F,$7A,$19,$5A
        EQUB    $08,$7B,$19,$73,$04,$48,$5A,$19
        EQUB    $09,$19,$22,$48,$00,$23,$09,$19
        EQUB    $01,$21,$3D,$08,$E8,$03,$01,$0A
        EQUB    $19,$01,$04,$01,$79,$60,$1D,$05
        EQUB    $45,$09,$20,$15,$08,$14,$05,$01
        EQUB    $0A,$19,$01,$04,$01,$45,$09,$79
        EQUB    $19,$5A,$04,$01,$15,$0F,$21,$4A
        EQUB    $09,$19,$22,$48,$00,$23,$78,$61
        EQUB    $01,$05,$78,$19,$42,$04,$01,$35
        EQUB    $01,$21,$14,$01,$8F,$12,$02,$08
        EQUB    $F4,$01,$02,$0A,$02,$01,$30,$01
        EQUB    $33,$04,$09,$01,$33,$02,$A3,$54
        EQUB    $01,$78,$01,$00,$1C,$48,$88,$01
        EQUB    $01,$59,$02,$A3,$54,$01,$48,$4C
        EQUB    $02,$0A,$02,$01,$04,$01,$20,$01
        EQUB    $A2,$54,$01,$01,$59,$02,$45,$09
        EQUB    $02,$48,$01,$29,$48,$00,$1B,$48
        EQUB    $01,$1A,$09,$19,$14,$01,$93,$02
        EQUB    $48,$00,$2B,$48,$00,$2C,$48,$00
        EQUB    $2D,$48,$00,$2E,$78,$1D,$00,$36
        EQUB    $48,$64,$2B,$0A,$1A,$2B,$78,$52
        EQUB    $00,$07,$48,$0C,$2C,$0A,$51,$2C
        EQUB    $0A,$08,$1B,$79,$1B,$02,$03,$45
        EQUB    $0A,$79,$2C,$00,$16,$48,$5D,$2C
        EQUB    $08,$E8,$03,$2D,$7A,$17,$5A,$08
        EQUB    $7B,$17,$73,$04,$48,$5A,$17,$0A
        EQUB    $17,$2D,$01,$BE,$01,$0A,$08,$1A
        EQUB    $7A,$1A,$0E,$AF,$7B,$1B,$01,$07
        EQUB    $78,$1B,$00,$0C,$45,$0B,$48,$00
        EQUB    $2B,$48,$00,$2C,$01,$B8,$01,$02
        EQUB    $48,$01,$32,$78,$31,$00,$1C,$78
        EQUB    $1F,$77,$15,$A3,$1F,$01,$78,$01
        EQUB    $00,$11,$A2,$1F,$01,$0A,$01,$01
        EQUB    $A1,$01,$02,$7B,$02,$7F,$04,$48
        EQUB    $00,$32,$02,$48,$02,$29,$21,$43
        EQUB    $48,$00,$25,$21,$33,$30,$1F,$54
        EQUB    $FB,$7B,$1F,$87,$F7,$78,$1F,$00
        EQUB    $07,$21,$C6,$78,$32,$00,$1B,$79
        EQUB    $24,$01,$0E,$0A,$08,$25,$48,$00
        EQUB    $2B,$48,$00,$2C,$21,$59,$21,$29
        EQUB    $09,$1F,$2B,$48,$00,$2C,$01,$B8
        EQUB    $01,$59,$1F,$00,$3D,$01,$02,$48
        EQUB    $87,$01,$17,$01,$23,$22,$1F,$24
        EQUB    $31,$02,$48,$01,$31,$48,$00,$01
        EQUB    $17,$01,$01,$01,$01,$01,$01,$02
        EQUB    $48,$18,$03,$78,$23,$00,$10,$78
        EQUB    $23,$1F,$23,$78,$23,$0E,$08,$31
        EQUB    $22,$54,$04,$48,$3C,$03,$0A,$23
        EQUB    $03,$04,$03,$78,$23,$00,$0F,$09
        EQUB    $22,$01,$01,$59,$02,$48,$10,$01
        EQUB    $0A,$01,$03,$04,$03,$02,$48,$00
        EQUB    $2D,$48,$00,$2E,$78,$2B,$00,$40
        EQUB    $09,$28,$04,$09,$2B,$12,$21,$6A
        EQUB    $09,$2C,$12,$21,$65,$09,$2D,$12
        EQUB    $21,$60,$09,$2E,$12,$21,$5B,$09
        EQUB    $04,$28,$79,$28,$18,$21,$48,$00
        EQUB    $04,$21,$37,$48,$00,$01,$48,$08
        EQUB    $02,$A7,$02,$03,$E7,$01,$03,$0A
        EQUB    $08,$01,$0A,$08,$02,$7A,$01,$10
        EQUB    $F1,$45,$03,$48,$10,$28,$02,$78
        EQUB    $28,$00,$FC,$48,$00,$04,$21,$12
        EQUB    $78,$28,$08,$08,$45,$0E,$48,$08
        EQUB    $04,$21,$07,$48,$00,$28,$45,$09
        EQUB    $02,$48,$03,$03,$21,$27,$09,$12
        EQUB    $01,$58,$29,$02,$16,$0C,$04,$12
        EQUB    $0B,$08,$03,$3A,$03,$50,$C3,$ED
        EQUB    $02,$0A,$08,$04,$E7,$04,$12,$0B
        EQUB    $08,$04,$01,$28,$0B,$E7,$04,$12
        EQUB    $0A,$09,$04,$02,$A7,$04,$12,$01
        EQUB    $0F,$0B,$0A,$08,$04,$A7,$04,$01
        EQUB    $0A,$01,$12,$0A,$08,$04,$02,$01
        EQUB    $A3,$0B,$78,$2A,$01,$27,$31,$26
        EQUB    $01,$19,$78,$57,$00,$05,$78,$2A
        EQUB    $04,$05,$05,$E2,$01,$02,$78,$2A
        EQUB    $00,$05,$05,$E3,$01,$02,$05,$E4
        EQUB    $01,$02,$45,$15,$20,$07,$45,$17
        EQUB    $20,$03,$45,$16,$09,$01,$26,$08
        EQUB    $2C,$01,$02,$0A,$01,$02,$04,$02
        EQUB    $02,$21,$04,$00,$A1,$12,$48,$00
        EQUB    $52,$48,$00,$1D,$0F,$14,$1A,$18
        EQUB    $17,$78,$17,$00,$1B,$09,$18,$01
        EQUB    $7A,$01,$04,$0D,$48,$01,$52,$82
        EQUB    $8D,$19,$48,$04,$02,$0B,$02,$01
        EQUB    $7B,$01,$01,$04,$48,$01,$1D,$02
        EQUB    $48,$0F,$1A,$0B,$08,$1A,$21,$CF
        EQUB    $78,$1A,$00,$05,$31,$17,$15,$F4
        EQUB    $02,$45,$05,$21,$04,$04,$30,$02
        EQUB    $0A,$08,$50,$7A,$50,$03,$04,$48
        EQUB    $00,$50,$0A,$50,$30,$02,$09,$19
        EQUB    $14,$48,$01,$1A,$21,$A4,$78,$52
        EQUB    $01,$08,$0A,$08,$1A,$7A,$1A,$0E
        EQUB    $F4,$02,$21,$EB,$82,$8D,$07,$78
        EQUB    $2A,$00,$04,$82,$8D,$19,$02,$01
        EQUB    $EF,$09,$01,$3E,$14,$06,$06,$48
        EQUB    $00,$56,$48,$00,$5F,$78,$3C,$00
        EQUB    $23,$48,$00,$3C,$78,$44,$00,$1C
        EQUB    $45,$11,$06,$02,$01,$48,$00,$44
        EQUB    $58,$58,$00,$3A,$03,$48,$88,$54
        EQUB    $48,$00,$58,$01,$15,$0F,$21,$C3
        EQUB    $01,$15,$0F,$01,$DE,$06,$79,$0B
        EQUB    $00,$03,$20,$CA,$01,$A2,$1F,$21
        EQUB    $04,$00,$53,$1D,$48,$01,$5F,$45
        EQUB    $05,$48,$00,$1A,$01,$84,$14,$09
        EQUB    $0B,$41,$01,$F8,$14,$78,$0E,$FF
        EQUB    $0C,$09,$0E,$1F,$01,$71,$0B,$58
        EQUB    $2A,$00,$B6,$06,$58,$3A,$01,$A5
        EQUB    $03,$48,$01,$1E,$A8,$1E,$1F,$78
        EQUB    $1F,$00,$1F,$01,$89,$05,$78,$2A
        EQUB    $01,$09,$01,$8B,$06,$48,$01,$43
        EQUB    $20,$0B,$09,$1F,$0D,$48,$01,$43
        EQUB    $21,$5A,$45,$05,$0A,$08,$1E,$20
        EQUB    $DC,$78,$43,$01,$06,$48,$FF,$0D
        EQUB    $21,$4A,$02,$48,$87,$1E,$48,$FF
        EQUB    $0D,$09,$1E,$1F,$01,$89,$05,$78
        EQUB    $2A,$00,$2A,$48,$01,$31,$A2,$1F
        EQUB    $01,$31,$01,$54,$08,$A3,$1F,$01
        EQUB    $79,$01,$00,$08,$01,$12,$01,$78
        EQUB    $32,$00,$12,$01,$DA,$08,$78,$2A
        EQUB    $01,$0B,$09,$1E,$0D,$48,$01,$43
        EQUB    $21,$12,$45,$05,$0B,$08,$1E,$3A
        EQUB    $1E,$50,$C3,$C6,$78,$43,$01,$03
        EQUB    $21,$02,$02,$09,$23,$62,$78,$0D
        EQUB    $FF,$15,$78,$3A,$01,$05,$7A,$42
        EQUB    $02,$0D,$78,$58,$01,$09,$09,$0D
        EQUB    $01,$01,$86,$02,$45,$12,$09,$0D
        EQUB    $26,$21,$05,$09,$62,$23,$02,$48
        EQUB    $01,$45,$09,$0D,$1F,$48,$1F,$23
        EQUB    $48,$01,$2A,$01,$25,$22,$78,$2A
        EQUB    $01,$34,$09,$0E,$1F,$01,$A3,$1F
        EQUB    $78,$2A,$01,$2A,$09,$0D,$1F,$01
        EQUB    $A3,$1F,$78,$2A,$01,$20,$78,$58
        EQUB    $01,$1D,$78,$59,$00,$19,$58,$0B
        EQUB    $33,$B1,$27,$58,$0B,$2D,$EF,$0C
        EQUB    $58,$0B,$2A,$03,$00,$58,$0B,$1E
        EQUB    $79,$14,$05,$FA,$0C,$02,$58,$0B
        EQUB    $0E,$60,$13,$58,$0B,$0F,$4D,$13
        EQUB    $5A,$0B,$10,$39,$0C,$58,$0B,$13
        EQUB    $15,$17,$58,$0B,$16,$1A,$0D,$58
        EQUB    $0B,$19,$D1,$0C,$58,$0B,$1A,$CE
        EQUB    $0C,$58,$0B,$18,$AA,$0C,$58,$0B
        EQUB    $2A,$03,$00,$58,$0B,$1E,$79,$14
        EQUB    $58,$0B,$1F,$80,$14,$58,$0B,$24
        EQUB    $7E,$0B,$58,$0B,$32,$A0,$19,$58
        EQUB    $0B,$22,$30,$0C,$58,$0B,$23,$2B
        EQUB    $0C,$58,$0B,$44,$65,$0D,$58,$0B
        EQUB    $45,$AC,$0D,$58,$0B,$46,$B1,$0D
        EQUB    $58,$0B,$1B,$43,$11,$58,$0B,$1C
        EQUB    $BF,$19,$58,$0B,$1D,$BF,$19,$58
        EQUB    $0B,$54,$09,$1B,$58,$0B,$52,$4A
        EQUB    $1B,$58,$0B,$2F,$69,$1B,$58,$0B
        EQUB    $62,$9B,$0B,$58,$0B,$63,$9F,$0B
        EQUB    $58,$0B,$61,$97,$0B,$58,$0B,$64
        EQUB    $8D,$0D,$58,$0B,$40,$B7,$0E,$58
        EQUB    $0B,$60,$59,$1B,$58,$0B,$4C,$3B
        EQUB    $1A,$59,$0D,$FF,$04,$05,$58,$58
        EQUB    $01,$47,$06,$08,$F1,$07,$30,$00
        EQUB    $D5,$02,$5A,$0B,$29,$85,$05,$58
        EQUB    $0B,$49,$A4,$17,$58,$0B,$3D,$2B
        EQUB    $0D,$58,$0B,$59,$2B,$0D,$58,$0B
        EQUB    $3E,$16,$0E,$58,$0B,$3F,$46,$0E
        EQUB    $58,$0B,$2D,$EF,$0C,$58,$0B,$29
        EQUB    $64,$0E,$58,$0B,$2E,$C5,$19,$58
        EQUB    $0B,$41,$39,$0E,$58,$0B,$42,$E1
        EQUB    $18,$58,$0B,$53,$1F,$14,$58,$0B
        EQUB    $5F,$23,$14,$58,$0B,$4D,$8C,$15
        EQUB    $58,$0B,$4E,$DD,$15,$58,$0B,$51
        EQUB    $D6,$15,$58,$0B,$43,$6A,$18,$58
        EQUB    $0B,$30,$AB,$0E,$58,$0B,$56,$AD
        EQUB    $1A,$58,$0B,$5A,$F7,$18,$58,$0B
        EQUB    $5B,$5C,$18,$58,$0B,$33,$B1,$27
        EQUB    $58,$0B,$4F,$3E,$13,$58,$0B,$55
        EQUB    $2C,$19,$58,$0B,$4B,$0F,$1A,$05
        EQUB    $F4,$07,$02,$05,$F7,$07,$02,$79
        EQUB    $0B,$33,$06,$58,$0D,$E6,$9E,$08
        EQUB    $7A,$1F,$BE,$14,$7B,$1F,$C7,$10
        EQUB    $48,$BE,$01,$09,$1F,$0F,$0B,$01
        EQUB    $0F,$09,$0F,$40,$48,$63,$1F,$7A
        EQUB    $1F,$DC,$09,$3B,$1F,$04,$01,$04
        EQUB    $00,$9E,$08,$79,$1F,$5E,$06,$58
        EQUB    $0B,$54,$9E,$08,$5B,$1F,$8D,$7C
        EQUB    $08,$79,$23,$1F,$10,$09,$19,$21
        EQUB    $48,$00,$20,$01,$40,$0B,$78,$2A
        EQUB    $01,$2E,$20,$05,$79,$23,$01,$0C
        EQUB    $09,$54,$21,$48,$1F,$20,$01,$40
        EQUB    $0B,$20,$1D,$09,$54,$21,$48,$1F
        EQUB    $20,$01,$40,$0B,$09,$2A,$01,$48
        EQUB    $00,$2A,$78,$01,$01,$0A,$09,$19
        EQUB    $21,$48,$00,$20,$01,$40,$0B,$02
        EQUB    $45,$13,$1C,$45,$13,$02,$08,$D1
        EQUB    $07,$30,$20,$73,$08,$D2,$07,$30
        EQUB    $20,$6D,$78,$58,$01,$30,$05,$D5
        EQUB    $07,$21,$E6,$45,$09,$00,$09,$03
        EQUB    $58,$56,$01,$44,$16,$78,$58,$01
        EQUB    $1D,$05,$D3,$07,$21,$D3,$08,$D4
        EQUB    $07,$30,$20,$4B,$01,$87,$1A,$78
        EQUB    $2A,$00,$0A,$09,$54,$01,$01,$59
        EQUB    $02,$05,$11,$08,$02,$01,$87,$1A
        EQUB    $78,$2A,$00,$F9,$79,$54,$46,$07
        EQUB    $05,$14,$0F,$00,$09,$03,$09,$54
        EQUB    $01,$01,$59,$02,$08,$0E,$08,$30
        EQUB    $01,$D5,$02,$00,$09,$03,$78,$58
        EQUB    $01,$DC,$48,$00,$1F,$48,$01,$43
        EQUB    $0A,$08,$42,$1C,$45,$12,$05,$52
        EQUB    $08,$02,$08,$DA,$07,$30,$78,$58
        EQUB    $01,$C4,$04,$30,$45,$07,$00,$09
        EQUB    $03,$78,$1F,$00,$4B,$78,$58,$01
        EQUB    $A4,$78,$23,$02,$13,$78,$23,$1F
        EQUB    $1C,$05,$DC,$07,$09,$1F,$01,$01
        EQUB    $59,$02,$45,$09,$00,$09,$03,$09
        EQUB    $54,$21,$48,$1F,$20,$01,$40,$0B
        EQUB    $78,$2A,$01,$18,$58,$1F,$B4,$27
        EQUB    $06,$09,$54,$21,$48,$1F,$20,$01
        EQUB    $40,$0B,$78,$2A,$01,$06,$05,$DB
        EQUB    $07,$20,$D2,$78,$0B,$44,$06,$05
        EQUB    $DD,$07,$20,$C9,$05,$4E,$08,$02
        EQUB    $05,$E1,$07,$02,$48,$00,$43,$01
        EQUB    $0A,$0A,$48,$00,$0B,$58,$38,$01
        EQUB    $E9,$07,$48,$08,$34,$01,$2E,$09
        EQUB    $7A,$12,$39,$2F,$7B,$12,$50,$2B
        EQUB    $09,$12,$1F,$01,$71,$0B,$78,$2A
        EQUB    $01,$0D,$05,$0C,$08,$00,$EF,$09
        EQUB    $05,$0D,$08,$00,$EF,$09,$30,$54
        EQUB    $12,$05,$78,$58,$01,$F3,$09,$12
        EQUB    $54,$48,$01,$58,$01,$15,$0F,$00
        EQUB    $41,$16,$48,$02,$34,$01,$2E,$09
        EQUB    $79,$12,$00,$0F,$48,$08,$34,$01
        EQUB    $2E,$09,$3B,$12,$73,$0E,$A6,$00
        EQUB    $22,$06,$79,$12,$15,$18,$09,$41
        EQUB    $0B,$58,$45,$01,$E9,$07,$58,$58
        EQUB    $01,$47,$06,$08,$02,$08,$30,$01
        EQUB    $D5,$02,$00,$09,$03,$09,$12,$0B
        EQUB    $09,$0B,$41,$E8,$07,$07,$E8,$08
        EQUB    $07,$48,$00,$3A,$48,$00,$36,$48
        EQUB    $00,$0C,$48,$00,$63,$48,$FF,$0D
        EQUB    $48,$FF,$0E,$48,$FF,$10,$48,$FF
        EQUB    $11,$08,$FF,$FF,$0F,$48,$00,$42
        EQUB    $48,$00,$45,$58,$0B,$5E,$82,$0B
        EQUB    $7A,$0B,$0D,$5C,$01,$F8,$14,$58
        EQUB    $0B,$58,$0C,$16,$58,$0B,$47,$04
        EQUB    $16,$01,$0A,$0A,$78,$39,$01,$F0
        EQUB    $78,$38,$01,$44,$78,$0B,$3F,$0F
        EQUB    $78,$0B,$49,$0B,$48,$06,$34,$01
        EQUB    $2E,$09,$79,$12,$00,$3A,$01,$65
        EQUB    $09,$79,$1F,$00,$43,$78,$3D,$01
        EQUB    $CF,$48,$00,$34,$01,$2E,$09,$78
        EQUB    $12,$2C,$C5,$79,$12,$00,$C1,$48
        EQUB    $0E,$34,$01,$2E,$09,$78,$12,$00
        EQUB    $0C,$09,$12,$0F,$09,$0F,$40,$0A
        EQUB    $08,$42,$20,$AC,$01,$72,$0A,$78
        EQUB    $63,$00,$04,$09,$63,$0C,$02,$59
        EQUB    $0C,$00,$27,$06,$09,$12,$0C,$01
        EQUB    $84,$14,$01,$F8,$14,$20,$91,$79
        EQUB    $1F,$B6,$16,$09,$3F,$1F,$09,$40
        EQUB    $0F,$7A,$1F,$FF,$0C,$58,$58,$01
        EQUB    $47,$06,$05,$05,$08,$00,$09,$03
        EQUB    $59,$0C,$00,$1F,$09,$78,$1F,$B4
        EQUB    $36,$58,$1F,$B5,$19,$09,$09,$1F
        EQUB    $3F,$08,$FF,$FF,$40,$7A,$1F,$BE
        EQUB    $08,$7B,$1F,$C7,$04,$00,$91,$07
        EQUB    $79,$0B,$43,$09,$78,$58,$00,$05
        EQUB    $78,$1F,$88,$1C,$48,$C0,$01,$78
        EQUB    $36,$01,$04,$48,$80,$01,$09,$1F
        EQUB    $0D,$21,$52,$00,$91,$07,$48,$01
        EQUB    $3A,$09,$3A,$0D,$00,$91,$07,$59
        EQUB    $0C,$00,$7C,$06,$09,$1F,$0E,$48
        EQUB    $5D,$63,$00,$91,$07,$7A,$01,$40
        EQUB    $09,$48,$40,$02,$0B,$02,$01,$20
        EQUB    $F5,$02,$08,$2C,$01,$01,$0A,$1F
        EQUB    $01,$3B,$01,$CF,$07,$17,$08,$E8
        EQUB    $03,$02,$0B,$02,$01,$30,$01,$19
        EQUB    $0C,$08,$2C,$01,$02,$0B,$02,$01
        EQUB    $31,$01,$19,$05,$48,$01,$2A,$02
        EQUB    $48,$00,$2A,$02,$A8,$07,$02,$78
        EQUB    $02,$00,$06,$11,$01,$02,$7C,$06
        EQUB    $48,$01,$02,$A8,$02,$03,$30,$03
        EQUB    $1F,$1E,$78,$03,$00,$06,$0A,$08
        EQUB    $02,$20,$F1,$5B,$02,$0F,$7C,$06
        EQUB    $0A,$08,$42,$E8,$07,$01,$E8,$02
        EQUB    $1F,$0A,$08,$02,$E8,$02,$07,$02
        EQUB    $48,$00,$2A,$A8,$07,$01,$79,$01
        EQUB    $C0,$15,$48,$01,$02,$A8,$02,$01
        EQUB    $0A,$08,$02,$78,$01,$00,$08,$31
        EQUB    $01,$1F,$F3,$48,$01,$2A,$02,$58
        EQUB    $58,$01,$47,$06,$48,$FF,$3F,$48
        EQUB    $01,$43,$1C,$45,$12,$01,$25,$22
        EQUB    $48,$00,$1F,$78,$2A,$01,$08,$08
        EQUB    $EE,$07,$30,$01,$D5,$02,$02,$48
        EQUB    $01,$36,$00,$91,$07,$78,$0E,$FF
        EQUB    $06,$11,$0E,$1F,$7C,$06,$09,$1F
        EQUB    $0E,$00,$91,$07,$48,$00,$13,$01
        EQUB    $7F,$0A,$78,$12,$00,$2D,$79,$35
        EQUB    $0E,$04,$0A,$09,$13,$0A,$09,$13
        EQUB    $48,$01,$44,$18,$12,$6A,$0E,$A7
        EQUB    $1A,$31,$35,$34,$E3,$79,$35,$08
        EQUB    $12,$3A,$12,$2C,$01,$0D,$3B,$12
        EQUB    $F4,$01,$08,$08,$2C,$01,$01,$0B
        EQUB    $01,$12,$02,$48,$01,$3D,$48,$0A
        EQUB    $34,$21,$C2,$78,$12,$00,$11,$09
        EQUB    $12,$10,$21,$BC,$78,$12,$00,$04
        EQUB    $09,$12,$11,$48,$00,$1F,$02,$48
        EQUB    $08,$34,$21,$A9,$48,$00,$1F,$78
        EQUB    $0C,$00,$04,$48,$1F,$23,$3B,$12
        EQUB    $73,$0E,$31,$3B,$12,$0F,$0E,$1E
        EQUB    $78,$10,$FF,$09,$30,$12,$10,$05
        EQUB    $31,$12,$11,$0B,$09,$12,$1F,$01
        EQUB    $89,$05,$78,$2A,$01,$2C,$01,$31
        EQUB    $09,$79,$12,$00,$DA,$78,$1F,$00
        EQUB    $31,$7B,$1F,$8D,$0E,$01,$8B,$06
        EQUB    $48,$01,$43,$48,$00,$2A,$48,$00
        EQUB    $1F,$02,$78,$1F,$B4,$1C,$78,$1F
        EQUB    $B6,$18,$78,$1F,$B5,$14,$00,$68
        EQUB    $06,$7A,$1F,$DC,$08,$3B,$1F,$04
        EQUB    $01,$03,$20,$06,$5B,$1F,$8D,$F9
        EQUB    $08,$48,$00,$3D,$02,$48,$00,$13
        EQUB    $01,$7F,$0A,$E9,$07,$07,$E9,$08
        EQUB    $07,$78,$12,$00,$08,$48,$01,$3E
        EQUB    $21,$07,$20,$EA,$48,$00,$3E,$02
        EQUB    $78,$3C,$01,$22,$78,$37,$01,$1E
        EQUB    $07,$01,$01,$01,$01,$48,$00,$34
        EQUB    $01,$2E,$09,$7A,$12,$21,$06,$5A
        EQUB    $12,$26,$0A,$0A,$21,$0C,$78,$56
        EQUB    $00,$04,$01,$DF,$16,$48,$00,$37
        EQUB    $02,$48,$00,$13,$21,$48,$48,$00
        EQUB    $39,$48,$00,$38,$78,$12,$00,$2A
        EQUB    $48,$04,$34,$01,$2E,$09,$38,$12
        EQUB    $E5,$01,$22,$48,$00,$34,$01,$2E
        EQUB    $09,$78,$3E,$01,$06,$58,$12,$80
        EQUB    $14,$06,$58,$12,$2C,$66,$0A,$78
        EQUB    $12,$2E,$0A,$02,$48,$01,$39,$20
        EQUB    $04,$48,$01,$3C,$48,$01,$38,$02
        EQUB    $48,$00,$13,$21,$09,$78,$12,$00
        EQUB    $04,$48,$01,$37,$02,$A9,$13,$12
        EQUB    $79,$12,$01,$0E,$48,$0E,$35,$09
        EQUB    $13,$01,$0A,$08,$01,$A9,$01,$12
        EQUB    $02,$09,$12,$35,$48,$20,$01,$7A
        EQUB    $12,$20,$06,$0B,$01,$12,$20,$F8
        EQUB    $21,$6C,$48,$01,$01,$0A,$13,$01
        EQUB    $A9,$01,$02,$0A,$02,$12,$09,$35
        EQUB    $02,$48,$00,$35,$48,$00,$01,$7A
        EQUB    $02,$20,$46,$48,$02,$35,$48,$64
        EQUB    $01,$7A,$02,$40,$3C,$48,$04,$35
        EQUB    $48,$00,$01,$7A,$02,$60,$32,$48
        EQUB    $06,$35,$48,$18,$01,$7A,$02,$80
        EQUB    $28,$48,$08,$35,$08,$2C,$01,$01
        EQUB    $7A,$02,$A0,$1D,$48,$0A,$35,$08
        EQUB    $2C,$01,$01,$7A,$02,$C0,$12,$48
        EQUB    $0C,$35,$08,$D8,$0E,$01,$7A,$02
        EQUB    $E0,$07,$48,$07,$35,$48,$00,$01
        EQUB    $0B,$01,$12,$3B,$12,$60,$EA,$02
        EQUB    $02,$48,$00,$12,$02,$0A,$12,$12
        EQUB    $0A,$12,$12,$0A,$12,$12,$0A,$12
        EQUB    $12,$0A,$12,$12,$0A,$12,$12,$0A
        EQUB    $12,$12,$0A,$12,$12,$02,$48,$00
        EQUB    $01,$08,$00,$01,$02,$0B,$02,$12
        EQUB    $3B,$12,$50,$C3,$06,$0A,$08,$01
        EQUB    $20,$F4,$09,$01,$12,$02,$09,$1F
        EQUB    $04,$78,$21,$00,$08,$A2,$04,$01
        EQUB    $31,$01,$21,$18,$A3,$04,$01,$78
        EQUB    $01,$00,$05,$78,$20,$1F,$05,$31
        EQUB    $01,$20,$09,$48,$01,$2A,$02,$48
        EQUB    $00,$2A,$02,$A3,$04,$01,$78,$01
        EQUB    $00,$F6,$A2,$04,$04,$20,$D3,$09
        EQUB    $23,$3B,$48,$1F,$23,$01,$89,$05
        EQUB    $09,$3B,$23,$02,$05,$7F,$08,$02
        EQUB    $01,$0A,$0A,$48,$04,$34,$01,$2E
        EQUB    $09,$19,$12,$E6,$01,$7C,$06,$05
        EQUB    $20,$08,$00,$09,$03,$05,$21,$08
        EQUB    $02,$05,$22,$08,$02,$05,$23,$08
        EQUB    $02,$48,$01,$57,$78,$01,$88,$61
        EQUB    $78,$01,$46,$65,$78,$01,$41,$59
        EQUB    $78,$01,$89,$51,$48,$00,$57,$78
        EQUB    $01,$77,$4E,$78,$01,$33,$4E,$78
        EQUB    $01,$09,$4A,$58,$01,$56,$12,$0C
        EQUB    $78,$01,$0E,$45,$78,$01,$1E,$41
        EQUB    $78,$01,$15,$3D,$78,$01,$16,$39
        EQUB    $78,$01,$17,$35,$78,$01,$63,$31
        EQUB    $78,$01,$1A,$2D,$78,$01,$1F,$25
        EQUB    $78,$01,$21,$25,$78,$01,$5F,$1D
        EQUB    $78,$01,$60,$19,$78,$01,$67,$15
        EQUB    $78,$01,$6A,$15,$78,$01,$7D,$11
        EQUB    $78,$01,$04,$0D,$48,$02,$2A,$02
        EQUB    $48,$01,$2A,$02,$48,$03,$2A,$02
        EQUB    $48,$04,$2A,$02,$21,$8C,$58,$2A
        EQUB    $04,$80,$02,$58,$2A,$03,$84,$02
        EQUB    $78,$2A,$01,$03,$45,$14,$00,$86
        EQUB    $02,$14,$00,$00,$12,$0E,$14,$01
        EQUB    $07,$48,$00,$33,$00,$03,$00,$59
        EQUB    $0C,$00,$7C,$06,$59,$1F,$FF,$7C
        EQUB    $06,$09,$0B,$1A,$09,$19,$14,$01
        EQUB    $93,$02,$78,$17,$00,$04,$00,$78
        EQUB    $13,$08,$42,$08,$30,$00,$53,$1A
        EQUB    $01,$EF,$09,$48,$5E,$4F,$01,$0C
        EQUB    $19,$05,$6E,$0A,$01,$12,$15,$08
        EQUB    $70,$0A,$30,$78,$2A,$00,$05,$08
        EQUB    $6F,$0A,$30,$04,$30,$20,$0E,$05
        EQUB    $C8,$0D,$05,$9E,$08,$08,$E6,$0D
        EQUB    $4A,$01,$4A,$11,$05,$A1,$08,$01
        EQUB    $EF,$09,$21,$03,$20,$FD,$48,$01
        EQUB    $3E,$48,$00,$3C,$01,$0A,$0A,$48
        EQUB    $02,$34,$01,$2E,$09,$58,$12,$19
        EQUB    $DB,$0C,$58,$12,$18,$D4,$11,$02
        EQUB    $05,$98,$08,$01,$12,$15,$78,$2A
        EQUB    $00,$1D,$01,$EF,$09,$05,$99,$08
        EQUB    $48,$03,$01,$E9,$07,$01,$06,$01
        EQUB    $A9,$08,$01,$79,$01,$20,$F2,$45
        EQUB    $05,$00,$D4,$11,$06,$03,$02,$05
        EQUB    $9A,$08,$01,$12,$15,$78,$2A,$00
        EQUB    $06,$06,$04,$48,$00,$33,$01,$03
        EQUB    $00,$48,$00,$3C,$48,$00,$38,$01
        EQUB    $0A,$0A,$00,$09,$03,$59,$0C,$00
        EQUB    $60,$0E,$7A,$1F,$8E,$05,$05,$40
        EQUB    $08,$02,$01,$0B,$23,$78,$2A,$01
        EQUB    $F9,$08,$58,$02,$01,$0A,$1F,$01
        EQUB    $04,$01,$45,$09,$01,$3C,$22,$09
        EQUB    $1F,$22,$48,$1F,$23,$00,$35,$01
        EQUB    $09,$54,$22,$48,$1F,$23,$01,$35
        EQUB    $01,$79,$25,$00,$04,$05,$3A,$08
        EQUB    $02,$59,$0C,$00,$49,$0D,$09,$0D
        EQUB    $1F,$09,$54,$21,$48,$04,$20,$08
        EQUB    $13,$08,$4A,$58,$58,$01,$4D,$10
        EQUB    $08,$66,$08,$4A,$00,$4D,$10,$09
        EQUB    $0D,$1F,$09,$0E,$21,$09,$23,$3B
        EQUB    $48,$1F,$20,$01,$40,$0B,$09,$3B
        EQUB    $23,$09,$0E,$1F,$58,$2A,$00,$DA
        EQUB    $06,$20,$CC,$78,$0C,$01,$28,$78
        EQUB    $0C,$42,$10,$78,$0C,$43,$0C,$78
        EQUB    $0C,$07,$1C,$78,$0C,$46,$04,$00
        EQUB    $7C,$06,$A3,$54,$01,$58,$01,$00
        EQUB    $24,$27,$09,$19,$17,$48,$00,$16
        EQUB    $00,$78,$13,$48,$01,$0C,$09,$0C
        EQUB    $16,$20,$20,$05,$FA,$07,$48,$64
        EQUB    $30,$0A,$0B,$30,$04,$30,$48,$18
        EQUB    $30,$0A,$0C,$30,$04,$30,$05,$FD
        EQUB    $07,$02,$48,$0C,$16,$20,$04,$48
        EQUB    $0D,$16,$79,$0C,$00,$04,$48,$01
        EQUB    $0C,$48,$00,$3D,$48,$78,$1F,$21
        EQUB    $1E,$48,$61,$1F,$21,$19,$48,$74
        EQUB    $1F,$21,$14,$48,$11,$1F,$21,$0F
        EQUB    $48,$66,$1F,$21,$0A,$79,$0B,$46
        EQUB    $01,$78,$3D,$00,$B7,$02,$30,$0E
        EQUB    $1F,$23,$21,$06,$78,$2A,$01,$1D
        EQUB    $02,$78,$3D,$01,$10,$01,$71,$0B
        EQUB    $78,$2A,$00,$09,$78,$0E,$FF,$09
        EQUB    $30,$0E,$1F,$05,$48,$00,$2A,$02
        EQUB    $48,$01,$2A,$02,$48,$01,$3D,$09
        EQUB    $0C,$16,$09,$1F,$17,$00,$78,$13
        EQUB    $05,$69,$08,$02,$A3,$0D,$01,$79
        EQUB    $01,$05,$0C,$A2,$0D,$01,$31,$01
        EQUB    $54,$05,$05,$63,$08,$02,$79,$0C
        EQUB    $00,$35,$09,$54,$21,$48,$05,$20
        EQUB    $08,$68,$08,$4A,$00,$4D,$10,$09
        EQUB    $54,$21,$48,$04,$20,$08,$69,$08
        EQUB    $4A,$00,$4D,$10,$09,$19,$21,$48
        EQUB    $00,$20,$08,$12,$08,$4A,$58,$58
        EQUB    $01,$4D,$10,$08,$67,$08,$4A,$00
        EQUB    $4D,$10,$05,$54,$08,$02,$05,$55
        EQUB    $08,$02,$09,$54,$69,$79,$0D,$6E
        EQUB    $0C,$08,$CE,$09,$30,$01,$71,$1A
        EQUB    $82,$6E,$07,$02,$78,$0D,$88,$09
        EQUB    $7A,$0D,$39,$14,$7B,$0D,$51,$10
        EQUB    $09,$0D,$6A,$09,$0E,$6B,$01,$2B
        EQUB    $27,$01,$5C,$27,$00,$4F,$25,$79
        EQUB    $0D,$65,$17,$C2,$65,$01,$79,$01
        EQUB    $8B,$10,$01,$2B,$27,$58,$6B,$FF
        EQUB    $0B,$1A,$05,$0B,$0A,$82,$65,$07
        EQUB    $02,$58,$58,$01,$47,$06,$08,$60
        EQUB    $08,$30,$00,$D5,$02,$78,$0D,$FF
        EQUB    $A2,$78,$0E,$FF,$A2,$09,$0E,$1F
        EQUB    $01,$89,$05,$78,$2A,$00,$10,$09
        EQUB    $0D,$1F,$78,$0C,$01,$0D,$78,$0C
        EQUB    $02,$40,$78,$0C,$07,$22,$05,$4B
        EQUB    $08,$02,$48,$00,$3D,$48,$78,$1F
        EQUB    $01,$EB,$0D,$78,$2A,$00,$F0,$09
        EQUB    $0D,$1F,$09,$0E,$21,$09,$0C,$20
        EQUB    $08,$69,$08,$4A,$00,$4D,$10,$78
        EQUB    $0E,$18,$ED,$78,$0E,$66,$E9,$78
        EQUB    $0E,$5E,$E5,$78,$0E,$14,$E1,$78
        EQUB    $0E,$75,$DD,$78,$0E,$11,$D9,$20
        EQUB    $C6,$20,$C4,$09,$54,$04,$78,$59
        EQUB    $00,$05,$09,$59,$19,$02,$A2,$04
        EQUB    $19,$A3,$04,$01,$58,$01,$00,$30
        EQUB    $0F,$09,$19,$04,$20,$F1,$02,$09
        EQUB    $47,$03,$A4,$03,$02,$30,$02,$21
        EQUB    $0D,$78,$02,$00,$09,$0A,$08,$03
        EQUB    $20,$F1,$48,$00,$03,$09,$03,$47
        EQUB    $02,$A2,$1F,$01,$31,$01,$19,$15
        EQUB    $06,$02,$01,$7B,$01,$A0,$0E,$09
        EQUB    $1F,$01,$01,$59,$02,$45,$01,$01
        EQUB    $D5,$02,$45,$09,$A4,$47,$14,$58
        EQUB    $14,$FF,$F2,$0F,$A2,$1F,$01,$31
        EQUB    $01,$14,$7E,$0A,$08,$47,$79,$14
        EQUB    $00,$06,$09,$48,$47,$20,$E6,$A4
        EQUB    $47,$15,$79,$15,$00,$06,$09,$48
        EQUB    $47,$20,$F5,$78,$15,$FF,$62,$E2
        EQUB    $1F,$15,$E3,$1F,$07,$10,$14,$15
        EQUB    $F2,$0F,$08,$D6,$0D,$30,$09,$1F
        EQUB    $01,$01,$CA,$2D,$30,$14,$19,$18
        EQUB    $31,$15,$19,$45,$08,$D4,$0D,$30
        EQUB    $09,$1F,$01,$01,$CA,$2D,$09,$15
        EQUB    $01,$09,$14,$15,$09,$01,$14,$09
        EQUB    $1F,$01,$3B,$30,$D5,$0D,$06,$01
        EQUB    $16,$0C,$20,$04,$01,$59,$02,$04
        EQUB    $30,$01,$C2,$02,$48,$64,$01,$0A
        EQUB    $1A,$01,$04,$01,$45,$09,$01,$93
        EQUB    $02,$78,$52,$00,$0C,$05,$44,$08
        EQUB    $09,$1F,$01,$01,$59,$02,$45,$09
        EQUB    $02,$48,$00,$2A,$78,$1F,$44,$0D
        EQUB    $7B,$1F,$5D,$0C,$7A,$1F,$39,$05
        EQUB    $7A,$1F,$55,$04,$48,$01,$2A,$02
        EQUB    $78,$20,$00,$36,$09,$21,$04,$A3
        EQUB    $04,$01,$78,$01,$00,$2C,$09,$04
        EQUB    $03,$A2,$04,$04,$31,$04,$1F,$F0
        EQUB    $A2,$1F,$01,$E2,$03,$01,$A3,$1F
        EQUB    $01,$E3,$03,$01,$05,$07,$08,$09
        EQUB    $03,$01,$01,$59,$02,$05,$08,$08
        EQUB    $09,$04,$01,$01,$59,$02,$05,$09
        EQUB    $08,$02,$48,$00,$21,$48,$00,$20
        EQUB    $48,$00,$4A,$21,$A5,$58,$2A,$00
        EQUB    $34,$11,$21,$B5,$78,$20,$00,$42
        EQUB    $79,$20,$05,$10,$78,$1F,$04,$0C
        EQUB    $78,$1F,$1E,$08,$78,$1F,$21,$04
        EQUB    $00,$3F,$11,$09,$1F,$46,$09,$21
        EQUB    $17,$09,$20,$16,$09,$1F,$21,$48
        EQUB    $1F,$20,$09,$54,$1F,$01,$40,$0B
        EQUB    $09,$46,$1F,$09,$17,$21,$09,$16
        EQUB    $20,$58,$2A,$01,$2D,$11,$48,$01
        EQUB    $2A,$01,$E3,$12,$58,$2A,$00,$2C
        EQUB    $11,$A2,$1F,$01,$31,$01,$54,$1E
        EQUB    $A3,$1F,$01,$78,$01,$00,$17,$79
        EQUB    $01,$05,$0C,$78,$3A,$00,$08,$05
        EQUB    $56,$08,$48,$00,$2A,$02,$01,$D4
        EQUB    $12,$78,$2A,$00,$6E,$78,$20,$00
        EQUB    $06,$10,$21,$1F,$D8,$0E,$78,$20
        EQUB    $00,$1D,$7A,$21,$39,$19,$7B,$21
        EQUB    $50,$15,$79,$21,$3C,$0A,$78,$1F
        EQUB    $04,$06,$05,$19,$08,$20,$50,$78
        EQUB    $20,$05,$04,$48,$04,$20,$A2,$1F
        EQUB    $14,$E2,$1F,$21,$E3,$1F,$20,$78
        EQUB    $58,$01,$05,$04,$4A,$20,$31,$09
        EQUB    $23,$3B,$09,$21,$6E,$01,$87,$1A
        EQUB    $09,$3B,$23,$78,$2A,$00,$21,$09
        EQUB    $54,$01,$01,$59,$02,$04,$4A,$09
        EQUB    $1F,$01,$01,$59,$02,$09,$6E,$21
        EQUB    $39,$4A,$14,$08,$09,$45,$5D,$09
        EQUB    $21,$01,$01,$59,$02,$45,$09,$48
        EQUB    $01,$2A,$02,$05,$53,$08,$48,$00
        EQUB    $2A,$02,$78,$58,$01,$0B,$08,$48
        EQUB    $08,$30,$00,$D5,$02,$05,$5E,$08
        EQUB    $02,$05,$DC,$09,$08,$E5,$0D,$4A
        EQUB    $21,$2B,$03,$04,$05,$E1,$0D,$08
        EQUB    $CA,$08,$30,$78,$04,$00,$12,$0B
        EQUB    $08,$04,$48,$0A,$01,$0B,$01,$04
        EQUB    $0A,$08,$30,$3A,$04,$50,$C3,$F3
        EQUB    $45,$03,$04,$30,$04,$4A,$03,$71
        EQUB    $05,$E4,$0D,$02,$48,$64,$04,$C6
        EQUB    $23,$01,$30,$01,$54,$38,$48,$18
        EQUB    $03,$48,$01,$02,$A7,$03,$01,$78
        EQUB    $01,$00,$0B,$0B,$08,$04,$7B,$03
        EQUB    $35,$04,$0B,$08,$04,$0A,$08,$03
        EQUB    $7A,$03,$61,$E9,$C6,$14,$01,$31
        EQUB    $01,$54,$07,$48,$1E,$01,$0B,$01
        EQUB    $04,$0A,$70,$04,$3B,$04,$30,$75
        EQUB    $06,$7B,$04,$64,$06,$02,$48,$00
        EQUB    $04,$02,$48,$64,$04,$02,$58,$0D
        EQUB    $FF,$5C,$0E,$05,$FC,$07,$48,$64
        EQUB    $30,$0A,$0B,$30,$04,$30,$05,$FD
        EQUB    $07,$02,$05,$34,$08,$06,$05,$48
        EQUB    $00,$07,$48,$01,$08,$48,$02,$09
        EQUB    $48,$03,$0A,$14,$01,$07,$48,$01
        EQUB    $01,$01,$71,$00,$48,$FF,$3F,$08
        EQUB    $FF,$FF,$40,$48,$01,$3C,$21,$4D
        EQUB    $48,$05,$4B,$48,$01,$5B,$48,$01
        EQUB    $44,$48,$01,$17,$48,$01,$65,$48
        EQUB    $1C,$60,$48,$1E,$66,$48,$32,$67
        EQUB    $48,$1E,$68,$48,$88,$54,$01,$15
        EQUB    $0F,$48,$14,$71,$48,$0F,$74,$48
        EQUB    $8E,$01,$48,$04,$02,$E6,$01,$02
        EQUB    $0A,$08,$01,$7A,$01,$98,$F7,$01
        EQUB    $B4,$15,$48,$8E,$01,$0A,$2F,$01
        EQUB    $48,$02,$02,$E6,$01,$02,$01,$D7
        EQUB    $13,$00,$09,$03,$48,$00,$1F,$01
        EQUB    $50,$15,$0A,$08,$1F,$7A,$1F,$8E
        EQUB    $F7,$48,$00,$01,$E7,$01,$07,$7B
        EQUB    $01,$20,$07,$E8,$01,$07,$E9,$01
        EQUB    $07,$7B,$01,$26,$04,$E6,$01,$07
        EQUB    $0A,$08,$01,$7A,$01,$61,$E6,$48
        EQUB    $00,$01,$48,$26,$03,$A5,$01,$02
        EQUB    $E6,$03,$02,$0A,$08,$01,$0A,$08
        EQUB    $03,$7A,$01,$68,$F1,$02,$08,$3D
        EQUB    $08,$30,$00,$D5,$02,$7A,$19,$41
        EQUB    $0E,$7B,$19,$58,$0A,$05,$AA,$0A
        EQUB    $48,$2A,$4F,$01,$0C,$19,$02,$48
        EQUB    $00,$16,$A3,$54,$01,$78,$01,$00
        EQUB    $01,$79,$17,$78,$08,$C2,$6E,$01
        EQUB    $79,$01,$00,$18,$79,$17,$87,$05
        EQUB    $78,$73,$00,$10,$79,$17,$45,$0B
        EQUB    $C2,$65,$01,$79,$01,$8B,$04,$48
        EQUB    $00,$1D,$02,$48,$00,$17,$48,$00
        EQUB    $1D,$02,$78,$1F,$3F,$05,$48,$01
        EQUB    $2A,$02,$05,$8E,$0A,$48,$00,$2A
        EQUB    $02,$21,$05,$01,$71,$1A,$02,$48
        EQUB    $00,$30,$48,$01,$2A,$79,$0B,$3E
        EQUB    $01,$79,$21,$44,$06,$05,$36,$0A
        EQUB    $20,$1A,$79,$21,$89,$12,$08,$37
        EQUB    $0A,$30,$78,$58,$01,$05,$08,$38
        EQUB    $0A,$30,$04,$30,$00,$09,$03,$48
        EQUB    $01,$2A,$02,$48,$00,$2A,$02,$78
        EQUB    $19,$86,$05,$79,$19,$81,$04,$82
        EQUB    $8C,$19,$79,$19,$01,$04,$82,$8D
        EQUB    $07,$C2,$3E,$01,$78,$01,$FD,$0C
        EQUB    $78,$19,$30,$05,$79,$19,$34,$04
        EQUB    $82,$61,$19,$02,$00,$D8,$0E,$E2
        EQUB    $0D,$0E,$48,$0F,$01,$E3,$0D,$01
        EQUB    $00,$12,$0E,$58,$0C,$46,$7C,$0D
        EQUB    $58,$0C,$07,$8D,$0D,$58,$0C,$01
        EQUB    $8D,$0D,$05,$51,$08,$02,$79,$19
        EQUB    $57,$09,$48,$00,$16,$48,$7A,$17
        EQUB    $20,$0D,$48,$09,$1A,$58,$0D,$7A
        EQUB    $46,$0C,$05,$4F,$08,$02,$01,$15
        EQUB    $0F,$09,$19,$14,$78,$16,$00,$0D
        EQUB    $79,$17,$61,$11,$79,$5E,$00,$0D
        EQUB    $05,$97,$0A,$02,$01,$C4,$1B,$58
        EQUB    $2A,$00,$C3,$1B,$09,$19,$14,$79
        EQUB    $16,$00,$3B,$09,$0B,$1A,$09,$17
        EQUB    $5C,$01,$93,$02,$09,$5C,$17,$78
        EQUB    $52,$00,$0C,$78,$51,$01,$08,$08
        EQUB    $43,$08,$30,$00,$53,$1A,$78,$58
        EQUB    $00,$09,$09,$17,$5D,$21,$47,$09
        EQUB    $5D,$17,$78,$58,$01,$10,$78,$52
        EQUB    $00,$0C,$05,$44,$08,$09,$54,$01
        EQUB    $01,$59,$02,$45,$09,$09,$19,$1C
        EQUB    $E2,$54,$17,$E3,$54,$16,$48,$00
        EQUB    $51,$48,$00,$49,$01,$FC,$02,$09
        EQUB    $19,$17,$01,$15,$0F,$58,$58,$01
        EQUB    $97,$1B,$A3,$54,$01,$78,$01,$00
        EQUB    $07,$01,$80,$00,$00,$97,$1B,$01
        EQUB    $03,$00,$00,$97,$1B,$09,$54,$1F
        EQUB    $48,$88,$54,$01,$15,$0F,$09,$17
        EQUB    $15,$01,$8D,$0F,$09,$1F,$54,$01
        EQUB    $15,$0F,$00,$97,$1B,$05,$6A,$08
        EQUB    $02,$79,$0D,$FA,$F9,$5B,$19,$37
        EQUB    $8B,$06,$5A,$19,$2C,$8B,$06,$05
        EQUB    $6D,$08,$79,$19,$2C,$EB,$48,$5D
        EQUB    $4F,$00,$0C,$19,$01,$15,$0F,$01
        EQUB    $88,$1D,$0A,$08,$49,$0A,$08,$4C
        EQUB    $0B,$08,$4D,$78,$4D,$00,$06,$3A
        EQUB    $4D,$50,$C3,$EC,$7A,$4C,$3C,$1C
        EQUB    $48,$3C,$01,$0B,$01,$4C,$0A,$08
        EQUB    $4B,$7B,$4C,$3B,$F4,$7A,$4B,$18
        EQUB    $0B,$48,$17,$01,$0B,$01,$4B,$7B
        EQUB    $4B,$0B,$F7,$48,$01,$4D,$02,$05
        EQUB    $6B,$08,$48,$0A,$4D,$02,$05,$23
        EQUB    $0A,$02,$79,$0B,$2A,$0B,$78,$0C
        EQUB    $00,$07,$48,$2D,$0B,$48,$00,$0C
        EQUB    $79,$0B,$3C,$14,$78,$0C,$46,$0D
        EQUB    $78,$0C,$42,$09,$78,$0C,$07,$05
        EQUB    $79,$0C,$01,$04,$48,$44,$0B,$79
        EQUB    $0B,$20,$07,$48,$01,$0C,$48,$44
        EQUB    $0B,$79,$0B,$21,$07,$48,$42,$0C
        EQUB    $48,$44,$0B,$79,$0B,$3D,$0F,$79
        EQUB    $0C,$42,$0B,$79,$0D,$FF,$07,$48
        EQUB    $41,$0B,$48,$00,$0C,$79,$0B,$40
        EQUB    $1E,$79,$0C,$01,$0C,$79,$0D,$FF
        EQUB    $16,$48,$3E,$0B,$48,$00,$0C,$02
        EQUB    $79,$0C,$46,$0B,$48,$4C,$0B,$79
        EQUB    $0D,$FF,$04,$09,$0E,$0D,$79,$0B
        EQUB    $3C,$04,$48,$3D,$0B,$02,$48,$02
        EQUB    $23,$78,$0B,$3D,$13,$78,$0B,$44
        EQUB    $0F,$48,$01,$23,$78,$0B,$3F,$08
        EQUB    $78,$0B,$33,$04,$48,$1F,$23,$02
        EQUB    $78,$58,$01,$37,$48,$00,$3C,$48
        EQUB    $01,$3E,$01,$0A,$0A,$78,$38,$01
        EQUB    $F0,$48,$08,$34,$01,$2E,$09,$38
        EQUB    $12,$10,$0E,$1B,$38,$12,$11,$0E
        EQUB    $1A,$78,$12,$01,$16,$48,$02,$34
        EQUB    $01,$2E,$09,$01,$0A,$0A,$48,$02
        EQUB    $34,$01,$2E,$09,$20,$D8,$48,$01
        EQUB    $2A,$02,$48,$00,$2A,$02,$09,$1F
        EQUB    $04,$0A,$04,$04,$A1,$04,$01,$01
        EQUB    $6F,$08,$E3,$1F,$01,$0A,$08,$04
        EQUB    $A1,$04,$01,$E2,$1F,$01,$02,$48
        EQUB    $00,$1F,$A2,$1F,$01,$31,$01,$21
        EQUB    $12,$A3,$1F,$02,$78,$02,$00,$0B
        EQUB    $E2,$1F,$17,$78,$16,$1F,$04,$E3
        EQUB    $1F,$16,$0A,$08,$1F,$7A,$1F,$8E
        EQUB    $E2,$02,$79,$1F,$8C,$0D,$59,$19
        EQUB    $86,$88,$12,$05,$F0,$09,$48,$01
        EQUB    $73,$02,$C6,$20,$01,$31,$01,$1F
        EQUB    $05,$05,$17,$0D,$02,$00,$34,$11
        EQUB    $48,$02,$01,$21,$10,$7B,$2F,$63
        EQUB    $F8,$02,$48,$19,$01,$21,$06,$7B
        EQUB    $2F,$09,$F8,$02,$48,$00,$2F,$06
        EQUB    $02,$02,$3B,$02,$50,$C3,$0D,$32
        EQUB    $02,$01,$09,$0A,$08,$2F,$0B,$01
        EQUB    $02,$20,$F0,$02,$59,$0D,$62,$24
        EQUB    $27,$20,$05,$79,$0D,$70,$07,$05
        EQUB    $F1,$09,$00,$4B,$1A,$59,$0D,$69
        EQUB    $48,$18,$C2,$73,$01,$59,$01,$87
        EQUB    $12,$0E,$05,$05,$0A,$82,$73,$07
        EQUB    $82,$79,$07,$48,$A0,$01,$82,$34
        EQUB    $01,$02,$05,$6C,$08,$01,$A8,$16
        EQUB    $20,$18,$05,$6C,$08,$48,$01,$56
        EQUB    $01,$A8,$16,$01,$0A,$0A,$48,$06
        EQUB    $34,$01,$2E,$09,$58,$12,$00,$CA
        EQUB    $16,$48,$01,$56,$01,$0A,$0A,$48
        EQUB    $08,$34,$01,$2E,$09,$5A,$12,$39
        EQUB    $CA,$16,$5B,$12,$50,$CA,$16,$09
        EQUB    $12,$54,$48,$01,$58,$20,$04,$01
        EQUB    $72,$0A,$48,$01,$56,$01,$0A,$0A
        EQUB    $01,$72,$0A,$48,$02,$34,$01,$2E
        EQUB    $09,$79,$12,$00,$04,$01,$0A,$0A
        EQUB    $01,$DE,$06,$01,$F8,$14,$01,$6E
        EQUB    $17,$78,$3C,$00,$DE,$78,$5F,$01
        EQUB    $3B,$01,$87,$1A,$78,$2A,$00,$34
        EQUB    $48,$00,$26,$09,$54,$01,$01,$59
        EQUB    $02,$78,$54,$3C,$05,$79,$54,$3A
        EQUB    $0D,$C6,$1A,$01,$30,$01,$54,$06
        EQUB    $05,$76,$0D,$20,$17,$01,$B4,$15
        EQUB    $08,$0A,$0F,$01,$0A,$2F,$01,$79
        EQUB    $54,$46,$05,$08,$14,$0F,$01,$04
        EQUB    $01,$45,$09,$00,$09,$03,$21,$0C
        EQUB    $78,$1F,$FF,$07,$09,$1F,$54,$48
        EQUB    $01,$58,$02,$48,$39,$1F,$01,$71
        EQUB    $0B,$78,$2A,$01,$0B,$0A,$08,$1F
        EQUB    $7A,$1F,$51,$F3,$48,$FF,$1F,$02
        EQUB    $48,$01,$56,$01,$72,$0A,$21,$D7
        EQUB    $48,$01,$56,$01,$0A,$0A,$78,$3C
        EQUB    $00,$F7,$00,$09,$03,$48,$08,$34
        EQUB    $01,$2E,$09,$38,$12,$12,$0E,$43
        EQUB    $78,$12,$1E,$66,$78,$12,$16,$62
        EQUB    $78,$12,$1B,$5E,$78,$12,$25,$5A
        EQUB    $38,$12,$15,$0E,$17,$78,$12,$04
        EQUB    $02,$02,$79,$54,$49,$FC,$C2,$04
        EQUB    $01,$31,$01,$54,$F5,$05,$78,$0A
        EQUB    $00,$09,$03,$79,$19,$55,$11,$48
        EQUB    $3B,$1F,$48,$01,$5A,$08,$52,$0A
        EQUB    $30,$01,$FC,$24,$48,$01,$5F,$00
        EQUB    $09,$03,$78,$58,$00,$21,$48,$00
        EQUB    $26,$09,$54,$01,$01,$59,$02,$48
        EQUB    $39,$01,$09,$54,$02,$0B,$01,$02
        EQUB    $08,$74,$0E,$01,$0A,$02,$01,$04
        EQUB    $01,$45,$09,$48,$01,$5F,$00,$09
        EQUB    $03,$06,$02,$01,$08,$F2,$0D,$30
        EQUB    $7A,$01,$50,$05,$08,$F5,$0D,$30
        EQUB    $48,$4B,$1F,$01,$FC,$24,$48,$01
        EQUB    $5F,$00,$09,$03,$38,$0B,$12,$0E
        EQUB    $0C,$C6,$25,$01,$78,$54,$49,$05
        EQUB    $30,$01,$54,$02,$02,$78,$0B,$00
        EQUB    $6F,$5A,$0B,$10,$4E,$03,$58,$0B
        EQUB    $3D,$4E,$03,$58,$0B,$3F,$4E,$03
        EQUB    $58,$0B,$29,$4E,$03,$58,$0B,$43
        EQUB    $4E,$03,$58,$0B,$49,$4E,$03,$00
        EQUB    $47,$06,$78,$1F,$8A,$05,$79,$1F
        EQUB    $8D,$47,$01,$D6,$2D,$78,$2A,$01
        EQUB    $3F,$58,$51,$01,$55,$18,$79,$19
        EQUB    $DC,$0C,$78,$75,$01,$08,$08,$4C
        EQUB    $0A,$30,$00,$53,$1A,$48,$01,$51
        EQUB    $58,$58,$00,$12,$0E,$01,$87,$1A
        EQUB    $78,$2A,$00,$1C,$09,$54,$01,$01
        EQUB    $59,$02,$79,$54,$3A,$07,$05,$4B
        EQUB    $0A,$48,$01,$75,$05,$15,$08,$09
        EQUB    $1F,$01,$01,$59,$02,$45,$09,$02
        EQUB    $79,$1F,$63,$53,$58,$58,$01,$47
        EQUB    $06,$38,$0F,$FF,$FF,$50,$5B,$0F
        EQUB    $09,$A8,$23,$48,$8E,$01,$0A,$0F
        EQUB    $01,$A6,$01,$02,$78,$02,$01,$44
        EQUB    $58,$02,$03,$A8,$23,$79,$02,$04
        EQUB    $13,$48,$03,$02,$E6,$01,$02,$05
        EQUB    $F8,$09,$48,$14,$55,$09,$54,$6A
        EQUB    $00,$19,$26,$48,$01,$02,$E6,$01
        EQUB    $02,$48,$63,$01,$82,$22,$01,$48
        EQUB    $07,$01,$83,$22,$01,$01,$12,$0E
        EQUB    $48,$5B,$4F,$00,$0C,$19,$08,$64
        EQUB    $08,$30,$00,$53,$1A,$05,$58,$08
        EQUB    $00,$09,$03,$08,$45,$08,$30,$00
        EQUB    $53,$1A,$09,$0E,$01,$09,$0D,$0E
        EQUB    $09,$01,$0D,$48,$05,$20,$20,$04
        EQUB    $48,$04,$20,$78,$0E,$88,$20,$7A
        EQUB    $0E,$39,$15,$7A,$0E,$51,$18,$79
        EQUB    $0E,$FF,$0D,$01,$B5,$16,$78,$1F
        EQUB    $FF,$06,$09,$1F,$0E,$20,$08,$08
        EQUB    $7C,$08,$30,$00,$53,$1A,$78,$0E
        EQUB    $FF,$F6,$09,$0E,$21,$09,$0D,$1F
        EQUB    $79,$0E,$49,$1B,$79,$0D,$21,$10
        EQUB    $82,$04,$54,$48,$04,$01,$83,$04
        EQUB    $01,$08,$79,$0A,$4A,$20,$2E,$08
        EQUB    $7A,$0A,$30,$00,$FC,$24,$79,$0E
        EQUB    $3E,$17,$08,$98,$0A,$4A,$01,$4D
        EQUB    $10,$78,$2A,$00,$0B,$48,$02,$5E
        EQUB    $78,$19,$30,$04,$48,$01,$5E,$02
        EQUB    $08,$14,$08,$4A,$78,$58,$01,$05
        EQUB    $08,$69,$08,$4A,$00,$4D,$10,$79
        EQUB    $0E,$43,$10,$59,$0D,$22,$46,$0E
        EQUB    $05,$41,$0A,$82,$43,$07,$82,$22
        EQUB    $07,$02,$00,$46,$0E,$00,$C0,$11
        EQUB    $45,$05,$78,$19,$02,$05,$7A,$19
        EQUB    $37,$05,$05,$D1,$07,$02,$05,$D0
        EQUB    $07,$02,$A7,$4F,$01,$79,$01,$00
        EQUB    $19,$E7,$4F,$08,$48,$01,$4E,$48
        EQUB    $01,$01,$7B,$4F,$35,$04,$48,$02
        EQUB    $01,$0A,$01,$71,$5B,$71,$63,$79
        EQUB    $0C,$02,$79,$0D,$56,$12,$59,$0E
        EQUB    $8B,$24,$27,$05,$CC,$09,$48,$01
        EQUB    $64,$01,$44,$10,$00,$03,$00,$59
        EQUB    $0D,$26,$88,$12,$48,$00,$16,$05
        EQUB    $69,$0A,$78,$76,$00,$27,$79,$0D
        EQUB    $26,$2C,$7A,$19,$1A,$1F,$7B,$19
        EQUB    $D0,$1B,$7A,$19,$1E,$11,$7B,$19
        EQUB    $C9,$0D,$78,$19,$2C,$09,$78,$19
        EQUB    $BB,$05,$7B,$19,$1D,$07,$09,$76
        EQUB    $17,$00,$78,$13,$09,$19,$76,$48
        EQUB    $BB,$17,$00,$78,$13,$59,$0C,$00
        EQUB    $7C,$06,$05,$80,$08,$02,$48,$01
        EQUB    $2A,$7A,$19,$37,$11,$48,$2B,$4F
        EQUB    $01,$0C,$19,$48,$01,$2A,$78,$64
        EQUB    $01,$04,$48,$00,$2A,$02,$79,$19
        EQUB    $01,$07,$05,$D3,$09,$00,$4B,$1A
        EQUB    $78,$0D,$8C,$06,$59,$0E,$8C,$C0
        EQUB    $11,$79,$19,$86,$05,$05,$EE,$09
        EQUB    $02,$05,$EF,$09,$02,$09,$0B,$60
        EQUB    $00,$12,$0E,$79,$0D,$6E,$12,$79
        EQUB    $0E,$20,$3F,$05,$CF,$09,$82,$6E
        EQUB    $07,$82,$0B,$19,$83,$0B,$07,$02
        EQUB    $79,$0D,$7A,$17,$01,$2B,$27,$78
        EQUB    $6C,$00,$23,$C2,$12,$01,$59,$01
        EQUB    $00,$AB,$0E,$05,$16,$0A,$82,$12
        EQUB    $19,$02,$59,$0D,$76,$64,$0E,$01
        EQUB    $2B,$27,$78,$6C,$00,$0C,$05,$AC
        EQUB    $0A,$82,$76,$07,$02,$79,$0E,$FF
        EQUB    $04,$05,$57,$08,$02,$78,$0E,$0A
        EQUB    $17,$78,$65,$00,$0B,$48,$0A,$1F
        EQUB    $01,$EB,$0D,$78,$2A,$01,$09,$05
        EQUB    $D0,$09,$02,$05,$CB,$09,$02,$78
        EQUB    $65,$00,$F5,$79,$0D,$78,$F5,$05
        EQUB    $CA,$09,$82,$78,$07,$82,$0E,$19
        EQUB    $02,$78,$0E,$0A,$06,$59,$0D,$0A
        EQUB    $AB,$0E,$05,$D2,$09,$48,$00,$65
        EQUB    $02,$79,$72,$00,$04,$48,$01,$72
        EQUB    $02,$78,$58,$00,$18,$21,$2F,$58
        EQUB    $2A,$00,$09,$03,$09,$54,$01,$01
        EQUB    $59,$02,$08,$0E,$08,$30,$01,$D5
        EQUB    $02,$00,$09,$03,$04,$30,$02,$78
        EQUB    $58,$01,$04,$04,$30,$02,$09,$2A
        EQUB    $5C,$21,$0B,$78,$2A,$00,$03,$04
        EQUB    $30,$09,$5C,$2A,$02,$48,$01,$2A
        EQUB    $78,$58,$00,$19,$09,$20,$6D,$09
        EQUB    $21,$6E,$09,$1F,$6F,$48,$88,$1F
        EQUB    $01,$71,$0B,$09,$6E,$21,$09,$6D
        EQUB    $20,$09,$6F,$1F,$02,$05,$84,$08
        EQUB    $00,$09,$03,$58,$0D,$FF,$5C,$0E
        EQUB    $C2,$5E,$01,$30,$01,$19,$06,$21
        EQUB    $5F,$05,$0F,$0A,$09,$0D,$1F,$48
        EQUB    $5E,$21,$48,$07,$20,$08,$11,$0A
        EQUB    $4A,$01,$4D,$10,$78,$2A,$00,$37
        EQUB    $09,$0D,$01,$01,$59,$02,$05,$12
        EQUB    $0A,$05,$10,$0A,$82,$5E,$07,$48
        EQUB    $5E,$21,$48,$FF,$17,$48,$00,$16
        EQUB    $01,$69,$15,$01,$8E,$2D,$08,$F3
        EQUB    $0D,$30,$78,$2A,$00,$05,$08,$F4
        EQUB    $0D,$30,$01,$76,$2D,$48,$4B,$1F
        EQUB    $01,$FC,$24,$82,$4B,$07,$02,$58
        EQUB    $0D,$FF,$13,$1B,$59,$0D,$5E,$24
        EQUB    $27,$21,$05,$05,$0F,$0A,$02,$48
        EQUB    $59,$1F,$01,$89,$05,$78,$2A,$01
        EQUB    $07,$05,$15,$0A,$00,$09,$03,$78
        EQUB    $19,$47,$0B,$78,$19,$03,$07,$05
        EQUB    $14,$0A,$00,$09,$03,$C2,$5E,$01
        EQUB    $78,$01,$00,$07,$05,$13,$0A,$00
        EQUB    $09,$03,$82,$5E,$19,$00,$12,$0E
        EQUB    $78,$0E,$5E,$06,$59,$0D,$5E,$48
        EQUB    $18,$20,$87,$05,$13,$0A,$02,$79
        EQUB    $0D,$07,$05,$05,$AB,$0A,$02,$58
        EQUB    $0E,$0A,$44,$1A,$00,$24,$27,$08
        EQUB    $DF,$08,$30,$7A,$19,$04,$24,$01
        EQUB    $88,$19,$78,$2A,$01,$09,$08,$E1
        EQUB    $08,$30,$78,$64,$00,$15,$08,$E0
        EQUB    $08,$30,$78,$19,$82,$0D,$08,$E2
        EQUB    $08,$30,$78,$19,$77,$05,$08,$DE
        EQUB    $08,$30,$04,$30,$02,$78,$58,$01
        EQUB    $26,$78,$19,$7A,$0B,$78,$72,$00
        EQUB    $07,$48,$00,$72,$05,$DB,$09,$79
        EQUB    $19,$54,$14,$C6,$20,$01,$30,$01
        EQUB    $54,$0D,$05,$19,$0D,$09,$1C,$17
        EQUB    $48,$00,$16,$00,$78,$13,$01,$15
        EQUB    $0F,$02,$01,$15,$0F,$48,$00,$2A
        EQUB    $30,$17,$1C,$4D,$48,$39,$1F,$01
        EQUB    $71,$0B,$78,$2A,$00,$3C,$79,$1F
        EQUB    $44,$0F,$01,$2C,$24,$78,$2A,$01
        EQUB    $31,$01,$36,$24,$78,$2A,$01,$2A
        EQUB    $79,$1F,$45,$08,$01,$22,$24,$78
        EQUB    $2A,$01,$1F,$01,$B0,$26,$A6,$04
        EQUB    $01,$31,$01,$54,$15,$C6,$24,$01
        EQUB    $30,$01,$1F,$0E,$09,$1F,$01,$01
        EQUB    $59,$02,$05,$17,$08,$48,$00,$2A
        EQUB    $02,$0A,$08,$1F,$7A,$1F,$50,$B8
        EQUB    $79,$17,$78,$0C,$C2,$6E,$01,$78
        EQUB    $01,$00,$05,$05,$CD,$09,$02,$79
        EQUB    $17,$7A,$07,$05,$D4,$09,$01,$E1
        EQUB    $15,$09,$17,$19,$01,$15,$0F,$79
        EQUB    $17,$45,$0C,$C2,$65,$01,$79,$01
        EQUB    $8B,$05,$05,$0A,$0A,$02,$79,$17
        EQUB    $3B,$2D,$C2,$33,$01,$79,$01,$FE
        EQUB    $26,$82,$33,$17,$09,$54,$6A,$48
        EQUB    $32,$55,$78,$58,$01,$0A,$05,$46
        EQUB    $0A,$01,$A7,$25,$00,$2A,$1D,$01
        EQUB    $07,$14,$09,$17,$19,$05,$47,$0A
        EQUB    $01,$19,$26,$00,$2A,$1D,$78,$5A
        EQUB    $01,$1A,$C2,$3B,$01,$31,$01,$19
        EQUB    $13,$79,$17,$DE,$0F,$48,$3B,$1F
        EQUB    $08,$50,$0A,$30,$01,$FC,$24,$48
        EQUB    $00,$2A,$02,$79,$17,$DE,$0E,$78
        EQUB    $58,$00,$0A,$05,$47,$0A,$E2,$54
        EQUB    $07,$00,$09,$03,$79,$17,$D8,$0F
        EQUB    $79,$14,$D9,$0B,$01,$D6,$2D,$58
        EQUB    $2A,$01,$91,$1C,$20,$73,$79,$17
        EQUB    $12,$39,$79,$14,$53,$35,$01,$76
        EQUB    $11,$7A,$04,$32,$08,$08,$82,$0A
        EQUB    $30,$00,$53,$1A,$08,$83,$0A,$30
        EQUB    $01,$53,$1A,$78,$79,$02,$09,$05
        EQUB    $84,$0A,$48,$01,$79,$20,$B1,$C2
        EQUB    $3F,$01,$79,$01,$FC,$0D,$05,$8C
        EQUB    $0A,$82,$3F,$54,$48,$0E,$01,$83
        EQUB    $3F,$01,$59,$17,$32,$1B,$1D,$78
        EQUB    $54,$89,$1A,$78,$14,$31,$1B,$A3
        EQUB    $54,$01,$79,$01,$00,$0F,$C2,$3E
        EQUB    $01,$79,$01,$61,$08,$05,$A0,$0A
        EQUB    $48,$3E,$1F,$02,$05,$9D,$0A,$20
        EQUB    $10,$79,$54,$89,$0C,$78,$14,$32
        EQUB    $08,$08,$9F,$0A,$30,$00,$53,$1A
        EQUB    $09,$14,$04,$09,$17,$05,$09,$1A
        EQUB    $06,$09,$05,$14,$09,$04,$15,$01
        EQUB    $C2,$02,$01,$93,$02,$79,$17,$00
        EQUB    $04,$05,$65,$08,$09,$04,$14,$09
        EQUB    $05,$17,$09,$06,$1A,$48,$01,$2A
        EQUB    $02,$01,$15,$0F,$C2,$4C,$01,$30
        EQUB    $01,$19,$14,$48,$01,$48,$09,$5B
        EQUB    $47,$48,$4C,$1F,$08,$D8,$0E,$30
        EQUB    $01,$4B,$0F,$09,$47,$5B,$79,$19
        EQUB    $42,$0F,$78,$61,$01,$0B,$06,$02
        EQUB    $01,$7B,$01,$50,$04,$05,$EC,$09
        EQUB    $01,$AE,$23,$00,$0C,$03,$78,$65
        EQUB    $00,$1B,$0B,$08,$74,$79,$74,$00
        EQUB    $14,$48,$00,$65,$48,$0A,$1F,$01
        EQUB    $71,$0B,$82,$0A,$07,$78,$2A,$00
        EQUB    $04,$05,$C9,$09,$78,$54,$3A,$1F
        EQUB    $48,$00,$53,$A6,$53,$01,$78,$01
        EQUB    $00,$0E,$0B,$08,$01,$E6,$53,$01
        EQUB    $79,$01,$00,$04,$01,$19,$1F,$0A
        EQUB    $08,$53,$7A,$53,$13,$E6,$78,$72
        EQUB    $00,$1B,$08,$D7,$09,$01,$0A,$72
        EQUB    $01,$04,$01,$0A,$08,$72,$39,$01
        EQUB    $DA,$09,$0A,$48,$5C,$4F,$01,$0C
        EQUB    $19,$48,$00,$72,$78,$4C,$01,$0D
        EQUB    $78,$4C,$10,$09,$78,$4C,$1F,$05
        EQUB    $79,$4C,$2E,$1D,$7A,$19,$98,$19
        EQUB    $7B,$19,$9E,$15,$08,$3C,$0A,$30
        EQUB    $79,$19,$9A,$0B,$08,$3D,$0A,$30
        EQUB    $48,$1E,$4F,$01,$0C,$19,$04,$30
        EQUB    $78,$19,$54,$05,$79,$19,$B6,$4B
        EQUB    $08,$8F,$0A,$30,$78,$49,$02,$37
        EQUB    $08,$91,$0A,$30,$78,$49,$04,$2F
        EQUB    $79,$49,$06,$37,$C2,$3F,$01,$31
        EQUB    $01,$54,$30,$05,$8D,$0A,$82,$3F
        EQUB    $07,$09,$19,$01,$48,$00,$02,$79
        EQUB    $19,$B6,$07,$48,$7D,$01,$48,$07
        EQUB    $02,$82,$58,$01,$83,$58,$02,$82
        EQUB    $0C,$01,$83,$0C,$02,$02,$C2,$3F
        EQUB    $01,$31,$01,$54,$04,$0A,$08,$30
        EQUB    $04,$30,$48,$20,$4F,$78,$19,$91
        EQUB    $40,$48,$2D,$4F,$78,$19,$A5,$39
        EQUB    $48,$2E,$4F,$78,$19,$C1,$32,$48
        EQUB    $2F,$4F,$78,$19,$BB,$2B,$48,$30
        EQUB    $4F,$78,$19,$2A,$24,$48,$31,$4F
        EQUB    $78,$19,$9A,$1D,$48,$32,$4F,$78
        EQUB    $19,$DA,$16,$48,$33,$4F,$78,$19
        EQUB    $DE,$0F,$48,$35,$4F,$78,$19,$93
        EQUB    $08,$79,$19,$89,$07,$48,$1A,$4F
        EQUB    $01,$0C,$19,$A3,$54,$01,$78,$01
        EQUB    $00,$37,$A2,$54,$01,$79,$01,$61
        EQUB    $30,$78,$5E,$00,$2C,$05,$99,$0A
        EQUB    $48,$32,$21,$79,$5E,$02,$19,$78
        EQUB    $19,$30,$0A,$48,$34,$21,$05,$9A
        EQUB    $0A,$48,$00,$5E,$82,$61,$21,$01
        EQUB    $15,$0F,$01,$03,$00,$20,$0A,$78
        EQUB    $19,$34,$F2,$48,$30,$21,$20,$E7
        EQUB    $78,$54,$89,$11,$79,$19,$31,$0D
        EQUB    $05,$9E,$0A,$48,$32,$17,$48,$00
        EQUB    $16,$01,$78,$13,$79,$19,$4D,$0D
        EQUB    $48,$24,$4F,$01,$0C,$19,$48,$2C
        EQUB    $4F,$01,$0C,$19,$78,$4E,$00,$07
        EQUB    $05,$A0,$08,$48,$00,$4E,$02,$48
        EQUB    $13,$01,$0A,$53,$01,$A6,$01,$1F
        EQUB    $78,$1F,$00,$7C,$79,$53,$04,$14
        EQUB    $E2,$1F,$19,$E3,$1F,$07,$82,$89
        EQUB    $07,$82,$5A,$07,$79,$1F,$88,$04
        EQUB    $48,$88,$54,$01,$71,$0B,$78,$2A
        EQUB    $00,$2C,$79,$53,$0D,$13,$79,$1F
        EQUB    $7E,$0F,$05,$64,$0A,$82,$60,$07
        EQUB    $82,$7E,$19,$83,$7E,$07,$20,$16
        EQUB    $05,$C9,$0D,$48,$DC,$01,$0A,$53
        EQUB    $01,$08,$2C,$01,$02,$0A,$02,$01
        EQUB    $04,$01,$05,$BC,$0D,$48,$13,$01
        EQUB    $0A,$53,$01,$E6,$01,$07,$E6,$53
        EQUB    $07,$79,$1F,$71,$0D,$48,$5F,$01
        EQUB    $82,$71,$01,$48,$01,$01,$83,$71
        EQUB    $01,$79,$53,$0C,$13,$05,$FB,$0C
        EQUB    $48,$00,$58,$48,$88,$54,$48,$00
        EQUB    $59,$01,$15,$0F,$01,$03,$00,$02
        EQUB    $02,$A2,$1F,$7B,$48,$01,$2A,$58
        EQUB    $0B,$2D,$46,$21,$58,$0B,$33,$46
        EQUB    $21,$79,$1F,$55,$3C,$78,$7A,$01
        EQUB    $38,$78,$0B,$4E,$05,$79,$0B,$3D
        EQUB    $30,$78,$58,$01,$28,$05,$C5,$09
        EQUB    $05,$9F,$08,$01,$12,$15,$78,$2A
        EQUB    $01,$06,$05,$C7,$09,$20,$16,$05
        EQUB    $C6,$09,$82,$25,$19,$82,$1B,$19
        EQUB    $48,$01,$7A,$82,$55,$54,$48,$04
        EQUB    $01,$83,$55,$01,$48,$01,$2A,$02
        EQUB    $79,$1F,$0F,$1D,$78,$61,$01,$19
        EQUB    $78,$54,$44,$0D,$58,$58,$01,$47
        EQUB    $06,$08,$ED,$09,$30,$00,$53,$1A
        EQUB    $05,$EB,$09,$48,$01,$61,$20,$DD
        EQUB    $7A,$1F,$DC,$11,$7B,$1F,$EE,$0D
        EQUB    $78,$0B,$33,$09,$78,$58,$01,$CD
        EQUB    $05,$E3,$0D,$02,$A3,$1F,$01,$78
        EQUB    $01,$00,$27,$7A,$7B,$39,$23,$7B
        EQUB    $7B,$50,$1F,$30,$54,$7B,$1B,$09
        EQUB    $7B,$01,$01,$59,$02,$08,$18,$08
        EQUB    $30,$79,$1F,$35,$05,$78,$7B,$3C
        EQUB    $05,$08,$17,$08,$30,$04,$30,$20
        EQUB    $9C,$79,$1F,$44,$27,$78,$0B,$3F
        EQUB    $23,$78,$0B,$29,$1F,$78,$0B,$33
        EQUB    $1B,$01,$2C,$24,$58,$2A,$01,$21
        EQUB    $22,$05,$35,$0A,$00,$EE,$1F,$04
        EQUB    $30,$48,$01,$2A,$02,$04,$30,$48
        EQUB    $00,$2A,$02,$79,$1F,$73,$05,$05
        EQUB    $06,$0A,$02,$79,$1F,$79,$1B,$08
        EQUB    $02,$0A,$30,$A3,$54,$01,$79,$01
        EQUB    $00,$DE,$C6,$20,$01,$08,$07,$0A
        EQUB    $30,$30,$01,$54,$D3,$05,$00,$0A
        EQUB    $02,$79,$1F,$1E,$22,$01,$8E,$2D
        EQUB    $48,$1E,$1F,$78,$2A,$01,$18,$C2
        EQUB    $4B,$01,$78,$01,$FD,$11,$01,$76
        EQUB    $2D,$48,$4B,$1F,$08,$F6,$0D,$30
        EQUB    $01,$FC,$24,$00,$EE,$1F,$79,$1F
        EQUB    $71,$19,$0A,$08,$7D,$7B,$7D,$03
        EQUB    $08,$05,$43,$0A,$48,$14,$71,$02
        EQUB    $05,$44,$0A,$48,$05,$01,$0A,$01
        EQUB    $70,$02,$79,$19,$53,$39,$79,$0B
        EQUB    $43,$35,$78,$1F,$FB,$31,$78,$1F
        EQUB    $FF,$2D,$78,$79,$02,$23,$7B,$1F
        EQUB    $12,$19,$05,$86,$0A,$48,$00,$26
        EQUB    $09,$1F,$01,$01,$59,$02,$05,$87
        EQUB    $0A,$E2,$1F,$07,$48,$02,$79,$00
        EQUB    $EE,$1F,$05,$85,$0A,$00,$EE,$1F
        EQUB    $05,$88,$0A,$00,$EE,$1F,$79,$1F
        EQUB    $61,$11,$78,$0B,$44,$0D,$78,$0B
        EQUB    $0F,$09,$78,$0B,$64,$05,$05,$96
        EQUB    $0A,$02,$79,$1F,$0B,$0F,$C2,$40
        EQUB    $01,$31,$01,$19,$08,$05,$AD,$0A
        EQUB    $82,$40,$07,$02,$79,$1F,$26,$54
        EQUB    $79,$7B,$60,$50,$A3,$1F,$01,$78
        EQUB    $01,$00,$49,$79,$0B,$2D,$07,$05
        EQUB    $5F,$0A,$00,$21,$22,$05,$60,$0A
        EQUB    $08,$63,$0A,$30,$C6,$20,$01,$78
        EQUB    $01,$7E,$18,$C6,$1C,$01,$31,$01
        EQUB    $54,$24,$05,$62,$0A,$08,$64,$0A
        EQUB    $30,$82,$60,$07,$82,$7E,$19,$83
        EQUB    $7E,$07,$04,$30,$59,$0B,$3D,$09
        EQUB    $03,$82,$26,$54,$48,$04,$01,$83
        EQUB    $26,$01,$00,$09,$03,$05,$61,$0A
        EQUB    $00,$7C,$0C,$79,$1F,$77,$10,$05
        EQUB    $D1,$09,$82,$77,$07,$48,$5F,$4F
        EQUB    $01,$0C,$19,$00,$EE,$1F,$09,$1F
        EQUB    $01,$59,$1F,$33,$BB,$21,$48,$06
        EQUB    $01,$7B,$01,$12,$0E,$79,$54,$88
        EQUB    $0A,$48,$36,$4F,$0A,$01,$4F,$01
        EQUB    $0C,$19,$79,$1F,$FB,$0B,$59,$19
        EQUB    $53,$A8,$23,$59,$0B,$43,$A8,$23
        EQUB    $79,$1F,$04,$07,$48,$1B,$4F,$01
        EQUB    $0C,$19,$79,$1F,$3C,$07,$48,$21
        EQUB    $4F,$01,$0C,$19,$79,$1F,$11,$07
        EQUB    $48,$28,$4F,$01,$0C,$19,$79,$1F
        EQUB    $67,$26,$A3,$54,$01,$08,$02,$0A
        EQUB    $30,$59,$01,$00,$71,$20,$C6,$20
        EQUB    $01,$08,$00,$0A,$30,$11,$01,$54
        EQUB    $71,$20,$08,$01,$0A,$30,$48,$29
        EQUB    $4F,$01,$0C,$19,$00,$71,$20,$48
        EQUB    $00,$2A,$02,$48,$01,$2A,$79,$0B
        EQUB    $31,$05,$05,$7E,$08,$02,$79,$0B
        EQUB    $2B,$05,$05,$7D,$08,$02,$48,$00
        EQUB    $2A,$02,$79,$1F,$55,$08,$78,$7A
        EQUB    $01,$04,$05,$C4,$09,$79,$1F,$0A
        EQUB    $1E,$78,$65,$00,$04,$05,$C8,$09
        EQUB    $08,$E2,$09,$30,$7B,$74,$07,$0D
        EQUB    $08,$E3,$09,$30,$7B,$74,$04,$05
        EQUB    $08,$E4,$09,$30,$04,$30,$C6,$20
        EQUB    $01,$31,$01,$1F,$12,$01,$59,$02
        EQUB    $08,$0E,$0D,$30,$30,$01,$54,$05
        EQUB    $08,$16,$0D,$30,$04,$30,$79,$1F
        EQUB    $44,$0B,$01,$2C,$24,$78,$2A,$00
        EQUB    $04,$05,$33,$0A,$79,$1F,$64,$23
        EQUB    $05,$3E,$0A,$08,$3F,$0A,$30,$09
        EQUB    $4B,$01,$7A,$4B,$0C,$0B,$08,$40
        EQUB    $0A,$30,$48,$0C,$02,$0B,$02,$01
        EQUB    $03,$01,$45,$12,$03,$4C,$04,$30
        EQUB    $45,$09,$79,$1F,$7E,$12,$08,$65
        EQUB    $0A,$30,$C2,$60,$01,$30,$01,$19
        EQUB    $05,$08,$66,$0A,$30,$04,$30,$79
        EQUB    $1F,$5F,$11,$C6,$20,$01,$79,$01
        EQUB    $71,$0A,$05,$42,$0A,$48,$26,$4F
        EQUB    $01,$0C,$19,$48,$27,$4F,$78,$1F
        EQUB    $6D,$25,$48,$19,$4F,$78,$1F,$02
        EQUB    $1E,$48,$1F,$4F,$78,$1F,$08,$17
        EQUB    $48,$18,$4F,$78,$1F,$74,$10,$48
        EQUB    $22,$4F,$78,$1F,$1D,$09,$48,$23
        EQUB    $4F,$78,$1F,$8A,$02,$02,$00,$0C
        EQUB    $19,$48,$00,$2A,$59,$1F,$63,$9A
        EQUB    $23,$39,$0F,$FF,$FF,$57,$48,$8E
        EQUB    $05,$48,$BE,$06,$08,$2C,$01,$01
        EQUB    $0A,$01,$06,$48,$00,$29,$48,$00
        EQUB    $25,$A6,$05,$01,$78,$01,$03,$1C
        EQUB    $0A,$08,$25,$79,$25,$02,$04,$05
        EQUB    $F7,$09,$09,$06,$2B,$48,$00,$2C
        EQUB    $79,$01,$01,$05,$08,$FA,$09,$2C
        EQUB    $01,$B8,$01,$0A,$08,$05,$0A,$08
        EQUB    $06,$7A,$05,$98,$D5,$48,$98,$01
        EQUB    $7B,$25,$01,$04,$05,$F6,$09,$48
        EQUB    $00,$2B,$48,$00,$2C,$01,$B8,$01
        EQUB    $48,$01,$2A,$02,$48,$8E,$01,$0A
        EQUB    $0F,$01,$A6,$01,$02,$78,$02,$03
        EQUB    $2E,$78,$02,$01,$08,$05,$F9,$09
        EQUB    $48,$01,$2A,$02,$48,$63,$22,$48
        EQUB    $1F,$23,$01,$35,$01,$7B,$25,$00
        EQUB    $04,$05,$FB,$09,$48,$01,$2A,$02
        EQUB    $79,$1F,$23,$07,$48,$34,$4F,$01
        EQUB    $0C,$19,$48,$00,$2A,$02,$05,$38
        EQUB    $08,$00,$09,$03,$48,$39,$1F,$7A
        EQUB    $54,$88,$4B,$A2,$1F,$01,$79,$01
        EQUB    $FD,$44,$06,$02,$01,$7B,$01,$02
        EQUB    $58,$05,$CA,$0D,$09,$1F,$01,$01
        EQUB    $59,$02,$05,$CB,$0D,$E2,$1F,$19
        EQUB    $E3,$1F,$07,$01,$B0,$26,$E6,$04
        EQUB    $54,$0A,$08,$04,$09,$04,$03,$48
        EQUB    $26,$01,$0B,$01,$04,$48,$03,$02
        EQUB    $A5,$04,$01,$E6,$03,$01,$0A,$08
        EQUB    $03,$0A,$08,$04,$0B,$08,$02,$7B
        EQUB    $02,$00,$EE,$20,$1C,$09,$19,$21
        EQUB    $48,$00,$20,$01,$40,$0B,$78,$2A
        EQUB    $00,$0F,$09,$1F,$46,$21,$2F,$09
        EQUB    $46,$1F,$01,$C1,$24,$09,$46,$1F
        EQUB    $0A,$08,$1F,$7A,$1F,$51,$91,$02
        EQUB    $48,$57,$1F,$01,$71,$0B,$48,$45
        EQUB    $1F,$02,$48,$09,$1F,$01,$71,$0B
        EQUB    $48,$44,$1F,$02,$48,$18,$21,$48
        EQUB    $1F,$20,$00,$40,$0B,$C6,$25,$01
        EQUB    $30,$01,$1F,$34,$78,$1F,$39,$30
        EQUB    $79,$1F,$44,$2D,$21,$DD,$78,$2A
        EQUB    $01,$10,$21,$E1,$78,$2A,$00,$20
        EQUB    $05,$32,$0A,$82,$44,$19,$83,$44
        EQUB    $07,$48,$3D,$1F,$09,$19,$21,$48
        EQUB    $00,$20,$01,$40,$0B,$78,$2A,$00
        EQUB    $07,$82,$3D,$07,$05,$34,$0A,$02
        EQUB    $79,$1F,$45,$07,$21,$A3,$78,$2A
        EQUB    $01,$F6,$79,$1F,$41,$1C,$C6,$23
        EQUB    $01,$09,$54,$6A,$58,$01,$41,$1A
        EQUB    $25,$05,$22,$0D,$09,$54,$6A,$01
        EQUB    $96,$27,$78,$2A,$01,$DA,$00,$7C
        EQUB    $0C,$01,$B0,$26,$A6,$04,$6A,$78
        EQUB    $6A,$00,$09,$A2,$6A,$01,$59,$01
        EQUB    $00,$1A,$25,$01,$81,$26,$A6,$04
        EQUB    $6A,$59,$6A,$00,$1A,$25,$02,$06
        EQUB    $02,$01,$7B,$01,$A0,$F9,$08,$10
        EQUB    $0E,$30,$48,$00,$02,$78,$1F,$3E
        EQUB    $24,$48,$03,$02,$78,$1F,$44,$1D
        EQUB    $48,$06,$02,$78,$1F,$4B,$16,$08
        EQUB    $14,$0F,$30,$78,$1F,$46,$14,$09
        EQUB    $1F,$02,$48,$3B,$01,$0B,$01,$02
        EQUB    $08,$19,$0E,$30,$0A,$02,$30,$01
        EQUB    $DA,$02,$78,$1F,$3A,$1A,$78,$1F
        EQUB    $39,$16,$78,$1F,$3C,$12,$01,$71
        EQUB    $0B,$78,$2A,$00,$0B,$09,$1F,$01
        EQUB    $01,$59,$02,$04,$30,$45,$09,$02
        EQUB    $09,$1F,$69,$C6,$24,$01,$30,$01
        EQUB    $69,$F6,$09,$6A,$1F,$01,$71,$0B
        EQUB    $58,$2A,$00,$21,$24,$79,$1F,$44
        EQUB    $0F,$01,$2C,$24,$78,$2A,$01,$E0
        EQUB    $01,$36,$24,$78,$2A,$01,$D9,$79
        EQUB    $1F,$45,$08,$01,$22,$24,$78,$2A
        EQUB    $01,$CE,$01,$3F,$27,$58,$6A,$46
        EQUB    $B3,$2D,$10,$69,$6A,$DA,$25,$09
        EQUB    $69,$1F,$01,$B0,$26,$0A,$09,$04
        EQUB    $A6,$04,$55,$32,$6C,$55,$04,$09
        EQUB    $6C,$55,$C6,$19,$01,$31,$01,$69
        EQUB    $04,$0A,$55,$55,$01,$D5,$26,$01
        EQUB    $83,$27,$01,$8D,$26,$09,$6A,$1F
        EQUB    $01,$B0,$26,$48,$01,$01,$0A,$01
        EQUB    $04,$A5,$04,$01,$01,$AA,$15,$A6
        EQUB    $04,$02,$33,$2F,$02,$10,$08,$BD
        EQUB    $0D,$30,$30,$6A,$54,$05,$08,$BE
        EQUB    $0D,$30,$04,$30,$02,$01,$ED,$26
        EQUB    $78,$01,$00,$59,$08,$B7,$0D,$30
        EQUB    $79,$6A,$88,$05,$08,$B6,$0D,$30
        EQUB    $04,$30,$01,$86,$02,$79,$01,$24
        EQUB    $19,$0B,$55,$66,$78,$66,$00,$25
        EQUB    $3B,$66,$50,$C3,$20,$09,$66,$02
        EQUB    $05,$C5,$0D,$03,$02,$05,$C6,$0D
        EQUB    $02,$79,$01,$1E,$17,$0B,$55,$67
        EQUB    $09,$67,$02,$78,$67,$00,$06,$3A
        EQUB    $67,$50,$C3,$E5,$05,$BA,$0D,$E2
        EQUB    $01,$07,$02,$0B,$55,$68,$09,$68
        EQUB    $02,$78,$68,$00,$F0,$3A,$68,$50
        EQUB    $C3,$CF,$20,$E9,$05,$B0,$0D,$03
        EQUB    $55,$08,$B3,$0D,$01,$78,$55,$01
        EQUB    $05,$08,$B1,$0D,$01,$04,$01,$09
        EQUB    $6A,$1F,$01,$B0,$26,$48,$03,$01
        EQUB    $0A,$01,$04,$A6,$04,$01,$0B,$55
        EQUB    $01,$E6,$04,$01,$78,$01,$00,$06
        EQUB    $3A,$01,$50,$C3,$22,$10,$6A,$54
        EQUB    $7C,$0C,$08,$B2,$0D,$30,$01,$78
        EQUB    $1A,$09,$6A,$21,$09,$19,$17,$48
        EQUB    $00,$16,$01,$69,$15,$48,$FD,$01
        EQUB    $E2,$6A,$01,$00,$09,$03,$09,$6A
        EQUB    $01,$01,$59,$02,$09,$6A,$01,$08
        EQUB    $C0,$0D,$30,$01,$CA,$2D,$04,$30
        EQUB    $09,$6A,$1F,$21,$07,$03,$01,$05
        EQUB    $C2,$0D,$02,$21,$3A,$48,$03,$01
        EQUB    $0A,$01,$04,$A6,$04,$01,$02,$21
        EQUB    $F3,$48,$26,$01,$0B,$01,$04,$A5
        EQUB    $04,$01,$02,$09,$69,$01,$01,$59
        EQUB    $02,$08,$AC,$0D,$30,$01,$CA,$2D
        EQUB    $04,$30,$09,$6A,$01,$01,$59,$02
        EQUB    $78,$6B,$FF,$0A,$05,$AE,$0D,$09
        EQUB    $6B,$01,$01,$86,$02,$02,$48,$26
        EQUB    $04,$78,$1F,$88,$1A,$78,$1F,$89
        EQUB    $17,$09,$1F,$04,$48,$38,$02,$0B
        EQUB    $02,$04,$0A,$04,$04,$0A,$04,$04
        EQUB    $48,$26,$01,$0A,$01,$04,$02,$48
        EQUB    $8A,$04,$02,$01,$B4,$15,$09,$2F
        EQUB    $04,$01,$B4,$15,$0A,$2F,$04,$33
        EQUB    $04,$55,$F1,$78,$04,$00,$ED,$09
        EQUB    $04,$55,$02,$48,$1E,$01,$A2,$01
        EQUB    $02,$31,$02,$6A,$08,$A3,$01,$02
        EQUB    $79,$02,$00,$26,$48,$24,$01,$A2
        EQUB    $01,$02,$31,$02,$6A,$08,$A3,$01
        EQUB    $02,$79,$02,$00,$15,$48,$04,$01
        EQUB    $A2,$01,$02,$31,$02,$6A,$08,$A3
        EQUB    $01,$02,$79,$02,$00,$04,$48,$00
        EQUB    $01,$02,$08,$E4,$07,$30,$00,$D5
        EQUB    $02,$09,$54,$69,$78,$0E,$FF,$0E
        EQUB    $09,$0E,$6B,$7A,$0E,$32,$05,$7A
        EQUB    $0E,$37,$E7,$21,$E6,$48,$36,$1F
        EQUB    $09,$69,$21,$48,$1F,$20,$01,$40
        EQUB    $0B,$09,$1F,$6B,$78,$2A,$01,$0B
        EQUB    $0B,$08,$1F,$7B,$1F,$31,$F0,$48
        EQUB    $FF,$6B,$48,$06,$6C,$78,$6B,$32
        EQUB    $20,$48,$08,$6C,$78,$6B,$33,$19
        EQUB    $48,$0A,$6C,$78,$6B,$34,$12,$48
        EQUB    $0F,$6C,$78,$6B,$35,$0B,$48,$14
        EQUB    $6C,$78,$6B,$36,$04,$48,$00,$6C
        EQUB    $02,$09,$6A,$1F,$01,$B0,$26,$E6
        EQUB    $04,$69,$09,$69,$1F,$01,$B0,$26
        EQUB    $E6,$04,$6A,$02,$48,$00,$2A,$C2
        EQUB    $58,$01,$31,$01,$6A,$11,$C3,$58
        EQUB    $01,$78,$01,$00,$0A,$82,$58,$07
        EQUB    $05,$6A,$0A,$48,$01,$2A,$02,$20
        EQUB    $0C,$C7,$34,$01,$79,$01,$00,$05
        EQUB    $05,$C7,$0D,$02,$78,$0C,$00,$09
        EQUB    $79,$0E,$FF,$05,$05,$59,$08,$02
        EQUB    $7A,$0D,$DC,$20,$7B,$0D,$EF,$1C
        EQUB    $09,$0D,$53,$48,$DC,$01,$0B,$01
        EQUB    $53,$09,$0E,$6A,$20,$12,$48,$17
        EQUB    $01,$0A,$53,$01,$A7,$01,$02,$79
        EQUB    $02,$00,$05,$05,$BF,$0D,$02,$09
        EQUB    $53,$1F,$79,$1F,$06,$04,$48,$33
        EQUB    $1F,$01,$71,$0B,$78,$2A,$01,$0E
        EQUB    $05,$DE,$0D,$09,$1F,$01,$01,$16
        EQUB    $0C,$05,$DF,$0D,$02,$20,$22,$09
        EQUB    $53,$01,$01,$1A,$2D,$01,$2E,$2D
        EQUB    $48,$6F,$06,$0B,$01,$06,$01,$76
        EQUB    $11,$32,$04,$06,$0C,$05,$E0,$0D
        EQUB    $03,$06,$05,$E1,$0D,$45,$09,$02
        EQUB    $01,$19,$1F,$48,$00,$1A,$79,$0E
        EQUB    $FF,$1F,$79,$53,$0C,$1B,$01,$0A
        EQUB    $0A,$48,$02,$34,$01,$2E,$09,$79
        EQUB    $12,$00,$07,$01,$72,$0A,$00,$F4
        EQUB    $2C,$7B,$12,$0F,$F7,$09,$12,$1A
        EQUB    $01,$96,$27,$78,$2A,$01,$D1,$48
        EQUB    $48,$4F,$0A,$53,$4F,$01,$0C,$19
        EQUB    $48,$01,$01,$01,$23,$19,$48,$0A
        EQUB    $7C,$09,$53,$01,$01,$2E,$2D,$0A
        EQUB    $01,$01,$08,$08,$0C,$30,$0A,$01
        EQUB    $30,$48,$00,$04,$79,$53,$01,$16
        EQUB    $10,$6A,$54,$D6,$2C,$5A,$6A,$39
        EQUB    $F4,$2C,$5B,$6A,$50,$F4,$2C,$48
        EQUB    $01,$04,$00,$A4,$2B,$48,$00,$7C
        EQUB    $79,$53,$02,$2A,$48,$02,$1F,$09
        EQUB    $54,$21,$48,$1F,$20,$01,$40,$0B
        EQUB    $48,$03,$04,$78,$2A,$00,$11,$09
        EQUB    $6A,$1F,$01,$3E,$2D,$48,$02,$04
        EQUB    $78,$2A,$00,$04,$48,$01,$04,$48
        EQUB    $02,$6A,$00,$D6,$2C,$79,$53,$03
        EQUB    $3C,$09,$19,$14,$48,$01,$1A,$48
        EQUB    $00,$1B,$01,$98,$02,$78,$17,$00
        EQUB    $1F,$01,$A1,$12,$78,$17,$00,$08
        EQUB    $01,$98,$02,$78,$1D,$01,$11,$05
        EQUB    $44,$0C,$48,$64,$01,$0A,$1A,$01
        EQUB    $04,$01,$45,$09,$0A,$08,$1B,$0A
        EQUB    $08,$1A,$7A,$1A,$0E,$D5,$58,$1B
        EQUB    $00,$F4,$2C,$02,$79,$53,$04,$56
        EQUB    $48,$0A,$7C,$48,$04,$1F,$09,$6A
        EQUB    $21,$48,$1F,$20,$01,$40,$0B,$58
        EQUB    $2A,$00,$F4,$2C,$48,$00,$04,$30
        EQUB    $6A,$54,$09,$59,$6A,$3C,$F4,$2C
        EQUB    $48,$01,$04,$09,$19,$17,$48,$00
        EQUB    $16,$09,$6A,$21,$01,$69,$15,$82
        EQUB    $04,$6A,$48,$05,$01,$83,$04,$01
        EQUB    $E2,$6A,$07,$48,$89,$01,$79,$6A
        EQUB    $3C,$07,$48,$02,$04,$48,$5A,$01
        EQUB    $E2,$01,$19,$79,$6A,$88,$04,$48
        EQUB    $89,$54,$00,$D6,$2C,$79,$53,$05
        EQUB    $4A,$30,$6A,$54,$0F,$5A,$6A,$39
        EQUB    $F4,$2C,$5B,$6A,$50,$F4,$2C,$7B
        EQUB    $6A,$47,$29,$09,$6A,$1F,$01,$81
        EQUB    $26,$09,$01,$12,$01,$75,$26,$E6
        EQUB    $04,$12,$09,$6A,$01,$01,$A3,$0B
        EQUB    $48,$00,$04,$58,$2A,$04,$D6,$2C
        EQUB    $10,$6A,$54,$D6,$2C,$48,$01,$04
        EQUB    $00,$D6,$2C,$48,$02,$04,$01,$D6
        EQUB    $2C,$48,$14,$55,$09,$54,$69,$00
        EQUB    $19,$26,$79,$53,$06,$1F,$48,$0A
        EQUB    $7C,$10,$6A,$54,$D6,$2C,$48,$01
        EQUB    $04,$5A,$6A,$39,$F4,$2C,$5B,$6A
        EQUB    $50,$F4,$2C,$01,$D6,$2C,$09,$54
        EQUB    $69,$00,$83,$27,$59,$53,$07,$A7
        EQUB    $2A,$48,$00,$7C,$10,$6A,$54,$D6
        EQUB    $2C,$48,$02,$04,$58,$6A,$16,$DC
        EQUB    $2C,$58,$6A,$25,$DC,$2C,$58,$6A
        EQUB    $1B,$DC,$2C,$48,$04,$04,$58,$6A
        EQUB    $39,$CD,$2C,$48,$0A,$7C,$48,$05
        EQUB    $04,$58,$6A,$3A,$D6,$2C,$48,$07
        EQUB    $04,$58,$6A,$3C,$D6,$2C,$48,$00
        EQUB    $7C,$7A,$6A,$39,$11,$48,$08,$04
        EQUB    $5A,$6A,$48,$DC,$2C,$48,$03,$04
        EQUB    $5A,$6A,$51,$DC,$2C,$48,$0D,$04
        EQUB    $78,$6A,$81,$54,$09,$6A,$04,$48
        EQUB    $74,$01,$0B,$01,$04,$48,$47,$01
        EQUB    $78,$6A,$82,$50,$58,$6A,$83,$DC
        EQUB    $2C,$48,$48,$01,$78,$6A,$84,$55
        EQUB    $79,$6A,$86,$05,$05,$A6,$0C,$02
        EQUB    $58,$6A,$85,$DC,$2C,$79,$6A,$7B
        EQUB    $13,$48,$1D,$4F,$01,$0C,$19,$48
        EQUB    $25,$4F,$01,$0C,$19,$48,$0B,$04
        EQUB    $00,$DC,$2C,$48,$01,$04,$59,$6A
        EQUB    $7C,$DC,$2C,$48,$0C,$04,$01,$DC
        EQUB    $2C,$48,$1C,$4F,$00,$0C,$19,$01
        EQUB    $DC,$2C,$48,$1E,$17,$48,$00,$16
        EQUB    $00,$96,$13,$01,$9E,$2A,$C2,$10
        EQUB    $01,$79,$01,$00,$07,$05,$A7,$0C
        EQUB    $82,$10,$19,$02,$E2,$01,$19,$E3
        EQUB    $01,$07,$00,$DC,$2C,$79,$53,$08
        EQUB    $6A,$10,$6A,$54,$D6,$2C,$78,$6A
        EQUB    $63,$32,$09,$6A,$01,$79,$01,$33
        EQUB    $04,$48,$06,$01,$7B,$01,$12,$11
        EQUB    $05,$AA,$0C,$08,$08,$02,$02,$0A
        EQUB    $01,$02,$04,$02,$05,$AB,$0C,$02
        EQUB    $48,$01,$04,$5A,$6A,$39,$DC,$2C
        EQUB    $5B,$6A,$47,$DC,$2C,$48,$04,$04
        EQUB    $00,$DC,$2C,$21,$0F,$48,$06,$04
        EQUB    $58,$2A,$01,$DC,$2C,$48,$01,$04
        EQUB    $00,$DC,$2C,$18,$0F,$FF,$FF,$4F
        EQUB    $18,$48,$8E,$01,$0A,$0F,$01,$A6
        EQUB    $01,$02,$48,$01,$2A,$78,$02,$04
        EQUB    $09,$58,$02,$03,$A8,$23,$48,$00
        EQUB    $2A,$02,$79,$53,$09,$0C,$48,$0A
        EQUB    $7C,$10,$6A,$54,$D6,$2C,$00,$F4
        EQUB    $2C,$79,$53,$0A,$23,$5B,$6A,$8D
        EQUB    $16,$2D,$05,$D0,$0C,$09,$6A,$04
        EQUB    $01,$20,$0F,$78,$19,$00,$0B,$7B
        EQUB    $19,$FA,$07,$01,$1F,$00,$00,$15
        EQUB    $0F,$05,$D1,$0C,$00,$15,$0F,$79
        EQUB    $53,$0B,$0D,$48,$5A,$17,$48,$00
        EQUB    $16,$05,$E4,$0C,$00,$78,$13,$79
        EQUB    $53,$0C,$2E,$58,$1A,$00,$F4,$2C
        EQUB    $59,$59,$00,$F4,$2C,$09,$19,$14
        EQUB    $01,$93,$02,$48,$00,$04,$58,$17
        EQUB    $00,$DC,$2C,$48,$01,$04,$48,$02
        EQUB    $7C,$09,$54,$6A,$01,$DC,$2C,$09
        EQUB    $17,$59,$01,$03,$00,$00,$09,$03
        EQUB    $48,$0A,$7C,$79,$53,$0D,$4F,$30
        EQUB    $6A,$54,$42,$7A,$6A,$39,$14,$7B
        EQUB    $6A,$50,$10,$7A,$6A,$3D,$25,$48
        EQUB    $09,$04,$21,$31,$09,$54,$69,$00
        EQUB    $83,$27,$09,$6A,$1F,$01,$F3,$0F
        EQUB    $48,$05,$04,$78,$2A,$01,$1E,$78
        EQUB    $6A,$71,$1A,$48,$08,$04,$58,$6A
        EQUB    $7E,$D6,$2C,$09,$6A,$01,$01,$59
        EQUB    $02,$48,$08,$04,$0A,$04,$30,$04
        EQUB    $30,$45,$09,$02,$E2,$6A,$19,$E3
        EQUB    $6A,$07,$00,$D6,$2C,$79,$53,$0E
        EQUB    $2A,$48,$00,$7C,$30,$6A,$54,$0B
        EQUB    $5A,$6A,$39,$F4,$2C,$5B,$6A,$50
        EQUB    $F4,$2C,$09,$6A,$01,$01,$CA,$2D
        EQUB    $01,$B4,$15,$0A,$08,$2F,$09,$2F
        EQUB    $55,$01,$D6,$2C,$48,$00,$04,$00
        EQUB    $19,$26,$79,$53,$0F,$22,$79,$19
        EQUB    $DE,$0A,$48,$01,$04,$01,$DC,$2C
        EQUB    $00,$5A,$0C,$48,$00,$04,$01,$DC
        EQUB    $2C,$48,$01,$53,$01,$19,$1F,$0A
        EQUB    $08,$53,$7A,$53,$13,$F7,$02,$79
        EQUB    $53,$10,$17,$10,$6A,$54,$D6,$2C
        EQUB    $48,$01,$04,$59,$6A,$41,$F4,$2C
        EQUB    $48,$41,$01,$82,$36,$01,$00,$D6
        EQUB    $2C,$79,$53,$11,$1F,$48,$0A,$7C
        EQUB    $10,$6A,$54,$D6,$2C,$48,$02,$04
        EQUB    $78,$6A,$46,$79,$5A,$6A,$39,$F4
        EQUB    $2C,$48,$01,$04,$7A,$6A,$51,$6D
        EQUB    $00,$F4,$2C,$59,$53,$12,$F4,$2C
        EQUB    $48,$00,$7C,$30,$6A,$54,$5E,$48
        EQUB    $01,$04,$78,$6A,$3D,$57,$78,$6A
        EQUB    $40,$53,$78,$6A,$42,$4F,$78,$6A
        EQUB    $43,$4B,$78,$6A,$46,$47,$48,$02
        EQUB    $04,$78,$6A,$3E,$40,$48,$03,$04
        EQUB    $78,$6A,$41,$39,$48,$0A,$7C,$48
        EQUB    $04,$04,$78,$6A,$3F,$2F,$78,$6A
        EQUB    $44,$2B,$78,$6A,$45,$27,$78,$6A
        EQUB    $47,$23,$78,$6A,$3A,$05,$79,$6A
        EQUB    $3C,$39,$C6,$1A,$01,$30,$01,$6A
        EQUB    $14,$09,$6A,$01,$01,$59,$02,$05
        EQUB    $76,$0D,$02,$82,$39,$07,$82,$07
        EQUB    $19,$83,$07,$07,$09,$6A,$01,$01
        EQUB    $59,$02,$0A,$04,$30,$04,$30,$45
        EQUB    $09,$78,$7C,$00,$E6,$E6,$53,$7C
        EQUB    $48,$13,$01,$0A,$53,$01,$E6,$01
        EQUB    $6A,$02,$78,$6A,$FF,$1F,$09,$6A
        EQUB    $01,$01,$59,$02,$09,$6A,$01,$01
        EQUB    $A3,$0B,$08,$C2,$0B,$30,$78,$57
        EQUB    $01,$05,$08,$B8,$0B,$30,$01,$D5
        EQUB    $02,$45,$09,$02,$05,$E2,$0D,$02
        EQUB    $48,$00,$02,$0B,$09,$01,$3B,$01
        EQUB    $50,$C3,$06,$0A,$08,$02,$20,$F4
        EQUB    $09,$02,$01,$02,$0A,$01,$01,$09
        EQUB    $01,$02,$0A,$02,$02,$0A,$02,$02
        EQUB    $0A,$02,$01,$02,$58,$1F,$63,$F5
        EQUB    $2A,$48,$01,$2A,$30,$1F,$54,$2C
        EQUB    $7A,$1F,$13,$28,$78,$1F,$26,$24
        EQUB    $78,$1F,$35,$20,$7A,$1F,$55,$05
        EQUB    $7A,$1F,$59,$18,$78,$1F,$71,$14
        EQUB    $78,$1F,$41,$10,$78,$1F,$40,$0C
        EQUB    $78,$1F,$46,$08,$78,$1F,$44,$04
        EQUB    $48,$00,$2A,$02,$C2,$4B,$01,$30
        EQUB    $01,$19,$11,$78,$01,$FD,$0D,$48
        EQUB    $4B,$26,$05,$F7,$0D,$82,$4B,$19
        EQUB    $83,$4B,$07,$02,$48,$00,$2A,$48
        EQUB    $16,$1F,$C2,$16,$01,$79,$01,$FF
        EQUB    $18,$48,$1B,$1F,$C2,$1B,$01,$79
        EQUB    $01,$FF,$0E,$48,$25,$1F,$C2,$25
        EQUB    $01,$79,$01,$FF,$04,$48,$01,$2A
        EQUB    $02,$09,$69,$01,$01,$59,$02,$09
        EQUB    $69,$01,$08,$C3,$0D,$30,$21,$09
        EQUB    $04,$30,$48,$02,$55,$00,$19,$26
        EQUB    $78,$01,$88,$08,$78,$01,$46,$04
        EQUB    $0A,$08,$30,$02,$48,$00,$2A,$C2
        EQUB    $46,$01,$31,$01,$19,$F6,$C6,$24
        EQUB    $01,$78,$01,$46,$EF,$08,$5B,$0A
        EQUB    $30,$C6,$20,$01,$30,$01,$54,$08
        EQUB    $48,$01,$2A,$08,$5A,$0A,$30,$00
        EQUB    $71,$1A,$05,$04,$09,$02,$BC,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$EF,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$EF,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00

.L7800
        CMP     #$E0
        BCS     L7818

        CMP     #$C0
        BCS     L782B

        CMP     #$A0
        BCS     L7836

        SEC
        SBC     #$80
        JSR     L0CE8

        JSR     L0E91

        JMP     L0E20

.L7818
        SBC     #$E0
        JSR     L0CE8

        JSR     L0E51

        JSR     L0E5E

        JSR     L0B62

        LDY     #$00
        STA     (L0032),Y
        RTS

.L782B
        SBC     #$C0
        JSR     L0CE8

        JSR     L0E91

        JMP     L0E3E

.L7836
        SBC     #$A0
        JSR     L0CE8

        JSR     L0E51

        JSR     L0E5E

        JSR     L0B62

        LDY     #$00
        LDA     (L0032),Y
        STA     L0400,X
        LDA     #$00
        STA     L0401,X
        RTS

        JSR     L0B62

        STA     L04FE
        LDA     L0401,X
        STA     L04FF
        RTS

        LDA     L0032
        CLC
        ADC     L04FE
        STA     L0032
        LDA     L0033
        ADC     L04FF
        STA     L0033
        RTS

        STY     L0029
        LDY     #$00
        LDA     (L0027),Y
        LDY     L0029
        INC     L0027
        BNE     L787C

        INC     L0028
.L787C
        CMP     #$00
        RTS

        LDA     L09CF
        BNE     L7891

        JSR     L0E6E

        STA     L04FE
        JSR     L0E6E

        STA     L04FF
        RTS

.L7891
        JSR     L0E6E

        STA     L04FE
        LDA     #$00
        STA     L04FF
        RTS

        JSR     L0E7F

        JSR     L0B62

        LDA     L04FE
        STA     L0400,X
        LDA     L04FF
        STA     L0401,X
        RTS

        LDA     #$FE
        STA     L0030
        LDA     #$04
        STA     L0031
        RTS

        JSR     L0B62

        TXA
        TAY
        JSR     L0B62

        LDA     L0400,Y
        STA     L0400,X
        LDA     L0401,Y
        STA     L0401,X
        RTS

        INC     L0014
        BNE     L78D4

        INC     L0015
.L78D4
        RTS

        LDA     L0014
        BNE     L78DB

        DEC     L0015
.L78DB
        DEC     L0014
        RTS

        JSR     L0B62

        STA     L002E
        JSR     L0B62

        STA     L002F
        JSR     L0EFA

        AND     #$70
        LSR     A
        LSR     A
        LSR     A
        LSR     A
        JSR     L10EC

        LDA     L09D1
        JMP     L10EC

        JSR     L0F7A

        LDY     #$00
        LDX     L002E
        DEX
        BEQ     L7913

.L7904
        LDA     (L0014),Y
        JSR     L0ECE

        JSR     L0ECE

        CMP     #$00
        BPL     L7904

        DEX
        BNE     L7904

.L7913
        LDA     (L0014),Y
        AND     #$0F
        CMP     L002F
        BNE     L7928

        LDA     (L0014),Y
        PHA
        JSR     L0ECE

        LDA     (L0014),Y
        STA     L09D1
        PLA
        RTS

.L7928
        LDA     (L0014),Y
        BMI     L7935

        JSR     L0ECE

        JSR     L0ECE

        JMP     L0F13

.L7935
        LDX     L002F
        LDA     L08C4,X
        STA     L002F
        JSR     L0F7A

        LDA     #$01
        STA     L09D1
.L7944
        LDA     (L0014),Y
        AND     #$10
        BEQ     L7963

        LDA     (L0014),Y
        AND     #$0F
        CMP     L002F
        BNE     L7963

        JSR     L0ECE

        LDA     (L0014),Y
        PHA
        JSR     L0ED5

        PLA
        CMP     L002E
        BNE     L7963

        LDA     (L0014),Y
        RTS

.L7963
        LDA     (L0014),Y
        BPL     L796A

        INC     L09D1
.L796A
        LDA     (L0014),Y
        JSR     L0ECE

        JSR     L0ECE

        CMP     #$00
        BNE     L7944

        STA     L09D1
        RTS

        LDA     L08D4
        STA     L0014
        LDA     L08D5
        STA     L0015
        RTS

        INC     L09CD
        BNE     L798D

        INC     L09CE
.L798D
        RTS

        STY     L002E
        STX     L002F
        LDA     #$00
        ORA     L002E
        ORA     L002F
        BEQ     L79FB

        LDA     #$00
        STA     L09D3
        LDA     #$01
        STA     L0025
        LDA     #$10
        STA     L0026
        LDY     #$00
        STY     L09D7
.L79AC
        LDY     L09D7
        LDA     (L0025),Y
        STA     L09D1
        INY
        LDA     (L0025),Y
        STA     L09D2
        INY
        STY     L09D7
        LDA     #$00
        ORA     L09D1
        ORA     L09D2
        BEQ     L7A00

        LDA     #$30
        STA     L09D5
        LDA     L002E
        SEC
        SBC     L09D1
        TAX
        LDA     L002F
        SBC     L09D2
        TAY
        BCC     L79EB

        INC     L09D5
        LDA     #$01
        STA     L09D3
        STX     L002E
        STY     L002F
        JMP     L0FCD

.L79EB
        LDA     #$00
        CMP     L09D3
        BEQ     L79AC

        LDA     L09D5
        JSR     L1500

        JMP     L0FAC

.L79FB
        LDA     #$30
        JSR     L1500

.L7A00
        RTS

.L7A01
        EQUB    $10

.L7A02
        EQUB    $27,$E8,$03,$64,$00,$0A,$00,$01
        EQUB    $00,$00,$00,$DC,$0B,$15,$0C,$36
        EQUB    $0C,$8E,$0C,$99,$0C,$A8,$0C,$4C
        EQUB    $10,$0C,$16,$9C,$0E,$B8,$0E,$AE
        EQUB    $0C,$CA,$0C,$54,$0B,$54,$0B,$E6
        EQUB    $0C,$DD,$0E,$6A,$0B,$7A,$0B,$82
        EQUB    $0B,$8C,$0B,$A5,$10,$AE,$10,$B4
        EQUB    $10,$CA,$19,$94,$0B,$9C,$0B,$A4
        EQUB    $0B,$AE,$0B,$98,$19,$54,$0B,$54
        EQUB    $0B,$54,$0B

.L7A4D
        JSR     L0E6E

        CMP     #$02
        BNE     L7A57

        JMP     L0C56

.L7A57
        CMP     #$03
        BNE     L7A5E

        JMP     L10D0

.L7A5E
        CMP     #$04
        BNE     L7A65

        JMP     L10C3

.L7A65
        CMP     #$05
        BNE     L7A6C

        JMP     L0C42

.L7A6C
        CMP     #$06
        BNE     L7A73

        JMP     L0C4C

.L7A73
        LDX     L08E8
        STX     L0029
        LDA     L08E9
        STA     L002A
        LDY     #$00
        LDA     (L0029),Y
        LDY     L08E9
        INX
        BNE     L7A88

        INY
.L7A88
        CMP     #$09
        BEQ     L7A8F

        JMP     L1B00

.L7A8F
        JSR     L0B21

        LDX     #$00
.L7A94
        DEY
        BNE     L7A94

        DEX
        BNE     L7A94

        LDA     #$09
        JMP     L1B00

        LDA     #$01
        LDY     #$00
        STA     (L0029),Y
        RTS

        JSR     L0E6E

        BEQ     L7AAE

        JMP     L0E6E

.L7AAE
        RTS

        JSR     L0E6E

        BEQ     L7AB8

        RTS

        JMP     L0B62

.L7AB8
        LDA     #$0C
        STA     L1101
        LDA     #$02
        JMP     L10FA

.L7AC2
        RTS

        LDA     #$06
        JSR     L10D2

        LDA     L093E
        BEQ     L7AC2

        JMP     BeebDisStartAddr

        LDA     #$05
        PHA
        LDX     #$00
.L7AD5
        LDA     L10E8,X
        STA     L093E,X
        INX
        CPX     #$04
        BNE     L7AD5

        LDY     #$09
        LDX     #$3E
        PLA
        JMP     L1B00

.L7AE8
        EQUB    $00

.L7AE9
        EQUB    $04,$00,$08

.L7AEC
        PHA
        JSR     L0B62

        PLA
        STA     L0400,X
        LDA     #$00
        STA     L0401,X
        RTS

        LDY     #$11
        LDX     #$01
        JMP     L1B00

.L7B01
        EQUB    $00

.L7B02
        LDA     L09C3
        STA     L002C
        LDA     L09C4
        STA     L002D
.L7B0C
        RTS

        JSR     L1102

.L7B10
        JSR     L138A

        BCS     L7B0C

        LDA     L04FF
        ORA     L04FE
        BEQ     L7B47

        LDY     #$00
        LDA     (L002C),Y
        BMI     L7B2C

        JSR     L1379

        JSR     L1335

        JMP     L1110

.L7B2C
        AND     #$7F
        STA     L002E
        JSR     L1397

        LDA     L04FE
        ORA     L04FF
        BEQ     L7B0C

        JSR     L1335

        LDA     L002E
        BEQ     L7B10

        DEC     L002E
        JMP     L1133

.L7B47
        LDY     #$00
        LDA     (L002C),Y
        BMI     L7B0C

        JSR     L1347

        LDA     L002E
        ORA     L002F
        BEQ     L7B0C

        LDY     #$00
        LDA     (L002C),Y
        BMI     L7BB3

        LDA     (L002C),Y
        CLC
        ROL     A
        CLC
        ADC     #$00
        STA     L0029
        LDA     #$1E
        ADC     #$00
        STA     L002A
        LDA     L0029
        CLC
        ADC     L1E0E
        STA     L0029
        LDA     L002A
        ADC     L1E0F
        STA     L002A
        LDY     #$00
        LDA     (L0029),Y
        STA     L09D2
        JSR     L1869

        LDA     (L0029),Y
        STA     L09D1
        JMP     L11C3

        LDA     (L002C),Y
        CLC
        ROL     A
        CLC
        ADC     #$00
        PHP
        ADC     L1E0E
        STA     L0029
        LDA     #$1E
        ADC     #$00
        PLP
        ADC     L1E0F
        STA     L002A
        LDA     (L0029),Y
        STA     L09D2
        JSR     L1869

        LDA     (L0029),Y
        STA     L09D1
        JMP     L11C3

.L7BB3
        LDA     (L002C),Y
        STA     L09D2
        JSR     L1397

        JSR     L11DD

        LDA     (L002C),Y
        STA     L09D1
        JSR     L1397

        JSR     L11DD

        LDA     L09D2
        CMP     #$8F
        BNE     L7BD7

        LDA     L09D1
        CMP     #$80
        BEQ     L7BE5

.L7BD7
        JSR     L11E6

        JMP     L1150

        LDA     L002E
        BNE     L7BE3

        DEC     L002F
.L7BE3
        DEC     L002E
.L7BE5
        RTS

        LDA     #$00
        STA     L09AE
        LDA     L09D2
        LSR     A
        LSR     A
        LSR     A
        LSR     A
        AND     #$07
        STA     L09AC
        LDA     L09D2
        AND     #$0F
        CMP     #$0F
        BCC     L7C25

include "OSEMUL.ASM"

.BeebDisEndAddr

SAVE "MAGIK",AtmHeader,BeebDisEndAddr

