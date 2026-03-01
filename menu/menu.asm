Base =? $2800

include "sysvars.asm"

include "menuvars.asm"

	org Base - 22

	guard &3C00

.STARTOFHEADER

; 22 byte ATM header

	EQUS    "MENU"

	EQUB    $00
	EQUB    $00
	EQUB    $00
	EQUB    $00
	EQUB    $00
	EQUB    $00
	EQUB    $00
	EQUB    $00
	EQUB    $00
	EQUB    $00
	EQUB    $00
	EQUB    $00

	EQUB    <Base
	EQUB    >Base

	EQUB    <Base
	EQUB    >Base

	EQUW	ENDOF - STARTOF

.STARTOF

.Menu
	; Minimum checks for a 12K Atom
	LDX #>TextBuffer        ; Test 3000 to 3BFF
	LDY #&3B
	JSR MemTest
	BCS Bail

	LDX #&80                ; Test 8000 to 97FF
	LDY #&97
	JSR MemTest
	BCC MeetsMinimum

.Bail
	LDX #0
.BailLoop
	LDA BailMessage, X
	BEQ BailExit
	JSR Oswrch
	INX
	BNE BailLoop
.BailExit
	JMP $c2b2

.BailMessage
	EQUB 12
	EQUS "THE ATOM SOFTWARE ARCHIVE NEEDS "
	EQUS "A MINIMUM OF 12K OF RAM TO RUN! "
	EQUB 0

.StrikeLenTable
	EQUB 13
	EQUB 19
	EQUB 23
	EQUB 17
	EQUB 22
	EQUB 15
	EQUB 13
	EQUB 0

.MeetsMinimum

	; Test for a RomRam board
	JSR RamRomTest

	; Work around for issue with older versions of AtomMMC on some titles (e.g. SUB HUNT)
	LDA #<KernelOsrdch
	STA RDCVEC
	LDA #>KernelOsrdch
	STA RDCVEC + 1

	LDA #0			; All chapters enabled
	STA KeyFlag

	LDA #&80		; Assume the screen is present
	STA HiMemBot

	LDX #&80                ; Test 8000 to AFFF
	LDY #&AF
	JSR MemTest
	STA HiMemTop

	LDX #>TextBuffer        ; Test 3000 to 7FFF
	LDY #&7F
	JSR MemTest
	STA LoMemTop

	LDX #&27                ; Test 27FF downto 2200
	LDY #&22
	JSR MemTest
	STA LoMemBot
	BCS SkipVeryLowRam
	LDX #&1F                ; Test 1FFF downto 0000
	LDY #&00
	JSR MemTest
	STA LoMemBot

.SkipVeryLowRam

	; Render the test results text panel

IF (banner_scroll = 1)
	LDA #&00
	STA Cycle
	LDA #&00		; Make this negative to delay panel startup
	STA Cycle + 1
ENDIF

	; The AGD chapter needs Video RAM up to 9FFF
	LDA HiMemTop
	CMP #&9F
	BCC DisableAGDChapter

	; The AGD chapter needs Main RAM up to 7FFF
	LDA LoMemTop
	CMP #&7F
	BCC DisableAGDChapter

	; The AGD chapter needs Main RAM down to 0300
	LDA LoMemBot
	CMP #&03
	BCC EnableAGDChapter

.DisableAGDChapter
	LDA KeyFlag
	ORA #(1<<AGDChapter)
	STA KeyFlag

.EnableAGDChapter

	; The ALL chapter needs Main RAM up to 7FFF
	LDA LoMemTop
	CMP #&7F
	BCC DisableALLChapter

	; The All chapter needs Main RAM down to 1000
	LDA #LoMemBot
	CMP #&10
	BCS EnableALLChapter

.DisableALLChapter
	LDA KeyFlag
	ORA #(1<<ALLChapter)
	STA KeyFlag

.EnableALLChapter

IF (econet = 1 OR gosdc = 1)
	JSR OscliString
	EQUS "DIR $.ASA", Return
	;JSR OscliString
	;EQUS "LIB $.ATOMLIB", Return
ELSE
IF (atommc = 1)
	JSR OscliString
	EQUS "CWD ASA", Return
ENDIF
	; 10 *NOMON
	JSR OscliString
	EQUS "NOMON", Return
ENDIF

	; 20 CLEAR 4
	LDY #4
	JSR Clear

	; 30 *LOAD SPLASH
	JSR OscliString
	EQUS "LOAD SPLASH", Return

	; Visibly strike out disabled chapters
	; This is a bit of a hack, as it depends on hard coded line lengths
	LDX #MaxChapter
	LDA #<(ScreenStart + (ChapterLineStart + MaxChapter * ChapterLineWidth) * 32)
	STA TmpPtr
	LDA #>(ScreenStart + (ChapterLineStart + MaxChapter * ChapterLineWidth) * 32)
	STA TmpPtr+1
.StrikeLoop1
	LDA KeyMask, X
	AND KeyFlag
	BEQ StrikeNext
	LDY StrikeLenTable, X
.StrikeLoop2
	TYA
	ORA #&20
	TAY
	LDA #0
	STA (TmpPtr), Y
	TYA
	AND #&DF
	TAY
	LDA #0
	STA (TmpPtr), Y
	DEY
	BNE StrikeLoop2
.StrikeNext
	LDA TmpPtr
	SEC
	SBC #<(ChapterLineWidth * 32)
	STA TmpPtr
	LDA TmpPtr + 1
	SBC #>(ChapterLineWidth * 32)
	STA TmpPtr + 1
	DEX
	BPL StrikeLoop1

.MenuMain
IF (banner_scroll = 1)
	JSR &FE66
	JSR Scroll
	JSR ScanKeyboard
	BCS MenuMain
ELSE
	JSR Osrdch
ENDIF
	CMP #&1B
	BEQ MenuExit

	; Shifted A-G bypass all checks, buyer beware!
	CMP #MinChapter + 'a'
	BCC KeyNotShiftedAtoG
	CMP #MaxChapter + 'a' + 1
	BCC MenuNext

.KeyNotShiftedAtoG
	; Unshifed A-G subject to mask in KegFLag
	CMP #MinChapter + 'A'
	BCC MenuMain
	CMP #MaxChapter + 'A' + 1
	BCS KeyNotAtoG

	; Test appropriate mask bit
	PHA
	AND #&F			; A = 1, B = 2, C = 3, ...
	TAX
	DEX			; A = 0; B = 1, C = 2, ...
	LDA KeyMask, X
	AND KeyFlag
	BEQ ChaptedEnabled
	PLA
	LDA #7			; Beep
	JSR Oswrch
	BNE MenuMain		; Branch always

.ChaptedEnabled
	PLA
	BNE MenuNext		; Branch alwats

.KeyMask
	EQUB &01
	EQUB &02
	EQUB &04
	EQUB &08
	EQUB &10
	EQUB &20
	EQUB &40
	EQUB &80

.KeyNotAtoG
	; Check for special system key for Rolands system
	CMP #'R'
	BNE MenuMain

	LDY #0
	JSR Clear
	JSR OscliString
IF (econet = 1 OR gosdc = 1)
	EQUS "DIR SYS", Return
ELSE
	EQUS "CWD SYS", Return
ENDIF
	JSR OscliString
	EQUS "INIT", Return

	; Don't expect to return, but just in case....
	JMP $c2b2

.MenuExit
IF (econet = 1 OR gosdc = 1)
	JSR OscliString
	EQUS "DIR $", Return
ELIF (atommc = 1)
	JSR OscliString
	EQUS "CWD /", Return
ENDIF
	LDA #&0C
	JSR Oswrch
	JMP $c2b2

.MenuNext
	AND #&DF                ; force lower case
IF (sddos2 = 1)
	; A-G -> Disks 1->N
	AND #&0F
	ORA #'0'
	STA chunk
	JSR OscliString
	EQUS "DIN 1,"
.chunk
	EQUS "X", Return
	JSR OscliString
	EQUS "DRIVE 1", Return
ELIF (sddos3 = 1)
	STA chunk
	JSR OscliString
	EQUS "DIN 1,MNU"
.chunk
	EQUS "X.DSK", Return
	JSR OscliString
	EQUS "DRIVE 1", Return
ELSE
	STA MenuDirChunk
	JSR OscliString
	IF (econet = 1 OR gosdc = 1)
	EQUS "DIR MNU"
	ELSE
	EQUS "CWD MNU"
	ENDIF
.MenuDirChunk
	EQUS " ", Return
ENDIF
	; 90 CLEAR 0
	LDY #0
	JSR Clear
	LDA #12
	JSR Oswrch

	; Load/run the chapter menu
	JSR OscliString
	EQUS "RUN CHAP", Return

.Clear
	LDA PlotDriverLS,Y
	STA $3FE
	LDA PlotDriverMS,Y
	STA $3FF
	LDA GraphicsCtrl,Y
	PHA
	LDA GraphicsLastPage,Y
	TAX
	LDA #>ScreenStart
	STA TmpPtr + 1
	LDA #0
	STA TmpPtr
	CPY #0
	BNE NotClear0
	ORA #$20
.NotClear0
	LDY #0
.ClearLoop
	STA (TmpPtr),Y
	INY
	BNE ClearLoop
	INC TmpPtr + 1
	CPX TmpPtr + 1
	BNE ClearLoop
	PLA
	STA $B000
	RTS

.GraphicsLastPage
	EQUB $82, $84, $86, $8c, $98

; Simple destructive memory test

; X = Start Page
; Y = End Page + 1
;
; On exit:
;     If test passes, C = 0
;     If test fails,  C = 1
;     In both cases, A = the last good page

; Exits with A = End P

.MemTest
{
	STY EndPage

	; If X (Start> < Y (End) then Dir=1 else Dir=-1
	LDA #1
	CPX EndPage
	BCC SetDir
	LDA #&FF	; Test backwards
.SetDir
	STA Dir

	; "Increment" the end page so it's the first page not to test
	CLC
	ADC EndPage
	STA EndPage

	; Y never changes; the last byte of each page
	LDY #&FF

  	TXA			; Save the start page
	PHA

; First pass writes the value read EOR &FF
  	STA TmpPtr + 1
	LDX #0
	STX TmpPtr
.WrLoop
	LDA (TmpPtr),Y
	STA TextBuffer, X	; Save original values in TextBuffer
	INX
	EOR #$FF
	STA (TmpPtr),Y
	LDA TmpPtr + 1
	CLC
	ADC Dir
	STA TmpPtr + 1
	CMP EndPage
	BNE WrLoop

	PLA			; Restore the start page

; Second pass reads back the value, checks it, then restores the original
	STA TmpPtr + 1
	LDX #0
.RdLoop
	LDA TextBuffer, X
	INX
	EOR #&FF
	CMP (TmpPtr),Y
	BNE Fail
	EOR #&FF
	STA (TmpPtr),Y	; restore the original value
 	LDA TmpPtr + 1
	CLC
	ADC Dir
	STA TmpPtr + 1
	CMP EndPage
	BNE RdLoop
	SEC
	SBC Dir
	CLC		; C = 0 indicates success, with A being last good page
	RTS

.Fail
	LDA TmpPtr + 1	; Save the page where there first fail happened
	PHA

; Third pass restores the remaing values after a failure

.RestoreLoop
	LDA TextBuffer, X
	INX
	STA (TmpPtr),Y	; restore the original value
 	LDA TmpPtr + 1
	CLC
	ADC Dir
	STA TmpPtr + 1
	CMP EndPage
	BNE RestoreLoop
	PLA		; Result the
	SEC
	SBC Dir
	SEC		; C = 1 indicates failure, with A being last good page
	RTS
}

include "common.asm"

IF (banner_scroll = 1)

.Scroll
{
	LDA Cycle + 1
	BMI jump_exit		; Negative allows for a longer startup delay if needed
	AND #&01
	BNE active		; xxxxxxx0 is delay, xxxxxxxx1 is scrolling
.jump_exit
	JMP exit
.active
	LDA Cycle + 1
	AND #ScrollStateMask
	CMP #(2 * (NumScrollStates - 1))
	BCC scroll_bottom

.scroll_top
	LDX #TopWindowStart
	LDA #TopWindowHeight
	STA NumLines
	LDA #<(ScreenStart + 32 * TopWindowStart)
	STA TmpPtr
	LDA #>(ScreenStart + 32 * TopWindowStart)
	STA TmpPtr+1
	LDY #1		; Fixing Y wraps the visible part back onto itself
	BNE window_calculated

.scroll_bottom
	LDX #BottomWindowStart
	LDA #BottomWindowHeight
	STA NumLines
	LDA #<TextBuffer
	STA TmpPtr
	LDA #>TextBuffer
	STA TmpPtr+1
	LDA Cycle
	LSR A
	LSR A
	LSR A
	TAY

.window_calculated
	TXA		; bits 7..3 indicate the PAGE
	LSR A
	LSR A
	LSR A
	CLC
	ADC #>ScreenStart
	STA unroll+2
	TXA		; bits 2..0 are the line
	ASL A
	ASL A
	ASL A
	ASL A
	ASL A
	TAX
.loop1
	LDA unroll + 2
FOR I, 1, 29
    	STA unroll + I * 3 + 2
NEXT
.loop2
	LDA (TmpPtr),Y
	ROL A
.unroll
FOR I, 0, 29
	ROL ScreenStart + &1E - I, X
NEXT
	LDA Cycle + 1
	AND #&0C
	EOR #&0C
	BEQ skip
	; This is needed for the bottom panel
	LDA (TmpPtr),Y
	ROL A
	STA (TmpPtr),Y
.skip
	DEC NumLines
	BEQ exit
	LDA TmpPtr
	CLC
	ADC #&20
	STA TmpPtr
	LDA TmpPtr + 1
	ADC #&00
	STA TmpPtr + 1
	TXA
	CLC
	ADC #&20
	TAX
	BEQ next1
	JMP loop2
.next1
	INC unroll + 2
	JMP loop1
.exit
	INC Cycle
	LDA Cycle
	CMP #30*8
	BCC exit2
	LDA #0
	STA Cycle
	; Cycle + 1 controls the scrolling as follows:
	; - Bit 0      = paused
	; - Bit 3..1 = 000 = RamTestInfo, 001 = RomTestInfo, 010 = Help1, 011 = Help2, 100 = Help3, 101 = Top panel
	; the total sequence takes 4 * 24 = 96s to repeat
	INC Cycle + 1
	; If still negative, we are in initial startup delay period
	BMI exit2
	; Wrap at 0E to implement the 7 screen sequence above
	LDA Cycle + 1
	CMP #(NumScrollStates * 2)
	BCC nowrap
	LDA #&00
.nowrap
	STA Cycle + 1
	AND #&01
	BEQ exit2	; xxxxxxx1 indicates we need to render the next help panel
	LDA Cycle + 1
	AND #ScrollStateMask
	TAX
	LDA table+1, X
	PHA
	LDA table, X
	PHA
.exit2
	RTS

.table
	EQUW stage0 - 1
	EQUW stage1 - 1
	EQUW stage2 - 1
	EQUW stage3 - 1
	EQUW stage4 - 1
	EQUW stage5 - 1
	EQUW stage6 - 1
	EQUW stage7 - 1
}

.stage0
{
  	JMP PrintRomTest
}

.stage1
{
	LDX #>TextBuffer
	LDY #>TextBuffer2
	JSR CopyBuffer			; Save the Startdot logo
	JMP PrintRamTest
}

.stage2
{
	JMP PrintHelp1
}

.stage3
{
	JMP PrintHelp2

}

.stage4
{
	JMP PrintHelp3

}

.stage5
{
	LDX #>TextBuffer2
	LDY #>TextBuffer
	JMP CopyBuffer			; Restore the Startdot logo
}

.stage6
{
	RTS				; The last scroll state scrolls the top panel
}

; Not currently used
.stage7
{
	RTS
}


.ScanKeyboard
{
	JSR &FE71
	BCS return
	JSR convert
	CLC
.return
	RTS
.convert
	PHP
	JMP &FEB1
}

.PrintHelp1
{
	JSR ClearTextBuffer
	LDA #Help1StringNum
	BNE PrintString		; Branch always
}

.PrintHelp2
{
	JSR ClearTextBuffer
	LDA #Help2StringNum
	BNE PrintString		; Branch always
}

.PrintHelp3
{
	JSR ClearTextBuffer
	LDA #Help3StringNum
	BNE PrintString		; Branch always
}

.PrintRamTest
{
	JSR ClearTextBuffer
	LDA #LowerRAMStringNum
	JSR PrintString
	LDX #LoMemBot
	JSR PrintBounds
	LDA #UpperRAMStringNum
	JSR PrintString
	LDX #HiMemBot
	JMP PrintBounds
}

.PrintRomTest
{
	JSR ClearTextBuffer
	LDX #Processor65C02StringNum
	EQUB &80, &01
	INX
	TXA
	JSR PrintString
	LDA RamRomType
	;; Fall through to
}

.PrintString
{
	ASL A
	TAY
	LDA HelpStringTable, Y
	STA TmpPtr
	LDA HelpStringTable + 1, Y
	STA TmpPtr + 1
	LDY #0
.loop
	LDA (TmpPtr), Y
	BEQ done
	JSR TextPrintChar
	INY
	BNE loop
.done
	RTS
}

RamRomNoneStringNum	  = 0
RamRomUnknownStringNum 	  = 1
RamRomAtom2K15StringNum   = 2
RamRomYARRBStringNum 	  = 3
RamRomRamothStringNum 	  = 4
RamRomGoSDCProStringNum	  = 5
RamRomTestFaultStringNum  = 6
Processor65C02StringNum   = 7
Processor6502StringNum    = 8
LowerRAMStringNum 	  = 9
UpperRAMStringNum 	  = 10
Help1StringNum 		  = 11
Help2StringNum 		  = 12
Help3StringNum 		  = 13

.HelpStringTable
{
	EQUW RamRomNone
	EQUW RamRomUnknown
	EQUW RamRomAtom2K15
	EQUW RamRomYARRB
	EQUW RamRomRamoth
	EQUW RamRomGoSDCPro
	EQUW RamRomTestFault
	EQUW Processor65C02
	EQUW Processor6502
	EQUW LowerRAM
	EQUW UpperRAM
	EQUW Help1
	EQUW Help2
	EQUW Help3

.RamRomNone
	EQUS "RAMROM Board: None", 0

.RamRomUnknown
	EQUS "RAMROM Board: Unknown", 0

.RamRomAtom2K15
	EQUS "RAMROM Board: Atom2K15", 0

.RamRomYARRB
	EQUS "RAMROM Board: YARRB", 0

.RamRomRamoth
	EQUS "RAMROM Board: Ramoth (Prime)", 0

.RamRomGoSDCPro
	EQUS "RAMROM Board: GoSDC Pro", 0

.RamRomTestFault
	EQUS "RAMROM Board: Test failed", 0

.Processor65C02
	EQUS "   Processor: 65C02", 13, 0

.Processor6502
	EQUS "   Processor: 6502", 13, 0

.LowerRAM
	EQUS "Lower Text RAM: ", 0

.UpperRAM
	EQUS "Upper Text RAM: ", 0

.Help1
	EQUS "Press R to load ROMS into a", 13
	EQUS "YARRB/Atom2015 RAMROM board.", 0

.Help2
	EQUS "Press Shift+Chapter to enter", 13
	EQUS "a chapter that is disabled.", 0

.Help3
	EQUS "In a chapter press / for HELP.", 13
	EQUS "Press ESC to exit to BASIC.", 0
}

.CopyBuffer
{
	STX loop + 2
	STY loop + 5
	LDX #3
	LDY #0
.loop
	LDA TextBuffer, Y
	STA TextBuffer, Y
	INY
	BNE loop
	INC loop + 2
	INC loop + 5
	DEX
	BNE loop
	RTS
}

.ClearTextBuffer
{
	JSR HomeTxtPtr

	LDX #BottomWindowHeight
.loop1
	LDY #&1F
	LDA #&FF
.loop2
	STA (TxtPtr),Y
	DEY
	BPL loop2
	LDA TxtPtr
	CLC
	ADC #&20
	STA TxtPtr
	LDA TxtPtr + 1
	ADC #&00
	STA TxtPtr + 1
	DEX
	BNE loop1
	; Fall through to
}

.HomeTxtPtr
{
	LDA #<TextBuffer
	STA TxtPtr
	LDA #>TextBuffer
	STA TxtPtr+1
	RTS
}

; Print memory bounds
; A = ZP locations
.PrintBounds
{
	LDA 0, X
	JSR TextPrintHex2
	LDA #&00
	JSR TextPrintHex2
	LDA #'-'
	JSR TextPrintChar
	LDA 1, X
	JSR TextPrintHex2
	LDA #&FF
	JSR TextPrintHex2
	LDA #&0D
	JMP TextPrintChar
}

.TextPrintHex2
{
	PHA
	LSR A
	LSR A
	LSR A
	LSR A
	JSR TextPrintHex1
	PLA
	; fall through to
}

.TextPrintHex1
{
	AND #&0F
	CMP #&0A
	BCC nocarry
	ADC #&06
.nocarry
	ADC #'0'
	; Fall through to
}

.TextPrintChar
{
	PHA
	TXA
	PHA
	TYA
	PHA

	; FontPtr = FontData + ((A-32) & 127)*8

	LDA #0
	STA FontPtr+1

	TSX
	LDA &103, X

	; Handle carriage return
	CMP #&0D
	BNE not_carriage_return
	LDA TxtPtr
	AND #&E0
	CLC
	ADC #<(LinePitch * 32)
	STA TxtPtr
	LDA TxtPtr+1
	ADC #>(LinePitch * 32)
	STA TxtPtr+1
	JMP exit
.not_carriage_return

	; Index into font table is either 0 or 1
	LDY #0
	; Check for characters with decenders
	CMP #'g'
	BEQ calc_fontptr
	CMP #'j'
	BEQ calc_fontptr
	CMP #'p'
	BEQ calc_fontptr
	CMP #'q'
	BEQ calc_fontptr
	CMP #'y'
	BEQ calc_fontptr

	INY		; offset other characters by one line

.calc_fontptr

	SEC
	SBC #&20
	AND #&7F
	ASL A
	ROL FontPtr+1
	ASL A
	ROL FontPtr+1
	ASL A
	ROL FontPtr+1
	ADC #<FontData
	STA FontPtr
	LDA FontPtr+1
	ADC #>FontData
	STA FontPtr+1

	LDA TxtPtr
	PHA
	LDA TxtPtr+1
	PHA

	LDX #0
.loop
	LDA (FontPtr), Y
	EOR #&FF
	STA (TxtPtr, X)
	LDA TxtPtr
	CLC
	ADC #&20
	STA TxtPtr
	LDA TxtPtr + 1
	ADC #&00
	STA TxtPtr + 1
	INY
	CPY #FontHeight
	BNE loop

	LDA TxtPtr
	AND #&1F
	CMP #&1F
	BEQ wrapline

	PLA
	STA TxtPtr+1
	PLA
	CLC
	ADC #1
	STA TxtPtr
	JMP exit

.wrapline
	PLA
	PLA
	LDA TxtPtr
	AND #&E0
	CLC
	ADC #<((LinePitch - FontHeight) * 32)
	STA TxtPtr
	LDA TxtPtr+1
	ADC #>((LinePitch - FontHeight) * 32)
	STA TxtPtr+1

.exit
	PLA
	TAY
	PLA
	TAX
	PLA
	RTS
}


.RamRomTest
{
	LDA #RamRomTypeNone
	STA RamRomType

	; Test if bit 7 of BFFE is writable, which identifies YARRB/Atom2K15
	LDA &BFFE
	EOR #&80
	STA &BFFE
	CMP &BFFE
	PHP
	EOR #&80
	STA &BFFE
	PLP
	BEQ yarrb_or_atom2k15

	; Test specifically for Prime's Ramoth board
	JSR TestForRamoth
	BCS done

	; Test for GoSDC Pro after Ramoth, otherwise we get a false positive
	JSR TestForGoSDCPro
	BCS done

	; Test if BFFE is returning the undriven value (&B1)
	AND #&F1
	CMP #&B1
	BEQ done		; Undriven, so conclude no board is present

	; TODO: Would it be better to test for a BFFF page register?

	; There is a RamRom board, but it's type is unknown at this point
	LDA #RamRomTypeUnknown
	STA RamRomType
.done
	RTS

.yarrb_or_atom2k15
	; Distinguish between YARRB and an "original" Atom2K15
	; The test we do depends on BFFE bit 4 (the upper mode bit) which controls the YARRB mode
	AND #&10
	BNE test_for_a00_hole
	; Distinguish between YARRB in Atom RamRom mode and an "original" Atom2K15
	; Test whether BFFE bit 0 (xma0) controls banked RAM at 0x4000-0x7FFF
	; If flipping bit 0 switches bank, this is an "original" Atom2K15,
	; as YARRB doesn't support this capability in Atom RamRom mode.
	LDA &BFFE
	LDX #&5A
	STX &4000	; Write 5A
	EOR #&01
	STA &BFFE	; Toggle bank
	LDX #&A5
	STX &4000	; Write A5
	EOR #&01
	STA &BFFE	; Toggle bank
	LDX &4000
	CPX #&5A	; 5A mean bank switching, so Atom2K15
	BEQ return_atom2k15
	CPX #&A5	; A5 means no bank switching, so YARRB
	BEQ return_yarrb
	; Anything else is regarded as a failure of the test for now.
	; Note: this could be triggered by an unknown board that
	; returned an even value in the upper nibble when BFFE is read.
	LDA #RamRomTypeTestFault
	STA RamRomType
	RTS
.return_atom2k15
	LDA #RamRomTypeAtom2K15
	STA RamRomType
	RTS
.return_yarrb
	LDA #RamRomTypeYARRB
	STA RamRomType
	RTS

.test_for_a00_hole
	; Distinguish between YARRB in Atom2K15 mode and a "original" Atom2K15
	; Test whether clearing BFFE bit 2 (DskRamEn) creates a hole at &A00
	; (YARRB has this feature; Atom2K15 does not)
	LDA &BFFE
	TAX
	AND #&FB
	STA &BFFE	; Clear bit 2 should disable RAM at A00
	LDA &A00
	EOR #&FF
	STA &A00
	CMP &A00
	PHP
	EOR #&FF
	STA &A00
	STX &BFFE
	PLP
	BNE return_yarrb	; Hole is present at A00 (i.e. no RAM), so this must be YARRB
	BEQ return_atom2k15	; Hole is absent at A00 (i.e. still RAM), so this must be an Atom2K15
}

	; Test for aliasing between &7000 and &A000 to positively identify Primes's board
.TestForRamoth
{
	; C=0 indicates board not found
	CLC
	; Save BFFE state (at there may be a ROM loaded into A000)
	LDA &BFFE
	PHA
	; Clear bit 0 (RAM at 7000, ROM at A000)
	AND #&FE
	STA &BFFE
	; Write sequence to &70xx, saveing original contents
	LDX #0
.loop1
	LDA &7000, X
	STA TextBuffer, X
	TXA
	STA &7000, X
	INX
	BNE loop1
	; Set bit 0 (RAM now at A000)
	LDA &BFFE
	ORA #1
	STA &BFFE
	; Test for sequence at &A0xx
.loop2	TXA
	EOR &A000, X
	BNE no_match
	INX
	BNE loop2
	; Ramoth found!
	LDA #RamRomTypeRamoth
	STA RamRomType
	SEC
.no_match
	; Clear bit 0 (RAM at 7000, ROM at A000)
	LDA &BFFE
	AND #&FE
	STA &BFFE
	; Restore original contents
	LDX #0
.loop3
	LDA TextBuffer, X
	STA &7000, X
	INX
	BNE loop3
	; Restore original BFFE state
	PLA
	STA &BFFE
	RTS
}


.TestForGoSDCPro
{
	; C=0 indicates board not found
	CLC
	; Test RAM with write protection on
	LDA #&81
	JSR test_byte
	; Fail if RAM detected
	BEQ done
	; Test RAM with write protection off
	LDA #&80
	JSR test_byte
	; Fail if RAM not detected
	BNE done
	; GoSDC Pro found!
	LDA #RamRomTypeGoSDCPro
	STA RamRomType
	SEC
.done
	; Leave board write protected
	LDA #&81
	STA &BFFF
	; Leave board with ROM 0 selected
	LDA #&00
	STA &BFFF
	RTS

	; Test A000 byte, none-destructively
.test_byte
	STA &BFFF	; set write protect (if this is GoSDCPro)
	LDX &A000	; save original value
	TXA
	EOR #&FF
	STA &A000	; write the inverse of what was read
	NOP
	NOP		; wait a while to avoid bus capacitance affects
	NOP
	NOP
	EOR &A000	; test it Z=1 if RAM; Z=0 if ROM
	STX &A000	; restore original value without affecting flags
	RTS
}

.FontData
	EQUB &00
	EQUB &00, &00, &00, &00, &00, &00, &00, &00		; &20
	EQUB &08, &08, &08, &08, &08, &00, &08, &00
	EQUB &14, &14, &00, &00, &00, &00, &00, &00
	EQUB &14, &14, &3E, &14, &3E, &14, &14, &00
	EQUB &08, &1E, &20, &1C, &02, &3C, &08, &00
	EQUB &32, &32, &04, &08, &10, &26, &26, &00
	EQUB &10, &28, &28, &10, &2A, &24, &1A, &00
	EQUB &0C, &0C, &0C, &00, &00, &00, &00, &00
	EQUB &04, &08, &10, &10, &10, &08, &04, &00
	EQUB &10, &08, &04, &04, &04, &08, &10, &00
	EQUB &00, &08, &2A, &1C, &2A, &08, &00, &00
	EQUB &00, &08, &08, &3E, &08, &08, &00, &00
	EQUB &00, &00, &00, &0C, &0C, &04, &08, &00
	EQUB &00, &00, &00, &3E, &00, &00, &00, &00
	EQUB &00, &00, &00, &00, &00, &0C, &0C, &00
	EQUB &02, &02, &04, &08, &10, &20, &20, &00
	EQUB &1C, &22, &26, &2A, &32, &22, &1C, &00		; &30
	EQUB &08, &18, &08, &08, &08, &08, &1C, &00
	EQUB &1C, &22, &02, &1C, &20, &20, &3E, &00
	EQUB &1C, &22, &02, &0C, &02, &22, &1C, &00
	EQUB &04, &0C, &14, &3E, &04, &04, &04, &00
	EQUB &3E, &20, &3C, &02, &02, &22, &1C, &00
	EQUB &1C, &20, &20, &3C, &22, &22, &1C, &00
	EQUB &3E, &02, &04, &08, &10, &20, &20, &00
	EQUB &1C, &22, &22, &1C, &22, &22, &1C, &00
	EQUB &1C, &22, &22, &1E, &02, &02, &1C, &00
	EQUB &00, &0C, &0C, &00, &0C, &0C, &00, &00
	EQUB &0C, &0C, &00, &0C, &0C, &04, &08, &00
	EQUB &04, &08, &10, &20, &10, &08, &04, &00
	EQUB &00, &00, &3E, &00, &3E, &00, &00, &00
	EQUB &20, &10, &08, &04, &08, &10, &20, &00
	EQUB &18, &24, &04, &08, &08, &00, &08, &00
	EQUB &1C, &22, &2E, &2A, &2E, &20, &1C, &00		; &40
	EQUB &08, &14, &22, &22, &3E, &22, &22, &00
	EQUB &3C, &12, &12, &1C, &12, &12, &3C, &00
	EQUB &1C, &22, &20, &20, &20, &22, &1C, &00
	EQUB &3C, &12, &12, &12, &12, &12, &3C, &00
	EQUB &3E, &20, &20, &38, &20, &20, &3E, &00
	EQUB &3E, &20, &20, &3C, &20, &20, &20, &00
	EQUB &1E, &20, &20, &26, &22, &22, &1E, &00
	EQUB &22, &22, &22, &3E, &22, &22, &22, &00
	EQUB &1C, &08, &08, &08, &08, &08, &1C, &00
	EQUB &02, &02, &02, &02, &22, &22, &1C, &00
	EQUB &22, &24, &28, &30, &28, &24, &22, &00
	EQUB &20, &20, &20, &20, &20, &20, &3E, &00
	EQUB &22, &36, &2A, &2A, &22, &22, &22, &00
	EQUB &22, &32, &2A, &26, &22, &22, &22, &00
	EQUB &1C, &22, &22, &22, &22, &22, &1C, &00
	EQUB &3C, &22, &22, &3C, &20, &20, &20, &00		; &50
	EQUB &1C, &22, &22, &22, &2A, &24, &1A, &00
	EQUB &3C, &22, &22, &3C, &28, &24, &22, &00
	EQUB &1C, &22, &10, &08, &04, &22, &1C, &00
	EQUB &3E, &08, &08, &08, &08, &08, &08, &00
	EQUB &22, &22, &22, &22, &22, &22, &1C, &00
	EQUB &22, &22, &22, &22, &14, &14, &08, &00
	EQUB &22, &22, &22, &2A, &2A, &36, &22, &00
	EQUB &22, &22, &14, &08, &14, &22, &22, &00
	EQUB &22, &22, &14, &08, &08, &08, &08, &00
	EQUB &3E, &02, &04, &08, &10, &20, &3E, &00
	EQUB &1C, &10, &10, &10, &10, &10, &1C, &00
	EQUB &20, &20, &10, &08, &04, &02, &02, &00
	EQUB &1C, &04, &04, &04, &04, &04, &1C, &00
	EQUB &08, &14, &22, &00, &00, &00, &00, &00
	EQUB &00, &00, &00, &00, &00, &00, &FF, &00
	EQUB &10, &08, &00, &00, &00, &00, &00, &00		; &60
	EQUB &00, &00, &1C, &02, &3E, &22, &1E, &00
	EQUB &20, &20, &3C, &22, &22, &22, &3C, &00
	EQUB &00, &00, &1C, &20, &20, &20, &1C, &00
	EQUB &02, &02, &0E, &12, &12, &12, &0E, &00
	EQUB &00, &00, &1C, &22, &3E, &20, &1C, &00
	EQUB &1C, &20, &20, &3C, &20, &20, &20, &00
	EQUB &00, &1E, &22, &22, &22, &1E, &02, &1C 		; &67 = g
	EQUB &20, &20, &3C, &22, &22, &22, &22, &00
	EQUB &08, &00, &18, &08, &08, &08, &1C, &00
	EQUB &04, &00, &04, &04, &04, &04, &14, &08		; &6A = j
	EQUB &20, &20, &24, &28, &30, &28, &22, &00
	EQUB &18, &08, &08, &08, &08, &08, &1C, &00
	EQUB &00, &00, &34, &2A, &2A, &2A, &2A, &00
	EQUB &00, &00, &3C, &22, &22, &22, &22, &00
	EQUB &00, &00, &1C, &22, &22, &22, &1C, &00
	EQUB &00, &3C, &22, &22, &22, &3C, &20, &20		; &70 = p
	EQUB &00, &1C, &22, &22, &22, &1E, &02, &02		; &71 = q
	EQUB &00, &00, &2C, &32, &20, &20, &20, &00
	EQUB &00, &00, &1C, &20, &1C, &02, &1C, &00
	EQUB &00, &10, &38, &10, &10, &14, &08, &00
	EQUB &00, &00, &22, &22, &22, &22, &1E, &00
	EQUB &00, &00, &22, &22, &14, &14, &08, &00
	EQUB &00, &00, &2A, &2A, &2A, &2A, &14, &00
	EQUB &00, &00, &22, &14, &08, &14, &22, &00
	EQUB &00, &22, &22, &22, &22, &1E, &02, &1C		; &79 = y
	EQUB &00, &00, &3E, &04, &08, &10, &3E, &00
	EQUB &04, &08, &08, &10, &08, &08, &04, &00
	EQUB &08, &08, &08, &08, &08, &08, &08, &00
	EQUB &10, &08, &08, &04, &08, &08, &10, &00
	EQUB &00, &00, &0A, &14, &00, &00, &00, &00
	EQUB &3E, &3E, &3E, &3E, &3E, &3E, &3E, &00
	EQUB &00
ENDIF


.ENDOF


align &100

.TextBuffer

skip &300

.TextBuffer2

skip &300

SAVE STARTOFHEADER, ENDOF
