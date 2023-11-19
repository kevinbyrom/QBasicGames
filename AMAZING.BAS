' ** Amazing.BAS
' ** 1993 Fred Sexton Jr.
' ** Requires: QBasic Extender TSR
' **
DEFINT A-Z                             'set default variable type to integer

TYPE Hues                              'define the type needed for hues
    red AS INTEGER                     'red component
  green AS INTEGER                     'green component
   blue AS INTEGER                     'blue component
END TYPE

DECLARE FUNCTION QBEX (ExtNum)         'TSR interface
DECLARE SUB EditMazes ()               'SUB to edit mazes
DECLARE SUB LoadMaze (maze)            'SUB to load mazes
DECLARE SUB MilliDelay (msecs)         'SUB to create delays
DECLARE SUB PlayTheGame ()             'SUB to play the game
DECLARE SUB PositionParts ()           'SUB to position maze parts
DECLARE SUB SetColors (pal() AS Hues, fc, lc)     'SUB to modify palette
DECLARE SUB ShowMaze ()                'SUB to show maze
DECLARE SUB WaitLetGo ()               'SUB to give user time
DECLARE FUNCTION GetKeyMask ()         'FUNCTION to handle keyboard
DECLARE FUNCTION Menus (menu)          'FUNCTION to handle all the menus
DECLARE FUNCTION SelectPart ()         'FUNCTION to select parts

'---------- define the variables used by the Extender TSR ----------
COMMON SHARED ExtKeyOfs, ExtKeySeg, FileName$
COMMON SHARED MouseLeft, MouseRight, MouseX, MouseY
'-------------------------------------------------------------------
COMMON SHARED MazeParts(), MazeMap()

IF NOT QBEX(0) THEN                    'verify presence of TSR
   PRINT "QBasic Extender TSR not found"
   END
END IF

z = QBEX(1)                            'verify presence of mouse

SCREEN 13                              '320x200 with 256 colors
RANDOMIZE TIMER

REDIM pal(256) AS Hues                 'array for the palette
DEF SEG = VARSEG(pal(0))               'point to it
BLOAD "default.pal", 0                 'load the palette file into array
pal(0).red = 15                        'set color 0
pal(0).green = 15                      '            to a shade
pal(0).blue = 15                       '                       of gray
SetColors pal(), 0, 255                'set the system colors

REDIM MazeParts(3231)                  'array for the images
DEF SEG = VARSEG(MazeParts(0))         'point to it
BLOAD "MAZEPART.SPR", 0                'load the image file into array

REDIM MazeMap(15, 9)                   'array for the map

LoadMaze 0                             'load opening screen map (maze 0)
ShowMaze                               'display it

z = GetKeyMask                         'will clear key buffer
DO
   FOR t = 250 TO 650 STEP 10
      SOUND t, .3                      'siren noise
   NEXT
LOOP WHILE INKEY$ = ""                 'wait for key press

COLOR 120                              'a gray for menus

DO                                     'main loop
   REDIM MazeMap(15, 9)                'clear the map
   CLS                                 'and the screen
   pick = Menus(0)                     'call the first menu
   SELECT CASE pick                    'do whatever is picked
      CASE 0                           'play
         PlayTheGame
      CASE 1                           'edit
         EditMazes
      CASE 2                           'quit
         EXIT DO
   END SELECT
LOOP                                   'end of main loop

END

SUB EditMazes

   DO
      opt = Menus(1)                             'get menu option
      SELECT CASE opt                            'decide what to do
         CASE 0                                  'edit
            PositionParts                        'call the maze editor
         CASE 1                                  'new
            REDIM MazeMap(15, 9)                 'clear existing map
            CLS                                  'and the screen
         CASE 2                                  'load
            maze = Menus(2) + 1                  'menu to select maze #
            LoadMaze maze                        'load the maze
            ShowMaze                             'show it
         CASE 3                                  'view
            DO                                   'wait
               z = QBEX(2)                       'button status
            LOOP UNTIL MouseLeft OR GetKeyMask   'click or key press
         CASE 4                                  'save
            pick = Menus(2) + 1                  'get maze #
            t$ = RIGHT$("0" + LTRIM$(STR$(pick)), 2)  'double digit string
            FileName$ = "MAZE" + t$ + ".MAP"          'make up name
            IF QBEX(9) THEN                      'see if it exists
               pick = Menus(3)                   'ok to overwrite file?
            END IF
            IF pick THEN
               DEF SEG = VARSEG(MazeMap(0, 0))   'point to map
               BSAVE FileName$, 0, 320           'and save it
            END IF
         CASE 5                                  'quit
            EXIT DO
      END SELECT
   LOOP

END SUB

FUNCTION GetKeyMask

   DEF SEG = ExtKeySeg                 'point to QBEX's data
   L = PEEK(ExtKeyOfs + 75) AND 1      'cursor left
   U = PEEK(ExtKeyOfs + 72) AND 2      'cursor up
   r = PEEK(ExtKeyOfs + 77) AND 4      'cursor right
   D = PEEK(ExtKeyOfs + 80) AND 8      'cursor down
   Ent = PEEK(ExtKeyOfs + 28) AND 16   'Enter
   SB = PEEK(ExtKeyOfs + 57) AND 32    'Space Bar
   Esc = PEEK(ExtKeyOfs + 1) AND 64    'Escape

   DEF SEG = &H40                      'point head to tail thus emptying
   POKE &H1A, PEEK(&H1C)               'the keyboard buffer

   GetKeyMask = L OR U OR r OR D OR Ent OR SB OR Esc       'OR them all
      
END FUNCTION

SUB LoadMaze (maze)
   t$ = RIGHT$("0" + LTRIM$(STR$(maze)), 2)      'make double digit string
   FileName$ = "MAZE" + t$ + ".MAP"              'the name
   IF QBEX(9) THEN                               'see if it exists
      DEF SEG = VARSEG(MazeMap(0, 0))            'point to the map
      BLOAD FileName$, 0                         'load the file
   ELSE                                          'file does not exist
      REDIM MazeMap(15, 9)                       'so clear out map
   END IF
END SUB

FUNCTION Menus (menu)
   
   SELECT CASE menu
      CASE 0
         h = 2                         'set height
         w = 10                        'and width
         REDIM list$(h)                'make an array
         list$(0) = "Play Game"        'assign the strings
         list$(1) = "Edit Mazes"
         list$(h) = "Quit"
      CASE 1
         h = 5                         'set height
         w = 4                         'and width
         REDIM list$(h)                'make an array
         list$(0) = "Edit"             'assign the strings
         list$(1) = "New"
         list$(2) = "Load"
         list$(3) = "View"
         list$(4) = "Save"
         list$(h) = "Quit"
      CASE 2
         h = 19                        'set height
         w = 2                         'and width
         REDIM list$(h)                'make an array
         FOR t = 0 TO h                'assign the strings
            list$(t) = RIGHT$("0" + LTRIM$(STR$(t + 1)), 2)
         NEXT
      CASE 3
         h = 1                         'set height
         w = 10                        'and width
         REDIM list$(h)                'make an array
         list$(0) = "Cancel"           'assign the strings
         list$(h) = "Overwrite"
      CASE 4
         h = 2                         'set height
         w = 8                         'and width
         REDIM list$(h)                'make an array
         list$(0) = "Continue"         'assign the strings
         list$(1) = "Hint"
         list$(h) = "Quit"
      CASE 5
         h = 2                         'set height
         w = 8                         'and width
         REDIM list$(h)                'make an array
         list$(0) = "In Order"         'assign the strings
         list$(1) = "Random"
         list$(h) = "Select"
   END SELECT

   wx = w * 8 + 15                     'calc bottom right corner
   wy = h * 8 + 23                     'of area that will be used

   telm = ((wx + 1) * (wy + 1)) \ 2 + 1
   REDIM tmp(telm)                     'array to hold existing screen
   GET (0, 0)-(wx, wy), tmp            'capture area

   REDIM bar(32 * w + 1)               'array for highlight bar
   bx = 8: by = 8
   mbx = w * 8 + bx - 1                'calc length of bar
   mby = by + 7
   LINE (bx, by)-(mbx, mby), 92, BF    'draw bar
   GET (bx, by)-(mbx, mby), bar        'capture bar
   PUT (bx, by), bar                   'erase bar
   
   clr = 105                                'a dark blue
   cav = -3                                 'getting lighter
   FOR t = 0 TO 6                           '7 lines
      LINE (t, t)-(wx - t, wy - t), clr, B  'draw the menu border
      IF t = 3 THEN cav = -cav              'after middle getting darker
      clr = clr + cav                       'adjust
   NEXT
   LINE (t, t)-(wx - t, wy - t), 0, BF      'clear center of menu

   FOR t = 0 TO h
      LOCATE t + 2, 2
      PRINT list$(t)                        'print the menu text
   NEXT

   smx = MouseX: smy = MouseY               'save mouse position
   MouseX = 0: MouseY = 0                   '0 'em
   z = QBEX(4)                              'set mouse position (0,0)
   WaitLetGo                                'wait for user to let go
   PUT (bx, by), bar                        'show highlight bar

   DO                                       'start menu loop
      z = QBEX(2)                           'get button status
      z = QBEX(3)                           'get mouse position
      row = MouseY \ 8                      'calc row
      IF row > h THEN row = h               'has to stay in menu

      k = GetKeyMask                        'check the keyboard
      IF k THEN                             'key pressed
         MilliDelay 150                     'give user time to let go
         IF k AND 2 THEN                    'cursor UP pressed
            IF row > 0 THEN row = row - 1   'if possible go up
         ELSEIF k AND 8 THEN                'cursor DOWN pressed
            IF row < h THEN row = row + 1   'if possible go down
         ELSEIF k AND 16 THEN               'Enter Key pressed
            EXIT DO                         'choice was made
         END IF
         MouseY = row * 8                   'adjust location
         z = QBEX(4)                        'set mouse position
      END IF

      IF row <> lr THEN                     'did the bar move?
         PUT (bx, by), bar                  'erase last bar
         by = row * 8 + 8                   'calc new position
         PUT (bx, by), bar                  'show highlight bar
         lr = row
      END IF

   LOOP UNTIL MouseLeft                     'choice was made

   PUT (0, 0), tmp, PSET                    'put the screen back
   MouseX = smx: MouseY = smy               'ditto for mouse
   z = QBEX(4)                              'set mouse position
   WaitLetGo                                'wait for user to let go
   Menus = row

END FUNCTION

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

SUB PlayTheGame

   PlayMode = Menus(5)                           'how to play?
   REDIM mazedone(1 TO 20)                       'array for done flags

   DO                                            'start outer loop
      IF PlayMode = 1 THEN                       'random mode
         DO
            maze = RND * 19 + 1                  'random maze number
         LOOP WHILE mazedone(maze)               'make sure its not done
          mazedone(maze) = -1                    'set its done flag
      ELSEIF PlayMode = 2 THEN                   'select mode
         maze = Menus(2) + 1                     'let user select number
         mazetot = 19                            'exit at end of outer loop
      ELSE                                       'in order
         maze = maze + 1                         'increment
      END IF
      mazetot = mazetot + 1                      'increment total

      LoadMaze maze                              'load the maze
      GoodMaze = -1                              'assume its ok
      FOR r = 0 TO 9                             'top to bottom
         FOR c = 0 TO 15                         'left to right
            IF MazeMap(c, r) = 0 THEN GoodMaze = 0    'check for holes
         NEXT
      NEXT

      IF GoodMaze THEN                           'maze has to be ok
         col = 0: row = 0                        'start values
         lc = col: lr = row                      'ditto
         wx = 0: wy = 0                          'ditto
         ThisPart = MazeMap(col, row)            'part at 0,0
         PUT (wx, wy), MazeParts(ThisPart * 202), PSET     'show it
         
         DO                                      'start inner loop
            ThisKey = GetKeyMask                 'check keyboard
            TestMask = ThisKey AND ThisPart      'keys AND map
            IF TestMask AND 1 THEN
              col = col - 1                      'go left
              IF col = -1 THEN col = 15          'screen wrap
            ELSEIF TestMask AND 2 THEN
              row = row - 1                      'go up
              IF row = -1 THEN row = 9           'screen wrap
            ELSEIF TestMask AND 4 THEN
              col = col + 1                      'go right
              IF col = 16 THEN col = 0           'screen wrap
            ELSEIF TestMask AND 8 THEN
              row = row + 1                      'go down
              IF row = 10 THEN row = 0           'screen wrap
            END IF

            IF row <> lr OR col <> lc THEN       'did it move?
               PUT (wx, wy), MazeParts(0), PSET  'image 0 is blank (erases)
               wx = col * 20: wy = row * 20      'calc new position
               ThisPart = MazeMap(col, row)      'check the map
               PUT (wx, wy), MazeParts(ThisPart * 202), PSET    'display part
               lc = col: lr = row                'save 'em
               FOR t = 800 TO 40 STEP -10
                  SOUND t, 8 / t                 'noise
               NEXT
               MilliDelay 100                    'give user time to let go
            END IF

            IF ThisKey AND 64 THEN               'Escape pressed
               opt = Menus(4)                    'ask what they want
               IF opt = 1 THEN                   'hint
                  sc = (col \ 8) * 8: ec = sc + 7     'calc start and end col
                  sr = (row \ 5) * 5: er = sr + 4     'calc start and end row
                  FOR r = sr TO er               'top to bottom
                     FOR c = sc TO ec            'left to right
                        ofs = MazeMap(c, r) * 202'which part
                        PUT (c * 20, r * 20), MazeParts(ofs), PSET
                     NEXT                        'display 1/4 of maze
                  NEXT
                  MilliDelay 1000                'pause
                  CLS                            'clear screen
                  PUT (wx, wy), MazeParts(ThisPart * 202), PSET 'current part
               ELSEIF opt = 2 THEN               'Quit
                  EXIT SUB                       'outta here
               END IF
            END IF

         LOOP UNTIL col = 15 AND row = 9         'end inner loop

         ShowMaze                                'show the maze
         DO
            FOR t = 250 TO 650 STEP 10
               SOUND t, .3                       'siren
            NEXT
         LOOP WHILE INKEY$ = ""                  'wait for key press
         CLS                                     'clear screen

      END IF                                     'maze has to be ok
   LOOP UNTIL mazetot = 20                       'end outer loop
   
END SUB

SUB PositionParts

   ShowMaze                                      'show the maze
   part = SelectPart                             'let user select part
   imageofs = part * 202                         'calc its offset
   PUT (wx, wy), MazeParts(imageofs), PSET       'show part
   LINE (wx, wy)-(wx + 19, wy + 19), 32, B       'draw a box around it
   MouseX = 0: MouseY = 0                        'upper left corner
   z = QBEX(4)                                   'set mouse position
   WaitLetGo                                     'wait for user to let go

   DO
      z = QBEX(2)                                'button status
      z = QBEX(3)                                'get mouse position
      col = MouseX \ 20                          'calc col
      row = MouseY \ 20                          'and  row
      ThisKey = GetKeyMask                       'check keyboard
      IF ThisKey THEN                            'key pressed
         IF ThisKey AND 1 THEN                   'cursor left pressed
            col = col - 1                        'move left
            IF col = -1 THEN col = 15            'screen wrap
         ELSEIF ThisKey AND 2 THEN               'cursor up pressed
            row = row - 1                        'move up
            IF row = -1 THEN row = 9             'screen wrap
         ELSEIF ThisKey AND 4 THEN               'cursor right pressed
            col = col + 1                        'move right
            IF col = 16 THEN col = 0             'screen wrap
         ELSEIF ThisKey AND 8 THEN               'cursor down pressed
            row = row + 1                        'move down
            IF row = 10 THEN row = 0             'screen wrap
         END IF
         MouseX = col * 20 + 10: MouseY = row * 20 + 10  'put mouse in middle
         z = QBEX(4)                                     'set mouse position
         MilliDelay 100                                  'pause
      END IF

      IF col <> lc OR row <> lr THEN                  'did it move?
         PUT (wx, wy), MazeParts(MazeMap(lc, lr) * 202), PSET  'old part back
         wx = col * 20                                'calc new position
         wy = row * 20                                'ditto
         PUT (wx, wy), MazeParts(imageofs), PSET      'move current piece
         LINE (wx, wy)-(wx + 19, wy + 19), 32, B      'draw box around it
         lc = col: lr = row                           'save position
      END IF

      IF MouseLeft OR ThisKey AND 16 THEN MazeMap(col, row) = part
      'a left click or the enter key places current part at current position
     
      IF MouseRight OR ThisKey AND 32 THEN            'right click or spacebar
         PUT (wx, wy), MazeParts(MazeMap(lc, lr) * 202), PSET 'old part back
         part = SelectPart                            'select new part
         imageofs = part * 202                        'calc- offset
         PUT (wx, wy), MazeParts(imageofs), PSET      'show current part
         LINE (wx, wy)-(wx + 19, wy + 19), 32, B      'draw box around it
      END IF

   LOOP UNTIL ThisKey AND 64                          'loop until Escape key

   PUT (wx, wy), MazeParts(MazeMap(lc, lr) * 202), PSET 'old part back

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
      CASE 9 'check if file exists - if so return size
         CALL ABSOLUTE(ExtNum, FileName$, FileSize&, TSRofs)
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

FUNCTION SelectPart

   clr = 104                                     'a dark blue
   cav = -2                                      'getting lighter
   FOR x = 50 TO 58                              '9 boxes
      y = x - 20
      LINE (x, y)-(320 - x, 200 - y), clr, B     'draw border for parts
      IF x = 54 THEN cav = -cav                  'after middle getting darker
      clr = clr + cav                            'adjust
   NEXT
   LINE (59, 39)-(261, 161), 0, BF               'clear out middle
   
   img = 1                                       'start with part 1
   FOR y = 50 TO 130 STEP 40
      FOR x = 70 TO 230 STEP 40
         PUT (x, y), MazeParts(img * 202), PSET  'display parts
         img = img + 1                           'images 1 to 15
      NEXT
   NEXT

   wx = 69: wy = 49                              'start position
   LINE (wx, wy)-(wx + 21, wy + 21), 32, B       'draw red box
   smx = MouseX: smy = MouseY                    'save mouse position
   MouseX = 0: MouseY = 0                        'and 0 it
   z = QBEX(4)                                   'set mouse position
   WaitLetGo                                     'wait for user to let go

   DO
      z = QBEX(2)                                'button status
      z = QBEX(3)                                'get mouse position
      
      col = MouseX \ 20                          'calc col
      IF col > 4 THEN col = 4                    '5 columns (0-4)
      row = MouseY \ 20                          'calc row
      IF row > 2 THEN row = 2                    '3 rows (0-2)

      ThisKey = GetKeyMask                       'check keyboard
      IF ThisKey THEN                            'key pressed
         IF ThisKey AND 1 THEN
           IF col > 0 THEN col = col - 1         'go left
         ELSEIF ThisKey AND 2 THEN
           IF row > 0 THEN row = row - 1         'go up
         ELSEIF ThisKey AND 4 THEN
            IF col < 4 THEN col = col + 1        'go right
         ELSEIF ThisKey AND 8 THEN
           IF row < 2 THEN row = row + 1         'go down
         END IF
         MouseX = col * 20 + 10                  'point mouse to
         MouseY = row * 20 + 10                  'middle of box
         z = QBEX(4)                             'set mouse position
         MilliDelay 100                          'give user time to let go
      END IF

      IF col <> lc OR row <> lr THEN             'did it change?
         LINE (wx, wy)-(wx + 21, wy + 21), 0, B  'erase last red box
         wx = col * 40 + 69                      'calc box -
         wy = row * 40 + 49                      '         - position
         LINE (wx, wy)-(wx + 21, wy + 21), 32, B 'draw red box
         lc = col: lr = row                      'save position
      END IF

   LOOP UNTIL MouseLeft OR ThisKey AND 16        'left click or Enter

   ShowMaze                                      'put screen back
   MouseX = smx: MouseY = smy                    'and the mouse
   z = QBEX(4)                                   'set mouse position

   WaitLetGo                                     'wait for user to let go

   SelectPart = row * 5 + col + 1                'calc which part box was on

END FUNCTION

SUB SetColors (pal() AS Hues, fc, lc)
      OUT &H3C8, fc                    'tell controller to get ready
   FOR t = fc TO lc                    'from first to last
      OUT &H3C9, pal(t).red            'send red component
      OUT &H3C9, pal(t).green          'send green component
      OUT &H3C9, pal(t).blue           'send blue component
   NEXT
END SUB

SUB ShowMaze

   FOR y = 0 TO 180 STEP 20            'from top to bottom
      FOR x = 0 TO 300 STEP 20         'from left to right
         PUT (x, y), MazeParts(MazeMap(col, row) * 202), PSET   'show part
         col = col + 1                 'adjust
      NEXT
      col = 0                          'reset
      row = row + 1                    'adjust
   NEXT

END SUB

SUB WaitLetGo
   DO
      z = QBEX(2)                           'get button status
   LOOP WHILE MouseLeft OR GetKeyMask       'wait 'til user lets go
END SUB
