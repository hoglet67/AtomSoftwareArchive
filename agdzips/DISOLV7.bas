    10 DIM LL10
    20 FOR I=0 TO 9
    30 LLI=-1
    40 NEXT
    60 R=#88
    70 S=#70
    80 T=#78
    90 FOR I=0 TO 1
   100 P=#4000
   110[
   120 :LL0
   130 LDA @#00
   140 STA #80
   150 STA #81
   160 \ COPY TABLES TO ZP
   170 LDY @#0F
   180 :LL1
   190 LDA LL8,Y
   200 STA R,Y
   210 LDA LL9,Y
   220 STA S,Y
   230 DEY
   240 BPL LL1
   250 :LL2
   260 LDA #81
   270 PHA
   290 TAX
   300 LDY #80
   310 :LL3
   320]
   330 FOR Z=#00 TO #17
   340[
   350 TYA
   360 EOR @(Z*11)
   370 TAY
   380 LDA #6000+Z*#100,Y
   390 AND S,X
   400 STA #82
   410 LDA #8000+Z*#100,Y
   420 AND T,X
   430 ORA #82
   440 STA #8000+Z*#100,Y
   450]
   460 NEXT
   470[
   480 CPY @#00
   490 BNE LL4
   500 LDY @#FF
   510 JMP LL3
   515:LL4
   520 PLA
   540 STA #81
   550 \ 11-bit PRBS (204)
   555 LDA #80
   560 AND @#04
   565 ORA #81
   570 AND @#06
   575 TAX
   580 LDA #80
   585 ASL A
   590 ORA R,X
   600 STA #80
   610 LDA #81
   620 ROL A
   630 AND @#03
   640 STA #81
   650 \ END?
   680 ORA #80
   690 BEQ LL5
   700 JMP LL2
   710 :LL5
   720 RTS
   730 :LL8
   740]
   745 REM COPIED TO R
   750 P!0=#01000001
   760 P!4=#00010100
   770 P!8=#00010100
   780 P!12=#01000001
   790 P=P+16
   800[
   810 :LL9
   820]
   825 REM COPIED TO S/T
   830 P!0=#81500A24
   840 P!4=0
   850 P!8=P!0:#FFFFFFFF
   860 P!12=0
   870 P=P+16
   880 NEXT
   890 *SAVE DISOLV 4000 4400
   900 END
