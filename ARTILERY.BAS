2 REM by Kevin Schafer
5 REM color graphics card needed
10 SCREEN 1: OUT 980, 2: OUT 981, 43
20 ON ERROR GOTO 820
30 KEY OFF: CLS
40 LOCATE 12, 16: PRINT "ARTILLERY!"
50 LOCATE 15, 22: PRINT "By Kevin Schafer"
60 LINE (158, 0)-(162, 85), 2, BF
70 LINE (110, 81)-(205, 85), 2, BF
80 LINE (110, 81)-(114, 100), 2, BF
90 LINE (205, 85)-(201, 100), 2, BF
100 LINE (110, 100)-(205, 96), 2, BF
110 LINE (158, 100)-(162, 199), 2, BF
120 PLAY "O3L4GGG8GD+B-8GD+B-8G"
130 PLAY "O4L4DDD8DD+O3B-8GD+B-8GP1"
140 CLS : INPUT "DO YOU WANT INSTRUCTIONS"; I$
150 IF LEFT$(I$, 1) = "Y" THEN 720
160 INPUT "DO YOU WANT SOUND"; S$
170 S$ = LEFT$(S$, 1)
180 V = VAL(MID$(TIME$, 4, 2)) + VAL(MID$(TIME$, 7, 2))
190 RANDOMIZE V
200 CLS
210 P(1) = CINT(60 * RND(1)) + 50
220 P(2) = CINT(60 * RND(1)) + 210
230 A = 100
240 B = RND(1)
250 FOR I = 0 TO 319
260 PSET (I, A): PSET (I, A + 1)
270 C = RND(1) + .25
280 IF B > .5 THEN 310
290 IF C > .8 THEN A = A + 1 ELSE A = A - 1
300 GOTO 330
310 IF C > .2 THEN A = A + 1 ELSE A = A - 1
320 B = C
330 IF A = 0 THEN C = .9: GOTO 280
340 IF A = 199 THEN C = 0: GOTO 280
350 IF I = P(1) THEN A(1) = A
360 IF I = P(2) THEN A(2) = A
370 NEXT I
380 LINE (P(1), A(1))-(P(1) - 5, A(1) - 5), 1, BF
390 LINE (P(2), A(2))-(P(2) - 5, A(2) - 5), 2, BF
400 T = 1: G = 0: PLAYER = 1
410 LOCATE 25, 1: PRINT "PLAYER"; PLAYER; : LOCATE 1, 1
420 INPUT "VELOCITY (30-200)"; V$: IF PLAYER = 1 THEN PLAYER = 2 ELSE PLAYER = 1
430 LOCATE 1, 18: PRINT "     "
440 INPUT "ANGLE (1-85)"; A$
445 LOCATE 2, 13: PRINT "     "
450 IF VAL(V$) < 1 OR VAL(A$) < 1 THEN 825
456 V = VAL(V$): A = VAL(A$): A = A * 3.1416 / 180
460 S = TAN(A)
470 X = P(T) - (6 * (T - 1)): Y = A(T) - 6
480 PSET (X, Y), 3: IF S$ = "Y" THEN SOUND (150 - Y) * 10, 1
490 X1 = X + 3 - (2 * T): Y1 = Y - S + G / V
500 IF POINT(X1, Y1) <> 0 THEN 530
510 PSET (X, Y), 0: X = X1: Y = Y1
520 G = G + 1: GOTO 480
530 P = POINT(X1, Y1)
540 IF P = 3 - T THEN 640
550 LINE (X1, Y1 - 1)-(X1 - 4, Y1 - 10)
560 LINE (X1, Y1 - 1)-(X1, Y1 - 10)
570 LINE (X1, Y1 - 1)-(X1 + 4, Y1 - 10)
580 IF S$ = "Y" THEN PLAY "O1L64CECECECECECECE"
590 FOR I = 1 TO 500: NEXT I
600 LINE (X1, Y1 - 1)-(X1 - 4, Y1 - 10), 0
610 LINE (X1, Y1 - 1)-(X1, Y1 - 10), 0
620 LINE (X1, Y1 - 1)-(X1 + 4, Y1 - 10), 0
630 T = 3 - T: G = 0: GOTO 410
640 T = 3 - T
650 FOR I = 1 TO 10
660 IF S$ = "Y" THEN SOUND 100 * I, .01
670 LINE (P(T) + I, A(T) + I)-(P(T) - 5 - I, A(T) - 5 - I), T, BF: NEXT I
680 LINE (P(T) + 10, A(T) + 10)-(P(T) - 15, A(T) - 15), 0, BF
690 SOUND 37, 0
700 INPUT "WANT TO PLAY AGAIN(Y/N)"; P$
710 IF P$ = "Y" THEN 140 ELSE 825
720 PRINT "  This game is for two players.Each       one controls one base.The two bases"
730 PRINT "  are blue and red.Blue goes first.When    the computer asks for velocity it"
740 PRINT "  wants to know how hard you want to      shoot your missile.Enter a number"
750 PRINT "  about 30 to 200.Then it will ask for    angle.45 is equally out and up,30 is"
760 PRINT "  mostly out,and 60 is mostly up.Enter    any number from 1 to 85.Whoever hits"
770 PRINT "  the other player's base first wins."
780 PRINT : PRINT "  Good luck!"
790 PRINT : PRINT "  Press any key to continue"
800 A$ = INPUT$(1)
810 GOTO 160
820 IF ERR = 73 THEN PRINT "  You aren't in BASICA.Load BASICA and    try again."
825 KEY ON: END

