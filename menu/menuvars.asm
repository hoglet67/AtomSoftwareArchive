;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Conditional Assembly Constants
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	banner_scroll 		=? 1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Miscellaneous constants
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	NumScrollStates		= 7
	ScrollStateMask		= &0E

	MinChapter		= 0	; A
	MaxChapter 		= 6	; G
	AGDChapter 		= 2	; C
	ALLChapter 		= 6	; G

	FontHeight       	= 9	; height of font
	LinePitch        	= 10	; pixel spacing of text lines

	ChapterLineStart 	= 70	; Y pixel row to strike in Chapter A
	ChapterLineWidth 	= 12	; Y pixels between adjacent text lines

	TopWindowStart     	= 10
	TopWindowHeight    	= 52

	BottomWindowStart  	= 154
	BottomWindowHeight 	= 20

	RamRomTypeNone		= &00
	RamRomTypeUnknown	= &01
	RamRomTypeAtom2K15	= &02
	RamRomTypeYARRB		= &03
	RamRomTypeRamoth	= &04
	RamRomTypeGoSDCPro	= &05
	RamRomTypeTestFault	= &06

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Zero Page
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	TmpPtr			= ZeroBase
	EndPage			= ZeroBase + 2
	Dir      		= ZeroBase + 3
	KeyFlag  		= ZeroBase + 4
	NumLines 		= ZeroBase + 5
	Cycle    		= ZeroBase + 6
	TxtPtr   		= ZeroBase + 8
	FontPtr  		= ZeroBase + 10
	LoMemBot 		= ZeroBase + 12
	LoMemTop 		= ZeroBase + 13
	HiMemBot 		= ZeroBase + 14
	HiMemTop 		= ZeroBase + 15
	RamRomType		= ZeroBase + 16
