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
  2130 ROR A
  2140 ROR A
  2150 ROR A
  2170 AND @#07
  2180 TAX

  2200 LDA #81
  2201 AND @#07
  2202 ORA @#60
  2203 STA #81
  2204 LDA (#80),Y
  2205 AND LL13,X
  2206 STA #82  
  2207 LDA #81
  2208 EOR @#E0
  2209 STA #81
  2210 LDA (#80),Y
  2211 AND LL14, X
  2212 ORA #82
  2213 STA (#80),Y

  2220 LDA #81
  2221 EOR @#E8
  2223 STA #81
  2224 LDA (#80),Y
  2225 AND LL13,X
  2226 STA #82  
  2227 LDA #81
  2228 EOR @#E0
  2229 STA #81
  2230 LDA (#80),Y
  2231 AND LL14, X
  2232 ORA #82
  2233 STA (#80),Y

  2240 LDA #81
  2242 EOR @#F8
  2243 STA #81
  2244 LDA (#80),Y
  2245 AND LL13,X
  2246 STA #82  
  2247 LDA #81
  2248 EOR @#E0
  2249 STA #81
  2250 LDA (#80),Y
  2251 AND LL14, X
  2252 ORA #82
  2253 STA (#80),Y

  2330 PLA
  2340 STA #81
  2350 \ 14-bit PRBS (201C)

  2360 ASL #80   \ 5
  2370 LDA #81   \ 3
  2380 ROL A     \ 2
  2390 STA #81   \ 3
  2400 ROL A     \ 2
  2401 ROL A     \ 2
  2402 LDA #80   \ 3
  2403 AND @#38  \ 2
  2404 ADC @#03  \ 2
  2410 LSR A     \ 2
  2415 LSR A     \ 2
  2420 TAX       \ 2
  2425 LDA LL12,X \ 4
  2430 ORA #80   \ 3
  2440 STA #80   \ 3 = 40

  2450 \ END?
  2460 BNE LL1
  2470 LDA #81
  2480 AND @#3F
  2490 BEQ LL2
  2491 JMP LL1
  2492 :LL2
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
  