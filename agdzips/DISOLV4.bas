  2000 DIM LL20
  2001 FOR I=0 TO 19
  2002 LLI=-1
  2003 NEXT
  2010 FOR I=0 TO 1
  2020 P=#3C00
  2030[
  2040 :LL0
  2050 LDA @#00
  2060 STA #80
  2080 STA #81
  2090 LDY @#00
  2100 :LL1
  2110 LDA #81
  2120 PHA 
  2130 ROL A
  2140 ROL A
  2150 ROL A
  2160 ROL A
  2170 AND @#07
  2180 TAX
  2190 LDA #81
  2200 AND @#1F
  2210 ORA @#60
  2220 STA #81
  2230 LDA (#80),Y
  2240 AND LL13,X
  2250 STA #82  
  2260 LDA #81
  2270 EOR @#E0
  2280 STA #81
  2290 LDA (#80),Y
  2300 AND LL14, X
  2310 ORA #82
  2320 STA (#80),Y
  2330 PLA
  2340 STA #81
  2350 \ 16-bit PRBS
  2360 LDA #80
  2370 LSR A 
  2380 AND @#0E
  2390 ASL #80
  2400 ROL #81
  2410 ADC @#00
  2420 TAX
  2430 LDA LL12,X
  2440 ORA #80
  2450 STA #80  
  2460 \ END?
  2470 LDA #80
  2480 ORA #81
  2490 BNE LL1
  2500 RTS
  2510 :LL12
  2520]
  2530 P!0=#01000001
  2540 P!4=#00010100
  2550 P!8=#00010100
  2560 P!12=#01000001
  2570 P=P+16
  2580[
  2590 :LL13
  2600]
  2610 P!0=#08040201
  2620 P!4=#80402010
  2630 P=P+8
  2640[
  2650 :LL14
  2660]
  2670 P!0=#F7FBFDFE
  2680 P!4=#7FBFDFEF
  2690 NEXT
  2700 *SAVE DISOLV 3C00 4000
  2710 END
  