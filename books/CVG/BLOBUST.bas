
1REM BLOCKBUSTER
2REM COMPUTER & VIDEO GAMES 4/1983
10X=#7F;Q=#BF
20S=#8000;B=#B000;H=0;Z=#80
30DIM C3,SS2,P-1
40GOS.i
50C?0=32;C?1=X;C?2=Q;C?3=#FF
60DO P.$12
70DO IN."SKILL LEVEL (1-5)"W;U.W>0 AND W<6
80N=0;T=0;@=0;A=3
90CLEAR0;MOVE 0,43;DRAW 63,43
100?#E1=0
110F.J=64 TO511
120R=A.R.%4
130N=N+(R+1 OR R+2)
140S?J=C?R
150N.J
160P=272;S?P=171
170P.$30"    press"$128"ANY"$128"key"$128"to"$128"start"
180LI.#FFE3
190Y=10;F.J=100 TO 1 S.-1;?Z=J;LI.SS0;N.J
200P.$30;LI.#FE22;?#E0=21;P."HIGH: ",H
210F=1
220DO D=0
230?B=2;IF B?1=254;D=32
240?B=3;IF B?1=254;D=-32
250?B=1;D=D-(B?1=251)
260?B=9;D=D+(B?1=247)
270IF D=0;D=F
280F=D
290L=P;P=P+D
300IF P%32=0 AND L%32=31;P=P-32
310IF P%32=31 AND L%32=0;P=P+32
320IF P<64;P=P+448
330IF P>511;P=P-448
340WAIT;V=S?P
350IF V=Q;GOS.j
360IF V=X;T=T+5+2*W;N=N-1;?Z=40;Y=40;LI.SS0
370IF V=#FF;GOS.k
380WAIT;S?L=32;WAIT;S?P=171
390P.$30"SCORE: "T" LIVES: "A
400F.J=1 TO 15-W*3;WAIT;N.
410U.N=0 OR A=0
420Y=10;F.J=1 TO100;?Z=J;LI.SS0;N.J
430?B=0
440IF T>H;H=T
450LI.#FFE3;U.0
460jIF A.R.%5;T=T+10+4*W;N=N-1;?Z=30;Y=40;LI.SS0;R.
470kA=A-1
480WAIT;S?L=32
490?Z=0;Y=150;LI.SS0
500F.J=1 TO4
510WAIT;S?P=V
520F.K=1TO150;N.K
530WAIT;S?P=171
540F.K=1TO150;N.K
550N.J
560F.J=1TO1500;N.J;R.
570iP.$12"          blockbuster"''
580P.$#FF"....SINGLE SCORE"'
590P.$#9F"....DOUBLE SCORE, 20% RISK"'
600P.$#DF"....AVOID AT ALL COSTS!"''
610P."CONTROLS:"''
620P."CURSOR KEYS...UP & DOWN"'
630P."      < & >...LEFT & RIGHT"''
640SS0=-1;SS1=-1;SS2=-1
650P.$21
660[
670:SS0 LDA B+2
680:SS1 LDX Z
690:SS2 DEX;NOP;NOP;BNE SS2;EOR @4; STA B+2;DEY;BNE SS1;RTS
700]
710P.$6;LI.#FFE3;R.
