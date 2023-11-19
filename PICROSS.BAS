DECLARE SUB begin ()
DECLARE SUB emailme ()
DECLARE SUB Centerprint (A$, row%, clr%)
DECLARE SUB previews ()
DECLARE SUB selectmd ()
DECLARE SUB title ()
DECLARE SUB checkend ()
DECLARE SUB placenum ()
DECLARE SUB exposeline ()
DECLARE SUB randboard ()
DECLARE SUB lsprite (file$)






DEFINT A-Z                                       'default type = integer
TYPE Hues                                        'define type for hues
    red AS INTEGER                               'red component
  green AS INTEGER                               'green component
   blue AS INTEGER                               'blue component
END TYPE

DECLARE FUNCTION QBEX (ExtNum)                   'TSR interface
DECLARE SUB millidelay (msecs)                   'SUB to create delays
DECLARE SUB SetColors (pal() AS Hues, fc, lc)    'SUB to modify palette
DECLARE SUB WaitLetGo ()                         'SUB to give user time
DECLARE FUNCTION GetKeyMask ()                   'FUNCTION to handle keyboard
'---------- define the variables used by the Extender TSR ----------
COMMON SHARED ExtKeyOfs, ExtKeySeg
COMMON SHARED filename$, FileSize&
'-------------------------------------------------------------------
COMMON SHARED stime$, timem, times1, times2, x, y, dbrd(), brd(), max, boysprite(), boyepi'define all the commons

IF NOT QBEX(0) THEN                              'verify presence of TSR
   PRINT "QBasic Extender TSR not found"
   END
END IF
RANDOMIZE TIMER
SCREEN 13                                        '320 x 200 w/256 colors
millidelay 0                                     'initialize
REDIM pal(255) AS Hues                           'array for palette
DEF SEG = VARSEG(pal(0))                         'point to it
BLOAD "mix.pal", 0                           'load from file
pal(0).red = 10                                  'set background
pal(0).green = 10                                'to a dark shade
pal(0).blue = 15                                 'of blue gray
SetColors pal(), 0, 255                          'set system colors
begin
lsprite "pcttl"
title
emailme
selectmd

lsprite "picross"

DIM dbrd(1 TO 10, 1 TO 10)
DIM brd(1 TO 10, 1 TO 10)

FOR y = 1 TO 10
   FOR x = 1 TO 10
     dbrd(x, y) = 2
     brd(x, y) = 0
   NEXT
NEXT

max = INT(40 * RND) + 30
randboard
placenum


FOR t = 1 TO 10
        FOR s = 1 TO 10
            IF brd(s, t) = 0 THEN img = 0
            IF brd(s, t) = 2 THEN img = 11
            IF brd(s, t) = 1 THEN img = 12
          
            PUT ((s * 10) + 60, (t * 10) + 60), boysprite(img * boyepi), PSET

         NEXT
NEXT

exposeline
timem = 10
times1 = 0
times2 = 0
TIME$ = "00:00:00"
x = 1
y = 1
DO
FOR t = 1 TO 10
        FOR s = 1 TO 10
            IF brd(s, t) = 0 THEN img = 0
            IF brd(s, t) = 2 THEN img = 11
            IF brd(s, t) = 1 THEN img = 12
           
            PUT ((s * 10) + 60, (t * 10) + 60), boysprite(img * boyepi), PSET

         NEXT
NEXT
LINE ((x * 10) + 60, (y * 10) + 60)-((x * 10 + 9) + 60, (y * 10 + 9) + 60), 1, B

DO
LOCATE 1
IF TIME$ = "00:00:01" THEN
   times2 = times2 - 1
   IF timem = 0 AND times1 = 0 AND times2 = 0 THEN
   lsprite "pcttl"
   PUT (250, 10), boysprite(2 * boyepi), PSET
   SLEEP 3
   END
   END IF
   IF times2 < 0 THEN
      times2 = 9
      IF timem = 0 AND times1 = 0 THEN GOTO notime
      times1 = times1 - 1
notime:
       
   END IF
   IF times1 < 0 AND timem > 0 THEN
      times1 = 5
      timem = timem - 1
   END IF
   TIME$ = "00:00:00"
END IF
PUT (10, 10), boysprite(timem * boyepi), PSET
PUT (20, 10), boysprite(times1 * boyepi), PSET
PUT (30, 10), boysprite(times2 * boyepi), PSET

thiskey = GetKeyMask
LOOP UNTIL thiskey
millidelay 110

IF thiskey AND 1 THEN x = x - 1
IF thiskey AND 2 THEN y = y - 1
IF thiskey AND 4 THEN x = x + 1
IF thiskey AND 8 THEN y = y + 1
IF x < 1 THEN x = 10
IF x > 10 THEN x = 1
IF y < 1 THEN y = 10
IF y > 10 THEN y = 1
IF thiskey AND 16 THEN
   IF brd(x, y) = 0 THEN
      brd(x, y) = 1
   ELSEIF brd(x, y) = 1 THEN
      brd(x, y) = 2
   ELSEIF brd(x, y) = 2 THEN
      brd(x, y) = 0
   END IF
END IF
IF thiskey AND 32 THEN
   stime$ = TIME$
   CLS
   FOR i = 1 TO 6
      img = 14 + i
      PUT ((i * 10) + 120, 95), boysprite(img * boyepi), PSET
   NEXT
   DO
   thiskey = GetKeyMask
   LOOP UNTIL thiskey
   millidelay 110
   CLS
   TIME$ = stime$
   placenum
END IF
IF thiskey AND 64 THEN
   checkend
   IF timem = 0 AND times1 < 3 THEN
   lsprite "pcttl"
   PUT (250, 10), boysprite(2 * boyepi), PSET
   SLEEP 3
   END
   END IF
   FOR t = 1 TO 3
   times1 = times1 - 1
   IF timem = 0 AND times1 = 0 AND times2 = 0 THEN
   lsprite "pcttl"
   PUT (250, 10), boysprite(2 * boyepi), PSET
   SLEEP 3
   END
   END IF
   IF times2 < 0 THEN
      times2 = 9
      IF timem = 0 AND times1 = 0 THEN GOTO ntime
      times1 = times1 - 1
ntime:
      
   END IF
   IF times1 < 0 AND timem > 0 THEN
      times1 = 5
      timem = timem - 1
   END IF
NEXT
END IF
IF thiskey AND 128 THEN
   stime$ = TIME$
   exposeline
   IF timem = 0 THEN
   lsprite "pcttl"
   PUT (250, 10), boysprite(2 * boyepi), PSET
   SLEEP 3
   END
   END IF
   timem = timem - 1
   TIME$ = stime$
END IF
LOOP

SUB begin

CLS

Centerprint "Just another game by KB 49ers", 12, 3
SLEEP 3
CLS
END SUB

SUB Centerprint (A$, row, clr)
   sl = LEN(A$)                        'string's length
   col = 20 - (sl \ 2)                 'calc start column
   LOCATE row, col                     'locate cursor
   COLOR clr
   PRINT A$;                           'do it

END SUB

SUB checkend
win = 0
FOR w = 1 TO 10
    FOR z = 1 TO 10
        IF dbrd(z, w) = 1 THEN
           IF brd(z, w) = 0 OR brd(z, w) = 2 THEN
              GOTO done
            END IF
        END IF
        IF dbrd(z, w) = 2 THEN
           IF brd(z, w) = 1 THEN
              GOTO done
           END IF
        END IF
    NEXT
NEXT
win = 1
done:
IF win = 1 THEN
   lsprite "pcttl"
   PUT (250, 10), boysprite(1 * boyepi), PSET
   SLEEP 3
   END
END IF


END SUB

SUB emailme
CLS
i = 16
imain = 16
iadd = 1
DO
LOCATE 1
COLOR i
PRINT "Whats up!  This is KB 49ers speaking."
'COLOR i + 1
PRINT "Thanks for downloading PICROSS."
'COLOR i + 2
PRINT "If you haven't played before, then"
'COLOR i + 3
PRINT "read PICROSS.TXT for instructions."
PRINT
'COLOR i + 4
PRINT "Email me for:"
'COLOR i + 5
PRINT "-Info on my upcoming games for AOL."
'COLOR i + 6
PRINT "-Info on my current games on AOL."
'COLOR i + 7
PRINT "-Any comments or suggestions."
PRINT
PRINT
PRINT "Email me on AOL to KB 49ers"

i = i + iadd
IF i = imain + 15 THEN iadd = -1
IF i = imain THEN
   iadd = 1
   imain = imain + 16
   IF imain = 224 THEN
       imain = 16
      
   END IF
   i = imain
END IF
millidelay 100
LOOP UNTIL INKEY$ <> ""


END SUB

SUB exposeline

ex = 1
ey = 1

DO
LINE (70, 170)-(170, 180), 0, BF
ex = ex + 1
IF ex = 11 THEN ex = 1
LINE ((ex * 10) + 60, 170)-((ex * 10) + 69, 180), 2, B
millidelay 20
thiskey = GetKeyMask
LOOP UNTIL thiskey
millidelay 110
DO
LINE (170, 70)-(180, 170), 0, BF
ey = ey + 1
IF ey = 11 THEN ey = 1
LINE (170, (ey * 10) + 60)-(180, (ey * 10) + 69), 3, B
millidelay 20
thiskey = GetKeyMask
LOOP UNTIL thiskey
millidelay 110
FOR i = 1 TO 10
    brd(ex, i) = dbrd(ex, i)
    brd(i, ey) = dbrd(i, ey)
NEXT
SLEEP 1
LINE (170, 70)-(180, 170), 0, BF
LINE (70, 170)-(170, 180), 0, BF



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
   h = PEEK(ExtKeyOfs + 35) AND 128              'the B key

   DEF SEG = &H40                      'point head to tail thus emptying
   POKE &H1A, PEEK(&H1C)               'the keyboard buffer

                                                                
   GetKeyMask = l OR U OR r OR d OR Ent OR SB OR Esc OR h
                                                        
END FUNCTION

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

SUB placenum


lsprite "pcttl"
PUT (250, 10), boysprite(0 * boyepi), PSET
lsprite "picross"

FOR A = 0 TO 40 STEP 10
PUT (A, 0), boysprite(13 * boyepi), PSET
PUT (A, 20), boysprite(13 * boyepi), PSET
NEXT
PUT (40, 10), boysprite(13 * boyepi), PSET
PUT (0, 10), boysprite(13 * boyepi), PSET

FOR A = 310 TO 240 STEP -10
    PUT (A, 0), boysprite(14 * boyepi), PSET
    PUT (A, 70), boysprite(14 * boyepi), PSET
NEXT
FOR A = 10 TO 60 STEP 10
    PUT (310, A), boysprite(14 * boyepi), PSET
    PUT (240, A), boysprite(14 * boyepi), PSET
NEXT





'vertical

FOR i = 1 TO 10
fd = 0
fds = 0
      FOR h = 10 TO 1 STEP -1
          nm = dbrd(i, h)
          IF nm = 2 THEN
             IF fd <> 0 THEN
                PUT ((i * 10) + 60, 60 - (fds * 10)), boysprite(fd * boyepi), PSET
                fd = 0
                fds = fds + 1
             END IF
          END IF
          IF nm = 1 THEN
          fd = fd + 1
          END IF
      NEXT
      IF fd <> 0 THEN
      PUT ((i * 10) + 60, 60 - (fds * 10)), boysprite(fd * boyepi), PSET
      END IF
         
NEXT

'horizontal

FOR h = 1 TO 10
fd = 0
fds = 0
      FOR i = 10 TO 1 STEP -1
          nm = dbrd(i, h)
          IF nm = 2 THEN
             IF fd <> 0 THEN
                PUT (60 - (fds * 10), (h * 10) + 60), boysprite(fd * boyepi), PSET
                fd = 0
                fds = fds + 1
             END IF
          END IF
          IF nm = 1 THEN
          fd = fd + 1
          END IF
      NEXT
      IF fd <> 0 THEN
      PUT (60 - (fds * 10), (h * 10) + 60), boysprite(fd * boyepi), PSET
      END IF
        
NEXT

END SUB

SUB previews

CLS
Centerprint "Available now for download on AOL...", 12, 3
SLEEP 3
CLS

REDIM pal(255) AS Hues                           'array for palette
DEF SEG = VARSEG(pal(0))                         'point to it
BLOAD "mix.PAL", 0                           'load from file
pal(0).red = 10                                  'set background
pal(0).green = 10                                'to a dark shade
pal(0).blue = 10                                 'of blue gray
SetColors pal(), 0, 255                          'set system colors
lsprite "helmsf"
PUT (0, 70), boysprite(0 * boyepi), PSET

lsprite "helmda"
'FOR i! = 0 TO 1.1 STEP .2
'scale 259, 70, 2, 60, 60, i!, i!, 0
'NEXT
PUT (259, 70), boysprite(1 * boyepi), PSET

SLEEP 1
FOR i = 0 TO 10 STEP 1
lsprite "helmsf"
PUT (i, 70), boysprite(0 * boyepi), PSET
lsprite "helmda"
PUT (259 - i, 70), boysprite(1 * boyepi), PSET
NEXT
FOR i = 10 TO 30 STEP 2
lsprite "helmsf"
PUT (i, 70), boysprite(0 * boyepi), PSET
lsprite "helmda"
PUT (259 - i, 70), boysprite(1 * boyepi), PSET
NEXT
FOR i = 30 TO 100 STEP 4
lsprite "helmsf"
PUT (i, 70), boysprite(0 * boyepi), PSET
lsprite "helmda"
PUT (259 - i, 70), boysprite(1 * boyepi), PSET
NEXT


lsprite "helmsf"

FOR i = 0 TO 30

FOR t = 0 TO 255
    pal(t).red = pal(t).red + 5
    pal(t).green = pal(t).green + 5
    pal(t).blue = pal(t).blue + 5
    IF pal(t).red > 60 THEN pal(t).red = 60
    IF pal(t).green > 60 THEN pal(t).green = 60
    IF pal(t).blue > 60 THEN pal(t).blue = 60
IF t MOD 10 = 0 THEN LINE (INT(320 * RND), INT(200 * RND))-(INT(320 * RND), INT(200 * RND)), 0

NEXT
SetColors pal(), 0, 255


NEXT

REDIM pal(255) AS Hues                           'array for palette
DEF SEG = VARSEG(pal(0))                         'point to it
BLOAD "mix.PAL", 0                           'load from file
pal(0).red = 60
pal(0).green = 60
pal(0).blue = 60


SetColors pal(), 0, 15

SCREEN 7, 0, 0, 0
LINE (0, 0)-(320, 200), 15, BF


REDIM pal(255) AS Hues                           'array for palette
DEF SEG = VARSEG(pal(0))                         'point to it
BLOAD "mix.PAL", 0                           'load from file
pal(0).red = 0
pal(0).green = 0
pal(0).blue = 0


SetColors pal(), 0, 15

SCREEN 7, 0, 1, 0
LOCATE 11, 17
COLOR 1
PRINT "MONDAY"
LOCATE 12, 17
COLOR 4
PRINT "NIGHT"
LOCATE 13, 16
COLOR 15
PRINT "FOOTBALL"
FOR i = 160 TO 0 STEP -1
PCOPY 1, 2
SCREEN 7, 0, 2, 0
LINE (i, 0)-(0, 200), 15, BF
LINE (320 - i, 0)-(320, 200), 15, BF
PCOPY 2, 0
millidelay 10
NEXT
SCREEN 7, 0, 0, 0
LINE (0, 0)-(0, 200), 0

SLEEP 3
SCREEN 13
CLS
Centerprint "On AOL in the QBASIC download files", 11, 3
Centerprint "as FBALL: QBASIC NFL FOOTBALL", 12, 3
Centerprint "Download it if you haven't already!", 15, 3


SLEEP 6

CLS
SCREEN 13
REDIM pal(255) AS Hues                           'array for palette
DEF SEG = VARSEG(pal(0))                         'point to it
BLOAD "mix.PAL", 0                           'load from file
pal(0).red = 10                                  'set background
pal(0).green = 10                                'to a dark shade
pal(0).blue = 10                                 'of blue gray
SetColors pal(), 0, 255                          'set system colors

LOCATE 1, 20
COLOR 4
PRINT "COMING SOON"
LOCATE 2, 20
PRINT "TO AOL FROM KB 49ers"
LOCATE 5, 20
COLOR 2
PRINT "DRAGOON LEGACY"
COLOR 3
LOCATE 7, 20
PRINT "PLAY AS THE "
LOCATE 8, 20
PRINT "LAST DECENDENT"
LOCATE 9, 20
PRINT "OF A MYSTERIOUS"
LOCATE 10, 20
PRINT "RACE THAT DISAPPEARED"
LOCATE 11, 20
PRINT "EONS AGO.  PREPARE TO"
LOCATE 12, 20
PRINT "FIGHT AN EVER RISING "
LOCATE 13, 20
PRINT "EVIL AS YOU UNLOCK"
LOCATE 14, 20
PRINT "YOUR HIDDEN DRAGOON"
LOCATE 15, 20
PRINT "POWERS."
LOCATE 19, 20
COLOR 1
PRINT "PREPARE FOR IT..."


lsprite "dragprev"
PUT (0, 20), boysprite(2 * boyepi), PSET
PUT (25, 90), boysprite(1 * boyepi), PSET
PUT (62, 7), boysprite(0 * boyepi), PSET
TIME$ = "00:00:00"
DO
LOOP UNTIL TIME$ = "00:00:10"
CLS

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

SUB randboard
FOR i = 1 TO max
an:
x = INT(10 * RND) + 1
y = INT(10 * RND) + 1
IF dbrd(x, y) = 1 THEN GOTO an
dbrd(x, y) = 1
NEXT



END SUB

SUB selectmd
DO
CLS
md = 1
LOCATE 10, 18
 COLOR 15
 PRINT "GAME"
LOCATE 14, 16

 PRINT "PREVIEWS"
DO
thiskey = GetKeyMask
IF md = 1 THEN LINE (134, 70)-(168, 80), 3, B
IF md = 2 THEN LINE (118, 102)-(183, 112), 12, B

IF thiskey AND 2 THEN
md = 1
LINE (118, 102)-(183, 112), 0, B
END IF
IF thiskey AND 8 THEN
md = 2
LINE (134, 70)-(168, 80), 0, B
END IF
LOOP UNTIL thiskey AND 16
millidelay 110
IF md = 2 THEN previews
LOOP UNTIL md = 1

CLS
END SUB

SUB SetColors (pal() AS Hues, fc, lc)
   OUT &H3C8, fc                                 'initialize controller
   FOR t = fc TO lc                              'from first to last
      OUT &H3C9, pal(t).red                      'send red component
      OUT &H3C9, pal(t).green                    'send green component
      OUT &H3C9, pal(t).blue                     'send blue component
   NEXT
END SUB

SUB title
   zoomsx = 0
   zoomsy = 0
   imageheight = 60
   imagewidth = 60
   zoomfact! = 0
   x! = 0
   y! = 0
   stp = 0
   
   zoomfact = 1
   
   img = 0
   DEF SEG = VARSEG(boysprite(0))            'point to image
   ofs = img * boyepi + 4                               'skip image size data
 
   addx! = 5.3
   addy! = 3.4       'for boxes
 
   FOR ih = 1 TO imageheight                     'top to bottom
      FOR iw = 1 TO imagewidth                   'left to right
         dat = PEEK(ofs)                         'get color
         LINE (x!, y!)-(x! + addx!, y! + addy!), dat, BF  'draw a box
         x! = x! + 5.3                        'adjust
         ofs = ofs + 1                           'ditto
      NEXT
      x! = 0                                 'reset
      y! = y! + 3.4                           'adjust
   NEXT

DO
thiskey = GetKeyMask
LOOP UNTIL thiskey
millidelay 110
FOR i = 0 TO 200
    LINE (0, i)-(320, i), 0
    millidelay 15
NEXT



END SUB

SUB WaitLetGo
   DO: LOOP WHILE GetKeyMask                     'wait 'til user lets go
END SUB

