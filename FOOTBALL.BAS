DECLARE SUB SpeedDelay ()
DECLARE SUB DelaySetting ()
DECLARE SUB emailme ()
'Email to KB 49ers
'run this game on a 386 or higher
'use arrow keys to move
'throw the ball with enter key
'try not to wait too long or you might be sacked
'the extension to make this game is copyright of QUE
'ps. Try to beat my score on practice mode...God knows it took me forever to get it





DECLARE SUB GAME ()
DECLARE SUB PRACTICE ()
DECLARE SUB showteam ()
DECLARE SUB showteams ()
DECLARE SUB COLORs (tm$, tm2$)
DECLARE SUB slant (sx!, sy!, img%, imageheight%, imagewidth%, addv!, addv2!, sxadd!, syadd!, clr%)
DECLARE SUB slscale (sx!, sy!, img%, imageheight%, imagewidth%, addv!, addv2!, adv!, adv2!, clr%)
DECLARE SUB scale (sx!, sy!, img%, imageheight%, imagewidth%, addv!, addv2!, clr%)
DECLARE SUB title ()
DECLARE SUB lsprite (file$)
DEFINT A-Z                                       'default type = integer

TYPE Hues                                        'define type for hues
    red AS INTEGER                               'red component
  green AS INTEGER                               'green component
   blue AS INTEGER                               'blue component
END TYPE
DECLARE FUNCTION QBEX (ExtNum)                   'TSR interface
DECLARE SUB millidelay (msecs)                   'SUB to create delays
DECLARE SUB setcolors (pal() AS Hues, fc, lc)    'SUB to modify palette
DECLARE FUNCTION GetKeyMask ()                   'FUNCTION to handle keyboard
'---------- define the variables used by the Extender TSR ----------
COMMON SHARED ExtKeyOfs, ExtKeySeg, pal() AS Hues
COMMON SHARED tmscore(), lbx, lbx2, lbx3, lbd1, lbd2, lbd3, filename$, FileSize&

'-------------------------------------------------------------------



COMMON SHARED ptm$(), dirimg, qbx, boysprite(), boyepi, CurBoy 'define all the commons
COMMON SHARED qx, xadd, delay, tmscore(), yard, down, yrds, half, bteam, fteam, qtr, throws, maxt, deion



RANDOMIZE TIMER
IF NOT QBEX(0) THEN                              'verify presence of TSR
   PRINT "QBasic Extender TSR not found"
   END
END IF

SCREEN 13                                        '320 x 200 w/256 colors
millidelay 0                                     'initialize
DelaySetting
title
emailme






DO
CLS
'lsprite "fbGOAL"
'COLORs "SF", "RM"
'LINE (0, 0)-(320, 200), 116, BF
'LINE (0, 150)-(320, 200), 92, BF
'LINE (60, 125)-(259, 149), 234, BF
'LINE (0, 125)-(59, 149), 230, BF
'LINE (260, 125)-(320, 149), 230, BF

'zoom! = 1
'slscale 160, 150, 1, 30, 30, .2, .2, 1, .1, 0
'scale 160 - INT((30 * zoom!) / 2), 150 - (30 * zoom!), 4, 30, 30, zoom!, zoom!, 1
'DO
'LOOP


REDIM tmscore(1 TO 2)
tmscore(1) = 0
tmscore(2) = 0

REDIM ptm$(1 TO 2)

REDIM stm$(1 TO 28)
stm$(1) = "GB"
stm$(2) = "DA"
stm$(3) = "EA"
stm$(4) = "CH"
stm$(5) = "NY"
stm$(6) = "AT"
stm$(7) = "SF"
stm$(8) = "MI"
stm$(9) = "RM"
stm$(10) = "JT"
stm$(11) = "PI"
stm$(12) = "KC"
stm$(13) = "RA"
stm$(14) = "BR"
stm$(15) = "WA"
stm$(16) = "PX"
stm$(17) = "DE"

COLORs "SF", "EA"
tm1 = 7
tm2 = 2
gmode$ = "MONDAY NIGHT"
sel = 0

DO
 LINE (1, 79)-(11, 120), 0, BF
 LINE (102, 70)-(320, 200), 0, BF
 lsprite "helm" + stm$(tm1)
 PUT (1, 1), boysprite(0 * boyepi), PSET

 lsprite "helm" + stm$(tm2)
 PUT (258, 1), boysprite(0 * boyepi), PSET

 LINE (0, 0)-(61, 61), 255, B
 LINE (257, 0)-(319, 61), 255, B
 LOCATE 11, 3
 COLOR 15
 PRINT "GAME MODE--"; gmode$
 LOCATE 13, 3
 PRINT "TEAM 1"
 LOCATE 15, 3
 PRINT "TEAM 2"
 IF sel = 0 THEN LINE (1, 79)-(11, 87), 15, BF
 IF sel = 1 THEN LINE (1, 95)-(11, 103), 15, BF
 IF sel = 2 THEN LINE (1, 111)-(11, 119), 15, BF

 DO
  thiskey = GetKeyMask
 LOOP UNTIL thiskey
 millidelay 110
 IF thiskey AND 1 THEN
    IF sel = 0 THEN
        IF gmode$ = "MONDAY NIGHT" THEN
        gmode$ = "PRACTICE DRILL"
        ELSEIF gmode$ = "PRACTICE DRILL" THEN
        gmode$ = "MONDAY NIGHT"
        END IF
    ELSEIF sel = 1 THEN
        tm1 = tm1 - 1
        IF tm1 = tm2 THEN tm1 = tm1 - 1
    ELSEIF sel = 2 THEN
        tm2 = tm2 - 1
        IF tm2 = tm1 THEN tm2 = tm2 - 1
    END IF
   IF tm1 < 1 THEN tm1 = 17
   IF tm2 < 1 THEN tm2 = 17
   ELSEIF thiskey AND 4 THEN
    IF sel = 0 THEN
        IF gmode$ = "MONDAY NIGHT" THEN
        gmode$ = "PRACTICE DRILL"
        ELSEIF gmode$ = "PRACTICE DRILL" THEN
        gmode$ = "MONDAY NIGHT"
        END IF
    ELSEIF sel = 1 THEN
        tm1 = tm1 + 1
        IF tm1 = tm2 THEN tm1 = tm1 + 1
    ELSEIF sel = 2 THEN
        tm2 = tm2 + 1
        IF tm2 = tm1 THEN tm2 = tm2 + 1
    END IF
   IF tm1 > 17 THEN tm1 = 1
   IF tm2 > 17 THEN tm2 = 1
  
ELSEIF thiskey AND 2 THEN
    sel = sel - 1
    IF sel < 0 THEN sel = 2
ELSEIF thiskey AND 8 THEN
    sel = sel + 1
    IF sel > 2 THEN sel = 0
    END IF

LOOP UNTIL thiskey AND 16
ptm$(1) = stm$(tm1)
ptm$(2) = stm$(tm2)

IF gmode$ = "PRACTICE DRILL" THEN PRACTICE
IF gmode$ = "MONDAY NIGHT" THEN GAME

LOOP

SUB COLORs (tm$, tm2$)
REDIM team$(1 TO 2)
team$(1) = tm$
team$(2) = tm2$


REDIM pal(255) AS Hues                           'array for palette
DEF SEG = VARSEG(pal(0))                         'point to it
BLOAD "MIX.PAL", 0                           'load from file
FOR i = 1 TO 2
IF i = 1 THEN cadd = 0
IF i = 2 THEN cadd = 4

IF team$(i) = "SF" THEN
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

ELSEIF team$(i) = "DA" THEN
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
ELSEIF team$(i) = "CH" THEN
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

ELSEIF team$(i) = "SA" THEN
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
ELSEIF team$(i) = "RA" THEN
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
ELSEIF team$(i) = "CO" THEN
   pal(1 + cadd).red = 0
   pal(1 + cadd).green = 0
   pal(1 + cadd).blue = 40

   pal(2 + cadd).red = 0
   pal(2 + cadd).green = 0
   pal(2 + cadd).blue = 50

   pal(3 + cadd).red = 0
   pal(3 + cadd).green = 0
   pal(3 + cadd).blue = 60

   pal(4 + cadd).red = 60
   pal(4 + cadd).green = 60
   pal(4 + cadd).blue = 60
ELSEIF team$(i) = "MI" THEN
   pal(1 + cadd).red = 15
   pal(1 + cadd).green = 50
   pal(1 + cadd).blue = 35

   pal(2 + cadd).red = 20
   pal(2 + cadd).green = 50
   pal(2 + cadd).blue = 35

   pal(3 + cadd).red = 25
   pal(3 + cadd).green = 50
   pal(3 + cadd).blue = 35

   pal(4 + cadd).red = 55
   pal(4 + cadd).green = 60
   pal(4 + cadd).blue = 55
ELSEIF team$(i) = "PI" THEN
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
ELSEIF team$(i) = "BU" THEN
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
ELSEIF team$(i) = "NY" THEN
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
ELSEIF team$(i) = "BR" THEN
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
ELSEIF team$(i) = "GB" THEN
   pal(1 + cadd).red = 0
   pal(1 + cadd).green = 20
   pal(1 + cadd).blue = 0

   pal(2 + cadd).red = 0
   pal(2 + cadd).green = 30
   pal(2 + cadd).blue = 0

   pal(3 + cadd).red = 0
   pal(3 + cadd).green = 40
   pal(3 + cadd).blue = 0

   pal(4 + cadd).red = 60
   pal(4 + cadd).green = 60
   pal(4 + cadd).blue = 0
ELSEIF team$(i) = "EA" THEN
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
   pal(4 + cadd).green = 40
   pal(4 + cadd).blue = 0
ELSEIF team$(i) = "JT" THEN
   pal(1 + cadd).red = 0
   pal(1 + cadd).green = 20
   pal(1 + cadd).blue = 0

   pal(2 + cadd).red = 0
   pal(2 + cadd).green = 30
   pal(2 + cadd).blue = 0

   pal(3 + cadd).red = 0
   pal(3 + cadd).green = 40
   pal(3 + cadd).blue = 0

   pal(4 + cadd).red = 0
   pal(4 + cadd).green = 40
   pal(4 + cadd).blue = 0
ELSEIF team$(i) = "AT" THEN
   pal(1 + cadd).red = 0
   pal(1 + cadd).green = 0
   pal(1 + cadd).blue = 0

   pal(2 + cadd).red = 5
   pal(2 + cadd).green = 5
   pal(2 + cadd).blue = 5

   pal(3 + cadd).red = 10
   pal(3 + cadd).green = 10
   pal(3 + cadd).blue = 10

   pal(4 + cadd).red = 0
   pal(4 + cadd).green = 0
   pal(4 + cadd).blue = 0
ELSEIF team$(i) = "MN" THEN
   pal(1 + cadd).red = 40
   pal(1 + cadd).green = 40
   pal(1 + cadd).blue = 40

   pal(2 + cadd).red = 50
   pal(2 + cadd).green = 50
   pal(2 + cadd).blue = 50

   pal(3 + cadd).red = 60
   pal(3 + cadd).green = 60
   pal(3 + cadd).blue = 60

   pal(4 + cadd).red = 10
   pal(4 + cadd).green = 0
   pal(4 + cadd).blue = 30
ELSEIF team$(i) = "KC" THEN
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
   pal(4 + cadd).green = 0
   pal(4 + cadd).blue = 0
ELSEIF team$(i) = "RM" THEN
   pal(1 + cadd).red = 50
   pal(1 + cadd).green = 40
   pal(1 + cadd).blue = 0

   pal(2 + cadd).red = 55
   pal(2 + cadd).green = 45
   pal(2 + cadd).blue = 0

   pal(3 + cadd).red = 60
   pal(3 + cadd).green = 50
   pal(3 + cadd).blue = 0

   pal(4 + cadd).red = 0
   pal(4 + cadd).green = 0
   pal(4 + cadd).blue = 30
ELSEIF team$(i) = "WA" THEN
   pal(1 + cadd).red = 50
   pal(1 + cadd).green = 50
   pal(1 + cadd).blue = 0

   pal(2 + cadd).red = 55
   pal(2 + cadd).green = 55
   pal(2 + cadd).blue = 0

   pal(3 + cadd).red = 60
   pal(3 + cadd).green = 60
   pal(3 + cadd).blue = 0

   pal(4 + cadd).red = 50
   pal(4 + cadd).green = 10
   pal(4 + cadd).blue = 0
ELSEIF team$(i) = "PX" THEN
   pal(1 + cadd).red = 30
   pal(1 + cadd).green = 0
   pal(1 + cadd).blue = 0

   pal(2 + cadd).red = 35
   pal(2 + cadd).green = 0
   pal(2 + cadd).blue = 0

   pal(3 + cadd).red = 40
   pal(3 + cadd).green = 0
   pal(3 + cadd).blue = 0

   pal(4 + cadd).red = 60
   pal(4 + cadd).green = 60
   pal(4 + cadd).blue = 60
ELSEIF team$(i) = "DE" THEN
   pal(1 + cadd).red = 0
   pal(1 + cadd).green = 0
   pal(1 + cadd).blue = 25

   pal(2 + cadd).red = 0
   pal(2 + cadd).green = 0
   pal(2 + cadd).blue = 35

   pal(3 + cadd).red = 0
   pal(3 + cadd).green = 0
   pal(3 + cadd).blue = 45

   pal(4 + cadd).red = 30
   pal(4 + cadd).green = 30
   pal(4 + cadd).blue = 35
END IF



NEXT
pal(0).red = 0                                  'set background
pal(0).green = 45                                'to a dark shade
pal(0).blue = 0                                 'of blue gray
setcolors pal(), 0, 255                          'set system colors

END SUB

SUB DelaySetting
delay = 100
CLS
qx = 0
xadd = 2
LOCATE 14
COLOR 2
PRINT "Set Speed of Game"
PRINT "By using left/right arrows"
PRINT
PRINT "Note: Box represents speed of receivers"
PRINT
COLOR 3
PRINT "Press Enter Key when Finished"
DO
thiskey = GetKeyMask
IF thiskey AND 1 THEN delay = delay - 10
IF delay < 0 THEN delay = 0
IF thiskey AND 4 THEN delay = delay + 10

LINE (qx, 0)-(qx + 20, 20), 1, BF
SpeedDelay
LINE (qx, 0)-(qx + 20, 20), 0, BF

qx = qx + xadd
IF qx = 0 THEN xadd = 2
IF qx = 298 THEN xadd = -2

LOOP UNTIL thiskey AND 16

CLS

END SUB

SUB emailme

CLS
COLOR 15
PRINT "Hey, what's up?"
PRINT "This is KB 49ers speaking."
PRINT "Email me to:"
PRINT " -Request an updated version"
PRINT "  of this game"
PRINT "  (all teams, more secrets)"
PRINT " -Request other games that I have made"
PRINT " -Comment on this game"
PRINT
PRINT "Hope you like the game."
anykey$ = INPUT$(2)

END SUB

SUB GAME

showteams
DO
  CLS
  LOCATE 1
  COLOR 15
  tms = bteam + 1
  lsprite "helm" + ptm$(tms)
  PUT (0, 0), boysprite(0 * boyepi), PSET
  LOCATE 6, 10
  PRINT "---"; tmscore(tms)
  tms2 = bteam + 2
  IF tms2 = 3 THEN tms2 = 1
  lsprite "helm" + ptm$(tms2)
  PUT (0, 60), boysprite(0 * boyepi), PSET
  LOCATE 14, 10
  PRINT "---"; tmscore(tms2)
  lsprite "fb01"
  LOCATE 16
  PRINT down; " AND "; yrds; " TO GO"
  PRINT
  PRINT "ON "; yard; " YARD LINE"
  PRINT
  IF qtr < 5 THEN PRINT "QUARTER--"; qtr
  IF qtr > 4 THEN PRINT "QUARTER-- OVERTIME"
  IF (maxt - throws) / 2 = INT((maxt - throws) / 2) THEN
  PRINT INT((maxt - throws) / 2); ": 00"
  ELSEIF (maxt - throws) / 2 <> INT((maxt - throws) / 2) THEN
  PRINT INT((maxt - throws) / 2); ": 30"
  END IF
  IF bteam = 0 THEN
   COLORs ptm$(1), ptm$(2)
  ELSEIF bteam = 1 THEN
   COLORs ptm$(2), ptm$(1)
  END IF
  anykey$ = INPUT$(1)
  CLS

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
  img1 = 21
  img2 = 19
  r1 = INT(290 * RND) + 6
  r2 = INT(290 * RND) + 6
  r3 = INT(290 * RND) + 6
  rd1 = INT(2 * RND)
  rd2 = INT(2 * RND)
  rd3 = INT(2 * RND)

  imgr1 = 4
  imgr2 = 6
  TIMEs = 0

  cth = 0
  pick = 0
  drop = 0
  ball = 0
  sack = 0
  rush = 0
 
 
   DO

                                       
      DO
      IF rush = 1 THEN
         IF rushr = 0 THEN
            IF rushx >= qbx - 20 THEN
               rushd = 0
               IF ball = 0 THEN
               sack = 1
               GOTO skp
               END IF
            END IF
         ELSEIF rushr = 1 THEN
            IF rushx <= qbx + 20 THEN
               rushd = 0
               IF ball = 0 THEN
               sack = 1
               GOTO skp
               END IF
            END IF
         END IF
      END IF
      IF TIMEs = 5 AND ball = 0 AND rush = 0 THEN
      rush = 1
      rusht = INT(2 * RND) + 1
      IF rusht = 1 THEN
         rushx = 4
         rushd = 2
         rushr = 0
      ELSEIF rusht = 2 THEN
         rushx = 294
         rushd = -2
         rushr = 1
      END IF

      END IF
      IF ball = 1 THEN
        IF bally <= 0 THEN
        drop = 1
        GOTO skp
        END IF
        clchk = 0
        LINE (ballx - 1, bally)-(ballx + 2, bally + 4), 59, BF
        FOR t = -9 TO 9
         clr = POINT(ballx + t, bally - 4)
         IF clr > 0 THEN clchk = 1
        NEXT
        LINE (ballx - 1, bally + 4)-(ballx + 2, bally + 8), 0, BF
        IF clchk = 0 THEN
          bally = bally - 4
        END IF
        IF clchk = 1 THEN
          IF bally > 100 AND bally < 130 THEN
            cth = 1
            GOTO skp
          END IF
          IF bally > 50 AND bally < 80 THEN
            cth = 2
            GOTO skp
          END IF
          IF bally > 0 AND bally < 30 THEN
            cth = 3
            GOTO skp
          END IF
          IF bally > 130 AND bally < 160 THEN
            pick = 1
            GOTO skp
          END IF
          IF bally > 75 AND bally < 105 THEN
            pick = 1
            GOTO skp
          END IF
          IF bally > 20 AND bally < 50 THEN
            pick = 1
            GOTO skp
          END IF
  
        END IF

      END IF


      PUT (r1, 0), boysprite((imgr1 + rd1) * boyepi), PSET
      PUT (r2, 50), boysprite((imgr2 + rd2) * boyepi), PSET
      PUT (r3, 100), boysprite((imgr1 + rd3) * boyepi), PSET

      PUT (qbx, 170), boysprite(dirimg * boyepi), PSET
      IF rush = 1 THEN PUT (rushx, 170), boysprite((rushr + img1) * boyepi), PSET
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
      SWAP imgr1, imgr2

      IF rush = 1 THEN rushx = rushx + rushd

      thiskey = GetKeyMask
      SpeedDelay
      IF rd1 = 0 THEN
        r1 = r1 + 2
      ELSEIF rd1 = 1 THEN
        r1 = r1 - 2
      END IF
      IF rd2 = 0 THEN
        r2 = r2 + 2
      ELSEIF rd2 = 1 THEN
        r2 = r2 - 2
      END IF
      IF rd3 = 0 THEN
        r3 = r3 + 2
      ELSEIF rd3 = 1 THEN
        r3 = r3 - 2
      END IF

      IF r1 <= 5 THEN
      rd1 = 0
      TIMEs = TIMEs + 1
      END IF
      IF r1 >= 293 THEN rd1 = 1
      IF r2 <= 5 THEN rd2 = 0
      IF r2 >= 293 THEN rd2 = 1
      IF r3 <= 5 THEN rd3 = 0
      IF r3 >= 293 THEN rd3 = 1


      IF lbd1 = 0 THEN
        lbx = lbx + 2
      ELSEIF lbd1 = 1 THEN
        lbx = lbx - 2
      END IF
     IF lbd2 = 0 THEN
       lbx2 = lbx2 + 2
     ELSEIF lbd2 = 1 THEN
       lbx2 = lbx2 - 2
     END IF
     IF lbd3 = 0 THEN
       lbx3 = lbx3 + 2
     ELSEIF lbd3 = 1 THEN
       lbx3 = lbx3 - 2
     END IF

     IF lbx <= 5 THEN lbd1 = 0
     IF lbx >= 194 THEN lbd1 = 1
     IF lbx2 <= 5 THEN lbd2 = 0
     IF lbx2 >= 144 THEN lbd2 = 1
     IF lbx3 <= 5 THEN lbd3 = 0
     IF lbx3 >= 194 THEN lbd3 = 1




     LOOP UNTIL thiskey

skp:





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
  IF thiskey AND 16 THEN
   IF ball = 0 THEN
    ball = 1
    ballx = qbx + 9
    bally = 164
   END IF
  END IF
  IF thiskey AND 64 THEN
    GOTO fingame
  END IF
LOOP UNTIL pick > 0 OR cth > 0 OR down > 4 OR drop > 0 OR sack > 0

IF pick > 0 THEN
   bteam = bteam + 1
   IF bteam = 2 THEN bteam = 0
   half = half + 1
   IF half = 2 THEN half = 0
   down = 1
   yrds = 10
   CLS
   COLOR 15
   PRINT "INTERCEPTED!"
   anykey$ = INPUT$(2)
END IF
IF cth > 0 THEN
    IF cth = 1 THEN
       IF half = 0 THEN yard = yard + 2
       IF half = 1 THEN yard = yard - 2
                                       
       down = down + 1
       yrds = yrds - 2
    END IF
    IF cth = 2 THEN
       IF half = 0 THEN yard = yard + 4
       IF half = 1 THEN yard = yard - 4
                                      
       down = down + 1
       yrds = yrds - 4
    END IF
    IF cth = 3 THEN
       IF half = 0 THEN yard = yard + 10
       IF half = 1 THEN yard = yard - 10
                                     
       down = 1
       yrds = 10
    END IF
  
       IF yrds <= 0 THEN
          down = 1
          yrds = 10
       END IF
       IF yard > 50 THEN
          yard = 50 - (yard - 50)
          half = 1
       END IF
       IF half = 1 AND yard <= 0 THEN
       CLS
       LOCATE 1
       COLOR 15
       tms = bteam + 1
       LOCATE 1, 14
       PRINT "TOUCHDOWN!!!"
       lsprite "helm" + ptm$(tms)
       PUT (130, 70), boysprite(0 * boyepi), PSET
       lsprite "fb01"
       tmscore(bteam + 1) = tmscore(bteam + 1) + 7
       anykey$ = INPUT$(2)
       yard = 40
       half = 0
       down = 1
       yrds = 10
       bteam = bteam + 1
       IF bteam = 2 THEN bteam = 0
       IF qtr > 4 THEN GOTO fingame
      END IF
   END IF
IF drop > 0 THEN
  CLS
  LOCATE 1
  COLOR 15
  PRINT "INCOMPLETE!"
  anykey$ = INPUT$(2)
  down = down + 1
END IF
IF sack > 0 THEN
  CLS
  LOCATE 1
  COLOR 15
  PRINT "QUARTERBACK SACK!"
  anykey$ = INPUT$(2)
  down = down + 1
  yrds = yrds + 2
  IF half = 0 THEN yard = yard - 2
  IF half = 1 THEN yard = yard + 1
  IF yard > 50 THEN
     half = 0
     yard = 50 - (yard - 50)
  END IF
END IF


IF down > 4 THEN
   CLS
   LOCATE 1
   COLOR 15
   PRINT "TURNOVER ON DOWNS"
   down = 1
   half = half + 1
   IF half = 2 THEN half = 0
   yrds = 10
   bteam = bteam + 1
   IF bteam = 2 THEN bteam = 0
   anykey$ = INPUT$(2)
END IF
throws = throws + 1
IF throws = 30 THEN
   throws = 0
   qtr = qtr + 1
END IF
IF qtr = 3 AND throws = 0 THEN
yard = 40
down = 1
yrds = 10
half = 0
bteam = fteam + 1
IF bteam = 2 THEN bteam = 1
CLS
COLOR 15
PRINT "HALF TIME!"
anykey$ = INPUT$(2)
END IF

IF qtr > 4 AND throws = 0 AND tmscore(1) <> tmscore(2) THEN
GOTO fingame
ELSEIF qtr > 4 AND throws = 0 AND tmscore(1) = tmscore(2) THEN
yard = 40
down = 1
yrds = 10
half = 0
bteam = INT(2 * RND)
CLS
COLOR 15
PRINT "OVERTIME!"
anykey$ = INPUT$(2)
maxt = 10
END IF

LOOP
fingame:
  CLS
  LOCATE 1
  COLOR 15
  tms = bteam + 1
  lsprite "helm" + ptm$(tms)
  PUT (0, 0), boysprite(0 * boyepi), PSET
  LOCATE 6, 10
  PRINT "---"; tmscore(tms)
  tms2 = bteam + 2
  IF tms2 = 3 THEN tms2 = 1
  lsprite "helm" + ptm$(tms2)
  PUT (0, 60), boysprite(0 * boyepi), PSET
  LOCATE 14, 10
  PRINT "---"; tmscore(tms2)
  lsprite "fb01"
  LOCATE 16
  PRINT "END OF GAME!"
  anykey$ = INPUT$(2)

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

SUB PRACTICE
  CLS
  INPUT "PLAYER NAME--"; pname$
  pname$ = UCASE$(pname$)
bteam = 0
ttgo = 10

   OPEN "HSCORE.TXT" FOR INPUT AS #1
         INPUT #1, hscore
         INPUT #1, teamp$
         INPUT #1, name$
   CLOSE #1
  CLS
  LOCATE 1
  COLOR 15
  
  lsprite "helm" + teamp$
  PUT (0, 0), boysprite(0 * boyepi), PSET
  LOCATE 6, 10
  PRINT "---"; hscore; ""
  LOCATE 16
  PRINT "HIGH SCORE---"; name$
  anykey$ = INPUT$(2)
showteam

DO
  CLS
  LOCATE 1
  COLOR 15
  tms = bteam + 1
  lsprite "helm" + ptm$(tms)
  PUT (0, 0), boysprite(0 * boyepi), PSET
  LOCATE 6, 10
  PRINT "---"; tmscore(tms)
  lsprite "fb01"
  LOCATE 15
  PRINT pname$
  PRINT ttgo; " TRIES LEFT"
 
  
   COLORs ptm$(1), ptm$(2)
  anykey$ = INPUT$(2)
  CLS

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
  img1 = 21
  img2 = 19
  r1 = INT(280 * RND) + 16
  r2 = INT(280 * RND) + 16
  r3 = INT(290 * RND) + 6
  rd1 = INT(2 * RND)
  rd2 = INT(2 * RND)
  rd3 = INT(2 * RND)

  imgr1 = 4
  imgr2 = 6
  TIMEs = 0

  cth = 0
  pick = 0
  drop = 0
  ball = 0
  sack = 0
  rush = 0


   DO

                                      
      DO
      IF rush = 1 THEN
      sack = 1
      GOTO skp2
      END IF
      IF TIMEs = 5 AND ball = 0 AND rush = 0 THEN
      rush = 1

      END IF
      IF ball = 1 THEN
        IF bally <= 0 THEN
        drop = 1
        GOTO skp2
        END IF
        clchk = 0
        LINE (ballx - 1, bally)-(ballx + 2, bally + 4), 59, BF
        FOR t = -4 TO 4
         clr = POINT(ballx + t, bally - 4)
         IF clr > 0 THEN clchk = 1
        NEXT
        LINE (ballx - 1, bally + 4)-(ballx + 2, bally + 8), 0, BF
        IF clchk = 0 THEN
          bally = bally - 4
        END IF
        IF clchk = 1 THEN
          IF bally > 100 AND bally < 130 THEN
            cth = 1
            GOTO skp2
          END IF
          IF bally > 50 AND bally < 80 THEN
            cth = 2
            GOTO skp2
          END IF
          IF bally > 0 AND bally < 30 THEN
            cth = 3
            GOTO skp2
          END IF
          IF bally > 130 AND bally < 160 THEN
            pick = 1
            GOTO skp2
          END IF
          IF bally > 75 AND bally < 105 THEN
            pick = 1
            GOTO skp2
          END IF
          IF bally > 20 AND bally < 50 THEN
            pick = 1
            GOTO skp2
          END IF
 
        END IF

      END IF


      PUT (r1, 0), boysprite((33) * boyepi), PSET
      PUT (r2, 50), boysprite((32) * boyepi), PSET
      PUT (r3, 100), boysprite((31) * boyepi), PSET

      PUT (qbx, 170), boysprite(dirimg * boyepi), PSET
      PUT (lbx, 20), boysprite((30) * boyepi), PSET
      PUT (lbx + 50, 20), boysprite((30) * boyepi), PSET
      PUT (lbx + 100, 20), boysprite((30) * boyepi), PSET

      PUT (lbx2, 75), boysprite((30) * boyepi), PSET
      PUT (lbx2 + 50, 75), boysprite((30) * boyepi), PSET
      PUT (lbx2 + 100, 75), boysprite((30) * boyepi), PSET
      PUT (lbx2 + 150, 75), boysprite((30) * boyepi), PSET

      PUT (lbx3, 130), boysprite((30) * boyepi), PSET
   
      PUT (lbx3 + 50, 130), boysprite((30) * boyepi), PSET
      PUT (lbx3 + 100, 130), boysprite((30) * boyepi), PSET



      thiskey = GetKeyMask
      SpeedDelay
      IF rd1 = 0 THEN
        r1 = r1 + 4
      ELSEIF rd1 = 1 THEN
        r1 = r1 - 4
      END IF
      IF rd2 = 0 THEN
        r2 = r2 + 3
      ELSEIF rd2 = 1 THEN
        r2 = r2 - 3
      END IF
      IF rd3 = 0 THEN
        r3 = r3 + 2
      ELSEIF rd3 = 1 THEN
        r3 = r3 - 2
      END IF

      IF r1 <= 7 THEN
      rd1 = 0
      TIMEs = TIMEs + 1
      END IF
      IF r1 >= 291 THEN rd1 = 1
      IF r2 <= 6 THEN rd2 = 0
      IF r2 >= 292 THEN rd2 = 1
      IF r3 <= 5 THEN rd3 = 0
      IF r3 >= 293 THEN rd3 = 1


      IF lbd1 = 0 THEN
        lbx = lbx + 2
      ELSEIF lbd1 = 1 THEN
        lbx = lbx - 2
      END IF
     IF lbd2 = 0 THEN
       lbx2 = lbx2 + 2
     ELSEIF lbd2 = 1 THEN
       lbx2 = lbx2 - 2
     END IF
     IF lbd3 = 0 THEN
       lbx3 = lbx3 + 2
     ELSEIF lbd3 = 1 THEN
       lbx3 = lbx3 - 2
     END IF

     IF lbx <= 5 THEN lbd1 = 0
     IF lbx >= 194 THEN lbd1 = 1
     IF lbx2 <= 5 THEN lbd2 = 0
     IF lbx2 >= 144 THEN lbd2 = 1
     IF lbx3 <= 5 THEN lbd3 = 0
     IF lbx3 >= 194 THEN lbd3 = 1




     LOOP UNTIL thiskey

skp2:





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
  IF thiskey AND 16 THEN
   IF ball = 0 THEN
    ball = 1
    ballx = qbx + 9
    bally = 164
   END IF
  END IF
LOOP UNTIL pick > 0 OR cth > 0 OR down > 4 OR drop > 0 OR sack > 0

IF pick > 0 THEN
   CLS
   COLOR 15
   PRINT "INCOMPLETE!"
   anykey$ = INPUT$(2)
   ttgo = ttgo - 1
   IF ttgo = 0 THEN GOTO fin
END IF
IF cth > 0 THEN
    IF cth = 1 THEN
        tmscore(tms) = tmscore(tms) + 2
        ttgo = ttgo - 1
        IF ttgo = 0 THEN GOTO fin
   
    END IF
    IF cth = 2 THEN
        tmscore(tms) = tmscore(tms) + 4
        ttgo = ttgo - 1
        IF ttgo = 0 THEN GOTO fin
   
    END IF
    IF cth = 3 THEN
        tmscore(tms) = tmscore(tms) + 10
        ttgo = ttgo - 1
        IF ttgo = 0 THEN GOTO fin
   
    END IF
 
       CLS
       LOCATE 1
       COLOR 15
   
   END IF
IF drop > 0 THEN
  CLS
  LOCATE 1
  COLOR 15
  PRINT "INCOMPLETE!"
  anykey$ = INPUT$(2)
        ttgo = ttgo - 1
        IF ttgo = 0 THEN GOTO fin
  
END IF
IF sack > 0 THEN
  CLS
  LOCATE 1
  COLOR 15
  PRINT "OUT OF TIME!"
  anykey$ = INPUT$(2)
        ttgo = ttgo - 1
        IF ttgo = 0 THEN GOTO fin
END IF



LOOP
fin:

  CLS
  LOCATE 1
  COLOR 15
  tms = bteam + 1
  lsprite "helm" + ptm$(tms)
  PUT (0, 0), boysprite(0 * boyepi), PSET
  LOCATE 6, 10
  PRINT "---"; tmscore(tms)
  lsprite "fb01"
  LOCATE 16
  PRINT "FINAL SCORE!"
  IF tmscore(tms) > hscore THEN
    LOCATE 17
    PRINT "A NEW RECORD!!"
  END IF
  anykey$ = INPUT$(2)
 
  IF tmscore(tms) > hscore THEN
  
  
   OPEN "HSCORE.TXT" FOR OUTPUT AS #1
         WRITE #1, tmscore(tms)
         WRITE #1, ptm$(tms)
         WRITE #1, pname$
   CLOSE #1
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

SUB setcolors (pal() AS Hues, fc, lc)
   OUT &H3C8, fc                                 'initialize controller
   FOR t = fc TO lc                              'from first to last
      OUT &H3C9, pal(t).red                      'send red component
      OUT &H3C9, pal(t).green                    'send green component
      OUT &H3C9, pal(t).blue                     'send blue component
   NEXT
END SUB

SUB showteam

  CLS
  bteam = 0
  LOCATE 1
  COLOR 15
  PRINT "TODAY'S PRACTICE..."

  lsprite "helm" + ptm$(bteam + 1)
  PUT (0, 70), boysprite(0 * boyepi), PSET
  anykey$ = INPUT$(2)

END SUB

SUB showteams
  CLS
  REDIM boxes(1 TO 6)
 
  bteam = 0
  LOCATE 1
  COLOR 15
  PRINT "TONIGHT'S GAME..."

  lsprite "helm" + ptm$(bteam + 1)
  PUT (0, 70), boysprite(0 * boyepi), PSET
  lsprite "helm" + ptm$(bteam + 2)
  PUT (259, 70), boysprite(0 * boyepi), PSET
  lsprite "fbltr"
  PUT (133, 90), boysprite(0 * boyepi), PSET
  PUT (153, 90), boysprite(1 * boyepi), PSET
  LINE (93, 169)-(114, 190), 15, B
  LINE (114, 169)-(135, 190), 15, B
  LINE (135, 169)-(156, 190), 15, B
  LINE (156, 169)-(177, 190), 15, B
  LINE (177, 169)-(198, 190), 15, B
  LINE (198, 169)-(219, 190), 15, B

  lsprite "codes"
  TIME$ = "00:00:00"
  DO
  PUT (94, 170), boysprite(boxes(1) * boyepi), PSET
  PUT (115, 170), boysprite(boxes(2) * boyepi), PSET
  PUT (136, 170), boysprite(boxes(3) * boyepi), PSET
  PUT (157, 170), boysprite(boxes(4) * boyepi), PSET
  PUT (178, 170), boysprite(boxes(5) * boyepi), PSET
  PUT (199, 170), boysprite(boxes(6) * boyepi), PSET
  key$ = INKEY$
 
  FOR i = 49 TO 54
  IF key$ = CHR$(i) THEN boxes(i - 48) = boxes(i - 48) + 1
  IF key$ = CHR$(55) THEN
     FOR z = 1 TO 6
         boxes(z) = 0
     NEXT
  END IF
  NEXT
  FOR i = 1 TO 6
  IF boxes(i) > 9 THEN boxes(i) = 0
   NEXT
  
  LOOP UNTIL TIME$ = "00:00:08"
                                                                                                                                                                                                                                                                                
yard = 40
down = 1
yrds = 10
half = 0
bteam = INT(2 * RND)
fteam = bteam
qtr = 1
throws = 0
maxt = 30

IF boxes(1) = 4 AND boxes(2) = 2 AND boxes(3) = 9 AND boxes(4) = 4 AND boxes(5) = 2 AND boxes(6) = 9 THEN
     CLS
     COLOR 15
     PRINT "7 POINT ADVANTAGE FOR "; ptm$(1)
     anykey$ = INPUT$(1)
     tmscore(1) = 7
END IF
IF boxes(1) = 4 AND boxes(2) = 2 AND boxes(3) = 8 AND boxes(4) = 4 AND boxes(5) = 2 AND boxes(6) = 8 THEN
     CLS
     COLOR 15
     PRINT "7 POINT ADVANTAGE FOR "; ptm$(2)
     anykey$ = INPUT$(1)
     tmscore(2) = 7
END IF
IF boxes(1) = 6 AND boxes(2) = 3 AND boxes(3) = 3 AND boxes(4) = 2 AND boxes(5) = 2 AND boxes(6) = 4 THEN
     CLS
     COLOR 15
     PRINT "40 YARDS TO GO"
     anykey$ = INPUT$(1)
     half = 1
END IF
IF boxes(1) = 8 AND boxes(2) = 7 AND boxes(3) = 1 AND boxes(4) = 3 AND boxes(5) = 4 AND boxes(6) = 0 THEN
     CLS
     COLOR 15
     PRINT ".5...."
     PRINT
     PRINT "THIS IS JUST PART OF THE ULTIMATE CODE.."
     anykey$ = INPUT$(1)
END IF
IF boxes(1) = 8 AND boxes(2) = 7 AND boxes(3) = 1 AND boxes(4) = 3 AND boxes(5) = 4 AND boxes(6) = 0 THEN
     CLS
     COLOR 15
     PRINT "_5____"
     PRINT "THIS IS JUST PART OF THE ULTIMATE CODE..."
     anykey$ = INPUT$(1)
END IF


                                                



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
  
   x! = x! + addv!
   addv! = addv! + adv!
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

SUB SpeedDelay STATIC
    FOR tdly = 1 TO delay
    NEXT
        
END SUB

SUB title
REDIM pal(255) AS Hues                           'array for palette
DEF SEG = VARSEG(pal(0))                         'point to it
BLOAD "mix.PAL", 0                           'load from file
pal(0).red = 10                                  'set background
pal(0).green = 10                                'to a dark shade
pal(0).blue = 10                                 'of blue gray
setcolors pal(), 0, 255                          'set system colors
lsprite "helmsf"
'FOR i! = 0 TO 1.1 STEP .2
'scale 0, 70, 0, 60, 60, i!, i!, 0
'NEXT
PUT (0, 70), boysprite(0 * boyepi), PSET

lsprite "helmda"
'FOR i! = 0 TO 1.1 STEP .2
'scale 259, 70, 2, 60, 60, i!, i!, 0
'NEXT
PUT (259, 70), boysprite(1 * boyepi), PSET

SLEEP 1
FOR i = 0 TO 10 STEP 1
lsprite "helmsf"
PUT (i, 70), boysprite(0 * boyepi), PSET
lsprite "helmda"
PUT (259 - i, 70), boysprite(1 * boyepi), PSET
NEXT
FOR i = 10 TO 30 STEP 2
lsprite "helmsf"
PUT (i, 70), boysprite(0 * boyepi), PSET
lsprite "helmda"
PUT (259 - i, 70), boysprite(1 * boyepi), PSET
NEXT
FOR i = 30 TO 100 STEP 4
lsprite "helmsf"
PUT (i, 70), boysprite(0 * boyepi), PSET
lsprite "helmda"
PUT (259 - i, 70), boysprite(1 * boyepi), PSET
NEXT


lsprite "helmsf"

FOR i = 0 TO 30

FOR t = 0 TO 255
    pal(t).red = pal(t).red + 5
    pal(t).green = pal(t).green + 5
    pal(t).blue = pal(t).blue + 5
    IF pal(t).red > 60 THEN pal(t).red = 60
    IF pal(t).green > 60 THEN pal(t).green = 60
    IF pal(t).blue > 60 THEN pal(t).blue = 60
IF t MOD 10 = 0 THEN LINE (INT(320 * RND), INT(200 * RND))-(INT(320 * RND), INT(200 * RND)), 0

NEXT
setcolors pal(), 0, 255

NEXT
CLS
REDIM pal(255) AS Hues                           'array for palette
DEF SEG = VARSEG(pal(0))                         'point to it
BLOAD "mix.PAL", 0                           'load from file
pal(0).red = 0
pal(0).green = 45
pal(0).blue = 0


setcolors pal(), 0, 255





END SUB

