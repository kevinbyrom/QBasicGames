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

x1 = 0
x2 = 180
x3 = 0
x4 = 180
x5 = 0
x6 = 180
y1 = 0
y2 = 40
y3 = 5
y4 = 45
y5 = 10
y6 = 50
x1add = 1
x2add = 1
x3add = 1
x4add = 1
x5add = 1
x6add = 1
y1add = 1
y2add = 1
y3add = 1
y4add = 1
y5add = 1
y6add = 1

a1 = 319
a2 = 139
a3 = 319
a4 = 139
a5 = 319
a6 = 139
b1 = 199
b2 = 159
b3 = 194
b4 = 154
b5 = 189
b6 = 149
a1add = -1
a2add = -1
a3add = -1
a4add = -1
a5add = -1
a6add = -1
b1add = -1
b2add = -1
b3add = -1
b4add = -1
b5add = -1
b6add = -1

DO
LINE (x1, y1)-(x2, y2), 0
LINE (x3, y3)-(x4, y4), 0
LINE (x5, y5)-(x6, y6), 0

LINE (a1, b1)-(a2, b2), 0
LINE (a3, b3)-(a4, b4), 0
LINE (a5, b5)-(a6, b6), 0

LINE (x1 + 320, y1)-(x2 + 320, y2), 0
LINE (x3 + 320, y3)-(x4 + 320, y4), 0
LINE (x5 + 320, y5)-(x6 + 320, y6), 0

LINE (a1 + 320, b1)-(a2 + 320, b2), 0
LINE (a3 + 320, b3)-(a4 + 320, b4), 0
LINE (a5 + 320, b5)-(a6 + 320, b6), 0

LINE (x1, y1 + 240)-(x2, y2 + 240), 0
LINE (x3, y3 + 240)-(x4, y4 + 240), 0
LINE (x5, y5 + 240)-(x6, y6 + 240), 0

LINE (a1, b1 + 240)-(a2, b2 + 240), 0
LINE (a3, b3 + 240)-(a4, b4 + 240), 0
LINE (a5, b5 + 240)-(a6, b6 + 240), 0

x1 = x1 + x1add
x2 = x2 + x2add
x3 = x3 + x3add
x4 = x4 + x4add
x5 = x5 + x5add
x6 = x6 + x6add
y1 = y1 + y1add
y2 = y2 + y2add
y3 = y3 + y3add
y4 = y4 + y4add
y5 = y5 + y5add
y6 = y6 + y6add

a1 = a1 + a1add
a2 = a2 + a2add
a3 = a3 + a3add
a4 = a4 + a4add
a5 = a5 + a5add
a6 = a6 + a6add
b1 = b1 + b1add
b2 = b2 + b2add
b3 = b3 + b3add
b4 = b4 + b4add
b5 = b5 + b5add
b6 = b6 + b6add

LINE (x1, y1)-(x2, y2), 1
LINE (x3, y3)-(x4, y4), 1
LINE (x5, y5)-(x6, y6), 1

LINE (a1, b1)-(a2, b2), 2
LINE (a3, b3)-(a4, b4), 2
LINE (a5, b5)-(a6, b6), 2

LINE (x1 + 320, y1)-(x2 + 320, y2), 3
LINE (x3 + 320, y3)-(x4 + 320, y4), 3
LINE (x5 + 320, y5)-(x6 + 320, y6), 3

LINE (a1 + 320, b1)-(a2 + 320, b2), 4
LINE (a3 + 320, b3)-(a4 + 320, b4), 4
LINE (a5 + 320, b5)-(a6 + 320, b6), 4

LINE (x1, y1 + 240)-(x2, y2 + 240), 5
LINE (x3, y3 + 240)-(x4, y4 + 240), 5
LINE (x5, y5 + 240)-(x6, y6 + 240), 5

LINE (a1, b1 + 240)-(a2, b2 + 240), 6
LINE (a3, b3 + 240)-(a4, b4 + 240), 6
LINE (a5, b5 + 240)-(a6, b6 + 240), 6

IF x1 > 319 THEN x1add = -1
IF x2 > 319 THEN x2add = -1
IF x3 > 319 THEN x3add = -1
IF x4 > 319 THEN x4add = -1
IF x5 > 319 THEN x5add = -1
IF x6 > 319 THEN x6add = -1
IF x1 < 1 THEN x1add = 1
IF x2 < 1 THEN x2add = 1
IF x3 < 1 THEN x3add = 1
IF x4 < 1 THEN x4add = 1
IF x5 < 1 THEN x5add = 1
IF x6 < 1 THEN x6add = 1
IF y1 > 199 THEN y1add = -1
IF y2 > 199 THEN y2add = -1
IF y3 > 199 THEN y3add = -1
IF y4 > 199 THEN y4add = -1
IF y5 > 199 THEN y5add = -1
IF y6 > 199 THEN y6add = -1
IF y1 < 1 THEN y1add = 1
IF y2 < 1 THEN y2add = 1
IF y3 < 1 THEN y3add = 1
IF y4 < 1 THEN y4add = 1
IF y5 < 1 THEN y5add = 1
IF y6 < 1 THEN y6add = 1

IF a1 > 319 THEN a1add = -1
IF a2 > 319 THEN a2add = -1
IF a3 > 319 THEN a3add = -1
IF a4 > 319 THEN a4add = -1
IF a5 > 319 THEN a5add = -1
IF a6 > 319 THEN a6add = -1
IF a1 < 1 THEN a1add = 1
IF a2 < 1 THEN a2add = 1
IF a3 < 1 THEN a3add = 1
IF a4 < 1 THEN a4add = 1
IF a5 < 1 THEN a5add = 1
IF a6 < 1 THEN a6add = 1
IF b1 > 239 THEN b1add = -1
IF b2 > 239 THEN b2add = -1
IF b3 > 239 THEN b3add = -1
IF b4 > 239 THEN b4add = -1
IF b5 > 239 THEN b5add = -1
IF b6 > 239 THEN b6add = -1
IF b1 < 1 THEN b1add = 1
IF b2 < 1 THEN b2add = 1
IF b3 < 1 THEN b3add = 1
IF b4 < 1 THEN b4add = 1
IF b5 < 1 THEN b5add = 1
IF b6 < 1 THEN b6add = 1

'start! = TIMER
'delay = .5
'WHILE TIMER < start! + delay: WEND


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

