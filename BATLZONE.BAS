'               ----------------------------------------
'                           A D A M  M O S E S 'S
'               ----------------------------------------
'                           B A T T L E  Z O N E
'               ----------------------------------------
'                       S H I F T + F 5  T O  P L A Y
'
'
'
'Questions, Comments, Or Want to Know The Codes E-Mail Me:
'
'TVV Adam@AOL.COM
'
'Technical Problems:
'Make sure that Batlzone.bas is in the same directory as
'  Batlzone.scr.  If they are not then certain peices will not work.
'  Also any modification in the code will badly screw up the entire program
'  so do not do this.




































1234 REM Adam Moses
RANDOMIZE TIMER
GOSUB inb
1 CLS : SCREEN 9
FOR starfeild = 1 TO 290
        PSET (RND * 640, RND * 400), 15
NEXT starfeild
CIRCLE (90, 200), 65, 12
PAINT (90, 200), 12, 12
opx = INT(RND * 230) + 400
opy = INT(RND * 200) + 100
opd = INT(RND * 25) + 20
opk = RND * 13 + 1
CIRCLE (opx, opy), opd, opk
PAINT (opx, opy), opk, opk
senor = 989: title$ = "Battle Zone"
FOR typeit = 1 TO 13
        LOCATE 12, typeit + 33
        COLOR RND * 13 + 1
        here$ = MID$(title$, typeit, 1)
        PRINT here$
NEXT typeit
PLAY "o4"
FOR playzer = 1 TO 2
        PLAY "mf<l16abdel8fdl32geead"
NEXT playzer
SLEEP 1

2 CLS : SCREEN 9: COLOR 15
ON ERROR GOTO 0
PRINT "Battle Zone Main Menu"
PRINT "---------------------"
PRINT "1) Create Ship"
PRINT "2) Play Game"
PRINT "3) Instructions"
PRINT "4) Save Game"
PRINT "5) Load Game"
PRINT "6) New Game"
PRINT "7) Highest Scorer"
PRINT "8) Exit Game"
INPUT "Selection: ", mm
IF shipname$ = "" THEN shipname$ = "Starfire"
slots = maxslots
IF mm = 6 THEN 1234
IF mm = 1 THEN
        IF shipmade = 0 THEN 4
        IF shipmade = 1 THEN
                COLOR 4: PRINT : PRINT "Your ship has already been created.": PRINT : GOSUB pause
        END IF
END IF
IF mm = 2 THEN
        IF shipmade = 1 THEN GOTO 9
        IF shipmade = 0 THEN
                PRINT : COLOR 4: PRINT "You must make a ship first.": PRINT : GOSUB pause
        END IF
END IF
IF mm = 3 THEN GOSUB instruct
IF mm = 7 THEN
        CLS : SCREEN 9
        OPEN "batlzone.scr" FOR INPUT AS #1
                INPUT #1, ohighscore, oname$, opname$, ocomment$
        CLOSE
        COLOR 15: PRINT "Name: "; opname$
        PRINT "Shipname: "; oname$
        PRINT "Score:"; ohighscore
        PRINT "Comment: "; ocomment$
        PRINT : GOSUB pause
END IF

IF mm = 8 THEN GOSUB mynameend
IF mm = 4 THEN
        IF shipmade = 0 THEN
                COLOR 4: PRINT : PRINT "You must make a ship first.": PRINT : GOSUB pause
        END IF
        IF shipmade = 1 THEN
                ffname$ = MID$(shipname$, 1, 8)
                filename$ = ffname$ + ".zon"
                OPEN filename$ FOR OUTPUT AS #1
                        WRITE #1, shipname$, shiptype$, accesscode$, tmoney
                        WRITE #1, level, money, cannonlv, shipmade
                        WRITE #1, teg, spd, weapon
                        WRITE #1, slots, maxslots, fat, spread, heat, ion, comp
                CLOSE
                PRINT : COLOR 2: PRINT "Saving File."; : FOR ofcool = 1 TO 16: PRINT "."; : FOR bubba = 1 TO 400: NEXT bubba: NEXT ofcool
                PRINT : PRINT : GOSUB pause
        END IF
END IF
IF mm = 5 THEN
        ON ERROR GOTO 9090
        PRINT : COLOR 15
        INPUT "Enter Shipname: ", fsname$
        INPUT "Enter Access Code: ", password$
        fsname2$ = MID$(fsname$, 1, 8)
        fsname3$ = fsname2$ + ".zon"
        OPEN fsname3$ FOR INPUT AS #1
                        INPUT #1, shipname$, shiptype$, accesscode$, tmoney
                        INPUT #1, level, money, cannonlv, shipmade
                        INPUT #1, teg, spd, weapon
                        INPUT #1, slots, maxslots, fat, spread, heat, ion, comp
        CLOSE
        IF UCASE$(password$) = UCASE$(accesscode$) THEN
        PRINT : COLOR 2: PRINT "Opening File."; : FOR ofcool2 = 1 TO 16: PRINT "."; : FOR bubba2 = 1 TO 400: NEXT bubba2: NEXT ofcool2
        PRINT : PRINT : GOSUB pause
        END IF
        IF UCASE$(password$) <> UCASE$(accesscode$) THEN
        PRINT : COLOR 4: PRINT "Invalid Access Code!": BEEP: PRINT : GOSUB pause
        shipmade = 0
        END IF
        ON ERROR GOTO 0
END IF
IF mm = senor THEN
        INPUT "Access Code: ", accesscode$
        INPUT "Lives: ", lives
        INPUT "Integrity: ", teg
        INPUT "Speed: ", spd
        INPUT "Slots: ", maxslots
        INPUT "Weapon: ", weapon
        INPUT "Money: ", money
        INPUT "Level: ", level
        shipmade = 1
        INPUT "Store: ", ss$
        slots = maxslots
        IF UCASE$(ss$) = "Y" THEN GOSUB store
        CLS : GOTO 2
END IF
GOTO 2

4 CLS : SCREEN 9: COLOR 15
INPUT "Enter a name for your ship: ", shipname$
INPUT "Enter an access code for your ship: ", accesscode$
5 CLS : SCREEN 9
teg = INT(RND * 6) + 1
spd = INT(RND * 6) + 1
weapon = INT(RND * 6) + 1
maxslots = INT(RND * 6) + 1
PRINT "Integrity: ", teg
PRINT "Speed: ", spd
PRINT "Weapons: ", weapon
PRINT "Slots: ", maxslots
PRINT : PRINT "Press a key to roll again, or Y to keep..."
statkeep$ = INPUT$(1)
IF UCASE$(statkeep$) = "Y" THEN
        GOTO 8
ELSE
        GOTO 5
END IF
8 CLS
PRINT "Name: ", " "; shipname$
PRINT "Type: ", " "; shiptype$
PRINT "Integrity: ", teg
PRINT "Speed: ", spd
PRINT "Weapons: ", weapon
PRINT "Slots: ", maxslots
PRINT "Computer: ", comp; "%"
PRINT : PRINT "Press a key to keep, or N to do again..."
allkeep$ = INPUT$(1)
IF UCASE$(allkeep$) = "N" THEN
        GOTO 4
ELSE
        slots = maxslots: shipmade = 1: GOTO 2
END IF

9 REM Start of Level
IF level = 20 THEN GOSUB starbase
x = 155: cspd = 1
rounds = level + 2
cround = 0
shots = 0
hits = 0
points = 0
cwep = 1
10 REM Start of Round
CLS : SCREEN 7
won = 0
IF lives <= 0 THEN GOSUB dead
badhp = INT(RND * level) + 1
badx = INT(RND * 100) + 51
cbadhp = badhp: hewins = 0
hp = teg: badcannonlv = INT(RND * (level - 6)) + 1
badjump = INT(RND * level) - 5
IF badjump <= 0 THEN badjump = 1

IF badcannonlv <= 0 THEN badcannonlv = 1
COLOR 15: LOCATE 11, 15: PRINT "Level"; level
COLOR 15: LOCATE 13, 13: PRINT "Round"; cround + 1; "of"; rounds
COLOR 15: LOCATE 15, 13: PRINT "Lives:"; lives
SLEEP 1: CLS

DO
hit$ = INKEY$
IF shiptype$ = "200X - Starfire" THEN
        dacolors = 9: aimers = 5
END IF
IF shiptype$ = "660C - Hellblaze" THEN
        dacolors = 4: aimers = 3
END IF
IF shiptype$ = "3000Z - Ironhall" THEN
        dacolors = 8: aimers = 11
END IF
LINE (x, 185)-(x + 10, 190), dacolors, BF              'Draws Ship
LINE (x - 1, 182)-(x - 2, 191), aimers, BF
LINE (x + 11, 182)-(x + 12, 191), aimers, BF

LINE (x - 3, 182)-(x - 3 - cspd, 191), 0, BF           'Covers up
LINE (x + 13, 182)-(x + 13 + cspd, 191), 0, BF
LINE (x, 182)-(x + 10, 184), 0, BF
LINE (x, 191)-(x + 10, 191), 0, BF

IF cbadhp > badhp / 2 THEN badcolor = 10
IF cbadhp <= badhp / 2 THEN badcolor = 12
LINE (badx, 98)-(badx + 6, 102), badcolor, BF        'Draws Badguy

LINE (badx - 1, 98)-(badx - 2 - badjump, 102), 0, BF    'Covers up badguy
LINE (badx + 6, 98)-(badx + 7 + badjump, 102), 0, BF

LOCATE 1, 1: COLOR 15: PRINT "Dmg:   ", hp; "/"; teg
LOCATE 2, 1: PRINT "Speed:", cspd; "/"; spd
LOCATE 3, 1
IF cwep = 1 THEN PRINT "Fat Missle:", fat
IF cwep = 2 THEN PRINT "Heat Seekers:", heat
IF cwep = 3 THEN PRINT "Spreaders:", spread
IF cwep = 4 THEN PRINT "Ion Torpedos:", ion
REM COLOR 15: LOCATE 2, 1: PRINT cspd
LOCATE 4, 1: PRINT cbadhp; "/"; badhp




IF hit$ = "[" THEN
        cspd = cspd - 1
        IF cspd <= 0 THEN cspd = 1
END IF
IF hit$ = "]" THEN
        cspd = cspd + 1
        IF cspd > spd THEN cspd = spd
END IF
IF hit$ = "4" THEN
        x = x - cspd
        IF x <= 5 THEN x = 5
END IF
IF hit$ = "6" THEN
        x = x + cspd
        IF x >= 270 THEN x = 270
END IF
IF hit$ = "0" THEN
        cannonwd = (cannonlv - 1)
        cannwd = INT(cannonwd / 2)
        LINE (x - 1, 184)-(x + 5, 170), 4
        LINE (x + 11, 184)-(x + 5, 170), 4
        LINE (x + 5 - cannwd, 170)-(x + 5 + cannwd, 93), 4, BF
        PLAY "mfo3l32abal48d"
        shots = shots + 1
        CLS
        IF x - 1 - cannwd <= badx AND x + 11 + cannwd >= badx + 6 THEN
                cbadhp = cbadhp - INT((RND * weapon) + 1)
                IF cbadhp <= 0 THEN won = 1
                hits = hits + 1
        END IF
END IF
IF hit$ = "+" THEN
        IF cwep = 1 AND fat > 0 THEN
                FOR fatgo = 184 TO 90 STEP -1
                LINE (x - 4, fatgo)-(x + 14, fatgo - 4), 9, BF
                LINE (x - 4, fatgo + 1)-(x + 14, fatgo + 1), 0
                NEXT fatgo
                slots = slots + 1: shots = shots + 1: fat = fat - 1
                PLAY "mfo2l32abo5cdd"
                IF x - 10 <= badx AND x + 20 >= badx + 6 THEN
                        cbadhp = cbadhp - INT((RND * 7) + 2)
                        IF cbadhp <= 0 THEN won = 1
                        hits = hits + 1
                END IF
        END IF
        IF cwep = 2 AND heat > 0 THEN
                heatseekchk = INT(RND * 100) + 1
                startwhere = INT(RND * 2) + 1
                IF startwhere = 1 THEN heaterx = x - 1
                IF startwhere = 2 THEN heaterx = x + 11
                shots = shots + 1: heat = heat - 1: slots = slots + 1
                IF heatseekchk <= comp THEN
                        LINE (heaterx, 184)-(badx + 3, 100), 4
                        hits = hits + 1: cbadhp = cbadhp - INT((RND * 12) + 1)
                        IF cbadhp <= 0 THEN won = 1
                ELSE
                        IF startwhere = 1 THEN LINE (heaterx, 184)-(badx + RND * 10, 104 + RND * 6), 4
                        IF startwhere = 2 THEN LINE (heaterx, 184)-(badx - RND * 10, 104 + RND * 6), 4
                END IF
                PLAY "mfo5l32bbdac"
        END IF
        IF cwep = 3 AND spread > 0 THEN
                sider = 1: sprds = 0
                FOR spreadkill = 183 TO 95 STEP -2
                        LINE (x + 5 - sider, spreadkill)-(x + 5 + sider, spreadkill + 1), 4, BF
                        IF spreadkill = 101 AND x - 1 - sider <= badx AND x + 11 + sider >= badx + 6 THEN sprds = 1
                        sider = sider + 1
                NEXT spreadkill
                PLAY "mfo3l20bacbde": shots = shots + 1: spread = spread - 1: slots = slots + 1
                IF sprds = 1 THEN
                        hits = hits + 1: cbadhp = cbadhp - INT((RND * 10) + 5)
                        IF cbad <= 0 THEN won = 1
                END IF
        END IF
        IF cwep = 4 AND ion > 0 THEN
                FOR ionline = 183 TO 100 STEP -1
                        PSET (x + 5, ionline), 1
                        FOR slowion = 1 TO 10: NEXT slowion
                NEXT ionline
                FOR majorwait = 1 TO 1000: NEXT majorwait
                sizeofexo = INT(RND * 30) + 31
                FOR ahhh = 1 TO sizeofexo
                        CIRCLE (x + 5, 100), ahhh, 12
                        FOR gogoion = 1 TO 40: NEXT gogoion
                NEXT ahhh
                PLAY "mfo2l20bdfe<adl64cea"
                radius = INT(sizeofexo / 2)
                shots = shots + 1: ion = ion - 1: slots = slots + 1
                IF x - 1 - sizeofexo <= badx AND x + 14 + sizeofexo >= badx + 6 THEN
                        dadam = INT(RND * 8) + 7
                        cbadhp = cbadhp - dadam: hits = hits + 1
                        IF cbadhp <= 0 THEN won = 1
                END IF
        END IF
        CLS
END IF
IF hit$ = "'" THEN
        cwep = cwep + 1
        IF cwep >= 5 THEN cwep = 1
END IF
IF hit$ = ";" THEN
        cwep = cwep - 1
        IF cwep <= 0 THEN cwep = 4
END IF
IF UCASE$(hit$) = "P" THEN
        pausekol = 15
        DO
                pch = INT(RND * 250) + 1
                IF pch = 1 THEN pausekol = INT(RND * 13) + 1
                LOCATE 5, 16: COLOR pausekol
                PRINT "-Paused-"
        LOOP UNTIL UCASE$(INKEY$) = "P"
        CLS
END IF
IF UCASE$(hit$) = "I" THEN
        GOSUB inv
END IF
IF won = 1 THEN
        FOR exo = 1 TO (45 + (2 * level))
                CIRCLE (badx + 2, 100), exo, 4
        NEXT exo
        PLAY "mfo4l60bbdl64<<fa>dd"
        points = points + 1
        cround = cround + 1
        money = money + INT(75 + (level * 4))
        IF cround < rounds GOTO 10
END IF
IF level >= 1 AND level <= 5 THEN badderspd = 6
IF level >= 6 AND level <= 11 THEN badderspd = 5
IF level >= 12 AND level <= 16 THEN badderspd = 3
IF level >= 17 AND level <= 19 THEN badderspd = 2
badmovechk = badmovechk + 1
IF badmovechk = badderspd THEN
        badmove = INT(RND * 6) + 1
        IF badjump <= 0 THEN badjump = 1
        IF badmove <= 5 THEN badx = badx + badjump
        IF badmove = 6 THEN badx = badx - badjump
        badmovechk = 0
        IF badx >= 270 THEN
                cround = cround + 1
                GOTO 10
        END IF
        IF badx <= 5 THEN badx = 5
END IF
badaim = INT(RND * 600) + 1
IF level >= 5 AND badaim <= level THEN
        bcannonwd = (badcannonlv - 1)
        bcannwd = INT(bcannonwd / 2)
        LINE (badx + 3 - bcannwd, 103)-(badx + 3 + bcannwd, 197), 12, BF
        PLAY "mfo2l32bdc"
        IF badx + 3 - 14 - bcannwd <= x - 2 AND badx + 3 + 14 + bcannwd >= x + 14 THEN
                baddam = INT(RND * level) - 3
                IF baddam <= 0 THEN baddam = 1
                hp = hp - baddam
                IF hp <= 0 THEN hewins = 1
        END IF
        CLS
END IF

IF hewins = 1 THEN
        CIRCLE (x + 5, 187), RND * (level * 2) + 35, 4
        PAINT (x + 5, 187), 4, 4
        PLAY "mfo4l16bfl32de<fal16>>aedc"
        cround = cround + 1
        IF cround < rounds GOTO 10
        lives = lives - 1
END IF


LOOP UNTIL cround = rounds



CLS : SCREEN 9
accuracy = INT((hits / shots) * 100)
accuracy2 = INT((points / rounds) * 100)
COLOR 5: PRINT "Weapon Information:"
COLOR 15: PRINT "Shots:", , shots: PRINT "Hits:", , hits: PRINT "Accuracy:", , accuracy; "%"
PRINT "Needed: ", , 20 + INT((level * 3) / 2); "%"
COLOR 5: PRINT "Level Information:"
COLOR 15: PRINT "Rounds:", , rounds: PRINT "Wins:", , points: PRINT "Loses:", , rounds - points: PRINT "Total Accuracy:", accuracy2; "%"
PRINT "Needed: ", , 50 + (level * 2); "%"
PRINT
IF accuracy2 >= 50 + (level * 2) AND accuracy >= 20 + INT((level * 3) / 2) THEN
        COLOR 2: PRINT "You advance to the next level."
        IF accuracy >= 100 AND accuracy >= 100 THEN
                bonusm = (level * 10) + 400: money = money + bonusm
                PRINT "You gain a bonus of"; bonusm; "dollars."
        END IF
        level = level + 1: PLAY "mbo4l16abdeec": tmoney = tmoney + money
ELSE
        COLOR 4: PRINT "You must do this level again."
        PLAY "mbo2l16eddl32feac"
END IF
PRINT : COLOR 15: GOSUB pause

100 GOSUB store

END

store:
CLS : SCREEN 9: COLOR 15
PRINT "                     Battle Zone War Shop"
PRINT "---------------------------------------------------------------"
PRINT "#  Name                  Cost              # of Slots    Damage"
PRINT "---------------------------------------------------------------"
PRINT "1) Speed Upgrade         $1000 *"; spd + 1
PRINT "2) Weapon Upgrade        $2300 *"; weapon + 1
PRINT "3) Additional Slot       $500 Per Slot"
PRINT "4) Integrity Upgrade     $2500 Per Point"
PRINT "5) Computer Upgrade      $400 A Point"
PRINT "6) Cannon Upgrade        $2200 *"; cannonlv + 1
PRINT "7) Fat Missle            $350              1             2-8"
PRINT "8) Heat Seeker           $600              1             1-12"
PRINT "9) Spreader              $850              2             4-14"
PRINT "10) Ion Torpedo          $1000             2             6-14"
PRINT "11) Inventory"
PRINT "12) Leave Store"
PRINT "13) Goto Main Menu"
IF level >= 12 AND shiptype$ <> "660C - Hellblaze" THEN
        COLOR 14: PRINT "14) 660C - Hellblaze     $25,000"
END IF
IF level >= 16 AND shiptype$ <> "3000Z - Ironhall" THEN
        COLOR 14: PRINT "15) 3000Z - Ironhall     $40,000"
END IF
COLOR 13: PRINT "Money:"; money: COLOR 15
INPUT "Selection: ", shop
IF shop = 1 THEN
        IF money >= 1000 * (spd + 1) THEN
                spd = spd + 1: money = money - 1000 * spd
        ELSE
                GOTO 250
        END IF
END IF
IF shop = 2 THEN
        IF money >= 2300 * (weapon + 1) AND weapon < 11 THEN
                money = money - 2300 * weapon: weapon = weapon + 1
        END IF
        IF money >= 2300 * (weapon + 1) AND weapon > 10 THEN
                COLOR 4: PRINT : PRINT "This is the maximum weapon level.": PRINT : GOSUB pause
        END IF
        IF money < 2300 * (weapon + 1) THEN 250
        
END IF
IF shop = 3 THEN
        IF money >= 500 THEN
                money = money - 500: maxslots = maxslots + 1: slots = slots + 1
        ELSE
                GOTO 250
        END IF
END IF
IF shop = 4 THEN
        IF money >= 2500 * (teg + 1) AND teg < 21 THEN
                teg = teg + 1: money = money + 2500 * teg
        END IF
        IF money >= 2500 * (teg + 1) AND teg > 20 THEN
                PRINT : COLOR 4: PRINT "This is the maximum integrity level.": PRINT : GOSUB pause
        END IF
        IF money < 2500 * (teg + 1) THEN 250
END IF
IF shop = 5 THEN
        IF money >= 400 AND comp <= 94 THEN
                money = money - 300: comp = comp + 1
        END IF
        IF money >= 400 AND comp > 94 THEN
                COLOR 4: PRINT : PRINT "This is the maximum computer rating.": PRINT : GOSUB pause
        END IF
        IF money < 400 THEN 250
END IF
IF shop = 6 THEN
        IF money >= 2200 * (cannonlv + 1) AND cannonlv <= 19 THEN
                cannonlv = cannonlv + 1: money = money - 2200 * cannonlv
        END IF
        IF money >= 2200 * (cannonlv + 1) AND cannonlv > 20 THEN
                PRINT : COLOR 4: PRINT "This is the maximum cannon level.": PRINT : GOSUB pause
        END IF
        IF money < 2200 * (cannonlv + 1) THEN 250
END IF
IF shop = 7 THEN
        IF money >= 350 AND slots > 0 THEN
                fat = fat + 1: money = money - 350: slots = slots - 1
        ELSE
                GOTO 250
        END IF
END IF
IF shop = 8 THEN
        IF money >= 600 AND slots > 0 THEN
                money = money - 600: heat = heat + 1: slots = slots - 1
        ELSE
                GOTO 250
        END IF
END IF
IF shop = 9 THEN
        IF money >= 850 AND slots > 1 THEN
                money = money - 850: spread = spread + 1: slots = slots - 2
        ELSE
                GOTO 250
        END IF
END IF
IF shop = 10 THEN
        IF money >= 1000 AND slots > 1 THEN
                money = money - 1000: slots = slots - 2: ion = ion + 1
        ELSE
                GOTO 250
        END IF
END IF
IF shop = 14 AND level >= 12 THEN
        IF money >= 25000 THEN
                shiptype$ = "660C - Hellblaze"
                teg = teg + 5: spd = spd + 4: maxslots = maxslots + 4: weapon = weapon + 5
                IF comp < 95 THEN
                        comp = comp + 10
                        IF comp >= 95 THEN comp = 95
                END IF
        ELSE
                GOTO 250
        END IF
END IF
IF shop = 15 AND level >= 16 THEN
        IF money >= 40000 THEN
                shiptype$ = "3000Z - Ironhall"
                teg = teg + 7: spd = spd + 5: maxslots = maxslots + 8: weapon = weapon + 8
                IF comp < 95 THEN
                        comp = comp + 18
                        IF comp >= 95 THEN comp = 95
                END IF
        ELSE
                GOTO 250
        END IF
END IF
IF shop = 11 THEN GOSUB inv
IF shop = 12 THEN 9
IF shop = 13 THEN 2
GOSUB store

250 COLOR 4: PRINT : PRINT "You do not have enough money or slots!"
PRINT : GOSUB pause: GOSUB store


inv:
        CLS : COLOR 15: SCREEN 9
        PRINT "Name: ", , " "; shipname$
        PRINT "Type: ", , " "; shiptype$
        PRINT "Money: ", , money
        PRINT "Integrity: ", , teg
        PRINT "Speed: ", , spd
        PRINT "Weapons: ", , weapon
        PRINT "Slots: ", , slots; "/"; maxslots
        PRINT "Cannon Level:", , cannonlv
        PRINT "Computer: ", , comp; "%"
        IF fat > 0 THEN PRINT "Fat Missles: ", , fat
        IF heat > 0 THEN PRINT "Heat Seekers: ", heat
        IF spread > 0 THEN PRINT "Spreaders: ", , spread
        IF ion > 0 THEN PRINT "Ion Torpedos: ", , ion
PRINT : GOSUB pause
CLS : SCREEN 7
RETURN



mynameend:
CLS : SCREEN 9
FOR seeyah = 1 TO 25
FOR byebye = 105 TO 300 STEP 5
        CIRCLE (320, 160), byebye, RND * 13 + 1
        CIRCLE (320, 160), byebye - 5, RND * 13 + 1
        COLOR RND * 13 + 1
        LOCATE 10, 34: PRINT "Produced By"
        LOCATE 12, 35: PRINT "Adam Moses"
        LOCATE 14, 33: PRINT "Copyright 1996"
NEXT byebye
NEXT seeyah
END




pause:
COLOR 15: PRINT "Press any key to continue..."
DO
LOOP UNTIL INKEY$ <> ""
RETURN

instruct:
CLS : SCREEN 9: COLOR 15
LOCATE 1, 25: PRINT "Battle Zone Instruction Manual"
FOR sters = 1 TO 80: PRINT "-"; : NEXT sters
PRINT
PRINT "         The alien race, Donarks, are attacking Earth.  You have been hired by"
PRINT "the Earth Defensive Army to drive out the Donarks.  You and you trusty"
PRINT "Starfire will head out into deep space.  You will battle through the small"
PRINT "gaurdians, which will increasingly become harder, and then go one on one"
PRINT "with the Donark Battle Base, a huge, sheilded, laser armed star base."
PRINT : GOSUB pause: CLS
PRINT "Ship Statistics:"
PRINT "Integrity: How much damage your ship can sustain before it is destroyed."
PRINT "Speed: How fast you can go across the screen."
PRINT "Slots: The number of spaces avabile for weapons to be put.  Each time you buy"
PRINT "  buy a weapon it takes up a number of spaces listed under slots in the store."
PRINT "  When you fire a weapon it makes another space avabile."
PRINT "Weapon: How damaging your main laser is."
PRINT "Computer: The percentage chance your use of heat seekers will hit."
PRINT "Cannon Level: The size of your main laser.  Note: An increase will not"
PRINT "  increase the damage level of the laser."
PRINT : GOSUB pause: CLS
PRINT "Commands: (Numlock On)"
PRINT "Go Left:         4"
PRINT "Go Right:        6"
PRINT "Fire Laser:      0 (Ins)"
PRINT "Increase Speed:  ]"
PRINT "Decrease Speed:  ["
PRINT "Next Weapons:    '"
PRINT "Previous Weapon: ;"
PRINT "Fire Weapon:     +"
PRINT "Pause:           P (P Again to Unpause)"
PRINT "View Inventory:  I"
PRINT : GOSUB pause: CLS
PRINT "Inflight Instructions:"
PRINT "At the top of screen is displayed the following data:"
PRINT "Dmg: This has two parts, the first part is your current ship strength, and the"
PRINT "  second is the number of ship at full strength.  If this number drops below one"
PRINT "  then your ship has ruptured and you have been destroyed."
PRINT "Speed: This also has two parts.  The first is your current speed, which is set"
PRINT "  to 1 at the start of each level.  The second is your ship's maximum speed."
PRINT "  remember you can use the [ and ] keys to increase and decrease speed."
PRINT "Weapon Status: This displays the weapon you are currently using.  To scroll"
PRINT "  through weapons you can use the ; and ' keys.  It displays the current"
PRINT "  weapon and the number of them you have."
PRINT
PRINT "Additional Note: When the enemy changes color from a green to a light cyan"
PRINT "  is a sign that he has sustained a major amount of damage and is soon to die"; ""
PRINT ""
PRINT
PRINT "Press P to print, or any key to continue..."

DO
        inss$ = INKEY$
        IF UCASE$(inss$) = "P" THEN
LPRINT TAB(25); "Battle Zone Instruction Manual"
FOR sters = 1 TO 80: LPRINT "-"; : NEXT sters
LPRINT
LPRINT "         The alien race, Donarks, are attacking Earth.  You have been hired by"
LPRINT "the Earth Defensive Army to drive out the Donarks.  You and you trusty"
LPRINT "Starfire will head out into deep space.  You will battle through the small"
LPRINT "gaurdians, which will increasingly become harder, and then go one on one"
LPRINT "with the Donark Battle Base, a huge sheilded and laser armed base.  Good Luck"
LPRINT
LPRINT "Ship Statistics:"
LPRINT "Integrity: How much damage your ship can sustain before it is destroyed."
LPRINT "Speed: How fast you can go across the screen."
LPRINT "Slots: The number of spaces where weapons my be put."
LPRINT "Weapon: How damaging your main laser is."
LPRINT "Computer: The percentage chance your use of heat seekers will hit."
LPRINT "Cannon Level: The size of your main laser.  Note: An increase will not"
LPRINT "  increase the damage level of the laser."
LPRINT
LPRINT "Commands: (Numlock On)"
LPRINT "Go Left:         4"
LPRINT "Go Right:        6"
LPRINT "Fire Laser:      0 (Ins)"
LPRINT "Increase Speed:  ]"
LPRINT "Decrease Speed:  ["
LPRINT "Next Weapons:    '"
LPRINT "Previous Weapon: ;"
LPRINT "Fire Weapon:     +"
LPRINT "Pause:           P (P Again to Unpause)"
LPRINT "View Inventory:  I"
LPRINT
LPRINT "Inflight Instructions:"
LPRINT "At the top of screen is displayed the following data:"
LPRINT "Dmg: This has two parts, the first part is your current ship strength, and the"
LPRINT "  second is the number of ship at full strength.  If this number drops below one"
LPRINT "  then your ship has ruptured and you have been destroyed."
LPRINT "Speed: This also has two parts.  The first is your current speed, which is set to"
LPRINT "  1 at the start of each level.  The second is your ship's maximum speed.  Remember"
LPRINT "  you can use the [ and ] keys to increase and decrease speed."
LPRINT "Weapon Status: This displays the weapon you are currently using.  To scroll through"
LPRINT "  weapons you can use the ; and ' keys.  It displays the current weapon and the"
LPRINT "  number of them you have."
LPRINT : LPRINT "Additional Note: When the enemy changes color from a green to a light cyan this"
LPRINT "  is a sign that he has sustained a major amount of damage and is soon to die."
COLOR 8: PRINT "Printing started.";
FOR coolprint = 1 TO 16: PRINT "."; : FOR coolprintw = 1 TO 600: NEXT coolprintw: NEXT coolprint
END IF

LOOP WHILE inss$ = ""
CLS
GOTO 2

9090 PRINT : COLOR 4: PRINT "Invalid Shipname."
PRINT : GOSUB pause
RESUME 2


starbase:
CLS
SCREEN 9: COLOR 15
FOR gomesses = 1 TO 7
        IF gomesses = 1 THEN mess$ = "Incoming message from Earth Defensive Army Headquarters......."
        IF gomesses = 2 THEN mess$ = "          Our sonar has detected the Donark Battle Base only"
        IF gomesses = 3 THEN mess$ = "a few kilometers from your postion.  Your orders are to proceed"
        IF gomesses = 4 THEN mess$ = "to intercept it and destory it.  WARNING: Our reports indicate that"
        IF gomesses = 5 THEN mess$ = "the base has highly dense sheilding and an array of four main laser"
        IF gomesses = 6 THEN mess$ = "cannons that can easily destroy you."
        IF gomesses = 7 THEN mess$ = "End Transmission"
        messlong = LEN(mess$)
        FOR typemess = 1 TO messlong
                curmess$ = MID$(mess$, typemess, 1)
                PRINT curmess$;
                FOR waitonin = 1 TO 600: NEXT waitonin
                PLAY "mfo1l64e"
        NEXT typemess
        PRINT
        IF gomesses = 6 OR gomesses = 1 THEN
                SLEEP 1: PRINT
        END IF
NEXT gomesses
PRINT : GOSUB pause
CLS : SCREEN 7
FOR starfeild = 1 TO 200
        PSET (RND * 320, RND * 200), 15
NEXT starfeild
badx = 120: GOSUB drawbase
LOCATE 16, 17: COLOR 15: PRINT "Level 20"
LOCATE 17, 11: FOR goders = 1 TO 20: PRINT "-"; : NEXT goders
LOCATE 18, 12: PRINT "Donark Battle Base"
PLAY "mfl16abdecel8<<adea>l32ffecade>adel4ddl16feadecc"
REM Start of Level 20
x = 155: cspd = 1
rounds = 1
cround = 0
shots = 0
hits = 0
points = 0
cwep = 1
REM Start of Round
CLS : SCREEN 7
won = 0
badhp = 80
badx = 120
cbadhp = badhp: hewins = 0
hp = teg: badcannonlv = 2
badjump = 2
REM  COLOR 15: LOCATE 11, 15: PRINT "Level"; level
REM COLOR 15: LOCATE 13, 13: PRINT "Round"; cround + 1; "of"; rounds
SLEEP 1: CLS

DO
badmid = badx + 40
hit$ = INKEY$
IF shiptype$ = "200X - Starfire" THEN
        dacolors = 9: aimers = 5
END IF
IF shiptype$ = "660C - Hellblaze" THEN
        dacolors = 4: aimers = 3
END IF
IF shiptype$ = "3000Z - Ironhall" THEN
        dacolors = 8: aimers = 11
END IF

LINE (x, 185)-(x + 10, 190), dacolors, BF              'Draws Ship
LINE (x - 1, 182)-(x - 2, 191), aimers, BF
LINE (x + 11, 182)-(x + 12, 191), aimers, BF

LINE (x - 3, 182)-(x - 3 - cspd, 191), 0, BF           'Covers up
LINE (x + 13, 182)-(x + 13 + cspd, 191), 0, BF
LINE (x, 182)-(x + 10, 184), 0, BF
LINE (x, 191)-(x + 10, 191), 0, BF
pulses = INT(RND * 3) + 1
IF pulses = 1 THEN pulse = 4
IF pulses = 2 THEN pulse = 11
IF pulses = 3 THEN pulse = 3
GOSUB drawbase

LOCATE 1, 1: COLOR 15: PRINT "Dmg:   ", hp; "/"; teg
LOCATE 2, 1: PRINT "Speed:", cspd; "/"; spd
LOCATE 3, 1
IF cwep = 1 THEN PRINT "Fat Missle:", fat
IF cwep = 2 THEN PRINT "Heat Seekers:", heat
IF cwep = 3 THEN PRINT "Spreaders:", spread
IF cwep = 4 THEN PRINT "Ion Torpedos:", ion
REM COLOR 15: LOCATE 2, 1: PRINT cspd
LOCATE 4, 1: PRINT cbadhp; "/"; badhp




IF hit$ = "[" THEN
        cspd = cspd - 1
        IF cspd <= 0 THEN cspd = 1
END IF
IF hit$ = "]" THEN
        cspd = cspd + 1
        IF cspd > spd THEN cspd = spd
END IF
IF hit$ = "4" THEN
        x = x - cspd
        IF x <= 5 THEN x = 5
END IF
IF hit$ = "6" THEN
        x = x + cspd
        IF x >= 270 THEN x = 270
END IF
IF hit$ = "0" THEN
        cannonwd = (cannonlv - 1)
        cannwd = INT(cannonwd / 2)
        LINE (x - 1, 184)-(x + 5, 170), 4
        LINE (x + 11, 184)-(x + 5, 170), 4
        LINE (x + 5 - cannwd, 170)-(x + 5 + cannwd, 93), 4, BF
        PLAY "mfo3l32abal48d"
        shots = shots + 1
        CLS
        IF x - 80 - cannwd <= badx AND x + 80 + cannwd >= badx + 80 THEN
                cbadhp = cbadhp - INT((RND * weapon) + 1)
                IF cbadhp <= 0 THEN won = 1
                hits = hits + 1
        END IF
END IF
IF hit$ = "+" THEN
        IF cwep = 1 AND fat > 0 THEN
                FOR fatgo = 184 TO 90 STEP -1
                LINE (x - 4, fatgo)-(x + 14, fatgo - 4), 9, BF
                LINE (x - 4, fatgo + 1)-(x + 14, fatgo + 1), 0
                NEXT fatgo
                slots = slots + 1: shots = shots + 1: fat = fat - 1
                PLAY "mfo2l32abo5cdd"
                IF x - 10 - 80 <= badx AND x + 20 + 80 >= badx + 80 THEN
                        cbadhp = cbadhp - INT((RND * 7) + 2)
                        IF cbadhp <= 0 THEN won = 1
                        hits = hits + 1
                END IF
        END IF
        IF cwep = 2 AND heat > 0 THEN
                heatseekchk = INT(RND * 100) + 1
                startwhere = INT(RND * 2) + 1
                IF startwhere = 1 THEN heaterx = x - 1
                IF startwhere = 2 THEN heaterx = x + 11
                shots = shots + 1: heat = heat - 1: slots = slots + 1
                IF heatseekchk <= comp THEN
                        LINE (heaterx, 184)-(badx + 40, 100), 4
                        hits = hits + 1: cbadhp = cbadhp - INT((RND * 12) + 1)
                        IF cbadhp <= 0 THEN won = 1
                ELSE
                        IF startwhere = 1 THEN LINE (heaterx, 184)-(badx + RND * 20, 104 + RND * 6 + 8), 4
                        IF startwhere = 2 THEN LINE (heaterx, 184)-(badx - RND * 20, 104 + RND * 6 + 8), 4
                END IF
                PLAY "mfo5l32bbdac"
        END IF
        IF cwep = 3 AND spread > 0 THEN
                sider = 1: sprds = 0
                FOR spreadkill = 183 TO 95 STEP -2
                        LINE (x + 5 - sider, spreadkill)-(x + 5 + sider, spreadkill + 1), 4, BF
                        IF spreadkill = 101 AND x - 1 - sider - 80 <= badx AND x + 11 + sider + 80 >= badx + 80 THEN sprds = 1
                        sider = sider + 1
                NEXT spreadkill
                PLAY "mfo3l20bacbde": shots = shots + 1: spread = spread - 1: slots = slots + 1
                IF sprds = 1 THEN
                        hits = hits + 1: cbadhp = cbadhp - INT((RND * 10) + 5)
                        IF cbadhp <= 0 THEN won = 1
                END IF
        END IF
        IF cwep = 4 AND ion > 0 THEN
                FOR ionline = 183 TO 100 STEP -1
                        PSET (x + 5, ionline), 1
                        FOR slowion = 1 TO 10: NEXT slowion
                NEXT ionline
                FOR majorwait = 1 TO 1000: NEXT majorwait
                sizeofexo = INT(RND * 30) + 31
                FOR ahhh = 1 TO sizeofexo
                        CIRCLE (x + 5, 100), ahhh, 12
                        FOR gogoion = 1 TO 40: NEXT gogoion
                NEXT ahhh
                PLAY "mfo2l20bdfe<adl64cea"
                radius = INT(sizeofexo / 2)
                shots = shots + 1: ion = ion - 1: slots = slots + 1
                IF x - 1 - sizeofexo - 80 <= badx AND x + 14 + sizeofexo + 80 >= badx + 80 THEN
                        dadam = INT(RND * 8) + 7
                        cbadhp = cbadhp - dadam: hits = hits + 1
                        IF cbadhp <= 0 THEN won = 1
                END IF
        END IF
        CLS
END IF
IF hit$ = "'" THEN
        cwep = cwep + 1
        IF cwep >= 5 THEN cwep = 1
END IF
IF hit$ = ";" THEN
        cwep = cwep - 1
        IF cwep <= 0 THEN cwep = 4
END IF
IF UCASE$(hit$) = "P" THEN
        pausekol = 15
        DO
                pch = INT(RND * 250) + 1
                IF pch = 1 THEN pausekol = INT(RND * 13) + 1
                LOCATE 5, 16: COLOR pausekol
                PRINT "-Paused-"
        LOOP UNTIL UCASE$(INKEY$) = "P"
        CLS
END IF
IF UCASE$(hit$) = "I" THEN
        GOSUB inv
END IF
IF won = 1 THEN
        FOR exo = 1 TO (45 + (2 * level))
                CIRCLE (badx + 2, 100), exo, 4
        NEXT exo
        PLAY "mfo4l60bbdl64<<fa>dd"
        points = points + 1
        cround = cround + 1
        money = money + INT(75 + (level * 4))
        GOSUB winner
END IF
badderspd = 8
badmovechk = badmovechk + 1
IF badmovechk = badderspd THEN
        badmove = INT(RND * 2) + 1
        IF badmove = 1 THEN badx = badx + badjump
        IF badmove = 2 THEN badx = badx - badjump
        badmovechk = 0
        IF badx + 80 >= 270 THEN badx = 190
        IF badx <= 5 THEN badx = 5
END IF
badaim = INT(RND * 300) + 1
cannonp = INT(RND * 4) + 1
IF level >= 5 AND badaim <= level THEN
        IF cannonp = 1 THEN cannonx = badx + 5
        IF cannonp = 2 THEN cannonx = badx + 75
        IF cannonp = 3 THEN cannonx = badmid - 13
        IF cannonp = 4 THEN cannonx = badmid + 13
        LINE (cannonx - 1, 113)-(cannonx + 1, 195), 4, BF
        IF cannonx - 1 - 14 <= x - 2 AND cannonx + 1 + 14 >= badx + 14 THEN
                baddam = INT(RND * 5) + 1
                hp = hp - baddam
                IF hp <= 0 THEN hewins = 1
        END IF
        PLAY "mfo5l32abdl64o3feab"
        CLS
END IF

IF hewins = 1 THEN
        CIRCLE (x + 5, 187), RND * (level * 2) + 35, 4
        PAINT (x + 5, 187), 4, 4
        PLAY "mfo4l16bfl32de<fal16>>aedc"
        cround = cround + 1
        IF cround < rounds GOTO 10
        IF lives <= 0 THEN GOSUB dead
END IF


LOOP UNTIL cround = rounds

END



drawbase:
badmid = badx + 40
IF pulse = 0 THEN pulse = 4
LINE (badx, 50)-(badx + 80, 105), 8, BF
LINE (badx + 30, 50)-(badx + 50, 105), 12, BF
LINE (badx + 2, 106)-(badx + 8, 112), 1, BF
LINE (badx + 78, 106)-(badx + 72, 112), 1, BF
LINE (badmid - 10, 106)-(badmid - 16, 112), 1, BF
LINE (badmid + 10, 106)-(badmid + 16, 112), 1, BF
CIRCLE (badmid, 49), 30, pulse, 0, 3.14159
LINE (badmid - 30, 49)-(badmid + 30, 49), pulse
PAINT (badmid, 48), pulse, pulse
LINE (badx - 1, 50)-(badx - 2, 105), 0, BF
LINE (badx + 81, 50)-(badx + 82, 105), 0, BF
CIRCLE (badmid, 49), 31, 0, 0, 3.14159
CIRCLE (badmid, 49), 32, 0, 0, 3.14159
LINE (badx, 106)-(badx + 1, 112), 0, BF
LINE (badx + 9, 106)-(badmid - 17, 112), 0, BF
LINE (badmid - 9, 106)-(badmid + 9, 112), 0, BF
LINE (badmid + 17, 106)-(badx + 71, 112), 0, BF
LINE (badx + 79, 106)-(badx + 80, 112), 0, BF
RETURN


dead:
CLS : SCREEN 9
FOR watchdead = 30 TO 200 STEP 2
x = watchdead: cspd = 2

IF shiptype$ = "200X - Starfire" THEN
        dacolors = 9: aimers = 5
END IF
IF shiptype$ = "660C - Hellblaze" THEN
        dacolors = 4: aimers = 3
END IF
IF shiptype$ = "3000Z - Ironhall" THEN
        dacolors = 8: aimers = 11
END IF

LINE (x, 185)-(x + 10, 190), dacolors, BF              'Draws Ship
LINE (x - 1, 182)-(x - 2, 191), aimers, BF
LINE (x + 11, 182)-(x + 12, 191), aimers, BF

LINE (x - 3, 182)-(x - 3 - cspd, 191), 0, BF           'Covers up
LINE (x + 13, 182)-(x + 13 + cspd, 191), 0, BF
LINE (x, 182)-(x + 10, 184), 0, BF
LINE (x, 191)-(x + 10, 191), 0, BF
NEXT watchdead
FOR yourdeadx = 1 TO 200
        CIRCLE (x + 5, 186), yourdeadx, 4
        FOR ouch = 1 TO 60: NEXT ouch
NEXT yourdeadx
PLAY "mbl16o4adeccfeca"
FOR adios = 1 TO 13
        beebee = INT(RND * 40) + 20
        FOR firefire = 1 TO beebee
                CIRCLE (RND * 320, RND * 200), beebee, 4
        NEXT firefire
        PLAY "mbo3l32abdeaddaedc"
NEXT adios
SLEEP 1: SLEEP 1: SLEEP 1
CLS
SCREEN 9: COLOR 15
PRINT "         The remains of your ship are found scattered across space.  The Earth"
PRINT "Defensive Army places you in there hall of fame.  Meanwhile the Donarks use"
PRINT "their battle base and destroy the remaining human bases.  Within a year the"
PRINT "Donarks enslave all of humanity and rule over the univerese with an iron fist."
PRINT : GOSUB pause
LOCATE INT(RND * 10) + 7, INT(RND * 80): COLOR RND * 13 + 1
PRINT "You Lost"
LOCATE 21, 1: GOSUB pause
CLS : shipmade = 0: GOTO 2

winner:
CLS : SCREEN 7
badx = 160: pulse = 4
GOSUB drawbase
FOR youkickedass = 1 TO 80
        CIRCLE (RND * 320, RND * 200), RND * 30 + 20, 4
        PLAY "mfl64o3abdece"
NEXT youkickedass
SLEEP 1: SLEEP 1: SLEEP 1
CLS : SCREEN 9: COLOR 15
FOR messers = 1 TO 6
        IF messers$ = 1 THEN cmess$ = "Incoming message from Earth Defensive Army......"
        IF messers$ = 2 THEN cmess$ = "         Congratulations on destroying the battle base.  You our"
        IF messers$ = 3 THEN cmess$ = "a hero among the people of Earth and the reward we offered you still"
        IF messers$ = 4 THEN cmess$ = "stands.  It is waiting make at Earth if you want it.  Once again,"
        IF messers$ = 5 THEN cmess$ = "thank you.  - Desk of General Balow"
        IF messers$ = 6 THEN cmess$ = "End Transmission"
        cmo = LEN(cmess$)
        FOR typemess = 1 TO cmo
                PRINT MID$(cmess$, cmo, 1);
                FOR waitonin = 1 TO 600: NEXT waitonin
                PLAY "mfo1l64e"
        NEXT typemess
        PRINT
        IF messers = 1 OR messers = 5 THEN
                SLEEP 1: PRINT
        END IF
NEXT messers
OPEN "batlzone.scr" FOR INPUT AS #1
        INPUT #1, ohighscore, oname$, opname$, ocomment$
CLOSE
IF tmoney > ohighscore THEN
        CLS : SCREEN 9: COLOR 15
        PRINT "You have made a new highscore!"
        INPUT "Enter Name: ", recname$
        INPUT "Enter Comment: ", comment$
        recname2$ = MID$(recname$, 1, 15)
        comment2$ = MID$(comment$, 1, 70)
        OPEN "batlzone.scr" FOR OUTPUT AS #1
                WRITE #1, tmoney, shipname$, recname2$, comment2$
        CLOSE
END IF
GOTO 2


inb:
level = 1
lives = 5
money = 0
cannonlv = 1
comp = 55
shipmade = 0
tmoney = 0
shiptype$ = "200X - Starfire"
RETURN

SUB instruct

END SUB

