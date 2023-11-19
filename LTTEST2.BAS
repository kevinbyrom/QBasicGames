DECLARE SUB Fqbput (sprite%(), image%, x%, y%, Mode%)
DECLARE SUB writeword (choice$(), mx1%, mx2%, my1%, my2%, mde%)
DECLARE SUB checkswitch ()
DECLARE SUB checkdeath ()
DECLARE SUB clearscreen (md%)
DECLARE SUB checkend ()
DECLARE SUB checkroll ()
DECLARE SUB drawlevel ()
DECLARE SUB lsprite (file$)
DECLARE SUB walk (dir%)
DECLARE SUB placeman (img%)
DECLARE SUB checkfall ()
DECLARE SUB checkwalk ()
DECLARE SUB jumpman ()
DECLARE SUB checkjump ()
' ** OVRBARRL.BAS
' ** 1993 Fred Sexton Jr.
' ** Requires: QBasic Extender TSR
' **
DEFINT A-Z                                       'default type = integer
TYPE Hues                                        'define type for hues
    red AS INTEGER                               'red component
  green AS INTEGER                               'green component
   blue AS INTEGER                               'blue component
END TYPE

DECLARE FUNCTION QBEX (ExtNum)                   'TSR interface
DECLARE SUB BldScreen (AddRow, AddCol)           'SUB to update screen
DECLARE SUB JumpBoy ()                           'SUB to jump boy
DECLARE SUB millidelay (msecs)                   'SUB to create delays
DECLARE SUB Restart ()                           'SUB to restart game
DECLARE SUB SetColors (pal() AS Hues, fc, lc)    'SUB to modify palette
DECLARE SUB ShowTreasure ()                      'SUB to show the treasure
DECLARE SUB ShowMap ()                           'SUB to show the map
DECLARE SUB TitleScreen (cfg)                    'SUB to display title screen
DECLARE SUB WaitLetGo ()                         'SUB to give user time
DECLARE SUB WalkBoy (way, dFlag)                 'SUB to move boy
DECLARE FUNCTION GetKeyMask ()                   'FUNCTION to handle keyboard
DECLARE FUNCTION MoveBarrel (br, bc, dr)         'FUNCTION to move barrels
DECLARE FUNCTION PullDown ()                     'FUNCTION for menu
'---------- define the variables used by the Extender TSR ----------
COMMON SHARED ExtKeyOfs, ExtKeySeg
COMMON SHARED filename$, FileSize&
'-------------------------------------------------------------------
COMMON SHARED x, y, ok, boysprite(), boyepi, CurBoy     'define all the commons
COMMON SHARED rollx, rolly, level, land, boydir, jok, jump, jumpheight      'ditto
COMMON SHARED ld, sw, sw2, resrv(), choice$(), n
IF NOT QBEX(0) THEN                              'verify presence of TSR
   PRINT "QBasic Extender TSR not found"
   END
END IF

SCREEN 13                                        '320 x 200 w/256 colors
millidelay 0                                     'initialize
REDIM pal(255) AS Hues                           'array for palette
DEF SEG = VARSEG(pal(0))                         'point to it
BLOAD "mix.PAL", 0                           'load from file
pal(0).red = 10                                  'set background
pal(0).green = 10                                'to a dark shade
pal(0).blue = 15                                 'of blue gray

pal(1).red = 60                                  'set background
pal(1).green = 60                               'to a dark shade
pal(1).blue = 60                                 'of blue gray

pal(2).red = 0                                  'set background
pal(2).green = 0                                'to a dark shade
pal(2).blue = 30                                 'of blue gray

pal(3).red = 0                                  'set background
pal(3).green = 30                                'to a dark shade
pal(3).blue = 30                                 'of blue gray


SetColors pal(), 0, 255                          'set system colors




lsprite "alphae"
LINE (0, 0)-(320, 200), 5
DIM word$(1 TO 3)
word$(1) = "FIGHT"
word$(2) = "RUN"
word$(3) = "MAGIC"


writeword word$(), 30, 35, 3, 3, 3
PRINT n


SUB checkdeath
death = 0

IF level = 1 THEN
IF x > 190 AND x < 320 AND y = 160 THEN death = 1
END IF
IF level = 2 THEN
IF x >= 20 AND x <= 80 AND y = 160 THEN death = 1
IF x >= 120 AND y = 160 THEN death = 1
IF x >= 210 AND x <= 226 AND y = 100 THEN death = 1
IF x >= 254 AND x <= 270 AND y = 100 THEN death = 1
END IF
IF level = 3 THEN
IF y = 160 THEN death = 1
END IF
IF level = 4 THEN
IF y = 160 THEN death = 1
END IF
IF death = 1 THEN
   DO
   FOR i = 6 TO 9
   thiskey = GetKeyMask
   PUT (x, y), boysprite(i * boyepi), PSET
   millidelay 110
   NEXT
   LOOP UNTIL thiskey
   clearscreen INT(2 * RND) + 1
   END
   
END IF


END SUB

SUB checkend

ld = 0
IF level = 0 THEN
IF y >= 178 THEN ld = 1
END IF

IF level = 1 THEN
IF x > 279 AND y < 70 THEN
ld = 1
END IF
END IF
IF level = 2 THEN
IF x > 226 AND x < 254 AND y = 100 THEN
ld = 1
END IF
END IF
IF level = 3 THEN
IF x >= 200 AND y = 20 OR x >= 240 AND y = 20 THEN
ld = 1

END IF
END IF
IF level = 4 THEN
IF x = 280 AND y = 20 THEN ld = 1
END IF

END SUB

SUB checkfall
FOR i = 0 TO 29
    a = POINT(x + i, y + 30)
    IF a > 0 THEN GOTO nofall
NEXT
SOUND 300 - y, .125
y = y + 1
land = 1
IF boydir = 1 THEN placeman 1
IF boydir = -1 THEN placeman 2
millidelay 10
GOTO 20
nofall:
land = 0
IF boydir = 1 THEN placeman 1
IF boydir = -1 THEN placeman 2
millidelay 10
20

END SUB

SUB checkjump
FOR i = 0 TO 29
    a = POINT(x + i, y - 2)
    IF y < 1 THEN GOTO endjump
    IF a > 0 THEN GOTO endjump
NEXT
y = y - 1

jump = jump - 1
SOUND 300 - jump, .125
IF boydir = 1 THEN placeman 2
IF boydir = -1 THEN placeman 3
GOTO 10

endjump:
jump = 0
IF boydir = 1 THEN placeman 0
IF boydir = -1 THEN placeman 1

10

END SUB

SUB checkroll

   rollx = 0
   rolly = 0

  
   FOR i = 0 TO 29
   a = POINT(x + 30, y + i)
   IF a > 0 THEN GOTO noroll
   IF x = 300 THEN GOTO noroll
   NEXT

   FOR i = 0 TO 29
   a = POINT(x - 2, y + i)
   IF a > 0 THEN GOTO noroll
   IF x = 0 THEN GOTO noroll
   NEXT


IF level = 1 THEN
   
   IF x >= 138 AND x <= 160 AND y = 120 THEN rollx = -1
   IF x >= 158 AND x <= 202 AND y = 90 THEN rollx = 1
   IF x >= 298 AND x <= 242 AND y = 90 THEN rollx = -1
   IF x >= 238 AND x <= 282 AND y = 90 THEN rollx = 1


END IF
IF level = 3 THEN
   IF x >= 14 AND x <= 179 AND y = 100 THEN rollx = boydir
   IF x >= 160 AND x <= 282 AND y = 60 THEN rollx = boydir
   IF x >= 180 AND x <= 262 AND y = 20 THEN rollx = boydir

END IF
noroll:
END SUB

SUB checkswitch
IF level = 4 THEN
   IF x >= 72 AND x <= 92 AND y = 120 THEN
      LINE (x, y)-(x + 19, y + 19), 0, BF
      FOR s = 1000 TO 150 STEP -20
          SOUND s, .125
      NEXT

      x = 300
      y = 120
   ELSEIF x >= 288 AND x <= 300 AND y = 120 THEN
      LINE (x, y)-(x + 19, y + 19), 0, BF
      FOR s = 1000 TO 150 STEP -20
          SOUND s, .125
      NEXT

      x = 80
      y = 120
   ELSEIF x >= 220 AND x <= 230 AND y = 120 THEN
      IF sw = 0 THEN
      lsprite "block01"
      PUT (220, 140), boysprite(10 * boyepi), PSET
      PUT (160, 40), boysprite(0 * boyepi), PSET
      PUT (180, 40), boysprite(0 * boyepi), PSET
      lsprite "hero01"
      END IF
      IF sw = 1 THEN
      LINE (160, 40)-(199, 60), 0, BF
      lsprite "block01"
      PUT (220, 140), boysprite(9 * boyepi), PSET
      lsprite "hero01"
      END IF
      sw = sw + 1
      IF sw = 2 THEN sw = 0
   ELSEIF x >= 220 AND x <= 236 AND y = 60 THEN
      IF sw2 = 0 THEN
      lsprite "block01"
      PUT (220, 80), boysprite(10 * boyepi), PSET
      PUT (220, 40), boysprite(0 * boyepi), PSET
      lsprite "hero01"
      END IF
      IF sw2 = 1 THEN
      LINE (220, 40)-(239, 60), 0, BF
      lsprite "block01"
      PUT (220, 80), boysprite(9 * boyepi), PSET
      lsprite "hero01"
      END IF
      sw2 = sw2 + 1
      IF sw2 = 2 THEN sw2 = 0

   END IF
   
END IF

END SUB

SUB checkwalk
ok = 0
IF boydir = 1 THEN
   FOR i = 0 TO 29
   a = POINT(x + 31, y + i)
   IF a > 0 THEN GOTO nowalk
   IF x >= 289 THEN GOTO nowalk
   NEXT
ok = 1
ELSEIF boydir = -1 THEN
   FOR i = 0 TO 29
   a = POINT(x - 2, y + i)
   IF a > 0 THEN GOTO nowalk
   IF x = 0 THEN GOTO nowalk
   NEXT
ok = 1
END IF
nowalk:
END SUB

SUB choices
'lx = mx1
'ly = my1
'begphr = 1

'DIM resrv(1 TO (((mx2 - mx1) * 10 + mx1 + 1 - (mx1 - 2))) * (((my2 * 10) + 1) - (mx2 - mx1)))
'GET (mx1 - 2, (my1 * 10) - 12)-((mx2 - mx1) * 10 + mx1 + 1, (my2 * 10) + 1), resrv

'IF mde = 0 THEN LINE (mx1 - 2, (my1 * 10) - 12)-((mx2 - mx1) * 10 + mx1 + 1, (my2 * 10) + 1), 2, B


'DO

' st = (mx2 - mx1) + (begphr) + 1
                       
' DO

'  st = st - 1
'  IF st = 1 THEN GOTO endw

'  IF st <= LEN(phrase$) THEN l$ = MID$(phrase$, st, st)

' LOOP UNTIL ASC(l$) = 95

' endphr = st

' FOR i = begphr TO endphr

'  ltr$ = MID$(phrase$, i, i)
'  IF i > LEN(phrase$) THEN GOTO endw
'  img = ASC(ltr$) - 65

'  IF ASC(ltr$) <> 95 THEN
'  IF ASC(ltr$) = 33 THEN img = 27
'  IF ASC(ltr$) = 45 THEN img = 26
'  IF mde = 0 THEN PUT (lx, (ly * 10) - 10), boysprite(img * boyepi), PSET
'  IF mde = 1 THEN Fqbput boysprite(), img, lx, (ly * 10) - 10, 0
'  END IF
'  lx = lx + 10


'  SOUND 150, .5

'   FOR T = 1 TO 5000
'   NEXT


' NEXT

' begphr = endphr + 1
' ly = ly + 1
' IF ly > my2 THEN
'    DO
'     thiskey = GetKeyMask
'    LOOP UNTIL thiskey
'    LINE (mx1 - 1, (my1 * 10) - 11)-((mx2 - mx1) * 10 + mx1, (my2 * 10)), 0, BF
'    ly = my1
' END IF
' lx = mx1
'endw:
'LOOP UNTIL endphr >= LEN(phrase$)
'DO
'thiskey = GetKeyMask
'LOOP UNTIL thiskey

'PUT (mx1 - 2, (my1 * 10) - 12), resrv, PSET

END SUB

SUB clearscreen (md)
IF md = 1 THEN
x1 = 0
x2 = 319
y1 = 0
y2 = 199

DO
LINE (x1, y1)-(x2, y2), 0, B
x1 = x1 + 1
x2 = x2 - 1
y1 = y1 + 1
y2 = y2 - 1
millidelay 20
LOOP WHILE x1 < 161
END IF
IF md = 2 THEN
x1 = 160
x2 = 160
y1 = 100
y2 = 100
DO
LINE (x1, 0)-(x1, 199), 0
LINE (x2, 0)-(x2, 199), 0
LINE (0, y1)-(319, y1), 0
LINE (0, y2)-(319, y2), 0
x1 = x1 + 1
x2 = x2 - 1
y1 = y1 + 1
y2 = y2 - 1
millidelay 20
LOOP WHILE x2 > 0
END IF

END SUB

SUB drawlevel

IF level = 0 THEN
lsprite "block01"
land = 0
boydir = 1                                       'face right at startup
x = 120: y = 70

PUT (120, 90), boysprite(14 * boyepi), PSET
PUT (140, 90), boysprite(15 * boyepi), PSET
PUT (160, 90), boysprite(16 * boyepi), PSET
PUT (180, 90), boysprite(17 * boyepi), PSET


END IF


IF level = 1 THEN
lsprite "block01"
land = 0
boydir = 1                                       'face right at startup
x = 0: y = 160

FOR i = 0 TO 140 STEP 20
PUT (0, i), boysprite(0 * boyepi), PSET
NEXT

FOR i = 0 TO 180 STEP 20
PUT (i, 180), boysprite(0 * boyepi), PSET
NEXT
FOR i = 200 TO 300 STEP 20
PUT (i, 180), boysprite(8 * boyepi), PSET
NEXT

PUT (157, 140), boysprite(1 * boyepi), PSET
PUT (178, 110), boysprite(2 * boyepi), PSET
PUT (219, 110), boysprite(1 * boyepi), PSET
PUT (260, 110), boysprite(2 * boyepi), PSET

PUT (280, 70), boysprite(0 * boyepi), PSET
PUT (300, 70), boysprite(0 * boyepi), PSET
PUT (300, 50), boysprite(13 * boyepi), PSET
lsprite "man01"

FOR i = 1 TO 10

walk 1
millidelay 10
NEXT
lsprite "block01"
PUT (0, 160), boysprite(12 * boyepi), PSET
SOUND 150, .5

END IF
IF level = 2 THEN
lsprite "block01"
land = 0
boydir = 1                                       'face right at startup
x = 0: y = 80

FOR i = 0 TO 180 STEP 20
PUT (0, i), boysprite(0 * boyepi), PSET
NEXT

FOR i = 20 TO 300 STEP 20
PUT (i, 180), boysprite(8 * boyepi), PSET
NEXT
LINE (0, 80)-(19, 99), 0, BF

PUT (20, 100), boysprite(0 * boyepi), PSET
PUT (100, 180), boysprite(0 * boyepi), PSET
PUT (100, 160), boysprite(6 * boyepi), PSET
PUT (140, 100), boysprite(0 * boyepi), PSET
PUT (160, 120), boysprite(6 * boyepi), PSET
PUT (240, 140), boysprite(0 * boyepi), PSET
PUT (220, 140), boysprite(0 * boyepi), PSET
PUT (260, 140), boysprite(0 * boyepi), PSET
PUT (220, 120), boysprite(8 * boyepi), PSET
PUT (260, 120), boysprite(8 * boyepi), PSET
PUT (240, 120), boysprite(13 * boyepi), PSET
'PUT (220, 60), boysprite(2 * boyepi), PSET

lsprite "man01"

FOR i = 1 TO 10

walk 1
millidelay 10
NEXT
lsprite "block01"
PUT (0, 80), boysprite(12 * boyepi), PSET
SOUND 150, .5


END IF
IF level = 3 THEN
lsprite "block01"
land = 0
boydir = 1                                       'face right at startup
x = 0: y = 100
FOR i = 20 TO 300 STEP 20
PUT (i, 180), boysprite(8 * boyepi), PSET
NEXT

FOR i = 20 TO 160 STEP 20
PUT (i, 120), boysprite(7 * boyepi), PSET
NEXT
FOR i = 180 TO 260 STEP 20
PUT (i, 80), boysprite(7 * boyepi), PSET
NEXT
FOR i = 200 TO 240 STEP 20
PUT (i, 40), boysprite(7 * boyepi), PSET
NEXT
PUT (220, 0), boysprite(7 * boyepi), PSET
FOR i = 0 TO 180 STEP 20
PUT (0, i), boysprite(0 * boyepi), PSET
NEXT
PUT (220, 20), boysprite(13 * boyepi), PSET
LINE (0, 119)-(20, 100), 0, BF
lsprite "man01"

FOR i = 1 TO 10

walk 1
millidelay 10
NEXT
lsprite "block01"
PUT (0, 100), boysprite(12 * boyepi), PSET
SOUND 150, .5

END IF

IF level = 4 THEN
sw = 0
sw2 = 0
lsprite "block01"
land = 0
boydir = 1                                       'face right at startup
x = 0: y = 120
FOR i = 0 TO 180 STEP 20
PUT (0, i), boysprite(0 * boyepi), PSET
NEXT
FOR i = 20 TO 300 STEP 20
PUT (i, 180), boysprite(8 * boyepi), PSET
NEXT
LINE (0, 120)-(20, 139), 0, BF
FOR i = 20 TO 60 STEP 20
PUT (i, 140), boysprite(0 * boyepi), PSET
NEXT
PUT (80, 140), boysprite(5 * boyepi), PSET
PUT (20, 100), boysprite(6 * boyepi), PSET
FOR i = 40 TO 300 STEP 20
PUT (i, 40), boysprite(0 * boyepi), PSET
NEXT
FOR i = 60 TO 300 STEP 20
PUT (i, 0), boysprite(0 * boyepi), PSET
NEXT
LINE (160, 40)-(199, 60), 0, BF
FOR i = 60 TO 140 STEP 20
PUT (200, i), boysprite(0 * boyepi), PSET
NEXT
FOR i = 240 TO 280 STEP 20
PUT (i, 140), boysprite(0 * boyepi), PSET
NEXT
PUT (300, 140), boysprite(5 * boyepi), PSET
PUT (220, 140), boysprite(9 * boyepi), PSET
PUT (300, 20), boysprite(13 * boyepi), PSET
PUT (220, 80), boysprite(9 * boyepi), PSET
LINE (220, 40)-(239, 60), 0, BF
lsprite "man01"

FOR i = 1 TO 10

walk 1
millidelay 10
NEXT
lsprite "block01"
PUT (0, 120), boysprite(12 * boyepi), PSET
SOUND 150, .5

END IF
END SUB

SUB Fqbput (sprite(), image, x, y, Mode)
  
   ImageWidth = sprite(0) / 8          'get the image width
   ImageHeight = sprite(1)             'and height

   WWidth = ImageWidth                 'assume full
   WX = x                              'assume its ok
   IF x < 0 THEN                       'partially off left side
      WWidth = ImageWidth + x          'adjust work value
      WX = 0                           'ditto
      SourceOfs = ABS(x)               'adjust start point
   ELSEIF x + ImageWidth > 320 THEN    'partially off right side
      WWidth = 320 - x                 'adjust work value
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

FUNCTION GetKeyMask

   DEF SEG = ExtKeySeg                           'point to QBEX's data
   l = PEEK(ExtKeyOfs + 75) AND 1                'cursor left
   U = PEEK(ExtKeyOfs + 72) AND 2                'cursor up
   r = PEEK(ExtKeyOfs + 77) AND 4                'cursor right
  
   D = PEEK(ExtKeyOfs + 80) AND 8                'cursor down
   Ent = PEEK(ExtKeyOfs + 28) AND 16             'Enter
   SB = PEEK(ExtKeyOfs + 57) AND 32              'Space Bar
   Esc = PEEK(ExtKeyOfs + 1) AND 64              'Escape
   B = PEEK(ExtKeyOfs + 48) AND 128              'the B key

   DEF SEG = &H40                      'point head to tail thus emptying
   POKE &H1A, PEEK(&H1C)               'the keyboard buffer

   GetKeyMask = l OR U OR r OR D OR Ent OR SB OR Esc OR B
      
END FUNCTION

SUB jumpman
checkjump
IF jump < 0 THEN
 
   jump = 45
   IF level = 2 THEN
     IF x >= 90 AND x <= 108 AND y >= 139 THEN jump = 90
     IF x >= 160 AND x <= 180 AND y >= 99 THEN jump = 90
   END IF
   IF level = 4 THEN
     IF x >= 20 AND x <= 40 AND y = 79 THEN jump = 90
   END IF


END IF
END SUB

SUB lsprite (file$)

filename$ = file$ + ".spr"
IF NOT QBEX(9) THEN END                          'get its size
ldelm = (FileSize& - 7) \ 2 - 1                  'calc array size
REDIM boysprite(ldelm)                           'array for boy
DEF SEG = VARSEG(boysprite(0))                   'point to it
BLOAD filename$, 0                               'load from file
boyepi = ((boysprite(0) \ 8) * boysprite(1)) \ 2 + 2  'elements per image



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

SUB placeman (img)
PUT (x, y), boysprite(img * boyepi), PSET

END SUB

FUNCTION QBEX (ExtNum) STATIC
   IF TSRseg THEN
      DEF SEG = TSRseg
      SELECT CASE ExtNum
      CASE 0  'get key table address
         CALL ABSOLUTE(ExtNum, ExtKeyOfs, ExtKeySeg, TSRofs)
      CASE 9 'check if file exists - if so return size
         CALL ABSOLUTE(ExtNum, filename$, FileSize&, TSRofs)
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
   FOR T = fc TO lc                              'from first to last
      OUT &H3C9, pal(T).red                      'send red component
      OUT &H3C9, pal(T).green                    'send green component
      OUT &H3C9, pal(T).blue                     'send blue component
   NEXT
END SUB

SUB WaitLetGo
   DO: LOOP WHILE GetKeyMask                     'wait 'til user lets go
END SUB

SUB walk (dir)
checkwalk

IF dir = 1 THEN
   IF boydir = -1 THEN
      boydir = 1
      placeman 1
      millidelay 10
   ELSEIF boydir = 1 AND ok = 1 THEN
      x = x + 2
      placeman 3
      IF land > 0 THEN checkfall
      millidelay 20
      placeman 1
      IF land > 0 THEN checkfall
      millidelay 10
   END IF
ELSEIF dir = -1 THEN
  IF boydir = 1 THEN
      boydir = -1
      placeman 2
      millidelay 10
   ELSEIF boydir = -1 AND ok = 1 THEN
      x = x - 2
      placeman 4
      IF land > 0 THEN checkfall
      millidelay 20
      placeman 2
      IF land > 0 THEN checkfall
      millidelay 10
   END IF
END IF

END SUB

SUB writeword (choice$(), mx1, mx2, my1, my2, max)

lx = mx1
ly = my1
fword = 1


LINE (mx1 - 2, (my1 * 10) - 12)-((mx2 - mx1) * 10 + mx1 + 1, (my2 * 10) + 1), 2, B
LINE (mx1 - 1, (my1 * 10) - 11)-((mx2 - mx1) * 10 + mx1, (my2 * 10)), 0, BF

n = 1
DO


  FOR i = 1 TO LEN(choice$(n))
  
   ltr$ = MID$(choice$(n), i, i)
   IF i > LEN(choice$(n)) THEN GOTO noword
   img = ASC(ltr$) - 65

   IF ASC(ltr$) <> 95 THEN
    IF ASC(ltr$) = 33 THEN img = 27
    IF ASC(ltr$) = 45 THEN img = 26
    PUT (lx, (ly * 10) - 10), boysprite(img * boyepi), PSET
   END IF
 
   lx = lx + 10


  SOUND 150, .5
 
   FOR T = 1 TO 5000
   NEXT


 NEXT


 lx = mx1

DO
thiskey = GetKeyMask
LOOP UNTIL thiskey
LINE (mx1 - 1, (my1 * 10) - 11)-((mx2 - mx1) * 10 + mx1, (my2 * 10)), 0, BF


IF thiskey AND 2 THEN
   n = n - 1
   IF n < 1 THEN n = max
END IF
IF thiskey AND 8 THEN
   n = n + 1
   IF n > max THEN n = 1
END IF

noword:
LOOP UNTIL thiskey AND 16



END SUB

