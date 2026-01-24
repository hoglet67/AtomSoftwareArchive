	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; Operating System Subroutines
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	PlotDriverLS    = $f6d3
	PlotDriverMS    = $f6d8
	GraphicsCtrl    = $f6dd
	WaitUntilVSync  = $fe66
	Osrdch          = $ffe3
	Oswrch          = $fff4
	Oscli           = $fff7

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; Miscellaneous constants
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	ScreenStart     = $8000

	OscliBuffer     = $100

	CountString     = OscliBuffer

   Return          = $0d

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; Zero page
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

IF (sddos = 1)

	TmpPtr       = $78 ; 2 bytes
	SortTablePtr = $7a ; 2 bytes
	PageState    = $7c ; 1 byte
	NumPages     = $7d ; 1 byte
	Item         = $7e ; 1 byte
	SortType     = $7f ; 1 byte
	FilterType   = $8c ; 1 byte
	FilterString = $8d ; 2 bytes
	AutoRepeat   = $8f ; 1 byte

	ExecAddr     = $9e ; don't change this, it's what SDDOS uses

ELIF (econet = 1)

	TmpPtr       = $78 ; 2 bytes
	SortTablePtr = $7a ; 2 bytes
	PageState    = $7c ; 1 byte
	NumPages     = $7d ; 1 byte
	Item         = $7e ; 1 byte
	SortType     = $7f ; 1 byte
	FilterType   = $8c ; 1 byte
	FilterString = $8d ; 2 bytes
	AutoRepeat   = $8f ; 1 byte

	ExecAddr     = $d0 ; don't change this, it's what ECONET uses

ELIF (gosdc = 1)

	TmpPtr       = $70 ; 2 bytes
	SortTablePtr = $72 ; 2 bytes
	PageState    = $74 ; 1 byte
	NumPages     = $75 ; 1 byte
	Item         = $76 ; 1 byte
	SortType     = $77 ; 1 byte
	FilterType   = $78 ; 1 byte
	FilterString = $79 ; 2 bytes
	AutoRepeat   = $7b ; 1 byte

	ExecAddr     = $d2 ; don't change this, it's what GOSDC uses

ELSE

	TmpPtr       = $70 ; 2 bytes
	SortTablePtr = $72 ; 2 bytes
	PageState    = $74 ; 1 byte
	NumPages     = $75 ; 1 byte
	Item         = $76 ; 1 byte
	SortType     = $77 ; 1 byte
	FilterType   = $78 ; 1 byte
	FilterString = $79 ; 2 bytes
	AutoRepeat   = $7b ; 1 byte

	ExecAddr     = $cd ; don't change this, it's what AtoMMC uses

ENDIF

	; SDDOS uses $80-$9F as workspace, so we need to relocate this
	; Shouldn't be any side effect of borrowing Basic's Integer Workspace
   ; Oops, there were, because SDDOS also uses Basic's Integer Workspace
   ;
IF (sddos = 1 OR econet = 1)
	ZeroBase = $52
ELSE
	ZeroBase = $80
ENDIF

	; For the Decimal Output routines
	BinBuffer        = ZeroBase + $1D
	BcdBuffer        = ZeroBase + $1F
	SuppressFlag     = ZeroBase + $21
