	Base =? &2800

include "sysvars.asm"

include "chaptervars.asm"

	org Base - 22

	guard Base + &B00

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
	; vvvvvvvv IMPORTANT: This code gets clobbered by the row return buffer

	JSR OscliString
	EQUS "LOAD MENU1", Return

	LDA ExecAddr
	STA MenuTablePtr
	LDA ExecAddr + 1
	STA MenuTablePtr + 1

	JSR OscliString
	EQUS "LOAD MENU2", Return

	; ^^^^^^^^ IMPORTANT code gets clobbered by the row return buffer

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
	JSR ClearFilterY	; Y=0 clears all filters

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Main command loop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.main_loop_page_state_zero
	; Reset back to the title page, and refresh everything
	LDA #0
	STA PageState

.main_loop_redo_counts

	; Update the annotation to point to this facet
	LDY PageState
	BEQ main_loop_redo_sizes
	LDA Annotation
	PHA
	STY Annotation
	; Make sure the title table is used, not the facet table
	LDA SortTablePtr
	STA Sort
	LDA SortTablePtr + 1
	STA Sort + 1
	; Recalculate Annotation counts the new filter screen
	LDA #DMUpdateCounts
	STA DisplayMode
	JSR RenderPage
	; Restore the original annotation the user has chose (to see on the title page)
	PLA
	STA Annotation

.main_loop_redo_sizes
	; Calculate LinesPerPage and StartLine from FilterType
	JSR CalculateTextWindow

.main_loop_reset_position
	; Reset the page/item back to the start
	LDY #&00
	STY Item
	INY
	STY Page

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

	; Calculate the number of pages (from Total Rows)
	JSR CalculateNumPages
	STY NumPages

	; Update the PAGE M and N
	JSR UpdateTotalPages	; TODO This also call CalculateNumPages which is wasteful

	; Highlight the currently active item
	JSR HighlightItem

.main_loop_release
	; Wait for key release, or for auto repeat to start
	JSR HandleAutoRepeat

.main_loop_scan
	; Check for original Atom
	LDA &bd00
	CMP #&bf
	BNE test_for_up_key_original

	; Test if shift key is pressed (emulator, scroll up)
	BIT &b001
	BMI test_for_down_key
	BPL handle_up_key

.test_for_up_key_original
	; Test if ctrl key is pressed (original atom, scroll up)
	BIT &b001
	BVS test_for_down_key

.handle_up_key
	; Handle the up key, decrementing item
	LDA Item
	BEQ handle_up_to_previous_page
	JSR HighlightItem
	DEC Item
	JSR HighlightItem
	BMI main_loop_release	; Branch always

.handle_up_to_previous_page
	; Handle the up key when at the top of a page
	LDA Page
	CMP #1
	BEQ main_loop_release
	DEC Page
	JSR HighlightItem
	LDX LinesPerPage
	DEX
	STX Item
	BNE main_loop_render			; Branch always

.test_for_down_key
	; Check for original Atom
	LDA &bd00
	CMP #&bf
	BNE test_for_down_key_original

	; Test if ctrl key is pressed (emulator, scroll down)
	BIT &b001
	BVC handle_down_key
	BVS call_inkey		; Branch always

.test_for_down_key_original
	; Test if shift key is pressed (original atom, scroll down)
	BIT &b001
	BMI call_inkey

.handle_down_key
	; Handle down key, incrementing item
	LDX Item
	INX
	CPX LinesPerPage
	BEQ handle_down_to_next_page
	JSR TestRowXActive
	BEQ handle_down_to_next_page
	JSR HighlightItem
	INC Item
	JSR HighlightItem
	JMP main_loop_release

.handle_down_to_next_page
	; Handle down key when at the bottom of a page
	LDA Page
	CMP NumPages
	BEQ main_loop_release
	INC Page
.set_item_to_zero
	JSR HighlightItem
	LDA #0
	STA Item
	JMP main_loop_render			; Branch always

.call_inkey
	; Call InKey to scan the keyboard
	JSR Inkey

	CPY #&FF
	BEQ main_loop_scan			; Branch of no key pressed

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
	EQUS "DIR &", Return
ELSE
	EQUS "CWD /", Return
ENDIF
	JSR OscliString
	EQUS "RUN MENU", Return
	; never returns

.test_for_filter
	; 0 (16) = title; 1..N = filter
	CPY #16					; 0
	BCC test_for_prev_sort
	CPY #16+NumFacets+1			; 8
	BCS test_for_prev_sort
	TYA
	SBC #15
	; At this point A=0, or 1..N
	BNE change_filter

	; Clear filter
	LDY PageState
	TYA
	ORA FilterType
	BEQ jump_main_loop_release		; nothing to do!
	JSR ClearFilterY			; Y=0 clears all filters, Y<>0 clean filter N
	JMP main_loop_redo_counts

.change_filter
	; Filter 1..8
	STA PageState
	JMP main_loop_redo_counts

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
	BNE test_for_prev_page
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

.test_for_prev_page
	CPY #28					; <
	BNE test_for_next_page
	; Handle previous page
	LDA NumPages				; special case there being just one page
	CMP #1
	BEQ jump_main_loop_release
	DEC Page
	BNE prev_page_nowrap
 	STA Page
.prev_page_nowrap
 	JMP set_item_to_zero

.test_for_next_page
	CPY #30					; >
	BNE test_for_prev_tag
	; Handle next page
	LDA NumPages				; special case there being just one page
	CMP #1
	BEQ jump_main_loop_release
	INC Page
	LDA NumPages
	CMP Page
	BCS next_page_nowrap
	LDA #1
	STA Page
.next_page_nowrap
	JMP set_item_to_zero

.jump_main_loop_release
	JMP main_loop_release

.test_for_prev_tag
	LDA PageState				; Tags not used in filter pages
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
	BNE test_for_help
	; Handle next tag
	INX
	CPX #NumFacets + 1
	BNE change_tag
	LDX #0

.change_tag
	STX Annotation
	JMP main_loop_render

.test_for_help
	CPY #31					; /
	BNE test_for_select
	; Handle help screen
	JSR HelpScreen
	JMP main_loop_render_all		; redraw the whole screen, but counts will be unchanged

.test_for_select
	; Test for select
	CPY #0	      	      	      	      	; <Space>
	BEQ handle_select
	CPY #Return				; <Return>
	BEQ handle_select

	; Test for search
	CPY #51					; S
	BNE test_for_a_to_m
	; Handle search
	LDA PageState
	BNE test_for_a_to_m
	JSR HighlightItem
	LDA #1
	STA Page
	JSR SetupRenderingVars
	JSR Search
	JMP main_loop_redo_counts

.test_for_a_to_m
	; A..M key pressed (select an item)
	CPY #33					; A
	BCC jump_main_loop_release
	CPY #46					; M + 1
	BCS jump_main_loop_release

	; Make sure that the row is not blank
	; 670 Y=?Q-33;IF ?(#8040+Y*32)=32 G.c
	TYA
	SBC #32
	TAX
	JSR TestRowXActive
	BEQ jump_main_loop_release
	STX Item

.handle_select
	; Test whether we are on the title page or a filter page
	LDY PageState
	BEQ boot_program

	; Filter page, so add the filter
	LDX Item
	LDA RowReturnLSB, X
	JSR AddFilterY				; Y = FilterType, A = FilterValue
	JMP main_loop_page_state_zero

.boot_program
	JSR GetItemAddress

   	; If info option is enabbled, then first show the info screen
IF (info_option = 1)
   	JSR InfoScreen
	CMP #&1B
	BNE boot_continue
	JSR ClearScreen
	JMP main_loop_render_all
.boot_continue
	JSR GetItemAddress
ENDIF
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Really Boot the Program!
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

{
	; Dereference the title to get the 11-bit index number
	LDX #Title
	JSR Dereference

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
	JSR ClearScreen

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
	EQUS "DIR &.ASA.",0

ELSE

.run_command
	EQUS "RUN ", 0

ENDIF
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Support code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.Inkey
{
	JSR &FE71
	BCC done
	LDY #&ff
.done
	RTS
}

; Translates the Item index (in the RowReturn buffer) to a record address
.GetItemAddress
{
	LDY Item		; Item starts at 0
	LDA RowReturnLSB, Y	; RowReturnBuffer stores the item index
	ASL A
	STA Title
	LDA RowReturnMSB, Y
	ROL A
	STA Title + 1		; Title now (item << 1)

	CLC			; Now indirect through the sort table
	LDA Title
	ADC Sort
	STA Title
	LDA Title + 1
	ADC Sort + 1
	STA Title + 1

	LDX #Title
	JMP Dereference
}

; Test if row X (0 based) is active
.TestRowXActive
{
	LDA RowReturnMSB, X
	CMP #&FF
	RTS
}

; Dereferences the pointer at zero page location X,X+1
.Dereference
{
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

; Handles auto repeat
.HandleAutoRepeat
{
	LDA AutoRepeat
	STA Tmp
.loop
	JSR WaitUntilVSync
	JSR Inkey
	CPY #255
	BNE pressed
	BIT &b001
	BPL pressed
	BVS released
.pressed
	DEC Tmp
	BNE loop
	; Key was not released
	; Update the auto repeat timer to the repeat value
	LDA #AutoRepeat2
	STA AutoRepeat
	RTS
.released
	; Key was released
	; Update the auto repeat timer to the delay value
	LDA #AutoRepeat1
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
	LDA FilterType
	LDX #&FF
.loop1
	INX
.loop2
	ASL A
	BCS loop1
   	BNE loop2
	TXA
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
; set, whose size is in TotalItems, by inefficiently dividing by
; TotalItem by LinesPerPage.
; Returns the number of pages in BCD in A, and in Binary in Y
.CalculateNumPages
{
	SEC
	LDA TotalItems
	SBC #1
	STA BinBuffer
	LDA TotalItems + 1
	SBC #0
	STA BinBuffer+1
	BCC return_one_page

	LDY #0
	TYA
.loop
	INY
	SED
	CLC
	ADC #1
	CLD
	PHA
	SEC
	LDA BinBuffer
	SBC LinesPerPage
	STA BinBuffer
	LDA BinBuffer+1
	SBC #0
	STA BinBuffer+1
	PLA
	BCS loop
	RTS

.return_one_page
	LDY #1
	TYA
	RTS
}

; Refreshes the Page M OF N text in the top line
.UpdateTotalPages
{
	; Write Page to the CountString
	LDA Page
	STA BinBuffer
	LDA #0
	STA BinBuffer+1

	JSR BinToDecimal8

	; X is used as the index into CountString
	LDX #0

	; Make sure that we don't suppress zeros
	LDY #&FF
	STY SuppressFlag

	JSR WriteHex

	; Write the page separator into CountString
	LDA #'/'
	LDX #2
	STA CountString, X

	JSR CalculateNumPages

	; Write the number of pages into to the CountString
	LDX #3
	JSR WriteHex

	LDX #0
.loop
	LDA CountString,X
	AND #&3F
	ORA #&80
	STA ScreenStart + CharsPerLine - 5, X
	INX
	CPX #5
	BNE loop
	RTS
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Render Page Header
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.RenderHeader
{
	; Clear the top half of the screen
	LDY #0
	LDA #' '
.loop
	STA ScreenStart,Y
	INY
	BNE loop

	; Setup the screen pointer to top left
	LDA #<ScreenStart
	STA Screen
	LDA #>ScreenStart
	STA Screen + 1

	; Title page or Filter page?
	LDA PageState
	BEQ title_page

.filter_page
	; Filter page, print FILTER BY
	LDX #9
	JSR ScreenStringX

	; Set Sort to the start of the pointer list in the secondary table
	LDA PageState
	ASL A
	ADC #2
	ADC MenuTablePtr
	STA Sort
	LDA MenuTablePtr + 1
	ADC #0
	STA Sort + 1
	LDX #Sort
	JSR Dereference

	; Prepare for printing the filter facet name
	LDX PageState
	BNE facet	; branch always

.title_page
	; Title page, print SORTED BY
	LDX #10
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

	; Print PAGE  OF
	LDX #11
	JSR ScreenStringX

	; Test if there is an active filter
	LDA FilterType
	BEQ done

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
	JMP SearchExit

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
	LDA #<(ScreenStart + &1E0)
	STA Screen
	LDA #>(ScreenStart + &1E0)
	STA Screen + 1

	; Write "  SEARCH="
	LDX #12
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

IF (info_option = 1)

.InfoScreen
{
	JSR OscliString
	EQUS "LOAD INFO", Return

	; Metata starts on line 4
	LDA #<(ScreenStart + 4 * CharsPerLine)
	STA Screen
	LDA #>(ScreenStart + 4 * CharsPerLine)
	STA Screen + 1

	LDX #1
.filter_loop1
	JSR WriteFacetToScreen
	INX
	CPX #CollectionsFilterNum
	BNE filter_loop1

.filter_loop2
	LDY #CollectionsByteOffset
	LDA (Title), Y
	BPL title
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

	LDY #CollectionsByteOffset
.title_loop2
	LDA (Title),Y
	BMI title_done2
	JSR WriteToScreen
	INY
	BNE title_loop2

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
	JSR Osrdch
	; fall though to
}

.ClearScreen
{
	LDA #12
	JMP Oswrch
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Multi Facet Filter Workspace
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; TODO: Move these out of code into some external buffer space

.FacetMasks
FOR i, 0, CollectionsByteOffset - 1, 1
	EQUB &00
NEXT
.CollectionsFacetMask
	EQUB &00

.FacetValues
FOR i, 0, CollectionsByteOffset - 1, 1
	EQUB &00
NEXT
.CollectionsFacetValue
	EQUB &00

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Multi Facet Filter Fixed Data
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.FilterTypeMask
	EQUB &01, &02, &04, &08
	EQUB &10, &20, &40, &80


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

.FacetXorTable
	EQUB PubXor
	EQUB PubXor
	EQUB GenreXor
	EQUB ChunkXor
	EQUB RamXor
	EQUB RomXor
	EQUB VersionXor
	EQUB JoystickXor
	EQUB CollectionsXor

;; This is a table of branch offsets used in some self modifying code
;; to avoid the cost of a loop:
;;     vvvvvv is modified based on the table value
;; BNE offset
;; LSR A        ; offset 0 shifts 7 bits
;; LSR A	; offset 1 shifts 6 bits
;; LSR A	; offset 2 shifts 5 bits
;; LSR A	; offset 3 shifts 4 bits
;; LSR A	; offset 4 shifts 3 bits
;; LSR A	; offset 5 shifts 2 bits
;; LSR A	; offset 6 shifts 1 bits
;; RTS 		; offset 7 shifts 0 bits

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
.ClearFilterY
{
	CPY #0
	BNE clear_y
	LDY #CollectionsFilterNum
.loop
	JSR clear_y
	DEY
	BNE loop
	RTS
.clear_y
	LDA FilterTypeMask - 1, Y
	EOR #&FF
	AND FilterType
	STA FilterType
	LDX FacetByteOffsetTable, Y
	LDA FacetMaskTable, Y
	EOR #&FF
	AND FacetMasks, X
	STA FacetMasks, X
	; Note, the FacetValue is irrelevant when the mask is zero
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

	; Maintain the bit-per-filter FilterType map for expendiency
	LDA FilterTypeMask - 1, Y
	ORA FilterType
	STA FilterType
	RTS
}

; List all filters in human readable form
.ListFilters
{
	LDA #<FacetValues
	STA Title
	LDA #>FacetValues
	STA Title + 1
	LDX #1
.loop
	LDY FacetByteOffsetTable, X
	LDA FacetMaskTable, X
	AND FacetMasks, Y
	BEQ next
	JSR WriteFacetToScreen	; preserves X
.next
	INX
	CPX #CollectionsFilterNum + 1
	BNE loop
	RTS
}

;; Extract the filter value from the current Title
;; TODO: could self modification could be done less often?
.ExtractFilterValue
{
	LDA FacetBitOffsetTable, Y
	STA shift + 1
	LDA FacetMaskTable, Y
	STA mask + 1
	LDA FacetXorTable, Y
	STA xor + 1
	LDA FacetByteOffsetTable, Y
	TAY
	LDA (Title), Y
.mask
	AND #&00
.xor
	EOR #&00
.shift
	BNE P%+2
	LSR A
	LSR A
	LSR A
	LSR A
	LSR A
	LSR A
	LSR A
	RTS
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Annotations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; Calculate a pointer to the requested annotation table, skipping the length field
; Get the address of the relevant secondary table for annotations
; - in normal mode (DisplayMode bit 7 = 0) this is used for rendering the annotation
; - in update counts mode (DisplayMode bit 7 = 1) this is where the current filter counts are maintained

; X=Annotation type
.GetAnnotationTable
{
	TXA
	ASL A
	TAY
	INY
	INY
	LDA (MenuTablePtr),Y
	STA AnnotationTable
	INY
	LDA (MenuTablePtr),Y
	STA AnnotationTable + 1
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
	LDA Annotation
	BEQ short_pub
	LDA #FacetTitleOffset
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

	JSR ExtractFilterValue

.update_count
	JSR GetAnnotationRecord
	LDY #FacetWorkingOffset + 1	; count is stored at offset 3 (LSB) and 2 (MSB)
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
.loop
	LDY #0
	LDA (AnnotationTable), Y
	STA Tmp
	INY
	LDA (AnnotationTable), Y
	STA Tmp + 1
	BEQ done
	LDY #FacetWorkingOffset
	LDA #&80
	STA (Tmp),Y
	INY
	LDA #&00
	STA (Tmp),Y
	CLC
	LDA AnnotationTable
	ADC #&02
	STA AnnotationTable
	BCC loop
	INC AnnotationTable + 1
	BNE loop
.done
	RTS
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Setup for Page Rendering
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.SetupRenderingVars
{
	LDY #0
	STY StartRow + 1
	INY
	STY StartRow
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
	LDY #&0F
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
.loop1
	; We have hit the end of the sort list
	LDA RowCount
	CMP LinesPerPage
	BEQ exit
	LDX #CharsPerLine
.loop2
	LDA #' '
	JSR WriteToScreen
	DEX
	BNE loop2
	INC RowCount
	BNE loop1
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

	; Default to assuming we are on a facet page
	LDA #FacetTitleOffset
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
	LDY #FacetWorkingOffset
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
	LDA FilterType
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

	LDY #FacetWorkingOffset
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
	LDY Annotation
	JSR ExtractFilterValue

	BPL not_null_collection

	; CollectionIDs always have bit 7 set
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
	LDA #' '
.write_separator_loop
	JSR WriteToScreen
	DEX
	BPL write_separator_loop

	; Write the annotation
	JMP ScreenString
}

.WriteTitleNoHighlight
{
	LDY TitleNameOffset
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

.WriteToScreen
{
	PHA
	STY TmpY
	LDY #0

	AND #&BF
	STA (Screen),Y
	INC Screen
	BNE nocarry
	INC Screen + 1
	; Ensure we don't overwrite the tables!
	LDA Screen + 1
	AND #&81
	STA Screen + 1
.nocarry
	LDY TmpY
	PLA
	RTS
}

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

.BinToDecimal8
{
	LDA #0
	STA BcdBuffer
	STA BcdBuffer+1
	SED
	LDY #8
.loop
	; Handle the binary bits one at a time
	ASL BinBuffer
	; Add into the BCD accumulator
	LDA BcdBuffer
	ADC BcdBuffer
	STA BcdBuffer
	LDA BcdBuffer+1
	ADC BcdBuffer+1
	STA BcdBuffer+1
	DEY
	BNE loop
	CLD
	LDA BcdBuffer
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
	PHA
	LSR A
	LSR A
	LSR A
	LSR A
	JSR WriteHex1
	PLA
	JMP WriteHex1
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
	LDY #2
.loop1
	JSR WaitUntilVSync
	DEY
	BNE loop1

	LDY #&1F
.loop2
	LDA (Screen),Y
	EOR #&80
	STA (Screen),Y
	DEY
	BPL loop2
	RTS
}


; X = facet number
; Facet Value read from (Title)
.WriteFacetToScreen
{
 	JSR GetAnnotationTable	; Preserves X

	LDY PadTable, X
	JSR YSpaces		; preserves X

	JSR ScreenStringX	; preserves X

	LDA #':'
	JSR WriteToScreen	; preserves A, X, Y
	LDA #' '
	JSR WriteToScreen	; preserves A, X, Y

	TXA
	TAY
	JSR ExtractFilterValue  ; Preserves X, result in A

	JSR GetAnnotationString ; Preserves X, result in TmpPtr

	JSR ScreenString
	;; Fall through to PadToEOL
}

.PadToEOL
{
.loop
	LDA Screen
	AND #&1F
	BEQ done
	LDA #' '
	JSR WriteToScreen
	BNE loop
.done
	RTS
}

.YSpaces
{
	LDA #' '
.loop
	DEY
	BMI done
	JSR WriteToScreen	; preserves A, X, Y
	BNE loop
.done
	RTS
}

.ScreenLineY
{
	LDA #<(ScreenStart)
	STA Screen
	LDA #>(ScreenStart)
	STA Screen+1
	TYA
	ASL A
	ASL A
	ASL A
	ASL A
	ASL A
	BCC nocarry
	INC Screen+1
.nocarry
	CLC
	ADC Screen
	STA Screen
	RTS
}

.ScreenStringX
{
	LDA StringTableLSB, X
	STA TmpPtr
	LDA StringTableMSB, X
	STA TmpPtr + 1
	; fall through to
}

.ScreenString
{
	LDY #0
.loop
	LDA (TmpPtr),Y
	BMI done
	BEQ done
	JSR WriteToScreen
	INY
	BNE loop
.done
	RTS
}

.StringTableLSB
	EQUB <String0
	EQUB <String1
	EQUB <String2
	EQUB <String3
	EQUB <String4
	EQUB <String5
	EQUB <String6
	EQUB <String7
	EQUB <String8
	EQUB <String9
	EQUB <String10
	EQUB <String11
	EQUB <String12

.StringTableMSB
	EQUB >String0
	EQUB >String1
	EQUB >String2
	EQUB >String3
	EQUB >String4
	EQUB >String5
	EQUB >String6
	EQUB >String7
	EQUB >String8
	EQUB >String9
	EQUB >String10
	EQUB >String11
	EQUB >String12

; Padding for the first 9 strings
.PadTable
	EQUB 5, 1, 5, 3, 0, 0, 3, 2, 0

.String0
	EQUS "TITLE", 0

.String1
	EQUS "PUBLISHER", 0

.String2
	EQUS "GENRE", 0

.String3
	EQUS "CHAPTER", 0

.String4
	EQUS "RAM NEEDED", 0

.String5
	EQUS "ROM NEEDED", 0

.String6
	EQUS "UPDATED", 0

.String7
	EQUS "JOYSTICK", 0

.String8
	EQUS "COLLECTION", 0

.String9
	EQUS "FILTER BY ", 0

.String10
	EQUS "SORTED BY ", 0

.String11
	EQUS "  PAGE   /  ", 0

.String12
	EQUS "  SEARCH=", 0

include "common.asm"

.ENDOF

SAVE STARTOFHEADER, ENDOF
