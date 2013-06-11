    1 REM Saddle Curve
  100 FINPUT"CHOOSE VIEW POSITION"'"X="%L,"Y="%M,"Z="%N
  110 FINPUT"LOOKING TOWARDS"'"X="%A,"Y="%B,"Z="%C
  115 %L=%L-%A;%M=%M-%B;%N=%N-%C
  120 W=4;CLEAR4
  150 %S=%L*%L+%M*%M;%R=SQR%S
  160 %T=%S+%N*%N;%Q=SQR%T
  200 FORX=-10TO10
  210 Y=-10;GOS.c;GOS.m
  220 FORY=-9TO10;GOS.c;GOS.p;N.;N.
  230 FORY=-10TO10
  240 X=-10;GOS.c;GOS.m
  250 FORX=-9TO10;GOS.c;GOS.p;N.;N.
  260 END
  400pW=5
  410m%U=%X-%A;%V=%Y-%B;%W=%Z-%C
  420 %O=(%T-%X*%L-%Y*%M-%Z*%N)*%R
  425 FIF %O<0.1 W=4
  430 G=%(400*(%Y*%L-%X*%M)*%Q/%O)+128
  440 H=%(500*(%Z*%S-%N*(%X*%L+%Y*%M))/%O)+96
  460 PLOTW,G,H;W=4;R.
  600c%Y=Y;%X=X
  610 %Z=.05*(%Y*%Y-%X*%X);R.

