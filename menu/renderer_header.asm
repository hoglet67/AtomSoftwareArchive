
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

	; (Immutable) This should point to the first row in the sort index
	Sort             = $80

	; (Immutable) This should point to the index of the row to search for (starting at 0) 
    StartRow         = $82 

    ; (Immutable) The Address to store the found rows, so that the basic program can access them
    RowRet           = $84

	; (Immutable) The annotation to show: 0 = Short Publisher, 1 = Publisher, 2 = Genre, 3 = Collection, 255 = Count
    Annotation       = $86

    ; (Immutable) The filter key: 1 = Genre, 2 = Publisher, 3 = Collection
    Filter           = $87

	; (Immutable) The filter value
    FilterVal        = $88

	; Search mode value
	; Bits 0..1 : 0 = Enable search filtering, 1,2,3 = Disable search filtering
	; Bit 7 : 0 =  Hight Matches, 1 = Don't Highlight Matches
    SearchMode       = $89
    
    ; (Immutable) Current Page
    Page             = $8a
    
    ; (Immutable) Current Page
    MenuTablePtr     = $8b

	; The value used to return InKey
	Key              = $8f

	; The row address to highlight
	Row              = $8f

	; These are working values
	Title            = $90
	AnnotationPtr    = $92
	AnnotationString = $94
	Screen           = $96
	TmpX             = $98    
	TmpY             = $99
	RowCount         = $9A
	
	; For the Decimal Output routines
	BinBuffer        = $9B
	BcdBuffer        = $9D
	SuppressFlag     = $9F
	
	; Copies of some of the input params so they are not modified
	CurrentRow       = $A0
	CurrentSort      = $A2
	