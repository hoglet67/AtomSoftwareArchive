 10 PROC MAIN();
 20 BEGIN
 30   PROC PRIME(N);
 35   {PRINT N IF PRIME}
 40   BEGIN D=1;
 60     TRY:D=D+1;E=N;
 65     IF D<N-1 THEN
 68     BEGIN
 70       TEST:E=E-D;
 75       IF E<>0 THEN
 80         IF E<128 THEN GOTO TEST
 85         ELSE GOTO TRY
 88     END
 90     ELSE WRHEX(N)
110   END;
115 {MAIN PROGRAM}
120   ENTER:T=1;
125   ALL:PRIME(T);WRCH(32);
130   IF T<128 THEN
140   BEGIN
150     T=T+1;GOTO ALL
170   END
190 END