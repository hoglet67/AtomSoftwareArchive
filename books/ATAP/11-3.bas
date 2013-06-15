    1 REM Three-Dimensional Plotting
   50 L=30;M=40;N=8
  110 Z=0;CLEAR4
  120 A=#8000;B=#9800
  130 FORJ=A TO B STEP4;!J=-1;N.
  150 S=L*L+M*M;GOS.s;R=Q
  160 S=S+N*N;GOS.s;S=L*L+M*M
  170 T=L*L+M*M+N*N
  200 F.U=-20TO20
  210 V=-20;GOS.c;GOS.b
  220 F.V=-19TO20;GOS.c;GOS.a;N.;N.
  230 END
  400sQ=S/2
  410 DOQ=(Q+S/Q)/2
  415 U.(Q-1)*(Q-1)<S AND(Q+1)*(Q+1)>S
  420 R.
  500 REM DRAWTO(U,V,W)
  510aZ=3
  520bO=T-U*L-V*M-W*N
  530 C=T*(V*L-U*M)*4/(R*O)+128
  540 D=96+3*Q*(W*S-N*(U*L+V*M))/(R*O)
  560 PLOT(Z+4),C,D;Z=0;R.
  600cW=300/(10+U*U+V*V)-10;R.

