
   
.start
   
   ;; Skip leading spaces
   LDY #$00
   JSR $F876

   ;; Skip the first token (i.e. RUN)
   DEY
.loop1   
   INY
   LDA $0100,Y
   CMP #$0D
   BEQ exit
   CMP #$20
   BNE loop1

   ;; Skip trailing spaces
   JSR $F876

   ;; Copy remainer of the line to $0100
   LDX #$00
.loop2
   LDA $0100,Y
   STA $0100,X
   INY
   INX
   CMP #$0D
   BNE loop2

   ;; Call OSCLI
   JMP $FFF7

.exit
   RTS
   
  
.end

SAVE "RUN", start, end
   
