;--------------------------------------------------------
; Subroutines called by SID file to update vu_meter
;--------------------------------------------------------

sid_reg = $9700

.start
	
.sub8c_1:		; JSR (Loadaddress)
	sty $bdc4
	sty sid_reg
	rts
.sub8c_2:		; JSR (Loadaddress + $07)
	sty $bdcb
	sty sid_reg+7
	rts
.sub8c_3:		; JSR (Loadaddress + $0E)
	sty $bdd2
	sty sid_reg+14
	rts
.sub8d_1:		; JSR (Loadaddress + $15)
	sta $bdc4
	sta sid_reg
	rts
.sub8d_2:		; JSR (Loadaddress + $1C)
	sta $bdcb
	sta sid_reg+7
	rts
.sub8d_3:		; JSR (Loadaddress + $23)
	sta $bdd2
	sta sid_reg+14
	rts
.sub8e_1		; JSR (Loadaddress + $2A)
	stx $bdc4
	stx sid_reg
	rts
.sub8e_2		; JSR (Loadaddress + $31)
	stx $bdcb
	stx sid_reg+7
	rts
.sub8e_3		; JSR (Loadaddress + $38)
	stx $bdd2
	stx sid_reg+14
	rts
.sub99			; JSR (Loadaddress + $3F)
	sta $bdc4,y
	sta sid_reg,y
	rts
.sub9d			; JSR (Loadaddress + $46)
	sta $bdc4,x
	sta sid_reg,x
	rts

.end

SAVE "VU", start, end
