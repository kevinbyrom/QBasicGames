' ** FLY-PIGS.BAS
' ** 1993 Fred Sexton Jr.
' ** Requires: QBasic Extender TSR
' **
DEFINT A-Z                                       'default type = integer
TYPE Hues                                        'define type for hues
    red AS INTEGER                               'red component
  green AS INTEGER                               'green component
   blue AS INTEGER                               'blue component
END TYPE
TYPE imgloc                                      'type for image locations
   x AS INTEGER                                  'X position
   y AS INTEGER                                  'Y position
   img AS INTEGER                                'image number
   stp AS INTEGER                                'current step
END TYPE

DECLARE FUNCTION QBEX (ExtNum)                   'TSR interface
DECLARE SUB MilliDelay (msecs)                   'SUB to create delays
DECLARE SUB SetColors (pal() AS Hues, fc, lc)    'SUB to modify palette
DECLARE FUNCTION GetKeyMask ()                   'FUNCTION to handle keyboard
'---------- define the variables used by the Extender TSR ----------
COMMON SHARED ExtKeyOfs, ExtKeySeg
COMMON SHARED FileName$, FileSize&
'-------------------------------------------------------------------

IF NOT QBEX(0) THEN                              'verify presence of TSR
   PRINT "QBasic Extender TSR not found"
   END
END IF

SCREEN 13                                        '320 x 200 w/256 colors
MilliDelay 0                                     'initialize
REDIM pal(255) AS Hues                           'array for palette
DEF SEG = VARSEG(pal(0))                         'point to it
BLOAD "DEFAULT.PAL", 0                           'load from file
SetColors pal(), 0, 255                          'set system colors

FileName$ = "FLYPIGS.SPR"                        'pigs sprite file
IF NOT QBEX(9) THEN END                          'get its size
ldelm = (FileSize& - 7) \ 2                      'calc array size
REDIM Pigs(ldelm)                                'array for pigs
DEF SEG = VARSEG(Pigs(0))                        'point to it
BLOAD FileName$, 0                               'load from file
PigEPI = ((Pigs(0) \ 8) * Pigs(1)) \ 2 + 2       'elements per image

REDIM imgs(13) AS imgloc                         'array for image locations
FOR t = 0 TO 13                                  '14 different pigs
   DO
      ok = 0                                     'assume ok
      x = RND * 260 + 1                          'random position
      y = RND * 140 + 1                          'ditto
      FOR z = 1 TO t                             'check for overlap
         IF ABS(x - imgs(z).x) < 30 AND ABS(y - imgs(z).y) < 30 THEN ok = -1
      NEXT
   LOOP WHILE ok                                 'if overlaps try again
   imgs(t).x = x                                 'assign location
   imgs(t).y = y                                 'ditto
   imgs(t).img = t * 4                           'each pig has 4 images
   imgs(t).stp = RND * 5                         'random step
NEXT

REDIM steporder(5)                               'array for step order
steporder(1) = 1: steporder(2) = 2               'assign steps
steporder(3) = 1: steporder(5) = 3               'ditto

DO                                               'main loop

   FOR t = 0 TO 13                               '14 different pigs
      cstp = steporder(imgs(t).stp)              'current step
      PUT (imgs(t).x, imgs(t).y), Pigs((imgs(t).img + cstp) * PigEPI), PSET
                                                 'display image
      imgs(t).stp = imgs(t).stp + 1              'increment step
      IF imgs(t).stp = 6 THEN imgs(t).stp = 0    'enforce max

      IF (imgs(t).x AND 1) THEN imgs(t).y = imgs(t).y + 1  'move down (2X:1Y)
      IF imgs(t).y = 171 THEN                              'screen edge
         LINE (imgs(t).x, imgs(t).y)-(imgs(t).x + 29, imgs(t).y + 29), 0, BF
                                                 'erase last image
         imgs(t).y = 0                           'screen wrap
      END IF

      imgs(t).x = imgs(t).x - 1                  'move left
      IF imgs(t).x = -1 THEN                     'screen edge
         LINE (imgs(t).x, imgs(t).y)-(imgs(t).x + 29, imgs(t).y + 29), 0, BF
                                                 'erase last image
         imgs(t).x = 290                         'screen wrap
      END IF
   NEXT

   MilliDelay 10                                 'pause

LOOP UNTIL GetKeyMask                            'wait for escape

END

FUNCTION GetKeyMask
  
   DEF SEG = &H40                                'point head to tail emptying
   POKE &H1A, PEEK(&H1C)                         'the keyboard buffer

   DEF SEG = ExtKeySeg                           'point to QBEX's data
   GetKeyMask = PEEK(ExtKeyOfs + 1)              'Escape
      
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
