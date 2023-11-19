
'                               ARCHERY v3.1
'                      By Michael Schwartz (MIKE23456)
'                             CREATED 2/15/95













DECLARE SUB drawcloud ()
DECLARE SUB bullssnd ()
DECLARE SUB drawscreen2 ()
DECLARE SUB intro ()
DECLARE SUB drawnumbers ()
DECLARE SUB DRAWSCREEN ()
DECLARE SUB GAMESYS ()
GAMESYS

SUB bullssnd
SOUND 900, 2
SOUND 1200, 2
END SUB

SUB drawcloud
DRAW "bm 345, 15 c15 l55 g5 l15 g10 r55 e3 r45 E3 R25 H4 L47 E5"
PAINT (330, 20), 15, 15

DRAW "bm 145, 3 c15 l55 g5 l15 g10 r55 e3 r45 E3 R25 H4 L47 E5"
PAINT (130, 8), 15, 15

DRAW "bm 529, 1 c15 l55 g5 l15 g10 r55 e3 r45 E3 R25 H4 L47 E5"
PAINT (525, 7), 15, 15


END SUB

SUB drawnumbers
LOCATE 22, 3
COLOR 2: PRINT "GREEN - 100"
LOCATE 23, 3
COLOR 9: PRINT "BLUE - 75"
LOCATE 24, 3
COLOR 14: PRINT "YELLOW - 50"
LOCATE 25, 3
COLOR 4: PRINT "RED - 25"



END SUB

SUB DRAWSCREEN
LINE (0, 0)-(635, 450), 9, B
       
LINE (0, 215)-(635, 250), 2, B
PAINT (5, 218), 2, 2

        CIRCLE (525, 350), 95, 4
        PAINT (528, 348), 4, 4
       CIRCLE (525, 350), 65, 14
          PAINT (528, 348), 14, 14
         CIRCLE (525, 350), 35, 9
           PAINT (528, 348), 9, 9
         CIRCLE (525, 350), 15, 2
            PAINT (528, 348), 2, 2

LINE (628, 45)-(633, 135), 4, B
PAINT (630, 47), 4, 4
LINE (628, 60)-(633, 120), 14, B
PAINT (630, 67), 14, 14
LINE (628, 75)-(633, 105), 9, B
PAINT (630, 77), 9, 9
LINE (628, 85)-(633, 95), 2, B
PAINT (630, 87), 2, 2
END SUB

SUB drawscreen2
CLS
LINE (1, 1)-(640, 250), 9, B
PAINT (3, 5), 9, 9
LINE (0, 0)-(635, 450), 9, B
    
LINE (0, 215)-(635, 250), 2, B
PAINT (5, 218), 2, 2

        CIRCLE (525, 350), 95, 4
        PAINT (528, 348), 4, 4
       CIRCLE (525, 350), 65, 14
          PAINT (528, 348), 14, 14
         CIRCLE (525, 350), 35, 1
           PAINT (528, 348), 1, 1
         CIRCLE (525, 350), 15, 2
            PAINT (528, 348), 2, 2

LINE (627, 44)-(634, 136), 0, B

LINE (634, 44)-(638, 215), 0, B
PAINT (637, 46), 0, 0
LINE (628, 45)-(633, 135), 4, B
PAINT (630, 47), 4, 4
LINE (628, 60)-(633, 120), 14, B
PAINT (630, 67), 14, 14
LINE (628, 75)-(633, 105), 1, B
PAINT (630, 77), 1, 1
LINE (628, 85)-(633, 95), 2, B
PAINT (630, 87), 2, 2
drawcloud
END SUB

SUB GAMESYS
u:
SCREEN 12
CLS
ar% = 25
buls% = 0
sco% = 0
darts% = ar%
intro

'***********************************************
drawscreen2
         COLOR 15
         LOCATE 18, 3
          PRINT "SCORE:"; sco%
       
         LOCATE 19, 3
         PRINT "BULLSEYE's:"; buls%
       
         LOCATE 20, 3
         PRINT "ARROWS LEFT:"; darts%
drawnumbers


'***********************************************
COLOR 15
'***********************************************

fire:
RANDOMIZE TIMER
e% = INT(RND * 20)
IF e% < 2 THEN GOTO stwnd
IF e% < 8 THEN GOTO downq
IF e% < 13 THEN GOTO upq
IF e% < 17 THEN GOTO stwnd2
IF e% < 20 THEN GOTO fire
'**************************************************
stwnd:
w% = INT(RND * 60)
LOCATE 2, 2: PRINT "WIND  --> :"; w%;
IF w% = 0 THEN e% = 0: sp% = 45: GOTO n4
IF w% < 7 THEN e% = 35: sp% = 43: GOTO n4
IF w% < 15 THEN e% = 30: sp% = 40: GOTO n4
IF w% < 25 THEN e% = 25: sp% = 35: GOTO n4
IF w% < 35 THEN e% = 20: sp% = 33: GOTO n4
IF w% < 45 THEN e% = 15: sp% = 25: GOTO n4
IF w% < 55 THEN e% = 13: sp% = 15: GOTO n4
IF w% < 60 THEN e% = 10: sp% = 10: GOTO n4
COLOR 2
n4:
COLOR 15
         LOCATE 18, 3
         PRINT "SCORE:"; sco%
         LOCATE 19, 3
         PRINT "BULLSEYE's:"; buls%
         LOCATE 20, 3
         PRINT "ARROWS LEFT:"; darts%
         IF darts% = 0 THEN GOTO endgame:
a% = 2
B% = 85
c% = 35
d% = 85
LINE (a%, B%)-(c%, d%), 0
DO
 F$ = INKEY$
 IF F$ = "I" OR F$ = "i" THEN GOSUB up4
 IF F$ = "M" OR F$ = "m" THEN GOSUB down4
LOOP UNTIL F$ = CHR$(32)
darts% = darts% - 1
GOTO fire4:

up4:
IF B% < 35 THEN RETURN
LINE (a%, B%)-(c%, d%), 9
B% = B% - 3
d% = d% - 3
LINE (a%, B%)-(c%, d%), 0
RETURN

down4:
IF B% > 205 THEN RETURN
LINE (a%, B%)-(c%, d%), 9
B% = B% + 3
d% = d% + 3
LINE (a%, B%)-(c%, d%), 0
RETURN
fire4:
DO
RANDOMIZE TIMER
LINE (a%, B%)-(c%, d%), 9
a% = a% + 3
c% = c% + 3
LINE (a%, B%)-(c%, d%), 0
FOR x = 1 TO 47: NEXT x
LOOP UNTIL c% > 627
GOTO mike
'***********************************************

stwnd2:
w% = INT(RND * 60)
LOCATE 2, 2: PRINT "WIND <u\d>:"; w%;
IF w% = 0 THEN e% = 0: sp% = 45: GOTO n1
IF w% < 7 THEN e% = 35: sp% = 43: GOTO n1
IF w% < 15 THEN e% = 30: sp% = 40: GOTO n1
IF w% < 25 THEN e% = 25: sp% = 35: GOTO n1
IF w% < 35 THEN e% = 20: sp% = 33: GOTO n1
IF w% < 45 THEN e% = 15: sp% = 25: GOTO n1
IF w% < 55 THEN e% = 13: sp% = 15: GOTO n1
IF w% < 60 THEN e% = 10: sp% = 10: GOTO n1
COLOR 2
n1:
COLOR 15
         LOCATE 18, 3
         PRINT "SCORE:"; sco%
         LOCATE 19, 3
         PRINT "BULLSEYE's:"; buls%
         LOCATE 20, 3
         PRINT "ARROWS LEFT:"; darts%
         IF darts% = 0 THEN GOTO endgame:
a% = 2
B% = 85
c% = 35
d% = 85
LINE (a%, B%)-(c%, d%), 0
DO
 F$ = INKEY$
 IF F$ = "I" OR F$ = "i" THEN GOSUB up
 IF F$ = "M" OR F$ = "m" THEN GOSUB down
LOOP UNTIL F$ = CHR$(32)
darts% = darts% - 1
GOTO fire1:
up:
IF B% < 35 THEN RETURN
LINE (a%, B%)-(c%, d%), 9
B% = B% - 3
d% = d% - 3
LINE (a%, B%)-(c%, d%), 0
RETURN
down:
IF B% > 205 THEN RETURN
LINE (a%, B%)-(c%, d%), 9
B% = B% + 3
d% = d% + 3
LINE (a%, B%)-(c%, d%), 0
RETURN
fire1:
DO
RANDOMIZE TIMER
q% = INT(RND * e%)
IF q% = 4 THEN GOSUB up
IF q% = 7 THEN GOSUB down
LINE (a%, B%)-(c%, d%), 9
a% = a% + 3
c% = c% + 3
LINE (a%, B%)-(c%, d%), 0
FOR x = 1 TO 47: NEXT x
LOOP UNTIL c% > 627
GOTO mike
'**********************************************************


upq:
w% = INT(RND * 60)
COLOR 0
LOCATE 2, 2: PRINT "                  "
COLOR 15
LOCATE 2, 2: PRINT "WIND <up>: "; w%;
IF w% = 0 THEN e% = 0: sp% = 40: GOTO n2
IF w% < 7 THEN e% = 50: sp% = 35: GOTO n2
IF w% < 17 THEN e% = 40: sp% = 34: GOTO n2
IF w% < 25 THEN e% = 35: sp% = 32: GOTO n2
IF w% < 35 THEN e% = 25: sp% = 31: GOTO n2
IF w% < 45 THEN e% = 15: sp% = 30: GOTO n2
IF w% < 55 THEN e% = 10: sp% = 25: GOTO n2
IF w% < 60 THEN e% = 8: sp% = 15: GOTO n2
COLOR 2
n2:
COLOR 15
         LOCATE 18, 3
         PRINT "SCORE:"; sco%
         LOCATE 19, 3
         PRINT "BULLSEYE's:"; buls%
         LOCATE 20, 3
         PRINT "ARROWS LEFT:"; darts%
         IF darts% = 0 THEN GOTO endgame:
a% = 2
B% = 85
c% = 35
d% = 85
LINE (a%, B%)-(c%, d%), 0
DO
 F$ = INKEY$
 IF F$ = "I" OR F$ = "i" THEN GOSUB up1
 IF F$ = "M" OR F$ = "m" THEN GOSUB down1
LOOP UNTIL F$ = CHR$(32)
darts% = darts% - 1
GOTO fire2:
up1:
IF B% < 35 THEN RETURN
LINE (a%, B%)-(c%, d%), 9
B% = B% - 3
d% = d% - 3
LINE (a%, B%)-(c%, d%), 0
RETURN
down1:
IF B% > 205 THEN RETURN
LINE (a%, B%)-(c%, d%), 9
B% = B% + 3
d% = d% + 3
LINE (a%, B%)-(c%, d%), 0
RETURN
fire2:
DO
RANDOMIZE TIMER
q% = INT(RND * e%)
IF q% = 3 THEN GOSUB up
LINE (a%, B%)-(c%, d%), 9
a% = a% + 2
c% = c% + 2
LINE (a%, B%)-(c%, d%), 0
FOR x% = 1 TO 550: NEXT x%
LOOP UNTIL c% > 627
GOTO mike
'*************************************************************


downq:
w% = INT(RND * 60)
COLOR 0
LOCATE 2, 2: PRINT "                "
COLOR 15
LOCATE 2, 2: PRINT "WIND <dwn>:"; w%;
IF w% = 0 THEN e% = 0: sp% = 40: GOTO n3
IF w% < 7 THEN e% = 50: sp% = 35: GOTO n3
IF w% < 15 THEN e% = 40: sp% = 35: GOTO n3
IF w% < 25 THEN e% = 35: sp% = 34: GOTO n3
IF w% < 35 THEN e% = 25: sp% = 32: GOTO n3
IF w% < 45 THEN e% = 15: sp% = 31: GOTO n3
IF w% < 55 THEN e% = 10: sp% = 30: GOTO n3
IF w% < 60 THEN e% = 8: sp% = 25: GOTO n3

COLOR 2
n3:
COLOR 15
         LOCATE 18, 3
         PRINT "SCORE:"; sco%
         LOCATE 19, 3
         PRINT "BULLSEYE's:"; buls%
         LOCATE 20, 3
         PRINT "ARROWS LEFT:"; darts%
         IF darts% = 0 THEN GOTO endgame:
a% = 2
B% = 85
c% = 35
d% = 85
LINE (a%, B%)-(c%, d%), 0
DO
 F$ = INKEY$
 IF F$ = "I" OR F$ = "i" THEN GOSUB up2
 IF F$ = "M" OR F$ = "m" THEN GOSUB down2
LOOP UNTIL F$ = CHR$(32)
darts% = darts% - 1
GOTO fire3:
up2:
IF B% < 35 THEN RETURN
LINE (a%, B%)-(c%, d%), 9
B% = B% - 3
d% = d% - 3
LINE (a%, B%)-(c%, d%), 0
RETURN
down2:
IF B% > 205 THEN RETURN
LINE (a%, B%)-(c%, d%), 9
B% = B% + 3
d% = d% + 3
LINE (a%, B%)-(c%, d%), 0
RETURN
fire3:
DO
RANDOMIZE TIMER
q% = INT(RND * e%)
IF q% = 2 THEN GOSUB down
LINE (a%, B%)-(c%, d%), 9
a% = a% + 3
c% = c% + 3
LINE (a%, B%)-(c%, d%), 0
FOR x = 1 TO 47: NEXT x
LOOP UNTIL c% > 627
GOTO mike






mike:
SOUND 150, 2
IF d% < 45 THEN GOTO misshigh
IF d% > 45 AND d% < 60 THEN GOTO topred
IF d% > 60 AND d% < 75 THEN GOTO topyellow
IF d% > 75 AND d% < 87 THEN GOTO topblue
IF d% > 85 AND d% < 95 THEN GOTO bullseye
IF d% > 95 AND d% < 105 THEN GOTO bottomblue
IF d% > 105 AND d% < 120 THEN GOTO bottomyellow
IF d% > 120 AND d% < 135 THEN GOTO bottomred
IF d% > 135 THEN GOTO misslow


'*****************************************

misshigh:
sco% = sco% + 0
FOR i% = 1 TO 25
LINE (a%, B%)-(c%, d%), 9
a% = a% + 1
c% = c% + 1
FOR x = 1 TO 5: NEXT x
LINE (a%, B%)-(c%, d%), 0
NEXT i%
LINE (a% - 25, B%)-(c%, d%), 9
GOTO fire

topred:
sco% = sco% + 25
r% = INT(RND * 10)
t% = INT(RND * 25)
CIRCLE (510 - t%, 266 + r%), 2, 0
GOTO fire

topyellow:
sco% = sco% + 50
r% = INT(RND * 10)
t% = INT(RND * 20)
CIRCLE (515 + t%, 292 + r%), 2, 0
GOTO fire

topblue:
sco% = sco% + 75
r% = INT(RND * 10)
t% = INT(RND * 15)
CIRCLE (520 - t%, 321 + r%), 2, 0
GOTO fire

bullseye:
sco% = sco% + 100
r% = INT(RND * 5)
CIRCLE (523, 350 - r%), 2, 0
buls% = buls% + 1
CALL bullssnd
IF buls% = 6 THEN GOSUB bonus
GOTO fire

bottomblue:
sco% = sco% + 75
r% = INT(RND * 10)
t% = INT(RND * 15)
CIRCLE (531 + t%, 378 - r%), 2, 0
GOTO fire

bottomyellow:
sco% = sco% + 50
r% = INT(RND * 10)
t% = INT(RND * 20)
CIRCLE (519 - t%, 409 - r%), 2, 0
GOTO fire

bottomred:
sco% = sco% + 25
r% = INT(RND * 10)
t% = INT(RND * 25)
CIRCLE (525 + t%, 440 - r%), 2, 0
GOTO fire

misslow:
sco% = sco% + 0
FOR i% = 1 TO 15
LINE (a%, B%)-(c%, d%), 9
a% = a% + 1
c% = c% + 1
FOR x = 1 TO 5: NEXT x
LINE (a%, B%)-(c%, d%), 0
NEXT i%
LINE (a% - 25, B%)-(c%, d%), 9
GOTO fire




endgame:
DO
RANDOMIZE TIMER
col% = INT(RND * 15)
LOCATE 5, 30
COLOR col%: PRINT "FINAL SCORE:"; sco%
LOCATE 6, 30: PRINT "TOTAL ARROWS:"; ar%
LOCATE 7, 29: PRINT "TOTAL BULLSEYE's:"; buls%
bulp% = (buls% / ar%) * 100
LOCATE 8, 28: PRINT "BULLSEYE PERCENTAGE:"; bulp%; "%"
FOR x = 1 TO 50: NEXT x
LOOP UNTIL INKEY$ <> ""
IF sco% > 2100 THEN : GOTO highsco:
IF sco% < 2100 THEN : DO: LOOP UNTIL INKEY$ <> "": CLS : END
highsco:
CLS
drawscreen2
a% = 2
B% = 90
c% = 32
d% = 90
DO
LINE (a%, B%)-(c%, d%), 9
a% = a% + 1
c% = c% + 1
LINE (a%, B%)-(c%, d%), 0
FOR x = 1 TO 50: NEXT x
LOOP UNTIL c% = 627
a% = 0
DO
col% = INT(RND * 15)
CIRCLE (325, 225), a%, col%
a% = a% + 2
FOR x = 1 TO 1: NEXT x
LOOP UNTIL a% > 230

DO
c% = INT(RND * 15)
LOCATE 5, 26
COLOR c%
PRINT "YOU HAVE ACHIEVED A HIGH SCORE!!!"
LOCATE 7, 32: PRINT "GOOD JOB PLAYER. "
LOOP UNTIL INKEY$ <> ""
CLS
END

bonus:
ar% = ar% + 5
darts% = darts% + 5
LOCATE 5, 15: COLOR 2: PRINT "  CONGRADULATIONS! You have hit SIX bullseye's"
LOCATE 7, 15: PRINT "You will now get a bonus of 250 points and 5 arrows!"
FOR x = 1 TO 1500: NEXT x
o% = 0
COLOR 9
LOCATE 8, 30: PRINT "SCORE"; sco%: FOR x = 1 TO 500: NEXT x
DO
LOCATE 8, 30: PRINT "SCORE"; sco%
sco% = sco% + 1
o% = o% + 1
SOUND 100, .1
LOOP UNTIL o% = 250
DO
c% = INT(RND * 15)
COLOR c%
LOCATE 8, 30: PRINT "SCORE"; sco%
LOOP UNTIL INKEY$ <> ""
COLOR 0
LOCATE 5, 15: COLOR : PRINT "    CONGRADULATIONS! You have hit five bullseye's"
LOCATE 7, 20: PRINT "You will now get a bonus of 250 points!"
LOCATE 8, 30: PRINT "SCORE"; sco%
COLOR 15
drawscreen2
RETURN


END SUB

SUB intro
CLS
COLOR 9
LOCATE 9, 25: PRINT "MICHAEL SCHWARTZ (MIKE23456)"
LOCATE 10, 25: PRINT "       PRESENTS...."
SLEEP 1: SLEEP 1

DRAWSCREEN

COLOR 2: LOCATE 2, 30: PRINT "ARCHERY v1.7"
COLOR 12
LOCATE 3, 2: PRINT "  THIS GAME IS SIMPLE TO PLAY. ALL YOU MUST DO IS AIM THE ARROW"
LOCATE 4, 2: PRINT " AND FIRE. YOU CAN DO THIS BY USING THE FOLLOWING KEYS:"
LOCATE 6, 2: PRINT "             UP - 'I'  DOWN - 'M'  FIRE - <space>  "
LOCATE 9, 2: PRINT " PLEASE NOTE THAT THERE WILL BE WIND. THIS WILL AFFECT THE ARROWS"
LOCATE 10, 2: PRINT "FLIGHT PATH. AT THE TOP LEFT CORNER OF YOUR SCREEN WILL BE A WIND"
LOCATE 11, 2: PRINT "METER. USE THE WIND TO HELP YOU GET A BULLSEYE. "
LOCATE 12, 7: PRINT "TO SEE MORE INSTRUCTIONS\RULES, PRESS I"
LOCATE 13, 7: PRINT "TO PLAY ARCHERY 1.7, PRESS G"

DO
h$ = INKEY$
IF h$ = "i" OR h$ = "I" THEN GOTO inst
IF h$ = "g" OR h$ = "G" THEN GOTO k
LOOP

inst:
CLS : COLOR 2
DRAWSCREEN
LOCATE 2, 2: PRINT "THERE ARE 4 TYPES OF WIND PATTERNS: up, down, up\down, and straight"
LOCATE 3, 2: PRINT "IT SHOULDN'T BE TOO HARD TO FIGURE OUT WHICH WAY THE WIND WILL TAKE"
LOCATE 4, 2: PRINT "THE ARROW. NEXT TO THE 'METER' IS A NUMBER INDICATING STRENGTH OF WIND."
LOCATE 5, 2: PRINT "ALSO, IF AFTER 25 ARROWS YOUR SCORE HAS EXCEEDED 2100 POINTS, YOU WILL"
LOCATE 6, 2: PRINT "HAVE ACHIEVED A HIGH SCORE. (nothing special)  "
LOCATE 7, 2: PRINT "YOU GET A CERTAIN NUMBER OF POINTS FOR HITTING THE AREAS ON THE TARGET:"
LOCATE 8, 2: PRINT "THE RED AREA IS WORTH 25, THE YELLOW AREA IS WORTH 50, THE BLUE, 75 AND"
LOCATE 9, 2: PRINT "A BULLSEYE IS WORTH 100. IF YOU MANAGE TO HIT 6 BULLSEYE'S IN ONE GAME,"
LOCATE 10, 2: PRINT "YOU WILL RECIEVE A 250 POINT BONUS. YOU WILL ALSO RECIEVE 5 BONUS ARROWS."
LOCATE 11, 2: PRINT "AFTER YOU ARE DONE, THE PROGRAM WILL CALCULATE YOUR BULLSEYE PERCENTAGE."
LOCATE 12, 2: PRINT "                        GOOD LUCK"
DO: LOOP UNTIL INKEY$ <> ""





k:
END SUB

