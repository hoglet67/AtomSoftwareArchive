
10 DIM LL6             
20 A=#28BE
30 P.$21               
40 GOSUB 80;GOSUB 80
50 P.$6                 
60 LINK A              
70 END                 
80 P=A;[
90 LDA@#28              
100 STA#209
110 LDA@#C9
120 STA#208            
130 RTS                
140 CMP @16            
150 BEQ LL1             
160 CMP @18            
170 BNE LL2
180 LDA @0
190 STA #90
200 RTS
210:LL1 LDA @1
220 STA #90
230 RTS
240:LL2 PHA 
250 LDA #90
260 BEQ LL3
270 PLA
280 JMP #FE52 
290:LL3 PLA 
300 CMP @32 
310 BMI LL5 
320 CMP @127
330 BEQ LL5 
340 CLC
350 CMP @64 
360 BMI LL6
370 CMP @95
380 BPL LL6 
390 ADC @32 
400 JMP #FE52 
410:LL6 ADC @96
420:LL5 JMP #FE52
430]; RETURN
