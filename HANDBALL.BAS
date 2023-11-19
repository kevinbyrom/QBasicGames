' ** HandBall.BAS
' ** 1993 Fred Sexton Jr.
' ** Requires: QBasic Extender TSR
' **
DEFINT A-Z
DECLARE FUNCTION QBEX (ExtNum)         'TSR interface
DECLARE SUB MilliDelay (msecs)         'SUB to create delays
DECLARE FUNCTION YesOrNo ()            'function for Yes or No
DECLARE FUNCTION UpDateKeys ()         'function to monitor keys

'---------- define the variables used by the Extender TSR ----------
COMMON SHARED ExtKeyOfs, ExtKeySeg, CursorRight, CursorLeft
COMMON SHARED MouseLeft, MouseRight, MouseX, MouseY
COMMON SHARED MinMX, MaxMX
'-------------------------------------------------------------------

IF NOT QBEX(0) THEN                    'verify presence of TSR
   PRINT "QBasic Extender TSR not found"
   END
END IF

SCREEN 13                              '320x200 with 256 colors

MilliDelay 0                           'has to be initialized

z = QBEX(1)                            'verify presence of mouse

LINE (1, 0)-(16, 4), 4, B              'draw the paddle
LINE (0, 1)-(17, 3), 4, BF             'ditto
LINE (1, 1)-(16, 3), 12, B             'ditto

REDIM Paddle(46)                       'array for paddle
GET (0, 0)-(17, 4), Paddle             'capture it
PUT (MouseX, PaddleY), Paddle          'erase it

LINE (4, 3)-(6, 5), 31, BF             'draw the ball
FOR t = 1 TO 4
 CIRCLE (5, 4), t, 30 - t              'ditto
NEXT

REDIM Ball(51)                         'array for ball
GET (0, 0)-(10, 8), Ball               'capture it
PUT (0, 0), Ball                       'erase it

LINE (0, 0)-(319, 2), 1, B             'draw the border
LINE (0, 0)-(2, 199), 1, B             'ditto
LINE (317, 0)-(319, 199), 1, B         'ditto
LINE (1, 1)-(1, 198), 9                'ditto
LINE (1, 1)-(318, 1), 9                'ditto
LINE (318, 1)-(318, 198), 9            'ditto

MinMX = 3                              'minimum mouse X
MaxMX = 299                            'maximum mouse X
z = QBEX(7)                            'set mouse min & max X values

PaddleY = 195                          'paddle at the bottom
AddBallX = 1                           'ball moves 1 pixel each loop

DO                                     'start of play again loop

   LINE (88, 72)-(223, 199), 0, BF     'will erase all the writing
   Score = 0: Delay = 10               'set up starting values
   BallX = 157: BallY = 100            'ditto
   AddBallY = -1
   MouseX = 151                        'ditto
   LastMX = MouseX                     'ditto
   z = QBEX(4)                         'set mouse position
   PUT (MouseX, PaddleY), Paddle       'display paddle
   
   DO                                  'start of main loop
      
      z = QBEX(3)                      'get mouse position

      IF UpDateKeys THEN               'if they use keys
         MouseX = MouseX OR 1          'force it to be odd
         IF CursorRight AND MouseX < MaxMX THEN MouseX = MouseX + 2
         IF CursorLeft AND MouseX > MinMX THEN MouseX = MouseX - 2
         z = QBEX(4)                   'set mouse position
      END IF

      PUT (LastMX, PaddleY), Paddle    'erase paddle
      PUT (MouseX, PaddleY), Paddle    'display paddle
      LastMX = MouseX

      IF BallX = 3 OR BallX = 306 THEN
         AddBallX = -AddBallX          'bounce off sides
         SOUND 500, .3                 'noise
      END IF

      IF BallY = 3 THEN
         AddBallY = -AddBallY          'bounce off top
         SOUND 500, .3                 'noise
      END IF

      IF BallY = 186 THEN
                                       'check if the paddle's there
         IF BallX < MouseX - 9 OR BallX > MouseX + 18 THEN EXIT DO

         AddBallY = -AddBallY          'bounce off paddle
         Score = Score + 1
         IF Score MOD 10 = 0 THEN
            IF Delay THEN Delay = Delay - 1          'speed it up
            FOR t = 1 TO 2
              SOUND 2000, .3           'noise
              SOUND 4000, .3
            NEXT
         ELSE
            SOUND 500, .3              'noise
         END IF
      END IF

      BallY = BallY + AddBallY         'adjust ball position
      BallX = BallX + AddBallX         'ditto

      PUT (BallX, BallY), Ball, PSET             'display ball

      MilliDelay Delay                 'pause

   LOOP

   FOR z = 1 TO 10
     SOUND 200, .5                       'make some noise
     SOUND 100, .5
   NEXT

   LINE (3, 186)-(316, 199), 0, BF       'erase ball & paddle

   IF Score > HighScore THEN HighScore = Score        'keep track

   LOCATE 10, 12                       'tell 'em the score
   PRINT "High Score:";
   PRINT USING "#####"; HighScore
   LOCATE 12, 12
   PRINT "Your Score:";
   PRINT USING "#####"; Score

   LOCATE 25, 12
   PRINT "Play Again (Y/N)?";          'ask if they've had enough
   
LOOP WHILE YesOrNo

END

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
      CASE 3 TO 4 'get / set mouse position
         MouseX = MouseX * 2           'adjust for screen mode
         CALL ABSOLUTE(ExtNum, MouseX, MouseY, TSRofs)
         MouseX = MouseX \ 2           'adjust for screen mode
      CASE 7  'set min & max mouse X values
         RealMinMX = MinMX * 2         'adjust for screen mode
         RealMaxMX = MaxMX * 2         'adjust for screen mode
         CALL ABSOLUTE(ExtNum, RealMinMX, RealMaxMX, TSRofs)
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

FUNCTION UpDateKeys

   DEF SEG = ExtKeySeg                 'point to QBEX's key table
   CursorRight = PEEK(ExtKeyOfs + 77)  'peek into table
   CursorLeft = PEEK(ExtKeyOfs + 75)   'ditto

   DEF SEG = &H40                      'point head to tail thus emptying
   POKE &H1A, PEEK(&H1C)               'the keyboard buffer

   UpDateKeys = CursorRight OR CursorLeft   'True for either key

END FUNCTION

FUNCTION YesOrNo

DO
   DEF SEG = ExtKeySeg                 'point to QBEX's data
   Y = PEEK(ExtKeyOfs + 21)            'check status in QBEX's key table.
   N = PEEK(ExtKeyOfs + 49)            'ditto
   DEF SEG = &H40                      'point head to tail thus emptying
   POKE &H1A, PEEK(&H1C)               'the keyboard buffer
LOOP UNTIL Y OR N
 
   DEF SEG                             'reset to default seg
   POKE VARPTR(Y) + 1, Y               'extend to word by
                                       'copying low byte into high byte
   YesOrNo = Y                         'True if yes

END FUNCTION
