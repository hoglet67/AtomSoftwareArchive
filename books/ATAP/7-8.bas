    1 REM Arbitrary Precision Powers
    5 T=#3BFF
   10 H=(T-TOP)/3; DIM P(H),S(H),D(H)
   15 H=10000
   20 @=0;PRINT'" POWER PROGRAM"
   30 PRINT'"  COMPUTES Y^X, WHERE X>0 AND Y>0"
   40 INPUT'"  VALUE OF Y"Y,"  VALUE OF X"X
   50 IFX<1ORY<1PRINT"  VALUE OUT OF RANGE";RUN
   60 M=Y;N=X;GOSUBp
   70 PRINT Y"^"X"="P!!P;IF!P<8 RUN
   90 F.L=!P-4TO4STEP-4
   95 IFL!P<100P.0
  100 IFL!P<10P.0
  110 IFL!P<1P.0
  120 P.L!P;N.;RUN
  140*
  200pJ=M;IFN%2=0J=1
  210 R=P;GOS.e;J=M;R=S;GOS.e;IFN=1R.
  250 B=S;DOA=B;GOS.m;B=E
  255 N=N/2;A=P;IFN%2GOS.m;P=E
  260 U.N<2;R.
  280*
  300m!D=!A+!B+4;F.J=4TO!D+4S.4
  310 D!J=0;N.;W=D-4
  320 F.J=4TO!B S.4;C=0;G=B!J
  325 V=W+J;F.L=4TO!A S.4
  330 Q=A!L*G+C+V!L;V!L=Q%H
  340 C=Q/H;N.;V!L=C;N.
  370 DO!D=!D-4;U.D!!D<>0;E=D;D=A;R.
  380*
  400e!R=0;DO!R=!R+4;R!!R=J%H
  410 J=J/H;U.J<1;R.

