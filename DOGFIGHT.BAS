DECLARE SUB DoExplosion (plane%)
DECLARE SUB CalculateExplosion ()
DECLARE SUB Drawplane (ang%)
DECLARE SUB title ()
DECLARE SUB printscore ()
' ** GALACTIC HANDBALL
' ** 1995 Kevin Byrom
' ** Requires: QBasic Extender TSR
' **
DEFINT A-Z                                       'default type = integer
TYPE Hues                                        'define type for hues
    red AS INTEGER                               'red component
  green AS INTEGER                               'green component
   blue AS INTEGER                               'blue component
END TYPE

DECLARE FUNCTION QBEX (ExtNum)                   'TSR interface
DECLARE SUB millidelay (msecs)                   'SUB to create delays
DECLARE SUB SetColors (pal() AS Hues, fc, lc)    'SUB to modify palette
DECLARE FUNCTION GetKeyMask ()                   'FUNCTION to handle keyboard
'---------- define the variables used by the Extender TSR ----------
COMMON SHARED ExtKeyOfs, ExtKeySeg
COMMON SHARED expl(), ex(), exadd(), ey(), eyadd(), planex, add, yadd, planey, score, FileName$, FileSize&
'-------------------------------------------------------------------

RANDOMIZE TIMER

IF NOT QBEX(0) THEN                              'verify presence of TSR
   PRINT "QBasic Extender TSR not found"
   END
END IF
millidelay 0                                     'initialize


REDIM pal(255) AS Hues                           'array for palette
DEF SEG = VARSEG(pal(0))                         'point to it
BLOAD "mix.PAL", 0                           'load from file
SetColors pal(), 0, 15
SCREEN 7
planex = 0
planey = 190
yadd = -5
add = 1

REDIM expl(1 TO 16)
REDIM ex(1 TO 16)
REDIM ey(1 TO 16)
REDIM exadd(1 TO 16)
REDIM eyadd(1 TO 16)

planex = 0
planey = 100

planex = 0
planey = 100



FOR t = 1 TO 50
SCREEN 7, 0, 1, 2
CLS
'LINE (0, 0)-(320, 200), 2, BF

Drawplane yadd

planex = planex + 3
IF planex > 319 THEN planex = planex - 319

planey = planey + yadd
SCREEN 7, 0, 2, 1
CLS
'LINE (0, 0)-(320, 200), 2, BF
Drawplane yadd
planex = planex + 2
IF planex > 319 THEN planex = planex - 319

planey = planey + yadd
yadd = yadd + add
IF yadd = 3 THEN add = -1
IF yadd = -3 THEN add = 1
NEXT
CalculateExplosion

  DO
  SCREEN 7, 0, 2, 1
  CLS
  DoExplosion 0
  SCREEN 7, 0, 1, 2
  CLS
  DoExplosion 0

  LOOP



'plane angle up
10 DATA 0,0,0,0,0,0,0,0,12,12,0,0,0,0,0,0,0,0,12,12,0,0,0,0,0,0,0,0,12,12,0,0,8,4,4,0,0,0,12,12,8,0,0,4,4,4,4,0,0,0,0,0,0,4,4,4,4,8,12,12,0,0,0,4,4,8,4,4,12,12,0,0,4,4,4,4,4,4,12,12,0,0,0,0,4,4,0,0,12,12,0,0,0,0,0,0
20 DATA 0,0,12,12,12,12,12,12,12,12,0,0,0,0,8,0,0,0,8,0,4,4,4,4,4,4,4,4,4,4,4,4,0,0,8,4,4,4,8,4,0,0,12,12,12,12,12,12,12,12
30 DATA 4,4,0,0,12,12,0,0,0,0,0,0,4,4,4,4,4,4,12,12,0,0,0,0,0,0,0,4,4,8,4,4,12,12,0,0,0,0,0,0,0,4,4,4,4,8,12,12,0,0,12,12,8,0,0,4,4,4,4,0,0,0,0,0,12,12,0,0,8,4,4,0,0,0,0,0,0,0,12,12,0,0,0,0,0,0,0,0,0,0,0,0,12,12,0,0


SUB CalculateExplosion
FOR i = 1 TO 16
 expl(i) = 1
NEXT
ex(1) = planex + 3
ey(1) = planey
ex(2) = planex + 5
ey(2) = planey
ex(3) = planex + 2
ey(3) = planey + 2
ex(4) = planex + 6
ey(4) = planey + 2
ex(5) = planex
ey(5) = planey + 3
ex(6) = planex + 4
ey(6) = planey + 3
ex(7) = planex + 8
ey(7) = planey + 3
ex(8) = planex + 4
ey(8) = planey + 4
ex(9) = planex + 5
ey(9) = planey + 4
ex(10) = planex
ey(10) = planey + 5
ex(11) = planex + 4
ey(11) = planey + 5
ex(12) = planex + 8
ey(12) = planey + 5
ex(13) = planex + 2
ey(13) = planey + 6
ex(14) = planex + 6
ey(14) = planey + 6
ex(15) = planex + 3
ey(15) = planey + 7
ex(16) = planex + 5
ey(16) = planey + 7

FOR i = 1 TO 16
    exadd(i) = ex(i) - (planex + 4)
    eyadd(i) = ey(i) - (planey + 4)


NEXT
    exadd(8) = -1

END SUB

SUB DoExplosion (plane)

    IF plane = 0 THEN
       FOR i = 1 TO 16
           IF expl(i) = 1 THEN
           PSET (ex(i), ey(i)), 4
           ex(i) = ex(i) + exadd(i)
           ey(i) = ey(i) + eyadd(i)
           'IF ex(i) < 0 THEN expl(i) = 0
           'IF ey(i) < 0 THEN expl(i) = 0
           'IF ex(i) > 319 THEN expl(i) = 0
           'IF ey(i) < 199 THEN expl(i) = 0
           END IF
       NEXT
     END IF




END SUB

SUB Drawplane (ang)

  IF ang < 0 THEN
     RESTORE 10
     FOR h = 0 TO 7
         FOR i = 0 TO 11
             READ clr
             IF clr > 0 THEN PSET (planex + i, planey + h), clr
         NEXT
     NEXT
ELSEIF ang = 0 THEN
     RESTORE 20
     FOR h = 0 TO 4
         FOR i = 0 TO 9
             READ clr
             IF clr > 0 THEN PSET (planex + i, planey + h), clr
         NEXT
     NEXT
  ELSEIF ang > 0 THEN
     RESTORE 30
     FOR h = 0 TO 7
         FOR i = 0 TO 11
             READ clr
             IF clr > 0 THEN PSET (planex + i, planey + h), clr
         NEXT
     NEXT



END IF
END SUB

FUNCTION GetKeyMask

   DEF SEG = ExtKeySeg                           'point to QBEX's data
   l = PEEK(ExtKeyOfs + 75) AND 1                'cursor left
   U = PEEK(ExtKeyOfs + 72) AND 2                'cursor up
   r = PEEK(ExtKeyOfs + 77) AND 4                'cursor right
   d = PEEK(ExtKeyOfs + 80) AND 8                'cursor down
   Ent = PEEK(ExtKeyOfs + 28) AND 16             'Enter
   SB = PEEK(ExtKeyOfs + 57) AND 32              'Space Bar
   Esc = PEEK(ExtKeyOfs + 1) AND 64              'Escape
   B = PEEK(ExtKeyOfs + 48) AND 128              'the B key

   DEF SEG = &H40                      'point head to tail thus emptying
   POKE &H1A, PEEK(&H1C)               'the keyboard buffer

   GetKeyMask = l OR U OR r OR d OR Ent OR SB OR Esc OR B
      
END FUNCTION

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
FOR i = 0 TO 10
    FOR t = 0 TO 31
    LINE (i + (10 * t), 0)-(i + (10 * t), 200), 0
    NEXT
NEXT
LOCATE 10, 15
COLOR 1
PRINT "GAME OVER!"
LOCATE 13, 14
PRINT "YOUR SCORE "; score
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

FUNCTION QBEX (ExtNum) STATIC
   IF TSRseg THEN
      DEF SEG = TSRseg
      SELECT CASE ExtNum
      CASE 0  'get key table address
         CALL ABSOLUTE(ExtNum, ExtKeyOfs, ExtKeySeg, TSRofs)
      CASE 9 'check if file exists - if so return size
         CALL ABSOLUTE(ExtNum, FileName$, FileSize&, TSRofs)
      END SELECT
      QBEX = ExtNum
   ELSE
      REDIM ary(46)                              'array to hold machine code
      DEF SEG = VARSEG(ary(0))                   'point to its seg
      BLOAD "CallMult.FPS", 0                    'load machine code
      CALL ABSOLUTE(TSRofs, TSRseg, 0)           'call the code
      ERASE ary                                  'done with the array
      IF TSRseg THEN                             'TSR was found
         QBEX = QBEX(0)                          'call Extender function 0
      ELSE                                       'TSR not found
         QBEX = 0                                'return false
      END IF
   END IF
END FUNCTION

SUB SetColors (pal() AS Hues, fc, lc)
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

