;----------------------------------------------
;DOWNFALL
; Atom game conversion by Kees van Oss 2012
;----------------------------------------------
asm_code = $8200
header = 0		; Header Wouter Ras emulator

org (asm_code-22*header)

.start

IF header
;********************************************************************
; ATM Header for Atom emulator Wouter Ras

	EQUS "SIDMENU"			; Filename
	EQUB 0,0,0,0,0,0,0,0,0
	EQUW asm_code			; 2 bytes startaddress
	EQUW exec			; 2 bytes linkaddress
	EQUW end_asm-start_asm		; 2 bytes filelength

;********************************************************************
ENDIF

.start_asm
include "menu.inc"
.end_asm

.end

SAVE "SIDMENU", start, end
