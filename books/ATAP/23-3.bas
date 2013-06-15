   10 REM Turn off Assembly Listing
   20 DIM P(-1)
   30 PRINT $21; REM TURN OFF
   40[LDA @#58; JSR #FFF4; RTS;]
   50 PRINT $6 ; REM TURN ON
   60 LINK TOP
   70 END


