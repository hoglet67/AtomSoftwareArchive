	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	; Conditional Assembly Constants
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

	properAnnotationCounts=1

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	; Operating System Subroutines
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

	WaitUntilVSync  = $fe66
	Osrdch          = $ffe3
	Oswrch          = $fff4
	Oscli           = $fff7

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	; Operating System Subroutines
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
	OscliBuffer     = $100
	CountString     = OscliBuffer
	SearchBuffer    = $120
	ScreenStart     = $8000

	; Note: Making CountString and Oscli buffer the same avoids a copy

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	; Miscellaneous constants
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

	CountOffset     = 0
	PubIdOffset     = 2
	TitleNameOffset = 4
	Space           = $20
	Return          = $0d
	Dot             = $2e
	CharsPerLine    = 32
	StartLine       =  2
	LinesPerPage    = 13 
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
    ; Zero Page Locations
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; SDDOS uses $80-$9F as workspace, so we need to relocate this
	; Shouldn't be any side effect of borrowing Basic's Integer Workspace
		
IF (sddos = 1)
	ZeroBase = $20
ELSE
	ZeroBase = $80
ENDIF

	; (Immutable) This should point to the first row in the sort index
	Sort             = ZeroBase + $00

	; (Immutable) This should point to the index of the row to search for (starting at 0) 
    StartRow         = ZeroBase + $02 

    ; (Immutable) The Address to store the found rows, so that the basic program can access them
    RowRet           = ZeroBase + $04

	; (Immutable) The annotation to show: 0 = Short Publisher, 1 = Publisher, 2 = Genre, 3 = Collection, 255 = Count
    Annotation       = ZeroBase + $06

    ; (Immutable) The filter key: 1 = Genre, 2 = Publisher, 3 = Collection
    Filter           = ZeroBase + $07

	; (Immutable) The filter value
    FilterVal        = ZeroBase + $08

	; Search mode value
	; Bits 0..1 : 0 = Enable search filtering, 1,2,3 = Disable search filtering
	; Bit 7 : 0 =  Hight Matches, 1 = Don't Highlight Matches
    SearchMode       = ZeroBase + $09
    
    ; (Immutable) Current Page
    Page             = ZeroBase + $0a
    
    ; (Immutable) Current Page
    MenuTablePtr     = ZeroBase + $0b

	; The value used to return InKey
	Key              = ZeroBase + $0f

	; The row address to highlight
	Row              = ZeroBase + $0f

	; These are working values
	Title            = ZeroBase + $10
	AnnotationPtr    = ZeroBase + $12
	AnnotationString = ZeroBase + $14
	Screen           = ZeroBase + $16
	Tmp              = ZeroBase + $18
	TmpX             = ZeroBase + $18    
	TmpY             = ZeroBase + $19
	RowCount         = ZeroBase + $1A
	
	; For the Decimal Output routines
	BinBuffer        = ZeroBase + $1B
	BcdBuffer        = ZeroBase + $1D
	SuppressFlag     = ZeroBase + $1F
	
	; Copies of some of the input params so they are not modified
	CurrentRow       = ZeroBase + $20
	CurrentSort      = ZeroBase + $22
	