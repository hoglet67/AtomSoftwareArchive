     6*NOMON
     7*LOAD DISOLV
    10C=#100;P=#2800
    20CLEAR4
    30DO
    40FOR N=0 TO 157
    45*CWD /AGD
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
   150LINK #3C00
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
  1023$P="BOXES/BOXSCR";R.
  1024$P="BRICK/BRSCR";R.
  1025$P="BSQUARE/BSSCR";R.
  1026$P="BTANK3D/BT3SCR";R.
  1027$P="BUBBLEF/BFSCR";R.
  1028$P="BUMBER/BUMSCR";R.
  1029$P="CAPRES1/CR1SCR";R.
  1030$P="CAPRES2/CR2SCR";R.
  1031$P="CAPRES3/CR3SCR";R.
  1032$P="CATCHAH/CHSCR";R.
  1033$P="CATTI1A/C1ASCR";R.
  1034$P="CATTI2/CA2SCR";R.
  1035$P="CHAOS/CHSCR";R.
  1036$P="CHOPPER/CDSCR";R.
  1037$P="CIRCUIT/CIRSCR";R.
  1038$P="CODEZER/CZSCR";R.
  1039$P="COUSIN3/CH3SCR";R.
  1040$P="CRONOPI/CROSCR";R.
  1041$P="DAVEY/DDSCR";R.
  1042$P="DBUBBLE/DBSCR";R.
  1043$P="DBUG/DBSCR";R.
  1044$P="DBUSTER/DBSCR";R.
  1045$P="DEADZON/DZSCR";R.
  1046$P="DFLESHB/DFBSCR";R.
  1047$P="DKJR/DKJSCR";R.
  1048$P="DKRELOA/DKRSCR";R.
  1049$P="DOOMPT1/DP1SCR";R.
  1050$P="DTRICKS/DTSCR";R.
  1051$P="ERYX/ERSCR";R.
  1052$P="ESCAPE/ESSCR";R.
  1053$P="EXPLORE/EXPSCR";R.
  1054$P="FGHOST/FGSCR";R.
  1055$P="FLIPHOR/FHSCR";R.
  1056$P="FOGBW/FOGSCR";R.
  1057$P="FOGCO/FOGSCR";R.
  1058$P="FUNGUS/FUNSCR";R.
  1059$P="GAUFO/GAUSCR";R.
  1060$P="GENERAC/GDSCR";R.
  1061$P="GIFTHUN/GHSCR";R.
  1062$P="GRUMPY/GSSCR";R.
  1063$P="HEDGEHO/HHSCR";R.
  1064$P="HEROES/HERSCR";R.
  1065$P="HIGGY2/HIGSCR";R.
  1066$P="HYPERKI/HYPSCR";R.
  1067$P="ICESLID/ISSCR";R.
  1068$P="IJONES/IJSCR";R.
  1069$P="IMPOSS/IMPSCR";R.
  1070$P="JANE1/J1SCR";R.
  1071$P="JANE2/J2SCR";R.
  1072$P="JANE3/J3SCR";R.
  1073$P="JUMPCOL/JCSCR";R.
  1074$P="KANGA/KANSCR";R.
  1075$P="KILLERB/KBSCR";R.
  1076$P="KNIGHT/KHSCR";R.
  1077$P="KNIGHTW/KWSCR";R.
  1078$P="KONG1/K1SCR";R.
  1079$P="KONG2/K2SCR";R.
  1080$P="KRAPPAR/KPSCR";R.
  1081$P="KYD1/K1SCR";R.
  1082$P="KYD2/K2SCR";R.
  1083$P="KYD3/K3SCR";R.
  1084$P="LADDER/LADSCR";R.
  1085$P="LDRAG2/LDSCR";R.
  1086$P="LLSPACE/LLSSCR";R.
  1087$P="LOSTSPE/LISSCR";R.
  1088$P="LUMOS/LUMSCR";R.
  1089$P="LUPOALB/LASCR";R.
  1090$P="MALIGNA/MGSCR";R.
  1091$P="METEORM/MMSCR";R.
  1092$P="MIKE/MGSCR";R.
  1093$P="MIREMAR/MMSCR";R.
  1094$P="MONTY1/MM1SCR";R.
  1095$P="MONTYXM/MMXSCR";R.
  1096$P="MORITZ/MOSCR";R.
  1097$P="MOUSER/MOUSCR";R.
  1098$P="MYSTER/M1SCR";R.
  1099$P="NADRAL/NADSCR";R.
  1100$P="NEMOKAY/NEMSCR";R.
  1101$P="NIGHTST/NSSCR";R.
  1102$P="NINJA/NINSCR";R.
  1103$P="NIXY2/NI2SCR";R.
  1104$P="NIXY/NIXSCR";R.
  1105$P="OCEANO/OCESCR";R.
  1106$P="OCTUKIT/OCTSCR";R.
  1107$P="OOZE/OOZSCR";R.
  1108$P="OPLABFA/OLFSCR";R.
  1109$P="PARACHU/PARSCR";R.
  1110$P="PCQUEST/PCQSCR";R.
  1111$P="PENGO/PENSCR";R.
  1112$P="PERCY/PPSCR";R.
  1113$P="PHARAOH/PHASCR";R.
  1114$P="PICKAXE/PAPSCR";R.
  1115$P="PINKPIL/PPSCR";R.
  1116$P="POPEYE/POPSCR";R.
  1117$P="PROSPEC/PROSCR";R.
  1118$P="PTM/PTMSCR";R.
  1119$P="PUMPKIN/PKPSCR";R.
  1120$P="QBOX/QBSCR";R.
  1121$P="QUAHAPP/QHSCR";R.
  1122$P="R2D2/R2SCR";R.
  1123$P="RESCUE/RESSCR";R.
  1124$P="ROBOPRO/RPSCR";R.
  1125$P="ROBOT/ROBSCR";R.
  1126$P="ROBOTSR/RRSCR";R.
  1127$P="ROVR/ROVSCR";R.
  1128$P="RUBICON/RUBSCR";R.
  1129$P="SANTOS/SANSCR";R.
  1130$P="SC0TB0T/SBSCR";R.
  1131$P="SETOKAZ/SKSCR";R.
  1132$P="SETOYOK/SYSCR";R.
  1133$P="SHIPOFD/SODSCR";R.
  1134$P="SINKING/SINSCR";R.
  1135$P="SOPHI21/S21SCR";R.
  1136$P="SOPHIA/SOPSCR";R.
  1137$P="SORCE2/SO2SCR";R.
  1138$P="SORCE/SO1SCR";R.
  1139$P="SPACEDI/SDSCR";R.
  1140$P="SPACEJU/SJSCR";R.
  1141$P="SPECCYP/PONSCR";R.
  1142$P="STEEL/STESCR";R.
  1143$P="SUPER48/SBSCR";R.
  1144$P="TEASYMP/TSSCR";R.
  1145$P="TERRAHA/TERSCR";R.
  1146$P="TERRAPI/TPSCR";R.
  1147$P="TISP/TISSCR";R.
  1148$P="TLBEAR/TLBSCR";R.
  1149$P="TLTED/TLTSCR";R.
  1150$P="TOOFY1/TO1SCR";R.
  1151$P="TOOFY2/TO2SCR";R.
  1152$P="VECTORN/VECSCR";R.
  1153$P="VINTIK/VINSCR";R.
  1154$P="ZBYLUT/ZBSCR";R.
  1155$P="ZOMBOX/ZOXSCR";R.
  1156$P="ZOMBO/ZOSCR";R.
  1157$P="ZUKINOX/ZUKSCR";R.
