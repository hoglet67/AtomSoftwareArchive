  10 REM TALKBACK
  20 DIM YY(6),ZZ(7),A(10)
  30 P.$12;P=P&#FF00+#100
 100 P.$21;GOSUBa;GOSUBa;P.$6$12
 110 DO INPUT"RECORD (R) OR PLAYBACK (P) "$A
 120 UNTIL ?A=CH"P" OR ?A=CH"R"
 130 IF ?A=CH"P" LINK ZZ0;GOTO 100
 200 P.'"ONE MOMENT PLEASE"'
 210 C=#1010101
 220 FOR X=#8200 TO #97FF STEP 4
 230 !X=C;NEXT X
 240 P.$12"PRESS ANY KEY TO START RECORDING"
 250 LINK #FFE3;LINK YY0
 260 P.$12"** END **"''$7;GOTO 100
1000a REM RECORD ROUTINE
1005 DIM P(-1)
1010[
1020:YY0 LDX @0;LDY @#82
1030:YY1 LDA @10
1040:YY2 SEC;NOP;SBC @1;BNE YY2
1050 LDA #B002;ROL A;ROL A;ROL A
1060:YY3 ROL #8200,X;BCC YY5
1070 INX;BNE YY6
1080 INY;STY YY3+2;CPY @#98
1090:YY4 BNE YY1;RTS
1100:YY5 LDA @#FF;NOP
1110:YY6 NOP;NOP;BNE YY4
1120]
1500 REM PLAYBACK ROUTINE
1510[
1520:ZZ0 LDX @0;LDY @#82
1530:ZZ1 LDA @8;STA ZZ7
1540:ZZ2 LDA #8200,X
1550:ZZ3 ASL A;PHA;PHP;LDA @10
1560:ZZ4 SEC;SBC @1;BNE ZZ4;NOP
1570 PLP;LDA @4;ADC @0;STA #B003
1580 PLA;DEC ZZ7;BNE ZZ6;INX;BNE ZZ5
1590 INY;STY ZZ2+2;CPY @#98;BNE ZZ1;RTS
1600:ZZ5 PHA;PLA;NOP;JMP ZZ1
1610:ZZ6 ASL #FF00,X;ASL #FF00,X;ASL #FF00,X;JMP ZZ3
1620:ZZ7 NOP
1630];RETURN