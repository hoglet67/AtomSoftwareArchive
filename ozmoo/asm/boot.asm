;; This is the first stage OZMOO game loader
;;
;; It starts the Atom Tube, then causes Co Pro to *RUN the loader

load   = $2800

STROUT = $F7D1
OSCLI  = $FFF7
OSRDCH = $FFE3
OSNEWL = $FFED
OSWRCH = $FFF4

TUBE_R0 = $BEE0

MACRO oscli_command command
   LDX #0
.loop
   LDA command, X
   STA $100, X
   INX
   CMP #&0D
   BNE loop
   JSR OSCLI
ENDMACRO

   org load - 22

.header

   EQUS "BOOT"
   org load - 6
   EQUW load
   EQUW load
   EQUW end - start

.start

   JSR STROUT
   EQUB 12
   EQUS "OZMOO GAME LOADER",10,13
   EQUS "=================",10,13,10,13
   NOP

   ;; Test for second processor

   LDX #2
.test_loop
   LDA #$81
   STA TUBE_R0
   NOP
   LDA TUBE_R0
   ROR A
   BCC no_tube
   LDA #$01
   STA TUBE_R0
   NOP
   LDA TUBE_R0
   ROR A
   BCS no_tube
   DEX
   BNE test_loop
   JMP tube_detected

.no_tube
   JSR STROUT
   EQUS "SECOND PROCESSOR NOT DETECTED",10,13
   NOP
   RTS

.tube_detected

   JSR STROUT
   EQUS "DISPLAY TYPE:",10,13
   EQUS " (A) 32*16 ATOM",10,13
   EQUS " (B) 40*24 VDU2440",10,13
   EQUS " (C) 80*40 VGA80",10,13
   EQUS "ENTER CHOICE: "
   NOP

.loop
   JSR OSRDCH

   CMP #$1B
   BEQ exit

   CMP #'A'
   BCC loop
   CMP #'C'+1
   BCS loop

   JSR OSWRCH

   CMP #'B'
   BEQ vdu2440

   CMP #'C'
   BEQ vga80

.run
   oscli_command command_run

.exit
   JMP OSNEWL

.vdu2440
   oscli_command command_vdu2440
   JMP run

.vga80
   oscli_command command_oswrch80
   JMP run

.command_vdu2440
   EQUS "/LIB/VDU2440", 13

.command_oswrch80
   EQUS "/LIB/OSWRCH80", 13

.command_run
   EQUS "/TUBE/TUBE 0 RUN LOADER", 13

.end

SAVE "BOOT", header, end
