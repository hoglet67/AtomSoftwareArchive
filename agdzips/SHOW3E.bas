     7*LOAD DISOLV
    10C=#100;P=#2800
    20CLEAR4
    30DO
    40FOR N=0 TO 198
    45*DIR
    50GOSUB (1000+N)
    60X=0;DO X=X+1;U.P?X=47;
    70$C="DIR "
    80$C+LEN(C)=$P
    90C?(X+4)=13
   100LINK #FFF7
   110$C="LOAD "
   120$C+LEN(C)=$P+X+1
   130$C+LEN(C)=" 6000"
   140LINK #FFF7
   150LINK #3C00
   160FOR I=1TO120;WAIT;NEXT
   170NEXT
   180UNTIL 0
  1000$P="3.9.7/DAGSCR";R.
  1001$P="3.9.8/A1SCR";R.
  1002$P="3.9.9/A2SCR";R.
  1003$P="3.9.A/A3SCR";R.
  1004$P="3.9.B/A4SCR";R.
  1005$P="4.8.2/AKSCR";R.
  1006$P="4.0.4/AWSCR";R.
  1007$P="4.6.6/AL2SCR";R.
  1008$P="4.0.5/AHSCR";R.
  1009$P="4.6.7/ABSCR";R.
  1010$P="4.0.6/ABSCR";R.
  1011$P="4.0.7/ANTSCR";R.
  1012$P="4.6.8/APSCR";R.
  1013$P="3.F.B/ASTSCR";R.
  1014$P="3.F.F/ASSCR";R.
  1015$P="3.9.C/BAFSCR";R.
  1016$P="3.9.D/BALSCR";R.
  1017$P="3.9.E/BBSCR";R.
  1018$P="4.3.9/BLSCR";R.
  1019$P="3.9.F/BJSCR";R.
  1020$P="4.0.8/BILSCR";R.
  1021$P="4.0.9/BINSCR";R.
  1022$P="4.6.9/BGSCR";R.
  1023$P="4.6.A/BLDSCR";R.
  1024$P="4.6.B/BLNSCR";R.
  1025$P="3.A.0/BMSCR";R.
  1026$P="3.A.2/B1SCR";R.
  1027$P="3.A.3/B2SCR";R.
  1028$P="3.A.4/B3SCR";R.
  1029$P="3.A.5/B4SCR";R.
  1030$P="3.F.E/BOXSCR";R.
  1031$P="3.A.6/BRSCR";R.
  1032$P="3.A.7/BSSCR";R.
  1033$P="4.0.C/BT3SCR";R.
  1034$P="4.0.0/BFSCR";R.
  1035$P="4.6.C/BSSCR";R.
  1036$P="3.A.8/BUMSCR";R.
  1037$P="3.A.A/CR1SCR";R.
  1038$P="3.A.B/CR2SCR";R.
  1039$P="3.A.C/CR3SCR";R.
  1040$P="4.0.D/CHSCR";R.
  1041$P="4.0.E/C1ASCR";R.
  1042$P="4.1.1/CA2SCR";R.
  1043$P="3.A.D/CHSCR";R.
  1044$P="4.6.D/CHSCR";R.
  1045$P="4.1.3/CDSCR";R.
  1046$P="3.A.E/CIRSCR";R.
  1047$P="4.6.E/112SCR";R.
  1048$P="3.F.D/CZSCR";R.
  1049$P="4.1.5/CH3SCR";R.
  1050$P="3.F.C/CROSCR";R.
  1051$P="3.B.0/DDSCR";R.
  1052$P="3.B.1/DBSCR";R.
  1053$P="3.B.2/DBSCR";R.
  1054$P="3.B.3/DBSCR";R.
  1055$P="4.6.F/DCSCR";R.
  1056$P="4.3.A/DZSCR";R.
  1057$P="4.1.7/DFBSCR";R.
  1058$P="4.7.0/DDSCR";R.
  1059$P="4.0.1/DKJSCR";R.
  1060$P="4.1.8/DKRSCR";R.
  1061$P="4.7.2/DKRSCR";R.
  1062$P="4.3.B/DP1SCR";R.
  1063$P="3.B.5/DTSCR";R.
  1064$P="3.B.6/ERSCR";R.
  1065$P="3.B.7/ESSCR";R.
  1066$P="3.B.8/EXPSCR";R.
  1067$P="3.B.9/FGSCR";R.
  1068$P="4.0.2/FHSCR";R.
  1069$P="4.7.3/FLSCR";R.
  1070$P="3.B.A/FOGSCR";R.
  1071$P="3.B.B/FOGSCR";R.
  1072$P="4.7.4/F21SCR";R.
  1073$P="4.7.5/F22SCR";R.
  1074$P="4.7.6/F23SCR";R.
  1075$P="4.7.7/F24SCR";R.
  1076$P="4.7.8/F25SCR";R.
  1077$P="3.B.C/FUNSCR";R.
  1078$P="4.1.B/GAUSCR";R.
  1079$P="4.4.1/GDSCR";R.
  1080$P="4.7.9/GXSCR";R.
  1081$P="3.B.D/GHSCR";R.
  1082$P="4.7.A/GNSCR";R.
  1083$P="3.B.E/GSSCR";R.
  1084$P="3.B.F/HHSCR";R.
  1085$P="3.C.0/HERSCR";R.
  1086$P="3.C.1/HIGSCR";R.
  1087$P="3.C.3/HYPSCR";R.
  1088$P="3.C.4/ISSCR";R.
  1089$P="4.1.C/IJSCR";R.
  1090$P="3.C.5/IMPSCR";R.
  1091$P="3.C.6/J1SCR";R.
  1092$P="3.C.7/J2SCR";R.
  1093$P="3.C.8/J3SCR";R.
  1094$P="3.C.9/JCSCR";R.
  1095$P="3.C.A/KANSCR";R.
  1096$P="3.C.B/KBSCR";R.
  1097$P="3.C.C/KHSCR";R.
  1098$P="4.4.3/KWSCR";R.
  1099$P="4.1.E/K1SCR";R.
  1100$P="4.1.F/K2SCR";R.
  1101$P="4.2.0/KPSCR";R.
  1102$P="4.2.1/K1SCR";R.
  1103$P="4.2.2/K2SCR";R.
  1104$P="4.2.3/K3SCR";R.
  1105$P="3.C.D/LADSCR";R.
  1106$P="4.7.B/L1SCR";R.
  1107$P="4.7.C/L2SCR";R.
  1108$P="4.7.D/L3SCR";R.
  1109$P="4.7.E/L4SCR";R.
  1110$P="3.C.E/LDSCR";R.
  1111$P="4.2.5/LLSSCR";R.
  1112$P="4.7.F/LCSCR";R.
  1113$P="4.2.6/LISSCR";R.
  1114$P="4.8.0/LISCR";R.
  1115$P="3.C.F/LUMSCR";R.
  1116$P="4.2.8/LASCR";R.
  1117$P="4.8.1/MASCR";R.
  1118$P="3.D.0/MGSCR";R.
  1119$P="4.4.4/MMSCR";R.
  1120$P="3.D.1/MGSCR";R.
  1121$P="3.D.2/MMSCR";R.
  1122$P="3.D.3/MM1SCR";R.
  1123$P="4.8.3/MTLSCR";R.
  1124$P="3.D.4/MMXSCR";R.
  1125$P="4.4.7/MOSCR";R.
  1126$P="4.4.8/MOUSCR";R.
  1127$P="4.8.4/MHASCR";R.
  1128$P="4.4.9/M1SCR";R.
  1129$P="3.D.5/NADSCR";R.
  1130$P="3.D.6/NEMSCR";R.
  1131$P="3.D.7/NSSCR";R.
  1132$P="3.D.8/NINSCR";R.
  1133$P="4.4.C/NI2SCR";R.
  1134$P="4.4.B/NIXSCR";R.
  1135$P="3.D.9/OCESCR";R.
  1136$P="3.D.A/OCTSCR";R.
  1137$P="3.D.B/OOZSCR";R.
  1138$P="4.4.E/OLFSCR";R.
  1139$P="3.D.C/PARSCR";R.
  1140$P="3.D.D/PCQSCR";R.
  1141$P="4.4.F/PENSCR";R.
  1142$P="4.5.0/PPSCR";R.
  1143$P="3.D.E/PHASCR";R.
  1144$P="3.D.F/PAPSCR";R.
  1145$P="3.E.0/PPSCR";R.
  1146$P="3.E.1/POPSCR";R.
  1147$P="4.5.1/PROSCR";R.
  1148$P="4.5.2/PTMSCR";R.
  1149$P="3.E.2/PKPSCR";R.
  1150$P="3.E.3/QBSCR";R.
  1151$P="4.5.3/QHSCR";R.
  1152$P="4.8.7/QFESCR";R.
  1153$P="3.E.4/R2SCR";R.
  1154$P="3.E.5/RESSCR";R.
  1155$P="3.E.6/RPSCR";R.
  1156$P="4.2.E/ROBSCR";R.
  1157$P="4.5.4/RRSCR";R.
  1158$P="3.E.7/ROVSCR";R.
  1159$P="3.E.8/RUBSCR";R.
  1160$P="3.E.9/SANSCR";R.
  1161$P="4.5.5/SBSCR";R.
  1162$P="4.5.6/SKSCR";R.
  1163$P="4.5.7/SYSCR";R.
  1164$P="4.8.8/SHSCR";R.
  1165$P="3.E.A/SODSCR";R.
  1166$P="3.E.B/SINSCR";R.
  1167$P="4.5.8/S21SCR";R.
  1168$P="3.E.C/SOPSCR";R.
  1169$P="3.E.E/SO2SCR";R.
  1170$P="3.E.D/SO1SCR";R.
  1171$P="4.8.9/CSSCR";R.
  1172$P="4.5.B/SDSCR";R.
  1173$P="3.E.F/SJSCR";R.
  1174$P="3.F.0/PONSCR";R.
  1175$P="4.8.A/SBSCR";R.
  1176$P="4.8.B/SPSCR";R.
  1177$P="3.F.1/STESCR";R.
  1178$P="4.8.C/STSCR";R.
  1179$P="4.5.C/SBSCR";R.
  1180$P="4.8.D/TASCR";R.
  1181$P="3.F.2/TSSCR";R.
  1182$P="3.F.3/TERSCR";R.
  1183$P="4.5.D/TPSCR";R.
  1184$P="3.F.4/TISSCR";R.
  1185$P="3.F.5/TLBSCR";R.
  1186$P="3.F.6/TLTSCR";R.
  1187$P="4.3.4/TO1SCR";R.
  1188$P="4.3.5/TO2SCR";R.
  1189$P="4.8.E/TO3SCR";R.
  1190$P="4.8.F/TRSCR";R.
  1191$P="4.9.0/UFOSCR";R.
  1192$P="4.9.1/VVSCR";R.
  1193$P="3.F.7/VECSCR";R.
  1194$P="3.F.8/VINSCR";R.
  1195$P="4.5.E/ZBSCR";R.
  1196$P="3.F.9/ZOXSCR";R.
  1197$P="4.5.F/ZOSCR";R.
  1198$P="3.F.A/ZUKSCR";R.
