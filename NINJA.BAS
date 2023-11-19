'                                   The
'                                 Ninjas
'                                  Saga
'
'       WizardWare Productions, 1996. Any Questions or comments may be
' E-mailed to me.
'                                           - Magus289 @ AOL
'
' ************************************************************************
'
'                               / = Status
'
'///////////////////////////////////   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

' All remarks below this one are for my own use. Ignore them if you want.

DECLARE SUB ClearLine ()
DECLARE SUB Sketch ()
DECLARE SUB Flick ()
DECLARE SUB Status ()
DECLARE SUB ChooseBox (Ind!, Ques$, Choice1$, Choice2$)
DECLARE SUB Dead ()
DECLARE SUB Fight ()
DECLARE SUB Throw ()
DECLARE SUB Ninja (x!, y!, Stance)
DECLARE SUB Wolf (x!, y!)
DECLARE SUB TalkBox (Clr!, Line1$, Line2$)
DECLARE SUB Intro ()
DIM SHARED Sword
DIM SHARED Armor
DIM SHARED Mnst
DIM SHARED Spr
DIM SHARED GOLD
DIM SHARED LEVEL
DIM SHARED XPER
Credit:
Cred = 1
CLS
TYPE DotType
x AS INTEGER
y AS INTEGER
col AS INTEGER
dir AS INTEGER
xp AS INTEGER
yp AS INTEGER
END TYPE
DEFINT A-Z
DIM SHARED dot(100) AS DotType
CLS
SCREEN 13
LINE (0, 0)-(319, 199), 31, B
RANDOMIZE TIMER
FOR y = 1 TO 100
dot(y).x = INT(RND * 320) + 1
dot(y).y = INT(RND * 200) + 1
DO UNTIL dot(y).col <> 31 AND dot(y).col <> 0
dot(y).col = INT(RND * 257) + 1
LOOP
dot(y).dir = INT(RND * 4) + 1
dot(y).xp = INT(RND * 3) + 1
dot(y).yp = INT(RND * 3) + 1
NEXT
COLOR 31
LOCATE 12, 9: PRINT "PLaSTiC PiTHaiR SoFTWaRe"
LOCATE 15, 10: PRINT "   The Ninja's Saga"
LOCATE 20, 10: PRINT "    Press Any Key"
DO UNTIL INKEY$ <> ""
FOR y = 1 TO 100
IF POINT(dot(y).x, dot(y).y) <> 31 THEN PSET (dot(y).x, dot(y).y), 0
SELECT CASE dot(y).dir
CASE 1: dot(y).x = dot(y).x + dot(y).xp
        dot(y).y = dot(y).y + dot(y).yp
CASE 2: dot(y).x = dot(y).x + dot(y).xp
        dot(y).y = dot(y).y - dot(y).yp
CASE 3: dot(y).x = dot(y).x - dot(y).xp
        dot(y).y = dot(y).y + dot(y).yp
CASE 4: dot(y).x = dot(y).x - dot(y).xp
        dot(y).y = dot(y).y - dot(y).yp
END SELECT
SELECT CASE dot(y).x
CASE IS >= 320: dot(y).dir = 4
CASE IS <= 0: dot(y).dir = 1
END SELECT
SELECT CASE dot(y).y
CASE IS >= 200: dot(y).dir = 2
CASE IS <= 0: dot(y).dir = 3
END SELECT
IF POINT(dot(y).x, dot(y).y) <> 31 THEN PSET (dot(y).x, dot(y).y), dot(y).col
NEXT
LOOP

' Credits
DIM l3(720)
DIM l4(720)
DIM l5(720)
DIM l6(720)
DIM l7(720)
DIM l8(720)
DIM l9(720)
DIM l10(720)
DIM l11(720)
DIM l12(720)
DIM l13(720)
DIM l14(720)
DIM l15(720)
DIM l16(720)
DIM l17(720)
DIM l18(720)
DIM l19(720)
DIM l20(720)
DIM l21(720)
DIM l22(720)
RANDOMIZE TIMER
SCREEN 7
COLOR 15, 2
CLS
LINE (0, 0)-(319, 10), 15, BF
LINE (0, 184)-(319, 199), 15, BF
DO
x = 0
y = 24
GET (x, y)-(x + 319, y + 7), l3
y = y + 8
GET (x, y)-(x + 319, y + 7), l4
y = y + 8
GET (x, y)-(x + 319, y + 7), l5
y = y + 8
GET (x, y)-(x + 319, y + 7), l6
y = y + 8
GET (x, y)-(x + 319, y + 7), l7
y = y + 8
GET (x, y)-(x + 319, y + 7), l8
y = y + 8
GET (x, y)-(x + 319, y + 7), l9
y = y + 8
GET (x, y)-(x + 319, y + 7), l10
y = y + 8
GET (x, y)-(x + 319, y + 7), l11
y = y + 8
GET (x, y)-(x + 319, y + 7), l12
y = y + 8
GET (x, y)-(x + 319, y + 7), l13
y = y + 8
GET (x, y)-(x + 319, y + 7), l14
y = y + 8
GET (x, y)-(x + 319, y + 7), l15
y = y + 8
GET (x, y)-(x + 319, y + 7), l16
y = y + 8
GET (x, y)-(x + 319, y + 7), l17
y = y + 8
GET (x, y)-(x + 319, y + 7), l18
y = y + 8
GET (x, y)-(x + 319, y + 7), l19
y = y + 8
GET (x, y)-(x + 319, y + 7), l20
y = y + 8
GET (x, y)-(x + 319, y + 7), l21
y = y + 8
GET (x, y)-(x + 319, y + 7), l22
y = y + 8
FOR up = 7 TO 0 STEP -1
PUT (0, up + 16), l3, PSET
PUT (0, up + 24), l4, PSET
PUT (0, up + 32), l5, PSET
PUT (0, up + 40), l6, PSET
PUT (0, up + 48), l7, PSET
PUT (0, up + 56), l8, PSET
PUT (0, up + 64), l9, PSET
PUT (0, up + 72), l10, PSET
PUT (0, up + 80), l11, PSET
PUT (0, up + 88), l12, PSET
PUT (0, up + 96), l13, PSET
PUT (0, up + 104), l14, PSET
PUT (0, up + 112), l15, PSET
PUT (0, up + 120), l16, PSET
PUT (0, up + 128), l17, PSET
PUT (0, up + 136), l18, PSET
PUT (0, up + 144), l19, PSET
PUT (0, up + 152), l20, PSET
PUT (0, up + 160), l21, PSET
PUT (0, up + 168), l22, PSET
NEXT up
LOCATE 3, 1
PRINT "                                        "
IF readit = 0 THEN
READ line$
LOCATE 22, 1
PRINT line$
END IF
IF line$ = "     " THEN readit = readit + 1
IF readit = 20 THEN readit = 0: GOTO 2006
LOOP UNTIL INKEY$ = " "
SCREEN 9
DATA "        PLaSTiC PiTHaiR SoFTWaRE"
DATA "             =-=-=-=-=-=-="
DATA "              Programmers:"
DATA ""
DATA
DATA "            Micheal Jaynes"
DATA "         (No Internet Address)"
DATA
DATA "                'Mono'"
DATA "          (Mono 10@AOL.COM)"
DATA ""
DATA "               Thuan Ho"
DATA "         (Thuan16692@AOL.COM)
DATA
DATA "             Ross McDaniel"
DATA "         (Buttschnaz@AOL.COM)
DATA
DATA "                 Nate          "
DATA "           (Nate126@AOL.COM)  "
DATA
DATA "               Jazzman
DATA "         (Jazzman518@AOL.COM)"
DATA
DATA "              Stealth311"
DATA "         (Stealth311@AOL.COM)"
DATA
DATA "               Joerutan"
DATA "          (Joerutan@AOL.COM)"
DATA
DATA "              NirvanaMar"
DATA "         (NirvanaMar@AOL.COM)"
DATA
DATA "              TonyCamp3"
DATA "         (TonyCamp3@AOL.COM)"
DATA
DATA "             Al  Koskelin"
DATA "           (ALSIXX@AOL.COM)"
DATA
DATA "              CDT Toasty"
DATA "         (CDT TOASTY@AOL.COM)
DATA
DATA "             Russel Tolley"
DATA "         (Russ00001@AOL.COM)
DATA
DATA "               Dab 007"
DATA "         (Dab 007@AOL.COM)
DATA
DATA "           Kevin  Fowlks
DATA "         (KFOWLKS@AOL.COM)
DATA
DATA
DATA "      Press any key to continue"
DATA "     "

CLS
COLOR 15
             PRINT "                        This program was written by:"
COLOR 4
LOCATE 2, 1: PRINT "                        M*I*C*H*E*A*L ** J*A*Y*N*E*S"
DIM A(10000)

GET (175, 15)-(500, 30), A

FOR x = 1 TO 200
        FOR A = 1 TO 10000
        NEXT A
PUT (175, 15 + x), A, PSET
NEXT x

SLEEP 2









2006 CLS
LEVEL = 1
Tlk = 1
Intro
SEL = 1
GOLD = 20
Sword = 0
Armor = 0
XPER = 0

Talk:                                           'Dialouge
IF Tlk = 1 THEN TalkBox 15, "A lone ninja, wandering in the night.", "": Ninja 300, 150, 0: SLEEP 2: GOTO NextLine
IF Tlk = 2 THEN TalkBox 15, "An enemy attacks!", "": Ninja 300, 150, 0: Mnst = 1: Flick: GOTO NextLine
IF Tlk = 3 THEN Mnst = 1: GOSUB Fighter
IF Tlk = 4 THEN TalkBox 15, "NINJA: Whew! That JuJumper came out", "of nowhere!": Ninja 300, 150, 0: SLEEP 3: CLS : GOTO NextLine
IF Tlk = 5 THEN TalkBox 15, "NINJA: Ah!!! More coming!!", "": Ninja 300, 150, 0: SLEEP 2: CLS : Mnst = 1: GOTO Fighter
IF Tlk = 6 THEN Mnst = 1: GOTO Fighter
IF Tlk = 7 THEN TalkBox 15, "NINJA: I made it to the town!", "": Ninja 300, 150, 0: SLEEP 2: GOTO NextLine
IF Tlk = 8 THEN TalkBox 2, "MERCHANT: I have many goods to sale!", "My prices are low!": Ninja 300, 150, 0: Spr = 2: Sketch: GOTO NextLine
IF Tlk = 9 THEN Ninja 300, 150, 0: ChooseBox 1, "What do you want?", "Pearl Armor - 40", "Nothing": PAINT (300, 150), 0, 0: Ninja 290, 150, 0: PAINT (290, 150), 0, 0: Ninja 300, 150, 0: PAINT (50, 150), 0, 0: GOTO NextLine
IF Tlk = 10 THEN TalkBox 15, "NINJA: Uh, oh. There's a thief!!!", "                                    ": Ninja 300, 150, 0: SLEEP 2: Mnst = 2: GOTO Fighter
IF Tlk = 11 THEN TalkBox 15, "NINJA: I must leave quickly! I'm not", "wanted here.                     ": Ninja 300, 150, 0: SLEEP 2: GOTO NextLine
IF Tlk = 12 THEN TalkBox 15, "You're walking in the wilderness... ", "                                 ": Ninja 300, 150, 0: RANDOMIZE TIMER: W = (RND * 3) + 1: IF W = 1 OR W = 2 THEN SLEEP 2: ClearLine: TalkBox 15, "A Wild Wolf!                        ", "                                 ": Mnst = 2: Flick: Mnst = 3: GOTO Fighter:  ELSE SLEEP 2: GOTO NextLine
IF Tlk = 13 THEN TalkBox 15, "You're walking in the wilderness... ", "                                 ": Ninja 300, 150, 0: RANDOMIZE TIMER: W = (RND * 3) + 1: IF W = 2 THEN SLEEP 2: ClearLine: TalkBox 15, "A Wild Wolf!                        ", "                                 ": Mnst = 2: Flick: Mnst = 3: GOTO Fighter:  ELSE SLEEP 2: GOTO NextLine
IF Tlk = 14 THEN TalkBox 15, "You're walking in the wilderness... ", "                                 ": Ninja 300, 150, 0: RANDOMIZE TIMER: W = (RND * 3) + 1: IF W = 3 THEN SLEEP 2: ClearLine: TalkBox 15, "A Wild Wolf!                        ", "                                 ": Mnst = 2: Flick: Mnst = 3: GOTO Fighter:  ELSE SLEEP 2: GOTO NextLine
IF Tlk = 15 THEN TalkBox 4, "STRANGE MAN: Take this sword!! I've  ", "gotta run!": Ninja 300, 150, 0: Spr = 4: Sketch: Sword = 1: Ninja 300, 150, 1: FOR x = 1 TO 1000: NEXT x: CLS : Ninja 300, 150, 0: SLEEP 1: GOTO NextLine
IF Tlk = 16 THEN TalkBox 15, "You're walking in the wilderness... ", "                                 ": Ninja 300, 150, 0: SLEEP 2: ClearLine: TalkBox 15, "A Wild Wolf!                        ", "                                 ": Mnst = 2: Flick: Mnst = 3: SLEEP 1: GOTO Fighter: GOTO NextLine
IF Tlk = 17 THEN TalkBox 15, "NINJA: I made it to the lair of the ", "ugly beast Raggino!!             ": Ninja 300, 150, 0: SLEEP 2: Mnst = 3: Flick: SLEEP 2: Mnst = 4: ClearLine: GOTO Fighter
IF Tlk = 18 THEN TalkBox 15, "NINJA: Yes! I killed Riggano! I can ", "go home now!                     ": Ninja 300, 150, 0: Fight: SLEEP 1: Fight: SLEEP 1: Fight: SLEEP 1: Fight: SLEEP 1: FOR x = 1 TO 400: CIRCLE (150, 100), x, 0: FOR A = 1 TO 100: NEXT A: NEXT x
END

NextLine:                                       'Next Dialouge
CLS
TalkBox 15, "                                     ", "                                     "
Tlk = Tlk + 1
GOSUB Talk

Fighter:                                          'Battle Sequence
CLS
IF Mnst = 1 THEN Sprite$ = "C4R2U5R6D5R2F5D5G2H2U5H3D10L6U10G3D5G2H2U5E5": EX = 15: MDFC = 4: MATK = 4: EHP = 50: OLD = 5: x = 50: y = 125
IF Mnst = 2 THEN Sprite$ = "C6R3F3L6U3U1C8U10BR3D10L3U10H3U4E2R4F2D2L2R6D3R1C6R3U3L3D3L1C8L6R2G2BU10C6U4L4D4R4BD4BR10C1L4R2U1C15U4BD10C1D": EX = 20: MDFC = 6: MATK = 7: EHP = 105: OLD = 8: x = 51: y = 150
IF Mnst = 3 THEN Sprite$ = "C23 D2L3U2R3L3L2H1L2H2G2L3BD4R10E1BL11BD1 G5D6R2D1L4U6 L7D6R2D1L4U7 L3H3U2G1L3H1E1R3F1E1R16E4 C4BD1BR8F1": EX = 30: MDFC = 20: MATK = 22: EHP = 120: OLD = 15: x = 50: y = 125
IF Mnst = 4 THEN Sprite$ = "C2E7R11E5R1E1R30E8U6R2E3F3R7F2D4L13G11D1G1D1G3D1G1D3G9L1G1L2G1L1G1L2G1L1G1L1G1U1E17L35G5L2G3L4E5BR75BU25C4F1": EX = 50: MDFC = 26: MATK = 28: EHP = 200: OLD = 50: x = 30: y = 125
HP = LEVEL * 50
ATK = LEVEL * 5
DFC = LEVEL * 4
SWBON = LEVEL * 5
DFBON = LEVEL * 6
IF Armor = 1 THEN DFC = DFC + DFBON
IF Sword = 1 THEN ATK = ATK + SWBON
Dags = 2
400 Ninja 300, 150, 0
PSET (x, y), 0: DRAW Sprite$
PSET (1, 1), 0
TalkBox 0, "                                     ", "                                           "
DRAW "C1R100D35L100U35D55R100U20"
PSET (1, 190), 0
DRAW "C4R100U15L100D15"
PSET (200, 1), 0
DRAW "C2R110D15L110U15"
1 IF HP < 0 THEN HP = 0
IF EHP < 0 THEN EHP = 0
LOCATE 6, 3
PRINT "HP : "; HP
LOCATE 23, 3
PRINT "HP : "; EHP
LOCATE 2, 27
PRINT "Daggers: "; Dags
IF EHP = 0 THEN GOTO 4
IF HP = 0 THEN Dead
2 IF SEL = 1 THEN
        LOCATE 2, 2: PRINT " FIGHT"
        LOCATE 3, 2: PRINT "  THROW"
        LOCATE 4, 2: PRINT "  QUIT"
END IF
IF SEL = 2 THEN
        LOCATE 2, 2: PRINT "  FIGHT"
        LOCATE 3, 2: PRINT " THROW"
        LOCATE 4, 2: PRINT "  QUIT"
END IF
IF SEL = 3 THEN
        LOCATE 2, 2: PRINT "  FIGHT"
        LOCATE 3, 2: PRINT "  THROW"
        LOCATE 4, 2: PRINT " QUIT"
END IF
DO: K$ = UCASE$(INKEY$): LOOP WHILE K$ = ""
IF K$ = CHR$(0) + "P" THEN SEL = SEL + 1: IF SEL > 3 THEN SEL = 1: GOTO 2
IF K$ = CHR$(0) + "H" THEN SEL = SEL - 1: IF SEL < 1 THEN SEL = 3: GOTO 2
IF K$ = "/" THEN Status: CLS : GOTO 400
IF K$ = CHR$(13) THEN GOTO 3
GOTO 2
3 RANDOMIZE TIMER
IF SEL = 1 THEN Fight: DMG = INT(RND * 3) + 1: EDMG = INT(RND * 3) + 1: DAMA = ATK * DMG - MDFC / 2: PDAM = MATK * EDMG - DFC / 2: HP = HP - PDAM: EHP = EHP - DAMA
IF SEL = 3 THEN COLOR 132: END
IF Dags = 0 AND SEL = 2 THEN BEEP: GOTO 1
IF SEL = 2 THEN Throw: DMG = INT(RND * 3) + 2: EDMG = INT(RND * 3) + 1: DAMA = ATK * DMG - MDFC / 2: PDAM = MATK * EDMG - DFC / 2: HP = HP - PDAM: EHP = EHP - DAMA: Dags = Dags - 1
GOTO 1
4 FOR x = 1 TO 50: CIRCLE (140, 60), x, 14: NEXT x: FOR A = 1 TO 50: CIRCLE (140, 60), A, 0: NEXT A
RANDOMIZE TIMER: RANDOMIZE TIMER: RANDOMIZE TIMER: RANDOMIZE TIMER: RANDOMIZE TIMER: RANDOMIZE TIMER: RANDOMIZE TIMER: RANDOMIZE TIMER: RANDOMIZE TIMER: RANDOMIZE TIMER: CLS : RANDOMIZE TIMER
RANDOMIZE TIMER: RANDOMIZE TIMER: RANDOMIZE TIMER: RANDOMIZE TIMER: RANDOMIZE TIMER: RANDOMIZE TIMER: RANDOMIZE TIMER: E = INT(RND * 2) + 1
RANDOMIZE TIMER: RANDOMIZE TIMER: RANDOMIZE TIMER: RANDOMIZE TIMER: RANDOMIZE TIMER: RANDOMIZE TIMER: RANDOMIZE TIMER: G = INT(RND * 5) + 1
XPER = XPER + EX * E
GOLD = GOLD + G * OLD

Exper:
CLS
IF XPER >= 50 THEN
        IF LEVEL < 2 THEN
                LEVEL = LEVEL + 1: PRINT "Level Up! You're now level "; LEVEL: SLEEP 2: GOTO 1000
ELSE
        IF XPER >= 100 THEN
                IF LEVEL < 3 THEN
                        LEVEL = LEVEL + 1: PRINT "Level Up!! You're now level "; LEVEL: SLEEP 2: GOTO 1000
        ELSE
                IF XPER >= 150 THEN
                        IF LEVEL < 4 THEN
                                LEVEL = LEVEL + 1: PRINT "Level Up!! You're now level "; LEVEL: SLEEP 2: GOTO 1000
                ELSE
                        IF XPER >= 200 THEN
                                IF LEVEL < 5 THEN
                                        LEVEL = LEVEL + 1: PRINT "Level Up!!! You're now level "; LEVEL: SLEEP 2: GOTO 1000
                        ELSE
                                IF XPER >= 250 THEN
                                        IF LEVEL < 6 THEN
                                                LEVEL = LEVEL + 1: PRINT "Level Up!!! You're now level "; LEVEL: SLEEP 2: GOTO 1000
                                ELSE
                                        IF XPER >= 300 THEN
                                                IF LEVEL < 7 THEN
                                                        LEVEL = LEVEL + 1: PRINT "Level Up!!!! You're now level "; LEVEL: SLEEP 2: GOTO 1000
                                        ELSE
                                                IF XPER >= 350 THEN
                                                        IF LEVEL < 8 THEN
                                                                LEVEL = LEVEL + 1: PRINT "Level Up!!!!! You're now level "; LEVEL: SLEEP 2: GOTO 1000
                                              
                                              
END IF
END IF
END IF
END IF
END IF
END IF
END IF
END IF
END IF
END IF
END IF
END IF
END IF
END IF
1000 CLS
GOTO NextLine

DEFSNG A-Z
SUB ChooseBox (Ind, Ques$, Choice1$, Choice2$)
SELI = 1
LOCATE 2, 2: PRINT Ques$
100 PSET (1, 1), 15
DRAW "C15R310D50L310U50"
        IF SELI = 1 THEN
                LOCATE 4, 2: PRINT " " + Choice1$: LOCATE 4, 24: PRINT "  " + Choice2$
        ELSE
                LOCATE 4, 2: PRINT "  " + Choice1$: LOCATE 4, 24: PRINT " " + Choice2$
        END IF
300 DO: K$ = UCASE$(INKEY$): LOOP WHILE K$ = ""
IF K$ = CHR$(0) + "K" THEN SELI = SELI + 1: IF SELI > 2 THEN SELI = 1: GOTO 100
IF K$ = CHR$(0) + "M" THEN SELI = SELI - 1: IF SELI < 1 THEN SELI = 2: GOTO 100
IF K$ = CHR$(13) THEN GOTO 200
GOTO 300
200 IF Ind = 1 THEN
        IF SELI = 2 THEN EXIT SUB
                IF SELI = 1 THEN
                        IF GOLD - 40 < 0 THEN
                                BEEP
                                EXIT SUB
                        ELSE
                                Armor = 1
                                GOLD = GOLD - 40
                                EXIT SUB
                        END IF
                END IF
        END IF
END SUB

SUB ClearLine
TalkBox 15, "                                  ", "                              "
END SUB

SUB Dead
LINE (1, 180)-(319, 199), 4, BF
DIM A(3000)
GET (1, 180)-(319, 199), A
FOR x = 1 TO 180
PUT (1, 180 - x), A, PSET
        FOR y = 1 TO 100: NEXT y
NEXT x
COLOR 4
LOCATE 21, 10: PRINT "  Well ninja, looks like you're DEAD!!  "
SLEEP
COLOR 0
END
END SUB

SUB Fight
PAINT (300, 150), 0, 0
Ninja 90, 150, 1
        FOR B = 1 TO 3000
        NEXT B
PAINT (90, 150), 0, 0
Ninja 300, 150, 0
END SUB

SUB Flick
IF Mnst = 1 THEN Sprite$ = "C4R2U5R6D5R2F5D5G2H2U5H3D10L6U10G3D5G2H2U5E5": BSprite$ = "C0R2U5R6D5R2F5D5G2H2U5H3D10L6U10G3D5G2H2U5E5"
IF Mnst = 2 THEN Sprite$ = "C23 D2L3U2R3L3L2H1L2H2G2L3BD4R10E1BL11BD1 G5D6R2D1L4U6 L7D6R2D1L4U7 L3H3U2G1L3H1E1R3F1E1R16E4 C4BD1BR8F1": BSprite$ = "C0 D2L3U2R3L3L2H1L2H2G2L3BD4R10E1BL11BD1 G5D6R2D1L4U6 L7D6R2D1L4U7 L3H3U2G1L3H1E1R3F1E1R16E4 BD1BR8F1"
IF Mnst = 3 THEN Sprite$ = "C2E7R11E5R1E1R30E8U6R2E3F3R7F2D4L13G11D1G1D1G3D1G1D3G9L1G1L2G1L1G1L2G1L1G1L1G1U1E17L35G5L2G3L4E5BR75BU25C4F1": BSprite$ = "C0E7R11E5R1E1R30E8U6R2E3F3R7F2D4L13G11D1G1D1G3D1G1D3G9L1G1L2G1L1G1L2G1L1G1L1G1U1E17L35G5L2G3L4E5R75U25F1"
PSET (50, 125), 0: DRAW Sprite$: FOR x = 1 TO 1000: NEXT x
PSET (50, 125), 0: DRAW BSprite$: FOR x = 1 TO 1000: NEXT x
PSET (50, 125), 0: DRAW Sprite$: FOR x = 1 TO 1000: NEXT x
PSET (50, 125), 0: DRAW BSprite$: FOR x = 1 TO 1000: NEXT x
PSET (50, 125), 0: DRAW Sprite$: FOR x = 1 TO 1000: NEXT x
PSET (50, 125), 0: DRAW BSprite$: FOR x = 1 TO 1000: NEXT x
PSET (50, 125), 0: DRAW Sprite$: FOR x = 1 TO 1000: NEXT x
SLEEP 2
END SUB

SUB Intro
SCREEN 13
PRINT "                saga"
DIM A(1000)
DIM B(1000)
DIM C(1000)
GET (127, 1)-(159, 10), A
FOR x = 1 TO 100
PUT (127, 1 + x), A, PSET
FOR A = 1 TO 200
NEXT A
NEXT x
PRINT "               ninjas"
GET (117, 1)-(179, 15), B
FOR x = 1 TO 85
PUT (117, 1 + x), B, PSET
FOR A = 1 TO 200
NEXT A
NEXT x
PRINT
PRINT "                The"
GET (117, 20)-(179, 30), C
FOR x = 1 TO 61
PUT (117, 20 + x), C, PSET
FOR A = 1 TO 200
NEXT A
NEXT x
SLEEP 1
PAINT (1, 1), 8, 8
CLS
END SUB

SUB Ninja (x, y, Stance)
PSET (x, y), 0
DRAW "C20R5D5L5U5R5U10L3D10U10H5U2L5U3R9BD3L4BU3U2E3U6R5D6L5R5D17"
PAINT (x + 3, y - 1), 20, 20
PAINT (x + 3, y + 2), 20, 20
IF Armor = 0 THEN
        PAINT (x + 3, y - 11), 20, 20
ELSE
        PAINT (x + 3, y - 11), 15, 20
END IF
PAINT (x + 3, y - 26), 20, 20
IF Stance = 0 THEN
        PSET (x - 4, y - 21), 0
        IF Sword = 0 THEN
                DRAW "C6L4R2U1C15U8"
                PSET (x - 6, y - 16), 6
        ELSE
                DRAW "C8L4R2U1C7U8"
                PSET (x - 6, y - 16), 8
        END IF
ELSE
        PSET (x - 9, y - 20), 0
        IF Sword = 0 THEN
                DRAW "C6D4U2L1C15L8"
        ELSE
                DRAW "C8D4U2L1C7L8"
        END IF
END IF
END SUB

SUB Sketch
IF Spr = 1 THEN Sprite$ = "C4R2U5R6D5R2F5D5G2H2U5H3D10L6U10G3D5G2H2U5E5": x = 50: y = 125
IF Spr = 2 THEN Sprite$ = "C6R3F3L6U3U1C2U10BR3D10L3U10H3U4E2R4F2D2L2R6D3R1C6R3U3L3D3L1C2L6R2G2BU10C6U4L4D4R4": x = 50: y = 150
IF Spr = 3 THEN Sprite$ = "C23 D2L3U2R3L3L2H1L2H2G2L3BD4R10E1BL11BD1 G5D6R2D1L4U6 L7D6R2D1L4U7 L3H3U2G1L3H1E1R3F1E1R16E4 C4BD1BR8F1": x = 50: y = 125
IF Spr = 4 THEN Sprite$ = "C6R3F3L6U3U1C1U10BR3D10L3U10H3U4E2R4F2D2L2R6D3R1C5R3U3L3D3L1C1L6R2G2BU10C6U4L4D4R4": x = 50: y = 150
PSET (x, y), 0: DRAW Sprite$
IF Spr = 2 THEN PAINT (51, 151), 6, 6: PAINT (51, 141), 2, 2: PAINT (61, 135), 6, 6: PSET (52, 127), 1
SLEEP 2
END SUB

SUB Status
CLS
PSET (1, 1), 15
DRAW "C15R315D195L315U195"
LOCATE 4, 2
PRINT "         ******STATUS******"
LOCATE 8, 2: PRINT "LEVEL: "; LEVEL
LOCATE 10, 2: PRINT "GOLD: "; GOLD
LOCATE 12, 2: PRINT "EXPERIENCE: "; XPER
IF Sword = 0 THEN
       Sword$ = "Rusty Sword"
ELSE
        Sword$ = "Ninja Blade"
END IF

IF Armor = 0 THEN
        Arm$ = "Kung Fu Suit"
ELSE
        Arm$ = "Pearl Armor"
END IF
LOCATE 14, 2: PRINT "SWORD: "; Sword$
LOCATE 16, 2: PRINT "ARMOR: "; Arm$
SLEEP
END SUB

SUB TalkBox (Clr, Line1$, Line2$)
PSET (1, 1), Clr
COLOR Clr
DRAW "R310D50L310U50"
COLOR 15
LOCATE 2, 2
PRINT Line1$
LOCATE 3, 2
PRINT "                              "
LOCATE 4, 2
PRINT Line2$
END SUB

SUB Throw
PSET (275, 125), 0
DRAW "C2L3U2D4U2L1C15L4"
DIM A(1000)
GET (265, 120)-(280, 130), A
FOR x = 1 TO 175
PUT (265 - x, 120), A, PSET
        FOR A = 1 TO 50
        NEXT A
NEXT x
PAINT (100, 125), 0, 0
END SUB

