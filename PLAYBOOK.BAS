' ** FightTest.BAS
' ** 1995 Kevin Byrom
' ** Requires: QBasic Extender TSR
' **
DEFINT A-Z                                       'default type = integer
TYPE Hues                                        'define type for hues
    red AS INTEGER                               'red component
  green AS INTEGER                               'green component
   blue AS INTEGER                               'blue component
END TYPE

DECLARE FUNCTION QBEX (ExtNum)                   'TSR interface
DECLARE SUB millidelay (msecs)                   'SUB to create delays
DECLARE SUB SetColors (pal() AS Hues, fc, lc)    'SUB to modify palette
DECLARE FUNCTION GetKeyMask ()                   'FUNCTION to handle keyboard
'---------- define the variables used by the Extender TSR ----------
COMMON SHARED ExtKeyOfs, ExtKeySeg
COMMON SHARED FileName$, FileSize&
'-------------------------------------------------------------------

RANDOMIZE TIMER

IF NOT QBEX(0) THEN                              'verify presence of TSR
   PRINT "QBasic Extender TSR not found"
   END
END IF

SCREEN 13                                        '320 x 200 w/256 colors
millidelay 0                                     'initialize
REDIM pal(255) AS Hues                           'array for palette
DEF SEG = VARSEG(pal(0))                         'point to it
BLOAD "mix.PAL", 0                           'load from file
SetColors pal(), 0, 255
REDIM qbxchange(1 TO 4)
REDIM qbychange(1 TO 4)
REDIM qbxadd(1 TO 4)
REDIM qbyadd(1 TO 4)

REDIM wr1xchange(1 TO 4)
REDIM wr1ychange(1 TO 4)
REDIM wr1xadd(1 TO 4)
REDIM wr1yadd(1 TO 4)

REDIM wr2xchange(1 TO 4)
REDIM wr2ychange(1 TO 4)
REDIM wr2xadd(1 TO 4)
REDIM wr2yadd(1 TO 4)

REDIM texchange(1 TO 4)
REDIM teychange(1 TO 4)
REDIM texadd(1 TO 4)
REDIM teyadd(1 TO 4)

REDIM rb1xchange(1 TO 4)
REDIM rb1ychange(1 TO 4)
REDIM rb1xadd(1 TO 4)
REDIM rb1yadd(1 TO 4)

REDIM rb2xchange(1 TO 4)
REDIM rb2ychange(1 TO 4)
REDIM rb2xadd(1 TO 4)
REDIM rb2yadd(1 TO 4)

form$ = "proset"
ply = 2
IF ply = 1 THEN
  
   qbx = 160
   qby = 120

   
  
   rb1x = 150
   rb1y = 130

   rb2x = 170
   rb2y = 130

   tex = 130
   tey = 115

   wr1x = 105
   wr1y = 110
  
   wr2x = 215
   wr2y = 110

END IF
IF ply = 2 THEN
 
   qbx = 160
   qby = 120

  
 
   rb1x = 160
   rb1y = 130

   rb2x = 160
   rb2y = 140

   tex = 130
   tey = 115

   wr1x = 105
   wr1y = 110
 
   wr2x = 215
   wr2y = 110

END IF








IF form$ = "proset" THEN
   PSET (160, 110), 15
   PSET (150, 110), 14
   PSET (140, 110), 13
   PSET (170, 110), 14
   PSET (180, 110), 13

   PSET (qbx, qby), 200

   PSET (rb1x, rb1y), 100
   PSET (rb2x, rb2y), 100

   PSET (tex, tey), 50

   PSET (wr1x, wr1y), 39
   PSET (wr2x, wr2y), 39


END IF



FUNCTION GetKeyMask

   DEF SEG = ExtKeySeg                           'point to QBEX's data
   l = PEEK(ExtKeyOfs + 75) AND 1                'cursor left
   U = PEEK(ExtKeyOfs + 72) AND 2                'cursor up
   r = PEEK(ExtKeyOfs + 77) AND 4                'cursor right
   d = PEEK(ExtKeyOfs + 80) AND 8                'cursor down
   Ent = PEEK(ExtKeyOfs + 28) AND 16             'Enter
   SB = PEEK(ExtKeyOfs + 57) AND 32              'Space Bar
   Esc = PEEK(ExtKeyOfs + 1) AND 64              'Escape
   b = PEEK(ExtKeyOfs + 48) AND 128              'the B key

   DEF SEG = &H40                      'point head to tail thus emptying
   POKE &H1A, PEEK(&H1C)               'the keyboard buffer

   GetKeyMask = l OR U OR r OR d OR Ent OR SB OR Esc OR b
      
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

SUB SetColors (pal() AS Hues, fc, lc)
   OUT &H3C8, fc                                 'initialize controller
   FOR t = fc TO lc                              'from first to last
      OUT &H3C9, pal(t).red                      'send red component
     
      OUT &H3C9, pal(t).green                    'send green component
      OUT &H3C9, pal(t).blue                     'send blue component
   NEXT
END SUB

