  5REM SKI-RUN By ROB HEARD
 10 DIM I(5),A(5),Q(10)
 15 C=#B002
 20 P.$12;INPUT"DO YOU NEED INSTRUCTIONS"$I
 30 IF?I=CH"Y" GOTO 450
 35IN."WHAT IS YOUR NAME "$Q
 40 INPUT"WHAT IS YOUR SKIING SPEED 0-5(0=SLOW;5=FAST)"K
 45 IF K<0 OR K>5 GOTO 40
 46 K=5-K
 50 P."HOW MANY TREES DO YOU THINK YOU COULD SKI AROUND "$Q"."
 55IN.L
 65IF L<1 OR L>200;P.'"TOO AMBITIOuS "$Q"!"';G.50
 70 P.$12;CLEAR0
 80 FOR N=1 TO L
 90 P=A.R.%(#1FF)+#8000
100 ?P=#1E
110 N.N
120 R=#800F;J=1
130 ?R=#23;?(R+32)=32
140 ?#81F0=255
150 F.O=1TO3000;N.O
160 T=R
170 M=?#B001
180  IF M=253 THEN R=R-1; GOTO 210
190 IF M=251 THEN R=R+1;GOTO 210
200 R=R+32
210 IF ?R=30 GOTO 269
220 IF ?R=255GOTO 310
230 ?T=32;?R=35
240 FOR Y=1 TO K*75;N.Y
250 IF R>#81FF;?R=32;GOTO 420
260 GOTO 160
269 FOR B=1 TO 150;?C=?C:4;N.B;P.$7;F.B=1TO150;?C=?C:4;N.B
270 ?T=32;F.D=1TO4;FORT=191TO255;?R=T;N.T
271 FOR G=65 TO127;?R=G;N.G;N.D
280 P."YOU HAVE HAD AN ACCIDENT"'$Q"."'
290 P."WHEN YOU RECOVER WOULD YOU LIKE"'
300 GOTO 390
310 F.B=1TO4
320?T=#AA;P.$7;?T=32;P.$7;?#81F0=32;P.$7
321N.B
330 P.$12
340 P."WELL DONE.."$Q" YOU MADE IT!"'
350 P."JUST IN TIME FOR TEA?*!"'
360 P."IT TOOK YOU"J" RUN";IF J>1 P."S"
370 P.'"DOWN THE SLOPE,"'
380 P."AND YOUR SPEED LEVEL WAS "K'
390 INPUT"ANOTHER GAME..."$A
400 IF?A=CH"Y" GOTO 40
410 P.$12;END
420 R=R-600;J=J+1
430 IF ?R=30 THEN ?R=32
440 GOTO 220
450 P.$12;P."    ## SKI RUN ##"';P.'
460 P."YOU ARE AT THE TOP OF A SNOWY"';P."HILL..."'
470 P."WHICH IS DOTTED WITH TREES-^"'
480 P."YOU START AT THE TOP CENTRE OF"'
490 P."THE SCREEN AND YOU'VE GOT TO"'
500 P."GET TO 'HOME':MIDDLE BOTTOM"'
510 P."OF THE SCREEN!"'
520 P.';P."TO GO LEFT PRESS THE'3'KEY."'
530 P."TO GO RIGHT PRESS THE'-'KEY."'
540 P."IF NO KEY IS PRESSED YOU MOVE"'
550 P."DOWN."'
560 PRINT"READ THAT?"'
570 LINK#FFE3
580 P.$12;P."PRESS ONLY ONE KEY AT"'
590 P."ANY TIME."'
600 PRINT"OKAY?"'
601 P.';P.';P."IF YOU GO OFF THE BOTTOM BEWARE!!!:"'
602 P.';P."YOU WILL REAPPEAR   SOMEWHERE ON THE TOP LINE!!!"'
603 P.';P."PRESS SPACE BAR & GET READY."'
604 LINK #FFE3
605 GOTO 35
