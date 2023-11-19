
'                             ÆÆÆSTAR WARSØØØ

CLS
FOR XO = 1 TO 2000
    CO% = INT((RND * 15) + 1)
    RANDOMIZE TIMER
    LOCATE , 35
    COLOR CO%
    PRINT "Visual üx"

NEXT XO
    CLS
    COLOR 11
    LOCATE 11, 30
    COLOR 11
    PRINT "∞±≤€€€€€€€€€€€€€≤±∞"
    COLOR 3
    PRINT "                             ∞±≤€€€€€€€€€€€€€≤±∞"
    LOCATE , 30
    COLOR 11
    PRINT "∞±≤€ Visual üx €≤±∞"
    COLOR 3
    PRINT "                             ∞±≤€€€€€€€€€€€€€≤±∞"
    COLOR 11
    PRINT "                             ∞±≤€€€€€€€€€€€€€≤±∞"
    COLOR 15
    PRINT "                                  PRESENTS:"
INPUT VFX$
    CLS
    LOCATE 8
    COLOR 14
    PRINT "                         …ÕÕÕÕÕÕÀÕÕÕ∏   …Õª    …ÕÕÕÕª"
    PRINT "                         ∫      ∫      ∫   ∫   ∫    ∫"
    PRINT "                         »ÕÕÕÕª ∫     ÃÕÕÕÕÕπ  ÃÕÕÀÕº "
    PRINT "                              ∫ ∫     ∫     ∫  ∫   ∫"
    PRINT "                      ‘ÕÕÕÕÕÕÕº –     –     –  –   »ÕÕÕæ"
    PRINT
    PRINT "                      “   “   “   …Õª   …ÕÕÕÕª  …ÕÕÕÕÕÕ∏"
    PRINT "                      ∫  ∫ ∫  ∫  ∫   ∫  ∫    ∫  ∫    "
    PRINT "                       ∫ ∫ ∫ ∫  ÃÕÕÕÕÕπ ÃÕÕÀÕº  »ÕÕÕÕª"
    PRINT "                        ∫   ∫   ∫     ∫ ∫   ∫        ∫"
    PRINT "                        –   –   –     – –   »ÕÕÕÕÕÕÕÕº  "
    INPUT TITLE$
CLS
COLOR 1
PRINT
PRINT
PRINT
PRINT
PRINT "                                 €€≤≤€≤±≤≤≤≤≤≤±±"
PRINT "        €€≤±∞                   €€≤≤€≤±≤≤≤≤≤≤≤±±∞"
PRINT "       €€≤±€≤∞                 €€≤≤€≤±≤≤≤≤≤≤≤≤≤±±∞∞"
PRINT "       €€≤±±±∞                 €€≤≤€≤±≤≤≤≤≤≤≤≤≤±±∞∞∞"
PRINT "        €€≤±∞                 €€€€≤±∞±≤≤€€€≤±∞≤±±∞∞∞"
PRINT "                             €∞≤±±±±≤±±±∞≤±±±±≤±±±∞∞∞"
PRINT "                             €∞≤±±±±≤€≤≤∞≤±±±±≤±±±±∞∞∞"
PRINT "                             €∞∞≤±±≤€∞±±≤∞≤±±≤±≤±±±∞∞∞"
PRINT "                             €∞∞≤≤≤€∞±±±±≤∞≤≤≤±∞≤±±±∞∞∞"
PRINT "                             €∞≤≤≤€∞±±±±±±≤∞≤±±±∞≤±±±±∞∞"
PRINT "                            €∞∞≤≤≤€€€€≤≤≤≤±∞∞±±±∞∞≤±±±±∞∞"
PRINT "                            €∞∞∞∞≤±±∞∞∞∞∞∞∞∞±±±±±∞∞≤±±±±∞"
PRINT "                             €€±∞∞≤±±∞∞∞∞∞∞∞∞±±±±±∞∞≤≤≤±±∞"
PRINT "                                 ≤≤±±±∞∞∞∞∞∞∞∞±±±±∞∞"
PRINT "                                  ≤≤±∞∞∞∞∞∞∞∞∞∞±±±∞"
COLOR 15
PRINT "                      STAR WARS: PROGRAMED BY CLB OF VISUAL üx"
INPUT VADER$
JOYSTICK$ = "NO"    'ERASE "NO" AND TYPE "YES" TO USE THE JOYSTICK
EELIN = 200
ETM = 1600
PT = 19
ZZ$ = "|"
Z$ = "√Ï¥"
A = 24
B = 11
1 SCREEN 7, 1
COLOR 9, 0
LINE (5, 10)-(315, 191), , B
LINE (5, 175)-(315, 175)
LINE (60, 191)-(80, 175), , B
LINE -(100, 191), , B
LINE -(120, 175), , B
LINE -(140, 191), , B
LINE -(160, 175), , B
PAINT (70, 180)
PAINT (110, 180)
PAINT (150, 180)
COLOR 8
FOR T = 1 TO 22 STEP 2
LOCATE T, 2
COLOR 15
PRINT "≤≤≤∞∞∞"
LOCATE T, 31
PRINT "  ∞∞∞≤≤≤"
NEXT T
COLOR 8
LOCATE 24, 3
PRINT "POWER"
LOCATE 23, 25
PRINT "SCORE"
10 X = INT(RND * 19)
M = X + 11
KL = INT(RND * 19)
LK = KL + 11
REM
REM
FOR O = 1 TO 19 STEP 2
GOSUB 80
COLOR 8
46 IF A <= 11 THEN A = 11
IF A >= 28 THEN A = 28
A2 = A + 2
LOCATE 19, A
COLOR 15
PRINT "‘ æ"
COLOR 4
IF F = 20 AND LK = A2 - 1 THEN 20
IF F = 20 AND M = A2 - 1 THEN 20
15 C = STICK(0) * 2
LOCATE 19, A
PRINT "    "
LOCATE F, M
PRINT "    "
LOCATE F, LK
PRINT "    "
LOCATE 2, PT
PRINT "    "
REM
IF STRIG(1) = -1 THEN SOUND 100, 1: GOTO 50
KEY$ = INKEY$
IF KEY$ = "4" THEN A = A - 1
IF KEY$ = "6" THEN A = A + 1
IF KEY$ = "8" THEN SOUND 150, 1: GOTO 50
IF JOYSTICK$ = "NO" THEN 3
12 IF C < 30 THEN A = A + 1: GOTO 3
IF C > 300 THEN A = A + 1
IF C < 100 THEN A = A - 1
3 NEXT O
HE = 0
P = 0
GOTO 10
REM
20 SOUND 50, 1
H = H + 1
CIRCLE (70, 175), 4, 0
IF H = 2 THEN CIRCLE (110, 175), 4, 0
IF H = 3 THEN CIRCLE (150, 175), 4, 0
IF H = 4 THEN 30
GOTO 15
REM
30 CLS
LOCATE 10, 1
COLOR 4, 7
PRINT "    THIS IS THE END OF THE WORLD                  AS WE KNOW IT!!"
END
REM
50 IF HE = 1 THEN 12
FOR V = 18 TO 1 STEP -2
LOCATE V, A
PRINT CHR$(6)
LOCATE V, A2
PRINT CHR$(6)
FOR Z = 1 TO 100: NEXT Z
LOCATE V, A
PRINT " "
LOCATE V, A2
PRINT " "
NEXT V
IF A = PT THEN 60
IF A2 = PT THEN 60
IF A + 1 = PT THEN 60
HE = 1
GOTO 12
REM
60 SOUND 200, 1
QW = INT(RND * 2) + 1
IF QW = 1 THEN PT = A - 10 ELSE PT = A + 10
YU = YU + 1
LOCATE 23, 35
PRINT YU
IF YU = 2 THEN Z$ = CHR$(3)
IF YU = 5 THEN Z$ = CHR$(15)
IF YU = 8 THEN GO = 3: GOTO 10
IF YU = 15 THEN 1000
GOTO 12
80 REM
F = O + 1
LOCATE F, LK
COLOR 2
PRINT ZZ$
LOCATE F, M
PRINT ZZ$
COLOR 4
45 TP = INT(RND * 2) + 1
IF TP = 1 THEN PT = PT + 1 ELSE IF TP = 2 THEN PT = PT - 1
IF PT <= 11 THEN PT = 11 ELSE IF PT >= 28 THEN PT = 28
LOCATE 2, PT
COLOR 2
PRINT Z$
RETURN
1000 SCREEN 7, 1
CLS
COLOR 7, 0
FOR ED = 1 TO 100
EDV = INT(RND * 200)
EDH = INT(RND * 315)
PSET (EDH, EDV): NEXT ED
FOR EC = 1 TO 40
COLOR 4, 0
FOR ET = 1 TO ETM: NEXT ET: ETM = ETM - 40
SOUND 300, 1
COLOR 5, 3
NEXT EC
COLOR 4, 0
COLOR 2, 0
FOR ECIR = 1 TO 150 STEP 5
FOR EN = 1 TO 700: NEXT EN
SOUND ECIR + 40, 1
CIRCLE (160, 100), ECIR
NEXT ECIR
SOUND 50, 50
FOR EN = 1 TO 50000: NEXT EN
1100 FOR ELINE = 0 TO 100
EELIN = EELIN - 1
FOR EN = 1 TO 1000: NEXT EN
COLOR 0
LINE (0, ELINE)-(320, ELINE)
LINE (0, EELIN)-(320, EELIN)
NEXT ELINE
SOUND 50, 1
SOUND 100, 1
SOUND 150, 1
SOUND 200, 1
SOUND 150, 1
SOUND 200, 1
COLOR 11
PRINT "     THE DEATH STAR HAS EXPLODED!!"
PRINT "   THE REBELS HAVE WON ONCE AGAIN!!!"
PRINT "         ∫  MAY THE FORCE  ∫"
PRINT "        ‘ æ  BE WITH YOU  ‘ æ "
PRINT
PRINT "               THE END "
PRINT
INPUT ENDING$
CLS
COLOR 11
PRINT "         THANKS FOR PLAYING!!!"
PRINT "     PROGRAMED BY CLB OF Visual üx"

