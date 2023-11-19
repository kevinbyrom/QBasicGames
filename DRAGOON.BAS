DECLARE SUB colors (team$, tm%)
DECLARE SUB slant (sx!, sy!, img%, imageheight%, imagewidth%, addv!, addv2!, sxadd!, syadd!, clr%)
DECLARE SUB slscale (sx!, sy!, img%, imageheight%, imagewidth%, addv!, addv2!, adv!, adv2!, clr%)
DECLARE SUB scale (sx!, sy!, img%, imageheight%, imagewidth%, addv!, addv2!, clr%)
DECLARE SUB title ()
DECLARE SUB lsprite (file$)
' ** DRAGOON.BAS
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
COMMON SHARED ExtKeyOfs, ExtKeySeg, pal() AS Hues
COMMON SHARED lbx, lbx2, lbx3, lbd1, lbd2, lbd3, filename$, FileSize&
'-------------------------------------------------------------------



 COMMON SHARED dirimg, qbx, boysprite(), boyepi, CurBoy  'define all the commons

RANDOMIZE TIMER
IF NOT QBEX(0) THEN                              'verify presence of TSR
   PRINT "QBasic Extender TSR not found"
   END
END IF




REDIM starsbrx(1 TO 20)
REDIM starsbry(1 TO 20)
REDIM starsx(1 TO 20)
REDIM starsy(1 TO 20)
REDIM starsltx(1 TO 20)
REDIM starslty(1 TO 20)
REDIM starsclx!(1 TO 5)
REDIM starscly!(1 TO 5)
REDIM statsclr(1 TO 5)
FOR i = 1 TO 5
    starsclx!(i) = INT(319 * RND) + 1
    starscly!(i) = INT(199 * RND) + 1
    starsclr(i) = INT(6 * RND) + 1
NEXT

FOR i = 1 TO 20
    starsbrx(i) = INT(319 * RND) + 1
    starsx(i) = INT(319 * RND) + 1
    starsltx(i) = INT(319 * RND) + 1
    starsbry(i) = INT(199 * RND) + 1
    starsy(i) = INT(199 * RND) + 1
    starslty(i) = INT(199 * RND) + 1
NEXT


DO
SCREEN 7, 0, 0, 1
CLS
FOR i = 1 TO 5
   PSET (starsclx!(i), starscly!(i)), 1
NEXT
FOR i = 1 TO 20
    PSET (starsbrx(i), starsbry(i)), 15
    PSET (starsx(i), starsy(i)), 7
    PSET (starsltx(i), starslty(i)), 8
NEXT
PCOPY 0, 1
DO
thiskey = GetKeyMask
LOOP UNTIL thiskey
IF thiskey AND 4 THEN
   FOR i = 1 TO 5
   starsclx!(i) = starsclx!(i) - .1
    IF starsclx!(i) < 0 THEN starsclx!(i) = 320 + starsclx!(i)
   NEXT
  
   FOR i = 1 TO 20
       starsbrx(i) = starsbrx(i) - 4
       starsx(i) = starsx(i) - 2
       starsltx(i) = starsltx(i) - 1
     
       IF starsbrx(i) < 0 THEN starsbrx(i) = 320 + starsbrx(i)
       IF starsx(i) < 0 THEN starsx(i) = 320 + starsx(i)
       IF starsltx(i) < 0 THEN starsltx(i) = 320 + starsltx(i)
    
      
   NEXT
END IF
IF thiskey AND 8 THEN
   FOR i = 1 TO 5
    starscly!(i) = starscly!(i) - .1
     IF starscly!(i) < 0 THEN starscly!(i) = 200 + starscly!(i)
   NEXT
  
   FOR i = 1 TO 20
       starsbry(i) = starsbry(i) - 4
       starsy(i) = starsy(i) - 2
       starslty(i) = starslty(i) - 1
     
       IF starsbry(i) < 0 THEN starsbry(i) = 200 + starsbry(i)
       IF starsy(i) < 0 THEN starsy(i) = 200 + starsy(i)
       IF starslty(i) < 0 THEN starslty(i) = 200 + starslty(i)
   NEXT
END IF
IF thiskey AND 1 THEN
   FOR i = 1 TO 5
      starsclx!(i) = starsclx!(i) + .1
     IF starsclx!(i) > 319 THEN starsclx!(i) = starsclx!(i) - 320
   NEXT

   FOR i = 1 TO 20
       starsbrx(i) = starsbrx(i) + 4
       starsx(i) = starsx(i) + 2
       starsltx(i) = starsltx(i) + 1
       IF starsbrx(i) > 319 THEN starsbrx(i) = starsbrx(i) - 320
       IF starsx(i) > 319 THEN starsx(i) = starsx(i) - 320
       IF starsltx(i) > 319 THEN starsltx(i) = starsltx(i) - 320
     
     
  
   NEXT
END IF
IF thiskey AND 2 THEN
   FOR i = 1 TO 5
    starscly!(i) = starscly!(i) + .1
    IF starscly!(i) > 199 THEN starscly!(i) = starscly!(i) - 200
   NEXT
   FOR i = 1 TO 20
       starsbry(i) = starsbry(i) + 4
       starsy(i) = starsy(i) + 2
       starslty(i) = starslty(i) + 1
      
     
       IF starsbry(i) > 199 THEN starsbry(i) = starsbry(i) - 200
       IF starsy(i) > 199 THEN starsy(i) = starsy(i) - 200
       IF starslty(i) > 199 THEN starslty(i) = starslty(i) - 200
      
                
  
   NEXT
END IF
LOOP













SCREEN 13                                        '320 x 200 w/256 colors
millidelay 0                                     'initialize
'title
colors "CL", 0


lsprite "fb01"
qbx = 100
dirimg = 2
LINE (1, 0)-(3, 200), 15, BF
LINE (315, 0)-(317, 200), 15, BF

lbx = INT(119 * RND) + 25
lbx2 = INT(69 * RND) + 25
lbx3 = INT(119 * RND) + 25

lbd1 = INT(2 * RND)
lbd2 = INT(2 * RND)
lbd3 = INT(2 * RND)

DO

DO

 PUT (qbx, 170), boysprite(dirimg * boyepi), PSET
 PUT (lbx, 20), boysprite((lbd1 + img1) * boyepi), PSET
 PUT (lbx + 50, 20), boysprite((lbd1 + img1) * boyepi), PSET
 PUT (lbx + 100, 20), boysprite((lbd1 + img1) * boyepi), PSET

 PUT (lbx2, 75), boysprite((lbd2 + img2) * boyepi), PSET
 PUT (lbx2 + 50, 75), boysprite((lbd2 + img2) * boyepi), PSET
 PUT (lbx2 + 100, 75), boysprite((lbd2 + img2) * boyepi), PSET
 PUT (lbx2 + 150, 75), boysprite((lbd2 + img2) * boyepi), PSET

 PUT (lbx3, 130), boysprite((lbd3 + img1) * boyepi), PSET
 PUT (lbx3 + 50, 130), boysprite((lbd3 + img1) * boyepi), PSET
 PUT (lbx3 + 100, 130), boysprite((lbd3 + img1) * boyepi), PSET

 SWAP img1, img2
 thiskey = GetKeyMask

 IF lbd1 = 0 THEN
     lbx = lbx - 2
 ELSEIF lbd1 = 1 THEN
     lbx = lbx + 2
 END IF
 IF lbd2 = 0 THEN
     lbx2 = lbx2 - 2
 ELSEIF lbd2 = 1 THEN
     lbx2 = lbx2 + 2
 END IF
 IF lbd3 = 0 THEN
     lbx3 = lbx3 - 2
 ELSEIF lbd3 = 1 THEN
     lbx3 = lbx3 + 2
 END IF

 IF lbx <= 5 THEN lbd1 = 1
 IF lbx >= 194 THEN lbd1 = 0
 IF lbx2 <= 5 THEN lbd2 = 1
 IF lbx2 >= 144 THEN lbd2 = 0
 IF lbx3 <= 5 THEN lbd3 = 1
 IF lbx3 >= 194 THEN lbd3 = 0




LOOP UNTIL thiskey







IF thiskey AND 1 THEN
   IF dirimg = 2 THEN
      dirimg = 3
   ELSEIF dirimg = 3 THEN
      IF qbx > 4 THEN
         img = 9
         FOR i = 1 TO 2
         qbx = qbx - 1
         PUT (qbx, 170), boysprite(img * boyepi), PSET
         
         img = img + 2
         NEXT
      END IF
  END IF
END IF
IF thiskey AND 4 THEN
   IF dirimg = 3 THEN
      dirimg = 2
   ELSEIF dirimg = 2 THEN
      IF qbx < 294 THEN
         img = 8
         FOR i = 1 TO 2
         qbx = qbx + 1
         PUT (qbx, 170), boysprite(img * boyepi), PSET
         
         img = img + 2
         NEXT
      END IF
  END IF
END IF
LOOP

SUB CalcPower (wpn$)

SELECT CASE wpn$
  
 CASE "Knife"
      addpower = 5
 CASE "Short Sword"
      addpower = 10
 CASE "Long Sword"
      addpower = 15
 CASE "Rapier"
      addpower = 20
 CASE "Edge Blade"
      addpower = 25
 CASE "Fast Blade"
      addpower = 35
 CASE "Slasher"
      addpower = 45
 CASE "Iron Sword"
      addpower = 60
 CASE "Rune Edge"
      addpower = 75
      bonus = 10
      effect$ = "ALL"
 CASE "Opal Sword"
      addpower = 90
 CASE "Ice Blade"
      addpower = 100
      bonus = 20
      effect$ = "FIRE"
 CASE "Fire Blade"
      addpower = 100
      bonus = 20
      effect$ = "ICE"
 CASE "Hard Blade"
      addpower = 120
      bonus = -10
      effect$ = "Fire"
 CASE "Gold Sword"
      addpower = 150
 CASE "Randomizer"
      addpower = 1
      bonus = INT(150 * RND) + 1
      effect$ = "ALL"
 CASE "Doubler"
      addpower = power * 2
 CASE "Dark Sword"
      addpower = 200
 CASE "Light Sword"
      addpower = 250
      bonus = 50
      effect$ = "ALL"
 CASE "Mystery Blade"
      addpower = 1
      bonus = INT(300 * RND) + 1
      effect$ = "ALL"
 CASE "Strong Sword"
      addpower = 400
 CASE "Revenger"
      addpower = hp
 CASE "Power Blade"
      addpower = 600
 CASE "Crystal Blade"
      addpower = 800
 CASE "Mega Sword"
      addpower = 1100
 CASE "Maximus"
      addpower = 1400
 CASE "Dragon Tear"
      addpower = 1700
 CASE "Sun Torch"
      addpower = 2100
      bonus = 300
      effect$ = "ICE"
 CASE "Punisher"
      addpower = 2500
 CASE "Exacter 1000"
      addpower = -power
      bonus = 1000
      effect$ = "ALL"
 CASE "Blood Blade"
      addpower = 3000
 CASE "Dragon Sword"
      addpower = 7000
 CASE "Ultima"
      addpower = 10000
      bonus = 5000
      effect$ = "ALL"
 END SELECT


END SUB

SUB colors (team$, tm)


IF tm = 0 THEN cadd = 0
IF tm = 1 THEN cadd = 4

REDIM pal(255) AS Hues                           'array for palette
DEF SEG = VARSEG(pal(0))                         'point to it
BLOAD "mix.PAL", 0                           'load from file

IF team$ = "SF" THEN
   pal(1 + cadd).red = 30
   pal(1 + cadd).green = 0
   pal(1 + cadd).blue = 0
  
   pal(2 + cadd).red = 45
   pal(2 + cadd).green = 0
   pal(2 + cadd).blue = 0

   pal(3 + cadd).red = 55
   pal(3 + cadd).green = 0
   pal(3 + cadd).blue = 0

   pal(4 + cadd).red = 55
   pal(4 + cadd).green = 35
   pal(4 + cadd).blue = 0

ELSEIF team$ = "DA" THEN
   pal(1 + cadd).red = 0
   pal(1 + cadd).green = 0
   pal(1 + cadd).blue = 30
 
   pal(2 + cadd).red = 0
   pal(2 + cadd).green = 0
   pal(2 + cadd).blue = 45

   pal(3 + cadd).red = 0
   pal(3 + cadd).green = 0
   pal(3 + cadd).blue = 55

   pal(4 + cadd).red = 45
   pal(4 + cadd).green = 45
   pal(4 + cadd).blue = 50
ELSEIF team$ = "CH" THEN
   pal(1 + cadd).red = 0
   pal(1 + cadd).green = 0
   pal(1 + cadd).blue = 10

   pal(2 + cadd).red = 0
   pal(2 + cadd).green = 0
   pal(2 + cadd).blue = 15

   pal(3 + cadd).red = 0
   pal(3 + cadd).green = 0
   pal(3 + cadd).blue = 20

   pal(4 + cadd).red = 15
   pal(4 + cadd).green = 5
   pal(4 + cadd).blue = 0

ELSEIF team$ = "SA" THEN
   pal(1 + cadd).red = 0
   pal(1 + cadd).green = 0
   pal(1 + cadd).blue = 0

   pal(2 + cadd).red = 0
   pal(2 + cadd).green = 0
   pal(2 + cadd).blue = 5

   pal(3 + cadd).red = 0
   pal(3 + cadd).green = 0
   pal(3 + cadd).blue = 10

   pal(4 + cadd).red = 45
   pal(4 + cadd).green = 35
   pal(4 + cadd).blue = 0
ELSEIF team$ = "RA" THEN
   pal(1 + cadd).red = 0
   pal(1 + cadd).green = 0
   pal(1 + cadd).blue = 0

   pal(2 + cadd).red = 5
   pal(2 + cadd).green = 5
   pal(2 + cadd).blue = 5

   pal(3 + cadd).red = 10
   pal(3 + cadd).green = 10
   pal(3 + cadd).blue = 10

   pal(4 + cadd).red = 50
   pal(4 + cadd).green = 50
   pal(4 + cadd).blue = 50
ELSEIF team$ = "CO" THEN
   pal(1 + cadd).red = 40
   pal(1 + cadd).green = 40
   pal(1 + cadd).blue = 40

   pal(2 + cadd).red = 50
   pal(2 + cadd).green = 50
   pal(2 + cadd).blue = 50

   pal(3 + cadd).red = 60
   pal(3 + cadd).green = 60
   pal(3 + cadd).blue = 60

   pal(4 + cadd).red = 0
   pal(4 + cadd).green = 0
   pal(4 + cadd).blue = 60
ELSEIF team$ = "MI" THEN
   pal(1 + cadd).red = 40
   pal(1 + cadd).green = 40
   pal(1 + cadd).blue = 40

   pal(2 + cadd).red = 50
   pal(2 + cadd).green = 50
   pal(2 + cadd).blue = 50

   pal(3 + cadd).red = 60
   pal(3 + cadd).green = 60
   pal(3 + cadd).blue = 60

   pal(4 + cadd).red = 30
   pal(4 + cadd).green = 60
   pal(4 + cadd).blue = 55
ELSEIF team$ = "PI" THEN
   pal(1 + cadd).red = 20
   pal(1 + cadd).green = 20
   pal(1 + cadd).blue = 0

   pal(2 + cadd).red = 30
   pal(2 + cadd).green = 30
   pal(2 + cadd).blue = 5

   pal(3 + cadd).red = 40
   pal(3 + cadd).green = 40
   pal(3 + cadd).blue = 10

   pal(4 + cadd).red = 0
   pal(4 + cadd).green = 0
   pal(4 + cadd).blue = 0
ELSEIF team$ = "BU" THEN
   pal(1 + cadd).red = 0
   pal(1 + cadd).green = 0
   pal(1 + cadd).blue = 50

   pal(2 + cadd).red = 0
   pal(2 + cadd).green = 0
   pal(2 + cadd).blue = 55

   pal(3 + cadd).red = 0
   pal(3 + cadd).green = 0
   pal(3 + cadd).blue = 60

   pal(4 + cadd).red = 60
   pal(4 + cadd).green = 0
   pal(4 + cadd).blue = 0
ELSEIF team$ = "NY" THEN
   pal(1 + cadd).red = 0
   pal(1 + cadd).green = 0
   pal(1 + cadd).blue = 50

   pal(2 + cadd).red = 0
   pal(2 + cadd).green = 0
   pal(2 + cadd).blue = 55

   pal(3 + cadd).red = 0
   pal(3 + cadd).green = 0
   pal(3 + cadd).blue = 60

   pal(4 + cadd).red = 0
   pal(4 + cadd).green = 0
   pal(4 + cadd).blue = 30
ELSEIF team$ = "CL" THEN
   pal(1 + cadd).red = 50
   pal(1 + cadd).green = 50
   pal(1 + cadd).blue = 50

   pal(2 + cadd).red = 55
   pal(2 + cadd).green = 55
   pal(2 + cadd).blue = 55

   pal(3 + cadd).red = 60
   pal(3 + cadd).green = 60
   pal(3 + cadd).blue = 60

   pal(4 + cadd).red = 60
   pal(4 + cadd).green = 40
   pal(4 + cadd).blue = 0
END IF




pal(0).red = 0                                  'set background
pal(0).green = 45                                'to a dark shade
pal(0).blue = 0                                 'of blue gray
SetColors pal(), 0, 255                          'set system colors

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
   b = PEEK(ExtKeyOfs + 48) AND 128              'the B key

   DEF SEG = &H40                      'point head to tail thus emptying
   POKE &H1A, PEEK(&H1C)               'the keyboard buffer

   GetKeyMask = l OR U OR r OR d OR Ent OR SB OR Esc OR b
      
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

SUB scale (sx!, sy!, img, imageheight, imagewidth, addv!, addv2!, clr)
   
   x! = sx!
   y! = sy!
   DEF SEG = VARSEG(boysprite(0))            'point to image
   ofs = img * boyepi + 4          'skip image size data

   FOR ih = 1 TO imageheight                     'top to bottom
      FOR iw = 1 TO imagewidth                   'left to right
         dat = PEEK(ofs)                         'get color
         IF clr = 1 THEN IF dat = 0 THEN GOTO nodraw
         LINE (x!, y!)-(x! + addv!, y! + addv2!), dat, BF  'draw a box
nodraw:
         x! = (x! + addv!)                        'adjust
         ofs = ofs + 1                           'ditto
      NEXT
      x! = sx!                               'reset
      y! = (y! + addv2!)                           'adjust
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

SUB slant (sx!, sy!, img, imageheight, imagewidth, addv!, addv2!, sxadd!, syadd!, clr)
   syadd2! = syadd!
   x! = sx!
   y! = sy!
   DEF SEG = VARSEG(boysprite(0))            'point to image
   ofs = img * boyepi + 4          'skip image size data

   FOR ih = 1 TO imageheight                     'top to bottom
      FOR iw = 1 TO imagewidth                   'left to right
   
         dat = PEEK(ofs)                         'get color
         IF clr = 1 AND dat = 0 THEN GOTO nodrw
         LINE (x!, y! + syadd2!)-(x! + addv!, y! + addv2! + syadd2!), dat, BF   'draw a box
nodrw:                                                                                                                                                                                                                                                                                                                                                                                           
         syadd2! = syadd2! + syadd!
        
         x! = (x! + addv!) + sxadd!                    'adjust
         ofs = ofs + 1                           'ditto
      NEXT
      sx! = sx! + sxadd!
      x! = sx!                                                'reset
      y! = (y! + addv!) - syadd!                   'adjust
      syadd2! = syadd!
                                
                       
   NEXT
   
END SUB

SUB slscale (sx!, sy!, img, imageheight, imagewidth, addv!, addv2!, adv!, adv2!, clr)
   img = img * 2
   x! = sx! - ((addv! * imageheight) / 2)
  
   y! = sy!
   DEF SEG = VARSEG(boysprite(0))            'point to image
   ofs = img * boyepi + 4                               'skip image size data

   FOR ih = 1 TO imageheight                     'top to bottom
      FOR iw = 1 TO imagewidth                   'left to right
         dat = PEEK(ofs)                         'get color
         IF clr = 1 THEN IF dat = 0 THEN GOTO ndraw
         LINE (x!, y!)-(x! + addv!, y! + addv2!), dat, BF  'draw a box
ndraw:
          x! = (x! + addv!)                        'adjust
         ofs = ofs + 1                           'ditto
      NEXT
      addv! = addv! + adv!
      x! = sx! - ((addv! * imageheight) / 2)
      y! = (y! + addv2!)                           'adjust
      addv2! = addv2! + adv2!
   
 
   NEXT


END SUB

SUB title
lsprite "drltr"
CLS

FOR i! = 125 TO 185 STEP 10
    scale i!, 95, ig, 10, 10, 1, 1, 0
    ig = ig + 2
NEXT
END SUB

