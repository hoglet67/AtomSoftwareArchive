  5 @=0;S=0;P.$12;IN."DIFFICULTY = "U
 10 F.G=1 TO 3;A=16;?#E1=0
 20 F.L=1 TO 15;P.';N.
 50 E=A.R.%10;IF E<U; GO.70
 60 E=A.R.%32;E?#81E0=32+G
 70 P.';S=S+(9-U)*G
 80 IF ?#B001<>#FF;GO.a
 81 IF ?#B002=151 OR ?#B002=135;GO.b
 90 GOS.w;GO.50
100aA=A-1;IF A<0 A=0
105 GOS.w;GO.81
110bA=A+1;IF A>30 A=30
120 GOS.w;GO.50
200wA ?#8000=48+4-G;WAIT
205 IF A ?#8020<>32 GO.300
210 R.
300 P.'$30 "LOST BASE #"4-G'"SCORE: "S'
301 U=U-2*G;IF U<1 U=1
302 P.3-G" BASES LEFT"'
303 IF G<3 P."DIFFICULTY NOW = "U'
304 F.T=1 TO 120;WAIT;N.
305 N.;P."GAME OVER"';E.
