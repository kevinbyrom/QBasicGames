'Woodchip Software's Chipper Gun v3.0
'
'    By      Michael "Woodchip" Woodburn          
'                   (owensub by)OWEN B.
'
'
        DECLARE SUB hit ()
        DECLARE SUB alock ()
        DECLARE SUB plaugame ()
        DECLARE SUB number1 ()
        DECLARE SUB intro ()
        DECLARE SUB gameover ()
        DECLARE SUB owensub ()
       
        COMMON SHARED x
        COMMON SHARED y
        COMMON SHARED points
        COMMON SHARED level
        COMMON SHARED ab$
       
        TYPE HighScore
                winner AS STRING * 20
                score AS SINGLE
                qote AS STRING * 40
        END TYPE
        DIM SHARED top10 AS HighScore
        DIM SHARED last AS HighScore
        DIM SHARED setback AS HighScore
        DIM SHARED aimer(10000)
        DIM SHARED PLANE(10000)

        CONST true = -1
        CONST false = 0
CLS
'Set up
SHELL "C:"
SHELL "CD\PROG"
level = 5
ab$ = "OFF"
intro
plaugame

SUB alock
                   PLAY "t255 l16 cg"          '{ADD FOR A LOCK SOUND}
                   COLOR 4
                   LOCATE 1, 60
                   PRINT "LOCK"
                   COLOR 15
END SUB

SUB gameover
COLOR 5
PRINT , , "G A M E   O V E R"
LOCATE 2, 1
LOCATE 3, 1
PRINT , , points; " points"; ", In level"; level
PRINT , "A plane just boomed the forest."
END SUB

SUB hit
                LINE (0, 0)-(x + 50, y + 50), 4
                FOR P = 1 TO 100: NEXT
                        LINE (0, 0)-(x + 50, y + 50), 0
                FOR z = 1 TO 50
                        RANDOMIZE TIMER
                        c = INT(RND * 14) + 1
                        CIRCLE (x + 50, y + 50), z, c
                NEXT
                FOR z = 1 TO 50 STEP 4
                        CIRCLE (x + 50, y + 50), z, 0
                NEXT
                FOR z = 1 TO 50 STEP 3
                        CIRCLE (x + 50, y + 50), z, 0
                NEXT
                FOR z = 1 TO 50 STEP 2
                        CIRCLE (x + 50, y + 50), z, 0
                FOR z = 0 TO 50
                        CIRCLE (x + 50, y + 50), z, 0
                NEXT
                NEXT
                PUT (x, y), aimer
                        PLAY "t225 l4dl1c"
                CLS
END SUB

SUB intro
CLS
SCREEN 7
WIDTH 80
PRINT "Woodchip's Chipper Gun  (v1.0)"
scale$ = "l8a<cc>a<cdp3a<cc>"
m$ = "A<EFCGFEE>ACl3"
PLAY "x" + VARPTR$(scale$)
PLAY "X" + VARPTR$(m$)


OPEN "maim.t10" FOR RANDOM AS #1 LEN = LEN(top10)
CLS
SCREEN 8
COLOR 9
LOCATE 1, 1
PRINT "Winner"
LOCATE 1, 23
PRINT "Score"
LOCATE 1, 40
PRINT "Qote"

COLOR 4
FOR i = 1 TO 10
GET #1, i, top10
LOCATE i + 2, 1
PRINT top10.winner
LOCATE i + 2, 23
PRINT top10.score
LOCATE i + 2, 40
PRINT top10.qote
NEXT
CLOSE
PRINT
PRINT
PRINT "Press any key"
DO WHILE INKEY$ = ""
LOOP
END SUB

SUB number1
CLS
OPEN "maim.t10" FOR RANDOM AS #1 LEN = LEN(top10)


FOR i = 9 TO 1 STEP -1
GET #1, i + 1, last
GET #1, i, top10
IF top10.score >= points AND last.score < points THEN
        last.score = points
        INPUT "Good job you got a top score"; last.winner
        INPUT "Input a qute"; last.qote
        FOR a = i + 1 TO 10
                GET #1, a, setback
                PUT #1, a, last
                last = setback
        NEXT
        EXIT FOR
END IF
NEXT

GET #1, 1, top10
IF top10.score < points THEN
        top10.score = points
        INPUT "Good job you got a All Time Top Score"; top10.winner
        INPUT "Input a qote"; top10.qote
        last = top10
        FOR a = 1 TO 10
                GET #1, a, setback
                PUT #1, a, last
                last = setback
        NEXT
END IF
CLS
SCREEN 8
COLOR 9
LOCATE 1, 1
PRINT "Winner"
LOCATE 1, 23
PRINT "Score"
LOCATE 1, 40
PRINT "Qote"

COLOR 4
FOR i = 1 TO 10
GET #1, i, top10
LOCATE i + 2, 1
PRINT top10.winner
LOCATE i + 2, 23
PRINT top10.score
LOCATE i + 2, 40
PRINT top10.qote
NEXT
CLOSE
END SUB

SUB owensub
PRINT "Good Job You Have completed the bouns stage.  You gain xxx points."
PRINT "Press any key to con't"
number1
END SUB

SUB plaugame
begin:

boom = 2
SCREEN 9
WINDOW (500, 500)-(0, 0)
                        DRAW "bm70,70 c7 r5 d1 l5 d1 r5 d1 l5 d1 r6 d1 l6 d1 r6 r30 D1 R5 D1 C1 L5 C7 D1"
                        DRAW "R5 D1 R1 D1 R1 D1 L1 D1 L1 l15 g10 l1 g2 l2  l3 u5 e7 l10 h6 r1"
                        PAINT (60, 385), 7, 7
                        FOR i = 20 TO 40 STEP 4
                        PSET (i, 8), 1
                        NEXT
GET (50, 410)-(90, 360), PLANE
CLS
DRAW "bm250,250"
PSET (250, 250), 4
DRAW "c4 bu 10 l10 d 20 r 20 u 20 l10 u10 bd30 d10 be20 l10 bl20 l10"
GET (200, 200)-(300, 300), aimer
x = 200
y = 200

t1 = TIMER
'Game
DO
        px = INT(RND * 300) + 90
        px1 = INT(RND * 300) + 90
gs = 7

pl = 60
DO
pl = pl + gs
pl1 = pl1 + gs + 1
                  
          IF y > px - 50 AND y < px THEN
          IF x > pl - 50 AND x < pl THEN
                   CALL alock
                   ls = true
          END IF
          END IF
          IF y > px1 - 50 AND y < px1 THEN
          IF x > pl1 - 50 AND x < pl1 THEN
                   CALL alock
                   ls = true
          END IF
          END IF

          IF ls = false THEN
                   LOCATE 1, 60
                   PRINT "    "
          END IF
          ls = false
       
        IF pl >= 310 OR pl1 >= 310 THEN
                gameover
                number1
                END
        END IF
        COLOR 2, 8
        LOCATE 1, 1
                PRINT "POINTS:  "; points
        COLOR 3, 8
       
        LOCATE 1, 20
                PRINT "LEVEL:   "; level
        COLOR 4, 8
        LOCATE 2, 20
                PRINT "PLANES:  "; planesd
        COLOR 5, 8
        LOCATE 3, 1
                PRINT STRING$(80, "ß")
        LOCATE 1, 40
        COLOR 6, 8
                PRINT "WOOODCHIP: "; boom
        LOCATE 2, 40
                PRINT "                 "
        COLOR 7, 8
        LOCATE 2, 40
                PRINT "AUTO:       "; ab$
        RANDOMIZE TIMER
        LINE (pl, px)-(pl + 55 + gs, px + 55 + gs), 0, BF
        PUT (pl, px), PLANE
        LINE (pl1, px1)-(pl1 + 55 + gs, px1 + 50 + gs), 0, BF
        PUT (pl1, px1), PLANE
        PUT (x, y), aimer
IF ab$ = "ON" THEN abb = true
SELECT CASE INKEY$
        CASE "h", "H"
                x = x + 30
                IF x >= 350 THEN x = 350
                LINE (x - 75, y - 75)-(x + 100, y + 100), 0, BF
                PUT (x, y), aimer
        CASE "f", "F"
                x = x - 30
                IF x <= 5 THEN x = 5
                LINE (x - 75, y - 75)-(x + 100, y + 100), 0, BF
                PUT (x, y), aimer
        CASE "g", "G"
                y = y - 15
                IF y <= 40 THEN y = 40
                LINE (x - 75, y - 75)-(x + 100, y + 100), 0, BF
                PUT (x, y), aimer
        CASE "t", "T"
                y = y + 15
                IF y >= 390 THEN y = 390
                LINE (x - 75, y - 75)-(x + 100, y + 100), 0, BF
                PUT (x, y), aimer
        CASE "a", "A"
                IF y > px - 50 AND y < px THEN
                IF x > pl - 50 AND x < pl THEN
                           CALL hit
                        pl = 60
                        px = INT(RND * 300) + 90
                        fire = true
                        planesd = planesd + 1
                        
                END IF
                END IF
       
                IF y > px1 - 50 AND y < px1 THEN
                IF x > pl1 - 50 AND x < pl1 THEN
                            CALL hit
                        pl1 = 0
                        px1 = INT(RND * 300) + 90
                        fire = true
                        planesd = planesd + 1
                        points = points + 2
               
                END IF
                END IF
               
                IF fire = false THEN
                        LOCATE 1, 20
                        PRINT "You Miss"
                        points = points - (1 + INT(points / 100))
                        points = points + 2
                        
                END IF
                       fire = false
       
        CASE "q", "Q"
              
                IF ab$ = "OFF" THEN
                ab$ = "ON"
                ELSE IF ab$ = "ON" THEN ab$ = "OFF"
                END IF
        CASE CHR$(27)
                IF boom > 0 THEN
                        FOR i = 1 TO 75 STEP -1
                                RANDOMIZE TIMER
                                c = INT(RND * 14) + 1
                                CIRCLE STEP(0, 0), i, c
                        NEXT
                        FOR i = 1 TO 75 STEP 1
                                RANDOMIZE TIMER
                                c = INT(RND * 14) + 1
                                CIRCLE STEP(0, 0), i, c
                        NEXT i
                        FOR i = 1 TO 75 STEP 1
                                CIRCLE STEP(0, 0), i, 0
                        NEXT i
                      
                        planesd = planesd + 1
                        boom = boom - 1
                        CLS
                        EXIT DO
                ELSE
                PLAY "L2 ec"
                END IF
END SELECT
        IF pl >= 290 THEN
                IF ab$ = "ON" THEN
                IF boom > 0 THEN
                        FOR i = 1 TO 100 STEP -1
                                RANDOMIZE TIMER
                                c = INT(RND * 14) + 1
                                CIRCLE STEP(0, 0), i, c
                        NEXT
                        FOR i = 1 TO 100 STEP 1
                                RANDOMIZE TIMER
                                c = INT(RND * 14) + 1
                                CIRCLE STEP(0, 0), i, c
                        NEXT i
                        FOR i = 1 TO 100 STEP 1
                                RANDOMIZE TIMER
                                c = INT(RND * 14) + 1
                                CIRCLE STEP(0, 0), i, 0
                        NEXT i
                      
                        planesd = planesd + 1
                        boom = boom - 1
                        CLS
                        EXIT DO
                END IF
                END IF
        END IF
t2 = TIMER
time = t2 - t1
LOCATE 2, 1
PRINT "TIME:    "; INT(60 - time)
IF time >= 60 THEN
CLS
level = level + 1
IF abb = false THEN abbb = 40
bonus = (level * 10) + (2 * level) + (obouns * .23)
points = points + bonus
obonus = bonus
PRINT "Good job, You about to play"; level
PRINT "You got "; points; "points."
PRINT "LEVEL COMPLETE BONUS: ", bonus
PLAY "T225 l4DEF l2 c."
DO
LOOP WHILE INKEY$ = ""
'number1

abb = true
GOTO begin
        END IF
        LOOP
        LOOP
END SUB

