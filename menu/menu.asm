	KernelOsrdch = $fe94
	RDCVEC       = $20a

	Base =? $2800

	BannerScroll =? 1

include "sysvars.asm"

; Some local variables

EndPage  = TmpPtr + 2
Dir      = TmpPtr + 3
KeyFlag  = TmpPtr + 4
NumLines = TmpPtr + 5
Cycle    = TmpPtr + 6
TxtPtr   = TmpPtr + 8
FontPtr  = TmpPtr + 10

LoMemBot = TmpPtr + 12
LoMemTop = TmpPtr + 13
HiMemBot = TmpPtr + 14
HiMemTop = TmpPtr + 15

MinChapter = 0			; A
MaxChapter = 6			; G
AGDChapter = 2			; C
ALLChapter = 6			; G

FontHeight       = 9		; height of font
LinePitch        = 10		; pixel spacing of text lines

ChapterLineStart = 70		; Y pixel row to strike in Chapter A
ChapterLineWidth = 12		; Y pixels between adjacent text lines

TopWindowStart     = 10
TopWindowHeight    = 52

BottomWindowStart  = 154
BottomWindowHeight = 20

	org Base - 22

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

IF (BannerScroll = 1)
	LDA #0
	STA Cycle
	STA Cycle + 1
	JSR PrintRamTest
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
IF (BannerScroll = 1)
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

IF (BannerScroll = 1)

.Scroll
{
	LDA Cycle + 1
	ROR A
	BCS active
	JMP exit
.active
	ROR A
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
	AND #&02
	BNE skip
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
	BNE exit2
	LDA #0
	STA Cycle
	INC Cycle + 1
	; Cycle + 1 controls the scrolling as follows:
	; - Bit 0   = Paused
	; - Bit 1   = Bottom (0) vs Top (1)
	; - Bit 2   = Bottom panel scrollimg in (0) vs out (1)
	; - Bit 4,3 = 00 = RamTestInfo, 01 = Help1, 10 = Help2, 11 = Help3
	; the total sequence takes 4 * 32 = 128s to repeat
	LDA Cycle + 1
	AND #&07
	BNE exit2	; xxxxx000 indicates we need to render the next help panel
	LDA Cycle + 1
	AND #&18
	LSR A
	LSR A
	TAX
	LDA table+1, X
	PHA
	LDA table, X
	PHA
.exit2
	RTS

.table
	EQUW PrintRamTest - 1
	EQUW PrintHelp1 - 1
	EQUW PrintHelp2 - 1
	EQUW PrintHelp3 - 1
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
	LDX #(Help1String - HelpStrings)
	BNE PrintString		; Branch always
}

.PrintHelp2
{
	JSR ClearTextBuffer
	LDX #(Help2String - HelpStrings)
	BNE PrintString		; Branch always
}

.PrintHelp3
{
	JSR ClearTextBuffer
	LDX #(Help3String - HelpStrings)
	BNE PrintString		; Branch always
}

.PrintRamTest
{
	JSR ClearTextBuffer
	LDX #(LowerRAMString - HelpStrings)
	JSR PrintString
	LDX #LoMemBot
	JSR PrintBounds
	LDX #(UpperRAMString - HelpStrings)
	JSR PrintString
	LDX #HiMemBot
	JMP PrintBounds
}

.PrintString
{
.loop
	LDA HelpStrings, X
	BEQ done
	JSR TextPrintChar
	INX
	BNE loop
.done
	RTS
}

.HelpStrings

.LowerRAMString
	EQUS "Lower Text RAM: "
	EQUB 0

.UpperRAMString
	EQUS "Upper Text RAM: "
	EQUB 0

.Help1String
	EQUS "Press R to load ROMS into a"
	EQUB 13
	EQUS "YARRB/Atom2015 RAMROM board."
	EQUB 0

.Help2String
	EQUS "Press Shift+Chapter to enter"
	EQUB 13
	EQUS "a chapter that is disabled."
	EQUB 0

.Help3String
	EQUS "Press ESC to exit to BASIC."
	EQUB 13
	EQUS "In a chapter press / for HELP."
	EQUB 0

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

align &100

.TextBuffer

.ENDOF



SAVE STARTOFHEADER, ENDOF
