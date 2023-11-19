1 REM THIS IS A SHORT QUIZ ON THE VIDEO GAME Super Street Fighter II
2 '   written by Kenneth Vitalis
3 '   for video game lovers everywhere
4 '   Fall 1994
5 '   a gw-basic program
8 '
9 CLS
10 COLOR 10, 1, 15
15 CLS : KEY OFF
20 LOCATE 10, 30: PRINT "SUPER STREET FIGHTER II"
30 LOCATE 11, 38: PRINT "by"
40 LOCATE 12, 30: PRINT "Kenneth Vitalis"
50 LOCATE 15, 20: PRINT "This is a short quiz on Super Street Fighter II."
60 LOCATE 16, 20: PRINT "It includes all new and old characters.  The"
70 LOCATE 17, 20: PRINT "quiz is multiple choice.  Only one of the listed"
80 LOCATE 18, 20: PRINT "answers is correct.  Make your selection by "
90 LOCATE 19, 20: PRINT "typing 1, 2, or 3 and pressing <ENTER>."
100 FOR X = 1 TO 3000: NEXT X
110 LOCATE 23, 25: PRINT "PRESS ANY KEY TO CONTINUE."
120 ANYKEY$ = INPUT$(1)
130 REM This starts question 1
135 CLS
140 LOCATE 10, 15: PRINT "Question #1"
150 LOCATE 12, 15: PRINT "What character intros for SSF II?"
160 LOCATE 14, 22: PRINT "1. T. Hawk"
170 LOCATE 15, 22: PRINT "2. Ryu"
180 LOCATE 16, 22: PRINT "3. Chun Li"
190 LOCATE 18, 15: INPUT "Enter selection (1 2 3)"; A$
200 CLS
210 IF A$ = "2" THEN GOSUB 4000 ELSE GOSUB 5000
215 REM This starts question 2
220 CLS
230 LOCATE 10, 15: PRINT "Question #2"
240 LOCATE 12, 15: PRINT "Who is the new female character for SSF II?"
250 LOCATE 14, 22: PRINT "1. Cammy"
260 LOCATE 15, 22: PRINT "2. Chun Li"
270 LOCATE 16, 22: PRINT "3. Kitana"
280 LOCATE 18, 15: INPUT "Enter selection (1 2 3 )"; B$
285 CLS
290 IF B$ = "1" THEN GOSUB 4000 ELSE GOSUB 5000
300 REM This starts question 3
310 CLS
420 LOCATE 10, 15: PRINT "Question #3"
430 LOCATE 12, 15: PRINT "Who is the secret character in SSF II?"
440 LOCATE 14, 22: PRINT "1. Jade"
450 LOCATE 15, 22: PRINT "2. Reptile"
460 LOCATE 16, 22: PRINT "3. Akuma"
470 LOCATE 18, 15: INPUT "Enter selection (1 2 3)"; C$
475 CLS
480 IF C$ = "3" THEN GOSUB 4000 ELSE GOSUB 5000
490 REM This starts question 4
500 CLS
510 LOCATE 10, 15: PRINT "Question #4"
520 LOCATE 12, 15: PRINT "Who is the last character to fight in SSF II"
530 LOCATE 15, 22: PRINT "1. Sagat"
540 LOCATE 16, 22: PRINT "2. M. Bison"
550 LOCATE 17, 22: PRINT "3. Balrog"
560 LOCATE 19, 15: INPUT "Enter selection (1 2 3 )"; D$
565 CLS
570 IF D$ = "2" THEN GOSUB 4000 ELSE GOSUB 5000
580 REM This starts question 5
590 CLS
600 LOCATE 10, 15: PRINT "Question #5"
610 LOCATE 12, 15: PRINT "Who was the first character designed for the Street Fighter series?"
620 LOCATE 15, 22: PRINT "1. Ken"
630 LOCATE 16, 22: PRINT "2. Blanka"
640 LOCATE 17, 22: PRINT "3. Ryu"
650 LOCATE 19, 15: INPUT "Enter selection (1 2 3 )"; E$
655 CLS
660 IF E$ = "3" THEN GOSUB 4000 ELSE GOSUB 5000
670 REM This starts question 6
675 CLS
680 LOCATE 10, 15: PRINT "Question #6"
690 LOCATE 12, 15: PRINT "Who are the only two Black characters in SSF II?"
700 LOCATE 14, 22: PRINT "1. Blanka and Guile"
710 LOCATE 15, 22: PRINT "2. Balrog and Dee Jay"
720 LOCATE 16, 22: PRINT "3. Ken and Ryu"
730 LOCATE 18, 15: INPUT "Enter selection (1 2 3 )"; F$
735 CLS
740 IF F$ = "2" THEN GOSUB 4000 ELSE GOSUB 5000
750 REM This starts question 7
755 CLS
760 LOCATE 10, 15: PRINT "Question #7"
770 LOCATE 12, 15: PRINT "Who is second in command on SSF II?"
780 LOCATE 15, 22: PRINT "1. Vega"
790 LOCATE 16, 22: PRINT "2. Balgog"
800 LOCATE 17, 22: PRINT "3. Sagat"
810 LOCATE 19, 22: INPUT "Enter selection (1 2 3 )"; G$
815 CLS
820 IF G$ = "3" THEN GOSUB 4000 ELSE GOSUB 5000
830 REM This starts question 8
835 CLS
840 LOCATE 10, 15: PRINT "Question #8"
850 LOCATE 12, 15: PRINT "Who is the character from India?"
860 LOCATE 15, 22: PRINT "1. Dhalsim"
870 LOCATE 16, 22: PRINT "2. Guile"
880 LOCATE 17, 22: PRINT "3. T. Hawk"
890 LOCATE 19, 15: INPUT "Enter selection (1 2 3 )"; H$
900 CLS
910 IF H$ = "1" THEN GOSUB 4000 ELSE GOSUB 5000
920 REM This starts question 9
925 CLS
930 LOCATE 10, 15: PRINT "Question #9"
940 LOCATE 12, 15: PRINT "Who is the character from England?"
960 LOCATE 15, 22: PRINT "1. Vega"
970 LOCATE 16, 22: PRINT "2. E. Honda"
980 LOCATE 17, 22: PRINT "3. Cammy"
990 LOCATE 19, 22: INPUT "Enter selection (1 2 3)"; I$
995 CLS
1000 IF I$ = "3" THEN GOSUB 4000 ELSE GOSUB 5000
1100 REM This starts question 10
1110 CLS
1120 LOCATE 10, 15: PRINT "Question #10"
1130 LOCATE 12, 15: PRINT "Who is the tallest character on SSF II?"
1140 LOCATE 14, 22: PRINT "1. Sagat"
1150 LOCATE 15, 22: PRINT "2. T. Hawk"
1160 LOCATE 16, 22: PRINT "3. Balrog"
1170 LOCATE 18, 15: INPUT "Enter selection (1 2 3 )"; J$
1175 CLS
1180 IF J$ = "2" THEN GOSUB 4000 ELSE GOSUB 5000
3900 LOCATE 15, 20: PRINT "Your score is "; SCORE; "percent."
3910 LOCATE 20, 20: PRINT "Press any key to continue."
3920 ANYKEY$ = INPUT$(1)
3930 CLS
3990 GOTO 6000
4000 LOCATE 15, 20: PRINT "YOUR SELECTION WAS CORRECT!!!!!"
4010 SCORE = SCORE + 10
4015 FOR X = 1 TO 2000: NEXT X
4020 LOCATE 20, 20: PRINT "Press any key to continue."
4030 ANYKEY$ = INPUT$(1)
4035 CLS
4040 RETURN
5000 LOCATE 15, 20: PRINT "Your selection was wrong."
5005 FOR X = 1 TO 2000: NEXT X
5010 LOCATE 20, 20: PRINT "Press any key to continue."
5020 ANYKEY$ = INPUT$(1)
5025 CLS
5030 RETURN
6000 CLS
6010 LOCATE 2, 35: PRINT "REVIEW"
6020 LOCATE 5, 10: PRINT "The following are the answers to the questions you answered wrong:"
6025 PRINT "  "
6030 IF A$ <> "2" THEN PRINT "Ryu"
6040 IF B$ <> "1" THEN PRINT "Cammy"
6050 IF C$ <> "3" THEN PRINT "Akuma"
6060 IF D$ <> "2" THEN PRINT "M. Bison"
6070 IF E$ <> "3" THEN PRINT "Ryu"
6080 IF F$ <> "2" THEN PRINT "Balrog and Dee Jay"
6090 IF G$ <> "3" THEN PRINT "Sagat"
6100 IF H$ <> "1" THEN PRINT "Dhalsim"
6110 IF I$ <> "3" THEN PRINT "Cammy"
6120 IF J$ <> "2" THEN PRINT "T. Hawk"
6130 FOR X = 1 TO 3000: NEXT X
6140 LOCATE 24, 20: PRINT "Press any key to continue."
6150 ANYKEY$ = INPUT$(1)
6160 CLS
6170 END

