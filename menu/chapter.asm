	Base =? &2800

include "sysvars.asm"

include "chaptervars.asm"

	org Base - 22

	guard Base + &A00

.STARTOFHEADER

; 22 byte ATM header

	EQUS    "MENU"

	EQUB    &00
	EQUB    &00
	EQUB    &00
	EQUB    &00
	EQUB    &00
	EQUB    &00
	EQUB    &00
	EQUB    &00
	EQUB    &00
	EQUB    &00
	EQUB    &00
	EQUB    &00

	EQUB    <Base
	EQUB    >Base

	EQUB    <Base
	EQUB    >Base

	EQUW	ENDOF - STARTOF

.STARTOF

.Menu
{
	; vvvvvvvv IMPORTANT: This code gets clobbered by the filter state and row return buffer

	JSR OscliString
	EQUS "LOAD MENU1", Return

	LDA ExecAddr
	STA MenuTablePtr
	LDA ExecAddr + 1
	STA MenuTablePtr + 1

	JSR OscliString
	EQUS "LOAD MENU2", Return

	; Initialize the variables
	LDY #0
	STY SortType
	INY
	STY Annotation

	; Load the default sort table (sort by title)
	JSR LoadSortTable

	; Initialize the search buffer to empty
	LDY #0
	STY SearchBuffer

	; Clear all filters
	JSR ClearAllFilters

	; ^^^^^^^^ IMPORTANT code gets clobbered by the filter state and row return buffer

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Main command loop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.main_loop_page_state_zero
	; Reset back to the title page, and refresh everything
	LDA #0
	STA PageState

.main_loop_redo_counts

	; Counts are only needed for the filter pages, not the title page
	LDY PageState
	BEQ main_loop_redo_sizes

	; Save the current annotation
	LDA Annotation
	PHA

	; Save the current filter mask for the filter controlled by this page
	LDX FacetByteOffsetTable, Y
	LDA FacetMasks, X
	PHA

	; Update the annotation to point to this filter
	STY Annotation

	; Clear the current filter (if there is one)
	JSR ClearFilterY

	; Make sure the title table is used, not the facet table
	LDA SortTablePtr
	STA Sort
	LDA SortTablePtr + 1
	STA Sort + 1

	; Recalculate the filter counts needed for this filter page
	LDA #DMUpdateCounts
	STA DisplayMode
	JSR RenderPage

	; Restore the original filter mask
	LDY PageState
	LDX FacetByteOffsetTable, Y
	PLA
	STA FacetMasks, X

	; Restore the original annotation the user has chose (to see on the title page)
	PLA
	STA Annotation

.main_loop_redo_sizes
	; Calculate LinesPerPage and StartLine from FilterCount
	JSR CalculateTextWindow

.main_loop_reset_position
	; Reset the page/item back to the start
	LDA #&00
	STA Item
	STA Page

.main_loop_render_all
	; Render the header, including the filter list
	JSR RenderHeader

	; Clear the bottom line
	JSR ClearSearchLine

	LDA PageState		; Only show SEARCH= in title page state
	BNE main_loop_render
	LDA SearchBuffer	; Only show SEARCH= when there is an active search
	BEQ main_loop_render

	; Render the currently active search
	JSR ShowCurrentSearchNoCursor

.main_loop_render
	; Prepare for rendering, setup verious ZP variables
	JSR SetupRenderingVars

	; Determine the display mode based on the current page state
	LDA PageState
	BEQ set_display_mode
	LDA #DMDisableSearchFilter
.set_display_mode
	STA DisplayMode

	; Render the page (show upto 13 rows, applying current search and filter set)
	JSR RenderPage

	; Update the PAGE M and N
	JSR UpdateTotalPages

	; On a filter page, try to pre-select the item that matches the current filter
	LDX PageState
	BEQ select_item
	JSR GetAnnotationTable
	JSR FindFilterItem
	BCS select_item		; C=0 if item found
	STX Item		; save found item

	; Gracefully handle the end of the list
.select_item
	LDX Item
	JSR TestRowXActive
	BCC highlight_item	; C=0 if item valid
	DEC Item
	BPL select_item

	; This can happen if there are no items
	BMI main_loop_release

	; Highlight the currently active item
.highlight_item
	JSR HighlightItem

.main_loop_release
	; Wait for key release, or for auto repeat to start
	JSR HandleAutoRepeat

.main_loop_scan
	LDA #&40      	; 40 (bit 6) is the control key mask
	LDX &bf00
	CPX #&bf	; Value on a real Atom is &b1, due to pulldowns on D3..1
	BNE original_atom
	ASL A		; 80 (bit 7) is the shift key mask
.original_atom

	; Test for up key
	BIT &b001
	BNE test_for_down_key

	; Handle the up key, decrementing item
.handle_up_key
	; De-select the existing item
	JSR HighlightItem
	; Set the page-change item to the bottom item on the page
	LDY LinesPerPage
	DEY
	; Decrement the item
	DEC Item
	; Branch if we have moved off the top bottom of the visible items
	BMI handle_prev_page
	; Select the new item
	JSR HighlightItem
	BMI main_loop_release	; Branch always

.test_for_down_key
	; Test for up key
	EOR #&C0   ; This inverts the mask used for the up key (40->80 and 80->40)
	BIT &b001
	BNE call_inkey

	; Handle down key, incrementing item
.handle_down_key
	; De-select the existing item
	JSR HighlightItem
	; Set the page-change item to the top item on the page
	LDY #&00
	; Decrement the item
	INC Item
	; Branch if we have moved off the bottom of the visible items
	LDX Item
	JSR TestRowXActive
	BCS handle_next_page
	; Select the new item
	JSR HighlightItem
	BMI main_loop_release	; Branch always

.call_inkey
	; Call InKey to scan the keyboard
	JSR Inkey
	BCS main_loop_scan			; Branch of no key pressed

.test_for_prev_page
	CPY #28					; <
	BNE test_for_next_page
	; Set the page-change item to the current item
	LDY Item
.handle_prev_page
	; Set the wrap page to the last page
	LDX NumPages
	DEX
	; Add -1 to the page
	LDA #&FF
	BNE change_page

.test_for_next_page
	CPY #30					; >
	BNE test_for_escape
	; Set the page-change item to the current item
	LDY Item
.handle_next_page
	; Set the wrap page to the first page
	LDX #&00
	; Add +1 to the page
	LDA #&01
	; fall through into change_page

; Helper code to support navigating to the previous or next page
;     A = &FF for prev page, or A=&01 for next page
;     X = page number to "wrap"
;     Y = item number on new page
.change_page
	CLC
	ADC Page
	CMP NumPages
	BCC page_valid
	TXA		; Wrap page number to value in X
.page_valid
	STA Page	; Save the new page number
	STY Item	; Save the new item number
	JMP main_loop_render

.test_for_escape
	CPY #&3B				; Escape
	BNE test_for_filter

	; Escape pressed, if on filter page, return to title page
	LDA PageState
	BEQ exit_back_to_splash
	JMP main_loop_page_state_zero

.exit_back_to_splash
	; Really exit, changing back to the "root" directory
	JSR OscliString
IF (sddos2 = 1 OR sddos3 = 1)
	EQUS "DRIVE 0", Return
ELIF (econet = 1 OR gosdc = 1)
	EQUS "DIR $", Return
ELSE
	EQUS "CWD /", Return
ENDIF
	JSR OscliString
	EQUS "RUN MENU", Return
	; never returns

.test_for_filter
	; Del (15) 0 (16) = title; 1..N = filter
	CPY #15					; Del
	BCC test_for_prev_tag
	CPY #16+NumFacets+1			; 8
	BCS test_for_prev_tag
	TYA
	SBC #15
	; At this point A=-1, 0, or 1..N
	BPL change_filter

.clear_filter
	; Clear filter
	LDY PageState
	JSR ClearFilterY			; Y=0 clears all filters, Y<>0 clean filter N; C=1 on exit if nothing changed
	BCS jump_main_loop_release		; nothing to do!
	LDA #0
	STA PageState
	JMP main_loop_redo_counts

.change_filter
	; At this point A=0, or 1..N
	CMP PageState
	BEQ jump_main_loop_release		; nothing to do!
	STA PageState
	JMP main_loop_redo_counts

.test_for_prev_tag
	; On a filter page, skip tests for: Z X [ ] S
	LDA PageState
	BNE test_for_help

	LDX Annotation
	CPY #58					; Z
	BNE test_for_next_tag
	; Handle prev tag
	DEX
	BPL change_tag
	LDX #NumFacets
	BNE change_tag

.test_for_next_tag
	CPY #56					; X
	BNE test_for_prev_sort
	; Handle next tag
	INX
	CPX #NumFacets + 1
	BNE change_tag
	LDX #0

.change_tag
	STX Annotation
	JMP main_loop_render

.jump_main_loop_release
	JMP main_loop_release

.test_for_prev_sort
	LDX SortType
	CPY #1					; [
	BNE test_for_next_sort
	; Decrement the current sort, handling wrapping
	DEX
	BPL change_sort
	LDX #NumFacets
	BNE change_sort				; branch always

.test_for_next_sort
	CPY #3					; ]
	BNE test_for_search
	; Increment the current sort, handling wrapping
	INX
	CPX #NumFacets + 1
	BNE change_sort
	LDX #0

.change_sort
	; Action the change of sort, also changing the current annotation ot match
	STX SortType
	BNE not_sort_zero
	INX					; Title sort defaults to long publisher
.not_sort_zero
	STX Annotation
	; Page in the appropriate sort table
	JSR LoadSortTable
	JMP main_loop_reset_position

.test_for_search
	; Test for search
	CPY #51					; S
	BNE test_for_help

	; Handle search
	JSR HighlightItem
	LDA #0
	STA Page
	JSR SetupRenderingVars
	JSR Search
	JMP main_loop_redo_counts

.test_for_help
	CPY #31					; /
	BNE test_for_select
	; Handle help screen
	JSR HelpScreen
	JMP main_loop_render_all		; redraw the whole screen, but counts will be unchanged

.test_for_select
	; Test for select (select current item)
	LDX Item
	CPY #0	      	      	      	      	; <Space>
	BEQ handle_select
	CPY #Return				; <Return>
	BEQ handle_select
	; Test for @
	CPY #32					; @, A-1
	BEQ handle_select
	; Test for A..M
	BCC jump_main_loop_release
	CPY #46					; M + 1
	BCS jump_main_loop_release
	TYA
	SBC #32
	TAX

.handle_select
	; Make sure the selected row actually exists
	JSR TestRowXActive
	BCS jump_main_loop_release
	;
	STX Item

	; Test whether we are on the title page or a filter page
	LDA PageState
	BEQ boot_program

	; Filter page, so add the filter
	TAY
	LDX Item
	LDA RowReturnLSB, X
	JSR AddFilterY				; Y = FilterNum, A = FilterValue
	JMP main_loop_page_state_zero

.boot_program

   	; If info option is enabled, then first show the info screen
IF (info_option > 0)
  IF (info_option = 2)
   	CPY #32
	BEQ boot_info
        JSR HandleAutoRepeat
	BCS boot_continue
	; Set the long auto repeat delay
	LDA #AutoRepeat1
	STA AutoRepeat
  ENDIF
.boot_info
	JSR GetItemAddress
   	JSR InfoScreen
	CMP #Return
	BEQ boot_continue
	JMP main_loop_render_all
.boot_continue
ENDIF
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Really Boot the Program!
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

{
	JSR GetItemAddress

	; Dereference the title to get the 11-bit index number
	JSR DereferenceTitle

	; For SDDOS we pack two games per disk
	LDA Title
	AND #&7
IF (sddos2 = 1)
	LSR A
ENDIF
	STA BinBuffer + 1
	LDA Title+1
IF (sddos2 = 1)
	ROR A
ENDIF
	STA BinBuffer
IF (sddos2 = 1)
	LDA #'0'
	ADC #0
	STA bootnum
ENDIF
	; Clear screen
	LDA #12
	JSR Oswrch

IF (sddos2 = 1 )

	; SDDOS2 has a *RUNME bug, where only drive 0 is
	; searched for the file RUNME
	LDA #'0'
	JSR load_disk

	JSR OscliString
	EQUS "DRIVE 0", Return

	JSR OscliString
	EQUS "RUN BOOT"
.bootnum
	EQUS "0", Return

.load_disk
	STA run_command + 4

ELIF (sddos3 = 1)

	; SDDOS3 is less messy if we use three different drives
	LDA #'2'
	JSR load_disk

	JSR OscliString
	EQUS "DRIVE 2", Return

	JSR OscliString
	EQUS "RUN BOOT", Return

.load_disk
	STA run_command + 4

ELIF (econet = 1)

	JSR change_directory

	JSR OscliString
	EQUS "BOOT", Return

.change_directory

ELIF (gosdc = 1)

	JSR change_directory

	JSR OscliString
	EQUS "RUN BOOT", Return

.change_directory

ENDIF

.run_command0
	LDX #0
.run_command1
	LDA run_command, X
	BEQ run_command2
	STA OscliBuffer, X
	INX
	BNE run_command1
.run_command2
IF (econet = 1 OR gosdc = 1)
	JSR WritePath
ELSE
	JSR WriteDecimal
ENDIF
IF (sddos3 = 1)
	LDY #0
.run_command3
	LDA DskSuffix, Y
	BEQ run_command4
	STA OscliBuffer, X
	INX
	INY
	BNE run_command3
.DskSuffix
	EQUS ".DSK", 0
.run_command4
ENDIF
	LDA #Return
	STA OscliBuffer, X
	INX
	STA OscliBuffer, X
	JMP Oscli

IF (sddos2 = 1 OR sddos3 = 1)

.run_command
	EQUS "DIN  ,",0

ELIF (econet = 1 OR gosdc = 1)

.run_command
	EQUS "DIR $.ASA.",0

ELSE

.run_command
	EQUS "RUN ", 0

ENDIF
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Support code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Translates the Item index (in the RowReturn buffer) to a record address
.GetItemAddress
{
	LDY Item		; Item starts at 0

	LDA RowReturnMSB, Y
	STA Title + 1

	LDA RowReturnLSB, Y	; RowReturnBuffer stores the item index
	ASL A
	ROL Title + 1
	CLC
	ADC Sort
	STA Title
	LDA Title + 1
	ADC Sort + 1
	STA Title + 1		; Title now (item << 1)
	;; Fall through into DeReferenceTitle
}

IF 0
; Old method that dereferences the pointer at zero page location
; X,X+1. This ended up only being used for title, so we save a few
; bytes with a customized version.
.DereferenceTitle
{
	LDX #Title
.Dereference
	LDA (0,X)
	PHA
	INC 0,X
	BNE skip
	INC 1,X
.skip
	LDA (0,X)
	STA 1,X
	PLA
	STA 0,X
	RTS
}
ENDIF

.DereferenceTitle
{
	LDY #0
	LDA (Title), Y
	PHA
	INY
	LDA (Title),Y
	STA Title + 1
	PLA
	STA Title
	RTS
}

; Test if row X (0 based) is active
; On exit:
;    C=0 if valid
;    C=1 if invalid
.TestRowXActive
{
	CPX #MaxItems
	BCS done
	LDA RowReturnMSB, X
	CMP #&FF		; C=0 if valid, C=1 if invalid
.done
	RTS
}

; Handles auto repeat
.HandleAutoRepeat
{
.loop
	JSR WaitUntilVSync
	BIT &b001
	BPL pressed	; shift
	BVC pressed	; control
	JSR Inkey	; C=1 if no key pressed
	; Key was released
	; Update the auto repeat timer to the delay value
	LDA #AutoRepeat1
	BCS released
.pressed
	DEC AutoRepeat
	BNE loop
	; Key was not released
	; Update the auto repeat timer to the repeat value
	LDA #AutoRepeat2
.released
	; Reload Autorepeat for next time
	STA AutoRepeat
	RTS
}

; Load Sort Table specified by SortType
.LoadSortTable
{
	LDA SortType
	ORA #'0'
	STA number
	JSR OscliString

	EQUS "LOAD SORT"
.number
	EQUS " ", Return

	LDA ExecAddr
	STA SortTablePtr
	LDA ExecAddr + 1
	STA SortTablePtr + 1
	RTS
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Calculations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Text window size calculation
;   Filter  Start   Lines
;   Count   Line   Per Page
;     0       2      13
;     1       2      13
;     2       3      12
;     3       4      11
;    ...     ...    ...
.CalculateTextWindow
{
	JSR CountFilters
	CLC
	LDA FilterCount
	BNE notzero
	SEC
.notzero
	ADC #1
	STA StartLine
	LDA #16
	SBC StartLine		; C=1
	STA LinesPerPage
	RTS
}

; Calculate the number of pages requires to display the current result
; set, by dividing (TotalItems - 1) by LinesPerPage.
; On Entry:
;    TotalItems (16 bits)
;    LinesPerPage (8 bits)
; On Exit:
;    NumPages (8 bits)
.CalculateNumPages
{
	LDY #1

	SEC
	LDA TotalItems
	SBC #1
	STA BinBuffer
	LDA TotalItems + 1
	SBC #0
	STA BinBuffer+1
	BCC done
	DEY
.loop
	INY
	; SEC not needed, as both paths to loop set C=1
	LDA BinBuffer
	SBC LinesPerPage
	STA BinBuffer
	LDA BinBuffer+1
	SBC #0
	STA BinBuffer+1
	BCS loop
.done
	STY NumPages
	RTS
}

; Refreshes the Page M OF N text in the top line
.UpdateTotalPages
{
	; Calculate the number of pages (from Total Rows)
	JSR CalculateNumPages  	  ; TODO: Count inline this

	; Zero the MSBs of the bin buffer, as pages are small
	LDA #0
	STA BinBuffer+1
	STA BinBuffer+2

	; Make sure that we don't suppress zeros
	SEC
	ROR SuppressFlag

	; X is used as the index into CountString
	TAX

	; Write Page to the CountString
	LDA Page
	STA BinBuffer
	INC BinBuffer
	JSR BinToDecimal16
	JSR WriteHex

	; Write the page separator into CountString
	LDA #'/'
	STA CountString, X
	INX

	; Write the number of pages into to the CountString
	LDA NumPages
	STA BinBuffer
	JSR BinToDecimal16
	JSR WriteHex

.loop
	; Can't assemble "LDA CountString - 1, X" here as CountString=&100
	EQUB &BD, <(CountString - 1), >(CountString-1)
	AND #&3F
	ORA #&80
	STA ScreenStart + CharsPerLine - 6, X
	DEX
	BNE loop
	RTS
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Render Page Header
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.RenderHeader
{
	; Clear line 1, as it's sometimes left blank
	LDY #CharsPerLine
	LDA #' '
.loop
	STA ScreenStart + CharsPerLine - 1, Y
	DEY
	BNE loop

	; Setup the screen pointer to top left
	; Y is already 0
	; LDY #0
	JSR ScreenLineY

	; Title page or Filter page?
	LDA PageState
	BEQ title_page

.filter_page
	; Filter page, print FILTER BY
	LDX #FilterByStringNum
	JSR ScreenStringX

	; Set Sort to the start of the pointer list in the secondary table
	LDX PageState
	LDY #Sort
	JSR GetMenuTable

	; Prepare for printing the filter facet name
	BNE facet	; branch always

.title_page
	; Title page, print SORTED BY
	LDX #SortedByStringNum
	JSR ScreenStringX

	; Set Sort to the start of the pointer list in the sort table
	LDA SortTablePtr
	STA Sort
	LDA SortTablePtr + 1
	STA Sort + 1

	; Prepare for printing the sort facet name
	LDX SortType

.facet
	; Print the facet name
	JSR ScreenStringX

	; Pad with spaces
	LDY PadTable, X
	JSR YSpaces

	; Print PAGE
	LDX #PageMofNStringNum
	JSR ScreenStringX

	; Move to next line
	JSR PadToEOL

	; Display the set of active filters
	JSR ListFilters

.done
	LDY #0
	JMP HighlightRowY
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Search
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.Search
{
	LDA DisplayMode
	ORA #DMHighlightMatches
	STA DisplayMode

	; Update current results set and number of pages
	JSR RenderPage
	JSR UpdateTotalPages

	; Returns with Y being the end of the search buffer
	LDA #&A0
	JSR ShowCurrentSearch

	; Read a character
	JSR Osrdch

	; Return cancels the search
	CMP #&1B
	BNE NotEscape
	LDY #0
	STY SearchBuffer
	BEQ SearchExit		; Branch always

.NotEscape
	; Return returns with the seach in place
	CMP #Return
	BEQ SearchExit

	CMP #&7F
	BNE Search1

	; Delete at the beginning of the line also terminates the search
	CPY #0
	BEQ SearchExit

	DEY
	LDA #0

.Search1
	STA SearchBuffer,Y
	INY
	LDA #0
	STA SearchBuffer,Y

	JMP Search

.SearchExit
	CPY #0
	BNE ShowCurrentSearchNoCursor
	; Fall though to...
}

.ClearSearchLine
{
	LDA #' '
	LDY #CharsPerLine - 1
.loop
	STA ScreenStart + &1E0,Y
	DEY
	BPL loop
	RTS
}

.ShowCurrentSearchNoCursor
{
	LDA #&20
	; Fall though to...
}

.ShowCurrentSearch
{
	; Save the cursor
	PHA

	; Move to the bottom row
	LDY #15
	JSR ScreenLineY

	; Write "  SEARCH="
	LDX #SearchStringNum
	JSR ScreenStringX

	; Write the contents of the search buffer
	LDY #0
.loop
	LDA SearchBuffer,Y
	BEQ done
	JSR WriteToScreen
	INY
	BNE loop

.done
	; Save the search buffer pointer
	STY TmpY

	; Restore the cursor
	PLA
	LDY #0
	STA (Screen),Y

	; Followed by a space
	INY
	LDA #' '
	STA (Screen),Y

	; Exit with Y pointing to the end of the search buffer
	LDY TmpY
	RTS
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Info Screen
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

IF (info_option > 0)

.InfoScreen
{
	JSR OscliString
	EQUS "LOAD INFO", Return

	; Metata starts on line 4
	LDY #4
	JSR ScreenLineY

	LDX #1
.filter_loop1
	LDA #FilterSeparator2
	JSR WriteFacetToScreen
	INX
	CPX #CollectionsFilterNum
	BNE filter_loop1

.filter_loop2
	LDY #CollectionsByteOffset
	LDA (Title), Y
	BPL title
	LDA #FilterSeparator2
	JSR WriteFacetToScreen
	INC Title
	BNE filter_loop2
	INC Title + 1
	BNE filter_loop2

; Finally go back and print the title (centred)
.title
	LDX #CharsPerLine
	LDY #CollectionsByteOffset
.title_loop1
	LDA (Title),Y
	BMI title_done1
	INY
	DEX
	BNE title_loop1

.title_done1
	TXA
	LSR A
	ORA #<(ScreenStart + 2 * CharsPerLine)
	STA Screen
	LDA #>(ScreenStart + 2 * CharsPerLine)
	STA Screen + 1

	LDX #CharsPerLine
	LDY #CollectionsByteOffset
	JSR WriteTitleNoHighlightOffsetY

.title_done2
	LDY #2
	JSR HighlightRowY
	JMP Osrdch
}
ENDIF

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Help Screen
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.HelpScreen
{
	JSR OscliString
	EQUS "LOAD HELP", Return
	JMP Osrdch
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Multi Facet Filter Workspace
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; These now overlap the startup code

; .FacetMasks
; FOR i, 0, CollectionsByteOffset - 1, 1
; 	EQUB &00
; NEXT
; .CollectionsFacetMask
; 	EQUB &00
;
; .FacetValues
; FOR i, 0, CollectionsByteOffset - 1, 1
; 	EQUB &00
; NEXT
; .CollectionsFacetValue
; 	EQUB &00

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Multi Facet Filter Fixed Data
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FacetByteOffsetTable
	EQUB PubByteOffset
	EQUB PubByteOffset
	EQUB GenreByteOffset
	EQUB ChunkByteOffset
	EQUB RamByteOffset
	EQUB RomByteOffset
	EQUB VersionByteOffset
	EQUB JoystickByteOffset
	EQUB CollectionsByteOffset

.FacetMaskTable
	EQUB PubMask
	EQUB PubMask
	EQUB GenreMask
	EQUB ChunkMask
	EQUB RamMask
	EQUB RomMask
	EQUB VersionMask
	EQUB JoystickMask
	EQUB CollectionsMask

.FacetBitOffsetTable
	EQUB 7 - PubBitOffset
	EQUB 7 - PubBitOffset
	EQUB 7 - GenreBitOffset
	EQUB 7 - ChunkBitOffset
	EQUB 7 - RamBitOffset
	EQUB 7 - RomBitOffset
	EQUB 7 - VersionBitOffset
	EQUB 7 - JoystickBitOffset
	EQUB 7 - CollectionsBitOffset

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Multi Facet Filtering Code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Clear Filter
;     Y = Filter Number
;
; Note, this only clears the FacetMask, as the FacetValue is
; irrelevant when the mask is zero
.ClearFilterY
{
	CPY #0
	BEQ ClearAllFilters
	; C = 1 at this point
	LDX FacetByteOffsetTable, Y
	LDA FacetMasks, X
	AND FacetMaskTable, Y
	BEQ done
 	EOR FacetMaskTable, Y	; this works because the relevant FacetMasks are all-0 or all-1
	STA FacetMasks, X
	CLC			; indicate some work was done
.done
	RTS
}

.ClearAllFilters
{
	SEC
	LDY #CollectionsByteOffset
.loop	LDA FacetMasks, Y
	BEQ next
	CLC			; indicate some work was done
	LDA #0
	STA FacetMasks, Y
.next
	DEY
	BPL loop
	RTS
}

.CountFilters
{
	LDA #0
	STA FilterCount
	LDY #CollectionsFilterNum
.loop
	LDX FacetByteOffsetTable, Y
	LDA FacetMasks, X
	AND FacetMaskTable, Y
	BEQ next
	INC FilterCount
.next
	DEY
	BNE loop
	RTS
}

; Add Filter
;     Y = Filter Number
;     A = Filter Value
.AddFilterY
{
	; Shift the value to the right bit position
	LDX FacetBitOffsetTable, Y
.shift_loop
	CPX #7
	BEQ shift_done
	ASL A
	INX
	BCC shift_loop  ; should be branch always
.shift_done
	PHA		; save the shifted valte

	; make X = byte offset into FacetMasks/Values for the required filter
	LDX FacetByteOffsetTable, Y

	; Update the FacetValues table with the (shifted) value
	LDA FacetMaskTable, Y
	EOR #&FF
	AND FacetValues, X
	STA FacetValues, X
	PLA
	ORA FacetValues, X
	STA FacetValues, X

	; Update the FacetMasks table with the mask
	LDA FacetMaskTable, Y
	ORA FacetMasks, X
	STA FacetMasks, X

	RTS
}

; List all filters in human readable form
.ListFilters
{
	LDX #1
.loop
	JSR GetFilterValue
	BCS next
	LDA #FilterSeparator1
	JSR WriteFacetToScreen	; preserves X
.next
	INX
	CPX #CollectionsFilterNum + 1
	BNE loop
	RTS
}

; Looks up the filter value for the filter specificed by X
;
; On entry:
;     X = filter num (i.e. page state)
; On exit:
;     C=0 if found, A=value
;     C=1 if not found
.GetFilterValue
{
	LDA #<FacetValues
	STA Title
	LDA #>FacetValues
	STA Title + 1
	LDY FacetByteOffsetTable, X
	LDA FacetMasks, Y
	AND FacetMaskTable, X
	BEQ ExitC1
	JSR ExtractAnnotationValue
	CLC
	RTS
}

; Looks for the current filter value in the result list
; On entry:
;     X = filter num (i.e. page state)
; On exit:
;     C=0 if found, A=value, X=position in the results list (0-based)
;     C=1 if not found
; TODO: this doesn't currently handle the filter nor being set
.FindFilterItem
{
	JSR GetFilterValue
	BCS ExitC1
	STA Tmp
	LDX #&FF
.loop	INX
	LDA RowReturnMSB, X
	BMI ExitC1
	LDA RowReturnLSB, X
	CMP Tmp
	BNE loop
	CLC
	RTS
}

.ExitC1
{
	SEC
	RTS
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Annotations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Extract the filter value from the current Title
.ExtractAnnotationValue
{
.*EAVOffset
	LDY #&00
	LDA (Title), Y
	PHP
.*EAVMask
	AND #&00
.*EAVShift
	BNE P%+2
	LSR A
	LSR A
	LSR A
	LSR A
	LSR A
	LSR A
	LSR A
	PLP
	RTS
}

; Calculate a pointer to the requested annotation table, skipping the length field
; Get the address of the relevant secondary table for annotations
; - in normal mode (DisplayMode bit 7 = 0) this is used for rendering the annotation
; - in update counts mode (DisplayMode bit 7 = 1) this is where the current filter counts are maintained

; X=Annotation type
.GetAnnotationTable
{
	; Modify ExtractAnnotationValue (immediately above)
	LDA FacetByteOffsetTable, X
	STA EAVOffset + 1
	LDA FacetMaskTable, X
	STA EAVMask + 1
	LDA FacetBitOffsetTable, X
	STA EAVShift + 1
	; Lookup the address of the annotation table
	LDY #AnnotationTable
	; Fall through into
}

; Place the address of Menu Table X in 0, Y and 1, Y
; (preserving X)

.GetMenuTable
{
	TXA
	STY lsb+1
	INY
	STY msb+1
	ASL A
	ADC #2		; Skip the length field
	TAY
	LDA (MenuTablePtr),Y
.lsb
	STA &00
	INY
	LDA (MenuTablePtr),Y
.msb
	STA &01
	RTS
}


; A=Annotation id value (7 bits)
.GetAnnotationRecord
{
	ASL A
	TAY
	LDA (AnnotationTable), Y
	STA AnnotationPtr
	INY
	LDA (AnnotationTable), Y
	STA AnnotationPtr + 1
	RTS
}

; A=Annotation id value (7 bits)
.GetAnnotationString
{
	JSR GetAnnotationRecord
	CLC
	; Special case the Short Publisher table, which doesn't
	; include the two bytes of counts.
	LDA Annotation
	BEQ short_pub
	LDA #FacetValueOffset
.short_pub
	ADC AnnotationPtr
	STA TmpPtr
	LDA #0
	ADC AnnotationPtr + 1
	STA TmpPtr + 1
	RTS
}

; Accumulate the annotation counts
.AccumulateAnnotationCounts
{
	LDY Annotation
	CPY #CollectionsFilterNum
	BEQ collection

	JSR ExtractAnnotationValue

.update_count
	JSR GetAnnotationRecord
	LDY #FacetCountOffset + 1	; count is stored at offset 3 (LSB) and 2 (MSB)
	SEC
.update_loop
	LDA (AnnotationPtr),Y
	ADC #0
	STA (AnnotationPtr),Y
	DEY
	BCS update_loop			; skip back in the rare case of carry
	RTS 				; (you only get this if you search for <space>)

.collection
	LDY #CollectionsByteOffset
.collection_loop
	LDA (Title),Y
	BPL done
	AND #&7F			; TODO: Fix hard-coded mask
	STY TmpY
	JSR update_count
	LDY TmpY
	INY
	BNE collection_loop		; branch always
.done
	RTS
}

; Set the first two bytes of each annotation record to 0x80, 0x00
; We will use these to store counts of the number of search filtered items
.ClearAnnotationCounts
{
	LDX Annotation
	JSR GetAnnotationTable
	LDX #0
.loop
	TXA
	JSR GetAnnotationRecord
	BEQ done
	LDY #FacetCountOffset
	LDA #&80
	STA (AnnotationPtr),Y
IF (FacetCountOffset = 0)	; it is zero, and no plans to change this
	TYA
ELSE
	LDA #&00
ENDIF
	INY
	STA (AnnotationPtr),Y
	INX
	BNE loop
.done
	RTS
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Setup for Page Rendering
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.SetupRenderingVars
{
	LDY #1
	STY StartRow
	DEY
	STY StartRow + 1
.loop1
	CPY Page
	BEQ done1
	CLC
	LDA StartRow
	ADC LinesPerPage
	STA StartRow
	BCC nocarry
	INC StartRow + 1
.nocarry
	INY
	BNE loop1
.done1
	LDY #MaxItems - 1
	LDA #&FF
.loop2
	STA RowReturnMSB, Y
	DEY
	BPL loop2
	RTS
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Page Rendering
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.RenderExit
{
	BIT DisplayMode
	BMI exit
.loop
	; We have hit the end of the sort list
	LDA RowCount
	CMP LinesPerPage
	BCS exit
	LDY #CharsPerLine
	JSR YSpaces
	INC RowCount
	BNE loop		; Branch always
.exit
	RTS
}

; Display Mode controls behaviour
; Bit 7 - 1=disable rendering (i.e. count only)
; Bit 6 - 1=disable search/filtering
; Bit 5 - 1=highlight search matches
.RenderPage
{
	LDA SearchBuffer
	STA SearchFirst

	LDA Sort
	STA CurrentSort
	LDA Sort + 1
	STA CurrentSort + 1

	BIT DisplayMode
	BPL skip_clear_counts
	JSR ClearAnnotationCounts
.skip_clear_counts

	LDX Annotation
	JSR GetAnnotationTable

	LDY StartLine
	JSR ScreenLineY

	LDX #0
	STX RowCount
	STX TotalItems
	STX TotalItems + 1

	DEX
	STX CurrentItem
	STX CurrentItem + 1

	; Make sure FilterCount is up to date
	JSR CountFilters

	; Default to assuming we are on a facet page
	LDA #FacetValueOffset
	STA TitleNameOffset

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Start of loop that needs to be efficient
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.next_row
	INC CurrentItem
	BNE nocarry1
	INC CurrentItem + 1
.nocarry1

	; Follow the sort pointer to the title record, and increment the sort pointer
	LDY #0
	LDA (CurrentSort),Y
	STA Title
	INY
	LDA (CurrentSort),Y
	STA Title + 1

	; Test if we have run off the end of the list
	BEQ RenderExit

	; Increment CurrentSort to point to the next title
	CLC
	LDA CurrentSort
	ADC #&02
	STA CurrentSort
	BCC nocarry2
	INC CurrentSort + 1
.nocarry2

	; Test if we are rendering one of the filter pages
	BIT DisplayMode
	BVC find_title

	; Yes, so the match now becomes a non-zero facet count
	LDY #FacetCountOffset
	LDA (Title), Y
	AND #&7F
	BNE matching_row
	INY
	LDA (Title), Y
	BNE matching_row

	; The facet count is zero, so move to the next row
	BEQ next_row ; Branch always

.find_title
{
	; Find the offset to the title, by skipping over all the collections
	LDY #CollectionsByteOffset - 1
.loop
	INY
	LDA (Title),Y
	BMI loop
	STY TitleNameOffset
}

{
.search
	LDA SearchFirst
	BEQ match
	DEY
.loop1
	INY
	LDA (Title),Y
	BMI next_row
	CMP SearchFirst
	BNE loop1
	STY TmpY
	LDX #0
.loop2
	INX
	INY
	LDA SearchBuffer,X
	BEQ match
	CMP (Title),Y
	BEQ loop2
	LDY TmpY
	BNE loop1
.match
}

; Attempt to match against the currently compiled filter set
;
; If the filter includes a collection, there is a list in the title to
; try to match against. This list is terminated by a non-negative
; value (the first char of the title name)
{
.filter
	LDA FilterCount
	BEQ match
	LDY #0
.loop1
	;; TODO could code this differently and optimize Mask=0
	LDA (Title), Y
	EOR FacetValues, Y
	AND FacetMasks, Y
	BNE next_row
	INY
	CPY #CollectionsByteOffset
	BNE loop1

	LDA CollectionsFacetMask
	BEQ match		; If No Collections Filter we have a match
.loop2
	LDA (Title), Y
	BPL next_row
	EOR CollectionsFacetValue
	AND #&7F		; TODO: Fix hard-coded mask
	BEQ match
	INY
	BNE loop2		; Branch always
.match
}

.matching_row
	BIT DisplayMode
	BPL matching_row1
	; In UpdateCounts mode, add one to the appropriate facet counr
	JSR AccumulateAnnotationCounts
	JMP next_row

.matching_row1
	; Increment the count of matched items
	INC TotalItems
	BNE matching_row2
	INC TotalItems + 1

.matching_row2
	; Have we reached the required start row yet?
	SEC
	LDA TotalItems
	SBC StartRow
	LDA TotalItems + 1
	SBC StartRow+1
	BCS found_row
	JMP next_row

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; End of loop that needs to be *very efficient*
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; Found a row that matches all filter and search

.found_row
	; Have we displayed the requested number of rows
	LDA RowCount
	CMP LinesPerPage
	BNE found_row1
	JMP next_row

.found_row1
	; Store current item so that the basic program knows what's on each line
	LDY RowCount
	LDA CurrentItem
	STA RowReturnLSB, Y
	LDA CurrentItem + 1
	STA RowReturnMSB, Y

	; Increment the count of the number of rows displayed
	INC RowCount

	; Write the line at (Title) to the screen
	JSR WriteLine
	JMP next_row
}


.WriteLine
{
	; Keep track of how many chars we have available
	LDX #CharsPerLine - 3

	; Prepare the Annotation first (so we know how long it is...)

	; Test display mode to decide on normal annotion vs facet count
	BIT DisplayMode
	BVC normal_annotation

	LDY #FacetCountOffset
	LDA (Title),Y
	AND #&7F
	STA BinBuffer + 1	; MSB first (i.e. count is stored big endian)
	INY
	LDA (Title),Y
	STA BinBuffer		; LSB last
	JSR WriteCount

	LDA #<CountString
	STA TmpPtr
	LDA #>CountString
	STA TmpPtr + 1

	JMP length_of_annotation

.normal_annotation
	JSR ExtractAnnotationValue
	; ExtractAnnotationValue flags set based on BYTE read from memory
	; "Null collection" is indicated by a positive value AND the current Annotation being a Collection
	BMI not_null_collection
	LDY Annotation
	CPY #CollectionsFilterNum
	BNE not_null_collection

	; CollectionIDs in memory always have bit 7 set
	; If bit 7 is clear, there is no collection
	LDA #<null_collection_message
	STA TmpPtr
	LDA #>null_collection_message
	STA TmpPtr + 1
	BNE length_of_annotation

.null_collection_message
	; Currently just blank, a string like "NO COLLECTION" could be put here
	EQUB &ff

.not_null_collection
	; Currently the MSB of the annotation is lost, which limits secondary tables to 7 bit values
	JSR GetAnnotationString

	; Measure length of the annotation, so the title can be truncated if needed
.length_of_annotation
	LDY #0
.loop
	LDA (TmpPtr),Y
	BMI done
	INY
	DEX
	BNE loop
.done

	; Write the row letter (A..M)
	CLC
	LDA #'A' - 1
	ADC RowCount
	JSR WriteToScreen
	LDA #'.'
	JSR WriteToScreen

	; Determine if the title needs the search string highlighting
	LDA SearchFirst
	BEQ no_highlight
	LDA DisplayMode
	AND #DMHighlightMatches
	BEQ no_highlight

	; There is an active search filter, so try to highlight
	JSR WriteTitleHighlight	    	    ; TODO: Could inline this
	JMP write_separator

.no_highlight
	; There is no active search filter, so don't try to highlight
	JSR WriteTitleNoHighlight   	    ; TODO Could inline this

	; Write the seperator and padding
.write_separator
	TXA
	TAY
	INY
	JSR YSpaces

	; Write the annotation
	JMP ScreenStringTmpPtr
}

.WriteTitleNoHighlight
	LDY TitleNameOffset
.WriteTitleNoHighlightOffsetY
{
.loop
	LDA (Title),Y
	BMI done
	JSR WriteToScreen
	INY
	DEX
	BNE loop
.done
	RTS
}

.WriteTitleHighlight
{
	STX TmpX
	LDY TitleNameOffset
.write_loop
	LDA (Title),Y
	BMI done
	CMP SearchFirst
	BEQ possible_match
.continue
	JSR WriteToScreen
	INY
	DEC TmpX
	BNE write_loop
.done
	LDX TmpX
	RTS

.possible_match
	PHA
	TYA
	PHA
	LDX #0
.match_loop
	INX
	INY
	LDA SearchBuffer,X
	BEQ match
	LDA (Title),Y
	BMI no_match
	CMP SearchBuffer,X
	BEQ match_loop

.no_match
	PLA
	TAY
	PLA
	JMP continue

.match
	PLA
	TAY
	PLA
.highlight_loop
	LDA (Title),Y
	ORA #&80
	JSR WriteToScreen
	INY
	DEC TmpX
	BEQ done
	DEX
	BNE highlight_loop
	BEQ write_loop
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Screen Handling Code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; Converts the 16-bit value in &BinBuffer to "(" <Decimal String> ")" <CR> at Buffer
.WriteCount
{
	TXA
	PHA
	LDA #'('
	STA CountString
	LDX #1
	JSR WriteDecimal
	CPX #1
	BNE not_zero
	LDA #'0'
	STA CountString,X
	INX
.not_zero
	LDA #')'
	STA CountString,X
	INX
	LDA #&80
	STA CountString,X
	PLA
	TAX
	RTS
}

.WriteDecimal
{
	JSR BinToDecimal16
	; Set the flag to support suppression of leading zeros
	STY SuppressFlag
	LDY #2
	; Output the BcdBuffer digits, MS first
.loop
	LDA BcdBuffer,Y
	JSR WriteHex
	DEY
	BPL loop
	RTS
}

.BinToDecimal16
{
	LDA #0
	STA BcdBuffer
	STA BcdBuffer+1
	STA BcdBuffer+2
	SED
	LDY #16
.loop
	; Handle the binary bits one at a time
	ASL BinBuffer
	ROL BinBuffer+1
	; Add into the BCD accumulator
	LDA BcdBuffer
	ADC BcdBuffer
	STA BcdBuffer
	LDA BcdBuffer+1
	ADC BcdBuffer+1
	STA BcdBuffer+1
	LDA BcdBuffer+2
	ADC BcdBuffer+2
	STA BcdBuffer+2
	DEY
	BNE loop
	CLD
	LDA BcdBuffer
	RTS
}

.WriteHex
{
	PHA
	LSR A
	LSR A
	LSR A
	LSR A
	JSR WriteHex1
	PLA
	; fall through to
}

.WriteHex1
{
	AND #&0F
	BNE hex1
	; Suppress leading zero
	BIT SuppressFlag
	BPL done
.hex1
	; Make sure bit 7 of SuppressFlag is set, so we don't suppress further zeros
	SEC
	ROR SuppressFlag
	CMP #10
	BCC hex2
	ADC #6
.hex2
	ADC #'0'
	STA CountString,X
	INX
.done
	RTS
}

IF (econet = 1)
.WritePath
{
	SEC
	ROR SuppressFlag
	LDA BinBuffer + 1
	JSR WriteHex1
	LDA #DirSep
	STA OscliBuffer, X
	INX
	LDA BinBuffer
	PHA
	LSR A
	LSR A
	LSR A
	LSR A
	JSR WriteHex1
	LDA #DirSep
	STA OscliBuffer, X
	INX
	PLA
	JMP WriteHex1
}
ELIF (gosdc = 1)
.WritePath
{
	SEC
	ROR SuppressFlag
	LDA #'E'
	STA OscliBuffer, X
	INX
	LDA BinBuffer + 1
	JSR WriteHex1
	LDA BinBuffer
	JMP WriteHex
}
ENDIF

.HighlightItem
{
	LDA Item
	CLC
	ADC StartLine
	TAY
	; Fall through to...
}

.HighlightRowY
{
	JSR ScreenLineY
	LDY #&1F
.loop2
	LDA (Screen),Y
	EOR #&80
	STA (Screen),Y
	DEY
	BPL loop2
	RTS
}


; A = seperator string number
; X = facet number
; Facet Value read from (Title)
.WriteFacetToScreen
{
	PHA			; save seperator

 	JSR GetAnnotationTable	; Preserves X

	LDY PadTable, X
	JSR YSpaces		; preserves X

	JSR ScreenStringX	; preserves X

	STX TmpX
	PLA
	TAX
	JSR ScreenStringX
	LDX TmpX

	JSR ExtractAnnotationValue  ; Preserves X, result in A

	JSR GetAnnotationString ; Preserves X, result in TmpPtr

	JSR ScreenStringTmpPtr
	;; Fall through to PadToEOL
}

.PadToEOL
{
	LDA #CharsPerLine
	SEC
	SBC Screen
	AND #CharsPerLine - 1
	TAY
	; Fall through to
}

.YSpaces
{
.loop
	DEY
	BMI done
	LDA #' '
	JSR WriteToScreen	; preserves X, Y
	BNE loop		; Z set by WriteToScreen based on Y
.done
	RTS
}

.ScreenLineY
{
	TYA
	ASL A
	ASL A
	ASL A
	ASL A
	ASL A
	STA Screen
	LDA #>ScreenStart
	ADC #0
	STA Screen + 1
	RTS
}

.ScreenStringX
{
	LDY StringTable, X
.loop
	LDA StringBase, Y
	BMI done
	JSR WriteToScreen
	INY
	BNE loop
.done
	; Print the last character
	AND #&7F    	; TODO: Could always do this in WriteToScreen
	; Fall throught to
}

.WriteToScreen
{
	STY TmpY
	LDY #0
	AND #&BF
	STA (Screen),Y
	INC Screen
	BNE done
	; Ensure we don't overwrite the tables!
	LDA Screen + 1
	EOR #&01
	STA Screen + 1
.done
	LDY TmpY
	RTS
}

.ScreenStringTmpPtr
{
	LDY #0
.loop
	LDA (TmpPtr),Y
	BMI done
	JSR WriteToScreen
	INY
	BNE loop
.done
	RTS
}

.StringTable
	EQUB String0 - StringBase
	EQUB String1 - StringBase
	EQUB String2 - StringBase
	EQUB String3 - StringBase
	EQUB String4 - StringBase
	EQUB String5 - StringBase
	EQUB String6 - StringBase
	EQUB String7 - StringBase
	EQUB String8 - StringBase
	EQUB String9 - StringBase
	EQUB String10 - StringBase
	EQUB String11 - StringBase
	EQUB String12 - StringBase
	EQUB String13 - StringBase
	EQUB String14 - StringBase


; Padding for the first 9 strings
.PadTable
	EQUB FilterPad - LEN(TitleName)
	EQUB FilterPad - LEN(PubFilterName)
	EQUB FilterPad - LEN(GenreFilterName)
	EQUB FilterPad - LEN(ChunkFilterName)
	EQUB FilterPad - LEN(RamFilterName)
	EQUB FilterPad - LEN(RomFilterName)
	EQUB FilterPad - LEN(VersionFilterName)
	EQUB FilterPad - LEN(JoystickFilterName)
	EQUB FilterPad - LEN(CollectionsFilterName)

.StringBase

.String0
	EQUS LEFT$(TitleName, LEN(TitleName) - 1), ASC(RIGHT$(TitleName, 1)) + &80

.String1
	EQUS LEFT$(PubFilterName, LEN(PubFilterName) - 1), ASC(RIGHT$(PubFilterName, 1)) + &80

.String2
	EQUS LEFT$(GenreFilterName, LEN(GenreFilterName) - 1), ASC(RIGHT$(GenreFilterName, 1)) + &80

.String3
	EQUS LEFT$(ChunkFilterName, LEN(ChunkFilterName) - 1), ASC(RIGHT$(ChunkFilterName, 1)) + &80

.String4
	EQUS LEFT$(RamFilterName, LEN(RamFilterName) - 1), ASC(RIGHT$(RamFilterName, 1)) + &80

.String5
	EQUS LEFT$(RomFilterName, LEN(RomFilterName) - 1), ASC(RIGHT$(RomFilterName, 1)) + &80

.String6
	EQUS LEFT$(VersionFilterName, LEN(VersionFilterName) - 1), ASC(RIGHT$(VersionFilterName, 1)) + &80

.String7
	EQUS LEFT$(JoystickFilterName, LEN(JoystickFilterName) - 1), ASC(RIGHT$(JoystickFilterName, 1)) + &80

.String8
	EQUS LEFT$(CollectionsFilterName, LEN(CollectionsFilterName) - 1), ASC(RIGHT$(CollectionsFilterName, 1)) + &80

.String9
	EQUS "FILTER BY", (' ' + &80)

.String10
	EQUS "SORTED BY", (' ' + &80)

.String11
	EQUS "  PAG", ('E' + &80)

.String12
	EQUS "  SEARCH", ('=' + &80)

.String13
	EQUS ('=' + &80)

.String14
	EQUS ":", (' ' + &80)


include "common.asm"

.ENDOF

SAVE STARTOFHEADER, ENDOF
