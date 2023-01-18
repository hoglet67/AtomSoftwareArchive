;; This is the first stage OZMOO game loader
;;
;; It starts the Atom Tube, then causes Co Pro to *RUN the loader

load   = $2800
OSCLI  = $FFF7

   org load - 22

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

.header

   EQUS "BOOT40"
   org load - 6
   EQUW load
   EQUW load
   EQUW end - start

.start
   oscli_command command1
   oscli_command command2
   RTS

.command1
   EQUS "/LIB/VDU2440", 13

.command2
   EQUS "/TUBE/TUBE 0 RUN LOADER", 13

.end

SAVE "BOOT40", header, end
