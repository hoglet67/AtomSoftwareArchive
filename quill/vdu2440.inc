;
; Code equates
;
L0052       = $0052
L0053       = $0053
L0080       = $0080
L0081       = $0081
L0082       = $0082
L008D       = $008D
L008E       = $008E
L008F       = $008F
L00DC       = $00DC
L00DE       = $00DE
L00DF       = $00DF
L00E0       = $00E0
L00E1       = $00E1
L00E2       = $00E2
L00E3       = $00E3
L00E4       = $00E4
L00E5       = $00E5
L00E6       = $00E6
L0100       = $0100
L0208       = $0208
L023D       = $023D
L023E       = $023E
L03FE       = $03FE
L03FF       = $03FF
LB000       = $B000
LB001       = $B001
LB002       = $B002
LFB8A       = $FB8A
LFD11       = $FD11
LFD1A       = $FD1A
LFE5C       = $FE5C
LFE5F       = $FE5F
LFE60       = $FE60
LFE66       = $FE66
LFE71       = $FE71
LFEB2       = $FEB2
LFEC1       = $FEC1
LFEC5       = $FEC5
LFEFB       = $FEFB
LFFF4       = $FFF4
;
; Start of code
;
;            *= $5000
;
L5000:
            .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            .byte $FF,$EF,$D7,$D7,$EF,$9B,$CF,$EF
            .byte $F7,$DF,$FF,$FF,$FF,$FF,$FF,$FF
            .byte $C7,$EF,$C7,$C7,$F7,$83,$C7,$83
            .byte $C7,$C7,$FF,$FF,$FF,$FF,$FF,$C7
            .byte $FF,$EF,$D7,$83,$C3,$97,$B7,$EF
            .byte $EF,$EF,$EF,$EF,$FF,$FF,$FF,$FB
            .byte $BB,$CF,$BB,$BB,$E7,$BF,$BF,$FB
            .byte $BB,$BB,$EF,$EF,$F7,$FF,$DF,$BB
            .byte $FF,$EF,$FF,$D7,$AF,$EF,$CF,$FF
            .byte $EF,$EF,$AB,$EF,$FF,$FF,$FF,$F7
            .byte $A3,$EF,$FB,$E7,$D7,$87,$87,$F7
            .byte $C7,$BB,$EF,$EF,$EF,$83,$EF,$F7
            .byte $FF,$EF,$FF,$D7,$C7,$DF,$AB,$FF
            .byte $EF,$EF,$C7,$83,$FF,$83,$FF,$EF
            .byte $8B,$EF,$C7,$FB,$83,$FB,$BB,$EF
            .byte $BB,$C3,$FF,$FF,$DF,$FF,$F7,$EF
            .byte $FF,$FF,$FF,$83,$EB,$B3,$B7,$FF
            .byte $EF,$EF,$AB,$EF,$EF,$FF,$EF,$DF
            .byte $BB,$EF,$BF,$BB,$F7,$FB,$BB,$DF
            .byte $BB,$FB,$EF,$EF,$EF,$83,$EF,$FF
            .byte $FF,$EF,$FF,$D7,$87,$B3,$CB,$FF
            .byte $F7,$DF,$EF,$EF,$DF,$FF,$EF,$BF
            .byte $C7,$C7,$83,$C7,$F7,$87,$C7,$BF
            .byte $C7,$C7,$EF,$DF,$F7,$FF,$DF,$EF
            .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            .byte $87,$EF,$87,$C7,$8F,$83,$83,$C7
            .byte $BB,$83,$83,$BB,$BF,$BB,$BB,$C7
            .byte $87,$C7,$87,$C3,$83,$BB,$BB,$BB
            .byte $BB,$BB,$83,$C7,$FF,$C7,$EF,$FF
            .byte $FB,$D7,$BB,$BB,$B7,$BF,$BF,$BB
            .byte $BB,$EF,$FB,$B7,$BF,$93,$9B,$BB
            .byte $BB,$BB,$BB,$BF,$EF,$BB,$BB,$BB
            .byte $D7,$BB,$F7,$DF,$BF,$F7,$C7,$EF
            .byte $CB,$BB,$87,$BF,$BB,$87,$87,$BF
            .byte $83,$EF,$FB,$AF,$BF,$AB,$AB,$BB
            .byte $BB,$BB,$BB,$C7,$EF,$BB,$BB,$AB
            .byte $EF,$D7,$EF,$DF,$DF,$F7,$AB,$DF
            .byte $AB,$83,$BB,$BF,$BB,$BF,$BF,$B3
            .byte $BB,$EF,$FB,$8F,$BF,$AB,$AB,$BB
            .byte $87,$BB,$87,$FB,$EF,$BB,$D7,$AB
            .byte $EF,$EF,$DF,$DF,$EF,$F7,$EF,$83
            .byte $AB,$BB,$BB,$BB,$B7,$BF,$BF,$BB
            .byte $BB,$EF,$BB,$B7,$BF,$BB,$B3,$BB
            .byte $BF,$C7,$AF,$FB,$EF,$BB,$D7,$93
            .byte $D7,$EF,$BB,$DF,$F7,$F7,$EF,$DF
            .byte $C7,$BB,$87,$C7,$8F,$83,$BF,$C7
            .byte $BB,$83,$C7,$BB,$83,$BB,$BB,$C7
            .byte $BF,$FB,$B3,$87,$EF,$C7,$EF,$BB
            .byte $BB,$EF,$83,$C7,$FB,$C7,$EF,$EF
            .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FC
            .byte $FF,$FF,$BF,$FF,$FB,$FF,$C7,$FF
            .byte $BF,$EF,$EF,$BF,$CF,$FF,$FF,$FF
            .byte $FF,$FF,$FF,$FF,$DF,$FF,$FF,$FF
            .byte $FF,$FF,$FF,$C7,$FF,$C7,$EF,$FC
            .byte $CB,$C7,$BF,$C3,$FB,$C7,$BB,$C3
            .byte $BF,$FF,$FF,$BF,$EF,$97,$87,$C7
            .byte $87,$C7,$87,$C3,$DF,$BB,$BB,$AB
            .byte $BB,$BB,$83,$CF,$83,$E7,$EF,$EC
            .byte $B7,$FB,$87,$BF,$C3,$BB,$BF,$BB
            .byte $87,$EF,$EF,$B3,$EF,$AB,$BB,$BB
            .byte $BB,$B7,$BB,$BF,$87,$BB,$BB,$AB
            .byte $D7,$BB,$FB,$DF,$BB,$F7,$EF,$F4
            .byte $B7,$C3,$BB,$BF,$BB,$83,$8F,$C3
            .byte $BB,$EF,$EF,$8F,$EF,$AB,$BB,$BB
            .byte $87,$C7,$BF,$C7,$DF,$BB,$BB,$AB
            .byte $EF,$C3,$C7,$DF,$BB,$F7,$AB,$80
            .byte $B7,$BB,$BB,$BF,$BB,$BF,$BF,$FB
            .byte $BB,$EF,$EF,$8F,$EF,$AB,$BB,$BB
            .byte $BF,$F7,$BF,$FB,$DB,$BB,$D7,$AB
            .byte $D7,$FB,$BF,$CF,$83,$E7,$C7,$F4
            .byte $CB,$C3,$87,$C3,$C3,$C7,$BF,$C7
            .byte $BB,$EF,$DF,$B3,$C7,$AB,$BB,$C7
            .byte $BF,$E3,$BF,$87,$E7,$C7,$EF,$D7
            .byte $BB,$C7,$83,$C7,$FF,$C7,$EF,$EC
            .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
            .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FC

L5300:
	.byte <L5342,<L530A,<L5323,<L537D,<L5343,<L534A,<L536D,<L5374
	.byte <L5378,<L535C

;            .byte $42,$0A,$23,$7D,$43,$4A,$6D,$74
;            .byte $78,$5C

L530A:
	dec L00E0
	bpl L530B
	lda #39
	sta L00E0
L530B:
            dec L00E1              ; C6 E1
            bpl L5312              ; 10 04
            lda #$03               ; A9 03
            sta L00E1              ; 85 E1
L5312:      beq L5316              ; F0 02
            dec L00DE              ; C6 DE
L5316:      bpl L5342              ; 10 2A
            lda L008E              ; A5 8E
            sec                    ; 38
            sbc #$01               ; E9 01
            sta L00DE              ; 85 DE
            dec L00DF              ; C6 DF
            bmi L5342              ; 30 1F

L5323:
	inc L00E0
	lda L00E0
	cmp #40
	bne L5324
	lda #0
	sta L00E0
L5324:
            inc L00E1              ; E6 E1
            lda L00E1              ; A5 E1
            cmp #$01               ; C9 01
            beq L532D              ; F0 02
            inc L00DE              ; E6 DE
L532D:      cmp #$04               ; C9 04
            bcc L5342              ; 90 11
            lda #$00               ; A9 00
            sta L00E1              ; 85 E1
            lda L00DE              ; A5 DE
            cmp L008E              ; C5 8E
            bcc L5342              ; 90 07
            jsr L537D              ; 20 7D 53
            lda #$00               ; A9 00
            sta L00DE              ; 85 DE

L5342:      rts                    ; 60

L5343:      dec L00DF              ; C6 DF
            bmi L5349              ; 30 02
            inc L00DF              ; E6 DF
L5349:      rts                    ; 60

L534A:      lda L008D              ; A5 8D
            clc                    ; 18
            adc #$7F               ; 69 7F
            sta L00DF              ; 85 DF
            ldy #$00               ; A0 00
            sty L00DE              ; 84 DE
L5355:      jsr L53C3              ; 20 C3 53
            dec L00DF              ; C6 DF
            bmi L5355              ; 30 F9

L535C:      lda #$F0               ; A9 F0
            sta LB000              ; 8D 00 B0
            lda #$80               ; A9 80
            sta L00DF              ; 85 DF
            lda L00E6              ; A5 E6
            bmi L536D              ; 30 04
            lda L008D              ; A5 8D
            sta L00E6              ; 85 E6

L536D:      lda #$00               ; A9 00
            sta L00E1              ; 85 E1
            sta L00DE              ; 85 DE
	sta L00E0
            rts                    ; 60

L5374:      ldx L008D              ; A6 8D
            bpl L537A              ; 10 02

L5378:      ldx #$80               ; A2 80
L537A:      stx L00E6              ; 86 E6
            rts                    ; 60

L537D:      ldy L00E6              ; A4 E6
            bmi L538D              ; 30 0C
            dey                    ; 88
            bne L538B              ; D0 07
L5384:      jsr LFE71              ; 20 71 FE
            bcs L5384              ; B0 FB
            ldy L008D              ; A4 8D
L538B:      sty L00E6              ; 84 E6
L538D:      inc L00DF              ; E6 DF
            lda L008D              ; A5 8D
            ora #$80               ; 09 80
            tax                    ; AA
            cpx L00DF              ; E4 DF
            beq L539B              ; F0 03
            bcc L535C              ; 90 C2
            rts                    ; 60

L539B:      lda L00DE              ; A5 DE
            pha                    ; 48
            ldy #$81               ; A0 81
            sty L00DF              ; 84 DF
            dey                    ; 88
            sty L00E3              ; 84 E3
            ldy #$00               ; A0 00
            sty L00DE              ; 84 DE
            sty L00E2              ; 84 E2
L53AB:      lda (L00DE),Y          ; B1 DE
            sta (L00E2),Y          ; 91 E2
            iny                    ; C8
            bne L53AB              ; D0 F9
            inc L00DF              ; E6 DF
            inc L00E3              ; E6 E3
            cpx L00DF              ; E4 DF
            bne L53AB              ; D0 F1
            dec L00DF              ; C6 DF
            jsr L53C3              ; 20 C3 53
            pla                    ; 68
            sta L00DE              ; 85 DE
            rts                    ; 60

L53C3:      bit L008F              ; 24 8F
            bmi L53C8              ; 30 01
            dey                    ; 88
L53C8:      tya                    ; 98
            ldy #$00               ; A0 00
L53CB:      sta (L00DE),Y          ; 91 DE
            iny                    ; C8
            bne L53CB              ; D0 FB
            rts                    ; 60

;--------------------------------------------
; Write vector #208
;--------------------------------------------

L53D2:
            jsr LFEFB              ; 20 FB FE
            php                    ; 08
            pha                    ; 48
            cld                    ; D8
            sty L00E5              ; 84 E5
            stx L00E4              ; 86 E4

            bit LB001              ; Check CTRL/SHIFT
            bmi L53E5              ; SHIFT
            bvs L53E5              ; CTRL

            jsr LFB8A              ; 20 8A FB

L53E5:      ldy #$00               ; A0 00

            cmp #$13               ; CTRL-3 VDU32x16
            beq L53FB              ; F0 10

            cmp #$14               ; CTRL-4 VDU40x24
            bne L5400              ; D0 11

            lda #$AA               ; A9 AA
            sta L03FE              ; 8D FE 03
            lda #$F7               ; A9 F7
            sta L03FF              ; 8D FF 03
            ldy #$F0               ; A0 F0

; Entry VDU32x16

L53FB:      sty LB000              ; 8C 00 B0
            lda #$0C               ; A9 0C

; Entry VDU40x24

L5400:      ldy LB000              ; AC 00 B0
            bmi L5408              ; 30 03
            jmp LFE5C              ; 4C 5C FE

L5408:      jsr L540E              ; 20 0E 54
            jmp LFE5F              ; 4C 5F FE

L540E:      cmp #$15               ; C9 15
            beq L5417              ; F0 05

            cmp #$06               ; C9 06
            bne L541A              ; D0 04
            clc                    ; 18
L5417:      jmp LFD11              ; 4C 11 FD

L541A:
;            ldy L00E0              ; A4 E0
;            bmi L5445              ; 30 27
            pha                    ; 48
            jsr L5431              ; 20 31 54
            pla                    ; 68
            cmp #$20               ; C9 20
            bcc L5469              ; 90 42
            cmp #$7F               ; C9 7F
            beq L5489              ; F0 5E
            jsr L5494              ; 20 94 54
            jsr L5323              ; 20 23 53
L5431:      ldy #$E0               ; A0 E0
            lda L00E1              ; A5 E1
            beq L5462              ; F0 2B
            cmp #$01               ; C9 01
            beq L5454              ; F0 19
            cmp #$02               ; C9 02
            beq L5446              ; F0 07
            lda (L00DE),Y          ; B1 DE
            eor #$3F               ; 49 3F
            sta (L00DE),Y          ; 91 DE
L5445:      rts                    ; 60

L5446:      lda (L00DE),Y          ; B1 DE
            eor #$0F               ; 49 0F
            sta (L00DE),Y          ; 91 DE
            iny                    ; C8
            lda (L00DE),Y          ; B1 DE
            eor #$C0               ; 49 C0
            sta (L00DE),Y          ; 91 DE
            rts                    ; 60

L5454:      lda (L00DE),Y          ; B1 DE
            eor #$03               ; 49 03
            sta (L00DE),Y          ; 91 DE
            iny                    ; C8
            lda (L00DE),Y          ; B1 DE
            eor #$F0               ; 49 F0
            sta (L00DE),Y          ; 91 DE
            rts                    ; 60

L5462:      lda (L00DE),Y          ; B1 DE
            eor #$FC               ; 49 FC
            sta (L00DE),Y          ; 91 DE
            rts                    ; 60

L5469:      cmp #$07               ; C9 07
            bne L5473              ; D0 06
            jsr LFD1A              ; 20 1A FD
L5470:      jmp L5431              ; 4C 31 54

L5473:      ldx #$09               ; A2 09
            jsr LFEC5              ; 20 C5 FE
            bne L5470              ; D0 F6

            lda L5300,X            ; BD 00 53
            sta L00E2              ; 85 E2
            lda #>L5300               ; A9 53
            sta L00E3              ; 85 E3
            jsr LFEC1              ; 20 C1 FE
            jmp L5431              ; 4C 31 54

L5489:      jsr L530A              ; 20 0A 53
            lda #$20               ; A9 20
            jsr L5494              ; 20 94 54
            jmp L5431              ; 4C 31 54
L5494:      pha                    ; 48
            and #$1F               ; 29 1F
            sta L00E2              ; 85 E2
            pla                    ; 68
            rol A                  ; 2A
            ldx #$00               ; A2 00
            bcc L54A0              ; 90 01
            dex                    ; CA
L54A0:      stx L0082              ; 86 82
            lsr A                  ; 4A
            lsr A                  ; 4A
            lsr A                  ; 4A
            lsr A                  ; 4A
            lsr A                  ; 4A
            lsr A                  ; 4A
            clc                    ; 18
            adc #(>L5000-1)               ; 69 4F
            sta L00E3              ; 85 E3
            ldy #$00               ; A0 00
            lda L00E1              ; A5 E1
            beq L54EC              ; F0 39
            cmp #$01               ; C9 01
            beq L54F8              ; F0 41
            cmp #$02               ; C9 02
            bne L54DE              ; D0 23
            lda #$0F               ; A9 0F
            sta L0081              ; 85 81
L54BF:      lda (L00E2),Y          ; B1 E2
            lsr A                  ; 4A
            lsr A                  ; 4A
            lsr A                  ; 4A
            lsr A                  ; 4A
            jsr L551B              ; 20 1B 55
            bcc L54BF              ; 90 F5
            inc L00DE              ; E6 DE
            lda #$C0               ; A9 C0
            sta L0081              ; 85 81
L54D0:      lda (L00E2),Y          ; B1 E2
            asl A                  ; 0A
            asl A                  ; 0A
            asl A                  ; 0A
            asl A                  ; 0A
            jsr L551B              ; 20 1B 55
            bcc L54D0              ; 90 F5
            dec L00DE              ; C6 DE
            rts                    ; 60
L54DE:      lda #$3F               ; A9 3F
            sta L0081              ; 85 81
L54E2:      lda (L00E2),Y          ; B1 E2
            lsr A                  ; 4A
            lsr A                  ; 4A
            jsr L551B              ; 20 1B 55
            bcc L54E2              ; 90 F7
            rts                    ; 60
L54EC:      lda #$FC               ; A9 FC
            sta L0081              ; 85 81
L54F0:      lda (L00E2),Y          ; B1 E2
            jsr L551B              ; 20 1B 55
            bcc L54F0              ; 90 F9
            rts                    ; 60
L54F8:      lda #$03               ; A9 03
            sta L0081              ; 85 81
L54FC:      lda (L00E2),Y          ; B1 E2
            lsr A                  ; 4A
            lsr A                  ; 4A
            lsr A                  ; 4A
            lsr A                  ; 4A
            lsr A                  ; 4A
            lsr A                  ; 4A
            jsr L551B              ; 20 1B 55
            bcc L54FC              ; 90 F3
            inc L00DE              ; E6 DE
            lda #$F0               ; A9 F0
            sta L0081              ; 85 81
L550F:      lda (L00E2),Y          ; B1 E2
            asl A                  ; 0A
            asl A                  ; 0A
            jsr L551B              ; 20 1B 55
            bcc L550F              ; 90 F7
            dec L00DE              ; C6 DE
            rts                    ; 60
L551B:      jsr L552E              ; 20 2E 55
            lda L0081              ; A5 81
            eor #$FF               ; 49 FF
            and (L00DE),Y          ; 31 DE
            ora L0080              ; 05 80
            sta (L00DE),Y          ; 91 DE
            clc                    ; 18
            tya                    ; 98
            adc #$20               ; 69 20
            tay                    ; A8
            rts                    ; 60

L552E:      bit L008F              ; 24 8F
            bpl L5534              ; 10 02
            eor #$FF               ; 49 FF
L5534:      eor L0082              ; 45 82
            and L0081              ; 25 81
            sta L0080              ; 85 80
            rts                    ; 60

L553B:      lda #$00               ; A9 00
            sta L0082              ; 85 82
            jsr L5552              ; 20 52 55
            tay                    ; A8
            bne L5551              ; D0 0C
            dec L0082              ; C6 82
            jsr L5552              ; 20 52 55
            tay                    ; A8
            bne L554F              ; D0 02
            lda #$BF               ; A9 BF
L554F:      eor #$80               ; 49 80
L5551:      rts                    ; 60

L5552:      lda #>L5000               ; A9 50
            ldy #<L5000               ; A0 00
            sta L00E3              ; 85 E3
            sty L00E2              ; 84 E2
            lda L00E1              ; A5 E1
            beq L5587              ; F0 29
            cmp #$01               ; C9 01
            beq L559C              ; F0 3A
            cmp #$02               ; C9 02
            beq L55D2              ; F0 6C
            lda #$3F               ; A9 3F
            sta L0081              ; 85 81
L556A:      lda (L00E2),Y          ; B1 E2
            lsr A                  ; 4A
            lsr A                  ; 4A
            jsr L5608              ; 20 08 56
            bne L5581              ; D0 0E
            bcc L556A              ; 90 F5
L5575:      lda L00E3              ; A5 E3
            sbc #$4F               ; E9 4F
            asl A                  ; 0A
            asl A                  ; 0A
            asl A                  ; 0A
            asl A                  ; 0A
            asl A                  ; 0A
            ora L00E2              ; 05 E2
            rts                    ; 60
L5581:      jsr L5621              ; 20 21 56
            bcc L556A              ; 90 E4
            rts                    ; 60
L5587:      lda #$FC               ; A9 FC
            sta L0081              ; 85 81
L558B:      lda (L00E2),Y          ; B1 E2
            jsr L5608              ; 20 08 56
            bne L5596              ; D0 04
            bcc L558B              ; 90 F7
            bcs L5575              ; B0 DF
L5596:      jsr L5621              ; 20 21 56
            bcc L558B              ; 90 F0
            rts                    ; 60

L559C:      lda #$03               ; A9 03
            sta L0081              ; 85 81
L55A0:      lda (L00E2),Y          ; B1 E2
            lsr A                  ; 4A
            lsr A                  ; 4A
            lsr A                  ; 4A
            lsr A                  ; 4A
            lsr A                  ; 4A
            lsr A                  ; 4A
            jsr L5608              ; 20 08 56
            bne L55C8              ; D0 1B
            bcc L55A0              ; 90 F1
            inc L00DE              ; E6 DE
            ldy #$00               ; A0 00
            lda #$F0               ; A9 F0
            sta L0081              ; 85 81
L55B7:      lda (L00E2),Y          ; B1 E2
            asl A                  ; 0A
            asl A                  ; 0A
            jsr L5608              ; 20 08 56
            bne L55CA              ; D0 0A
            bcc L55B7              ; 90 F5
            jsr L5575              ; 20 75 55
            dec L00DE              ; C6 DE
            rts                    ; 60
L55C8:      inc L00DE              ; E6 DE
L55CA:      jsr L5621              ; 20 21 56
            dec L00DE              ; C6 DE
            bcc L559C              ; 90 CB
            rts                    ; 60

L55D2:      lda #$0F               ; A9 0F
            sta L0081              ; 85 81
L55D6:      lda (L00E2),Y          ; B1 E2
            lsr A                  ; 4A
            lsr A                  ; 4A
            lsr A                  ; 4A
            lsr A                  ; 4A
            jsr L5608              ; 20 08 56
            bne L55FE              ; D0 1D
            bcc L55D6              ; 90 F3
            inc L00DE              ; E6 DE
            ldy #$00               ; A0 00
            lda #$C0               ; A9 C0
            sta L0081              ; 85 81
L55EB:      lda (L00E2),Y          ; B1 E2
            asl A                  ; 0A
            asl A                  ; 0A
            asl A                  ; 0A
            asl A                  ; 0A
            jsr L5608              ; 20 08 56
            bne L5600              ; D0 0A
            bcc L55EB              ; 90 F3
            jsr L5575              ; 20 75 55
            dec L00DE              ; C6 DE
            rts                    ; 60

L55FE:      inc L00DE              ; E6 DE
L5600:      jsr L5621              ; 20 21 56
            dec L00DE              ; C6 DE
            bcc L55D2              ; 90 CB
            rts                    ; 60

L5608:      jsr L552E              ; 20 2E 55
            lda (L00DE),Y          ; B1 DE
            cpy #$E0               ; C0 E0
            bcc L5613              ; 90 02
            eor L0081              ; 45 81
L5613:      and L0081              ; 25 81
            eor L0080              ; 45 80
            sta L0080              ; 85 80
            tya                    ; 98
            clc                    ; 18
            adc #$20               ; 69 20
            tay                    ; A8
            lda L0080              ; A5 80
            rts                    ; 60

L5621:      ldy #$00               ; A0 00
            inc L00E2              ; E6 E2
            lda L00E2              ; A5 E2
            cmp #$20               ; C9 20
            bcc L5636              ; 90 0B
            sty L00E2              ; 84 E2
            inc L00E3              ; E6 E3
            lda L00E3              ; A5 E3
            cmp #>L5300               ; C9 53
            bcc L5636              ; 90 01
            tya                    ; 98
L5636:      rts                    ; 60

;--------------------------------------------
; Read vector #20A
;--------------------------------------------

L5637:      php                    ; 08
            cld                    ; D8
            stx L00E4              ; 86 E4
            sty L00E5              ; 84 E5
            jsr LFE71              ; 20 71 FE
            bcc L564D              ; 90 0B
L5642:      ldx #$19               ; A2 19
            stx L00DC              ; 86 DC
L5646:      jsr LFE71              ; 20 71 FE
            bcs L5646              ; B0 FB
            bcc L5665              ; 90 18
L564D:      dec L00DC              ; C6 DC
            beq L565B              ; F0 0A
            jsr LFE66              ; 20 66 FE
            jsr LFE71              ; 20 71 FE
            bcs L5642              ; B0 E9
            bcc L564D              ; 90 F2
L565B:      inc L00DC              ; E6 DC
            bit LB002              ; 2C 02 B0
            bvc L5665              ; 50 03
            jsr LFB8A              ; 20 8A FB
L5665:      jsr LFE66              ; 20 66 FE
            tya                    ; 98

            cmp #$06               ; left-right
            beq L5683              ; F0 16

            cmp #$07               ; up-down
            beq L5683              ; F0 12

            cmp #$0E               ; COPY
            beq L5678              ; F0 03
L5675:      jmp LFEB2              ; 4C B2 FE

; Copy

L5678:      ldy LB000              ; AC 00 B0
            bpl L5675              ; 10 F8
            jsr L553B              ; 20 3B 55
            jmp LFE60              ; 4C 60 FE

; Cursor keys

L5683:      and #$05               ; 29 05
            rol LB001              ; 2E 01 B0
            rol A                  ; 2A
            jmp LFE60              ; 4C 60 FE

L568C:      lda #$40               ; A9 40
            eor L008F              ; 45 8F
            sta L008F              ; 85 8F

L5692:      cpy #$00               ; C0 00
            bne L5698              ; D0 02
            sty L0053              ; 84 53
L5698:      jsr L5637              ; 20 37 56

            cmp #$7F               ; Backspace
            beq L56CE              ; F0 2F

            cmp #$20               ; Copy
            bcs L56C1              ; B0 1E

            cmp #$1B               ; Escape
            beq L56CD              ; F0 26

            cmp #$18               ; CTRL-8
            beq L56D9              ; F0 2E

            cmp #$0D               ; Return
            beq L56CD              ; F0 1E

            cmp #$11               ; CTRL-1
            beq L56E2              ; F0 2F

            cmp #$12               ; CTRL-2
            beq L56F3              ; F0 3C

            cmp #$16               ; CTRL-6
            beq L568C              ; F0 D1

            jsr LFFF4              ; 20 F4 FF

L56BE:      jmp L5692              ; 4C 92 56

; Space

L56C1:      bit L008F              ; 24 8F
            bvc L56C7              ; 50 02
            eor #$80               ; 49 80
L56C7:      cpy #$80               ; C0 80
            bcs L56CD              ; B0 02
            inc L0052              ; E6 52

; Escape

L56CD:      rts                    ; 60

; Backspace

L56CE:      cpy #$00               ; C0 00
            beq L56CD              ; F0 FB
            cpy #$81               ; C0 81
            bcs L56CD              ; B0 F7
            dec L0052              ; C6 52
            rts                    ; 60
L56D9:      ldy L0053              ; A4 53
            beq L56DF              ; F0 02
            ldy #$40               ; A0 40
L56DF:      sty L0052              ; 84 52
            rts                    ; 60

L56E2:      ldy #$00               ; A0 00
L56E4:      lda L0100,Y            ; B9 00 01
            cmp #$0D               ; C9 0D
            beq L56BE              ; F0 D3
            jsr LFFF4              ; 20 F4 FF
            iny                    ; C8
            bne L56E4              ; D0 F3
            beq L56BE              ; F0 CB

; Switch VDU32/40 without clearing screen

L56F3:      lda LB000              ; AD 00 B0
            eor #$F0               ; 49 F0
            sta LB000              ; 8D 00 B0
            jmp L5692              ; 4C 92 56

;--------------------------------------------
; Init entry
;--------------------------------------------

L56FE:
            ldy #$03               ; A0 03
L5700:      lda L5715,Y            ; B9 15 57
            sta L0208,Y            ; 99 08 02
            dey                    ; 88
            bpl L5700              ; 10 F7

            iny                    ; C8
            sty L008F              ; 84 8F

            lda #$18               ; A9 18
            sta L008D              ; 85 8D
            lda #$1E               ; A9 1E
            sta L008E              ; 85 8E

	lda #$14		; Switch to VDU40x24
	jsr LFFF4
	lda #$1b		; Execute ESCAPE
	jsr LFFF4

            rts                    ; 60

L5715:      .word L53D2,L5637

            lda #$18               ; A9 18
            sta L023D              ; 8D 3D 02
            lda #$1E               ; A9 1E
            sta L023E              ; 8D 3E 02
            rts                    ; 60

            .byte $D9,$53,$9D,$56,$50,$2E,$24,$31
            .byte $32,$20,$3B,$50,$2E,$22,$20,$20
            .byte $20,$20,$20,$20,$20,$20,$80,$64
            .byte $69,$73,$6B,$80,$74,$6F,$80,$64
            .byte $69,$73,$6B,$80,$22,$20,$0D,$00
            .byte $1E,$46,$3D,$3F,$31,$38,$2A,$32
            .byte $35,$36,$2B,$31,$3B,$44,$4F,$46
            .byte $3D,$46,$2B,$4C,$2E,$28,$46,$2B
            .byte $32,$29,$2B,$33,$3B,$55,$2E,$46
            .byte $3F,$32,$3D,$43,$48,$22,$66,$22
            .byte $3B,$46,$3D,$46,$2B,$33,$3B,$58
            .byte $3D,$46,$0D,$00,$28,$24,$58,$3D
            .byte $22,$2A,$4C,$4F,$41,$44,$22,$22
            .byte $22,$3B,$58,$3D,$58,$2B,$4C,$2E
            .byte $58,$0D,$00,$32,$50,$2E,$27,$27
            .byte $27,$22,$3C,$43,$52,$3E,$20,$3D
            .byte $20,$41,$42,$4F,$52,$54,$22,$0D
            .byte $00,$3C,$4C,$49,$2E,$23,$45,$30
            .byte $30,$30,$3B,$2A,$4E,$4F,$4D,$4F
            .byte $4E,$0D,$00,$46,$49,$4E,$2E,$27
            .byte $22,$46,$49,$4C,$45,$20,$4E,$41
            .byte $4D,$45,$22,$24,$58,$3B,$49,$46
            .byte $3F,$58,$3D,$23,$30,$44,$20,$3B
            .byte $21,$46,$3D,$23,$46,$46,$30,$44
            .byte $3B,$50,$2E,$24,$31,$32,$3B,$45
            .byte $2E,$0D,$00,$50,$47,$4F,$53,$2E
            .byte $61,$0D,$00,$5A,$47,$4F,$53,$2E
            .byte $66,$3B,$50,$FF
