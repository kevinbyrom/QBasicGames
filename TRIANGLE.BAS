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
DECLARE SUB MILLIDELAY (msecs)                   'SUB to create delays
DECLARE SUB SetColors (pal() AS Hues, fc, lc)    'SUB to modify palette
DECLARE FUNCTION GetKeyMask ()                   'FUNCTION to handle keyboard
'---------- define the variables used by the Extender TSR ----------
COMMON SHARED ExtKeyOfs, ExtKeySeg
COMMON SHARED FileName$, FileSize&
'-------------------------------------------------------------------

RANDOMIZE TIMER

IF NOT QBEX(0) THEN                              'verify presence of TSR
   PRINT "QBasic Extender TSR not found"
   END
END IF

SCREEN 12                                        '320 x 200 w/256 colors
MILLIDELAY 0                                     'initialize
REDIM pal(12) AS Hues                           'array for palette
DEF SEG = VARSEG(pal(0))                         'point to it
'BLOAD "DEFAULT.PAL", 0                           'load from file
pal(0).red = 0                                  'set background
pal(0).green = 0                                'to a dark shade
pal(0).blue = 0                                 'of blue gray
SetColors pal(), 0, 12                          'set system colors

x1 = 80
x2 = 0
x3 = 160
x4 = 80
y1 = 0
y2 = 80
y3 = 80
y4 = 40
x1add = 1
x2add = 1
x3add = 1
x4add = 1
y1add = 1
y2add = 1
y3add = 1
y4add = 1

radd = 1
gadd = 0
badd = 0
DO

IF pal(1).red = 60 THEN
   radd = -1
   gadd = 1
   badd = 0
END IF
IF pal(1).green = 60 THEN
   gadd = -1
   badd = 1
   radd = 0
END IF
IF pal(1).blue = 60 THEN
   badd = -1
   radd = 1
   gadd = 0
END IF

pal(1).red = pal(1).red + radd                                'set background
pal(1).green = pal(1).green + gadd                               'to a dark shade
pal(1).blue = pal(1).blue + badd                               'of blue gray

SetColors pal(), 0, 12                          'set system colors

LINE (x1, y1)-(x2, y2), 0
LINE (x1, y1)-(x3, y3), 0
LINE (x1, y1)-(x4, y4), 0
LINE (x2, y2)-(x4, y4), 0
LINE (x2, y2)-(x3, y3), 0
LINE (x3, y3)-(x4, y4), 0


x1 = x1 + x1add
x2 = x2 + x2add
x3 = x3 + x3add
x4 = x4 + x4add
y1 = y1 + y1add
y2 = y2 + y2add
y3 = y3 + y3add
y4 = y4 + y4add


LINE (x1, y1)-(x2, y2), 1
LINE (x1, y1)-(x3, y3), 1
LINE (x1, y1)-(x4, y4), 1
LINE (x2, y2)-(x4, y4), 1
LINE (x2, y2)-(x3, y3), 1
LINE (x3, y3)-(x4, y4), 1


IF x1 > 639 THEN x1add = -1
IF x2 > 639 THEN x2add = -1
IF x3 > 639 THEN x3add = -1
IF x4 > 639 THEN x4add = -1
IF x1 < 1 THEN x1add = 1
IF x2 < 1 THEN x2add = 1
IF x3 < 1 THEN x3add = 1
IF x4 < 1 THEN x4add = 1
IF y1 > 479 THEN y1add = -1
IF y2 > 479 THEN y2add = -1
IF y3 > 479 THEN y3add = -1
IF y4 > 479 THEN y4add = -1
IF y1 < 1 THEN y1add = 1
IF y2 < 1 THEN y2add = 1
IF y3 < 1 THEN y3add = 1
IF y4 < 1 THEN y4add = 1

FOR i = 1 TO 1000
NEXT


LOOP

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

SUB MILLIDELAY (msecs) STATIC

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

