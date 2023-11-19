' ** MATCHMAK.BAS - Match Maker
' ** 1993 Fred Sexton Jr.
' ** Requires: QBasic Extender TSR, Mouse
' **
DEFINT A-Z                             'set default variable type to integer

TYPE Hues                              'define the type needed for hues
    red AS INTEGER                     'red component
  green AS INTEGER                     'green component
   blue AS INTEGER                     'blue component
END TYPE

DECLARE FUNCTION QBEX (ExtNum)         'TSR interface
DECLARE SUB MilliDelay (msecs)         'SUB to create delays
DECLARE SUB SetColors (pal() AS Hues, fc, lc)     'SUB to modify palette
'---------- define the variables used by the Extender TSR ----------
COMMON SHARED ExtKeyOfs, ExtKeySeg
COMMON SHARED MouseLeft, MouseRight, MouseX, MouseY
COMMON SHARED MinMX, MaxMX, MinMY, MaxMY
'-------------------------------------------------------------------

IF NOT QBEX(0) THEN                    'verify presence of TSR
   PRINT "QBasic Extender TSR not found"
   END
END IF

IF NOT QBEX(1) THEN                    'verify presence of mouse
   PRINT "Mouse not found"
   END
END IF

SCREEN 13                              '320x200 with 256 colors
RANDOMIZE TIMER                        'seed random number generator
MilliDelay 0                           'has to be initialized

REDIM pal(256) AS Hues                 'dimension an array for the palette
DEF SEG = VARSEG(pal(0))               'point to it
BLOAD "mix.pal", 0                 'load the palette file into array

pal(0).red = 0                        'set color 0
pal(0).green = 0                      '            to a shade
pal(0).blue = 0                       '                       of gray
SetColors pal(), 0, 255                'set the system colors
md = 1
IF md = 0 THEN

DO
clr = INT(15 * RND) + 1
nclr = clr * 16
xm:
x = INT(320 * RND) + 1
x2 = INT(320 * RND) + 1
IF x > x2 THEN GOTO xm
ym:
y = INT(200 * RND) + 1
y2 = INT(200 * RND) + 1
IF y > y2 THEN GOTO ym

FOR i = 15 TO 1 STEP -1
    LINE (x - i, y - i)-(x2 + i, y2 + i), nclr + i, BF
NEXT
LOOP

END IF
IF md = 1 THEN

DO
  x = INT(320 * RND) + 1
  y = INT(200 * RND) + 1

  clr = INT(15 * RND) + 1
  nclr = clr * 16
 
  FOR i = 15 TO 0 STEP -1
  CIRCLE (x, y), i, nclr + i, , , 1 / 7
  NEXT
LOOP
END IF

SUB MilliDelay (msecs) STATIC

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
      CASE 1  'check for mouse
         CALL ABSOLUTE(ExtNum, Blank, Blank, TSRofs)
      CASE 2  'check mouse clicks
         CALL ABSOLUTE(ExtNum, MouseLeft, MouseRight, TSRofs)
      CASE 3 TO 4 'get / set mouse position
         MouseX = MouseX * 2           'adjust for screen mode
         CALL ABSOLUTE(ExtNum, MouseX, MouseY, TSRofs)
         MouseX = MouseX \ 2           'adjust for screen mode
      CASE 5  'turn mouse cursor on
         CALL ABSOLUTE(ExtNum, Blank, Blank, TSRofs)
      CASE 6  'turn mouse cursor off
         CALL ABSOLUTE(ExtNum, Blank, Blank, TSRofs)
      END SELECT
      QBEX = ExtNum
   ELSE
      REDIM ary(46)                         'array to hold machine code
      DEF SEG = VARSEG(ary(0))              'point to its seg
      BLOAD "CallMult.FPS", 0               'load machine code
      CALL ABSOLUTE(TSRofs, TSRseg, 0)      'call the code
      ERASE ary                             'done with the array
      IF TSRseg THEN                        'TSR was found
         QBEX = QBEX(0)                     'call Extender function 0
      ELSE                                  'TSR not found
         QBEX = 0                           'return false
      END IF
   END IF
END FUNCTION

SUB SetColors (pal() AS Hues, fc, lc)
      OUT &H3C8, fc                    'tell controller to get ready
   FOR t = fc TO lc                    'from first to last
      OUT &H3C9, pal(t).red            'send red component
      OUT &H3C9, pal(t).green          'send green component
      OUT &H3C9, pal(t).blue           'send blue component
   NEXT
END SUB

