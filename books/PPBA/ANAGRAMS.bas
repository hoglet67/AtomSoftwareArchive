 10 REM ... ANAGRAMS ...
 30 DIMA(64)
 40 INPUT"WORD"$A
 50 N=LENA;DIM CC(N)
 60 A=A-1;F=1;S=1
100 FOR J=1TON;CCJ=J;F=F*J;NEXT
102 PRINT "THERE ARE" F " PERMUTATIONS"
105 GOSUBd
110 FOR H=2TOF;GOSUBp;GOSUBd;NEXT
120 END
200pI=N-1; J=N
205 IF CC(I)>=CC(I+1) I=I-1; GOTO 205 
210 IF CC(J)<=CC(I) J=J-1; GOTO 210
220 GOSUBs
230 I=I+1;J=N;IF I=J RETURN
240 DO GOSUBs; I=I+1; J=J-1;UNTIL I>=J
250 RETURN
300sT=CCI;CCI=CCJ;CCJ=T;S=1-S;RETURN
400dPRINT ';FORK=1TON;PRINT $A?CCK;NEXT;RETURN
