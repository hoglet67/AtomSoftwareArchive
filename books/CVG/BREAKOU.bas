
0 REM BREAKOUT
5 DIM A1,PP5,BB5,LL5,NN6
10 FOR J=0 TO 5; LLJ=-1; BBJ=-1; PPJ=-1; NEXT
15 PRINT $12,$21
20 GOSUB a; GOSUB a
25 PRINT$6
30 @=3; C=0
35gPRINT"           BREAKOUT"'
40 PRINT"           ========"
45 PRINT'''"BEST SCORE SO FAR = ",C
50 PRINT'''"HOW FAST DO YOU WANT TO PLAY?"'
55cINPUT"TYPE 1 TO 5 AND PRESS RETURN"',$A
60 IF LEN A >1 GOTO c
65 B=53-?A
70 IF B<0 OR B>4 G.c
75 CLEAR 0
80 MOVE 1,0; DRAW 1,44
85 MOVE 62,0; DRAW 62,44
90 ?#E1=0
95 PRINT $#1E,$#A,$9,$223,$223
100 GOSUB e
105 PRINT $#D,$#A,$9; GOSUB e;  PRINT $255,$255,$#D,$#A,$9
110 PRINT $223,$223; GOSUB e;  PRINT $#1E
115 S=0; ?#80=14
120 FOR N=5 TO 1 STEP -1; REM MAIN LOOP 
125 X=ABSRND%60+2; Y=35; REM INITIAL X & Y OF BALL
130fU=-1; REM DOWN 
135 R=ABSRND%3-1; REM R,L OR 0
140 PRINT" SCORE: ",S,"      BALLS LEFT:",N,$#1E
145 Q=#8000
150 PLOT 13,X,Y
155 Z=3
160 DO REM GRAPHICS LOOP 
165 IF B=0 GOTO d
170 FOR J=1TOB;WAIT;NEXT
175dWAIT
180 LINK LL0
185 UNTIL Z<3
190 IF Z=0 PRINT $7; GOTO b
195 REM Z=0 IF BAT MISSED
200 IF Z=2 S=S+50; LINK NN0; GOTO b
205 REM Z=2 IF THRO' GAP
210 REM Z=1 IF BRICK HIT, AND
215 REM Q THEN HOLDS SCREEN
220 REM ADDRESS OF BRICK HIT
225 IF Q%2=1 Q=Q+1 
230 M=Q-1
235 ?M=#59; ?Q=#66
240 LINK NN3
245 ?M=#40; ?Q=#40
250 S=S+10; GOTO f
255bNEXT N; REM NEXT BALL
260 PRINT"FINAL SCORE: ",S,"  BALLS LEFT: 0",$#1E 
265 FOR J=1 TO 15; P.$#A; NEXT
270 PRINT $9,"PRESS SPACE BAR TO PLAY AGAIN "
275 LINK #FFE3
280 IF S>C C=S
285 PRINT $12; GOTO g
290aDIM P(-1)
295[:LL0
300 LDA #B001
305 AND @#80
310 BEQ LL2
315 LDA #B002
320 AND @#40
325 BNE LL3
330:LL1 LDA #80 
335 CMP @28
340 BCS LL3
345 INC #80
350 BNE LL3
355:LL2 LDA #80
360 CMP @2    
365 BCC LL3
370 DEC #80 
375:LL3 LDX @30
380:LL4 LDA #81E0,X
385 AND @#FC
390 STA #81E0,X
395 DEX
400 BNE LL4
405 LDX #80 
410 LDY @3
415:LL5 LDA #81E0,X
420 ORA @3
425 STA #81E0,X
430 INX
435 DEY
440 BNE LL5
445 LDA @2
450 STA #5E
455 LDA #33A
460 BEQ BB1 OUT IF Y=0 
465 STA #5C
470 LDA #339 
475 STA #5A
480 JSR #F6E2 BLANK BALL
485 LDA #339
490 CMP @2 CHECK L.H.0WALL
495 BNE BB2
500 LDA @1; STA #333
505 BNE BB3
510:BB2 CMP @61 CHECK R.H.WALL
515 BNE BB4
520 LDA @#FF; STA #333
525:BB3 LDA #339
530:BB4 CLC
535 ADC #333
540 STA #339 NEW X
545 JSR PP0
550 CLC
555 LDA #33A
560 ADC #336
565 CMP @45
570 BEQ BB0 OUT IN THRO' GAP 
575 STA #33A NEW Y
580 LDA #339; STA #5A
585 LDA #33A; STA #5C
590 JSR #F6E2 PLOT BALL
595 RTS
600:BB0 LDA @2; STA #33B 
605 RTS  OUT WITH Z=2
610:BB1 STA #33B;RTS OUT WITHZ=0
615:PP0 LDA #339
620 LSR A
625 STA #5F STORE X/2
630 LDA @47
635 SEC
640 SBC #33A
645 SBC #336   Y = NEW Y
650 LDX @#FF
655 SEC
660:PP1 INX
665 SBC @3
670 BCS PP1
675 ADC @3
680 STA #61 STORE (47-Y)%3
685 TXA; ASL A; ASL A
690 ASL A; ASL A; ASL A
695 ORA  #5F
700 STA #5F STORE (X/2)/(47-Y)/3*32  
705 LDA @#80; ADC @0
710 STA #60 HI BYTE OF SCREEN ADDRESS
715 LDA #339; LSR A
720 LDA  #61
725 ROL A; TAY
730 LDA #F7CB,Y
735 LDY @0
740 AND (#5F),Y
745 BEQ PP5 RTN IF BIT CLEAR
750 LDA #33A
755 CMP @1; BNE PP3
760 LDA @1
765 STA #336 GO UP IF BAT HIT
770 LDA #B001; AND @#80
775 BNE PP4 BRANCH IF NO SHIFT
780 LDA #333; BMI PP5
785 DEC #333; DEC #339 DEC X&R
790 RTS
795:PP4 LDA #B002
800 AND @#40
805 BNE PP5 RTN IF NO REPT
810 LDA #333; CMP @1
815 BEQ PP5
820 INC #333; INC#339  INC R&X
825:PP5 RTS
830:PP3 LDA @1
835 STA #33B  Z=1
840 LDA #5F
845 STA #332  SAVE BRICK POSN IN Q
850 RTS
855:NN0 LDA #B002 HIGH BLEEP
860 LDY @#FF
865:NN1 LDX @#80
870:NN2 DEX
875 BNE NN2
880 EOR @4
885 STA #B002
890 DEY
895 BNE NN1
900 RTS
905:NN3 LDA @3 EXPLOSION
910 STA #81
915:NN4 LDX @#FF
920:NN5 TXA; TAY
925 LDA #B002
930 EOR @4
935 STA #B002
940:NN6 DEY; BNE NN6
945 DEX; BNE NN5
950 DEC #81; BNE NN4
955 RTS             
960] RETURN
965eFOR I=1 TO 7
970 PRINT $255,$255,$223,$223;NEXT
975 RETURN
