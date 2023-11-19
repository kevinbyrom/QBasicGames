



' ** SCRNSVR.BAS
' ** 1996 KB 49ers

DEFINT A-Z                                       'default type = integer
TYPE Hues                                        'define type for hues
    red AS INTEGER                               'red component
  green AS INTEGER                               'green component
   blue AS INTEGER                               'blue component
END TYPE

DECLARE SUB millidelay (msecs)                   'SUB to create delays
DECLARE SUB SetColors (pal() AS Hues, fc, lc)    'SUB to modify palette

RANDOMIZE TIMER

SCREEN 13                                        '320 x 200 w/256 colors

millidelay 0

REDIM pal(255) AS Hues                           'array for palette
DEF SEG = VARSEG(pal(0))                         'point to it
BLOAD "mix.PAL", 0                           'load from file
SetColors pal(), 0, 255
DO
CLS
10
INPUT "MODE? (1-3.....0 to exit)"; md
IF md < 0 OR md > 3 THEN GOTO 10
IF md = 0 THEN END
CLS

IF md = 1 THEN
x1 = INT(320 * RND)
y1 = INT(200 * RND)
kolor = 0

DO
x2 = INT(320 * RND)
y2 = INT(200 * RND)
kolor = kolor + 16
IF kolor > 192 THEN kolor = 16
FOR i = 0 TO 15
LINE (x1 - i, y1)-(x2 - i, y2), kolor + i
LINE (x1 + i, y1)-(x2 + i, y2), kolor + i
millidelay 2
NEXT
millidelay 150
x1 = x2
y1 = y2
LOOP UNTIL UCASE$(INKEY$) = "Q"
END IF
IF md = 2 THEN
kolor = 0
x = 0
DO
kolor = kolor + 16
IF kolor > 192 THEN kolor = 16

FOR i = 0 TO 15
LINE (x, 0)-(x, 200), kolor + i
x = x + 1
IF x = 318 THEN x = 0
NEXT

FOR i = 15 TO 0 STEP -1
LINE (x, 0)-(x, 200), kolor + i
x = x + 1
IF x = 318 THEN x = 0
NEXT

LOOP UNTIL UCASE$(INKEY$) = "Q"

END IF
IF md = 3 THEN
kolor = 0
x = 0
DO
kolor = kolor + 16
IF kolor > 192 THEN kolor = 16

FOR i = 0 TO 15
LINE (0, x)-(320, x), kolor + i
x = x + 1
IF x = 199 THEN x = 0
NEXT
millidelay 5
FOR i = 15 TO 0 STEP -1
LINE (0, x)-(320, x), kolor + i
x = x + 1
IF x = 199 THEN x = 0
NEXT
millidelay 5

LOOP UNTIL UCASE$(INKEY$) = "Q"

END IF
LOOP

SUB millidelay (msecs) STATIC

    IF sysfact& THEN
        IF msecs THEN
            count& = (sysfact& * msecs) \ -54
            DO
               
                count& = count& + 1
                IF count& = z THEN EXIT DO
            LOOP UNTIL t2 = PEEK(&H6C)
        END IF
    ELSE
        DEF SEG = &H40
        t1 = PEEK(&H6C)
        DO
            t2 = PEEK(&H6C)
        LOOP UNTIL t2 <> t1
        DO
            sysfact& = sysfact& + 1
            IF sysfact& = z THEN EXIT DO
        LOOP UNTIL t2 <> PEEK(&H6C)
        t2 = 256
    END IF
END SUB

SUB SetColors (pal() AS Hues, fc, lc)
   OUT &H3C8, fc                                 'initialize controller
   FOR t = fc TO lc                              'from first to last
      OUT &H3C9, pal(t).red                      'send red component
     
      OUT &H3C9, pal(t).green                    'send green component
      OUT &H3C9, pal(t).blue                     'send blue component
   NEXT
END SUB

