
4GOS.1940
1550DIMR(7)
1560G=#1740
1570S=#8000
1580CLEAR4
1590H=17;GOS.1750
1600GOS.a
1610IF H=1;GOS.c;G=G-#100;GOS.2010
1620IF H=2;GOS.c;GOS.2020
1630IF H=3;GOS.c;G=G-#100;GOS.2030
1640IF H=5;GOS.c;G=G-#100;GOS.2050
1650IF H=6;GOS.c;GOS.2060
1660IF H=7;GOS.c;G=G-#100;GOS.2070
1670IF H=20;GOS.c;GOS.2200
1680IF H=24;GOS.c;GOS.2240
1690IF H=4;GOS.c;G=G-#200;GOS.2040
1700IF H=8;GOS.c;G=G-#200;GOS.2080
1710IF H=18;GOS.c;G=G-#200;GOS.2180
1720IF H=22;GOS.c;G=G-#200;GOS.2220
1730IF H=10;GOS.c;G=G+#1;GOS.2100
1740IF H=14;GOS.c;G=G+#1;GOS.2140
1750IF H=17;GOS.c;G=G-#FF;GOS.2170
1760IF H=23;GOS.c;G=G-#FF;GOS.2230
1770IF H=12;GOS.c;G=G-#1;GOS.2120
1780IF H=16;GOS.c;G=G-#1;GOS.2160
1790IF H=19;GOS.c;G=G-#101;GOS.2190
1800IF H=21;GOS.c;G=G-#101;GOS.2210
1810IFH=9;GOS.c;G=G+#20;GOS.2090
1820IFH=11;GOS.c;G=G+#20;GOS.2110
1830IFH=13;G.c;G=G+#20;GOS.2130
1840IFH=15;GOS.c;G=G+#20;GOS.2150
1850IF S+G<#8000;G.m
1860IF S+G>#98FF;G.m
1870F.B=1TO5;?#B000=?#B000&#F0+B
1880B?#7F=?#B001&8;N.B
1890IF?#81=0;GOS.d
1900IF?#82=0;GOS.e
1910IF?#83=0;GOS.f
1920IF?#84=0;GOS.g
1930G.1610
1940CLEAR0
1950P.$12''
1960 P."            pilot"'''"         BY roy pincott"'''
1970 P."C BANK LEFT       B BANK RIGHT"''
1980 P."E NOSE DOWN       D NOSE UP"''''
1990 LINK#FFE3
2000 R.
2010GOS.c;!R=#18E70000;R!4=#000000;H=1;GOS.a;R.
2020GOS.c;!R=#003C7EC3;R!4=#000018;H=2;GOS.a;R.
2030GOS.c;!R=#E7180000;R!4=#000000;H=3;GOS.a;R.
2040GOS.c;!R=#7E3C0018;R!4=#0000C3;H=4;GOS.a;R.
2050GOS.c;!R=#18E70000;R!4=#000000;H=5;GOS.a;R.
2060GOS.c;!R=#003C7EC3;R!4=#000018;H=6;GOS.a;R.
2070GOS.c;!R=#E7180000;R!4=#000000;H=7;GOS.a;R.
2080GOS.c;!R=#7E3C0018;R!4=#0000C3;H=8;GOS.a;R.
2090GOS.c;!R=#18040606;R!4=#060604;H=9;GOS.a;R.
2100GOS.c;!R=#7B7B70E0;R!4=#00E070;H=10;GOS.a;R.
2110GOS.c;!R=#06081818;R!4=#181808;H=11;GOS.a;R.
2120GOS.c;!R=#DEDE0E07;R!4=#00070E;H=12;GOS.a;R.
2130GOS.c;!R=#18040606;R!4=#060604;H=13;GOS.a;R.
2140GOS.c;!R=#7B7B70E0;R!4=#00E070;H=14;GOS.a;R.
2150GOS.c;!R=#06081818;R!4=#181808;H=15;GOS.a;R.
2160GOS.c;!R=#DEDE0E07;R!4=#00070E;H=16;GOS.a;R.
2170GOS.c;!R=#7B60C000;R!4=#000000;H=17;GOS.a;R.
2180GOS.c;!R=#18180018;R!4=#605838;H=18;GOS.a;R.
2190GOS.c;!R=#0306DE00;R!4=#000000;H=19;GOS.a;R.
2200GOS.c;!R=#181C1A06;R!4=#180018;H=20;GOS.a;R.
2210GOS.c;!R=#DE060300;R!4=#000000;H=21;GOS.a;R.
2220GOS.c;!R=#18180018;R!4=#061A1C;H=22;GOS.a;R.
2230GOS.c;!R=#C0607B00;R!4=#00000C;H=23;GOS.a;R.
2240GOS.c;!R=#18385860;R!4=#180018;H=24;GOS.a;R.
4000dIF H=1;GOS.2020;R.
4002IF H=2;GOS.2030;R.
4004IF H=3;GOS.2040;R.
4006IF H=4;GOS.2010;R.
4008IF H=5;GOS.2060;R.
4010IF H=6;GOS.2070;R.
4012IF H=7;GOS.2080;R.
4014IF H=8;GOS.2050;R.
4016IF H=9;GOS.2120;R.
4018IF H=10;GOS.2090;R.
4020IF H=11;GOS.2100;R.
4022IF H=12;GOS.2110;R.
4024IF H=13;GOS.2160;R.
4026IF H=14;GOS.2130;R.
4030IF H=15;GOS.2140;R.
4032IF H=16;GOS.2150;R.
4034IF H=17;G=G-#100;GOS.2200;R.
4036IF H=18;GOS.2170;R.
4038IF H=19;GOS.2180;R.
4040IF H=20;GOS.2190;R.
4042IF H=21;GOS.2240;R.
4044IF H=22;GOS.2210;R.
4046IF H=23;GOS.2220;R.
4048IF H=24;GOS.2230;R.
4050R.
5000eIF H=1;GOS.2040;R.
5002IF H=2;GOS.2010;R.
5004IF H=3;GOS.2020;R.
5006IF H=4;GOS.2030;R.
5008IF H=5;GOS.2080;R.
5010IF H=6;GOS.2050;R.
5012IF H=7;GOS.2060;R.
5014IF H=8;GOS.2070;R.
5016IF H=9;GOS.2100;R.
5018IF H=10;GOS.2110;R.
5020IF H=11;GOS.2120;R.
5022IF H=12;GOS.2090;R.
5024IF H=13;GOS.2140;R.
5026IF H=14;GOS.2150;R.
5028IF H=15;GOS.2160;R.
5030IF H=16;GOS.2130;R.
5032IF H=17;G=G-#100;GOS.2180;R.
5034IF H=18;GOS.2190;R.
5036IF H=19;GOS.2200;R.
5038IF H=20;GOS.2170;R.
5040IF H=21;GOS.2220;R.
5042IF H=22;GOS.2230;R.
5044IF H=23;GOS.2240;R.
5046IF H=24;GOS.2210;R.
5048R.
6000fIF H=1;GOS.2150;R.
6002IF H=2;GOS.2240;R.
6004IF H=3;GOS.2110;R.
6006IF H=4;GOS.c;G=G-#200;GOS.2180;R.
6008IF H=5;GOS.2130;R.
6010IF H=6;GOS.2200;R.
6012IF H=7;GOS.2090;R.
6014IF H=8;GOS.c;G=G-#200;GOS.2220;R.
6016IF H=9;GOS.c;G=G-#200;GOS.2010;R.
6018IF H=10;GOS.2170;R.
6020IF H=11;GOS.2050;R.
6022IF H=12;GOS.2210;R.
6024IF H=13;GOS.2030;R.
6026IF H=14;GOS.2230;R.
6028IF H=15;GOS.2070;R.
6030IF H=16;GOS.2190;R.
6032IF H=17;GOS.2140;R.
6034IF H=18;GOSc;G=G-#200;GOS.2080;R.
6036IF H=19;GOS.2120;R.
6038IF H=20;GOS.2020;R.
6040IF H=21;GOS.2160;R.
6042IF H=22;GOS.c;G=G-#200;GOS.2040;R.
6044IF H=23;GOS.2100;R.
6046IF H=24;GOS.2060;R.
6048R.
7000gIF H=1;GOS.2090;R.
7002IF H=2;GOS.2200;R.
7004IF H=3;GOS.2130;R.
7006IF H=4;GOS.c;G=G-#200;GOS.2220;R.
7008IF H=5;GOS.2110;R.
7010IF H=6;GOS.2240;R.
7012IF H=7;GOS.2150;R.
7014IF H=8;GOS.c;G=G-#200;GOS.2180;R.
7016IF H=9;GOS.2070;R.
7018IF H=10;GOS.2230;R.
7020IF H=11;GOS.2030;R.
7022IF H=12;GOS.2190;R.
7024IF H=13;GOS.2050;R.
7026IF H=14;GOS.2170;R.
7028IF H=15;GOS.2010;R.
7030IF H=16;GOS.2210;R.
7032IF H=17;GOS.2100;R.
7034IF H=18;GOS.c;G=G-#200;GOS.2040;R.
7036IF H=19;GOS.2160;R.
7038IF H=20;GOS.2060;R.
7040IF H=21;GOS.2120;R.
7042IF H=22;GOS.c;G=G-#200;GOS.2080;R.
7044IF H=23;GOS.2140;R.
7046IF H=24;GOS.2020;R.
8000aF.V=0TO7;S?G=R?V;G=G+32;N.V;R.
8010bF.V=0TO7;S?H=R?V;H=H+32;N.V;R.
8100c!R=#00000000;R!4=#000000;H=G-#120;GOS.b
8110R.
8200mCLEAR0;P.$12;P."you crashed"
9999 LINK#FFE3;G.1550
