' ** GALACTIC HANDBALL
' ** 1996 KB 49ers
'
'
'____________________________________________________________________________
'|                                                                          |
'|        Hey! Wassup! This iz KB 49ers speaking, telling you that I am     |
'|        BACK! Yep, thats right, I have returned and the answer to the     |
'|        most asked question is ........... DRAGOON LEGACY will STILL      |
'|        be coming out on AOL, very soon! It is taking me alot of time     |
'|        to make it but believe me, it will be worth it.  I have devoted   |
'|        all my time working on NEW special effects for the game, so       |
'|        it won't turn out to be another lame RPG.  So lemme divulge       |
'|        you with only SOME of the features that will be found in          |
'|        DRAGOON LEGACY......                                              |
'|                                                                          |
'|        .......DIGITAL VOICE & Sound FX (Yes! Actual WAV sounds!)         |
'|        .......256 Color Special FX (Fade IN/OUT-Color Swap, ETC)         |
'|        .......Multiple Players (Thats right! MULTIPLE)                   |
'|                                                                          |
'|        So there you have it, that is only a small portion of what        |
'|        DRAGOON LEGACY will offer.  Also, I am alway open to              |
'|        ideas and suggestions, so if you feel that I am missing           |
'|        something that you would like to see in DRAGOON LEGACY...         |
'|        EMAIL ME!  Most likely your idea WILL be put into the game.       |
'|        Multiple minds are always better than one.  I can't think         |
'|        of it all, so with combining many ideas, DRAGOON LEGACY           |
'|        promises to be the BEST QBASIC RPG available on AOL!              |
'|                                                                          |
'|        EMAIL me with your suggestions and/or comments to:                |
'|                                                                          |
'|                             KB MaiL                                      |
'|__________________________________________________________________________|
'        ______          _            ___   ________  ___
'       /   _  \    /\  | |     /\   / _  \|__   __||/ _  \     /\
'      |   | |__| / <> \| |   / <> \| | |__|  | | | | | |__|  /    \
'      |   |____ |      | |  |      | |  __   | | | | |  __   \    /
'      |   |_   ||  ||  | |__|  ||  | |_|  |  | | | | |_|  |    \/
'       \______/ |__||__|____|__||__|\____/   |_| |_|\____/
'              __   __        __   _ ___   ___          _ _
'        /\   |  | |  |  /\  |  \ | |    \|    \   /\  | | |
'      /    \ |  |_|  |/ <> \|    \ |  O  | o   |/ <> \| | |
'      \    / |   _   |      |      |     |    <|      | | |
'        \/   |  | |  |  ||  |  |\  |     | O   |  ||  | |_|__
'             |__| |__|__||__|__|  \|____/|____/|__||__|____|_|
'
'
'

DEFINT A-Z                                       'default type = integer
TYPE hues                                        'define type for hues
    red AS INTEGER                               'red component
  green AS INTEGER                               'green component
   blue AS INTEGER                               'blue component
END TYPE


DECLARE SUB title ()
DECLARE SUB printscore ()
DECLARE SUB millidelay (msecs)                   'SUB to create delays
DECLARE SUB SetColors (pal() AS hues, fc, lc)    'SUB to modify palette
DECLARE SUB DragPrev ()
DECLARE SUB centerprint (A$, row%, clr%)
DECLARE FUNCTION GetKeyMask ()                   'FUNCTION to handle keyboard
'---------- define the variables used by the Extender TSR ----------
COMMON SHARED score, FileName$, FileSize&, pal() AS hues
'-------------------------------------------------------------------

RANDOMIZE TIMER

millidelay 0                                     'initialize
'REDIM pal(255) AS hues                           'array for palette
'DEF SEG = VARSEG(pal(0))                         'point to it
'BLOAD "default.PAL", 0                           'load from file
'SetColors pal(), 0, 255

title
max = 15
REDIM bstarx(1 TO max)
REDIM bstary(1 TO max)
FOR i = 1 TO max
   bstarx(i) = INT(318 * RND) + 1
   bstary(i) = INT(198 * RND) + 1
NEXT
REDIM starx(1 TO max)
REDIM stary(1 TO max)
FOR i = 1 TO max
   starx(i) = INT(318 * RND) + 1
   stary(i) = INT(198 * RND) + 1
NEXT
REDIM lstarx(1 TO max)
REDIM lstary(1 TO max)
FOR i = 1 TO max
   lstarx(i) = INT(318 * RND) + 1
   lstary(i) = INT(198 * RND) + 1
NEXT
barx = 1
ballx! = INT(307 * RND) + 6
bally! = 100
xadd! = INT(2 * RND) + 1
IF xadd! = 2 THEN xadd! = -1
yadd! = -1

SCREEN 7, 0, 0, 2
'x = INT(300 * RND) + 10
'y = INT(180 * RND) + 10
'CIRCLE (x, y), 50, 7
'PAINT (x, y), 15, 7
'LINE (0, 0)-(0, 199), 1, B
'LINE (319, 0)-(319, 199), 1, B



PCOPY 0, 4
SCREEN 7, 0, 4, 2
FOR i = 1 TO max
    IF POINT(lstarx(i), lstary(i)) = 0 THEN PSET (lstarx(i), lstary(i)), 8
    IF POINT(starx(i), stary(i)) = 0 THEN PSET (starx(i), stary(i)), 7
    IF POINT(bstarx(i), bstary(i)) = 0 THEN PSET (bstarx(i), bstary(i)), 15
NEXT
PCOPY 4, 1
delay = 5


DO


millidelay delay
SCREEN 7, 0, 1, 2
PCOPY 0, 1

ballx! = ballx! + xadd!
bally! = bally! + yadd!
IF ballx! >= 312 OR ballx! <= 6 THEN
SOUND 150, .25
xadd! = -xadd!
END IF
IF bally! >= 189 THEN
SCREEN 7, 0, 2, 2
printscore
END IF
IF bally! >= 188 AND ballx! > barx - 5 AND ballx! < barx + 58 THEN
SOUND 150, .25
score = score + 1
yadd! = -yadd!
IF score MOD 5 = 0 THEN
xadd! = xadd! + (xadd! * .2)
yadd! = yadd! + (yadd! * .2)
sdd = sdd + 1
SOUND 200, .25
SOUND 300, .25
END IF
END IF
IF bally! <= 11 AND ballx! > barx - 5 AND ballx! < barx + 58 THEN
SOUND 150, .25
score = score + 1
yadd! = -yadd!
IF score MOD 5 = 0 THEN
xadd! = xadd! + (xadd! * .2)
yadd! = yadd! + (yadd! * .2)
sdd = sdd + 1
SOUND 200, .25
SOUND 300, .25
END IF
END IF
IF bally! <= 8 THEN
SCREEN 7, 0, 1, 1
printscore
END IF
aa$ = INKEY$
SELECT CASE aa$
     CASE CHR$(0) + "M": barx = barx + 12
     CASE CHR$(0) + "K": barx = barx - 12
END SELECT


IF barx < 1 THEN barx = 1
IF barx > 318 - 53 THEN barx = 318 - 53
LINE (barx, 193)-(barx + 53, 198), INT(14 * RND) + 1, BF
LINE (barx, 193)-(barx + 53, 198), INT(14 * RND) + 1, B

LINE (barx, 1)-(barx + 53, 6), INT(14 * RND) + 1, BF
LINE (barx, 1)-(barx + 53, 6), INT(14 * RND) + 1, B

CIRCLE (ballx!, bally!), 5, 14
PAINT (ballx!, bally!), INT(13 * RND) + 1, 14

FOR i = 1 TO max
    IF POINT(lstarx(i), lstary(i)) = 0 THEN PSET (lstarx(i), lstary(i)), 8
    IF POINT(starx(i), stary(i)) = 0 THEN PSET (starx(i), stary(i)), 7
    IF POINT(bstarx(i), bstary(i)) = 0 THEN PSET (bstarx(i), bstary(i)), 15
NEXT
FOR i = 1 TO max
    lstary(i) = lstary(i) + 1 + sdd
    stary(i) = stary(i) + 2 + sdd
    bstary(i) = bstary(i) + 4 + sdd
    IF lstary(i) > 198 THEN
     lstary(i) = 1
     lstarx(i) = INT(318 * RND) + 1
    END IF
    IF stary(i) > 198 THEN
     stary(i) = 1
     starx(i) = INT(318 * RND) + 1
    END IF
    IF bstary(i) > 198 THEN
     bstary(i) = 1
     bstarx(i) = INT(318 * RND) + 1
    END IF
NEXT


millidelay delay

SCREEN 7, 0, 2, 1
PCOPY 0, 2


ballx! = ballx! + xadd!
bally! = bally! + yadd!
IF ballx! >= 312 OR ballx! <= 6 THEN
SOUND 150, .25
xadd! = -xadd!
END IF
IF bally! >= 189 THEN
SCREEN 7, 0, 1, 1
printscore
END IF
IF bally! >= 188 AND ballx! > barx - 5 AND ballx! < barx + 58 THEN
SOUND 150, .25
score = score + 1
yadd! = -yadd!
IF score MOD 5 = 0 THEN
xadd! = xadd! + (xadd! * .2)
yadd! = yadd! + (yadd! * .2)
sdd = sdd + 1
SOUND 200, .25
SOUND 300, .25
END IF
END IF

IF bally! <= 11 AND ballx! > barx - 5 AND ballx! < barx + 58 THEN
SOUND 150, .25
score = score + 1
yadd! = -yadd!
IF score MOD 5 = 0 THEN
xadd! = xadd! + (xadd! * .2)
yadd! = yadd! + (yadd! * .2)
sdd = sdd + 1
SOUND 200, .25
SOUND 300, .25
END IF
END IF
IF bally! <= 8 THEN
SCREEN 7, 0, 1, 1
printscore
END IF
aa$ = INKEY$
SELECT CASE aa$
     CASE CHR$(0) + "M": barx = barx + 12
     CASE CHR$(0) + "K": barx = barx - 12
END SELECT
IF INKEY$ = CHR$(64) THEN END
IF barx < 1 THEN barx = 1
IF barx > 318 - 53 THEN barx = 318 - 53
LINE (barx, 193)-(barx + 53, 198), INT(14 * RND) + 1, BF
LINE (barx, 193)-(barx + 53, 198), INT(14 * RND) + 1, B

LINE (barx, 1)-(barx + 53, 6), INT(14 * RND) + 1, BF
LINE (barx, 1)-(barx + 53, 6), INT(14 * RND) + 1, B


CIRCLE (ballx!, bally!), 5, 14
PAINT (ballx!, bally!), INT(13 * RND) + 1, 14

FOR i = 1 TO max
    IF POINT(lstarx(i), lstary(i)) = 0 THEN PSET (lstarx(i), lstary(i)), 8
    IF POINT(starx(i), stary(i)) = 0 THEN PSET (starx(i), stary(i)), 7
    IF POINT(bstarx(i), bstary(i)) = 0 THEN PSET (bstarx(i), bstary(i)), 15
NEXT
FOR i = 1 TO max
    lstary(i) = lstary(i) + 1 + sdd
    stary(i) = stary(i) + 2 + sdd
    bstary(i) = bstary(i) + 4 + sdd
    IF lstary(i) > 198 THEN
     lstary(i) = 1
     lstarx(i) = INT(318 * RND) + 1
    END IF
    IF stary(i) > 198 THEN
     stary(i) = 1
     starx(i) = INT(318 * RND) + 1
    END IF
    IF bstary(i) > 198 THEN
     bstary(i) = 1
     bstarx(i) = INT(318 * RND) + 1
    END IF
NEXT

LOOP

SUB centerprint (A$, row, clr)
  sl = LEN(A$)
  col = 20 - (sl / 2)
  LOCATE row, col
  COLOR clr
  PRINT A$
END SUB

SUB millidelay (msecs) STATIC

    IF sysfact& THEN                   'Did we calc- system speed yet?
        IF msecs THEN                  'have to want a delay
            count& = (sysfact& * msecs) \ -54    'calc- # of loops needed
            DO
                count& = count& + 1         'negative - add to get to 0
                IF count& = z THEN EXIT DO  'when its 0 we're done
            LOOP UNTIL t2 = PEEK(&H6C)      'make it the same as loop below
        END IF
    ELSE                               'if sysfact& is 0, calc- system speed
        DEF SEG = &H40                 'point to low memory
        t1 = PEEK(&H6C)                'get tick count
        DO
            t2 = PEEK(&H6C)            'get tick count
        LOOP UNTIL t2 <> t1            'wait 'til its a new tick
        DO
            sysfact& = sysfact& + 1         'count number of loops
            IF sysfact& = z THEN EXIT DO    'make it the same as loop above
        LOOP UNTIL t2 <> PEEK(&H6C)         'keep going 'til its a new tick
        t2 = 256                            'prevent the above UNTIL
    END IF
END SUB

SUB printscore

FOR i = 0 TO 10
    FOR t = 0 TO 31
    LINE (i + (10 * t), 0)-(i + (10 * t), 200), 1
    NEXT
NEXT
millidelay 25

SCREEN 7, 0, 4, 1
CLS
LOCATE 10, 15
COLOR 1
PRINT "GAME OVER!"
LOCATE 13, 14
PRINT "YOUR SCORE "; score

FOR i = 160 TO 0 STEP -2
     PCOPY 4, 3
     SCREEN 7, 0, 3, 2
     LINE (0, 0)-(i, 200), 1, BF
     LINE (320, 0)-(320 - i, 200), 1, BF
     PCOPY 3, 2
NEXT


SCREEN 7, 0, 2, 2
LINE (0, 0)-(0, 200), 0



SLEEP 1
anykey$ = INPUT$(2)
FOR i = 10 TO 0 STEP -1
    FOR t = 0 TO 31
    LINE (i + (10 * t), 0)-(i + (10 * t), 200), 1
    NEXT
NEXT
millidelay 25
FOR i = 10 TO 0 STEP -1
    FOR t = 0 TO 31
    LINE (i + (10 * t), 0)-(i + (10 * t), 200), 0
    NEXT
NEXT

END

END SUB

SUB SetColors (pal() AS hues, fc, lc)
   OUT &H3C8, fc                                 'initialize controller
   FOR t = fc TO lc                              'from first to last
      OUT &H3C9, pal(t).red                      'send red component
     
      OUT &H3C9, pal(t).green                    'send green component
      OUT &H3C9, pal(t).blue                     'send blue component
   NEXT
END SUB

SUB title

REDIM strsx(1 TO 100)
REDIM strsy(1 TO 100)
FOR i = 1 TO 100
    strsx(i) = 160
    strsy(i) = 100
NEXT

REDIM sx(1 TO 100)
REDIM sy(1 TO 100)
FOR i = 1 TO 100
   DO
   sx(i) = INT(10 * RND) - 5
   sy(i) = INT(10 * RND) - 5
   LOOP UNTIL sx(i) <> 0 OR sy(i) <> 0
NEXT


SCREEN 7, 0, 3, 0
LOCATE 11, 17
COLOR 1
PRINT "GALACTIC"
LOCATE 15, 17
COLOR 2
PRINT "HANDBALL"

REDIM lx(1 TO 8)
lx(1) = 0
lx(2) = 319
lx(3) = 319
lx(4) = 0

lx(5) = 0
lx(6) = 319
lx(7) = 319
lx(8) = 0

REDIM ly(1 TO 8)
ly(1) = 0
ly(2) = 0
ly(3) = 199
ly(4) = 199

ly(5) = 0
ly(6) = 0
ly(7) = 199
ly(8) = 199

REDIM lxadd(1 TO 8)
lxadd(1) = 1
lxadd(2) = 0
lxadd(3) = -1
lxadd(4) = 0

lxadd(5) = 0
lxadd(6) = -1
lxadd(7) = 0
lxadd(8) = 1

REDIM lyadd(1 TO 8)
lyadd(1) = 0
lyadd(2) = 1
lyadd(3) = 0
lyadd(4) = -1

lyadd(5) = 1
lyadd(6) = 0
lyadd(7) = -1
lyadd(8) = 0

DO
millidelay 5
PCOPY 3, 5
SCREEN 7, 0, 5, 4

FOR i = 1 TO 100
    IF POINT(strsx(i), strsy(i)) = 0 THEN PSET (strsx(i), strsy(i)), 15
    strsx(i) = strsx(i) + sx(i)
    strsy(i) = strsy(i) + sy(i)
    IF strsx(i) <= 0 OR strsx(i) >= 319 OR strsy(i) <= 0 OR strsy(i) >= 199 THEN
       strsx(i) = 160
       strsy(i) = 100
       DO
       sx(i) = INT(10 * RND) - 5
       sy(i) = INT(10 * RND) - 5
       LOOP UNTIL sx(i) <> 0 OR sy(i) <> 0
    END IF
NEXT

LINE (lx(5), ly(5))-(lx(6), ly(6)), 4
LINE (lx(1), ly(1))-(lx(2), ly(2)), 3

LINE (lx(6), ly(6))-(lx(7), ly(7)), 4
LINE (lx(2), ly(2))-(lx(3), ly(3)), 3

LINE (lx(7), ly(7))-(lx(8), ly(8)), 4
LINE (lx(3), ly(3))-(lx(4), ly(4)), 3

LINE (lx(8), ly(8))-(lx(5), ly(5)), 4
LINE (lx(4), ly(4))-(lx(1), ly(1)), 3



SCREEN 7, 0, 5, 5
PCOPY 5, 4
FOR i = 1 TO 4
lx(i) = lx(i) + lxadd(i)
ly(i) = ly(i) + lyadd(i)

IF lx(i) = 319 AND ly(i) = 199 THEN
   lxadd(i) = -1
   lyadd(i) = 0

END IF
IF lx(i) = 0 AND ly(i) = 199 THEN
   lxadd(i) = 0
   lyadd(i) = -1

END IF
IF lx(i) = 0 AND ly(i) = 0 THEN
   lxadd(i) = 1
   lyadd(i) = 0
END IF
IF lx(i) = 319 AND ly(i) = 0 THEN
   lxadd(i) = 0
   lyadd(i) = 1
END IF
NEXT

FOR i = 5 TO 8
lx(i) = lx(i) + lxadd(i)
ly(i) = ly(i) + lyadd(i)
IF lx(i) = 319 AND ly(i) = 199 THEN
   lxadd(i) = 0
   lyadd(i) = -1

END IF
IF lx(i) = 0 AND ly(i) = 199 THEN
   lxadd(i) = 1
   lyadd(i) = 0

END IF
IF lx(i) = 0 AND ly(i) = 0 THEN
   lxadd(i) = 0
   lyadd(i) = 1
END IF
IF lx(i) = 319 AND ly(i) = 0 THEN
   lxadd(i) = -1
   lyadd(i) = 0
END IF
NEXT


LOOP WHILE INKEY$ = ""
FOR i = 0 TO 10
    FOR t = 0 TO 31
    LINE (i + (10 * t), 0)-(i + (10 * t), 200), 1
    NEXT
NEXT
millidelay 25
FOR i = 0 TO 10
    FOR t = 0 TO 31
    LINE (i + (10 * t), 0)-(i + (10 * t), 200), 0
    NEXT
NEXT


END SUB

