'                           Killer Kombat Pong III
'                                    V1.3
'
'                                ÚÄÄÄÄÄÄÄÄÄÄ¿
'                                ³ Kontrols ³
'                      ÚÄÄÄÄÄÄÄÄÄÁÄÄÄÄÂÂÄÄÄÄÁÄÄÄÄÄÄÄÄÄ¿
'                      ³ [8] Up       ³³       Up [w] ³
'                      ³ [2] Down     ³³     Down [z] ³
'                      ³ [4] Button 1 ³³ Button 1 [a] ³
'                      ³ [5] Button 2 ³³ Button 2 [s] ³
'                      ³ [5] Button 3 ³³ Button 3 [d] ³
'                      ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
'
'         Copyright (C) 1996 Realm Productions. All rights reserved.

DECLARE SUB Title ()
DECLARE SUB BigWrite (Word$, Name$)
DECLARE SUB SmallWrite (Word$, Name$)
DECLARE SUB Bios (Paddle, Victory)
DECLARE SUB Options ()
DECLARE SUB Player (Choice, Spooky, Round())
DECLARE SUB Versus (Battle)
DECLARE SUB Kodes ()
DECLARE SUB Update (Fight, Flash, Time, Paddle1$, Paddle2$, Px)
DECLARE SUB FX ()
DECLARE SUB Projectile (Refreeze)
DECLARE SUB Finish ()
DECLARE SUB Bleed1 (Blood1)
DECLARE SUB Bleed2 (Blood2)
DECLARE SUB Ball (Spook)
DECLARE SUB Controls (a$, B$)
DECLARE SUB Moves (Mer1, Mer2, In1, In2, Fire, Fire2, Extend)
DECLARE SUB Win ()
DECLARE SUB Portal ()
DECLARE SUB Credits ()
DECLARE SUB Ultimate ()
DIM SHARED Speed, Paddle1, Paddle2, En1, En2, Shift1, Shift2, a, B, c, d
DIM SHARED Zone, AI, Kode, Frozen1, Frozen2, Scream1, Scream2, Net1, Net2
DIM SHARED BallType, BallTime, Angle, Invis, Inv1, Inv2, InvisB, InAng
DIM SHARED Bomb, Bmb, ShC, ShD, Shock, Morph, Teleport, Vacuum, Laser
DIM SHARED Tournament, Combo, Hits, Hits2, Proj, Col1, Col2
DIM SHARED Fatal, Baby, Friend, Anim, Mercy
DIM Round(15)
DIM Move(26)

    DEF SEG = 0
    KeyFlags = PEEK(1047)
    IF (KeyFlags AND 32) = 0 THEN
    POKE 1047, KeyFlags OR 32
    END IF
    DEF SEG
a$ = INKEY$

CLEAR , 2147483647, 9000

SCREEN 7, 0, 0, 0: CLS
Speed = 50: AI = 1: Zone = 5

Tournament = 0

Title

10
SCREEN 7, 0, 1, 0

Word$ = "GAME START": CALL BigWrite(Word$, Name$)
DRAW "bm100,89c7" + Name$
IF Choice = 0 THEN DRAW "bm100,90c15" + Name$ ELSE DRAW "bm100,90c8" + Name$

Word$ = "OPTIONS": CALL BigWrite(Word$, Name$)
DRAW "bm121,119c7" + Name$
IF Choice = 1 THEN DRAW "bm121,120c15" + Name$ ELSE DRAW "bm121,120c8" + Name$

PCOPY 1, 0
DO: a$ = INKEY$: LOOP WHILE a$ = ""
IF a$ = "8" THEN Choice = 0
IF a$ = "2" THEN Choice = 1
IF a$ = "8" OR a$ = "2" THEN FOR x = 1 TO 1000: NEXT x: GOTO 10
IF Choice = 0 THEN SCREEN 7, 0, 1, 0: CLS : GOTO 17
Choice = 0

CALL Options

Choice = 0: SCREEN 7, 0, 1, 0: CLS : GOTO 10

17

Choice = 0: Turn = 0
Shift1 = 0: Shift2 = 0
Paddle1 = 1: Paddle2 = 1

CALL Player(Choice, Spooky, Round())

18
CALL Versus(Battle)

50

SCREEN 7, 0, 1, 0: CLS
IF Paddle1 = 15 THEN Shift1 = 1
IF Paddle2 = 15 THEN Shift2 = 1
Angle = 1: a = 85: B = 85: c = 160: d = 100
En1 = 40: En2 = 40

FOR x = 1 TO 2
IF x = 1 THEN Paddle = Paddle1
IF x = 2 THEN Paddle = Paddle2
Word$ = ""
Px = 15
IF Paddle = 1 THEN Word$ = "CHILLN"
IF Paddle = 2 THEN Word$ = "SHOCKER": Px = 9
IF Paddle = 3 THEN Word$ = "SHARK"
IF Paddle = 4 THEN Word$ = "BLOODBATH": Px = 0
IF Paddle = 5 THEN Word$ = "CYBER": Px = 17
IF Paddle = 6 THEN Word$ = "ICEPICK": Px = 14
IF Paddle = 7 THEN Word$ = "SHAO PONG": Px = -2
IF Paddle = 8 THEN Word$ = "NINJA"
IF Paddle = 9 THEN Word$ = "BANSHEE": Px = 8
IF Paddle = 10 THEN Word$ = "SYLVA"
IF Paddle = 11 THEN Word$ = "GLACIER": Px = 11
IF Paddle = 12 THEN Word$ = "BLACKOUT": Px = 5
IF Paddle = 13 THEN Word$ = "SPOOK"
IF Paddle = 14 THEN Word$ = "FIREBUG": Px = 10
IF Paddle = 15 THEN Word$ = "SHIFTER": Px = 11
CALL SmallWrite(Word$, Name$)
IF x = 1 THEN Paddle1$ = Name$
IF x = 2 THEN Paddle2$ = Name$
NEXT x

IF Kode = 3 THEN En2 = 20
IF Kode = 4 THEN En1 = 20
IF Kode = 8 THEN En2 = 10
IF Kode = 9 THEN En1 = 10
IF Kode = 7 THEN Speed = 0

Proj = 0: Fight = 0: Fatal = 0: Morph = 0: Teleport = 0: Invis = 0: Time = 0
Frozen1 = 0: Frozen2 = 0: Flash = 0: Shock = 0: InvisB = 0: Inv1 = 0: Inv2 = 0
Vacuum = 0: Combo = 0: Bmb = 0: Bomb = 0: Fire2 = 0: Fire = 0: Baby = 0
Refreeze = 0: Spook = 0: Dip = 0: Friend = 0: Anim = 0: ITime = 0: EyeX = 0
EyeY = 0: Mercy = 0: Mer1 = 0: Mer2 = 0: Scream1 = 0: Scream2 = 0: Net1 = 0
Net2 = 0: BallType = 0: BallTime = 0: ComboTime = 0: Hits = 0: Percent = 0
Damage = 0: HitCombo = 0: CEn1 = 0: CEn2 = 0: ComboTime2 = 0: Hits2 = 0
Percent2 = 0: Damage2 = 0: HitCombo2 = 0: Extend = 0
FOR x = 1 TO 26: Move(x) = 0: NEXT x

100

IF Kode = 6 THEN c = 160: InvisB = 1: InAng = Angle: Bomb = 0: Bmb = 0: BallType = 0: BallTime = 0: Vacuum = 0: IF Proj = 17 OR Proj = 18 THEN Proj = 0 ELSE IF Invis = 5 THEN Invis = 0
IF Paddle2 = 3 THEN Frozen2 = 0: Refreeze = 0
IF Paddle1 = 13 THEN Frozen1 = 0: Scream1 = 0: Net1 = 0: Refreeze = 0
IF Paddle2 = 0 OR Paddle2 = 13 THEN Frozen2 = 0: Scream2 = 0: Net2 = 0: Refreeze = 0

IF Extend > 0 AND Fatal = 0 AND Baby = 0 AND Friend = 0 AND Anim = 0 AND Move(Combo) = 0 THEN FOR y = 1 TO Speed * 100: NEXT y: IF Extend = 1 THEN FOR x = 1 TO 13: Move(x) = 0: NEXT x: En2 = En2 - 1 ELSE IF Extend = 2 THEN FOR x = 14 TO 26: Move(x) = 0: NEXT x: En1 = En1 - 1
IF Extend > 0 THEN Extend = 0

CALL Update(Fight, Flash, Time, Paddle1$, Paddle2$, Px)

IF Fight = 0 THEN LINE (1, 1)-(40, 3), 4, BF: LINE (318, 1)-(279, 3), 4, BF

IF Fatal > 0 OR Baby > 0 OR Friend > 0 OR Anim > 0 THEN Spook = 0: Dip = 0
IF Spook = 1 THEN Dip = Dip + 6: IF Dip = 30 THEN Spook = 2
IF Spook = 2 THEN Pause = Pause + 1: IF Pause = 10 THEN Pause = 0: Spook = 3
IF Spook = 3 THEN Dip = Dip - 6: IF Dip = 0 THEN Spook = 0
IF Spook > 0 THEN LINE (270, 199)-(271, 199 - Dip), 13, B
IF Spook = 2 THEN Word$ = "SPOOKY!": CALL SmallWrite(Word$, Name$): DRAW "bm259,162c14" + Name$

IF Refreeze > 0 AND En1 > 0 AND En2 > 0 AND Mercy = 0 AND Fatal = 0 AND Baby = 0 AND Friend = 0 AND Anim = 0 AND Time < 30 THEN Word$ = "DOUBLE ICE BACKFIRE": CALL SmallWrite(Word$, Name$): DRAW "bm130,100c11" + Name$

IF Kode = 2 AND Proj = 0 AND Fatal = 0 AND Baby = 0 AND Friend = 0 AND Anim = 0 AND Morph = 0 AND Invis = 0 AND Teleport = 0 AND Bomb = 0 THEN CLS

IF Zone = 5 AND Fatal = 0 AND Baby = 0 AND Friend = 0 AND Anim = 0 AND Time < 30 THEN
 ITime = ITime + 1
 IF ITime = 15 THEN ITime = 0: EyeX = INT(50 * RND(1) + 1): EyeX = EyeX + 135: EyeY = INT(50 * RND(1) + 1): EyeY = EyeY + 75
 IF ITime > 3 THEN LINE (EyeX - 2, EyeY)-(EyeX - 7, EyeY), 6: LINE (EyeX + 2, EyeY)-(EyeX + 7, EyeY), 6
 IF ITime > 4 AND ITime < 14 THEN LINE (EyeX - 4, EyeY)-(EyeX - 5, EyeY), 14: LINE (EyeX + 4, EyeY)-(EyeX + 5, EyeY), 14
 END IF

IF ComboTime > 0 AND Proj = 0 AND Fatal = 0 AND Baby = 0 AND Friend = 0 AND Anim = 0 THEN
 ComboTime = ComboTime - 1
 Word$ = STR$(HitCombo) + " HIT COMBO"
 CALL SmallWrite(Word$, Name$)
 DRAW "bm7," + STR$(a + 13) + "c14" + Name$
 Word$ = STR$(Damage) + "% DAMAGE"
 CALL SmallWrite(Word$, Name$)
 DRAW "bm7," + STR$(a + 21) + "c14" + Name$
 END IF
IF ComboTime2 > 0 AND Proj = 0 AND Fatal = 0 AND Baby = 0 AND Friend = 0 AND Anim = 0 THEN
 ComboTime2 = ComboTime2 - 1
 Word$ = STR$(HitCombo2) + " HIT COMBO"
 CALL SmallWrite(Word$, Name$)
 DRAW "bm267," + STR$(B + 13) + "c14" + Name$
 Word$ = STR$(Damage2) + "% DAMAGE"
 CALL SmallWrite(Word$, Name$)
 DRAW "bm267," + STR$(B + 21) + "c14" + Name$
 END IF

PCOPY 1, 0

IF Fight = 0 THEN Surprise = 0: IF Paddle2 <> 0 AND Paddle2 <> 3 AND Paddle2 <> 7 AND Paddle2 <> 13 THEN RANDOMIZE TIMER: x = INT(30 * RND(1) + 1): IF x = 1 THEN Surprise = 1: Paddle = 13 ELSE IF x = 2 THEN Surprise = 2: Paddle = 13 ELSE IF x = 3 THEN Surprise = 3: Paddle = 3 ELSE IF x = 4 THEN Surprise = 4: Paddle = 3
IF Fight = 0 AND Surprise > 0 THEN
 FOR y = 1 TO Speed * 20: NEXT y: SCREEN 7, 0, 0, 0: FOR j = 1 TO 3: FOR x = 1 TO 15 STEP 2: CIRCLE (161, 90 - x), x, 8: CIRCLE (161, 120 - x), x, 8: FOR y = 1 TO Speed * 2: NEXT y: CIRCLE (161, 90 - x), x, 0: CIRCLE (161, 120 - x), x, 0: NEXT x: NEXT j
 LINE (160, 90)-(161, 120), Paddle, B
 IF Surprise = 1 THEN Word$ = "GHOST WHO?": x = 3
 IF Surprise = 2 THEN Word$ = "BOO!": x = 17
 IF Surprise = 3 THEN Word$ = "MISS THE BALL": x = 2
 IF Surprise = 4 THEN Word$ = "BEFORE THE PIT": x = 0
 CALL SmallWrite(Word$, Name$)
 DRAW "bm" + STR$(138 + x) + ",83c14" + Name$: FOR y = 1 TO Speed * 200: NEXT y: DRAW "bm" + STR$(138 + x) + ",83c0" + Name$
 LINE (160, 90)-(161, 120), 0, B
 FOR j = 1 TO 3: FOR x = 1 TO 15 STEP 2: CIRCLE (161, 90 - x), x, 8: CIRCLE (161, 120 - x), x, 8: FOR y = 1 TO Speed * 2: NEXT y: CIRCLE (161, 90 - x), x, 0: CIRCLE (161, 120 - x), x, 0: NEXT x: NEXT j
 END IF

IF Fight = 0 THEN
 SCREEN 7, 0, 1, 0
 j = 40 \ En1
 q = 40 \ En2
 FOR x = 1 TO 40
 LINE (1, 1)-(x \ j, 3), 10, BF
 LINE (318, 1)-(319 - x \ q, 3), 10, BF
 LINE (0, 0)-(41, 4), 2, B: LINE (278, 0)-(319, 4), 2, B
 FOR y = 1 TO Speed * 2: NEXT y
 PCOPY 1, 0: NEXT x
 FOR y = 1 TO Speed * 20: NEXT y
 Word$ = "FIGHT!": CALL BigWrite(Word$, Name$)
 SCREEN 7, 0, 1, 0
 FOR x = 10 TO 4 STEP -1
 Star$ = "s" + STR$(x) + Name$
 DRAW "bm" + STR$(160 - (7 * x)) + "," + STR$(96 + (2 * x)) + "c7" + Star$ + "bm" + STR$(160 - (7 * x)) + "," + STR$(97 + (2 * x)) + "c8" + Star$
 PCOPY 1, 0
 DRAW "bm" + STR$(160 - (7 * x)) + "," + STR$(96 + (2 * x)) + "c0" + Star$ + "bm" + STR$(160 - (7 * x)) + "," + STR$(97 + (2 * x)) + "c0" + Star$
 NEXT x
 SCREEN 7, 0, 0, 0
 IF Kode = 5 THEN Word$ = "     OLD SCHOOL"
 IF Kode = 6 THEN Word$ = "    BALL DISABLED"
 IF Kode = 10 THEN Word$ = "PROJECTILES DISABLED"
 IF Kode = 11 THEN Word$ = "  COMBOS DISABLED"
 IF Kode = 5 OR Kode = 6 OR Kode = 10 OR Kode = 11 THEN CALL SmallWrite(Word$, Name$): DRAW "bm127,114c1" + Name$
 Word$ = "FIGHT!": CALL BigWrite(Word$, Name$)
 DRAW "bm132,104c7" + Name$: FOR x = 1 TO 6: DRAW "bm132,105c15" + Name$: FOR y = 1 TO Speed * 20: NEXT y: DRAW "bm132,105c8" + Name$: FOR y = 1 TO Speed * 20: NEXT y: NEXT x: Fight = 1
 DRAW "bm132,105c0" + Name$: FOR y = 1 TO Speed * 10: NEXT y: DRAW "bm132,104c0" + Name$: FOR y = 1 TO Speed * 10: NEXT y
 END IF

SCREEN 7, 0, 0, 0

IF Time = 30 THEN Fatal = 0: Baby = 0: Friend = 0: Anim = 0: GOTO 500

IF Shift1 > 1 THEN Shift1 = Shift1 - 1: IF Shift1 = 1 THEN Paddle1 = 15: Invis = 1: Inv1 = 1: FOR x = 1 TO 13: Move(x) = 0: NEXT x
IF Shift2 > 1 THEN Shift2 = Shift2 - 1: IF Shift2 = 1 THEN Paddle2 = 15: Invis = 2: Inv2 = 1: FOR x = 14 TO 26: Move(x) = 0: NEXT x
IF Anim > 0 AND En2 < 1 THEN Invis = 1: Inv1 = 0
IF Anim > 0 AND En1 < 1 THEN Invis = 2: Inv2 = 0
CALL FX
IF Kode = 10 AND Proj > 0 AND Proj <> 17 AND Proj <> 18 AND Proj <> 23 AND Proj <> 24 AND Proj <> 27 AND Proj <> 28 AND Fatal = 0 THEN Proj = 0
IF Proj > 0 THEN CALL Projectile(Refreeze)

IF En1 < 0 AND (Fatal > 0 OR Baby > 0 OR Friend > 0 OR Anim > 0) THEN En1 = 0: CEn1 = 0
IF En2 < 0 AND (Fatal > 0 OR Baby > 0 OR Friend > 0 OR Anim > 0) THEN En2 = 0: CEn2 = 0
                                                                                                                                               
IF Hits > 0 AND (En2 = CEn2 AND Frozen2 = 0 AND Scream2 = 0 AND Net2 = 0 OR Move(Combo) = 1 AND (En2 < CEn2 OR (c = 315 AND d = B + 15))) THEN
 IF Hits > 1 THEN ComboTime = 10: HitCombo = Hits: Damage = INT(Percent / 40 * 100): IF Damage > 100 THEN Damage = 100
 FOR x = 1 TO 13: Move(x) = 0: NEXT x
 Hits = 0: Percent = 0: CEn2 = En2
 END IF
IF Hits2 > 0 AND (En1 = CEn1 AND Frozen1 = 0 AND Scream1 = 0 AND Net1 = 0 OR Move(Combo) = 1 AND (En1 < CEn1 OR (c = 4 AND d = a + 15))) THEN
 IF Hits2 > 1 THEN ComboTime2 = 10: HitCombo2 = Hits2: Damage2 = INT(Percent2 / 40 * 100): IF Damage2 > 100 THEN Damage2 = 100
 FOR x = 14 TO 26: Move(x) = 0: NEXT x
 Hits2 = 0: Percent2 = 0: CEn1 = En1
 END IF
IF En2 < CEn2 AND Move(Combo) = 0 THEN
 Hits = Hits + 1
 Percent = Percent + (CEn2 - En2)
 IF Combo <> 0 THEN Move(Combo) = 1
 END IF
IF Combo <> 0 AND c = 315 AND d = B + 15 AND BallTime > 0 THEN Move(Combo) = 1
IF En1 < CEn1 AND Move(Combo) = 0 THEN
 Hits2 = Hits2 + 1
 Percent2 = Percent2 + (CEn1 - En1)
 IF Combo <> 0 THEN Move(Combo) = 1
 END IF
IF Combo <> 0 AND c = 4 AND d = a + 15 AND BallTime > 0 THEN Move(Combo) = 1
                                   
IF Kode = 11 THEN Hits = 0: Hits2 = 0

IF Hits > 1 AND Refreeze = 10 THEN Refreeze = 0: Frozen2 = Frozen1: Frozen1 = 0
IF Hits2 > 1 AND Refreeze = 10 THEN Refreeze = 0: Frozen1 = Frozen2: Frozen2 = 0

IF Mercy > 0 THEN
 IF Mercy = 1 THEN En2 = 10: Mer1 = 1
 IF Mercy = 2 THEN En1 = 10: Mer2 = 1
 Mercy = 0: Time = 0
 FOR x = 1 TO 20
 PSET (160 - x, 100), 8: PSET (160 + x, 100), 8
 PSET (160, 100 - x), 8: PSET (160, 100 + x), 8
 PSET (160 - x / 1.4, 100 - x / 1.4), 8: PSET (160 + x / 1.4, 100 + x / 1.4), 8
 PSET (160 + x / 1.4, 100 - x / 1.4), 8: PSET (160 - x / 1.4, 100 + x / 1.4), 8
 CIRCLE (160, 100), x \ 1.5, 8
 CIRCLE (160, 100), x \ 3.5, 7, , , 1
 CIRCLE (160, 100), x \ 7.5, 15, , , 2
 FOR y = 1 TO Speed * 2: NEXT y
 NEXT x
 Word$ = "MERCY"
 CALL BigWrite(Word$, Name$)
 DRAW "bm134,106c2" + Name$ + "bm134,107c10" + Name$
 FOR y = 1 TO Speed * 150: NEXT y
 END IF

IF Fatal > 0 OR Baby > 0 OR Friend > 0 OR Anim > 0 THEN CALL Finish: GOTO 500

SCREEN 7, 0, 1, 0

IF AI = 1 AND Hits < 2 THEN a$ = "": B$ = "" ELSE a$ = INKEY$: B$ = INKEY$
IF AI = 0 THEN FOR x = 1 TO 2: DEF SEG = 0: POKE 1050, PEEK(1052): DEF SEG : NEXT x
                        
IF AI > 0 THEN AI = AI + 1: IF AI = 4 THEN AI = 1
IF AI = 2 AND Hits < 2 THEN
 RANDOMIZE TIMER: x = INT(15 * RND(1) + 1)
 B$ = ""
 IF x = 1 OR x = 4 OR x = 5 OR x = 7 OR x = 10 THEN a$ = "a"
 IF x = 2 OR x = 6 OR x = 8 OR x = 11 THEN a$ = "s"
 IF x = 3 OR x = 9 OR x = 12 THEN a$ = "d"
 IF x = 4 THEN B$ = "s"
 IF x = 5 OR x = 6 THEN B$ = "d"
 IF x = 7 OR x = 8 OR x = 9 OR x = 13 THEN B$ = "w"
 IF x = 10 OR x = 11 OR x = 12 THEN B$ = "z"
 IF x = 13 THEN a$ = "z"
 IF x > 13 AND c <= 220 AND B + 15 > a - 1 AND B + 15 < a + 31 AND Hits2 = 0 AND ComboAI = 0 AND Kode <> 11 THEN
  IF Paddle2 = 0 AND Net1 = 0 AND a = B THEN Combo$ = "adsws ": ComboAI = 6
  IF Paddle2 = 1 AND Frozen1 = 0 THEN Combo$ = "asads ": ComboAI = 6
  IF Paddle2 = 2 THEN Combo$ = "assws ": ComboAI = 6
  IF Paddle2 = 3 THEN Combo$ = "asa ": ComboAI = 4
  IF Paddle2 = 4 THEN Combo$ = "sdad": ComboAI = 4
  IF Paddle2 = 5 AND Net1 = 0 AND a = B THEN Combo$ = "adass ": ComboAI = 6
  IF Paddle2 = 6 AND Frozen1 = 0 THEN Combo$ = "s assd": ComboAI = 6
  IF Paddle2 = 7 THEN Combo$ = "s a ": ComboAI = 4
  IF Paddle2 = 8 THEN Combo$ = "s as": ComboAI = 4
  IF Paddle2 = 9 THEN Combo$ = "sdadsw": ComboAI = 6
  IF Paddle2 = 10 THEN Combo$ = "s d as": ComboAI = 6
  IF Paddle2 = 11 AND Frozen1 = 0 THEN Combo$ = "d ad": ComboAI = 4
  IF Paddle2 = 12 AND Inv2 = 0 THEN Combo$ = "azassw": ComboAI = 6
  IF Paddle2 = 13 THEN Combo$ = "assw": ComboAI = 4
  IF Paddle2 = 14 THEN Combo$ = "ass ": ComboAI = 4
  IF Paddle2 = 15 AND Fire2 = 0 THEN Combo$ = "a asad": ComboAI = 6
  IF x = 15 AND ComboAI > 0 THEN
   IF Paddle1 > 5 AND Paddle1 < 11 THEN Combo$ = Combo$ + "a " + Combo$
   IF Paddle1 > 10 AND Paddle1 < 14 OR Paddle1 = 15 THEN Combo$ = Combo$ + "s " + Combo$
   IF Paddle1 < 6 OR Paddle1 = 14 THEN Combo$ = Combo$ + "d " + Combo$
   ComboAI = ComboAI * 2 + 2
   END IF
  END IF
 IF c > 220 THEN IF a$ + B$ = "s" AND (Paddle2 = 1 OR Paddle2 = 2) OR a$ + B$ = "a" AND Paddle2 = 3 THEN a$ = "": B$ = ""
 IF Frozen1 > 0 THEN IF Paddle2 = 6 AND (a$ + B$ = "a" OR a$ + B$ = "as" OR a$ + B$ = "ad") AND En1 < 1 OR Paddle2 = 1 AND a$ + B$ = "as" OR Paddle2 = 11 AND (a$ + B$ = "d" OR a$ + B$ = "ad") AND En1 < 1 THEN a$ = "": B$ = ""
 IF d < B THEN a$ = "w" ELSE IF d > B + 30 THEN a$ = "z"
 END IF
                                                                
IF ComboAI > 0 THEN a$ = MID$(Combo$, LEN(Combo$) - ComboAI + 1, 1): B$ = MID$(Combo$, LEN(Combo$) - ComboAI + 2, 1): ComboAI = ComboAI - 2

CLS

IF Refreeze > 0 THEN Refreeze = Refreeze - 1

Combo = 0: CEn1 = En1: CEn2 = En2
CALL Ball(Spook)
CALL Controls(a$, B$)
IF Kode = 5 THEN Combo = 0
CALL Moves(Mer1, Mer2, In1, In2, Fire, Fire2, Extend)
IF Spook > 0 AND (Paddle1 = 13 OR Paddle2 = 13) THEN Spook = 0
IF Combo = 11 AND Spook > 0 AND Zone = 2 AND Kode = 1 THEN Zone = 5: Paddle2 = 3: Shift2 = 0: PCOPY 0, 1: SCREEN 7, 0, 0, 0: CALL Portal: Kode = 0: AI = 1: GOTO 50

GOTO 100


500
 
IF Fatal < 25 OR Fatal > 30 THEN
 IF En1 > 0 THEN
  IF Inv1 = 1 AND Anim = 0 THEN LINE (0, a)-(1, a + 30), Paddle1, B
  IF Paddle1 = 13 THEN PSET (0, a + 8), 0: LINE (1, a + 8)-(1, a + 10), 0
  END IF
 IF En2 > 0 THEN
  IF Inv2 = 1 AND Anim = 0 THEN LINE (318, B)-(319, B + 30), Paddle2, B
  IF Paddle2 = 13 THEN PSET (319, B + 8), 0: LINE (318, B + 8)-(318, B + 10), 0
  END IF
 END IF

IF Paddle2 = 7 AND En2 < 1 THEN
 CLS
 LINE (318, B)-(319, B + 30), 7, B
 FOR y = 1 TO Speed * 100: NEXT y
 q = 0
 FOR j = 1 TO 14
 IF q = 0 THEN q = 2 ELSE q = 0
 LINE (318, B + q)-(319, B + 30 + q), 7, B
 FOR x = 1 TO 15 STEP 2: CIRCLE (319, B + q - x), x, 8: CIRCLE (319, B + 30 + q - x), x, 8: FOR y = 1 TO Speed * 2: NEXT y: CIRCLE (319, B + q - x), x, 0: CIRCLE (319, B + 30 + q - x), x, 0: NEXT x
 LINE (318, B + q)-(319, B + 30 + q), 0, B
 NEXT j
 LINE (318, B)-(319, B + 30), 0, B
 FOR j = 1 TO 2: COLOR 0, 4: FOR y = 1 TO Speed: NEXT y: COLOR 0, 0: FOR x = 1 TO 40: CIRCLE (319, B + 15), x, 4: FOR y = 1 TO Speed * .3: NEXT y: CIRCLE (319, B + 15), x, 0: NEXT x: NEXT j
 En1 = 1
 END IF
        
CALL Win
IF Paddle2 = 7 AND En2 < 1 THEN GOTO 750

IF Kode = 7 THEN Speed = 50

IF Tournament = 1 AND En1 > 0 THEN
 Round(Paddle2) = 1
 Zone = Zone + 1: IF Zone = 6 THEN Zone = 1
 DO
 RANDOMIZE TIMER: Paddle2 = INT(14 * RND(1) + 1)
 IF Paddle2 = 3 OR Paddle2 = 7 OR Paddle2 = 13 THEN Paddle2 = Paddle2 + 1
 Rounds = 0
 FOR x = 1 TO 14
 IF x = 3 OR x = 7 OR x = 13 THEN x = x + 1
 Rounds = Rounds + Round(x)
 NEXT x
 IF Rounds = 11 THEN Paddle2 = 15
 IF Round(15) = 1 THEN Paddle2 = 7: Zone = 5
 LOOP WHILE Round(Paddle2) = 1
 END IF

600

IF Zone = 4 AND Kode = 1 THEN Zone = 5: Paddle2 = 13: Shift2 = 0: CALL Portal: Kode = 0: AI = 1: GOTO 50
IF Tournament = 1 AND En2 < 1 THEN GOTO 18
IF AI = 0 OR En2 < 1 THEN Choice = 0: SCREEN 7, 0, 1, 0: CLS : GOTO 10

750

IF Shift1 > 0 THEN Paddle1 = 15
IF Paddle2 = 7 AND En2 < 1 THEN FOR y = 1 TO Speed * 250: NEXT y: CALL Credits
IF Kode = 21 THEN Kode = 0: Choice = 0: Spooky = 1: CLS : GOTO 10
IF Kode = 20 THEN Kode = 0: Tournament = 0: GOTO 50

SCREEN 7, 0, 1, 0: CLS

Word$ = "GAME OVER": CALL BigWrite(Word$, Name$)

j = 17
FOR x = 360 TO 0 STEP -30
j = j - 1
DRAW "s" + STR$(j) + "ta" + STR$(x)
DRAW "bm159,97c9bl55bd7" + Name$ + "bm159,98c1bl55bd7" + Name$
PCOPY 1, 0
FOR y = 1 TO Speed * 5: NEXT y
CLS
NEXT x

SCREEN 7, 0, 0, 0

FOR x = 1 TO 6
DRAW "bm104,104c7" + Name$ + "bm104,105c15" + Name$
FOR y = 1 TO Speed * 20: NEXT y
DRAW "bm104,104c9" + Name$ + "bm104,105c1" + Name$
FOR y = 1 TO Speed * 20: NEXT y
NEXT x

DO: a$ = INKEY$: LOOP WHILE a$ = ""

Choice = 0: SCREEN 7, 0, 1, 0: CLS : GOTO 10

SUB Ball (Spook)

IF BallType = 1 OR BallType = 5 THEN BallTime = BallTime - 1
IF BallType = 2 OR BallType = 4 OR BallType = 6 OR BallType = 7 OR BallType = 8 THEN BallTime = BallTime - (6 - (Speed / 10))
IF BallTime <= 0 THEN BallTime = 0: BallType = 0

BSpeed = (9 - (Speed / 10))
IF BallType = 3 THEN BallTime = BallTime - BSpeed: IF BallTime <= 0 THEN BallTime = 0: BallType = 0
IF BallType = 1 THEN BSpeed = 0
IF BallType = 6 THEN BSpeed = BSpeed * 2
IF BallType = 8 THEN BSpeed = BSpeed \ 2
IF Angle = 1 THEN c = c + BSpeed: d = d + BSpeed ELSE IF Angle = 2 THEN c = c - BSpeed: d = d - BSpeed ELSE IF Angle = 3 THEN c = c + BSpeed: d = d - BSpeed:  ELSE IF Angle = 4 THEN c = c - BSpeed: d = d + BSpeed
IF BallType = 5 THEN RANDOMIZE TIMER: x = INT(10 * RND(1) + 1): IF x < 5 THEN Angle = x

IF Vacuum = 1 OR BallType = 7 THEN IF d > a + 15 THEN Angle = 2 ELSE IF d < a + 16 THEN Angle = 4
IF Vacuum = 1 AND c < 3 THEN Vacuum = 0
IF Vacuum = 2 THEN IF d > B + 15 THEN Angle = 3 ELSE IF d < B + 16 THEN Angle = 1
IF Vacuum = 2 AND c > 316 THEN Vacuum = 0

IF Angle = 1 AND d >= 199 THEN Angle = 3
IF Angle = 4 AND d >= 199 THEN Angle = 2
IF Angle = 3 AND d <= 0 THEN Angle = 1
IF Angle = 2 AND d <= 0 THEN Angle = 4

IF En2 < 1 AND BallType = 4 AND c >= 317 AND (Angle = 1 OR Angle = 3) AND d < B + 31 AND d > B - 1 THEN Fatal = 7
IF En1 < 1 AND BallType = 4 AND c <= 2 AND (Angle = 2 OR Angle = 4) AND d < a + 31 AND d > a - 1 THEN Fatal = 8

IF c >= 317 AND (Angle = 1 OR Angle = 3) AND d < B + 31 AND d > B - 1 AND BallType <> 2 THEN
 IF Angle = 1 THEN Angle = 4
 IF Angle = 3 THEN Angle = 2
 IF (BallType = 4 OR BallType = 7) AND En1 > 0 THEN En2 = En2 - 7: Scream2 = 3: Frozen2 = 0: Net2 = 0 ELSE IF En2 > 0 THEN En1 = En1 - 3
 END IF

IF c <= 2 AND (Angle = 2 OR Angle = 4) AND d < a + 31 AND d > a - 1 AND BallType <> 2 THEN
 IF Angle = 2 THEN Angle = 3
 IF Angle = 4 THEN Angle = 1
 IF (BallType = 4 OR BallType = 7) AND En2 > 0 THEN En1 = En1 - 7: Scream1 = 3: Frozen1 = 0: Net1 = 0 ELSE IF En1 > 0 THEN En2 = En2 - 3
 END IF

IF c > 317 AND (Angle = 1 OR Angle = 3) THEN
 IF Angle = 1 THEN Angle = 4
 IF Angle = 3 THEN Angle = 2
 IF En1 > 0 THEN En2 = En2 - 5
 Scream2 = 6: Frozen2 = 0: Net2 = 0
 IF Spook = 0 THEN RANDOMIZE TIMER: x = INT(5 * RND(1) + 1): IF x = 1 THEN Spook = 1
 END IF

IF c < 2 AND (Angle = 2 OR Angle = 4) THEN
 IF Angle = 2 THEN Angle = 3
 IF Angle = 4 THEN Angle = 1
 IF En2 > 0 THEN En1 = En1 - 5
 Scream1 = 6: Frozen1 = 0: Net1 = 0
 IF Spook = 0 THEN RANDOMIZE TIMER: x = INT(5 * RND(1) + 1): IF x = 1 THEN Spook = 1
 END IF

END SUB

SUB BigWrite (Word$, Name$)

Name$ = ""

FOR x = 1 TO LEN(Word$)
a$ = MID$(Word$, x, 1)
B$ = ""
IF a$ = " " THEN B$ = "br15"
IF a$ = "A" THEN B$ = "u12e3r3f3d12l3u6l3d6l3r3bu9u3r3d3l3bd9br9"
IF a$ = "B" THEN B$ = "u15r6f3g3f3d3g3l6r3bu3u3r3d3l3bu6u3r3g3bd9br9"
IF a$ = "C" THEN B$ = "u15r6d3l3d9r3d3l6br9"
IF a$ = "D" THEN B$ = "u15r6f3d9g3l6r3bu3u9r3d9l3bd3br9"
IF a$ = "E" THEN B$ = "u15r6d3l3d3r3d3l3d3r3d3l6br9"
IF a$ = "F" THEN B$ = "u15r6d3l3d3r3d3l3d6l3br9"
IF a$ = "G" THEN B$ = "u15r12d3l9d9r6u3l3u3r6d9l12br15"
IF a$ = "H" THEN B$ = "r3u6r3d6r3u15l3d6l3u6l3d15br12"
IF a$ = "I" THEN B$ = "u15r3d15l3br6"
IF a$ = "J" THEN B$ = "u6r3d3r3u12r3d15l9br12"
IF a$ = "K" THEN B$ = "u15r3d3e3r3g6f6d3l3u3h3d6l3br12"
IF a$ = "L" THEN B$ = "u15r3d12r3d3l6br9"
IF a$ = "M" THEN B$ = "u15r3f3e3r3d15l3u9g3h3d9l3br15"
IF a$ = "N" THEN B$ = "u15r3f6u6r3d15L3h6d6l3br15"
IF a$ = "O" THEN B$ = "u15r9d15l9r3bu3u9r3d9l3bd3br9"
IF a$ = "P" THEN B$ = "u15r9d9l6d6l3r3bu9u3r3d3l3bd9br9"
IF a$ = "Q" THEN B$ = "u15r9d15f3l3h3l6r3bu3u9r3d9l3bd3br9"
IF a$ = "R" THEN B$ = "u15r6f3d3g3f3d3l3u3h3d6l3r3bu9u3r3d3l3bd9br9"
IF a$ = "S" THEN B$ = "u3r6u3l6u9r9d3l6d3r6d9l9br12"
IF a$ = "T" THEN B$ = "br3u12l3u3r9d3l3d12l3br9"
IF a$ = "U" THEN B$ = "u15r3d12r3u12r3d15l9br12"
IF a$ = "V" THEN B$ = "br6h6u9r3d6f3e3u6r3d9g6br9"
IF a$ = "W" THEN B$ = "bu3f3e3f3e3u12l3d9h3g3u9l3d12bd3br15"
IF a$ = "X" THEN B$ = "u3e3u3h3u3f6e6d3g3d3f3d3l3u3h3g3d3l3br15"
IF a$ = "Y" THEN B$ = "br3u9h3u3f3r3e3d3g3d9l3br9"
IF a$ = "Z" THEN B$ = "u3e9l9u3r12d6g6r6d3l12br15"
IF a$ = "0" THEN B$ = "br3h3u9e3r3f3d9g3l3bu3u9r3d9l3bd3br9"
IF a$ = "1" THEN B$ = "br3u12l3e3r3d15l3br6"
IF a$ = "2" THEN B$ = "u3e6u3l3g3u3e3r6d9g3r3d3l9br12"
IF a$ = "3" THEN B$ = "r6e3u9h3l6d3r3d3l3d3r3d3l3d3br12"
IF a$ = "4" THEN B$ = "br3u6l3u3e6r3d15l3bu9u3g3r3bd9l3br9"
IF a$ = "5" THEN B$ = "r6e3u3h3l3u3r6u3l9d9r3d3l3d3br12"
IF a$ = "6" THEN B$ = "r9u9l6bd3r3d3l3u3bu3u6l3d15br12"
IF a$ = "7" THEN B$ = "u3e6u3l6u3r9d9g3d3l6br12"
IF a$ = "8" THEN B$ = "u15r9d15l9r3bu6r3d3l3u3bu6r3d3l3u3bd12br9"
IF a$ = "9" THEN B$ = "br6u6l6u9r9d15l3bu9l3u3r3d3bd9br6"
IF a$ = "!" THEN B$ = "u3r3d3l3bu6u9r3d9l3bd6br6"
IF a$ = "?" THEN B$ = "br3u3r3d3l3bu6u3r3u3l3g3u3e3r6d9l6bd6br9"
IF a$ = "." THEN B$ = "u3r3d3l3br6"
IF a$ = "-" THEN B$ = "bu6r6u3l6d3bd6br9"
Name$ = Name$ + B$
NEXT x
                  
END SUB

SUB Bios (Paddle, Victory)

CLS

DRAW "bm130,60c8u50r60d50l60r2c7bu2u46r56d46l56"
DRAW "bm50,183c8u70r220d70l220r2c7bu2u66r216d66l216"
LINE (159, 20)-(160, 50), Paddle, B

j = 22
IF Paddle = 1 THEN Word$ = "CHILLN": x = 1: y = 9
IF Paddle = 2 THEN Word$ = "SHOCKER": j = 14: x = 2: y = 10
IF Paddle = 4 THEN Word$ = "BLOODBATH": j = 0: x = 4: y = 12
IF Paddle = 5 THEN Word$ = "CYBER": j = 26: x = 5: y = 13
IF Paddle = 6 THEN Word$ = "ICEPICK": x = 6: y = 14
IF Paddle = 8 THEN Word$ = "NINJA": x = 7: y = 8
IF Paddle = 9 THEN Word$ = "BANSHEE": j = 11: x = 9: y = 3
IF Paddle = 10 THEN Word$ = "SYLVA": x = 10: y = 2
IF Paddle = 11 THEN Word$ = "GLACIER": j = 16: x = 11: y = 3
IF Paddle = 12 THEN Word$ = "BLACKOUT": j = 9: x = 12: y = 4
IF Paddle = 13 AND Victory = 0 THEN Word$ = "?": j = 45: x = 5: y = 13
IF Paddle = 13 AND Victory = 1 THEN Word$ = "SPOOK": j = 23: x = 13: y = 5
IF Paddle = 14 THEN Word$ = "FIREBUG": j = 14: x = 14: y = 6
IF Paddle = 15 THEN Word$ = "SHIFTER": j = 16: x = 15: y = 7
CALL BigWrite(Word$, Name$)

DRAW "bm" + STR$(109 + j) + ",94c" + STR$(y) + Name$ + "bm" + STR$(109 + j) + ",95c" + STR$(x) + Name$

j = 0
IF Victory = 0 THEN
 IF Paddle = 1 THEN Word$ = "THE COLD KILLER CHILLN PREPARES TO RETRIEVE ICEPICK.": j = 2
 IF Paddle = 2 THEN Word$ = "THE LORD OF LIGHTNING RETURNS. SEEKING REVENGE": j = 6
 IF Paddle = 4 THEN Word$ = "THE FORMER MASTER OF THE TOURNAMENT HAS RETURNED"
 IF Paddle = 5 THEN Word$ = "FORMERLY KNOWN AS THE ASSASSIN SPIDER. CYBER HAS"
 IF Paddle = 6 THEN Word$ = "AFTER BEING DEFEATED BY BLOODBATH IN THE FIRST": j = 7
 IF Paddle = 8 THEN Word$ = "NINJA IS A SHADOWY COMPETER WHOSE DEADLY SKILLS": j = 4
 IF Paddle = 9 THEN Word$ = "THE DEAD WIFE OF SHAO PONG. BANSHEE HAS ENTERED": j = 4
 IF Paddle = 10 THEN Word$ = "BELIEVED TO BE THE TRUE MASTERMIND BEHIND THE": j = 7
 IF Paddle = 11 THEN Word$ = "GLACIER. THE MASTER OF ICE. HAS ENTERED THE THIRD": j = 4
 IF Paddle = 12 THEN Word$ = "THE MYSTERIOUS BLACKOUT RETURNS FOR ROUND THREE": j = 2
 IF Paddle = 13 THEN Word$ = ""
 IF Paddle = 14 THEN Word$ = "FIREBUG ENTERED THE SECOND TOURNAMENT TO DRAW": j = 4
 IF Paddle = 15 THEN Word$ = "SHAPESHIFTER. AFTER CLAIMING VICTORY IN THE SECOND"
 END IF
IF Victory = 1 THEN
 IF Paddle = 1 THEN Word$ = "WITH THE ELIMINATION OF ICEPICK AND GLACIER. CHILLN": j = 1
 IF Paddle = 2 THEN Word$ = "SEEING THE THREAT SHAO PONG POSES TO THE EARTH": j = 5
 IF Paddle = 4 THEN Word$ = "ONCE AGAIN. BLOODBATH OVERCOMES ALL CHALLENGERS. HE"
 IF Paddle = 5 THEN Word$ = "WITH HIS NEW TECHNOLOGY. CYBER OVERCOMES THREE TOP": j = -1
 IF Paddle = 6 THEN Word$ = "ICEPICK ABANDONS HIS CLAN TO PURSUE HIS OBSESSION": j = 2
 IF Paddle = 8 THEN Word$ = "NINJA WAS HIRED BY SHAO PONG TO ELIMINATE THE TRUE": j = -1
 IF Paddle = 9 THEN Word$ = "RESTORED TO LIFE BY HER HUSBAND. SHAO PONG.": j = 11
 IF Paddle = 10 THEN Word$ = "AFTER YEARS OF WATCHING THE TOURNAMENT IN SECRET."
 IF Paddle = 11 THEN Word$ = "GLACIER. THE MASTER OF ICE. ENTERS THE THIRD": j = 12
 IF Paddle = 12 THEN Word$ = "ANOTHER VICTORY... NO SURPRISE TO BLACKOUT. HE": j = 6
 IF Paddle = 13 THEN Word$ = "A WARRIOR KILLED BY SHAO PONG LONG AGO. SPOOK": j = 7
 IF Paddle = 14 THEN Word$ = "WHEN GLACIER REVEALED HIMSELF. FIREBUG IMMEDIATELY": j = 1
 IF Paddle = 15 THEN Word$ = "SHAPESHIFTER PLEASED HIS MASTER WITH THE DEFEAT OF": j = 1
 END IF
CALL SmallWrite(Word$, Name$)
DRAW "bm" + STR$(70 + j) + ",135c14" + Name$

j = 0
IF Victory = 0 THEN
 IF Paddle = 1 THEN Word$ = "WHO LEFT THE CLAN EARLIER TO PURSUE THE": j = 17
 IF Paddle = 2 THEN Word$ = "FOR HIS HUMILIATING DEFEAT AT THE HANDS OF": j = 11
 IF Paddle = 4 THEN Word$ = "TO DEFEND HIS TITLE AND TO PROVE HIMSELF ONCE AGAIN": j = 1
 IF Paddle = 5 THEN Word$ = "BEEN ENDOWED WITH CYBERNETIC TECHNOLOGY. HIS ROLE"
 IF Paddle = 6 THEN Word$ = "TOURNAMENT. ICEPICK VOWED TO DESTROY BLOODBATH": j = 3
 IF Paddle = 8 THEN Word$ = "ARE WELL KNOWN ALTHOUGH HIS REASONS FOR ENTERING": j = 2
 IF Paddle = 9 THEN Word$ = "TO FIGHT ALONG SIDE HER DEVIOUS HUSBAND AND": j = 11
 IF Paddle = 10 THEN Word$ = "TOURNAMENT. SYLVA HAS OBSERVED CLOSELY. ONLY NOW"
 IF Paddle = 11 THEN Word$ = "AND FINAL TOURNAMENT TO HUMILIATE HIS COLD": j = 13
 IF Paddle = 12 THEN Word$ = "AGAINST HIS UNIQUE OPPONENTS. HE BATTLES FOR ONE": j = 2
 IF Paddle = 13 THEN Word$ = "HA HA HA HA HA...": j = 62
 IF Paddle = 14 THEN Word$ = "OUT HIS MORTAL ENEMY. GLACIER. WHEN GLACIER ENTERED"
 IF Paddle = 15 THEN Word$ = "TOURNAMENT. ALLOWED HIS MASTER. SHAO PONG. TO": j = 3
 END IF
IF Victory = 1 THEN
 IF Paddle = 1 THEN Word$ = "FINALLY GAINS HIS WELL-DESERVED PROMOTION...": j = 13
 IF Paddle = 2 THEN Word$ = "REALM. SHOCKER ENTERS THE TOURNAMENT. DESTROYS": j = 5
 IF Paddle = 4 THEN Word$ = "RECLAIMS HIS TITLE AS MASTER OF THE TOURNAMENT AND"
 IF Paddle = 5 THEN Word$ = "ASSASSINS OF RIVAL CLANS... CHILLN. ICEPICK. AND NINJA.": j = -1
 IF Paddle = 6 THEN Word$ = "WITH THE TOURNAMENT. AFTER SO LONG. ICEPICK FINALLY"
 IF Paddle = 8 THEN Word$ = "POWER BEHIND THE TOURNAMENTS... SYLVA. BUT NINJA'S"
 IF Paddle = 9 THEN Word$ = "BANSHEE GOES INSANE. SHE KILLS EVERYONE. INCLUDING": j = 1
 IF Paddle = 10 THEN Word$ = "SYLVA REVEALS HERSELF AND DEFEATS SHAO PONG.": j = 10
 IF Paddle = 11 THEN Word$ = "TOURNAMENT AND THOROUGHLY HUMILIATES HIS WEAKER": j = 1
 IF Paddle = 12 THEN Word$ = "QUICKLY BORES WITH THE TOURNAMENT AND DISAPPEARS"
 IF Paddle = 13 THEN Word$ = "RAISES THE LIVING DEAD AND THEY TAKE OVER THE EARTH."
 IF Paddle = 14 THEN Word$ = "ENTERED THE THIRD TOURNAMENT AND DESTROYED HIS": j = 3
 IF Paddle = 15 THEN Word$ = "HIS ENEMIES. BUT SHAPESHIFTER TURNS ON SHAO PONG": j = 2
 END IF
CALL SmallWrite(Word$, Name$)
DRAW "bm" + STR$(70 + j) + ",150c14" + Name$

j = 0
IF Victory = 0 THEN
 IF Paddle = 1 THEN Word$ = "TOURNAMENT. RETRIEVE HIM. DEAD OR ALIVE...": j = 14
 IF Paddle = 2 THEN Word$ = "THE RED PADDLE. BLOODBATH.": j = 42
 IF Paddle = 4 THEN Word$ = "AGAINST HIS MORTAL ENEMIES. SHOCKER AND ICEPICK.": j = 6
 IF Paddle = 5 THEN Word$ = "IN THE TOURNAMENT IS UNKNOWN.": j = 38
 IF Paddle = 6 THEN Word$ = "AND TAKE THE TITLE AS MASTER OF THE TOURNAMENT.": j = 3
 IF Paddle = 8 THEN Word$ = "THE TOURNAMENT ARE NOT.": j = 46
 IF Paddle = 9 THEN Word$ = "DEFEAT ALL CHALLENGERS. BUT...": j = 40
 IF Paddle = 10 THEN Word$ = "DOES SHE REVEAL HERSELF AND ENTER THE TOURNAMENT.": j = 1
 IF Paddle = 11 THEN Word$ = "COMPETERS. CHILLN AND ICEPICK.": j = 35
 IF Paddle = 12 THEN Word$ = "THING ONLY...  THE THRILL OF VICTORY.": j = 25
 IF Paddle = 13 THEN Word$ = ""
 IF Paddle = 14 THEN Word$ = "THE THIRD TOURNAMENT. FIREBUG WAS NOT FAR BEHIND.": j = 2
 IF Paddle = 15 THEN Word$ = "PASS THROUGH THE VOID AND BEGIN THE FINAL BATTLE."
 END IF
IF Victory = 1 THEN
 IF Paddle = 1 THEN Word$ = "AS LEADER OF THE CLAN.": j = 52
 IF Paddle = 2 THEN Word$ = "SHAO PONG AND HIS MINIONS. AND CLAIMS VICTORY.": j = 7
 IF Paddle = 4 THEN Word$ = "HAS BEEN UNDEFEATED EVER SINCE.": j = 38
 IF Paddle = 5 THEN Word$ = "SHORTLY AFTER. THE ENTIRE CLAN IS CYBERNIZED.": j = 10
 IF Paddle = 6 THEN Word$ = "CLAIMS THE TITLE OF MASTER OF THE TOURNAMENT.": j = 9
 IF Paddle = 8 THEN Word$ = "TRUE INTENTION WAS TO KILL EVERYONE AND TAKE OVER.": j = 2
 IF Paddle = 9 THEN Word$ = "HER HUSBAND. AND IS DOOMED TO A RESTLESS SOUL.": j = 7
 IF Paddle = 10 THEN Word$ = "RECLAIMING HER POWER OVER THE TOURNAMENT.": j = 13
 IF Paddle = 11 THEN Word$ = "COMPETERS OF COLD. CHILLN AND ICEPICK.": j = 25
 IF Paddle = 12 THEN Word$ = "INTO THE SHADOWS OF WHICH HE CAME.": j = 29
 IF Paddle = 13 THEN Word$ = "HAVE A NICE DAY!": j = 63
 IF Paddle = 14 THEN Word$ = "ARCHRIVAL ONCE AND FOR ALL.": j = 42
 IF Paddle = 15 THEN Word$ = "AND TAKES OVER THE EARTH REALM.": j = 34
 END IF
CALL SmallWrite(Word$, Name$)
DRAW "bm" + STR$(70 + j) + ",165c14" + Name$

END SUB

SUB Bleed1 (Blood1)

FOR u = 1 TO 3

n = 5
RANDOMIZE TIMER: x = INT(2 * RND(1) + 1)
IF x = 1 THEN
 CIRCLE (15, a + 7), 10, Blood1, 2, 3, 1: CIRCLE (15, a + 7), 10, Blood1, 2, 3, .7
 CIRCLE (13, a), 2, Blood1, 4, 2: PAINT (13, a), Blood1
 FOR y = 1 TO Speed: NEXT y
 CIRCLE (15, a + 7), 10, 0, 2, 3, 1: CIRCLE (15, a + 7), 10, 0, 2, 3, .7: PAINT (13, a), 0
 CIRCLE (20, a + 15), 10, Blood1, 0, 1, 1: CIRCLE (21, a + 15), 10, Blood1, 0, 1, 1.7
 CIRCLE (29, a + 16), 2, Blood1, 3, 1: PAINT (29, a + 16), Blood1
 FOR y = 1 TO Speed: NEXT y
 CIRCLE (20, a + 15), 10, 0, 0, 1, 1: CIRCLE (21, a + 15), 10, 0, 0, 1, 1.7: PAINT (29, a + 16), 0
 n = 30
 END IF

RANDOMIZE TIMER: q = INT(4 * RND(1) + 1): q = q * 2: q = q + 14
FOR x = a + 25 TO 190 STEP 10: n = n + q * .2: LINE (n - 4, x - 7)-(n + 2, x - 1), Blood1: LINE (n - 4, x - 7)-(n - 2, x), Blood1: CIRCLE (n, x), 2, Blood1, 3, 0: PAINT (n, x), Blood1: PSET (n - 4, x - 7), 0: FOR y = 1 TO Speed * 2: NEXT y: PAINT (n, x), 0: NEXT x
FOR x = 1 TO 15: CIRCLE (n, 200), x, Blood1, , , .2: FOR y = 1 TO Speed: NEXT y: NEXT x
FOR x = 15 TO 13 STEP -1: CIRCLE (n, 200), x, 0, , , .2: FOR y = 1 TO Speed: NEXT y: NEXT x: PSET (n - 15, 199), Blood1

NEXT u

END SUB

SUB Bleed2 (Blood2)

FOR u = 1 TO 3

n = 315
RANDOMIZE TIMER: x = INT(2 * RND(1) + 1)
IF x = 1 THEN
 CIRCLE (304, B + 7), 10, Blood2, 0, 1, 1: CIRCLE (304, B + 7), 10, Blood2, 0, 1, .7
 CIRCLE (307, B), 2, Blood2, 1, 5: PAINT (307, B), Blood2
 FOR y = 1 TO Speed: NEXT y
 CIRCLE (304, B + 7), 10, 0, 0, 1, 1: CIRCLE (304, B + 7), 10, 0, 0, 1, .7: PAINT (307, B), 0
 CIRCLE (299, B + 15), 10, Blood2, 2, 3, 1: CIRCLE (298, B + 15), 10, Blood2, 2, 3, 1.7
 CIRCLE (290, B + 16), 2, Blood2, 3, 1: PAINT (290, B + 16), Blood2
 FOR y = 1 TO Speed: NEXT y
 CIRCLE (299, B + 15), 10, 0, 2, 3, 1: CIRCLE (298, B + 15), 10, 0, 2, 3, 1.7: PAINT (290, B + 16), 0
 n = 285
 END IF

RANDOMIZE TIMER: q = INT(4 * RND(1) + 1): q = q * 2: q = q + 14
FOR x = B + 24 TO 190 STEP 10: n = n - q * .2: LINE (n + 3, x - 6)-(n - 2, x - 1), Blood2: LINE (n + 3, x - 6)-(n + 2, x), Blood2: CIRCLE (n, x), 2, Blood2, 3, 0: PAINT (n, x), Blood2: FOR y = 1 TO Speed * 2: NEXT y: PAINT (n, x), 0: NEXT x
FOR x = 1 TO 15: CIRCLE (n, 200), x, Blood2, , , .2: FOR y = 1 TO Speed: NEXT y: NEXT x
FOR x = 15 TO 13 STEP -1: CIRCLE (n, 200), x, 0, , , .2: FOR y = 1 TO Speed: NEXT y: NEXT x: PSET (n + 15, 199), Blood2

NEXT u

END SUB

SUB Controls (a$, B$)

IF Frozen1 > 0 THEN Frozen1 = Frozen1 - 1
IF Frozen2 > 0 THEN Frozen2 = Frozen2 - 1
IF Scream1 > 0 THEN Scream1 = Scream1 - 1
IF Scream2 > 0 THEN Scream2 = Scream2 - 1
IF Net1 > 0 THEN Net1 = Net1 - 1
IF Net2 > 0 THEN Net2 = Net2 - 1
IF Frozen1 > 0 OR Scream1 > 0 OR Net1 > 0 OR Hits2 > 1 OR En1 < 1 THEN IF a$ = "8" OR a$ = "2" OR a$ = "4" OR a$ = "5" OR a$ = "6" THEN a$ = "": B$ = ""
IF Frozen2 > 0 OR Scream2 > 0 OR Net2 > 0 OR Hits > 1 OR En2 < 1 THEN IF a$ = "w" OR a$ = "z" OR a$ = "a" OR a$ = "s" OR a$ = "d" THEN a$ = "": B$ = ""

IF a$ = "w" THEN B = B - 30: IF B < 0 THEN B = 0
IF a$ = "z" THEN B = B + 30: IF B > 169 THEN B = 169
IF a$ = "8" THEN a = a - 30: IF a < 0 THEN a = 0
IF a$ = "2" THEN a = a + 30: IF a > 169 THEN a = 169

IF a$ = "4" THEN Combo = 1 ' Button 1
IF a$ = "5" THEN Combo = 2 ' Button 2
IF a$ = "6" THEN Combo = 3 ' Button 3
IF a$ + B$ = "45" OR a$ + B$ = "54" THEN Combo = 4 ' Button 1 + Button 2
IF a$ + B$ = "46" OR a$ + B$ = "64" THEN Combo = 5 ' Button 1 + Button 3
IF a$ + B$ = "56" OR a$ + B$ = "65" THEN Combo = 6 ' Button 2 + Button 3
IF a$ + B$ = "48" OR a$ + B$ = "84" THEN Combo = 7 ' Up + Button 1
IF a$ + B$ = "58" OR a$ + B$ = "85" THEN Combo = 8 ' Up + Button 2
IF a$ + B$ = "68" OR a$ + B$ = "86" THEN Combo = 9 ' Up + Button 3
IF a$ + B$ = "42" OR a$ + B$ = "24" THEN Combo = 10 ' Down + Button 1
IF a$ + B$ = "52" OR a$ + B$ = "25" THEN Combo = 11 ' Down + Button 2
IF a$ + B$ = "62" OR a$ + B$ = "26" THEN Combo = 12 ' Down + Button 3
IF a$ + B$ = "28" OR a$ + B$ = "82" THEN Combo = 13 ' Up + Down

IF a$ = "a" THEN Combo = 14 ' Button 1
IF a$ = "s" THEN Combo = 15 ' Button 2
IF a$ = "d" THEN Combo = 16 ' Button 3
IF a$ + B$ = "as" OR a$ + B$ = "sa" THEN Combo = 17 ' Button 1 + Button 2
IF a$ + B$ = "ad" OR a$ + B$ = "da" THEN Combo = 18 ' Button 1 + Button 3
IF a$ + B$ = "sd" OR a$ + B$ = "ds" THEN Combo = 19 ' Button 2 + Button 3
IF a$ + B$ = "aw" OR a$ + B$ = "wa" THEN Combo = 20 ' Up + Button 1
IF a$ + B$ = "sw" OR a$ + B$ = "ws" THEN Combo = 21 ' Up + Button 2
IF a$ + B$ = "dw" OR a$ + B$ = "wd" THEN Combo = 22 ' Up + Button 3
IF a$ + B$ = "az" OR a$ + B$ = "za" THEN Combo = 23 ' Down + Button 1
IF a$ + B$ = "sz" OR a$ + B$ = "zs" THEN Combo = 24 ' Down + Button 2
IF a$ + B$ = "dz" OR a$ + B$ = "zd" THEN Combo = 25 ' Down + Button 3
IF a$ + B$ = "zw" OR a$ + B$ = "wz" THEN Combo = 26 ' Up + Down

END SUB

SUB Credits

Victory = 1: Paddle = Paddle1
CALL Bios(Paddle, Victory)
FOR x = 1 TO 65000: NEXT x

CLS

Word$ = "CAST OF CHARACTERS": CALL SmallWrite(Word$, Name$)
DRAW "bm130,74c14" + Name$
FOR y = 1 TO Speed * 100: NEXT y

FOR q = 1 TO 15

IF q = 3 OR q = 7 OR q = 13 THEN q = q + 1

IF q = 1 OR q = 6 OR q = 11 THEN
 SOUND 200, .5: SOUND 10000, 1: LINE (160, 85)-(160, 115), 3: LINE (161, 85)-(161, 115), 11
 FOR y = 1 TO Speed * 100: NEXT y
 END IF
IF q = 2 THEN FOR j = -1 TO 6: FOR x = 0 TO 200 STEP 20: LINE (163 - j, x)-(158 + j, x + 10), 10: LINE (158 + j, x + 10)-(163 - j, x + 20), 10: NEXT x: FOR y = 1 TO Speed * 2: NEXT y: FOR x = 0 TO 200 STEP 20: LINE (163 - j, x)-(158 + j, x + 10), 0: LINE (158 + j, x + 10)-(163 - j, x + 20), 0: NEXT x: NEXT j
IF q = 4 THEN
 FOR x = 0 TO 5: PSET (161, 100 + x), 0: PSET (161, 100 - x), 0: FOR y = 1 TO Speed * 4: NEXT y: NEXT x
 FOR x = 162 TO 177: PSET (x, 100), 6: FOR y = 1 TO Speed * 3: NEXT y: NEXT x
 FOR x = 5 TO 0 STEP -1: PSET (161, 100 + x), 2: PSET (161, 100 - x), 2: FOR y = 1 TO Speed * 4: NEXT y: NEXT x
 END IF
IF q = 5 THEN
 FOR x = 0 TO 5: PSET (161, 100 + x), 0: PSET (161, 100 - x), 0: FOR y = 1 TO Speed * 4: NEXT y: NEXT x
 FOR x = 177 TO 162 STEP -1: PSET (x, 100), 0: FOR y = 1 TO Speed * 3: NEXT y: NEXT x
 FOR x = 5 TO 0 STEP -1: PSET (161, 100 + x), 4: PSET (161, 100 - x), 4: FOR y = 1 TO Speed * 4: NEXT y: NEXT x
 FOR x = 2 TO 160 STEP 2: PSET (x - 1, 100), 5: LINE (x, 103)-(x, 97), 5: LINE (x, 97)-(x + 3, 97), 5: LINE (x, 103)-(x + 3, 103), 5: FOR y = 1 TO Speed: NEXT y: LINE (x, 103)-(x, 97), 0: LINE (x, 97)-(x + 3, 97), 0: LINE (x, 103)-(x + 3, 103), 0: NEXT x
 PSET (159, 100), 0: LINE (160, 85)-(161, 115), 0, B: LINE (160, 85)-(161, 115), 5, B
 FOR x = 153 TO -4 STEP -2: LINE (x + 4, 85)-(x + 5, 115), q - 1, B: LINE (x, 103)-(x, 97), 5: LINE (x, 97)-(x + 3, 97), 5: LINE (x, 103)-(x + 3, 103), 5: FOR y = 1 TO Speed: NEXT y: LINE (x + 4, 85)-(x + 5, 115), 0, B: LINE (x, 103)-(x, 97), 0: LINE (x, 97)-(x + 3, 97), 0: LINE (x, 103)-(x + 3, 103), 0: NEXT x
 END IF
IF q = 8 THEN FOR j = 1 TO 3: FOR x = 1 TO 15 STEP 2: CIRCLE (161, 90 - x), x, 8: CIRCLE (161, 120 - x), x, 8: FOR y = 1 TO Speed * 2: NEXT y: CIRCLE (161, 90 - x), x, 0: CIRCLE (161, 120 - x), x, 0: NEXT x: NEXT j
IF q = 9 OR q = 12 THEN
 FOR x = 0 TO 15: PSET (160, 100 + x), 0: PSET (160, 100 - x), 0: PSET (161, 85 + x), 0: PSET (161, 115 - x), 0: FOR y = 1 TO Speed * 2: NEXT y: NEXT x
 FOR y = 1 TO Speed * 20: NEXT y
 END IF
IF q = 10 THEN FOR x = 0 TO 115: LINE (160, x - 30)-(160, x), 10: LINE (161, 200 - x + 30)-(161, 200 - x), 10: FOR y = 1 TO Speed * 2: NEXT y: LINE (160, x - 30)-(160, x), 0: LINE (161, 200 - x + 30)-(161, 200 - x), 0: NEXT x
IF q = 14 THEN CIRCLE (160, 100), 1, 0: FOR x = 1 TO 25: CIRCLE (161, 100), x, 6: FOR y = 1 TO Speed: NEXT y: CIRCLE (161, 100), x, 0: NEXT x
IF q = 1 OR q = 6 OR q = 9 OR q = 11 OR q = 12 OR q = 15 THEN
 FOR x = 0 TO 15: PSET (161, 100 + x), q: PSET (161, 100 - x), q: PSET (160, 85 + x), q: PSET (160, 115 - x), q: FOR y = 1 TO Speed * 2: NEXT y: NEXT x
 END IF

LINE (160, 85)-(161, 115), q, B

n = 7
IF q = 1 THEN Word$ = "CHILLN"
IF q = 2 THEN Word$ = "SHOCKER": n = 5
IF q = 4 THEN Word$ = "BLOODBATH": n = 0
IF q = 5 THEN Word$ = "CYBER": n = 9
IF q = 6 THEN Word$ = "ICEPICK"
IF q = 8 THEN Word$ = "NINJA": n = 8
IF q = 9 THEN Word$ = "BANSHEE": n = 4
IF q = 10 THEN Word$ = "SYLVA": n = 8
IF q = 11 THEN Word$ = "GLACIER": n = 6
IF q = 12 THEN Word$ = "BLACKOUT": n = 3
IF q = 14 THEN Word$ = "FIREBUG": n = 4
IF q = 15 THEN Word$ = "SHIFTER": n = 6

CALL SmallWrite(Word$, Name$): Star$ = Name$
DRAW "bm" + STR$(144 + n) + ",130c" + STR$(q) + Star$
Word$ = "CAST OF CHARACTERS": CALL SmallWrite(Word$, Name$)
DRAW "bm130,74c14" + Name$
FOR y = 1 TO Speed * 100: NEXT y
DRAW "bm" + STR$(144 + n) + ",130c0" + Star$

NEXT q

FOR x = 0 TO 15: PSET (160, 100 + x), 0: PSET (160, 100 - x), 0: PSET (161, 85 + x), 0: PSET (161, 115 - x), 0: FOR y = 1 TO Speed * 2: NEXT y: NEXT x
Word$ = "CAST OF CHARACTERS": CALL SmallWrite(Word$, Name$)
DRAW "bm130,74c0" + Name$
FOR y = 1 TO Speed * 100: NEXT y

Word$ = "SPECIAL THANKS TO": CALL SmallWrite(Word$, Name$)
DRAW "bm131,90c14" + Name$
FOR y = 1 TO Speed * 100: NEXT y
Word$ = "NATHAN SWEET": CALL SmallWrite(Word$, Name$)
DRAW "bm138,100c14" + Name$: FOR y = 1 TO Speed * 200: NEXT y
DRAW "bm138,100c0" + Name$: FOR y = 1 TO Speed * 100: NEXT y
Word$ = "TRAVIS ECKMAN": CALL SmallWrite(Word$, Name$)
DRAW "bm137,100c14" + Name$: FOR y = 1 TO Speed * 200: NEXT y
DRAW "bm137,100c0" + Name$: FOR y = 1 TO Speed * 100: NEXT y
Word$ = "PC SYLVA": CALL SmallWrite(Word$, Name$)
DRAW "bm147,100c14" + Name$: FOR y = 1 TO Speed * 200: NEXT y
DRAW "bm147,100c0" + Name$
Word$ = "SPECIAL THANKS TO": CALL SmallWrite(Word$, Name$)
DRAW "bm131,90c0" + Name$
FOR y = 1 TO Speed * 200: NEXT y

Word$ = "CHECK OUT OUR FTP SITE!": CALL SmallWrite(Word$, Name$)
Star$ = Name$
Word$ = "USERS.AOL.COM/LORDREALM": CALL SmallWrite(Word$, Name$)
DRAW "bm124,90c14" + Star$ + "bm120,100c14" + Name$
FOR y = 1 TO Speed * 400: NEXT y
DRAW "bm124,90c0" + Star$ + "bm120,100c0" + Name$
FOR y = 1 TO Speed * 200: NEXT y

CALL Ultimate

END SUB

SUB Finish

Blood1 = 4
IF Paddle1 = 5 THEN Blood1 = 1
IF Paddle1 = 9 THEN Blood1 = 2
IF Paddle1 = 13 THEN Blood1 = 7

Blood2 = 4
IF Paddle2 = 0 OR Paddle2 = 5 THEN Blood2 = 1
IF Paddle2 = 9 THEN Blood2 = 2
IF Paddle2 = 13 THEN Blood2 = 7

IF Fatal = 11 OR Fatal = 13 OR Fatal = 29 OR Friend = 1 THEN FOR x = 0 TO 5: PSET (1, a + 15 + x), 0: PSET (1, a + 15 - x), 0: FOR y = 1 TO Speed * 4: NEXT y: NEXT x
IF Fatal = 12 OR Fatal = 14 OR Fatal = 30 OR Friend = 2 THEN FOR x = 0 TO 5: PSET (318, B + 15 + x), 0: PSET (318, B + 15 - x), 0: FOR y = 1 TO Speed * 4: NEXT y: NEXT x

' Slice Fatality
IF Fatal = 1 THEN
 IF Paddle1 = 12 THEN LINE (318, B + 15)-(319, B + 15), 0
 CALL Bleed2(Blood2)
 FOR x = 1 TO 10 STEP 2: LINE (318, B - x)-(319, B - x + 14), Paddle2, B: LINE (318, B - x + 14)-(319, B + x + 16), 0, B: LINE (318, B + x + 16)-(319, B + x + 30), Paddle2, B: FOR y = 1 TO Speed * 2: NEXT y: NEXT x
 END IF

IF Fatal = 2 THEN
 IF Paddle2 = 12 THEN LINE (0, a + 15)-(1, a + 15), 0
 CALL Bleed1(Blood1)
 FOR x = 1 TO 10 STEP 2: LINE (0, a - x)-(1, a - x + 14), Paddle1, B: LINE (0, a - x + 14)-(1, a + x + 16), 0, B: LINE (0, a + x + 16)-(1, a + x + 30), Paddle1, B: FOR y = 1 TO Speed * 2: NEXT y: NEXT x
 END IF

' Crumble Fatality
IF Fatal = 3 THEN
 IF Paddle1 = 8 THEN FOR x = 10 TO 310 STEP 4: Star$ = "bm" + STR$(x) + "," + STR$(a + 15) + "bl2bu2u4f4r4g4d4h4l4e5u1f3r2g3d2h3l2e3": DRAW "c8" + Star$: FOR y = 1 TO Speed: NEXT y: DRAW "c0" + Star$: NEXT x
 SCREEN 7, 0, 1, 0: PCOPY 0, 1
 q = 300: x = -11
 Name$ = "u3r1d5l1u2"
 Star$ = "u3r1d5l1u2"
 IF Paddle1 = 11 THEN Star$ = "c3u3r1c11d5l1c3u2": SOUND 7000, 1: SOUND 10000, 1
 FOR j = 0 TO (200 - B) * 2.925 STEP 20
 x = x + 11
 q = q + 60: IF q > 360 THEN q = 60
 DRAW "bm" + STR$(318 - x \ 2) + "," + STR$(B + 3 + j) + "ta" + STR$(q) + "c" + STR$(Paddle2) + Star$ + "bm" + STR$(318 - x) + "," + STR$(B + 8 + j \ 2) + Star$ + "bm" + STR$(318 - x \ 3) + "," + STR$(B + 13 + j \ 3) + Star$ + "bm" + STR$(318 - x \ 2) + "," + STR$(B + 18 + j \ 3) + Star$ + "bm" + STR$(318 - x) + "," + STR$(B + 23 + j \ 2) + Star$ + "bm" + STR$(318 - x) + "," + STR$(B + 28 + j) + Star$
 PCOPY 1, 0
 FOR y = 1 TO Speed: NEXT y
 DRAW "bm" + STR$(318 - x \ 2) + "," + STR$(B + 3 + j) + "ta" + STR$(q) + "c0" + Name$ + "bm" + STR$(318 - x) + "," + STR$(B + 8 + j \ 2) + Name$ + "bm" + STR$(318 - x \ 3) + "," + STR$(B + 13 + j \ 3) + Name$ + "bm" + STR$(318 - x \ 2) + "," + STR$(B + 18 + j \ 3) + Name$ + "bm" + STR$(318 - x) + "," + STR$(B + 23 + j \ 2) + Name$ + "bm" + STR$(318 - x) + "," + STR$(B + 28 + j) + Name$
 NEXT j
 CLS : PCOPY 0, 1: SCREEN 7, 0, 0, 0: PCOPY 1, 0
 END IF

IF Fatal = 4 THEN
 IF Paddle2 = 8 THEN FOR x = 309 TO 9 STEP -4: Star$ = "bm" + STR$(x) + "," + STR$(B + 15) + "br2bu2u4g4l4f4d4e4r4h5u1g3l2f3d2e3r2h3": DRAW "c8" + Star$: FOR y = 1 TO Speed: NEXT y: DRAW "c0" + Star$: NEXT x
 SCREEN 7, 0, 1, 0: PCOPY 0, 1
 q = 60: x = -11
 Name$ = "u3l1d5r1u2"
 Star$ = "u3l1d5r1u2"
 IF Paddle2 = 11 THEN Star$ = "c3u3l1c11d5r1c3u2": SOUND 7000, 1: SOUND 10000, 1
 FOR j = 0 TO (200 - a) * 2.925 STEP 20
 x = x + 11
 q = q - 60: IF q < -360 THEN q = 300
 DRAW "bm" + STR$(1 + x \ 2) + "," + STR$(a + 3 + j) + "ta" + STR$(q) + "c" + STR$(Paddle1) + Star$ + "bm" + STR$(1 + x) + "," + STR$(a + 8 + j \ 2) + Star$ + "bm" + STR$(1 + x \ 3) + "," + STR$(a + 13 + j \ 3) + Star$ + "bm" + STR$(1 + x \ 2) + "," + STR$(a + 18 + j \ 3) + Star$ + "bm" + STR$(1 + x) + "," + STR$(a + 23 + j \ 2) + Star$ + "bm" + STR$(1 + x) + "," + STR$(a + 28 + j) + Star$
 PCOPY 1, 0
 FOR y = 1 TO Speed: NEXT y
 DRAW "bm" + STR$(1 + x \ 2) + "," + STR$(a + 3 + j) + "ta" + STR$(q) + "c0" + Name$ + "bm" + STR$(1 + x) + "," + STR$(a + 8 + j \ 2) + Name$ + "bm" + STR$(1 + x \ 3) + "," + STR$(a + 13 + j \ 3) + Name$ + "bm" + STR$(1 + x \ 2) + "," + STR$(a + 18 + j \ 3) + Name$ + "bm" + STR$(1 + x) + "," + STR$(a + 23 + j \ 2) + Name$ + "bm" + STR$(1 + x) + "," + STR$(a + 28 + j) + Name$
 NEXT j
 CLS : PCOPY 0, 1: SCREEN 7, 0, 0, 0: PCOPY 1, 0
 END IF

' Ice Fatality
IF Fatal = 5 THEN
 LINE (318, B)-(318, B + 30), 3: LINE (319, B)-(319, B + 30), 11
 LINE (318, B + 8)-(318, B + 22), 0: LINE (319, B + 10)-(319, B + 20), 0
 SOUND 7000, 1: SOUND 10000, 1
 Name$ = "u1r1u1r2d1r1d1l1d1l3r1d1r2u1r1"
 j = 8: FOR x = 311 TO 160 STEP -4: j = j + 4: n = j / 4: Star$ = "bm" + STR$(x) + "," + STR$(B + 15) + Name$ + "bl4bu1bu" + STR$(n) + Name$ + "bl4bd" + STR$(n * 2) + Name$: DRAW "c11" + Star$: FOR y = 1 TO Speed * 2: NEXT y: DRAW "c0" + Star$: NEXT x
 END IF

IF Fatal = 6 THEN
 LINE (0, a)-(0, a + 30), 11: LINE (1, a)-(1, a + 30), 3
 LINE (0, a + 10)-(0, a + 20), 0: LINE (1, a + 8)-(1, a + 22), 0
 SOUND 7000, 1: SOUND 10000, 1
 Name$ = "u1r1u1r2d1r1d1l1d1l3r1d1r2u1r1"
 n = 0: FOR x = 8 TO 160 STEP 4: n = x \ 4: Star$ = "bm" + STR$(x) + "," + STR$(a + 15) + Name$ + "bl4bu1bu" + STR$(n) + Name$ + "bl4bd" + STR$(n * 2) + Name$: DRAW "c11" + Star$: FOR y = 1 TO Speed * 2: NEXT y: DRAW "c0" + Star$: NEXT x
 END IF

' Smoke Fatality
IF Fatal = 7 THEN
 IF Paddle1 = 12 THEN FOR y = 1 TO Speed * 100: NEXT y
 FOR j = 1 TO 3: FOR x = 1 TO 15 STEP 2: CIRCLE (319, B - x), x, 8: CIRCLE (319, B + 30 - x), x, 8: FOR y = 1 TO Speed * 2: NEXT y: CIRCLE (319, B - x), x, 0: CIRCLE (319, B + 30 - x), x, 0: NEXT x: NEXT j
 FOR x = B TO B + 30 STEP 2: PSET (318, x), 8: PSET (318, x + 1), 0: PSET (319, x), 0: PSET (319, x + 1), 8: NEXT x
 END IF
           
IF Fatal = 8 THEN
 IF Paddle2 = 12 THEN FOR y = 1 TO Speed * 100: NEXT y
 FOR j = 1 TO 3: FOR x = 1 TO 15 STEP 2: CIRCLE (0, a - x), x, 8: CIRCLE (0, a + 30 - x), x, 8: FOR y = 1 TO Speed * 2: NEXT y: CIRCLE (0, a - x), x, 0: CIRCLE (0, a + 30 - x), x, 0: NEXT x: NEXT j
 FOR x = a TO a + 30 STEP 2: PSET (1, x), 8: PSET (1, x + 1), 0: PSET (0, x), 0: PSET (0, x + 1), 8: NEXT x
 END IF

' Purple Fatality
IF Fatal = 11 THEN
 FOR x = 2 TO 312 STEP 2: PSET (x - 1, B + 15), 5: LINE (x, B + 18)-(x, B + 12), 5: LINE (x, B + 12)-(x + 3, B + 12), 5: LINE (x, B + 18)-(x + 3, B + 18), 5: LINE (x, B + 18)-(x, B + 12), 0: LINE (x, B + 12)-(x + 3, B + 12), 0: LINE (x, B + 18)-(x + 3, B + 18), 0: NEXT x
 FOR y = 3 TO 15: LINE (x, B + 15 + y)-(x, B + 15 - y), 5: LINE (x, B + 15 - y)-(x + 3, B + 15 - y), 5: LINE (x, B + 15 + y)-(x + 3, B + 15 + y), 5: FOR j = 1 TO Speed * 4: NEXT j: LINE (x, B + 15 + y)-(x, B + 15 - y), 0: LINE (x, B + 15 - y)-(x + 3, B + 15 - y), 0: LINE (x, B + 15 + y)-(x + 3, B + 15 + y), 0: NEXT y
 FOR x = 312 TO 316 STEP 2: PSET (x - 1, B + 15), 5: LINE (x, B + 15 + y)-(x, B + 15 - y), 5: LINE (x, B + 15 - y)-(x + 3, B + 15 - y), 5: LINE (x, B + 15 + y)-(x + 3, B + 15 + y), 5: FOR j = 1 TO Speed * 4: NEXT j: LINE (x, B + 15 + y)-(x, B + 15 - y), 0: LINE (x, B + 15 - y)-(x + 3, B + 15 - y), 0: LINE (x, B + 15 + y)-(x + 3, B + 15 + y), 0: NEXT x
 FOR y = 15 TO 0 STEP -1: LINE (x, B + 15 + y)-(x, B + 15 - y), 5: LINE (x, B + 15 - y)-(x + 3, B + 15 - y), 5: LINE (x, B + 15 + y)-(x + 3, B + 15 + y), 5: FOR j = 1 TO Speed * 4: NEXT j: LINE (x, B + 15 + y)-(x, B + 15 - y), 0: LINE (x, B + 15 - y)-(x + 3, B + 15 - y), 0: LINE (x, B + 15 + y)-(x + 3, B + 15 + y), 0: NEXT y
 FOR x = 316 TO 2 STEP -1: LINE (x, B + 18)-(x, B + 12), 5: LINE (x, B + 12)-(x + 3, B + 12), 5: LINE (x, B + 18)-(x + 3, B + 18), 5: LINE (x, B + 18)-(x, B + 12), 0: LINE (x, B + 12)-(x + 3, B + 12), 0: LINE (x, B + 18)-(x + 3, B + 18), 0: NEXT x
 FOR x = 5 TO 0 STEP -1: PSET (1, a + 15 + x), 5: PSET (1, a + 15 - x), 5: FOR y = 1 TO Speed * 4: NEXT y: NEXT x
 END IF

IF Fatal = 12 THEN
 FOR x = 317 TO 7 STEP -2: PSET (x + 1, a + 15), 5: LINE (x, a + 18)-(x, a + 12), 5: LINE (x, a + 12)-(x - 3, a + 12), 5: LINE (x, a + 18)-(x - 3, a + 18), 5: LINE (x, a + 18)-(x, a + 12), 0: LINE (x, a + 12)-(x - 3, a + 12), 0: LINE (x, a + 18)-(x - 3, a + 18), 0: NEXT x
 FOR y = 3 TO 15: LINE (x, a + 15 + y)-(x, a + 15 - y), 5: LINE (x, a + 15 - y)-(x - 3, a + 15 - y), 5: LINE (x, a + 15 + y)-(x - 3, a + 15 + y), 5: FOR j = 1 TO Speed * 4: NEXT j: LINE (x, a + 15 + y)-(x, a + 15 - y), 0: LINE (x, a + 15 - y)-(x - 3, a + 15 - y), 0: LINE (x, a + 15 + y)-(x - 3, a + 15 + y), 0: NEXT y
 FOR x = 7 TO 3 STEP -2: PSET (x + 1, a + 15), 5: LINE (x, a + 15 + y)-(x, a + 15 - y), 5: LINE (x, a + 15 - y)-(x - 3, a + 15 - y), 5: LINE (x, a + 15 + y)-(x - 3, a + 15 + y), 5: FOR j = 1 TO Speed * 4: NEXT j: LINE (x, a + 15 + y)-(x, a + 15 - y), 0: LINE (x, a + 15 - y)-(x - 3, a + 15 - y), 0: LINE (x, a + 15 + y)-(x - 3, a + 15 + y), 0: NEXT x
 FOR y = 15 TO 0 STEP -1: LINE (x, a + 15 + y)-(x, a + 15 - y), 5: LINE (x, a + 15 - y)-(x - 3, a + 15 - y), 5: LINE (x, a + 15 + y)-(x - 3, a + 15 + y), 5: FOR j = 1 TO Speed * 4: NEXT j: LINE (x, a + 15 + y)-(x, a + 15 - y), 0: LINE (x, a + 15 - y)-(x - 3, a + 15 - y), 0: LINE (x, a + 15 + y)-(x - 3, a + 15 + y), 0: NEXT y
 FOR x = 3 TO 317: LINE (x, a + 18)-(x, a + 12), 5: LINE (x, a + 12)-(x - 3, a + 12), 5: LINE (x, a + 18)-(x - 3, a + 18), 5: LINE (x, a + 18)-(x, a + 12), 0: LINE (x, a + 12)-(x - 3, a + 12), 0: LINE (x, a + 18)-(x - 3, a + 18), 0: NEXT x
 FOR x = 5 TO 0 STEP -1: PSET (318, B + 15 + x), 5: PSET (318, B + 15 - x), 5: FOR y = 1 TO Speed * 4: NEXT y: NEXT x
 END IF

' Red Fatality
IF Fatal = 13 THEN
 FOR x = 2 TO 17: PSET (x, a + 15), 6: FOR y = 1 TO Speed * 3: NEXT y: NEXT x
 FOR x = 5 TO 0 STEP -1: PSET (1, a + 15 + x), 4: PSET (1, a + 15 - x), 4: FOR y = 1 TO Speed * 4: NEXT y: NEXT x
 FOR x = 2 TO 304 STEP 5: LINE (x, a + 15)-(x + 15, a + 15), 6: FOR y = 1 TO Speed: NEXT y: LINE (x, a + 15)-(x + 15, a + 15), 0: NEXT x: LINE (x, a + 15)-(x + 15, a + 15), 6
 CALL Bleed2(Blood2)
 END IF

IF Fatal = 14 THEN
 FOR x = 317 TO 302 STEP -1: PSET (x, B + 15), 6: FOR y = 1 TO Speed * 3: NEXT y: NEXT x
 FOR x = 5 TO 0 STEP -1: PSET (318, B + 15 + x), 4: PSET (318, B + 15 - x), 4: FOR y = 1 TO Speed * 4: NEXT y: NEXT x
 FOR x = 302 TO 0 STEP -5: LINE (x, B + 15)-(x + 15, B + 15), 6: FOR y = 1 TO Speed: NEXT y: LINE (x, B + 15)-(x + 15, B + 15), 0: NEXT x: LINE (x, B + 15)-(x + 15, B + 15), 6
 CALL Bleed1(Blood1)
 END IF

' Burst Fatality
IF Fatal = 15 THEN
 PCOPY 0, 1: SCREEN 7, 0, 1, 0
 FOR x = 11 TO 2 STEP -1: CIRCLE (319, B + 15), 15, Paddle2, , , x: PAINT (319, B + 15), Paddle2: PCOPY 1, 0: FOR y = 1 TO Speed * 2: NEXT y: PAINT (319, B + 15), 0: NEXT x
 FOR y = 1 TO Speed * 100: NEXT y
 SCREEN 7, 0, 0, 0: PCOPY 1, 0
 FOR j = 1 TO 2
 COLOR 0, Blood2: FOR y = 1 TO Speed: NEXT y: COLOR 0, 0
 FOR x = 1 TO 40: CIRCLE (319, B + 15), x, Blood2: FOR y = 1 TO Speed * .3: NEXT y: CIRCLE (319, B + 15), x, 0: NEXT x
 NEXT j
 END IF

IF Fatal = 16 THEN
 PCOPY 0, 1: SCREEN 7, 0, 1, 0
 FOR x = 11 TO 2 STEP -1: CIRCLE (0, a + 15), 15, Paddle1, , , x: PAINT (0, a + 15), Paddle1: PCOPY 1, 0: FOR y = 1 TO Speed * 2: NEXT y: PAINT (0, a + 15), 0: NEXT x
 FOR y = 1 TO Speed * 100: NEXT y
 SCREEN 7, 0, 0, 0: PCOPY 1, 0
 FOR j = 1 TO 2
 COLOR 0, Blood1: FOR y = 1 TO Speed: NEXT y: COLOR 0, 0
 FOR x = 1 TO 40: CIRCLE (0, a + 15), x, Blood1: FOR y = 1 TO Speed * .3: NEXT y: CIRCLE (0, a + 15), x, 0: NEXT x
 NEXT j
 END IF

' Icicle Fatality
IF Fatal = 17 THEN
 SOUND 200, .5: SOUND 10000, 1
 FOR x = 5 TO 301 STEP 9: LINE (x, a + 12)-(x, a + 18), 3: LINE (x, a + 12)-(x + 20, a + 15), 3: LINE (x, a + 18)-(x + 20, a + 15), 3: PAINT (x + 5, a + 15), 11, 3: FOR y = 1 TO Speed * 2: NEXT y: LINE (x, a + 12)-(x, a + 18), 0: LINE (x, a + 12)-(x + 20, a + 15), 0: LINE (x, a + 18)-(x + 20, a + 15), 0: PAINT (x + 5, a + 15), 0: NEXT x
 LINE (x, a + 12)-(x, a + 18), 3: LINE (x, a + 12)-(x + 20, a + 15), 3: LINE (x, a + 18)-(x + 20, a + 15), 3: PAINT (x + 5, a + 15), 11, 3
 SOUND 7000, 1: SOUND 10000, 1
 CALL Bleed2(Blood2)
 END IF

IF Fatal = 18 THEN
 SOUND 200, .5: SOUND 10000, 1
 FOR x = 314 TO 18 STEP -9: LINE (x, B + 12)-(x, B + 18), 3: LINE (x, B + 12)-(x - 20, B + 15), 3: LINE (x, B + 18)-(x - 20, B + 15), 3: PAINT (x - 5, B + 15), 11, 3: FOR y = 1 TO Speed * 2: NEXT y: LINE (x, B + 12)-(x, B + 18), 0: LINE (x, B + 12)-(x - 20, B + 15), 0: LINE (x, B + 18)-(x - 20, B + 15), 0: PAINT (x - 5, B + 15), 0: NEXT x
 LINE (x, B + 12)-(x, B + 18), 3: LINE (x, B + 12)-(x - 20, B + 15), 3: LINE (x, B + 18)-(x - 20, B + 15), 3: PAINT (x - 5, B + 15), 11, 3
 SOUND 7000, 1: SOUND 10000, 1
 CALL Bleed1(Blood1)
 END IF

' Smash Fatality
IF Fatal = 19 THEN
 FOR x = 1 TO 20: LINE (0, a - x)-(x, a + 30 + x), Paddle1, BF: FOR y = 1 TO Speed * 2: NEXT y: NEXT x
 SCREEN 7, 0, 1, 0
 FOR x = 0 TO 300 STEP 30
 LINE (x, a - 20)-(x + 20, a + 50), Paddle1, BF
 PCOPY 1, 0
 FOR y = 1 TO Speed: NEXT y
 PAINT (x + 10, a + 15), 0
 NEXT x
 SCREEN 7, 0, 0, 0
 END IF
                  
IF Fatal = 20 THEN
 FOR x = 1 TO 20: LINE (319, B - x)-(319 - x, B + 30 + x), Paddle2, BF: FOR y = 1 TO Speed * 2: NEXT y: NEXT x
 SCREEN 7, 0, 1, 0
 FOR x = 320 TO 20 STEP -30
 LINE (x, B - 20)-(x - 20, B + 50), Paddle2, BF
 PCOPY 1, 0
 FOR y = 1 TO Speed: NEXT y
 PAINT (x - 10, B + 15), 0
 NEXT x
 SCREEN 7, 0, 0, 0
 END IF

' Melt Fatality
IF Fatal = 21 THEN
 FOR x = B TO 169 STEP 10
 LINE (318, x)-(319, x + 30), Paddle2, B
 FOR y = 1 TO Speed * 3: NEXT y
 LINE (318, x)-(319, x + 30), 0, B
 NEXT x
 LINE (318, 171)-(319, 201), Paddle2, B
 FOR x = 169 TO 199
 LINE (318, x)-(319, x + 30), Paddle2, B
 PSET (318 - (x - 170), 199), Paddle2
 FOR y = 1 TO Speed * 2: NEXT y
 LINE (318, x)-(319, x + 30), 0, B
 NEXT x
 LINE (319, 199)-(289, 199), Paddle2
 END IF

IF Fatal = 22 THEN
 FOR x = a TO 169 STEP 10
 LINE (0, x)-(1, x + 30), Paddle1, B
 FOR y = 1 TO Speed * 3: NEXT y
 LINE (0, x)-(1, x + 30), 0, B
 NEXT x
 LINE (0, 171)-(1, 201), Paddle1, B
 FOR x = 169 TO 199
 LINE (0, x)-(1, x + 30), Paddle1, B
 PSET (1 + (x - 170), 199), Paddle1
 FOR y = 1 TO Speed * 2: NEXT y
 LINE (0, x)-(1, x + 30), 0, B
 NEXT x
 LINE (0, 199)-(30, 199), Paddle1
 END IF

' Break Fatality
IF Fatal = 23 THEN
 FOR x = 2 TO 320 STEP 2: PSET (x - 1, a + 15), 5: LINE (x, a + 18)-(x, a + 12), 5: LINE (x, a + 12)-(x + 3, a + 12), 5: LINE (x, a + 18)-(x + 3, a + 18), 5: LINE (x, a + 18)-(x, a + 12), 0: LINE (x, a + 12)-(x + 3, a + 12), 0: LINE (x, a + 18)-(x + 3, a + 18), 0: NEXT x
 FOR x = 321 TO 20 STEP -2: LINE (x + 4, a)-(x + 5, a + 30), Paddle2, B: LINE (x, a + 18)-(x, a + 12), 5: LINE (x, a + 12)-(x + 3, a + 12), 5: LINE (x, a + 18)-(x + 3, a + 18), 5: FOR y = 1 TO Speed: NEXT y: LINE (x + 4, a)-(x + 5, a + 30), 0, B: LINE (x, a + 18)-(x, a + 12), 0: LINE (x, a + 12)-(x + 3, a + 12), 0: LINE (x, a + 18)-(x + 3, a + 18), 0: NEXT x
 LINE (x + 4, a)-(x + 5, a + 30), Paddle2, B: LINE (x, a + 18)-(x, a + 12), 5: LINE (x, a + 12)-(x + 3, a + 12), 5: LINE (x, a + 18)-(x + 3, a + 18), 5
 FOR j = a + 5 TO a + 25 STEP 20
 FOR x = 2 TO 22 STEP 2: PSET (x - 1, j), 5: LINE (x, j + 3)-(x, j - 3), 5: FOR y = 1 TO Speed: NEXT y: LINE (x, j + 3)-(x, j - 3), 0: NEXT x
 LINE (22, j + 3)-(22, j - 3), 5
 FOR x = 23 TO 43: LINE (x, j - 5)-(x + 1, j + 5), Paddle2, B: FOR y = 1 TO Speed * 2: NEXT y: LINE (x, j - 5)-(x + 1, j + 5), 0, B: NEXT x
 FOR x = 22 TO 2 STEP -1: LINE (x, j + 3)-(x, j - 3), 5: FOR y = 1 TO Speed: NEXT y: LINE (x, j + 3)-(x, j - 3), 0: NEXT x
 NEXT j
 END IF

IF Fatal = 24 THEN
 FOR x = 317 TO -1 STEP -2: PSET (x + 1, B + 15), 5: LINE (x, B + 18)-(x, B + 12), 5: LINE (x, B + 12)-(x - 3, B + 12), 5: LINE (x, B + 18)-(x - 3, B + 18), 5: LINE (x, B + 18)-(x, B + 12), 0: LINE (x, B + 12)-(x - 3, B + 12), 0: LINE (x, B + 18)-(x - 3, B + 18), 0: NEXT x
 FOR x = -2 TO 299 STEP 2: LINE (x - 4, B)-(x - 5, B + 30), Paddle1, B: LINE (x, B + 18)-(x, B + 12), 5: LINE (x, B + 12)-(x - 3, B + 12), 5: LINE (x, B + 18)-(x - 3, B + 18), 5: FOR y = 1 TO Speed: NEXT y: LINE (x - 4, B)-(x - 5, B + 30), 0, B: LINE (x, B + 18)-(x, B + 12), 0: LINE (x, B + 12)-(x - 3, B + 12), 0: LINE (x, B + 18)-(x - 3, B + 18), 0: NEXT x
 LINE (x - 4, B)-(x - 5, B + 30), Paddle1, B: LINE (x, B + 18)-(x, B + 12), 5: LINE (x, B + 12)-(x - 3, B + 12), 5: LINE (x, B + 18)-(x - 3, B + 18), 5
 FOR j = B + 5 TO B + 25 STEP 20
 FOR x = 317 TO 297 STEP -2: PSET (x + 1, j), 5: LINE (x, j + 3)-(x, j - 3), 5: FOR y = 1 TO Speed: NEXT y: LINE (x, j + 3)-(x, j - 3), 0: NEXT x
 LINE (297, j + 3)-(297, j - 3), 5
 FOR x = 296 TO 276 STEP -1: LINE (x, j - 5)-(x - 1, j + 5), Paddle1, B: FOR y = 1 TO Speed * 2: NEXT y: LINE (x, j - 5)-(x - 1, j + 5), 0, B: NEXT x
 FOR x = 297 TO 317: LINE (x, j + 3)-(x, j - 3), 5: FOR y = 1 TO Speed: NEXT y: LINE (x, j + 3)-(x, j - 3), 0: NEXT x
 NEXT j
 END IF
       
' Babality!
IF Baby = 1 THEN
 FOR x = 0 TO 10: LINE (318, B + x)-(319, B + x), 0: LINE (318, B + 30 - x)-(319, B + 30 - x), 0: FOR y = 1 TO Speed * 3: NEXT y: NEXT x
 END IF

IF Baby = 2 THEN
 FOR x = 0 TO 10: LINE (1, a + x)-(0, a + x), 0: LINE (1, a + 30 - x)-(0, a + 30 - x), 0: FOR y = 1 TO Speed * 3: NEXT y: NEXT x
 END IF

' Pit Fatality
IF Fatal = 25 OR Fatal = 26 THEN
 SCREEN 7, 0, 1, 0: CLS
 FOR x = 2 TO 307 STEP 15
 IF x <> 62 AND x <> 257 THEN LINE (x + 4, 177)-(x + 4, 147), 8
 NEXT x
 LINE (52, 0)-(52, 179), 8
 LINE (70, 0)-(70, 179), 8
 LINE (249, 0)-(249, 179), 8
 LINE (267, 0)-(267, 179), 8
 CIRCLE (61, 180), 10, 8, 3, 0, .5
 CIRCLE (258, 180), 10, 8, 3, 0, .5
 PAINT (58, 5), 7, 8
 PAINT (262, 5), 7, 8
 LINE (0, 178)-(319, 178), 7
 PAINT (160, 195), 8, 7
 FOR x = 0 TO 160 STEP 20
 CIRCLE (61, x), 10, 8, 3, 0, .5
 CIRCLE (258, x), 10, 8, 3, 0, .5
 LINE (52, x + 5)-(47, x), 7
 LINE (70, x + 5)-(75, x), 15
 LINE (61, x + 5)-(60, x), 15
 LINE (267, x + 5)-(272, x), 7
 LINE (249, x + 5)-(244, x), 15
 LINE (258, x + 5)-(259, x), 15
 NEXT x
 FOR x = 2 TO 307 STEP 15
 LINE (x + 8, 188)-(x + 8, 158), 7
 LINE (x, 199)-(x, 169), 15
 NEXT x
 LINE (100, 188)-(133, 195), 1: LINE (100, 189)-(133, 196), 1
 LINE (170, 189)-(203, 182), 14: LINE (170, 190)-(203, 183), 14
 LINE (280, 173)-(313, 180), 6: LINE (280, 174)-(313, 181), 6
 LINE (13, 169)-(46, 162), 4: LINE (13, 170)-(46, 163), 4
 SCREEN 7, 0, 0, 0: PCOPY 1, 0
 IF Fatal = 25 THEN Paddle = Paddle2: Blood = Blood2
 IF Fatal = 26 THEN Paddle = Paddle1: Blood = Blood1
 FOR y = 2 TO 166 STEP 4: PCOPY 1, 0: LINE (140, y)-(180, y + 1), Paddle, B: FOR j = 1 TO Speed * 2: NEXT j: NEXT y
 CIRCLE (180, 151), 10, Blood, 2, 3, 1: CIRCLE (180, 151), 10, Blood, 2, 3, .7
 CIRCLE (178, 144), 2, Blood, 4, 2: PAINT (178, 144), Blood
 CIRCLE (140, 151), 10, Blood, 0, 1, 1: CIRCLE (140, 151), 10, Blood, 0, 1, .7
 CIRCLE (143, 144), 2, Blood, 1, 5: PAINT (143, 144), Blood
 FOR y = 1 TO Speed * 7: NEXT y
 PCOPY 1, 0: LINE (140, 166)-(180, 167), Paddle, B
 CIRCLE (185, 159), 10, Blood, 0, 1, 1: CIRCLE (186, 159), 10, Blood, 0, 1, 1.7
 CIRCLE (194, 160), 2, Blood, 3, 1: PAINT (194, 160), Blood
 CIRCLE (135, 159), 10, Blood, 2, 3, 1: CIRCLE (134, 159), 10, Blood, 2, 3, 1.7
 CIRCLE (126, 160), 2, Blood, 3, 1: PAINT (126, 160), Blood
 FOR y = 1 TO Speed * 7: NEXT y
 PCOPY 1, 0: LINE (140, 166)-(180, 167), Paddle, B
 END IF

' Pool Fatality
IF Fatal = 27 OR Fatal = 28 THEN
 SCREEN 7, 0, 1, 0: CLS
 FOR x = 0 TO 319 STEP 9
 CIRCLE (x, 180), 4, 2, 0, 3
 NEXT x
 PAINT (160, 187), 2
 FOR x = 0 TO 319 STEP 9
 PSET (x - 1, 179), 10
 PSET (x, 176), 2
 NEXT x
 SCREEN 7, 0, 0, 0
 IF Fatal = 27 THEN Paddle = Paddle2
 IF Fatal = 28 THEN Paddle = Paddle1
 FOR y = 2 TO 184 STEP 4: PCOPY 1, 0: LINE (140, y)-(180, y + 1), Paddle, B: FOR j = 1 TO Speed * 2: NEXT j: NEXT y
 FOR x = 184 TO 120 STEP -1: RANDOMIZE TIMER: j = INT(30 * RND(1) + 1): CIRCLE (144 + j, x), 2, 2: PSET (143 + j, x - 1), 10: FOR y = 1 TO Speed: NEXT y: PCOPY 1, 0: NEXT x
 END IF

' Big Bang Fatality
IF Fatal = 29 THEN
 Name$ = "bd2l1h1u2e1r1d2l1r3u1h1f1d2g1"
 FOR n = 1 TO 15
 RANDOMIZE TIMER: q = INT(12 * RND(1) + 1)
 u = 0: j = 2: FOR x = a + 15 TO 197
 x = x + u: u = u + 1
 j = j + q
 DRAW "c14bm" + STR$(j) + "," + STR$(x) + Name$
 FOR y = 1 TO Speed * 2: NEXT y
 DRAW "c0bm" + STR$(j) + "," + STR$(x) + Name$
 NEXT x
 DRAW "c14bm" + STR$(j) + ",197" + Name$
 NEXT n
 FOR y = 1 TO Speed * 100: NEXT y
 END IF

IF Fatal = 30 THEN
 Name$ = "bd2r1e1u2h1l1d2r1l3u1e1g1d2f1"
 FOR n = 1 TO 15
 RANDOMIZE TIMER: q = INT(12 * RND(1) + 1)
 u = 0: j = 317: FOR x = B + 15 TO 197
 x = x + u: u = u + 1
 j = j - q
 DRAW "c14bm" + STR$(j) + "," + STR$(x) + Name$
 FOR y = 1 TO Speed * 2: NEXT y
 DRAW "c0bm" + STR$(j) + "," + STR$(x) + Name$
 NEXT x
 DRAW "c14bm" + STR$(j) + ",197" + Name$
 NEXT n
 FOR y = 1 TO Speed * 100: NEXT y
 END IF

IF Fatal = 29 OR Fatal = 30 THEN
 SCREEN 7, 0, 1, 0: CLS
 RANDOMIZE TIMER
 FOR j = 1 TO 10
 x = INT(319 * RND(1) + 1)
 y = INT(199 * RND(1) + 1)
 PSET (x, y), 9
 NEXT j
 Name$ = "u1l1u1l1u3r1u1l1u1l1u1l1u1l3u1l1u1r3u1r3u2r2u1r1u1l2u1r5d1r1d1r2d3r2d2r1d1r2d2l2d1l2d4r1d2l1d3l8d1l1u3l2d1l3d1g1e1u1h1u2l1u1l1u2l3u5r1u4r1u3"
 CIRCLE (160, 93), 16, 9
 PAINT (160, 93), 1, 9
 DRAW "bm160,100c9" + Name$
 PAINT (160, 82), 2, 9
 PAINT (160, 105), 2, 9
 PCOPY 1, 0
 FOR y = 1 TO Speed * 100: NEXT y
 PAINT (160, 93), 0
 j = 0
 FOR x = 1 TO 30
 IF j = 0 THEN j = 2 ELSE IF j = 2 THEN j = 0
 CIRCLE (160, 93 + j), 16, 9
 PAINT (160, 93 + j), 1, 9
 DRAW "bm160," + STR$(100 + j) + "c9" + Name$
 PAINT (160, 82 + j), 2, 9
 PAINT (160, 105 + j), 2, 9
 PCOPY 1, 0
 FOR y = 1 TO Speed * 5: NEXT y
 PAINT (160, 93 + j), 0
 NEXT x
 SCREEN 7, 0, 0, 0
 PAINT (160, 93 + j), 0
 FOR j = 1 TO 2
 COLOR 0, 4: FOR y = 1 TO Speed: NEXT y: COLOR 0, 0
 FOR x = 1 TO 40: CIRCLE (160, 93), x, 4: FOR y = 1 TO Speed * .3: NEXT y: CIRCLE (160, 93), x, 0: NEXT x
 NEXT j
 END IF

' Singing Friendship
IF Friend = 1 THEN
 Name$ = "g1f1e1l1r1u5r5d4l1g1f1e1l1r1u7l5d1"
 FOR j = 1 TO 16
 IF Sing = 1 THEN Sing = 0: DRAW "bm9," + STR$(a + 19) + "c0" + Name$ + "bm20," + STR$(a + 15) + "c0" + Name$ + "bm9," + STR$(a + 15) + "c14" + Name$ + "bm20," + STR$(a + 19) + "c14" + Name$ ELSE IF Sing = 0 THEN Sing = 1: DRAW "bm9," + STR$(a + 15) + "c0" + Name$ + "bm20," + STR$(a + 19) + "c0" + Name$ + "bm9," + STR$(a + 19) + "c14" + Name$ + "bm20," + STR$(a + 15) + "c14" + Name$
 FOR y = 1 TO Speed * 20: NEXT y
 NEXT j
 END IF

IF Friend = 2 THEN
 Name$ = "g1f1e1l1r1u5r5d4l1g1f1e1l1r1u7l5d1"
 FOR j = 1 TO 16
 IF Sing = 1 THEN Sing = 0: DRAW "bm304," + STR$(B + 19) + "c0" + Name$ + "bm293," + STR$(B + 15) + "c0" + Name$ + "bm304," + STR$(B + 15) + "c14" + Name$ + "bm293," + STR$(B + 19) + "c14" + Name$ ELSE IF Sing = 0 THEN Sing = 1: DRAW "bm304," + STR$(B + 15) + "c0" + Name$ + "bm293," + STR$(B + 19) + "c0" + Name$ + "bm304," + STR$(B + 19) + "c14" + Name$ + "bm293," + STR$(B + 15) + "c14" + Name$
 FOR y = 1 TO Speed * 20: NEXT y
 NEXT j
 END IF

' Doll Friendship
IF Friend = 3 THEN
 Word$ = "BUY A"
 IF Paddle1 = 2 THEN Word$ = Word$ + " SHOCKER"
 IF Paddle1 = 4 THEN Word$ = Word$ + " BLOODBATH"
 IF Paddle1 = 6 THEN Word$ = Word$ + "N ICEPICK"
 Word$ = Word$ + " DOLL!"
 CALL SmallWrite(Word$, Name$)
 DRAW "bm15," + STR$(a + 17) + "c14" + Name$
 LINE (8, a + 10)-(9, a + 18), Paddle1, B: LINE (8, a + 13)-(6, a + 17), Paddle1: LINE (9, a + 13)-(11, a + 17), Paddle1: LINE (8, a + 18)-(6, a + 23), Paddle1: LINE (9, a + 18)-(11, a + 23), Paddle1
 FOR j = 1 TO 3
 LINE (9, a + 13)-(11, a + 9), 0: LINE (9, a + 13)-(11, a + 17), Paddle1
 FOR y = 1 TO Speed * 50: NEXT y
 LINE (9, a + 13)-(11, a + 17), 0: LINE (9, a + 13)-(11, a + 9), Paddle1
 FOR y = 1 TO Speed * 50: NEXT y
 NEXT j
 LINE (9, a + 13)-(11, a + 9), 0: LINE (9, a + 13)-(11, a + 17), Paddle1
 DRAW "bm15," + STR$(a + 17) + "c0" + Name$
 END IF

IF Friend = 4 THEN
 Word$ = "BUY A"
 IF Paddle2 = 2 THEN Word$ = Word$ + " SHOCKER"
 IF Paddle2 = 4 THEN Word$ = Word$ + " BLOODBATH"
 IF Paddle2 = 6 THEN Word$ = Word$ + "N ICEPICK"
 Word$ = Word$ + " DOLL!"
 CALL SmallWrite(Word$, Name$)
 IF Paddle2 = 2 OR Paddle2 = 6 THEN DRAW "bm238," + STR$(B + 17) + "c14" + Name$
 IF Paddle2 = 4 THEN DRAW "bm227," + STR$(B + 17) + "c14" + Name$
 LINE (311, B + 10)-(310, B + 18), Paddle2, B: LINE (311, B + 13)-(313, B + 17), Paddle2: LINE (310, B + 13)-(308, B + 17), Paddle2: LINE (311, B + 18)-(313, B + 23), Paddle2: LINE (310, B + 18)-(308, B + 23), Paddle2
 FOR j = 1 TO 3
 LINE (309, B + 13)-(308, B + 9), 0: LINE (309, B + 13)-(308, B + 17), Paddle2
 FOR y = 1 TO Speed * 50: NEXT y
 LINE (309, B + 13)-(308, B + 17), 0: LINE (309, B + 13)-(308, B + 9), Paddle2
 FOR y = 1 TO Speed * 50: NEXT y
 NEXT j
 LINE (309, B + 13)-(308, B + 9), 0: LINE (309, B + 13)-(308, B + 17), Paddle2
 IF Paddle2 = 2 OR Paddle2 = 6 THEN DRAW "bm238," + STR$(B + 17) + "c0" + Name$
 IF Paddle2 = 4 THEN DRAW "bm227," + STR$(B + 17) + "c0" + Name$
 END IF

' Snowman Friendship
IF Friend = 5 THEN
 FOR x = 1 TO 8
 IF x = 2 THEN CIRCLE (15, a + 16), 5, 11: PAINT (15, a + 16), 11
 IF x = 3 THEN CIRCLE (15, a + 21), 7, 11: PAINT (15, a + 21), 11
 IF x = 1 THEN CIRCLE (15, a + 11), 4, 11: PAINT (15, a + 11), 11
 IF x = 5 THEN PSET (13, a + 10), 1: PSET (17, a + 10), 1
 IF x = 6 THEN LINE (15, a + 12)-(18, a + 12), 6
 IF x = 7 THEN LINE (10, a + 15)-(6, a + 16), 6: LINE (20, a + 15)-(24, a + 16), 6
 IF x = 8 THEN PSET (15, a + 16), 1: PSET (15, a + 19), 1: PSET (15, a + 22), 1
 IF x = 4 THEN LINE (12, a + 8)-(18, a + 8), 1: LINE (14, a + 8)-(14, a + 4), 1: LINE (15, a + 8)-(15, a + 4), 1: LINE (16, a + 8)-(16, a + 4), 1
 FOR y = 1 TO Speed * 20: NEXT y
 NEXT x
 END IF

IF Friend = 6 THEN
 FOR x = 1 TO 8
 IF x = 2 THEN CIRCLE (304, B + 16), 5, 11: PAINT (304, B + 16), 11
 IF x = 3 THEN CIRCLE (304, B + 21), 7, 11: PAINT (304, B + 21), 11
 IF x = 1 THEN CIRCLE (304, B + 11), 4, 11: PAINT (304, B + 11), 11
 IF x = 5 THEN PSET (306, B + 10), 1: PSET (302, B + 10), 1
 IF x = 6 THEN LINE (304, B + 12)-(301, B + 12), 6
 IF x = 7 THEN LINE (309, B + 15)-(313, B + 16), 6: LINE (299, B + 15)-(295, B + 16), 6
 IF x = 8 THEN PSET (304, B + 16), 1: PSET (304, B + 19), 1: PSET (304, B + 22), 1
 IF x = 4 THEN LINE (307, B + 8)-(301, B + 8), 1: LINE (305, B + 8)-(305, B + 4), 1: LINE (304, B + 8)-(304, B + 4), 1: LINE (303, B + 8)-(303, B + 4), 1
 FOR y = 1 TO Speed * 20: NEXT y
 NEXT x
 END IF

' Rainbow Friendship
IF Friend = 7 THEN
 FOR x = 1 TO 4
 IF x = 1 THEN y = 9 ELSE IF x = 2 THEN y = 12 ELSE IF x = 3 THEN y = 14 ELSE IF x = 4 THEN y = 10
 CIRCLE (1, a + 15), x + 17, y, , , 1
 LINE (0, a)-(1, a + 30), y, B
 FOR y = 1 TO Speed * 20: NEXT y
 NEXT x
 LINE (0, a)-(1, a + 30), 15, B
 END IF

IF Friend = 8 THEN
 FOR x = 1 TO 4
 IF x = 1 THEN y = 9 ELSE IF x = 2 THEN y = 12 ELSE IF x = 3 THEN y = 14 ELSE IF x = 4 THEN y = 10
 CIRCLE (318, B + 15), x + 17, y, , , 1
 LINE (318, B)-(319, B + 30), y, B
 FOR y = 1 TO Speed * 20: NEXT y
 NEXT x
 LINE (318, B)-(319, B + 30), 15, B
 END IF

' Disco Friendship
IF Friend = 9 THEN
 Name$ = "g1f1e1l1r1u5r5d4l1g1f1e1l1r1u7l5d1"
 LINE (160, 0)-(160, 30), 8
 CIRCLE (160, 30), 10, 7: PAINT (160, 30), 8, 7
 FOR j = 1 TO 20
 RANDOMIZE TIMER: x = INT(13 * RND(1) + 1): y = INT(13 * RND(1) + 1)
 PSET (153 + x, 23 + y), 15
 IF Sing = 1 THEN Sing = 0: DRAW "bm140,55c0" + Name$ + "bm172,45c0" + Name$ + "bm140,45c14" + Name$ + "bm172,55c14" + Name$ ELSE IF Sing = 0 THEN Sing = 1: DRAW "bm140,45c0" + Name$ + "bm172,55c0" + Name$ + "bm140,55c14" + Name$ + "bm172,45c14" + Name$
 FOR q = 1 TO Speed * 20: NEXT q
 PSET (153 + x, 23 + y), 8
 NEXT j
 PSET (153 + x, 23 + y), 15
 END IF

' Sunny Friendship
IF Friend = 10 THEN
 Word$ = "GET A SUN TAN!": CALL SmallWrite(Word$, Name$)
 DRAW "bm7," + STR$(a + 17) + "c14" + Name$
 FOR x = 0 TO 15: PSET (1, a + 15 + x), 6: PSET (1, a + 15 - x), 6: PSET (0, a + x), 6: PSET (0, a + 30 - x), 6: PSET (0, a + 8), 0: LINE (1, a + 8)-(1, a + 10), 0: FOR y = 1 TO Speed * 10: NEXT y: NEXT x
 FOR y = 1 TO Speed * 100: NEXT y: DRAW "bm7," + STR$(a + 17) + "c0" + Name$
 END IF

IF Friend = 11 THEN
 Word$ = "GET A SUN TAN!": CALL SmallWrite(Word$, Name$)
 DRAW "bm260," + STR$(B + 17) + "c14" + Name$
 FOR x = 0 TO 15: PSET (318, B + 15 + x), 6: PSET (318, B + 15 - x), 6: PSET (319, B + x), 6: PSET (319, B + 30 - x), 6: PSET (319, B + 8), 0: LINE (318, B + 8)-(318, B + 10), 0: FOR y = 1 TO Speed * 10: NEXT y: NEXT x
 FOR y = 1 TO Speed * 100: NEXT y: DRAW "bm260," + STR$(B + 17) + "c0" + Name$
 END IF

' Flower Friendship
IF Friend = 12 THEN
 FOR x = 130 TO 190 STEP 30
 CIRCLE (x - 2, 195), 3, 10: CIRCLE (x + 2, 195), 3, 10
 PAINT (x - 2, 195), 2, 10: PAINT (x + 2, 195), 2, 10
 FOR y = 1 TO Speed * 10: NEXT y
 LINE (x, 199)-(x, 180), 10
 FOR y = 1 TO Speed * 10: NEXT y
 CIRCLE (x, 180), 4, 14: PAINT (x, 180), 14
 FOR y = 1 TO Speed * 10: NEXT y
 CIRCLE (x - 4, 176), 1, 1: CIRCLE (x - 4, 184), 1, 1
 CIRCLE (x + 4, 176), 1, 1: CIRCLE (x + 4, 184), 1, 1
 CIRCLE (x, 174), 2, 1: CIRCLE (x, 186), 2, 1
 CIRCLE (x - 6, 180), 2, 1: CIRCLE (x + 6, 180), 2, 1
 PAINT (x - 4, 176), 1: PAINT (x - 4, 184), 1
 PAINT (x + 4, 176), 1: PAINT (x + 4, 184), 1
 PAINT (x, 174), 1: PAINT (x, 186), 1
 PAINT (x - 6, 180), 1: PAINT (x + 6, 180), 1
 FOR y = 1 TO Speed * 10: NEXT y
 NEXT x
 END IF

' Happy Friendship
IF Friend = 13 THEN
 CIRCLE (160, 93), 16, 14
 CIRCLE (154, 88), 2, 14: CIRCLE (166, 88), 2, 14
 PAINT (160, 93), 14
 CIRCLE (160, 96), 8, 0, 3, 0: PSET (168, 95), 0
 CIRCLE (160, 95), 8, 0, 3, 0: PSET (168, 94), 0
 Word$ = "HAVE A NICE DAY!": CALL SmallWrite(Word$, Name$)
 DRAW "bm134,116c14" + Name$
 PSET (0, a + 8), 0: LINE (1, a + 8)-(1, a + 10), 0
 PSET (319, B + 8), 0: LINE (318, B + 8)-(318, B + 10), 0
 FOR y = 1 TO Speed * 300: NEXT y
 PAINT (160, 93), 0
 DRAW "bm134,116c0" + Name$
 END IF

' Fireworks Friendship
IF Friend = 14 THEN
 FOR j = 1 TO 5
 IF j = 1 THEN n = 200: q = 90
 IF j = 2 THEN n = 160: q = 60
 IF j = 3 THEN n = 100: q = 130
 IF j = 4 THEN n = 120: q = 100
 IF j = 5 THEN n = 200: q = 120
 IF j = 6 THEN n = 160: q = 100
 FOR x = 200 TO q STEP -2: PSET (n, x), j + 9: FOR y = 1 TO Speed: NEXT y: PSET (n, x), 0: NEXT x
 COLOR 0, j + 9: FOR y = 1 TO Speed: NEXT y: COLOR 0, 0
 FOR x = 1 TO j * 10 STEP 3
 PSET (n - x, q), j + 9: PSET (n + x, q), j + 9
 PSET (n, q - x), j + 9: PSET (n, q + x), j + 9
 PSET (n - x / 1.4, q - x / 1.4), j + 9: PSET (n + x / 1.4, q + x / 1.4), j + 9
 PSET (n + x / 1.4, q - x / 1.4), j + 9: PSET (n - x / 1.4, q + x / 1.4), j + 9
 FOR y = 1 TO Speed: NEXT y
 PSET (n - x, q), 0: PSET (n + x, q), 0
 PSET (n, q - x), 0: PSET (n, q + x), 0
 PSET (n - x / 1.4, q - x / 1.4), 0: PSET (n + x / 1.4, q + x / 1.4), 0
 PSET (n + x / 1.4, q - x / 1.4), 0: PSET (n - x / 1.4, q + x / 1.4), 0
 NEXT x
 FOR q = q TO q + 20 STEP 2
 PSET (n - x, q), j + 9: PSET (n + x, q), j + 9
 PSET (n, q - x), j + 9: PSET (n, q + x), j + 9
 PSET (n - x / 1.4, q - x / 1.4), j + 9: PSET (n + x / 1.4, q + x / 1.4), j + 9
 PSET (n + x / 1.4, q - x / 1.4), j + 9: PSET (n - x / 1.4, q + x / 1.4), j + 9
 FOR y = 1 TO Speed: NEXT y
 PSET (n - x, q), 0: PSET (n + x, q), 0
 PSET (n, q - x), 0: PSET (n, q + x), 0
 PSET (n - x / 1.4, q - x / 1.4), 0: PSET (n + x / 1.4, q + x / 1.4), 0
 PSET (n + x / 1.4, q - x / 1.4), 0: PSET (n - x / 1.4, q + x / 1.4), 0
 NEXT q
 NEXT j
 END IF

' Spotlight Friendship
IF Friend = 15 OR Friend = 16 THEN
 SCREEN 7, 0, 1, 0
 IF Friend = 15 THEN Shift = Shift1
 IF Friend = 16 THEN Shift = Shift2
 IF Shift = 0 THEN Word$ = "NINJA WINS" ELSE Word$ = "SHIFTER WINS"
 CALL BigWrite(Word$, Name$)
 Name$ = "br16" + Name$
 IF Shift = 0 THEN Name$ = "br6" + Name$
 n = 0: q = 70
 FOR j = 1 TO 33
 IF n = 0 THEN q = q + 30: IF q > 180 THEN n = 1
 IF n = 1 THEN q = q - 30: IF q < 30 THEN n = 0
 FOR x = q + 20 TO q + 100 STEP 5: LINE (x, 0)-(2, 200), 1: LINE (319 - x, 0)-(317, 200), 1: NEXT x
 DRAW "bm76,84c7" + Name$ + "bm76,85c8" + Name$
 PCOPY 1, 0: FOR y = 1 TO Speed * 2: NEXT y
 FOR x = q + 20 TO q + 100 STEP 5: LINE (x, 0)-(2, 200), 0: LINE (319 - x, 0)-(317, 200), 0: NEXT x
 NEXT j
 SCREEN 7, 0, 0, 0
 DRAW "bm76,84c0" + Name$ + "bm76,85c0" + Name$
 FOR x = q + 20 TO q + 100 STEP 5: LINE (x, 0)-(2, 200), 1: LINE (319 - x, 0)-(317, 200), 1: NEXT x
 END IF

' Spider Animality
IF Anim = 1 THEN
 Star$ = "h2e1g1f2g1l1h1f1r1f1g1l1r1e1f1d1u1e1f1d1u1e1f1r1l1h1e1r1e1g1l1h1e2h1f1g2h1u1d1l2u1d1"
 FOR x = 10 TO B + 14 STEP 4
 PSET (303, x - 6), Paddle1: PSET (303, x - 4), Paddle1
 DRAW "bm301," + STR$(x) + "c" + STR$(Paddle1) + Star$
 FOR y = 1 TO Speed * 2: NEXT y
 DRAW "bm301," + STR$(x) + "c0" + Star$
 NEXT x
 PSET (303, x - 6), Paddle1: PSET (303, x - 4), Paddle1: DRAW "bm301," + STR$(x) + "c" + STR$(Paddle1) + Star$
 LINE (309, B + 15)-(319, B), 7
 LINE (309, B + 15)-(319, B + 10), 7
 LINE (309, B + 15)-(319, B + 15), 7
 LINE (309, B + 15)-(319, B + 20), 7
 LINE (309, B + 15)-(319, B + 30), 7
 LINE (316, B + 6)-(316, B + 24), 7
 END IF

IF Anim = 2 THEN
 Star$ = "h2e1g1f2g1l1h1f1r1f1g1l1r1e1f1d1u1e1f1d1u1e1f1r1l1h1e1r1e1g1l1h1e2h1f1g2h1u1d1l2u1d1"
 FOR x = 10 TO a + 14 STEP 4
 PSET (16, x - 6), Paddle2: PSET (16, x - 4), Paddle2
 DRAW "bm14," + STR$(x) + "c" + STR$(Paddle2) + Star$
 FOR y = 1 TO Speed * 2: NEXT y
 DRAW "bm14," + STR$(x) + "c0" + Star$
 NEXT x
 PSET (16, x - 6), Paddle2: PSET (16, x - 4), Paddle2: DRAW "bm14," + STR$(x) + "c" + STR$(Paddle2) + Star$
 LINE (10, a + 15)-(0, a), 7
 LINE (10, a + 15)-(0, a + 10), 7
 LINE (10, a + 15)-(0, a + 15), 7
 LINE (10, a + 15)-(0, a + 20), 7
 LINE (10, a + 15)-(0, a + 30), 7
 LINE (3, a + 6)-(3, a + 24), 7
 END IF
                
' Frog Animality
IF Anim = 3 THEN
 IF Paddle1 = 2 OR Paddle1 = 10 THEN Name$ = "bd5bl1d1r2l4h1u2e2r1u1e1r1f1d1l2d2r2l2g1u1l1u1r1"
 IF Paddle1 = 12 OR Paddle1 = 15 THEN Name$ = "u2d2r2d2l2u1d1l1d1l2d1l1d1r1u1r1d2r2l2u2r2u1"
 DRAW "bm293," + STR$(B + 24) + "c" + STR$(Paddle1) + Name$
 FOR y = 1 TO Speed * 50: NEXT y
 DRAW "bm293," + STR$(B + 24) + "c0" + Name$
 n = 7: FOR x = 0 TO 24: x = x + n: n = n - 1: DRAW "bm" + STR$(293 + x) + "," + STR$(B + 24 - x) + "c" + STR$(Paddle1) + Name$: FOR y = 1 TO Speed * 5: NEXT y: DRAW "bm" + STR$(293 + x) + "," + STR$(B + 24 - x) + "c0" + Name$: NEXT x
 FOR j = 0 TO 3
 IF j > 0 THEN n = 7: FOR x = 0 TO 24: x = x + n: n = n - 1: DRAW "bm317," + STR$(B + 24 - x) + "c" + STR$(Paddle1) + Name$: FOR y = 1 TO Speed * 5: NEXT y: DRAW "bm317," + STR$(B + 24 - x) + "c0" + Name$: NEXT x
 n = 0: FOR x = 24 TO 0 STEP -1: x = x - n: n = n + 1: LINE (318, B + 20 - x)-(319, B + 30 - x), 0, B: DRAW "bm317," + STR$(B + 24 - x) + "c" + STR$(Paddle1) + Name$: FOR y = 1 TO Speed * 5: NEXT y: DRAW "bm317," + STR$(B + 24 - x) + "c0" + Name$: NEXT x
 NEXT j
 DRAW "bm317," + STR$(B + 24) + "c" + STR$(Paddle1) + Name$
 END IF

IF Anim = 4 THEN
 IF Paddle2 = 2 OR Paddle2 = 10 THEN Name$ = "bd5br1d1l2r4e1u2h2l1u1h1l1g1d1r2d2l2r2f1u1r1u1l1"
 IF Paddle2 = 12 OR Paddle2 = 15 THEN Name$ = "u2d2l2d2r2u1d1r1d1r2d1r1d1l1u1l1d2l2r2u2l2u1"
 DRAW "bm26," + STR$(a + 24) + "c" + STR$(Paddle2) + Name$
 FOR y = 1 TO Speed * 50: NEXT y
 DRAW "bm26," + STR$(a + 24) + "c0" + Name$
 n = 7: FOR x = 0 TO 24: x = x + n: n = n - 1: DRAW "bm" + STR$(26 - x) + "," + STR$(a + 24 - x) + "c" + STR$(Paddle2) + Name$: FOR y = 1 TO Speed * 5: NEXT y: DRAW "bm" + STR$(26 - x) + "," + STR$(a + 24 - x) + "c0" + Name$: NEXT x
 FOR j = 0 TO 3
 IF j > 0 THEN n = 7: FOR x = 0 TO 24: x = x + n: n = n - 1: DRAW "bm2," + STR$(a + 24 - x) + "c" + STR$(Paddle2) + Name$: FOR y = 1 TO Speed * 5: NEXT y: DRAW "bm2," + STR$(a + 24 - x) + "c0" + Name$: NEXT x
 n = 0: FOR x = 24 TO 0 STEP -1: x = x - n: n = n + 1: LINE (0, a + 20 - x)-(1, a + 30 - x), 0, B: DRAW "bm2," + STR$(a + 24 - x) + "c" + STR$(Paddle2) + Name$: FOR y = 1 TO Speed * 5: NEXT y: DRAW "bm2," + STR$(a + 24 - x) + "c0" + Name$: NEXT x
 NEXT j
 DRAW "bm2," + STR$(a + 24) + "c" + STR$(Paddle2) + Name$
 END IF

' Bee Animality
IF Anim = 5 THEN
 Star$ = "e2h1f2g2h2f2d1f1e3h1f2d1g1f2h2g1l1h1l3h1r3u1e2r1u3f1d3"
 FOR j = 1 TO 3
 FOR x = 299 TO 281 STEP -3: DRAW "bm" + STR$(x) + "," + STR$(B) + "c" + STR$(Paddle1) + Star$: FOR y = 1 TO Speed * 4: NEXT y: DRAW "bm" + STR$(x) + "," + STR$(B) + "c0" + Star$: NEXT x
 FOR x = 281 TO 299 STEP 3: DRAW "bm" + STR$(x) + "," + STR$(B) + "c" + STR$(Paddle1) + Star$: FOR y = 1 TO Speed * 4: NEXT y: DRAW "bm" + STR$(x) + "," + STR$(B) + "c0" + Star$: NEXT x
 NEXT j
 FOR x = 299 TO 311 STEP 3: DRAW "bm" + STR$(x) + "," + STR$(B + 12 - (311 - x)) + "c" + STR$(Paddle1) + Star$: LINE (318, B)-(319, B + 30), Paddle2, B: FOR y = 1 TO Speed * 3: NEXT y: DRAW "bm" + STR$(x) + "," + STR$(B + 12 - (311 - x)) + "c0" + Star$: NEXT x
 DRAW "bm311," + STR$(B + 12) + "c" + STR$(Paddle1) + Star$: LINE (318, B)-(319, B + 30), Paddle2, B
 CALL Bleed2(Blood2)
 END IF
            
IF Anim = 6 THEN
 Star$ = "h2e1g2f2e2g2d1g1h3e1g2d1f1g2e2f1r1e1r3e1l3u1h2l1u3g1d3"
 FOR j = 1 TO 3
 FOR x = 19 TO 37 STEP 3: DRAW "bm" + STR$(x) + "," + STR$(a) + "c" + STR$(Paddle2) + Star$: FOR y = 1 TO Speed * 4: NEXT y: DRAW "bm" + STR$(x) + "," + STR$(a) + "c0" + Star$: NEXT x
 FOR x = 37 TO 19 STEP -3: DRAW "bm" + STR$(x) + "," + STR$(a) + "c" + STR$(Paddle2) + Star$: FOR y = 1 TO Speed * 4: NEXT y: DRAW "bm" + STR$(x) + "," + STR$(a) + "c0" + Star$: NEXT x
 NEXT j
 FOR x = 19 TO 8 STEP -3: DRAW "bm" + STR$(x) + "," + STR$(a + 12 - (x - 8)) + "c" + STR$(Paddle2) + Star$: LINE (0, a)-(1, a + 30), Paddle1, B: FOR y = 1 TO Speed * 3: NEXT y: DRAW "bm" + STR$(x) + "," + STR$(a + 12 - (x - 8)) + "c0" + Star$: NEXT x
 DRAW "bm8," + STR$(a + 12) + "c" + STR$(Paddle2) + Star$: LINE (0, a)-(1, a + 30), Paddle1, B
 CALL Bleed1(Blood1)
 END IF

' Bat Animality
IF Anim = 7 THEN
 Star$ = "h2d3h3g3f2e1f2e1f2e2f1e2f1e2h3g3u3g1"
 FOR y = 1 TO Speed * 100: NEXT y
 q = 330: FOR x = 3 TO 310 STEP 9
 j = j + 6
 q = q + 30: IF q > 360 THEN q = 30
 DRAW "bm" + STR$(319 - x) + "," + STR$(B + 8) + "ta0c" + STR$(Paddle1) + Star$
 DRAW "bm" + STR$(319 - x \ 2) + "," + STR$(B + 2 + j) + "ta" + STR$(q) + "c" + STR$(Paddle2) + "bd7u15r1d15"
 LINE (318, B + 15)-(319, B + 30), Paddle2, B
 FOR y = 1 TO Speed: NEXT y
 DRAW "bm" + STR$(319 - x) + "," + STR$(B + 8) + "ta0c0" + Star$
 DRAW "bm" + STR$(319 - x \ 2) + "," + STR$(B + 2 + j) + "ta" + STR$(q) + "c0bd7u15r1d15"
 NEXT x
 DRAW "bm10," + STR$(B + 8) + "ta0c" + STR$(Paddle1) + Star$
 SCREEN 7, 0, 1, 0: CLS : PCOPY 0, 1: SCREEN 7, 0, 0, 0: PCOPY 1, 0
 END IF

IF Anim = 8 THEN
 Star$ = "e2d3e3f3g2h1g2h1g2h2g1h2g1h2e3f3u3f1"
 FOR y = 1 TO Speed * 100: NEXT y
 q = -330: FOR x = 1 TO 308 STEP 9
 j = j + 6
 q = q - 30: IF q < -360 THEN q = 330
 DRAW "bm" + STR$(x) + "," + STR$(a + 8) + "ta0c" + STR$(Paddle2) + Star$
 DRAW "bm" + STR$(x \ 2) + "," + STR$(a + 2 + j) + "ta" + STR$(q) + "c" + STR$(Paddle1) + "bd7u15r1d15"
 LINE (1, a + 15)-(0, a + 30), Paddle1, B
 FOR y = 1 TO Speed: NEXT y
 DRAW "bm" + STR$(x) + "," + STR$(a + 8) + "ta0c0" + Star$
 DRAW "bm" + STR$(x \ 2) + "," + STR$(a + 2 + j) + "ta" + STR$(q) + "c0bd7u15r1d15"
 NEXT x
 DRAW "bm309," + STR$(a + 8) + "ta0c" + STR$(Paddle2) + Star$
 SCREEN 7, 0, 1, 0: CLS : PCOPY 0, 1: SCREEN 7, 0, 0, 0: PCOPY 1, 0
 END IF

' Shark Animality
IF Anim = 9 THEN
 FOR x = 0 TO 110 STEP 2
 Star$ = "u10f10"
 DRAW "bm" + STR$(x) + "," + STR$(199 + x \ 10) + "c" + STR$(Paddle1) + Star$
 FOR y = 1 TO Speed * 5: NEXT y
 DRAW "bm" + STR$(x) + "," + STR$(199 + x \ 10) + "c0" + Star$
 NEXT x
 FOR y = 1 TO Speed * 100: NEXT y
 Star$ = "g1h1g1h1g1h1g1h1u2e5r3l2bd3u1br2"
 Name$ = "bd5g2h1g1h1g1h1d2f2r5"
 FOR x = 10 TO 0 STEP -1
 DRAW "bm" + STR$(319 + x) + "," + STR$(B + 15) + "c" + STR$(Paddle1) + "bu10" + Star$ + "bd20" + Name$
 FOR y = 1 TO Speed * 2: NEXT y
 DRAW "bm" + STR$(319 + x) + "," + STR$(B + 15) + "c0bu10" + Star$ + "bd20" + Name$
 NEXT x
 FOR x = 10 TO 0 STEP -1
 DRAW "bm319," + STR$(B + 15) + "c" + STR$(Paddle1) + "bu" + STR$(x) + Star$ + "bd" + STR$(x * 2) + Name$
 FOR y = 1 TO Speed * 2: NEXT y
 DRAW "bm319," + STR$(B + 15) + "c0bu" + STR$(x) + Star$ + "bd" + STR$(x * 2) + Name$
 NEXT x
 DRAW "bm319," + STR$(B + 15) + "c" + STR$(Paddle1) + Star$ + Name$
 END IF

IF Anim = 10 THEN
 FOR x = 0 TO 110 STEP 2
 Star$ = "u10g10"
 DRAW "bm" + STR$(319 - x) + "," + STR$(199 + x \ 10) + "c" + STR$(Paddle2) + Star$
 FOR y = 1 TO Speed * 5: NEXT y
 DRAW "bm" + STR$(319 - x) + "," + STR$(199 + x \ 10) + "c0" + Star$
 NEXT x
 FOR y = 1 TO Speed * 100: NEXT y
 Star$ = "bl10f1e1f1e1f1e1f1e1u2h5l3r2bd3u1bl2"
 Name$ = "bd5f2e1f1e1f1e1d2g2l5"
 FOR x = 10 TO 0 STEP -1
 DRAW "bm" + STR$(10 - x) + "," + STR$(a + 15) + "c" + STR$(Paddle2) + "bu10" + Star$ + "bd20" + Name$
 FOR y = 1 TO Speed * 2: NEXT y
 DRAW "bm" + STR$(10 - x) + "," + STR$(a + 15) + "c0bu10" + Star$ + "bd20" + Name$
 NEXT x
 FOR x = 10 TO 0 STEP -1
 DRAW "bm10," + STR$(a + 15) + "c" + STR$(Paddle2) + "bu" + STR$(x) + Star$ + "bd" + STR$(x * 2) + Name$
 FOR y = 1 TO Speed * 2: NEXT y
 DRAW "bm10," + STR$(a + 15) + "c0bu" + STR$(x) + Star$ + "bd" + STR$(x * 2) + Name$
 NEXT x
 DRAW "bm10," + STR$(a + 15) + "c" + STR$(Paddle2) + Star$ + Name$
 END IF

END SUB

SUB FX

IF Morph > 0 THEN
 DO: RANDOMIZE TIMER: x = INT(14 * RND(1) + 1): LOOP WHILE x = 3 OR x = 7 OR x = 13
 IF Morph = 1 THEN Paddle1 = x
 IF Morph = 2 THEN Paddle2 = x
 END IF

IF Invis = 1 OR Invis = 3 THEN IF Inv1 = 1 THEN Inv1 = 0 ELSE IF Inv1 = 0 THEN Inv1 = 1
IF Invis = 1 AND Inv1 = 1 OR Teleport = 1 THEN FOR x = 0 TO 15: PSET (1, a + 15 + x), 0: PSET (1, a + 15 - x), 0: PSET (0, a + x), 0: PSET (0, a + 30 - x), 0: FOR y = 1 TO Speed * 2: NEXT y: NEXT x: SCREEN 7, 0, 1, 0: LINE (0, a)-(1, a + 30), 0, B: SCREEN 7, 0, 0, 0: PCOPY 1, 0: Invis = 0: IF Teleport = 1 THEN a = B
IF Morph = 1 OR Invis = 1 AND Inv1 = 0 OR Teleport = 1 THEN FOR x = 0 TO 15: PSET (1, a + 15 + x), Paddle1: PSET (1, a + 15 - x), Paddle1: PSET (0, a + x), Paddle1: PSET (0, a + 30 - x), Paddle1: FOR y = 1 TO Speed * 2: NEXT y: NEXT x: Morph = 0: Teleport = 0: Invis = 0
IF Invis = 3 THEN FOR j = 1 TO 2: FOR x = 1 TO 15 STEP 2: CIRCLE (0, a - x), x, 8: CIRCLE (0, a + 30 - x), x, 8: FOR y = 1 TO Speed * 2: NEXT y: CIRCLE (0, a - x), x, 0: CIRCLE (0, a + 30 - x), x, 0: NEXT x: LINE (0, a)-(1, a + 30), Paddle1, B: NEXT j: Invis = 0

IF Invis = 2 OR Invis = 4 THEN IF Inv2 = 1 THEN Inv2 = 0 ELSE IF Inv2 = 0 THEN Inv2 = 1
IF Invis = 2 AND Inv2 = 1 OR Teleport = 2 THEN FOR x = 0 TO 15: PSET (318, B + 15 + x), 0: PSET (318, B + 15 - x), 0: PSET (319, B + x), 0: PSET (319, B + 30 - x), 0: FOR y = 1 TO Speed * 2: NEXT y: NEXT x: SCREEN 7, 0, 1, 0: LINE (318, B)-(319, B + 30), 0, B: SCREEN 7, 0, 0, 0: PCOPY 1, 0: Invis = 0: IF Teleport = 2 THEN B = a
IF Morph = 2 OR Invis = 2 AND Inv2 = 0 OR Teleport = 2 THEN FOR x = 0 TO 15: PSET (318, B + 15 + x), Paddle2: PSET (318, B + 15 - x), Paddle2: PSET (319, B + x), Paddle2: PSET (319, B + 30 - x), Paddle2: FOR y = 1 TO Speed * 2: NEXT y: NEXT x: Morph = 0: Teleport = 0: Invis = 0
IF Invis = 4 THEN FOR j = 1 TO 2: FOR x = 1 TO 15 STEP 2: CIRCLE (319, B - x), x, 8: CIRCLE (319, B + 30 - x), x, 8: FOR y = 1 TO Speed * 2: NEXT y: CIRCLE (319, B - x), x, 0: CIRCLE (319, B + 30 - x), x, 0: NEXT x: LINE (318, B)-(319, B + 30), Paddle2, B: NEXT j: Invis = 0
                                                                                                                                                                                                                       
IF Invis = 5 THEN SCREEN 7, 0, 1, 0: CIRCLE (c, d), 2, 0: PSET (c - 1, d - 1), 0: SCREEN 7, 0, 0, 0: PCOPY 1, 0: CIRCLE (c, d), 2, 15: FOR y = 1 TO Speed * 10: NEXT y: CIRCLE (c, d), 2, 7: PSET (c, d + 2), 0: PSET (c, d - 2), 0: PSET (c + 2, d), 0: PSET (c - 2, d), 0: FOR y = 1 TO Speed * 10: NEXT y: CIRCLE (c, d), 2, 0: Invis = 0

IF Bomb = 1 THEN FOR x = 1 TO 25: CIRCLE (c, d), x, 6: FOR y = 1 TO Speed: NEXT y: CIRCLE (c, d), x, 0: NEXT x: Bomb = 0
IF Bmb > 0 THEN Bmb = Bmb - 1: BallType = 1: BallTime = 2: InvisB = 1: InAng = Angle: IF Bmb = 0 THEN InvisB = 0

END SUB

SUB Kodes

SCREEN 7, 0, 1, 0
Name$ = "c8u30r30d30l30r2c7bu2u26r26d26l26"
DRAW "bm85,110" + Name$ + "bm125,110" + Name$ + "bm165,110" + Name$ + "bm205,110" + Name$
Name$ = "": Symbol$ = "": Symbol = 0

DO
DRAW "bm68,102c7" + Name$ + "bm68,103c8" + Name$
PCOPY 1, 0
DO: a$ = INKEY$: LOOP WHILE a$ = ""
IF a$ = "4" THEN Name$ = Name$ + "br28r6e3u9h3l6d3r3d3l3d3r3d3l3d3br12": Symbol = Symbol + 1: Symbol$ = Symbol$ + "@"
IF a$ = "5" THEN Name$ = Name$ + "br30u3r3d3l3bu6u3r3u3l3g3u3e3r6d9l6bd6br10": Symbol = Symbol + 1: Symbol$ = Symbol$ + "3"
IF a$ = "6" THEN Name$ = Name$ + "br28bu3d3r3u3r3d3r3u3e3u6h3l9g3d6f3bu6r3g3u3br9d3h3r3bd9br3": Symbol = Symbol + 1: Symbol$ = Symbol$ + "?"
LOOP WHILE Symbol < 4

DRAW "bm68,102c7" + Name$ + "bm68,103c8" + Name$
PCOPY 1, 0
                                                                                Kode$ = ""
                                                                                FOR x = 20 TO 1 STEP -1
                                                                                IF x > 17 OR x = 16 OR x = 14 OR x = 5 THEN Kode$ = Kode$ + "3"
                                                                                IF x = 13 OR x > 7 AND x < 11 THEN Kode$ = Kode$ + "?"
                                                                                IF x = 17 OR x = 15 OR x = 12 OR x = 11 OR x = 7 OR x = 6 OR x < 5 THEN Kode$ = Kode$ + "@"
                                                                                NEXT x
IF Symbol$ = MID$(Kode$, 3, 4) THEN Kode = 1: Correct = 1
IF Symbol$ = MID$(Kode$, 6, 4) THEN Kode = 2: Correct = 1
IF Symbol$ = MID$(Kode$, 9, 4) THEN Kode = 3: Correct = 1
IF Symbol$ = MID$(Kode$, 12, 4) THEN Kode = 4: Correct = 1
IF Symbol$ = MID$(Kode$, 5, 4) THEN Kode = 5: Correct = 1
IF Symbol$ = MID$(Kode$, 14, 4) THEN Kode = 6: Correct = 1
IF Symbol$ = MID$(Kode$, 17, 4) THEN Kode = 7: Correct = 1
IF Symbol$ = MID$(Kode$, 10, 4) THEN Kode = 8: Correct = 1
IF Symbol$ = MID$(Kode$, 11, 4) THEN Kode = 9: Correct = 1
IF Symbol$ = MID$(Kode$, 16, 4) THEN Kode = 10: Correct = 1
IF Symbol$ = MID$(Kode$, 1, 4) THEN Kode = 11: Correct = 1
IF Symbol$ = MID$(Kode$, 8, 4) THEN AI = 1: Paddle2 = 7: Zone = 5: Correct = 1

IF Correct = 1 THEN Correct = 0: FOR x = 1 TO 3: COLOR 0, 15: FOR y = 1 TO Speed * 10: NEXT y: COLOR 0, 0: FOR y = 1 TO Speed * 10: NEXT y: NEXT x
DO: a$ = INKEY$: LOOP WHILE a$ = ""

END SUB

SUB Moves (Mer1, Mer2, In1, In2, Fire, Fire2, Extend)

BallType2 = BallType
    
IF Paddle1 = 1 THEN
 IF Combo = 1 AND BallType <> 1 THEN BallType = 1: BallTime = 40: SOUND 200, .5: SOUND 10000, 1
 IF Combo = 2 AND BallType <> 2 THEN BallType = 2: BallTime = 30
 IF Combo = 2 AND Hits > 0 THEN Invis = 5: InvisB = 0: Scream2 = 2: c = 315: d = B + 15: IF Angle = 2 THEN Angle = 3 ELSE IF Angle = 4 THEN Angle = 1
 IF Combo = 4 THEN Proj = 11
 IF Combo = 5 THEN Proj = 1: Laser = 1
 IF Combo = 5 AND Frozen2 > 0 AND En2 < 1 THEN Fatal = 5: Proj = 0
 IF Combo = 6 AND En2 < 1 AND a = B THEN Proj = 1: Laser = 1: Fatal = 1
 IF Combo = 7 AND En2 < 1 AND Mer1 = 1 THEN Anim = 9
 IF Combo = 8 AND En2 < 1 AND Mer1 = 1 THEN Friend = 5
 END IF
IF Paddle1 = 2 THEN
 IF Combo = 1 AND BallType <> 3 THEN BallType = 3: BallTime = 30: RANDOMIZE TIMER: Angle = INT(4 * RND(1) + 1): ShC = c: ShD = d
 IF Combo = 2 AND BallType <> 4 THEN BallType = 4: BallTime = 30
 IF Combo = 2 AND Hits > 0 THEN Invis = 5: InvisB = 0: Scream2 = 2: c = 315: d = B + 15: IF Angle = 2 THEN Angle = 3 ELSE IF Angle = 4 THEN Angle = 1
 IF Combo = 3 AND En2 < 1 AND Mer1 = 1 THEN Anim = 3
 IF Combo = 4 THEN Proj = 13: IF En2 < 1 AND a + 15 > B - 1 AND a + 15 < B + 31 THEN Fatal = 21
 IF Combo = 7 AND En2 < 1 AND Mer1 = 1 THEN Friend = 3
 IF Combo = 8 THEN Teleport = 1: IF Hits > 0 THEN Proj = 13
 END IF
IF Paddle1 = 4 THEN
 IF Combo = 1 THEN Proj = 27: IF Vacuum = 1 THEN Vacuum = 0
 IF Combo = 1 THEN IF Angle = 2 THEN Angle = 3 ELSE IF Angle = 4 THEN Angle = 1
 IF Combo = 1 AND En2 < 1 AND a = B THEN Proj = 0: Fatal = 13: Inv1 = 0
 IF Combo = 2 AND Vacuum = 0 THEN Proj = 23: Vacuum = 1
 IF Combo = 2 AND En2 < 1 AND Mer1 = 1 THEN Anim = 7: Proj = 0
 IF Combo = 5 THEN Proj = 31
 IF Combo = 6 THEN Proj = 33
 IF Combo = 6 AND En2 < 1 AND a + 15 > B - 1 AND a + 15 < B + 31 THEN Proj = 0: Fatal = 19
 IF Combo = 7 AND En2 < 1 AND Mer1 = 1 THEN Friend = 3
 END IF
IF Paddle1 = 5 THEN
 IF Combo = 1 THEN IF d > a - 1 AND d < a + 31 THEN Proj = 17: BallType = 0: BallTime = 0
 IF Combo = 1 AND En2 < 1 AND a = B THEN Proj = 0: Fatal = 11: Inv1 = 0
 IF Combo = 2 AND Net2 > 0 THEN Shock = 2
 IF Combo = 3 AND En2 < 1 AND Mer1 = 1 THEN Friend = 9
 IF Combo = 4 THEN Proj = 1: Laser = 4: RANDOMIZE TIMER: x = INT(20 * RND(1) + 1): IF x = 1 THEN Laser = 1
 IF Combo = 5 THEN Proj = 37
 IF Combo = 5 AND En2 < 1 AND a = B THEN Proj = 0: Fatal = 23
 IF Combo = 6 AND En2 < 1 AND Mer1 = 1 THEN Anim = 1
 END IF
IF Paddle1 = 6 THEN
 IF Combo = 2 THEN Proj = 15
 IF Combo = 4 THEN Proj = 39
 IF Combo = 4 AND En2 < 1 AND Mer1 = 1 THEN Anim = 5: Proj = 0
 IF Combo = 5 AND En2 < 1 AND a = B THEN Fatal = 17
 IF Combo = 6 THEN Proj = 19: IF En2 < 1 AND a + 15 > B - 1 AND a + 15 < B + 31 THEN Fatal = 5
 IF Combo = 7 AND En2 < 1 AND Mer1 = 1 THEN Friend = 3
 END IF
IF Paddle1 = 8 THEN
 IF Combo = 2 THEN Proj = 5
 IF Combo = 2 AND En2 < 1 AND a + 15 > B - 1 AND a + 15 < B + 31 THEN Fatal = 3: Proj = 0
 IF Combo = 4 THEN Proj = 7
 IF Combo = 5 AND En2 < 1 AND Mer1 = 1 THEN Friend = 15
 IF Combo = 6 AND En2 < 1 AND Mer1 = 1 THEN Anim = 1
 IF Combo = 8 THEN Invis = 3: In1 = En1
 IF Combo = 13 AND En2 < 1 AND Inv1 = 1 THEN Fatal = 7
 END IF
IF Paddle1 = 9 THEN
 IF Combo = 1 AND En2 < 1 AND Mer1 = 1 THEN Friend = 1
 IF Combo = 3 THEN RANDOMIZE TIMER: Angle = INT(4 * RND(1) + 1): c = INT(200 * RND(1) + 1): c = c + 60: d = INT(199 * RND(1) + 1): Invis = 5: InvisB = 0
 IF Combo = 5 THEN Proj = 21: IF En2 < 1 AND a + 15 > B - 1 AND a + 15 < B + 31 THEN Fatal = 7
 IF Combo = 6 THEN Proj = 35: IF En2 < 1 AND a + 15 > B - 1 AND a + 15 < B + 31 THEN Fatal = 3
 IF Combo = 8 THEN Teleport = 1: IF Hits > 0 THEN Proj = 21
 IF Combo = 8 AND En2 < 1 AND Mer1 = 1 THEN Anim = 7: Teleport = 0: Proj = 0
 END IF
IF Paddle1 = 10 THEN
 IF Combo = 1 AND En2 < 1 AND Mer1 = 1 THEN Anim = 3
 IF Combo = 2 THEN Proj = 9
 IF Combo = 3 THEN Proj = 31
 IF Combo = 4 THEN Proj = 1: Laser = 10: IF En2 < 1 AND a = B THEN Fatal = 1
 IF Combo = 5 AND En2 < 1 THEN Fatal = 15
 IF Combo = 13 AND En2 < 1 AND Mer1 = 1 THEN Friend = 12
 END IF
IF Paddle1 = 11 THEN
 IF Combo = 1 AND BallType <> 1 THEN BallType = 1: BallTime = 40: SOUND 200, .5: SOUND 10000, 1
 IF Combo = 3 THEN Proj = 11
 IF Combo = 4 AND En2 < 1 AND Mer1 = 1 THEN Anim = 9
 IF Combo = 5 THEN Proj = 19: IF En2 < 1 AND a + 15 > B - 1 AND a + 15 < B + 31 THEN Fatal = 5
 IF Combo = 7 AND Frozen2 > 0 AND En2 < 1 THEN Fatal = 3
 IF Combo = 8 AND En2 < 1 AND Mer1 = 1 THEN Friend = 5
 END IF
IF Paddle1 = 12 THEN
 IF Combo = 1 THEN Invis = 5: InAng = Angle: IF InvisB = 0 THEN InvisB = 1 ELSE IF InvisB = 1 THEN InvisB = 0
 IF Combo = 3 AND InvisB = 1 THEN RANDOMIZE TIMER: Angle = INT(4 * RND(1) + 1): c = INT(200 * RND(1) + 1): c = c + 60: d = INT(199 * RND(1) + 1): Invis = 5: InvisB = 0
 IF Combo = 3 AND En2 < 1 THEN Invis = 1: Inv1 = 0: Fatal = 7
 IF Combo = 4 THEN Proj = 1: Laser = 4: IF Inv1 = 1 AND En2 < 1 THEN Proj = 0: Fatal = 1
 IF Combo = 5 AND En2 < 1 AND Mer1 = 1 THEN Anim = 3
 IF Combo = 8 AND Inv1 = 1 THEN Invis = 1: a = B: IF Hits > 0 THEN Proj = 1: Laser = 4
 IF Combo = 8 AND En2 < 1 AND Mer1 = 1 THEN Friend = 14
 IF Combo = 10 THEN Invis = 1: In1 = En1
 IF Combo = 12 THEN Invis = 2: In2 = En2
 END IF
IF Paddle1 = 13 THEN
 IF Combo = 1 AND BallType <> 5 THEN BallType = 5: BallTime = 30
 IF Combo = 4 THEN Proj = 47: IF En2 < 1 AND a + 15 > B - 1 AND a + 15 < B + 31 THEN Fatal = 7
 IF Combo = 5 AND En2 < 1 AND Shift1 = 0 THEN Fatal = 29
 IF Combo = 7 AND En2 < 1 AND Mer1 = 1 AND Shift1 = 0 THEN Friend = 13
 IF Combo = 8 THEN Teleport = 1: IF Hits > 0 THEN Proj = 47
 IF Combo = 13 AND En2 < 1 AND Mer1 = 1 AND Shift1 = 0 THEN Anim = 7
 END IF
IF Paddle1 = 14 THEN
 IF Combo = 1 AND BallType <> 6 THEN BallType = 6: BallTime = 30
 IF Combo = 2 AND Bmb = 0 THEN Bomb = 1: Bmb = 30
 IF Combo = 2 AND Hits > 0 THEN Bomb = 1: c = 315: d = B + 15: IF Angle = 2 THEN Angle = 3 ELSE IF Angle = 4 THEN Angle = 1
 IF Combo = 2 AND Bomb = 1 AND c > 295 AND d > B - 5 AND d < B + 35 THEN En2 = En2 - 3: Scream2 = 6: IF En2 + 3 < 1 THEN Fatal = 21
 IF Combo = 4 THEN Proj = 25: IF En2 < 1 AND a + 15 > B - 1 AND a + 15 < B + 31 THEN Fatal = 7
 IF Combo = 5 AND En2 < 1 AND Mer1 = 1 THEN Friend = 10
 IF Combo = 6 AND En2 < 1 AND Mer1 = 1 THEN Anim = 5
 END IF
IF Paddle1 = 15 THEN
 IF Combo = 1 AND Fire2 = 0 THEN Fire = Fire + 1
 IF Combo = 1 AND En2 < 1 AND Mer1 = 1 THEN Anim = 3: Fire = 0
 IF Combo = 4 AND Fire2 = 0 THEN Fire = Fire + 2
 IF Combo = 5 AND Fire2 = 0 THEN Fire = Fire + 3
 IF Combo = 6 AND En2 < 1 AND Mer1 = 1 THEN Friend = 7: Fire = 0
 IF Combo = 8 AND En2 < 1 THEN Paddle1 = 13: Inv1 = 1: Invis = 3: Fire = 0
 END IF
 
IF En2 < 1 THEN
 IF Combo = 9 THEN Baby = 1: IF Paddle1 = 13 THEN Baby = 2
 IF Combo = 10 AND Mer1 = 0 THEN Mercy = 1
 IF Combo = 11 AND Zone = 1 THEN Fatal = 27
 IF Combo = 12 AND Zone = 3 THEN Fatal = 25
 END IF
IF Shift1 = 1 AND Combo = 13 AND Paddle1 <> 13 THEN Morph = 1: Shift1 = 32: Fire = 0
IF Shift1 = 1 AND Combo = 3 AND Paddle1 <> 13 AND Paddle2 <> 3 AND Paddle2 <> 7 AND Paddle2 <> 13 AND Paddle2 <> 0 THEN Paddle1 = Paddle2: Shift1 = 16: Inv1 = 1: Invis = 3: Fire = 0: IF En2 < 1 THEN Fatal = 7
IF Hits > 0 THEN IF Combo = 1 AND (Paddle1 > 5 AND Paddle1 < 11) OR Combo = 2 AND (Paddle1 > 10 AND Paddle1 < 14 OR Paddle1 = 15) OR Combo = 3 AND (Paddle1 < 6 OR Paddle1 = 14) THEN Extend = 1
IF In1 > En1 THEN Inv1 = 0: In1 = 0

IF Paddle2 = 0 THEN
 IF Combo = 14 AND BallType <> 8 THEN BallType = 8: BallTime = 30
 IF Combo = 15 AND Net1 > 0 THEN Shock = 1: IF En1 < 1 THEN Net1 = Net1 + 100: IF Net1 > 500 THEN Fatal = 22
 IF Combo = 18 THEN Proj = 38
 IF Combo = 21 THEN B = a: IF Hits2 > 0 THEN Proj = 38
 END IF
IF Paddle2 = 1 THEN
 IF Combo = 14 AND BallType <> 1 THEN BallType = 1: BallTime = 40: SOUND 200, .5: SOUND 10000, 1
 IF Combo = 15 AND BallType <> 2 THEN BallType = 2: BallTime = 30
 IF Combo = 15 AND Hits2 > 0 THEN Invis = 5: InvisB = 0: Scream1 = 2: c = 4: d = a + 15: IF Angle = 3 THEN Angle = 2 ELSE IF Angle = 1 THEN Angle = 4
 IF Combo = 17 THEN Proj = 12
 IF Combo = 18 THEN Proj = 2: Laser = 1
 IF Combo = 18 AND Frozen1 > 0 AND En1 < 1 THEN Fatal = 6: Proj = 0
 IF Combo = 19 AND En1 < 1 AND a = B THEN Proj = 2: Laser = 1: Fatal = 2
 IF Combo = 20 AND En1 < 1 AND Mer2 = 1 THEN Anim = 10
 IF Combo = 21 AND En1 < 1 AND Mer2 = 1 THEN Friend = 6
 END IF
IF Paddle2 = 2 THEN
 IF Combo = 14 AND BallType <> 3 THEN BallType = 3: BallTime = 30: RANDOMIZE TIMER: Angle = INT(4 * RND(1) + 1): ShC = c: ShD = d
 IF Combo = 15 AND BallType <> 4 THEN BallType = 4: BallTime = 30
 IF Combo = 15 AND Hits2 > 0 THEN Invis = 5: InvisB = 0: Scream1 = 2: c = 4: d = a + 15: IF Angle = 3 THEN Angle = 2 ELSE IF Angle = 1 THEN Angle = 4
 IF Combo = 16 AND En1 < 1 AND Mer2 = 1 THEN Anim = 4
 IF Combo = 17 THEN Proj = 14: IF En1 < 1 AND B + 15 > a - 1 AND B + 15 < a + 31 THEN Fatal = 22
 IF Combo = 20 AND En1 < 1 AND Mer2 = 1 THEN Friend = 4
 IF Combo = 21 THEN Teleport = 2: IF Hits2 > 0 THEN Proj = 14
 END IF
IF Paddle2 = 3 THEN
 IF Combo = 14 AND BallType <> 2 THEN BallType = 2: BallTime = 30
 IF Combo = 14 AND Hits2 > 0 THEN Invis = 5: InvisB = 0: Scream1 = 2: c = 4: d = a + 15: IF Angle = 3 THEN Angle = 2 ELSE IF Angle = 1 THEN Angle = 4
 IF Combo = 17 THEN Proj = 20: IF En1 < 1 AND B + 15 > a - 1 AND B + 15 < a + 31 THEN Fatal = 6
 IF Combo = 23 THEN Invis = 2: In2 = En2
 END IF
IF Paddle2 = 4 THEN
 IF Combo = 14 THEN Proj = 28: IF Vacuum = 2 THEN Vacuum = 0
 IF Combo = 14 THEN IF Angle = 3 THEN Angle = 2 ELSE IF Angle = 1 THEN Angle = 4
 IF Combo = 14 AND En1 < 1 AND a = B THEN Proj = 0: Fatal = 14: Inv2 = 0
 IF Combo = 15 AND Vacuum = 0 THEN Proj = 24: Vacuum = 2
 IF Combo = 15 AND En1 < 1 AND Mer2 = 1 THEN Anim = 8: Proj = 0
 IF Combo = 18 THEN Proj = 32
 IF Combo = 19 THEN Proj = 34
 IF Combo = 19 AND En1 < 1 AND B + 15 > a - 1 AND B + 15 < a + 31 THEN Proj = 0: Fatal = 20
 IF Combo = 20 AND En1 < 1 AND Mer2 = 1 THEN Friend = 4
 END IF
IF Paddle2 = 5 THEN
 IF Combo = 14 THEN IF d > B - 1 AND d < B + 31 THEN Proj = 18: BallType = 0: BallTime = 0
 IF Combo = 14 AND En1 < 1 AND a = B THEN Proj = 0: Fatal = 12: Inv2 = 0
 IF Combo = 15 AND Net1 > 0 THEN Shock = 1
 IF Combo = 16 AND En1 < 1 AND Mer2 = 1 THEN Friend = 9
 IF Combo = 17 THEN Proj = 2: Laser = 4: RANDOMIZE TIMER: x = INT(20 * RND(1) + 1): IF x = 1 THEN Laser = 1
 IF Combo = 18 THEN Proj = 38
 IF Combo = 18 AND En1 < 1 AND a = B THEN Proj = 0: Fatal = 24
 IF Combo = 19 AND En1 < 1 AND Mer2 = 1 THEN Anim = 2
 END IF
IF Paddle2 = 6 THEN
 IF Combo = 15 THEN Proj = 16
 IF Combo = 17 THEN Proj = 40
 IF Combo = 17 AND En1 < 1 AND Mer2 = 1 THEN Anim = 6: Proj = 0
 IF Combo = 18 AND En1 < 1 AND a = B THEN Fatal = 18
 IF Combo = 19 THEN Proj = 20: IF En1 < 1 AND B + 15 > a - 1 AND B + 15 < a + 31 THEN Fatal = 6
 IF Combo = 20 AND En1 < 1 AND Mer2 = 1 THEN Friend = 4
 END IF
IF Paddle2 = 7 THEN
 IF Combo = 14 AND BallType <> 7 THEN BallType = 7: BallTime = 10
 IF Combo = 14 AND Hits2 > 0 THEN Invis = 5: InvisB = 0: Scream1 = 2: c = 4: d = a + 15
 IF Combo = 15 THEN Proj = 50
 END IF
IF Paddle2 = 8 THEN
 IF Combo = 15 THEN Proj = 6
 IF Combo = 15 AND En1 < 1 AND B + 15 > a - 1 AND B + 15 < a + 31 THEN Fatal = 4: Proj = 0
 IF Combo = 17 THEN Proj = 8
 IF Combo = 18 AND En1 < 1 AND Mer2 = 1 THEN Friend = 16
 IF Combo = 19 AND En1 < 1 AND Mer2 = 1 THEN Anim = 2
 IF Combo = 21 THEN Invis = 4: In2 = En2
 IF Combo = 26 AND En1 < 1 AND Inv2 = 1 THEN Fatal = 8
 END IF
IF Paddle2 = 9 THEN
 IF Combo = 14 AND En1 < 1 AND Mer2 = 1 THEN Friend = 2
 IF Combo = 16 THEN RANDOMIZE TIMER: Angle = INT(4 * RND(1) + 1): c = INT(200 * RND(1) + 1): c = c + 60: d = INT(199 * RND(1) + 1): Invis = 5: InvisB = 0
 IF Combo = 18 THEN Proj = 22: IF En1 < 1 AND B + 15 > a - 1 AND B + 15 < a + 31 THEN Fatal = 8
 IF Combo = 19 THEN Proj = 36: IF En1 < 1 AND B + 15 > a - 1 AND B + 15 < a + 31 THEN Fatal = 4
 IF Combo = 21 THEN Teleport = 2: IF Hits2 > 0 THEN Proj = 22
 IF Combo = 21 AND En1 < 1 AND Mer2 = 1 THEN Anim = 8: Teleport = 0: Proj = 0
 END IF
IF Paddle2 = 10 THEN
 IF Combo = 14 AND En1 < 1 AND Mer2 = 1 THEN Anim = 4
 IF Combo = 15 THEN Proj = 10
 IF Combo = 16 THEN Proj = 32
 IF Combo = 17 THEN Proj = 2: Laser = 10: IF En1 < 1 AND a = B THEN Fatal = 2
 IF Combo = 18 AND En1 < 1 THEN Fatal = 16
 IF Combo = 26 AND En1 < 1 AND Mer2 = 1 THEN Friend = 12
 END IF
IF Paddle2 = 11 THEN
 IF Combo = 14 AND BallType <> 1 THEN BallType = 1: BallTime = 40: SOUND 200, .5: SOUND 10000, 1
 IF Combo = 16 THEN Proj = 12
 IF Combo = 17 AND En1 < 1 AND Mer2 = 1 THEN Anim = 10
 IF Combo = 18 THEN Proj = 20: IF En1 < 1 AND B + 15 > a - 1 AND B + 15 < a + 31 THEN Fatal = 6
 IF Combo = 20 AND Frozen1 > 0 AND En1 < 1 THEN Fatal = 4
 IF Combo = 21 AND En1 < 1 AND Mer2 = 1 THEN Friend = 6
 END IF
IF Paddle2 = 12 THEN
 IF Combo = 14 THEN Invis = 5: InAng = Angle: IF InvisB = 0 THEN InvisB = 1 ELSE IF InvisB = 1 THEN InvisB = 0
 IF Combo = 16 AND InvisB = 1 THEN RANDOMIZE TIMER: Angle = INT(4 * RND(1) + 1): c = INT(200 * RND(1) + 1): c = c + 60: d = INT(199 * RND(1) + 1): Invis = 5: InvisB = 0
 IF Combo = 16 AND En1 < 1 THEN Invis = 2: Inv2 = 0: Fatal = 8
 IF Combo = 17 THEN Proj = 2: Laser = 4: IF Inv2 = 1 AND En1 < 1 THEN Proj = 0: Fatal = 2
 IF Combo = 18 AND En1 < 1 AND Mer2 = 1 THEN Anim = 4
 IF Combo = 21 AND Inv2 = 1 THEN Invis = 2: B = a: IF Hits2 > 0 THEN Proj = 2: Laser = 4
 IF Combo = 21 AND En1 < 1 AND Mer2 = 1 THEN Friend = 14
 IF Combo = 23 THEN Invis = 2: In2 = En2
 IF Combo = 25 THEN Invis = 1: In1 = En1
 END IF
IF Paddle2 = 13 THEN
 IF Combo = 14 AND BallType <> 5 THEN BallType = 5: BallTime = 30
 IF Combo = 17 THEN Proj = 48: IF En1 < 1 AND B + 15 > a - 1 AND B + 15 < a + 31 THEN Fatal = 8
 IF Combo = 18 AND En1 < 1 AND Shift2 = 0 THEN Fatal = 30
 IF Combo = 20 AND En1 < 1 AND Mer2 = 1 AND Shift2 = 0 THEN Friend = 13
 IF Combo = 21 THEN Teleport = 2: IF Hits2 > 0 THEN Proj = 48
 IF Combo = 26 AND En1 < 1 AND Mer2 = 1 AND Shift2 = 0 THEN Anim = 8
 END IF
IF Paddle2 = 14 THEN
 IF Combo = 14 AND BallType <> 6 THEN BallType = 6: BallTime = 30
 IF Combo = 15 AND Bmb = 0 THEN Bomb = 1: Bmb = 30
 IF Combo = 15 AND Hits2 > 0 THEN Bomb = 1: c = 4: d = a + 15: IF Angle = 3 THEN Angle = 2 ELSE IF Angle = 1 THEN Angle = 4
 IF Combo = 15 AND Bomb = 1 AND c < 25 AND d > a - 5 AND d < a + 35 THEN En1 = En1 - 3: Scream1 = 6: IF En1 + 3 < 1 THEN Fatal = 22
 IF Combo = 17 THEN Proj = 26: IF En1 < 1 AND B + 15 > a - 1 AND B + 15 < a + 31 THEN Fatal = 8
 IF Combo = 18 AND En1 < 1 AND Mer2 = 1 THEN Friend = 11
 IF Combo = 19 AND En1 < 1 AND Mer2 = 1 THEN Anim = 6
 END IF
IF Paddle2 = 15 THEN
 IF Combo = 14 AND Fire = 0 THEN Fire2 = Fire2 + 1
 IF Combo = 14 AND En1 < 1 AND Mer2 = 1 THEN Anim = 4: Fire2 = 0
 IF Combo = 17 AND Fire = 0 THEN Fire2 = Fire2 + 2
 IF Combo = 18 AND Fire = 0 THEN Fire2 = Fire2 + 3
 IF Combo = 19 AND En1 < 1 AND Mer2 = 1 THEN Friend = 8: Fire2 = 0
 IF Combo = 21 AND En1 < 1 THEN Paddle2 = 13: Inv2 = 1: Invis = 4: Fire2 = 0
 END IF

IF En1 < 1 THEN
 IF Combo = 22 THEN Baby = 2: IF Paddle2 = 13 THEN Baby = 1
 IF Combo = 23 AND Mer2 = 0 THEN Mercy = 2
 IF Combo = 24 AND Zone = 1 THEN Fatal = 28
 IF Combo = 25 AND Zone = 3 THEN Fatal = 26
 END IF
IF Fire > 0 THEN Fire = Fire - 1: Proj = 29
IF Fire2 > 0 THEN Fire2 = Fire2 - 1: Proj = 30
IF Shift2 = 1 AND Combo = 26 AND Paddle2 <> 13 THEN Morph = 2: Shift2 = 32: Fire2 = 0
IF Shift2 = 1 AND Combo = 16 AND Paddle2 <> 13 AND Paddle1 <> 13 THEN Paddle2 = Paddle1: Shift2 = 16: Inv2 = 1: Invis = 4: Fire2 = 0: IF En1 < 1 THEN Fatal = 8
IF Hits2 > 0 THEN IF Combo = 14 AND (Paddle2 > 5 AND Paddle2 < 11) OR Combo = 15 AND (Paddle2 > 10 AND Paddle2 < 14 OR Paddle2 = 15) OR Combo = 16 AND (Paddle2 < 6 OR Paddle2 = 14) THEN Extend = 2
IF In2 > En2 THEN Inv2 = 0: In2 = 0
IF InAng <> Angle THEN InvisB = 0

IF BallType <> BallType2 THEN Bmb = 0: InvisB = 0

END SUB

SUB Options

15
SCREEN 7, 0, 1, 0
CLS

IF AI > 0 AND Tournament = 1 THEN Word$ = "TOURNAMENT": x = 0
IF AI > 0 AND Tournament = 0 THEN Word$ = "PRACTICE": x = 24
IF AI = 0 THEN Word$ = "2 PLAYER": x = 17
Word$ = Word$ + " MODE"
CALL BigWrite(Word$, Name$)
DRAW "bm" + STR$(70 + x) + ",79c7" + Name$
IF Choice = 0 THEN DRAW "bm" + STR$(70 + x) + ",80c15" + Name$ ELSE DRAW "bm" + STR$(70 + x) + ",80c8" + Name$

Word$ = "SPEED "
IF Speed = 50 THEN Word$ = Word$ + "1"
IF Speed = 40 THEN Word$ = Word$ + "2"
IF Speed = 30 THEN Word$ = Word$ + "3"
IF Speed = 20 THEN Word$ = Word$ + "4"
IF Speed = 10 THEN Word$ = Word$ + "5"
CALL BigWrite(Word$, Name$)
DRAW "bm121,109c7" + Name$
IF Choice = 1 THEN DRAW "bm121,110c15" + Name$ ELSE DRAW "bm121,110c8" + Name$

Word$ = "EXIT": CALL BigWrite(Word$, Name$)
DRAW "bm141,149c7" + Name$
IF Choice = 2 THEN DRAW "bm141,150c15" + Name$ ELSE DRAW "bm141,150c8" + Name$

SCREEN 7, 0, 0, 0: PCOPY 1, 0
DO: a$ = INKEY$: LOOP WHILE a$ = ""
IF a$ = "8" THEN Choice = Choice - 1: IF Choice < 0 THEN Choice = 0
IF a$ = "2" THEN Choice = Choice + 1: IF Choice > 2 THEN Choice = 2
IF a$ = "8" OR a$ = "2" THEN FOR x = 1 TO 1000: NEXT x: GOTO 15
IF Choice = 0 THEN IF AI = 0 THEN AI = 1 ELSE IF AI > 0 AND Tournament = 0 THEN Tournament = 1 ELSE IF AI > 0 AND Tournament = 1 THEN AI = 0: Tournament = 0
IF Choice = 1 THEN Speed = Speed - 10: IF Speed < 10 THEN Speed = 50
IF Choice < 2 THEN FOR x = 1 TO 1000: NEXT x: GOTO 15

END SUB

SUB Player (Choice, Spooky, Round())

16

SCREEN 7, 0, 2, 0: CLS
DRAW "bm130,60c8u50r60d50l60r2c7bu2u46r56d46l56"
IF Tournament = 0 THEN DRAW "bm130,180c8u50r60d50l60r2c7bu2u46r56d46l56"

Zone = Zone + 1: IF Zone = 6 THEN Zone = 1

IF Spooky = 0 THEN
 DRAW "bm130,110c8u30r60d30l60r2c7bu2u26r56d26l56"
 Word$ = "KOMBAT": CALL SmallWrite(Word$, Name$): DRAW "bm148,78c8" + Name$
 Word$ = "ZONE": CALL SmallWrite(Word$, Name$): DRAW "bm152,116c8" + Name$

 IF Zone = 1 THEN
  Word$ = "POOL": CALL BigWrite(Word$, Name$)
  DRAW "bm139,102c10" + Name$ + "bm139,103c2" + Name$: Col1 = 2: Col2 = 10
  END IF
 IF Zone = 2 THEN
  Word$ = "VOID": CALL BigWrite(Word$, Name$)
  DRAW "bm139,102c12" + Name$ + "bm139,103c4" + Name$: Col1 = 4: Col2 = 12
  END IF
 IF Zone = 3 THEN
  Word$ = "PIT": CALL BigWrite(Word$, Name$)
  DRAW "bm147,102c9" + Name$ + "bm147,103c1" + Name$: Col1 = 9: Col2 = 11
  END IF
 IF Zone = 4 THEN
  Word$ = "?": CALL BigWrite(Word$, Name$)
  DRAW "bm155,102c13" + Name$ + "bm155,103c5" + Name$: Col1 = 5: Col2 = 13
  END IF
 IF Zone = 5 THEN
  Word$ = "LAIR": CALL BigWrite(Word$, Name$)
  DRAW "bm142,102c8" + Name$ + "bm142,103c7" + Name$: Col1 = 8: Col2 = 7
  END IF
 END IF

Word$ = "CHILLN": CALL BigWrite(Word$, Name$)
DRAW "bm32,30c7" + Name$ + "bm32,31c8" + Name$
Word$ = "SHOCKER": CALL BigWrite(Word$, Name$)
DRAW "bm24,60c7" + Name$ + "bm24,61c8" + Name$
Word$ = "BLOODBATH": CALL BigWrite(Word$, Name$)
DRAW "bm10,90c7" + Name$ + "bm10,91c8" + Name$
Word$ = "ICEPICK": CALL BigWrite(Word$, Name$)
DRAW "bm32,120c7" + Name$ + "bm32,121c8" + Name$
Word$ = "NINJA": CALL BigWrite(Word$, Name$)
DRAW "bm32,150c7" + Name$ + "bm32,151c8" + Name$
Word$ = "SYLVA": CALL BigWrite(Word$, Name$)
DRAW "bm32,180c7" + Name$ + "bm32,181c8" + Name$
Word$ = "BLACKOUT": CALL BigWrite(Word$, Name$)
DRAW "bm219,30c7" + Name$ + "bm219,31c8" + Name$
Word$ = "CYBER": CALL BigWrite(Word$, Name$)
DRAW "bm236,60c7" + Name$ + "bm236,61c8" + Name$
Word$ = "FIREBUG": CALL BigWrite(Word$, Name$)
DRAW "bm224,90c7" + Name$ + "bm224,91c8" + Name$
Word$ = "GLACIER": CALL BigWrite(Word$, Name$)
DRAW "bm226,120c7" + Name$ + "bm226,121c8" + Name$
Word$ = "BANSHEE": CALL BigWrite(Word$, Name$)
DRAW "bm221,150c7" + Name$ + "bm221,151c8" + Name$
Word$ = "SHIFTER": CALL BigWrite(Word$, Name$)
DRAW "bm226,180c7" + Name$ + "bm226,181c8" + Name$
IF Spooky = 1 THEN
 Word$ = "?": CALL BigWrite(Word$, Name$)
 DRAW "bm155,102c7" + Name$ + "bm155,103c8" + Name$
 END IF

20

SCREEN 7, 0, 1, 0: PCOPY 2, 1: DRAW "ta0"

Word$ = "CHILLN": CALL BigWrite(Word$, Name$)
IF Choice = 0 THEN Paddle = 1: DRAW "bm32,30c9" + Name$ + "bm32,31c1" + Name$
Word$ = "SHOCKER": CALL BigWrite(Word$, Name$)
IF Choice = 1 THEN Paddle = 2: DRAW "bm24,60c10" + Name$ + "bm24,61c2" + Name$
Word$ = "BLOODBATH": CALL BigWrite(Word$, Name$)
IF Choice = 2 THEN Paddle = 4: DRAW "bm10,90c12" + Name$ + "bm10,91c4" + Name$
Word$ = "ICEPICK": CALL BigWrite(Word$, Name$)
IF Choice = 3 THEN Paddle = 6: DRAW "bm32,120c14" + Name$ + "bm32,121c6" + Name$
Word$ = "NINJA": CALL BigWrite(Word$, Name$)
IF Choice = 4 THEN Paddle = 8: DRAW "bm32,150c8" + Name$ + "bm32,151c7" + Name$
Word$ = "SYLVA": CALL BigWrite(Word$, Name$)
IF Choice = 5 THEN Paddle = 10: DRAW "bm32,180c2" + Name$ + "bm32,181c10" + Name$
Word$ = "BLACKOUT": CALL BigWrite(Word$, Name$)
IF Choice = 6 THEN Paddle = 12: DRAW "bm219,30c4" + Name$ + "bm219,31c12" + Name$
Word$ = "CYBER": CALL BigWrite(Word$, Name$)
IF Choice = 7 THEN Paddle = 5: DRAW "bm236,60c13" + Name$ + "bm236,61c5" + Name$
Word$ = "FIREBUG": CALL BigWrite(Word$, Name$)
IF Choice = 8 THEN Paddle = 14: DRAW "bm224,90c6" + Name$ + "bm224,91c14" + Name$
Word$ = "GLACIER": CALL BigWrite(Word$, Name$)
IF Choice = 9 THEN Paddle = 11: DRAW "bm226,120c3" + Name$ + "bm226,121c11" + Name$
Word$ = "BANSHEE": CALL BigWrite(Word$, Name$)
IF Choice = 10 THEN Paddle = 9: DRAW "bm221,150c3" + Name$ + "bm221,151c9" + Name$
Word$ = "SHIFTER": CALL BigWrite(Word$, Name$)
IF Choice = 11 THEN Paddle = 15: DRAW "bm226,180c7" + Name$ + "bm226,181c15" + Name$
IF Spooky = 1 THEN
 Word$ = "?": CALL BigWrite(Word$, Name$)
 IF Choice = 12 THEN Paddle = 13: DRAW "bm155,102c13" + Name$ + "bm155,103c5" + Name$
 END IF

DO: a$ = INKEY$
x = x + 1: IF x > 360 THEN x = 1

IF Surprise = 0 THEN RANDOMIZE TIMER: y = INT(500 * RND(1) + 1): IF y = 1 OR y = 2 THEN Surprise = 1
IF Surprise = 1 THEN Dip = Dip + 3: IF Dip = 30 THEN Surprise = 2
IF Surprise = 2 THEN Pause = Pause + 1: IF Pause = 20 THEN Pause = 0: Surprise = 3
IF Surprise = 3 THEN Dip = Dip - 3: IF Dip = 0 THEN Surprise = 0
IF Surprise > 0 AND y = 1 THEN LINE (200, 199)-(201, 199 - Dip), 13, B
IF Surprise > 0 AND y = 2 THEN LINE (120, 0)-(121, Dip), 3, B

Star$ = "ta" + STR$(x) + "u15r1d30l1u15"
IF Turn = 0 THEN DRAW "bm159,35c" + STR$(Paddle) + Star$
IF Turn = 1 THEN DRAW "bm159,155c" + STR$(Paddle) + Star$
IF Turn = 0 AND Tournament = 0 THEN DRAW "bm159,155ta0c" + STR$(Paddle2) + "u15r1d30l1u15"
IF Turn = 1 THEN DRAW "bm159,35ta0c" + STR$(Paddle1) + "u15r1d30l1u15"
PCOPY 1, 0
IF Turn = 0 THEN DRAW "bm159,35c0" + Star$
IF Turn = 1 THEN DRAW "bm159,155c0" + Star$

IF Surprise > 0 AND y = 1 THEN LINE (200, 199)-(201, 199 - Dip), 0, B
IF Surprise > 0 AND y = 2 THEN LINE (120, 0)-(121, Dip), 0, B
                                                            
LOOP WHILE a$ = ""

IF a$ = "*" THEN
 PCOPY 2, 1
 DRAW "ta0"
 Word$ = "RANDOM SELECT": CALL SmallWrite(Word$, Name$)
 IF Turn = 0 THEN DRAW "bm136,66c15" + Name$
 IF Turn = 1 THEN DRAW "bm136,128c15" + Name$
 PCOPY 1, 2
 FOR j = 0 TO 360 STEP 10
 Star$ = "ta" + STR$(j) + "u15r1d30l1u15"
 IF Turn = 0 THEN DRAW "bm159,35c" + STR$(Paddle) + Star$
 IF Turn = 1 THEN DRAW "bm159,155c" + STR$(Paddle) + Star$
 IF Turn = 0 AND Tournament = 0 THEN DRAW "bm159,155ta0c" + STR$(Paddle2) + "u15r1d30l1u15"
 IF Turn = 1 THEN DRAW "bm159,35ta0c" + STR$(Paddle1) + "u15r1d30l1u15"
 PCOPY 1, 0
 IF Turn = 0 THEN DRAW "bm159,35c0" + Star$
 IF Turn = 1 THEN DRAW "bm159,155c0" + Star$
 DO: RANDOMIZE TIMER: Paddle = INT(15 * RND(1) + 1): LOOP WHILE Paddle = 3 OR Paddle = 7 OR Paddle = 13 AND Spooky = 0
 NEXT j
 END IF

IF a$ = "8" AND Choice <> 12 THEN Choice = Choice - 1: IF Choice < 0 THEN Choice = 11
IF a$ = "2" AND Choice <> 12 THEN Choice = Choice + 1: IF Choice > 11 THEN Choice = 0
IF Spooky = 1 THEN
 IF a$ = "6" AND Choice = 12 THEN Choice = 8: a$ = "2"
 IF a$ = "4" AND Choice = 12 THEN Choice = 2: a$ = "2"
 IF a$ = "6" AND (Choice = 2 OR Choice = 3) OR a$ = "4" AND (Choice = 8 OR Choice = 9) THEN Choice = 12: a$ = "2"
 END IF
IF a$ = "6" AND Choice < 6 THEN Choice = Choice + 6
IF a$ = "4" AND Choice > 5 THEN Choice = Choice - 6
IF a$ = "8" OR a$ = "2" OR a$ = "6" OR a$ = "4" THEN GOTO 20

IF a$ = CHR$(9) THEN GOTO 16

IF Turn = 0 AND Tournament = 1 THEN
 Paddle1 = Paddle
 FOR x = 0 TO 15: Round(x) = 0: NEXT x
 RANDOMIZE TIMER: Paddle = INT(14 * RND(1) + 1)
 IF Paddle = 3 OR Paddle = 7 OR Paddle = 13 THEN Paddle = Paddle + 1
 Turn = 1
 END IF

IF Turn = 0 THEN Paddle1 = Paddle: Turn = 1: Choice = 0: x = 0: GOTO 20
IF Turn = 1 THEN Paddle2 = Paddle

END SUB

SUB Portal

PCOPY 1, 0
IF Paddle2 = 3 THEN j = 11 ELSE IF Paddle2 = 13 THEN j = 5
Word$ = "GET READY!": CALL BigWrite(Word$, Name$)
DRAW "bm105,104c8" + Name$ + "bm105,105c15" + Name$
FOR x = 1 TO 3: COLOR 0, 8: COLOR 0, 7: COLOR 0, 15: COLOR 0, 7: COLOR 0, 8: COLOR 0, 0: FOR y = 1 TO Speed * 10: NEXT y: NEXT x
FOR x = 1 TO Speed * 200: NEXT x: PCOPY 1, 0
FOR x = 3 TO 19: CIRCLE (160, 100), x, j: CIRCLE (160, 100), x - 2, Paddle2: FOR y = 1 TO Speed * 4: NEXT y: CIRCLE (160, 100), x, 0: CIRCLE (160, 100), x - 2, 0: NEXT x: CIRCLE (160, 100), x, j: CIRCLE (160, 100), x - 2, Paddle2
Word$ = "?": CALL BigWrite(Word$, Name$)
DRAW "bm155,107c" + STR$(Paddle2) + Name$ + "bm155,108c" + STR$(j) + Name$
FOR x = 1 TO Speed * 100: NEXT x
DRAW "bm155,107c0" + Name$ + "bm155,108c0" + Name$
FOR x = 20 TO 30: CIRCLE (160, 100), x, j: CIRCLE (160, 100), x - 2, Paddle2: FOR y = 1 TO Speed * 4: NEXT y: CIRCLE (160, 100), x, 0: CIRCLE (160, 100), x - 2, 0: NEXT x: CIRCLE (160, 100), x, j: CIRCLE (160, 100), x - 2, Paddle2
LINE (160, 85)-(161, 115), Paddle2, B
FOR x = 1 TO Speed * 100: NEXT x
LINE (160, 85)-(161, 115), 0, B
FOR x = 31 TO 3 STEP -1: CIRCLE (160, 100), x, j: CIRCLE (160, 100), x - 2, Paddle2: FOR y = 1 TO Speed * 4: NEXT y: CIRCLE (160, 100), x, 0: CIRCLE (160, 100), x - 2, 0: NEXT x

END SUB

SUB Projectile (Refreeze)

IF Proj = 1 THEN
 FOR x = 2 TO 319 STEP 5: LINE (x, a + 15)-(x + 15, a + 15), Laser: FOR y = 1 TO Speed * 2: NEXT y: LINE (x, a + 15)-(x + 15, a + 15), 0: NEXT x
 IF a + 15 > B - 1 AND a + 15 < B + 31 THEN En2 = En2 - 5
 END IF
IF Proj = 2 THEN
 FOR x = 302 TO -15 STEP -5: LINE (x, B + 15)-(x + 15, B + 15), Laser: FOR y = 1 TO Speed * 2: NEXT y: LINE (x, B + 15)-(x + 15, B + 15), 0: NEXT x
 IF B + 15 > a - 1 AND B + 15 < a + 31 THEN En1 = En1 - 5
 END IF
 
IF Proj = 5 THEN
 FOR x = 6 TO 310 STEP 4: Star$ = "bm" + STR$(x) + "," + STR$(a + 14) + "u2f2r2g2d2h2l2e2": DRAW "c8" + Star$: FOR y = 1 TO Speed: NEXT y: DRAW "c0" + Star$: NEXT x
 IF a + 15 > B - 1 AND a + 15 < B + 31 THEN En2 = En2 - 5
 END IF
IF Proj = 6 THEN
 FOR x = 313 TO 9 STEP -4: Star$ = "bm" + STR$(x) + "," + STR$(B + 14) + "u2g2l2f2d2e2r2h2": DRAW "c8" + Star$: FOR y = 1 TO Speed: NEXT y: DRAW "c0" + Star$: NEXT x
 IF B + 15 > a - 1 AND B + 15 < a + 31 THEN En1 = En1 - 5
 END IF

IF Proj = 7 THEN
 Name$ = "u2f2r2g2d2h2l2e2"
 n = 0: FOR x = 6 TO 310 STEP 4: n = x \ 4: Star$ = "bm" + STR$(x) + "," + STR$(a + 14) + Name$ + "bu" + STR$(n) + Name$ + "bd" + STR$(n * 2) + Name$: DRAW "c8" + Star$: FOR y = 1 TO Speed: NEXT y: DRAW "c0" + Star$: NEXT x
 IF a + 15 > B - 1 AND a + 15 < B + 31 OR a + 15 - n > B - 1 AND a + 15 - n < B + 31 OR a + 15 + n > B - 1 AND a + 15 + n < B + 31 THEN En2 = En2 - 3
 END IF
IF Proj = 8 THEN
 Name$ = "u2g2l2f2d2e2r2h2"
 j = 8: FOR x = 313 TO 9 STEP -4: j = j + 4: n = j / 4: Star$ = "bm" + STR$(x) + "," + STR$(B + 14) + Name$ + "bu" + STR$(n) + Name$ + "bd" + STR$(n * 2) + Name$: DRAW "c8" + Star$: FOR y = 1 TO Speed: NEXT y: DRAW "c0" + Star$: NEXT x
 IF B + 15 > a - 1 AND B + 15 < a + 31 OR B + 15 - n > a - 1 AND B + 15 - n < a + 31 OR B + 15 + n > a - 1 AND B + 15 + n < a + 31 THEN En1 = En1 - 3
 END IF
                           
IF Proj = 9 THEN
 FOR x = 6 TO 316 STEP 4: Star$ = "bm" + STR$(x) + "," + STR$(a + 17) + "bu2e1u1d1f1r1l1g1d1u1h1l1": DRAW "c10" + Star$: FOR y = 1 TO Speed: NEXT y: DRAW "c0" + Star$: NEXT x
 IF a + 15 > B - 1 AND a + 15 < B + 31 THEN En2 = En2 - 3
 END IF
IF Proj = 10 THEN
 FOR x = 313 TO 3 STEP -4: Star$ = "bm" + STR$(x) + "," + STR$(B + 17) + "bu2e1u1d1f1r1l1g1d1u1h1l1": DRAW "c10" + Star$: FOR y = 1 TO Speed: NEXT y: DRAW "c0" + Star$: NEXT x
 IF B + 15 > a - 1 AND B + 15 < a + 31 THEN En1 = En1 - 3
 END IF

IF Proj = 11 THEN
 FOR x = 8 TO 319 STEP 4: Star$ = "bm" + STR$(x) + "," + STR$(a + 15) + "h2f1g2e1f2h1e2": DRAW "c11" + Star$: FOR y = 1 TO Speed: NEXT y: DRAW "c0" + Star$: NEXT x
 IF a + 15 > B - 1 AND a + 15 < B + 31 THEN En2 = En2 - 2: SOUND 200, .5: SOUND 10000, 1: IF Frozen2 = 0 THEN Frozen2 = 50: Net2 = 0: Scream2 = 0 ELSE Frozen2 = 0: Frozen1 = 50: Refreeze = 10
 END IF
IF Proj = 12 THEN
 FOR x = 311 TO 0 STEP -4: Star$ = "bm" + STR$(x) + "," + STR$(B + 15) + "e2g1f2h1g2e1h2": DRAW "c11" + Star$: FOR y = 1 TO Speed: NEXT y: DRAW "c0" + Star$: NEXT x
 IF B + 15 > a - 1 AND B + 15 < a + 31 THEN En1 = En1 - 2: SOUND 200, .5: SOUND 10000, 1: IF Frozen1 = 0 THEN Frozen1 = 50: Net1 = 0: Scream1 = 0 ELSE Frozen1 = 0: Frozen2 = 50: Refreeze = 10
 END IF

IF Proj = 13 THEN
 FOR j = 0 TO 5: FOR x = 3 TO 315 STEP 20: LINE (x, a + 17 - j)-(x + 10, a + 12 + j), 10: LINE (x + 10, a + 12 + j)-(x + 20, a + 17 - j), 10: NEXT x: FOR y = 1 TO Speed * 2: NEXT y: FOR x = 3 TO 315 STEP 20: LINE (x, a + 17 - j)-(x + 10, a + 12 + j), 0: LINE (x + 10, a + 12 + j)-(x + 20, a + 17 - j), 0: NEXT x: NEXT j
 IF a + 15 > B - 1 AND a + 15 < B + 31 THEN En2 = En2 - 7
 END IF
IF Proj = 14 THEN
 FOR j = 0 TO 5: FOR x = 316 TO 3 STEP -20: LINE (x, B + 17 - j)-(x - 10, B + 12 + j), 10: LINE (x - 10, B + 12 + j)-(x - 20, B + 17 - j), 10: NEXT x: FOR y = 1 TO Speed * 2: NEXT y: FOR x = 316 TO 3 STEP -20: LINE (x, B + 17 - j)-(x - 10, B + 12 + j), 0: LINE (x - 10, B + 12 + j)-(x - 20, B + 17 - j), 0: NEXT x: NEXT j
 IF B + 15 > a - 1 AND B + 15 < a + 31 THEN En1 = En1 - 7
 END IF

IF Proj = 15 THEN
 Name$ = "h2f1g2e1f2h1e2"
 n = 0: FOR x = 8 TO 319 STEP 4: n = x \ 4: Star$ = "bm" + STR$(x) + "," + STR$(a + 14) + Name$ + "bl1bu" + STR$(n) + Name$ + "bd3bl1bd" + STR$(n * 2) + Name$: DRAW "c11" + Star$: FOR y = 1 TO Speed: NEXT y: DRAW "c0" + Star$: NEXT x
 IF a + 15 > B - 1 AND a + 15 < B + 31 OR a + 15 - n > B - 1 AND a + 15 - n < B + 31 OR a + 15 + n > B - 1 AND a + 15 + n < B + 31 THEN En2 = En2 - 1: SOUND 200, .5: SOUND 10000, 1: IF Frozen2 = 0 THEN Frozen2 = 30: Net2 = 0: Scream2 = 0 ELSE Frozen2 = 0: Frozen1 = 30: Refreeze = 10
 END IF
IF Proj = 16 THEN
 Name$ = "e2g1f2h1g2e1h2"
 j = 8: FOR x = 311 TO 0 STEP -4: j = j + 4: n = j / 4: Star$ = "bm" + STR$(x) + "," + STR$(B + 14) + Name$ + "br1bu" + STR$(n) + Name$ + "bd3br1bd" + STR$(n * 2) + Name$: DRAW "c11" + Star$: FOR y = 1 TO Speed: NEXT y: DRAW "c0" + Star$: NEXT x
 IF B + 15 > a - 1 AND B + 15 < a + 31 OR B + 15 - n > a - 1 AND B + 15 - n < a + 31 OR B + 15 + n > a - 1 AND B + 15 + n < a + 31 THEN En1 = En1 - 1: SOUND 200, .5: SOUND 10000, 1: IF Frozen1 = 0 THEN Frozen1 = 30: Net1 = 0: Scream1 = 0 ELSE Frozen1 = 0: Frozen2 = 30: Refreeze = 10
 END IF

IF Proj = 17 THEN
 FOR x = 2 TO c - 2 STEP 2: PSET (x - 1, d), 5: LINE (x, d)-(x, d - 3), 5: LINE (x, d - 3)-(x + 3, d - 3), 5: LINE (x, d)-(x, d + 3), 5: LINE (x, d + 3)-(x + 3, d + 3), 5: LINE (x, d)-(x, d - 3), 0: LINE (x, d - 3)-(x + 3, d - 3), 0: LINE (x, d)-(x, d + 3), 0: LINE (x, d + 3)-(x + 3, d + 3), 0: NEXT: SCREEN 7, 0, 1, 0: CIRCLE (c, d), 2, 0: PSET (c - 1, d - 1), 0: SCREEN 7, 0, 0, 0
 FOR x = c - 2 TO 2 STEP -1: CIRCLE (c, d), 2, Col1: PSET (c - 1, d - 1), Col2: LINE (x, d)-(x, d - 3), 5: LINE (x, d - 3)-(x + 3, d - 3), 5: LINE (x, d)-(x, d + 3), 5: LINE (x, d + 3)-(x + 3, d + 3), 5: LINE (x, d)-(x, d - 3), 0: LINE (x, d - 3)-(x + 3, d - 3), 0: LINE (x, d)-(x, d + 3), 0: LINE (x, d + 3)-(x + 3, d + 3), 0: CIRCLE (c, d), 2, 0: PSET (c - 1, d - 1), 0: c = c - 1: NEXT
 END IF
IF Proj = 18 THEN
 FOR x = 317 TO c + 2 STEP -2: PSET (x + 1, d), 5: LINE (x, d)-(x, d - 3), 5: LINE (x, d - 3)-(x - 3, d - 3), 5: LINE (x, d)-(x, d + 3), 5: LINE (x, d + 3)-(x - 3, d + 3), 5: LINE (x, d)-(x, d - 3), 0: LINE (x, d - 3)-(x - 3, d - 3), 0: LINE (x, d)-(x, d + 3), 0: LINE (x, d + 3)-(x - 3, d + 3), 0: NEXT: SCREEN 7, 0, 1, 0: CIRCLE (c, d), 2, 0: PSET (c - 1, d - 1), 0: SCREEN 7, 0, 0, 0
 FOR x = c + 2 TO 317: CIRCLE (c, d), 2, Col1: PSET (c - 1, d - 1), Col2: LINE (x, d)-(x, d - 3), 5: LINE (x, d - 3)-(x - 3, d - 3), 5: LINE (x, d)-(x, d + 3), 5: LINE (x, d + 3)-(x - 3, d + 3), 5: LINE (x, d)-(x, d - 3), 0: LINE (x, d - 3)-(x - 3, d - 3), 0: LINE (x, d)-(x, d + 3), 0: LINE (x, d + 3)-(x - 3, d + 3), 0: CIRCLE (c, d), 2, 0: PSET (c - 1, d - 1), 0: c = c + 1: NEXT
 END IF

IF Proj = 19 THEN
 FOR x = 21 TO 313 STEP 7: CIRCLE (x, a + 15), 4, 11: LINE (x - 9, a + 15)-(x, a + 14), 11: LINE (x - 9, a + 15)-(x, a + 16), 11: PAINT (x, a + 15), 15, 11: PAINT (x - 5, a + 15), 9, 11: FOR y = 1 TO Speed * 2: NEXT y: LINE (x - 9, a + 15)-(x, a + 14), 0: LINE (x - 9, a + 15)-(x, a + 16), 0: PAINT (x, a + 15), 0: CIRCLE (x, a + 15), 4, 0: NEXT x
 IF a + 15 > B - 1 AND a + 15 < B + 31 THEN En2 = En2 - 5: SOUND 200, .5: SOUND 10000, 1: IF Frozen2 = 0 THEN Frozen2 = 50: Net2 = 0: Scream2 = 0 ELSE Frozen2 = 0: Frozen1 = 50: Refreeze = 10
 END IF
IF Proj = 20 THEN
 FOR x = 297 TO 6 STEP -7: CIRCLE (x, B + 15), 4, 11: LINE (x + 9, B + 15)-(x, B + 12), 11: LINE (x + 9, B + 15)-(x, B + 18), 11: PAINT (x, B + 15), 15, 11: PAINT (x + 5, B + 15), 9, 11: FOR y = 1 TO Speed * 2: NEXT y: LINE (x + 9, B + 15)-(x, B + 12), 0: LINE (x + 9, B + 15)-(x, B + 18), 0: PAINT (x, B + 15), 0: CIRCLE (x, B + 15), 4, 0: NEXT x
 IF B + 15 > a - 1 AND B + 15 < a + 31 THEN En1 = En1 - 5: SOUND 200, .5: SOUND 10000, 1: IF Frozen1 = 0 THEN Frozen1 = 50: Net1 = 0: Scream1 = 0 ELSE Frozen1 = 0: Frozen2 = 50: Refreeze = 10
 END IF

IF Proj = 21 OR Proj = 35 OR Proj = 37 THEN FOR x = 0 TO 5: PSET (1, a + 15 + x), 0: PSET (1, a + 15 - x), 0: FOR y = 1 TO Speed * 4: NEXT y: NEXT x
IF Proj = 22 OR Proj = 36 OR Proj = 38 OR Proj = 49 THEN FOR x = 0 TO 5: PSET (318, B + 15 + x), 0: PSET (318, B + 15 - x), 0: FOR y = 1 TO Speed * 4: NEXT y: NEXT x

IF Proj = 21 THEN
 FOR x = 21 TO 313 STEP 8: CIRCLE (x, a + 15), 5, 1: LINE (x - 19, a + 15)-(x, a + 13), 1: LINE (x - 19, a + 15)-(x, a + 17), 1: PAINT (x, a + 15), 13, 1: PAINT (x - 6, a + 15), 5, 1: FOR y = 1 TO Speed * 2: NEXT y: LINE (x - 19, a + 15)-(x, a + 13), 0: LINE (x - 19, a + 15)-(x, a + 17), 0: PAINT (x, a + 15), 0: CIRCLE (x, a + 15), 5, 0: NEXT x
 IF a + 15 > B - 1 AND a + 15 < B + 31 THEN En2 = En2 - 7
 END IF
IF Proj = 22 THEN
 FOR x = 297 TO 6 STEP -8: CIRCLE (x, B + 15), 5, 1: LINE (x + 20, B + 15)-(x, B + 13), 1: LINE (x + 20, B + 15)-(x, B + 17), 1: PAINT (x, B + 15), 13, 1: PAINT (x + 6, B + 15), 5, 1: FOR y = 1 TO Speed * 2: NEXT y: LINE (x + 20, B + 15)-(x, B + 13), 0: LINE (x + 20, B + 15)-(x, B + 17), 0: PAINT (x, B + 15), 0: CIRCLE (x, B + 15), 5, 0: NEXT x
 IF B + 15 > a - 1 AND B + 15 < a + 31 THEN En1 = En1 - 7
 END IF

IF Proj = 23 THEN n = 13: FOR x = 49 TO 2 STEP -2: n = n - .5: PSET (x, a + 15), 4: PSET (x, a + 15 - n), 4: PSET (x, a + 15 + n), 4: FOR y = 1 TO Speed * 2: NEXT y: PSET (x, a + 15), 0: PSET (x, a + 15 - n), 0: PSET (x, a + 15 + n), 0: NEXT x
IF Proj = 24 THEN n = 13: FOR x = 270 TO 317 STEP 2: n = n - .5: PSET (x, B + 15), 4: PSET (x, B + 15 - n), 4: PSET (x, B + 15 + n), 4: FOR y = 1 TO Speed * 2: NEXT y: PSET (x, B + 15), 0: PSET (x, B + 15 - n), 0: PSET (x, B + 15 + n), 0: NEXT x

IF Proj = 25 THEN
 FOR x = 21 TO 313 STEP 7: CIRCLE (x, a + 15), 4, 6: LINE (x - 9, a + 15)-(x, a + 14), 6: LINE (x - 9, a + 15)-(x, a + 16), 6: PAINT (x, a + 15), 4, 6: PAINT (x - 5, a + 15), 4, 6: FOR y = 1 TO Speed * 2: NEXT y: LINE (x - 9, a + 15)-(x, a + 14), 0: LINE (x - 9, a + 15)-(x, a + 16), 0: PAINT (x, a + 15), 0: CIRCLE (x, a + 15), 4, 0: NEXT x
 IF a + 15 > B - 1 AND a + 15 < B + 31 THEN En2 = En2 - 7
 END IF
IF Proj = 26 THEN
 FOR x = 297 TO 6 STEP -7: CIRCLE (x, B + 15), 4, 6: LINE (x + 9, B + 15)-(x, B + 12), 6: LINE (x + 9, B + 15)-(x, B + 18), 6: PAINT (x, B + 15), 4, 6: PAINT (x + 5, B + 15), 4, 6: FOR y = 1 TO Speed * 2: NEXT y: LINE (x + 9, B + 15)-(x, B + 12), 0: LINE (x + 9, B + 15)-(x, B + 18), 0: PAINT (x, B + 15), 0: CIRCLE (x, B + 15), 4, 0: NEXT x
 IF B + 15 > a - 1 AND B + 15 < a + 31 THEN En1 = En1 - 7
 END IF

IF Proj = 27 THEN n = 0: FOR x = 2 TO 49 STEP 2: n = n + .5: PSET (x, a + 15), 4: PSET (x, a + 15 - n), 4: PSET (x, a + 15 + n), 4: FOR y = 1 TO Speed * 2: NEXT y: PSET (x, a + 15), 0: PSET (x, a + 15 - n), 0: PSET (x, a + 15 + n), 0: NEXT x
IF Proj = 28 THEN n = 0: FOR x = 317 TO 270 STEP -2: n = n + .5: PSET (x, B + 15), 4: PSET (x, B + 15 - n), 4: PSET (x, B + 15 + n), 4: FOR y = 1 TO Speed * 2: NEXT y: PSET (x, B + 15), 0: PSET (x, B + 15 - n), 0: PSET (x, B + 15 + n), 0: NEXT x

IF Proj = 29 THEN
 FOR x = 16 TO 313 STEP 7: CIRCLE (x, a + 15), 2, 6: LINE (x - 5, a + 15)-(x, a + 14), 6: LINE (x - 5, a + 15)-(x, a + 16), 6: PAINT (x, a + 15), 4, 6: PAINT (x - 3, a + 15), 4, 6: FOR y = 1 TO Speed * 2: NEXT y: LINE (x - 5, a + 15)-(x, a + 14), 0: LINE (x - 5, a + 15)-(x, a + 16), 0: PAINT (x, a + 15), 0: CIRCLE (x, a + 15), 2, 0: NEXT x
 IF a + 15 > B - 1 AND a + 15 < B + 31 THEN En2 = En2 - 3
 END IF
IF Proj = 30 THEN
 FOR x = 303 TO 6 STEP -7: CIRCLE (x, B + 15), 2, 6: LINE (x + 5, B + 15)-(x, B + 13), 6: LINE (x + 5, B + 15)-(x, B + 17), 6: PAINT (x, B + 15), 4, 6: PAINT (x + 3, B + 15), 4, 6: FOR y = 1 TO Speed * 2: NEXT y: LINE (x + 5, B + 15)-(x, B + 13), 0: LINE (x + 5, B + 15)-(x, B + 17), 0: PAINT (x, B + 15), 0: CIRCLE (x, B + 15), 2, 0: NEXT x
 IF B + 15 > a - 1 AND B + 15 < a + 31 THEN En1 = En1 - 3
 END IF

IF Proj = 31 THEN
 FOR x = 2 TO 318 STEP 4: n = x \ 4: PSET (x, a + 15), 10: PSET (x, a + 15 - n), 10: PSET (x, a + 15 + n), 10: FOR y = 1 TO Speed * 2: NEXT y: PSET (x, a + 15), 0: PSET (x, a + 15 - n), 0: PSET (x, a + 15 + n), 0: NEXT x
 IF a + 15 > B - 1 AND a + 15 < B + 31 OR a + 15 - n > B - 1 AND a + 15 - n < B + 31 OR a + 15 + n > B - 1 AND a + 15 + n < B + 31 THEN En2 = En2 - 4
 END IF
IF Proj = 32 THEN
 n = 2: FOR x = 317 TO 1 STEP -4: n = n + 1: PSET (x, B + 15), 10: PSET (x, B + 15 - n), 10: PSET (x, B + 15 + n), 10: FOR y = 1 TO Speed * 2: NEXT y: PSET (x, B + 15), 0: PSET (x, B + 15 - n), 0: PSET (x, B + 15 + n), 0: NEXT x
 IF B + 15 > a - 1 AND B + 15 < a + 31 OR B + 15 - n > a - 1 AND B + 15 - n < a + 31 OR B + 15 + n > a - 1 AND B + 15 + n < a + 31 THEN En1 = En1 - 4
 END IF

IF Proj = 33 THEN
 FOR x = 2 TO 318 STEP 4: n = x \ 6: PSET (x, a + 15), 10: PSET (x, a + 15 - n), 10: PSET (x, a + 15 + n), 10: FOR y = 1 TO Speed * 2: NEXT y: PSET (x, a + 15), 0: PSET (x, a + 15 - n), 0: PSET (x, a + 15 + n), 0: NEXT x
 IF a + 15 > B - 1 AND a + 15 < B + 31 OR a + 15 - n > B - 1 AND a + 15 - n < B + 31 OR a + 15 + n > B - 1 AND a + 15 + n < B + 31 THEN En2 = En2 - 4
 END IF
IF Proj = 34 THEN
 n = 2: FOR x = 317 TO 1 STEP -4: n = n + .63: PSET (x, B + 15), 10: PSET (x, B + 15 - n), 10: PSET (x, B + 15 + n), 10: FOR y = 1 TO Speed * 2: NEXT y: PSET (x, B + 15), 0: PSET (x, B + 15 - n), 0: PSET (x, B + 15 + n), 0: NEXT x
 IF B + 15 > a - 1 AND B + 15 < a + 31 OR B + 15 - n > a - 1 AND B + 15 - n < a + 31 OR B + 15 + n > a - 1 AND B + 15 + n < a + 31 THEN En1 = En1 - 4
 END IF

IF Proj = 35 THEN
 j = 0: FOR x = 2 TO 302 STEP 10
 CIRCLE (x + (x \ 20), a + 15), (x + (x \ 6)) \ 21, 13, , , 3: CIRCLE (x + (x \ 10), a + 15), (x + (x \ 3)) \ 21, 13, , , 3: CIRCLE (x, a + 15), x \ 21, 13, , , 3
 j = j + 1: IF j = 4 THEN j = 0
 IF a + 15 > B - 1 AND a + 15 < B + 31 THEN IF j = 0 THEN LINE (318, B)-(319, B + 30), 0, B: LINE (318, B + 2)-(319, B + 32), Paddle2, B ELSE IF j = 2 THEN LINE (318, B + 2)-(319, B + 32), 0, B: LINE (318, B)-(319, B + 30), Paddle2, B
 FOR y = 1 TO Speed * 4: NEXT y
 CIRCLE (x + (x \ 20), a + 15), (x + (x \ 6)) \ 21, 0, , , 3: CIRCLE (x + (x \ 10), a + 15), (x + (x \ 3)) \ 21, 0, , , 3: CIRCLE (x, a + 15), x \ 21, 0, , , 3
 NEXT x
 IF a + 15 > B - 1 AND a + 15 < B + 31 THEN En2 = En2 - 1: Scream2 = 20: Frozen2 = 0: Net2 = 0
 END IF
IF Proj = 36 THEN
 j = 0: FOR x = 317 TO 17 STEP -10
 CIRCLE (x - (319 - x) \ 20, B + 15), (319 - (x - (319 - x) \ 6)) \ 21, 13, , , 3: CIRCLE (x - (319 - x) \ 10, B + 15), (319 - (x - (319 - x) \ 3)) \ 21, 13, , , 3: CIRCLE (x, B + 15), (319 - x) \ 21, 13, , , 3
 j = j + 1: IF j = 4 THEN j = 0
 IF B + 15 > a - 1 AND B + 15 < a + 31 THEN IF j = 0 THEN LINE (0, a)-(1, a + 30), 0, B: LINE (0, a + 2)-(1, a + 32), Paddle1, B ELSE IF j = 2 THEN LINE (0, a + 2)-(1, a + 32), 0, B: LINE (0, a)-(1, a + 30), Paddle1, B
 FOR y = 1 TO Speed * 4: NEXT y
 CIRCLE (x - (319 - x) \ 20, B + 15), (319 - (x - (319 - x) \ 6)) \ 21, 0, , , 3: CIRCLE (x - (319 - x) \ 10, B + 15), (319 - (x - (319 - x) \ 3)) \ 21, 0, , , 3: CIRCLE (x, B + 15), (319 - x) \ 21, 0, , , 3
 NEXT x
 IF B + 15 > a - 1 AND B + 15 < a + 31 THEN En1 = En1 - 1: Scream1 = 20: Frozen1 = 0: Net1 = 0
 END IF

IF Proj = 37 THEN
 j = 15: q = 5: n = 9
 FOR x = 8 TO 309 STEP 7
 LINE (x, a + 15)-(x + 10, a + j), 2: LINE (x, a + 15)-(x + 10, a + 10 + q), 2
 LINE (x, a + 15)-(x + 10, a + 15), 2: LINE (x, a + 15)-(x + 10, a + 20 - q), 2
 LINE (x, a + 15)-(x + 10, a + 30 - j), 2: LINE (x + 7, a + 6 + n)-(x + 7, a + 24 - n), 2
 FOR y = 1 TO Speed * 2: NEXT y
 LINE (x, a + 15)-(x + 10, a + j), 0: LINE (x, a + 15)-(x + 10, a + 10 + q), 0
 LINE (x, a + 15)-(x + 10, a + 15), 0: LINE (x, a + 15)-(x + 10, a + 20 - q), 0
 LINE (x, a + 15)-(x + 10, a + 30 - j), 0: LINE (x + 7, a + 6 + n)-(x + 7, a + 24 - n), 0
 j = j - .34651145#: q = q - .115: n = n - .207
 NEXT x
 IF a = B THEN En2 = En2 - 1: Net2 = 20: Frozen2 = 0: Scream2 = 0
 END IF
IF Proj = 38 THEN
 j = 15: q = 5: n = 9
 FOR x = 311 TO 10 STEP -7
 LINE (x, B + 15)-(x - 10, B + j), 2: LINE (x, B + 15)-(x - 10, B + 10 + q), 2
 LINE (x, B + 15)-(x - 10, B + 15), 2: LINE (x, B + 15)-(x - 10, B + 20 - q), 2
 LINE (x, B + 15)-(x - 10, B + 30 - j), 2: LINE (x - 7, B + 6 + n)-(x - 7, B + 24 - n), 2
 FOR y = 1 TO Speed * 2: NEXT y
 LINE (x, B + 15)-(x - 10, B + j), 0: LINE (x, B + 15)-(x - 10, B + 10 + q), 0
 LINE (x, B + 15)-(x - 10, B + 15), 0: LINE (x, B + 15)-(x - 10, B + 20 - q), 0
 LINE (x, B + 15)-(x - 10, B + 30 - j), 0: LINE (x - 7, B + 6 + n)-(x - 7, B + 24 - n), 0
 j = j - .34651145#: q = q - .115: n = n - .207
 NEXT x
 IF a = B THEN En1 = En1 - 1: Net1 = 20: Frozen1 = 0: Scream1 = 0
 END IF

IF Proj = 39 THEN
 Name$ = "h2f1g2e1f2h1e2"
 n = 0: FOR x = 8 TO 319 STEP 4: n = x \ 6: Star$ = "bm" + STR$(x) + "," + STR$(a + 14) + Name$ + "bl1bu" + STR$(n) + Name$ + "bd3bl1bd" + STR$(n * 2) + Name$: DRAW "c11" + Star$: FOR y = 1 TO Speed: NEXT y: DRAW "c0" + Star$: NEXT x
 IF a + 15 > B - 1 AND a + 15 < B + 31 OR a + 15 - n > B - 1 AND a + 15 - n < B + 31 OR a + 15 + n > B - 1 AND a + 15 + n < B + 31 THEN En2 = En2 - 1: SOUND 200, .5: SOUND 10000, 1: IF Frozen2 = 0 THEN Frozen2 = 30: Net2 = 0: Scream2 = 0 ELSE Frozen2 = 0: Frozen1 = 30: Refreeze = 10
 END IF
IF Proj = 40 THEN
 Name$ = "e2g1f2h1g2e1h2"
 j = 8: FOR x = 311 TO 0 STEP -4: j = j + 4: n = j \ 6: Star$ = "bm" + STR$(x) + "," + STR$(B + 14) + Name$ + "br1bu" + STR$(n) + Name$ + "bd3br1bd" + STR$(n * 2) + Name$: DRAW "c11" + Star$: FOR y = 1 TO Speed: NEXT y: DRAW "c0" + Star$: NEXT x
 IF B + 15 > a - 1 AND B + 15 < a + 31 OR B + 15 - n > a - 1 AND B + 15 - n < a + 31 OR B + 15 + n > a - 1 AND B + 15 + n < a + 31 THEN En1 = En1 - 1: SOUND 200, .5: SOUND 10000, 1: IF Frozen1 = 0 THEN Frozen1 = 30: Net1 = 0: Scream1 = 0 ELSE Frozen1 = 0: Frozen2 = 30: Refreeze = 10
 END IF

IF Proj = 47 THEN
 FOR x = 7 TO 317 STEP 4: Star$ = "bm" + STR$(x) + "," + STR$(a + 16) + "u2l2d2r1l1d2r1l1u2l1u3r2": DRAW "c13" + Star$: FOR y = 1 TO Speed: NEXT y: DRAW "c0" + Star$: NEXT x
 IF a + 15 > B - 1 AND a + 15 < B + 31 THEN En2 = En2 - 7
 END IF
IF Proj = 48 THEN
 FOR x = 312 TO 2 STEP -4: Star$ = "bm" + STR$(x) + "," + STR$(B + 16) + "u2r2d2l1r1d2l1r1u2r1u3l2": DRAW "c13" + Star$: FOR y = 1 TO Speed: NEXT y: DRAW "c0" + Star$: NEXT x
 IF B + 15 > a - 1 AND B + 15 < a + 31 THEN En1 = En1 - 7
 END IF

IF Proj = 50 THEN
 Name$ = "u2r2d2l1r1d2l1r1u2r1u3l2"
 j = 8: FOR x = 311 TO 0 STEP -4: j = j + 4: n = j / 4: Star$ = "bm" + STR$(x) + "," + STR$(B + 16) + Name$ + "bl1bu" + STR$(n) + Name$ + "bl1bd9bd" + STR$(n * 2) + Name$: DRAW "c7" + Star$: FOR y = 1 TO Speed: NEXT y: DRAW "c0" + Star$: NEXT x
 IF B + 15 > a - 1 AND B + 15 < a + 31 OR B + 15 - n > a - 1 AND B + 15 - n < a + 31 OR B + 15 + n > a - 1 AND B + 15 + n < a + 31 THEN En1 = En1 - 7
 END IF

Proj = 0

END SUB

SUB SmallWrite (Word$, Name$)

Name$ = ""

FOR x = 1 TO LEN(Word$)
a$ = MID$(Word$, x, 1)
B$ = ""
IF a$ = " " THEN B$ = "br3"
IF a$ = "A" THEN B$ = "u3e1f1d1l1r1d2br2"
IF a$ = "B" THEN B$ = "u4r1f1g1f1g1br3"
IF a$ = "C" THEN B$ = "u4r1l1d4r1br2"
IF a$ = "D" THEN B$ = "u4r1f1d2g1br3"
IF a$ = "E" THEN B$ = "u4r1l1d2r1l1d2r1br2"
IF a$ = "F" THEN B$ = "u4r1l1d2r1l1d2br3"
IF a$ = "G" THEN B$ = "u4r3l3d4r3u2l1r1d2br2"
IF a$ = "H" THEN B$ = "u4d2r2u2d4br2"
IF a$ = "I" THEN B$ = "u4d4br2"
IF a$ = "J" THEN B$ = "u1d1r2u4d4br2"
IF a$ = "K" THEN B$ = "u4d2e2g2f2br2"
IF a$ = "L" THEN B$ = "u4d4r1br2"
IF a$ = "M" THEN B$ = "u4f2e2d4br2"
IF a$ = "N" THEN B$ = "u4d1f3u4d4br2"
IF a$ = "O" OR a$ = "0" THEN B$ = "u4r2d4l1br3"
IF a$ = "P" THEN B$ = "u4r2d2l2d2br4"
IF a$ = "Q" THEN B$ = "u4r2d4h1f1d1u1l1br3"
IF a$ = "R" THEN B$ = "u4r1f1g1d1f1br2"
IF a$ = "S" THEN B$ = "r2u2l2u2r2bd4br2"
IF a$ = "T" THEN B$ = "br1u4l1r2bd4br2"
IF a$ = "U" THEN B$ = "u4d4r2u4bd4br2"
IF a$ = "V" THEN B$ = "br1h1u3d3f1e1u3bd4br2"
IF a$ = "W" THEN B$ = "u4d4e2f2u4bd4br2"
IF a$ = "X" THEN B$ = "u1e2u1d1g1f1d1u1h2u1bd4br4"
IF a$ = "Y" THEN B$ = "br1u3h1f1e1bd4br2"
IF a$ = "Z" THEN B$ = "r2l2u1e2u1l2bd4br4"
IF a$ = "1" THEN B$ = "u4d4br2"
IF a$ = "2" THEN B$ = "r2l2e2u1h1g1bd3br4"
IF a$ = "3" THEN B$ = "r1e1h1l1r1e1h1l1bd4br4"
IF a$ = "4" THEN B$ = "br2u4g2d1r2d1br2"
IF a$ = "5" THEN B$ = "r2e1h1l2u2r3bd4br2"
IF a$ = "6" THEN B$ = "u4d4r2u2l2r2d2br2"
IF a$ = "7" THEN B$ = "u1e2u1l2bd4br4"
IF a$ = "8" THEN B$ = "br1h1e1r1e1h1l1g1f1r1f1g1br3"
IF a$ = "9" THEN B$ = "br2u2l2u2r2d4br2"
IF a$ = "/" THEN B$ = "e4bd4br2"
IF a$ = "%" THEN B$ = "bu1e2g1h1u1d1f2d1br2"
IF a$ = "!" THEN B$ = "u1bu3d1bd3br2"
IF a$ = "?" THEN B$ = "br1r1bu2l1r1u2l2bd4br4"
IF a$ = "." THEN B$ = "u1d1br2"
IF a$ = "-" THEN B$ = "bu2r2bd2br2"
IF a$ = "'" THEN B$ = "bu4d1bd3br2"
Name$ = Name$ + B$
NEXT x

END SUB

SUB Title

1
FOR x = 1 TO 5000: NEXT x
Word$ = "REALM PRODUCTIONS PRESENTS": CALL BigWrite(Word$, Name$)
DRAW "bm8,104c8" + Name$: FOR y = 1 TO 500: NEXT y: DRAW "bm8,105c8" + Name$: FOR y = 1 TO 500: NEXT y: DRAW "bm8,105c7" + Name$: FOR y = 1 TO 500: NEXT y: DRAW "bm8,105c15" + Name$: FOR y = 1 TO 7000: NEXT y: DRAW "bm8,105c7" + Name$: FOR y = 1 TO 500: NEXT y: DRAW "bm8,105c8" + Name$: FOR y = 1 TO 500: NEXT y: DRAW "bm8,105c0" + Name$: FOR y = 1 TO 500: NEXT y: DRAW "bm8,104c0" + Name$
FOR x = 1 TO 5000: NEXT x

SCREEN 7, 0, 1, 0: CLS
FOR x = 10 TO 4 STEP -1
Name$ = "s" + STR$(x) + "d10r15d45l15d10r85u10l15u45r15u10l85d10r10br15d45r10u45l10r10br15d45r10u45l10"
DRAW "bm" + STR$(158 - (10 * x)) + "," + STR$(144 - (10 * x)) + "c7" + Name$ + "bm" + STR$(158 - (10 * x)) + "," + STR$(145 - (10 * x)) + "c8" + Name$
PCOPY 1, 0
DRAW "bm" + STR$(158 - (10 * x)) + "," + STR$(144 - (10 * x)) + "c0" + Name$ + "bm" + STR$(158 - (10 * x)) + "," + STR$(145 - (10 * x)) + "c0" + Name$
NEXT x
SCREEN 7, 0, 0, 0

Name$ = "u15r5d10e10r5g15f15l5h10d10l5u15d15br25u30r5d30l5br10u30r5d25r5d5l10br15u30r5d25r5d5l10br15u30r10d5l5d10r5d5l5d5r5d5l10br15u30r5f10g10f10l5h5d5l5r5bu25f5g5u5d5u10bd25br30u30r5d10e10r5g15f15l5h10d10l5br25u30r15d30l15r5bu5r5u20l5d20bd5br15u30f10e10d30l5u15g5h5d15l5br25u30r5f10g5f5d5g5l10r5bu5e5h5d10u10bu10f5l5u5bd30bu5br15u25e5r5f5d25l5u10l5d10l5r5u10bu5r5u10l5d10bd15br20u25l5u5r15d5l5d25l5bd10bl155d30r5u15r5e5u5h5l10d5br5d5r5u5l5bd25br15u30r15d30l15r5bu5r5u20l5d20bd5br15u30r5f10u10r5d30l5h10d10l5br25u30r20d5l15d20r10u5l5u5r10d15l20bd10"
DRAW "bm43,39c7" + Name$ + "bm43,40c8" + Name$

x = 0: Paddle = 0: Victory = 0
DO: a$ = INKEY$
x = x + 1
PRINT CHR$(11);
IF x = 20000 THEN
 x = 0
 Paddle = Paddle + 1
 IF Paddle = 16 THEN Paddle = 1: CLS : GOTO 1
 IF Paddle = 3 OR Paddle = 7 THEN Paddle = Paddle + 1
 CALL Bios(Paddle, Victory)
 END IF
LOOP WHILE a$ = ""

CLS

END SUB

SUB Ultimate

DO: k$ = INKEY$: LOOP WHILE k$ <> ""

SCREEN 7, 0, 1, 0: CLS
Word$ = "ULTIMATE KOMBAT KODE": CALL BigWrite(Word$, Name$)
DRAW "bm43,84c7" + Name$ + "bm43,85c8" + Name$

Name$ = "c8u30r30d30l30r2c7bu2u26r26d26l26"
DRAW "bm45,125" + Name$ + "bm85,125" + Name$ + "bm125,125" + Name$ + "bm165,125" + Name$ + "bm205,125" + Name$ + "bm245,125" + Name$
Name$ = "": Symbol$ = "": Symbol = 0: Kode = 0

DO
DRAW "bm28,117c7" + Name$ + "bm28,118c8" + Name$
PCOPY 1, 0
DO: a$ = INKEY$: LOOP WHILE a$ = ""
IF a$ = "4" THEN Name$ = Name$ + "br28r6e3u9h3l6d3r3d3l3d3r3d3l3d3br12": Symbol = Symbol + 1: Symbol$ = Symbol$ + "@"
IF a$ = "5" THEN Name$ = Name$ + "br30u3r3d3l3bu6u3r3u3l3g3u3e3r6d9l6bd6br10": Symbol = Symbol + 1: Symbol$ = Symbol$ + "3"
IF a$ = "6" THEN Name$ = Name$ + "br28bu3d3r3u3r3d3r3u3e3u6h3l9g3d6f3bu6r3g3u3br9d3h3r3bd9br3": Symbol = Symbol + 1: Symbol$ = Symbol$ + "?"
LOOP WHILE Symbol < 6

DRAW "bm28,117c7" + Name$ + "bm28,118c8" + Name$
PCOPY 1, 0
                                                                                Kode$ = ""
                                                                                FOR x = 12 TO 1 STEP -1
                                                                                IF x = 12 OR x = 10 OR x = 8 OR x = 6 OR x = 2 THEN Kode$ = Kode$ + "3"
                                                                                IF x = 4 OR x = 1 THEN Kode$ = Kode$ + "?"
                                                                                IF x = 11 OR x = 9 OR x = 7 OR x = 5 OR x = 3 THEN Kode$ = Kode$ + "@"
                                                                                NEXT x
IF Symbol$ = MID$(Kode$, 7, 6) THEN AI = 1: Paddle2 = 0: Kode = 20: Correct = 1
IF Symbol$ = MID$(Kode$, 1, 6) THEN Kode = 21: Correct = 1

IF Correct = 1 THEN Correct = 0: FOR x = 1 TO 3: COLOR 0, 15: FOR y = 1 TO Speed * 10: NEXT y: COLOR 0, 0: FOR y = 1 TO Speed * 10: NEXT y: NEXT x
DO: a$ = INKEY$: LOOP WHILE a$ = ""

END SUB

SUB Update (Fight, Flash, Time, Paddle1$, Paddle2$, Px)
  
IF En1 < 1 THEN En1 = 0
IF En2 < 1 THEN En2 = 0

IF En1 = 0 OR En2 = 0 THEN
 Word$ = "FINISH H"
 IF (Paddle1 = 9 OR Paddle1 = 10) AND En1 = 0 AND Shift1 = 0 OR (Paddle2 = 9 OR Paddle2 = 10) AND En2 = 0 AND Shift2 = 0 THEN Word$ = Word$ + "ER!" ELSE Word$ = Word$ + "IM!"
 CALL BigWrite(Word$, Name$)
 DRAW "bm100,99c12" + Name$ + "bm100,100c4" + Name$
 Time = Time + 1
 IF Paddle2 = 7 THEN Time = 30
 END IF

IF Fatal > 0 OR Baby > 0 OR Friend > 0 OR Anim > 0 OR Mercy > 0 OR Time = 30 THEN DRAW "bm100,99c0" + Name$ + "bm100,100c0" + Name$

LINE (1, 1)-(En1, 3), 10, BF: LINE (En1 + 1, 1)-(40, 3), 4, BF
LINE (318, 1)-(319 - En2, 3), 10, BF: LINE (318 - En2, 1)-(279, 3), 4, BF
LINE (0, 0)-(41, 4), 2, B: LINE (278, 0)-(319, 4), 2, B
DRAW "bm0,11c14" + Paddle1$ + "bm" + STR$(286 + Px) + ",11c14" + Paddle2$

LINE (0, a)-(1, a + 30), Paddle1, B
LINE (318, B)-(319, B + 30), Paddle2, B
IF Frozen1 > 0 THEN LINE (0, a)-(0, a + 30), 11: LINE (1, a)-(1, a + 30), 3
IF Frozen2 > 0 THEN LINE (318, B)-(318, B + 30), 3: LINE (319, B)-(319, B + 30), 11
IF Inv1 > 0 THEN LINE (0, a)-(1, a + 30), 0, B
IF Inv2 > 0 THEN LINE (318, B)-(319, B + 30), 0, B
IF Fatal = 0 AND Baby = 0 AND Friend = 0 AND Anim = 0 AND Time < 30 THEN
 IF Scream1 > 0 THEN IF Flash = 1 THEN LINE (0, a)-(1, a + 30), 0, B: LINE (0, a + 2)-(1, a + 32), Paddle1, B
 IF Scream2 > 0 THEN IF Flash = 1 THEN LINE (318, B)-(319, B + 30), 0, B: LINE (318, B + 2)-(319, B + 32), Paddle2, B
 IF Net1 > 0 AND Shock = 0 THEN LINE (10, a + 15)-(0, a), 2: LINE (10, a + 15)-(0, a + 10), 2: LINE (10, a + 15)-(0, a + 15), 2: LINE (10, a + 15)-(0, a + 20), 2: LINE (10, a + 15)-(0, a + 30), 2: LINE (3, a + 6)-(3, a + 24), 2
 IF Net2 > 0 AND Shock = 0 THEN LINE (309, B + 15)-(319, B), 2: LINE (309, B + 15)-(319, B + 10), 2: LINE (309, B + 15)-(319, B + 15), 2: LINE (309, B + 15)-(319, B + 20), 2: LINE (309, B + 15)-(319, B + 30), 2: LINE (316, B + 6)-(316, B + 24), 2
 IF Net1 > 0 AND Shock = 1 THEN LINE (10, a + 15)-(0, a), 10: LINE (10, a + 15)-(0, a + 10), 10: LINE (10, a + 15)-(0, a + 15), 10: LINE (10, a + 15)-(0, a + 20), 10: LINE (10, a + 15)-(0, a + 30), 10: LINE (3, a + 6)-(3, a + 24), 10: En1 = En1 - 1: Shock = 0
 IF Net2 > 0 AND Shock = 2 THEN LINE (309, B + 15)-(319, B), 10: LINE (309, B + 15)-(319, B + 10), 10: LINE (309, B + 15)-(319, B + 15), 10: LINE (309, B + 15)-(319, B + 20), 10: LINE (309, B + 15)-(319, B + 30), 10: LINE (316, B + 6)-(316, B + 24), 10: En2 = En2 - 1: Shock = 0
 END IF

IF BallType <> 1 AND BallType <> 2 AND BallType <> 5 AND BallType <> 7 AND Fight = 1 THEN CIRCLE (c, d), 2, Col1: PSET (c - 1, d - 1), Col2
IF BallType = 1 THEN CIRCLE (c, d), 2, 11: PSET (c - 1, d - 1), 15
IF BallType = 7 THEN DRAW "c7bm" + STR$(c) + "," + STR$(d) + "d1f1u1r1u2l1u1l1d1u1l1d1l1d2r1d1"
IF BallType = 5 THEN DRAW "c14bm" + STR$(c) + "," + STR$(d) + "u2l1g1d2f1r2e1u2h1l1d2l1r2"
IF BallType = 2 THEN CIRCLE (c, d), 2, 1: PSET (c - 1, d - 1), 9

IF Fatal = 0 AND Baby = 0 AND Friend = 0 AND Anim = 0 AND Time < 30 AND InvisB = 0 THEN
 IF BallType = 6 THEN
  IF Angle = 1 THEN LINE (c - 2, d)-(c - 4, d - 4), 6: LINE (c, d - 2)-(c - 4, d - 4), 6
  IF Angle = 2 THEN LINE (c + 2, d)-(c + 4, d + 4), 6: LINE (c, d + 2)-(c + 4, d + 4), 6
  IF Angle = 3 THEN LINE (c - 2, d)-(c - 4, d + 4), 6: LINE (c, d + 2)-(c - 4, d + 4), 6
  IF Angle = 4 THEN LINE (c + 2, d)-(c + 4, d - 4), 6: LINE (c, d - 2)-(c + 4, d - 4), 6
  CIRCLE (c, d), 2, 6: PAINT (c, d - 1), 4, 6
  END IF
 IF BallType = 3 THEN
  CIRCLE (ShC + (30 - BallTime), ShD + (30 - BallTime)), 2, Col1: PSET (ShC + (30 - BallTime) - 1, ShD + (30 - BallTime) - 1), Col2
  CIRCLE (ShC - (30 - BallTime), ShD - (30 - BallTime)), 2, Col1: PSET (ShC - (30 - BallTime) - 1, ShD - (30 - BallTime) - 1), Col2
  CIRCLE (ShC - (30 - BallTime), ShD + (30 - BallTime)), 2, Col1: PSET (ShC - (30 - BallTime) - 1, ShD + (30 - BallTime) - 1), Col2
  CIRCLE (ShC + (30 - BallTime), ShD - (30 - BallTime)), 2, Col1: PSET (ShC + (30 - BallTime) - 1, ShD - (30 - BallTime) - 1), Col2
  END IF
 END IF

IF BallType = 4 OR Scream1 > 0 OR Scream2 > 0 THEN IF Flash = 0 THEN Flash = 1 ELSE IF Flash = 1 THEN Flash = 0

IF BallType = 4 AND Flash = 1 THEN LINE (c - 3, d - 3)-(c + 3, d + 3), 10: LINE (c + 3, d - 3)-(c - 3, d + 3), 10
IF Fatal > 0 OR Baby > 0 OR Friend > 0 OR Anim > 0 OR Time = 30 OR Bomb > 0 OR InvisB = 1 THEN DRAW "bm" + STR$(c) + "," + STR$(d) + "c0u2l1d1l1d2r1d1r2u1r1u2l1u1d2g1h1": IF BallType = 4 THEN LINE (c - 3, d - 3)-(c + 3, d + 3), 0: LINE (c + 3, d - 3)-(c - 3, d + 3), 0

END SUB

SUB Versus (Battle)

Kode = 0

Battle = Battle + 1

SCREEN 7, 0, 0, 0: CLS
FOR x = 120 TO 20 STEP -20
Name$ = "c8u50r60d50l60r2c7bu2u46r56d46l56"
Star$ = "c0u50r60d50l60r2bu2u46r56d46l56"
DRAW "bm" + STR$(130 - x) + ",60" + Name$ + "bm" + STR$(130 + x) + ",180" + Name$
FOR y = 1 TO Speed * 10: NEXT y
DRAW "bm" + STR$(130 - x) + ",60" + Star$ + "bm" + STR$(130 + x) + ",180" + Star$
NEXT x

DRAW "bm" + STR$(130 - x) + ",60" + Name$ + "bm" + STR$(130 + x) + ",180" + Name$

LINE (159, 20)-(160, 50), Paddle1, B
LINE (159, 140)-(160, 170), Paddle2, B

Word$ = "V"
CALL BigWrite(Word$, Name$)
DRAW "bm148,102c7" + Name$: FOR y = 1 TO Speed * 10: NEXT y
DRAW "bm148,103c8" + Name$: FOR y = 1 TO Speed * 10: NEXT y
DRAW "bm148,103c7" + Name$: FOR y = 1 TO Speed * 10: NEXT y
DRAW "bm148,103c15" + Name$: FOR y = 1 TO Speed * 10: NEXT y
Word$ = "S"
CALL BigWrite(Word$, Name$)
DRAW "bm163,102c7" + Name$: FOR y = 1 TO Speed * 10: NEXT y
DRAW "bm163,103c8" + Name$: FOR y = 1 TO Speed * 10: NEXT y
DRAW "bm163,103c7" + Name$: FOR y = 1 TO Speed * 10: NEXT y
DRAW "bm163,103c15" + Name$: FOR y = 1 TO Speed * 10: NEXT y
Word$ = "VS"
CALL BigWrite(Word$, Name$)
DRAW "bm148,103c7" + Name$: FOR y = 1 TO Speed * 10: NEXT y
DRAW "bm148,103c8" + Name$: FOR y = 1 TO Speed * 100: NEXT y
DRAW "bm148,103c0" + Name$: FOR y = 1 TO Speed * 10: NEXT y
DRAW "bm148,102c0" + Name$: FOR y = 1 TO Speed * 10: NEXT y

Word$ = "BATTLE "

a$ = STR$(Battle)
IF Battle < 10 THEN Word$ = Word$ + "0"
FOR x = 1 TO LEN(a$)
IF MID$(a$, x, 1) <> " " THEN Word$ = Word$ + MID$(a$, x, 1)
NEXT x

CALL BigWrite(Word$, Name$)
DRAW "bm108,102c7" + Name$: FOR y = 1 TO Speed * 10: NEXT y
DRAW "bm108,103c8" + Name$: FOR y = 1 TO Speed * 10: NEXT y
DRAW "bm108,103c7" + Name$: FOR y = 1 TO Speed * 10: NEXT y
DRAW "bm108,103c15" + Name$: FOR y = 1 TO Speed * 10: NEXT y
DRAW "bm108,103c7" + Name$: FOR y = 1 TO Speed * 10: NEXT y
DRAW "bm108,103c8" + Name$: FOR y = 1 TO Speed * 10: NEXT y

FOR y = 1 TO 1000
a$ = INKEY$: IF a$ <> "" THEN DRAW "bm108,103c0" + Name$: FOR y = 1 TO Speed * 10: NEXT y: DRAW "bm108,102c0" + Name$: FOR y = 1 TO Speed * 10: NEXT y: PCOPY 0, 1: CALL Kodes: SCREEN 7, 0, 0, 0: y = 1000
NEXT y

IF a$ = "" THEN DRAW "bm108,103c0" + Name$: FOR y = 1 TO Speed * 10: NEXT y: DRAW "bm108,102c0" + Name$: FOR y = 1 TO Speed * 10: NEXT y
LINE (159, 20)-(160, 50), 0, B: LINE (159, 140)-(160, 170), 0, B

FOR x = 0 TO -120 STEP -20
Name$ = "c8u50r60d50l60r2c7bu2u46r56d46l56"
Star$ = "c0u50r60d50l60r2bu2u46r56d46l56"
DRAW "bm" + STR$(130 - x) + ",60" + Name$ + "bm" + STR$(130 + x) + ",180" + Name$
FOR y = 1 TO Speed * 10: NEXT y
DRAW "bm" + STR$(130 - x) + ",60" + Star$ + "bm" + STR$(130 + x) + ",180" + Star$
NEXT x
SCREEN 7, 0, 1, 0

END SUB

SUB Win

PCOPY 0, 1
IF Shift1 > 0 THEN Paddle1 = 15: Shift1 = 0
IF Shift2 > 0 THEN Paddle2 = 15: Shift2 = 0

j = 22
IF En1 < 1 THEN Paddle = Paddle2
IF En2 < 1 THEN Paddle = Paddle1
IF Paddle = 0 THEN Word$ = "MIDNIGHT": j = 7
IF Paddle = 1 THEN Word$ = "CHILLN"
IF Paddle = 2 THEN Word$ = "SHOCKER": j = 14
IF Paddle = 3 THEN Word$ = "SHARK"
IF Paddle = 4 THEN Word$ = "BLOODBATH": j = 0
IF Paddle = 5 THEN Word$ = "CYBER": j = 26
IF Paddle = 6 THEN Word$ = "ICEPICK"
IF Paddle = 7 THEN Word$ = "SHAO PONG": j = -7
IF Paddle = 8 THEN Word$ = "NINJA"
IF Paddle = 9 THEN Word$ = "BANSHEE": j = 12
IF Paddle = 10 THEN Word$ = "SYLVA"
IF Paddle = 11 THEN Word$ = "GLACIER": j = 16
IF Paddle = 12 THEN Word$ = "BLACKOUT": j = 9
IF Paddle = 13 THEN Word$ = "SPOOK"
IF Paddle = 14 THEN Word$ = "FIREBUG": j = 14
IF Paddle = 15 THEN Word$ = "SHIFTER": j = 16
Word$ = Word$ + " WINS"
CALL BigWrite(Word$, Name$)

DRAW "bm" + STR$(76 + j) + ",84c7" + Name$
FOR x = 1 TO 6
DRAW "bm" + STR$(76 + j) + ",85c15" + Name$
FOR y = 1 TO Speed * 20: NEXT y
DRAW "bm" + STR$(76 + j) + ",85c8" + Name$
FOR y = 1 TO Speed * 20: NEXT y
NEXT x

IF En1 = 40 OR En2 = 40 THEN
 Name$ = "u25r10d5l5d5r5d5l5d10l5br15u25r5d20r5d5l10br15u20e5r5f5d20l5u10l5d10l5r5u10bu10r5d5l5u5bd20br15bu25d20f5e5f5e5u20l5d15h5g5u15l5br25d25r10u5l5u20l5br15d25r10u5l5u5r5u5l5u5r5u5l10d25br15u5r5u5l5u15r10d5l5d5r5d15l10br15u5r5u5l5u15r10d5l5d5r5d15l10"
 DRAW "bm94,118c12" + Name$: FOR x = 1 TO 6: DRAW "bm94,119c14" + Name$: FOR y = 1 TO Speed * 20: NEXT y: DRAW "bm94,119c4" + Name$: FOR y = 1 TO Speed * 20: NEXT y: NEXT x
 END IF

IF Fatal > 0 OR Baby > 0 OR Friend > 0 OR Anim > 0 THEN IF En1 = 40 OR En2 = 40 THEN DRAW "bm94,118c0" + Name$ + "bm94,119c0" + Name$
IF Kode <> 11 AND En1 > 0 AND Hits > 0 AND (Fatal > 0 OR Baby > 0 OR Friend > 0 OR Anim > 0) THEN Word$ = STR$(Hits + 1) + " HITS": CALL BigWrite(Word$, Name$): DRAW "bm112,142c7" + Name$ + "bm112,143c8" + Name$
IF Kode <> 11 AND En2 > 0 AND Hits2 > 0 AND (Fatal > 0 OR Baby > 0 OR Friend > 0 OR Anim > 0) THEN Word$ = STR$(Hits2 + 1) + " HITS": CALL BigWrite(Word$, Name$): DRAW "bm112,142c7" + Name$ + "bm112,143c8" + Name$
IF Fatal > 0 THEN Name$ = "u25r10d5l5d5r5d5l5d10l5r5br10u20e5r5f5d20l5u10l5d10l5br25u20l5u5r15d5l5d20l5br15u20e5r5f5d20l5u10l5d10l5br20u25r5d20r10d5l15br20u25r5d25l5br15u20l5u5r15d5l5d20l5br20u15h5u5f5r5e5d5g5d15l5bl65u10bu5l5u5r5d5bl45u5r5d5l5": DRAW "bm90,118c4" + Name$
IF Baby > 0 THEN Name$ = "u25r10f5g5f5d5g5l10r5bu5r5u5l5d5u5bu10r5g5u5bd20br15u20e5r5f5d20l5u10l5d10l5r5bu15r5u5l5d5br15u10r10f5g5f5d5g5l10u15br5u5r5g5bd10r5u5l5bd5u5bd10br15u20e5r5f5d20l5u10l5d10l5r5u10bu10r5d5l5u5br15u5r5d20r10d5l15u20d20br20u25r5d25l5br15u20l5u5r15d5l5d20l5br20u15h5u5f5r5e5d5g5d15l5": DRAW "bm88,118c2" + Name$
IF Friend > 0 THEN Name$ = "c4u25r10d5l5d5r5d5l5d10l5br15c14u20r10f5d5g5f5d5l5u5h5d10l5u5d5r5bu20r5d5l5u5c2br15u10r5d25l5u15br10bu5r10d5l5d5r5d5l5d5r5d5l10u25c6br15u5r5f10u10r5d25l5h10d10l5u20c5br25d25r10e5u15h5l10bf5d15r5u15l5c14br15u10r15d5l10d5r10d15l15u5r10u5l10u5c1br20u5r5d10r5u10r5d25l5u10l5d10l5u20c2br20u10r5d25l5u15c4br10u5r10f5d5g5l5d10l5u20br5d5r5u5l5": DRAW "bm76,118" + Name$
IF Friend > 0 THEN Star$ = "c0u25r10d5l5d5r5d5l5d10l5br15u20r10f5d5g5f5d5l5u5h5d10l5u5d5r5bu20r5d5l5u5br15u10r5d25l5u15br10bu5r10d5l5d5r5d5l5d5r5d5l10u25br15u5r5f10u10r5d25l5h10d10l5u20br25d25r10e5u15h5l10bf5d15r5u15l5br15u10r15d5l10d5r10d15l15u5r10u5l10u5br20u5r5d10r5u10r5d25l5u10l5d10l5u20br20u10r5d25l5u15br10u5r10f5d5g5l5d10l5u20br5d5r5u5l5"
IF Anim > 0 THEN Name$ = "u20e5r5f5d20l5u10l5d10l5r5u10bu5r5u5l5d5br15u10r5f10u10r5d25l5h10d10l5u15d15br25u25r5d25l5br10u25f10e10d25l5u10g5h5d10l5br25u20e5r5f5d20l5u10l5d10l5r5u10bu5r5u5l5d5br15u10r5d20r10d5l15u15d15br20u25r5d25l5br15u20l5u5r15d5l5d20l5br20u15h5u5f5r5e5d5g5d15l5": DRAW "bm78,118c6" + Name$

DO: k$ = INKEY$: LOOP WHILE k$ <> ""
DO: a$ = INKEY$
IF Paddle2 = 7 AND En2 < 1 THEN a$ = " "
IF Fatal > 0 THEN DRAW "bm90,119c0" + Name$ + "bm90,119c4" + Name$
IF Baby > 0 THEN DRAW "bm88,119c0" + Name$ + "bm88,119c2" + Name$
IF Friend > 0 THEN DRAW "bm76,119" + Star$ + "bm76,119" + Name$
IF Anim > 0 THEN DRAW "bm78,119c0" + Name$ + "bm78,119c6" + Name$
LOOP WHILE a$ = ""

END SUB

