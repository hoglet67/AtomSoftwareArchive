jmp main

;--------------------------------------------
; VARIABLES
;--------------------------------------------

.line_ptr	EQUS 0		; Pointer in menu
.highlight	EQUS 0		; Linenr to be highlighted
.invert		EQUS 0		; Invert flag
.y_tmp		EQUS 0		; Temp y-storage
.x_tmp		EQUS 0		; Temp x-storeage
.scr_ptr	EQUS 0		; Temp menu screen pointer
.old_nomon      EQUS 0          ; Store old NOMON flag (#ea)
.old_irq	EQUS 0,0	; Store old IRQ vec

load_param	= $80		; File load pointers

workspace       = $90		; Start of the zero page workspace used by the menu
workspace_size  = $08		; Size of the zero page workspace used by the menu PLUS ONE as #FF saved in the last location

scr_adr		= $90		; Pointer
max_files       = $92           ; Max Files
cursor		= $93
row_lb		= $94
row_hb		= $95
linepos		= $96

x_min		= 1		; x-pos menu
y_min		= 5		; y-pos menu
scr_max		= 8 		; 8 lines in menu

key_up		= $3a		; Z
key_down	= $21		; A
key_action	= $0		; Space
key_esc		= $3b		; ESC

oscli		= $fff7

sid_reg         = $9700

;--------------------------------------------
; MAIN
;
; Main entry program
;--------------------------------------------

.main
	sei
	lda $204		; Save old IRQ vector
	sta old_irq
	lda $205
	sta old_irq+1

	lda $ea			; Save the old NOMON flag
	sta old_nomon
	lda #255		; Disable the NOMON flag
	sta $ea

	jsr save_zero		; Save the zero page, in case a SID messes stuff up

	lda #0			; Init vars
	sta line_ptr
	sta highlight
	sta cursor
	sta $4c6		; ABBA SOS and Knowing Me Knowing You use
				; 4c6 b2..0 as channel disable

				; Determine the number of titles at run time
	tay
.numfiles
	lda  txt_ptr + 1,y
	beq  numfilesend
	iny
	iny
	bne numfiles
.numfilesend
	tya
	lsr a
	sta max_files


	jsr scr_layout		; Display screen layout

.main_loop
	 jsr print_menu		; Display menu


.update
	  lda cursor		; Display slider at $C0/2
	  lsr a
	  jsr print_slider

	  jsr print_timer	; Display timer

.chk_up
	  jsr $fe71
	  cpy #key_up
	  bne chk_down		; Check CTRL pressed

	   jsr $fb8a		; Wait 0,1 sec

	   lda max_files
	   sec
	   sbc #1
	   cmp highlight       	; Check last filename
	   beq chk_up

	   sec
	   lda highlight
	   sbc line_ptr
	   cmp #scr_max-1	; Check bottom
	   beq chk_end_up

	   inc highlight	; Within menu
	   jmp main_loop
.chk_end_up
	   inc highlight
	   inc line_ptr
	   jmp main_loop

.chk_down
	  jsr $fe71
	  cpy #key_down
	  bne chk_action	; Check CTRL pressed

	   jsr $fb8a		; Wait 0,1 sec

	   lda highlight	; Check first file
	   beq chk_up

	   cmp line_ptr		; Check top
	   beq chk_end_down

	   dec highlight	; Within menu
	   jmp main_loop
.chk_end_down
	   dec highlight
	   dec line_ptr
	   jmp main_loop

.chk_action
	  jsr $fe71		; Check SPACE pressed
	   cpy #key_action
	   beq play_song
.chk_esc
	  cpy #key_esc		; Check ESC pressed
	   beq end_prog

	  lda $205		; If nomusic, skip slider+timer
	   cmp old_irq+1
	   bne update
	   jmp chk_up

.end_prog
	jsr restore_irq		; Restore IRQ vec
	jsr resetSID		; Reset SID sound

	jsr restore_zero	; Restore the original page zero

	lda old_nomon		; Restore the NOMON flag
	sta $ea

	lda #12			; Clear screen
	jmp $fff4

;--------------------------------------------
; PLAY_SONG
;
; Play song depending on selection
;--------------------------------------------

.play_song			; SPACE pressed

	jsr resetSID
	jsr restore_irq		; Restore IRQ vec

	lda #0			; Reset slider
	sta cursor
	jsr print_slider

	lda #'0'		; Reset timer
	sta timer
	sta timer+1
	sta timer+3
	sta timer+4

	lda highlight		; Set pointer to songdata
	asl a
	tay
	lda txt_ptr,y
	sta scr_adr
	lda txt_ptr+1,y
	sta scr_adr+1

	clc			; Set LOAD name
	lda scr_adr
	adc #37
	sta load_param
	lda scr_adr+1
	adc #0
	sta load_param+1

;	ldy #31			; Set LOAD address
;	lda (scr_adr),y
;	sta load_param+2
;	sta load_param+4
;	iny			; Set EXEC address
;	lda (scr_adr),y
;	sta load_param+3
;	sta load_param+5

	ldy #0
.init_loop
	lda (load_param),y
	sta $100,y
	iny
	cmp #$0d
	bne init_loop

	jsr restore_zero

	jsr oscli

	jsr save_zero

.init_wait
	ldx #60
	jsr $fb83		; Wait 1 sec

	ldy #33			; Set init SID routine
	lda (scr_adr),y
	sta init_ptr+1
	iny
	lda (scr_adr),y
	sta init_ptr+2

	iny			; Set init SID routine
	lda (scr_adr),y
	sta play_ptr+1
	iny
	lda (scr_adr),y
	sta play_ptr+2

	jsr initIRQ		; Init SID and IRQ

	jmp update		; Play song

;--------------------------------------------
; PRINT_MENU
;
; Print menu and invert selected line
;--------------------------------------------

.print_menu
	lda #0			; Set temp screen pointer menu
	sta scr_ptr

.print_loop
	lda #0			; Reset invert flag
	sta invert

	clc			; Calculate data pointer
	lda line_ptr
	adc scr_ptr

	cmp max_files		; If >=maxfiles, print empty line
	bcc chk_invert

	lda #<empty_line	; Set empty line pointer
	sta scr_adr
	lda #>empty_line
	sta scr_adr+1
	jmp go_prt

.chk_invert
	cmp highlight		; Check to invert string
	bne not_inv
	ldx #$80
	stx invert
.not_inv
	asl a			; Calculate data address
	tay
	lda txt_ptr,y
	sta scr_adr
	lda txt_ptr+1,y
	sta scr_adr+1
.go_prt
	clc			; Cursor at x,y+5
	lda scr_ptr
	adc #y_min
	tay
	ldx #x_min
	jsr goto_xy

	jsr prt_line		; Print line

	inc scr_ptr		; Point to next line
	lda scr_ptr
	cmp #scr_max		; If not end of menu screen, next
	bne print_loop
.print_end
	lda #0			; Reset invert flag
	sta invert
	rts

.empty_line
	EQUS "                              ",0

;--------------------------------------------
; PRINT_SLIDER A
;
; Print play slider, 25 ticks/sec
;--------------------------------------------

.print_slider
	pha			; Save slider pos

	ldx #1			; Goto slider 1,14
	ldy #14
	jsr goto_xy

	lda #<slider		; Point to sliderdata
	sta scr_adr
	lda #>slider
	sta scr_adr+1
	jsr prt_line		; Print line

	pla			; Print slider pos
	tax
	inx
	ldy #14
	jsr goto_xy
	lda #111		; Slider block
	jsr prt_chr

	rts

.slider
	EQUS "-------------------------",0

;--------------------------------------------
; PRINT_TIMER
;
; Print timer xx:xx at 26,15
;--------------------------------------------

.print_timer
	ldx #26			; Cursor to 26,14
	ldy #14
	jsr goto_xy

	lda #<timer		; Set timer data
	sta scr_adr
	lda #>timer
	sta scr_adr+1
	jsr prt_line		; Print timer

	rts

.timer
	EQUS "00:00",0

;--------------------------------------------
; GOTOXY X,Y
;
; Cursor to pos X,Y
;--------------------------------------------

.goto_xy
	sty row_hb		; set row address
	lda #0
	sta row_lb
	lsr row_hb
	ror row_lb
	lsr row_hb
	ror row_lb
	sec
	ror row_hb
	ror row_lb

	stx linepos		; Set column address

	rts

;--------------------------------------------
; PRT_CHR A
;
; Convert ASCII code to SCREEN code
; Print ASCII character A at cursorpos
; and increment X-pointer
;--------------------------------------------

.prt_chr			; Convert ASCII->SCREEN code
	cmp #32			; <32 CTRL-code so skip
	bcc prt_end

	cmp #64			; 32-63 -> SCR = ASCII
	bcs chk2
	jmp no_change
.chk2
	cmp #96			; 64-95 -> SCR = ASCII-64
	bcs chk3
	sec
	sbc #64
	jmp no_change
.chk3
	cmp #160		; 96-159 -> SCR = ASCII+32
	bcs prt_end
	clc
	adc #32

.no_change
	clc			; Invert char if set
	adc invert

	sty y_tmp		; Save y

	ldy linepos		; Put char on screen
	sta (row_lb),y
	inc linepos		; Increment x

	ldy y_tmp		; Restore y
.prt_end
	rts


;--------------------------------------------
; PRT_LINE at X,Y
;
; Print line pointed to in X,Y
;--------------------------------------------

.prt_line
	sty y_tmp		; Save Y
	jsr $fe66

	ldy #0			; Print string
.next_char
	lda (scr_adr),y
	beq string_end
	jsr prt_chr
	iny
	jmp next_char

.string_end
	ldy y_tmp		; Restore Y
	rts

;--------------------------------------------
; INITIRQ
;
; Initialize IRQ vector + timer
; 50 Hz = 1.000.000 / 50 = 20.000 usec
;--------------------------------------------

irqtime	= 20000

.initIRQ
	sei

	jsr resetSID		; Reset SID

	lda #>irqvec		; Set IRQ vec
	sta $205
	lda #<irqvec
	sta $204

	lda #<(irqtime)		; Set IRQ timer
	sta $b804
	lda #>(irqtime)
	sta $b805

	lda $b80b		; Continuous IRQ on T1
	and #$7f
	ora #$40
	sta $b80b

	lda #$c0		; Enable T1-IRQ
	sta $b80e

	lda #0			; Init SID player
	tax
	tay

.init_ptr
	jsr prt_end		; SID init

	jsr save_zero_sid
	cli
	rts

;--------------------------------------------
; RESTORE_IRQ
;--------------------------------------------

.restore_irq
	sei
	lda #$40			; Enable T1-IRQ
	sta $b80e
	lda #<$a000			; Reset IRQ vector
	sta $204
	lda #>$a000
	sta $205
	cli
	rts

;--------------------------------------------
; IRQVEC
;
; New IRQ vector, jumps to play SID routine
;--------------------------------------------

.irqvec
	lda $b804		; Clear IRQ flag
	txa
	pha
	tya
	pha

	inc cursor		; Increment slider pointer
	lda cursor
	cmp #51
	bne play_swap

	lda #0
	sta cursor

	inc timer+4		; Update timer
	lda timer+4
	cmp #':'
	bne play_swap
	lda #'0'
	sta timer+4

	inc timer+3
	lda timer+3
	cmp #'6'
	bne play_swap
	lda #'0'
	sta timer+3

	inc timer+1
	lda timer+1
	cmp #':'
	bne play_swap
	lda #'0'
	sta timer+1

	inc timer+0
	lda timer+0
	cmp #'6'
	bne play_swap
	lda #'0'
	sta timer+0

.play_swap
	jsr swap_zero_atom_to_sid

.play_ptr
	jsr prt_end		; SID IRQ entry

	jsr swap_zero_sid_to_atom

	jsr update_vu

	pla
	tay
	pla
	tax
	pla
	rti

;--------------------------------------------------
;RESETSID
;
; Reset SID registers so there will be no sound
;--------------------------------------------------

SID	= $bdc0

.resetSID
      ldx #$1F               ; Reg pointer
      lda #$00
.L30B5
      sta SID,X              ; Clear reg
      dex
      bpl L30B5
      rts

;--------------------------------------------------
;SAVE_ZERO_PAGE
;
; Save the Zero Page memory block
;--------------------------------------------------


.save_zero_sid
        ldx #(workspace_size - 1)

	lda $ff
	sta tmp_sid,x
	dex

.save_zero_sid1
	lda workspace,x
	sta tmp_sid,x
	dex
	bpl save_zero_sid1
	rts


.swap_zero_atom_to_sid
        ldx #(workspace_size - 1)

	lda $ff
	sta tmp_atom,x
	lda tmp_sid,x
	sta $ff
	dex

.swap_zero_atom_to_sid1
	lda workspace,x
	sta tmp_atom,x
	lda tmp_sid,x
	sta workspace,x
	dex
	bpl swap_zero_atom_to_sid1
	rts


.swap_zero_sid_to_atom
        ldx #(workspace_size - 1)

	lda $ff
	sta tmp_sid,x
	lda tmp_atom,x
	sta $ff
	dex

.swap_zero_sid_to_atom1
	lda workspace,x
	sta tmp_sid,x
	lda tmp_atom,x
	sta workspace,x
	dex
	bpl swap_zero_sid_to_atom1
	rts


.save_zero
        ldx #$00

.save_zero1
	lda $00,x
	sta tmp_zero,x
	inx
	bne save_zero1
	rts

.restore_zero
        ldx #$00

.restore_zero1
	lda $00,x
	sta tmp_zero,x
	inx
	bne restore_zero1
	rts



;----------------------------------------
; update_vu
;
; Update vu_values and plot vu_meters
;----------------------------------------

.update_vu
	tya		; Save regs
	pha
	txa
	pha

	ldx #2		; Update vu_val according to gatebit
.chk_loop
	ldy vu_ptr,x	; Check gatebit
	lda sid_reg,y
	and #1
	beq vu_decay
	lda #9		; Gatebit=1 -> max value
	sta vu_val,x
	jmp end_vu
.vu_decay
	dec vu_val,x	; Gatebit=0 -> decrement value
	bpl end_vu
	inc vu_val,x
.end_vu
	ldy vu_val,x	; Draw vu_meters
	lda col1,y
	sta $807b,x
	lda col2,y
	sta $805b,x
	lda col3,y
	sta $803b,x
.no_vu
	dex
	bpl chk_loop
.end_chk
	pla		; Restore regs
	tax
	pla
	tay
	rts

.vu_val
	EQUS 0,0,0
.vu_ptr
	EQUS 0,7,14

.col1	EQUS 192,193,197,213,213,213,213,213,213,213
.col2	EQUS 192,192,192,192,193,197,213,213,213,213
.col3	EQUS 192,192,192,192,192,192,192,193,197,213

;------------------------------------------------
; Screen layout
;------------------------------------------------

.scr_layout
	ldy #0
.loop1
	lda scr_data,y
	sta $8000,y		; Display upper half
	lda scr_data+$100,y
	sta $8100,y		; Display lower half
	iny
	bne loop1
	rts

.scr_data
            EQUS $4E,$4C,$4C,$4C,$4C,$4C,$4C,$4C
            EQUS $4C,$4C,$4C,$4C,$4C,$4C,$4C,$4C
            EQUS $4C,$4C,$4C,$4C,$4C,$4C,$4C,$4C
            EQUS $4C,$4C,$4C,$4C,$4C,$4C,$4C,$4D

;            EQUS $6A,$D5,$FA,$F2,$FF,$D5,$F3,$F1
;            EQUS $F7,$D5,$F1,$F2,$F5,$D5,$F1,$F1
;            EQUS $F5,$40,$5F,$7C,$68,$7F,$55,$7E
            EQUS $6A,$D5,$F1,$F2,$FF,$D5,$F1,$F3
            EQUS $F7,$D5,$F1,$F3,$F7,$D5,$F1,$F2
            EQUS $FF,$40,$5F,$7C,$68,$7F,$55,$7E
            EQUS $7D,$4A,$40,$40,$40,$40,$40,$55

;            EQUS $6A,$D5,$E0,$E3,$F5,$D5,$FF,$D0
;            EQUS $FF,$D5,$D5,$FF,$D5,$D5,$D5,$D5
;            EQUS $D5,$40,$7C,$4D,$4A,$7F,$55,$6A
            EQUS $6A,$D5,$D0,$E3,$F5,$D5,$D0,$F3
            EQUS $F7,$D5,$D0,$F3,$F7,$D5,$D0,$E3
            EQUS $F5,$40,$7C,$4D,$4A,$7F,$55,$6A
            EQUS $55,$6A,$40,$40,$40,$40,$40,$55

;            EQUS $6A,$D5,$C3,$FF,$D7,$D5,$FF,$C3
;            EQUS $FF,$D5,$D3,$F3,$D7,$D5,$D7,$D7
;            EQUS $D7,$40,$4F,$5F,$68,$7F,$55,$6F
            EQUS $6A,$D5,$C3,$F3,$D7,$D5,$C3,$F3
            EQUS $F7,$D5,$C3,$F3,$F7,$D5,$C3,$F3
            EQUS $D7,$40,$4F,$5F,$68,$7F,$55,$6F
            EQUS $5F,$68,$40,$40,$40,$40,$40,$55

            EQUS $6E,$4C,$4C,$4C,$4C,$4C,$4C,$4C
            EQUS $4C,$4C,$4C,$4C,$4C,$4C,$4C,$4C
            EQUS $4C,$4C,$4C,$4C,$4C,$4C,$4C,$4C
            EQUS $4C,$4C,$4C,$4C,$4C,$4C,$4C,$5D
            EQUS $6A,$40,$40,$40,$40,$40,$40,$40
            EQUS $40,$40,$40,$40,$40,$40,$40,$40
            EQUS $40,$40,$40,$40,$40,$40,$40,$40
            EQUS $40,$40,$40,$40,$40,$40,$40,$55
            EQUS $6A,$40,$40,$40,$40,$40,$40,$40
            EQUS $40,$40,$40,$40,$40,$40,$40,$40
            EQUS $40,$40,$40,$40,$40,$40,$40,$40
            EQUS $40,$40,$40,$40,$40,$40,$40,$55
            EQUS $6A,$40,$40,$40,$40,$40,$40,$40
            EQUS $40,$40,$40,$40,$40,$40,$40,$40
            EQUS $40,$40,$40,$40,$40,$40,$40,$40
            EQUS $40,$40,$40,$40,$40,$40,$40,$55
            EQUS $6A,$40,$40,$40,$40,$40,$40,$40
            EQUS $40,$40,$40,$40,$40,$40,$40,$40
            EQUS $40,$40,$40,$40,$40,$40,$40,$40
            EQUS $40,$40,$40,$40,$40,$40,$40,$55
            EQUS $6A,$40,$40,$40,$40,$40,$40,$40
            EQUS $40,$40,$40,$40,$40,$40,$40,$40
            EQUS $40,$40,$40,$40,$40,$40,$40,$40
            EQUS $40,$40,$40,$40,$40,$40,$40,$55
            EQUS $6A,$40,$40,$40,$40,$40,$40,$40
            EQUS $40,$40,$40,$40,$40,$40,$40,$40
            EQUS $40,$40,$40,$40,$40,$40,$40,$40
            EQUS $40,$40,$40,$40,$40,$40,$40,$55
            EQUS $6A,$40,$40,$40,$40,$40,$40,$40
            EQUS $40,$40,$40,$40,$40,$40,$40,$40
            EQUS $40,$40,$40,$40,$40,$40,$40,$40
            EQUS $40,$40,$40,$40,$40,$40,$40,$55
            EQUS $6A,$40,$40,$40,$40,$40,$40,$40
            EQUS $40,$40,$40,$40,$40,$40,$40,$40
            EQUS $40,$40,$40,$40,$40,$40,$40,$40
            EQUS $40,$40,$40,$40,$40,$40,$40,$55
            EQUS $6E,$4C,$4C,$4C,$4C,$4C,$4C,$4C
            EQUS $4C,$4C,$4C,$4C,$4C,$4C,$4C,$4C
            EQUS $4C,$4C,$4C,$4C,$4C,$4C,$4C,$4C
            EQUS $4C,$4C,$4C,$4C,$4C,$4C,$4C,$5D
            EQUS $6A,$40,$40,$40,$40,$40,$40,$40
            EQUS $40,$40,$40,$40,$40,$40,$40,$40
            EQUS $40,$40,$40,$40,$40,$40,$40,$40
            EQUS $40,$40,$40,$40,$40,$40,$40,$55

	 EQUS $a0,$81,$bd,$95,$90,$a0,$9a,$bd
	 EQUS $84,$8f,$97,$8e,$a0,$93,$90,$83
	 EQUS $bd,$90,$8c,$81,$99,$a0,$85,$93
	 EQUS $83,$bd,$91,$95,$89,$94,$a0,$a0


.tmp_zero
	skip 256

.tmp_sid
	skip workspace_size

.tmp_atom
	skip workspace_size

.txt_ptr

;
; 	EQUW line1,line2,line3,line4
; 	EQUW line5,line6,line7,line8
; 	EQUW line9,line10,line11,line12
; 	EQUW line13,line14,$0
;
; .line1
; 	EQUS "A. AXEL-F                     ",0
; 	EQUW $1800,$1800,$1806
; 	EQUS "LOAD AXELF",13
; .line2
; 	EQUS "B. BLADERUNNER                ",0
; 	EQUW $1000,$1000,$1003
; 	EQUS "LOAD BLADERU",13
; .line3
; 	EQUS "C. BLUES BROTHERS             ",0
; 	EQUW $1800,$1800,$1806
; 	EQUS "LOAD BLUESBR",13
; .line4
; 	EQUS "D. CHARIOTS OF FIRE           ",0
; 	EQUW $1000,$1000,$1003
; 	EQUS "LOAD CHARIOT",13
; .line5
; 	EQUS "E. GHOSTBUSTERS               ",0
; 	EQUW $1800,$1800,$1806
; 	EQUS "LOAD GHOST",13
; .line6
; 	EQUS "F. GREAT ESCAPE               ",0
; 	EQUW $1000,$1000,$1003
; 	EQUS "LOAD GREATES",13
; .line7
; 	EQUS "G. JUNGLE BOOK                ",0
; 	EQUW $1000,$1000,$1003
; 	EQUS "LOAD JUNGLEB",13
; .line8
; 	EQUS "H. MIDNIGHT EXPRESS           ",0
; 	EQUW $5000,$5000,$5029
; 	EQUS "LOAD MIDNIGH",13
; .line9
; 	EQUS "I. LION KING                  ",0
; 	EQUW $0FF9,$1000,$1003
; 	EQUS "LOAD LIONKIN",13
; .line10
; 	EQUS "J. ROCKY                      ",0
; 	EQUW $1000,$1000,$1003
; 	EQUS "LOAD ROCKY",13
; .line11
; 	EQUS "K. TERMINATOR                 ",0
; 	EQUW $1000,$1000,$1003
; 	EQUS "LOAD TERMINA",13
; .line12
; 	EQUS "L. TITANIC                    ",0
; 	EQUW $6000,$6000,$6003
; 	EQUS "LOAD TITANIC",13
; .line13
; 	EQUS "M. TOP GUN                    ",0
; 	EQUW $1000,$1000,$1003
; 	EQUS "LOAD TOPGUN",13
; .line14
; 	EQUS "N. WIZARD OF OZ               ",0
; 	EQUW $1000,$1000,$1003
; 	EQUS "LOAD WIZARDO",13
