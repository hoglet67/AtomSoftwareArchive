;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Conditional Assembly Constants
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  	info_option             =? 1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Miscellaneous constants
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	CharsPerLine    	= 32

	; DisplayModeFlags
	DMUpdateCounts		= &80	; 1=disable rendering (i.e. count only)
	DMDisableSearchFilter	= &40	; 1=disable search/filtering
	DMHighlightMatches	= &20	; 1=highlight search matches

	; Autorepeat delay / rate
	AutoRepeat1		= -&200
	AutoRepeat2  		= -&20

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Table Structure Offsets
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	NumFacets       	= 8

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

	; Field offsets into the secondary table record
	FacetWorkingOffset	= 0	   ; the on-the-fly calculated  facet count where there is a seach
	FacetTitleOffset	= 2	   ; the name of the facet itself

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Buffering
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	RowReturnLSB		= Base

	RowReturnMSB    	= Base + 16

IF (econet = 1)
	SearchBuffer		= &140
ELSE
	SearchBuffer		= &120
ENDIF

	CountString     	= OscliBuffer

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Zero page - two-byte pointers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; Points to the master Menu Table, which starts with a block
	; of pointers to the title and secondard tables.
	; (this is set when MENU1 is loaded)
	MenuTablePtr     	= ZeroBase + &00

	; Points to the current Sort Table
	; (this is set when SORTi is loaded)
	SortTablePtr   	 	= ZeroBase + &02

	; Points sort table to be used for renderimg the current page
	; (can be either the current Sort Table, or one of the secondary tables)
	Sort             	= ZeroBase + &04

	; A pointer within the current sort list (within the renderer)
	; (it might be possible to combine this with Sort)
	CurrentSort      	= ZeroBase + &06

	; Points to the currently active annotation/filter table
	AnnotationTable  	= ZeroBase + &08

	; Points to the current annotation record
	AnnotationPtr    	= ZeroBase + &0A

	; Points to the current title record
	Title            	= ZeroBase + &0C

	; Points into screen, updated as stuff is written
	Screen           	= ZeroBase + &0E

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Zero page - two-byte variables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; The auto repeat counter
	AutoRepeat       	= ZeroBase + &10

	; The first row to render, usually (item + (page - 1) * LinesPerPage
	StartRow         	= ZeroBase + &12

	; The index of the item currently being worked on by the renderer
	CurrentItem      	= ZeroBase + &14

	; The total number of result rows (set after a rendering pass)
	TotalItems       	= ZeroBase + &16

	; The 2-byte binary input of the decimal conversion code
	; (also occasionally used as a scratch value)
	BinBuffer        	= ZeroBase + &18

	; The 3-byte BCD output of the decimal conversion code
	BcdBuffer        	= ZeroBase + &1A

	; Spare 1D-1F

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Zero page - one-byte variables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; The main state of the application, i.e. what screen sis the user seeing
	; (0 = Titles screen, 1 = Publishers filter screen, ...)
	PageState        	= ZeroBase + &20

	; A bit mask, one bit per filter (2^0 = Publisher, 2^1 = Genre....)
	FilterType       	= ZeroBase + &21

	; The sort order the user has chosen
	; (0 = by Title, 1 = by Publisher, 2 = by Genre, ...)
	SortType     	 	= ZeroBase + &22

	; The annotation the user has chosen
	; (0 = Short Publisher, 1 = Publisher, 2 = Genre, ...)
	Annotation       	= ZeroBase + &23

	; The first line on the screen where rows can be rendered
	; (was fixed at 2, now depends on number of filters)
	StartLine        	= ZeroBase + &24

	; The number of active lines per page to be displayed
	; (was fixed at 13, now depends on number of filters)
	LinesPerPage     	= ZeroBase + &25

	; Current Page (1 based)
	Page             	= ZeroBase + &26

	; The number of pages of results that are available
	NumPages     	 	= ZeroBase + &27

	; Current Item on the Page (0 based)
	Item             	= ZeroBase + &28

	; Display mode bit mask
	; See DisplayModeFlags above
	DisplayMode      	= ZeroBase + &29

	; The offset of the title string within title record
	; (this changes with the number of collections)
	TitleNameOffset  	= ZeroBase + &2A

	; A count of the number of rows that have been rendered in the current page
	RowCount         	= ZeroBase + &2B

	; The first character in the search buffer, replicated in ZP as a slight optimization
	SearchFirst      	= ZeroBase + &2C

	; For the Decimal Output routines
	SuppressFlag     	= ZeroBase + &2D

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Zero page - very tenporary values
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; General purpose temporary poimyer
	TmpPtr       	 	= TmpBase

	; Temporary holding values
	Tmp              	= TmpBase + &02
	TmpX             	= TmpBase + &03
	TmpY             	= TmpBase + &04
