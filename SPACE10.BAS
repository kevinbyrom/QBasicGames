'
'    ,----------    ,---------,    ,---------,    ,---------   ,---------
'    |              |         |    |         |    |            |
'    |              |         |    |         |    |            |
'    |              |         |    |         |    |            |
'    |              |         |    |_________|    |            |
'    `---------,    |---------'    |         |    |            |--------
'              |    |              |         |    |            |
'              |    |              |         |    |            |
'              |    |              |         |    |            |
'              |    |              |         |    |            |
'    ----------'    |              |         |    `---------   `---------
'                                         
'    \            /\            /      ,---------,      ,--------,
'    ;           / ;           /       |         |      |         ',
'     \         |   \         |        |         |      |          |
'     ;         /   ;         /        |         |      |          ;
'      \       /     \       /         |_________|      |_______,/'
'      ;      |      ;      |          |         |      |   `\
'       \     /       \     /          |         |      |    `\
'       ;    /        ;    /           |         |      |     `\
'        \   |         \  |            |         |      |      `\
'        ;  /          ;  /            |         |      |       `\
'         \/            \/             |         |      |        `\
'  
'    ===================================================================                 
'              
'                          V E R S I O N    1 . 0
'            
'    ===================================================================          
'
'   
'             ,-----------------------------------------------,
'             |                                               |
'             |    Do you like this game? Do you hate this    |
'             |    game? Do you have ideas for making it      |
'             |    better? Do you have ideas for new levels?  |
'             |    Whatever your thoughts of Spacewar are,    |
'             |    I want to hear them. Feedback is what      |
'             |    every programmer wants (and what a lot of  |
'             |    programmers don't get enough of). So       |
'             |    drop me some E-mail sometime. My address   |
'             |    is Shan0019@aol.com. Oh, and one more      |
'             |    thing. No comments about spaghetti code.   |
'             |    I'm already working on Spacewar 1.1 which  |
'             |    might have a few new features but mainly   |
'             |    won't be written in spaghetti code. I'm    |
'             |    going to go through and re - write the     |
'             |    whole thing so that it will run better.    |
'             |    So, once again, no comments on spaghetti   |
'             |    code but please E-mail me and tell me      |
'             |    what you think of Spacewar.                |
'             |                                               |
'             `-----------------------------------------------'                                              
'
'
'
'    ===================================================================
'    ===================================================================
'
'
'
'    ===================================================================
'    ===================================================================
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
'
SHELL "mode con: rate=32 delay=1"
SHELL "cls"
DIM paz(1 TO 1000)
DIM ded(1 TO 5000)
6 SCREEN 12: CLS
LINE (210, 110)-(410, 270), 1, BF
LINE (230, 130)-(390, 250), 0, BF
LOCATE 10, 31: PRINT "S P A C E   W A R"
LOCATE 11, 31: PRINT "-----------------"
LOCATE 12, 34: PRINT "VERSION 1.0"
LOCATE 14, 38: PRINT "by"
LOCATE 15, 32: PRINT "Shannon O'Neil"
LOCATE 20, 32: PRINT "press space bar"
DO
SELECT CASE INKEY$
CASE CHR$(32): EXIT DO
END SELECT
LOOP
34 CLEAR
SCREEN 12: CLS
PAINT (1, 1), 8
PSET (100, 60): DRAW "C7;G50;F50;G50"
PSET (120, 60): DRAW "C7;D150;U70;E40;H40"
PSET (170, 210): DRAW "C7;U150;R30;D150;U80;L30"
PSET (280, 60): DRAW "C7;G75;F75"
PSET (300, 60): DRAW "C7;D150;R40;L40;U80;R40;L40;U70;R40"
PSET (350, 60): DRAW "C7;D150;E40;U70;D70;F40;U150"
PSET (440, 210): DRAW "C7;U150;R30;D150;U80;L30"
PSET (480, 60): DRAW "C7;D150;U70;E40;H40"
LINE (495, 125)-(520, 210), 7
LOCATE 17, 40: PRINT "START"
LOCATE 20, 40: PRINT "INSTRUCTIONS"
LOCATE 23, 40: PRINT "REGISTRATION"
a = 180: b = 262
CIRCLE (a, b), 40, , , , (2 / 15)
LINE (a + 40, b)-(a + 50, b)
DO
SELECT CASE INKEY$
CASE CHR$(0) + "M" 'right
CIRCLE (a, b), 40, 8, , , (2 / 15)
LINE (a + 40, b)-(a + 50, b), 8
SELECT CASE b
CASE 262: b = 310
CASE 310: b = 359
CASE 359: b = 262
END SELECT
CASE CHR$(0) + "P" 'down
CIRCLE (a, b), 40, 8, , , (2 / 15)
LINE (a + 40, b)-(a + 50, b), 8
SELECT CASE b
CASE 262: b = 310
CASE 310: b = 359
CASE 359: b = 262
END SELECT
CASE CHR$(0) + "K" 'left
CIRCLE (a, b), 40, 8, , , (2 / 15)
LINE (a + 40, b)-(a + 50, b), 8
SELECT CASE b
CASE 262: b = 359
CASE 310: b = 262
CASE 359: b = 310
END SELECT
CASE CHR$(0) + "H" 'up
CIRCLE (a, b), 40, 8, , , (2 / 15)
LINE (a + 40, b)-(a + 50, b), 8
SELECT CASE b
CASE 262: b = 359
CASE 310: b = 262
CASE 359: b = 310
END SELECT
CASE CHR$(32)
SELECT CASE b
CASE 262: GOTO 17
CASE 310
CLS
LOCATE 7, 15: PRINT "In Spacewar you are the oval shaped ship. You"
LOCATE 8, 15: PRINT "move up, down, left, and right by using the"
LOCATE 9, 15: PRINT "arrow keys. You shoot by pressing the space bar."
LOCATE 10, 15: PRINT "To pause the game press the p button. You can end the"
LOCATE 11, 15: PRINT "game at any point by pressing the e button. In level 1"
LOCATE 12, 15: PRINT "if you or the circles touch the border then you"
LOCATE 13, 15: PRINT "(or the circles) are transported to another place"
LOCATE 14, 15: PRINT "on the screen. You will not be able to shoot the"
LOCATE 15, 15: PRINT "level 1 boss until you shoot all of the small circles."
LOCATE 16, 15: PRINT "Sometimes you will run across invisible small circles."
LOCATE 17, 15: PRINT "Those are the hardest to shoot but are worth the most points."
LOCATE 18, 15: PRINT "If you encounter any problems when using Spacewar"
LOCATE 19, 15: PRINT "then E-mail me at Shan0019@aol.com and let me know."
LOCATE 22, 26: PRINT "press spacebar to continue"
DO
SELECT CASE INKEY$
CASE "e": GOTO 33
CASE "E": GOTO 33
CASE CHR$(32): GOTO 34
END SELECT
LOOP
CASE 359
CLS
LOCATE 9, 17: PRINT "The full version of Spacewar isn't finished yet."
LOCATE 10, 17: PRINT "Spacewar version 2.0 will have registration info"
LOCATE 11, 17: PRINT "and will run a lot better than Spacewar version 1.0."
LOCATE 12, 17: PRINT "Look for it sometime early '96."
LOCATE 13, 17: PRINT "If you are interested in registering Spacewar"
LOCATE 14, 17: PRINT "let me know. E-mail me at Shan0019@aol.com and"
LOCATE 15, 17: PRINT "tell me what you think of Spacewar, along with "
LOCATE 16, 17: PRINT "any suggestions and ideas you have for it."
LOCATE 20, 26: PRINT "press spacebar to continue"
DO
SELECT CASE INKEY$
CASE "e": GOTO 33
CASE "E": GOTO 33
CASE CHR$(32): GOTO 34
END SELECT
LOOP
END SELECT
CASE "e": GOTO 33
CASE "E": GOTO 33
END SELECT
CIRCLE (a, b), 40, , , , (2 / 15)
LINE (a + 40, b)-(a + 50, b)
LOOP
17 SCREEN 12: CLS
qqqq = 0
LOCATE 14, 35: PRINT "level 1"
DO
qqqq = qqqq + 1
LOOP UNTIL qqqq = 5000
LOCATE 16, 30: PRINT "                "
LOCATE 17, 20: PRINT "                                     "
LOCATE 28, 43: PRINT "press p to pause and e to quit"
qwe = 0
RANDOMIZE TIMER
FOR ab = 1 TO 150
  ac = INT(RND * 629) + 1
  ad = INT(RND * 429) + 1
  PSET (ac, ad)
NEXT ab
a = 50
b = 240
CIRCLE (a, b), 40, , , , (2 / 15)
LINE (a + 40, b)-(a + 50, b)
m = 450
n = 300
x = 500
y = 270
vc = 9
cx = 14
op = 470
po = 270
level = 1
life = 3
cleer = 0
CIRCLE (m, n), 10, vc
CIRCLE (x, y), 10, cx
CONST true = -1
CONST false = NOT true
LOCATE 28, 5: PRINT "level:"
LOCATE 28, 17: PRINT "lives:"
LOCATE 28, 28: PRINT "score:"
100 DO
LINE (1, 1)-(630, 430), 8, B
LINE (1, 430)-(630, 479), 8, B
LOCATE 28, 11: PRINT level
LOCATE 28, 23: PRINT life
LOCATE 28, 34: PRINT score
wwww = wwww + 1
IF wwww = 50 THEN LOCATE 14, 35: PRINT "       "
IF chan = true AND (score MOD 800) = 0 THEN
chan = false
life = life + 1
END IF
IF bn >= 16 AND bn < 31 AND ty < 40 THEN
IF bn = 30 THEN uj = 1          ' no more circles
CIRCLE (op, po), 75, 0
ml = ml + 1
IF ml < 100 THEN po = po - 1
IF ml > 100 THEN po = po + 1
IF ml >= 200 THEN ml = 0
IF bn < 30 THEN clo = 7
IF bn = 30 THEN clo = 9
CIRCLE (op, po), 75, clo
RANDOMIZE TIMER
nl = INT(RND * 30) + 1
SELECT CASE nl
CASE 10
RANDOMIZE TIMER
bl = INT(RND * 6) + 1
SELECT CASE bl
CASE IS < 7
change = true
END SELECT
CASE ELSE: change = false
END SELECT
END IF
IF change = true THEN
SELECT CASE bl
CASE 1
ol = op
oo = po
oll = op
ooo = po
DO
qi = qi + 1
IF (oll - 10) < (a + 50) AND (oll - 10) > (a - 40) AND ooo < (b + 15) AND ooo > (b - 15) THEN GOTO 1
IF (ol - 10) < (a + 50) AND (ol - 10) > (a - 40) AND oo < (b + 15) AND oo > (b - 15) THEN GOTO 1
LINE (ol, oo - 60)-(ol - 10, oo - 60), 0
LINE (oll, ooo)-(oll - 10, ooo), 0
ol = ol - 50
oll = oll - 50
LINE (ol, oo - 60)-(ol - 10, oo - 60), 4
LINE (oll, ooo)-(oll - 10, ooo), 4
LOOP UNTIL qi >= 50
qi = 0
CASE 2
ol = op
oo = po
oll = op
ooo = po
DO
qi = qi + 1
IF (oll - 10) < (a + 50) AND (oll - 10) > (a - 40) AND ooo < (b + 15) AND ooo > (b - 15) THEN GOTO 1
IF (ol - 10) < (a + 50) AND (ol - 10) > (a - 40) AND oo < (b + 15) AND oo > (b - 15) THEN GOTO 1
LINE (ol, oo - 40)-(ol - 10, oo - 40), 0
LINE (oll, ooo)-(oll - 10, ooo), 0
ol = ol - 50
oll = oll - 50
LINE (ol, oo - 40)-(ol - 10, oo - 40), 4
LINE (oll, ooo)-(oll - 10, ooo), 4
LOOP UNTIL qi >= 50
qi = 0
CASE 3
ol = op
oo = po
oll = op
ooo = po
DO
qi = qi + 1
IF (oll - 10) < (a + 50) AND (oll - 10) > (a - 40) AND ooo < (b + 15) AND ooo > (b - 15) THEN GOTO 1
IF (ol - 10) < (a + 50) AND (ol - 10) > (a - 40) AND oo < (b + 15) AND oo > (b - 15) THEN GOTO 1
LINE (ol, oo + 60)-(ol - 10, oo + 60), 0
LINE (oll, ooo)-(oll - 10, ooo), 0
ol = ol - 50
oll = oll - 50
LINE (ol, oo + 60)-(ol - 10, oo + 60), 4
LINE (oll, ooo)-(oll - 10, ooo), 4
LOOP UNTIL qi >= 50
qi = 0
CASE 4
ol = op
oo = po
oll = op
ooo = po
DO
qi = qi + 1
IF (oll - 10) < (a + 50) AND (oll - 10) > (a - 40) AND ooo < (b + 15) AND ooo > (b - 15) THEN GOTO 1
IF (ol - 10) < (a + 50) AND (ol - 10) > (a - 40) AND oo < (b + 15) AND oo > (b - 15) THEN GOTO 1
LINE (ol, oo + 40)-(ol - 10, oo + 40), 0
LINE (oll, ooo)-(oll - 10, ooo), 0
ol = ol - 50
oll = oll - 50
LINE (ol, oo + 40)-(ol - 10, oo + 40), 4
LINE (oll, ooo)-(oll - 10, ooo), 4
LOOP UNTIL qi >= 50
qi = 0
CASE 5
ol = op
oo = po
oll = op
ooo = po
ool = op
loo = po
DO
qi = qi + 1
IF (ool - 10) < (a + 50) AND (ool - 10) > (a - 40) AND loo < (b + 15) AND loo > (b - 15) THEN GOTO 1
IF (oll - 10) < (a + 50) AND (oll - 10) > (a - 40) AND ooo < (b + 15) AND ooo > (b - 15) THEN GOTO 1
IF (ol - 10) < (a + 50) AND (ol - 10) > (a - 40) AND oo < (b + 15) AND oo > (b - 15) THEN GOTO 1
LINE (ol, oo - 60)-(ol - 10, oo - 60), 0
LINE (ool, loo + 60)-(ool - 10, loo + 60), 0
LINE (oll, ooo)-(oll - 10, ooo), 0
ol = ol - 50
oll = oll - 50
ool = ool - 50
LINE (ol, oo - 60)-(ol - 10, oo - 60), 4
LINE (ool, loo + 60)-(ool - 10, loo + 60), 4
LINE (oll, ooo)-(oll - 10, ooo), 4
LOOP UNTIL qi >= 50
qi = 0
CASE 6
ol = op
oo = po
oll = op
ooo = po
ool = op
loo = po
DO
qi = qi + 1
IF (ool - 10) < (a + 50) AND (ool - 10) > (a - 40) AND loo < (b + 15) AND loo > (b - 15) THEN GOTO 1
IF (oll - 10) < (a + 50) AND (oll - 10) > (a - 40) AND ooo < (b + 15) AND ooo > (b - 15) THEN GOTO 1
IF (ol - 10) < (a + 50) AND (ol - 10) > (a - 40) AND oo < (b + 15) AND oo > (b - 15) THEN GOTO 1
LINE (ol, oo - 40)-(ol - 10, oo - 40), 0
LINE (ol, oo + 40)-(ol - 10, oo + 40), 0
LINE (ol, oo)-(ol - 10, oo), 0
ool = ool - 50
oll = oll - 50
ol = ol - 50
LINE (ol, oo - 40)-(ol - 10, oo - 40), 4
LINE (oll, ooo + 40)-(oll - 10, ooo + 40), 4
LINE (ool, loo)-(ool - 10, loo), 4
LOOP UNTIL qi >= 50
qi = 0
END SELECT
END IF
IF circ = 1 AND sfd = 1 AND uj = 0 THEN
RANDOMIZE TIMER
vc = INT(RND * 16)
cx = INT(RND * 16)
2 m = INT(RND * 600) + 1
IF m < 20 THEN GOTO 2
3 n = INT(RND * 450) + 1
IF n < 20 THEN GOTO 3
4 x = INT(RND * 600) + 1
IF x < 20 THEN GOTO 4
5 y = INT(RND * 450) + 1
IF y < 20 THEN GOTO 5
circ = 0
sfd = 0
END IF
IF level = 2 THEN GOTO 333
IF m <= 1 OR m >= 630 OR n <= 1 OR n >= 425 THEN
CIRCLE (m, n), 10, 0
RANDOMIZE TIMER
m = INT(RND * 600) + 1
n = INT(RND * 450) + 1
LOCATE 28, 5: PRINT "level:"
LOCATE 28, 17: PRINT "lives:"
LOCATE 28, 28: PRINT "score:"
LOCATE 28, 43: PRINT "press p to pause and e to quit"
ELSEIF x <= 1 OR x >= 630 OR y <= 1 OR y >= 425 THEN
CIRCLE (x, y), 10, 0
RANDOMIZE TIMER
x = INT(RND * 600) + 1
y = INT(RND * 450) + 1
LOCATE 28, 5: PRINT "level:"
LOCATE 28, 17: PRINT "lives:"
LOCATE 28, 28: PRINT "score:"
LOCATE 28, 43: PRINT "press p to pause and e to quit"
END IF
IF (a - 40) <= 1 OR (a + 50) >= 630 OR (b - 10) <= 1 OR (b + 10) >= 425 THEN
CIRCLE (a, b), 40, 0, , , (2 / 15)
LINE (a + 40, b)-(a + 50, b), 0
RANDOMIZE TIMER
a = INT(RND * 600) + 1
b = INT(RND * 450) + 1
CIRCLE (a, b), 40, , , , (2 / 15)
LINE (a + 40, b)-(a + 50, b)
LOCATE 28, 5: PRINT "level:"
LOCATE 28, 17: PRINT "lives:"
LOCATE 28, 28: PRINT "score:"
LOCATE 28, 43: PRINT "press e to quit and p to pause"
END IF
RANDOMIZE TIMER
IF circ = 0 THEN
xy = INT(RND * 5) + 1
SELECT CASE xy
CASE 1
CIRCLE (m, n), 10, 0
m = m + 10
CIRCLE (m, n), 10, vc
CASE 2
CIRCLE (m, n), 10, 0
m = m - 10
CIRCLE (m, n), 10, vc
CASE 3
CIRCLE (m, n), 10, 0
n = n - 10
CIRCLE (m, n), 10, vc
CASE 4
CIRCLE (m, n), 10, 0
n = n + 10
CIRCLE (m, n), 10, vc
CASE 5
RANDOMIZE TIMER
aw = INT(RND * ((vc + 10) * 2)) + 1
SELECT CASE aw
CASE 20
az = m
FOR aa = 1 TO 130
IF (az - 30) <= (a + 50) AND (az - 30) >= (a - 50) AND n < (b + 20) AND n > (b - 20) THEN
1 life = life - 1
DO
jk = jk + 1
CIRCLE (a, b), jk, 4
LOOP UNTIL jk = 70
jk = 80
DO
jk = jk - 1
CIRCLE (a, b), jk, 0
LOOP UNTIL jk = 0
IF life = 0 THEN GOTO 333
GET (180, 179)-(440, 251), ded
LINE (180, 179)-(440, 251), 15, B
LINE (181, 180)-(439, 250), 8, BF
DO
SELECT CASE INKEY$
CASE CHR$(32): fill0 = 0: EXIT DO
CASE "e": GOTO 33
CASE "E": GOTO 33
END SELECT
LINE (181, 180)-(439, 250), 8, B
IF fill0 = 0 THEN
COLOR 15
LOCATE 13, 30: PRINT "You disappoint me."
LOCATE 15, 26: PRINT "press space bar to continue"
END IF
PAINT (300, 195), 8, 15
PAINT (300, 240), 8, 15
fill0 = 1
LOOP
PUT (180, 179), ded, PSET
CIRCLE (a, b), 40, , , , (2 / 15)
LINE (a + 40, b)-(a + 50, b)
EXIT FOR
END IF
LINE (az - 10, n)-(az - 30, n), 0
az = az - 5
LINE (az - 10, n)-(az - 30, n), 4
NEXT aa
END SELECT
END SELECT
END IF
IF sfd = 0 THEN
RANDOMIZE TIMER
yu = INT(RND * 5) + 1
SELECT CASE yu
CASE 1
CIRCLE (x, y), 10, 0
x = x + 10
CIRCLE (x, y), 10, cx
CASE 2
CIRCLE (x, y), 10, 0
x = x - 10
CIRCLE (x, y), 10, cx
CASE 3
CIRCLE (x, y), 10, 0
y = y - 10
CIRCLE (x, y), 10, cx
CASE 4
CIRCLE (x, y), 10, 0
y = y + 10
CIRCLE (x, y), 10, cx
CASE 5
RANDOMIZE TIMER
aq = INT(RND * ((cx + 10) * 2)) + 1
SELECT CASE aq
CASE 20
sw = x
FOR se = 1 TO 130
IF (sw - 30) <= (a + 50) AND (sw - 30) >= (a - 50) AND y < (b + 20) AND y > (b - 20) THEN
life = life - 1
DO
ff = ff + 1
CIRCLE (a, b), ff, 4
LOOP UNTIL ff = 70
ff = 80
DO
ff = ff - 1
CIRCLE (a, b), ff, 0
LOOP UNTIL ff = 0
GET (180, 179)-(440, 251), ded
LINE (180, 179)-(440, 251), 15, B
LINE (181, 180)-(439, 250), 8, BF
DO
SELECT CASE INKEY$
CASE CHR$(32): fill0 = 0: EXIT DO
CASE "e": GOTO 33
CASE "E": GOTO 33
END SELECT
LINE (181, 180)-(439, 250), 8, B
IF fill0 = 0 THEN
COLOR 15
LOCATE 13, 30: PRINT "You disappoint me."
LOCATE 15, 26: PRINT "press space bar to continue"
END IF
PAINT (300, 195), 8, 15
PAINT (300, 240), 8, 15
fill0 = 1
LOOP
PUT (180, 179), ded, PSET
CIRCLE (a, b), 40, , , , (2 / 15)
LINE (a + 40, b)-(a + 50, b)
EXIT FOR
END IF
IF life = 0 THEN GOTO 333
LINE (sw - 10, y)-(sw - 30, y), 0
sw = sw - 5
LINE (sw - 10, y)-(sw - 30, y), 6
NEXT se
END SELECT
END SELECT
END IF
333 IF life = 0 OR level = 2 THEN
33 CLS
FOR tbg = 1 TO 20
RANDOMIZE TIMER
tbf = INT(RND * 620) + 1
tbd = INT(RND * 460) + 1
tbc = INT(RND * 15) + 1
CIRCLE (tbf, tbd), 10, tbc
NEXT tbg
FOR stb = 1 TO 100
RANDOMIZE TIMER
ynh = INT(RND * 630) + 1
yng = INT(RND * 470) + 1
PSET (ynh, yng)
NEXT stb
LOCATE 12, 31: PRINT "G A M E    O V E R !"
LOCATE 15, 30: PRINT "you made it to level"; level
LOCATE 16, 30: PRINT "your score is"; score
SELECT CASE ac2
CASE 0: LOCATE 17, 30: PRINT "accuracy: 0 %"
CASE ELSE: LOCATE 17, 30: PRINT "accuracy:"; CINT((ac1 / ac2) * 100); "%"
END SELECT
DO
cleer = cleer + 1
SELECT CASE INKEY$
CASE CHR$(32): cleer = cleer - 5
END SELECT
LOOP UNTIL cleer = 1000
LOCATE 25, 27: PRINT "PRESS SPACE BAR TO CONTINUE"
DO
SELECT CASE INKEY$
CASE CHR$(32)
CLS
PAINT (1, 1), 8
PSET (100, 60): DRAW "C7;G50;F50;G50"
PSET (120, 60): DRAW "C7;D150;U70;E40;H40"
PSET (170, 210): DRAW "C7;U150;R30;D150;U80;L30"
PSET (280, 60): DRAW "C7;G75;F75"
PSET (300, 60): DRAW "C7;D150;R40;L40;U80;R40;L40;U70;R40"
PSET (350, 60): DRAW "C7;D150;E40;U70;D70;F40;U150"
PSET (440, 210): DRAW "C7;U150;R30;D150;U80;L30"
PSET (480, 60): DRAW "C7;D150;U70;E40;H40"
LINE (495, 125)-(520, 210), 7
LOCATE 17, 30: PRINT "PLAY AGAIN?"
LOCATE 20, 40: PRINT "YES"
LOCATE 23, 40: PRINT "NO"
a = 180: b = 310
CIRCLE (a, b), 40, , , , (2 / 15)
LINE (a + 40, b)-(a + 50, b)
DO
SELECT CASE INKEY$
CASE CHR$(0) + "M" 'right
CIRCLE (a, b), 40, 8, , , (2 / 15)
LINE (a + 40, b)-(a + 50, b), 8
SELECT CASE b
CASE 310: b = 359
CASE 359: b = 310
END SELECT
CASE CHR$(0) + "P" 'down
CIRCLE (a, b), 40, 8, , , (2 / 15)
LINE (a + 40, b)-(a + 50, b), 8
SELECT CASE b
CASE 310: b = 359
CASE 359: b = 310
END SELECT
CASE CHR$(0) + "K" 'left
CIRCLE (a, b), 40, 8, , , (2 / 15)
LINE (a + 40, b)-(a + 50, b), 8
SELECT CASE b
CASE 310: b = 359
CASE 359: b = 310
END SELECT
CASE CHR$(0) + "H" 'up
CIRCLE (a, b), 40, 8, , , (2 / 15)
LINE (a + 40, b)-(a + 50, b), 8
SELECT CASE b
CASE 310: b = 359
CASE 359: b = 310
END SELECT
CASE CHR$(32)
SELECT CASE b
CASE 310: GOTO 34
CASE 359
CLS
LOCATE 10, 36: PRINT "BYE  BYE"
END
END SELECT
END SELECT
CIRCLE (a, b), 40, , , , (2 / 15)
LINE (a + 40, b)-(a + 50, b)
LOOP
END SELECT
LOOP
END IF
321 SELECT CASE INKEY$
CASE CHR$(0) + "M": CIRCLE (a, b), 40, 0, , , (2 / 15): LINE (a + 40, b)-(a + 50, b), 0
a = a + 20: CIRCLE (a, b), 40, , , , (2 / 15): LINE (a + 40, b)-(a + 50, b)
CASE CHR$(0) + "K": CIRCLE (a, b), 40, 0, , , (2 / 15): LINE (a + 40, b)-(a + 50, b), 0
a = a - 20: CIRCLE (a, b), 40, , , , (2 / 15): LINE (a + 40, b)-(a + 50, b)
CASE CHR$(0) + "H": CIRCLE (a, b), 40, 0, , , (2 / 15): LINE (a + 40, b)-(a + 50, b), 0
b = b - 20: CIRCLE (a, b), 40, , , , (2 / 15): LINE (a + 40, b)-(a + 50, b)
CASE CHR$(0) + "P": CIRCLE (a, b), 40, 0, , , (2 / 15): LINE (a + 40, b)-(a + 50, b), 0
b = b + 20: CIRCLE (a, b), 40, , , , (2 / 15): LINE (a + 40, b)-(a + 50, b)
CASE "p"
GET (262, 179)-(363, 251), paz
LINE (262, 179)-(363, 251), 15, B
LINE (263, 180)-(362, 250), 8, BF
DO
SELECT CASE INKEY$
CASE "p": fill0 = 0: EXIT DO
CASE "P": fill0 = 0: EXIT DO
CASE "e": GOTO 33
CASE "E": GOTO 33
END SELECT
LINE (263, 180)-(362, 250), 8, B
IF fill0 = 0 THEN
COLOR 15
LOCATE 13, 35: PRINT "paused..."
LOCATE 14, 35: PRINT "press p to"
LOCATE 15, 35: PRINT "continue"
END IF
PAINT (300, 220), 8, 15
fill0 = 1
LOOP
PUT (262, 179), paz, PSET
CASE "P"
GET (262, 179)-(363, 251), paz
LINE (262, 179)-(363, 251), 15, B
LINE (263, 180)-(362, 250), 8, BF
DO
SELECT CASE INKEY$
CASE "p": fill0 = 0: EXIT DO
CASE "P": fill0 = 0: EXIT DO
CASE "e": GOTO 33
CASE "E": GOTO 33
END SELECT
LINE (263, 180)-(362, 250), 8, B
IF fill0 = 0 THEN
COLOR 15
LOCATE 13, 35: PRINT "paused..."
LOCATE 14, 35: PRINT "press p to"
LOCATE 15, 35: PRINT "continue"
END IF
PAINT (300, 220), 8, 15
fill0 = 1
LOOP
PUT (262, 179), paz, PSET
CASE CHR$(32)
ac2 = ac2 + 1
d = a
FOR r = 1 TO 28
  IF (d + 75) <= (m + 10) AND (d + 75) >= (m - 10) AND b <= (n + 10) AND b >= (n - 10) AND circ = 0 THEN
  ac1 = ac1 + 1
  SELECT CASE vc
  CASE 0: score = score + 90
  CASE 1: score = score + 75
  CASE 2: score = score + 70
  CASE 3: score = score + 65
  CASE 4: score = score + 60
  CASE 5: score = score + 55
  CASE 6: score = score + 50
  CASE 7: score = score + 45
  CASE 8: score = score + 40
  CASE 9: score = score + 35
  CASE 10: score = score + 30
  CASE 11: score = score + 25
  CASE 12: score = score + 20
  CASE 13: score = score + 15
  CASE 14: score = score + 10
  CASE 15: score = score + 5
  CASE 16: score = score + 5
  END SELECT
  chang = true
  bn = bn + 1
  circ = 1
  DO
  z = z + 1
  CIRCLE (m, n), z, 4
  LOOP UNTIL z = 25
  z = 27
  DO
  z = z - 1
  CIRCLE (m, n), z, 0
  LOOP UNTIL z = 0
  LINE (d + 55, b)-(d + 75, b), 0
  EXIT FOR
  ELSEIF (d + 75) <= (x + 10) AND (d + 75) >= (x - 10) AND b <= (y + 10) AND b >= (y - 10) AND sfd = 0 THEN
  ac1 = ac1 + 1
  SELECT CASE cx
  CASE 0: score = score + 90
  CASE 1: score = score + 75
  CASE 2: score = score + 70
  CASE 3: score = score + 65
  CASE 4: score = score + 60
  CASE 5: score = score + 55
  CASE 6: score = score + 50
  CASE 7: score = score + 45
  CASE 8: score = score + 40
  CASE 9: score = score + 35
  CASE 10: score = score + 30
  CASE 11: score = score + 25
  CASE 12: score = score + 20
  CASE 13: score = score + 15
  CASE 14: score = score + 10
  CASE 15: score = score + 5
  CASE 16: score = score + 5
  END SELECT
  chang = true
  bn = bn + 1
  sfd = 1
  DO
  z = z + 1
  CIRCLE (x, y), z, 4
  LOOP UNTIL z = 25
  z = 27
  DO
  z = z - 1
  CIRCLE (x, y), z, 0
  LOOP UNTIL z = 0
  LINE (d + 55, b)-(d + 75, b), 0
  EXIT FOR
  ELSEIF (d + 75) <= (op + 75) AND (d + 75) >= (op - 75) AND b <= (po + 75) AND b >= (po - 75) AND ty < 40 AND bn = 30 THEN
  ac1 = ac1 + 1
  chang = true
  gv = (d + 75)
  ty = ty + 1
  score = score + 2
  IF ty = 30 THEN
  chang = true
  sfd = 1
  circ = 1
  uj = 0
  score = score + 150
  level = level + 1
  bn = bn + 1
  DO
  qas = qas + 1
  RANDOMIZE TIMER
10 ra = INT(RND * (op + 75)) + 1
  IF ra < (op - 75) THEN GOTO 10
11 ar = INT(RND * (po + 75)) + 1
  IF ar < (po - 75) THEN GOTO 11
  DO
  qaz = qaz + 1
  CIRCLE (ra, ar), qaz, 4
  LOOP UNTIL qaz = 40
  qaz = 42
  DO
  qaz = qaz - 1
  CIRCLE (ra, ar), qaz, 0
  LOOP UNTIL qaz = 0
  LOOP UNTIL qas = 50
  CIRCLE (op, po), 75, 0
  FOR star = 1 TO 50
    ac = INT(RND * 630)
    ad = INT(RND * 470)
    PSET (ac, ad)
  NEXT star
  SELECT CASE score
  CASE 900 TO 1099: life = life + 1
  CASE 1100 TO 1300: life = life + 3
  CASE IS >= 1301: life = life + 10
  END SELECT
  END IF
  DO
  yt = yt + 1
  CIRCLE (gv, b), yt, 4
  LOOP UNTIL yt = 20
  yt = 22
  DO
  yt = yt - 1
  CIRCLE (gv, b), yt, 0
  LOOP UNTIL yt = 0
  LINE (d + 55, b)-(d + 75, b), 0
  EXIT FOR
  END IF
  LINE (d + 55, b)-(d + 80, b), 0
  d = d + 20
  LINE (d + 55, b)-(d + 80, b), 3
NEXT r
CASE "e": GOTO 33
CASE "E": GOTO 33
END SELECT
LOOP

