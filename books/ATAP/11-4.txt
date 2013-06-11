    1 REM Plotting Hex Characters
   10 N=TOP; !N=#6E3E4477; N!4=#467B6B4D
   12 N!8=#795F4F7F; N!12=#1B3B7C33
   20 V=2; H=2; S=0
   25 CLEAR 0
   30 X=30; Y=0
   40 MOVE (32+X),(24+Y)
   50 X=X+Y/6;Y=Y-X/6
   60 A=ABSRND&#F
   70 GOSUBp
   90 GOTO 40
 1000qREM Plot B as 2 hex digits
 1010 A=B/16; GOSUB p
 1020 A=B&#F
 2000pREM Plot A in hex
 2001 REM uses:A,H,J,K,L,N,Q,V
 2010 Q=N?A
 2020 FOR J=1 TO 7
 2030 K=(2-J%6)%2;L=(2-(J-1)%4)%2
 2040 PLOT(Q&1),(L*H+K*S),(K*V)
 2050 Q=Q/2; NEXT J
 2060 PLOT0,((H+2)/2),0; RETURN


