' ** Cntr-Act.BAS - Counter Action Game
' ** 1993 Fred Sexton Jr.
' ** Requires: QBasic Extender TSR
' **
DEFINT A-Z
DECLARE FUNCTION QBEX (ExtNum)         'TSR interface
DECLARE SUB MilliDelay (msecs)         'SUB to create delays
DECLARE SUB UpdateKeys ()              'SUB to monitor keys
DECLARE FUNCTION YesOrNo ()            'function for Yes or No

'---------- define the variables used by the Extender TSR ----------
COMMON SHARED ExtKeyOfs, ExtKeySeg
COMMON SHARED CursorUp, CursorDown, CursorRight, CursorLeft
'-------------------------------------------------------------------

IF NOT QBEX(0) THEN                    'verify presence of TSR
   PRINT "QBasic Extender TSR not found"
   END
END IF

SCREEN 13                              '320x200 with 256 colors
RANDOMIZE TIMER                        'seed random number generator

MilliDelay 0                           'has to be initialized

Intensity = 63                         'brightest allowed
FOR clr = 16 TO 26                     'colors of the ball
   PALETTE clr, 65536 * Intensity + Intensity  'make it purple (blue+red)
   Intensity = Intensity - 4           'dimmer toward edge
NEXT

FOR t = 1 TO 10                        'draw the ball
 CIRCLE (10, 8), t, t + 15             'draw 2 circles to
 CIRCLE (10, 9), t, t + 15             '                  fill in the holes
NEXT

REDIM Ball(190)                        'make an array for the ball
GET (0, 0)-(20, 17), Ball              'capture it

LINE (49, 19)-(270, 180), 4, B         'draw the border
LINE (48, 18)-(271, 181), 12, B
LINE (47, 17)-(272, 182), 4, B

MinX = 50: MinY = 20                   'set the minimum
MaxX = 249: MaxY = 162                 '                & maximums

LOCATE 1, 12
PRINT "High Score:"

DO                                     'start of play again loop

   LINE (88, 192)-(221, 199), 0, BF    'will erase "Play Again (Y/N)?"

   PUT (LastX, LastY), Ball            'erase last ball
   BallX = 150: LastX = BallX          'starting values
   BallY = 90: LastY = BallY           'ditto
   MaxRand = 2                         'ditto
   Delay = 50                          'ditto

   PUT (BallX, BallY), Ball            'draw the first ball

   LOCATE 1, 23
   PRINT USING "#####"; HighScore

   DO                                  'start of main loop
      UpdateKeys                       'get latest key status

      IF CursorRight THEN RandX = RandX + 1      'adjust according to status
      IF CursorLeft THEN RandX = RandX - 1       'ditto
      IF CursorUp THEN RandY = RandY - 1         'ditto
      IF CursorDown THEN RandY = RandY + 1       'ditto

      IF RandX = 0 THEN RandX = (RND * MaxRand) - MaxRand \ 2  'don't let it
      IF RandY = 0 THEN RandY = (RND * MaxRand) - MaxRand \ 2  'sit still

      BallX = BallX + RandX            'calc -
      BallY = BallY + RandY            '       new position

      IF BallX <= MinX THEN            'check if it still in bounds
         BallX = MinX                  'don't let it mess up border
         GameOver = NOT GameOver       'toggle flag
      ELSEIF BallX >= MaxX THEN        'check if it still in bounds
         BallX = MaxX                  'don't let it mess up border
         GameOver = NOT GameOver       'toggle flag
      END IF

      IF BallY <= MinY THEN            'check if it still in bounds
         BallY = MinY                  'don't let it mess up border
         GameOver = NOT GameOver       'toggle flag
      ELSEIF BallY >= MaxY THEN        'check if it still in bounds
         BallY = MaxY                  'don't let it mess up border
         GameOver = NOT GameOver       'toggle flag
      END IF

      PUT (LastX, LastY), Ball         'erase last ball
      PUT (BallX, BallY), Ball         'draw the new ball

      LastX = BallX                    'update
      LastY = BallY                    'ditto

      Score = Score + 1                'add up their Score
      LOCATE 2, 17                     'position cursor
      PRINT USING "#####"; Score;      'show their Score

      IF Score MOD 100 = 0 THEN        'every 100 points
         IF Delay THEN                 'still slowing down?
            Delay = Delay - 5          'speed up
         ELSE                          'fast as it can go?
            MaxRand = MaxRand + 2      'increase distance it can move
         END IF
      END IF

      MilliDelay Delay                 'slow things down

   LOOP UNTIL GameOver                 'end of main loop

   FOR z = 1 TO 10
     SOUND 200, .5                     'make some noise
     SOUND 100, .5
   NEXT

   IF Score > HighScore THEN HighScore = Score        'keep track

   Score = 0: RandX = 0: RandY = 0     'reset for new game
   GameOver = NOT GameOver             'ditto

   LOCATE 25, 12                       'position cursor
   PRINT "Play Again (Y/N)?";          'ask if they've had enough
   
LOOP WHILE YesOrNo                     'end of play again loop

END

SUB MilliDelay (msecs) STATIC

    IF sysfact& THEN                   'Did we calc- system speed yet?
        IF msecs THEN                  'have to want a delay
            count& = (sysfact& * msecs) \ -54    'calc- # of loops needed
            DO
                count& = count& + 1         'negative - add to get to 0
                IF count& = z THEN EXIT DO  'when its 0 we're done
            LOOP UNTIL t2 = PEEK(&H6C)      'make it the same
        END IF
    ELSE                               'if sysfact& is 0, calc- system speed
        DEF SEG = &H40                 'point to low memory
        t1 = PEEK(&H6C)                'get tick count
        DO
            t2 = PEEK(&H6C)            'get tick count
        LOOP UNTIL t2 <> t1            'wait 'til its a new tick
        DO
            sysfact& = sysfact& + 1         'count number of loops
            IF sysfact& = z THEN EXIT DO    'make it the same
        LOOP UNTIL t2 <> PEEK(&H6C)         'keep going 'til its a new tick
        t2 = 256                            'prevent the delay loop's UNTIL
    END IF
END SUB

FUNCTION QBEX (ExtNum) STATIC
   REDIM ary(46)                       'array to hold machine code
   DEF SEG = VARSEG(ary(0))            'point to its seg
   BLOAD "CallMult.FPS", 0             'load machine code
   CALL ABSOLUTE(TSRofs, TSRseg, 0)    'call the code
   ERASE ary                           'done with the array
   IF TSRseg THEN                      'TSR was found
      DEF SEG = TSRseg                 'point to its seg
      CALL ABSOLUTE(ExtNum, ExtKeyOfs, ExtKeySeg, TSRofs)
      QBEX = ExtNum
   ELSE                                'TSR not found
      QBEX = 0                         'return false
   END IF
END FUNCTION

SUB UpdateKeys

   DEF SEG = ExtKeySeg                 'point to QBEX's data
   CursorUp = PEEK(ExtKeyOfs + 72)     'peek into table
   CursorDown = PEEK(ExtKeyOfs + 80)   'ditto
   CursorRight = PEEK(ExtKeyOfs + 77)  'ditto
   CursorLeft = PEEK(ExtKeyOfs + 75)   'ditto

   DEF SEG = &H40                      'point head to tail thus emptying
   POKE &H1A, PEEK(&H1C)               'the keyboard buffer
  
   'NOTE: To monitor other keys:                            ****
   '****        DEF SEG = ExtKeySeg                         ****
   '****        Key = PEEK(ExtKeyOfs+ScanCodeOfKey)         ****
   '****   values returned 255 = pressed   0 = not pressed  ****
   '****   If the key will be tested with "... NOT key ..." ****
   '****   it must be extended from a byte to a word by     ****
   '****   copying low byte into high byte:                 ****
   '****        DEF SEG                                     ****
   '****        POKE VARPTR(Key) + 1, Key                   ****

END SUB

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
