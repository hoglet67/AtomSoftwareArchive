	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; Conditional Assembly Constants
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	properAnnotationCounts=1

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; Table Structure Offsets
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	NumFacets       	= 8

	SearchModeMask          = &0F		; large enough to represent NumFacets

	; Field offsets into the title table record

	PubIdOffset     	= 2
	GenreIdOffset           = 0
	ChunkIdOffset     	= 4
	RamIdOffset     	= 3
	RomIdOffset     	= 4
	VersionIdOffset     	= 3
	JoystickIdOffset  	= 2
	CategoriesIdOffset  	= 5

	PubFilterNum		= 1
	GenreFilterNum		= 2
	ChunkFilterNum		= 3
	RamFilterNum		= 4
	RomFilterNum		= 5
	VersionFilterNum	= 6
	JoystickFilterNum	= 7
	CategoriesFilterNum 	= 8

	; Field offsets into the secondard table record

	FacetCountOffset	= 0	   ; the original facet count where there is a search
	FacetWorkingOffset	= 2	   ; the on-the-fly calculated  facet count where there is a seach
	FacetTitleOffset	= 4	   ; the name of the facet itself

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; Operating System Subroutines
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

IF (econet = 1)
	SearchBuffer    = $140
ELSE
	SearchBuffer    = $120
ENDIF

	; Note: Making CountString and Oscli buffer the same avoids a copy

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; Miscellaneous constants
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	Space           = $20
	Dot             = $2e
	CharsPerLine    = 32
	StartLine       =  2
	LinesPerPage    = 13

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; Zero Page Locations
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

	; The title name offet in the title record (used to be fixed at 4, but now collections are dynamic)
	TitleNameOffset  = ZeroBase + $0d

	; The first character in the search buffe
	; Store this in Zero Page as a slight optimization
	SearchFirst      = ZeroBase + $0e

	; The value used to return InKey
	Key              = ZeroBase + $0f

	; The row address to highlight
	Row              = ZeroBase + $0f

	; These are working values
	Title            = ZeroBase + $10
	AnnotationPtr    = ZeroBase + $12
	AnnotationString = ZeroBase + $14
	Screen           = ZeroBase + $16
	TmpX             = ZeroBase + $18
	TmpY             = ZeroBase + $19
	Tmp              = ZeroBase + $1A
	RowCount         = ZeroBase + $1C

	; Copies of some of the input params so they are not modified
	CurrentRow       = ZeroBase + $22
	CurrentSort      = ZeroBase + $24
