atommc =? 0
sddos2 =? 0
sddos3 =? 0
econet =? 0
gosdc =? 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Operating System Subroutines
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	RDCVEC		= &020a

	PlotDriverLS	= &f6d3
	PlotDriverMS    = &f6d8
	GraphicsCtrl    = &f6dd
	WaitUntilVSync  = &fe66
	Inkey		= &fe71
	KernelOsrdch	= &fe94
	Osrdch          = &ffe3
	Oswrch          = &fff4
	Oscli           = &fff7

	OscliBuffer     = &100

	ScreenStart	= &8000

	Return          = &0d

IF (econet = 1 OR gosdc = 1)
	DirSep		= '.'
ELSE
	DirSep		= '/'
ENDIF

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Zero page
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; SDDOS uses &80-&9F as workspace, so we need to relocate this
; Shouldn't be any side effect of borrowing Basic's Integer Workspace
; Oops, there were, because SDDOS also uses Basic's Integer Workspace

IF (sddos2 = 1 OR sddos3 = 1)
	ZeroBase	= &52
	TmpBase		= &8C
	ExecAddr    	= &9e ; don't change this, it's what SDDOS uses
ELIF (econet = 1)
	ZeroBase	= &52
	TmpBase		= &8C
	ExecAddr     	= &d0 ; don't change this, it's what ECONET uses
ELIF (gosdc = 1)
	ZeroBase	= &70
	TmpBase		= &A0
	ExecAddr     	= &d2 ; don't change this, it's what GOSDC uses
ELSE
	ZeroBase	= &70
	TmpBase		= &A0
	ExecAddr     	= &cd ; don't change this, it's what AtoMMC uses
ENDIF

	FilterBase	= &B0
