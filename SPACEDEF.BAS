' ** SPACEDEF.BAS
' ** 1993 Fred Sexton Jr.
' ** Requires: QBasic Extender TSR
' **
DEFINT A-Z
TYPE Hues                                        'type for hues
    red AS INTEGER                               'red component
  green AS INTEGER                               'green component
   blue AS INTEGER                               'blue component
END TYPE

DECLARE FUNCTION QBEX (ExtNum)                   'TSR interface
DECLARE SUB DrawBackGround ()                    'SUB to draw background
DECLARE SUB MilliDelay (msecs)                   'SUB to create delays
DECLARE SUB SetColors (pal() AS Hues, fc, lc)    'SUB to modify palette
DECLARE FUNCTION GetKeyMask ()                   'SUB to handle keyboard
DECLARE FUNCTION YesOrNo ()                      'FUNCTION for Yes or No

'---------- define the variables used by the Extender TSR ----------
COMMON SHARED ExtKeyOfs, ExtKeySeg
'-------------------------------------------------------------------

IF NOT QBEX(0) THEN                    'verify presence of TSR
   PRINT "QBasic Extender TSR not found"
   END
END IF

SCREEN 13                                        '320 x 200 w/256 colors
MilliDelay 0                                     'initialize
REDIM pal(255) AS Hues                           'array for palette
SetColors pal(), 0, 255           'all = 0  - won't see ships being drawn

REDIM Ship(3647)                                 'array for ship
ShipEPI = 152                                    '50 by 6
FOR x = 1 TO 24                                  '24 ships
   x2 = 49 - x                                   'opposite end
   LINE (x, 2)-(x2, 3), 92, BF                   'draw ship
   IF x < 24 THEN                                'according to size
      PSET (x + 2, 2), 80                        'dress it up some
      PSET (x2 - 2, 2), 80                       'ditto
      PSET (x + 2, 3), 64                        'ditto
      PSET (x2 - 2, 3), 64                       'ditto
   ELSE
      LINE (x, 2)-(x2, 3), 64, BF                'ditto
   END IF
   IF x < 22 THEN                                'according to size
      LINE (x + 5, 1)-(x2 - 5, 1), 91            'dress it up some
      LINE (x + 5, 4)-(x2 - 5, 4), 92            'ditto
      LINE (x + 3, 2)-(x2 - 3, 3), 96, BF        'ditto
   END IF
   IF x < 14 THEN                                'according to size
      LINE (x + 10, 0)-(x2 - 10, 0), 89          'dress it up some
      LINE (x + 10, 5)-(x2 - 10, 5), 90          'ditto
   END IF
   GET (x - 1, 0)-(x2 + 1, 5), Ship(ofs)         'capture each ship
   ofs = ofs + ShipEPI                           'adjust
   LINE (0, 0)-(49, 5), 0, BF                    'erase it
NEXT

REDIM Cannon(201)                                'array for cannon
CanX = 40                                        'set up values
CanY = 160                                       'ditto
mcy = 179                                        'ditto
FOR x = 2 TO 10                                  'kinda 3D
   y2 = mcy + 2 - (x * 2)                        'calc once
   clr = 252 - x                                 'ditto
   LINE (CanX + x, mcy)-(CanX + x, y2), clr      'draw it
   LINE (CanX + 19 - x, mcy)-(CanX + 19 - x, y2), clr      'ditto
NEXT
GET (CanX, CanY)-(CanX + 19, mcy), Cannon        'capture it

DEF SEG = VARSEG(pal(0))                         'point to array
BLOAD "DEFAULT.PAL", 0                           'load from file
pal(0).red = 10                                  'set background
pal(0).green = 10                                'to a dark shade
pal(0).blue = 15                                 'of blue gray
SetColors pal(), 0, 255                          'set system colors

DO                                               'play again loop
   DrawBackGround
   PUT (CanX, CanY), Cannon, PSET                'display cannon
   ShipX! = 0: ShipY = 10                        'starting values
   ShipDir! = .5: CurOfs = 0                     'ditto
   MaxShipX! = 270: freq = 50                    'ditto
   delay = 8: score = 0                          'ditto
   ShotFlag = 0: ShotY = 0                       'ditto

   DO                                            'main loop
      ThisKey = GetKeyMask                       'check keyboard
      IF ThisKey AND 8 THEN                      'Escape
         END                                     'they want to quit
      ELSEIF ThisKey AND 1 THEN                  'cursor left
         IF CanX > 40 THEN CanX = CanX - 2       'move cannon
      ELSEIF ThisKey AND 2 THEN                  'cursor right
         IF CanX < 260 THEN CanX = CanX + 2      'move cannon
      END IF
      IF ThisKey THEN PUT (CanX, CanY), Cannon, PSET  'display cannon

      IF ThisKey AND 4 THEN                      'SpaceBar
         IF ShotFlag = 0 THEN ShotFlag = NOT ShotFlag 'set the flag
      END IF

      IF ShotFlag THEN                           'shot active
         IF ShotY THEN                           'not first pass
            ShotY = ShotY - 2                    'going upward
            IF ShotY THEN                        'still going
               IF POINT(ShotX, ShotY) OR POINT(ShotX2, ShotY) THEN
                                                 'hit the ship
                  SOUND 500, .5                  'beep
                  freq = freq + 25               'adjust ship noise
                  ShotFlag = NOT ShotFlag        'end of this shot
                  LINE (ShotX, ShotY + 2)-(ShotX2, ShotY + 6), 0, B 'erase
                  ShotY = 0                           'reset
                  PUT (ShipX!, ShipY), Ship(CurOfs)   'erase last ship
                  ShipDir! = -ShipDir!                'change direction
                  score = score + 1                   'keep track
                  CurOfs = CurOfs + ShipEPI                'adjust
                  MaxShipX! = MaxShipX! + 2                'ditto
                  ShipX! = ShipX! + 1: ShipY = ShipY + 3   'ditto
                  IF score MOD 24 = 0 THEN                 '24 ships
                     IF delay THEN delay = delay - 1       'speed up
                     ShipX! = 0: ShipY = 10                'new ship
                     ShipDir! = .5: freq = 50              'reset
                     CurOfs = 0: MaxShipX! = 270           'ditto
                  END IF
                  PUT (ShipX!, ShipY), Ship(CurOfs), PSET  'display ship

               ELSE                              'keep moving shot
                  LINE (ShotX, ShotY + 5)-(ShotX2, ShotY + 6), 0, B
                  LINE (ShotX, ShotY)-(ShotX2, ShotY + 1), 32, B
               END IF
            ELSE                                 'top of screen
               ShotFlag = NOT ShotFlag           'done
               LINE (ShotX, ShotY)-(ShotX2, ShotY + 6), 0, B 'erase last
            END IF

         ELSE                                    'first pass
            ShotX = CanX + 9                     'set up values
            ShotX2 = ShotX + 1                   'ditto
            ShotY = CanY - 4                     'ditto
            LINE (ShotX, CanY)-(ShotX2, ShotY), 32, B 'draw the shot
         END IF
      END IF
      
      ShipX! = ShipX! + ShipDir!                 'adjust
      IF (ShipX! = -1) OR (ShipX! > MaxShipX!) THEN   'screen edges
         ShipDir! = -ShipDir!                    'reverse
         ShipX! = ShipX! + ShipDir!              'adjust
         PUT (ShipX!, ShipY), Ship(CurOfs)       'erase last
         ShipY = ShipY + 5                       'adjust
         IF ShipY >= 153 THEN EXIT DO            'lose yet?
         IF ShotFlag THEN                        'shot active
            ShotFlag = NOT ShotFlag              'deactivate
            LINE (ShotX, ShotY)-(ShotX2, ShotY + 6), 0, B 'erase last
            ShotY = 0                            'adjust
         END IF
      END IF
      PUT (ShipX!, ShipY), Ship(CurOfs), PSET    'display ship
      IF ShipX! MOD 20 = 0 THEN SOUND freq, .2   'noise
      MilliDelay delay                           'slowdown

   LOOP                                          'end main loop
   
   ShipX! = 0: ShipDir! = 1                      'set up values
   CurOfs = 0: MaxShipX! = 270                   'ditto
   ShipY = 154: freq = 100                       'ditto
   DO                                            'victory dance loop
      PUT (ShipX!, ShipY), Ship(CurOfs), PSET    'display ship
      ShipX! = ShipX! + ShipDir!                 'adjust
      IF (ShipX! = -1) OR (ShipX! > MaxShipX!) THEN   'edges
         ShipDir! = -ShipDir!                    'reverse
         ShipX! = ShipX! + ShipDir!              'adjust
         PUT (ShipX!, ShipY), Ship(CurOfs)       'erase last
         IF ShipY < 194 THEN                     'til done
            ShipY = ShipY + 5                    'move down
         ELSE                                    'done
            EXIT DO                              'out of loop
         END IF
      END IF
      SOUND freq, freq / 5000                    'noise
      freq = freq + 100                          'adjust
      IF freq = 1000 THEN freq = 100             'check limit
   LOOP
  
   IF score > HighScore THEN HighScore = score   'keep track
   LOCATE 10, 12                                 'tell 'em the score
   PRINT "High Score:";
   PRINT USING "#####"; HighScore
   LOCATE 12, 12
   PRINT "Your Score:";
   PRINT USING "#####"; score

   LOCATE 25, 12
   PRINT "Play Again (Y/N)?";                    'ask if they've had enough

LOOP WHILE YesOrNo

END

SUB DrawBackGround

   CLS                                           'clear screen
   clr = 214                                     'brown
   y = 180: y2 = 199                             'starting values
   FOR x = 0 TO 9                                'cycle for 3D effect
      FOR xs = 0 TO 300 STEP 20                  'cycle across screen
         LINE (xs + x, y)-(xs + 19 - x, y2), clr, B   'draw base
         IF xs < 40 OR xs > 260 THEN             'on ends - do sides
            LINE (xs + x, y - 20)-(xs + 19 - x, y2 - 20), clr, B
         END IF
      NEXT
      y = y + 1: y2 = y2 - 1                     'adjust
      clr = clr + 1                              'ditto
   NEXT

END SUB

FUNCTION GetKeyMask

   DEF SEG = ExtKeySeg                           'point to QBEX's data
   l = PEEK(ExtKeyOfs + 75) AND 1                'cursor left
   r = PEEK(ExtKeyOfs + 77) AND 2                'cursor right
   SB = PEEK(ExtKeyOfs + 57) AND 4               'Space Bar
   Esc = PEEK(ExtKeyOfs + 1) AND 8               'Escape

   DEF SEG = &H40                                'point head to tail
   POKE &H1A, PEEK(&H1C)                         'emptying buffer
   
   GetKeyMask = l OR r OR SB OR Esc              'or 'em all together
      
END FUNCTION

SUB MilliDelay (msecs) STATIC

    IF sysfact& THEN                   'Did we calc- system speed yet?
        IF msecs THEN                 'have to want a delay
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
   REDIM ary(46)                                 'array for machine code
   DEF SEG = VARSEG(ary(0))                      'point to its seg
   BLOAD "CallMult.FPS", 0                       'load machine code
   CALL ABSOLUTE(TSRofs, TSRseg, 0)              'call the code
   ERASE ary                                     'done with the array
   IF TSRseg THEN                                'TSR was found
      DEF SEG = TSRseg                           'point to its seg
      CALL ABSOLUTE(ExtNum, ExtKeyOfs, ExtKeySeg, TSRofs)
      QBEX = ExtNum
   ELSE                                          'TSR not found
      QBEX = 0                                   'return false
   END IF
END FUNCTION

SUB SetColors (pal() AS Hues, fc, lc)
   OUT &H3C8, fc                                 'get controller ready
   FOR t = fc TO lc                              'from first to last
      OUT &H3C9, pal(t).red                      'send red component
      OUT &H3C9, pal(t).green                    'send green component
      OUT &H3C9, pal(t).blue                     'send blue component
   NEXT
END SUB

FUNCTION YesOrNo

   DO
      DEF SEG = ExtKeySeg                        'point to QBEX's data
      y = PEEK(ExtKeyOfs + 21)                   'check key table.
      N = PEEK(ExtKeyOfs + 49)                   'ditto
      DEF SEG = &H40                             'point head to tail
      POKE &H1A, PEEK(&H1C)                      'emptying buffer
   LOOP UNTIL y OR N

   YesOrNo = y                                   'True if yes

END FUNCTION
