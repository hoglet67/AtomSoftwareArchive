Width = 32
UpperCaseOnly=0

        org     $2800 - 22

.STARTOFHEADER

	EQUS	"QLLC32"

include "QUILLINT.ASM"

SAVE "QLLC32",STARTOFHEADER, ENDOF
