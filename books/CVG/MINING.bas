  5 REM MINING COLONY, ROBERT CAMPBELL, C&VG ISSUE 12
  6 REM MODIFIED BY DAVID BANKS AS ORIGINAL WAS POOR
 10 P.$12
 11 IN."INSTRUCTIONS (1=YES;2=NO)"V;IF V=1 GOS.i
 15 B=32928
 16 IN."DIFFICULTY (1-6)"F
 17 CLEAR 0
 18 IF F>6 G.16
 20 F. I=1 TO F;A=A.R.%32+33249
 30 ?A=42
 35 ?B=64
 36 ?B=102
 37 ?B=64
 38 IF ?(B+32)=42 G.100
 39 IF B=32960 G.200
 40 N.
 50 WAIT;P.$10$24
 60 C=?#B001
 70 IF C=127 B=B+1
 80 IF C=191 B=B-1
 81 IF B<32928 B=32928
 85 ?B=102
 86 IF ?B+32=42 G.100
 87 F.I=1 TO 5;WAIT;N.
 90 G.20
100 P."YOU CRASHED"';LINK#FFE3;RUN
200 P.$12$7$7"YOU DID IT"'"THE MINERS THANK YOU"';END
300iP.$12"FERRY"'"-----"''
310 P."A MINING COLONY HAS BEEN SET"'"UP IN AN ASTEROID "
320 P."FIELD. IT IS"'"YOUR JOB TO CONTROL THE ROBOT"'
330 P."SHIPS THROUGH THE ASTEROID"'"FIELD TO SUPPLY "
340 P."THEM."'"CTRL-LEFT"'"SHIFT-RIGHT"''
350 P."press and key to run"';LI.#FFE3;P.$12;R.