     5GOS.z
     6*NOMON
    10C=#100;P=#2800;G=#BDE0
    20CLEAR4
    30DO
    40FOR N=0 TO 187
    50GOSUB (1000+N)
    60X=0;DO X=X+1;U.P?X=47;
    70$C="CWD "
    80$C+LEN(C)=$P
    90C?(X+4)=13
   100LINK #FFF7;
   110$C="LOAD "
   120$C+LEN(C)=$P+X+1
   130$C+LEN(C)=" 6000"
   140LINK #FFF7;
   150*CWD ..
   155LINK LL0
   160FOR I=1TO120;WAIT;NEXT
   170NEXT
   180UNTIL 0
  1000$P="ADAGGER/DAGSCR";R.
  1001$P="AEON1/A1SCR";R.
  1002$P="AEON2/A2SCR";R.
  1003$P="AEON3/A3SCR";R.
  1004$P="AEON4/A4SCR";R.
  1005$P="ALBERTW/AWSCR";R.
  1006$P="ALLHALL/AHSCR";R.
  1007$P="ANGRYBI/ABSCR";R.
  1008$P="ANTIQUI/ANTSCR";R.
  1009$P="ASTRONA/ASTSCR";R.
  1010$P="ASTROSM/ASSCR";R.
  1011$P="BAFFO/BAFSCR";R.
  1012$P="BALDY/BALSCR";R.
  1013$P="BEANBRO/BBSCR";R.
  1014$P="BEINGLE/BLSCR";R.
  1015$P="BIGJAVI/BJSCR";R.
  1016$P="BILQUES/BILSCR";R.
  1017$P="BINARY/BINSCR";R.
  1018$P="BMALBA/BMSCR";R.
  1019$P="BOB1/B1SCR";R.
  1020$P="BOB2/B2SCR";R.
  1021$P="BOB3/B3SCR";R.
  1022$P="BOB4/B4SCR";R.
  1023$P="BOBBLOB/BOBSCR";R.
  1024$P="BOTFLOA/BOTSCR";R.
  1025$P="BOXES/BOXSCR";R.
  1026$P="BRICK/BRSCR";R.
  1027$P="BSQUARE/BSSCR";R.
  1028$P="BTANK3D/BT3SCR";R.
  1029$P="BUBBLEF/BFSCR";R.
  1030$P="BUMBER/BUMSCR";R.
  1031$P="CAPRES1/CR1SCR";R.
  1032$P="CAPRES2/CR2SCR";R.
  1033$P="CAPRES3/CR3SCR";R.
  1034$P="CATCHAH/CHSCR";R.
  1035$P="CATTI1A/C1ASCR";R.
  1036$P="CATTI1B/C1BSCR";R.
  1037$P="CATTI1C/C1CSCR";R.
  1038$P="CATTI2/CA2SCR";R.
  1039$P="CHAOS/CHSCR";R.
  1040$P="CHERRY6/C68SCR";R.
  1041$P="CHOPPER/CDSCR";R.
  1042$P="CIRCUIT/CIRSCR";R.
  1043$P="CODEZER/CZSCR";R.
  1044$P="COUSIN3/CH3SCR";R.
  1045$P="COUSIN5/CH5SCR";R.
  1046$P="CRONOPI/CROSCR";R.
  1047$P="DAVEY/DDSCR";R.
  1048$P="DBUBBLE/DBSCR";R.
  1049$P="DBUG/DBSCR";R.
  1050$P="DBUSTER/DBSCR";R.
  1051$P="DEADZON/DZSCR";R.
  1052$P="DFLESHB/DFBSCR";R.
  1053$P="DKJR/DKJSCR";R.
  1054$P="DKRELOA/DKRSCR";R.
  1055$P="DOOMPT1/DP1SCR";R.
  1056$P="DOOMPT2/DP2SCR";R.
  1057$P="DOOMPT3/DP3SCR";R.
  1058$P="DRAGNWA/DRASCR";R.
  1059$P="DTRICKS/DTSCR";R.
  1060$P="ERYX/ERSCR";R.
  1061$P="ESCAPE/ESSCR";R.
  1062$P="EXPLORE/EXPSCR";R.
  1063$P="FGHOST/FGSCR";R.
  1064$P="FLIPHOR/FHSCR";R.
  1065$P="FOGBW/FOGSCR";R.
  1066$P="FOGCO/FOGSCR";R.
  1067$P="FUNGUS2/F2SCR";R.
  1068$P="FUNGUS3/F3SCR";R.
  1069$P="FUNGUS4/F4SCR";R.
  1070$P="FUNGUS/FUNSCR";R.
  1071$P="GAUFO/GAUSCR";R.
  1072$P="GENERAC/GDSCR";R.
  1073$P="GIFTHUN/GHSCR";R.
  1074$P="GRUMPY/GSSCR";R.
  1075$P="HEDGEHO/HHSCR";R.
  1076$P="HEROES/HERSCR";R.
  1077$P="HIGGY2/HIGSCR";R.
  1078$P="HYPERKI/HYPSCR";R.
  1079$P="ICESLID/ISSCR";R.
  1080$P="IJONES/IJSCR";R.
  1081$P="IMPOSS/IMPSCR";R.
  1082$P="JANE1/J1SCR";R.
  1083$P="JANE2/J2SCR";R.
  1084$P="JANE3/J3SCR";R.
  1085$P="JOEYJUM/JOESCR";R.
  1086$P="JUMPCOL/JCSCR";R.
  1087$P="KANGA/KANSCR";R.
  1088$P="KILLERB/KBSCR";R.
  1089$P="KNIGHT/KHSCR";R.
  1090$P="KNIGHTW/KWSCR";R.
  1091$P="KONG1/K1SCR";R.
  1092$P="KONG2/K2SCR";R.
  1093$P="KRAPPAR/KPSCR";R.
  1094$P="KYD1/K1SCR";R.
  1095$P="KYD2/K2SCR";R.
  1096$P="KYD3/K3SCR";R.
  1097$P="LADDER/LADSCR";R.
  1098$P="LDRAG2/LDSCR";R.
  1099$P="LINSPAC/LINSCR";R.
  1100$P="LLSPACE/LLSSCR";R.
  1101$P="LOSTSPE/LISSCR";R.
  1102$P="LSTHUMA/LSTSCR";R.
  1103$P="LUMOS/LUMSCR";R.
  1104$P="LUPOALB/LASCR";R.
  1105$P="MALIGNA/MGSCR";R.
  1106$P="METEORM/MMSCR";R.
  1107$P="MGSI/MGSSCR";R.
  1108$P="MIKE/MGSCR";R.
  1109$P="MIREMAR/MMSCR";R.
  1110$P="MISSMAR/MARSCR";R.
  1111$P="MONTY1/MM1SCR";R.
  1112$P="MONTYXM/MMXSCR";R.
  1113$P="MORITZ/MOSCR";R.
  1114$P="MOUSER/MOUSCR";R.
  1115$P="MYSTER2/M2SCR";R.
  1116$P="MYSTER/M1SCR";R.
  1117$P="NADRAL/NADSCR";R.
  1118$P="NEMOKAY/NEMSCR";R.
  1119$P="NIGHTST/NSSCR";R.
  1120$P="NINJA/NINSCR";R.
  1121$P="NIXY2/NI2SCR";R.
  1122$P="NIXY/NIXSCR";R.
  1123$P="OCEANO/OCESCR";R.
  1124$P="OCTUKIT/OCTSCR";R.
  1125$P="OOZE/OOZSCR";R.
  1126$P="OPLABFA/OLFSCR";R.
  1127$P="PARACHU/PARSCR";R.
  1128$P="PCQUEST/PCQSCR";R.
  1129$P="PENGO/PENSCR";R.
  1130$P="PERCY/PPSCR";R.
  1131$P="PHARAOH/PHASCR";R.
  1132$P="PICKAXE/PAPSCR";R.
  1133$P="PINKPIL/PPSCR";R.
  1134$P="PLTFPDG/PLTSCR";R.
  1135$P="POPEYE/POPSCR";R.
  1136$P="PROSPEC/PROSCR";R.
  1137$P="PTM/PTMSCR";R.
  1138$P="PUMPKIN/PKPSCR";R.
  1139$P="QBECKIN/QBKSCR";R.
  1140$P="QBOX/QBSCR";R.
  1141$P="QUAHAPP/QHSCR";R.
  1142$P="R2D2/R2SCR";R.
  1143$P="RESCUE/RESSCR";R.
  1144$P="RNDMATO/RNDSCR";R.
  1145$P="ROBOPRO/RPSCR";R.
  1146$P="ROBOT/ROBSCR";R.
  1147$P="ROBOTSR/RRSCR";R.
  1148$P="ROCKROD/RRSCR";R.
  1149$P="ROVR/ROVSCR";R.
  1150$P="RUBICON/RUBSCR";R.
  1151$P="RUDXMAS/RUDSCR";R.
  1152$P="SANTOS/SANSCR";R.
  1153$P="SC0TB0T/SBSCR";R.
  1154$P="SETOKAZ/SKSCR";R.
  1155$P="SETOYOK/SYSCR";R.
  1156$P="SHIPOFD/SODSCR";R.
  1157$P="SINKING/SINSCR";R.
  1158$P="SOPHI21/S21SCR";R.
  1159$P="SOPHI22/S22SCR";R.
  1160$P="SOPHI23/S23SCR";R.
  1161$P="SOPHIA/SOPSCR";R.
  1162$P="SORCE2/SO2SCR";R.
  1163$P="SORCE/SO1SCR";R.
  1164$P="SPACEDI/SDSCR";R.
  1165$P="SPACEJU/SJSCR";R.
  1166$P="SPECCYP/PONSCR";R.
  1167$P="STEEL/STESCR";R.
  1168$P="STWTP/STWSCR";R.
  1169$P="SUPER48/SBSCR";R.
  1170$P="TEASYMP/TSSCR";R.
  1171$P="TERRAHA/TERSCR";R.
  1172$P="TERRAPI/TPSCR";R.
  1173$P="TIKITMP/TTSCR";R.
  1174$P="TIMTRAV/TIMSCR";R.
  1175$P="TISP/TISSCR";R.
  1176$P="TLBEAR/TLBSCR";R.
  1177$P="TLTED/TLTSCR";R.
  1178$P="TOOFY1/TO1SCR";R.
  1179$P="TOOFY2/TO2SCR";R.
  1180$P="TRIKTRO/TRISCR";R.
  1181$P="VECTORN/VECSCR";R.
  1182$P="VINTIK/VINSCR";R.
  1183$P="ZBYLUT/ZBSCR";R.
  1184$P="ZOESADV/ZOESCR";R.
  1185$P="ZOMBOX/ZOXSCR";R.
  1186$P="ZOMBO/ZOSCR";R.
  1187$P="ZUKINOX/ZUKSCR";R.

  2000zDIM LL20
  2001 FOR I=0 TO 19
  2002 LLI=-1
  2003 NEXT
  2010 FOR I=0 TO 1
  2020 P=#2820
  2030[
  2040 :LL0
  2050 LDA @#01
  2060 STA #80
  2070 LDA @#00
  2080 STA #81
  2090 LDY @#00
  2100 :LL1
  2105 LDA #81
  2106 AND @#1F
  2107 ORA @#60
  2108 STA #81
  2110 LDA (#80),Y
  2120 TAX
  2130 LDA #81
  2140 EOR @#E0
  2150 STA #81
  2155 TXA
  2160 STA (#80),Y
  2200 \ 13-bit PRBS
  2210 ASL #80
  2220 ROL #81
  2230 LDA #81
  2240 AND @#39
  2250 CLC
  2260 ADC @#03
  2270 LSR A
  2280 LSR A
  2290 TAX
  2291 LDA LL12,X
  2292 ORA #80
  2293 STA #80
  2300 \ END?
  2310 LDA #80
  2320 CMP @#01
  2330 BNE LL1
  2340 LDA #81
  2350 AND @#1F
  2360 CMP @#00
  2370 BNE LL1
  2420 RTS
  2500 :LL12
  2510]
  2520 P!0=#01000001
  2530 P!4=#00010100
  2540 P!8=#00010100
  2550 P!12=#01000001
  2560 NEXT
  2570 RETURN
  