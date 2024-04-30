	Base = $3100

include "renderer_header.asm"

	org Base - 22

	guard $3600

.STARTOFHEADER

; 22 byte ATM header

	EQUS    "MENUMC"

	EQUB    $00
	EQUB    $00
	EQUB    $00
	EQUB    $00
	EQUB    $00
	EQUB    $00
	EQUB    $00
	EQUB    $00
	EQUB    $00
	EQUB    $00

	EQUB    <Base
	EQUB    >Base

	EQUB    <Base
	EQUB    >Base

	EQUW	ENDOF - STARTOF

.STARTOF

	JMP WritePage
	JMP Inkey
	JMP HighlightRow
	JMP Search
	JMP UpdateTotalPages

include "renderer_body.asm"


.ENDOF


SAVE "MENUMC",STARTOFHEADER, ENDOF
