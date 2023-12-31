' Pac-Mania V2.5
'
' Player 1 Keys:    Player 2 Keys:
'      [8]               [W]
'   [4]   [6]         [A]   [S]
'      [2]               [Z]
'
' [0] to switch from Pac-Man and Ms. Pac-Man
'
    DEF SEG = 0
    POKE &H417, (Status% XOR &H40)     'Change Caps Lock state, bit 6.
    DEF FnRan (X) = INT(RND(1) * X) + 1
    DEF SEG = 0                       ' Set NumLock to ON
    KeyFlags = PEEK(1047)
    IF (KeyFlags AND 32) = 0 THEN
    POKE 1047, KeyFlags OR 32
    END IF
    DEF SEG
A$ = INKEY$
SPD = 250: PLAYER = 0: STYLE = 1: B = 47
SCREEN 7, 0, 1, 0: COLOR 15, 0: CLS
LOCATE 9, 17: PRINT "PAC-MANIA"
FOR A = 320 TO 0 STEP -10
CIRCLE (20 + A, 20 + B), 10, 14: PAINT (11 + A, 20 + B), 14
PSET (17 + A, 18 + B), 0: PSET (17 + A, 17 + B), 0: PSET (18 + A, 17 + B), 0
IF CHOMP = 0 THEN CHOMP = 1 ELSE IF CHOMP = 1 THEN CHOMP = 0
IF CHOMP = 1 THEN LINE (8 + A, 16 + B)-(17 + A, 20 + B), 0
IF CHOMP = 1 THEN LINE (17 + A, 20 + B)-(8 + A, 23 + B), 0
IF CHOMP = 1 THEN PAINT (10 + A, 20 + B), 0
IF CHOMP = 0 THEN LINE (17 + A, 20 + B)-(8 + A, 20 + B), 0
FOR X = 1 TO 700: NEXT X
SCREEN 7, 0, 0, 0: PCOPY 1, 0: SCREEN 7, 0, 1, 0
PAINT (20 + A, 20 + B), 0: PAINT (20 + A, 28 + B), 0: PAINT (12 + A, 23 + B), 0
NEXT A
5
DO: K$ = INKEY$: LOOP WHILE K$ <> ""
SCREEN 7, 0, 1, 0: COLOR 15, 0: CLS
PP = 0: W1 = 0: W2 = 0: W3 = 0: W4 = 0: W5 = 0: CHOMP = 0: BITE = 0: P = 0: T = 0: MV = 0: SELCT = 0
FOR X = 0 TO 290 STEP 40: CIRCLE (20 + X, 45), 10, 14: PAINT (11 + X, 45), 14: LINE (8 + X, 41)-(17 + X, 45), 0: LINE (17 + X, 45)-(8 + X, 48), 0: PAINT (10 + X, 45), 0: NEXT X
FOR X = 0 TO 290 STEP 40: CIRCLE (20 + X, 150), 10, 14: PAINT (11 + X, 150), 14: LINE (8 + X, 146)-(17 + X, 150), 0: LINE (17 + X, 150)-(8 + X, 153), 0: PAINT (10 + X, 150), 0: NEXT X
SCREEN 7, 0, 0, 0: PCOPY 1, 0
10
LOCATE 9, 17: PRINT "PAC-MANIA": LOCATE 11, 14
IF SELCT = 0 THEN PRINT CHR$(16); " PLAYERS? ";  ELSE PRINT "  PLAYERS? ";
IF PLAYER = 0 THEN PRINT "1" ELSE IF PLAYER = 1 THEN PRINT "2"
LOCATE 13, 14
IF SELCT = 1 THEN PRINT CHR$(16); " STYLE? ";  ELSE PRINT "  STYLE? ";
IF STYLE = 0 THEN PRINT "ATARI " ELSE IF STYLE = 1 THEN PRINT "ARCADE"
LOCATE 15, 14
IF SELCT = 2 THEN PRINT CHR$(16); " SPEED? ";  ELSE PRINT "  SPEED? ";
IF SPD = 50 THEN PRINT "FAST  " ELSE IF SPD = 250 THEN PRINT "MEDIUM" ELSE IF SPD = 500 THEN PRINT "SLOW  "
LOCATE 17, 14
IF SELCT = 3 THEN PRINT CHR$(16); " END";  ELSE PRINT "  END";
DO: A$ = INKEY$: LOOP WHILE A$ = ""
IF A$ = "8" THEN SELCT = SELCT - 1: IF SELCT < 0 THEN SELCT = 0: GOTO 10 ELSE GOTO 10
IF A$ = "2" THEN SELCT = SELCT + 1: IF SELCT > 3 THEN SELCT = 3: GOTO 10 ELSE GOTO 10
IF SELCT = 0 AND PLAYER = 0 THEN PLAYER = 1 ELSE IF SELCT = 0 AND PLAYER = 1 THEN PLAYER = 0
IF SELCT = 1 AND STYLE = 0 THEN STYLE = 1 ELSE IF SELCT = 1 AND STYLE = 1 THEN STYLE = 0
IF SELCT = 2 AND SPD = 50 THEN SPD = 250 ELSE IF SELCT = 2 AND SPD = 250 THEN SPD = 500 ELSE IF SELCT = 2 AND SPD = 500 THEN SPD = 50
IF SELCT <> 3 THEN GOTO 10
G = 120: H = 80: A = 0: B = 80
SCREEN 7, 0, 0, 0: CLS : EATEN = 1: YUM = 35
IF STYLE = 0 THEN COLOR 0, 1 ELSE IF STYLE = 1 THEN COLOR 0, 0
SCREEN 7, 0, 1, 0: CLS
PLAY "MB": SOUND 1000, 5: SOUND 1200, 5: SOUND 1100, 5: SOUND 920, 5
IF STYLE = 0 THEN DRAW "C6" ELSE IF STYLE = 1 THEN DRAW "C13"
DRAW "BM0,0D199R140BR40R139U199L140BL40L139"
DRAW "BM0,0R80BD40L80R40BD40R80U80"
DRAW "BM0,199R80BU40L80R40BU40R80D80"
DRAW "BM319,0L80BD40R80L40BD40L80U80"
DRAW "BM319,199L80BU40R80L40BU40L80D80"
DRAW "BM160,100U60D120"
DRAW "BM160,100C0U20D40"
DRAW "BM0,20C11"
FOR X = 1 TO 3: DRAW "BR18R4BR18": NEXT: DRAW "BR80": FOR X = 1 TO 3: DRAW "BR18R4BR18": NEXT
DRAW "BM0,60C11"
FOR X = 1 TO 3: DRAW "BR18R4BR18": NEXT: DRAW "BR80": FOR X = 1 TO 3: DRAW "BR18R4BR18": NEXT
DRAW "BM0,100C11"
FOR X = 1 TO 3: DRAW "BR18R4BR18": NEXT: DRAW "BR80": FOR X = 1 TO 3: DRAW "BR18R4BR18": NEXT
DRAW "BM0,140C11"
FOR X = 1 TO 3: DRAW "BR18R4BR18": NEXT: DRAW "BR80": FOR X = 1 TO 3: DRAW "BR18R4BR18": NEXT
DRAW "BM0,180C11"
FOR X = 1 TO 3: DRAW "BR18R4BR18": NEXT: DRAW "BR80": FOR X = 1 TO 3: DRAW "BR18R4BR18": NEXT
DRAW "BM160,100C6BD5BL5U10R10D10L10": PAINT (160, 100), 14, 6
CIRCLE (20, 20), 4, 14
CIRCLE (300, 20), 4, 14
CIRCLE (300, 180), 4, 14
CIRCLE (20, 180), 4, 14
PAINT (20, 20), 14
PAINT (300, 20), 14
PAINT (300, 180), 14
PAINT (20, 180), 14
20
CIRCLE (20 + A, 20 + B), 10, 14
IF PP = 0 THEN PAINT (11 + A, 20 + B), 14 ELSE IF PP = 1 THEN PAINT (11 + A, 20 + B), 15, 14
IF PAC = 1 THEN MSPAC$ = "BM" + STR$(A + 30) + "," + STR$(B + 10): DRAW MSPAC$: DRAW "C4BL2BD2L2R2D2R2D2"
IF PAC = 1 OR STYLE = 0 THEN PSET (17 + A, 18 + B), 0
IF PAC = 1 OR STYLE = 0 THEN PSET (17 + A, 17 + B), 0
IF PAC = 1 OR STYLE = 0 THEN PSET (18 + A, 17 + B), 0
GHOST$ = "BM" + STR$(G + 10) + "," + STR$(H + 16)
DRAW GHOST$
IF PP = 0 AND EATEN = 0 THEN DRAW "C5E5R10F5H5L10G5D10E5F5E5F5U10"
IF PP = 1 AND EATEN = 0 THEN DRAW "C9E5R10F5H5L10G5D10E5F5E5F5U10"
IF PP = 0 AND EATEN = 0 THEN PSET (17 + G, 18 + H), 5: PSET (17 + G, 17 + H), 5: PSET (18 + G, 17 + H), 5: PSET (23 + G, 18 + H), 5: PSET (23 + G, 17 + H), 5: PSET (22 + G, 17 + H), 5
IF PP = 1 OR EATEN = 1 THEN PSET (17 + G, 18 + H), 9: PSET (17 + G, 17 + H), 9: PSET (18 + G, 17 + H), 9: PSET (23 + G, 18 + H), 9: PSET (23 + G, 17 + H), 9: PSET (22 + G, 17 + H), 9
IF CHOMP = 1 THEN LINE (8 + A, 16 + B)-(17 + A, 20 + B), 0
IF CHOMP = 1 THEN LINE (17 + A, 20 + B)-(8 + A, 23 + B), 0
IF CHOMP = 1 THEN PAINT (10 + A, 20 + B), 0
IF CHOMP = 1 AND PAC = 1 THEN LINE (10 + A, 16 + B)-(17 + A, 20 + B), 4
IF CHOMP = 1 AND PAC = 1 THEN LINE (17 + A, 20 + B)-(10 + A, 23 + B), 4
IF CHOMP = 0 THEN LINE (17 + A, 20 + B)-(8 + A, 20 + B), 0
IF CHOMP = 0 AND PAC = 1 THEN LINE (17 + A, 20 + B)-(10 + A, 20 + B), 4
SCREEN 7, 0, 0, 0: PCOPY 1, 0: SCREEN 7, 0, 1, 0
A$ = INKEY$
IF A$ = "0" THEN PAC = PAC + 1: IF PAC > 1 THEN PAC = 0
IF A = 0 AND B = 0 AND W1 = 0 THEN W1 = 1: PLAY "O1T255L8A": PP = 1: T = 0
IF A = 0 AND B = 160 AND W2 = 0 THEN W2 = 1: PLAY "O1T255L8A": PP = 1: T = 0
IF A = 280 AND B = 0 AND W3 = 0 THEN W3 = 1: PLAY "O1T255L8A": PP = 1: T = 0
IF A = 280 AND B = 160 AND W4 = 0 THEN W4 = 1: PLAY "O1T255L8A": PP = 1: T = 0
IF CHOMP = 0 THEN CHOMP = 1 ELSE IF CHOMP = 1 THEN CHOMP = 0
IF A = G AND B = H AND PP = 0 AND EATEN = 0 THEN PLAY "MF": FOR X = 100 TO 500 STEP 70: SOUND X, 1: NEXT: FOR X = 1 TO 500: NEXT
IF A = G AND B = H AND PP = 0 AND EATEN = 0 THEN FOR X = 200 TO 600 STEP 70: SOUND X, 1: NEXT: FOR X = 1 TO 500: NEXT
IF A = G AND B = H AND PP = 0 AND EATEN = 0 THEN FOR X = 700 TO 1100 STEP 70: SOUND X, 1: NEXT: FOR X = 1 TO 500: NEXT
IF A = G AND B = H AND PP = 0 AND EATEN = 0 THEN FOR X = 2000 TO 10000 STEP 300: SOUND X, 1: NEXT
IF A = G AND B = H AND PP = 0 AND EATEN = 0 THEN FOR X = 1 TO 500: NEXT: GOTO 5
IF A = G AND B = H AND PP = 1 AND EATEN = 0 THEN EATEN = 1: SOUND 10000, 1: SOUND 2000, 1
IF EATEN = 1 THEN YUM = YUM + 1: IF YUM > 40 THEN YUM = 0: EATEN = 0
IF PP = 1 THEN T = T + 1: IF T > 15 THEN T = 0: PP = 0
IF W1 = 1 AND W2 = 1 AND W3 = 1 AND W4 = 1 THEN GOTO 5
FOR X = 1 TO SPD: NEXT
DRAW GHOST$
DRAW "C0E5R10F5H5L10G5D10E5F5E5F5U10"
PSET (17 + G, 18 + H), 0
PSET (17 + G, 17 + H), 0
PSET (18 + G, 17 + H), 0
PSET (23 + G, 18 + H), 0
PSET (23 + G, 17 + H), 0
PSET (22 + G, 17 + H), 0
PAINT (20 + A, 20 + B), 0: PAINT (20 + A, 28 + B), 0: PAINT (12 + A, 23 + B), 0
IF PAC = 1 THEN MSPAC$ = "BM" + STR$(A + 30) + "," + STR$(B + 10): DRAW MSPAC$: DRAW "C0BL2BD2L2R2D2R2D2"
IF PP = 1 THEN PAINT (20 + A, 20 + B), 0
IF PP = 1 THEN PAINT (12 + A, 23 + B), 0
IF PP = 1 THEN PSET (13 + A, 22 + B), 0
CIRCLE (20 + A, 20 + B), 10, 0
IF A$ = "W" AND PLAYER = 1 THEN MV = 1
IF A$ = "Z" AND PLAYER = 1 THEN MV = 2
IF A$ = "A" AND PLAYER = 1 THEN MV = 3
IF A$ = "S" AND PLAYER = 1 THEN MV = 4
IF MV = 1 AND PLAYER = 1 THEN H = H - 40
IF MV = 2 AND PLAYER = 1 THEN H = H + 40
IF MV = 3 AND PLAYER = 1 THEN G = G - 40
IF MV = 4 AND PLAYER = 1 THEN G = G + 40
IF PLAYER = 0 THEN PLAYER = 0: IF B < H AND CHOMP = 1 AND BITE = 0 AND EATEN = 0 THEN H = H - 40 ELSE IF B > H AND CHOMP = 1 AND BITE = 0 AND EATEN = 0 THEN H = H + 40
IF PLAYER = 0 THEN PLAYER = 0: IF A < G AND CHOMP = 1 AND BITE = 1 AND EATEN = 0 THEN G = G - 40 ELSE IF A > G AND CHOMP = 1 AND BITE = 1 AND EATEN = 0 THEN G = G + 40
IF PLAYER = 0 THEN PLAYER = 0: IF H < 80 AND CHOMP = 1 AND BITE = 0 AND EATEN = 1 THEN H = H + 40 ELSE IF H > 80 AND CHOMP = 1 AND BITE = 0 AND EATEN = 1 THEN H = H - 40
IF PLAYER = 0 THEN PLAYER = 0: IF G < 140 AND CHOMP = 1 AND BITE = 1 AND EATEN = 1 THEN G = G + 40 ELSE IF G > 140 AND CHOMP = 1 AND BITE = 1 AND EATEN = 1 THEN G = G - 40
IF G < 0 THEN G = 0 ELSE IF G > 280 THEN G = 280
IF H < 0 THEN H = 0 ELSE IF H > 160 THEN H = 160
IF CHOMP = 1 AND BITE = 1 THEN BITE = 0 ELSE IF CHOMP = 1 AND BITE = 0 THEN BITE = 1
IF A$ = "8" THEN P = 1
IF A$ = "4" THEN P = 2
IF A$ = "2" THEN P = 3
IF A$ = "6" THEN P = 4
IF A = 140 AND B = -15 THEN A = 160: B = 160
IF A = 140 AND B = 175 THEN A = 120: B = 0
IF A$ = "8" AND A = 120 AND B = 0 OR A$ = "8" AND A = 160 AND B = 0 THEN A = 140: B = -15: P = 0
IF A$ = "2" AND A = 120 AND B = 160 OR A$ = "2" AND A = 160 AND B = 160 THEN A = 140: B = 175: P = 0
IF A = 0 AND B = 0 AND P = 3 THEN P = 0
IF A = 0 AND B = 40 AND P = 1 THEN P = 0
IF A = 280 AND B = 0 AND P = 3 THEN P = 0
IF A = 280 AND B = 40 AND P = 1 THEN P = 0
IF A = 40 AND B = 0 AND P = 3 THEN P = 0
IF A = 80 AND B = 0 AND P = 4 THEN P = 0
IF A = 120 AND B = 0 AND P = 2 THEN P = 0
IF A = 120 AND B = 80 AND P = 4 AND W5 = 0 THEN PLAY "O1T100L8G": W5 = 1
IF W5 = 1 THEN PAINT (160, 100), 0, 6: DRAW "BM160,100C0BD5BL5U10R10D10L10": W5 = 2
IF A = 160 AND B = 0 AND P = 4 THEN P = 0
IF A = 200 AND B = 0 AND P = 2 THEN P = 0
IF A = 240 AND B = 0 AND P = 3 THEN P = 0
IF A = 280 AND B = 160 AND P = 1 THEN P = 0
IF A = 280 AND B = 120 AND P = 3 THEN P = 0
IF A = 0 AND B = 120 AND P = 3 THEN P = 0
IF A = 0 AND B = 160 AND P = 1 THEN P = 0
IF A = 40 AND B = 40 AND P = 1 THEN P = 0
IF A = 40 AND B = 40 AND P = 3 THEN P = 0
IF A = 80 AND B = 40 AND P = 4 THEN P = 0
IF A = 80 AND B = 40 AND P = 3 THEN P = 0
IF A = 120 AND B = 40 AND P = 2 THEN P = 0
IF A = 120 AND B = 40 AND P = 4 THEN P = 0
IF A = 160 AND B = 40 AND P = 4 THEN P = 0
IF A = 160 AND B = 40 AND P = 2 THEN P = 0
IF A = 200 AND B = 40 AND P = 2 THEN P = 0
IF A = 200 AND B = 40 AND P = 3 THEN P = 0
IF A = 240 AND B = 40 AND P = 1 THEN P = 0
IF A = 240 AND B = 40 AND P = 3 THEN P = 0
IF A = 40 AND B = 80 AND P = 1 THEN P = 0
IF A = 40 AND B = 80 AND P = 3 THEN P = 0
IF A = 80 AND B = 80 AND P = 1 THEN P = 0
IF A = 80 AND B = 80 AND P = 3 THEN P = 0
IF A = 200 AND B = 80 AND P = 1 THEN P = 0
IF A = 200 AND B = 80 AND P = 3 THEN P = 0
IF A = 240 AND B = 80 AND P = 1 THEN P = 0
IF A = 240 AND B = 80 AND P = 3 THEN P = 0
IF A = 40 AND B = 120 AND P = 3 THEN P = 0
IF A = 40 AND B = 120 AND P = 1 THEN P = 0
IF A = 80 AND B = 120 AND P = 4 THEN P = 0
IF A = 80 AND B = 120 AND P = 1 THEN P = 0
IF A = 120 AND B = 120 AND P = 2 THEN P = 0
IF A = 120 AND B = 120 AND P = 4 THEN P = 0
IF A = 160 AND B = 120 AND P = 4 THEN P = 0
IF A = 160 AND B = 120 AND P = 2 THEN P = 0
IF A = 200 AND B = 120 AND P = 2 THEN P = 0
IF A = 200 AND B = 120 AND P = 1 THEN P = 0
IF A = 240 AND B = 120 AND P = 3 THEN P = 0
IF A = 240 AND B = 120 AND P = 1 THEN P = 0
IF A = 40 AND B = 160 AND P = 1 THEN P = 0
IF A = 80 AND B = 160 AND P = 4 THEN P = 0
IF A = 120 AND B = 160 AND P = 2 THEN P = 0
IF A = 160 AND B = 160 AND P = 4 THEN P = 0
IF A = 200 AND B = 160 AND P = 2 THEN P = 0
IF A = 240 AND B = 160 AND P = 1 THEN P = 0
IF P = 1 THEN B = B - 40: IF B < 0 THEN B = 0: P = 0
IF P = 2 THEN A = A - 40: IF A < 0 THEN A = 0: P = 0
IF P = 3 THEN B = B + 40: IF B > 160 THEN B = 160: P = 0
IF P = 4 THEN A = A + 40: IF A > 280 THEN A = 280: P = 0
GOTO 20

