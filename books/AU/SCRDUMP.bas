10 ?35=#00;?36=#28
20 REM SCREEN DUMP FOR KAGA
30 REM OR EPSON COMPATIBLE
40 REM PRINTERS
50 REM BY JOHN FERGUSON. 8/86
60 DIMPP7
70 F.Z=0TO7;PPZ=-1;N.
80 S=#3B00
90 J=#FF10
100 W=S-1
110 L=S-2
120 C=S-3
130 T=#90
140 D=#92
150 P.$21
160 F.Z=0TO1;P=S
170[
180:PP0
190 LDA@32
200 STAW SCREEN WIDTH IN BYTES
210 LDA@64
220 STAL 64 LINES OF 6 BITS
230 LDA@#00
240 STAT
250 LDA@#80
260 STAT+1 STORE SCREEN START ADDRESS270 LDA@2
270 LDA@2
280 JSR#FEFB SWITCH ON PRINTER
290 LDA@#1B ESCAPE CODE
300 JSRJ
310 LDA@64 RESET PRINTER
320 JSRJ
330 LDA@#0D CARRIAGE RETURN
340 JSRJ
350 LDA@#1B ESCAPE CODE
360 JSRJ
370 LDA@#41 SET DOT LINE SPACING
380 JSRJ
390 LDA@6 NO. OF DOTS
400 JSRJ
410:PP1
420 LDY@8 COUNT 8 SPACES
430:PP2
440 LDA@32 SEND 8 SPACES FOR MARGIN
450 JSRJ
460 DEY
470 BNEPP2
480 LDA@#1B ESCAPE CODE
490 JSRJ
500 LDA@#4C DOUBLE DENSITY GRAPHICS
510 JSRJ
520 LDA@0 NO OF DOTS-LOW BYTE
530 JSRJ
540 LDA@3 NO OF DOTS/256-HIGH BYTE
550 JSRJ
560 BEQPP4
570 BNEPP4
580:PP3
590 PLA
600 STAT+1
610 PLA
620 STAT
630:PP4
640 LDA@3
650 STAC
660 LDAT
670 PHA
680 LDAT+1
690 PHA
700:PP5
710 LDA(T),Y
720 LDX@0
730 STA#21C
740 STA#21D
750:PP6
760 LDA#21C
770 ROLA
780 STA#21C
790 ROLD,X
800 LDA#21D
810 ROLA
820 STA#21D
830 ROLD,X
840 INX
850 CPX@8
860 BNEPP6
870 CLC
880 LDAT
890 ADCW
900 STAT
910 LDAT+1
920 ADC@0
930 STAT+1
940 DECC
950 BNEPP5
960 LDX@0
970:PP7
980 LDAD,X
990 ORA@#40
1000 EOR@#40
1010 STA#21E
1020 JSR#FF10
1030 JSR#FF10
1040 JSR#FF10
1050 INX
1060 CPX@8
1070 BNEPP7
1080 INY
1090 CPYW
1100 BNEPP3
1110 PLA
1120 PLA
1130 LDA@#0D
1140 JSR#FF10
1150 DECL
1160 BEQP+4;JMPPP1
1170 LDA@#1B ESCAPE CODE
1180 JSRJ
1190 LDA@64 RESET PRINTER
1200 JSRJ
1210 LDA@#0D
1220 JSRJ
1230 JSRJ
1240 LDA@3 TURN OFF PRINTER
1250 JSR#FEFB
1260 RTS
1270]
1280 N.
1290 P.$6
1295 PRINT "PRESS RETURN TO TEST"'
1296 LINK #FFE3
1300 CLEAR 4
1310 MOVE 0,0
1320 DRAW 255,0
1330 DRAW 255,191
1340 DRAW 0,191
1350 DRAW 0,0
1360 DRAW 255,191
1370 MOVE 255,0
1380 DRAW 0,191
1390 LINK S
1400 REM LINK TO LOCATION OF M/C TO START
1410 E.