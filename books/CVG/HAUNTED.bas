  10 REM HAUNTED HOUSE
  15A=#8200;B=A+64;C=B+64
  20 DIM RR(11),EE(11),DD(20)
  30 F.N=0 TO 11;DIM J(14);RR(N)=J;N.
  40 $RR(1)="HALL"
  50 $RR(2)="LOUNGE"
  60 $RR(3)="DINING ROOM"
  70 $RR(4)="KITCHEN"
  80 $RR(5)="BALLROOM"
  90 $RR(6)="CONSERVATORY"
 100 $RR(7)="BILLIARD ROOM"
 110 $RR(8)="LIBRARY"
 120 $RR(9)="STUDY"
 130 $RR(10)="CELLAR"
 140 $RR(11)="GARDEN"
 200 F.N=0 TO 11;DIM J(12);EE(N)=J;N.
 210$EE(1)="EKIH@J@@@@@@"
 220$EE(2)="@@E@@@a@@@@n"
 230$EE(3)="@E@D@@j@@@@@"
 240$EE(4)="I@C@@@gb@@@@"
 250$EE(5)="CA@B@@@@@@@@"
 260$EE(6)="@GH@@@f@@@@@"
 270$EE(7)="FI@@@@c@@@@@"
 280$EE(8)="@@AF@@dh@@@l"
 290$EE(9)="GD@A@@k@@@@@"
 300$EE(10)="@@@@A@ei@@@m"
 310$EE(11)="@@@@@A@@@@@o"
 400 F.N=0 TO 15;DIM J(12);DD(N)=J;N.
 410 $DD(1)="KEY"
 420 $DD(2)="GUN"
 430 $DD(3)="TORCH"
 440 $DD(4)="BIBLE"
 450 $DD(5)="CANDLE"
 460 $DD(6)="BELL"
 470 $DD(7)="BONE"
 480 $DD(8)="DOG"
 485 $DD(9)="ROPE"
 490 $DD(12)="FIERCE DOG"
 500 $DD(13)="LOT OF RATS"
 510 $DD(14)="GHOST"
 520 $DD(15)="LOCKED DOOR"
 530 $DD(10)="AXE"
 540 $DD(11)="BUGLE"
 600 REM MAIN PROG
 610 F.N=0 TO 64;C?N=0;A?N=0;B?N=0;N.;I=0;P.$12
 620C?5=1;P."YOU HAVE JUST ENTERED A HAUNTED HOUSE AND THE "
 625 P."DOOR HAS LOCKED   BEHIND YOU."''
 626 P."       CAN YOU ESCAPE!!"'''
 630 P."WE ARE IN THE "$RR(C?5)'
 633 IF C?5=11 END
 635 GOS. 4000
 640 GOS.2000
 650 P."WHAT NOW?"';GOS.1000
 660 GOS.3000;REM TEST VERB
 662 IF C?5=11 P."!!!!YOU MADE IT!!!"';G.630
 665 IF ?C=1 G.630
 670 G.650
1000 REM INPUT CMDS
1010 IN.$A
1020 I=0;IF LEN(A)<1 G.1000
1030 DO;I=I+1
1040 UNTIL A?I=32 OR I=LEN(A)
1050 IF I=LEN(A) P."REPLY TWO WORDS"';G.1000
1060 $B=$A+(I+1);$A+I=""
1100 IF $A="GO" ?C=1;G.1200
1110 IF $A="TAKE" ?C=2;G.1200
1120 IF $A="LEAVE" ?C=3;G.1200
1130 IF $A="USE" ?C=4;G.1200
1140 IF $A="EXORCISE" ?C=5;G.1200
1170 P."I DON'T RECOGNISE "$A" "$B'';G.1000
1200 IF $B="NORTH" C?1=1;G.1300
1210 IF $B="SOUTH" C?1=2;G.1300
1220 IF $B="EAST" C?1=3;G.1300
1230 IF $B="WEST" C?1=4;G.1300
1240 IF $B="UP" C?1=5;G.1300
1250 IF $B="DOWN" C?1=6;G.1300
1255 I=0
1260 DO;I=I+1
1270 UNTIL $B=$DD(I) OR I=20
1280 IF I=20 P."I DON'T RECOGNISE "$B';G.1000
1290 C?1=I+96
1300 IF ?C=1 AND C?1>6 P."YOU CAN'T DO THAT !"';G.1000
1305 IF ?C>1 AND C?1<7 P."YOU CAN'T DO THAT"';G.1000
1310 R.
2000 IF C?2<96AND C?3<96AND C?4<96 R.
2010 P."YOU ARE CARRYING A :"'
2020 IF C?2>96P."                   "$DD(C?2-96)'
2030 IF C?3>96P."                   "$DD(C?3-96)'
2040 IF C?4>96P."                   "$DD(C?4-96)'
2050 R.
3000 REM VERB TEST
3010 $A=$EE(C?5)
3020 IF ?C=1 I=C?1-1;REM GO
3030 IF ?C>1  G.3100
3035 $B=$EE(A?I-64)
3040 IF A?I=64 P."THERE'S NO DOOR THERE."';R.
3050 IF B?11<>64 G.3070
3060 C?5=A?I-64;C?6=64;R.
3070 P."YOU CAN'T GO IN THERE.THERE'S A "$DD((B?11)-96)'
3080 C?6=B?11;C?7=A?I-64;R.
3100 IF ?C>2 G.3200;REM TAKE
3120 I=5
3130 DO;I=I+1
3140 UNTIL C?1=A?I OR I=11
3150 IF I=11 P."THE "$B" IS NOT IN HERE"';R.
3155 IF C?1>108 P."YOU MUST BE JOKING!!."';R.
3160 IF C?2=0 C?2=C?1;G.3195
3170 IF C?3=0 C?3=C?1;G.3195
3180 IF C?4=0 C?4=C?1;G.3195
3190 P."YOU HAVE THREE ITEMS ALREADY"';R.
3195 A?I=64;$EE(C?5)=$A;P."YOU'VE GOT IT"';R.
3200 IF ?C>3 G.3300
3215 I=5;REM LEAVE
3225 DO;I=I+1
3235 UNTIL A?I=64 OR I=11
3245 IFI=11 P."THERE'S NO SPACE IN HERE TO      LEAVE THAT."';R.
3250 IF C?1=C?2 C?2=0;G.3290
3260 IF C?1=C?3 C?3=0;G.3290
3270 IF C?1=C?4 C?4=0;G.3290
3280 P."YOU DON'T HAVE THE "$B';R.
3290 IF ?C=3 A?I=C?1;$EE(C?5)=$A;P."OK."';R.
3295 R.
3300 IF ?C>4 G.3500
3310 IF C?1=C?2 OR C?1=C?3 OR C?1=C?4 G.3330
3320 P."YOU DON'T HAVE THAT"';R.
3330 IF C?6<96 P."THERE'S NOTHING HERE.DON'T WASTE IT!"';R.
3335 $A=$EE(C?7)
3340IF C?6=108 AND C?1=103 P."THAT'S SATISFIED THE DOG"';G.3400
3350IF C?6=109 AND C?1=104 P."THE RATS HAVE FLED"';G.3400
3360IF C?6=111 AND C?1=97 P."THE DOOR'S UNLOCKED NOW"';G.3400
3370IF C?6=110 P."A "$B" WON'T SCARE A GHOST"';R.
3380 P."THAT HAS NO EFFECT.I SHOULD KEEP IT"';R.
3400 I=5
3410 DO;I=I+1
3420 UNTIL A?I=64 OR I=11
3425 IF C?1<>110 A?I=C?1
3430 A?11=64;$EE(C?7)=$A;G.3250
3500 IF ?C=5ANDC?1<>110 P."YOU CAN'T EXORCISE A "$B"!!"';R.
3505 IF C?6<>110 P."WHERE'S THE GHOST!!"';R.
3510 IFC?2=100 OR C?3=100 OR C?4=100 G.3530
3520 G.3600
3530 IFC?2=101 OR C?3=101 OR C?4=101 G.3550
3540 G.3600
3550 IFC?2=102 OR C?3=102 OR C?4=102 $A=$EE(C?7);G.3570
3560 G.3600
3570 P."YOU DID IT.HE'S VANISHED!!"';A?11=64;$EE(C?7)=$A;R.
3600 P."YOU DON'T HAVE THE NECESARY     ITEMS."';R.
4000 $A=$EE(C?5);REM LIST CONT
4010 I=5
4020 DO;I=I+1
4030 UNTIL A?I>64 OR I=11
4040 IF I=11 R.
4050 P."IN HERE THERE'S "'
4060 IF A?6>96 P."A "$DD(A?6-96)'
4070 IF A?7>96 P."A "$DD(A?7-96)'
4080 IF A?8>96 P."A "$DD(A?8-96)'
4090 IF A?9>96 P."A "$DD(A?9-96)'
4100 IF A?10>96 P."A "$DD(A?10-96)'
4110 R.


