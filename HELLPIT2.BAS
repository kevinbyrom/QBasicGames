' Read this stuff, then use HELLPIT2.bat, or else you may get errors!
'�����������������������������������������������������������������������������
'�      Fig's e-mail address:                      PANTERA55@aol.com         �
'�      Fig's web site      :       http://members.aol.com/PANTERA55         �
'�����������������������������������������������������������������������������

'�����������������������������������������������������������������������������
'�      Fig Presents HELLPIT II                                              �
'�                                                                           �
'�      Thank you for downloading HELLPIT II from FIG.  This is the sequel to�
'� HELLPIT I.  This is not the final HELLPIT game; there is one more left in �
'� the trilogy.  This is the longest HELLPIT game.  This game will always go �
'� different; you have different choices.  This game only has ONE save file. �
'� HELLPIT III will have two save files.  I would really, really appreciate  �
'� any comments, questions and criticisms that you may have of this game, so �
'� please e-mail me.  Please do not edit this file in any way.  I don't ask  �
'� any money for this game, but in return I ask that you leave the files     �
'� alone.  There are many new features in this game, such as a two-player    �
'� magic attack and a secret three player magic attack.  There is also a new �
'� game + feature, where you can start a new game with old stats, and a new  �
'� unique HP counter.  Have fun with this game!                              �
'�      P.S There are two secrets in the game, so if you want them, then you �
'� have to e-mail me with comments on the game!                              �
'�����������������������������������������������������������������������������

'�����������������������������������������������������������������������������
'�   Look for these games soon:                                              �
'�        DUNGEON MASTER VERSION 1.1                     (FIG)               �
'�        HELLPIT III                                    (FIG)               �
'�        BULLET BATTLES                                 (FIG)               �
'�����������������������������������������������������������������������������

'�����������������������������������������������������������������������������
'�     I am always looking for new members of FIG.  I don't really care if   �                                                    
'�you are not good at making games, you can still join.  All I ask for is a  �
'�sample of your work to see how good you are, and to see what style of      �
'�programming you use.  You can join FIG to help me with my games, or you can�
'�join FIG so you can make your own games (or with another member of FIG) and�
'�use the FIG logo.  I would like to know what kind of games you like to     �
'�program, and how much experience you have making games.                    �
'�                                              - FIG (PANTERA55)            �
'�����������������������������������������������������������������������������

'DO NOT RUN THIS GAME NOW!  RUN HELLPIT2.bat!


















DECLARE SUB boom ()
DECLARE SUB blacken ()
DECLARE SUB border ()
DECLARE SUB delay ()
DECLARE SUB fp ()
DECLARE SUB howto ()
DECLARE SUB icon ()
DECLARE SUB intro ()
DECLARE SUB logo ()
DECLARE SUB sounds ()
DECLARE SUB swordblood ()
DECLARE SUB town ()

DIM i%(350)

RANDOMIZE TIMER

SCREEN 8

CLS

icon
GET (0, 0)-(35, 8), i%

fp

SCREEN 8

border

logo

swordblood

DO
IF ads < 4 THEN PLAY "mbo1l12ade": ads = ads + 1
IF ads = 4 THEN PLAY "mbo1l12fa#cc": ads = 0
LOOP UNTIL INKEY$ <> ""

CLS
COLOR 15

PRINT "                             1997 FIG"
PRINT "     This is the full version of HELLPIT II.  You do not need to register."
PRINT "Do not mess around with the programming (please).  This game took a long"
PRINT "time to make.  It's not that hard, anyways.  Upload this and any of my other"
PRINT "games anywhere, if you want.  Just tell me, please.  My email address is:"
PRINT "                                                 PANTERA55@aol.com       "
PRINT "      My web site is              http://members.aol.com/PANTERA55       "
PRINT
PRINT "     If you are not using HELLPIT2.bat, it's not my fault that your games "
PRINT "don't save properly."
PRINT
PRINT "     This is the second and the longest of the HELLPIT trilogy.  Once all "
PRINT "three of them are finished, I will make the final copies of them, and upload"
PRINT "one ZIP file containing all three of them."
PRINT
PRINT "                                                         FIG     "


DO
IF ads < 4 THEN PLAY "mfo1l12ade": ads = ads + 1
IF ads = 4 THEN PLAY "mfo1l12fa#cc": ads = 0
LOOP UNTIL INKEY$ <> ""

y = 40

0




CLS
PRINT
PRINT "                                 1997 FIG"
LOCATE 6, 1
PRINT "                                 New Game"
PRINT
PRINT "                                 Load Game"
PRINT
PRINT "                                 How to Play"
PRINT
PRINT "                                 Introduction"
PRINT
PRINT "                                 Quit"

0.1

PUT (210, y), i%, PSET
yy = y

DO
a$ = INKEY$
IF a$ = CHR$(0) + "P" THEN IF y < 104 THEN y = y + 16: GOSUB down
IF a$ = CHR$(0) + "H" THEN IF y > 40 THEN y = y - 16: GOSUB up
IF a$ = CHR$(13) THEN GOSUB choice
LOOP

down:
FOR downs = yy TO y STEP .3
PUT (210, downs), i%, PSET
SOUND 200, .05
NEXT downs
GOTO 0.1

up:
FOR ups = yy TO y STEP -.3
PUT (210, ups), i%, PSET
SOUND 500, .05
NEXT ups
GOTO 0.1

choice:
IF y = 40 THEN GOTO 1
IF y = 56 THEN GOTO 2
IF y = 72 THEN GOTO 3
IF y = 88 THEN GOTO 4
IF y = 104 THEN GOTO 5

1 'play game

CLS
COLOR 15
PRINT "IS THIS A (N)ew Game OR A New Game (+) (NEW GAME USING OLD DATA) ?"
PRINT "(N)ew or (+) or (E) to Exit ?"

DO
a$ = INKEY$
IF UCASE$(a$) = "N" THEN GOTO 1.1
IF UCASE$(a$) = "E" THEN CLS : GOTO 0
IF UCASE$(a$) = "+" THEN GOTO 1.5
LOOP

1.1

nhpmax = 37: dhpmax = 38
nmpmax = 8: dmpmax = 9
nweapon = 1: dweapon = 1
nlev = 1: dlev = 1
money = 100

OPEN "savefile.hp2" FOR OUTPUT AS #1
        WRITE #1, nhp, nhpmax, nmp, nmpmax
        WRITE #1, nweapon, narmor
        WRITE #1, nex, nlev
        WRITE #1, nskill
        WRITE #1, dhp, dhpmax, dmp, dmpmax
        WRITE #1, dweapon, darmor
        WRITE #1, dex, dlev
        WRITE #1, dskill
        WRITE #1, money, crystals
CLOSE #1

CHAIN "town.hp2"

1.5

OPEN "savefile.hp2" FOR INPUT AS #1
        INPUT #1, nhp, nhpmax, nmp, nmpmax
        INPUT #1, nweapon, narmor
        INPUT #1, nex, nlev
        INPUT #1, nskill
        INPUT #1, dhp, dhpmax, dmp, dmpmax
        INPUT #1, dweapon, darmor
        INPUT #1, dex, dlev
        INPUT #1, dskill
        INPUT #1, money, crystals
CLOSE #1

crystals = 0

OPEN "savefile.hp2" FOR OUTPUT AS #1
        WRITE #1, nhp, nhpmax, nmp, nmpmax
        WRITE #1, nweapon, narmor
        WRITE #1, nex, nlev
        WRITE #1, nskill
        WRITE #1, dhp, dhpmax, dmp, dmpmax
        WRITE #1, dweapon, darmor
        WRITE #1, dex, dlev
        WRITE #1, dskill
        WRITE #1, money, crystals
CLOSE #1

CHAIN "town.hp2"

2 'load game

CLS

OPEN "savefile.hp2" FOR INPUT AS #1
        INPUT #1, nhp, nhpmax, nmp, nmpmax
        INPUT #1, nweapon, narmor
        INPUT #1, nex, nlev
        INPUT #1, nskill
        INPUT #1, dhp, dhpmax, dmp, dmpmax
        INPUT #1, dweapon, darmor
        INPUT #1, dex, dlev
        INPUT #1, dskill
        INPUT #1, money, crystals
CLOSE #1

nhp = nhpmax: nmp = nmpmax
dhp = dhpmax: dmp = dmpmax

CLS
PAINT (1, 1), 10
border
COLOR 15
LOCATE 3, 6
PRINT "NEON   HP:", nhp, "/", nhpmax
LOCATE 4, 6
PRINT "       MP:", nmp, "/", nmpmax
LOCATE 5, 6
PRINT "    LEVEL:", nlev
LOCATE 6, 6
PRINT "       EX:", nex

IF nweapon = 1 THEN nwname$ = "X-Stars"
IF nweapon = 2 THEN nwname$ = "Ravage Stars"
IF nweapon = 3 THEN nwname$ = "Hybrid Stars"
IF nweapon = 4 THEN nwname$ = "Z-Stars"
IF nweapon = 5 THEN nwname$ = "Exo-Stars"
LOCATE 7, 6
PRINT "   WEAPON:", nwname$

IF narmor = 0 THEN naname$ = "None"
IF narmor = 1 THEN naname$ = "X-Armor"
IF narmor = 2 THEN naname$ = "Z-Armor"
IF narmor = 3 THEN naname$ = "Exo-Vest"
LOCATE 8, 6
PRINT "    ARMOR:", naname$

COLOR 1
LOCATE 10, 7
PRINT "DAVID HP:", dhp, "/", dhpmax
LOCATE 11, 6
PRINT "       MP:", dmp, "/", dmpmax
LOCATE 12, 6
PRINT "    LEVEL:", dlev
LOCATE 13, 6
PRINT "       EX:", dex
IF dweapon = 1 THEN dwname$ = "X-Stars"
IF dweapon = 2 THEN dwname$ = "Ravage Stars"
IF dweapon = 3 THEN dwname$ = "Hybrid Stars"
IF dweapon = 4 THEN dwname$ = "Z-Stars"
IF dweapon = 5 THEN dwname$ = "Exo-Stars"
LOCATE 14, 6
PRINT "   WEAPON:", dwname$

IF darmor = 0 THEN daname$ = "None"
IF darmor = 1 THEN daname$ = "X-Armor"
IF darmor = 2 THEN daname$ = "Z-Armor"
IF darmor = 3 THEN daname$ = "Exo-Vest"
LOCATE 15, 6
PRINT "    ARMOR:", naname$

COLOR 15
LOCATE 23, 50
PRINT "MONEY:", money

LOCATE 23, 6
COLOR 9: PRINT "CRYSTALS:"
LOCATE 23, 16: COLOR 8: PRINT ""

IF crystals = 1 THEN LOCATE 23, 16: COLOR 9: PRINT ""
IF crystals = 2 THEN LOCATE 23, 16: COLOR 9: PRINT ""
IF crystals = 3 THEN LOCATE 23, 16: COLOR 9: PRINT ""
IF crystals = 4 THEN LOCATE 23, 16: COLOR 9: PRINT ""
IF crystals = 5 THEN LOCATE 23, 16: COLOR 9: PRINT ""
IF crystals = 6 THEN LOCATE 23, 16: COLOR 9: PRINT ""
IF crystals = 6 THEN LINE (40, 179)-(166, 179), 4

COLOR 15
LOCATE 20, 37
PRINT "LOAD ?"

DO

a$ = INKEY$
IF UCASE$(a$) = "Y" THEN CHAIN "town.hp2"
IF UCASE$(a$) = "N" THEN GOTO 0

LOOP

3 'how to play

CLS
howto

DO

FOR x = 1 TO 590 STEP 1
PUT (x, 140), i%, PSET
LINE (x, 140)-(x - 1, 190), 0, BF
SOUND (200 + (x / 5)), .07
IF INKEY$ <> "" THEN CLS : GOTO 3.1
NEXT x

FOR x = 590 TO 1 STEP -1
PUT (x, 140), i%, PSET
LINE (x + 35, 140)-(x + 36, 190), 0, BF
SOUND (200 + (x / 5)), .07
IF INKEY$ <> "" THEN CLS : GOTO 3.1
NEXT x

LOOP

3.1

y = 40

GOTO 0

4 'introduction

intro

GOTO 0

5 'quit
END

SUB blacken
LINE (10, 5)-(630, 185), 0, B
LINE (80, 110)-(140, 86), 0, B
LINE (530, 100)-(590, 76), 0, B
LINE (240, 160)-(300, 136), 0, B
LINE (240, 60)-(400, 0), 0, B
LINE (290, 60)-(350, 40), 0, B
PAINT (320, 100), 0

town

SOUND 60, .1
END SUB

SUB boom
FOR s = 1 TO 50 STEP .3
co = INT(RND * 3) + 1
IF co = 1 THEN co = 0
IF co = 2 THEN co = 7
IF co = 3 THEN co = 8
CIRCLE (320, 50), s, co
SOUND (50 + s - s), .08
NEXT s
END SUB

SUB border
PAINT (1, 1), 1
LINE (4, 1)-(636, 198), 10, BF
LINE (10, 4)-(630, 196), 0, BF
END SUB

SUB delay
FOR d = 1 TO 3000
NEXT d
END SUB

SUB fp
SCREEN 12
PAINT (1, 1), 1
COLOR 14
LINE (20, 20)-(620, 460), , BF
COLOR 4
LINE (0, 0)-(660, 480)
PAINT (1, 470), 4
COLOR 1
LINE (100, 100)-(130, 250), , BF
LINE (100, 100)-(200, 130), , BF
LINE (100, 160)-(180, 190), , BF
LINE (270, 100)-(370, 130), , BF
LINE (305, 100)-(335, 250), , BF
LINE (270, 220)-(370, 250), , BF
LINE (440, 100)-(540, 130), , BF
LINE (440, 100)-(470, 250), , BF
LINE (470, 250)-(540, 220), , BF
LINE (540, 250)-(510, 200), , BF
LINE (540, 200)-(490, 170), , BF
COLOR 15
LOCATE 23, 37
PRINT "PRESENTS"
delay
FOR sizers = 0 TO 320 STEP 1
CIRCLE (320, 240), sizers, 0, , , .9
SOUND 100 + (sizers * .8), .04
LINE (sizers, 0)-(sizers, 480), 0, B
LINE (640 - sizers, 0)-(640 - sizers, 480), 0, B
NEXT sizers
END SUB

SUB howto
COLOR 15
PRINT "The object of the game is to get all six crystals to open the portal to"
PRINT "the center of hell.  Once this portal is open, you can put an end to the"
PRINT "hell portal, and get Thesse back (hopefully)."
PRINT "The controls are:         - UP     - DOWN    - LEFT    - RIGHT"
PRINT "                         ESC - END GAME     ENTER - SEE STATUS    "
PRINT "The main portal is located inside the castle.  Then there are six sub-"
PRINT "portals, each containing a crystal.  It is up to you to lead Neon and "
PRINT "David to them all, and into hell's core."
END SUB

SUB icon
LINE (0, 3)-(10, 5), 6, BF
LINE (10, 1)-(13, 7), 4, BF
COLOR 7
LINE (14, 3)-(35, 4)
LINE -(14, 5)
LINE -(14, 4)
LINE -(25, 4)
END SUB

SUB intro
SCREEN 13

FOR col = 16 TO 31 STEP .1
COLOR col
LOCATE 1, 5
PRINT "Thesse?  Why did you do this to me?"
NEXT col

FOR col = 16 TO 31 STEP .1
COLOR col
LOCATE 2, 1
PRINT "Why did you side with evil?"
NEXT col

FOR col = 16 TO 31 STEP .1
COLOR col
LOCATE 4, 5
PRINT "She had no choice.  She has been"
NEXT col

FOR col = 16 TO 31 STEP .1
COLOR col
LOCATE 5, 1
PRINT "posessed by the devil himself..."
NEXT col

FOR col = 16 TO 31 STEP .1
COLOR col
LOCATE 7, 5
PRINT "And who are you???"
NEXT col

FOR col = 16 TO 31 STEP .1
COLOR col
LOCATE 9, 5
PRINT "I am David.  I have some cleric"
NEXT col

FOR col = 16 TO 31 STEP .1
COLOR col
LOCATE 10, 1
PRINT "abilities.  I will help you and Thesse."
NEXT col

FOR col = 16 TO 31 STEP .1
COLOR col
LOCATE 11, 1
PRINT "It was my fault that the portal opened,"
NEXT col

FOR col = 16 TO 31 STEP .1
COLOR col
LOCATE 12, 1
PRINT "so I will help you out.  I can re-open "
NEXT col

FOR col = 16 TO 31 STEP .1
COLOR col
LOCATE 13, 1
PRINT "the portal, and I don't know where the"
NEXT col

FOR col = 16 TO 31 STEP .1
COLOR col
LOCATE 14, 1
PRINT "portal will re-open, but we must take"
NEXT col

FOR col = 16 TO 31 STEP .1
COLOR col
LOCATE 15, 1
PRINT "our chances....."
NEXT col

SLEEP

SCREEN 8

CLS

town

sounds

sounds

sounds

FOR s = 1 TO 50 STEP 1
SOUND (50 - s + s), .05
NEXT s

SCREEN 8

town

FOR s = 1 TO 3
blacken
delay
delay
delay
NEXT s
FOR s = 1 TO 2
blacken
delay
delay
NEXT s
FOR s = 1 TO 7
blacken
delay
NEXT s
FOR s = 1 TO 23
blacken
NEXT s

delay
delay

boom

SLEEP

SCREEN 13
CLS

FOR col = 16 TO 31 STEP .1
COLOR col
LOCATE 1, 5
PRINT "The portal is now open.  Neon"
NEXT col

FOR col = 16 TO 31 STEP .1
COLOR col
LOCATE 2, 1
PRINT "and David must use all of their"
NEXT col

FOR col = 16 TO 31 STEP .1
COLOR col
LOCATE 3, 1
PRINT "power to save Thesse.  Inside the"
NEXT col

FOR col = 16 TO 31 STEP .1
COLOR col
LOCATE 4, 1
PRINT "castle lies the portal.  What lies"
NEXT col

FOR col = 16 TO 31 STEP .1
COLOR col
LOCATE 5, 1
PRINT "beyond the portal?"
NEXT col

SLEEP

SCREEN 8
END SUB

SUB logo
COLOR 4
LINE (20, 10)-(20, 70) 'begin H
LINE -(18, 75)
LINE -(32, 75)
LINE -(30, 70)
LINE -(30, 42)
LINE -(50, 42)
LINE -(50, 70)
LINE -(48, 75)
LINE -(62, 75)
LINE -(60, 70)
LINE -(60, 10)
LINE -(62, 5)
LINE -(48, 5)
LINE -(50, 10)
LINE -(50, 38)
LINE -(30, 38)
LINE -(30, 10)
LINE -(32, 5)
LINE -(18, 5)
LINE -(20, 10)
PAINT (40, 40), 4
COLOR 12
LINE (68, 5)-(70, 10) 'Begin E
LINE -(70, 70)
LINE -(68, 75)
LINE -(115, 75)
LINE -(110, 70)
LINE -(110, 60)
LINE -(105, 70)
LINE -(80, 70)
LINE -(80, 42)
LINE -(110, 42)
LINE -(115, 43)
LINE -(115, 38)
LINE -(110, 40)
LINE -(80, 40)
LINE -(80, 15)
LINE -(105, 15)
LINE -(110, 25)
LINE -(110, 10)
LINE -(115, 5)
LINE -(70, 5)
PAINT (73, 40), 12
COLOR 13
LINE (123, 5)-(125, 10)'begin L
LINE -(125, 70)
LINE -(120, 75)
LINE -(170, 75)
LINE -(165, 65)
LINE -(155, 70)
LINE -(135, 70)
LINE -(135, 10)
LINE -(138, 5)
LINE -(123, 5)
PAINT (133, 35), 13
COLOR 4
LINE (178, 5)-(180, 10)'begin L
LINE -(180, 70)
LINE -(175, 75)
LINE -(225, 75)
LINE -(220, 65)
LINE -(210, 70)
LINE -(190, 70)
LINE -(190, 10)
LINE -(193, 5)
LINE -(178, 5)
PAINT (188, 35), 4
COLOR 12
LINE (228, 5)-(230, 10)'Begin P
LINE -(230, 70)
LINE -(228, 75)
LINE -(243, 75)
LINE -(240, 70)
LINE -(240, 38)
LINE -(275, 38)
LINE -(280, 35)
LINE -(280, 10)
LINE -(275, 5)
LINE -(228, 5)
LINE (240, 10)-(240, 32)
LINE -(266, 32)
LINE -(269, 30)
LINE -(269, 12)
LINE -(266, 10)
LINE -(240, 10)
PAINT (235, 30), 12
COLOR 13
LINE (283, 5)-(285, 10)'Begin I
LINE -(285, 70)
LINE -(283, 75)
LINE -(297, 75)
LINE -(295, 70)
LINE -(295, 10)
LINE -(297, 5)
LINE -(283, 5)
PAINT (286, 50), 13
COLOR 4
LINE (303, 5)-(305, 10)'Begin T
LINE -(327, 10)
LINE -(327, 70)
LINE -(325, 75)
LINE -(335, 75)
LINE -(333, 70)
LINE -(333, 10)
LINE -(355, 10)
LINE -(360, 5)
LINE -(303, 5)
PAINT (330, 35), 4
COLOR 15
LINE (500, 5)-(505, 10)
LINE -(505, 70)
LINE -(500, 75)
LINE -(600, 75)
LINE -(595, 70)
LINE -(595, 10)
LINE -(600, 5)
LINE -(500, 5)
LINE (530, 15)-(570, 65), , B
PAINT (520, 50), 15
COLOR 14
LINE (500, 5)-(505, 10)
LINE -(505, 70)
LINE -(500, 75)
LINE -(600, 75)
LINE -(595, 70)
LINE -(595, 10)
LINE -(600, 5)
LINE -(500, 5)
LINE (530, 15)-(570, 65), , B
COLOR 15
LOCATE 13, 47
PRINT "Into the Lungs of Hell"
LINE (150, 144)-(530, 140) 'Start Sword
LINE -(550, 150)
LINE -(530, 160)
LINE -(150, 156)
LINE -(150, 144)
PAINT (180, 150), 15
COLOR 1
LINE (150, 150)-(510, 150)
LINE -(530, 140)
LINE (510, 150)-(530, 160)
LINE (150, 130)-(140, 170), 6, BF
LINE (150, 130)-(160, 140), 6, BF
LINE (150, 170)-(160, 160), 6, BF
LINE (139, 147)-(59, 153), 1, BF
END SUB

SUB sounds
FOR s = 100 TO 0 STEP -2
SOUND (140 + s), .06
NEXT s

delay
delay
END SUB

SUB swordblood
09.012
x = INT(RND * 550) + 1
y = INT(RND * 195) + 1
IF x < 160 THEN GOTO 09.012
IF y < 155 THEN GOTO 09.012
CIRCLE (x, y), 4, 4
PAINT (x, y), 4
COLOR 4
LINE (x - 2, y)-(x, y - 5)
LINE -(x + 2, y)
PAINT (x, y - 3), 4
howmany = howmany + 1
IF howmany < 100 THEN GOTO 09.012
howmany = 0
END SUB

SUB town
PAINT (1, 1), 8
LINE (10, 5)-(630, 185), 4, BF
LINE (80, 110)-(140, 86), 3, BF
LINE (530, 100)-(590, 76), 2, BF
LINE (240, 160)-(300, 136), 1, BF
LINE (240, 60)-(400, 0), 8, BF
LINE (290, 60)-(350, 40), 6, BF
COLOR 0
LINE (240, 60)-(400, -1), , B
LINE (240, 60)-(270, -1), , B
LINE (400, 60)-(370, -1), , B
LINE (320, 60)-(320, 40)
COLOR 0
LINE (100, 100)-(120, 110), , BF
LINE (550, 100)-(570, 90), , BF
LINE (260, 160)-(280, 150), , BF

END SUB

