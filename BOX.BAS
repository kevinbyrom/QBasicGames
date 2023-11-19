DECLARE SUB drawchest ()
' ** FightTest.BAS
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
COMMON SHARED zoom, x, y, ExtKeyOfs, ExtKeySeg
COMMON SHARED FileName$, FileSize&
'-------------------------------------------------------------------

RANDOMIZE TIMER

IF NOT QBEX(0) THEN                              'verify presence of TSR
   PRINT "QBasic Extender TSR not found"
   END
END IF

SCREEN 13                                        '320 x 200 w/256 colors
millidelay 0                                     'initialize
REDIM pal(255) AS Hues                           'array for palette
DEF SEG = VARSEG(pal(0))                         'point to it
BLOAD "DEFAULT.PAL", 0                           'load from file
SetColors pal(), 0, 255
'zoom = 2
'drawchest
'DO
'LOOP
RANDOMIZE TIMER

x = 160
y = 100

zoom = 2
DO
drawchest

DO
thiskey = GetKeyMask
LOOP UNTIL thiskey
millidelay 110

LINE (x, y)-(x + (12 * zoom), y + (16 * zoom)), 0, BF

IF thiskey AND 1 THEN
zoom = zoom - 1
x = x + zoom
y = y + zoom
END IF

IF thiskey AND 4 THEN
zoom = zoom + 1
x = x - zoom
y = y - zoom

END IF

LOOP

SUB drawchest
clr = 220
clr2 = 216

LINE (x + (6 * zoom), y + (0 * zoom))-(x + (5 * zoom), y + (1 * zoom)), clr
LINE (x + (6 * zoom), y + (0 * zoom))-(x + (6 * zoom), y + (3 * zoom)), clr
LINE (x + (7 * zoom), y + (0 * zoom))-(x + (7 * zoom), y + (2 * zoom)), clr
LINE (x + (9 * zoom), y + (0 * zoom))-(x + (9 * zoom), y + (5 * zoom)), clr
LINE (x + (5 * zoom), y + (1 * zoom))-(x + (5 * zoom), y + (2 * zoom)), clr
LINE (x + (9 * zoom), y + (1 * zoom))-(x + (10 * zoom), y + (2 * zoom)), clr
LINE (x + (5 * zoom), y + (2 * zoom))-(x + (4 * zoom), y + (3 * zoom)), clr
LINE (x + (7 * zoom), y + (2 * zoom))-(x + (9 * zoom), y + (4 * zoom)), clr
LINE (x + (3 * zoom), y + (3 * zoom))-(x + (4 * zoom), y + (3 * zoom)), clr
LINE (x + (6 * zoom), y + (3 * zoom))-(x + (7 * zoom), y + (4 * zoom)), clr
LINE (x + (10 * zoom), y + (2 * zoom))-(x + (10 * zoom), y + (4 * zoom)), clr
LINE (x + (3 * zoom), y + (3 * zoom))-(x + (0 * zoom), y + (6 * zoom)), clr
LINE (x + (0 * zoom), y + (6 * zoom))-(x + (0 * zoom), y + (11 * zoom)), clr
LINE (x + (0 * zoom), y + (11 * zoom))-(x + (2 * zoom), y + (13 * zoom)), clr
LINE (x + (2 * zoom), y + (13 * zoom))-(x + (2 * zoom), y + (15 * zoom)), clr
LINE (x + (3 * zoom), y + (16 * zoom))-(x + (2 * zoom), y + (15 * zoom)), clr
LINE (x + (3 * zoom), y + (16 * zoom))-(x + (9 * zoom), y + (16 * zoom)), clr
LINE (x + (9 * zoom), y + (15 * zoom))-(x + (9 * zoom), y + (16 * zoom)), clr
LINE (x + (9 * zoom), y + (15 * zoom))-(x + (10 * zoom), y + (14 * zoom)), clr
LINE (x + (10 * zoom), y + (12 * zoom))-(x + (10 * zoom), y + (14 * zoom)), clr
LINE (x + (10 * zoom), y + (12 * zoom))-(x + (11 * zoom), y + (11 * zoom)), clr
LINE (x + (11 * zoom), y + (10 * zoom))-(x + (11 * zoom), y + (11 * zoom)), clr
LINE (x + (11 * zoom), y + (10 * zoom))-(x + (12 * zoom), y + (9 * zoom)), clr
LINE (x + (12 * zoom), y + (6 * zoom))-(x + (12 * zoom), y + (9 * zoom)), clr
LINE (x + (12 * zoom), y + (6 * zoom))-(x + (10 * zoom), y + (4 * zoom)), clr
LINE (x + (1 * zoom), y + (5 * zoom))-(x + (3 * zoom), y + (5 * zoom)), clr
LINE (x + (4 * zoom), y + (6 * zoom))-(x + (3 * zoom), y + (5 * zoom)), clr
LINE (x + (4 * zoom), y + (6 * zoom))-(x + (4 * zoom), y + (11 * zoom)), clr
LINE (x + (2 * zoom), y + (13 * zoom))-(x + (4 * zoom), y + (11 * zoom)), clr
LINE (x + (4 * zoom), y + (4 * zoom))-(x + (3 * zoom), y + (5 * zoom)), clr
LINE (x + (4 * zoom), y + (4 * zoom))-(x + (8 * zoom), y + (4 * zoom)), clr
LINE (x + (11 * zoom), y + (7 * zoom))-(x + (8 * zoom), y + (4 * zoom)), clr
LINE (x + (11 * zoom), y + (7 * zoom))-(x + (11 * zoom), y + (9 * zoom)), clr
LINE (x + (10 * zoom), y + (10 * zoom))-(x + (11 * zoom), y + (9 * zoom)), clr
LINE (x + (10 * zoom), y + (10 * zoom))-(x + (7 * zoom), y + (10 * zoom)), clr
LINE (x + (4 * zoom), y + (7 * zoom))-(x + (7 * zoom), y + (10 * zoom)), clr
LINE (x + (4 * zoom), y + (11 * zoom))-(x + (6 * zoom), y + (13 * zoom)), clr
LINE (x + (7 * zoom), y + (13 * zoom))-(x + (6 * zoom), y + (13 * zoom)), clr
LINE (x + (7 * zoom), y + (13 * zoom))-(x + (8 * zoom), y + (12 * zoom)), clr
LINE (x + (9 * zoom), y + (12 * zoom))-(x + (8 * zoom), y + (12 * zoom)), clr
LINE (x + (9 * zoom), y + (12 * zoom))-(x + (10 * zoom), y + (11 * zoom)), clr
LINE (x + (10 * zoom), y + (12 * zoom))-(x + (10 * zoom), y + (10 * zoom)), clr
LINE (x + (10 * zoom), y + (14 * zoom))-(x + (8 * zoom), y + (14 * zoom)), clr
LINE (x + (7 * zoom), y + (13 * zoom))-(x + (8 * zoom), y + (14 * zoom)), clr
LINE (x + (7 * zoom), y + (13 * zoom))-(x + (7 * zoom), y + (15 * zoom)), clr
LINE (x + (8 * zoom), y + (16 * zoom))-(x + (7 * zoom), y + (15 * zoom)), clr
LINE (x + (9 * zoom), y + (5 * zoom))-(x + (10 * zoom), y + (4 * zoom)), clr
LINE (x + (6 * zoom), y + (0 * zoom))-(x + (9 * zoom), y + (0 * zoom)), clr

PAINT (x + (5 * zoom), y + (3 * zoom)), clr2, clr
PAINT (x + (7 * zoom), y + (3 * zoom)), clr2, clr
PAINT (x + (8 * zoom), y + (2 * zoom)), clr2, clr
PAINT (x + (9.5 * zoom), y + (3 * zoom)), clr2, clr
PAINT (x + (2 * zoom), y + (8.5 * zoom)), clr2, clr
PAINT (x + (7 * zoom), y + (7 * zoom)), clr2, clr
PAINT (x + (11 * zoom), y + (6 * zoom)), clr2, clr
PAINT (x + (6 * zoom), y + (11 * zoom)), clr2, clr
PAINT (x + (10.5 * zoom), y + (10.5 * zoom)), clr2, clr
PAINT (x + (5 * zoom), y + (14 * zoom)), clr2, clr
PAINT (x + (9 * zoom), y + (13 * zoom)), clr2, clr
PAINT (x + (8 * zoom), y + (15 * zoom)), clr2, clr

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
   b = PEEK(ExtKeyOfs + 48) AND 128              'the B key

   DEF SEG = &H40                      'point head to tail thus emptying
   POKE &H1A, PEEK(&H1C)               'the keyboard buffer

   GetKeyMask = l OR U OR r OR d OR Ent OR SB OR Esc OR b
      
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

