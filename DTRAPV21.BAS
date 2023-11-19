'
'----------------------------------------------------------------------------------
'                       ULTIMATE DEATH TRAP (V 2.1)
'                    1996  STEELE SOFTWARE- finished 3/5
'
'Unless you're a programmer, hit SHIFT+F5 right now before you hurt yourself!
'
'
'       It's basically the same as version 2.00 except it works! Now you can
'use your soundblaster card. This version has better gameplay and an ending.
'Choose from two players and fight in a five battle tournament. You alternate
'between the two backgrounds. In the final fight, you must beet Shogun to get
'the glow of the master. In short, choose one of two players and fight your
'way to knock some attacker off a ledge to win the tournament!
'
'OTHER INFO:
'
'This program was made on a 90 mhz Pentium, and some parts of it on a
'386 25 mhz. Sorry! So, you programmers using dinosaur computers might have a
'little trouble during soundblaster effects and gameplay.
'
'The code is pretty choppy (you should see version 2.00!) but some of you
'might get some use out of sound and graphics, and your free to take them.
'That's the main way I learned QBASIC. Just don't take the credit!
'
'---------------------HERE'S WHERE THE PROGRAM BEGINS!------------------------------
'

DECLARE SUB GUY1ENDING ()
DECLARE SUB GUY2ENDING ()
DECLARE SUB GUY1PUNCH ()
DECLARE SUB GUY2PUNCH ()
DECLARE SUB ENEMY2KICK ()
DECLARE SUB SLECTFIGHT ()
DECLARE SUB ENEMY2PLAIN ()
DECLARE SUB FIGHTSET2 ()
DECLARE SUB FIGHTSET1 ()
DECLARE SUB ENEMY1KICK ()
DECLARE SUB ENEMYMOVE ()
DECLARE SUB ENEMYFIGHT ()
DECLARE SUB ENEMYACTION ()
DECLARE SUB ENEMY1PLAIN ()
DECLARE SUB BACKGROUND2 ()
DECLARE SUB GUY2KICK ()
DECLARE SUB GUY1KICK ()
DECLARE SUB SCOREA ()
DECLARE SUB SCOREB ()
DECLARE SUB PUNCHOFFLEDGE ()
DECLARE SUB BACKGROUND1 ()
DECLARE SUB GUY2PLAIN ()
DECLARE SUB PICK ()
DECLARE SUB GUY1PLAIN ()
DEFINT A-Z
DECLARE FUNCTION DetectCard% ()
DECLARE SUB SBInit ()
DECLARE SUB WriteReg (Reg%, Value%)
DECLARE SUB SBPlay (NOTE%)
DECLARE SUB HELPPRINT ()
DECLARE SUB SETUP ()
DECLARE SUB HELP ()
DECLARE SUB FONT (fh%, fv%, letter$, col%)
DECLARE SUB CREDITS ()
DECLARE SUB SNDTEST ()
DECLARE SUB MENU ()
DECLARE SUB BUILDING ()
DECLARE SUB SONG2 ()
DECLARE SUB NOTE (level%, legnth%)
DECLARE SUB DELAY (break%)
DECLARE SUB SONG1 ()
COMMON SHARED NA$, NB$, XA%, YA%, XB%, YB%, C%, D%, CHRPICK%, ASCORE%, BSCORE%, R%, AL%, BL%

COLOR 15
CONST false = 0, true = NOT false
SCREEN 0: CLS
                                                            
IF DetectCard = true THEN
  PRINT "AdLib-compatible sound card detected."
ELSE
  PRINT "Unable to find/detect sound card."
  BEEP
  SYSTEM
END IF
PRINT " Initalizing..."; : SBInit
PRINT " Done."
FOR nt = 0 TO 255
            
NEXT nt
PRINT
PRINT "The Sound Blaster card initialized"
FOR nt = 255 TO 0 STEP -1
   SBPlay nt
NEXT nt
CALL WriteReg(&HB0, &H0) 'Makes sure no extra sound is left playing
SLEEP 1
PRINT ""
COLOR 15, 0: PRINT "Death Trap v2.10"
PRINT "Free memory bytes:"; FRE(-1)
PRINT "Loading..."
SLEEP 2
CLS
SCREEN 13
FOR C = 1 TO 46
FONT 70, 80, "U", C
FONT 80, 80, "L", C
FONT 90, 80, "T", C
FONT 100, 80, "I", C
FONT 110, 80, "M", C
FONT 120, 80, "A", C
FONT 130, 80, "T", C
FONT 140, 80, "E", C
FONT 160, 80, "D", C
FONT 170, 80, "E", C
FONT 180, 80, "A", C
FONT 190, 80, "T", C
FONT 200, 80, "H", C
FONT 220, 80, "T", C
FONT 230, 80, "R", C
FONT 240, 80, "A", C
FONT 250, 80, "P", C
DELAY 18000
NEXT C
SLEEP 1
COLOR 4
LOCATE 12, 14
PRINT "VERSION 2.1"
SONG2
SONG2
SONG2
SLEEP 2
BUILDING
SLEEP 3
AL% = 0
BL% = 0
MENU

DEFSNG A-Z
SUB BACKGROUND1
SCREEN 13
PAINT (100, 60), 9
LINE (0, 140)-(320, 160), 10, BF
LINE (0, 139)-(320, 139), 0
LINE (0, 161)-(320, 161), 0
PAINT (10, 165), 0
CIRCLE (300, 20), 13, 14
PAINT (300, 20), 14
CIRCLE (100, 30), 10, 15
CIRCLE (120, 28), 15, 15
CIRCLE (135, 32), 10, 15
PAINT (100, 30), 15
PAINT (120, 28), 15
PAINT (135, 32), 15
PAINT (106, 30), 15
PAINT (130, 32), 15
CIRCLE (180, 40), 10, 15
CIRCLE (200, 38), 15, 15
CIRCLE (215, 42), 10, 15
PAINT (180, 40), 15
PAINT (200, 38), 15
PAINT (215, 42), 15
PAINT (186, 40), 15
PAINT (210, 42), 15
LINE (5, 1)-(280, 10), 0, BF
COLOR 15
LOCATE 1, 2
PRINT "SCENE- The countryside  ROUND- "; R%
END SUB

SUB BACKGROUND2
SCREEN 13
LINE (0, 140)-(320, 160), 10, BF
LINE (0, 139)-(320, 139), 0
LINE (2, 50)-(318, 138), 9, BF
LINE (2, 50)-(159, 10), 6
LINE (159, 10)-(318, 50), 6
LINE (2, 50)-(318, 50), 6
PAINT (159, 20), 6
LINE (5, 60)-(35, 75), 1, BF
LINE (50, 60)-(80, 75), 1, BF
LINE (95, 60)-(125, 75), 1, BF
LINE (140, 60)-(170, 75), 1, BF
LINE (185, 60)-(215, 75), 1, BF
LINE (230, 60)-(260, 75), 1, BF
LINE (275, 60)-(305, 75), 1, BF
LOCATE 1, 2
COLOR 15
PRINT "SCENE- BUILDING     ROUND"; R%
END SUB

SUB BUILDING
SCREEN 9
LINE (1, 250)-(650, 275), 2, BF
LINE (70, 100)-(110, 125), 1, BF
LINE (130, 100)-(170, 125), 1, BF
LINE (190, 100)-(230, 125), 1, BF
LINE (250, 100)-(290, 125), 1, BF
LINE (310, 100)-(350, 125), 1, BF
LINE (370, 100)-(410, 125), 1, BF
LINE (430, 100)-(470, 125), 1, BF
LINE (490, 100)-(530, 125), 1, BF
LINE (550, 100)-(590, 125), 1, BF
LINE (50, 80)-(610, 250), 4, B
PSET (30, 79), 4
DRAW "R610H50L510G50"
COLOR 4
LOCATE 3, 23
PRINT "                                    "
LOCATE 4, 23
PRINT "          DEATH TRAP ARENA          "
LOCATE 5, 23
PRINT "                                    "
COLOR 15
LOCATE 3, 23
PRINT "* * * * * * * * * * * * * * * * * *"
LOCATE 4, 23
PRINT "*"
LOCATE 5, 23
PRINT "* * * * * * * * * * * * * * * * * *"
LOCATE 4, 57
PRINT "*"
LINE (275, 175)-(375, 250), 8, BF
PSET (325, 175), 0
DRAW "D73"
LINE (285, 190)-(315, 195), 0, BF
LINE (335, 190)-(365, 195), 0, BF
COLOR 4
LOCATE 7, 8
PRINT "∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞"
LOCATE 10, 8
PRINT "±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±"
LOCATE 11, 8
PRINT "∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞"
LOCATE 12, 8
PRINT "±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±"
LOCATE 13, 8
PRINT "∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞"
LOCATE 14, 8
PRINT "±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±"
LOCATE 14, 48
PRINT "±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±"
LOCATE 15, 8
PRINT "∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞"
LOCATE 15, 48
PRINT "∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞"
LOCATE 16, 8
PRINT "±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±"
LOCATE 16, 48
PRINT "±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±"
LOCATE 17, 8
PRINT "∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞"
LOCATE 17, 48
PRINT "∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞"
LOCATE 18, 8
PRINT "±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±"
LOCATE 18, 48
PRINT "±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±∞±"
COLOR 6
LOCATE 2, 22
PRINT "…ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕª"
LOCATE 3, 22
PRINT "∫"
LOCATE 4, 22
PRINT "∫"
LOCATE 5, 22
PRINT "∫"
LOCATE 6, 22
PRINT "»ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº"
LOCATE 5, 59
PRINT "∫"
LOCATE 4, 59
PRINT "∫"
LOCATE 3, 59
PRINT "∫"
COLOR 15
END SUB

SUB CREDITS
CLS
COLOR 4
LOCATE 5, 15
PRINT "PROGRAMMING"
COLOR 4
LOCATE 8, 13
PRINT "-Britt Steele-"
COLOR 15
LOCATE 12, 12
PRINT "GRAPHICS/SOUND"
LOCATE 15, 13
PRINT "-Britt Steele-"
COLOR 1
LOCATE 20, 17
PRINT "DESIGN"
LOCATE 23, 13
PRINT "-Britt Steele-"
PLAY "MB T70 O3 L20AL32AFA"
PLAY "MB L8O3B L16 B B L8O4C D L16E F F F L8 G "
SLEEP 10
MENU
END SUB

DEFINT A-Z
SUB DELAY (break%)
FOR W% = 1 TO break% STEP 1: NEXT W%
END SUB

FUNCTION DetectCard%
   '  Purpose:   Detects an AdLib-compatible card.
   '             Returns -1 (true) if detected and 0 (false) if not.
   '  Variables: Nope
                                                               
   CALL WriteReg(&H4, &H60)
   CALL WriteReg(&H4, &H80)
   B = INP(&H388)
   CALL WriteReg(&H2, &HFF)
   CALL WriteReg(&H4, &H21)
   FOR X = 0 TO 130
      a = INP(&H388)
   NEXT X
   C = INP(&H388)
   CALL WriteReg(&H4, &H60)
   CALL WriteReg(&H4, &H80)
   Success = 0
   IF (B AND &HE0) = &H0 THEN
     IF (C AND &HE0) = &HC0 THEN
       Success = -1
     END IF
   END IF
   DetectCard% = Success
END FUNCTION

DEFSNG A-Z
SUB ENEMY1KICK
CIRCLE (XB% - 1, YB% + 30), 4, 0
LINE (XB% - 3, YB% + 33)-(XB% + 2, YB% + 40), 0, B
LINE (XB% - 6, YB% + 34)-(XB% + 5, YB% + 34), 0
LINE (XB% + 6, YB% + 35)-(XB% + 6, YB% + 39), 0
LINE (XB% + 4, YB% + 40)-(XB% + 5, YB% + 40), 0
LINE (XB% + 4, YB% + 39)-(XB% + 4, YB% + 36), 0
LINE (XB% + 3, YB% + 36)-(XB% + 3, YB% + 36), 0
LINE (XB%, YB% + 30)-(XB%, YB% + 30), 0
LINE (XB% - 2, YB% + 30)-(XB% - 2, YB% + 30), 0
LINE (XB% - 7, YB% + 35)-(XB% - 7, YB% + 39), 0
LINE (XB% - 6, YB% + 40)-(XB% - 5, YB% + 40), 0
LINE (XB% - 5, YB% + 40)-(XB% - 5, YB% + 36), 0
LINE (XB% - 5, YB% + 36)-(XB% - 4, YB% + 36), 0
LINE (XB% + 2, YB% + 40)-(XB% + 5, YB% + 47.75), 0
LINE (XB% + 2, YB% + 48)-(XB% + 0, YB% + 45), 0
LINE (XB% + 1, YB% + 48)-(XB% + 5, YB% + 50), 0, BF
LINE (XB% - 6, YB% + 44)-(XB% - 8, YB% + 40), 0
LINE (XB% - 9, YB% + 40)-(XB% - 9, YB% + 44), 0
LINE (XB% - 9, YB% + 44)-(XB% - 7, YB% + 44), 0
PAINT (XB% - 8, YB% + 43), 0, 0
LINE (XB% - 8, YB% + 41)-(XB% - 3, YB% + 41), 0
LINE (XB% - 1, YB% + 44)-(XB% - 6, YB% + 44), 0
PSET (XB% + 2, YB% + 27), 9
PAINT (XB% + 2, YB% + 43), 4, 0
PAINT (XB%, YB% + 38), 1, 0
PAINT (XB% + 1, YB% + 31), 11, 0
PAINT (XB% + 5, YB% + 36), 11, 0
PAINT (XB% - 6, YB% + 36), 11, 0

END SUB

SUB ENEMY1PLAIN
CIRCLE (XB% - 1, YB% + 30), 4, 0
LINE (XB% - 3, YB% + 33)-(XB% + 2, YB% + 40), 0, B
LINE (XB% - 6, YB% + 34)-(XB% + 5, YB% + 34), 0
LINE (XB% + 6, YB% + 35)-(XB% + 6, YB% + 39), 0
LINE (XB% + 4, YB% + 40)-(XB% + 5, YB% + 40), 0
LINE (XB% + 4, YB% + 39)-(XB% + 4, YB% + 36), 0
LINE (XB% + 3, YB% + 36)-(XB% + 3, YB% + 36), 0
LINE (XB% - 2, YB% + 30)-(XB% - 2, YB% + 30), 0
LINE (XB%, YB% + 30)-(XB%, YB% + 30), 0
LINE (XB% - 2, YB% + 27)-(XB% + 2, YB% + 27), 0
LINE (XB% - 7, YB% + 35)-(XB% - 7, YB% + 39), 0
LINE (XB% - 6, YB% + 40)-(XB% - 5, YB% + 40), 0
LINE (XB% - 5, YB% + 40)-(XB% - 5, YB% + 36), 0
LINE (XB% - 5, YB% + 36)-(XB% - 4, YB% + 36), 0
LINE (XB% + 2, YB% + 40)-(XB% + 5, YB% + 48), 0
LINE (XB% - 3, YB% + 40)-(XB% - 6, YB% + 47.75), 0
LINE (XB% + 5, YB% + 48)-(XB% + 2, YB% + 48), 0
LINE (XB% - 6, YB% + 48)-(XB% - 6, YB% + 48), 3
LINE (XB% - 5, YB% + 48)-(XB% - 2, YB% + 48), 0
LINE (XB% - 3, YB% + 48)-(XB% - 1, YB% + 45), 0
LINE (XB% + 2, YB% + 48)-(XB%, YB% + 44), 0
LINE (XB% + 2, YB% + 48)-(XB% + 6, YB% + 50), 0, BF
LINE (XB% - 2, YB% + 48)-(XB% - 6, YB% + 50), 0, BF
LINE (XB% + 2, YB% + 27)-(XB% + 2, YB% + 27), 9
PAINT (XB% - 4, YB% + 47), 4, 0
PAINT (XB%, YB% + 38), 1, 0
PAINT (XB% + 1, YB% + 31), 11, 0
PAINT (XB% + 5, YB% + 36), 11, 0
PAINT (XB% - 6, YB% + 36), 11, 0

END SUB

SUB ENEMY2KICK
FOR E = 1 TO 46
CIRCLE (XB% - 1, YB% + 30), 4, E
LINE (XB% - 3, YB% + 33)-(XB% + 2, YB% + 40), E, B
LINE (XB% - 6, YB% + 34)-(XB% + 5, YB% + 34), E
LINE (XB% + 6, YB% + 35)-(XB% + 6, YB% + 39), E
LINE (XB% + 4, YB% + 40)-(XB% + 5, YB% + 40), E
LINE (XB% + 4, YB% + 39)-(XB% + 4, YB% + 36), E
LINE (XB% + 3, YB% + 36)-(XB% + 3, YB% + 36), E
LINE (XB%, YB% + 30)-(XB%, YB% + 30), 0
LINE (XB% - 2, YB% + 30)-(XB% - 2, YB% + 30), E
LINE (XB% - 7, YB% + 35)-(XB% - 7, YB% + 39), E
LINE (XB% - 6, YB% + 40)-(XB% - 5, YB% + 40), E
LINE (XB% - 5, YB% + 40)-(XB% - 5, YB% + 36), E
LINE (XB% - 5, YB% + 36)-(XB% - 4, YB% + 36), E
LINE (XB% + 2, YB% + 40)-(XB% + 5, YB% + 47.75), E
LINE (XB% + 2, YB% + 48)-(XB% + 0, YB% + 45), E
LINE (XB% + 1, YB% + 48)-(XB% + 5, YB% + 50), E, BF
LINE (XB% - 6, YB% + 44)-(XB% - 8, YB% + 40), E
LINE (XB% - 9, YB% + 40)-(XB% - 9, YB% + 44), E
LINE (XB% - 9, YB% + 44)-(XB% - 7, YB% + 44), E
PAINT (XB% - 8, YB% + 43), E, E
LINE (XB% - 8, YB% + 41)-(XB% - 3, YB% + 41), E
LINE (XB% - 1, YB% + 44)-(XB% - 6, YB% + 44), E
PSET (XB% + 2, YB% + 27), E
PAINT (XB% + 2, YB% + 43), E, E
PAINT (XB%, YB% + 38), E, E
PAINT (XB% + 1, YB% + 31), E, E
PAINT (XB% + 5, YB% + 36), E, E
PAINT (XB% - 6, YB% + 36), E, E
NEXT E
END SUB

SUB ENEMY2PLAIN
FOR E = 1 TO 46
CIRCLE (XB% - 1, YB% + 30), 4, E
LINE (XB% - 3, YB% + 33)-(XB% + 2, YB% + 40), E, B
LINE (XB% - 6, YB% + 34)-(XB% + 5, YB% + 34), E
LINE (XB% + 6, YB% + 35)-(XB% + 6, YB% + 39), E
LINE (XB% + 4, YB% + 40)-(XB% + 5, YB% + 40), E
LINE (XB% + 4, YB% + 39)-(XB% + 4, YB% + 36), E
LINE (XB% + 3, YB% + 36)-(XB% + 3, YB% + 36), E
LINE (XB% - 2, YB% + 30)-(XB% - 2, YB% + 30), E
LINE (XB%, YB% + 30)-(XB%, YB% + 30), 0
LINE (XB% - 2, YB% + 27)-(XB% + 2, YB% + 27), E
LINE (XB% - 7, YB% + 35)-(XB% - 7, YB% + 39), E
LINE (XB% - 6, YB% + 40)-(XB% - 5, YB% + 40), E
LINE (XB% - 5, YB% + 40)-(XB% - 5, YB% + 36), E
LINE (XB% - 5, YB% + 36)-(XB% - 4, YB% + 36), E
LINE (XB% + 2, YB% + 40)-(XB% + 5, YB% + 48), E
LINE (XB% - 3, YB% + 40)-(XB% - 6, YB% + 47.75), E
LINE (XB% + 5, YB% + 48)-(XB% + 2, YB% + 48), E
LINE (XB% - 6, YB% + 48)-(XB% - 6, YB% + 48), E
LINE (XB% - 5, YB% + 48)-(XB% - 2, YB% + 48), E
LINE (XB% - 3, YB% + 48)-(XB% - 1, YB% + 45), E
LINE (XB% + 2, YB% + 48)-(XB%, YB% + 44), E
LINE (XB% + 2, YB% + 48)-(XB% + 6, YB% + 50), E, BF
LINE (XB% - 2, YB% + 48)-(XB% - 6, YB% + 50), E, BF
LINE (XB% + 2, YB% + 27)-(XB% + 2, YB% + 27), E
PAINT (XB% - 4, YB% + 47), E, E
PAINT (XB%, YB% + 38), E, E
PAINT (XB% + 1, YB% + 31), E, E
PAINT (XB% + 5, YB% + 36), E, E
PAINT (XB% - 6, YB% + 36), E, E
NEXT E

END SUB

SUB ENEMYACTION
IF XA% < XB% - 35 THEN ENEMYMOVE
IF XA% > XB% - 35 THEN ENEMYFIGHT
END SUB

SUB ENEMYFIGHT
RANDOMIZE TIMER
N = INT(RND * 3)
IF N = 1 THEN LINE (XB% - 10, YB% + 10)-(XB% + 10, YB% + 50), 9, BF:  ENEMY1KICK: DELAY 18000: LINE (XB% - 10, YB% + 10)-(XB% + 10, YB% + 50), 9, BF: ENEMY1PLAIN: IF XA% > XB% - 20 THEN ASCORE% = ASCORE% - 200: NOTE 15500, 5000
IF N = 2 THEN ENEMY1PLAIN
IF N = 3 THEN ENEMY1PLAIN
END SUB

SUB ENEMYMOVE
RANDOMIZE TIMER
NB = INT(RND * 3)
IF NB = 1 THEN LINE (XB% - 10, YB% + 10)-(XB% + 10, YB% + 50), 9, BF: XB% = XB% - 10: IF BL% = 8 OR BL% = 9 THEN ENEMY2PLAIN: ENEMY1PLAIN
IF NB = 2 OR NB = 3 THEN ENEMY1PLAIN
END SUB

SUB FIGHTSET1
CLS
XA% = 30
YA% = 88
XB% = 250
YB% = 88
R% = 1
ASCORE% = 5000
BSCORE% = 5000
IF BL% = 0 THEN CLS : LOCATE 15, 15: COLOR 12: PRINT "FIGHT ONE": SLEEP 2: CLS
IF BL% = 4 THEN CLS : LOCATE 15, 13: COLOR 12: PRINT "FIGHT THREE": SLEEP 2: CLS
IF BL% = 8 THEN CLS : LOCATE 15, 16: COLOR 12: PRINT "FIGHT FIVE": LOCATE 17, 5: PRINT "The Final Match: against the Shogun": SONG1: SLEEP 2: CLS
DO
SCOREA
SCOREB
BACKGROUND1
IF CHRPICK% = 1 THEN GUY1PLAIN
IF CHRPICK% = 2 THEN GUY2PLAIN
IF BL% = 0 OR BL% = 1 OR BL% = 2 OR BL% = 3 OR BL% = 4 OR BL% = 5 OR BL% = 6 OR BL% = 7 THEN ENEMY1PLAIN
IF BL% = 8 THEN ENEMY2PLAIN
ENEMYACTION
IF BL% = 2 OR BL% = 6 THEN AL% = 0: FIGHTSET2
SELECT CASE INKEY$
CASE IS = "6"
LINE (XA% - 10, YA% + 10)-(XA% + 10, YA% + 50), 9, BF
XA% = XA% + 5
IF XA% > XB% - 15 THEN XA% = XA% - 5
CASE IS = "4"
LINE (XA% - 10, YA% + 10)-(XA% + 10, YA% + 50), 9, BF
XA% = XA% - 5
CASE IS = "8"
LINE (XA% - 10, YA% + 10)-(XA% + 10, YA% + 50), 9, BF
YA% = YA% - 20
IF CHRPICK% = 1 THEN GUY1PLAIN
IF CHRPICK% = 2 THEN GUY2PLAIN
DELAY 30000
LINE (XA% - 10, YA% + 10)-(XA% + 10, YA% + 50), 9, BF
YA% = YA% + 20
CASE IS = "3"
LINE (XA% - 10, YA% + 10)-(XA% + 10, YA% + 50), 9, BF
IF CHRPICK% = 1 THEN GUY1KICK
IF CHRPICK% = 2 THEN GUY2KICK
DELAY 18000
LINE (XA% - 10, YA% + 10)-(XA% + 10, YA% + 50), 9, BF
IF XA% > XB% - 20 THEN BSCORE% = BSCORE% - 200: NOTE 15500, 5000
CASE IS = "9"
LINE (XA% - 10, YA% + 10)-(XA% + 10, YA% + 50), 9, BF
IF CHRPICK% = 1 THEN GUY1PUNCH
IF CHRPICK% = 2 THEN GUY2PUNCH
DELAY 18000
LINE (XA% - 10, YA% + 10)-(XA% + 10, YA% + 50), 9, BF
IF XA% > XB% - 20 THEN BSCORE% = BSCORE% - 100: NOTE 15500, 5000
END SELECT
LOOP
END SUB

SUB FIGHTSET2
CLS
XA% = 30
YA% = 88
XB% = 250
YB% = 88
R% = 1
ASCORE% = 5000
BSCORE% = 5000
IF BL% = 2 THEN CLS : LOCATE 15, 15: COLOR 12: PRINT "FIGHT TWO": SLEEP 2: CLS
IF BL% = 6 THEN CLS : LOCATE 15, 13: COLOR 12: PRINT "FIGHT FOUR": SLEEP 2: CLS
DO
SCOREA
SCOREB
BACKGROUND2
IF CHRPICK% = 1 THEN GUY1PLAIN
IF CHRPICK% = 2 THEN GUY2PLAIN
ENEMY1PLAIN
ENEMYACTION
IF BL% = 0 OR BL% = 4 OR BL% = 8 THEN AL% = 0: FIGHTSET1
SELECT CASE INKEY$
CASE IS = "6"
LINE (XA% - 10, YA% + 10)-(XA% + 10, YA% + 50), 9, BF
XA% = XA% + 5
IF XA% > XB% - 15 THEN XA% = XA% - 5
CASE IS = "4"
LINE (XA% - 10, YA% + 10)-(XA% + 10, YA% + 50), 9, BF
XA% = XA% - 5
CASE IS = "8"
LINE (XA% - 10, YA% + 10)-(XA% + 10, YA% + 50), 9, BF
YA% = YA% - 10
IF CHRPICK% = 1 THEN GUY1PLAIN
IF CHRPICK% = 2 THEN GUY2PLAIN
DELAY 30000
LINE (XA% - 10, YA% + 10)-(XA% + 10, YA% + 50), 9, BF
YA% = YA% + 10
CASE IS = "3"
LINE (XA% - 10, YA% + 10)-(XA% + 10, YA% + 50), 9, BF
IF CHRPICK% = 1 THEN GUY1KICK
IF CHRPICK% = 2 THEN GUY2KICK
DELAY 18000
LINE (XA% - 10, YA% + 10)-(XA% + 10, YA% + 50), 9, BF
IF XA% > XB% - 20 THEN BSCORE% = BSCORE% - 200: NOTE 15500, 5000
CASE IS = "9"
LINE (XA% - 10, YA% + 10)-(XA% + 10, YA% + 50), 9, BF
IF CHRPICK% = 1 THEN GUY1PUNCH
IF CHRPICK% = 2 THEN GUY2PUNCH
DELAY 18000
LINE (XA% - 10, YA% + 10)-(XA% + 10, YA% + 50), 9, BF
IF XA% > XB% - 20 THEN BSCORE% = BSCORE% - 200: NOTE 15500, 5000
END SELECT
LOOP
END SUB

SUB FONT (fh%, fv%, letter$, col%)
SELECT CASE letter$
CASE IS = "A"
LINE (fh% - 3, fv%)-(fh%, fv% - 8), col%
LINE (fh% + 3, fv%)-(fh%, fv% - 8), col%
LINE (fh% - 1, fv% - 3)-(fh% + 1, fv% - 3), col%
CASE IS = "B"
LINE (fh% - 3, fv%)-(fh% - 3, fv% - 8), col%
LINE (fh% - 3, fv% - 4)-(fh% + 1, fv% - 4), col%
LINE (fh% - 3, fv%)-(fh% + 2, fv%), col%
LINE (fh% - 3, fv% - 8)-(fh% + 2, fv% - 8), col%
LINE (fh% + 2, fv% - 8)-(fh% + 1, fv% - 4), col%
LINE (fh% + 2, fv%)-(fh% + 1, fv% - 4), col%
CASE IS = "C"
LINE (fh% - 3, fv%)-(fh% - 3, fv% - 8), col%
LINE (fh% - 3, fv%)-(fh% + 2, fv%), col%
LINE (fh% - 3, fv% - 8)-(fh% + 2, fv% - 8), col%
CASE IS = "D"
LINE (fh% - 3, fv%)-(fh% - 3, fv% - 8), col%
LINE (fh% - 3, fv%)-(fh% + 1, fv%), col%
LINE (fh% - 3, fv% - 8)-(fh% + 1, fv% - 8), col%
LINE (fh% + 2, fv% - 1)-(fh% + 2, fv% - 7), col%
CASE IS = "E"
LINE (fh% - 3, fv%)-(fh% - 3, fv% - 8), col%
LINE (fh% - 3, fv% - 4)-(fh% + 1, fv% - 4), col%
LINE (fh% - 3, fv%)-(fh% + 2, fv%), col%
LINE (fh% - 3, fv% - 8)-(fh% + 2, fv% - 8), col%
CASE IS = "F"
LINE (fh% - 3, fv%)-(fh% - 3, fv% - 8), col%
LINE (fh% - 3, fv% - 4)-(fh% + 1, fv% - 4), col%
LINE (fh% - 3, fv% - 8)-(fh% + 2, fv% - 8), col%
CASE IS = "G"
LINE (fh% - 3, fv%)-(fh% - 3, fv% - 8), col%
LINE (fh% - 3, fv%)-(fh% + 2, fv%), col%
LINE (fh% - 3, fv% - 8)-(fh% + 2, fv% - 8), col%
LINE (fh% + 2, fv%)-(fh% + 2, fv% - 4), col%
LINE (fh% + 2, fv% - 4)-(fh%, fv% - 4), col%
CASE IS = "H"
LINE (fh% - 3, fv%)-(fh% - 3, fv% - 8), col%
LINE (fh% + 3, fv%)-(fh% + 3, fv% - 8), col%
LINE (fh% + 3, fv% - 4)-(fh% - 3, fv% - 4), col%
CASE IS = "I"
LINE (fh%, fv%)-(fh%, fv% - 8), col%
LINE (fh% - 1, fv%)-(fh% + 1, fv%), col%
LINE (fh% - 1, fv% - 8)-(fh% + 1, fv% - 8), col%
CASE IS = "J"
LINE (fh% + 1, fv%)-(fh% + 1, fv% - 8), col%
LINE (fh% - 3, fv%)-(fh% + 1, fv%), col%
LINE (fh% - 3, fv%)-(fh% - 3, fv% - 3), col%
LINE (fh% - 1, fv% - 8)-(fh% + 3, fv% - 8), col%
CASE IS = "K"
LINE (fh% - 3, fv%)-(fh% - 3, fv% - 8), col%
LINE (fh% - 3, fv% - 4)-(fh% + 2, fv%), col%
LINE (fh% - 3, fv% - 4)-(fh% + 2, fv% - 8), col%
CASE IS = "L"
LINE (fh% - 3, fv%)-(fh% - 3, fv% - 8), col%
LINE (fh% - 3, fv%)-(fh% + 2, fv%), col%
CASE IS = "M"
LINE (fh% - 3, fv%)-(fh% - 3, fv% - 8), col%
LINE (fh% + 3, fv%)-(fh% + 3, fv% - 8), col%
LINE (fh% + 3, fv% - 8)-(fh%, fv% - 5), col%
LINE (fh% - 3, fv% - 8)-(fh%, fv% - 5), col%
CASE IS = "N"
LINE (fh% - 3, fv%)-(fh% - 3, fv% - 8), col%
LINE (fh% + 3, fv%)-(fh% + 3, fv% - 8), col%
LINE (fh% - 3, fv% - 7)-(fh% + 3, fv% - 1), col%
CASE IS = "O"
LINE (fh% - 3, fv% - 1)-(fh% - 3, fv% - 7), col%
LINE (fh% - 2, fv%)-(fh% + 1, fv%), col%
LINE (fh% - 2, fv% - 8)-(fh% + 1, fv% - 8), col%
LINE (fh% + 2, fv% - 1)-(fh% + 2, fv% - 7), col%
CASE IS = "P"
LINE (fh% - 3, fv%)-(fh% - 3, fv% - 8), col%
LINE (fh% - 3, fv% - 4)-(fh% + 1, fv% - 4), col%
LINE (fh% - 3, fv% - 8)-(fh% + 2, fv% - 8), col%
LINE (fh% + 2, fv% - 8)-(fh% + 1, fv% - 4), col%
CASE IS = "Q"
LINE (fh% - 3, fv% - 1)-(fh% - 3, fv% - 7), col%
LINE (fh% - 2, fv%)-(fh% + 1, fv%), col%
LINE (fh% - 2, fv% - 8)-(fh% + 1, fv% - 8), col%
LINE (fh% + 2, fv% - 1)-(fh% + 2, fv% - 7), col%
LINE (fh%, fv% - 3)-(fh% + 3, fv%), col%
CASE IS = "R"
LINE (fh% - 3, fv%)-(fh% - 3, fv% - 8), col%
LINE (fh% - 3, fv% - 4)-(fh% + 1, fv% - 4), col%
LINE (fh% - 3, fv% - 8)-(fh% + 2, fv% - 8), col%
LINE (fh% + 2, fv% - 8)-(fh% + 1, fv% - 4), col%
LINE (fh% - 2, fv% - 4)-(fh% + 2, fv%), col%
CASE IS = "S"
LINE (fh% - 3, fv% - 4)-(fh% - 3, fv% - 8), col%
LINE (fh% - 3, fv% - 4)-(fh% + 1, fv% - 4), col%
LINE (fh% - 3, fv%)-(fh% + 2, fv%), col%
LINE (fh% - 3, fv% - 8)-(fh% + 2, fv% - 8), col%
LINE (fh% + 2, fv%)-(fh% + 1, fv% - 4), col%
CASE IS = "T"
LINE (fh%, fv%)-(fh%, fv% - 8), col%
LINE (fh% - 3, fv% - 8)-(fh% + 3, fv% - 8), col%
CASE IS = "U"
LINE (fh% - 3, fv% - 1)-(fh% - 3, fv% - 8), col%
LINE (fh% - 2, fv%)-(fh% + 1, fv%), col%
LINE (fh% + 2, fv% - 1)-(fh% + 2, fv% - 8), col%
CASE IS = "V"
LINE (fh%, fv%)-(fh% - 3, fv% - 8), col%
LINE (fh%, fv% - 1)-(fh% + 3, fv% - 8), col%
CASE IS = "W"
LINE (fh% + 3, fv%)-(fh% + 3, fv% - 8), col%
LINE (fh% + 3, fv%)-(fh%, fv% - 5), col%
LINE (fh% - 3, fv%)-(fh%, fv% - 5), col%
LINE (fh% - 3, fv%)-(fh% - 3, fv% - 8), col%
CASE IS = "X"
LINE (fh% + 3, fv%)-(fh% - 3, fv% - 8), col%
LINE (fh% - 3, fv%)-(fh% + 3, fv% - 8), col%
PSET (fh% + 1, fv% - 4), col%
CASE IS = "Y"
LINE (fh%, fv% - 5)-(fh% - 3, fv% - 8), col%
LINE (fh%, fv% - 5)-(fh% + 3, fv% - 8), col%
LINE (fh%, fv% - 5)-(fh%, fv%), col%
CASE IS = "Z"
LINE (fh% - 3, fv%)-(fh% + 3, fv% - 8), col%
LINE (fh% - 3, fv%)-(fh% + 3, fv%), col%
LINE (fh% - 3, fv% - 8)-(fh% + 3, fv% - 8), col%
END SELECT

END SUB

SUB GUY1ENDING
CLS
FOR V = 1 TO 46
CIRCLE (XA% - 1, YA% + 60), 8, V
LINE (XA% - 6, YA% + 66)-(XA% + 4, YA% + 80), V, B
LINE (XA% - 14, YA% + 68)-(XA% + 12, YA% + 68), V
LINE (XA% + 12, YA% + 68)-(XA% + 12, YA% + 80), V
LINE (XA% + 8, YA% + 80)-(XA% + 12, YA% + 80), V
LINE (XA% + 8, YA% + 80)-(XA% + 8, YA% + 72), V
LINE (XA% + 4, YA% + 72)-(XA% + 8, YA% + 72), V
LINE (XA%, YA% + 60)-(XA%, YA% + 60), 0
LINE (XA% + 4, YA% + 60)-(XA% + 4, YA% + 60), V
LINE (XA% - 4, YA% + 54)-(XA% + 4, YA% + 54), V
LINE (XA% - 14, YA% + 68)-(XA% - 14, YA% + 80), V
LINE (XA% - 13, YA% + 80)-(XA% - 10, YA% + 80), V
LINE (XA% - 10, YA% + 80)-(XA% - 10, YA% + 72), V
LINE (XA% - 10, YA% + 72)-(XA% - 6, YA% + 72), V
LINE (XA% + 4, YA% + 80)-(XA% + 10, YA% + 96), V
LINE (XA% - 6, YA% + 80)-(XA% - 12, YA% + 95), V
LINE (XA% + 10, YA% + 96)-(XA% + 4, YA% + 96), V
LINE (XA% - 12, YA% + 96)-(XA% - 12, YA% + 96), V
LINE (XA% - 10, YA% + 96)-(XA% - 4, YA% + 96), V
LINE (XA% - 6, YA% + 96)-(XA% - 1, YA% + 88), V
LINE (XA% + 4, YA% + 96)-(XA%, YA% + 88), V
LINE (XA% + 4, YA% + 96)-(XA% + 12, YA% + 100), V, BF
LINE (XA% - 4, YA% + 96)-(XA% - 12, YA% + 100), V, BF
PAINT (XA% + 6, YA% + 94), V, V
PAINT (XA%, YA% + 76), V, V
PAINT (XA% + 2, YA% + 62), V, V
PAINT (XA% + 10, YA% + 72), V, V
PAINT (XA% - 12, YA% + 72), V, V
DELAY 15000
NEXT V
SLEEP 2
COLOR 39
LOCATE 2, 8
PRINT "TO REACH THE FINAL LEVEL,"
LOCATE 3, 1
PRINT "YOUR MIND, BODY, AND SOUL MUST BE ONE"
SLEEP 2
COLOR 0
LOCATE 2, 1
PRINT "                                      "
LOCATE 3, 1
PRINT "                                      "
COLOR 39
LOCATE 2, 1
PRINT "IT'S A SACRIFICE, IT TAKES HARD WORK,"
SLEEP 2
LOCATE 2, 1
COLOR 0
PRINT "                                      "
COLOR 39
LOCATE 2, 6
PRINT "IT'S A WAY OF LIIIIIIIIIIIIIFE"
SLEEP 2
LOCATE 23, 6
PRINT "YOU HAVE ACCOMPLISHED THIS "
LOCATE 24, 12
PRINT NA$; "-DIESEL"
SLEEP 5
CLS
FOR Y% = 1 TO 46
FONT 130, 70, "Y", Y%
FONT 140, 70, "O", Y%
FONT 150, 70, "U", Y%
FONT 160, 70, "V", Y%
FONT 170, 70, "E", Y%
FONT 120, 100, "G", Y%
FONT 130, 100, "O", Y%
FONT 140, 100, "T", Y%
FONT 160, 100, "T", Y%
FONT 170, 100, "H", Y%
FONT 180, 100, "E", Y%
FONT 140, 140, "G", Y%
FONT 150, 140, "L", Y%
FONT 160, 140, "O", Y%
FONT 170, 140, "W", Y%
DELAY 30000
NEXT Y%
SLEEP 1
COLOR 1
LOCATE 24, 11
PRINT "1996 Steele Software"
SLEEP 10
END
END SUB

SUB GUY1KICK
CIRCLE (XA%, YA% + 30), 4, 0
LINE (XA% - 3, YA% + 33)-(XA% + 2, YA% + 40), 0, B
LINE (XA% - 6, YA% + 34)-(XA% + 5, YA% + 34), 0
LINE (XA% + 6, YA% + 35)-(XA% + 6, YA% + 39), 0
LINE (XA% + 4, YA% + 40)-(XA% + 5, YA% + 40), 0
LINE (XA% + 4, YA% + 39)-(XA% + 4, YA% + 36), 0
LINE (XA% + 3, YA% + 36)-(XA% + 3, YA% + 36), 0
LINE (XA%, YA% + 30)-(XA%, YA% + 30), 0
LINE (XA% + 2, YA% + 30)-(XA% + 2, YA% + 30), 0
LINE (XA% - 2, YA% + 27)-(XA% + 2, YA% + 27), 0
LINE (XA% - 7, YA% + 35)-(XA% - 7, YA% + 39), 0
LINE (XA% - 6, YA% + 40)-(XA% - 5, YA% + 40), 0
LINE (XA% - 5, YA% + 40)-(XA% - 5, YA% + 36), 0
LINE (XA% - 5, YA% + 36)-(XA% - 4, YA% + 36), 0
LINE (XA% - 3, YA% + 40)-(XA% - 6, YA% + 47.75), 0
LINE (XA% - 3, YA% + 48)-(XA% - 1, YA% + 45), 0
LINE (XA%, YA% + 44)-(XA%, YA% + 44), 0
LINE (XA% - 2, YA% + 48)-(XA% - 6, YA% + 50), 0, BF
LINE (XA% + 5, YA% + 44)-(XA% + 7, YA% + 40), 0
LINE (XA% + 7, YA% + 40)-(XA% + 9, YA% + 40), 0
LINE (XA% + 9, YA% + 40)-(XA% + 8, YA% + 44), 0
LINE (XA% + 8, YA% + 44)-(XA% + 6, YA% + 44), 0
PAINT (XA% + 7, YA% + 43), 0, 0
LINE (XA% + 7, YA% + 41)-(XA% + 2, YA% + 41), 0
LINE (XA%, YA% + 44)-(XA% + 5, YA% + 44), 0
PAINT (XA% + 3, YA% + 43), 1, 0
PAINT (XA%, YA% + 38), 2, 0
PAINT (XA% + 1, YA% + 31), 11, 0
PAINT (XA% + 5, YA% + 36), 11, 0
PAINT (XA% - 6, YA% + 36), 11, 0

END SUB

SUB GUY1PLAIN
CIRCLE (XA%, YA% + 30), 4, 0
LINE (XA% - 3, YA% + 33)-(XA% + 2, YA% + 40), 0, B
LINE (XA% - 6, YA% + 34)-(XA% + 5, YA% + 34), 0
LINE (XA% + 6, YA% + 35)-(XA% + 6, YA% + 39), 0
LINE (XA% + 4, YA% + 40)-(XA% + 5, YA% + 40), 0
LINE (XA% + 4, YA% + 39)-(XA% + 4, YA% + 36), 0
LINE (XA% + 3, YA% + 36)-(XA% + 3, YA% + 36), 0
LINE (XA%, YA% + 30)-(XA%, YA% + 30), 0
LINE (XA% + 2, YA% + 30)-(XA% + 2, YA% + 30), 0
LINE (XA% - 2, YA% + 27)-(XA% + 2, YA% + 27), 0
LINE (XA% - 7, YA% + 35)-(XA% - 7, YA% + 39), 0
LINE (XA% - 6, YA% + 40)-(XA% - 5, YA% + 40), 0
LINE (XA% - 5, YA% + 40)-(XA% - 5, YA% + 36), 0
LINE (XA% - 5, YA% + 36)-(XA% - 4, YA% + 36), 0
LINE (XA% + 2, YA% + 40)-(XA% + 5, YA% + 48), 0
LINE (XA% - 3, YA% + 40)-(XA% - 6, YA% + 47.75), 0
LINE (XA% + 5, YA% + 48)-(XA% + 2, YA% + 48), 0
LINE (XA% - 6, YA% + 48)-(XA% - 6, YA% + 48), 3
LINE (XA% - 5, YA% + 48)-(XA% - 2, YA% + 48), 0
LINE (XA% - 3, YA% + 48)-(XA% - 1, YA% + 45), 0
LINE (XA% + 2, YA% + 48)-(XA%, YA% + 44), 0
LINE (XA% + 2, YA% + 48)-(XA% + 6, YA% + 50), 0, BF
LINE (XA% - 2, YA% + 48)-(XA% - 6, YA% + 50), 0, BF
PAINT (XA% + 3, YA% + 47), 1, 0
PAINT (XA%, YA% + 38), 2, 0
PAINT (XA% + 1, YA% + 31), 11, 0
PAINT (XA% + 5, YA% + 36), 11, 0
PAINT (XA% - 6, YA% + 36), 11, 0

END SUB

SUB GUY1PUNCH
CIRCLE (XA%, YA% + 30), 4, 0
LINE (XA% - 3, YA% + 33)-(XA% + 2, YA% + 40), 0, B
LINE (XA% - 6, YA% + 34)-(XA% + 10, YA% + 34), 0
LINE (XA% + 11, YA% + 35)-(XA% + 11, YA% + 36), 0
LINE (XA% + 2, YA% + 36)-(XA% + 10, YA% + 36), 0   '13
LINE (XA% + 3, YA% + 35)-(XA% + 10, YA% + 35), 15
LINE (XA%, YA% + 30)-(XA%, YA% + 30), 0
LINE (XA% + 2, YA% + 30)-(XA% + 2, YA% + 30), 0
LINE (XA% - 2, YA% + 27)-(XA% + 2, YA% + 27), 0
LINE (XA% - 7, YA% + 35)-(XA% - 7, YA% + 39), 0
LINE (XA% - 6, YA% + 40)-(XA% - 5, YA% + 40), 0
LINE (XA% - 5, YA% + 40)-(XA% - 5, YA% + 36), 0
LINE (XA% - 5, YA% + 36)-(XA% - 4, YA% + 36), 0
LINE (XA% + 2, YA% + 40)-(XA% + 5, YA% + 48), 0
LINE (XA% - 3, YA% + 40)-(XA% - 6, YA% + 47.75), 0
LINE (XA% + 5, YA% + 48)-(XA% + 2, YA% + 48), 0
LINE (XA% - 6, YA% + 48)-(XA% - 6, YA% + 48), 3
LINE (XA% - 5, YA% + 48)-(XA% - 2, YA% + 48), 0
LINE (XA% - 3, YA% + 48)-(XA% - 1, YA% + 45), 0
LINE (XA% + 2, YA% + 48)-(XA%, YA% + 44), 0
LINE (XA% + 2, YA% + 48)-(XA% + 6, YA% + 50), 0, BF
LINE (XA% - 2, YA% + 48)-(XA% - 6, YA% + 50), 0, BF
PAINT (XA% + 3, YA% + 47), 1, 0
PAINT (XA%, YA% + 38), 2, 0
PAINT (XA% + 1, YA% + 31), 11, 0
PAINT (XA% + 5, YA% + 36), 11, 0
PAINT (XA% - 6, YA% + 36), 11, 0

END SUB

SUB GUY2ENDING
CLS
FOR V = 1 TO 47
CIRCLE (XA% - 1, YA% + 60), 8, V
LINE (XA% - 6, YA% + 66)-(XA% + 4, YA% + 80), V, B
LINE (XA% - 14, YA% + 68)-(XA% + 12, YA% + 68), V
LINE (XA% + 12, YA% + 68)-(XA% + 12, YA% + 80), V
LINE (XA% + 8, YA% + 80)-(XA% + 12, YA% + 80), V
LINE (XA% + 8, YA% + 80)-(XA% + 8, YA% + 72), V
LINE (XA% + 4, YA% + 72)-(XA% + 8, YA% + 72), V
LINE (XA%, YA% + 60)-(XA%, YA% + 60), 0
LINE (XA% + 4, YA% + 60)-(XA% + 4, YA% + 60), V
LINE (XA% - 4, YA% + 54)-(XA% + 4, YA% + 54), V
LINE (XA% - 14, YA% + 68)-(XA% - 14, YA% + 80), V
LINE (XA% - 13, YA% + 80)-(XA% - 10, YA% + 80), V
LINE (XA% - 10, YA% + 80)-(XA% - 10, YA% + 72), V
LINE (XA% - 10, YA% + 72)-(XA% - 6, YA% + 72), V
LINE (XA% + 4, YA% + 80)-(XA% + 10, YA% + 96), V
LINE (XA% - 6, YA% + 80)-(XA% - 12, YA% + 95), V
LINE (XA% + 10, YA% + 96)-(XA% + 4, YA% + 96), V
LINE (XA% - 12, YA% + 96)-(XA% - 12, YA% + 96), V
LINE (XA% - 10, YA% + 96)-(XA% - 4, YA% + 96), V
LINE (XA% - 6, YA% + 96)-(XA% - 1, YA% + 88), V
LINE (XA% + 4, YA% + 96)-(XA%, YA% + 88), V
LINE (XA% + 4, YA% + 96)-(XA% + 12, YA% + 100), V, BF
LINE (XA% - 4, YA% + 96)-(XA% - 12, YA% + 100), V, BF
PAINT (XA% + 6, YA% + 94), V, V
PAINT (XA%, YA% + 76), V, V
PAINT (XA% + 2, YA% + 62), V, V
PAINT (XA% + 10, YA% + 72), V, V
PAINT (XA% - 12, YA% + 72), V, V
DELAY 15000
NEXT V
SLEEP 2
COLOR 38
LOCATE 2, 8
PRINT "TO REACH THE FINAL LEVEL,"
LOCATE 3, 1
PRINT "YOUR MIND, BODY, AND SOUL MUST BE ONE"
SLEEP 2
COLOR 0
LOCATE 2, 1
PRINT "                                      "
LOCATE 3, 1
PRINT "                                      "
COLOR 38
LOCATE 2, 1
PRINT "IT'S A SACRIFICE, IT TAKES HARD WORK,"
SLEEP 2
LOCATE 2, 1
COLOR 0
PRINT "                                      "
COLOR 38
LOCATE 2, 6
PRINT "IT'S A WAY OF LIIIIIIIIIIIIIFE"
SLEEP 2
LOCATE 23, 11
PRINT "YOU HAVE ACCOMPLISHED THIS "
LOCATE 24, 9
PRINT NA$; "- THE NINJA KID"
SLEEP 5
CLS
FOR Y% = 1 TO 46
FONT 130, 70, "Y", Y%
FONT 140, 70, "O", Y%
FONT 150, 70, "U", Y%
FONT 160, 70, "V", Y%
FONT 170, 70, "E", Y%
FONT 120, 100, "G", Y%
FONT 130, 100, "O", Y%
FONT 140, 100, "T", Y%
FONT 160, 100, "T", Y%
FONT 170, 100, "H", Y%
FONT 180, 100, "E", Y%
FONT 140, 140, "G", Y%
FONT 150, 140, "L", Y%
FONT 160, 140, "O", Y%
FONT 170, 140, "W", Y%
DELAY 30000
NEXT Y%
SLEEP 1
COLOR 1
LOCATE 24, 11
PRINT "1996 Steele Software"
SLEEP 10
END
END SUB

SUB GUY2KICK
CIRCLE (XA%, YA% + 30), 4, 0
LINE (XA% - 3, YA% + 33)-(XA% + 2, YA% + 40), 0, B
LINE (XA% - 6, YA% + 34)-(XA% + 5, YA% + 34), 0
LINE (XA% + 6, YA% + 35)-(XA% + 6, YA% + 39), 0
LINE (XA% + 4, YA% + 40)-(XA% + 5, YA% + 40), 0
LINE (XA% + 4, YA% + 39)-(XA% + 4, YA% + 36), 0
LINE (XA% + 3, YA% + 36)-(XA% + 3, YA% + 36), 0
LINE (XA%, YA% + 30)-(XA%, YA% + 30), 0
LINE (XA% + 2, YA% + 30)-(XA% + 2, YA% + 30), 0
LINE (XA% - 2, YA% + 27)-(XA% + 2, YA% + 27), 0
LINE (XA% - 7, YA% + 35)-(XA% - 7, YA% + 39), 0
LINE (XA% - 6, YA% + 40)-(XA% - 5, YA% + 40), 0
LINE (XA% - 5, YA% + 40)-(XA% - 5, YA% + 36), 0
LINE (XA% - 5, YA% + 36)-(XA% - 4, YA% + 36), 0
LINE (XA% - 3, YA% + 40)-(XA% - 6, YA% + 47.75), 0
LINE (XA% - 3, YA% + 48)-(XA% - 1, YA% + 45), 0
LINE (XA%, YA% + 44)-(XA%, YA% + 44), 0
LINE (XA% - 2, YA% + 48)-(XA% - 6, YA% + 50), 0, BF
LINE (XA% + 5, YA% + 44)-(XA% + 7, YA% + 40), 0
LINE (XA% + 7, YA% + 40)-(XA% + 9, YA% + 40), 0
LINE (XA% + 9, YA% + 40)-(XA% + 8, YA% + 44), 0
LINE (XA% + 8, YA% + 44)-(XA% + 6, YA% + 44), 0
PAINT (XA% + 7, YA% + 43), 0, 0
LINE (XA% + 7, YA% + 41)-(XA% + 2, YA% + 41), 0
LINE (XA%, YA% + 44)-(XA% + 5, YA% + 44), 0
LINE (XA% - 3, YA% + 38)-(XA% + 2, YA% + 37), 0, BF
PAINT (XA%, YA% + 36), 15, 0
PAINT (XA%, YA% + 39), 15, 0
PAINT (XA%, YA% + 43), 15, 0
PAINT (XA% + 5, YA% + 36), 65, 0
PAINT (XA% - 6, YA% + 36), 65, 0
PAINT (XA%, YA% + 31), 65, 0
END SUB

SUB GUY2PLAIN
CIRCLE (XA%, YA% + 30), 4, 0
LINE (XA% - 3, YA% + 33)-(XA% + 2, YA% + 40), 0, B
LINE (XA% - 6, YA% + 34)-(XA% + 5, YA% + 34), 0
LINE (XA% + 6, YA% + 35)-(XA% + 6, YA% + 39), 0
LINE (XA% + 4, YA% + 40)-(XA% + 5, YA% + 40), 0
LINE (XA% + 4, YA% + 39)-(XA% + 4, YA% + 36), 0
LINE (XA% + 3, YA% + 36)-(XA% + 3, YA% + 36), 0
LINE (XA%, YA% + 30)-(XA%, YA% + 30), 0
LINE (XA% + 2, YA% + 30)-(XA% + 2, YA% + 30), 0
LINE (XA% - 2, YA% + 27)-(XA% + 2, YA% + 27), 0
LINE (XA% - 7, YA% + 35)-(XA% - 7, YA% + 39), 0
LINE (XA% - 6, YA% + 40)-(XA% - 5, YA% + 40), 0
LINE (XA% - 5, YA% + 40)-(XA% - 5, YA% + 36), 0
LINE (XA% - 5, YA% + 36)-(XA% - 4, YA% + 36), 0
LINE (XA% + 2, YA% + 40)-(XA% + 5, YA% + 48), 0
LINE (XA% - 3, YA% + 40)-(XA% - 6, YA% + 47.75), 0
LINE (XA% + 5, YA% + 48)-(XA% + 2, YA% + 48), 0
LINE (XA% - 6, YA% + 48)-(XA% - 6, YA% + 48), 3
LINE (XA% - 5, YA% + 48)-(XA% - 2, YA% + 48), 0
LINE (XA% - 3, YA% + 48)-(XA% - 1, YA% + 45), 0
LINE (XA% + 2, YA% + 48)-(XA%, YA% + 44), 0
LINE (XA% + 2, YA% + 48)-(XA% + 6, YA% + 50), 0, BF
LINE (XA% - 2, YA% + 48)-(XA% - 6, YA% + 50), 0, BF
LINE (XA% - 3, YA% + 38)-(XA% + 2, YA% + 37), 0, BF
PAINT (XA% + 3, YA% + 47), 15, 0
PAINT (XA% + 1, YA% + 39), 15, 0
PAINT (XA% + 1, YA% + 35), 15, 0
PAINT (XA% + 5, YA% + 36), 65, 0
PAINT (XA% - 6, YA% + 36), 65, 0
PAINT (XA%, YA% + 31), 65, 0
END SUB

SUB GUY2PUNCH
CIRCLE (XA%, YA% + 30), 4, 0
LINE (XA% - 3, YA% + 33)-(XA% + 2, YA% + 40), 0, B
LINE (XA% - 6, YA% + 34)-(XA% + 10, YA% + 34), 0
LINE (XA% + 11, YA% + 35)-(XA% + 11, YA% + 36), 0
LINE (XA% + 2, YA% + 36)-(XA% + 10, YA% + 36), 0   '13
LINE (XA% + 3, YA% + 35)-(XA% + 10, YA% + 35), 15
LINE (XA%, YA% + 30)-(XA%, YA% + 30), 0
LINE (XA% + 2, YA% + 30)-(XA% + 2, YA% + 30), 0
LINE (XA% - 2, YA% + 27)-(XA% + 2, YA% + 27), 0
LINE (XA% - 7, YA% + 35)-(XA% - 7, YA% + 39), 0
LINE (XA% - 6, YA% + 40)-(XA% - 5, YA% + 40), 0
LINE (XA% - 5, YA% + 40)-(XA% - 5, YA% + 36), 0
LINE (XA% - 5, YA% + 36)-(XA% - 4, YA% + 36), 0
LINE (XA% + 2, YA% + 40)-(XA% + 5, YA% + 48), 0
LINE (XA% - 3, YA% + 40)-(XA% - 6, YA% + 47.75), 0
LINE (XA% + 5, YA% + 48)-(XA% + 2, YA% + 48), 0
LINE (XA% - 6, YA% + 48)-(XA% - 6, YA% + 48), 3
LINE (XA% - 5, YA% + 48)-(XA% - 2, YA% + 48), 0
LINE (XA% - 3, YA% + 48)-(XA% - 1, YA% + 45), 0
LINE (XA% + 2, YA% + 48)-(XA%, YA% + 44), 0
LINE (XA% + 2, YA% + 48)-(XA% + 6, YA% + 50), 0, BF
LINE (XA% - 2, YA% + 48)-(XA% - 6, YA% + 50), 0, BF
LINE (XA% - 3, YA% + 38)-(XA% + 2, YA% + 37), 0, BF
PAINT (XA% + 1, YA% + 39), 15, 0
PAINT (XA% + 1, YA% + 35), 15, 0
PAINT (XA% + 3, YA% + 47), 15, 0
PAINT (XA%, YA% + 38), 15, 0
PAINT (XA% + 1, YA% + 31), 65, 0
PAINT (XA% - 5, YA% + 36), 65, 0
PAINT (XA% - 6, YA% + 36), 65, 0
END SUB

SUB HELP
7 :
CLS
SCREEN 9
CLS
COLOR 4
LOCATE 2, 30
PRINT "DEATH TRAP"
LOCATE 3, 28
PRINT "(C) STEELE SOFTWARE"
COLOR 7
LOCATE 10, 1
PRINT "   Thanks for getting Steele Software's latest program- DEATH TRAP. It is a good"
PRINT "fighting game in which you fight against oppenents in a tournament in the  "
PRINT "Death Trap Arena. The controls are simple: use the numeric keypad to move,"
PRINT "punch, and kick. Make sure caps lock and num lock are on."
LOCATE 18, 1
COLOR 4
PRINT "                               (8) up      (9) punch"
PRINT ""
PRINT "                    (4) left               (6) right"
PRINT ""
PRINT "                              (2) down     (3) kick"
SLEEP 10
LOCATE 23, 5
INPUT "DO YOU WANT TO PRINT THESE INSTRUCTIONS?(YES/NO)", P$
IF P$ = "YES" THEN HELPPRINT
IF P$ = "NO" THEN MENU
IF P$ <> "YES" OR P$ <> "NO" THEN GOTO 7
MENU

END SUB

SUB HELPPRINT
CLS
COLOR 4
LOCATE 2, 30
LPRINT "DEATH TRAP"
LOCATE 3, 28
LPRINT "(C) STEELE SOFTWARE"
COLOR 7
LOCATE 10, 1
LPRINT "   Thanks for getting Steele Software's latest program- DEATH TRAP. It is a good"
LPRINT "fighting game in which you fight against oppenents in a tournament in the  "
LPRINT "Death Trap Arena. The controls are simple: use the numeric keypad to move,"
LPRINT "punch, and kick. Make sure caps lock and num lock are on."
LOCATE 18, 1
COLOR 4
LPRINT "                               (8) up      (9) punch"
LPRINT ""
LPRINT "                    (4) left               (6) right"
LPRINT ""
LPRINT "                              (2) down     (3) kick "
MENU

END SUB

SUB MENU
a = 8
B = 13
CLS
SCREEN 13
DO
COLOR 14
LOCATE 2, 15
PRINT "DEATH TRAP"
LOCATE 3, 12
PRINT "BY STEELE SOFTWARE 1996"
COLOR 4
LOCATE 8, 15
PRINT "PLAY DEATH TRAP"
LOCATE 9, 15
PRINT "INSTRUCTIONS"
LOCATE 10, 15
PRINT "VIEW CREDITS"
LOCATE 11, 15
PRINT "GO TO SOUNDTEST"
LOCATE 12, 15
PRINT "EXIT"
COLOR 15
LOCATE a, B
PRINT CHR$(1)
SELECT CASE INKEY$
CASE IS = "8"
COLOR 0
LOCATE a, B
PRINT " "
a = a - 1
IF a < 8 THEN a = a + 1
CASE IS = "2"
COLOR 0
LOCATE a, B
PRINT " "
a = a + 1
IF a > 12 THEN a = a - 1
CASE IS = CHR$(13)
GOTO 3
END SELECT
LOOP
3 :
IF a = 8 THEN GOTO 5
IF a = 9 THEN HELP
IF a = 10 THEN CREDITS
IF a = 12 THEN CLS : LOCATE 15, 13: COLOR 12: PRINT "GOODBYE   HERO": END
IF a = 11 THEN SNDTEST
5 : SETUP
END SUB

DEFINT A-Z
SUB NOTE (level%, legnth%)
SBPlay level%
FOR delay1% = 0 TO legnth% STEP 1: NEXT delay1%
FOR delay1% = 0 TO legnth% STEP 1: NEXT delay1%
CALL WriteReg(&HB0, &H0)
END SUB

DEFSNG A-Z
SUB PICK
CLS
SCREEN 13
LOCATE 2, 7
COLOR 12
PRINT "PICK YOUR CHARACTER, "; NA$; ":"
LINE (0, 40)-(320, 140), 8, BF
C% = 70
D% = 55
DO
LOCATE 16, 9
PRINT "DEISEL"
LOCATE 16, 26
PRINT "NINJA KID"
XA% = 90
YA% = 40
GUY1PLAIN
XA% = 235
YA% = 40
GUY2PLAIN
LINE (C%, D%)-(C% + 40, D% + 45), 0, B
SELECT CASE INKEY$
CASE IS = "6"
LINE (C%, D%)-(C% + 40, D% + 45), 8, B
C% = C% + 145
D% = D% + 0
IF C% > 215 THEN C% = C% - 145
DELAY 32677
NOTE 15500, 5000
CASE IS = "4"
LINE (C%, D%)-(C% + 40, D% + 45), 8, B
C% = C% - 145
D% = D% + 0
IF C% < 70 THEN C% = C% + 145
DELAY 32677
NOTE 15500, 5000
CASE IS = CHR$(13)
GOTO 6
END SELECT
LOOP
6 :
IF C% < 146 THEN CHRPICK% = 1
IF C% > 146 THEN CHRPICK% = 2
FIGHTSET1
END SUB

SUB PUNCHOFFLEDGE
XA% = 140
YA% = 30
XB% = 155
YB% = 30
CLS
SCREEN 13
LINE (0, 0)-(320, 200), 9, BF
LINE (0, 80)-(160, 80), 0
LINE (160, 80)-(160, 150), 0
LINE (160, 150)-(165, 140), 0
LINE (165, 140)-(165, 200), 0
LINE (70, 110)-(80, 90), 0
LINE (80, 90)-(90, 110), 0
LINE (20, 140)-(70, 140), 0
LINE (40, 140)-(45, 135), 0
LINE (45, 135)-(46, 137), 0
LINE (46, 137)-(49, 134), 0
LINE (49, 134)-(52, 140), 0
PAINT (30, 170), 8, 0
PAINT (48, 138), 6, 0
IF CHRPICK% = 1 THEN GUY1PLAIN: ENEMY2PLAIN: SLEEP 1: GUY1PUNCH
IF CHRPICK% = 2 THEN GUY2PLAIN: ENEMY2PLAIN: SLEEP 1: GUY2PUNCH
SLEEP 1: NOTE 15500, 5000
LINE (XB% - 10, YB% + 10)-(XB% + 10, YB% + 50), 9, BF: XB% = XB% + 30: ENEMY2PLAIN
SLEEP 1
'---------------------------------------------------------------------------
DO
LINE (XB% - 10, YB% + 10)-(XB% + 10, YB% + 50), 9, BF
YB% = YB% + 20
ENEMY2PLAIN
LOOP UNTIL YB% >= 200
'---------------------------------------------------------------
XB% = 160
YB% = 1
PAINT (1, 1), 8
PAINT (1, 1), 6
PAINT (1, 1), 8
PAINT (180, 100), 9, 0
LINE (80, 0)-(80, 200), 0
PAINT (10, 10), 8, 0
LINE (240, 0)-(240, 200), 0
PAINT (250, 10), 8, 0
DO
LINE (XB% - 10, YB% + 10)-(XB% + 10, YB% + 50), 9, BF
YB% = YB% + 20
ENEMY2PLAIN
LOOP UNTIL YB% >= 200
'-----------------------------------------------------------------
XB% = 160
YB% = 1
PAINT (180, 100), 9, 0
LINE (80, 0)-(80, 200), 0
PAINT (10, 10), 8, 0
LINE (240, 0)-(240, 200), 0
PAINT (250, 10), 8, 0
DO
LINE (XB% - 10, YB% + 10)-(XB% + 10, YB% + 50), 9, BF
YB% = YB% + 20
ENEMY2PLAIN
LOOP UNTIL YB% >= 200
'--------------------------------------------------------------------------
XB% = 160
YB% = 1
PAINT (1, 1), 8
PAINT (1, 1), 6
PAINT (1, 1), 8
PAINT (180, 100), 9, 0
LINE (80, 0)-(80, 170), 0
LINE (240, 0)-(240, 170), 0
LINE (80, 170)-(240, 170), 0
PAINT (10, 10), 8, 0
DO
LINE (XB% - 10, YB% + 10)-(XB% + 10, YB% + 50), 9, BF
YB% = YB% + 20
ENEMY2PLAIN
LOOP UNTIL YB% >= 110: NOTE 15500, 5000
XC% = 160
YC% = 0
ENEMY2PLAIN
CIRCLE (XC%, YC%), 30, 0
PAINT (XC% + 1, YC% + 1), 8, 0
DELAY 30000
DO
CIRCLE (XC%, YC%), 30, 9
PAINT (XC% + 1, YC% + 1), 9, 9
YC% = YC% + 20
CIRCLE (XC%, YC%), 30, 0
PAINT (XC% + 1, YC% - 10), 8, 0
DELAY 30000
IF YC% <= 120 THEN ENEMY2PLAIN
IF YC% >= 120 THEN ENEMY1PLAIN
IF YC% >= 135 THEN LINE (XB% - 10, YB% + 10)-(XB% + 10, YB% + 50), 9, BF
CIRCLE (XC%, YC%), 30, 0
PAINT (XC% + 1, YC% + 1), 8, 0
LOOP UNTIL YC% = 200: SONG1
CIRCLE (XC%, YC%), 30, 0
PAINT (XC% + 1, YC% - 10), 8, 0
SLEEP 2
FOR H = 1 TO 56
PAINT (1, 1), H
DELAY 10000
NEXT H
SLEEP 1
IF CHRPICK% = 1 THEN GUY1ENDING
IF CHRPICK% = 2 THEN GUY2ENDING
END
END SUB

DEFINT A-Z
SUB SBInit
   '  Initialize the sound card
                                                               
   '(This is the "quick-and-dirty" method; what it's doing is zeroing out

   '  all of the card's registers.  I haven't had any problems with this.)
   FOR q = 1 TO &HF5
     CALL WriteReg(q, 0)
   NEXT q
END SUB

SUB SBPlay (freq%)
'  Purpose:      Plays a note
'  Variables:    freq% - Frequency (00-FF hex)
'                duration% - Duration (n seconds) (not used)
'  I'm still working on this part, it may be ugly, but it works <g>.
'  The first group of WriteRegs is the modulator, the second is the
'  carrier.
'  If you just want to know how to create your own instrument, play around
'  with the second values in the first four calls to WriteReg in each group.
'  :-)  Have fun!  - Brett
                                                            
CALL WriteReg(&H20, &H7)    ' Set modulator's multiple to F
CALL WriteReg(&H40, &HF)    ' Set modulator's level to 40 dB
CALL WriteReg(&H60, &HF0)   ' Modulator attack: quick, decay: long

CALL WriteReg(&H80, &HF0)   ' Modulator sustain: medium, release: medium
CALL WriteReg(&HA0, freq%)
                                                            
                                                            
CALL WriteReg(&H23, &HF)   ' Set carrier's multiple to 0
CALL WriteReg(&H43, &H0)   ' Set carrier's level to 0 dB
CALL WriteReg(&H63, &HF0)  ' Carrier attack: quick, decay: long

CALL WriteReg(&H83, &HFF)  ' Carrier sustain: quick, release: quick
CALL WriteReg(&HB0, &H20)  ' Octave
                                                            
CALL WriteReg(&HE0, &H0)   ' Waveform argument for Tom..
                           ' &H00 is the default, but I felt like
                           ' dropping it in for you.. :)
                                                            
' I originally had an extra argument, duration!, but for some reason
' I wanted to do the timing outside of this sub..  You can change it back
' if needs require..
                                                            
'TimeUp! = TIMER + duation!
'WHILE TimeUp! > TIMER: WEND  ' Worst you can be off is .182 of a second

END SUB

DEFSNG A-Z
SUB SCOREA
IF ASCORE% <= 0 THEN AL% = AL% + 1: R% = R% + 1: ASCORE% = 5000: IF AL% = 2 THEN CLS : COLOR 12: LOCATE 10, 13: PRINT "YOU LOSE "; NA$: END
COLOR 12
LOCATE 22, 2
PRINT NA$; "- "
LOCATE 22, 16
PRINT ASCORE%
END SUB

SUB SCOREB
IF BSCORE% <= 0 THEN BL% = BL% + 1: R% = R% + 1: BSCORE% = 5000:  IF BL% = 10 THEN PUNCHOFFLEDGE
COLOR 12
LOCATE 23, 2
PRINT NB$; "- "
LOCATE 23, 16
PRINT BSCORE%
END SUB

SUB SETUP
CLS
SCREEN 9
COLOR 10
INPUT "WHAT IS YOUR NAME?(DEFAULT PLAYER1)", NA$
NA$ = UCASE$(NA$)
IF NA$ = "" THEN NA$ = "PLAYER1"
NB$ = "ENEMY"
SCREEN 13
PICK
END SUB

SUB SLECTFIGHT
IF BL% = 0 OR BL% = 1 OR BL% = 4 OR BL% = 5 OR BL% = 8 OR BL% = 9 THEN FIGHTSET1
IF BL% = 2 OR BL% = 3 OR BL% = 6 OR BL% = 7 THEN FIGHTSET2
END SUB

SUB SNDTEST
4 :
CLS
SCREEN 9
COLOR 10
LOCATE 5, 5
PRINT "1. SONG1 (STORY)"
LOCATE 6, 5
PRINT "2. SONG2 (OPENING)"
LOCATE 7, 5
PRINT "3. CREDITS SONG"
LOCATE 8, 5
PRINT "4. BEEP"
LOCATE 9, 5
PRINT "5. EXIT"
INPUT S$
IF S$ = "1" THEN SONG1
IF S$ = "2" THEN SONG2
IF S$ = "3" THEN PLAY "MB T70 O3 L20AL32AFA": PLAY "MB L8O3B L16 B B L8O4C D L16E F F F L8 G "
IF S$ = "4" THEN BEEP
IF S$ = "5" THEN MENU
IF S$ <> "1" OR S$ <> "2" OR S$ <> "3" OR S$ <> "4" OR S$ <> "5" THEN GOTO 4
END SUB

DEFINT A-Z
SUB SONG1
IF sounds$ = "NO" THEN EXIT SUB
IF soundcard$ = "NO" THEN EXIT SUB
DELAY 32766
DELAY 32766
NOTE 15500, 20000
NOTE 14000, 15000
NOTE 14500, 15000
NOTE 15000, 32766
NOTE 16250, 17500
NOTE 15000, 32766
NOTE 16250, 17500
NOTE 16000, 15000
NOTE 16250, 17500
NOTE 15000, 32766
NOTE 16250, 17500
NOTE 15000, 32766
NOTE 14500, 15000
NOTE 14000, 15000
NOTE 15500, 20000
DELAY 20000
NOTE 14750, 15000
NOTE 14000, 15000
NOTE 15500, 20000
DELAY 32766

END SUB

SUB SONG2
IF sounds$ = "NO" THEN EXIT SUB
IF soundcard$ = "NO" THEN EXIT SUB
NOTE 13000, 32766
NOTE 16000, 10000
NOTE 15000, 10000
DELAY 10000
NOTE 14500, 15000
NOTE 13000, 20000
NOTE 11000, 32766
NOTE 12000, 32766
NOTE 13000, 32766
END SUB

SUB WriteReg (Reg%, Value%)
                   'Purpose:   Writes to any of the SB/AdLib's registers
                   'Variables: Reg%: Register number,
                   'Value%: Value to insert in register
                   '(Note: The registers are from 00-F5 (hex))
OUT &H388, Reg%    '388h = address/status port, 389h = dataport
FOR X = 0 TO 5     'This tells the SB what register we want to write to
   a = INP(&H388)  'After we write to the address port we must wait 3.3ms
NEXT X
OUT &H389, Value%  'Send the value for the register to 389h
FOR X = 0 TO 34    'Here we must also wait, this time 23ms
   a = INP(&H388)
NEXT X
END SUB

