
0REM /// DOGFIGHT /// V4
120 P.$12"            dogfight"'''
130P."CONTROLS  PLAYER 1  PLAYER 2"''
140P." LEFT      LOCK       /"'
150P." RIGHT      Z        REPT"'
160P." FIRE      COPY       M"'
170P." THRUST    CTRL       ,"'
175P.'"STARS  :  SHIFT"'''
180P."PRESS KEY TO START"
190 LINK#FFE3
200A=#2D1F;B=#2D00;F=#2E00
210F.I=0TO159S.4;F!I=0;N.
220F?1=#80;F?19=F?1;F?37=F?1;F?55=F?1
230?#8F=0;?#88=0;?#89=#2F
240F.I=0 TO 61;B?I=0;N.
250Z=!#310D;FOR I=0 TO 61;Z?I=0;N.
260!A=#C0110F0;A!4=4;!B=#4011010;B!4=0
270CLEAR4;MOVE0,5;DRAW255,5;MOVE255,191;DRAW0,191
280MOVE127,5;DRAW127,20
290IF?#B001&#80<>0 G.320
300PLOT13,(RND&#FF),(ABSRND%170+25)
310PLOT9,1,1;PLOT9,-2,0;PLOT9,0,-2;PLOT9,2,0;G.290
320LI.#3100;F.I=0TO3000;N.
322 MOVE 15,5
325 IF A?26=#A MOVE 140,5
327 FORJ=1 TO 4
330 D=#2CDB;GOSUB d
335 PLOT 0,20,-15;N.J
350 G.190
1000dDO PLOT(?D-128),(D?1-128),(D?2-128)
1002 FORI=1TO200;N.
1005 D=D+3;U.?D-128=16;R.
0 (C) ACORNSOFT 1980
