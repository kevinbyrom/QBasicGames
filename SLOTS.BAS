'
'               MichaelSoft Slots v3.5
'                  
'                     ====================      NOTE: If asked to save
'   by                =Press F5 to start.=            loaded file when
'                     ====================            quitting, say NO.
'       Michael       =Press Alt, then F,=
'       Nelson        =then X to quit.   =    See the file SLOTS.DOC
'                     ====================    for complete instructions.
'
'      Revision History:
'      v1.0 - First version.
'      v1.5 - Added $10,000 limit.
'           - Added secret game rigging feature.
'           - Fixed the game so scoreboard didn't have to be redrawn after
'             every spin.
'      v2.0 - Added save and load game features.
'           - Modified game rigging feature.
'           - Added display that tells you what you've won.
'      v3.0 - Rewrote save and load features.
'           - Changed game rigging feature to a different keypress.
'           - Improved event trapping - no more tapping.
'      v3.5 - Added high scores.
'           - Fixed bug from 3.0 that didn't allow N, S, C, A, L, and Q to
'             be typed to describe a saved game.
'           - Changed opening logo.
'           - Added -$10,000 limit.
'           - Fixed minor bug in saved games.
'           - Added speed trap for fast computers so the slots don't stop
'             spinning until the sound is finished.
'
DEF SEG = 0
POKE &H417, (&H0)
LET score = 0
LET hasbeenrigged = 0
LET rig% = 0
SCREEN 7
CLS
GOTO intro
startagain:
IF spinning = 1 THEN RETURN
LET score = 0
LET hasbeenrigged = 0
LET rig% = 0
LOCATE 14, 8
PRINT "    "
LOCATE 14, 8
PRINT score
LOCATE 19, 25
PRINT "            "
LOCATE 3, 25
PRINT "               "
LOCATE 4, 25
PRINT "               "
LOCATE 20, 20
PRINT "               "
RETURN

scoreboard:
PRINT
PRINT "    $1  $2"
PRINT
PRINT "    2   3"
PRINT "    4   6"
PRINT "    4   7"
PRINT "    10  15"
PRINT "    12  17"
PRINT "    14  20"
PRINT "    25  50"
PRINT "    150 350"
PRINT "    500 1000"
PRINT : PRINT " score:"; score: PRINT
COLOR 4: PRINT " C"; : COLOR 15: PRINT "hange "; : COLOR 4: PRINT "N"; : COLOR 15: PRINT "ew"
PRINT " bet    game"
PRINT
COLOR 4: PRINT " S"; : COLOR 15: PRINT "pin   "; : COLOR 4: PRINT "Q"; : COLOR 15: PRINT "uit"
PRINT
PRINT " s"; : COLOR 4: PRINT "A"; : COLOR 15: PRINT "ve   "; : COLOR 4: PRINT "L"; : COLOR 15: PRINT "oad"
PRINT
PRINT " MichaelSoft"
LINE (5, 5)-(100, 195), 7, B
PSET (8, 24)
DRAW "c15r20d6l20u6"
PAINT (9, 25), 15
DRAW scherry$
PSET (8, 32)
DRAW "c15r20d6l20u6"
PAINT (9, 33), 15
DRAW scherry$
DRAW "br4bu2"
DRAW scherry$
PSET (8, 40)
DRAW "c15r20d6l20u6"
PAINT (9, 41), 15
DRAW "br6"
DRAW scherry$
DRAW "br4bu2"
DRAW scherry$
PSET (8, 48)
DRAW "c15r20d6l20u6"
PAINT (9, 49), 15
DRAW scherry$
DRAW "br4bu2"
DRAW scherry$
DRAW "br4bu2"
DRAW scherry$
PSET (8, 56)
DRAW "c15r20d6l20u6"
PAINT (9, 57), 15
DRAW slemon$
DRAW "br4bu1"
DRAW slemon$
DRAW "br4bu1"
DRAW slemon$
PSET (8, 64)
DRAW "c15r20d6l20u6"
PAINT (9, 65), 15
DRAW splum$
DRAW "br4bu1"
DRAW splum$
DRAW "br4bu1"
DRAW splum$
PSET (8, 72)
DRAW "c15r20d6l20u6"
PAINT (9, 73), 15
DRAW sbar$
DRAW "br6bu3"
DRAW sbar$
DRAW "br6bu3"
DRAW sbar$
PSET (8, 80)
DRAW "c15r20d6l20u6"
PAINT (9, 81), 15
DRAW sseven$
DRAW "br5bu4"
DRAW sseven$
DRAW "br5bu4"
DRAW sseven$
PSET (8, 88)
DRAW "c15r20d6l20u6"
PAINT (9, 89), 15
DRAW sm$
DRAW "bu4br2"
DRAW sm$
DRAW "bu4br2"
DRAW sm$
LINE (160, 80)-(281, 121), 7, B
IF bet = 1 THEN LINE (32, 16)-(45, 18), 4, BF
IF bet = 2 THEN LINE (64, 16)-(77, 18), 4, BF
RETURN

intro:
RANDOMIZE TIMER
LET scherry$ = "c2r2d2c4bl1r1d1r1d1l1d1l1u1l1u1r1u1r1"
LET slemon$ = "bd1br1c14r1d1r1d1l1d1l1u1l1u1r1u1r1"
LET splum$ = "bd1br1c5r1d1r1d1l1d1l1u1l1u1r1u1r1"
LET sbar$ = "bd2c0r3d1l3"
LET sseven$ = "c6r3d1g2d1"
LET sm$ = "c2d4u4r2d4u4r2d4"
COLOR 14
PRINT "ÚÂ¿³ÚÄÄ³ ³ÚÄ¿ÚÄÄ³  ÉÍÍÉÍ»ÉÍÍÍËÍ"
PRINT "³³³³³  ÃÄ´ÃÄ´ÃÄ ³  ÈÍ»º ºÌÍ  º "
PRINT "³³³³ÀÄÄ³ ³³ ³ÀÄÄÀÄÄÍÍ¼ÈÍ¼º   º "
PRINT : PRINT : PRINT
COLOR 11
PRINT "ÚÄÄÄÄÄÄ¿ÚÄÄ¿    ÚÄÄÄÄÄÄ¿ÚÄÄÄÄÄÄ¿ÚÄÄÄÄÄÄ¿"
PRINT "³ÛÛÛÛÛÛ³³ÛÛ³    ³ÛÛÛÛÛÛ³³ÛÛÛÛÛÛ³³ÛÛÛÛÛÛ³"
PRINT "³²²ÚÄÄÄÙ³²²³    ³²²Ú¿²²³ÀÄ¿²²ÚÄÙ³²²ÚÄÄÄÙ"
PRINT "³±±³    ³±±³    ³±±³³±±³  ³±±³  ³±±³"
PRINT "³°°ÀÄÄÄ¿³°°³    ³°°³³°°³  ³°°³  ³°°ÀÄÄÄ¿"
PRINT "³Michae³³lS³    ³of³³tS³  ³lo³  ³tsv3.5³"
PRINT "ÀÄÄÄ¿°°³³°°³    ³°°³³°°³  ³°°³  ÀÄÄÄ¿°°³"
PRINT "    ³±±³³±±³    ³±±³³±±³  ³±±³      ³±±³"
PRINT "ÚÄÄÄÙ²²³³²²ÀÄÄÄ¿³²²ÀÙ²²³  ³²²³  ÚÄÄÄÙ²²³"
PRINT "³ÛÛÛÛÛÛ³³ÛÛÛÛÛÛ³³ÛÛÛÛÛÛ³  ³ÛÛ³  ³ÛÛÛÛÛÛ³"
PRINT "ÀÄÄÄÄÄÄÙÀÄÄÄÄÄÄÙÀÄÄÄÄÄÄÙ  ÀÄÄÙ  ÀÄÄÄÄÄÄÙ"
PRINT
COLOR 5
PRINT "     by"; : COLOR 2: PRINT " Michael Nelson"
PRINT
COLOR 12, 0
PRINT "                                  ÍÍ»ÉÍÍ"
PRINT "                                  ÍÍ¹ÈÍ»"
PRINT "                          version ÍÍ¼0Í¼"
SLEEP 10
CLS
COLOR 15
GOSUB scoreboard
GOSUB betisone

betisone:
KEY 15, CHR$(0) + CHR$(46)
KEY 16, CHR$(0) + CHR$(49)
KEY 17, CHR$(0) + CHR$(31)
KEY 18, CHR$(0) + CHR$(16)
KEY 19, CHR$(12) + CHR$(19)
KEY 20, CHR$(0) + CHR$(30)
KEY 21, CHR$(0) + CHR$(38)
LINE (15, 16)-(95, 18), 0, BF
LINE (32, 16)-(45, 18), 4, BF
LET bet = 1
olop:
IF score >= 10000 THEN GOTO tenthousand
IF score <= -10000 THEN GOTO yousuck
KEY(15) ON
KEY(16) ON
KEY(17) ON
KEY(18) ON
KEY(19) ON
KEY(20) ON
KEY(21) ON
ON KEY(15) GOSUB changebet
ON KEY(16) GOSUB startagain
ON KEY(17) GOSUB spin
ON KEY(18) GOSUB finish
ON KEY(19) GOSUB riggame
ON KEY(20) GOSUB savegame
ON KEY(21) GOSUB loadgame
GOTO olop

changebet:
IF spinning = 1 THEN RETURN
IF bet = 1 THEN LINE (15, 16)-(95, 18), 0, BF: LINE (64, 16)-(77, 18), 4, BF: LET bet = 2: RETURN
IF bet = 2 THEN LINE (15, 16)-(95, 18), 0, BF: LINE (32, 16)-(45, 18), 4, BF: LET bet = 1: RETURN

spin:
LET spinning = 1
LINE (161, 81)-(280, 120), 0, BF
LET score = score - bet
LOCATE 14, 8
PRINT score
LOCATE 3, 25
PRINT "           "
LOCATE 4, 25
PRINT "        "
LOCATE 20, 20
PRINT "            "
LET s1% = INT(RND * 24 + 1)
LET s2% = INT(RND * 24 + 1)
LET s3% = INT(RND * 24 + 1)
IF rig% = 1 THEN LET which3% = INT(RND * 6)
IF rig% = 1 AND which3% = 0 THEN LET s1% = 2: LET s2% = 2: LET s3% = 2
IF rig% = 1 AND which3% = 1 THEN LET s1% = 10: LET s2% = 10: LET s3% = 10
IF rig% = 1 AND which3% = 2 THEN LET s1% = 15: LET s2% = 15: LET s3% = 15
IF rig% = 1 AND which3% = 3 THEN LET s1% = 5: LET s2% = 5: LET s3% = 5
IF rig% = 1 AND which3% = 4 THEN LET s1% = 20: LET s2% = 20: LET s3% = 20
IF rig% = 1 AND which3% = 5 THEN LET s1% = 1: LET s2% = 1: LET s3% = 1
PLAY "o3mbl32<<eeeeeeeeeeeeeeeeel16eeeeeeel8eeel4eel2el8"
DO
FOR h = 1 TO 3
LINE (161, 103)-(280, 103), 15
NEXT h
LINE (161, 103)-(280, 103), 0
FOR h = 1 TO 3
LINE (161, 85)-(280, 85), 15
NEXT h
LINE (161, 85)-(280, 85), 0
FOR h = 1 TO 3
LINE (161, 114)-(280, 114), 15
NEXT h
LINE (161, 114)-(280, 114), 0
LOOP WHILE PLAY(0) > 0
IF s1% = 1 THEN GOSUB s1m
IF s1% > 1 AND s1% < 5 THEN GOSUB s1cherry
IF s1% > 4 AND s1% < 10 THEN GOSUB s1bar
IF s1% > 9 AND s1% < 15 THEN GOSUB s1lemon
IF s1% > 14 AND s1% < 20 THEN GOSUB s1plum
IF s1% > 19 THEN GOSUB s1seven
IF s2% = 1 THEN GOSUB s2m
IF s2% > 1 AND s2% < 5 THEN GOSUB s2cherry
IF s2% > 4 AND s2% < 10 THEN GOSUB s2bar
IF s2% > 9 AND s2% < 15 THEN GOSUB s2lemon
IF s2% > 14 AND s2% < 20 THEN GOSUB s2plum
IF s2% > 19 THEN GOSUB s2seven
IF s3% = 1 THEN GOSUB s3m
IF s3% > 1 AND s3% < 5 THEN GOSUB s3cherry
IF s3% > 4 AND s3% < 10 THEN GOSUB s3bar
IF s3% > 9 AND s3% < 15 THEN GOSUB s3lemon
IF s3% > 14 AND s3% < 20 THEN GOSUB s3plum
IF s3% > 19 THEN GOSUB s3seven
IF s1$ = s2$ AND s2$ = s3$ THEN GOTO match
IF s1$ = "cherry" THEN GOTO oneisacherry
IF s2$ = "cherry" THEN GOTO oneisacherry
IF s3$ = "cherry" THEN GOTO oneisacherry
ret:
LOCATE 14, 8
PRINT score
LET spinning = 0
RETURN

oneisacherry:
IF bet = 2 THEN GOTO cherrybettwo
IF s1$ = "cherry" AND s2$ = "cherry" THEN PLAY "o3<dgb": LET score = score + 4: LOCATE 3, 25: PRINT "2 cherries": LOCATE 4, 25: PRINT "left": GOTO ret
IF s2$ = "cherry" AND s3$ = "cherry" THEN PLAY "o3<dgb": LET score = score + 4: LOCATE 3, 25: PRINT "2 cherries": LOCATE 4, 25: PRINT "right": GOTO ret
IF s1$ = "cherry" THEN PLAY "o3<dg": LET score = score + 2: LOCATE 3, 25: PRINT "1 cherry"
IF s2$ = "cherry" THEN PLAY "o3<dg": LET score = score + 2: LOCATE 3, 25: PRINT "1 cherry"
IF s3$ = "cherry" THEN PLAY "o3<dg": LET score = score + 2: LOCATE 3, 25: PRINT "1 cherry"
IF s1$ = "cherry" AND s3$ = "cherry" THEN LOCATE 4, 25: PRINT "X 2"
GOTO ret
cherrybettwo:
IF s1$ = "cherry" AND s2$ = "cherry" THEN PLAY "o3<dgb": LET score = score + 6: LOCATE 3, 25: PRINT "2 cherries": LOCATE 4, 25: PRINT "left": GOTO ret
IF s2$ = "cherry" AND s3$ = "cherry" THEN PLAY "o3<dgb": LET score = score + 7: LOCATE 3, 25: PRINT "2 cherries": LOCATE 4, 25: PRINT "right": GOTO ret
IF s1$ = "cherry" THEN PLAY "o3<dg": LET score = score + 3: LOCATE 3, 25: PRINT "1 cherry"
IF s2$ = "cherry" THEN PLAY "o3<dg": LET score = score + 3: LOCATE 3, 25: PRINT "1 cherry"
IF s3$ = "cherry" THEN PLAY "o3<dg": LET score = score + 3: LOCATE 3, 25: PRINT "1 cherry"
IF s1$ = "cherry" AND s3$ = "cherry" THEN LOCATE 4, 25: PRINT "X 2"
GOTO ret

match:
IF bet = 2 THEN GOTO matchbettwo
IF s1$ = "cherry" THEN PLAY "o3<dgb>d": LET score = score + 10: LOCATE 3, 25: PRINT "3 cherries"
IF s1$ = "lemon" THEN PLAY "o3c<g>c<g>c": LET score = score + 12: LOCATE 3, 25: PRINT "3 lemons"
IF s1$ = "plum" THEN PLAY "o3def#ed": LET score = score + 14: LOCATE 3, 25: PRINT "3 plums"
IF s1$ = "bar" THEN PLAY "o3a<a>a<a>a": LET score = score + 25: LOCATE 3, 25: PRINT "3 bars"
IF s1$ = "seven" THEN PLAY "o3cccf#": LET score = score + 150: LOCATE 3, 25: PRINT "3 sevens"
IF s1$ = "m" THEN PLAY "o3g.ggg": LET score = score + 500: LOCATE 3, 25: PRINT "3 m's"
GOTO ret
matchbettwo:
IF s1$ = "cherry" THEN PLAY "o3<dgb>d": LET score = score + 15: LOCATE 3, 25: PRINT "3 cherries"
IF s1$ = "lemon" THEN PLAY "o3c<g>c<g>c": LET score = score + 17: LOCATE 3, 25: PRINT "3 lemons"
IF s1$ = "plum" THEN PLAY "o3def#ed": LET score = score + 20: LOCATE 3, 25: PRINT "3 plums"
IF s1$ = "bar" THEN PLAY "o3a<a>a<a>a": LET score = score + 50: LOCATE 3, 25: PRINT "3 bars"
IF s1$ = "seven" THEN PLAY "o3cccf#": LET score = score + 350: LOCATE 3, 25: PRINT "3 sevens"
IF s1$ = "m" THEN PLAY "o3g.ggg": LET score = score + 1000: LOCATE 3, 25: PRINT "3 m's"
GOTO ret

s1cherry:
LET s1$ = "cherry"
CIRCLE (180, 105), 12, 4
PAINT (180, 100), 4
CIRCLE (180, 105), 12, 12
LINE (178, 94)-(180, 90), 10
LINE (182, 94)-(186, 86), 10
LINE (180, 90)-(175, 90), 10
LINE (186, 86)-(179, 86), 10
LINE (175, 90)-(179, 86), 10
LINE (176, 90)-(180, 86), 10
LINE (181, 94)-(185, 86), 10
LINE (179, 94)-(181, 90), 10
PAINT (180, 87), 10
LINE (178, 94)-(180, 90), 2
LINE (182, 94)-(186, 86), 2
LINE (180, 90)-(175, 90), 2
LINE (186, 86)-(179, 86), 2
LINE (175, 90)-(179, 86), 2
LINE (176, 90)-(180, 86), 2
LINE (181, 94)-(185, 86), 2
LINE (179, 94)-(181, 90), 2
LINE (180, 94)-(183, 87), 10
RETURN

s1lemon:
LET s1$ = "lemon"
CIRCLE (180, 100), 15, 14, , , .7
PAINT (180, 100), 14
CIRCLE (180, 100), 15, 6, , , .7
PSET (170, 97), 6
PSET (185, 107), 6
PSET (189, 95), 6
PSET (172, 106), 6
PSET (181, 92), 6
RETURN

s1plum:
LET s1$ = "plum"
CIRCLE (180, 100), 13, 5
PAINT (180, 100), 5
CIRCLE (180, 100), 13, 13
CIRCLE (180, 100), 12.5, 13
RETURN

s1bar:
LET s1$ = "bar"
LINE (165, 95)-(195, 105), 15, B
PSET (168, 97)
DRAW "c15d6r3e1u1h1l3r3e1u1h1l3br10bd1d5u5e1r2f1d5u3l3bu3br9d6u3r3f1d2u2h1e1u1h1l3"
RETURN

s1seven:
LET s1$ = "seven"
LINE (175, 115)-(175, 105), 14
LINE (180, 115)-(180, 105), 14
LINE (175, 115)-(180, 115), 14
LINE (180, 105)-(190, 90), 14
LINE (190, 90)-(170, 90), 14
LINE (170, 90)-(170, 95), 14
LINE (170, 95)-(180, 95), 14
LINE (180, 95)-(175, 105), 14
PAINT (171, 91), 14
LINE (175, 115)-(175, 105), 6
LINE (180, 115)-(180, 105), 6
LINE (175, 115)-(180, 115), 6
LINE (180, 105)-(190, 90), 6
LINE (190, 90)-(170, 90), 6
LINE (170, 90)-(170, 95), 6
LINE (170, 95)-(180, 95), 6
LINE (180, 95)-(175, 105), 6
LINE (178, 101)-(182, 101), 6
LINE (178, 102)-(181, 102), 6
LINE (177, 104)-(180, 104), 6
PAINT (178, 105), 6
LINE (179, 98)-(184, 98), 6
RETURN

s1m:
LET s1$ = "m"
LINE (165, 85)-(165, 115), 2
LINE (165, 115)-(170, 115), 2
LINE (170, 115)-(170, 95), 2
LINE (170, 95)-(180, 105), 2
LINE (180, 105)-(190, 95), 2
LINE (190, 95)-(190, 115), 2
LINE (190, 115)-(195, 115), 2
LINE (195, 115)-(195, 85), 2
LINE (195, 85)-(190, 85), 2
LINE (190, 85)-(180, 95), 2
LINE (180, 95)-(170, 85), 2
LINE (170, 85)-(165, 85), 2
PAINT (166, 86), 2
LINE (166, 86)-(166, 114), 10
LINE (166, 114)-(169, 114), 10
LINE (169, 114)-(169, 94), 10
LINE (170, 94)-(180, 104), 10
LINE (180, 104)-(190, 94), 10
LINE (191, 94)-(191, 114), 10
LINE (191, 114)-(194, 114), 10
LINE (194, 114)-(194, 86), 10
LINE (194, 86)-(191, 86), 10
LINE (190, 86)-(180, 96), 10
LINE (180, 96)-(170, 86), 10
LINE (169, 86)-(166, 86), 10
RETURN

s2cherry:
LET s2$ = "cherry"
CIRCLE (220, 105), 12, 4
PAINT (220, 100), 4
CIRCLE (220, 105), 12, 12
LINE (218, 94)-(220, 90), 10
LINE (222, 94)-(226, 86), 10
LINE (220, 90)-(215, 90), 10
LINE (226, 86)-(219, 86), 10
LINE (215, 90)-(219, 86), 10
LINE (216, 90)-(220, 86), 10
LINE (221, 94)-(225, 86), 10
LINE (219, 94)-(221, 90), 10
PAINT (220, 87), 10
LINE (218, 94)-(220, 90), 2
LINE (222, 94)-(226, 86), 2
LINE (220, 90)-(215, 90), 2
LINE (226, 86)-(219, 86), 2
LINE (215, 90)-(219, 86), 2
LINE (216, 90)-(220, 86), 2
LINE (221, 94)-(225, 86), 2
LINE (219, 94)-(221, 90), 2
LINE (220, 94)-(223, 87), 10
RETURN

s2lemon:
LET s2$ = "lemon"
CIRCLE (220, 100), 15, 14, , , .7
PAINT (220, 100), 14
CIRCLE (220, 100), 15, 6, , , .7
PSET (210, 97), 6
PSET (225, 107), 6
PSET (229, 95), 6
PSET (212, 106), 6
PSET (221, 92), 6
RETURN

s2plum:
LET s2$ = "plum"
CIRCLE (220, 100), 13, 5
PAINT (220, 100), 5
CIRCLE (220, 100), 13, 13
CIRCLE (220, 100), 12.5, 13
RETURN

s2bar:
LET s2$ = "bar"
LINE (205, 95)-(235, 105), 15, B
PSET (208, 97)
DRAW "c15d6r3e1u1h1l3r3e1u1h1l3br10bd1d5u5e1r2f1d5u3l3bu3br9d6u3r3f1d2u2h1e1u1h1l3"
RETURN

s2seven:
LET s2$ = "seven"
LINE (215, 115)-(215, 105), 14
LINE (220, 115)-(220, 105), 14
LINE (215, 115)-(220, 115), 14
LINE (220, 105)-(230, 90), 14
LINE (230, 90)-(210, 90), 14
LINE (210, 90)-(210, 95), 14
LINE (210, 95)-(220, 95), 14
LINE (220, 95)-(215, 105), 14
PAINT (211, 91), 14
LINE (215, 115)-(215, 105), 6
LINE (220, 115)-(220, 105), 6
LINE (215, 115)-(220, 115), 6
LINE (220, 105)-(230, 90), 6
LINE (230, 90)-(210, 90), 6
LINE (210, 90)-(210, 95), 6
LINE (210, 95)-(220, 95), 6
LINE (220, 95)-(215, 105), 6
LINE (218, 101)-(222, 101), 6
LINE (218, 102)-(221, 102), 6
LINE (217, 104)-(220, 104), 6
PAINT (218, 105), 6
LINE (219, 98)-(224, 98), 6
RETURN

s2m:
LET s2$ = "m"
LINE (205, 85)-(205, 115), 2
LINE (205, 115)-(210, 115), 2
LINE (210, 115)-(210, 95), 2
LINE (210, 95)-(220, 105), 2
LINE (220, 105)-(230, 95), 2
LINE (230, 95)-(230, 115), 2
LINE (230, 115)-(235, 115), 2
LINE (235, 115)-(235, 85), 2
LINE (235, 85)-(230, 85), 2
LINE (230, 85)-(220, 95), 2
LINE (220, 95)-(210, 85), 2
LINE (210, 85)-(205, 85), 2
PAINT (206, 86), 2
LINE (206, 86)-(206, 114), 10
LINE (206, 114)-(209, 114), 10
LINE (209, 114)-(209, 94), 10
LINE (210, 94)-(220, 104), 10
LINE (220, 104)-(230, 94), 10
LINE (231, 94)-(231, 114), 10
LINE (231, 114)-(234, 114), 10
LINE (234, 114)-(234, 86), 10
LINE (234, 86)-(231, 86), 10
LINE (230, 86)-(220, 96), 10
LINE (220, 96)-(210, 86), 10
LINE (209, 86)-(206, 86), 10
RETURN

s3cherry:
LET s3$ = "cherry"
CIRCLE (260, 105), 12, 4
PAINT (260, 100), 4
CIRCLE (260, 105), 12, 12
LINE (258, 94)-(260, 90), 10
LINE (262, 94)-(266, 86), 10
LINE (260, 90)-(255, 90), 10
LINE (266, 86)-(259, 86), 10
LINE (255, 90)-(259, 86), 10
LINE (256, 90)-(260, 86), 10
LINE (261, 94)-(265, 86), 10
LINE (259, 94)-(261, 90), 10
PAINT (260, 87), 10
LINE (258, 94)-(260, 90), 2
LINE (262, 94)-(266, 86), 2
LINE (260, 90)-(255, 90), 2
LINE (266, 86)-(259, 86), 2
LINE (255, 90)-(259, 86), 2
LINE (256, 90)-(260, 86), 2
LINE (261, 94)-(265, 86), 2
LINE (259, 94)-(261, 90), 2
LINE (260, 94)-(263, 87), 10
RETURN

s3lemon:
LET s3$ = "lemon"
CIRCLE (260, 100), 15, 14, , , .7
PAINT (260, 100), 14
CIRCLE (260, 100), 15, 6, , , .7
PSET (250, 97), 6
PSET (265, 107), 6
PSET (269, 95), 6
PSET (252, 106), 6
PSET (261, 92), 6
RETURN

s3plum:
LET s3$ = "plum"
CIRCLE (260, 100), 13, 5
PAINT (260, 100), 5
CIRCLE (260, 100), 13, 13
CIRCLE (260, 100), 12.5, 13
RETURN

riggame:
IF spinning = 1 THEN RETURN
LET hasbeenrigged = 1
IF rig% = 0 THEN LET rig% = 1: LOCATE 19, 25: PRINT "Game rigged": RETURN
IF rig% = 1 THEN LET rig% = 0: LOCATE 19, 25: PRINT "           "
RETURN

s3bar:
LET s3$ = "bar"
LINE (245, 95)-(275, 105), 15, B
PSET (248, 97)
DRAW "c15d6r3e1u1h1l3r3e1u1h1l3br10bd1d5u5e1r2f1d5u3l3bu3br9d6u3r3f1d2u2h1e1u1h1l3"
RETURN

s3seven:
LET s3$ = "seven"
LINE (255, 115)-(255, 105), 14
LINE (260, 115)-(260, 105), 14
LINE (255, 115)-(260, 115), 14
LINE (260, 105)-(270, 90), 14
LINE (270, 90)-(250, 90), 14
LINE (250, 90)-(250, 95), 14
LINE (250, 95)-(260, 95), 14
LINE (260, 95)-(255, 105), 14
PAINT (251, 91), 14
LINE (255, 115)-(255, 105), 6
LINE (260, 115)-(260, 105), 6
LINE (255, 115)-(260, 115), 6
LINE (260, 105)-(270, 90), 6
LINE (270, 90)-(250, 90), 6
LINE (250, 90)-(250, 95), 6
LINE (250, 95)-(260, 95), 6
LINE (260, 95)-(255, 105), 6
LINE (258, 101)-(262, 101), 6
LINE (258, 102)-(261, 102), 6
LINE (257, 104)-(260, 104), 6
PAINT (258, 105), 6
LINE (259, 98)-(264, 98), 6
RETURN

s3m:
LET s3$ = "m"
LINE (245, 85)-(245, 115), 2
LINE (245, 115)-(250, 115), 2
LINE (250, 115)-(250, 95), 2
LINE (250, 95)-(260, 105), 2
LINE (260, 105)-(270, 95), 2
LINE (270, 95)-(270, 115), 2
LINE (270, 115)-(275, 115), 2
LINE (275, 115)-(275, 85), 2
LINE (275, 85)-(270, 85), 2
LINE (270, 85)-(260, 95), 2
LINE (260, 95)-(250, 85), 2
LINE (250, 85)-(245, 85), 2
PAINT (246, 86), 2
LINE (246, 86)-(246, 114), 10
LINE (246, 114)-(249, 114), 10
LINE (249, 114)-(249, 94), 10
LINE (250, 94)-(260, 104), 10
LINE (260, 104)-(270, 94), 10
LINE (271, 94)-(271, 114), 10
LINE (271, 114)-(274, 114), 10
LINE (274, 114)-(274, 86), 10
LINE (274, 86)-(271, 86), 10
LINE (270, 86)-(260, 96), 10
LINE (260, 96)-(250, 86), 10
LINE (249, 86)-(246, 86), 10
RETURN

tenthousand:
CLS
PAINT (1, 1), 15
FOR h = 1 TO 40
PSET (INT(RND * 300), INT(RND * 200))
DRAW scherry$
PSET (INT(RND * 300), INT(RND * 200))
DRAW slemon$
PSET (INT(RND * 300), INT(RND * 200))
DRAW splum$
PSET (INT(RND * 300), INT(RND * 200))
DRAW sbar$
PSET (INT(RND * 300), INT(RND * 200))
DRAW sseven$
PSET (INT(RND * 300), INT(RND * 200))
DRAW sm$
NEXT h
COLOR 15
PRINT "         Ten Thousand Dollars!!         "
IF hasbeenrigged = 0 THEN PRINT
IF hasbeenrigged = 1 THEN PRINT "          Too bad you cheated!          "
PRINT "           Incredible score!            "
PRINT "      (Press any key to continue)       "
DO
LINE (160, 80)-(281, 121), 0, BF
GOSUB s1m
GOSUB s2m
GOSUB s3m
SLEEP 1
LINE (160, 80)-(281, 121), 0, BF
GOSUB s1seven
GOSUB s2seven
GOSUB s3seven
SLEEP 1
LINE (160, 80)-(281, 121), 0, BF
GOSUB s1bar
GOSUB s2bar
GOSUB s3bar
SLEEP 1
LINE (160, 80)-(281, 121), 0, BF
GOSUB s1plum
GOSUB s2plum
GOSUB s3plum
SLEEP 1
LINE (160, 80)-(281, 121), 0, BF
GOSUB s1lemon
GOSUB s2lemon
GOSUB s3lemon
SLEEP 1
LINE (160, 80)-(281, 121), 0, BF
GOSUB s1cherry
GOSUB s2cherry
GOSUB s3cherry
SLEEP 1
LOOP WHILE INKEY$ = ""
GOTO finish

savegame:
IF spinning = 1 THEN RETURN
KEY(15) OFF: KEY(16) OFF: KEY(17) OFF: KEY(18) OFF: KEY(19) OFF: KEY(20) OFF: KEY(21) OFF
LOCATE 20, 17
PRINT "Name your game:"
LOCATE 21, 17
PRINT "(8 characters)"
si: LOCATE 22, 17: INPUT f$
IF LEN(f$) > 8 THEN GOTO si
LET f$ = f$ + ".ssg"
OPEN f$ FOR BINARY AS #1
IF hasbeenrigged = 0 THEN LET r% = 0
IF hasbeenrigged = 1 THEN LET r% = 1
LET s% = score + 1981
PUT #1, 1, r%
PUT #1, 3, s%
LOCATE 20, 17
PRINT "                 "
LOCATE 21, 17
PRINT "                 "
LOCATE 22, 17
PRINT "                 "
LOCATE 20, 20
PRINT "Game saved."
CLOSE #1
RETURN

loadgame:
IF spinning = 1 THEN RETURN
KEY(15) OFF: KEY(16) OFF: KEY(17) OFF: KEY(18) OFF: KEY(19) OFF: KEY(20) OFF: KEY(21) OFF
LOCATE 20, 17
PRINT "Name of game:"
LOCATE 21, 17
PRINT "(8 characters)"
li: LOCATE 22, 17: INPUT f$
IF LEN(f$) > 8 THEN GOTO si
LET f$ = f$ + ".ssg"
OPEN f$ FOR BINARY AS #1
GET #1, 1, r%
GET #1, 3, s%
IF r% = 0 THEN LET hasbeenrigged = 0
IF r% = 1 THEN LET hasbeenrigged = 1
LET score = s% - 1981
LOCATE 20, 17
PRINT "                 "
LOCATE 21, 17
PRINT "                 "
LOCATE 22, 17
PRINT "                      "
LOCATE 14, 8
PRINT score
LET rig% = 0
LOCATE 19, 25
PRINT "            "
LOCATE 20, 20
PRINT "Game loaded."
CLOSE #1
RETURN

yousuck: CLS
PRINT "Congratulations! You have lost $10,000!"
PRINT "You are one of the worst players in the"
PRINT "history of slot machines!": PRINT
PRINT "Press any key to continue."
SLEEP
GOTO finish

finish:
KEY(15) OFF
KEY(16) OFF
KEY(17) OFF
KEY(18) OFF
KEY(19) OFF
KEY(20) OFF
KEY(21) OFF
OPEN "slots.dat" FOR INPUT AS #1
INPUT #1, name1$
INPUT #1, score1%
INPUT #1, name2$
INPUT #1, score2%
INPUT #1, name3$
INPUT #1, score3%
CLS
PRINT "         Slots High Scores": PRINT
PRINT "              "; name1$
PRINT "              "; score1%
PRINT "              "; name2$
PRINT "              "; score2%
PRINT "              "; name3$
PRINT "              "; score3%: PRINT
PRINT "             Your Score:"
PRINT "              "; score
IF score < score3% THEN END
IF hasbeenrigged = 1 THEN PRINT "      No high scores for cheaters!": END
PRINT "  You have made the high score list!"
PRINT "       Please type your name:"
PRINT "       (8 characters please)"
IF score > score3% AND score < score2% THEN
1 LOCATE 15, 1
PRINT "                                        "
LOCATE 15, 1
INPUT name3$
IF LEN(name3$) > 8 THEN 1
   LET score3% = score
END IF
IF score > score2% AND score < score1% THEN
   LET name3$ = name2$
   LET score3% = score2%
2 LOCATE 15, 1
PRINT "                                        "
LOCATE 15, 1
INPUT name2$
IF LEN(name2$) > 8 THEN 2
   LET score2% = score
END IF
IF score > score1% THEN
   LET name3$ = name2$
   LET score3% = score2%
   LET name2$ = name1$
   LET score2% = score1%
3 LOCATE 15, 1
PRINT "                                        "
LOCATE 15, 1
INPUT name1$
IF LEN(name1$) > 8 THEN 3
   LET score1% = score
END IF
CLOSE #1
KILL "slots.dat"
OPEN "slots.dat" FOR OUTPUT AS #1
WRITE #1, name1$
WRITE #1, score1%
WRITE #1, name2$
WRITE #1, score2%
WRITE #1, name3$
WRITE #1, score3%
CLOSE #1
OPEN "slots.dat" FOR INPUT AS #1
INPUT #1, name1$
INPUT #1, score1%
INPUT #1, name2$
INPUT #1, score2%
INPUT #1, name3$
INPUT #1, score3%
CLS
PRINT "         Slots High Scores": PRINT
PRINT "              "; name1$
PRINT "              "; score1%
PRINT "              "; name2$
PRINT "              "; score2%
PRINT "              "; name3$
PRINT "              "; score3%


