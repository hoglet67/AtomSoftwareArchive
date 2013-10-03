\ > BBC_OS/S
\ Source for Atom MOS interface for BBC BASIC


\ I/O Addresses
\ -------------
\ &7000 - 8255
\ &7800 - 6522

ORIGINAL=0

IF ORIGINAL
BBCBASICENTRY = &8000
BBCBASICCOPYRIGHT = &800E
MOSEXT = &C000
SCREEN = &4000
IO8255_0 = &7000
IO6522_0 = &7800
ELSE
BBCBASICENTRY = &4023
BBCBASICCOPYRIGHT = &400E
MOSEXT = &C000
SCREEN = &8000
IO8255_0 = &B000
IO6522_0 = &B800
ENDIF


IO8255_1 = IO8255_0 + 1
IO8255_2 = IO8255_0 + 2
IO8255_3 = IO8255_0 + 3

IO6522_1 = IO6522_0 + 1
IO6522_2 = IO6522_0 + 2
IO6522_3 = IO6522_0 + 3
IO6522_4 = IO6522_0 + 4
IO6522_5 = IO6522_0 + 5
IO6522_6 = IO6522_0 + 6
IO6522_7 = IO6522_0 + 7
IO6522_8 = IO6522_0 + 8
IO6522_9 = IO6522_0 + 9
IO6522_A = IO6522_0 + 10
IO6522_B = IO6522_0 + 11
IO6522_C = IO6522_0 + 12
IO6522_D = IO6522_0 + 13
IO6522_E = IO6522_0 + 14
IO6522_F = IO6522_0 + 15


\ Memory Map
\ ----------
\ &00-&8F - BBC BASIC zero page workspace
\
\ &98 - IRQ A store
\ &99 - IRQ X store
\ &9E/F - pointer to control block or memory
\
\ &A2/3 - OSWORD 0 control block
\ &A4/5 - OSWORD 0 text address
\ &A6   - OSWORD 0 maximum length
\ &A7   - OSWORD 0 lowest character
\ &A8   - OSWORD 0 highest character
\
\ &DE/F
\ &E0
\ &E1
\ &E2/3
\ &E8/9 - inline text pointer
\ &EA
\
\ &0300-&0303 - TIME
\ &0318
\ &0319   - copied to 8255 &7808 on Timer1
\ &031A   - copied to 8255 &7809 on Timer1
\ &031B/C - INKEY delay
\ &031D
\ &031E
\ &031F
\
\ &0400-&07FF - BBC BASIC workspace
\

ATM=0

load=&F000

	org load

IF ATM
	org load - 22
ENDIF

.AtmHeader

IF ATM
        EQUS    "ATMOS"
        org AtmHeader + 16
        EQUW	BeebDisStartAddr
        EQUW    BeebDisStartAddr
        EQUW	BeebDisEndAddr - BeebDisStartAddr
ENDIF

.BeebDisStartAddr

	org load


.LF000
CMP #&00:BEQ LF019       :\ Jump with read input line
CMP #&01:BEQ LF013       :\ Jump with =TIME
CMP #&02:BEQ LF07F       :\ Jump with TIME=
CMP #&07:BEQ LF016       :\ Jump with SOUND
JMP LF0E6                :\ Otherwise, generate error
.LF013:JMP LF090         :\ Pass on to do =TIME
.LF016:JMP LF0A1         :\ Pass on to do SOUND


\ OSWORD 0 - READ INPUT LINE
\ ==========================
.LF019
STX &A2:STY &A3:LDY #&04
.LF01F
LDA (&A2),Y     :\ F01F= B1 A2       1"
STA &00A4,Y     :\ F021= 99 A4 00    .$.
DEY             :\ F024= 88          .
BPL LF01F       :\ F025= 10 F8       .x
.LF027
LDY #&00        :\ F027= A0 00        .
.LF029
JSR OSRDCH      :\ F029= 20 E0 FF     `.
CMP #&15        :\ F02C= C9 15       I.
BNE LF03E       :\ F02E= D0 0E       P.
.LF030
DEY             :\ F030= 88          .
BMI LF027       :\ F031= 30 F4       0t
LDA #&7F        :\ F033= A9 7F       ).
JSR OSWRCH      :\ F035= 20 EE FF     n.
JMP LF030       :\ F038= 4C 30 F0    L0p

\ TODO: UNREACHABLE
JMP LF027       :\ F03B= 4C 27 F0    L'p

.LF03E
CMP #&7F        :\ F03E= C9 7F       I.
BNE LF04B       :\ F040= D0 09       P.
DEY             :\ F042= 88          .
BMI LF027       :\ F043= 30 E2       0b
JSR OSWRCH      :\ F045= 20 EE FF     n.
JMP LF029       :\ F048= 4C 29 F0    L)p

.LF04B
JSR OSWRCH      :\ F04B= 20 EE FF     n.
CMP #&0D        :\ F04E= C9 0D       I.
BEQ LF070       :\ F050= F0 1E       p.
CMP #&1B        :\ F052= C9 1B       I.
BEQ LF079       :\ F054= F0 23       p#
CMP &A7         :\ F056= C5 A7       E'
BCC LF029       :\ F058= 90 CF       .O
CMP &A8         :\ F05A= C5 A8       E(
BEQ LF060       :\ F05C= F0 02       p.
BCS LF029       :\ F05E= B0 C9       0I
.LF060
STA (&A4),Y     :\ F060= 91 A4       .$
INY             :\ F062= C8          H
CPY &A6         :\ F063= C4 A6       D&
BCC LF029       :\ F065= 90 C2       .B
LDA #&7F        :\ F067= A9 7F       ).
JSR OSWRCH      :\ F069= 20 EE FF     n.
DEY             :\ F06C= 88          .
JMP LF029       :\ F06D= 4C 29 F0    L)p
 
.LF070
STA (&A4),Y     :\ F070= 91 A4       .$
JSR OSNEWL      :\ F072= 20 E7 FF     g.
LDX #&00        :\ F075= A2 00       ".
CLC             :\ F077= 18          .
RTS             :\ F078= 60          `

.LF079
SEC             :\ F079= 38          8
LDX #&FF        :\ F07A= A2 FF       ".
STX &FF         :\ F07C= 86 FF       ..
RTS             :\ F07E= 60          `


\ OSWORD 2 - TIME=
\ ================
.LF07F
STX &9E         :\ F07F= 86 9E       ..
STY &9F         :\ F081= 84 9F       ..
LDY #&04        :\ F083= A0 04        .
.LF085
LDA (&9E),Y     :\ F085= B1 9E       1.
STA &0300,Y     :\ F087= 99 00 03    ...
DEY             :\ F08A= 88          .
BPL LF085       :\ F08B= 10 F8       .x
LDY &9F         :\ F08D= A4 9F       $.
RTS             :\ F08F= 60          `


\ OSWORD 1 - =TIME
\ ================ 
.LF090
STX &9E         :\ F090= 86 9E       ..
STY &9F         :\ F092= 84 9F       ..
LDY #&04        :\ F094= A0 04        .
.LF096
LDA &0300,Y     :\ F096= B9 00 03    9..
STA (&9E),Y     :\ F099= 91 9E       ..
DEY             :\ F09B= 88          .
BPL LF096       :\ F09C= 10 F8       .x
LDY &9F         :\ F09E= A4 9F       $.
RTS             :\ F0A0= 60          `


\ OSWORD 7 - SOUND
\ ================
.LF0A1
STX &9E         :\ F0A1= 86 9E       ..
STY &9F         :\ F0A3= 84 9F       ..
LDY #&04        :\ F0A5= A0 04        .
LDA (&9E),Y     :\ F0A7= B1 9E       1.
STA &0319       :\ F0A9= 8D 19 03    ...
INY             :\ F0AC= C8          H
LDA (&9E),Y     :\ F0AD= B1 9E       1.
STA &031A       :\ F0AF= 8D 1A 03    ...
INY             :\ F0B2= C8          H
LDA (&9E),Y     :\ F0B3= B1 9E       1.
STA &0317       :\ F0B5= 8D 17 03    ...
INY             :\ F0B8= C8          H
LDA (&9E),Y     :\ F0B9= B1 9E       1.
STA &0318       :\ F0BB= 8D 18 03    ...
LDA &0319       :\ F0BE= AD 19 03    -..
STA IO6522_8       :\ F0C1= 8D 08 78    ..x
LDA &031A       :\ F0C4= AD 1A 03    -..
STA IO6522_9       :\ F0C7= 8D 09 78    ..x
LDA #&A0        :\ F0CA= A9 A0       )
STA IO6522_E       :\ F0CC= 8D 0E 78    ..x
LDY &9F         :\ F0CF= A4 9F       $.
RTS             :\ F0D1= 60          `


\ OSBYTE HANDLER
\ ==============
.LF0D2
CMP #&83:BEQ LF0FC       :\ Jump with read bottom of memory
CMP #&84:BEQ LF101       :\ Jump with read top of memory
CMP #&81:BEQ LF12B       :\ Jump with INKEY
CMP #&7E:BEQ LF0F9       :\ Jump with Escape Acknowledge
CMP #&82:BEQ LF0F8       :\ Jump with address high word
.LF0E6
BRK
EQUB &FE
EQUS "NOT IMPLEMENTED"
EQUB 0

\ OSBYTE &82 - Read address high word
\ ===================================
.LF0F8
RTS                      :\ Return XY unchanged

\ OSBYTE &7E - Escape Acknoweldge
\ =============================== 
.LF0F9
JMP LF172

\ OSBYTE &83 - Read bottom of memory
\ ==================================
.LF0FC
LDX #&00:LDY #&08:RTS    :\ Return &0800

\ OSBYTE &84 - Read top of memory
\ ===============================
.LF101
PHA
LDA #&00:STA &9E:LDA #&08:STA &9F  :\ &9E/F=>&0800, lowest available location
LDY #&00
.LF10C
LDA (&9E),Y:EOR #&FF:STA (&9E),Y   :\ Complement byte in memory
CMP (&9E),Y:BNE LF125              :\ Doesn't match, end of RAM
EOR #&FF:STA (&9E),Y               :\ Complement it back to restore it
INY:BNE LF10C                      :\ Loop for 256 bytes
INC &9F:LDA &9F:CMP #&40:BCC LF10C :\ Scan up to &4000
.LF125
TYA:TAX:LDY &9F                    :\ X=low byte, Y=high byte
PLA:RTS                            :\ A.b7=1, indicates <&10000

 
\ OSBYTE &81 - INKEY
\ ==================
.LF12B
STX &031B:STY &031C                :\ Store INKEY countdown time
LDX #&00:STX &031F:STX &031E:STX &031D
.LF13C
LDY #&04:CLC
.LF13F
LDA &0300,X:ADC &031B,X:STA &0320,X
INX:DEY:BPL LF13F
.LF14C
JSR LFE4A       :\ F14C= 20 4A FE     J~
BCC LF162       :\ F14F= 90 11       ..
LDX #&04        :\ F151= A2 04       ".
.LF153
LDA &0320,X     :\ F153= BD 20 03    = .
CMP &0300,X     :\ F156= DD 00 03    ]..
BMI LF16A       :\ F159= 30 0F       0.
BNE LF14C       :\ F15B= D0 EF       Po
DEX             :\ F15D= CA          J
BPL LF153       :\ F15E= 10 F3       .s
BMI LF16A       :\ F160= 30 08       0.
.LF162
JSR LF16E       :\ F162= 20 6E F1     nq
TAX             :\ F165= AA          *
LDY #&00        :\ F166= A0 00        .
CLC             :\ F168= 18          .
RTS             :\ F169= 60          `

.LF16A
LDY #&FF:SEC:RTS
 
.LF16E
PHP:JMP LFE8A
 
\ OSBYTE &7E - Escape Acknoweldge
\ ===============================
.LF172
LDA &FF:BPL LF17C       :\ No pending Escape, exit
JSR LF17D:JMP LF172     :\ Update Escape state, loop until no Escape
.LF17C
RTS

\ Update Escape state by checking for Escape key pressed
\ ------------------------------------------------------
.LF17D
LDA IO8255_0:PHA
AND #&F0:STA IO8255_0
LDA IO8255_1:AND #&20:BEQ LF191
LDA #&00:BPL LF1A0            :\ Set 'No Escape'
.LF191
LDA #&20:STA IO6522_E
LDA #&00:STA &0317:STA &0318  :\ ?Clear countdown timer?
LDA #&FF                      :\ Set 'Escape pending'
.LF1A0
STA &FF:PLA:STA IO8255_0:RTS


\ 6522 INTERUPT
\ =============
.LF1A7
AND #&40:BNE LF1C2           :\ Jump if not Timer1 interupt
LDA IO8255_2:EOR #&04:STA IO8255_2 :\ Toggle a 8255 bit
LDA &0319:STA IO6522_8          :\
LDA &031A:STA IO6522_9          :\
LDA &98:RTI                  :\ Restore A and return

\ 6522 Timer2 Interupt
\ --------------------
.LF1C2
STX &99:JSR LF17D             :\ Update Escape state
LDA &0317:ORA &0318:BEQ LF1E7 :\
LDA &0317:BNE LF1D7:DEC &0318 :\
.LF1D7
DEC &0317:LDA &0317
ORA &0318:BNE LF1E7
LDA #&20:STA IO6522_E            :\ Set 8255
.LF1E7
LDX #&00
.LF1E9
INC &0300,X:INX:CPX #&05:BEQ LF1F6
LDA &02FF,X:BEQ LF1E9
.LF1F6
LDX &99:LDA IO6522_4
LDA &98:RTI                   :\ Restore A and return

.LF1FE
LDX #&03        :\ F1FE= A2 03       ".
.LF200
LDA &030F,X     :\ F200= BD 0F 03    =..
STA &B3,X       :\ F203= 95 B3       .3
DEX             :\ F205= CA          J
BPL LF200       :\ F206= 10 F8       .x
LDA &030E       :\ F208= AD 0E 03    -..
AND #&04        :\ F20B= 29 04       ).
BNE LF222       :\ F20D= D0 13       P.
LDX #&02        :\ F20F= A2 02       ".
.LF211
CLC             :\ F211= 18          .
LDA &BB,X       :\ F212= B5 BB       5;
ADC &B3,X       :\ F214= 75 B3       u3
STA &BB,X       :\ F216= 95 BB       .;
LDA &BC,X       :\ F218= B5 BC       5<
ADC &B4,X       :\ F21A= 75 B4       u4
STA &BC,X       :\ F21C= 95 BC       .<
DEX             :\ F21E= CA          J
DEX             :\ F21F= CA          J
BPL LF211       :\ F220= 10 EF       .o
.LF222
LDX #&03        :\ F222= A2 03       ".
.LF224
LDA &BB,X       :\ F224= B5 BB       5;
STA &030F,X     :\ F226= 9D 0F 03    ...
DEX             :\ F229= CA          J
BPL LF224       :\ F22A= 10 F8       .x
LDA &030E       :\ F22C= AD 0E 03    -..
AND #&03        :\ F22F= 29 03       ).
BEQ LF23F       :\ F231= F0 0C       p.
STA &BF         :\ F233= 85 BF       .?
LDA &030E       :\ F235= AD 0E 03    -..
AND #&08        :\ F238= 29 08       ).
BEQ LF240       :\ F23A= F0 04       p.
JSR LF301       :\ F23C= 20 01 F3     .s
.LF23F
RTS             :\ F23F= 60          `

.LF240
LDX #&02        :\ F240= A2 02       ".
.LF242
SEC             :\ F242= 38          8
LDA &BB,X       :\ F243= B5 BB       5;
SBC &B3,X       :\ F245= F5 B3       u3
LDY &B3,X       :\ F247= B4 B3       43
STY &BB,X       :\ F249= 94 BB       .;
STA &B3,X       :\ F24B= 95 B3       .3
LDY &B4,X       :\ F24D= B4 B4       44
LDA &BC,X       :\ F24F= B5 BC       5<
SBC &B4,X       :\ F251= F5 B4       u4
STY &BC,X       :\ F253= 94 BC       .<
STA &B4,X       :\ F255= 95 B4       .4
STA &B7,X       :\ F257= 95 B7       .7
BPL LF268       :\ F259= 10 0D       ..
LDA #&00        :\ F25B= A9 00       ).
SEC             :\ F25D= 38          8
SBC &B3,X       :\ F25E= F5 B3       u3
STA &B3,X       :\ F260= 95 B3       .3
LDA #&00        :\ F262= A9 00       ).
SBC &B4,X       :\ F264= F5 B4       u4
STA &B4,X       :\ F266= 95 B4       .4
.LF268
DEX             :\ F268= CA          J
DEX             :\ F269= CA          J
BPL LF242       :\ F26A= 10 D6       .V
LDA &B5         :\ F26C= A5 B5       %5
CMP &B3         :\ F26E= C5 B3       E3
LDA &B6         :\ F270= A5 B6       %6
SBC &B4         :\ F272= E5 B4       e4
BCC LF2A5       :\ F274= 90 2F       ./
LDA #&00        :\ F276= A9 00       ).
SBC &B5         :\ F278= E5 B5       e5
STA &B8         :\ F27A= 85 B8       .8
LDA #&00        :\ F27C= A9 00       ).
SBC &B6         :\ F27E= E5 B6       e6
SEC             :\ F280= 38          8
ROR A           :\ F281= 6A          j
STA &BA         :\ F282= 85 BA       .:
ROR &B8         :\ F284= 66 B8       f8
.LF286
JSR LF301       :\ F286= 20 01 F3     .s
LDA &BD         :\ F289= A5 BD       %=
CMP &0311       :\ F28B= CD 11 03    M..
BNE LF298       :\ F28E= D0 08       P.
LDA &BE         :\ F290= A5 BE       %>
CMP &0312       :\ F292= CD 12 03    M..
BNE LF298       :\ F295= D0 01       P.
.LF297
RTS             :\ F297= 60          `

.LF298
JSR LF2DE       :\ F298= 20 DE F2     ^r
LDA &BA         :\ F29B= A5 BA       %:
BMI LF286       :\ F29D= 30 E7       0g
JSR LF2CD       :\ F29F= 20 CD F2     Mr
JMP LF286       :\ F2A2= 4C 86 F2    L.r
 
.LF2A5
LDA &B4         :\ F2A5= A5 B4       %4
LSR A           :\ F2A7= 4A          J
STA &BA         :\ F2A8= 85 BA       .:
LDA &B3         :\ F2AA= A5 B3       %3
ROR A           :\ F2AC= 6A          j
STA &B8         :\ F2AD= 85 B8       .8
.LF2AF
JSR LF301       :\ F2AF= 20 01 F3     .s
LDA &BB         :\ F2B2= A5 BB       %;
CMP &030F       :\ F2B4= CD 0F 03    M..
BNE LF2C0       :\ F2B7= D0 07       P.
LDA &BC         :\ F2B9= A5 BC       %<
CMP &0310       :\ F2BB= CD 10 03    M..
BEQ LF297       :\ F2BE= F0 D7       pW
.LF2C0
JSR LF2CD       :\ F2C0= 20 CD F2     Mr
LDA &BA         :\ F2C3= A5 BA       %:
BPL LF2AF       :\ F2C5= 10 E8       .h
JSR LF2DE       :\ F2C7= 20 DE F2     ^r
JMP LF2AF       :\ F2CA= 4C AF F2    L/r
 
.LF2CD
SEC             :\ F2CD= 38          8
LDA &B8         :\ F2CE= A5 B8       %8
SBC &B5         :\ F2D0= E5 B5       e5
STA &B8         :\ F2D2= 85 B8       .8
LDA &BA         :\ F2D4= A5 BA       %:
SBC &B6         :\ F2D6= E5 B6       e6
STA &BA         :\ F2D8= 85 BA       .:
LDX #&00        :\ F2DA= A2 00       ".
BEQ LF2ED       :\ F2DC= F0 0F       p.
.LF2DE
CLC             :\ F2DE= 18          .
LDA &B8         :\ F2DF= A5 B8       %8
ADC &B3         :\ F2E1= 65 B3       e3
STA &B8         :\ F2E3= 85 B8       .8
LDA &BA         :\ F2E5= A5 BA       %:
ADC &B4         :\ F2E7= 65 B4       e4
STA &BA         :\ F2E9= 85 BA       .:
LDX #&02        :\ F2EB= A2 02       ".
.LF2ED
LDA &B7,X       :\ F2ED= B5 B7       57
BPL LF2FA       :\ F2EF= 10 09       ..
LDA &BB,X       :\ F2F1= B5 BB       5;
BNE LF2F7       :\ F2F3= D0 02       P.
DEC &BC,X       :\ F2F5= D6 BC       V<
.LF2F7
DEC &BB,X       :\ F2F7= D6 BB       V;
.LF2F9
RTS             :\ F2F9= 60          `

.LF2FA
INC &BB,X       :\ F2FA= F6 BB       v;
BNE LF2F9       :\ F2FC= D0 FB       P{
INC &BC,X       :\ F2FE= F6 BC       v<
RTS             :\ F300= 60          `

\ Call the plot subrouting for the current screen mode
.LF301
JMP (&0313)     :\ F301= 6C 13 03    l..

.LF304
LDY #&00        :\ F304= A0 00        .
LDA #&07        :\ F306= A9 07       ).
AND &B3         :\ F308= 25 B3       %3
STA &B3         :\ F30A= 85 B3       .3
STA &032A       :\ F30C= 8D 2A 03    .*.
LDA #&07        :\ F30F= A9 07       ).
SEC             :\ F311= 38          8
SBC &B3         :\ F312= E5 B3       e3
BEQ LF34A       :\ F314= F0 34       p4
CMP #&05        :\ F316= C9 05       I.
BMI LF31C       :\ F318= 30 02       0.
LDA #&04        :\ F31A= A9 04       ).
.LF31C
LDX #>SCREEN    :\ F31C= A2 40       "@
STX &B5         :\ F31E= 86 B5       .5
STY &B4         :\ F320= 84 B4       .4
STA &B3         :\ F322= 85 B3       .3
TAX             :\ F324= AA          *
LDA LF357-1,X     :\ F325= BD 56 F3    =Vs
TAX             :\ F328= AA          *
TYA             :\ F329= 98          .
.LF32A
STA (&B4),Y     :\ F32A= 91 B4       .4
DEY             :\ F32C= 88          .
BNE LF32A       :\ F32D= D0 FB       P{
INC &B5         :\ F32F= E6 B5       f5
CPX &B5         :\ F331= E4 B5       d5
BNE LF32A       :\ F333= D0 F5       Pu
.LF335
LDY &B3         :\ F335= A4 B3       $3
LDA LF360,Y     :\ F337= B9 60 F3    9`s
STA &0314       :\ F33A= 8D 14 03    ...
LDA LF35B,Y     :\ F33D= B9 5B F3    9[s
STA &0313       :\ F340= 8D 13 03    ...
LDA LF365,Y     :\ F343= B9 65 F3    9es
STA IO8255_0       :\ F346= 8D 00 70    ..p
RTS             :\ F349= 60          `

.LF34A
LDA #&40        :\ F34A= A9 40       )@
.LF34C
STA SCREEN,Y     :\ F34C= 99 00 40    ..@
STA SCREEN+256,Y     :\ F34F= 99 00 41    ..A
DEY             :\ F352= 88          .
BNE LF34C       :\ F353= D0 F7       Pw
BEQ LF335       :\ F355= F0 DE       p^

.LF357
EQUB (>SCREEN) + &04 \ mode 6 = clear 1
EQUB (>SCREEN) + &06 \ mode 5 = clear 2
EQUB (>SCREEN) + &0c \ mode 4 = clear 3
EQUB (>SCREEN) + &18 \ mode 3..0 = clear 4

.LF35B
EQUB <LF36A
EQUB <LF3C3
EQUB <LF3DC
EQUB <LF3F5
EQUB <LF432

.LF360
EQUB >LF36A
EQUB >LF3C3
EQUB >LF3DC
EQUB >LF3F5
EQUB >LF432

.LF365
EQUB &00
EQUB &30
EQUB &70
EQUB &B0
EQUB &F0

 \ mode 7 = clear 0
.LF36A
LDA &BC         :\ F36A= A5 BC       %<
ORA &BE         :\ F36C= 05 BE       .>
BNE LF3C2       :\ F36E= D0 52       PR
LDA &BB         :\ F370= A5 BB       %;
CMP #&40        :\ F372= C9 40       I@
BCS LF3C2       :\ F374= B0 4C       0L
LSR A           :\ F376= 4A          J
STA &C0         :\ F377= 85 C0       .@
LDA #&2F        :\ F379= A9 2F       )/
SEC             :\ F37B= 38          8
SBC &BD         :\ F37C= E5 BD       e=
CMP #&30        :\ F37E= C9 30       I0
BCS LF3C2       :\ F380= B0 40       0@
LDX #&FF        :\ F382= A2 FF       ".
SEC             :\ F384= 38          8
.LF385
INX             :\ F385= E8          h
SBC #&03        :\ F386= E9 03       i.
BCS LF385       :\ F388= B0 FB       0{
ADC #&03        :\ F38A= 69 03       i.
STA &C2         :\ F38C= 85 C2       .B
TXA             :\ F38E= 8A          .
ASL A           :\ F38F= 0A          .
ASL A           :\ F390= 0A          .
ASL A           :\ F391= 0A          .
ASL A           :\ F392= 0A          .
ASL A           :\ F393= 0A          .
ORA &C0         :\ F394= 05 C0       .@
STA &C0         :\ F396= 85 C0       .@
LDA #>SCREEN    :\ F398= A9 40       )@
ADC #&00        :\ F39A= 69 00       i.
STA &C1         :\ F39C= 85 C1       .A
LDA &BB         :\ F39E= A5 BB       %;
LSR A           :\ F3A0= 4A          J
LDA &C2         :\ F3A1= A5 C2       %B
ROL A           :\ F3A3= 2A          *
TAY             :\ F3A4= A8          (
LDA LF453,Y     :\ F3A5= B9 53 F4    9St
.LF3A8
LDY #&00        :\ F3A8= A0 00        .
LDX &BF         :\ F3AA= A6 BF       &?
DEX             :\ F3AC= CA          J
BEQ LF3BE       :\ F3AD= F0 0F       p.
DEX             :\ F3AF= CA          J
BEQ LF3B9       :\ F3B0= F0 07       p.
EOR #&FF        :\ F3B2= 49 FF       I.
AND (&C0),Y     :\ F3B4= 31 C0       1@
STA (&C0),Y     :\ F3B6= 91 C0       .@
RTS             :\ F3B8= 60          `

.LF3B9
EOR (&C0),Y     :\ F3B9= 51 C0       Q@
STA (&C0),Y     :\ F3BB= 91 C0       .@
RTS             :\ F3BD= 60          `

.LF3BE
ORA (&C0),Y     :\ F3BE= 11 C0       .@
STA (&C0),Y     :\ F3C0= 91 C0       .@
.LF3C2
RTS             :\ F3C2= 60          `

\ mode 6 = clear 1
 .LF3C3
LDA &BC         :\ F3C3= A5 BC       %<
ORA &BE         :\ F3C5= 05 BE       .>
BNE LF3C2       :\ F3C7= D0 F9       Py
LDA &BB         :\ F3C9= A5 BB       %;
BMI LF3C2       :\ F3CB= 30 F5       0u
LSR A           :\ F3CD= 4A          J
LSR A           :\ F3CE= 4A          J
LSR A           :\ F3CF= 4A          J
STA &C0         :\ F3D0= 85 C0       .@
LDA #&3F        :\ F3D2= A9 3F       )?
SEC             :\ F3D4= 38          8
SBC &BD         :\ F3D5= E5 BD       e=
CMP #&40        :\ F3D7= C9 40       I@
BCC LF40D       :\ F3D9= 90 32       .2
RTS             :\ F3DB= 60          `

 \ mode 5 = clear 2
.LF3DC
LDA &BC         :\ F3DC= A5 BC       %<
ORA &BE         :\ F3DE= 05 BE       .>
BNE LF3C2       :\ F3E0= D0 E0       P`
LDA &BB         :\ F3E2= A5 BB       %;
BMI LF3C2       :\ F3E4= 30 DC       0\
LSR A           :\ F3E6= 4A          J
LSR A           :\ F3E7= 4A          J
LSR A           :\ F3E8= 4A          J
STA &C0         :\ F3E9= 85 C0       .@
LDA #&5F        :\ F3EB= A9 5F       )_
SEC             :\ F3ED= 38          8
SBC &BD         :\ F3EE= E5 BD       e=
CMP #&60        :\ F3F0= C9 60       I`
BCC LF40D       :\ F3F2= 90 19       ..
.LF3F4
RTS             :\ F3F4= 60          `

 \ mode 4 = clear 3
.LF3F5
LDA &BC         :\ F3F5= A5 BC       %<
ORA &BE         :\ F3F7= 05 BE       .>
BNE LF3C2       :\ F3F9= D0 C7       PG
LDA &BB         :\ F3FB= A5 BB       %;
BMI LF3C2       :\ F3FD= 30 C3       0C
LSR A           :\ F3FF= 4A          J
LSR A           :\ F400= 4A          J
LSR A           :\ F401= 4A          J
STA &C0         :\ F402= 85 C0       .@
LDA #&BF        :\ F404= A9 BF       )?
SEC             :\ F406= 38          8
SBC &BD         :\ F407= E5 BD       e=
CMP #&C0        :\ F409= C9 C0       I@
BCS LF3C2       :\ F40B= B0 B5       05

.LF40D
LDY #&00        :\ F40D= A0 00        .
STY &C1         :\ F40F= 84 C1       .A
.LF411
ASL A           :\ F411= 0A          .
ROL &C1         :\ F412= 26 C1       &A
ASL A           :\ F414= 0A          .
ROL &C1         :\ F415= 26 C1       &A
ASL A           :\ F417= 0A          .
ROL &C1         :\ F418= 26 C1       &A
ASL A           :\ F41A= 0A          .
ROL &C1         :\ F41B= 26 C1       &A
ADC &C0         :\ F41D= 65 C0       e@
STA &C0         :\ F41F= 85 C0       .@
LDA &C1         :\ F421= A5 C1       %A
ADC #>SCREEN    :\ F423= 69 40       i@
STA &C1         :\ F425= 85 C1       .A
LDA &BB         :\ F427= A5 BB       %;
AND #&07        :\ F429= 29 07       ).
TAY             :\ F42B= A8          (
LDA LF451,Y     :\ F42C= B9 51 F4    9Qt
JMP LF3A8       :\ F42F= 4C A8 F3    L(s

 \ mode 3..0 = clear 4
.LF432
LDA &BC         :\ F432= A5 BC       %<
ORA &BE         :\ F434= 05 BE       .>
BNE LF3F4       :\ F436= D0 BC       P<
LDA &BB         :\ F438= A5 BB       %;
LSR A           :\ F43A= 4A          J
LSR A           :\ F43B= 4A          J
LSR A           :\ F43C= 4A          J
STA &C0         :\ F43D= 85 C0       .@
LDA #&BF        :\ F43F= A9 BF       )?
SEC             :\ F441= 38          8
SBC &BD         :\ F442= E5 BD       e=
CMP #&C0        :\ F444= C9 C0       I@
BCS LF3F4       :\ F446= B0 AC       0,
LDY #&00        :\ F448= A0 00        .
STY &C1         :\ F44A= 84 C1       .A
ASL A           :\ F44C= 0A          .
ROL &C1         :\ F44D= 26 C1       &A
BPL LF411       :\ F44F= 10 C0       .@

.LF451
EQUB &80
EQUB &40
.LF453
EQUB &20
EQUB &10
EQUB &08
EQUB &04
EQUB &02
EQUB &01

\ ONLY CALLED FROM UNREACHABLE CODE

.LF459
AND #&03        :\ F459= 29 03
TAY             :\ F45B= A8          (
LDA LF49D,Y     :\ F45C= B9 9D F4    9.t
STA &0315       :\ F45F= 8D 15 03    ...
LDA IO8255_0       :\ F462= AD 00 70    -.p
AND #&F0        :\ F465= 29 F0       )p
CMP #&70        :\ F467= C9 70       Ip
BNE LF477       :\ F469= D0 0C       P.
LDA #&00        :\ F46B= A9 00       ).
TAY             :\ F46D= A8          (
.LF46E
STA &4600,Y     :\ F46E= 99 00 46    ..F
STA &4700,Y     :\ F471= 99 00 47    ..G
DEY             :\ F474= 88          .
BNE LF46E       :\ F475= D0 F7       Pw
.LF477
LDA IO8255_0       :\ F477= AD 00 70    -.p
AND #&DF        :\ F47A= 29 DF       )_
STA IO8255_0       :\ F47C= 8D 00 70    ..p
ROL A           :\ F47F= 2A          *
ROL A           :\ F480= 2A          *
ROL A           :\ F481= 2A          *
AND #&03        :\ F482= 29 03       ).
TAY             :\ F484= A8          (
LDA LF491,Y     :\ F485= B9 91 F4    9.t
STA &0313       :\ F488= 8D 13 03    ...
LDA LF495,Y     :\ F48B= B9 95 F4    9.t
STA &0314       :\ F48E= 8D 14 03    ...

\ TODO: BAD STUFF HAPPENS HERE !!!
.LF491
EQUB <LF4A1
EQUB <LF4BF
EQUB <LF4D7
EQUB <LF506

.LF495
EQUB >LF4A1
EQUB >LF4BF
EQUB >LF4D7
EQUB >LF506

.LF499
EQUB &3F        :\ F499= 3F          ?
EQUB &CF        :\ F49A= CF          O
EQUB &F3        :\ F49B= F3          s
EQUB &FC        :\ F49C= FC          |

.LF49D
EQUB &00        :\ F49D= 00          .
EQUB &55        :\ F49E= 55          U
EQUB &AA        :\ F49E= AA          *
EQUB &FF        :\ F4A0= FF          .

.LF4A1
LDA &BC         :\ F4A1= A5 BC       %<
ORA &BE         :\ F4A3= 05 BE       .>
BNE LF4EE       :\ F4A5= D0 47       PG
LDA &BB         :\ F4A7= A5 BB       %;
CMP #&40        :\ F4A9= C9 40       I@
BCS LF4EE       :\ F4AB= B0 41       0A
LSR A           :\ F4AD= 4A          J
LSR A           :\ F4AE= 4A          J
STA &C0         :\ F4AF= 85 C0       .@
LDY #&00        :\ F4B1= A0 00        .
STY &C1         :\ F4B3= 84 C1       .A
LDA #&3F        :\ F4B5= A9 3F       )?
SEC             :\ F4B7= 38          8
SBC &BD         :\ F4B8= E5 BD       e=
CMP #&40        :\ F4BA= C9 40       I@
BCC LF524       :\ F4BC= 90 66       .f
RTS             :\ F4BE= 60          `

.LF4BF
LDA &BC         :\ F4BF= A5 BC       %<
ORA &BE         :\ F4C1= 05 BE       .>
BNE LF4EE       :\ F4C3= D0 29       P)
LDA &BB         :\ F4C5= A5 BB       %;
BMI LF4EE       :\ F4C7= 30 25       0%
LSR A           :\ F4C9= 4A          J
LSR A           :\ F4CA= 4A          J
STA &C0         :\ F4CB= 85 C0       .@
LDA #&3F        :\ F4CD= A9 3F       )?
SEC             :\ F4CF= 38          8
SBC &BD         :\ F4D0= E5 BD       e=
CMP #&40        :\ F4D2= C9 40       I@
BCC LF51D       :\ F4D4= 90 47       .G
RTS             :\ F4D6= 60          `

.LF4D7
LDA &BC         :\ F4D7= A5 BC       %<
ORA &BE         :\ F4D9= 05 BE       .>
BNE LF4EE       :\ F4DB= D0 11       P.
LDA &BB         :\ F4DD= A5 BB       %;
BMI LF4EE       :\ F4DF= 30 0D       0.
LSR A           :\ F4E1= 4A          J
LSR A           :\ F4E2= 4A          J
STA &C0         :\ F4E3= 85 C0       .@
LDA #&5F        :\ F4E5= A9 5F       )_
SEC             :\ F4E7= 38          8
SBC &BD         :\ F4E8= E5 BD       e=
CMP #&60        :\ F4EA= C9 60       I`
BCC LF51D       :\ F4EC= 90 2F       ./
.LF4EE
RTS             :\ F4EE= 60          `

.LF4EF
EOR #&FF        :\ F4EF= 49 FF       I.
EOR (&C0),Y     :\ F4F1= 51 C0       Q@
STA (&C0),Y     :\ F4F3= 91 C0       .@
RTS             :\ F4F5= 60          `

.LF4F6
TAX             :\ F4F6= AA          *
AND (&C0),Y     :\ F4F7= 31 C0       1@
STA (&C0),Y     :\ F4F9= 91 C0       .@
TXA             :\ F4FB= 8A          .
EOR #&FF        :\ F4FC= 49 FF       I.
AND &0315       :\ F4FE= 2D 15 03    -..
ORA (&C0),Y     :\ F501= 11 C0       .@
STA (&C0),Y     :\ F503= 91 C0       .@
RTS             :\ F505= 60          `

.LF506
LDA &BC         :\ F506= A5 BC       %<
ORA &BE         :\ F508= 05 BE       .>
BNE LF4EE       :\ F50A= D0 E2       Pb
LDA &BB         :\ F50C= A5 BB       %;
BMI LF4EE       :\ F50E= 30 DE       0^
LSR A           :\ F510= 4A          J
LSR A           :\ F511= 4A          J
STA &C0         :\ F512= 85 C0       .@
LDA #&BF        :\ F514= A9 BF       )?
SEC             :\ F516= 38          8
SBC &BD         :\ F517= E5 BD       e=
CMP #&C0        :\ F519= C9 C0       I@
BCS LF4EE       :\ F51B= B0 D1       0Q
.LF51D
LDY #&00        :\ F51D= A0 00        .
STY &C1         :\ F51F= 84 C1       .A
ASL A           :\ F521= 0A          .
ROL &C1         :\ F522= 26 C1       &A
.LF524
ASL A           :\ F524= 0A          .
ROL &C1         :\ F525= 26 C1       &A
ASL A           :\ F527= 0A          .
ROL &C1         :\ F528= 26 C1       &A
ASL A           :\ F52A= 0A          .
ROL &C1         :\ F52B= 26 C1       &A
ASL A           :\ F52D= 0A          .
ROL &C1         :\ F52E= 26 C1       &A
ADC &C0         :\ F530= 65 C0       e@
STA &C0         :\ F532= 85 C0       .@
LDA &C1         :\ F534= A5 C1       %A
ADC #&80        :\ F536= 69 80       i.
STA &C1         :\ F538= 85 C1       .A
LDA &BB         :\ F53A= A5 BB       %;
AND #&03        :\ F53C= 29 03       ).
TAX             :\ F53E= AA          *
LDA LF499,X     :\ F53F= BD 99 F4    =.t
LDX &BF         :\ F542= A6 BF       &?
DEX             :\ F544= CA          J
BEQ LF4F6       :\ F545= F0 AF       p/
DEX             :\ F547= CA          J
BEQ LF4EF       :\ F548= F0 A5       p%
AND (&C0),Y     :\ F54A= 31 C0       1@
STA (&C0),Y     :\ F54C= 91 C0       .@
RTS             :\ F54E= 60          `


\ OSWRCH HANDLER
\ ==============
.LF54F
STY &A0:STX &9F:STA &9E   :\ Save registers
LDX &0316:BEQ LF57F       :\ Jump if VDU queue empty
STA &0305,X:DEX:STX &0316 :\ Store byte in VDU queue
BNE LF578                 :\ Queue not empty, exit
LDA &0305                 :\ Get VDU command
CMP #&16:BEQ LF5D1        :\ Jump with MODE
CMP #&19:BEQ LF575        :\ Jump with PLOT
CMP #&1F:BNE LF578        :\ Exit if not TAB
JMP LF791                 :\ Jump with TAB
.LF575
JMP LF614                 :\ Jump onwards for PLOT
.LF578
LDY &A0:LDX &9F:LDA &9E   :\ Restore registers
RTS                       :\ and return

\ VDU queue empty, must be character or first byte of command
\ -----------------------------------------------------------
.LF57F
CMP #&16:BNE LF58E        :\ Jump if not VDU 22, start of MODE

\ One more byte needed
\ --------------------
.LF583
LDX #&01:STX &0316        :\ One more byte needed
STA &0305:JMP LF578       :\ Save command, and exit
.LF58E
CMP #&19:BNE LF59D        :\ Jump if not VSU 25, start of PLOT
LDX #&05:STX &0316        :\ Five more bytes needed
STA &0305:JMP LF578       :\ Save command, and exit
.LF59D
CMP #&12:BEQ LF583        :\ Jump if VDU 18, COLOUR, to collect one byte
CMP #&1F:BNE LF5B0        :\ Jump if not VDU 31, TAB
LDX #&02:STX &0316        :\ Two more bytes needed
STA &0305:JMP LF578       :\ Save command, and exit
.LF5B0
CMP #&10:BNE LF5BD        :\ Jump if not VDU 16 - CLG
LDA &032A:STA &0306
JMP LF5D1                 :\ Continue into MODE

\ VDU command sequences checked for, must be single character
\ -----------------------------------------------------------
.LF5BD
LDY &A0:LDX &9F:LDA &9E   :\ Get registers back
CMP #&61:BMI LF5CE        :\ Not a lower-case character
CMP #&7B:BPL LF5CE
SEC:SBC #&20              :\ Force lower case to upper case
.LF5CE
JMP LFE2B       :\ F5CE= 4C 2B FE    L+~


\ VDU 22,n - MODE
\ ===============
.LF5D1
LDA &0306       :\ F5D1= AD 06 03    -..
STA &B3         :\ F5D4= 85 B3       .3
JSR LF304       :\ F5D6= 20 04 F3     .s
LDA &B3         :\ F5D9= A5 B3       %3
CMP #&07        :\ F5DB= C9 07       I.
BNE LF5ED       :\ F5DD= D0 0E       P.
JSR LF578       :\ F5DF= 20 78 F5     xu
LDA #&0C        :\ F5E2= A9 0C       ).
JSR OSWRCH      :\ F5E4= 20 EE FF     n.
JSR LF578       :\ F5E7= 20 78 F5     xu
LDA #&07        :\ F5EA= A9 07       ).
RTS             :\ F5EC= 60          `

.LF5ED
JSR LF578       :\ F5ED= 20 78 F5     xu
PHA             :\ F5F0= 48          H
LDA #&19        :\ F5F1= A9 19       ).
JSR OSWRCH      :\ F5F3= 20 EE FF     n.
LDA #&04        :\ F5F6= A9 04       ).
JSR OSWRCH      :\ F5F8= 20 EE FF     n.
LDA #&00        :\ F5FB= A9 00       ).
JSR OSWRCH      :\ F5FD= 20 EE FF     n.
JSR OSWRCH      :\ F600= 20 EE FF     n.
JSR OSWRCH      :\ F603= 20 EE FF     n.
JSR OSWRCH      :\ F606= 20 EE FF     n.
PLA             :\ F609= 68          h
RTS             :\ F60A= 60          `

\ TODO UNREACHABLE

LDA &0306       :\ F60B= AD 06 03    -..
JSR LF459       :\ F60E= 20 59 F4     Yt
JMP LF578       :\ F611= 4C 78 F5    Lxu

.LF614
LDA &030A       :\ F614= AD 0A 03    -..
CMP #&40        :\ F617= C9 40       I@
BCC LF61D       :\ F619= 90 02       ..
SBC #&38        :\ F61B= E9 38       i8
.LF61D
AND #&1F        :\ F61D= 29 1F       ).
STA &030E       :\ F61F= 8D 0E 03    ...
LDA #&00        :\ F622= A9 00       ).
STA &032B       :\ F624= 8D 2B 03    .+.
LDA &0308       :\ F627= AD 08 03    -..
BPL LF636       :\ F62A= 10 0A       ..
LDX #&03        :\ F62C= A2 03       ".
JSR LF6FA       :\ F62E= 20 FA F6     zv
LDA #&FF        :\ F631= A9 FF       ).
STA &032B       :\ F633= 8D 2B 03    .+.
.LF636
LDA #&00        :\ F636= A9 00       ).
STA &BB         :\ F638= 85 BB       .;
STA &BC         :\ F63A= 85 BC       .<
LDA &0309       :\ F63C= AD 09 03    -..
.LF63F
SEC             :\ F63F= 38          8
SBC #&05        :\ F640= E9 05       i.
BCS LF649       :\ F642= B0 05       0.
DEC &0308       :\ F644= CE 08 03    N..
BMI LF651       :\ F647= 30 08       0.
.LF649
INC &BB         :\ F649= E6 BB       f;
BNE LF63F       :\ F64B= D0 F2       Pr
INC &BC         :\ F64D= E6 BC       f<
BNE LF63F       :\ F64F= D0 EE       Pn
.LF651
LDA IO8255_0       :\ F651= AD 00 70    -.p
AND #&F0        :\ F654= 29 F0       )p
CMP #&F0        :\ F656= C9 F0       Ip
BEQ LF666       :\ F658= F0 0C       p.
CMP #&20        :\ F65A= C9 20       I
BCS LF662       :\ F65C= B0 04       0.
LSR &BC         :\ F65E= 46 BC       F<
ROR &BB         :\ F660= 66 BB       f;
.LF662
LSR &BC         :\ F662= 46 BC       F<
ROR &BB         :\ F664= 66 BB       f;
.LF666
LDA &032B       :\ F666= AD 2B 03    -+.
BPL LF670       :\ F669= 10 05       ..
LDX #&08        :\ F66B= A2 08       ".
JSR LF70C       :\ F66D= 20 0C F7     .w
.LF670
LDA #&00        :\ F670= A9 00       ).
STA &032C       :\ F672= 8D 2C 03    .,.
LDA &0306       :\ F675= AD 06 03    -..
BPL LF684       :\ F678= 10 0A       ..
LDX #&01        :\ F67A= A2 01       ".
JSR LF6FA       :\ F67C= 20 FA F6     zv
LDA #&FF        :\ F67F= A9 FF       ).
STA &032C       :\ F681= 8D 2C 03    .,.
.LF684
LDA IO8255_0       :\ F684= AD 00 70    -.p
AND #&F0        :\ F687= 29 F0       )p
CMP #&10        :\ F689= C9 10       I.
BEQ LF695       :\ F68B= F0 08       p.
CMP #&30        :\ F68D= C9 30       I0
BEQ LF695       :\ F68F= F0 04       p.
CMP #&50        :\ F691= C9 50       IP
BNE LF6AA       :\ F693= D0 15       P.
.LF695
LDA &0307       :\ F695= AD 07 03    -..
STA &BD         :\ F698= 85 BD       .=
LDA &0306       :\ F69A= AD 06 03    -..
STA &BE         :\ F69D= 85 BE       .>
LSR &BE         :\ F69F= 46 BE       F>
ROR &BD         :\ F6A1= 66 BD       f=
LSR &BE         :\ F6A3= 46 BE       F>
ROR &BD         :\ F6A5= 66 BD       f=
JMP LF6E2       :\ F6A7= 4C E2 F6    Lbv

.LF6AA
LDA &0307       :\ F6AA= AD 07 03    -..
ASL A           :\ F6AD= 0A          .
STA &BD         :\ F6AE= 85 BD       .=
LDA &0306       :\ F6B0= AD 06 03    -..
ROL A           :\ F6B3= 2A          *
STA &BE         :\ F6B4= 85 BE       .>
CLC             :\ F6B6= 18          .
LDA &BD         :\ F6B7= A5 BD       %=
ADC &0307       :\ F6B9= 6D 07 03    m..
STA &BD         :\ F6BC= 85 BD       .=
LDA &BE         :\ F6BE= A5 BE       %>
ADC &0306       :\ F6C0= 6D 06 03    m..
STA &BE         :\ F6C3= 85 BE       .>
LSR &BE         :\ F6C5= 46 BE       F>
ROR &BD         :\ F6C7= 66 BD       f=
LSR &BE         :\ F6C9= 46 BE       F>
ROR &BD         :\ F6CB= 66 BD       f=
LSR &BE         :\ F6CD= 46 BE       F>
ROR &BD         :\ F6CF= 66 BD       f=
LSR &BE         :\ F6D1= 46 BE       F>
ROR &BD         :\ F6D3= 66 BD       f=
LDA IO8255_0       :\ F6D5= AD 00 70    -.p
AND #&F0        :\ F6D8= 29 F0       )p
CMP #&A0        :\ F6DA= C9 A0       I
BCS LF6EA       :\ F6DC= B0 0C       0.
CMP #&00        :\ F6DE= C9 00       I.
BNE LF6E6       :\ F6E0= D0 04       P.
.LF6E2
LSR &BE         :\ F6E2= 46 BE       F>
ROR &BD         :\ F6E4= 66 BD       f=
.LF6E6
LSR &BE         :\ F6E6= 46 BE       F>
ROR &BD         :\ F6E8= 66 BD       f=
.LF6EA
LDA &032C       :\ F6EA= AD 2C 03    -,.
BPL LF6F4       :\ F6ED= 10 05       ..
LDX #&0A        :\ F6EF= A2 0A       ".
JSR LF70C       :\ F6F1= 20 0C F7     .w
.LF6F4
JSR LF1FE       :\ F6F4= 20 FE F1     ~q
JMP LF578       :\ F6F7= 4C 78 F5    Lxu

.LF6FA
SEC             :\ F6FA= 38          8
LDA #&00        :\ F6FB= A9 00       ).
SBC &0306,X     :\ F6FD= FD 06 03    }..
STA &0306,X     :\ F700= 9D 06 03    ...
LDA #&00        :\ F703= A9 00       ).
SBC &0305,X     :\ F705= FD 05 03    }..
STA &0305,X     :\ F708= 9D 05 03    ...
RTS             :\ F70B= 60          `

.LF70C
SEC             :\ F70C= 38          8
LDA #&00        :\ F70D= A9 00       ).
SBC &B3,X       :\ F70F= F5 B3       u3
STA &B3,X       :\ F711= 95 B3       .3
LDA #&00        :\ F713= A9 00       ).
SBC &B4,X       :\ F715= F5 B4       u4
STA &B4,X       :\ F717= 95 B4       .4
RTS             :\ F719= 60          `


\ OSFILE HANDLER
\ ==============
.LF71A
STA &9E         :\ F71A= 85 9E       ..
STX &9F         :\ F71C= 86 9F       ..
STY &A0         :\ F71E= 84 A0       .
LDX #&A9        :\ F720= A2 A9       ")
LDY #&03        :\ F722= A0 03        .
.LF724
LDA (&9F),Y     :\ F724= B1 9F       1.
STA &00A9,Y     :\ F726= 99 A9 00    .).
DEY             :\ F729= 88          .
BPL LF724       :\ F72A= 10 F8       .x
LDA &9E         :\ F72C= A5 9E       %.
BEQ LF74A       :\ F72E= F0 1A       p.
LDA #&00        :\ F730= A9 00       ).
STA &AD         :\ F732= 85 AD       .-
LDY #&06        :\ F734= A0 06        .
LDA (&9F),Y     :\ F736= B1 9F       1.
BEQ LF740       :\ F738= F0 06       p.
JSR LF945       :\ F73A= 20 45 F9     Ey
JMP LF76E       :\ F73D= 4C 6E F7    Lnw
 
.LF740
LDA #&FF        :\ F740= A9 FF       ).
STA &AD         :\ F742= 85 AD       .-
JSR LF945       :\ F744= 20 45 F9     Ey
JMP LF76E       :\ F747= 4C 6E F7    Lnw
 
.LF74A
LDY #&06        :\ F74A= A0 06        .
LDA (&9F),Y     :\ F74C= B1 9F       1.
STA &AD         :\ F74E= 85 AD       .-
INY             :\ F750= C8          H
LDA (&9F),Y     :\ F751= B1 9F       1.
STA &AE         :\ F753= 85 AE       ..
LDY #&0A        :\ F755= A0 0A        .
LDA (&9F),Y     :\ F757= B1 9F       1.
STA &AF         :\ F759= 85 AF       ./
INY             :\ F75B= C8          H
LDA (&9F),Y     :\ F75C= B1 9F       1.
STA &B0         :\ F75E= 85 B0       .0
LDY #&0E        :\ F760= A0 0E        .
LDA (&9F),Y     :\ F762= B1 9F       1.
STA &B1         :\ F764= 85 B1       .1
INY             :\ F766= C8          H
LDA (&9F),Y     :\ F767= B1 9F       1.
STA &B2         :\ F769= 85 B2       .2
JSR LFAB8       :\ F76B= 20 B8 FA     8z
.LF76E
LDA &9E         :\ F76E= A5 9E       %.
LDX &9F         :\ F770= A6 9F       &.
LDY &A0         :\ F772= A4 A0       $
RTS             :\ F774= 60          `


\ CLI HANDLER
\ =========== 
.LF775
STA &9B         :\ F775= 85 9B       ..
STX &9C         :\ F777= 86 9C       ..
STY &9D         :\ F779= 84 9D       ..
LDY #&01        :\ F77B= A0 01        .
.LF77D
LDA (&9C),Y     :\ F77D= B1 9C       1.
STA &00FF,Y     :\ F77F= 99 FF 00    ...
INY             :\ F782= C8          H
CMP #&0D        :\ F783= C9 0D       I.
BNE LF77D       :\ F785= D0 F6       Pv
JSR LF8C3       :\ F787= 20 C3 F8     Cx
LDY &9D         :\ F78A= A4 9D       $.
LDX &9C         :\ F78C= A6 9C       &.
LDA &9B         :\ F78E= A5 9B       %.
RTS             :\ F790= 60          `


\ VDU 31,x,y - TAB
\ ================
.LF791
LDX &0307       :\ F791= AE 07 03    ...
CPX #&20        :\ F794= E0 20       `
BCS LF7B6       :\ F796= B0 1E       0.
LDA &0306       :\ F798= AD 06 03    -..
CMP #&10        :\ F79B= C9 10       I.
BCS LF7B6       :\ F79D= B0 17       0.
LDY &E0         :\ F79F= A4 E0       $`
JSR LFD1D       :\ F7A1= 20 1D FD     .}
STX &E0         :\ F7A4= 86 E0       .`
LSR &DF         :\ F7A6= 46 DF       F_
ASL A           :\ F7A8= 0A          .
ASL A           :\ F7A9= 0A          .
ASL A           :\ F7AA= 0A          .
ASL A           :\ F7AB= 0A          .
ASL A           :\ F7AC= 0A          .
STA &DE         :\ F7AD= 85 DE       .^
ROL &DF         :\ F7AF= 26 DF       &_
LDY &E0         :\ F7B1= A4 E0       $`
JSR LFD1D       :\ F7B3= 20 1D FD     .}
.LF7B6
JMP LF578       :\ F7B6= 4C 78 F5    Lxu

.LF7B9
EQUS " WORK +"


\ PRINT INLINE TEXT
\ =================
.LF7C0
PLA:STA &E8:PLA:STA &E9    :\ &E8/9=>inline text
.LF7C6
LDY #&00
INC &E8:BNE LF7CE:INC &E9  :\ Update address
.LF7CE
LDA (&E8),Y:BMI LF7D8      :\ b7=1, end of text
JSR OSWRCH:JMP LF7C6       :\ Print character and loop for more
.LF7D8
JMP (&00E8)                :\ Jump back to code after text


.LF7DB
LDX #&D4        :\ F7DB= A2 D4       "T
JSR LF7E0       :\ F7DD= 20 E0 F7     `w
.LF7E0
LDA &01,X       :\ F7E0= B5 01       5.
JSR LF7F1       :\ F7E2= 20 F1 F7     qw
INX             :\ F7E5= E8          h
INX             :\ F7E6= E8          h
LDA &FE,X       :\ F7E7= B5 FE       5~
JSR LF7F1       :\ F7E9= 20 F1 F7     qw
.LF7EC
LDA #&20        :\ F7EC= A9 20       )
JMP OSWRCH      :\ F7EE= 4C EE FF    Ln.
 
.LF7F1
PHA             :\ F7F1= 48          H
LSR A           :\ F7F2= 4A          J
LSR A           :\ F7F3= 4A          J
LSR A           :\ F7F4= 4A          J
LSR A           :\ F7F5= 4A          J
JSR LF7FA       :\ F7F6= 20 FA F7     zw
PLA             :\ F7F9= 68          h
.LF7FA
AND #&0F        :\ F7FA= 29 0F       ).
CMP #&0A        :\ F7FC= C9 0A       I.
BCC LF802       :\ F7FE= 90 02       ..
ADC #&06        :\ F800= 69 06       i.
.LF802
ADC #&30        :\ F802= 69 30       i0
JMP OSWRCH      :\ F804= 4C EE FF    Ln.

.LF807
JSR LF863       :\ F807= 20 63 F8     cx
LDX #&00        :\ F80A= A2 00       ".
CMP #&22        :\ F80C= C9 22       I"
BEQ LF816       :\ F80E= F0 06       p.
INX             :\ F810= E8          h
BNE LF82E       :\ F811= D0 1B       P.
.LF813
JMP LFA53       :\ F813= 4C 53 FA    LSz

.LF816
INY             :\ F816= C8          H
LDA &0100,Y     :\ F817= B9 00 01    9..
CMP #&0D        :\ F81A= C9 0D       I.
BEQ LF813       :\ F81C= F0 F5       pu
STA &0140,X     :\ F81E= 9D 40 01    .@.
INX             :\ F821= E8          h
CMP #&22        :\ F822= C9 22       I"
BNE LF816       :\ F824= D0 F0       Pp
INY             :\ F826= C8          H
LDA &0100,Y     :\ F827= B9 00 01    9..
CMP #&22        :\ F82A= C9 22       I"
BEQ LF816       :\ F82C= F0 E8       ph
.LF82E
LDA #&0D        :\ F82E= A9 0D       ).
STA &013F,X     :\ F830= 9D 3F 01    .?.
LDA #&40        :\ F833= A9 40       )@
STA &C9         :\ F835= 85 C9       .I
LDA #&01        :\ F837= A9 01       ).
STA &CA         :\ F839= 85 CA       .J
LDX #&C9        :\ F83B= A2 C9       "I
RTS             :\ F83D= 60          `
 
.LF83E
LDY #&00        :\ F83E= A0 00        .
.LF840
LDA &00,X       :\ F840= B5 00       5.
STA &00C9,Y     :\ F842= 99 C9 00    .I.
INX             :\ F845= E8          h
INY             :\ F846= C8          H
CPY #&0A        :\ F847= C0 0A       @.
BCC LF840       :\ F849= 90 F5       .u
LDY #&FF        :\ F84B= A0 FF        .
LDA #&0D        :\ F84D= A9 0D       ).
.LF84F
INY             :\ F84F= C8          H
CPY #&0E        :\ F850= C0 0E       @.
BCS LF85B       :\ F852= B0 07       0.
CMP (&C9),Y     :\ F854= D1 C9       QI
BNE LF84F       :\ F856= D0 F7       Pw
CPY #&00        :\ F858= C0 00       @.
RTS             :\ F85A= 60          `
 
.LF85B
BRK             :\ F85B= 00          .
EQUB &FE
EQUS "NAME"
EQUB 0

.LF862
INY             :\ F862= C8          H
.LF863
LDA &0100,Y     :\ F863= B9 00 01    9..
CMP #&20        :\ F866= C9 20       I 
BEQ LF862       :\ F868= F0 F8       px
RTS             :\ F86A= 60          `
 
.LF86B
CMP #&30        :\ F86B= C9 30       I0
BCC LF87E       :\ F86D= 90 0F       ..
CMP #&3A        :\ F86F= C9 3A       I:
BCC LF87B       :\ F871= 90 08       ..
SBC #&07        :\ F873= E9 07       i.
BCC LF87E       :\ F875= 90 07       ..
CMP #&40        :\ F877= C9 40       I@
BCS LF87D       :\ F879= B0 02       0.
.LF87B
AND #&0F        :\ F87B= 29 0F       ).
.LF87D
RTS             :\ F87D= 60          `

.LF87E
SEC             :\ F87E= 38          8
RTS             :\ F87F= 60          `

.LF880
LDA #&00        :\ F880= A9 00       ).
STA &00,X       :\ F882= 95 00       ..
STA &01,X       :\ F884= 95 01       ..
STA &02,X       :\ F886= 95 02       ..
JSR LF863       :\ F888= 20 63 F8     cx
.LF88B
LDA &0100,Y     :\ F88B= B9 00 01    9..
JSR LF86B       :\ F88E= 20 6B F8     kx
BCS LF8A8       :\ F891= B0 15       0.
ASL A           :\ F893= 0A          .
ASL A           :\ F894= 0A          .
ASL A           :\ F895= 0A          .
ASL A           :\ F896= 0A          .
STY &02,X       :\ F897= 94 02       ..
LDY #&04        :\ F899= A0 04        .
.LF89B
ASL A           :\ F89B= 0A          .
ROL &00,X       :\ F89C= 36 00       6.
ROL &01,X       :\ F89E= 36 01       6.
DEY             :\ F8A0= 88          .
BNE LF89B       :\ F8A1= D0 F8       Px
LDY &02,X       :\ F8A3= B4 02       4.
INY             :\ F8A5= C8          H
BNE LF88B       :\ F8A6= D0 E3       Pc
.LF8A8
LDA &02,X       :\ F8A8= B5 02       5.
RTS             :\ F8AA= 60          `

.LF8AB
EQUS "CAT"
EQUB >LFA00
EQUB <LFA00
EQUS "LOAD"
EQUB >LF932
EQUB <LF932
EQUS "SAVE"
EQUB >LFA91
EQUB <LFA91
EQUS "RUN"
EQUB >LF9F6
EQUB <LF9F6
EQUB >LF8FA
EQUB <LF8FA

.LF8C3
LDX #&FF        :\ F8C3= A2 FF       ".
CLD             :\ F8C5= D8          X
.LF8C6
LDY #&00        :\ F8C6= A0 00        .
STY &DD         :\ F8C8= 84 DD       .]
JSR LF863       :\ F8CA= 20 63 F8     cx
DEY             :\ F8CD= 88          .
.LF8CE
INY             :\ F8CE= C8          H
INX             :\ F8CF= E8          h
.LF8D0
LDA LF8AB,X     :\ F8D0= BD AB F8    =+x
BMI LF8ED       :\ F8D3= 30 18       0.
CMP &0100,Y     :\ F8D5= D9 00 01    Y..
BEQ LF8CE       :\ F8D8= F0 F4       pt
DEX             :\ F8DA= CA          J
.LF8DB
INX             :\ F8DB= E8          h
LDA LF8AB,X     :\ F8DC= BD AB F8    =+x
BPL LF8DB       :\ F8DF= 10 FA       .z
INX             :\ F8E1= E8          h
LDA &0100,Y     :\ F8E2= B9 00 01    9..
CMP #&2E        :\ F8E5= C9 2E       I.
BNE LF8C6       :\ F8E7= D0 DD       P]
INY             :\ F8E9= C8          H
DEX             :\ F8EA= CA          J
BCS LF8D0       :\ F8EB= B0 E3       0c
.LF8ED
STA &CA         :\ F8ED= 85 CA       .J
LDA LF8AB+1,X     :\ F8EF= BD AC F8    =,x
STA &C9         :\ F8F2= 85 C9       .I
CLC             :\ F8F4= 18          .
LDX #&00        :\ F8F5= A2 00       ".
JMP (&00C9)     :\ F8F7= 6C C9 00    lI.

.LF8FA
BRK
EQUB &FE
EQUS "BAD COMMAND"
EQUB 0

\ OSARGS HANDLER
\ ==============
.LF908
BRK             :\ F908= 00          .
.LF909
JSR LFB61       :\ F909= 20 61 FB     a{
BVC LF908       :\ F90C= 50 FA       Pz
BEQ LF909       :\ F90E= F0 F9       py
JSR LFBFE       :\ F910= 20 FE FB     ~{
LDY #&00        :\ F913= A0 00        .
.LF915
JSR OSBGET      :\ F915= 20 D7 FF     W.
STA (&CB),Y     :\ F918= 91 CB       .K
INC &CB         :\ F91A= E6 CB       fK
BNE LF920       :\ F91C= D0 02       P.
INC &CC         :\ F91E= E6 CC       fL
.LF920
LDX #&D4        :\ F920= A2 D4       "T
JSR LF9DE       :\ F922= 20 DE F9     ^y
BNE LF915       :\ F925= D0 EE       Pn
SEC             :\ F927= 38          8
.LF928
ROR &DD         :\ F928= 66 DD       f]
CLC             :\ F92A= 18          .
ROR &DD         :\ F92B= 66 DD       f]
PLP             :\ F92D= 28          (
RTS             :\ F92E= 60          `

\ TODO: UNREACHABLE
SEC             :\ F92F= 38          8
ROR &DD         :\ F930= 66 DD       f]
.LF932
JSR LF807       :\ F932= 20 07 F8     .x
LDX #&CB        :\ F935= A2 CB       "K
JSR LF880       :\ F937= 20 80 F8     .x
BEQ LF940       :\ F93A= F0 04       p.
LDA #&FF        :\ F93C= A9 FF       ).
STA &CD         :\ F93E= 85 CD       .M
.LF940
JSR LFA4C       :\ F940= 20 4C FA     Lz
LDX #&C9        :\ F943= A2 C9       "I
.LF945
PHP             :\ F945= 08          .
SEI             :\ F946= 78          x
JSR LF83E       :\ F947= 20 3E F8     >x
PHP             :\ F94A= 08          .
JSR LFC13       :\ F94B= 20 13 FC     .|
PLP             :\ F94E= 28          (
BEQ LF909       :\ F94F= F0 B8       p8
LDA #&00        :\ F951= A9 00       ).
STA &D0         :\ F953= 85 D0       .P
STA &D1         :\ F955= 85 D1       .Q
.LF957
JSR LF979       :\ F957= 20 79 F9     yy
BCC LF928       :\ F95A= 90 CC       .L
INC &D0         :\ F95C= E6 D0       fP
INC &CC         :\ F95E= E6 CC       fL
BNE LF957       :\ F960= D0 F5       Pu
CLC             :\ F962= 18          .
BCC LF928       :\ F963= 90 C3       .C
.LF965
JSR OSWRCH      :\ F965= 20 EE FF     n.
INY             :\ F968= C8          H
.LF969
LDA &00ED,Y     :\ F969= B9 ED 00    9m.
CMP #&0D        :\ F96C= C9 0D       I.
BNE LF965       :\ F96E= D0 F5       Pu
.LF970
INY             :\ F970= C8          H
JSR LF7EC       :\ F971= 20 EC F7     lw
CPY #&0E        :\ F974= C0 0E       @.
BCC LF970       :\ F976= 90 F8       .x
RTS             :\ F978= 60          `

.LF979
LDA #&00        :\ F979= A9 00       ).
STA &DC         :\ F97B= 85 DC       .\
JSR LFB61       :\ F97D= 20 61 FB     a{
BVC LF979+1     :\ F980= 50 F8       Px
BNE LF979       :\ F982= D0 F5       Pu
JSR LFB9C       :\ F984= 20 9C FB     .{
PHP             :\ F987= 08          .
JSR LFBB5       :\ F988= 20 B5 FB     5{
PLP             :\ F98B= 28          (
BEQ LF99E       :\ F98C= F0 10       p.
LDA &DB         :\ F98E= A5 DB       %[
AND #&20        :\ F990= 29 20       )
ORA &EA         :\ F992= 05 EA       .j
BNE LF979       :\ F994= D0 E3       Pc
JSR LF969       :\ F996= 20 69 F9     iy
JSR OSNEWL      :\ F999= 20 E7 FF     g.
BNE LF979       :\ F99C= D0 DB       P[
.LF99E
LDX #&02        :\ F99E= A2 02       ".
LDA &DD         :\ F9A0= A5 DD       %]
BMI LF9B7       :\ F9A2= 30 13       0.
.LF9A4
LDA &CF,X       :\ F9A4= B5 CF       5O
CMP &D8,X       :\ F9A6= D5 D8       UX
BCS LF9B2       :\ F9A8= B0 08       0.
LDA #&05        :\ F9AA= A9 05       ).
JSR LFC15       :\ F9AC= 20 15 FC     .|
JSR LFC13       :\ F9AF= 20 13 FC     .|
.LF9B2
BNE LF979       :\ F9B2= D0 C5       PE
DEX             :\ F9B4= CA          J
BNE LF9A4       :\ F9B5= D0 ED       Pm
.LF9B7
JSR LFBFE       :\ F9B7= 20 FE FB     ~{
BIT &DB         :\ F9BA= 24 DB       $[
BVC LF9C9       :\ F9BC= 50 0B       P.
DEY             :\ F9BE= 88          .
.LF9BF
INY             :\ F9BF= C8          H
JSR OSBGET      :\ F9C0= 20 D7 FF     W.
STA (&CB),Y     :\ F9C3= 91 CB       .K
CPY &D8         :\ F9C5= C4 D8       DX
BNE LF9BF       :\ F9C7= D0 F6       Pv
.LF9C9
LDA &DC         :\ F9C9= A5 DC       %\
STA &CE         :\ F9CB= 85 CE       .N
JSR OSBGET      :\ F9CD= 20 D7 FF     W.
CMP &CE         :\ F9D0= C5 CE       EN
BEQ LF9DB       :\ F9D2= F0 07       p.

BRK             :\ F9D4= 00          .
EQUB &FE
EQUS "SUM?"
EQUB 0

.LF9DB
ROL &DB         :\ F9DB= 26 DB       &[
RTS             :\ F9DD= 60          `

.LF9DE
INC &00,X       :\ F9DE= F6 00       v.
BNE LF9E4       :\ F9E0= D0 02       P.
INC &01,X       :\ F9E2= F6 01       v.
.LF9E4
LDA &00,X       :\ F9E4= B5 00       5.
CMP &02,X       :\ F9E6= D5 02       U.
BNE LF9EE       :\ F9E8= D0 04       P.
LDA &01,X       :\ F9EA= B5 01       5.
CMP &03,X       :\ F9EC= D5 03       U.
.LF9EE
RTS             :\ F9EE= 60          `

\ TODO: UNREACHABLE

DEX             :\ F9EF= CA          J
JSR LFA4C       :\ F9F0= 20 4C FA     Lz
STX &EA         :\ F9F3= 86 EA       .j
.LF9F5
RTS             :\ F9F5= 60          `

.LF9F6
JSR LF932       :\ F9F6= 20 32 F9     2y
BIT &DD         :\ F9F9= 24 DD       $]
BVS LFA49       :\ F9FB= 70 4C       pL
JMP (&00D6)     :\ F9FD= 6C D6 00    lV.


\ *CAT
\ ====
.LFA00
PHP             :\ FA00= 08          .
JSR LFA4C       :\ FA01= 20 4C FA     Lz
JSR LFC13       :\ FA04= 20 13 FC     .|
.LFA07
JSR LFB61       :\ FA07= 20 61 FB     a{
BVS LFA0E       :\ FA0A= 70 02       p.
PLP             :\ FA0C= 28          (
RTS             :\ FA0D= 60          `

.LFA0E
BEQ LFA1A       :\ FA0E= F0 0A       p.
LDY #&00        :\ FA10= A0 00        .
JSR LF970       :\ FA12= 20 70 F9     py
JSR LF7DB       :\ FA15= 20 DB F7     [w
BNE LFA33       :\ FA18= D0 19       P.
.LFA1A
JSR LFB9C       :\ FA1A= 20 9C FB     .{
JSR LFBB5       :\ FA1D= 20 B5 FB     5{
JSR LF969       :\ FA20= 20 69 F9     iy
JSR LF7DB       :\ FA23= 20 DB F7     [w
ROL &DB         :\ FA26= 26 DB       &[
BPL LFA33       :\ FA28= 10 09       ..
INX             :\ FA2A= E8          h
JSR LF7E0       :\ FA2B= 20 E0 F7     `w
LDA &FD,X       :\ FA2E= B5 FD       5}
JSR LF7F1       :\ FA30= 20 F1 F7     qw
.LFA33
JSR OSNEWL      :\ FA33= 20 E7 FF     g.
BNE LFA07       :\ FA36= D0 CF       PO
JMP OSNEWL      :\ FA38= 4C E7 FF    Lg.

.LFA3B
JSR LF880       :\ FA3B= 20 80 F8     .x
BEQ LFA53       :\ FA3E= F0 13       p.
RTS             :\ FA40= 60          `

LDX #&CB        :\ FA41= A2 CB       "K
JSR LFA3B       :\ FA43= 20 3B FA     ;z
JSR LFA4C       :\ FA46= 20 4C FA     Lz
.LFA49
JMP (&00CB)     :\ FA49= 6C CB 00    lK.

.LFA4C
JSR LF863       :\ FA4C= 20 63 F8     cx
CMP #&0D        :\ FA4F= C9 0D       I.
BEQ LF9F5       :\ FA51= F0 A2       p"
.LFA53
BRK             :\ FA53= 00          .
EQUB &FE
EQUS "SYNTAX"
EQUB 0

.LFA5C
SEC             :\ FA5C= 38          8
LDA &D1         :\ FA5D= A5 D1       %Q
SBC &CF         :\ FA5F= E5 CF       eO
PHA             :\ FA61= 48          H
LDA &D2         :\ FA62= A5 D2       %R
SBC &D0         :\ FA64= E5 D0       eP
TAY             :\ FA66= A8          (
PLA             :\ FA67= 68          h
CLC             :\ FA68= 18          .
ADC &CB         :\ FA69= 65 CB       eK
STA &CD         :\ FA6B= 85 CD       .M
TYA             :\ FA6D= 98          .
ADC &CC         :\ FA6E= 65 CC       eL
STA &CE         :\ FA70= 85 CE       .N
LDY #&04        :\ FA72= A0 04        .
.LFA74
LDA &00CA,Y     :\ FA74= B9 CA 00    9J.
JSR OSBPUT      :\ FA77= 20 D4 FF     T.
DEY             :\ FA7A= 88          .
BNE LFA74       :\ FA7B= D0 F7       Pw
.LFA7D
LDA (&CF),Y     :\ FA7D= B1 CF       1O
JSR OSBPUT      :\ FA7F= 20 D4 FF     T.
INC &CF         :\ FA82= E6 CF       fO
BNE LFA88       :\ FA84= D0 02       P.
INC &D0         :\ FA86= E6 D0       fP
.LFA88
LDX #&CB        :\ FA88= A2 CB       "K
JSR LF9DE       :\ FA8A= 20 DE F9     ^y
BNE LFA7D       :\ FA8D= D0 EE       Pn
PLP             :\ FA8F= 28          (
RTS             :\ FA90= 60          `

.LFA91
JSR LF807       :\ FA91= 20 07 F8     .x
LDX #&CB        :\ FA94= A2 CB       "K
JSR LFA3B       :\ FA96= 20 3B FA     ;z
LDX #&D1        :\ FA99= A2 D1       "Q
JSR LFA3B       :\ FA9B= 20 3B FA     ;z
LDX #&CD        :\ FA9E= A2 CD       "M
JSR LF880       :\ FAA0= 20 80 F8     .x
PHP             :\ FAA3= 08          .
LDA &CB         :\ FAA4= A5 CB       %K
LDX &CC         :\ FAA6= A6 CC       &L
PLP             :\ FAA8= 28          (
BNE LFAAF       :\ FAA9= D0 04       P.
STA &CD         :\ FAAB= 85 CD       .M
STX &CE         :\ FAAD= 86 CE       .N
.LFAAF
STA &CF         :\ FAAF= 85 CF       .O
STX &D0         :\ FAB1= 86 D0       .P
JSR LFA4C       :\ FAB3= 20 4C FA     Lz
LDX #&C9        :\ FAB6= A2 C9       "I
.LFAB8
PHP             :\ FAB8= 08          .
SEI             :\ FAB9= 78          x
JSR LF83E       :\ FABA= 20 3E F8     >x
PHP             :\ FABD= 08          .
LDA #&06        :\ FABE= A9 06       ).
JSR LFC15       :\ FAC0= 20 15 FC     .|
LDX #&07        :\ FAC3= A2 07       ".
JSR LFB4D       :\ FAC5= 20 4D FB     M{
PLP             :\ FAC8= 28          (
BEQ LFA5C       :\ FAC9= F0 91       p.
LDX #&04        :\ FACB= A2 04       ".
.LFACD
LDA &CE,X       :\ FACD= B5 CE       5N
STA &D2,X       :\ FACF= 95 D2       .R
DEX             :\ FAD1= CA          J
BNE LFACD       :\ FAD2= D0 F9       Py
STX &D0         :\ FAD4= 86 D0       .P
STX &D1         :\ FAD6= 86 D1       .Q
LDA &D5         :\ FAD8= A5 D5       %U
BNE LFADE       :\ FADA= D0 02       P.
DEC &D6         :\ FADC= C6 D6       FV
.LFADE
DEC &D5         :\ FADE= C6 D5       FU
CLC             :\ FAE0= 18          .
.LFAE1
ROR &D2         :\ FAE1= 66 D2       fR
SEC             :\ FAE3= 38          8
LDX #&FF        :\ FAE4= A2 FF       ".
LDA &D5         :\ FAE6= A5 D5       %U
SBC &D3         :\ FAE8= E5 D3       eS
STA &CF         :\ FAEA= 85 CF       .O
LDA &D6         :\ FAEC= A5 D6       %V
SBC &D4         :\ FAEE= E5 D4       eT
PHP             :\ FAF0= 08          .
ROR &D2         :\ FAF1= 66 D2       fR
PLP             :\ FAF3= 28          (
BCC LFAFC       :\ FAF4= 90 06       ..
CLC             :\ FAF6= 18          .
BEQ LFAFC       :\ FAF7= F0 03       p.
STX &CF         :\ FAF9= 86 CF       .O
SEC             :\ FAFB= 38          8
.LFAFC
ROR &D2         :\ FAFC= 66 D2       fR
INX             :\ FAFE= E8          h
JSR LFB0E       :\ FAFF= 20 0E FB     .{
INC &D0         :\ FB02= E6 D0       fP
INC &D4         :\ FB04= E6 D4       fT
INC &CC         :\ FB06= E6 CC       fL
ROL &D2         :\ FB08= 26 D2       &R
BCS LFAE1       :\ FB0A= B0 D5       0U
PLP             :\ FB0C= 28          (
RTS             :\ FB0D= 60          `
 
.LFB0E
LDX #&07        :\ FB0E= A2 07       ".
JSR LFB4D       :\ FB10= 20 4D FB     M{
STX &DC         :\ FB13= 86 DC       .\
LDY #&04        :\ FB15= A0 04        .
.LFB17
LDA #&2A        :\ FB17= A9 2A       )*
JSR OSBPUT      :\ FB19= 20 D4 FF     T.
DEY             :\ FB1C= 88          .
BNE LFB17       :\ FB1D= D0 F8       Px
.LFB1F
LDA (&C9),Y     :\ FB1F= B1 C9       1I
JSR OSBPUT      :\ FB21= 20 D4 FF     T.
INY             :\ FB24= C8          H
CMP #&0D        :\ FB25= C9 0D       I.
BNE LFB1F       :\ FB27= D0 F6       Pv
LDY #&08        :\ FB29= A0 08        .
.LFB2B
LDA &00CA,Y     :\ FB2B= B9 CA 00    9J.
JSR OSBPUT      :\ FB2E= 20 D4 FF     T.
DEY             :\ FB31= 88          .
BNE LFB2B       :\ FB32= D0 F7       Pw
JSR LFB54       :\ FB34= 20 54 FB     T{
BIT &D2         :\ FB37= 24 D2       $R
BVC LFB46       :\ FB39= 50 0B       P.
DEY             :\ FB3B= 88          .
.LFB3C
INY             :\ FB3C= C8          H
LDA (&D3),Y     :\ FB3D= B1 D3       1S
JSR OSBPUT      :\ FB3F= 20 D4 FF     T.
CPY &CF         :\ FB42= C4 CF       DO
BNE LFB3C       :\ FB44= D0 F6       Pv
.LFB46
LDA &DC         :\ FB46= A5 DC       %\
JSR OSBPUT      :\ FB48= 20 D4 FF     T.
LDX #&04        :\ FB4B= A2 04       ".
.LFB4D
STX IO8255_2       :\ FB4D= 8E 02 70    ..p
LDX #&78        :\ FB50= A2 78       "x
BNE LFB56       :\ FB52= D0 02       P.
.LFB54
LDX #&1E        :\ FB54= A2 1E       ".
.LFB56
JSR LFE3F       :\ FB56= 20 3F FE     ?~
DEX             :\ FB59= CA          J
BNE LFB56       :\ FB5A= D0 FA       Pz
RTS             :\ FB5C= 60          `
 
.LFB5D
LDX #&06        :\ FB5D= A2 06       ".
BNE LFB56       :\ FB5F= D0 F5       Pu
.LFB61
BIT IO8255_1       :\ FB61= 2C 01 70    ,.p
BPL LFB61       :\ FB64= 10 FB       .{
BVC LFB61       :\ FB66= 50 F9       Py
.LFB68
LDY #&00        :\ FB68= A0 00        .
STA &C3         :\ FB6A= 85 C3       .C
LDA #&10        :\ FB6C= A9 10       ).
STA &C2         :\ FB6E= 85 C2       .B
.LFB70
BIT IO8255_1       :\ FB70= 2C 01 70    ,.p
BPL LFB84       :\ FB73= 10 0F       ..
BVC LFB84       :\ FB75= 50 0D       P.
JSR LFC92       :\ FB77= 20 92 FC     .|
BCS LFB68       :\ FB7A= B0 EC       0l
DEC &C3         :\ FB7C= C6 C3       FC
BNE LFB70       :\ FB7E= D0 F0       Pp
DEC &C2         :\ FB80= C6 C2       FB
BNE LFB70       :\ FB82= D0 EC       Pl
.LFB84
BVS LFB87       :\ FB84= 70 01       p.
RTS             :\ FB86= 60          `

.LFB87
LDY #&04        :\ FB87= A0 04        .
PHP             :\ FB89= 08          .
JSR LFBB7       :\ FB8A= 20 B7 FB     7{
PLP             :\ FB8D= 28          (
LDY #&04        :\ FB8E= A0 04        .
LDA #&2A        :\ FB90= A9 2A       )*
.LFB92
CMP &00D3,Y     :\ FB92= D9 D3 00    YS.
BNE LFB9A       :\ FB95= D0 03       P.
DEY             :\ FB97= 88          .
BNE LFB92       :\ FB98= D0 F8       Px
.LFB9A
RTS             :\ FB9A= 60          `
 
.LFB9B
INY             :\ FB9B= C8          H
.LFB9C
JSR OSBGET      :\ FB9C= 20 D7 FF     W.
STA &00ED,Y     :\ FB9F= 99 ED 00    .m.
CMP #&0D        :\ FBA2= C9 0D       I.
BNE LFB9B       :\ FBA4= D0 F5       Pu
LDY #&FF        :\ FBA6= A0 FF        .
.LFBA8
INY             :\ FBA8= C8          H
LDA (&C9),Y     :\ FBA9= B1 C9       1I
CMP &00ED,Y     :\ FBAB= D9 ED 00    Ym.
BNE LFB9A       :\ FBAE= D0 EA       Pj
CMP #&0D        :\ FBB0= C9 0D       I.
BNE LFBA8       :\ FBB2= D0 F4       Pt
RTS             :\ FBB4= 60          `
 
.LFBB5
LDY #&08        :\ FBB5= A0 08        .
.LFBB7
JSR OSBGET      :\ FBB7= 20 D7 FF     W.
STA &00D3,Y     :\ FBBA= 99 D3 00    .S.
DEY             :\ FBBD= 88          .
BNE LFBB7       :\ FBBE= D0 F7       Pw
RTS             :\ FBC0= 60          `


\ OSBGET HANDLER
\ ============== 
.LFBC1
STX &EC         :\ FBC1= 86 EC       .l
STY &C3         :\ FBC3= 84 C3       .C
PHP             :\ FBC5= 08          .
SEI             :\ FBC6= 78          x
.LFBC7
LDA #&78        :\ FBC7= A9 78       )x
STA &C0         :\ FBC9= 85 C0       .@
.LFBCB
JSR LFC92       :\ FBCB= 20 92 FC     .|
BCC LFBC7       :\ FBCE= 90 F7       .w
INC &C0         :\ FBD0= E6 C0       f@
BPL LFBCB       :\ FBD2= 10 F7       .w
.LFBD4
LDA #&53        :\ FBD4= A9 53       )S
STA &C4         :\ FBD6= 85 C4       .D
LDX #&00        :\ FBD8= A2 00       ".
LDY IO8255_2       :\ FBDA= AC 02 70    ,.p
.LFBDD
JSR LFCA2       :\ FBDD= 20 A2 FC     "|
BEQ LFBE2       :\ FBE0= F0 00       p.
.LFBE2
BEQ LFBE5       :\ FBE2= F0 01       p.
INX             :\ FBE4= E8          h
.LFBE5
DEC &C4         :\ FBE5= C6 C4       FD
BNE LFBDD       :\ FBE7= D0 F4       Pt
CPX #&0C        :\ FBE9= E0 0C       `.
ROR &C0         :\ FBEB= 66 C0       f@
BCC LFBD4       :\ FBED= 90 E5       .e
LDA &C0         :\ FBEF= A5 C0       %@
PLP             :\ FBF1= 28          (
LDY &C3         :\ FBF2= A4 C3       $C
LDX &EC         :\ FBF4= A6 EC       &l
.LFBF6
PHA             :\ FBF6= 48          H
CLC             :\ FBF7= 18          .
ADC &DC         :\ FBF8= 65 DC       e\
STA &DC         :\ FBFA= 85 DC       .\
PLA             :\ FBFC= 68          h
RTS             :\ FBFD= 60          `
 
.LFBFE
LDA &CD         :\ FBFE= A5 CD       %M
BMI LFC0A       :\ FC00= 30 08       0.
LDA &D4         :\ FC02= A5 D4       %T
STA &CB         :\ FC04= 85 CB       .K
LDA &D5         :\ FC06= A5 D5       %U
STA &CC         :\ FC08= 85 CC       .L
.LFC0A
RTS             :\ FC0A= 60          `


\ DEFAULT OSFIND HANDLER
\ ======================
.LFC0B
CMP #&C0:BEQ LFC13       :\ Jump with OPENUP
LDA #&06:BNE LFC15       :\ A=&06 for OPENIN/OPENOUT/CLOSE
.LFC13
LDA #&04                 :\ A=&04 for OPENUP
.LFC15
LDX #&07:STX IO8255_2
BIT &EA:BNE LFC4B
CMP #&05:BEQ LFC38:BCS LFC2D
JSR LF7C0
EQUS "PLAY"
BNE LFC42

.LFC2D
JSR LF7C0       :\ FC2D= 20 C0 F7     @w
EQUS "RECORD"
BNE LFC42       :\ FC36= D0 0A       P.
.LFC38
JSR LF7C0       :\ FC38= 20 C0 F7     @w
EQUS "REWIND"
NOP             :\ FC41= EA          j
.LFC42
JSR LF7C0       :\ FC42= 20 C0 F7     @w
EQUS " TAPE"
NOP             :\ FC4A= EA          j
.LFC4B
JSR OSRDCH      :\ FC4B= 20 E0 FF     `.
JMP OSNEWL      :\ FC4E= 4C E7 FF    Lg.


\ OSBPUT HANDLER
\ ==============
.LFC51
STX &EC         :\ FC51= 86 EC       .l
STY &C3         :\ FC53= 84 C3       .C
PHP             :\ FC55= 08          .
SEI             :\ FC56= 78          x
PHA             :\ FC57= 48          H
JSR LFBF6       :\ FC58= 20 F6 FB     v{
STA &C0         :\ FC5B= 85 C0       .@
JSR LFCAD       :\ FC5D= 20 AD FC     -|
LDA #&0A        :\ FC60= A9 0A       ).
STA &C1         :\ FC62= 85 C1       .A
CLC             :\ FC64= 18          .
.LFC65
BCC LFC71       :\ FC65= 90 0A       ..
LDX #&07        :\ FC67= A2 07       ".
STX IO8255_2       :\ FC69= 8E 02 70    ..p
JSR LFCAF       :\ FC6C= 20 AF FC     /|
BMI LFC84       :\ FC6F= 30 13       0.
.LFC71
LDY #&04        :\ FC71= A0 04        .
.LFC73
LDA #&04        :\ FC73= A9 04       ).
.LFC75
STA IO8255_2       :\ FC75= 8D 02 70    ..p
JSR LFCAD       :\ FC78= 20 AD FC     -|
INC IO8255_2       :\ FC7B= EE 02 70    n.p
JSR LFCAD       :\ FC7E= 20 AD FC     -|
DEY             :\ FC81= 88          .
BNE LFC73       :\ FC82= D0 EF       Po
.LFC84
SEC             :\ FC84= 38          8
ROR &C0         :\ FC85= 66 C0       f@
DEC &C1         :\ FC87= C6 C1       FA
BNE LFC65       :\ FC89= D0 DA       PZ
LDY &C3         :\ FC8B= A4 C3       $C
LDX &EC         :\ FC8D= A6 EC       &l
.LFC8F
PLA             :\ FC8F= 68          h
PLP             :\ FC90= 28          (
RTS             :\ FC91= 60          `
 
.LFC92
LDX #&00        :\ FC92= A2 00       ".
LDY IO8255_2       :\ FC94= AC 02 70    ,.p
.LFC97
INX             :\ FC97= E8          h
BEQ LFCA1       :\ FC98= F0 07       p.
JSR LFCA2       :\ FC9A= 20 A2 FC     "|
BEQ LFC97       :\ FC9D= F0 F8       px
CPX #&08        :\ FC9F= E0 08       `.
.LFCA1
RTS             :\ FCA1= 60          `
 
.LFCA2
STY &C5         :\ FCA2= 84 C5       .E
LDA IO8255_2       :\ FCA4= AD 02 70    -.p
TAY             :\ FCA7= A8          (
EOR &C5         :\ FCA8= 45 C5       EE
AND #&20        :\ FCAA= 29 20       ) 
RTS             :\ FCAC= 60          `

.LFCAD
LDX #&00        :\ FCAD= A2 00       ".
.LFCAF
LDA #&10        :\ FCAF= A9 10       ).
.LFCB1
BIT IO8255_2       :\ FCB1= 2C 02 70    ,.p
BEQ LFCB1       :\ FCB4= F0 FB       p{
.LFCB6
BIT IO8255_2       :\ FCB6= 2C 02 70    ,.p
BNE LFCB6       :\ FCB9= D0 FB       P{
DEX             :\ FCBB= CA          J
BPL LFCB1       :\ FCBC= 10 F3       .s
RTS             :\ FCBE= 60          `

.LFCBF
CMP #&06        :\ FCBF= C9 06       I.
BEQ LFCE0       :\ FCC1= F0 1D       p.
CMP #&15        :\ FCC3= C9 15       I.
BEQ LFCE6       :\ FCC5= F0 1F       p.
LDY &E0         :\ FCC7= A4 E0       $`
BMI LFCEE       :\ FCC9= 30 23       0#
CMP #&1B        :\ FCCB= C9 1B       I.
BEQ LFCE0       :\ FCCD= F0 11       p.
CMP #&07        :\ FCCF= C9 07       I.
BEQ LFCEF       :\ FCD1= F0 1C       p.
JSR LFD1D       :\ FCD3= 20 1D FD     .}
LDX #&0A        :\ FCD6= A2 0A       ".
JSR LFE9E       :\ FCD8= 20 9E FE     .~
BNE LFD02       :\ FCDB= D0 25       P%
JMP LFE90       :\ FCDD= 4C 90 FE    L.~
 
.LFCE0
CLC             :\ FCE0= 18          .
LDX #&00        :\ FCE1= A2 00       ".
STX IO8255_0       :\ FCE3= 8E 00 70    ..p
.LFCE6
LDX #&02        :\ FCE6= A2 02       ".
.LFCE8
PHP             :\ FCE8= 08          .
ASL &DE,X       :\ FCE9= 16 DE       .^
PLP             :\ FCEB= 28          (
ROR &DE,X       :\ FCEC= 76 DE       v^
.LFCEE
RTS             :\ FCEE= 60          `
 
.LFCEF
LDA #&05        :\ FCEF= A9 05       ).
TAY             :\ FCF1= A8          (
.LFCF2
STA IO8255_3       :\ FCF2= 8D 03 70    ..p
.LFCF5
DEX             :\ FCF5= CA          J
BNE LFCF5       :\ FCF6= D0 FD       P}
EOR #&01        :\ FCF8= 49 01       I.
INY             :\ FCFA= C8          H
BPL LFCF2       :\ FCFB= 10 F5       .u
RTS             :\ FCFD= 60          `


\ NMI HANDLER
\ =========== 
.LFCFE
PHA:JMP (&0200)     :\ Hand on to Atom NMIV

.LFD02
CMP #&20        :\ FD02= C9 20       I
BCC LFD1D       :\ FD04= 90 17       ..
ADC #&1F        :\ FD06= 69 1F       i.
BMI LFD0C       :\ FD08= 30 02       0.
EOR #&60        :\ FD0A= 49 60       I`
.LFD0C
JSR LFE44       :\ FD0C= 20 44 FE     D~
STA (&DE),Y     :\ FD0F= 91 DE       .^
.LFD11
INY             :\ FD11= C8          H
CPY #&20        :\ FD12= C0 20       @
BCC LFD1B       :\ FD14= 90 05       ..
JSR LFDC5       :\ FD16= 20 C5 FD     E}
.LFD19
LDY #&00        :\ FD19= A0 00        .
.LFD1B
STY &E0         :\ FD1B= 84 E0       .`
.LFD1D
PHA             :\ FD1D= 48          H
JSR LFE44       :\ FD1E= 20 44 FE     D~
LDA (&DE),Y     :\ FD21= B1 DE       1^
EOR &E1         :\ FD23= 45 E1       Ea
STA (&DE),Y     :\ FD25= 91 DE       .^
PLA             :\ FD27= 68          h
RTS             :\ FD28= 60          `

.LFD29
JSR LFE0E       :\ FD29= 20 0E FE     .~
LDA #&20        :\ FD2C= A9 20       )
JSR LFE44       :\ FD2E= 20 44 FE     D~
STA (&DE),Y     :\ FD31= 91 DE       .^
BPL LFD1B       :\ FD33= 10 E6       .f

.LFD35
JSR LFE0E       :\ FD35= 20 0E FE     .~
JMP LFD1B       :\ FD38= 4C 1B FD    L.}

.LFD3B
JSR LFDC5       :\ FD3B= 20 C5 FD     E}
.LFD3E
LDY &E0         :\ FD3E= A4 E0       $`
BPL LFD1B       :\ FD40= 10 D9       .Y

.LFD42
LDY #&80        :\ FD42= A0 80        .
STY &E1         :\ FD44= 84 E1       .a
LDY #&00        :\ FD46= A0 00        .
STY IO8255_0       :\ FD48= 8C 00 70    ..p
LDA #&20        :\ FD4B= A9 20       )
.LFD4D
STA SCREEN,Y     :\ FD4D= 99 00 40    ..@
STA SCREEN+256,Y     :\ FD50= 99 00 41    ..A
INY             :\ FD53= C8          H
BNE LFD4D       :\ FD54= D0 F7       Pw
.LFD56
LDA #>SCREEN        :\ FD56= A9 40       )@
LDY #&00        :\ FD58= A0 00        .
STA &DF         :\ FD5A= 85 DF       ._
STY &DE         :\ FD5C= 84 DE       .^
BEQ LFD1B       :\ FD5E= F0 BB       p;

.LFD60
JSR LFE13       :\ FD60= 20 13 FE     .~
JMP LFD1B       :\ FD63= 4C 1B FD    L.}

.LFD66
CLC             :\ FD66= 18          .
LDA #&10        :\ FD67= A9 10       ).
STA &E6         :\ FD69= 85 E6       .f
.LFD6B
LDX #&08        :\ FD6B= A2 08       ".
JSR LFCE8       :\ FD6D= 20 E8 FC     h|
JMP LFD1D       :\ FD70= 4C 1D FD    L.}

.LFD73
LDA &E7         :\ FD73= A5 E7       %g
EOR #&60        :\ FD75= 49 60       I`
STA &E7         :\ FD77= 85 E7       .g
BCS LFD84       :\ FD79= B0 09       0.
.LFD7B
AND #&05        :\ FD7B= 29 05       ).
ROL IO8255_1       :\ FD7D= 2E 01 70    ..p
ROL A           :\ FD80= 2A
JSR LFCBF       :\ FD81= 20 BF FC     ?|
.LFD84
JMP LFE73       :\ FD84= 4C 73 FE    Ls~

.LFD87
LDY &E0         :\ FD87= A4 E0       $`
JSR LFE44       :\ FD89= 20 44 FE     D~
LDA (&DE),Y     :\ FD8C= B1 DE       1^
EOR &E1         :\ FD8E= 45 E1       Ea
BMI LFD94       :\ FD90= 30 02       0.
EOR #&60        :\ FD92= 49 60       I`
.LFD94
SBC #&20        :\ FD94= E9 20       i
JMP LFDC2       :\ FD96= 4C C2 FD    LB}

.LFD99
LDA #&5F        :\ FD99= A9 5F       )
.LFD9B
EOR #&20        :\ FD9B= 49 20       I
BNE LFDC2       :\ FD9D= D0 23       P#
.LFD9F
EOR &E7         :\ FD9F= 45 E7       Eg
.LFDA1
BIT IO8255_1       :\ FDA1= 2C 01 70    ,.p
BMI LFDA8       :\ FDA4= 30 02       0.
EOR #&60        :\ FDA6= 49 60       I`
.LFDA8
JMP LFDB8       :\ FDA8= 4C B8 FD    L8}

.LFDAB
ADC #&39        :\ FDAB= 69 39       i9
BCC LFDA1       :\ FDAD= 90 F2       .r
.LFDAF
EOR #&10        :\ FDAF= 49 10       I.
.LFDB1
BIT IO8255_1       :\ FDB1= 2C 01 70    ,.p
BMI LFDB8       :\ FDB4= 30 02       0.
EOR #&10        :\ FDB6= 49 10       I.
.LFDB8
CLC             :\ FDB8= 18          .
ADC #&20        :\ FDB9= 69 20       i

.LFDBB
BIT IO8255_1       :\ FDBB= 2C 01 70    ,.p
BVS LFDC2       :\ FDBE= 70 02       p.
AND #&1F        :\ FDC0= 29 1F       ).
.LFDC2
JMP LFE39       :\ FDC2= 4C 39 FE    L9~
 
.LFDC5
LDA &DE         :\ FDC5= A5 DE       %^
LDY &DF         :\ FDC7= A4 DF       $_
CPY #(>SCREEN)+1:\ FDC9= C0 41       @A
BCC LFE05       :\ FDCB= 90 38       .8
CMP #&E0        :\ FDCD= C9 E0       I`
BCC LFE05       :\ FDCF= 90 34       .4
LDY &E6         :\ FDD1= A4 E6       $f
BMI LFDE1       :\ FDD3= 30 0C       0.
DEY             :\ FDD5= 88          .
BNE LFDDF       :\ FDD6= D0 07       P.
.LFDD8
JSR LFE4A       :\ FDD8= 20 4A FE     J~
BCS LFDD8       :\ FDDB= B0 FB       0{
LDY #&10        :\ FDDD= A0 10        .
.LFDDF
STY &E6         :\ FDDF= 84 E6       .f
.LFDE1
LDY #&20        :\ FDE1= A0 20         
JSR LFE3F       :\ FDE3= 20 3F FE     ?~
.LFDE6
LDA SCREEN,Y     :\ FDE6= B9 00 40    9.@
STA SCREEN-32,Y     :\ FDE9= 99 E0 3F    .`?
INY             :\ FDEC= C8          H
BNE LFDE6       :\ FDED= D0 F7       Pw
JSR LFE44       :\ FDEF= 20 44 FE     D~
.LFDF2
LDA SCREEN+256,Y     :\ FDF2= B9 00 41    9.A
STA SCREEN+224,Y     :\ FDF5= 99 E0 40    .`@
INY             :\ FDF8= C8          H
BNE LFDF2       :\ FDF9= D0 F7       Pw
LDY #&1F        :\ FDFB= A0 1F        .
LDA #&20        :\ FDFD= A9 20       )
.LFDFF
STA (&DE),Y     :\ FDFF= 91 DE       .^
DEY             :\ FE01= 88          .
BPL LFDFF       :\ FE02= 10 FB       .{
RTS             :\ FE04= 60          `

.LFE05
ADC #&20        :\ FE05= 69 20       i
STA &DE         :\ FE07= 85 DE       .^
BNE LFE0D       :\ FE09= D0 02       P.
INC &DF         :\ FE0B= E6 DF       f_
.LFE0D
RTS             :\ FE0D= 60          `

.LFE0E
DEY             :\ FE0E= 88          .
BPL LFE2A       :\ FE0F= 10 19       ..
LDY #&1F        :\ FE11= A0 1F        .
.LFE13
LDA &DE         :\ FE13= A5 DE       %^
BNE LFE22       :\ FE15= D0 0B       P.
LDX &DF         :\ FE17= A6 DF       &_
CPX #>SCREEN    :\ FE19= E0 40       `@
BNE LFE22       :\ FE1B= D0 05       P.
PLA             :\ FE1D= 68          h
PLA             :\ FE1E= 68          h
JMP LFD3E       :\ FE1F= 4C 3E FD    L>}
 
.LFE22
SBC #&20        :\ FE22= E9 20       i 
STA &DE         :\ FE24= 85 DE       .^
BCS LFE2A       :\ FE26= B0 02       0.
DEC &DF         :\ FE28= C6 DF       F_
.LFE2A
RTS             :\ FE2A= 60          `

\ Write a character to VDU
\ ------------------------
.LFE2B
JSR LFED4       :\ FE2B= 20 D4 FE     T~
PHP             :\ FE2E= 08          .
PHA             :\ FE2F= 48          H
CLD             :\ FE30= D8          X
STY &E5         :\ FE31= 84 E5       .e
STX &E4         :\ FE33= 86 E4       .d
JSR LFCBF       :\ FE35= 20 BF FC     ?|
PLA             :\ FE38= 68          h
.LFE39
LDX &E4         :\ FE39= A6 E4       &d
LDY &E5         :\ FE3B= A4 E5       $e
PLP             :\ FE3D= 28          (
RTS             :\ FE3E= 60          `

.LFE3F
BIT IO8255_2       :\ FE3F= 2C 02 70    ,.p
BPL LFE3F       :\ FE42= 10 FB       .{
.LFE44
BIT IO8255_2       :\ FE44= 2C 02 70    ,.p
BMI LFE44       :\ FE47= 30 FB       0{
RTS             :\ FE49= 60          `
 
.LFE4A
LDY #&3B        :\ FE4A= A0 3B        ;
CLC             :\ FE4C= 18          .
LDA #&20        :\ FE4D= A9 20       )
.LFE4F
LDX #&0A        :\ FE4F= A2 0A       ".
.LFE51
BIT IO8255_1       :\ FE51= 2C 01 70    ,.p
BEQ LFE5E       :\ FE54= F0 08       p.
INC IO8255_0       :\ FE56= EE 00 70    n.p
DEY             :\ FE59= 88          .
DEX             :\ FE5A= CA          J
BNE LFE51       :\ FE5B= D0 F4       Pt
LSR A           :\ FE5D= 4A          J
.LFE5E
PHP             :\ FE5E= 08          .
PHA             :\ FE5F= 48          H
LDA IO8255_0       :\ FE60= AD 00 70    -.p
AND #&F0        :\ FE63= 29 F0       )p
STA IO8255_0       :\ FE65= 8D 00 70    ..p
PLA             :\ FE68= 68          h
PLP             :\ FE69= 28          (
BNE LFE4F       :\ FE6A= D0 E3       Pc
RTS             :\ FE6C= 60          `


\ OSRDCH HANDLER
\ ==============
.LFE6D
PHP             :\ FE6D= 08          .
CLD             :\ FE6E= D8          X
STX &E4         :\ FE6F= 86 E4       .d
STY &E5         :\ FE71= 84 E5       .e
.LFE73
BIT IO8255_2       :\ FE73= 2C 02 70    ,.p
BVC LFE7D       :\ FE76= 50 05       P.
JSR LFE4A       :\ FE78= 20 4A FE     J~
BCC LFE73       :\ FE7B= 90 F6       .v
.LFE7D
JSR LFB5D       :\ FE7D= 20 5D FB     ]{
.LFE80
JSR LFE4A       :\ FE80= 20 4A FE     J~
BCS LFE80       :\ FE83= B0 FB       0{
JSR LFE4A       :\ FE85= 20 4A FE     J~
BCS LFE80       :\ FE88= B0 F6       0v
.LFE8A
TYA             :\ FE8A= 98          .
LDX #&17        :\ FE8B= A2 17       ".
JSR LFE9E       :\ FE8D= 20 9E FE     .~
.LFE90
LDA LFEBC,X     :\ FE90= BD BC FE    =<~
STA &E2         :\ FE93= 85 E2       .b
LDA #>LFD11        :\ FE95= A9 FD       )}
STA &E3         :\ FE97= 85 E3       .c
TYA             :\ FE99= 98          .
JMP (&00E2)     :\ FE9A= 6C E2 00    lb.

.LFE9D
DEX             :\ FE9D= CA          J
.LFE9E
CMP LFEA4,X     :\ FE9E= DD A4 FE    ]$~
BCC LFE9D       :\ FEA1= 90 FA       .z
RTS             :\ FEA3= 60          `

.LFEA4

EQUB &00
EQUB &08
EQUB &09
EQUB &0A
EQUB &0B
EQUB &0C
EQUB &0D
EQUB &0E
EQUB &0F
EQUB &1E
EQUB &7F
EQUB &00
EQUB &01
EQUB &05
EQUB &06
EQUB &08
EQUB &0E
EQUB &0F
EQUB &10
EQUB &11
EQUB &1C
EQUB &20
EQUB &21
EQUB &3B

\ LOW BYTE OF A JUMP TABLE INTO FD00 FOR OSRDCH (HIGH BYTE FD)

.LFEBC
EQUB <LFD1D
EQUB <LFD35
EQUB <LFD11
EQUB <LFD3B
EQUB <LFD60
EQUB <LFD42
EQUB <LFD19
EQUB <LFD66
EQUB <LFD6B
EQUB <LFD56
EQUB <LFD29
EQUB <LFDB8
EQUB <LFDAB
EQUB <LFD73
EQUB <LFD7B
EQUB <LFDBB
EQUB <LFD87
EQUB <LFD99
EQUB <LFDB8
EQUB <LFDB1
EQUB <LFDAF
EQUB <LFDA1
EQUB <LFD9F
EQUB <LFD9B

.LFED4
PHA             :\ FED4= 48          H
CMP #&02        :\ FED5= C9 02       I.
BEQ LFF00       :\ FED7= F0 27       p'
CMP #&03        :\ FED9= C9 03       I.
BEQ LFF11       :\ FEDB= F0 34       p4
CMP &FE         :\ FEDD= C5 FE       E~
BEQ LFF0F       :\ FEDF= F0 2E       p.
LDA IO6522_C       :\ FEE1= AD 0C 78    -.x
AND #&0E        :\ FEE4= 29 0E       ).
BEQ LFF0F       :\ FEE6= F0 27       p'
PLA             :\ FEE8= 68          h
.LFEE9
BIT IO6522_1       :\ FEE9= 2C 01 78    ,.x
BMI LFEE9       :\ FEEC= 30 FB       0{
STA IO6522_1       :\ FEEE= 8D 01 78    ..x
PHA             :\ FEF1= 48          H
LDA IO6522_C       :\ FEF2= AD 0C 78    -.x
AND #&F0        :\ FEF5= 29 F0       )p
ORA #&0C        :\ FEF7= 09 0C       ..
STA IO6522_C       :\ FEF9= 8D 0C 78    ..x
ORA #&02        :\ FEFC= 09 02       ..
BNE LFF0C       :\ FEFE= D0 0C       P.
.LFF00
LDA #&7F        :\ FF00= A9 7F       ).
STA IO6522_3       :\ FF02= 8D 03 78    ..x
LDA IO6522_C       :\ FF05= AD 0C 78    -.x
AND #&F0        :\ FF08= 29 F0       )p
ORA #&0E        :\ FF0A= 09 0E       ..
.LFF0C
STA IO6522_C       :\ FF0C= 8D 0C 78    ..x
.LFF0F
PLA             :\ FF0F= 68          h

\ DEFAULT OSGBPB, IRQ2 HANDLER
\ ============================
.LFF10
RTS             :\ FF10= 60          `

.LFF11
LDA IO6522_C       :\ FF11= AD 0C 78    -.x
AND #&F0        :\ FF14= 29 F0       )p
BCS LFF0C       :\ FF16= B0 F4       0t


\ RESET HANDLER
\ =============
.LFF18
LDX #&19
.LFF1A
LDA LFF88,X:STA &0204,X   :\ Set up default vectors
DEX:BPL LFF1A:TXS         :\ Clear stack
TXA:INX
STX &EA:STX &E1:STX &E7   :\ Clear some locations
LDA #&0A:STA &FE
LDA #&8A:STA IO8255_3        :\ Set up 8255
LDA #&07:STA IO8255_2
JSR LF7C0                 :\ Print inline text
EQUB 6:EQUB 12:EQUB 15    :\ Enable VDU, clear screen
EQUS "BBC BASIC"
EQUB 10:EQUB 10:EQUB 13
LDA #&0E:STA IO6522_4        :\ Set up 6522
LDA #&27:STA IO6522_5        :\
LDA #&40:STA IO6522_B        :\
LDA #&C0:STA IO6522_E        :\
LDA #&00:LDX #&04         :\
.LFF64
STA &0300,X:DEX:BPL LFF64 :\ Set TIME to zero
STA &0316:STA &0317
STA &FF                   :\ Clear Escape flag
LDA #<(BBCBASICCOPYRIGHT):STA &FD
LDA #>(BBCBASICCOPYRIGHT):STA &FE          :\ Point last error to BASIC copyright message
LDA MOSEXT                 :\ Is extension ROM present?
CMP #&AA:BNE LFF85        :\ No, skip past
JSR MOSEXT+1:CLI             :\ Call extension ROM
.LFF85
JMP BBCBASICENTRY                 :\ Enter BASIC at &8000

\ DEFAULT VECTORS
\ ===============
.LFF88
             :\ &200 - NMIV, initialised by DOS
             :\ &202 - BRKV, initialised by BASIC
EQUW BBCBASICENTRY   :\ &204 - IRQ1V
EQUW LFF10   :\ &206 - IRQ2V
EQUW LF775   :\ &208 - CLIV
EQUW LF0D2   :\ &20A - BYTEV
EQUW LF000   :\ &20C - WORDV
EQUW LF54F   :\ &20E - WRCHV
EQUW LFE6D   :\ &210 - RDCHV
EQUW LF71A   :\ &212 - FILEV
EQUW LF908   :\ &214 - ARGSV
EQUW LFBC1   :\ &216 - BGETV
EQUW LFC51   :\ &218 - BPUTV
EQUW LFF10   :\ &21A - GBPBV
EQUW LFC0B   :\ &21C - FINDV
\ FSCV

\ IRQ HANDLER
\ ===========
.LFFA2
STA &98:PLA:PHA          :\ Get pushed flags from stack
AND #&10:BNE LFFBA       :\ Jump if BRK occured
LDA IO6522_D:AND #&60       :\ Check 6522 Timer1/Timer2 interupt status
BEQ LFFB4:JMP LF1A7      :\ Jump to process 6522 interupt
.LFFB4
LDA &98:PHA:JMP (&0204)  :\ Unrecognised, pass on to IRQ1V

\ BRK occured, set up error pointer and pass on to BRKV
\ -----------------------------------------------------
.LFFBA
LDA &98:PLP
PLA:SEC:SBC #&01:STA &FD
PLA:SBC #&00:STA &FE          :\ &FD/E=>error

\ &FFC8
.OSBRK :JMP (&0202)  :\ Pass to BRKV
\ &FFCB
.OSIRQ2:JMP (&0206)  :\ Pass to IRQ2V

\ &FFCE
.OSFIND:JMP (&021C)
\ &FFD1
.OSGBPB:JMP (&021A)
\ &FFD4
.OSBPUT:JMP (&0218)
\ &FFD7
.OSBGET:JMP (&0216)
\ &FFDA
.OSARGS:JMP (&0214)
\ &FFDD
.OSFILE:JMP (&0212)

\ &FFE0
.OSRDCH:JMP (&0210)
\ &FFE3
.OSASCI:CMP #&0D:BNE OSWRCH
\ &FFE7
.OSNEWL:LDA #&0A:JSR OSWRCH
\ &FFEC
.OSWRCR:LDA #&0D
\ &FFEE
.OSWRCH:JMP (&020E)
\ &FFF1
.OSWORD:JMP (&020C)
\ &FFF4
.OSBYTE:JMP (&020A)
\ &FFF7
.OS_CLI:JMP (&0208)
.NMI   :EQUW LFCFE
.RESET :EQUW LFF18
.IRQ   :EQUW LFFA2

.BeebDisEndAddr

SAVE "ATMOS",AtmHeader,BeebDisEndAddr
