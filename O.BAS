DECLARE SUB endin ()
'
'
'        You shoot in the last direction you moved, but not up or down.
'      If you like this game PLEASE tell me. My screen name for America
'      Online is SWEET 4.
'
'
'                        (Turn on Numlocks)
'
'     8 - UP
'     2 - DOWN
'     4 - LEFT
'     6 - RIGHT
'
'       Spell | DMG | MP's | Special Effect
'
'     * - Slow, 0 dmg, 10 MP, Slows
'     / - Freeze, 0 dmg, 15 MP, Freezes
'     - - Wave, 4-6, 8 MP, Wide
'     + - Still, 0 dmg, 10 MP, Keeps enemy from speeding up
'     7 - Ice, 1-10 dmg, 4 MP, Slows
'     9 - Fire, 1-20 dmg, 6 MP, Destroys Slow or Freeze
'     1 - Lightning, 1-15 dmg, 6 MP, Makes enemy speed up
'     3 - Destroy, 6-12 dmg, 12 MP, Takes 1 HP every time enemy moves
'     5 - Ultimate, 3-19 dmg, 20 MP, Freezes and Destroy's HP's, if spell
'          doesn't work (50% chance, won't take MP's) it takes 1 of your HP's
'
'
'
'
'
RANDOMIZE TIMER
COLOR 7
fast$ = "0"
ed = 76: BE = 3: EDD = 24: BEU = 2: u = 10: r = 10: U2 = 5: R2 = 20: PIC$ = "X": PIC2$ = "O": energy = 60: mp = 120: HP = 20
a: CLS
may = 0
IF energy < 15 THEN fast$ = "1"
IF energy < 10 THEN litt = litt + 100000
IF energy <= 0 THEN endin
IF r = ed THEN r = ed - 1
IF r = BE THEN r = BE + 1
IF u = EDD THEN u = EDD - 1
IF u = BEU THEN u = BEU + 1
IF R2 = ed THEN R2 = ed - 1
IF R2 = BE THEN R2 = BE + 1
IF U2 = EDD THEN U2 = EDD - 1
IF U2 = BEU THEN U2 = BEU + 1
LOCATE 1: PRINT "MP"; mp
PRINT "HP"; HP
LOCATE 1, 20: PRINT "HP"; energy
IF frz > 0 THEN LOCATE 2, 20: PRINT frz
LOCATE u, r: PRINT PIC$
LOCATE U2, R2: PRINT PIC2$
DO
sd:
a$ = INKEY$
IF frz2 > 0 THEN frz2 = frz2 - 1
IF R2 = r AND U2 = u THEN HP = HP - (INT(RND * 13) + 7)
IF HP <= 0 THEN PLAY "p1": PLAY "p1": CLS : PRINT "Try again (and don't forget to send money!!)": END
IF mp < 4 THEN PLAY "p1": PLAY "p1": CLS : PRINT "How are ya gonna win when you don't have enough MP's??": END
IF a$ = "8" THEN GOTO UP
IF a$ = "2" THEN GOTO DOWN
IF a$ = "4" THEN GOTO LEFT
IF a$ = "6" THEN GOTO RIGHT
IF a$ = "7" AND mp >= 4 THEN GOTO Ice
IF a$ = "9" AND mp >= 6 THEN GOTO FIRE
IF a$ = "1" AND mp >= 6 THEN GOTO lit
IF a$ = "*" AND mp >= 10 THEN GOTO frz
IF a$ = "+" AND mp >= 10 THEN GOTO still
IF a$ = "-" AND mp >= 8 THEN GOTO wave
IF a$ = "/" AND mp >= 15 THEN GOTO frzz
IF a$ = "3" AND mp >= 12 THEN GOTO DES
IF a$ = "5" AND mp >= 20 THEN GOTO MAS
IF frz2 > 0 THEN GOTO sd
IF a$ = "" THEN GOTO move
LOOP
UP:
u = u - 1
M = INT(RND * 4) + 1
GOTO move
DOWN:
u = u + 1
GOTO move
LEFT: LAST$ = "L"
r = r - 1
M = INT(RND * 4) + 1
GOTO move
RIGHT: LAST$ = "R"
r = r + 1
GOTO move
Ice:
IF LAST$ = "" THEN GOTO a
UU = u
mp = mp - 4
RAT = INT(RND * 20) + 1
IF RAT < 5 THEN GOTO move
rr = r
rr = rr + 1
IF LAST$ = "R" THEN
FOR x = 1 TO 40
rr = rr + 1
IF R2 = rr AND U2 = UU THEN energy = energy - (INT(RND * 10) + 1): frz = 8
NEXT x
rr = r
EN = 40
S:
IF EN + rr > ed THEN EN = EN - 1
IF EN + rr > ed THEN GOTO S
UU = u
FOR x = 1 TO EN
rr = rr + 1
COLOR 9
LOCATE UU, rr: PRINT "Û"
FOR xx = 1 TO 175
NEXT xx
c = INT(RND * 3) + 1
IF c = 2 THEN CC = 17
IF c = 3 THEN CC = 9
COLOR CC
LOCATE UU, rr: PRINT "Û"
NEXT x
COLOR 7
END IF
IF LAST$ = "L" THEN
FOR x = 1 TO 40
rr = rr - 1
IF R2 = rr AND u = U2 THEN energy = energy - (INT(RND * 10) + 1): frz = 8
NEXT x
rr = r
EN = 40
SS:
IF rr - EN <= 3 THEN EN = EN - 1
IF rr - EN <= 3 THEN GOTO SS
UU = u
FOR x = 1 TO EN
rr = rr - 1
COLOR 9
LOCATE UU, rr: PRINT "Û"
FOR xx = 1 TO 175
NEXT xx
c = INT(RND * 3) + 1
IF c = 2 THEN CC = 17
IF c = 3 THEN CC = 9
COLOR CC
LOCATE UU, rr: PRINT "Û"
NEXT x
COLOR 7
END IF
move:
IF still > 0 THEN still = still - 1
may = 0
M = INT(RND * 4) + 1
may = INT(RND * 100) + 1
IF may = 50 THEN litt = 50
IF fast$ = "1" AND may = 25 THEN litt = 60
IF fast$ = "1" AND may = 50 THEN litt = 70
IF litt = 0 AND frz = 0 THEN ma = 1
IF ma = 1 AND still = 0 THEN may = INT(RND * 100) + 1
IF R2 = r AND U2 = u THEN HP = HP - INT(RND * 13) + 2
ma = 0
IF M = 1 THEN U2 = U2 - 1
IF M = 2 THEN U2 = U2 + 1
IF M = 3 THEN R2 = R2 - 1
IF M = 4 THEN R2 = R2 + 1
IF litt > 0 AND still = 0 THEN litt = litt - 1: FOR x = 1 TO 100: NEXT x: GOTO a
IF fast$ = "1" THEN
FOR xxv = 1 TO 500
NEXT xxv
GOTO a
END IF
IF zap > 0 THEN energy = energy - 1: zap = zap - 1
IF R2 = r AND U2 = u THEN HP = HP - INT(RND * 13) + 2
IF frz > 0 THEN frz = frz - 1: FOR x = 1 TO 1000: NEXT x
FOR x = 1 TO 700
NEXT x
GOTO a
FIRE:
IF LAST$ = "" THEN GOTO a
UU = u
mp = mp - 6
RAT = INT(RND * 20) + 1
IF RAT < 5 THEN GOTO move
rr = r
rr = rr + 1
IF LAST$ = "R" THEN
FOR x = 1 TO 20
rr = rr + 1
IF R2 = rr AND U2 = UU THEN energy = energy - (INT(RND * 20) + 1): frz = 0: frz2 = 0
NEXT x
rr = r
EN = 20
D:
IF EN + rr > ed THEN EN = EN - 1
IF EN + rr > ed THEN GOTO D
UU = u
FOR x = 1 TO EN
rr = rr + 1
COLOR 4
LOCATE UU, rr: PRINT "Û"
FOR xx = 1 TO 150
NEXT xx
c = INT(RND * 3) + 1
IF c = 2 THEN CC = 20
IF c = 3 THEN CC = 4
COLOR CC
LOCATE UU, rr: PRINT "Û"
NEXT x
COLOR 7
END IF
IF LAST$ = "L" THEN
FOR x = 1 TO 20
rr = rr - 1
IF R2 = rr AND U2 = UU THEN energy = energy - (INT(RND * 20) + 1): frz = 0: frz2 = 0
NEXT x
rr = r
EN = 20
DD:
IF rr - EN <= 3 THEN EN = EN - 1
IF rr - EN <= 3 THEN GOTO DD
UU = u
FOR x = 1 TO EN
rr = rr - 1
COLOR 4
LOCATE UU, rr: PRINT "Û"
FOR xx = 1 TO 150
NEXT xx
c = INT(RND * 3) + 1
IF c = 2 THEN CC = 20
IF c = 3 THEN CC = 4
COLOR CC
LOCATE UU, rr: PRINT "Û"
NEXT x
COLOR 7
END IF
GOTO move
lit:
IF LAST$ = "" THEN GOTO a
UU = u
mp = mp - 6
RAT = INT(RND * 20) + 1
IF RAT < 5 THEN GOTO move
rr = r
rr = rr + 1
IF LAST$ = "R" THEN
FOR x = 1 TO 30
rr = rr + 1
IF R2 = rr AND U2 = UU THEN energy = energy - (INT(RND * 15) + 1): litt = litt + 23
NEXT x
rr = r
EN = 30
F:
IF EN + rr > ed THEN EN = EN - 1
IF EN + rr > ed THEN GOTO F
UU = u
FOR x = 1 TO EN
rr = rr + 1
COLOR 11
LOCATE UU, rr: PRINT "Û"
FOR xx = 1 TO 150
NEXT xx
c = INT(RND * 3) + 1
IF c = 2 THEN CC = 15
IF c = 3 THEN CC = 31
COLOR CC
LOCATE UU, rr: PRINT "Û"
NEXT x
COLOR 7
END IF
IF LAST$ = "L" THEN
FOR x = 1 TO 30
rr = rr - 1
IF R2 = rr AND U2 = UU THEN energy = energy - (INT(RND * 15) + 1): litt = litt + 23
NEXT x
rr = r
EN = 30
FF:
IF rr - EN <= 3 THEN EN = EN - 1
IF rr - EN <= 3 THEN GOTO FF
UU = u
FOR x = 1 TO EN
rr = rr - 1
COLOR 11
LOCATE UU, rr: PRINT "Û"
FOR xx = 1 TO 100
NEXT xx
c = INT(RND * 3) + 1
IF c = 2 THEN CC = 15
IF c = 3 THEN CC = 31
COLOR CC
LOCATE UU, rr: PRINT "Û"
NEXT x
COLOR 7
END IF
GOTO move
frz:
mp = mp - 10
RAT = INT(RND * 20) + 1
IF RAT < 5 THEN GOTO move
frz = 75
GOTO move
DES:
IF LAST$ = "" THEN GOTO a
UU = u
mp = mp - 12
RAT = INT(RND * 20) + 1
IF RAT < 5 THEN GOTO move
rr = r
rr = rr + 1
IF LAST$ = "R" THEN
FOR x = 1 TO 120
rr = rr + 1
IF R2 = rr AND U2 = UU THEN zap = (INT(RND * 5) + 7)
NEXT x
rr = r
EN = ed - rr
UU = u
FOR x = 1 TO EN
rr = rr + 1
COLOR 31
LOCATE UU, rr: PRINT "Û"
FOR xx = 1 TO 150
NEXT xx
c = INT(RND * 3) + 1
IF c = 2 THEN CC = 0
IF c = 3 THEN CC = 15
COLOR CC
LOCATE UU, rr: PRINT "Û"
NEXT x
COLOR 7
END IF
IF LAST$ = "L" THEN
FOR x = 1 TO 120
rr = rr - 1
IF R2 = rr AND U2 = UU THEN zap = (INT(RND * 5) + 7)
NEXT x
rr = r
EN = rr - 3
UU = u
FOR x = 1 TO EN
rr = rr - 1
COLOR 11
LOCATE UU, rr: PRINT "Û"
FOR xx = 1 TO 100
NEXT xx
c = INT(RND * 3) + 1
IF c = 2 THEN CC = 15
IF c = 3 THEN CC = 31
COLOR CC
LOCATE UU, rr: PRINT "Û"
NEXT x
COLOR 7
END IF
GOTO move
MAS:
IF LAST$ = "" THEN GOTO a
RAT = INT(RND * 20) + 1
IF RAT < 10 THEN HP = HP - 1: GOTO move
mp = mp - 20
UU = u
rr = r
rr = rr + 1
IF LAST$ = "R" THEN
FOR x = 1 TO 35
rr = rr + 1
IF R2 = rr AND U2 = UU THEN zap = (INT(RND * 3) + 4): energy = energy - (INT(RND * 5) + 1): frz2 = 3000: frz = 50
NEXT x
rr = r
EN = 35
FFF:
IF EN + rr > ed THEN EN = EN - 1
IF EN + rr > ed THEN GOTO FFF
UU = u
FOR x = 1 TO EN
rr = rr + 1
COLOR 0
LOCATE UU, rr: PRINT "Û"
FOR xx = 1 TO 550
NEXT xx
c = INT(RND * 3) + 1
IF c = 2 THEN CC = 31
IF c = 3 THEN CC = 4
COLOR CC
LOCATE UU, rr: PRINT "Û"
NEXT x
COLOR 7
END IF
IF LAST$ = "L" THEN
FOR x = 1 TO 35
rr = rr - 1
IF R2 = rr AND U2 = UU THEN zap = (INT(RND * 6) + 4): energy = energy - (INT(RND * 9) + 1): frz2 = 3500: frz = 50
NEXT x
rr = r
EN = 30
FFFFFF:
IF rr - EN <= 3 THEN EN = EN - 1
IF rr - EN <= 3 THEN GOTO FFFFFF
UU = u
FOR x = 1 TO EN
rr = rr - 1
COLOR 0
LOCATE UU, rr: PRINT "Û"
FOR xx = 1 TO 550
NEXT xx
c = INT(RND * 3) + 1
IF c = 2 THEN CC = 31
IF c = 3 THEN CC = 4
COLOR CC
LOCATE UU, rr: PRINT "Û"
NEXT x
COLOR 7
END IF
GOTO move
frzz:
mp = mp - 15
RAT = INT(RND * 20) + 1
IF RAT < 5 THEN GOTO move
frz2 = 5000
GOTO a
wave:
IF LAST$ = "" THEN GOTO a
UU = u
mp = mp - 8
RAT = INT(RND * 20) + 1
IF RAT < 5 THEN GOTO move
rr = r
rr = rr + 1
IF LAST$ = "R" THEN
FOR x = 1 TO 40
rr = rr + 1
dmg = INT(RND * 3) + 5
IF R2 = rr AND U2 = UU THEN energy = energy - dmg
NEXT x
rr = r
UU = u + 1
FOR x = 1 TO 40
rr = rr + 1
dmg = INT(RND * 3) + 5
IF R2 = rr AND U2 = UU THEN energy = energy - dmg
NEXT x
rr = r
UU = u - 1
FOR x = 1 TO 40
rr = rr + 1
dmg = INT(RND * 3) + 5
IF R2 = rr AND U2 = UU THEN energy = energy - dmg
NEXT x
rr = r
EN = 40
dS:
IF EN + rr > ed THEN EN = EN - 1
IF EN + rr > ed THEN GOTO dS
UU = u
FOR x = 1 TO EN
rr = rr + 1
COLOR 9
LOCATE UU, rr: PRINT "Û"
FOR xx = 1 TO 175
NEXT xx
c = INT(RND * 3) + 1
IF c = 2 THEN CC = 17
IF c = 3 THEN CC = 9
COLOR CC
LOCATE UU, rr: PRINT "Û"
NEXT x
COLOR 7
rr = r
UU = u + 1
FOR x = 1 TO EN
rr = rr + 1
COLOR 9
LOCATE UU, rr: PRINT "Û"
FOR xx = 1 TO 75
NEXT xx
c = INT(RND * 3) + 1
IF c = 2 THEN CC = 17
IF c = 3 THEN CC = 9
COLOR CC
LOCATE UU, rr: PRINT "Û"
NEXT x
COLOR 7
UU = u - 1
rr = r
FOR x = 1 TO EN
rr = rr + 1
COLOR 9
LOCATE UU, rr: PRINT "Û"
FOR xx = 1 TO 75
NEXT xx
c = INT(RND * 3) + 1
IF c = 2 THEN CC = 17
IF c = 3 THEN CC = 9
COLOR CC
LOCATE UU, rr: PRINT "Û"
NEXT x
COLOR 7
END IF
IF LAST$ = "L" THEN
FOR x = 1 TO 40
rr = rr - 1
dmg = INT(RND * 3) + 5
IF R2 = rr AND U2 = UU THEN energy = energy - dmg
NEXT x
rr = r
UU = u + 1
FOR x = 1 TO 40
rr = rr - 1
dmg = INT(RND * 3) + 5
IF R2 = rr AND U2 = UU THEN energy = energy - dmg
NEXT x
rr = r
UU = u - 1
FOR x = 1 TO 40
rr = rr - 1
dmg = INT(RND * 3) + 5
IF R2 = rr AND U2 = UU THEN energy = energy - dmg
NEXT x
rr = r
EN = 40
ddS:
IF rr - EN <= 3 THEN EN = EN - 1
IF rr - EN <= 3 THEN GOTO ddS
UU = u
FOR x = 1 TO EN
rr = rr - 1
COLOR 9
LOCATE UU, rr: PRINT "Û"
FOR xx = 1 TO 175
NEXT xx
c = INT(RND * 3) + 1
IF c = 2 THEN CC = 17
IF c = 3 THEN CC = 9
COLOR CC
LOCATE UU, rr: PRINT "Û"
NEXT x
COLOR 7
rr = r
UU = u + 1
FOR x = 1 TO EN
rr = rr - 1
COLOR 9
LOCATE UU, rr: PRINT "Û"
FOR xx = 1 TO 75
NEXT xx
c = INT(RND * 3) + 1
IF c = 2 THEN CC = 17
IF c = 3 THEN CC = 9
COLOR CC
LOCATE UU, rr: PRINT "Û"
NEXT x
COLOR 7
UU = u - 1
rr = r
FOR x = 1 TO EN
rr = rr - 1
COLOR 9
LOCATE UU, rr: PRINT "Û"
FOR xx = 1 TO 75
NEXT xx
c = INT(RND * 3) + 1
IF c = 2 THEN CC = 17
IF c = 3 THEN CC = 9
COLOR CC
LOCATE UU, rr: PRINT "Û"
NEXT x
COLOR 7
END IF
GOTO move
still:
mp = mp - 10
RAT = INT(RND * 20) + 1
IF RAT < 5 THEN GOTO move
still = 300
GOTO move

SUB endin
RANDOMIZE TIMER
CLS
FOR xx = 1 TO 54
c = INT(RND * 15) + 1
FOR x = 1 TO 300
u = INT(RND * 20) + 3
r = INT(RND * 66) + 7
LOCATE u, r
COLOR c
PRINT "*"
NEXT x
IF xx > 27 THEN CLS
NEXT xx
aaa:
CLS
COLOR 15
PRINT : PRINT " If you like this game you can send me any amount of money for the"
PRINT "time it took to make it."
PRINT : PRINT "   Thank You,"
PRINT "      Nathan Sweet"
LOCATE 25
PRINT "Press any key to continue"
DO
LOOP WHILE INKEY$ = ""
PRINT "Oh, yeah..."
PRINT
PRINT "Nathan Sweet"
PRINT "4011 23rd SW"
PRINT "Seattle, WA 98106"
LOCATE 25
PRINT "Press any key to continue"
FOR x = 1 TO 30
DO
LOOP WHILE INKEY$ = ""
CLS
LOCATE 25
COLOR 15
PRINT "Press any key to continue"
u = INT(RND * 20) + 1
r = INT(RND * 10) + 1
LOCATE r, u
IF x = 30 THEN COLOR 15: GOTO gj
COLOR x
gj:
PRINT "Don't forget"
NEXT x
END
END SUB

