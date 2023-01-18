;; This is the first stage OZMOO game loader
;;
;; It starts the Atom Tube, then causes Co Pro to *RUN the loader

load   = $2800
OSCLI  = $FFF7

   org load - 22

.header

   EQUS "BOOT"
   org load - 6
   EQUW load
   EQUW load
   EQUW end - start

.start

   LDX #0
.loop
   LDA command, X
   STA $100, X
   INX
   CMP #&0D
   BNE loop

   JMP $FFF7

.command
   EQUS "/TUBE/TUBE 0 RUN LOADER", 13

.end

SAVE "BOOT", header, end
