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
DECLARE SUB fqbput (sprite(), image, x, y, Mode)  'enhanced PUT command
DECLARE SUB MilliDelay (msecs)         'SUB to create delays
DECLARE SUB SetColors (pal() AS Hues, fc, lc)     'SUB to modify palette
DECLARE FUNCTION CheckEscape ()        'function to monitor escape key
DECLARE FUNCTION WhichBox ()           'function to calculate clicked box
DECLARE FUNCTION YesOrNo ()            'function for Yes or No

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

REDIM pal(16) AS Hues                 'dimension an array for the palette
DEF SEG = VARSEG(pal(0))               'point to it
BLOAD "DEFAULT.PAL", 0                 'load the palette file into array

pal(0).red = 20                        'set color 0
pal(0).green = 20                      '            to a shade
pal(0).blue = 20                       '                       of gray
SetColors pal(), 0, 15                'set the system colors


REDIM kids(911)                       'dimension an array for the images
DEF SEG = VARSEG(kids(0))              'point to it
BLOAD "mode12.spr", 0                    'load the image file into array



fqbput kids(), 0, x, 0, 3

FUNCTION CheckEscape

   DEF SEG = ExtKeySeg                 'point to QBEX's data
   Escape = PEEK(ExtKeyOfs + 1)        'peek into table

   DEF SEG = &H40                      'point head to tail thus emptying
   POKE &H1A, PEEK(&H1C)               'the keyboard buffer
 
   DEF SEG                             'reset to default seg
   POKE VARPTR(Escape) + 1, Escape     'extend to word by
                                       'copying low byte into high byte
   CheckEscape = Escape                'True if pressed
END FUNCTION

SUB fqbput (sprite(), image, x, y, Mode)

   ImageWidth = sprite(0) / 8          'get the image width
   ImageHeight = sprite(1)             'and height

   WWidth = ImageWidth                 'assume full
   WX = x                              'assume its ok
   IF x < 0 THEN                       'partially off left side
      WWidth = ImageWidth + x          'adjust work value
      WX = 0                           'ditto
      SourceOfs = ABS(x)               'adjust start point
   ELSEIF x + ImageWidth > 160 THEN    'partially off right side
      WWidth = 160 - x                 'adjust work value
   END IF
                                       'if the value is bad
   IF WWidth < 0 THEN ERROR 5          'cause illegal function call error

   WHeight = ImageHeight               'assume full
   WY = y                              'assume its ok
   IF y < 0 THEN                       'partially off top
      WHeight = ImageHeight + y        'adjust work value
      WY = 0                           'ditto
      SourceOfs = SourceOfs + (ABS(y) * ImageWidth)   'adjust start point
   ELSEIF y + ImageHeight > 200 THEN   'partially off bottom
      WHeight = 200 - y                'adjust work value
   END IF
                                       'if the value is bad
   IF WHeight < 0 THEN ERROR 5         'cause illegal function call error

   Elements = ((WWidth + 1) \ 2) * WHeight + 1   'calc- work image size
   REDIM WImage(Elements)                        'array for work image
   GET (WX, WY)-(WX - 1 + WWidth, WY - 1 + WHeight), WImage

   WSegment = VARSEG(WImage(0))                  'array's segment
   WOffset = 4                                   'offset to image data

   ElmPerImg = ((ImageWidth + 1) \ 2) * ImageHeight + 2    'find the starting
   StartElm = ElmPerImg * image                            'element # in the
   SourceSeg = VARSEG(sprite(StartElm))                    'source image
   SourceOfs = SourceOfs + VARPTR(sprite(StartElm)) + 4    'skip size info
       
   SELECT CASE Mode
      CASE 0                                     'in front
         FOR py = 1 TO WHeight                   'from top to bottom
            FOR px = 0 TO WWidth - 1             'from left to right
               DEF SEG = SourceSeg
               sc = PEEK(SourceOfs + px)         'check source
               IF sc THEN                        'if its not 0
                  DEF SEG = WSegment
                  POKE WOffset + px, sc          'put it into work image
               END IF
            NEXT
            WOffset = WOffset + WWidth           'adjust
            SourceOfs = SourceOfs + ImageWidth   'ditto
         NEXT
      CASE 1                                     'behind
         FOR py = 1 TO WHeight                   'from top to bottom
            FOR px = 0 TO WWidth - 1             'from left to right
               DEF SEG = SourceSeg
               sc = PEEK(SourceOfs + px)         'get source
               DEF SEG = WSegment
               wc = PEEK(WOffset + px)           'get dest-
               IF wc = 0 THEN                    'if dest- is 0
                  POKE WOffset + px, sc          'replace with source
               END IF
            NEXT
            WOffset = WOffset + WWidth           'adjust
            SourceOfs = SourceOfs + ImageWidth   'ditto
         NEXT
      CASE 2                                     'XOR
         FOR py = 1 TO WHeight                   'from top to bottom
            FOR px = 0 TO WWidth - 1             'from left to right
               DEF SEG = SourceSeg
               sc = PEEK(SourceOfs + px)         'get source
               DEF SEG = WSegment
               wc = PEEK(WOffset + px)           'get dest
               POKE WOffset + px, wc XOR sc      'put the XOR result
            NEXT
            WOffset = WOffset + WWidth           'adjust
            SourceOfs = SourceOfs + ImageWidth   'ditto
         NEXT
      CASE 3                                     'PSET
         FOR py = 1 TO WHeight                   'from top to bottom
            FOR px = 0 TO WWidth - 1             'from left to right
               DEF SEG = SourceSeg
               sc = PEEK(SourceOfs + px)         'get source
               DEF SEG = WSegment
               POKE WOffset + px, sc             'put in dest-
            NEXT
            WOffset = WOffset + WWidth           'adjust
            SourceOfs = SourceOfs + ImageWidth   'ditto
         NEXT
   END SELECT

   PUT (WX, WY), WImage, PSET                    'display resulting image

END SUB

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

FUNCTION WhichBox
   z = QBEX(5)                         'turn on mouse cursor
   DO
      DO                               'click loop
         IF CheckEscape THEN           'if escape is pressed
            z = QBEX(6)                'MUST turn off mouse cursor
            END                        'end the game
         END IF
         z = QBEX(2)                   'get mouse button status
         z = QBEX(3)                   'get mouse position
      LOOP UNTIL MouseLeft             'wait for a click

      DO
         z = QBEX(2)                   'if they hold button
      LOOP WHILE MouseLeft             'wait for them to let go

      IF MouseX > 12 AND MouseX < 306 THEN       'has to be inside border
         IF MouseY > 9 AND MouseY < 188 THEN     'ditto
            WX = (MouseX - 13) \ 50              'calc box row 0 - 5
            WY = (MouseY - 10) \ 46              'calc box column 0 - 3
            box = WY * 6 + WX                    'calc box # 0 - 23
            IF MouseX < WX * 50 + 57 THEN        'make sure the click is
               IF MouseY < WY * 46 + 51 THEN EXIT DO       'inside a box
            END IF                               'not on a border
         END IF
      END IF
   LOOP

   z = QBEX(6)                         'turn off mouse cursor
   WhichBox = box                      'return the box number

END FUNCTION

FUNCTION YesOrNo

DO
   DEF SEG = ExtKeySeg                 'point to QBEX's data
   y = PEEK(ExtKeyOfs + 21)            'check status in QBEX's key table.
   N = PEEK(ExtKeyOfs + 49)            'ditto
   DEF SEG = &H40                      'point head to tail thus emptying
   POKE &H1A, PEEK(&H1C)               'the keyboard buffer
LOOP UNTIL y OR N

   DEF SEG                             'reset to default seg
   POKE VARPTR(y) + 1, y               'extend to word by
                                       'copying low byte into high byte
   YesOrNo = y                         'True if yes

END FUNCTION

