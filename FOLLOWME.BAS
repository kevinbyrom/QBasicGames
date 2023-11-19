' ** FollowMe.BAS
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
DECLARE SUB BarBlink (bar)             'SUB to make bars blink
DECLARE SUB MilliDelay (msecs)         'SUB to create delays
DECLARE SUB SetColors (pal() AS Hues, fc, lc) 'SUB to modify palette
DECLARE SUB NewSequence (Sequence(), SeqLen)  'SUB to create random sequence
DECLARE FUNCTION CheckEscape ()        'function to monitor escape key
DECLARE FUNCTION YesOrNo ()            'function for Yes or No
DECLARE FUNCTION RandOrAdd ()          'function for Random or Additive
DECLARE SUB CenterPrint (A$, row)      'SUB to print string in center

'---------- define the variables used by the Extender TSR ----------
COMMON SHARED ExtKeyOfs, ExtKeySeg
COMMON SHARED MouseLeft, MouseRight, MouseX, MouseY
COMMON SHARED MinMX, MaxMX, MinMY, MaxMY
'-------------------------------------------------------------------
COMMON SHARED Bpal() AS Hues, Dpal() AS Hues

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

REDIM Bpal(255) AS Hues                'array for bright hues
REDIM Dpal(255) AS Hues                'array for dim hues

FOR t = 20 TO 51                       'set up 4 groups of 31 colors
   Dpal(t).red = t                     'dim reds
   Bpal(t).red = t + 12                'bright reds

   Dpal(t + 32).green = t              'dim greens
   Bpal(t + 32).green = t + 12         'bright greens

   Dpal(t + 64).blue = t               'dim blues
   Bpal(t + 64).blue = t + 12          'bright blues

   Dpal(t + 96).red = t                'dim purples
   Dpal(t + 96).blue = t
   Bpal(t + 96).red = t + 12           'bright purples
   Bpal(t + 96).blue = t + 12
NEXT

fc = 20                                'at start up all
lc = 147                               'need to be set
SetColors Dpal(), fc, lc               'to their dim hues

clr = 20                               'first color in first group
cav = 1                                'going up
FOR t = 1 TO 63                        'each bar has 63 lines

    LINE (t, t)-(319 - t, t), clr                   'red bar
    LINE (t, t)-(t, 199 - t), clr + 32              'green bar
    LINE (t, 199 - t)-(319 - t, 199 - t), clr + 64  'blue bar
    LINE (319 - t, t)-(319 - t, 199 - t), clr + 96  'purple bar

    IF t = 32 THEN cav = -cav          'when middle - go back down
    clr = clr + cav                    'set up for next pass

NEXT

REDIM Sequence(1 TO 1000)              'array for sequence

DO                                     'start of play again loop

   LINE (64, 64)-(255, 135), 0, BF     'erase the center
   Mistakes = 0                        'starting values
   ThisLen = 3                         'ditto
   NewSequence Sequence(), 1000        'ditto

   CenterPrint "Random", 10           'ask which way they wanna play
   CenterPrint "OR", 12
   CenterPrint "Additive", 14
   CenterPrint "(R/A)", 16
                                  
   RandomSeq = RandOrAdd               'returns True for random
   
   LINE (64, 64)-(255, 135), 0, BF     'erase the question
  
   CenterPrint "High Score   ", 11     'print all the info
   LOCATE 11, 25
   PRINT USING "###"; HighScore
   CenterPrint "This Count   ", 13
   LOCATE 13, 25
   PRINT USING "###"; ThisLen
   CenterPrint "Mistakes     ", 15
   LOCATE 15, 25
   PRINT USING "###"; Mistakes
   
   z = QBEX(5)                         'turn on the mouse cursor

   DO                                  'begin main loop
      FOR t = 1 TO ThisLen             'play the sequence
         BarBlink Sequence(t)
      NEXT

      t = 1                            'to align clicks with Sequence
      z = QBEX(2)                      'get rid of extraneous clicks
      DO                               'start of mouse input loop
         IF CheckEscape THEN           'if they want to quit - let 'em
            z = QBEX(6)                'MUST turn mouse cursor off
            END                        'before ending
         END IF

         z = QBEX(2)                   'button status
         z = QBEX(3)                   'position
         IF MouseLeft THEN             'left button pressed?

            z = QBEX(6)                'cursor off
            pclr = POINT(MouseX, MouseY) 'get point color under mouse
            z = QBEX(5)                'cursor on

            IF pclr > 19 THEN          'on a bar?
               ClickBar = (pclr - 20) \ 32  'which bar
               IF ClickBar = Sequence(t) THEN    'is the right bar?
                  BarBlink ClickBar    'blink it
                  t = t + 1            'ready for next one
                  z = QBEX(2)          'get rid of extraneous clicks
               ELSE                    'wrong bar
                  FOR z = 1 TO 10
                    SOUND 200, .5      'make some noise
                    SOUND 100, .5      'to let 'em know they're wrong
                  NEXT
                  Mistakes = Mistakes + 1   'add up their mistakes
                  z = QBEX(6)                   'turn mouse cursor off
                  LOCATE 15, 25
                  PRINT USING "###"; Mistakes   'show em
                  z = QBEX(5)                   'turn on the mouse cursor
                  EXIT DO              'jump out of mouse loop
               END IF                  'is the right bar?
            END IF                     'on a bar?
         END IF                        'left button pressed?

      LOOP WHILE t <= ThisLen          'end of mouse input loop

      IF t > ThisLen THEN              'if they got it all
         IF ThisLen > HighScore THEN HighScore = ThisLen   'keep track
         ThisLen = ThisLen + 1         'make the next one longer
         IF RandomSeq THEN NewSequence Sequence(), ThisLen

         z = QBEX(6)                   'turn mouse cursor off
         LOCATE 11, 25
         PRINT USING "###"; HighScore  'show em
         LOCATE 13, 25
         PRINT USING "###"; ThisLen
         z = QBEX(5)                   'turn on the mouse cursor

         FOR t = 1 TO 3
           SOUND 200, 1                'make some noise
           SOUND 300, 1                'to show end of level
           SOUND 400, 1
         NEXT
      END IF

      MilliDelay 750                   'pause

   LOOP WHILE Mistakes < 3             'end of main loop

   z = QBEX(6)                         'turn mouse cursor off

   LINE (64, 64)-(255, 135), 0, BF
   
   CenterPrint "Play Again (Y/N)?", 13 'ask if they've had enough

LOOP WHILE YesOrNo                     'end of play again loop

END

SUB BarBlink (bar)

   fc = bar * 32 + 20                  'calculate first
   lc = fc + 31                        '                & last color
   SetColors Bpal(), fc, lc            'brighten a bar
   SOUND bar * 500 + 500, 1            'make some noise
   MilliDelay 350                      'pause
   SetColors Dpal(), fc, lc            'dim bar back down
   MilliDelay 300                      'pause

   'NOTE: The speed of of blinks can be adjusted by changing the ****
   '****  values passed to MilliDelay.                           ****

END SUB

SUB CenterPrint (A$, row)
   sl = LEN(A$)                        'string's length
   col = 20 - (sl \ 2)                 'calc start column
   LOCATE row, col                     'locate cursor
   PRINT A$;                           'do it
END SUB

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

SUB NewSequence (Sequence(), SeqLen)

   FOR t = 1 TO SeqLen                 'build a sequence
      DO
         rv = RND * 3                  'color bars are numbered 0 - 3
      LOOP WHILE rv = lrv              'prevent same group twice in a row
      lrv = rv
      Sequence(t) = rv                 'store it
   NEXT

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

FUNCTION RandOrAdd

DO
   DEF SEG = ExtKeySeg                 'point to QBEX's data
   A = PEEK(ExtKeyOfs + 30)            'peek into table
   R = PEEK(ExtKeyOfs + 19)            'ditto
   DEF SEG = &H40                      'point head to tail thus emptying
   POKE &H1A, PEEK(&H1C)               'the keyboard buffer
LOOP UNTIL A OR R

   DEF SEG                             'reset to default seg
   POKE VARPTR(R) + 1, R               'extend to word by
                                       'copying low byte into high byte
   RandOrAdd = R                       'True if random

END FUNCTION

SUB SetColors (pal() AS Hues, fc, lc)
      OUT &H3C8, fc                    'tell controller to get ready
   FOR t = fc TO lc                    'from first to last
      OUT &H3C9, pal(t).red            'send red component
      OUT &H3C9, pal(t).green          'send green component
      OUT &H3C9, pal(t).blue           'send blue component
   NEXT
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
