' ** TREASLOT.BAS
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
DECLARE SUB  MilliDelay (msecs)                   'SUB to create delays
DECLARE SUB ScrollImages (ssc1, ssc2)            'SUB to spin slots
DECLARE SUB SetColors (pal() AS Hues, fc, lc)    'SUB to modify palette
DECLARE FUNCTION GetKeyMask ()                   'FUNCTION to handle keyboard
'---------- define the variables used by the Extender TSR ----------
COMMON SHARED ExtKeyOfs, ExtKeySeg, FileName$, FileSize&
'-------------------------------------------------------------------
COMMON SHARED Images(), ImgEPI                   'define the commons
COMMON SHARED curimg1, curimg2, curimg3          'ditto
CONST bitwidth = 240                             '30 * 8

IF NOT QBEX(0) THEN                              'verify presence of TSR
   PRINT "QBasic Extender TSR not found"
   END
END IF

SCREEN 13                                        '320 x 200 w/256 colors
RANDOMIZE TIMER                                  'initialize
MilliDelay 0                                     'ditto
REDIM pal(255) AS Hues                           'array for palette
DEF SEG = VARSEG(pal(0))                         'point to it
BLOAD "DEFAULT.PAL", 0                           'load from file
pal(0).red = 20                                  'set background
pal(0).green = 20                                'to a shade
pal(0).blue = 20                                 'of gray
SetColors pal(), 0, 255                          'set system colors

FileName$ = "TREASURE.SPR"                       'object sprite file
IF NOT QBEX(9) THEN END                          'get its size
ldelm = (FileSize& - 7) \ 2                      'calc array size
REDIM Images(ldelm)                              'array for objects
DEF SEG = VARSEG(Images(0))                      'point to it
BLOAD FileName$, 0                               'load from file
ImgEPI = ((Images(0) \ 8) * Images(1)) \ 2 + 2   'elements per image

LINE (0, 0)-(319, 199), 190, BF                  'fill in middle of machine
LINE (101, 21)-(218, 32), 0, BF                  'make space for words
LINE (117, 133)-(202, 145), 0, BF                'ditto
LINE (61, 165)-(258, 178), 0, BF                 'ditto
COLOR 192                                        'gold
LOCATE 4, 14
PRINT "TREASURE  SLOT"                           'print name
LOCATE 22, 9
PRINT "Press Space Bar to Play!"                 'print instructions
COLOR 15                                         'white
LOCATE 18, 16
PRINT "$";
PRINT USING "#########"; score&;                 'print score
clr = 235                                        'cyan
cav = -1                                         'getting lighter
FOR t = t = 0 TO 6                               '7 boxes
   LINE (101 - t, 21 - t)-(218 + t, 32 + t), clr, B        'draw border
   LINE (117 - t, 133 - t)-(202 + t, 145 + t), clr + 16, B 'ditto
   LINE (61 - t, 165 - t)-(258 + t, 178 + t), clr, B       'ditto
   IF t = 3 THEN cav = -cav                                'getting darker
   clr = clr + cav                                         'adjust
NEXT
clr = 43                                         'red
cav = -1                                         'getting lighter
FOR t = 0 TO 14                                  '15 boxes
   LINE (t, t)-(319 - t, 199 - t), clr, B        'draw border
   IF t = 7 THEN cav = -cav                      'getting darker
   clr = clr + cav                               'adjust
NEXT
clr = 106                                        'blue
cav = -1                                         'getting lighter
FOR t = 0 TO 10                                  '11 boxes
   y1 = 51 - t                                   'calc once
   y2 = 112 + t                                  'ditto
   LINE (84 - t, y1)-(115 + t, y2), clr, B       'draw border
   LINE (144 - t, y1)-(175 + t, y2), clr, B      'ditto
   LINE (204 - t, y1)-(235 + t, y2), clr, B      'ditto
   IF t = 5 THEN cav = -cav                      'getting darker
   clr = clr + cav                               'adjust
NEXT

curimg1 = 19: curimg2 = curimg1: curimg3 = curimg1    'so first call shows 0
ScrollImages 1, 1                                     'for opening screen

DO                                               'main loop
   ThisKey = GetKeyMask                          'check keyboard
   IF ThisKey AND 1 THEN                         'spacebar pressed
      score& = score& - 1                        '$1 per play
      ssc1 = RND * 20 + 5                        'get spin length
      ssc2 = RND * 20 + 5 + ssc1                 'ditto
      ssc3 = RND * 20 + 5 + ssc2                 'ditto

      DO                                         'spin loop
         ScrollImages ssc1, ssc2                 'call spin sub
         IF ssc1 THEN ssc1 = ssc1 - 1            'adjust
         IF ssc2 THEN ssc2 = ssc2 - 1            'ditto
         IF ssc3 THEN ssc3 = ssc3 - 1            'ditto
      LOOP WHILE ssc3                            'until done

      MilliDelay 5                               'pause
      scoreadd& = 0                              'assume - no matches
      IF curimg1 = curimg2 THEN                  '2 alike
         IF curimg1 = curimg3 THEN               '3 alike
            IF curimg1 THEN                      'not red crowns
               scoreadd& = 1000
            ELSE                                 'jackpot - 3 red crowns
               scoreadd& = 10000
            END IF
         ELSE                                    '2 alike
            IF curimg1 THEN                      'not red crowns
               scoreadd& = 25
            ELSE                                 'red crowns
               scoreadd& = 100
            END IF
         END IF
      ELSEIF curimg1 = curimg3 THEN              '2 alike
         IF curimg1 THEN                         'not red crowns
            scoreadd& = 25
         ELSE                                    'red crowns
            scoreadd& = 100
         END IF
      ELSEIF curimg2 = curimg3 THEN
         IF curimg2 THEN                         'not red crowns
            scoreadd& = 25
         ELSE                                    'red crowns
            scoreadd& = 100
         END IF
      END IF
      score& = score& + scoreadd&                'add it up
      LOCATE 18, 17
      PRINT USING "#########"; score&;           'print score
      IF scoreadd& THEN
         FOR z = 1 TO 5
            FOR t = 1 TO 14
               SOUND t * 100, .3                 'noise
            NEXT
            FOR t = 15 TO 1 STEP -1
               SOUND t * 100, .2                 'noise
            NEXT
         NEXT
      ELSE
         SOUND 50, 10                            'noise
      END IF
   END IF
   
LOOP UNTIL ThisKey AND 2                         'wait for escape

FUNCTION GetKeyMask

   DEF SEG = ExtKeySeg                           'point to QBEX's data
   SB = PEEK(ExtKeyOfs + 57) AND 1               'Space Bar
   Esc = PEEK(ExtKeyOfs + 1) AND 2               'Escape

   DEF SEG = &H40                      'point head to tail thus emptying
   POKE &H1A, PEEK(&H1C)               'the keyboard buffer

   GetKeyMask = SB OR Esc
      
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

SUB ScrollImages (ssc1, ssc2)

   IF ssc1 THEN                                  'move slot 1?
      img1 = curimg1                             'middle image
      curimg1 = curimg1 + 1                      'for next time
      IF curimg1 = 20 THEN curimg1 = 0           'wrap
      ciofs1 = img1 * ImgEPI                     'calc- offset
      ciy1 = 64                                  'Y position
      IF img1 THEN li1 = img1 - 1 ELSE li1 = 19  'top image
      liwofs1 = li1 * ImgEPI + 270               'offset to width data
      lihofs1 = liwofs1 + 1                      'offset to height data
      lih1 = 12                                  'start height
      IF img1 < 19 THEN ni1 = img1 + 1           'bottom image
      niwofs1 = ni1 * ImgEPI                     'offset to width data
      nihofs1 = niwofs1 + 1                      'offset to height data
      nih1 = 18                                  'start height
      niy1 = 94                                  'Y position
   END IF

   IF ssc2 THEN                                  'move slot 2?
      img2 = curimg2                             'middle image
      curimg2 = curimg2 + 1                      'for next time
      IF curimg2 = 20 THEN curimg2 = 0           'wrap
      ciofs2 = img2 * ImgEPI                     'calc- offset
      ciy2 = 64                                  'Y position
      IF img2 THEN li2 = img2 - 1 ELSE li2 = 19  'top image
      liwofs2 = li2 * ImgEPI + 270               'offset to width data
      lihofs2 = liwofs2 + 1                      'offset to height data
      lih2 = 12                                  'start height
      IF img2 < 19 THEN ni2 = img2 + 1           'bottom image
      niwofs2 = ni2 * ImgEPI                     'offset to width data
      nihofs2 = niwofs2 + 1                      'offset to height data
      nih2 = 18                                  'start height
      niy2 = 94                                  'Y position
   END IF

   img3 = curimg3                                'middle image
   curimg3 = curimg3 + 1                         'for next time
   IF curimg3 = 20 THEN curimg3 = 0              'wrap
   ciofs3 = img3 * ImgEPI                        'calc- offset
   ciy3 = 64                                     'Y position
   IF img3 THEN li3 = img3 - 1 ELSE li3 = 19     'top image
   liwofs3 = li3 * ImgEPI + 270                  'offset to width data
   lihofs3 = liwofs3 + 1                         'offset to height data
   lih3 = 12                                     'start height
   IF img3 < 19 THEN ni3 = img3 + 1              'bottom image
   niwofs3 = ni3 * ImgEPI                        'offset to width data
   nihofs3 = niwofs3 + 1                         'offset to height data
   nih3 = 18                                     'start height
   niy3 = 94                                     'Y position
   
   FOR t = 0 TO 9

      IF ssc1 THEN                               'move slot 1?
         v1 = Images(liwofs1)                    'save value
         v2 = Images(lihofs1)                    'ditto
         Images(liwofs1) = bitwidth              'set width
         Images(lihofs1) = lih1                  'set height
         IF lih1 THEN PUT (85, 52), Images(liwofs1), PSET  'display top image
         Images(liwofs1) = v1                    'restore value
         Images(lihofs1) = v2                    'ditto
         liwofs1 = liwofs1 + 45                  'adjust  (3 lines 15 ea.)
         lihofs1 = liwofs1 + 1                   'adjust
         lih1 = lih1 - 3                         'adjust
         PUT (85, ciy1), Images(ciofs1), PSET    'display middle image
         ciy1 = ciy1 - 3                         'adjust
         v1 = Images(nihofs1)                    'save value
         Images(nihofs1) = nih1                  'set height
         PUT (85, niy1), Images(niwofs1), PSET   'display bottom image
         Images(nihofs1) = v1                    'restore value
         nih1 = nih1 + 3                         'adjust
         niy1 = niy1 - 3                         'adjust
         IF t = 4 THEN                           'need to recalc images
            li1 = img1                           'middle to top
            lih1 = 27                            'next height
            liwofs1 = ciofs1 + 45                'offset to width data
            lihofs1 = liwofs1 + 1                'offset to height data
            img1 = ni1                           'bottom to middle
            ciofs1 = img1 * ImgEPI               'offset
            ciy1 = niy1                          'Y position
            IF img1 < 19 THEN ni1 = img1 + 1 ELSE ni1 = 0  'bottom image
            niwofs1 = ni1 * ImgEPI               'offset to width data
            nihofs1 = niwofs1 + 1                'offset to height data
            nih1 = 3                             'next height
            niy1 = ciy1 + 30                     'Y position
         END IF
      ELSE                                       'not moving
         MilliDelay 4                            'so delay instead
      END IF

      IF ssc2 THEN                               'move slot 2?
         v1 = Images(liwofs2)                    'save value
         v2 = Images(lihofs2)                    'ditto
         Images(liwofs2) = bitwidth              'set width
         Images(lihofs2) = lih2                  'set height
         IF lih2 THEN PUT (145, 52), Images(liwofs2), PSET 'display top image
         Images(liwofs2) = v1                    'restore value
         Images(lihofs2) = v2                    'ditto
         liwofs2 = liwofs2 + 45                  'adjust  (3 lines 15 ea.)
         lihofs2 = liwofs2 + 1                   'adjust
         lih2 = lih2 - 3                         'adjust
         PUT (145, ciy2), Images(ciofs2), PSET   'display middle image
         ciy2 = ciy2 - 3                         'adjust
         v1 = Images(nihofs2)                    'save value
         Images(nihofs2) = nih2                  'set height
         PUT (145, niy2), Images(niwofs2), PSET  'display bottom image
         Images(nihofs2) = v1                    'restore value
         nih2 = nih2 + 3                         'adjust
         niy2 = niy2 - 3                         'adjust
         IF t = 4 THEN                           'need to recalc images
            li2 = img2                           'middle to top
            lih2 = 27                            'next height
            liwofs2 = ciofs2 + 45                'offset to width data
            lihofs2 = liwofs2 + 1                'offset to height data
            img2 = ni2                           'bottom to middle
            ciofs2 = img2 * ImgEPI               'offset
            ciy2 = niy2                          'Y position
            IF img2 < 19 THEN ni2 = img2 + 1 ELSE ni2 = 0  'bottom image
            niwofs2 = ni2 * ImgEPI               'offset to width data
            nihofs2 = niwofs2 + 1                'offset to height data
            nih2 = 3                             'next height
            niy2 = ciy2 + 30                     'Y position
         END IF
      ELSE                                       'not moving
         MilliDelay 4                            'so delay instead
      END IF
      
      v1 = Images(liwofs3)                       'save value
      v2 = Images(lihofs3)                       'ditto
      Images(liwofs3) = bitwidth                 'set width
      Images(lihofs3) = lih3                     'set height
      IF lih3 THEN PUT (205, 52), Images(liwofs3), PSET    'display top image
      Images(liwofs3) = v1                       'restore value
      Images(lihofs3) = v2                       'ditto
      liwofs3 = liwofs3 + 45                     'adjust  (3 lines 15 ea.)
      lihofs3 = liwofs3 + 1                      'adjust
      lih3 = lih3 - 3                            'adjust
      PUT (205, ciy3), Images(ciofs3), PSET      'display middle image
      ciy3 = ciy3 - 3                            'adjust
      v1 = Images(nihofs3)                       'save value
      Images(nihofs3) = nih3                     'set height
      PUT (205, niy3), Images(niwofs3), PSET     'display bottom image
      Images(nihofs3) = v1                       'restore value
      nih3 = nih3 + 3                            'adjust
      niy3 = niy3 - 3                            'adjust
      IF t = 4 THEN                              'need to recalc images
         li3 = img3                              'middle to top
         lih3 = 27                               'next height
         liwofs3 = ciofs3 + 45                   'offset to width data
         lihofs3 = liwofs3 + 1                   'offset to height data
         img3 = ni3                              'bottom to middle
         ciofs3 = img3 * ImgEPI                  'offset
         ciy3 = niy3                             'Y position
         IF img3 < 19 THEN ni3 = img3 + 1 ELSE ni3 = 0  'bottom image
         niwofs3 = ni3 * ImgEPI                  'offset to width data
         nihofs3 = niwofs3 + 1                   'offset to height data
         nih3 = 3                                'next height
         niy3 = ciy3 + 30                        'Y position
      END IF

      SOUND 150, .1                              'noise

   NEXT

END SUB

SUB SetColors (pal() AS Hues, fc, lc)
   OUT &H3C8, fc                                 'initialize controller
   FOR t = fc TO lc                              'from first to last
      OUT &H3C9, pal(t).red                      'send red component
      OUT &H3C9, pal(t).green                    'send green component
      OUT &H3C9, pal(t).blue                     'send blue component
   NEXT
END SUB
