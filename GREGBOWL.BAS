CLS
SCREEN 13
PLAY "mbt175l10dp10ddp8edefefl3g"
PLAY "mbt175l10ggaggaggagab>c<p6<<<c>>>>"
FOR sc = 16 TO 256
CIRCLE (160, 100), sc, sc
IF e = 0 THEN LET e = 1 ELSE e = 0
IF e = 0 THEN
CIRCLE (160, 100 + 1), sc, sc
CIRCLE (160, 100 - 1), sc, sc
END IF
NEXT sc
DO
COLOR 10
LOCATE 1, 1
PRINT "BY:"
COLOR 35
LOCATE 1, 5
PRINT "Greg Partlow"
LET rc = INT(RND * 256)
COLOR rc
LOCATE 12, 17
PRINT "Burst Tech"
LOCATE 13, 17
PRINT "software"
LOCATE 14, 17
PRINT "presents."
LOCATE 23, 1
PRINT "PRESS A KEY"

FOR delay = 1 TO 1000: NEXT delay
LOOP UNTIL INKEY$ <> ""

CLS
SCREEN 0
DIM NA$(3), S(3), T(3): COLOR 3, 0, 0
WIDTH 40: KEY OFF: LOCATE 1, 1, 0: CLS : DEF SEG = 0: POKE 1047, 64
LOCATE 8, 12: PRINT "BOWLING CHAMP!!"
LOCATE 13, 7: PRINT "How many bowlers? (1-4):"
50 a$ = "": WHILE a$ = "": a$ = INKEY$: WEND
IF ASC(a$) < 49 OR ASC(a$) > 52 THEN 50 ELSE a = VAL(a$)
FOR I = 1 TO a: LOCATE 15 + I, 8: PRINT "Bowler"; I;
LOCATE , 16: PRINT "'s name:";
INPUT a$: NA$(I - 1) = LEFT$(a$, 8): NEXT
CLS : LOCATE 13, 7: PRINT "Difficulty level (0-60).": LOCATE 14, 7: PRINT "60=extremely easy ; 0=impossible"
LOCATE 16, 9: INPUT DIFLVL
CLS : COLOR 15: LOCATE 1, 10: PRINT "1  2  3  4  5  6  7  8  9  10"
LOCATE 2, 10: FOR J = 1 TO 31: PRINT CHR$(196); : NEXT
    FOR I = 1 TO a: LOCATE 2 * I + 1, 1: COLOR I + 1: PRINT NA$(I - 1); : LOCATE , 12
    COLOR 15: FOR J = 12 TO 36 STEP 3: PRINT CHR$(179) + "  "; : NEXT
     LOCATE 2 * I + 2, 10: FOR J = 1 TO 31: PRINT CHR$(196); : NEXT: NEXT
    LOCATE 12, 1: FOR I = 0 TO a - 1: IF I = 2 THEN LOCATE 14, 1
    COLOR I + 2: PRINT NA$(I); ":"; SPC(19 - LEN(NA$(I))); : NEXT: COLOR 15
    LOCATE 15, 1: FOR I = 1 TO 39: PRINT CHR$(196); : NEXT
    LOCATE 25, 1: FOR I = 1 TO 39: PRINT CHR$(196); : NEXT
    FOR I = 0 TO a - 1: S(I) = 1: NEXT
    FOR Q = 1 TO 10: FOR Z9 = 0 TO a - 1
    COLOR , Z9 + 2: FOR I = 16 TO 24: LOCATE I, 1: PRINT SPC(39); : NEXT
    B1 = 0: GOSUB 390
    IF J1 <> 10 THEN B1 = 1: GOSUB 430
    IF Q = 10 THEN ON S GOTO 280, 310, 310, 280, 340
280 NEXT: NEXT: LOCATE 16, 10: PRINT "Play again? (y/n):"
    a$ = "": WHILE a$ = "": a$ = INKEY$: WEND: IF a$ = "Y" THEN RUN ELSE COLOR 7, 0: END
310 LOCATE 20, 1: PRINT "Take two more balls, "; NA$(Z9);
    FOR I = 1 TO 2000: NEXT: LOCATE , 1: PRINT SPC(29);
    S(Z9) = S - 1: B1 = 1: GOSUB 390: IF J <> 10 THEN 370 ELSE 360
340 LOCATE 20, 1: PRINT "Take one more ball, "; NA$(Z9);
    FOR I = 1 TO 2200: NEXT: LOCATE , 1: PRINT SPC(28);
360 S(Z9) = 1: B1 = 2: GOSUB 390: GOTO 280
370 S(Z9) = 1: B1 = 2: GOSUB 430: GOTO 280
390 COLOR 15: LOCATE 17, 39
    FOR I = 1 TO 31: READ PC: PRINT CHR$(PC); : NEXT: RESTORE
    PS = 1 = 1: J1 = 0: GOTO 440
430 PS = 0
440 GOSUB 500: T = T(Z9): S = S(Z9): T = T + J
    ON S(Z9) GOSUB 680, 700, 720, 740, 760
    T(Z9) = T: S(Z9) = S: COLOR Z9 + 2, 0
    LOCATE 14 + (Z9 < 2) * 2, 31 + (Z9 / 2 = INT(Z9 / 2)) * 20: PRINT T(Z9)
    COLOR 0, Z9 + 2: RETURN
500 H = 1: V = 24: D = -1: COLOR 0, Z9 + 2
    WHILE INKEY$ = "": LOCATE V, H: PRINT " ";
    V = V + D: LOCATE V, H: PRINT "O";
    FOR I = 1 TO DIFLVL * 50: NEXT: IF V = 24 OR V = 16 THEN D = -D
    WEND: FOR H = 2 TO 35: LOCATE V, H - 1: PRINT " O"; : a$ = INKEY$
    IF a$ = "]" THEN WHILE INKEY$ = "": WEND
    SOUND 37, .5: SOUND 32767, .1: NEXT
    J = 0: WHILE H < 40
    IF SCREEN(V, H) = 234 THEN J = J + 1 ELSE 610
    FOR D = -1 TO 1 STEP 2: X1 = V: X2 = H
590 X1 = X1 + D: X2 = X2 + 1: IF SCREEN(X1, X2) = 234 THEN LOCATE X1, X2: PRINT " "; : J = J + 1: SOUND 74, .5: SOUND 32767, .1: GOTO 590
    NEXT
610 LOCATE V, H - 1: PRINT " O"; : H = H + 1: WEND
    J1 = J1 + J
    LOCATE 2 * Z9 + 3, 7 + 3 * Q + B1: COLOR -(2 + Z9) * (B1 = 0), -(2 + Z9) * (B1 <> 0): G = J + 48
    IF J1 = 10 THEN IF PS THEN G = 88 ELSE G = 47
    PRINT CHR$(G): COLOR 0, 2 + Z9
    LOCATE V, H - 1: PRINT " "; : RETURN
680 IF J1 = 10 THEN IF PS THEN S = 2 ELSE S = 5
    RETURN
700 T = T + J: IF J = 10 THEN S = 3 ELSE S = 4
    RETURN
720 T = T + J * 2: IF J <> 10 THEN S = 4
    RETURN
740 T = T + J: IF J1 = 10 THEN S = 5 ELSE S = 1
    RETURN
760 T = T + J: IF J = 10 THEN S = 2 ELSE S = 1
    RETURN
     DATA 234,31,29,29,234,31,29,29,234,28
     DATA 234,31,29,29,29,29,234,28,234,31
     DATA 29,29,234,28,234,31,29,29,234,31,234

