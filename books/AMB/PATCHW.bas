
 10 REM PATCHWORK
100 CLEAR 0
110 FOR A=1 TO 100
120 FOR B=1 TO 31
130 FOR C=0 TO 31
140 E=(C*5/(B+A+1)+B)%2*2+13
145 D=B+C
146 F=B*23/31;G=D*23/31;H=63-D;I=63-B;J=47-F;K=47-G
150 WAIT;PLOT E,D,F
160 PLOT E,H,F
170 WAIT;PLOT E,D,J
180 PLOT E,H,J
190 WAIT;PLOT E,B,G
200 PLOT E,I,G
210 WAIT;PLOT E,B,K
220 PLOT E,I,K
230 NEXT;NEXT;NEXT;END