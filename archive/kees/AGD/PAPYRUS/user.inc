; Copy logo onto titlescreen

	lda #<data
	sta label+1
	lda #>data
	sta label+2

	lda #<$8208
	sta label1+1
	lda #>$8208
	sta label1+2

	ldy #0
plotline:
	ldx #0
label:
	lda data
label1:
	sta $8000,x
	inc label+1
	bne :+
	inc label+2
:
	inx
	cpx #$11
	bne label
	clc
	lda label1+1
	adc #$20
	sta label1+1
	bcc :+
	inc label1+2
:
	iny
	cpy #58
	bne plotline
	rts
                                                                                                                             data:
	.byte $9F,$FB,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.byte $EF,$FD,$80,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.byte $FF,$FF,$C0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.byte $FF,$FF,$C0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.byte $FF,$FF,$E0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
	.byte $FF,$FF,$E0,$F0,$7F,$FF,$3C,$3,$C3,$FF,$F0,$1C,$1,$C0,$1F,$80,$0
	.byte $FE,$F,$E3,$FC,$7D,$FF,$9E,$7,$EF,$FF,$F8,$3E,$3,$E0,$7F,$E0,$0
	.byte $FE,$F,$EF,$FF,$7D,$FF,$DF,$F,$EF,$FF,$FC,$7F,$7,$F1,$FF,$F8,$0
	.byte $FE,$3,$EF,$FF,$BA,$FF,$EF,$F,$EF,$FF,$FE,$7F,$7,$F3,$FF,$FC,$0
	.byte $7E,$F,$EF,$FF,$BF,$FF,$EF,$F,$EF,$FF,$FE,$7F,$7,$F7,$FF,$FE,$0
	.byte $7F,$FF,$EF,$FF,$DF,$FF,$EF,$B,$EF,$FF,$FE,$7F,$7,$F7,$FF,$C7,$0
	.byte $BF,$FF,$EF,$FF,$DF,$83,$EF,$7,$EF,$E0,$FE,$7D,$7,$F7,$FF,$F7,$0
	.byte $FF,$FF,$AF,$FF,$EF,$FF,$EF,$7,$EF,$FF,$FE,$7E,$7,$F7,$FF,$FB,$0
	.byte $FF,$FF,$AF,$1F,$EF,$FF,$EF,$7,$EF,$FF,$FE,$7C,$5,$F7,$E0,$FB,$0
	.byte $FF,$FF,$2E,$F,$EF,$FF,$CF,$7,$EF,$FF,$FE,$7D,$5,$F7,$C0,$FF,$0
	.byte $FF,$FC,$4E,$F,$EF,$FF,$DF,$F,$EF,$FF,$FE,$7F,$5,$F7,$0,$FE,$0
	.byte $FF,$FC,$9E,$F,$EE,$FF,$9F,$F,$EF,$FE,$FE,$7F,$5,$F7,$1,$FE,$0
	.byte $FE,$FF,$3E,$F,$EE,$7F,$BF,$F,$EF,$7E,$7C,$7F,$5,$F7,$0,$FC,$0
	.byte $FE,$FF,$7F,$FF,$EF,$7F,$BF,$9F,$EF,$7F,$7C,$7F,$7,$F7,$0,$FC,$0
	.byte $FF,$0,$FF,$FF,$EF,$7F,$7F,$9F,$EE,$FE,$F8,$7F,$7,$F7,$0,$F8,$0
	.byte $FF,$1,$FF,$FF,$CF,$80,$7F,$FF,$CF,$3F,$F8,$7F,$7,$F7,$0,$78,$0
	.byte $DF,$1,$FF,$FF,$AF,$80,$3F,$FF,$CF,$DF,$FC,$7F,$7,$F7,$80,$30,$0
	.byte $BF,$1,$FF,$FF,$EF,$80,$3F,$FF,$CF,$E3,$FE,$7F,$7,$F7,$80,$0,$0
	.byte $BF,$1,$FE,$BF,$EF,$80,$1F,$EF,$CF,$E1,$7F,$7F,$7,$F7,$80,$0,$0
	.byte $BF,$1,$FE,$3F,$ED,$80,$F,$E7,$CF,$E0,$3F,$3F,$7,$F7,$80,$0,$0
	.byte $BF,$0,$FE,$F,$EC,$80,$7,$E7,$CF,$E0,$3F,$9F,$7,$F7,$C0,$0,$0
	.byte $BF,$0,$FE,$F,$EE,$80,$0,$F,$CB,$E0,$3F,$CF,$7,$F7,$F0,$0,$0
	.byte $BF,$0,$FE,$F,$EF,$80,$0,$F,$C3,$E0,$17,$EF,$7,$F7,$FF,$E0,$0
	.byte $BF,$0,$FE,$F,$EF,$80,$0,$1F,$C7,$E0,$17,$EF,$7,$F7,$FF,$F0,$0
	.byte $DF,$1,$7E,$F,$EF,$80,$0,$1F,$CB,$E0,$B,$EF,$7,$F7,$FF,$FC,$0
	.byte $FF,$1,$FE,$F,$EF,$80,$0,$1F,$CF,$E0,$F,$EF,$7,$F7,$FF,$FE,$0
	.byte $FF,$1,$FE,$F,$EF,$80,$0,$3F,$CF,$E0,$F,$EF,$8F,$D7,$FF,$FF,$0
	.byte $FF,$1,$FE,$F,$EF,$80,$FF,$FF,$CF,$E0,$F,$EF,$FF,$E3,$FF,$FF,$80
	.byte $FF,$1,$FE,$F,$EF,$81,$FF,$FF,$CF,$E0,$F,$CF,$FF,$E0,$7F,$FB,$80
	.byte $AF,$1,$FE,$F,$EF,$81,$EB,$FF,$CF,$E0,$F,$CF,$FF,$E0,$0,$F9,$80
	.byte $8F,$1,$FE,$F,$EF,$83,$E3,$FF,$8F,$E0,$F,$EF,$FF,$E0,$0,$79,$80
	.byte $CF,$0,$FE,$F,$EF,$83,$F3,$FD,$7,$E0,$F,$EE,$DF,$C0,$0,$7B,$80
	.byte $6E,$0,$7C,$7,$CF,$1,$FB,$FC,$3,$E0,$7,$C6,$1F,$80,$0,$FF,$0
	.byte $3C,$0,$38,$3,$9E,$0,$FF,$FC,$1,$C0,$3,$83,$3F,$0,$0,$FF,$0
	.byte $3C,$0,$38,$3,$BE,$0,$FF,$FC,$1,$C0,$3,$83,$FF,$0,$1,$FF,$0
	.byte $7,$3,$7,$7,$3,$0,$7,$0,$0,$0,$0,$0,$0,$0,$3,$FE,$0
	.byte $3,$7,$3,$3,$13,$C,$B,$0,$0,$0,$0,$0,$0,$0,$7,$FC,$0
	.byte $17,$23,$17,$17,$23,$18,$13,$0,$0,$0,$0,$0,$0,$0,$F,$FC,$0
	.byte $2B,$63,$2B,$2B,$23,$0,$30,$0,$0,$F,$FF,$FF,$FF,$FF,$FF,$F8,$0
	.byte $2B,$23,$2B,$2B,$1F,$0,$3E,$0,$0,$1B,$FF,$FF,$FF,$FF,$FF,$F0,$0
	.byte $23,$23,$23,$23,$3,$0,$2,$0,$0,$13,$FF,$FF,$FF,$FF,$FF,$F0,$0
	.byte $23,$23,$23,$23,$2,$0,$2,$0,$0,$37,$FF,$FF,$FF,$FF,$FF,$60,$0
	.byte $23,$16,$23,$23,$4,$0,$24,$0,$0,$10,$0,$0,$20,$22,$54,$40,$0
	.byte $0,$0,$0,$20,$18,$0,$38,$0,$0,$F,$FF,$FF,$FF,$FF,$FF,$80,$0
	.byte $0,$0,$0,$0,$18,$0,$18,$0,$18,$0,$0,$0,$0,$0,$0,$0,$0
	.byte $0,$0,$0,$40,$58,$50,$58,$50,$98,$0,$0,$0,$0,$0,$0,$0,$0
	.byte $0,$0,$0,$80,$80,$98,$98,$99,$18,$0,$0,$0,$0,$0,$0,$0,$0
	.byte $0,$0,$1,$1,$61,$1,$19,$1,$18,$0,$0,$0,$0,$0,$0,$0,$0
	.byte $0,$0,$1,$3,$E1,$1,$19,$0,$F8,$0,$0,$0,$0,$0,$0,$0,$0
	.byte $0,$0,$1,$1,$61,$7B,$F9,$0,$18,$0,$0,$0,$0,$0,$0,$0,$0
	.byte $0,$0,$1,$1,$1,$19,$19,$0,$10,$0,$0,$0,$0,$0,$0,$0,$0
	.byte $0,$0,$1,$19,$19,$11,$19,$11,$20,$0,$0,$0,$0,$0,$0,$0,$0
	.byte $0,$0,$3,$fb,$f8,$f3,$1c,$f0,$c0,$0,$0,$0,$0,$0,$0,$0,$0
