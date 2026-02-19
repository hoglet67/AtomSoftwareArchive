	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; Conditional Assembly Constants
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	properAnnotationCounts=1

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; Table Structure Offsets
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	NumFacets       	= 8

	; DisplayModeFlags
	DMUpdateCounts		= &80	; 1=disable rendering (i.e. count only)
	DMDisableSearchFilter	= &40	; 1=disable search/filtering
	DMHighlightMatches	= &20	; 1=highlight search matches

	; Field offsets into the title table record

	PubByteOffset     	= 2
	GenreByteOffset         = 0
	ChunkByteOffset     	= 4
	RamByteOffset     	= 3
	RomByteOffset     	= 4
	VersionByteOffset     	= 3
	JoystickByteOffset  	= 2
	CollectionsByteOffset  	= 5

	PubMask     		= &3F
	GenreMask         	= &78
	ChunkMask     		= &07
	RamMask     		= &E0
	RomMask     		= &F8
	VersionMask     	= &1F
	JoystickMask  		= &C0
	CollectionsMask  	= &FF

	PubXor     		= &00
	GenreXor         	= &00
	ChunkXor     		= &00
	RamXor     		= &00
	RomXor     		= &00
	VersionXor    		= &00
	JoystickXor  		= &00
	CollectionsXor  	= &80

	PubBitOffset     	= 0
	GenreBitOffset          = 3
	ChunkBitOffset     	= 0
	RamBitOffset     	= 5
	RomBitOffset     	= 3
	VersionBitOffset     	= 0
	JoystickBitOffset  	= 6
	CollectionsBitOffset  	= 0


	PubFilterNum		= 1
	GenreFilterNum		= 2
	ChunkFilterNum		= 3
	RamFilterNum		= 4
	RomFilterNum		= 5
	VersionFilterNum	= 6
	JoystickFilterNum	= 7
	CollectionsFilterNum 	= 8

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
	; No longer used; it's been combined with FilterType
	FilterType       = ZeroBase + $07

	; (Immutable) The filter value
	FilterVal        = ZeroBase + $08

	; Display mode value
	; Bits 0..3 : 0 = Enable search filtering, 1.... disabl
	; Bit 7 : 0 =  Hight Matches, 1 = Don't Highlight Matches
	DisplayMode      = ZeroBase + $09

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

	; A temporary offset into the title record, used by the info screen
	TmpOffset        = ZeroBase + $0f

	; These are working values
	Title            = ZeroBase + $10
	AnnotationTable  = ZeroBase + $12
	AnnotationPtr    = ZeroBase + $14
	Screen           = ZeroBase + $16
	TmpX             = ZeroBase + $18
	TmpY             = ZeroBase + $19
	Tmp              = ZeroBase + $1A
	RowCount         = ZeroBase + $1C

	; Copies of some of the input params so they are not modified
	CurrentRow       = ZeroBase + $22
	CurrentSort      = ZeroBase + $24
