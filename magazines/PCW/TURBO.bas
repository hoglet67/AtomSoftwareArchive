  0S=0;A=32773;B=A.R.%15;C=0;P.$12;?#E1=0
 20IF?#B001=127A=A+1
 30IF?#B001=191A=A-1
 40A=A-1;?A=32;A=A+2;?A=32;A=A-1
 50IFA>32781G.e
 51IFA<32769G.e
 70?33248=127;?33262=127;P.';S=S+1
 92C=C+33248;?C=8;C=A.R.%15;IFS>200G.f
 93A=A+32;IF?A=8G.e
 94A=A-32;?A=127;G.20
100eP."SPLAT"'"SCORE:"S;E.
200fC=C+33248;?C=8;C=A.R.%15;G.93