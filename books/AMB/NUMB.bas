
 10 REM NUMBER GUESSING B
 20 N=1+ABS(RND%99);@=0
 30 PRINT $12,"I AM THINKING OF "'
 40 PRINT "A NUMBER FROM 1 TO 99"'
 50 PRINT "YOU HAVE 7 GUESSES."''
100 FOR G=1 TO 7
110 INPUT X;IF X=N THEN GOTO 200
120 IF X<N THEN PRINT $11,X," IS TOO SMALL"'
130 IF X>N THEN PRINT $11,X," IS TOO BIG"'
140 NEXT G
150 PRINT'"IT WAS ",N';END
200 PRINT $7;WAIT;PRINT $7
210 PRINT'"*** CORRECT ***"';END
