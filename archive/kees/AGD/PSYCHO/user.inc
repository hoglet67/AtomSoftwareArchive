; Invert screen from #8b00-#97FF

	lda #>$8b00
	sta label+2
	sta label1+2

	ldx #13
invline:
	ldy #0
label:
	lda $8b00,y
	eor #$ff
label1:
	sta $8b00,y
	iny
	bne label

	inc label+2
	inc label1+2
	dex
	bne invline
	rts
                                                                                                                             