
70?#E=51;?#D=#ED
80P=#81;Q=#80;P.$21;[JSR#FFE3;STAQ;RTS;];P.$6
100B=256;M=T.-25;T=T.-49;R=T.-71;E=#2803;X=#21C
120P.$12;GOS.d;P.$T';GOS.d;T=#2F50
130P.'"PLEASE TYPE YOUR NAME THEN PRESSRETURN"';GOS.r;$X=$B
135?#E1=0;P." "'"HELLO "$X';W=10;GOS.w;O=#80BD;K=13;GOS.p
150GOS.a;?#E1=#80;P."TRY PRESSING RETURN A FEW TIMES"';W=0
155GOS.h;GOS.p;P.';GOS.s;GOS.p
161?#E1=Q;P."LIKE THIS"'">"
165W=20;GOS.w;P.'"NOW PRESS RETURN"';J=0;W=0
166P.';GOS.w;P.">";LINK#81;IF?Q=13A.J<4;J=J+1;G.166
168IFJ<4;P.'"JUST PRESS RETURN";G.166
169P.';GOS.p;O=O-65;K=127;GOS.a;?#E1=Q;P."NOW PRESS DELETE"'
170W=0;GOS.h
180O=#80FC;GOS.a;?#E1=Q;P."PRESS REPEAT NOW"';W=3;GOS.h
190GOS.s;GOS.p;?#E1=Q
195P."TRY ENTERING A LONG LINE NOW"'
200LINK#CD0F;P."WELL DONE "$X" YOU TYPED:"'$B'
210P.'$R"THAT ?"';LINK#CD0F;IF?B=89G.195
220O=#80E4;Q=#80FA;GOS.a;?#E1=#80
230P."PRESS SHIFT NOW"';W=1;GOS.h
260Q=#80;O=#80E2;GOS.a;?#E1=Q
270P."PRESS LOCK NOW"';W=2;GOS.h
290GOS.p;GOS.s;GOS.p;P.';?#E1=Q;P.$E'
300LINK#CD0F;IF$B=$E;P."WELL DONE "$X'';G.330
310P.'"SORRY "$X" YOU TYPED:"'$B'"TRY AGAIN"'$E'';G.300
330O=#8021;GOS.g;O=O+28;GOS.g;GOS.s;?#E1=Q;P." "
360GOS.p;P.'$R'"LESSON ";IN.$B
370IF?B=89;G.100
380P.'"GOODBYE "$X';END
1000fW=2;F.J=0TO9;GOS.c;GOS.w;N.;R.
1010c?O=#7F;?Q=?O;GOS.w;?O=#FF;?Q=?O;R.
1100dF.I=1TO32;P.$172;N.I;R.
1200wF.I=0TO8*W;WAIT;N.I;R.
1300pI=0;DOB?I=T?I;I=I+1;U.T?I=32ORT?I=13
1310B?I=13;IFT?I=13;T=T+2
1320IFC.+I>31;P.'
1330I=I+1;IF$B="^"G.q
1335P.$B" ";T=T+I;G.p
1340qT=T+I;W=20;GOS.w;P.';R.
1400bF.I=0TO28S.2;B?I=223;B?(I+1)=32;N.;B?I=13
1410P.'" "$B''$B''" "$B''"  "$B$8$8" "''"        "
1420F.I=1TO15;P.$223;N.;P.'';R.
1500rA=58;LINK#CD0F;R.
1600aGOS.s;GOS.b;GOS.p;GOS.f;R.
1610gGOS.s;GOS.b;P.$7"DON'T PRESS THIS KEY !"'';?O=#7F;GOS.p;R.
1700hD=W;W=1;F.J=0TO3;GOS.(1710+D);P.$7;GOS.c;N.;R.
1710DOLINK#81;U.?#80=K;R.
1711DOU.?#B001=K;R.
1712?#B000=4;DOU.?#B001&1=0;?#B000=0;R.
1713DOU.?#B002&#40=0;R.
2000s?#E1=0;P.$M;LINK#FFE3;P.'$12;?#E1=0;P." "$8;R.
5000THESE PROGRAMS WILL INTRODUCE YOU TO ATOM BASIC.
5010TO COMMUNICATE WITH THE ATOM YOU MUST BE FAMILIAR
5020WITH THE KEYBOARD. ^ THE MOST IMPORTANT KEY IS RETURN. ^
5030YOU HAVE TO PRESS RETURN AFTER EVERY COMMAND. ^
5045A COMMAND TELLS THE ATOM TO DO SOMETHING. WHEN THE ATOM IS
5046WAITING FOR A COMMAND IT DIPLAYS A PROMPT. ^ A PROMPT WILL
5047APPEAR UNTIL YOU ENTER A COMMAND. ^ THE DELETE KEY WILL
5050REMOVE THE LAST CHARACTER YOU TYPED. ^ PRESSING REPEAT
5055TOGETHER WITH ANOTHER KEY WILL REPEAT THAT KEY. ^
5060THE ATOM WILL ACCEPT 64 CHARACTERS BEFORE A RETURN. IF YOU
5070TYPE MORE THAN THIS YOU WILL HAVE TO DELETE SOME CHARACTERS
5080^ SOME KEYS HAVE TWO LEGENDS. BY HOLDING DOWN A SHIFT KEY
5090YOU CAN SELECT THE UPPER LEGEND. ^ IF YOU PRESS LOCK ANY
5100LETTER YOU TYPE WILL APPEAR inverted UNTIL YOU PRESS LOCK
5110AGAIN. ^ BEWARE inverted LETTERS ARE NOT LEGAL IN COMMANDS.
5120^ TRY USING SHIFT NOW. SEE IF YOU CAN TYPE THIS. ^
5140YOU CAN STOP ANY BASIC PROGRAM BY PRESSING ESCAPE. ^
5150BREAK IS LIKE ESCAPE BUT MUCH MORE DRASTIC. ^ DON'T PRESS
5160ESCAPE UNLESS I ASK YOU. ONLY PRESS BREAK AS A LAST RESORT.
5170^ �(�L��
8800DO YOU WANT TO REPEAT 
8900INTRODUCTION TO BASIC
9000PRESS SPACE TO CONTINUE
