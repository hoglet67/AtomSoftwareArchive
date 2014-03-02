L0019   = $0019
L001A   = $001A
L001C   = $001C
L001D   = $001D
L0021   = $0021
L0022   = $0022
L002A   = $002A
L002B   = $002B
L002E   = $002E
L002F   = $002F
L0030   = $0030
L0031   = $0031
L0032   = $0032
L0033   = $0033
L0034   = $0034
L0035   = $0035
L0036   = $0036
L0037   = $0037
L0038   = $0038
L0039   = $0039
L003C   = $003C
L003D   = $003D
L003E   = $003E
L003F   = $003F
L0040   = $0040
L0041   = $0041
L0044   = $0044
L0049   = $0049
L004A   = $004A
L004B   = $004B
L004C   = $004C
L004D   = $004D
L004E   = $004E
L0050   = $0050
L0051   = $0051
L0052   = $0052
L0053   = $0053
L0056   = $0056
L0057   = $0057
L0058   = $0058
L0059   = $0059
L0060   = $0060
L006A   = $006A
L006B   = $006B
L006C   = $006C
L006E   = $006E
L006F   = $006F
L00FD   = $00FD
L00FE   = $00FE
L00FF   = $00FF
L0202   = $0202
L0203   = $0203
L020E   = $0208
L020F   = $0209
L0400   = $0400
L0500   = $0500
L0501   = $0501
L0502   = $0502
L0504   = $0504
L053F   = $053F
L057B   = $057B
L0580   = $0580
L05F0   = $05F0
L05F1   = $05F1
L05F2   = $05F2
L05F3   = $05F3
L05F4   = $05F4
L05F5   = $05F5
L05F6   = $05F6
L05F7   = $05F7
L0600   = $0600
L08C0   = $08C0
L08C1   = $08C1
L08C2   = $08C2
L08C3   = $08C3
L08C4   = $08C4
L08C5   = $08C5
L0E07   = $0E07
L1082   = $1082
L10BC   = $10BC
L1204   = $1204
L17D3   = $17D3
L17D4   = $17D4
L1904   = $1904
L1914   = $1914
; LFFE0   = $FFE3 ; OSRDCH
; LFFE3   = $FFE9 ; OSASCI
; LFFE7   = $FFED ; OSNEWL
; LFFEE   = $FFF4 ; OSWRCH
; LFFF1   = $FF37 ; OSWORD
; LFFF4   = $FF37 ; OSBYTE
; LFFF7   = $FFF7 ; OSCLI
LFFFC   = $FFFC ; RESETV

L3500 = $3500
L3501 = $3501
L3502 = $3502
L3503 = $3503
L3504 = $3504
L3505 = $3505
L3506 = $3506
L3507 = $3507
L3508 = $3508
L3509 = $3509
L350A = $350A
L350B = $350B
L350C = $350C
L350D = $350D
L3513 = $3513
L3514 = $3514
L3515 = $3515

UpperCaseOnly=0

Width=$20

        org     $2800 - 22

.AtmHeader

        EQUS    "QUILL"

        org AtmHeader + 16

        EQUW	BeebDisStartAddr
        EQUW    BeebDisStartAddr
        EQUW	BeebDisEndAddr - BeebDisStartAddr


.BeebDisStartAddr

        JMP     Start

include "OSEMUL.ASM"

        org         $2900
.Start
        LDA     #$44
        STA     L2981
        LDA     #$2C
        STA     L2982
.L290A
        LDA     #$EE
        STA     L0202
        LDA     #$29
        STA     L0203
        LDA     L020F
        CMP     #$2A
        BEQ     L2933

        LDA     L020E
        STA     L0021
        LDA     L020F
        STA     L0022
        LDA     #$2E
        STA     L020E
        LDA     #$2A
        STA     L020F
        LDA     #$00
        STA     L004B
.L2933
        LDY     L004B
        LDA     L2983,Y
        BEQ     L294A

        INY
        LDX     L2983,Y
        LDY     #$00
        JSR     LFFF4

        INC     L004B
        INC     L004B
        JMP     L2933

.L294A
        LDY     #$00
.L294C
        LDA     L1082,Y
        STA     L08C5,Y
        INY
        CPY     #$05
        BCC     L294C

.L2957
        LDA     L10BC,Y
        STA     L08C5,Y
        INY
        CPY     #$24
        BCC     L2957

        LDA     L17D3
        STA     L08C0
        LDA     L17D4
        STA     L08C1
        LDA     L1904
        STA     L08C2
        LDA     L1914
        STA     L08C3
        LDA     L1204
        STA     L08C4
.L2980
        JMP     L0E07

        L2981   = L2980+1
        L2982   = L2980+2
.L2983
        EQUB    $E5

.L2984
        EQUB    $01,$00,$0C,$8B,$00,$DB,$00,$04
        EQUB    $01,$E1,$A5,$E2,$9B,$E3,$8C,$E4
        EQUB    $00,$F7,$4C,$F8,$9C,$F9,$29,$00

.L299C
        BCS     L29B1

        LDA     #$FD
        LDX     #$00
        LDY     #$FF
        JSR     LFFF4

        CPX     #$02
        BNE     L29B0

        LDA     #$F7
        JSR     LFFF4

.L29B0
        RTS

.L29B1
        CLI
        LDX     #$FF
        TXS
        LDY     #$00
.L29B7
        LDA     L08C5,Y
        STA     L1082,Y
        INY
        CPY     #$05
        BCC     L29B7

.L29C2
        LDA     L08C5,Y
        STA     L10BC,Y
        INY
        CPY     #$24
        BCC     L29C2

        LDA     L08C0
        STA     L17D3
        LDA     L08C1
        STA     L17D4
        LDA     L08C2
        STA     L1904
        LDA     L08C3
        STA     L1914
        LDA     L08C4
        STA     L1204
        JMP     L290A

.L29EE
        PLA
        PLA
        PLA
        TYA
        PHA
        LDY     #$00
        LDA     (L00FD),Y
        PHA
.L29F8
        INY
        LDA     (L00FD),Y
        BEQ     L2A03

        JSR     LFFE3

        JMP     L29F8

.L2A03
        PLA
        CMP     #$FF
        BNE     L2A1A

        INY
        TYA
        CLC
        ADC     L00FD
        STA     L00FD
        LDA     L00FE
        ADC     #$00
        STA     L00FE
        PLA
        TAY
        JMP     (L00FD)

.L2A1A
        LDA     #$07
        JSR     LFFEE

        LDA     #$0F
        LDX     #$01
        LDY     #$00
        JSR     LFFF4

        JSR     LFFE0

        JMP     L290A

.L2A2E
        CMP     #$3E
        BEQ     L2A39

        CMP     #$7E
        BEQ     L2A46

.L2A36
        JMP     (L0021)

.L2A39
        LDA     #Width
        JSR     L2A48

        LDA     #$7F
        JSR     L2A36

        JMP     LFFE7

.L2A46
        LDA     #$0D
.L2A48
        STA     L2A5B
        TXA
        PHA
        TYA
        PHA
        LDA     #$86
        JSR     LFFF4

.L2A54
        LDA     #$20
        JSR     L2A36

        INX
.L2A5A
        CPX     #$0D
        L2A5B   = L2A5A+1
        BNE     L2A54

        PLA
        TAY
        PLA
        TAX
        RTS

.L2A63
        JSR     L2A7C

        CMP     #$59
        BEQ     L2A79

        CMP     #$79
        BEQ     L2A79

        CMP     #$4E
        BEQ     L2A76

        CMP     #$6E
        BNE     L2A63

.L2A76
        LDA     #$00
        RTS

.L2A79
        LDA     #$FF
        RTS

.L2A7C
        LDA     #$15
        LDX     #$00
        JSR     LFFF4

        JSR     LFFE0

        RTS

.L2A87
        STA     L002A
        LDA     #$00
        STA     L002B
.L2A8D
        LDX     #$04
.L2A8F
        LDA     #$00
        STA     L003F,X
        SEC
.L2A94
        LDA     L002A
        SBC     L2C3A,X
        TAY
        LDA     L002B
        SBC     L2C3F,X
        BCC     L2AA9

        STA     L002B
        STY     L002A
        INC     L003F,X
        BNE     L2A94

.L2AA9
        DEX
        BPL     L2A8F

        LDX     #$05
.L2AAE
        DEX
        BEQ     L2AB5

        LDA     L003F,X
        BEQ     L2AAE

.L2AB5
        LDA     L003F,X
        ORA     #$30
        JSR     LFFEE

        STX     L004B
        LDX     L004D
        STA     L0600,X
        INC     L004D
        LDX     L004B
        DEX
        BPL     L2AB5

        RTS

.L2ACB
        LDA     (L0050),Y
.L2ACD
        STA     L002F
        LDX     #$00
        STY     L006E
.L2AD3
        INC     L006E
        LDY     L006E
        CPY     L002F
        BCC     L2AE3

        LDA     #$0D
        STA     L0600,X
        STX     L004D
        RTS

.L2AE3
        LDA     (L0050),Y
        PHA
        AND     #$7F
        CMP     #$20
        BCS     L2AF7

        TAY
        LDA     L2BFA,Y
        STA     L0600,X
        INX
        LDA     L2C1A,Y
.L2AF7
        CMP     #$40
        BNE     L2AFD

.L2AFB
        LDA     #$20
        L2AFC   = L2AFB+1
.L2AFD
        STA     L0600,X
        INX
        PLA
        BPL     L2B0A

        LDA     #$20
        STA     L0600,X
        INX
.L2B0A
        JMP     L2AD3

.L2B0D
        JSR     L2ACB

.L2B10
        STX     L006E
        LDX     #$00
.L2B14
        LDA     L0600,X
        JSR     LFFEE

        INX
        CPX     L006E
        BCC     L2B14

        RTS

.L2B20
        LDA     L3500
        STA     L0050
        LDA     L3501
        STA     L0051
.L2B2A
        JSR     L2B51

        LDA     L0037
        CMP     #$FF
        BNE     L2B50

        LDA     L0050
        CLC
        ADC     #$05
        STA     L0050
        LDA     L0051
        ADC     #$00
        STA     L0051
        CMP     L3503
        BNE     L2B2A

        LDA     L0050
        CMP     L3502
        BNE     L2B2A

        LDA     #$FF
        STA     L0037
.L2B50
        RTS

.L2B51
        LDY     #$00
.L2B53
        LDA     L0580,Y
        CMP     #$61
        BCC     L2B5D

        SEC
        SBC     #$20
.L2B5D
        CMP     (L0050),Y
        BNE     L2B6B

        INY
        CPY     #$04
        BNE     L2B53

        LDA     (L0050),Y
.L2B68
        STA     L0037
        RTS

.L2B6B
        LDY     #$04
        LDA     #$FF
        JMP     L2B68

.L2B72
        LDA     #$01
        JSR     L2BA9

        LDA     #$04
        LDX     #$00
        LDY     #$00
        JSR     LFFF4

        LDA     #$06
        STA     L004B
        LDA     #$27
        STA     L004C
        LDA     #$20
        STA     L004D
        LDA     #$7D
        STA     L004E
        LDA     #$00
        STA     L004A
        TAY
        LDX     #$4A
        JSR     LFFF1

        LDA     #$04
        LDX     #$01
        LDY     #$00
        JSR     LFFF4

        LDA     #$00
        STA     L003D
        STA     L003C
.L2BA9
        STA     L2BBC
        LDY     #$00
.L2BAE
        LDA     L2BBA,Y
        JSR     LFFEE

        INY
        CPY     #$0A
        BCC     L2BAE

        RTS

.L2BBA
        EQUB    $17

.L2BBB
        EQUB    $01

.L2BBC
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00

.L2BC4
        LDX     #$00
        STX     L003C
.L2BC8
        LDY     L003D
        INC     L003D
        LDA     L0600,Y
        CMP     #$20
        BEQ     L2BF1

        CMP     #$0D
        BEQ     L2BEA

        STA     L0580,X
        INX
        CMP     #$30
        BCC     L2BE3

        CMP     #$3A
        BCC     L2BC8

.L2BE3
        LDA     #$01
        STA     L003C
        JMP     L2BC8

.L2BEA
        CPX     #$00
        BNE     L2BF5

        LDY     #$01
        RTS

.L2BF1
        CPX     #$00
        BEQ     L2BC8

.L2BF5
        LDY     #$00
        DEC     L003D
        RTS

.L2BFA
        EQUB    $73

.L2BFB
        EQUB    $63,$69,$69,$65,$6C,$6F,$65,$74
        EQUB    $65,$68,$6C,$64,$72,$6E,$63,$6F
        EQUB    $65,$69,$74,$61,$73,$65,$61,$65
        EQUB    $6F,$64,$6C,$61,$65,$61,$67

.L2C1A
        EQUB    $74,$68,$65,$6E,$64,$65,$75,$65
        EQUB    $68,$72,$65,$6C,$73,$65,$74,$6B
        EQUB    $72,$61,$74,$6F,$6E,$73,$73,$74
        EQUB    $6E,$6F,$6F,$79,$64,$78,$6D,$68

.L2C3A
        EQUB    $01,$0A,$64,$E8,$10

.L2C3F
        EQUB    $00,$00,$00,$03,$27

.L2C44
        LDA     #$AC
        STA     L2981
        LDA     #$2C
        STA     L2982
        LDA     #$FF
        STA     L34FF
        LDX     #$00
        STX     L001D
        LDY     #$00
        LDA     #$04
        JSR     LFFF4

        LDA     #$01
        LDX     #$00
        LDY     #$05
        JSR     LFFF1

        LDA     L0504
        STA     L0019
.L2C6C
        LDA     L3508
        SEC
        ADC     L3514
        STA     L0050
        LDA     L3509
        ADC     #$00
        STA     L0051
        LDY     #$00
        STY     L0501
.L2C81
        LDA     (L0050),Y
        STA     L0400,Y
        CMP     #$FD
        BCC     L2C91

        CMP     #$FF
        BEQ     L2C91

        INC     L0501
.L2C91
        INY
        CPY     L3514
        BCC     L2C81

        BEQ     L2C81

        LDY     #$00
        LDA     #$FF
        STA     L0500,Y
        INY
        INY
.L2CA2
        LDA     #$00
        STA     L0500,Y
        INY
        CPY     #$40
        BNE     L2CA2

.L2CAC
        LDA     #$20
        STA     L2AFC
        LDA     L3513
        CMP     L0502
        BCC     L2C6C

        LDA     #$0C
        JSR     LFFEE

        LDA     #$FF
        STA     L053F
        LDA     L001D
        BEQ     L2CD6

        LDA     #$1F
        JSR     LFFEE

        LDA     #$00
        JSR     LFFEE

        LDA     #$08
        JSR     LFFEE

.L2CD6
        LDA     L0400
        CMP     L0502
        BEQ     L2CF5

        CMP     #$FE
        BEQ     L2CF5

        CMP     #$FD
        BEQ     L2CF5

        LDA     L0500
        CMP     #$00
        BNE     L2CF5

        LDX     #$03
        JSR     L2FD2

        JMP     L2D41

.L2CF5
        LDA     L0502
        STA     L003E
        LDA     L3504
        STA     L0050
        LDA     L3505
        STA     L0051
        JSR     L2F9B

        JSR     L2B0D

        JSR     LFFE7

        LDA     #$00
        STA     L0037
        STA     L0030
.L2D13
        LDX     L0030
        LDA     L0400,X
        CMP     L0502
        BNE     L2D33

        LDA     L0037
        CMP     #$00
        BNE     L2D30

        STX     L0037
        LDX     #$04
        JSR     L2FD2

        LDX     L0037
        LDA     #$FF
        STA     L0037
.L2D30
        JSR     L2FF5

.L2D33
        INC     L0030
        LDA     L3514
        CLC
        ADC     #$01
        CMP     L0030
        BEQ     L2D41

        BCS     L2D13

.L2D41
        LDA     #$02
        STA     L0030
        JMP     L2E71

.L2D48
        LDA     L001D
        BNE     L2D4F

        JMP     L2DCC

.L2D4F
        LDA     #$86
        JSR     LFFF4

        CPY     #$09
        BCS     L2D5A

        LDY     #$09
.L2D5A
        CPY     #$18
        BCC     L2D68

        BRK
.L2D5F
        EQUB    $FF

.L2D60
        EQUB    $1F,$01,$18,$0D,$0D,$00

.L2D66
        LDY     #$16
.L2D68
        TYA
        PHA
        LDA     #$1E
        JSR     LFFEE

        LDX     #$00
        LDY     #$00
        STX     L0049
        STX     L004C
        STX     L004A
.L2D79
        LDA     #$20
        JSR     LFFEE

        INX
        CPX     #Width
        BCC     L2D79

        INY
        LDX     #$00
        CPY     #$08
        BCC     L2D79

.L2D8A
        LDA     #$1F
        JSR     LFFEE

        LDA     L004C
        JSR     LFFEE

        LDA     L004A
        JSR     LFFEE

        LDX     L0049
        CPX     #$40
        BCS     L2DBE

        LDA     L0500,X
        JSR     L2A87

        INC     L0049
        LDA     L004C
        CLC
        ADC     #$04
        STA     L004C
        CMP     #$28
        BCC     L2D8A

        INC     L004A
        LDA     #$00
        STA     L004C
        LDA     L0049
        CMP     #$40
        BCC     L2D8A

.L2DBE
        LDA     #$1F
        JSR     LFFEE

        LDA     #$00
        JSR     LFFEE

        PLA
        JSR     LFFEE

.L2DCC
        JSR     L2F8D

        LDA     (L0050),Y
        LDY     #$02
        JSR     L2ACD

        JSR     L2B10

        JSR     L2B72

        LDA     #$00
        STA     L003E
.L2DE0
        JSR     L2BC4

        CPY     #$01
        BNE     L2DFA

        LDA     L003E
        CMP     #$01
        BNE     L2DF2

        LDA     #$FF
        JMP     L2E1D

.L2DF2
        LDX     #$0E
        JSR     L2FD2

        JMP     L2D41

.L2DFA
        CPX     #$04
        BCS     L2E07

        LDA     #$20
        STA     L0580,X
        INX
        JMP     L2DFA

.L2E07
        JSR     L2B20

        LDA     L0037
        CMP     #$FF
        BEQ     L2DE0

        LDY     L003E
        CPY     #$00
        BNE     L2E1D

        STA     L006A
        INC     L003E
        JMP     L2DE0

.L2E1D
        STA     L006F
        LDA     #$00
        STA     L0030
        JMP     L2E71

.L2E26
        LDA     L0044
        CMP     #$FF
        BNE     L2E2F

        JMP     L2D41

.L2E2F
        LDA     L0502
        STA     L003E
        LDA     L350A
        STA     L0050
        LDA     L350B
        STA     L0051
        JSR     L2F9B

        LDY     #$00
        LDA     (L0050),Y
        STA     L0056
.L2E47
        INY
        CPY     L0056
        BCS     L2E5B

        LDA     (L0050),Y
        INY
        CMP     L006A
        BNE     L2E47

        LDA     (L0050),Y
        STA     L0502
        JMP     L2CAC

.L2E5B
        LDA     L006A
        CMP     #$0D
        BCC     L2E69

        LDX     #$05
        JSR     L2FD2

        JMP     L2D41

.L2E69
        LDX     #$0F
        JSR     L2FD2

        JMP     L2D41

.L2E71
        LDY     L0030
        STY     L0044
        LDA     L350C,Y
        STA     L0052
        LDA     L350D,Y
        STA     L0053
.L2E7F
        LDY     #$00
        STY     L0057
        LDA     (L0052),Y
        STA     L0059
        INY
        LDA     (L0052),Y
        STA     L0060
        INY
        LDA     (L0052),Y
        STA     L0056
        LDA     L0052
        CLC
        ADC     #$02
        STA     L0052
        LDA     L0053
        ADC     #$00
        STA     L0053
        LDA     L0059
        CMP     #$FF
        BNE     L2EA7

        JMP     L2F49

.L2EA7
        LDY     L0030
        CPY     #$02
        BEQ     L2EC7

        LDA     L0059
        CMP     L006A
        BEQ     L2EB6

        JMP     L2F39

.L2EB6
        LDA     L0060
        CMP     #$FF
        BEQ     L2EC7

        CMP     L006F
        BEQ     L2EC7

        JMP     L2F39

.L2EC3
        LDA     #$FF
        STA     L0044
.L2EC7
        LDA     #$00
        STA     L001A
        INC     L0057
        LDY     L0057
        CPY     L0056
        BCC     L2ED6

        JMP     L2F39

.L2ED6
        LDA     #$00
        STA     L0059
        STA     L0060
        LDA     (L0052),Y
        STA     L0058
        CMP     #$0F
        BCC     L2EFC

        INY
        INC     L0057
        LDA     (L0052),Y
        STA     L0059
        STA     L0035
        LDA     L0058
        CMP     #$2C
        BCC     L2EFC

        INY
        INC     L0057
        LDA     (L0052),Y
        STA     L0060
        STA     L0036
.L2EFC
        LDY     L0058
        LDA     L345D,Y
        LSR     A
        LSR     A
        LSR     A
        LSR     A
        LDX     L0059
        JSR     L33B4

        STX     L0038
        LDA     L006B
        STA     L0031
        LDA     L006C
        STA     L0032
        LDA     L345D,Y
        AND     #$0F
        LDX     L0060
        JSR     L33B4

        STX     L0039
        LDA     L006B
        STA     L0033
        LDA     L006C
        STA     L0034
        LDA     L0058
        ASL     A
        TAY
        LDA     L33EB,Y
        STA     L0050
        LDA     L33EC,Y
        STA     L0051
        JMP     (L0050)

.L2F39
        LDA     L0052
        CLC
        ADC     L0056
        STA     L0052
        LDA     L0053
        ADC     #$00
        STA     L0053
        JMP     L2E7F

.L2F49
        LDA     L0030
        CMP     #$02
        BNE     L2F52

        JMP     L2D48

.L2F52
        JMP     L2E26

.L2F55
        EQUB    $53

.L2F56
        EQUB    $41,$56,$45,$20

.L2F5A
        EQUB    $20,$30,$34,$30,$30,$20,$30,$35
        EQUB    $34,$30,$0D

.L2F65
        EQUB    $4C,$4F,$41,$44,$20

.L2F6A
        EQUB    $20,$30,$34,$30,$30,$0D

.L2F70
        JSR     L2F8D

        JSR     L2B72

        LDA     L0600
        CMP     #$61
        BCC     L2F80

        SEC
        SBC     #$20
.L2F80
        LDY     #$01
        CMP     (L0050),Y
        BEQ     L2F8C

        INY
        CMP     (L0050),Y
        BEQ     L2F8C

        INY
.L2F8C
        RTS

.L2F8D
        LDA     L3502
        STA     L0050
        LDA     L3503
        STA     L0051
        LDA     #$13
        STA     L003E
.L2F9B
        LDX     #$00
        LDY     #$00
.L2F9F
        CPX     L003E
        BEQ     L2FB4

        LDA     (L0050),Y
        CLC
        ADC     L0050
        STA     L0050
        LDA     L0051
        ADC     #$00
        STA     L0051
        INX
        JMP     L2F9F

.L2FB4
        RTS

.L2FB5
        LDA     L3502
        STA     L0050
        LDA     L3503
        STA     L0051
        STX     L003E
        JSR     L2F9B

        LDA     #$00
        STA     L006E
        JSR     L2B0D

        LDX     L003E
        LDA     #$FF
        STA     L001C
        RTS

.L2FD2
        JSR     L2FB5

        JMP     LFFE7

.L2FD8
        LDA     L3506
        STA     L0050
        LDA     L3507
        STA     L0051
        STX     L003E
        JSR     L2F9B

        LDA     #$00
        STA     L006E
        JSR     L2B0D

        LDX     L003E
        LDA     #$FF
        STA     L001C
        RTS

.L2FF5
        JSR     L2FD8

        JMP     LFFE7

.L2FFB
        LDA     #$04
        JMP     L300B

        LDA     #$01
        JMP     L300B

        LDA     #$02
        STA     L001A
        LDA     #$02
.L300B
        STA     L002E
        LDA     L0038
        CMP     L0039
        BEQ     L301A

        BCS     L301F

        LDA     #$01
        JMP     L3021

.L301A
        LDA     #$02
        JMP     L3021

.L301F
        LDA     #$04
.L3021
        AND     L002E
        EOR     L001A
        CMP     #$00
        BEQ     L302C

        JMP     L2EC7

.L302C
        JMP     L2F39

        LDX     #$00
        TXA
        PHA
        JSR     L2FD2

.L3036
        LDA     L0400,X
        CMP     #$FD
        BNE     L3047

        JSR     L2FF5

        PLA
        LDA     #$FF
        PHA
        JMP     L305B

.L3047
        CMP     #$FE
        BNE     L305B

        JSR     L2FD8

        PLA
        LDA     #$FF
        PHA
        TXA
        PHA
        LDX     #$01
        JSR     L2FD2

        PLA
        TAX
.L305B
        INX
        CPX     L3514
        BCC     L3036

        BEQ     L3036

        PLA
        BNE     L306B

        LDX     #$02
        JSR     L2FD2

.L306B
        JMP     L2EC3

        LDX     #$11
        JSR     L2FB5

        JSR     L2F70

        CPY     #$02
        BEQ     L307D

        JMP     L2C6C

.L307D
        LDA     L34FF
        CMP     #$FF
        BNE     L3099

        LDA     #$F7
        LDX     #$00
        LDY     #$00
        JSR     LFFF4

        LDX     #$C8
        LDX     #$03
        LDY     #$00
        JSR     LFFF4

        JMP     (LFFFC)

.L3099
        JMP     L0E07

.L309C
        LDX     #$08
        JSR     L2FD2

        LDA     #$FF
        STA     L0044
        JMP     L2F49

        LDY     #$00
.L30AA
        LDA     L2F55,Y
        STA     L057B,Y
        INY
        CPY     #$05
        BCC     L30AA

        LDX     #$12
        JSR     L2FB5

        JSR     L2B72

        JSR     L2BC4

        LDY     #$00
        CPX     #$0B
        BCC     L30C8

        LDX     #$0B
.L30C8
        LDA     L2F5A,Y
        STA     L0580,X
        INX
        INY
        CMP     #$0D
        BNE     L30C8

        LDX     #$7B
        LDY     #$05
        JSR     LFFF7

        JMP     L2CAC

        LDY     #$00
.L30E0
        LDA     L2F65,Y
        STA     L057B,Y
        INY
        CPY     #$05
        BCC     L30E0

        LDX     #$12
        JSR     L2FB5

        JSR     L2B72

        JSR     L2BC4

        LDY     #$00
        CPX     #$0B
        BCC     L30FE

        LDX     #$0B
.L30FE
        LDA     L2F6A,Y
        STA     L0580,X
        INX
        INY
        CMP     #$0D
        BNE     L30FE

        LDX     #$7B
        LDY     #$05
        JSR     LFFF7

        JMP     L2CAC

        LDY     #$00
        LDX     L0058
        LDA     L3508
        STA     L0050
        LDA     L3509
        STA     L0051
        LDA     L006F
        CMP     #$FF
        BEQ     L315B

.L3128
        LDA     (L0050),Y
        CMP     L006F
        BNE     L3153

        STY     L0035
        LDA     L0400,Y
        STA     L0038
        CPX     #$06
        BNE     L313C

        JMP     L3208

.L313C
        CPX     #$07
        BNE     L3143

        JMP     L3249

.L3143
        LDA     (L0050),Y
        CMP     #$C8
        BCC     L3153

        CPX     #$08
        BNE     L3150

        JMP     L326B

.L3150
        JMP     L3284

.L3153
        INY
        CPY     L3514
        BCC     L315E

        BEQ     L315E

.L315B
        JMP     L2F49

.L315E
        JMP     L3128

        JMP     L309C

        LDX     #$07
        JSR     L2FB5

        JSR     L2F70

        CPY     #$01
        BEQ     L3177

        LDA     #$FF
        STA     L0044
        JMP     L2F49

.L3177
        JMP     L2EC3

        LDX     #$06
        JSR     L2FD2

        JSR     L2A7C

        JMP     L2EC3

        LDA     #$0C
        JSR     LFFEE

        JMP     L2EC3

        LDX     #$00
.L318F
        LDA     L0400,X
        CMP     #$FD
        BCC     L31A0

        CMP     #$FF
        BEQ     L31A0

        LDA     L0502
        STA     L0400,X
.L31A0
        INX
        CPX     L3514
        BCC     L318F

        BEQ     L318F

        LDA     #$00
        STA     L0501
        JMP     L2EC3

        LDA     L0019
        CLC
        ADC     #$01
        STA     L0040
        LDA     #$65
        STA     L0041
        LDA     #$00
        STA     L0019
        LDX     #$08
.L31C1
        LSR     L0040
        BCC     L31C8

        CLC
        ADC     L0041
.L31C8
        ROR     A
        ROR     L0019
        DEX
        BNE     L31C1

        STA     L0039
        JMP     L2FFB

.L31D3
        LDA     L0038
        CMP     #$00
        BEQ     L31ED

        DEC     L0038
        LDX     #$23
.L31DD
        LDY     #$64
.L31DF
        NOP
        DEY
        CPY     #$00
        BNE     L31DF

        DEX
        CPX     #$00
        BNE     L31DD

        JMP     L31D3

.L31ED
        JMP     L2EC3

        LDA     L0038
        STA     L0502
        JMP     L2EC3

        LDX     L0038
        JSR     L2FD2

        JMP     L2EC3

        LDX     L0038
        JSR     L2FB5

        JMP     L2EC3

.L3208
        LDA     L0501
        CMP     L3515
        BNE     L321C

        LDX     #$10
.L3212
        JSR     L2FD2

        LDA     #$FF
        STA     L0044
        JMP     L2F49

.L321C
        LDA     L0038
        CMP     L0502
        BEQ     L3235

        CMP     #$FD
        BEQ     L3230

        CMP     #$FE
        BEQ     L3230

        LDX     #$0B
        JMP     L3212

.L3230
        LDX     #$09
        JMP     L3212

.L3235
        LDA     L0501
        CMP     #$FF
        BEQ     L323F

        INC     L0501
.L323F
        LDA     #$FD
.L3241
        LDY     L0035
        STA     L0400,Y
        JMP     L2EC3

.L3249
        LDA     L0038
        CMP     #$FD
        BEQ     L3258

        CMP     #$FE
        BEQ     L3266

        LDX     #$0A
        JMP     L3212

.L3258
        LDA     L0501
        BEQ     L3260

        DEC     L0501
.L3260
        LDA     L0502
        JMP     L3241

.L3266
        LDX     #$05
        JMP     L3212

.L326B
        LDA     L0038
        CMP     #$FD
        BEQ     L327F

        CMP     #$FE
        BEQ     L327A

        LDX     #$0A
        JMP     L3212

.L327A
        LDX     #$0C
        JMP     L3212

.L327F
        LDA     #$FE
        JMP     L3241

.L3284
        LDA     L0038
        CMP     #$FE
        BEQ     L323F

        LDX     #$0D
        JMP     L3212

        LDA     L0502
.L3292
        PHA
        LDA     L0038
        CMP     #$FF
        BEQ     L32A5

        CMP     #$FD
        BCC     L32A5

        LDA     L0501
        BEQ     L32A5

        DEC     L0501
.L32A5
        PLA
        JMP     L3241

        LDA     #$FF
        JMP     L3292

        LDA     L0039
        JMP     L3292

        LDA     L0039
        LDX     L0035
        STA     L0500,X
        JMP     L2EC3

        LDA     L0035
        CMP     #$30
        BCS     L32CB

        LDA     L0038
        JSR     L2A87

        JMP     L2EC3

.L32CB
        LDA     L0038
        STA     L002A
        LDY     #$01
        LDA     (L0031),Y
        STA     L002B
        JSR     L2A8D

        JMP     L2EC3

        LDX     L0035
        LDA     L0038
        CLC
        ADC     L0039
        STA     L0500,X
        BCC     L32FD

        CPX     #$30
        BCS     L32F3

        LDA     #$FF
        STA     L0500,X
        JMP     L2EC3

.L32F3
        LDA     L0501,X
        CMP     #$FF
        BEQ     L32FD

        INC     L0501,X
.L32FD
        JMP     L2EC3

        LDA     #$FF
        JMP     L3307

        LDA     #$00
.L3307
        STA     L001A
        LDA     L0038
        CMP     #$FD
        BEQ     L3324

        CMP     #$FE
        BEQ     L3324

        CMP     L0502
        BEQ     L3324

        LDA     #$FF
.L331A
        EOR     L001A
        BEQ     L3321

        JMP     L2F39

.L3321
        JMP     L2EC7

.L3324
        LDA     #$00
        JMP     L331A

        LDX     L0035
        LDA     L0038
        SEC
        SBC     L0039
        STA     L0500,X
        BCS     L3349

        CPX     #$30
        BCS     L3341

        LDA     #$00
        STA     L0500,X
        JMP     L2EC3

.L3341
        LDA     L0501,X
        BEQ     L3349

        DEC     L0501,X
.L3349
        JMP     L2EC3

        LDX     L0035
        LDA     L0039
        STA     L0400,X
        LDX     L0036
        LDA     L0038
        STA     L0400,X
        JMP     L2EC3

        LDA     #$00
        STA     L006E
        LDX     L0038
        JSR     L2FD2

        LDA     L0600
        CMP     #$2A
        BNE     L3378

        LDX     #$00
        LDY     #$06
        JSR     LFFF7

        LDA     #$01
        STA     L006E
.L3378
        JMP     L2EC3

        JSR     L3381

        JMP     L2EC3

.L3381
        JMP     (L0038)

        LDA     #$00
        STA     L05F1
        STA     L05F5
        STA     L05F7
        LDA     #$01
        STA     L05F0
        LDA     #$F1
        STA     L05F2
        LDA     L00FF
        STA     L05F3
        LDA     L0038
        STA     L05F4
        LDA     L0039
        STA     L05F6
        LDX     #$F0
        LDY     #$05
        LDA     #$07
        JSR     LFFF1

        JMP     L2EC3

.L33B4
        CMP     #$00
        BEQ     L33E9

        CMP     #$04
        BEQ     L33C1

        BCS     L33CC

        LDA     #$0A
        RTS

.L33C1
        STA     L006C
        STX     L006B
        LDA     L0400,X
        TAX
        LDA     #$04
        RTS

.L33CC
        CMP     #$05
        BNE     L33DE

        PHA
        TXA
        STA     L006B
        LDA     #$05
        STA     L006C
        LDA     L0500,X
        TAX
        PLA
        RTS

.L33DE
        CMP     #$06
        BNE     L33E6

        LDX     L0502
        RTS

.L33E6
        CLC
        ADC     #$F6
.L33E9
        TAX
        RTS

.L33EB
        EQUB    $2F

.L33EC
        EQUB    $30,$AC,$2C,$8D,$31,$49,$2F,$9C
        EQUB    $30,$7A,$31,$14,$31,$14,$31,$14
        EQUB    $31,$14,$31,$A8,$30,$DE,$30,$64
        EQUB    $31,$85,$31,$6E,$30,$FB,$2F,$00
        EQUB    $30,$05,$30,$09,$30,$05,$33,$00
        EQUB    $33,$05,$30,$09,$30,$05,$30,$09
        EQUB    $30,$05,$30,$09,$30,$8F,$32,$A9
        EQUB    $32,$F8,$31,$B0,$31,$08,$32,$49
        EQUB    $32,$6B,$32,$84,$32,$05,$30,$09
        EQUB    $30,$D3,$31,$F0,$31,$00,$32,$B3
        EQUB    $32,$B3,$32,$BD,$32,$5D,$33,$DB
        EQUB    $32,$29,$33,$B3,$32,$DB,$32,$29
        EQUB    $33,$4C,$33,$AE,$32,$05,$30,$09
        EQUB    $30,$FB,$2F,$00,$30,$7B,$33,$84
        EQUB    $33

.L345D
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$16
        EQUB    $16,$16,$16,$46,$46,$48,$48,$47
        EQUB    $47,$49,$49,$46,$49,$20,$30,$40
        EQUB    $40,$40,$40,$50,$50,$30,$10,$20
        EQUB    $59,$50,$50,$20,$53,$53,$53,$55
        EQUB    $55,$44,$41,$53,$53,$53,$53,$33
        EQUB    $33,$00,$FF,$0C,$7E,$20,$20,$20
        EQUB    $54,$68,$65,$20,$51,$75,$69,$6C
        EQUB    $6C,$0D,$7E,$28,$43,$29,$20,$47
        EQUB    $69,$6C,$73,$6F,$66,$74,$20,$31
        EQUB    $39,$38,$35,$0D,$1F,$0A,$02,$42
        EQUB    $79,$20,$4E,$65,$69,$6C,$20,$46
        EQUB    $6C,$65,$6D,$69,$6E,$67,$2D,$53
        EQUB    $6D,$69,$74,$68,$0D,$0D,$0D,$00
        EQUB    $60,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00

.L34FF
        EQUB    $00

.BeebDisEndAddr
SAVE "QUILLINT",AtmHeader,BeebDisEndAddr

