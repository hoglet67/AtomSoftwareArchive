
2T=32;X=16;G=#DE;C=#8000;*L."TDATA"
3D=#E1;F.M=0TO95;M?C=#AA;N.;!G=#98020;P."TELEPHONE BOOK"
4S=256;A=#880C0;B=A+#A0;GOS.T;!G=A;F.I=0TO16;P." ";N.;!G=A
5J=#27E0;?D=#80;IN.$S;?D=0;P."�";!G=B;IF?S-60G.9
6$S=$S+1;$S+15="";GOS.X;IF?J=0$J+48=$J+X;J?T=0;IFJ?T;P.$7;G.4
7$J=$S;F.I=0TOX;P." ";N.;!G=B;?D=#80;IN.$S
8$S+15="";$J+X=$S;?D=0;P."�";G.4
9IF?S-62ORJ?T=0GOS.X;P.$J+X;LI.-29;G.4
11DOJ=J+T;GOS.T;!G=A;P.$J;!G=B;P.$J+X;LI.-29;U.J?T=0;G.4
16DOJ=J+T;U.$J=$S OR?J=0;R.
32F.I=96TO508S.4;I!C=-1;N.;R.