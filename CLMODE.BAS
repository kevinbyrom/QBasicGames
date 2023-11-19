DECLARE SUB WaitLetGo ()
DECLARE FUNCTION SelectColor% (mode%, defclr%)
DECLARE SUB DisplayMsg (msg$)
DECLARE FUNCTION GetKeyMask% ()
DECLARE SUB drawborders ()
DECLARE SUB DoZoom ()
DECLARE SUB DoColors ()
' ** PICMAKER.BAS Picture Maker
' ** 1995 Kevin Byrom
' ** Requires: QBasic Extender TSR, Mouse
' **
DEFINT A-Z                             'set default variable type to integer

TYPE hues                              'define the type needed for hues
    red AS INTEGER                     'red component
  green AS INTEGER                     'green component
   blue AS INTEGER                     'blue component
END TYPE

DECLARE FUNCTION QBEX (ExtNum)         'TSR interface
DECLARE SUB FQBPut (Sprite(), image, x, y, mode)  'enhanced PUT command
DECLARE SUB millidelay (msecs)         'SUB to create delays
DECLARE SUB SetColors (pal() AS hues, fc, lc)     'SUB to modify palette
DECLARE FUNCTION CheckEscape ()        'function to monitor escape key
DECLARE FUNCTION WhichBox ()           'function to calculate clicked box
DECLARE FUNCTION YesOrNo ()            'function for Yes or No

'---------- define the variables used by the Extender TSR ----------
COMMON SHARED ExtKeyOfs, ExtKeySeg
COMMON SHARED MouseLeft, MouseRight, MouseX, MouseY
COMMON SHARED MinMX, MaxMX, MinMY, MaxMY
COMMON SHARED imagewidth, imageheight, UndoClipBoard()
COMMON SHARED CursorClr, CurrentClr, ZoomSx, ZoomSy, ZoomFact
COMMON SHARED pal() AS hues, ClipBoard(), PCXImage(), tmp()
'-------------------------------------------------------------------
CONST null$ = "", SelClr$ = "Select New Color"

IF NOT QBEX(0) THEN                    'verify presence of TSR
   PRINT "QBasic Extender TSR not found"
   END
END IF

IF NOT QBEX(1) THEN                    'verify presence of mouse
   PRINT "Mouse not found"
   END
END IF

SCREEN 9, 0, 0, 0                           '320x200 with 16 colors
RANDOMIZE TIMER                        'seed random number generator
millidelay 0                           'has to be initialized

10

x = 0
t = 0
DO
LOCATE 5
FOR c = 1 TO 15
  PALETTE c, c + (16 * t)
  LINE (x, 0)-(x + 9, 10), c, BF
  x = x + 10
COLOR c
PRINT c + (16 * t)
NEXT
x = 0
DO
LOOP UNTIL INKEY$ <> ""
t = t + 1
IF t > 3 THEN t = 0
LOOP

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

SUB DisplayMsg (msg$) STATIC
   ml = LEN(msg$)                                'message length
   IF ml THEN                                    'display it
      REDIM tmp(1281)                            'array to save area
      GET (0, 192)-(319, 199), tmp               'capture area
      col = 20 - (ml \ 2)                        'center it
      LOCATE 25, col
      COLOR 15
      PRINT msg$;                                'print it
   ELSE                                          'erase it
      PUT (0, 192), tmp, PSET                    'restore screen area
   END IF

END SUB

SUB DoColors
clr = 0
FOR y = 151 TO 187 STEP 12
  FOR x = 1 TO 37 STEP 12
      LINE (x, y)-(x + 11, y + 11), clr, BF
      clr = clr + 1
  NEXT
NEXT

END SUB

SUB DoZoom
FOR y = 0 TO 3
 FOR x = 0 TO 3
   LINE (202 + (x * 29), 1 + (y * 29))-(231 + (x * 29), 30 + (y * 29)), POINT(Zoomx + x, Zoomy + y), BF
 NEXT
NEXT

END SUB

SUB drawborders
CLS
LINE (0, 0)-(imageheight + 1, imagewidth + 1), 15, B
LINE (0, 150)-(319, 199), 15, B
LINE (201, 0)-(319, 118), 15, B
LINE (49, 150)-(49, 199), 15

END SUB

SUB FQBPut (Sprite(), image, x, y, mode)

   imagewidth = Sprite(0) / 8          'get the image width
   imageheight = Sprite(1)             'and height

   WWidth = imagewidth                 'assume full
   wx = x                              'assume its ok
   IF x < 0 THEN                       'partially off left side
      WWidth = imagewidth + x          'adjust work value
      wx = 0                           'ditto
      SourceOfs = ABS(x)               'adjust start point
   ELSEIF x + imagewidth > 320 THEN    'partially off right side
      WWidth = 320 - x                 'adjust work value
   END IF
                                       'if the value is bad
   IF WWidth < 0 THEN ERROR 5          'cause illegal function call error

   WHeight = imageheight               'assume full
   wy = y                              'assume its ok
   IF y < 0 THEN                       'partially off top
      WHeight = imageheight + y        'adjust work value
      wy = 0                           'ditto
      SourceOfs = SourceOfs + (ABS(y) * imagewidth)   'adjust start point
   ELSEIF y + imageheight > 200 THEN   'partially off bottom
      WHeight = 200 - y                'adjust work value
   END IF
                                       'if the value is bad
   IF WHeight < 0 THEN ERROR 5         'cause illegal function call error

   Elements = ((WWidth + 1) \ 2) * WHeight + 1   'calc- work image size
   REDIM WImage(Elements)                        'array for work image
   GET (wx, wy)-(wx - 1 + WWidth, wy - 1 + WHeight), WImage

   WSegment = VARSEG(WImage(0))                  'array's segment
   WOffset = 4                                   'offset to image data

   ElmPerImg = ((imagewidth + 1) \ 2) * imageheight + 2    'find the starting
   StartElm = ElmPerImg * image                            'element # in the
   SourceSeg = VARSEG(Sprite(StartElm))                    'source image
   SourceOfs = SourceOfs + VARPTR(Sprite(StartElm)) + 4    'skip size info
       
   SELECT CASE mode
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
            SourceOfs = SourceOfs + imagewidth   'ditto
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
            SourceOfs = SourceOfs + imagewidth   'ditto
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
            SourceOfs = SourceOfs + imagewidth   'ditto
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
            SourceOfs = SourceOfs + imagewidth   'ditto
         NEXT
   END SELECT

   PUT (wx, wy), WImage, PSET                    'display resulting image

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

SUB Nincolors

PALETTE 14, 7
PALETTE 12, 0

PALETTE 1, 36
PALETTE 3, 54
PALETTE 4, 42
PALETTE 5, 52
PALETTE 6, 11
PALETTE 7, 41
PALETTE 8, 28
PALETTE 9, 20
PALETTE 10, 39
PALETTE 11, 44
PALETTE 13, 56

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
      CASE 7
         ActMinMX = MinMX * 2
         ActMaxMX = MaxMX * 2
         CALL ABSOLUTE(ExtNum, ActMinMX, ActMaxMX, TSRofs)
      CASE 8
         CALL ABSOLUTE(ExtNum, MinMY, MaxMY, TSRofs)


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

FUNCTION SelectColor (mode, defclr)
   REDIM tmp(7034)                               'temp array
   GET (87, 51)-(231, 147), tmp                  'capture area
   IF mode THEN                                  'single?
      savmx = MouseX: savmy = MouseY             'save location
      MouseX = (defclr MOD 16) * 9 + 91          'point to current color
      MouseY = (defclr \ 16) * 6 + 54            'ditto
      z = QBEX(4)                                'set mouse location
      sminMX = MinMX: smaxMX = MaxMX             'save current limits
      sminMY = MinMY: smaxMY = MaxMY             'ditto
      MinMX = 0: MaxMX = 319                     'full screen
      z = QBEX(7)                                'set mouse X limits
      MinMY = 0: MaxMY = 199                     'full screen
      z = QBEX(8)                                'set mouse Y limits
   END IF
   MouseRight = 1                                'draw chart on first loop
   z = QBEX(5)                                   'mouse cursor on
   DO                                            'start selection loop
      IF MouseRight THEN                         'right click
         z = QBEX(6)                             'mouse cursor off
         IF chart THEN                           'pop it down
            PUT (87, 51), tmp, PSET              'restore screen area
         ELSE                                    'pop it up
            LINE (87, 51)-(231, 147), 0, BF      'clear area
            FOR y = 52 TO 142 STEP 6             'draw chart
               FOR x = 88 TO 223 STEP 9          'ditto
                  LINE (x, y)-(x + 7, y + 4), clr, BF
                  clr = clr + 1                  'next color
                  IF clr > 15 THEN clr = 0
               NEXT
            NEXT
         END IF
         z = QBEX(5)                             'mouse cursor on
         chart = NOT chart                       'toggle it
         WaitLetGo                               'wait for 'em to let go
      END IF
      z = QBEX(2)                                'get button status
      z = QBEX(3)                                'get mouse position
   LOOP UNTIL MouseLeft                          'wait for left click

   z = QBEX(6)                                   'mouse cursor off
   clicked = POINT(MouseX, MouseY)               'get color
   PUT (87, 51), tmp, PSET                       'restore screen area
   WaitLetGo                                     'wait for 'em to let go
  
   IF mode THEN                                  'single?
      MouseX = savmx: MouseY = savmy             'restore position
      z = QBEX(4)                                'set mouse position
      MinMX = sminMX: MaxMX = smaxMX             'reset limits
      MinMY = sminMY: MaxMY = smaxMY             'reset limits
      z = QBEX(7)                                'set mouse X limits
      z = QBEX(8)                                'set mouse Y limits
   ELSE                                          'group?
      clicked = (clicked \ 16) * 16              'first color in the group
   END IF
   SelectColor = clicked                         'return it

END FUNCTION

SUB SetColors (pal() AS hues, fc, lc)
      OUT &H3C8, fc                    'tell controller to get ready
   FOR t = fc TO lc                    'from first to last
      OUT &H3C9, pal(t).red            'send red component
      OUT &H3C9, pal(t).green          'send green component
      OUT &H3C9, pal(t).blue           'send blue component
   NEXT
END SUB

SUB WaitLetGo
   DO
      z = QBEX(2)                                     'get button status
   LOOP WHILE MouseLeft OR MouseRight OR GetKeyMask   'wait 'til user lets go

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
            wx = (MouseX - 13) \ 50              'calc box row 0 - 5
            wy = (MouseY - 10) \ 46              'calc box column 0 - 3
            box = wy * 6 + wx                    'calc box # 0 - 23
            IF MouseX < wx * 50 + 57 THEN        'make sure the click is
               IF MouseY < wy * 46 + 51 THEN EXIT DO       'inside a box
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

