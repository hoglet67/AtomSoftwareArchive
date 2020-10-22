
10 REM *********************
20 REM REPTON
30 REM ELECTRON - TIM TYLER
40 REM ATOM     - KEES V.OSS
50 REM *********************
60 
70 P.$12;?#E1=0
80 P."€€€€€€€r€e€p€t€o€n€€€€€€"'
90 P."      ORIGINAL BY TIM TYLER     " 
100 P."  ATOM VERSION BY KEES VAN OSS  "'
110 P."       €keys€or€joystick€       "
120 P.'
130 P."    Z - LEFT     ; - UP         "
140 P."    X - RIGHT    . - DOWN       "'
150 P."  ESC - KILL     R - RESTART    "'
160 P."          Q/S   - SOUND         "
170 P."       COPY/DEL - PAUSE         "'
180 P."€€€€€press€space€to€start€€€€€€";?#81FF=160
190 LI.#FFE3
200 CLEAR4;CO.1;*N.
210 *LO."REPSCR"8000
220 F.I=0TO180;WAIT;N.
230 F.I=0TO#1FFS.4;I!#9400=I!#2C00;N.
240 LI.#FFE3
250 ?#20A=#78;?#20B=#C2
260 *R."REPTON"
