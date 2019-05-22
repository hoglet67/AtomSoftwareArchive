
   LOAD = $0140

   org LOAD - 22

 .start
      
   EQUS ""

   org LOAD - 6
   
   EQUW LOAD
   EQUW LOAD
   EQUW end - code

.code

   RTS
   RTS   
  
.end

SAVE "NOMON", start, end
   
