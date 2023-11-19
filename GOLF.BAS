'This is a GAME of MINIATURE GOLF using VGA graphics     
'SCREEN 13 Mode. It is TWO PLAYER version and uses        
'The KEYPAD to determine the eight direction that the     
'Golf Ball travels. Use the SPACEBAR to confirm           
'selection. Use the LEFT/RIGHT arrow keys to select       
'amount of POWER used to Swing the golf club.             

DEFLNG A-Z: SCREEN 13: CLS : DIM TURF(30), BALL(30)
DIM BALL2(30), WET(30), WET2(30), H(2), SWG5(110)
DIM SWG4(110), SWG3(110), SWG2(110), SWG1(110)
DIM SWBL(110): HL = 1: GOTO COLORS

HOLE1:                                                  
    LOCATE 5, 5: PRINT CHR$(201); STRING$(29, 205); CHR$(187)
    LOCATE 10, 15: PRINT CHR$(201); STRING$(13, 205); CHR$(187)
    LOCATE 14, 15: PRINT CHR$(200); STRING$(9, 205); CHR$(187)
    LOCATE 20, 5: PRINT CHR$(200); STRING$(19, 205); CHR$(188)
    LOCATE 20, 29: PRINT CHR$(200); STRING$(5, 205); CHR$(188)
    FOR C = 11 TO 13: LOCATE C, 15: PRINT CHR$(186); : NEXT C
    FOR C = 15 TO 19: LOCATE C, 25: PRINT CHR$(186); : NEXT C
    FOR C = 11 TO 19: LOCATE C, 29: PRINT CHR$(186); : NEXT C
    FOR C = 6 TO 19: LOCATE C, 5: PRINT CHR$(186); : NEXT C
    FOR C = 6 TO 19: LOCATE C, 35: PRINT CHR$(186); : NEXT C
    PAINT (50, 50), 164, 30
ROUND2:                                                   
    BX = 180: BY = 120: CIRCLE (BX, BY), 3, 0: PAINT (BX, BY), 0, 0
    GET (247, 137)-(253, 143), TURF: CIRCLE (250, 140), 2, 32
    PAINT (250, 140), 32, 32: CIRCLE (250, 140), 3, 173, 3.64, .5
    GET (247, 137)-(253, 143), BALL2: CIRCLE (250, 140), 2, 30
    PAINT (250, 140), 30, 30: GET (247, 137)-(253, 143), BALL
    CIRCLE (250, 140), 2, 32: PAINT (250, 140), 32, 32
    GET (247, 137)-(253, 143), BALL2: PUT (247, 137), BALL, PSET
    LINE (58, 58)-(92, 92), 15, B: LINE (59, 59)-(91, 91), 15, B
    LINE (60, 60)-(90, 90), 15, B: PAINT (75, 75), 150, 15
    CIRCLE (75, 75), 2, 30: PAINT (75, 75), 30, 30
    GET (72, 72)-(78, 78), WET: PAINT (75, 75), 150, 150
    CIRCLE (75, 75), 2, 32: PAINT (75, 75), 32, 32
    GET (72, 72)-(78, 78), WET2: PAINT (75, 75), 150, 150
    D1$ = "C15BL2U4R2U12G2U4E2R4D16r2d4L8": FOR I = 1 TO 3
    DRAW "BM" + STR$(126 + I) + "," + STR$(30 - I) + D1$: NEXT I
    DRAW "BM126,30;C30;BL2U4r2U12G2U4E2r4d16r2d4L8"
    PAINT (128, 28), 30, 30: COLOR 150
    LOCATE 1, 22: PRINT "PARR:": LOCATE 3, 22: PRINT "STROKES (1):"
    LOCATE 4, 22: PRINT "STROKES (2):"
    COLOR 30: LOCATE 1, 27: PRINT "4";
    LINE (120, 78)-(224, 104), 0, BF
    GOTO TITLE
POND:                                                     
    FOR I = 121 TO 150: COLOR I: PAINT (75, 75), I, 15
    COLOR 122: LINE (61, 61)-(61, 89): LINE -(89, 89)
    COLOR 128: LINE (61, 61)-(89, 61): LINE -(89, 89)
    FOR T = 1 TO 2500: NEXT T: NEXT I
    LINE (34, 160)-(74, 196), 112, B: LINE (35, 161)-(73, 195), 112, B
    LINE (36, 162)-(72, 194), 112, B: PAINT (54, 178), 0, 112
    PSET (54, 178), 30: X = 247: X1 = 247: X2 = 247: Q = 0: Y = 137
    Y1 = 137: Y2 = 137: ST1 = 0: ST2 = 0: PLYR = 1: PARR = 4
DIRECTION:                                                
    IF PLYR = 1 THEN COLOR 164 ELSE COLOR 32
    LOCATE 11, 18: PRINT "PLAYER #" + RIGHT$(STR$(PLYR), 1);
    LOCATE 12, 17: PRINT "SELECT BALL";
    LOCATE 13, 17: PRINT " DIRECTION";
    WHILE D$ = "": D$ = INKEY$: WEND
NEWDIRECTION:                                             
    DRAW "BM54,174;C4;U10G2E2F2": DRAW "BM57, 175;E8L2R2D2"
    DRAW "BM58, 178;R12H2F2G2": DRAW "BM57, 181;F8U2D2L2"
    DRAW "BM54, 182;D10H2F2E2": DRAW "BM51, 181;G8U2D2R2"
    DRAW "BM50,178;L12E2G2F2": DRAW "BM51,175;H8D2U2R2;C32"
    IF D$ = CHR$(0) + CHR$(72) THEN DRAW "BM54,174;U10G2E2F2": AC = 8
    IF D$ = CHR$(0) + CHR$(73) THEN DRAW "BM57,175;E8L2R2D2": AC = 9
    IF D$ = CHR$(0) + CHR$(77) THEN DRAW "BM58,178;R12H2F2G2": AC = 6
    IF D$ = CHR$(0) + CHR$(81) THEN DRAW "BM57,181;F8U2D2L2": AC = 3
    IF D$ = CHR$(0) + CHR$(80) THEN DRAW "BM54,182;D10H2F2E2": AC = 2
    IF D$ = CHR$(0) + CHR$(79) THEN DRAW "BM51,181;G8U2D2R2": AC = 1
    IF D$ = CHR$(0) + CHR$(75) THEN DRAW "BM50,178;L12E2G2F2": AC = 4
    IF D$ = CHR$(0) + CHR$(71) THEN DRAW "BM51,175;H8D2U2R2": AC = 7
    SOUND 100, 2
    WHILE E$ = "": E$ = INKEY$: WEND
    IF E$ = CHR$(32) AND PLYR = 1 AND ST1 > 0 THEN GOTO PUTT
    IF E$ = CHR$(32) AND PLYR = 2 AND ST2 > 0 THEN GOTO PUTT
    IF E$ = CHR$(32) AND PLYR = 1 AND ST1 = 0 THEN GOTO DISTANCE
    IF E$ = CHR$(32) AND PLYR = 2 AND ST2 = 0 THEN GOTO DISTANCE
    IF AC = 1 THEN DRAW "BM51,181;C0;G8u2d2r2"
    IF AC = 2 THEN DRAW "BM54,182;C0;D10h2f2e2"
    IF AC = 3 THEN DRAW "BM57,181;C0;F8u2d2l2"
    IF AC = 4 THEN DRAW "BM50,178;C0;L12e2g2f2"
    IF AC = 6 THEN DRAW "BM58,178;C0;R12h2f2g2"
    IF AC = 7 THEN DRAW "BM51,175;C0;H8d2u2r2"
    IF AC = 8 THEN DRAW "BM54,174;C0;U10g2e2f2"
    IF AC = 9 THEN DRAW "BM57,175;C0;E8l2r2d2"
    D$ = E$: E$ = "": GOTO NEWDIRECTION:                     
DISTANCE:                                                 
    CIRCLE (92, 185), 13, 30: PAINT (92, 185), 30, 30
    FOR H = 84 TO 104 STEP 6: CIRCLE (H, 185), 2, 15, 4, .4: NEXT H
    FOR H = 87 TO 99 STEP 6: CIRCLE (H, 191), 2, 15, 4, .4: NEXT H
    FOR H = 93 TO 99 STEP 6: CIRCLE (H, 179), 2, 15, 4, .4: NEXT H
    CIRCLE (289, 185), 30, 30, , 6, .24: FOR SX = 313 TO 318
    LINE (SX, 10)-(SX, 190), 30: NEXT SX: PAINT (289, 185), 30, 30
    LINE (319, 183)-(319, 187), 0: FOR CL = 180 TO 188 STEP 4
    LINE (269, CL)-(309, CL + 2), 15, B: NEXT CL
    IF HL > 1 THEN GOTO PUTT
    RA$ = "C30;E9D3R11D12L11D3H9": FOR RA = 109 TO 239 STEP 32
    DRAW "BM" + STR$(RA) + ",187;" + RA$: NEXT RA
    FOR I = 112 TO 242 STEP 32: PAINT (I, 187), 172, 30: NEXT I
    AR$ = "C164;E9D3R11": FOR AR = 109 TO 239 STEP 32
    DRAW "BM" + STR$(AR) + ",187;" + AR$: NEXT AR
    FL$ = "C172;F9U3R11U12": FOR FL = 109 TO 239 STEP 32
    DRAW "BM" + STR$(FL) + ",187;" + FL$: NEXT FL
    N = 6: COLOR 30: FOR L = 16 TO 34 STEP 4: LOCATE 24, L
    N = N - 1: PRINT RIGHT$(STR$(N), 1); : NEXT L
    GET (109, 178)-(129, 197), SWG5: GET (141, 178)-(161, 197), SWG4
    GET (173, 178)-(193, 197), SWG3: GET (205, 178)-(225, 197), SWG2
    GET (237, 178)-(257, 197), SWG1: GET (0, 100)-(20, 119), SWBL
PUTT:                                                     
    LINE (120, 78)-(224, 104), 0, BF
    IF PLYR = 1 THEN COLOR 164 ELSE COLOR 32
    LOCATE 11, 18: PRINT "PLAYER #" + RIGHT$(STR$(PLYR), 1);
    LOCATE 12, 17: PRINT "SELECT YOUR";
    LOCATE 13, 17: PRINT "POWER SWING";
    H = 109: FOR I = 1 TO 4: PUT (H, 178), SWBL, PSET
    H = H + 32: NEXT I: P = 1: SPEED = 2000: TD = 15
    DO
        WHILE P$ = "": P$ = INKEY$: WEND
        IF P$ = CHR$(0) + CHR$(75) THEN P = P + 1
        IF P$ = CHR$(0) + CHR$(77) THEN P = P - 1
        IF P$ = CHR$(32) THEN EXIT DO
        IF P > 5 THEN P = 5
        IF P < 1 THEN P = 1
        ON P GOTO P1, P2, P3, P4, P5
P1:                                                       
        PUT (237, 178), SWG1, PSET: PUT (205, 178), SWBL, PSET
        SPEED = 2000: TD = 15: GOTO MORE
P2:                                                       
        PUT (205, 178), SWG2, PSET: PUT (173, 178), SWBL, PSET
        SPEED = 1500: TD = 60: GOTO MORE
P3:                                                       
        PUT (173, 178), SWG3, PSET: PUT (141, 178), SWBL, PSET
        SPEED = 1000: TD = 110: GOTO MORE
P4:                                                       
        PUT (141, 178), SWG4, PSET: PUT (109, 178), SWBL, PSET
        SPEED = 500: TD = 155: GOTO MORE
P5:                                                       
        PUT (109, 178), SWG5, PSET: SPEED = 100: TD = 200
MORE:                                                     
        P$ = "": COLOR 30
    LOOP
NEWS:                                                     
    LINE (120, 78)-(224, 104), 0, BF
    IF PLYR = 1 THEN ST1 = ST1 + 1: LOCATE 3, 34: PRINT RIGHT$(STR$(ST1), 2)
    IF PLYR = 2 THEN ST2 = ST2 + 1: LOCATE 4, 34: PRINT RIGHT$(STR$(ST2), 2)
    IF AC = 1 THEN GOTO SOUTHWEST:                           
    IF AC = 2 THEN GOTO SOUTH:                               
    IF AC = 3 THEN GOTO SOUTHEAST:                           
    IF AC = 4 THEN GOTO WEST:                                
    IF AC = 6 THEN GOTO EAST:                                
    IF AC = 7 THEN GOTO NORTHWEST:                           
    IF AC = 8 THEN GOTO NORTH:                               
    IF AC = 9 THEN GOTO NORTHEAST:                           
NEXTSTROKE:                                               
    IF PLYR = 1 THEN X1 = X: Y1 = Y
    IF PLYR = 2 THEN X2 = X: Y2 = Y
    FOR I = 1 TO 30
    LINE (36 + I, 162 + I)-(72 - I, 194 - I), 0, B: NEXT I
    PAINT (54, 178), 0, 112: PSET (54, 178), 30
    AC = 0: HF = 0: D$ = "": E$ = "": P$ = ""
    PLYR = PLYR + 1: IF PLYR = 3 THEN PLYR = 1
    'Determine if Either Player has already Made Hole        
    IF H(1) = 10 AND H(2) = 10 THEN GOTO NEWGAME
    IF PLYR = 1 AND H(1) = 10 THEN PLYR = 2
    IF PLYR = 2 AND H(2) = 10 THEN PLYR = 1
    ON PLYR GOTO L1, L2
L1:                                                       
    X = X1: Y = Y1: CIRCLE (92, 185), 13, 30
    PAINT (92, 185), 30, 30: FOR H = 84 TO 104 STEP 6
    CIRCLE (H, 185), 2, 15, 4, .4: NEXT H
    FOR H = 87 TO 99 STEP 6: CIRCLE (H, 191), 2, 15, 4, .4
    NEXT H: FOR H = 93 TO 99 STEP 6: CIRCLE (H, 179), 2, 15, 4, .4
    NEXT H: GOTO L3
L2:                                                       
    X = X2: Y = Y2: CIRCLE (92, 185), 13, 32
    PAINT (92, 185), 32, 32: FOR H = 84 TO 104 STEP 6
    CIRCLE (H, 185), 2, 15, 4, .4: NEXT H
    FOR H = 87 TO 99 STEP 6: CIRCLE (H, 191), 2, 15, 4, .4: NEXT H
    FOR H = 93 TO 99 STEP 6: CIRCLE (H, 179), 2, 15, 4, .4: NEXT H
L3:                                                       
    IF PLYR = 1 THEN GOTO DIRECTION
    IF HL = 1 AND X = 247 AND Y = 137 THEN PUT (X, Y), BALL2, PSET
    IF HL = 2 AND X = 192 AND Y = 139 THEN PUT (X, Y), BALL2, PSET
    GOTO DIRECTION
BIRDIE:                                                   
    PUT (X, Y), TURF, PSET: SPEED = 20000
    TX = X + 3: TY = Y + 3
    IF PLYR = 1 THEN C = 30
    IF PLYR = 2 THEN C = 32
XAXIS:                                                    
    IF TX < BX THEN TX = TX + 1
    IF TX > BX THEN TX = TX - 1
YAXIS:                                                    
    IF TY > BY THEN TY = TY - 1
    IF TY < BY THEN TY = TY + 1
    IF TX = BX AND TY = BY THEN GOTO HIO
    CIRCLE (TX, TY), 2, C: PAINT (TX, TY), C, C
    CIRCLE (TX, TY), 3, C + 1: PAINT (TX, TY), 164, C + 1
    CIRCLE (TX, TY), 3, 164: GOTO XAXIS
HIO:                                                      
    CIRCLE (BX, BY), 3, 0: FOR T = 1 TO SPEED: NEXT T
    ON PLYR GOTO A1, A2
A1:                                                       
    CIRCLE (BX, BY), 2, 30: PAINT (BX, BY), 30, 30
    FOR T = 1 TO SPEED: NEXT T
    H(1) = 10: X = 0: Y = 0: GOTO MORE2
A2:                                                       
    CIRCLE (BX, BY), 2, 32: PAINT (BX, BY), 32, 32
    FOR T = 1 TO SPEED: NEXT T: H(2) = 10: X = 0: Y = 0
MORE2:                                                    
    CIRCLE (180, 120), 3, 0: PAINT (180, 120), 0, 0
    PLAY "L8CEFGP16L8EL4G"
    IF PLYR = 1 AND ST1 = PARR THEN COLOR 121: GOTO MESSAGE
    IF PLYR = 2 AND ST2 = PARR THEN COLOR 164: GOTO MESSAGE
    GOTO NEXTSTROKE
MESSAGE:                                                  
    LOCATE 11, 18: PRINT "PLAYER #" + STR$(PLYR);
    LOCATE 12, 18: PRINT "MADE PARR!";
    LOCATE 13, 17: PRINT "-VERY GOOD-";
    SLEEP 5
    LINE (120, 78)-(224, 104), 0, BF
    GOTO NEXTSTROKE
WEST:                                                     
    DO
        PUT (X, Y), TURF, PSET: X = X - 1
        ON PLYR GOTO Y1, Y2
Y1:                                                       
        PUT (X, Y), BALL, PSET: ST = Y2 - 7: ED = Y2 + 6
        Q = Y: IF X = X2 + 7 THEN GOTO WEST1
        GOTO WEST2
Y2:                                                       
        PUT (X, Y), BALL2, PSET: ST = Y1 - 7: ED = Y1 + 6
        Q = Y: IF X = X1 + 7 THEN GOTO WEST1
WEST2:                                                    
        NW = POINT(X - 1, Y - 1): SW = POINT(X - 1, Y + 7)
        SPEED = SPEED + 10: FOR T = 1 TO SPEED: NEXT T
        IF NW = 30 AND SW <> 30 THEN SOUND 200, 1: GOTO SOUTH
        IF SW = 30 AND NW <> 30 THEN SOUND 200, 1: GOTO NORTH
        IF NW = 30 OR SW = 30 THEN SOUND 200, 1: EXIT DO
        IF SW = 30 AND NW <> 30 THEN SOUND 200, 1: GOTO NORTH
        IF NW = 15 OR SW = 15 THEN GOTO SPLASH
        IF NW = 0 OR SW = 0 THEN GOTO BIRDIE
        IF Q = -99 THEN SOUND 200, 1: SOUND 100, 1: EXIT DO
        HF = HF + 1: IF HF = TD THEN GOTO NEXTSTROKE
    LOOP
EAST:                                                     
    DO
        PUT (X, Y), TURF, PSET: X = X + 1
        ON PLYR GOTO B1, B2
B1:                                                       
        PUT (X, Y), BALL, PSET: ST = Y2 - 7: ED = Y2 + 6: Q = Y
        IF X = X2 - 7 THEN GOTO EAST1
        GOTO EAST2
B2:                                                       
        PUT (X, Y), BALL2, PSET: ST = Y1 - 7: ED = Y1 + 6
        Q = Y: IF X = X1 - 7 THEN GOTO EAST1
EAST2:                                                    
        NE = POINT(X + 7, Y - 1): SE = POINT(X + 7, Y + 7): EAST = POINT(X + 7, Y + 3)
        SPEED = SPEED + 10: FOR T = 1 TO SPEED: NEXT T
        IF NE = 30 OR SE = 30 THEN SOUND 200, 1: SOUND 100, 1: EXIT DO
        IF NE = 15 OR SE = 15 THEN GOTO SPLASH
        IF NE = 0 OR SE = 0 OR EAST = 0 THEN GOTO BIRDIE
        IF Q = -99 THEN SOUND 200, 1: SOUND 100, 1: EXIT DO
        HF = HF + 1: IF HF = TD THEN GOTO NEXTSTROKE
    LOOP
GOTO WEST:                                                
NORTH:                                                    
    DO
        PUT (X, Y), TURF, PSET: Y = Y - 1
        ON PLYR GOTO C1, C2
C1:                                                       
        PUT (X, Y), BALL, PSET: ST = X2 - 7: ED = X2 + 6
        Q = X: IF Y = Y2 + 7 THEN GOTO NORTH1
        GOTO NORTH2
C2:                                                       
        PUT (X, Y), BALL2, PSET: ST = X1 - 7: ED = X1 + 6
        Q = X: IF Y = Y1 + 7 THEN GOTO NORTH1
NORTH2:                                                   
        NW = POINT(X - 1, Y - 1): NE = POINT(X + 7, Y - 1)
        SPEED = SPEED + 10: FOR T = 1 TO SPEED: NEXT T
        IF NW = 30 AND NE = 30 THEN SOUND 200, 1: SOUND 100, 1: EXIT DO
        IF NW = 30 AND NE <> 30 THEN SOUND 200, 1: SOUND 100, 1: GOTO EAST
        IF NW = 15 OR NE = 15 THEN GOTO SPLASH:                  
        IF NW = 0 OR NE = 0 THEN GOTO BIRDIE:                    
        IF Q = -99 THEN SOUND 200, 1: SOUND 100, 1: EXIT DO
        HF = HF + 1: IF HF = TD THEN GOTO NEXTSTROKE:            
    LOOP
SOUTH:                                                
    DO
        PUT (X, Y), TURF, PSET: Y = Y + 1
        ON PLYR GOTO D1, D2
D1:                                                       
        PUT (X, Y), BALL, PSET: ST = X2 - 7: ED = X2 + 6
        Q = X: IF Y = Y2 - 7 THEN GOTO SOUTH1
        GOTO SOUTH2
D2:                                                       
        PUT (X, Y), BALL2, PSET: ST = X1 - 7: ED = X1 + 6
        Q = X: IF Y = Y1 - 7 THEN GOTO SOUTH1
SOUTH2:                                                   
        SW = POINT(X - 1, Y + 7): SE = POINT(X + 7, Y + 7)
        SPEED = SPEED + 10: FOR T = 1 TO SPEED: NEXT T
        IF SW = 30 OR SE = 30 THEN SOUND 200, 1: SOUND 100, 1: EXIT DO
        IF SW = 15 OR SE = 15 THEN GOTO SPLASH:                  
        IF SW = 0 OR SE = 0 THEN GOTO BIRDIE:                    
        IF Q = -99 THEN SOUND 200, 1: SOUND 100, 1: EXIT DO
        HF = HF + 1: IF HF = TD THEN GOTO NEXTSTROKE:            
    LOOP
GOTO NORTH:                                               
NORTHEAST:                                                
    DO
        PUT (X, Y), TURF, PSET: X = X + 1: Y = Y - 1
        ON PLYR GOTO E1, E2
E1:                                                      
        PUT (X, Y), BALL, PSET: : ST = X2 - 7: ED = X2 + 6
        Q = X: IF Y = Y2 + 7 THEN GOTO NE1
        ST = Y2 - 7: ED = Y2 + 6
        Q = Y: IF X = X2 - 7 THEN GOTO NE3
        GOTO NE2
E2:                                                       
        PUT (X, Y), BALL2, PSET: ST = X1 - 7: ED = X1 + 6
        Q = X: IF Y = Y1 + 7 THEN GOTO NE1
        ST = Y1 - 7: ED = Y1 + 6
        Q = Y: IF X = X1 - 7 THEN GOTO NE3
NE2:                                                     
        NE = POINT(X + 7, Y - 1): SE = POINT(X + 7, Y + 7): NW = POINT(X - 1, Y - 1)
        SPEED = SPEED + 10: FOR T = 1 TO SPEED: NEXT T
        IF NE = 30 AND SE <> 30 THEN SOUND 200, 1: GOTO SOUTHEAST
        IF NE = 15 OR SE = 15 THEN GOTO SPLASH
        IF NE = 30 AND SE = 30 THEN SOUND 200, 1: GOTO NORTHWEST
        IF NE = 0 OR SE = 0 OR NW = 0 THEN GOTO BIRDIE
        IF Q = -99 THEN SOUND 200, 1: SOUND 100, 1: GOTO SOUTHWEST
        HF = HF + 1: IF HF = TD THEN GOTO NEXTSTROKE:            
    LOOP
GOTO SOUTHWEST:                                           
NORTHWEST:                                                
    DO
        PUT (X, Y), TURF, PSET: X = X - 1: Y = Y - 1
        ON PLYR GOTO F1, F2
F1:                                                       
        PUT (X, Y), BALL, PSET: ST = X2 - 7: ED = X2 + 6
        Q = X: IF Y = Y2 + 7 THEN GOTO NW1
        ST = Y2 - 7: ED = Y2 + 6: Q = Y: IF X = X2 + 7 THEN GOTO NW3
        GOTO NW2
F2:                                                       
        PUT (X, Y), BALL2, PSET: ST = X1 - 7: ED = X1 + 6
        Q = X: IF Y = Y1 + 7 THEN GOTO NW1
        ST = Y1 - 7: ED = Y1 + 6: Q = Y: IF X = X1 + 7 THEN GOTO NW3
NW2:                                                      
        NW = POINT(X - 1, Y - 1): SW = POINT(X - 1, Y + 7)
        SPEED = SPEED + 10: FOR T = 1 TO SPEED: NEXT T
        IF Q = -99 THEN SOUND 200, 1: SOUND 100, 1: GOTO SOUTHEAST
        IF NW = 30 AND SW <> 30 THEN SOUND 200, 1: GOTO SOUTHWEST
        IF NW = 30 AND SW = 30 THEN SOUND 200, 1: GOTO NORTHEAST
        IF SW = 30 AND NW <> 30 THEN SOUND 200, 1: GOTO NORTHEAST
        IF NW = 15 OR SW = 15 THEN GOTO SPLASH:                  
        IF NW = 0 AND POINT(X - 2, Y - 1) = 0 THEN GOTO BIRDIE
        IF SW = 0 AND POINT(X - 2, Y - 1) = 0 THEN GOTO BIRDIE
        HF = HF + 1: IF HF = TD THEN GOTO NEXTSTROKE
    LOOP
GOTO SOUTHEAST:                                           
SOUTHWEST:                                                
    DO
        PUT (X, Y), TURF, PSET: X = X - 1: Y = Y + 1
        ON PLYR GOTO G1, G2
G1:                                                      
        PUT (X, Y), BALL, PSET: ST = X2 - 7: ED = X2 + 6: Q = X
        IF Y = Y2 - 7 THEN GOTO SW1
        ST = Y2 - 7: ED = Y2 + 6: Q = Y: IF X = X2 + 7 THEN GOTO SW3
        GOTO SW2
G2:                                                      
        PUT (X, Y), BALL2, PSET: ST = X1 - 7: ED = X1 + 6: Q = X
        IF Y = Y1 - 7 THEN GOTO SW1
        ST = Y1 - 7: ED = Y1 + 6: Q = Y: IF X = X1 + 7 THEN GOTO SW3
SW2:                                                     
        NW = POINT(X - 1, Y - 1): SW = POINT(X - 1, Y + 7): SE = POINT(X + 7, Y + 7)
        SPEED = SPEED + 10: FOR T = 1 TO SPEED: NEXT T
        IF NW = 30 AND SW = 30 THEN SOUND 200, 1: GOTO SOUTHEAST
        IF NW <> 30 AND SW = 30 THEN SOUND 200, 1: GOTO NORTHWEST
        IF SE = 30 THEN SOUND 200, 1: SOUND 100, 1: GOTO NORTHWEST
        IF SW = 30 AND NW <> 30 AND SE <> 30 THEN GOTO SOUTHEAST
        IF NW = 15 OR SW = 15 THEN GOTO SPLASH
        IF NW = 0 OR SW = 0 OR SE = 0 THEN GOTO BIRDIE
        IF Q = -99 THEN SOUND 200, 1: SOUND 100, 1: GOTO NORTHEAST
        HF = HF + 1: IF HF = TD THEN GOTO NEXTSTROKE
    LOOP
    GOTO NORTHEAST
SOUTHEAST:                                                
    DO
        PUT (X, Y), TURF, PSET: X = X + 1: Y = Y + 1
        ON PLYR GOTO H1, H2
H1:                                                      
        PUT (X, Y), BALL, PSET: ST = X2 - 7: ED = X2 + 6: Q = X
        IF Y = Y2 - 7 THEN GOTO SE1
        ST = Y2 - 7: ED = Y2 + 6: Q = Y: IF X = X2 - 7 THEN GOTO SE3
        GOTO SE2
H2:                                                       
        PUT (X, Y), BALL2, PSET: ST = X1 - 7: ED = X1 + 6: Q = X
        IF Y = Y1 - 7 THEN GOTO SE1
        ST = Y1 - 7: ED = Y1 + 6: Q = Y: IF X = X1 - 7 THEN GOTO SE3
SE2:                                                     
        NE = POINT(X + 7, Y - 1): SE = POINT(X + 7, Y + 7): NW = POINT(X - 1, Y - 1)
        SPEED = SPEED + 10: FOR T = 1 TO SPEED: NEXT T
        IF NE = 30 AND SE = 30 THEN SOUND 200, 1: GOTO SOUTHWEST
        IF NE <> 30 AND SE = 30 THEN SOUND 200, 1: GOTO NORTHEAST
        IF NE = 15 OR SE = 15 THEN GOTO SPLASH
        IF NE = 0 OR SE = 0 OR NW = 0 THEN GOTO BIRDIE
        IF Q = -99 THEN SOUND 200, 1: SOUND 100, 1: GOTO NORTHWEST
        HF = HF + 1: IF HF = TD THEN GOTO NEXTSTROKE
    LOOP
    GOTO NORTHWEST
NEWGAME:                                                  
    COLOR 57: LOCATE 11, 17: PRINT "    PLAY"
    LOCATE 12, 17: PRINT "  ANOTHER";
    LOCATE 13, 17: PRINT "GAME? [Y/N]";
    WHILE D$ = "": D$ = INKEY$: WEND
    LINE (120, 78)-(224, 104), 0, BF
    IF D$ = "Y" OR D$ = "y" THEN RUN
    IF D$ = "N" OR D$ = "n" THEN END: CLS
    GOTO NEWGAME
SPLASH:                                                  
    SPEED = 10000
    PUT (X, Y), TURF, PSET
    IF PLYR = 1 THEN PUT (72, 72), WET, PSET
    IF PLYR = 2 THEN PUT (72, 72), WET2, PSET
    FOR T = 1 TO SPEED: NEXT T
    CIRCLE (75, 75), 2, 150: CIRCLE (75, 75), 4, 133
    FOR T = 1 TO SPEED: NEXT T
    PAINT (75, 75), 150, 133: PSET (75, 75), 133
    FOR T = 1 TO SPEED: NEXT T: CIRCLE (75, 75), 8, 133
    FOR T = 1 TO SPEED: NEXT T: PSET (75, 75), 150
    FOR T = 1 TO SPEED: NEXT T: CIRCLE (75, 75), 4, 150
    FOR T = 1 TO SPEED: NEXT T: CIRCLE (75, 75), 8, 150
    IF PLYR = 1 THEN PUT (X, Y), BALL, PSET: SOUND 100, 1: SOUND 200, 1
    IF PLYR = 2 THEN PUT (X, Y), BALL2, PSET: SOUND 100, 1: SOUND 200, 1
    GOTO NEXTSTROKE
NORTH1:                                                   
    FOR RANGE = ST TO ED
    IF Q = RANGE THEN Q = -99: GOTO NORTH2
    NEXT RANGE
    Q = 0: GOTO NORTH2
SOUTH1:                                               
    FOR RANGE = ST TO ED
    IF Q = RANGE THEN Q = -99: GOTO SOUTH2
    NEXT RANGE
    Q = 0: GOTO SOUTH2
WEST1:                                                   
    FOR RANGE = ST TO ED
    IF Q = RANGE THEN Q = -99: GOTO WEST2
    NEXT RANGE
    Q = 0: GOTO WEST2
EAST1:                                                   
    FOR RANGE = ST TO ED
    IF Q = RANGE THEN Q = -99: GOTO EAST2
    NEXT RANGE
    Q = 0: GOTO EAST2
NE1:                                                         
    FOR RANGE = ST TO ED
    IF Q = RANGE THEN Q = -99: GOTO NE2
    NEXT RANGE
    Q = 0: GOTO NE2
NE3:                                                     
    FOR RANGE = ST TO ED
    IF Q = RANGE THEN Q = -99: GOTO NE2
    NEXT RANGE
    Q = 0: GOTO NE2
NW1:                                                     
    FOR RANGE = ST TO ED
    IF Q = RANGE THEN Q = -99: GOTO NW2
    NEXT RANGE
    Q = 0: GOTO NW2
NW3:                                                     
    FOR RANGE = ST TO ED
    IF Q = RANGE THEN Q = -99: GOTO NW2
    NEXT RANGE
    Q = 0: GOTO NW2
SW1:                                                     
    FOR RANGE = ST TO ED
    IF Q = RANGE THEN Q = -99: GOTO SW2
    NEXT RANGE: Q = 0: GOTO SW2
SW3:                                                     
    FOR RANGE = ST TO ED
    IF Q = RANGE THEN Q = -99: GOTO SW2
    NEXT RANGE: Q = 0: GOTO SW2
SE1:                                                     
    FOR RANGE = ST TO ED
    IF Q = RANGE THEN Q = -99: GOTO SE2
    NEXT RANGE: Q = 0: GOTO SE2
SE3:                                                      
    FOR RANGE = ST TO ED
    IF Q = RANGE THEN Q = -99: GOTO SE2
    NEXT RANGE: Q = 0: GOTO SE2
TITLE:                                                   
    H$ = "U20R4D8R8U8R4D20L4U8L8D8L4"
    O$ = "U20R16D20L16BR4BU4U12R8D12L8"
    L$ = "U20R4D16R12D4L16": E$ = "U20R16D4L12D4R8d4l8d4r12d4l16"
    FOR I = 1 TO 3
    DRAW "BM" + STR$(10 + I) + "," + STR$(30 - I) + ";C15" + H$: NEXT I
    DRAW "BM10,30;C30" + H$: PAINT (18, 20), 30, 30
    FOR I = 1 TO 3
    DRAW "BM" + STR$(36 + I) + "," + STR$(30 - I) + "C15" + O$: NEXT I
    DRAW "BM36,30;C30" + O$: PAINT (38, 12), 30, 30
    FOR I = 1 TO 3
    DRAW "BM" + STR$(62 + I) + "," + STR$(30 - I) + "C15" + L$: NEXT I
    DRAW "BM62,30;C30" + L$: PAINT (64, 28), 30, 30
    FOR I = 1 TO 3
    DRAW "BM" + STR$(88 + I) + "," + STR$(30 - I) + "C15" + E$: NEXT I
    DRAW "BM88,30;C30" + E$: PAINT (90, 28), 30, 30
    GOTO POND
COLORS:                                                  
    PALETTE 4, (7 * (256 ^ 2)) + (7 * 256) + 7
    PALETTE 15, (29 * (256 ^ 2)) + (29 * 256) + 29
    PALETTE 30, (59 * (256 ^ 2)) + (59 * 256) + 59
    PALETTE 32, (58 * 256) + 63: PALETTE 57, (12 * 256) + 60
    PALETTE 112, (55 * (256 ^ 2)) + 55
    PALETTE 121, (60 * (256 ^ 2)) + (35 * 256)
    PALETTE 122, (57 * (256 ^ 2)) + (32 * 256)
    PALETTE 123, (54 * (256 ^ 2)) + (30 * 256)
    PALETTE 124, (51 * (256 ^ 2)) + (27 * 256)
    PALETTE 125, (48 * (256 ^ 2)) + (25 * 256)
    PALETTE 126, (45 * (256 ^ 2)) + (23 * 256)
    PALETTE 127, (42 * (256 ^ 2)) + (20 * 256)
    PALETTE 128, (20 * (256 ^ 2)): PALETTE 129, (22 * (256 ^ 2))
    PALETTE 130, (24 * (256 ^ 2)): PALETTE 131, (26 * (256 ^ 2))
    PALETTE 132, (28 * (256 ^ 2)): PALETTE 133, (30 * (256 ^ 2))
    PALETTE 134, (32 * (256 ^ 2)): PALETTE 135, (34 * (256 ^ 2))
    PALETTE 136, (36 * (256 ^ 2)): PALETTE 137, (38 * (256 ^ 2))
    PALETTE 138, (40 * (256 ^ 2)): PALETTE 139, (42 * (256 ^ 2))
    PALETTE 140, (44 * (256 ^ 2)): PALETTE 141, (46 * (256 ^ 2))
    PALETTE 142, (48 * (256 ^ 2)): PALETTE 143, (50 * (256 ^ 2))
    PALETTE 144, (51 * (256 ^ 2)): PALETTE 145, (52 * (256 ^ 2))
    PALETTE 146, (54 * (256 ^ 2)): PALETTE 147, (56 * (256 ^ 2))
    PALETTE 148, (58 * (256 ^ 2)): PALETTE 149, (60 * (256 ^ 2))
    PALETTE 150, (63 * (256 ^ 2)): PALETTE 164, (42 * 256)
    PALETTE 172, (23 * 256): PALETTE 173, (20 * 256)
    COLOR 30: GOTO HOLE1
                                             ' ~DAVE~    

