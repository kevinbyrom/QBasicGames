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
DECLARE SUB MilliDelay (msecs)                   'SUB to create delays
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
COMMON SHARED FileName$, FileSize&
'-------------------------------------------------------------------
COMMON SHARED BoySprite(), BoyEPI, CurBoy        'define all the commons
COMMON SHARED BoyDir, BoyCol, BoyRow             'ditto
COMMON SHARED BoyX, BoyY, MapRow, MapCol         'ditto
COMMON SHARED TnBmap(), ScrnMap()                'ditto
COMMON SHARED StepOrder(), TreasureFound()       'ditto
COMMON SHARED Objects(), ObjEPI, Barrels         'ditto

IF NOT QBEX(0) THEN                              'verify presence of TSR
   PRINT "QBasic Extender TSR not found"
   END
END IF

SCREEN 13                                        '320 x 200 w/256 colors
MilliDelay 0                                     'initialize
REDIM pal(255) AS Hues                           'array for palette
DEF SEG = VARSEG(pal(0))                         'point to it
BLOAD "DEFAULT.PAL", 0                           'load from file
pal(0).red = 10                                  'set background
pal(0).green = 10                                'to a dark shade
pal(0).blue = 15                                 'of blue gray
SetColors pal(), 0, 255                          'set system colors

FileName$ = "OB-BOY.SPR"                         'boy sprite file
IF NOT QBEX(9) THEN END                          'get its size
ldelm = (FileSize& - 7) \ 2 - 1                  'calc array size
REDIM BoySprite(ldelm)                           'array for boy
DEF SEG = VARSEG(BoySprite(0))                   'point to it
BLOAD FileName$, 0                               'load from file
BoyEPI = ((BoySprite(0) \ 8) * BoySprite(1)) \ 2 + 2  'elements per image

FileName$ = "OB-OBJS.SPR"                        'object sprite file
IF NOT QBEX(9) THEN END                          'get its size
ldelm = (FileSize& - 7) \ 2 - 1                  'calc array size
REDIM Objects(ldelm)                             'array for objects
DEF SEG = VARSEG(Objects(0))                     'point to it
BLOAD FileName$, 0                               'load from file
ObjEPI = ((Objects(0) \ 8) * Objects(1)) \ 2 + 2 'elements per image

REDIM StepOrder(14)                              'array for walking order
StepOrder(0) = 1: StepOrder(1) = 2               'assign the images in the
StepOrder(2) = 1: StepOrder(3) = 0               'appropriate order
StepOrder(4) = 3: StepOrder(5) = 4               'when images are displayed
StepOrder(6) = 3:  StepOrder(7) = 0              'in this order boy will
StepOrder(8) = 1: StepOrder(9) = 2               'appear to walk
StepOrder(10) = 1:  StepOrder(11) = 0
StepOrder(12) = 3: StepOrder(13) = 4
StepOrder(14) = 3

BoyDir = 1                                       'face right at startup

TitleScreen 0                                    'opening screen
Restart                                          'load maps

lt& = TIMER                                      'used for little barrels
DO
   t& = TIMER - lt&                              'check timer
   IF t& > 60 THEN                               '60 seconds
      IF barlup THEN                             'little barrel active
         IF t& > 80 THEN                         'stays up 20 seconds
            lt& = TIMER                          'for next time
            ScrnMap(r, c) = 0                    'clear it
            MapCol = MapCol - 1                  'force total -
            BldScreen 0, 1                       '              screen update
            barlup = NOT barlup                  'toggle flag
         END IF
      ELSE                                       'little barrel not active
         DO                                      'use loop to find empty
            r = RND * 2 + MapRow                 'location on screen
            c = RND * 9 + MapCol
         LOOP WHILE ScrnMap(r, c) OR ((c = BoyCol) AND (r = BoyRow))
         FOR t = z TO 10
            SOUND z * 100 + 500, .3              'noise
         NEXT
         ScrnMap(r, c) = 2                       'put little barrel in map
         BldScreen 0, 0                          'update screen
         barlup = NOT barlup                     'toggle flag
      END IF
   END IF

   ThisKey = GetKeyMask                          'check keyboard
   IF ThisKey AND 32 THEN                        'space bar = jump
         JumpBoy
   ELSEIF ThisKey AND 1 THEN                     'cursor left
         WalkBoy -1, -1
   ELSEIF ThisKey AND 4 THEN                     'cursor right
         WalkBoy 1, -1
   ELSEIF ThisKey AND 128 THEN                   'the B key
      wRow = BoyRow + MapRow                     'calc column
      wCol = BoyCol + BoyDir + MapCol            'calc row - in front of boy
      img = ScrnMap(wRow, wCol)                  'check map
      IF (img = 0) AND Barrels THEN              'check if they have one
         ScrnMap(wRow, wCol) = 1                 'put it in the map
         Barrels = Barrels - 1                   'used one
         BldScreen 0, 0                          'update screen
      END IF
   ELSEIF ThisKey AND 64 THEN                    'escape
      pick = PullDown                            'see what they want
      SELECT CASE pick
      CASE 1                                     'cheat
         ShowMap                                 'do it
      CASE 2                                     'start over
         Restart                                 'do it
      CASE 3                                     'quit
         EXIT DO                                 'outta here
      END SELECT
   END IF

LOOP


END

SUB BldScreen (AddRow, AddCol)

   IF AddRow > 0 THEN                            'positive
      IF MapRow = 12 THEN AddRow = 0             'if max don't move
   ELSE                                          'negative
      IF MapRow = 0 THEN AddRow = 0              'if min don't move
   END IF
   MapRow = MapRow + AddRow                      'adjust map position

   IF AddCol > 0 THEN                            'positive
      IF MapCol = 30 THEN AddCol = 0             'if max don't move
   ELSE                                          'negative
      IF MapCol = 0 THEN AddCol = 0              'if min don't move
   END IF
   MapCol = MapCol + AddCol                      'adjust map position

   mflag = AddRow OR AddCol                      'map moved flag

   IF mflag THEN                                 'if it moved
      FOR y = 0 TO 3                             'top to bottom
         wy = y * 63: mwy = wy + 10              'calc position
         FOR x = 0 TO 9                          'left to right
            wx = x * 32:  mwx = wx + 31          'calc position
            IF TnBmap(y + MapRow, x + MapCol) THEN    'check map
               LINE (wx, wy)-(mwx, mwy), 0, BF   'clear hole
            ELSE
               clr = 159                         'brown
               FOR t = 0 TO 4                    '5 boxes
                  LINE (wx + t, wy + t)-(mwx - t, mwy - t), clr, BF 'draw
                  clr = clr - 1                  'adjust
               NEXT
            END IF
         NEXT
      NEXT
   END IF

   FOR y = 0 TO 2                                'top to bottom
      wy = y * 63 + 11: mwy = wy + 51            'calc position
      iy = wy + 22                               'ditto
      FOR x = 0 TO 9                             'left to right
         wx = x * 32: mwx = wx + 31              'calc position
         img = ScrnMap(y + MapRow, x + MapCol)   'check for wall or treasure
         IF mflag THEN LINE (wx, wy)-(mwx, mwy), 0, BF 'clear area
         IF img = -1 THEN                        'wall
            wx = wx + 10: mwx = wx + 11          'adjust
            clr = 159                            'brown
            FOR t = 0 TO 5                       '6 boxes
               LINE (wx + t, wy + t)-(mwx - t, mwy - t), clr, B 'draw wall
               clr = clr - 1                     'adjust
            NEXT
         ELSEIF img = 1 THEN                     'barrel
            bx = wx + 1: by = iy                 'calc barrel position
            bc = x + MapCol: br = y + MapRow     'ditto
            PUT (bx, by), Objects(ObjEPI), PSET  'display barrel
            IF POINT(wx, by + 32) = 0 THEN       'anthing under it?
               freq = 700                        'for the noise
               ScrnMap(br, bc) = 0               'its gonna fall -
               ScrnMap(br + 1, bc) = 1           '                  fix map
               DO UNTIL POINT(wx, by + 32)       'until it hits something
                  by = by + 1                    'move down
                  PUT (bx, by), Objects(ObjEPI), PSET 'display barrel
                  MilliDelay 5                   'pause
                  SOUND freq, .2                 'noise
                  freq = freq - 8                'adjust
                  IF freq < 50 THEN freq = 50    'minimum
               LOOP
               IF by = 168 THEN                  'at bottom of screen
                  bhelm = ObjEPI + 1             'barrel height element
                  FOR by = 169 TO 190            'the rest of the way off
                     IF by > 170 THEN Objects(bhelm) = 200 - by 'adjust
                     PUT (bx, by), Objects(ObjEPI), PSET   'display barrel
                     MilliDelay 5                'pause
                     SOUND freq, .2              'noise
                     freq = freq - 8             'adjust
                     IF freq < 50 THEN freq = 50 'minimum
                  NEXT
                  Objects(bhelm) = 30            'reset
               END IF
            END IF
         ELSEIF img THEN                         'all other images
            IF img > 3 THEN img = 3              'show? instead of treasure
            PUT (wx + 1, iy), Objects(img * ObjEPI), PSET     'display image
         END IF
         IF x = BoyCol AND y = BoyRow THEN       'boy goes here
            PUT (BoyX, BoyY), BoySprite(CurBoy * BoyEPI), PSET 'display boy
         END IF
      NEXT
   NEXT

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

SUB JumpBoy

   MilliDelay 10                                 'pause
   ThisKey = GetKeyMask                          'check keyboard
   JumpHeight = 20                               'assume low jump
   IF ThisKey AND 2 THEN JumpHeight = 43         'up key = high jump
   freq = 100                                    'for noise
   ofs = (CurBoy + 2) * BoyEPI                   'calc offset
   TrFx = BoyY                                   'for top row check

   FOR t = 1 TO JumpHeight                       'jump structure
      nbY = BoyY - 1                             'move up
      IF POINT(BoyX, nbY) = 0 THEN               'anything in the way?
         BoyY = nbY                              'adjust
         PUT (BoyX, BoyY), BoySprite(ofs), PSET  'display boy
         MilliDelay 5                            'pause
         SOUND freq, .2                          'noise
         freq = freq + 8                         'adjust
      END IF
      ThisKey = GetKeyMask                       'check keyboard
      IF ThisKey AND 1 THEN                      'left
            dir = -1                             'flag it
      ELSEIF ThisKey AND 4 THEN                  'right
            dir = 1                              'flag it
      END IF
   NEXT
   BoyRow = BoyY \ 63                            'calc row

   IF BoyY = 0 THEN                              'top of screen?
      IF JumpHeight = 20 THEN                    'low jump
         dir = 0                                 'CAN'T move
      ELSEIF JumpHeight = 43 THEN                'high jump
         BoyY = TrFx + 20                        'fixup for top row
         BldScreen -1, 0                         'update screen
      END IF
   END IF

   pxchk = (32 * dir) + 16                       'calc x coordinate
   clr = POINT(BoyX + pxchk, BoyY + 14)          'see what's there
   IF clr > 143 AND clr < 160 THEN dir = 0       'CAN'T move through walls
   img = ScrnMap(BoyRow + MapRow, BoyCol + dir + MapCol) 'check map
   IF (img = 0) AND dir AND (JumpHeight = 20) THEN WalkBoy dir, 0
                                                 'long jump & don't fall
   clr = POINT(BoyX + pxchk, BoyY + 14)          'see what's there
   IF clr > 143 AND clr < 160 THEN dir = 0       'CAN'T move through walls
   WalkBoy dir, -1                               'update boy position

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

FUNCTION MoveBarrel (br, bc, dr)
   nxtrow = br                                   'row
   nxtcol = bc + dr                              'calc column
   nxtimg = ScrnMap(nxtrow, nxtcol)              'see what's there
   mbf = dr                                      'assume ok to move
   IF nxtimg = 1 THEN                            'next is a barrel
      mbf = MoveBarrel(nxtrow, nxtcol, dr)       'call recursively
   ELSEIF nxtimg = -1 THEN                       'next is a wall
      mbf = 0                                    'can't move barrel
   END IF

   IF mbf THEN                                   'ok to move barrel?
      ScrnMap(br, bc) = 0                        'update the map
      ScrnMap(nxtrow, nxtcol) = 1                'ditto
      IF br >= MapRow AND br <= MapRow + 2 THEN  'is it on the screen?
         IF bc >= MapCol AND br <= MapCol + 9 THEN    'ditto?
            REDIM work(ObjEPI)                   'work array
            wby = (br - MapRow) * 63 + 33        'calc corner
            mby = wby + 29                       'ditto
            wbx = (bc - MapCol) * 32 + 1         'ditto
            IF wbx < 2 THEN wbx = 2              'check minimum
            mbx = wbx + 29                       'calc corners
            IF mbx > 317 THEN mbx = 317          'check maximum
            abxv = dr * 2
            FOR t = 1 TO 16
               GET (wbx, wby)-(mbx, mby), work   'get image
               wbx = wbx + abxv                  'check maximum
               PUT (wbx, wby), work, PSET        'move image
               IF wbx < 2 THEN                   'check minimum
                  wbx = 2                        'adjust
               ELSEIF wbx > 317 THEN             'check maximum
                  wbx = 317                      'adjust
               END IF
               mbx = mbx + abxv                  'adjust
               IF mbx > 317 THEN mbx = 317       'check maximum
               MilliDelay 10                     'pause
               SOUND 200, .2                     'noise
            NEXT
            BldScreen 0, 0                       'update screen
         END IF
      END IF
   END IF

   MoveBarrel = mbf                              'return result

END FUNCTION

FUNCTION PullDown

   clr = 159                                     'brown
   FOR t = 0 TO 4                                '5 boxes
      LINE (t, t)-(79 - t, 39 - t), clr, B       'draw border
      clr = clr - 1                              'adjust
   NEXT
   LINE (t, t)-(79 - t, 39 - t), 0, BF           'clear area
   REDIM bar(257)                                'array for highlight bar
   bx = 8: by = bx: mbx = bx + 63: mby = by + 7  'set up values
   LINE (bx, by)-(mbx, mby), 95, BF              'draw highlight bar
   GET (bx, by)-(mbx, mby), bar                  'capture highlight bar
   PUT (bx, by), bar                             'erase highlight bar
   COLOR 156                                     'tan
   LOCATE 2, 2: PRINT "View Map"                 'display menu text
   LOCATE 3, 2: PRINT "Restart"                  'ditto
   LOCATE 4, 2: PRINT "Exit"                     'ditto
   PUT (bx, by), bar                             'display highlight bar
   row = 1                                       'start value
   WaitLetGo                                     'wait 'til they let go
   
   DO                                            'start of menu loop
      ThisKey = GetKeyMask                       'check the keyboard

      IF ThisKey THEN                            'key pressed
         MilliDelay 110                          'give user time to let go
         IF ThisKey AND 2 THEN                   'cursor UP pressed
            IF row > 1 THEN row = row - 1        'move bar up
         ELSEIF ThisKey AND 8 THEN               'cursor DOWN pressed
            IF row < 3 THEN row = row + 1        'move bar down
         ELSEIF ThisKey AND 16 THEN              'Enter Key pressed
            EXIT DO                              'choice made
         ELSEIF ThisKey AND 64 THEN              'Escape pressed
            row = 0                              'return 0
            EXIT DO                              'outta here
         END IF
      END IF

      IF row <> lr THEN                          'did the bar move?
         PUT (bx, by), bar                       'erase highlight bar
         by = row * 8                            'calc new position
         PUT (bx, by), bar                       'display highlight bar
         lr = row                                'for next time
      END IF
      
   LOOP                                          'end of menu loop

   MapCol = MapCol - 1                           'force total -
   BldScreen 0, 1                                '              screen update
   WaitLetGo                                     'wait 'til they let go

   PullDown = row                                'return the selection

END FUNCTION

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

SUB Restart

   OPEN "OVRBARRL.MAP" FOR INPUT AS #1           'open map file
   FOR r = 0 TO 15                               'top to bottom
      FOR c = 0 TO 39                            'left to right
         INPUT #1, TnBmap(r, c)                  'read ceiling and floor map
      NEXT
   NEXT
   FOR r = 0 TO 14                               'top to bottom
      FOR c = 0 TO 39                            'left to right
         INPUT #1, ScrnMap(r, c)                 'read wall and treasure map
      NEXT
   NEXT
   CLOSE #1                                      'close map file

   REDIM TreasureFound(4 TO 23)                  'array to keep score
   CurBoy = 0: BoyDir = 1                        'set up starting values
   BoyCol = 1: BoyRow = 0                        'ditto
   BoyX = BoyCol * 32 + 6                        'ditto
   BoyY = BoyRow * 63 + 33                       'ditto
   MapRow = 1: MapCol = 1                        'so BldScreen will 0 them
   BldScreen -1, -1                              'update screen

END SUB

SUB SetColors (pal() AS Hues, fc, lc)
   OUT &H3C8, fc                                 'initialize controller
   FOR t = fc TO lc                              'from first to last
      OUT &H3C9, pal(t).red                      'send red component
      OUT &H3C9, pal(t).green                    'send green component
      OUT &H3C9, pal(t).blue                     'send blue component
   NEXT
END SUB

SUB ShowMap

   clr = 159                                     'brown
   FOR t = 0 TO 7                                '8 boxes
      LINE (31 + t, 7 + t)-(288 - t, 192 - t), clr, B      'draw border
      clr = clr - 1                              'adjust
   NEXT
   LINE (31 + t, 7 + t)-(288 - t, 192 - t), clr, BF        'center of map
   
   y = 17: x = 39                                'start values
   cbr = BoyRow + MapRow: cbc = BoyCol + MapCol  'current boy location
   FOR r = 0 TO 14                               'top to bottom
      FOR c = 0 TO 39                            'left to right
         IF TnBmap(r, c) = 0 THEN                'check map
            LINE (x, y)-(x + 5, y), 159          'draw piece
         END IF
         img = ScrnMap(r, c)                     'check map
         IF r = cbr AND c = cbc THEN             'current boy
            IF img = 1 THEN                      'check if on a barrel
               LINE (x + 1, y + 3)-(x + 4, y + 6), 34, BF  'on a barrel
            ELSE
               LINE (x + 1, y + 7)-(x + 4, y + 10), 34, BF 'normal
            END IF
         END IF
         IF img = -1 THEN                                  'wall
            LINE (x + 2, y)-(x + 3, y + 10), 159, B        'draw wall
         ELSEIF img = 1 THEN                               'barrel
            LINE (x + 1, y + 7)-(x + 4, y + 10), 217, BF   'draw barrel
         ELSEIF img THEN                                   'treasure
            LINE (x + 1, y + 7)-(x + 4, y + 10), 192       'draw a -
            LINE (x + 4, y + 7)-(x + 1, y + 10), 192       '          gold X
         END IF
         x = x + 6                               'adjust
      NEXT
      x = 39: y = y + 11                         'adjust
   NEXT
   LINE (x, y)-(278, y), 159                     'bottom line of map

   DO: LOOP UNTIL GetKeyMask                     'wait for key press

   MapCol = MapCol - 1                           'force total -
   BldScreen 0, 1                                '              screen update
   WaitLetGo                                     'wait 'til they let go

END SUB

SUB ShowTreasure
   
   img = 4                                       'first treasure image
   FOR y = 30 TO 150 STEP 40                     'top to bottom
      my = y + 39                                'calc corner
      FOR x = 60 TO 240 STEP 40                  'left to right
         mx = x + 39                             'calc corner
         clr = 159                               'brown
         FOR t = 0 TO 4                          '5 boxes each
            LINE (x + t, y + t)-(mx - t, my - t), clr, B   'draw border
            clr = clr - 1                        'adjust
         NEXT
         IF TreasureFound(img) THEN              'found yet?
            PUT (x + t, y + t), Objects(img * ObjEPI), PSET     'show it
            score = score + 1                    'keep track
         ELSE
            LINE (x + t, y + t)-(mx - t, my - t), 0, BF    'clear area
         END IF
         img = img + 1                           'adjust
      NEXT
   NEXT
     
   clr = 159                                     'brown
   FOR t = 0 TO 4                                'five boxes
      LINE (112 + t, t)-(207 - t, 22 - t), clr, B     'draw border
      clr = clr - 1                              'adjust
   NEXT
   LINE (112 + t, t)-(207 - t, 22 - t), 0, BF    'clear area

   COLOR 195: LOCATE 2, 16                       'gold
   PRINT USING "##"; score;                      'show the -
   PRINT "  of  20"                              '           score

   DO
      FOR t = 1 TO 14
         SOUND t * 100, .3                       'noise
      NEXT
      FOR t = 15 TO 1 STEP -1
         SOUND t * 100, .2                       'noise
      NEXT
   LOOP UNTIL GetKeyMask                         'wait for key press

   MapCol = MapCol - 1                           'force total -
   BldScreen 0, 1                                '              screen update
   WaitLetGo                                     'wait 'til they let go

   IF score = 20 THEN                            'if they got em all
      ScrnMap(0, 0) = 0                          'remove wall at entrance
      clr = 159                                  'brown
      FOR t = 0 TO 4                             'five boxes
         LINE (56 + t, 80 + t)-(263 - t, 102 - t), clr, B    'draw border
         clr = clr - 1                           'adjust
      NEXT
      LINE (56 + t, 80 + t)-(263 - t, 102 - t), 0, BF   'clear area
      LOCATE 12, 9
      PRINT "Now to Find The Way Out!"
      DO
         FOR t = 1 TO 14
            SOUND t * 100, .3                    'noise
         NEXT
         FOR t = 15 TO 1 STEP -1
            SOUND t * 100, .2                    'noise
         NEXT
      LOOP UNTIL GetKeyMask                      'wait for key press
      MapCol = MapCol - 1                        'force total -
      BldScreen 0, 1                             '              screen update
      WaitLetGo                                  'wait 'til they let go
   END IF


END SUB

SUB TitleScreen (cfg)

   REDIM TnBmap(15, 39)                          'map for ceiling and floor
   REDIM ScrnMap(14, 39)                         'map for walls and treasure

   FOR r = 0 TO 4                                'top to bottom
      FOR c = 0 TO 9                             'left to right
         TnBmap(r, c) = 1                        '1 is a hole
      NEXT
      IF r = 1 THEN r = 2                        'skip row 2
   NEXT
   TnBmap(2, 0) = 1: TnBmap(2, 9) = 1            'bottom corners of screen
   TnBmap(3, 0) = 0: TnBmap(3, 9) = 0            'ends of row 2

   BoyCol = 1: BoyRow = 0                        'set up title screen values
   BoyX = BoyCol * 32 + 6                        'ditto
   BoyY = BoyRow * 63 + 33                       'ditto
   CurBoy = 0: BoyDir = 1                        'ditto
   ScrnMap(0, 8) = 1                             'a barrel
   MapRow = 1: MapCol = 1                        'so BldScreen will 0 them
   BldScreen -1, -1                              'update screen

   IF cfg THEN
      clr = 159                                  'brown
      FOR t = 0 TO 4                             'five boxes
         LINE (88 + t, 144 + t)-(231 - t, 166 - t), clr, B 'draw border
         clr = clr - 1                           'adjust
      NEXT
      LINE (88 + t, 144 + t)-(231 - t, 166 - t), 0, BF     'clear area
      LOCATE 20, 13: PRINT "CONGRATULATIONS!";   'they made it
   END IF

   img = 24                                      'first image of title
   FOR y = 0 TO 30 STEP 30                       'top to bottom
      FOR x = 115 TO 175 STEP 30                 'left to right
         IF (y = 30) AND (x <> 145) THEN         'second row ends
            PUT (x, y), Objects(ObjEPI), PSET         'barrel
         ELSE
            PUT (x, y), Objects(img * ObjEPI), PSET   'piece of title
            img = img + 1                        'next piece
         END IF
      NEXT
   NEXT
   FOR x = 100 TO 190 STEP 30                    'left to right
      PUT (x, y), Objects(img * ObjEPI), PSET    'piece of title
      img = img + 1                              'next piece
   NEXT
   y = 170                                       'credits on bottom
   FOR x = 85 TO 205 STEP 30                     'left to right
      PUT (x, y), Objects(img * ObjEPI), PSET    'piece of credits
      img = img + 1                              'next piece
   NEXT

   DO                                            'title loop
      WalkBoy dir, -1                            'make him walk
      IF BoyX = 38 THEN                          'left end
         IF dir = 1 THEN                         'second time
            ScrnMap(0, 8) = 1                    'a barrel
            BldScreen 0, 0                       'update screen
         END IF
         dir = 1                                 'reverse direction
      ELSEIF BoyX = 262 THEN                     'right end
         IF dir = -1 THEN                        'second time
            ScrnMap(0, 1) = 1                    'a barrel
            BldScreen 0, 0                       'update screen
         END IF
         dir = -1                                'reverse direction
      END IF
   LOOP UNTIL GetKeyMask                         'wait for key press

END SUB

SUB WaitLetGo
   DO: LOOP WHILE GetKeyMask                     'wait 'til user lets go
END SUB

SUB WalkBoy (way, dFlag)

   IF (BoyDir + way) THEN                        'facing right direction?
      mvdir = way                                'assume ok to move
      nxtcol = BoyCol + way                      'desired location
      wRow = BoyRow + MapRow                     'calc work row
      wCol = nxtcol + MapCol                     'calc work col
      img = ScrnMap(wRow, wCol)                  'check map
      IF img = -1 THEN                           'wall
         mvdir = 0                               'can't move
      ELSEIF img = 1 AND ((BoyY - 33) MOD 63 = 0) THEN  'barrel & not on one
         mvdir = MoveBarrel(wRow, wCol, way)     'try to move barrel
      ELSEIF img = 2 THEN                        'little barrel
         IF Barrels < 3 THEN Barrels = Barrels + 1    'save 'em  (3 max)
         ScrnMap(wRow, wCol) = 0                 'clear map
         FOR z = 10 TO 0 STEP -1
            SOUND z * 100 + 500, .3              'noise
         NEXT
      ELSEIF img > 3 THEN                        'found some treasure
         mvdir = 0                               'don't move
         ftflag = NOT ftflag                     'set flag
         TreasureFound(img) = ftflag             'ditto
      END IF

      IF mvdir THEN                              'still trying to move?
         IF (nxtcol <= 0) OR (nxtcol >= 9) THEN  'edges of screen
            IF nxtcol = 0 AND BoyRow = 0 AND MapCol = 0 THEN    'out of maze
               CLS
               TitleScreen -1                    'congratulate them
               END                               'all done
            END IF
            addScol = mvdir                      'move screen-
            mvdir = 0                            '             instead of boy
         END IF
      END IF

      Xav = mvdir * 2                            'will move 2 pixels
      BoyX = BoyCol * 32 + 6                     'calc position
      BoyX = BoyX + Xav                          'adjust
      FOR t = 0 TO 14                            '15 steps
         ofs = (CurBoy + StepOrder(t)) * BoyEPI  'calc image offset
         PUT (BoyX, BoyY), BoySprite(ofs), PSET  'display image
         BoyX = BoyX + Xav                       'adjust
         ThisKey = GetKeyMask                    'clear keyboard buffer
         MilliDelay 30                           'pause
         SOUND 100, .3                           'noise
      NEXT
      BoyCol = BoyCol + mvdir                    'adjust
   ELSE                                          'facing wrong way
      BoyDir = BoyDir * -1                       'reverse direction
      IF BoyDir > 0 THEN CurBoy = 0 ELSE CurBoy = 5   'correct image
      MilliDelay 150                             'pause
   END IF

   BoyX = BoyCol * 32 + 6                        'calc position
   PUT (BoyX, BoyY), BoySprite(CurBoy * BoyEPI), PSET 'display image
   MilliDelay 20                                 'pause
   
   IF addScol THEN BldScreen 0, addScol          'update screen
   IF dFlag THEN                                 'ok to drop?
      freq = 700                                 'for noise
      DO UNTIL POINT(BoyX, BoyY + 30)            'until he's on something
         BoyY = BoyY + 1                         'move down
         IF BoyY = 167 THEN                      'going off bottom
            BoyY = 136                           'adjust
            BldScreen 1, 0                       'update screen
         END IF
         PUT (BoyX, BoyY), BoySprite(CurBoy * BoyEPI), PSET
         SOUND freq, .2                          'noise
         freq = freq - 8                         'adjust
         IF freq < 50 THEN freq = 50             'minimum
         ThisKey = GetKeyMask                    'clear keyboard buffer
         MilliDelay 5                            'pause
      LOOP
   END IF
   BoyRow = BoyY \ 63                            'calc row

   IF ftflag THEN                                'was treasure found?
      ix = nxtcol * 32 + 1                       'calc position
      iy = BoyRow * 63 + 33                      'ditto
      ScrnMap(wRow, wCol) = 0                    'clear map
      ofs = img * ObjEPI                         'calc offset
      PUT (ix, iy), Objects(ofs), PSET           'display it
      MilliDelay 500                             'pause
      PUT (ix, iy), Objects(ofs)                 'erase it
      ShowTreasure                               'show all that they have
   END IF

END SUB
