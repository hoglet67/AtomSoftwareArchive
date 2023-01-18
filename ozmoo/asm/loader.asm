;; This is the second stage OZMOO game loader
;;
;; It runs on the Co Pro and
;; - sets the default screen mode and default colours
;; - mounts the game data disk in drive 0
;; - runs the OZMOO2P program

load   = $0900
OSCLI  = $FFF7

   org load - 22           ; 22 byte AtoMMC hwader

.header

   EQUS "LOADER"
   org load - 6
   EQUW load
   EQUW load
   EQUW end - start

.start
   LDA #$00
   STA $ED
   LDA #$06                ; Mode 6
   STA $416
   LDA #$00                ; Background colour 0
   STA $417
   LDA #$07                ; Foreground colour 7
   STA $418
   LDX #<din_command       ; Execute the *DIN command
   LDY #>din_command
   JSR OSCLI
   LDX #<run_command       ; Execute the *RUN OZMOO2P command
   LDY #>run_command
   JMP OSCLI

.din_command
   EQUS "DIN 0 GAME.DSK", 13

.run_command
   EQUS "RUN OZMOO2P", 13

.end

SAVE "LOADER", header, end
