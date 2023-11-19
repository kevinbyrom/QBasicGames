'                               SPACE QUEST 2
'                
'                     By: 14 year old programmer - Tom Ford
'
'                            Finished - 12/16/96
'
'                           Screen name - Tom672
'
'
'        If your interested in getting Space Quest 1, then e-mail me.
'
'
'                       I hope you enjoy this sequel!
'                 All instructions and controls are included!
'
'-------------------------Just press F5 to start!----------------------------------------
'-------------If you don't know that, then press----ALT + F + X--------------------
'
'
'
'
'
'
'------------------------------PRESS F5 NOW!!!!--------------------------------
'
'
'
'
'--------------------------Don't go any further!!!--------------------------------
DECLARE SUB EndItCool ()
DECLARE SUB AskSp ()
DECLARE SUB Clip2 ()
DECLARE SUB Clip3 ()
DECLARE SUB ReadyScreen ()
DECLARE SUB Clip1 ()
DECLARE SUB Instruct ()
DECLARE SUB Menus ()
DECLARE SUB fade ()
DECLARE SUB Die (x, y)
DECLARE SUB Intro ()
DECLARE SUB EndIt ()
RANDOMIZE TIMER
  menu$ = "main"
 KEY(1) ON
 ON KEY(1) GOSUB Ford
 KEY 15, CHR$(128) + CHR$(72)
 KEY 16, CHR$(128) + CHR$(80)
 KEY 17, CHR$(0) + CHR$(54)
 KEY 18, CHR$(0) + CHR$(20)
 KEY 19, CHR$(0) + CHR$(24)
 KEY 20, CHR$(0) + CHR$(50)
 ON KEY(18) GOSUB Part1
 ON KEY(19) GOSUB Part2
 ON KEY(20) GOSUB Part3
TheMenu:
    ON KEY(15) GOSUB MenUp
    ON KEY(16) GOSUB MenDown
    ON KEY(17) GOSUB MenSel
  MenX = 130
  MenY = 75
  Menus
   IF HasSelected = 1 AND menu$ = "main" THEN
   HasSelected = 0
   IF MenY = 75 THEN fade: SCREEN 9: SCREEN 13: menu$ = "play": GOTO TheMenu
   IF MenY = 91 THEN fade: SCREEN 9: SCREEN 13: Instruct: GOTO TheMenu
   IF MenY = 107 THEN fade: SCREEN 9: SCREEN 13: Intro: GOTO TheMenu
   IF MenY = 123 THEN fade: SCREEN 9: SCREEN 13: AskSp: GOTO TheMenu
   IF MenY = 139 THEN fade: SCREEN 9: SCREEN 13: EndIt
   END IF
     IF HasSelected = 1 AND menu$ = "play" THEN
     HasSelected = 0
     IF MenY = 75 THEN fade: SCREEN 9: SCREEN 13: DifLev = 1000: GOTO ResetStuff
     IF MenY = 91 THEN fade: SCREEN 9: SCREEN 13: DifLev = 3000: GOTO ResetStuff
     IF MenY = 107 THEN fade: SCREEN 9: SCREEN 13: DifLev = 5000: GOTO ResetStuff
     IF MenY = 123 THEN fade: SCREEN 9: SCREEN 13: menu$ = "main": GOTO TheMenu
     END IF
ResetStuff:
x1 = -9: x2 = -9: x3 = -9: x4 = -9: x5 = -9: x6 = -9: x7 = -9
this = 0
dir$ = "stop"
level = 1
cheating = 0
a1 = 0: a2 = 0: a3 = 0: a4 = 0: a5 = 0: a6 = 0: a7 = 0
level.3 = 0: level.5 = 0: level.7 = 0: level.9 = 0
ReadyScreen
Something:
  SCREEN 13: CLS
  ON KEY(15) GOSUB GoUp
  ON KEY(16) GOSUB GoDown
  ON KEY(17) GOSUB StopIt
  x = 10
  y = 98
  x1 = 320
  rx1 = 1
  rx2 = 1
  rx3 = 1
  rx4 = 1
  rx5 = 1
  rx6 = 1
  rx7 = 1
  level = 1
GOTO start
Ford: END
MenUp:
  MenMove = 1
  IF menu$ = "main" AND MenY = 75 THEN RETURN
  IF menu$ = "play" AND MenY = 75 THEN RETURN
  LINE (MenX - 2, MenY - 2)-(MenX + 2, MenY + 2), 16, BF
  MenY = MenY - 16
  RETURN

MenDown:
  MenMove = 1
  IF menu$ = "main" AND MenY = 139 THEN RETURN
  IF menu$ = "play" AND MenY = 123 THEN RETURN
  LINE (MenX - 2, MenY - 2)-(MenX + 2, MenY + 2), 16, BF
  MenY = MenY + 16
  RETURN

MenSel:
  HasSelected = 1
  RETURN

Part1:
IF cheating = 0 THEN cheating = 1
RETURN

Part2:
IF cheating = 1 THEN cheating = 2
RETURN

Part3:
IF cheating = 2 THEN cheating = 3: COLOR 31: LOCATE 1, 1: PRINT "CHEATER!!!"
RETURN

GoUp:
dir$ = "up"
RETURN

GoDown:
dir$ = "down"
RETURN

StopIt:
dir$ = "stop"
RETURN

start:
 KEY(15) ON
 KEY(16) ON
 KEY(17) ON
GoLevel:
IF level = 1 THEN GOTO level1
GOTO GoLevel

level1:
this = this + 1
x1 = x1 - rx1
LINE (x1, y1)-(x1 + 10, y1 + 10), 114, BF
LINE (x1 - 1, y1 - 1)-(x1 + 11, y1 + 11), 16, B
LINE (x1 - 2, y1 - 2)-(x1 + 12, y1 + 12), 16, B
IF x1 < -8 THEN LINE (x1 - 1, y1 - 1)-(x1 + 11, y1 + 11), 16, BF: rx1 = (RND * 1 + 1): y1 = INT(RND * 189): x1 = 315
 x2 = x2 - rx2
 LINE (x2, y2)-(x2 + 10, y2 + 10), 114, BF
 LINE (x2 - 1, y2 - 1)-(x2 + 11, y2 + 11), 16, B
 LINE (x2 - 2, y2 - 2)-(x2 + 12, y2 + 12), 16, B
 IF x2 < -8 THEN LINE (x2 - 1, y2 - 1)-(x2 + 11, y2 + 11), 16, BF: rx2 = (RND * 1 + 1): y2 = INT(RND * 189): x2 = 315
  x3 = x3 - rx3
  LINE (x3, y3)-(x3 + 5, y3 + 5), 113, BF
  LINE (x3 - 1, y3 - 1)-(x3 + 6, y3 + 6), 16, B
  LINE (x3 - 2, y3 - 2)-(x3 + 7, y3 + 7), 16, B
  LINE (x3 - 3, y3 - 3)-(x3 + 8, y3 + 8), 16, B
  IF x3 < -3 THEN LINE (x3 - 1, y3 - 1)-(x3 + 6, y3 + 6), 16, BF: rx3 = (RND * 1 + 2): y3 = INT(RND * 189): x3 = 315
   x4 = x4 - rx4
   LINE (x4, y4)-(x4 + 5, y4 + 5), 113, BF
   LINE (x4 - 1, y4 - 1)-(x4 + 6, y4 + 6), 16, B
   LINE (x4 - 2, y4 - 2)-(x4 + 7, y4 + 7), 16, B
   LINE (x4 - 3, y4 - 3)-(x4 + 8, y4 + 8), 16, B
   IF x4 < -3 THEN LINE (x4 - 1, y4 - 1)-(x4 + 6, y4 + 6), 16, BF: rx4 = (RND * 1 + 2): y4 = INT(RND * 189): x4 = 315
    x5 = x5 - rx5
    LINE (x5, y5)-(x5 + 5, y5 + 5), 113, BF
    LINE (x5 - 1, y5 - 1)-(x5 + 6, y5 + 6), 16, B
    LINE (x5 - 2, y5 - 2)-(x5 + 7, y5 + 7), 16, B
    LINE (x5 - 3, y5 - 3)-(x5 + 8, y5 + 8), 16, B
    IF x5 < -3 THEN LINE (x5 - 1, y5 - 1)-(x5 + 6, y5 + 6), 16, BF: rx5 = (RND * 1 + 2): y5 = INT(RND * 189): x5 = 315
     x6 = x6 - rx6
     LINE (x6, y6)-(x6 + 5, y6 + 5), 113, BF
     LINE (x6 - 1, y6 - 1)-(x6 + 6, y6 + 6), 16, B
     LINE (x6 - 2, y6 - 2)-(x6 + 7, y6 + 7), 16, B
     LINE (x6 - 3, y6 - 3)-(x6 + 8, y6 + 8), 16, B
     IF x6 < -3 THEN LINE (x6 - 1, y6 - 1)-(x6 + 6, y6 + 6), 16, BF: rx6 = (RND * 1 + 2): y6 = INT(RND * 189): x6 = 315
      x7 = x7 - rx7
      LINE (x7, y7)-(x7 + 10, y7 + 10), 114, BF
      LINE (x7 - 1, y7 - 1)-(x7 + 11, y7 + 11), 16, B
      LINE (x7 - 2, y7 - 2)-(x7 + 12, y7 + 12), 16, B
      IF x7 < -8 THEN LINE (x7 - 1, y7 - 1)-(x7 + 11, y7 + 11), 16, BF: rx7 = (RND * 1 + 1): y7 = INT(RND * 189): x7 = 315
IF cheating < 3 THEN
IF x > x1 - 5 AND x < x1 + 11 AND y > y1 - 5 AND y < y1 + 11 OR x > x2 - 5 AND x < x2 + 11 AND y > y2 - 5 AND y < y2 + 11 OR x > x7 - 5 AND x < x7 + 11 AND y > y7 - 5 AND y < y7 + 11 THEN CALL Die(x, y): GOTO TheMenu
IF x > x3 - 5 AND x < x3 + 6 AND y > y3 - 5 AND y < y3 + 6 OR x > x4 - 5 AND x < x4 + 6 AND y > y4 - 5 AND y < y4 + 6 OR x > x5 - 5 AND x < x5 + 6 AND y > y5 - 5 AND y < y5 + 6 OR x > x6 - 5 AND x < x6 + 6 AND y > y6 - 5 AND y < y6 + 6 THEN CALL Die(x, y): GOTO TheMenu
END IF
IF this > DifLev THEN level = 2: GOTO level2
GOTO main

level2: '222222222222222222222222222222222222222222222222222222222222222222222
this = this + 1
x1 = x1 - rx1
LINE (x1, y1)-(x1 + 10, y1 + 10), 114, BF
LINE (x1 - 1, y1 - 1)-(x1 + 11, y1 + 11), 16, B
LINE (x1 - 2, y1 - 2)-(x1 + 12, y1 + 12), 16, B
LINE (x1 - 3, y1 - 3)-(x1 + 13, y1 + 13), 16, B
LINE (x1 - 4, y1 - 4)-(x1 + 14, y1 + 14), 16, B
LINE (x1 - 5, y1 - 5)-(x1 + 15, y1 + 15), 16, B
IF x1 < -8 AND level.3 = 0 THEN LINE (x1 - 1, y1 - 1)-(x1 + 11, y1 + 11), 16, BF: rx1 = (RND * 1 + 4): y1 = INT(RND * 189): x1 = 315
IF x1 < -8 AND level.3 = 1 THEN a1 = 1: LINE (x1, y1)-(x1 + 10, y1 + 10), 16, BF
 x2 = x2 - rx2
 LINE (x2, y2)-(x2 + 10, y2 + 10), 114, BF
 LINE (x2 - 1, y2 - 1)-(x2 + 11, y2 + 11), 16, B
 LINE (x2 - 2, y2 - 2)-(x2 + 12, y2 + 12), 16, B
 LINE (x2 - 3, y2 - 3)-(x2 + 13, y2 + 13), 16, B
 LINE (x2 - 4, y2 - 4)-(x2 + 14, y2 + 14), 16, B
 LINE (x2 - 5, y2 - 5)-(x2 + 15, y2 + 15), 16, B
 IF x2 < -8 AND level.3 = 0 THEN LINE (x2 - 1, y2 - 1)-(x2 + 11, y2 + 11), 16, BF: rx2 = (RND * 1 + 4): y2 = INT(RND * 189): x2 = 315
 IF x2 < -8 AND level.3 = 1 THEN a2 = 1: LINE (x2, y2)-(x2 + 10, y2 + 10), 16, BF
  x3 = x3 - rx3
  LINE (x3, y3)-(x3 + 5, y3 + 5), 113, BF
  LINE (x3 - 1, y3 - 1)-(x3 + 6, y3 + 6), 16, B
  LINE (x3 - 2, y3 - 2)-(x3 + 7, y3 + 7), 16, B
  LINE (x3 - 3, y3 - 3)-(x3 + 8, y3 + 8), 16, B
  LINE (x3 - 4, y3 - 4)-(x3 + 9, y3 + 9), 16, B
  LINE (x3 - 5, y3 - 5)-(x3 + 10, y3 + 10), 16, B
  LINE (x3 - 6, y3 - 6)-(x3 + 11, y3 + 11), 16, B
  IF x3 < -3 AND level.3 = 0 THEN LINE (x3 - 1, y3 - 1)-(x3 + 6, y3 + 6), 16, BF: rx3 = (RND * 1 + 5): y3 = INT(RND * 189): x3 = 315
  IF x3 < -3 AND level.3 = 1 THEN a3 = 1: LINE (x3, y3)-(x3 + 5, y3 + 5), 16, BF
   x4 = x4 - rx4
   LINE (x4, y4)-(x4 + 5, y4 + 5), 113, BF
   LINE (x4 - 1, y4 - 1)-(x4 + 6, y4 + 6), 16, B
   LINE (x4 - 2, y4 - 2)-(x4 + 7, y4 + 7), 16, B
   LINE (x4 - 3, y4 - 3)-(x4 + 8, y4 + 8), 16, B
   LINE (x4 - 4, y4 - 4)-(x4 + 9, y4 + 9), 16, B
   LINE (x4 - 5, y4 - 5)-(x4 + 10, y4 + 10), 16, B
   LINE (x4 - 6, y4 - 6)-(x4 + 11, y4 + 11), 16, B
   IF x4 < -3 AND level.3 = 0 THEN LINE (x4 - 1, y4 - 1)-(x4 + 6, y4 + 6), 16, BF: rx4 = (RND * 1 + 5): y4 = INT(RND * 189): x4 = 315
   IF x4 < -3 AND level.3 = 1 THEN a4 = 1: LINE (x4, y4)-(x4 + 5, y4 + 5), 16, BF
    x5 = x5 - rx5
    LINE (x5, y5)-(x5 + 5, y5 + 5), 113, BF
    LINE (x5 - 1, y5 - 1)-(x5 + 6, y5 + 6), 16, B
    LINE (x5 - 2, y5 - 2)-(x5 + 7, y5 + 7), 16, B
    LINE (x5 - 3, y5 - 3)-(x5 + 8, y5 + 8), 16, B
    LINE (x5 - 4, y5 - 4)-(x5 + 9, y5 + 9), 16, B
    LINE (x5 - 5, y5 - 5)-(x5 + 10, y5 + 10), 16, B
    LINE (x5 - 6, y5 - 6)-(x5 + 11, y5 + 11), 16, B
    IF x5 < -3 AND level.3 = 0 THEN LINE (x5 - 1, y5 - 1)-(x5 + 6, y5 + 6), 16, BF: rx5 = (RND * 1 + 5): y5 = INT(RND * 189): x5 = 315
    IF x5 < -3 AND level.3 = 1 THEN a5 = 1: LINE (x5, y5)-(x5 + 5, y5 + 5), 16, BF
     x6 = x6 - rx6
     LINE (x6, y6)-(x6 + 5, y6 + 5), 113, BF
     LINE (x6 - 1, y6 - 1)-(x6 + 6, y6 + 6), 16, B
     LINE (x6 - 2, y6 - 2)-(x6 + 7, y6 + 7), 16, B
     LINE (x6 - 3, y6 - 3)-(x6 + 8, y6 + 8), 16, B
     LINE (x6 - 4, y6 - 4)-(x6 + 9, y6 + 9), 16, B
     LINE (x6 - 5, y6 - 5)-(x6 + 10, y6 + 10), 16, B
     LINE (x6 - 6, y6 - 6)-(x6 + 11, y6 + 11), 16, B
     IF x6 < -3 AND level.3 = 0 THEN LINE (x6 - 1, y6 - 1)-(x6 + 6, y6 + 6), 16, BF: rx6 = (RND * 1 + 5): y6 = INT(RND * 189): x6 = 315
     IF x6 < -3 AND level.3 = 1 THEN a6 = 1: LINE (x6, y6)-(x6 + 5, y6 + 5), 16, BF
      x7 = x7 - rx7
      LINE (x7, y7)-(x7 + 10, y7 + 10), 114, BF
      LINE (x7 - 1, y7 - 1)-(x7 + 11, y7 + 11), 16, B
      LINE (x7 - 2, y7 - 2)-(x7 + 12, y7 + 12), 16, B
      LINE (x7 - 3, y7 - 3)-(x7 + 13, y7 + 13), 16, B
      LINE (x7 - 4, y7 - 4)-(x7 + 14, y7 + 14), 16, B
      LINE (x7 - 5, y7 - 5)-(x7 + 15, y7 + 15), 16, B
      IF x7 < -8 AND level.3 = 1 THEN a7 = 1: LINE (x7, y7)-(x7 + 10, y7 + 10), 16, BF
      IF x7 < -8 AND level.3 = 0 THEN LINE (x7 - 1, y7 - 1)-(x7 + 11, y7 + 11), 16, BF: rx7 = (RND * 1 + 4): y7 = INT(RND * 189): x7 = 315
IF cheating < 3 THEN
IF x > x1 - 5 AND x < x1 + 11 AND y > y1 - 5 AND y < y1 + 11 OR x > x2 - 5 AND x < x2 + 11 AND y > y2 - 5 AND y < y2 + 11 OR x > x7 - 5 AND x < x7 + 11 AND y > y7 - 5 AND y < y7 + 11 THEN CALL Die(x, y): GOTO TheMenu
IF x > x3 - 5 AND x < x3 + 6 AND y > y3 - 5 AND y < y3 + 6 OR x > x4 - 5 AND x < x4 + 6 AND y > y4 - 5 AND y < y4 + 6 OR x > x5 - 5 AND x < x5 + 6 AND y > y5 - 5 AND y < y5 + 6 OR x > x6 - 5 AND x < x6 + 6 AND y > y6 - 5 AND y < y6 + 6 THEN CALL Die(x, y): GOTO TheMenu
END IF
IF this > DifLev * 2 THEN level.3 = 1
IF a1 = 1 AND a2 = 1 AND a3 = 1 AND a4 = 1 AND a5 = 1 AND a6 = 1 AND a7 = 1 THEN a1 = 0: a2 = 0: a3 = 0: a4 = 0: a5 = 0: a6 = 0: a7 = 0: level = 3: Clip1: ReadyScreen: GOTO level3
GOTO main

level3: '333333333333333333333333333333333333333333333333333333333333333333333333333333
this = this + 1
x1 = x1 - rx1
LINE (x1, y1)-(x1 + 15, y1 + 15), 115, BF
LINE (x1 - 1, y1 - 1)-(x1 + 16, y1 + 16), 16, B
LINE (x1 - 2, y1 - 2)-(x1 + 17, y1 + 17), 16, B
IF x1 < -13 THEN LINE (x1 - 1, y1 - 1)-(x1 + 16, y1 + 16), 16, BF: rx1 = (RND * 1 + 1): y1 = INT(RND * 189): x1 = 315
 x2 = x2 - rx2
 LINE (x2, y2)-(x2 + 15, y2 + 15), 115, BF
 LINE (x2 - 1, y2 - 1)-(x2 + 16, y2 + 16), 16, B
 LINE (x2 - 2, y2 - 2)-(x2 + 17, y2 + 17), 16, B
 IF x2 < -13 THEN LINE (x2 - 1, y2 - 1)-(x2 + 16, y2 + 16), 16, BF: rx2 = (RND * 1 + 1): y2 = INT(RND * 189): x2 = 315
  x3 = x3 - rx3
  LINE (x3, y3)-(x3 + 10, y3 + 10), 114, BF
  LINE (x3 - 1, y3 - 1)-(x3 + 11, y3 + 11), 16, B
  LINE (x3 - 2, y3 - 2)-(x3 + 12, y3 + 12), 16, B
  LINE (x3 - 3, y3 - 3)-(x3 + 13, y3 + 13), 16, B
  IF x3 < -8 THEN LINE (x3 - 1, y3 - 1)-(x3 + 11, y3 + 11), 16, BF: rx3 = (RND * 1 + 2): y3 = INT(RND * 189): x3 = 315
   x4 = x4 - rx4
   LINE (x4, y4)-(x4 + 10, y4 + 10), 114, BF
   LINE (x4 - 1, y4 - 1)-(x4 + 11, y4 + 11), 16, B
   LINE (x4 - 2, y4 - 2)-(x4 + 12, y4 + 12), 16, B
   LINE (x4 - 3, y4 - 3)-(x4 + 13, y4 + 13), 16, B
   IF x4 < -8 THEN LINE (x4 - 1, y4 - 1)-(x4 + 11, y4 + 11), 16, BF: rx4 = (RND * 1 + 2): y4 = INT(RND * 189): x4 = 315
    x5 = x5 - rx5
    LINE (x5, y5)-(x5 + 10, y5 + 10), 114, BF
    LINE (x5 - 1, y5 - 1)-(x5 + 11, y5 + 11), 16, B
    LINE (x5 - 2, y5 - 2)-(x5 + 12, y5 + 12), 16, B
    LINE (x5 - 3, y5 - 3)-(x5 + 13, y5 + 13), 16, B
    IF x5 < -8 THEN LINE (x5 - 1, y5 - 1)-(x5 + 11, y5 + 11), 16, BF: rx5 = (RND * 1 + 2): y5 = INT(RND * 189): x5 = 315
     x6 = x6 - rx6
     LINE (x6, y6)-(x6 + 10, y6 + 10), 114, BF
     LINE (x6 - 1, y6 - 1)-(x6 + 11, y6 + 11), 16, B
     LINE (x6 - 2, y6 - 2)-(x6 + 12, y6 + 12), 16, B
     LINE (x6 - 3, y6 - 3)-(x6 + 13, y6 + 13), 16, B
     IF x6 < -8 THEN LINE (x6 - 1, y6 - 1)-(x6 + 11, y6 + 11), 16, BF: rx6 = (RND * 1 + 2): y6 = INT(RND * 189): x6 = 315
      x7 = x7 - rx7
      LINE (x7, y7)-(x7 + 15, y7 + 15), 115, BF
      LINE (x7 - 1, y7 - 1)-(x7 + 16, y7 + 16), 16, B
      LINE (x7 - 2, y7 - 2)-(x7 + 17, y7 + 17), 16, B
      IF x7 < -13 THEN LINE (x7 - 1, y7 - 1)-(x7 + 16, y7 + 16), 16, BF: rx7 = (RND * 1 + 1): y7 = INT(RND * 189): x7 = 315
IF cheating < 3 THEN
IF x > x1 - 5 AND x < x1 + 16 AND y > y1 - 5 AND y < y1 + 16 OR x > x2 - 5 AND x < x2 + 16 AND y > y2 - 5 AND y < y2 + 16 OR x > x7 - 5 AND x < x7 + 16 AND y > y7 - 5 AND y < y7 + 16 THEN CALL Die(x, y): GOTO TheMenu
IF x > x3 - 5 AND x < x3 + 11 AND y > y3 - 5 AND y < y3 + 11 OR x > x4 - 5 AND x < x4 + 11 AND y > y4 - 5 AND y < y4 + 11 OR x > x5 - 5 AND x < x5 + 11 AND y > y5 - 5 AND y < y5 + 11 OR x > x6 - 5 AND x < x6 + 11 AND y > y6 - 5 AND y < y6 + 11 THEN CALL Die(x, y): GOTO TheMenu
END IF
IF this > DifLev * 3 THEN level = 4: GOTO level4
GOTO main
level4:    '44444444444444444444444444444444444444444444444444444444444444444444444444
this = this + 1
x1 = x1 - rx1
LINE (x1, y1)-(x1 + 15, y1 + 15), 115, BF
LINE (x1 - 1, y1 - 1)-(x1 + 16, y1 + 16), 16, B
LINE (x1 - 2, y1 - 2)-(x1 + 17, y1 + 17), 16, B
LINE (x1 - 3, y1 - 3)-(x1 + 18, y1 + 18), 16, B
LINE (x1 - 4, y1 - 4)-(x1 + 19, y1 + 19), 16, B
LINE (x1 - 5, y1 - 5)-(x1 + 20, y1 + 20), 16, B
IF x1 < -13 AND level.5 = 0 THEN LINE (x1 - 1, y1 - 1)-(x1 + 16, y1 + 16), 16, BF: rx1 = (RND * 1 + 4): y1 = INT(RND * 189): x1 = 315
IF x1 < -13 AND level.5 = 1 THEN a1 = 1: LINE (x1, y1)-(x1 + 15, y1 + 15), 16, BF
 x2 = x2 - rx2
 LINE (x2, y2)-(x2 + 15, y2 + 15), 115, BF
 LINE (x2 - 1, y2 - 1)-(x2 + 16, y2 + 16), 16, B
 LINE (x2 - 2, y2 - 2)-(x2 + 17, y2 + 17), 16, B
 LINE (x2 - 3, y2 - 3)-(x2 + 18, y2 + 18), 16, B
 LINE (x2 - 4, y2 - 4)-(x2 + 19, y2 + 19), 16, B
 LINE (x2 - 5, y2 - 5)-(x2 + 20, y2 + 20), 16, B
 IF x2 < -13 AND level.5 = 0 THEN LINE (x2 - 1, y2 - 1)-(x2 + 16, y2 + 16), 16, BF: rx2 = (RND * 1 + 4): y2 = INT(RND * 189): x2 = 315
 IF x2 < -13 AND level.5 = 1 THEN a2 = 1: LINE (x2, y2)-(x2 + 15, y2 + 15), 16, BF
  x3 = x3 - rx3
  LINE (x3, y3)-(x3 + 10, y3 + 10), 114, BF
  LINE (x3 - 1, y3 - 1)-(x3 + 11, y3 + 11), 16, B
  LINE (x3 - 2, y3 - 2)-(x3 + 12, y3 + 12), 16, B
  LINE (x3 - 3, y3 - 3)-(x3 + 13, y3 + 13), 16, B
  LINE (x3 - 4, y3 - 4)-(x3 + 14, y3 + 14), 16, B
  LINE (x3 - 5, y3 - 5)-(x3 + 15, y3 + 15), 16, B
  LINE (x3 - 6, y3 - 6)-(x3 + 16, y3 + 16), 16, B
  IF x3 < -8 AND level.5 = 0 THEN LINE (x3 - 1, y3 - 1)-(x3 + 11, y3 + 11), 16, BF: rx3 = (RND * 1 + 5): y3 = INT(RND * 189): x3 = 315
  IF x3 < -8 AND level.5 = 1 THEN a3 = 1: LINE (x3, y3)-(x3 + 10, y3 + 10), 16, BF
   x4 = x4 - rx4
   LINE (x4, y4)-(x4 + 10, y4 + 10), 114, BF
   LINE (x4 - 1, y4 - 1)-(x4 + 11, y4 + 11), 16, B
   LINE (x4 - 2, y4 - 2)-(x4 + 12, y4 + 12), 16, B
   LINE (x4 - 3, y4 - 3)-(x4 + 13, y4 + 13), 16, B
   LINE (x4 - 4, y4 - 4)-(x4 + 14, y4 + 14), 16, B
   LINE (x4 - 5, y4 - 5)-(x4 + 15, y4 + 15), 16, B
   LINE (x4 - 6, y4 - 6)-(x4 + 16, y4 + 16), 16, B
   IF x4 < -8 AND level.5 = 0 THEN LINE (x4 - 1, y4 - 1)-(x4 + 11, y4 + 11), 16, BF: rx4 = (RND * 1 + 5): y4 = INT(RND * 189): x4 = 315
   IF x4 < -8 AND level.5 = 1 THEN a4 = 1: LINE (x4, y4)-(x4 + 10, y4 + 10), 16, BF
    x5 = x5 - rx5
    LINE (x5, y5)-(x5 + 10, y5 + 10), 114, BF
    LINE (x5 - 1, y5 - 1)-(x5 + 11, y5 + 11), 16, B
    LINE (x5 - 2, y5 - 2)-(x5 + 12, y5 + 12), 16, B
    LINE (x5 - 3, y5 - 3)-(x5 + 13, y5 + 13), 16, B
    LINE (x5 - 4, y5 - 4)-(x5 + 14, y5 + 14), 16, B
    LINE (x5 - 5, y5 - 5)-(x5 + 15, y5 + 15), 16, B
    LINE (x5 - 6, y5 - 6)-(x5 + 16, y5 + 16), 16, B
    IF x5 < -8 AND level.5 = 0 THEN LINE (x5 - 1, y5 - 1)-(x5 + 11, y5 + 11), 16, BF: rx5 = (RND * 1 + 5): y5 = INT(RND * 189): x5 = 315
    IF x5 < -8 AND level.5 = 1 THEN a5 = 1: LINE (x5, y5)-(x5 + 10, y5 + 10), 16, BF
     x6 = x6 - rx6
     LINE (x6, y6)-(x6 + 10, y6 + 10), 114, BF
     LINE (x6 - 1, y6 - 1)-(x6 + 11, y6 + 11), 16, B
     LINE (x6 - 2, y6 - 2)-(x6 + 12, y6 + 12), 16, B
     LINE (x6 - 3, y6 - 3)-(x6 + 13, y6 + 13), 16, B
     LINE (x6 - 4, y6 - 4)-(x6 + 14, y6 + 14), 16, B
     LINE (x6 - 5, y6 - 5)-(x6 + 15, y6 + 15), 16, B
     LINE (x6 - 6, y6 - 6)-(x6 + 16, y6 + 16), 16, B
     IF x6 < -8 AND level.5 = 0 THEN LINE (x6 - 1, y6 - 1)-(x6 + 11, y6 + 11), 16, BF: rx6 = (RND * 1 + 5): y6 = INT(RND * 189): x6 = 315
     IF x6 < -8 AND level.5 = 1 THEN a6 = 1: LINE (x6, y6)-(x6 + 10, y6 + 10), 16, BF
      x7 = x7 - rx7
      LINE (x7, y7)-(x7 + 15, y7 + 15), 115, BF
      LINE (x7 - 1, y7 - 1)-(x7 + 16, y7 + 16), 16, B
      LINE (x7 - 2, y7 - 2)-(x7 + 17, y7 + 17), 16, B
      LINE (x7 - 3, y7 - 3)-(x7 + 18, y7 + 18), 16, B
      LINE (x7 - 4, y7 - 4)-(x7 + 19, y7 + 19), 16, B
      LINE (x7 - 5, y7 - 5)-(x7 + 20, y7 + 20), 16, B
      IF x7 < -13 AND level.5 = 1 THEN a7 = 1: LINE (x7, y7)-(x7 + 15, y7 + 15), 16, BF
      IF x7 < -13 AND level.5 = 0 THEN LINE (x7 - 1, y7 - 1)-(x7 + 16, y7 + 16), 16, BF: rx7 = (RND * 1 + 4): y7 = INT(RND * 189): x7 = 315
IF cheating < 3 THEN
IF x > x1 - 5 AND x < x1 + 16 AND y > y1 - 5 AND y < y1 + 16 OR x > x2 - 5 AND x < x2 + 16 AND y > y2 - 5 AND y < y2 + 16 OR x > x7 - 5 AND x < x7 + 16 AND y > y7 - 5 AND y < y7 + 16 THEN CALL Die(x, y): GOTO TheMenu
IF x > x3 - 5 AND x < x3 + 11 AND y > y3 - 5 AND y < y3 + 11 OR x > x4 - 5 AND x < x4 + 11 AND y > y4 - 5 AND y < y4 + 11 OR x > x5 - 5 AND x < x5 + 11 AND y > y5 - 5 AND y < y5 + 11 OR x > x6 - 5 AND x < x6 + 11 AND y > y6 - 5 AND y < y6 + 11 THEN CALL Die(x, y): GOTO TheMenu
END IF
IF this > DifLev * 4 THEN level.5 = 1
IF a1 = 1 AND a2 = 1 AND a3 = 1 AND a4 = 1 AND a5 = 1 AND a6 = 1 AND a7 = 1 THEN a1 = 0: a2 = 0: a3 = 0: a4 = 0: a5 = 0: a6 = 0: a7 = 0: level = 5: Clip2: ReadyScreen: GOTO level5
GOTO main
level5: '555555555555555555555555555555555555555555555555555555555555555555555555
this = this + 1
x1 = x1 - rx1
LINE (x1, y1)-(x1 + 20, y1 + 20), 114, BF
LINE (x1 - 1, y1 - 1)-(x1 + 21, y1 + 21), 16, B
LINE (x1 - 2, y1 - 2)-(x1 + 22, y1 + 22), 16, B
IF x1 < -13 THEN LINE (x1 - 1, y1 - 1)-(x1 + 21, y1 + 21), 16, BF: rx1 = (RND * 1 + 1): y1 = INT(RND * 189): x1 = 315
 x2 = x2 - rx2
 LINE (x2, y2)-(x2 + 20, y2 + 20), 114, BF
 LINE (x2 - 1, y2 - 1)-(x2 + 21, y2 + 21), 16, B
 LINE (x2 - 2, y2 - 2)-(x2 + 22, y2 + 22), 16, B
 IF x2 < -13 THEN LINE (x2 - 1, y2 - 1)-(x2 + 21, y2 + 21), 16, BF: rx2 = (RND * 1 + 1): y2 = INT(RND * 189): x2 = 315
  x3 = x3 - rx3
  LINE (x3, y3)-(x3 + 15, y3 + 15), 113, BF
  LINE (x3 - 1, y3 - 1)-(x3 + 16, y3 + 16), 16, B
  LINE (x3 - 2, y3 - 2)-(x3 + 17, y3 + 17), 16, B
  LINE (x3 - 3, y3 - 3)-(x3 + 18, y3 + 18), 16, B
  IF x3 < -8 THEN LINE (x3 - 1, y3 - 1)-(x3 + 16, y3 + 16), 16, BF: rx3 = (RND * 1 + 2): y3 = INT(RND * 189): x3 = 315
   x4 = x4 - rx4
   LINE (x4, y4)-(x4 + 15, y4 + 15), 113, BF
   LINE (x4 - 1, y4 - 1)-(x4 + 16, y4 + 16), 16, B
   LINE (x4 - 2, y4 - 2)-(x4 + 17, y4 + 17), 16, B
   LINE (x4 - 3, y4 - 3)-(x4 + 18, y4 + 18), 16, B
   IF x4 < -8 THEN LINE (x4 - 1, y4 - 1)-(x4 + 16, y4 + 16), 16, BF: rx4 = (RND * 1 + 2): y4 = INT(RND * 189): x4 = 315
    x5 = x5 - rx5
    LINE (x5, y5)-(x5 + 15, y5 + 15), 113, BF
    LINE (x5 - 1, y5 - 1)-(x5 + 16, y5 + 16), 16, B
    LINE (x5 - 2, y5 - 2)-(x5 + 17, y5 + 17), 16, B
    LINE (x5 - 3, y5 - 3)-(x5 + 18, y5 + 18), 16, B
    IF x5 < -8 THEN LINE (x5 - 1, y5 - 1)-(x5 + 16, y5 + 16), 16, BF: rx5 = (RND * 1 + 2): y5 = INT(RND * 189): x5 = 315
     x6 = x6 - rx6
     LINE (x6, y6)-(x6 + 15, y6 + 15), 113, BF
     LINE (x6 - 1, y6 - 1)-(x6 + 16, y6 + 16), 16, B
     LINE (x6 - 2, y6 - 2)-(x6 + 17, y6 + 17), 16, B
     LINE (x6 - 3, y6 - 3)-(x6 + 18, y6 + 18), 16, B
     IF x6 < -8 THEN LINE (x6 - 1, y6 - 1)-(x6 + 16, y6 + 16), 16, BF: rx6 = (RND * 1 + 2): y6 = INT(RND * 189): x6 = 315
      x7 = x7 - rx7
      LINE (x7, y7)-(x7 + 20, y7 + 20), 114, BF
      LINE (x7 - 1, y7 - 1)-(x7 + 21, y7 + 21), 16, B
      LINE (x7 - 2, y7 - 2)-(x7 + 22, y7 + 22), 16, B
      IF x7 < -13 THEN LINE (x7 - 1, y7 - 1)-(x7 + 21, y7 + 21), 16, BF: rx7 = (RND * 1 + 1): y7 = INT(RND * 189): x7 = 315
IF cheating < 3 THEN
IF x > x1 - 5 AND x < x1 + 21 AND y > y1 - 5 AND y < y1 + 21 OR x > x2 - 5 AND x < x2 + 21 AND y > y2 - 5 AND y < y2 + 21 OR x > x7 - 5 AND x < x7 + 21 AND y > y7 - 5 AND y < y7 + 21 THEN CALL Die(x, y): GOTO TheMenu
IF x > x3 - 5 AND x < x3 + 16 AND y > y3 - 5 AND y < y3 + 16 OR x > x4 - 5 AND x < x4 + 16 AND y > y4 - 5 AND y < y4 + 16 OR x > x5 - 5 AND x < x5 + 16 AND y > y5 - 5 AND y < y5 + 16 OR x > x6 - 5 AND x < x6 + 16 AND y > y6 - 5 AND y < y6 + 16 THEN CALL Die(x, y): GOTO TheMenu
END IF
IF this > DifLev * 5 THEN level = 6: GOTO level6
GOTO main
level6: '666666666666666666666666666666666666666666666666666666666666666666666666666
this = this + 1
x1 = x1 - rx1
LINE (x1, y1)-(x1 + 20, y1 + 20), 114, BF
LINE (x1 - 1, y1 - 1)-(x1 + 21, y1 + 21), 16, B
LINE (x1 - 2, y1 - 2)-(x1 + 22, y1 + 22), 16, B
LINE (x1 - 3, y1 - 3)-(x1 + 23, y1 + 23), 16, B
LINE (x1 - 4, y1 - 4)-(x1 + 24, y1 + 24), 16, B
LINE (x1 - 5, y1 - 5)-(x1 + 25, y1 + 25), 16, B
IF x1 < -13 AND level.7 = 0 THEN LINE (x1 - 1, y1 - 1)-(x1 + 21, y1 + 21), 16, BF: rx1 = (RND * 1 + 4): y1 = INT(RND * 189): x1 = 315
IF x1 < -13 AND level.7 = 1 THEN a1 = 1: LINE (x1, y1)-(x1 + 20, y1 + 20), 16, BF
 x2 = x2 - rx2
 LINE (x2, y2)-(x2 + 20, y2 + 20), 114, BF
 LINE (x2 - 1, y2 - 1)-(x2 + 21, y2 + 21), 16, B
 LINE (x2 - 2, y2 - 2)-(x2 + 22, y2 + 22), 16, B
 LINE (x2 - 3, y2 - 3)-(x2 + 23, y2 + 23), 16, B
 LINE (x2 - 4, y2 - 4)-(x2 + 24, y2 + 24), 16, B
 LINE (x2 - 5, y2 - 5)-(x2 + 25, y2 + 25), 16, B
 IF x2 < -13 AND level.7 = 0 THEN LINE (x2 - 1, y2 - 1)-(x2 + 21, y2 + 21), 16, BF: rx2 = (RND * 1 + 4): y2 = INT(RND * 189): x2 = 315
 IF x2 < -13 AND level.7 = 1 THEN a2 = 1: LINE (x2, y2)-(x2 + 20, y2 + 20), 16, BF
  x3 = x3 - rx3
  LINE (x3, y3)-(x3 + 15, y3 + 15), 113, BF
  LINE (x3 - 1, y3 - 1)-(x3 + 16, y3 + 16), 16, B
  LINE (x3 - 2, y3 - 2)-(x3 + 17, y3 + 17), 16, B
  LINE (x3 - 3, y3 - 3)-(x3 + 18, y3 + 18), 16, B
  LINE (x3 - 4, y3 - 4)-(x3 + 19, y3 + 19), 16, B
  LINE (x3 - 5, y3 - 5)-(x3 + 20, y3 + 20), 16, B
  LINE (x3 - 6, y3 - 6)-(x3 + 21, y3 + 21), 16, B
  IF x3 < -8 AND level.7 = 0 THEN LINE (x3 - 1, y3 - 1)-(x3 + 16, y3 + 16), 16, BF: rx3 = (RND * 1 + 5): y3 = INT(RND * 189): x3 = 315
  IF x3 < -8 AND level.7 = 1 THEN a3 = 1: LINE (x3, y3)-(x3 + 15, y3 + 15), 16, BF
   x4 = x4 - rx4
   LINE (x4, y4)-(x4 + 15, y4 + 15), 113, BF
   LINE (x4 - 1, y4 - 1)-(x4 + 16, y4 + 16), 16, B
   LINE (x4 - 2, y4 - 2)-(x4 + 17, y4 + 17), 16, B
   LINE (x4 - 3, y4 - 3)-(x4 + 18, y4 + 18), 16, B
   LINE (x4 - 4, y4 - 4)-(x4 + 19, y4 + 19), 16, B
   LINE (x4 - 5, y4 - 5)-(x4 + 20, y4 + 20), 16, B
   LINE (x4 - 6, y4 - 6)-(x4 + 21, y4 + 21), 16, B
   IF x4 < -8 AND level.7 = 0 THEN LINE (x4 - 1, y4 - 1)-(x4 + 16, y4 + 16), 16, BF: rx4 = (RND * 1 + 5): y4 = INT(RND * 189): x4 = 315
   IF x4 < -8 AND level.7 = 1 THEN a4 = 1: LINE (x4, y4)-(x4 + 15, y4 + 15), 16, BF
    x5 = x5 - rx5
    LINE (x5, y5)-(x5 + 15, y5 + 15), 113, BF
    LINE (x5 - 1, y5 - 1)-(x5 + 16, y5 + 16), 16, B
    LINE (x5 - 2, y5 - 2)-(x5 + 17, y5 + 17), 16, B
    LINE (x5 - 3, y5 - 3)-(x5 + 18, y5 + 18), 16, B
    LINE (x5 - 4, y5 - 4)-(x5 + 19, y5 + 19), 16, B
    LINE (x5 - 5, y5 - 5)-(x5 + 20, y5 + 20), 16, B
    LINE (x5 - 6, y5 - 6)-(x5 + 21, y5 + 21), 16, B
    IF x5 < -8 AND level.7 = 0 THEN LINE (x5 - 1, y5 - 1)-(x5 + 16, y5 + 16), 16, BF: rx5 = (RND * 1 + 5): y5 = INT(RND * 189): x5 = 315
    IF x5 < -8 AND level.7 = 1 THEN a5 = 1: LINE (x5, y5)-(x5 + 15, y5 + 15), 16, BF
     x6 = x6 - rx6
     LINE (x6, y6)-(x6 + 15, y6 + 15), 113, BF
     LINE (x6 - 1, y6 - 1)-(x6 + 16, y6 + 16), 16, B
     LINE (x6 - 2, y6 - 2)-(x6 + 17, y6 + 17), 16, B
     LINE (x6 - 3, y6 - 3)-(x6 + 18, y6 + 18), 16, B
     LINE (x6 - 4, y6 - 4)-(x6 + 19, y6 + 19), 16, B
     LINE (x6 - 5, y6 - 5)-(x6 + 20, y6 + 20), 16, B
     LINE (x6 - 6, y6 - 6)-(x6 + 21, y6 + 21), 16, B
     IF x6 < -8 AND level.7 = 0 THEN LINE (x6 - 1, y6 - 1)-(x6 + 16, y6 + 16), 16, BF: rx6 = (RND * 1 + 5): y6 = INT(RND * 189): x6 = 315
     IF x6 < -8 AND level.7 = 1 THEN a6 = 1: LINE (x6, y6)-(x6 + 15, y6 + 15), 16, BF
      x7 = x7 - rx7
      LINE (x7, y7)-(x7 + 20, y7 + 20), 114, BF
      LINE (x7 - 1, y7 - 1)-(x7 + 21, y7 + 21), 16, B
      LINE (x7 - 2, y7 - 2)-(x7 + 22, y7 + 22), 16, B
      LINE (x7 - 3, y7 - 3)-(x7 + 23, y7 + 23), 16, B
      LINE (x7 - 4, y7 - 4)-(x7 + 24, y7 + 24), 16, B
      LINE (x7 - 5, y7 - 5)-(x7 + 25, y7 + 25), 16, B
      IF x7 < -13 AND level.7 = 1 THEN a7 = 1: LINE (x7, y7)-(x7 + 20, y7 + 20), 16, BF
      IF x7 < -13 AND level.7 = 0 THEN LINE (x7 - 1, y7 - 1)-(x7 + 21, y7 + 21), 16, BF: rx7 = (RND * 1 + 4): y7 = INT(RND * 189): x7 = 315
IF cheating < 3 THEN
IF x > x1 - 5 AND x < x1 + 21 AND y > y1 - 5 AND y < y1 + 21 OR x > x2 - 5 AND x < x2 + 21 AND y > y2 - 5 AND y < y2 + 21 OR x > x7 - 5 AND x < x7 + 21 AND y > y7 - 5 AND y < y7 + 21 THEN CALL Die(x, y): GOTO TheMenu
IF x > x3 - 5 AND x < x3 + 16 AND y > y3 - 5 AND y < y3 + 16 OR x > x4 - 5 AND x < x4 + 16 AND y > y4 - 5 AND y < y4 + 16 OR x > x5 - 5 AND x < x5 + 16 AND y > y5 - 5 AND y < y5 + 16 OR x > x6 - 5 AND x < x6 + 16 AND y > y6 - 5 AND y < y6 + 16 THEN CALL Die(x, y): GOTO TheMenu
END IF
IF this > DifLev * 6 THEN level.7 = 1
IF a1 = 1 AND a2 = 1 AND a3 = 1 AND a4 = 1 AND a5 = 1 AND a6 = 1 AND a7 = 1 THEN a1 = 0: a2 = 0: a3 = 0: a4 = 0: a5 = 0: a6 = 0: a7 = 0: level = 7: Clip3: ReadyScreen: GOTO level7
GOTO main
level7:
this = this + 1
x1 = x1 - rx1
LINE (x1, y1)-(x1 + 25, y1 + 25), 115, BF
LINE (x1 - 1, y1 - 1)-(x1 + 26, y1 + 26), 16, B
LINE (x1 - 2, y1 - 2)-(x1 + 27, y1 + 27), 16, B
IF x1 < -13 THEN LINE (x1 - 1, y1 - 1)-(x1 + 26, y1 + 26), 16, BF: rx1 = (RND * 1 + 1): y1 = INT(RND * 189): x1 = 315
 x2 = x2 - rx2
 LINE (x2, y2)-(x2 + 25, y2 + 25), 115, BF
 LINE (x2 - 1, y2 - 1)-(x2 + 26, y2 + 26), 16, B
 LINE (x2 - 2, y2 - 2)-(x2 + 27, y2 + 27), 16, B
 IF x2 < -13 THEN LINE (x2 - 1, y2 - 1)-(x2 + 26, y2 + 26), 16, BF: rx2 = (RND * 1 + 1): y2 = INT(RND * 189): x2 = 315
  x3 = x3 - rx3
  LINE (x3, y3)-(x3 + 20, y3 + 20), 114, BF
  LINE (x3 - 1, y3 - 1)-(x3 + 21, y3 + 21), 16, B
  LINE (x3 - 2, y3 - 2)-(x3 + 22, y3 + 22), 16, B
  LINE (x3 - 3, y3 - 3)-(x3 + 23, y3 + 23), 16, B
  IF x3 < -8 THEN LINE (x3 - 1, y3 - 1)-(x3 + 21, y3 + 21), 16, BF: rx3 = (RND * 1 + 2): y3 = INT(RND * 189): x3 = 315
   x4 = x4 - rx4
   LINE (x4, y4)-(x4 + 20, y4 + 20), 114, BF
   LINE (x4 - 1, y4 - 1)-(x4 + 21, y4 + 21), 16, B
   LINE (x4 - 2, y4 - 2)-(x4 + 22, y4 + 22), 16, B
   LINE (x4 - 3, y4 - 3)-(x4 + 23, y4 + 23), 16, B
   IF x4 < -8 THEN LINE (x4 - 1, y4 - 1)-(x4 + 21, y4 + 21), 16, BF: rx4 = (RND * 1 + 2): y4 = INT(RND * 189): x4 = 315
    x5 = x5 - rx5
    LINE (x5, y5)-(x5 + 20, y5 + 20), 114, BF
    LINE (x5 - 1, y5 - 1)-(x5 + 21, y5 + 21), 16, B
    LINE (x5 - 2, y5 - 2)-(x5 + 22, y5 + 22), 16, B
    LINE (x5 - 3, y5 - 3)-(x5 + 23, y5 + 23), 16, B
    IF x5 < -8 THEN LINE (x5 - 1, y5 - 1)-(x5 + 21, y5 + 21), 16, BF: rx5 = (RND * 1 + 2): y5 = INT(RND * 189): x5 = 315
     x6 = x6 - rx6
     LINE (x6, y6)-(x6 + 20, y6 + 20), 114, BF
     LINE (x6 - 1, y6 - 1)-(x6 + 21, y6 + 21), 16, B
     LINE (x6 - 2, y6 - 2)-(x6 + 22, y6 + 22), 16, B
     LINE (x6 - 3, y6 - 3)-(x6 + 23, y6 + 23), 16, B
     IF x6 < -8 THEN LINE (x6 - 1, y6 - 1)-(x6 + 21, y6 + 21), 16, BF: rx6 = (RND * 1 + 2): y6 = INT(RND * 189): x6 = 315
      x7 = x7 - rx7
      LINE (x7, y7)-(x7 + 25, y7 + 25), 115, BF
      LINE (x7 - 1, y7 - 1)-(x7 + 26, y7 + 26), 16, B
      LINE (x7 - 2, y7 - 2)-(x7 + 27, y7 + 27), 16, B
      IF x7 < -13 THEN LINE (x7 - 1, y7 - 1)-(x7 + 26, y7 + 26), 16, BF: rx7 = (RND * 1 + 1): y7 = INT(RND * 189): x7 = 315
IF cheating < 3 THEN
IF x > x1 - 5 AND x < x1 + 26 AND y > y1 - 5 AND y < y1 + 26 OR x > x2 - 5 AND x < x2 + 26 AND y > y2 - 5 AND y < y2 + 26 OR x > x7 - 5 AND x < x7 + 26 AND y > y7 - 5 AND y < y7 + 26 THEN CALL Die(x, y): GOTO TheMenu
IF x > x3 - 5 AND x < x3 + 21 AND y > y3 - 5 AND y < y3 + 21 OR x > x4 - 5 AND x < x4 + 21 AND y > y4 - 5 AND y < y4 + 21 OR x > x5 - 5 AND x < x5 + 21 AND y > y5 - 5 AND y < y5 + 21 OR x > x6 - 5 AND x < x6 + 21 AND y > y6 - 5 AND y < y6 + 21 THEN CALL Die(x, y): GOTO TheMenu
END IF
IF this > DifLev * 7 THEN level = 8: GOTO level8
GOTO main
level8:
this = this + 1
x1 = x1 - rx1
LINE (x1, y1)-(x1 + 25, y1 + 25), 115, BF
LINE (x1 - 1, y1 - 1)-(x1 + 26, y1 + 26), 16, B
LINE (x1 - 2, y1 - 2)-(x1 + 27, y1 + 27), 16, B
LINE (x1 - 3, y1 - 3)-(x1 + 28, y1 + 28), 16, B
LINE (x1 - 4, y1 - 4)-(x1 + 29, y1 + 29), 16, B
LINE (x1 - 5, y1 - 5)-(x1 + 30, y1 + 30), 16, B
IF x1 < -13 AND level.9 = 0 THEN LINE (x1 - 1, y1 - 1)-(x1 + 26, y1 + 26), 16, BF: rx1 = (RND * 1 + 4): y1 = INT(RND * 189): x1 = 315
IF x1 < -13 AND level.9 = 1 THEN a1 = 1: LINE (x1, y1)-(x1 + 25, y1 + 25), 16, BF
 x2 = x2 - rx2
 LINE (x2, y2)-(x2 + 25, y2 + 25), 115, BF
 LINE (x2 - 1, y2 - 1)-(x2 + 26, y2 + 26), 16, B
 LINE (x2 - 2, y2 - 2)-(x2 + 27, y2 + 27), 16, B
 LINE (x2 - 3, y2 - 3)-(x2 + 28, y2 + 28), 16, B
 LINE (x2 - 4, y2 - 4)-(x2 + 29, y2 + 29), 16, B
 LINE (x2 - 5, y2 - 5)-(x2 + 30, y2 + 30), 16, B
 IF x2 < -13 AND level.9 = 0 THEN LINE (x2 - 1, y2 - 1)-(x2 + 26, y2 + 26), 16, BF: rx2 = (RND * 1 + 4): y2 = INT(RND * 189): x2 = 315
 IF x2 < -13 AND level.9 = 1 THEN a2 = 1: LINE (x2, y2)-(x2 + 25, y2 + 25), 16, BF
  x3 = x3 - rx3
  LINE (x3, y3)-(x3 + 20, y3 + 20), 114, BF
  LINE (x3 - 1, y3 - 1)-(x3 + 21, y3 + 21), 16, B
  LINE (x3 - 2, y3 - 2)-(x3 + 22, y3 + 22), 16, B
  LINE (x3 - 3, y3 - 3)-(x3 + 23, y3 + 23), 16, B
  LINE (x3 - 4, y3 - 4)-(x3 + 24, y3 + 24), 16, B
  LINE (x3 - 5, y3 - 5)-(x3 + 25, y3 + 25), 16, B
  LINE (x3 - 6, y3 - 6)-(x3 + 26, y3 + 26), 16, B
  IF x3 < -8 AND level.9 = 0 THEN LINE (x3 - 1, y3 - 1)-(x3 + 21, y3 + 21), 16, BF: rx3 = (RND * 1 + 5): y3 = INT(RND * 189): x3 = 315
  IF x3 < -8 AND level.9 = 1 THEN a3 = 1: LINE (x3, y3)-(x3 + 20, y3 + 20), 16, BF
   x4 = x4 - rx4
   LINE (x4, y4)-(x4 + 20, y4 + 20), 114, BF
   LINE (x4 - 1, y4 - 1)-(x4 + 21, y4 + 21), 16, B
   LINE (x4 - 2, y4 - 2)-(x4 + 22, y4 + 22), 16, B
   LINE (x4 - 3, y4 - 3)-(x4 + 23, y4 + 23), 16, B
   LINE (x4 - 4, y4 - 4)-(x4 + 24, y4 + 24), 16, B
   LINE (x4 - 5, y4 - 5)-(x4 + 25, y4 + 25), 16, B
   LINE (x4 - 6, y4 - 6)-(x4 + 26, y4 + 26), 16, B
   IF x4 < -8 AND level.9 = 0 THEN LINE (x4 - 1, y4 - 1)-(x4 + 21, y4 + 21), 16, BF: rx4 = (RND * 1 + 5): y4 = INT(RND * 189): x4 = 315
   IF x4 < -8 AND level.9 = 1 THEN a4 = 1: LINE (x4, y4)-(x4 + 20, y4 + 20), 16, BF
    x5 = x5 - rx5
    LINE (x5, y5)-(x5 + 20, y5 + 20), 114, BF
    LINE (x5 - 1, y5 - 1)-(x5 + 21, y5 + 21), 16, B
    LINE (x5 - 2, y5 - 2)-(x5 + 22, y5 + 22), 16, B
    LINE (x5 - 3, y5 - 3)-(x5 + 23, y5 + 23), 16, B
    LINE (x5 - 4, y5 - 4)-(x5 + 24, y5 + 24), 16, B
    LINE (x5 - 5, y5 - 5)-(x5 + 25, y5 + 25), 16, B
    LINE (x5 - 6, y5 - 6)-(x5 + 26, y5 + 26), 16, B
    IF x5 < -8 AND level.9 = 0 THEN LINE (x5 - 1, y5 - 1)-(x5 + 21, y5 + 21), 16, BF: rx5 = (RND * 1 + 5): y5 = INT(RND * 189): x5 = 315
    IF x5 < -8 AND level.9 = 1 THEN a5 = 1: LINE (x5, y5)-(x5 + 20, y5 + 20), 16, BF
     x6 = x6 - rx6
     LINE (x6, y6)-(x6 + 20, y6 + 20), 114, BF
     LINE (x6 - 1, y6 - 1)-(x6 + 21, y6 + 21), 16, B
     LINE (x6 - 2, y6 - 2)-(x6 + 22, y6 + 22), 16, B
     LINE (x6 - 3, y6 - 3)-(x6 + 23, y6 + 23), 16, B
     LINE (x6 - 4, y6 - 4)-(x6 + 24, y6 + 24), 16, B
     LINE (x6 - 5, y6 - 5)-(x6 + 25, y6 + 25), 16, B
     LINE (x6 - 6, y6 - 6)-(x6 + 26, y6 + 26), 16, B
     IF x6 < -8 AND level.9 = 0 THEN LINE (x6 - 1, y6 - 1)-(x6 + 21, y6 + 21), 16, BF: rx6 = (RND * 1 + 5): y6 = INT(RND * 189): x6 = 315
     IF x6 < -8 AND level.9 = 1 THEN a6 = 1: LINE (x6, y6)-(x6 + 20, y6 + 20), 16, BF
      x7 = x7 - rx7
      LINE (x7, y7)-(x7 + 25, y7 + 25), 115, BF
      LINE (x7 - 1, y7 - 1)-(x7 + 26, y7 + 26), 16, B
      LINE (x7 - 2, y7 - 2)-(x7 + 27, y7 + 27), 16, B
      LINE (x7 - 3, y7 - 3)-(x7 + 28, y7 + 28), 16, B
      LINE (x7 - 4, y7 - 4)-(x7 + 29, y7 + 29), 16, B
      LINE (x7 - 5, y7 - 5)-(x7 + 30, y7 + 30), 16, B
      IF x7 < -13 AND level.9 = 1 THEN a7 = 1: LINE (x7, y7)-(x7 + 25, y7 + 25), 16, BF
      IF x7 < -13 AND level.9 = 0 THEN LINE (x7 - 1, y7 - 1)-(x7 + 26, y7 + 26), 16, BF: rx7 = (RND * 1 + 4): y7 = INT(RND * 189): x7 = 315
IF cheating < 3 THEN
IF x > x1 - 5 AND x < x1 + 26 AND y > y1 - 5 AND y < y1 + 26 OR x > x2 - 5 AND x < x2 + 26 AND y > y2 - 5 AND y < y2 + 26 OR x > x7 - 5 AND x < x7 + 26 AND y > y7 - 5 AND y < y7 + 26 THEN CALL Die(x, y): GOTO TheMenu
IF x > x3 - 5 AND x < x3 + 21 AND y > y3 - 5 AND y < y3 + 21 OR x > x4 - 5 AND x < x4 + 21 AND y > y4 - 5 AND y < y4 + 21 OR x > x5 - 5 AND x < x5 + 21 AND y > y5 - 5 AND y < y5 + 21 OR x > x6 - 5 AND x < x6 + 21 AND y > y6 - 5 AND y < y6 + 21 THEN CALL Die(x, y): GOTO TheMenu
END IF
IF this > DifLev * 8 THEN level.9 = 1
IF a1 = 1 AND a2 = 1 AND a3 = 1 AND a4 = 1 AND a5 = 1 AND a6 = 1 AND a7 = 1 THEN a1 = 0: a2 = 0: a3 = 0: a4 = 0: a5 = 0: a6 = 0: a7 = 0: level = 9: GOTO Level9
GOTO main
Level9:
EndItCool
GOTO TheMenu
END
main:
       LINE (x, y)-(x + 4, y + 4), 42, BF
       FOR Uh = 1 TO speed
       NEXT Uh
       LINE (x - 1, y - 1)-(x + 5, y + 5), 16, B
       LINE (x - 2, y - 2)-(x + 6, y + 6), 16, B
       IF dir$ = "up" AND y > 0 AND level = 1 OR dir$ = "up" AND y > 0 AND level = 3 OR dir$ = "up" AND y > 0 AND level = 5 OR dir$ = "up" AND y > 0 AND level = 7 THEN y = y - 1
       IF dir$ = "down" AND y < 195 AND level = 1 OR dir$ = "down" AND y < 195 AND level = 3 OR dir$ = "down" AND y < 195 AND level = 5 OR dir$ = "down" AND y < 195 AND level = 7 THEN y = y + 1
       IF dir$ = "up" AND y > 0 AND level = 2 OR dir$ = "up" AND y > 0 AND level = 4 OR dir$ = "up" AND y > 0 AND level = 6 OR dir$ = "up" AND y > 0 AND level = 8 THEN y = y - 2
       IF dir$ = "down" AND y < 195 AND level = 2 OR dir$ = "down" AND y < 195 AND level = 4 OR dir$ = "down" AND y < 195 AND level = 6 OR dir$ = "down" AND y < 195 AND level = 8 THEN y = y + 2
       IF y < 2 THEN dir$ = "down"
       IF y > 188 THEN dir$ = "up"
IF level = 8 THEN GOTO level8
IF level = 7 THEN GOTO level7
IF level = 6 THEN GOTO level6
IF level = 5 THEN GOTO level5
IF level = 4 THEN GOTO level4
IF level = 3 THEN GOTO level3
IF level = 2 THEN GOTO level2
IF level = 1 THEN GOTO level1

SUB AskSp
SHARED speed
retard:
SCREEN 12
CLS
COLOR 15
PRINT "Enter a speed between 0 and 10000"
PRINT "0 is the fastest, and 10000 is the slowest"
PRINT "0 is also the default."
PRINT
INPUT "So what will it be? ", speed
IF speed < 0 OR speed > 10000 THEN GOTO retard
END SUB

SUB Clip1
KEY(0) OFF
SCREEN 13
CLS
 FOR Stars = 1 TO 100
 Sx = INT(RND * 320)
 Sy = INT(RND * 200)
 Sc = INT(RND * 15 + 16)
 PSET (Sx, Sy), Sc
 NEXT Stars
FOR Lroids = 1 TO 150
Ax = INT(RND * 80)
Ay = INT(RND * 200)
Ac = INT(RND * 2 + 113)
IF Ac = 113 THEN PSET (Ax, Ay), Ac
IF Ac = 114 THEN LINE (Ax, Ay)-(Ax + 1, Ay + 1), Ac, BF

NEXT Lroids

FOR Rroids = 1 TO 150
Ax = INT(RND * 80 + 240)
Ay = INT(RND * 200)
Ac = INT(RND * 2 + 114)
IF Ac = 114 THEN LINE (Ax, Ay)-(Ax + 1, Ay + 1), Ac, BF
IF Ac = 115 THEN LINE (Ax, Ay)-(Ax + 2, Ay + 2), Ac, BF
NEXT Rroids
  Ux = 83
  Uy = 100
  PSET (Ux, Uy), 42
      FOR Stall = 1 TO 10000
      NEXT Stall
  DO
  FOR slow = 1 TO 700
  NEXT slow
  PSET (Ux, Uy), 16
  Ux = Ux + 1
  PSET (Ux, Uy), 42
  LOOP UNTIL Ux > 232
fade
SCREEN 9
SCREEN 13
KEY(0) ON
END SUB

SUB Clip2
KEY(0) OFF
SCREEN 13
CLS
 FOR Stars = 1 TO 100
 Sx = INT(RND * 320)
 Sy = INT(RND * 200)
 Sc = INT(RND * 15 + 16)
 PSET (Sx, Sy), Sc
 NEXT Stars
FOR Lroids = 1 TO 150
Ax = INT(RND * 80)
Ay = INT(RND * 200)
Ac = INT(RND * 2 + 114)
IF Ac = 114 THEN LINE (Ax, Ay)-(Ax + 1, Ay + 1), Ac, BF
IF Ac = 115 THEN LINE (Ax, Ay)-(Ax + 2, Ay + 2), Ac, BF
NEXT Lroids

FOR Rroids = 1 TO 150
Ax = INT(RND * 80 + 240)
Ay = INT(RND * 200)
Ac = INT(RND * 2 + 113)
IF Ac = 113 THEN LINE (Ax, Ay)-(Ax + 2, Ay + 2), Ac, BF
IF Ac = 114 THEN LINE (Ax, Ay)-(Ax + 3, Ay + 3), Ac, BF
NEXT Rroids
  Ux = 83
  Uy = 100
  PSET (Ux, Uy), 42
      FOR Stall = 1 TO 10000
      NEXT Stall
  DO
  FOR slow = 1 TO 700
  NEXT slow
  PSET (Ux, Uy), 16
  Ux = Ux + 1
  PSET (Ux, Uy), 42
  LOOP UNTIL Ux > 232
fade
SCREEN 9
SCREEN 13
KEY(0) ON
END SUB

SUB Clip3
KEY(0) OFF
SCREEN 13
CLS
 FOR Stars = 1 TO 100
 Sx = INT(RND * 320)
 Sy = INT(RND * 200)
 Sc = INT(RND * 15 + 16)
 PSET (Sx, Sy), Sc
 NEXT Stars
FOR Lroids = 1 TO 150
Ax = INT(RND * 80)
Ay = INT(RND * 200)
Ac = INT(RND * 2 + 113)
IF Ac = 113 THEN LINE (Ax, Ay)-(Ax + 2, Ay + 2), Ac, BF
IF Ac = 114 THEN LINE (Ax, Ay)-(Ax + 3, Ay + 3), Ac, BF
NEXT Lroids

FOR Rroids = 1 TO 150
Ax = INT(RND * 80 + 240)
Ay = INT(RND * 200)
Ac = INT(RND * 2 + 114)
IF Ac = 114 THEN LINE (Ax, Ay)-(Ax + 3, Ay + 3), Ac, BF
IF Ac = 115 THEN LINE (Ax, Ay)-(Ax + 4, Ay + 4), Ac, BF
NEXT Rroids
  Ux = 83
  Uy = 100
  PSET (Ux, Uy), 42
      FOR Stall = 1 TO 10000
      NEXT Stall
  DO
  FOR slow = 1 TO 700
  NEXT slow
  PSET (Ux, Uy), 16
  Ux = Ux + 1
  PSET (Ux, Uy), 42
  LOOP UNTIL Ux > 232
fade
SCREEN 9
SCREEN 13
KEY(0) ON
END SUB

SUB Die (x, y)
KEY(0) OFF
  s = 37
  explode = 0
  FOR explode = 1 TO 5
  CIRCLE (x + 2, y + 2), explode, 40
  SOUND s, 1
  s = s + 10
  NEXT explode
  FOR explode = 6 TO 10
  CIRCLE (x + 2, y + 2), explode, 41
  SOUND s, 1
  s = s + 10
  NEXT explode
 
  FOR explode = 11 TO 15
  CIRCLE (x + 2, y + 2), explode, 42
  SOUND s, 1
  s = s + 10
  NEXT explode
  FOR explode = 16 TO 20
  CIRCLE (x + 2, y + 2), explode, 43
  SOUND s, 1
  s = s + 10
  NEXT explode
 
  FOR explode = 21 TO 25
  CIRCLE (x + 2, y + 2), explode, 44
  SOUND s, 1
  s = s + 10
  NEXT explode
  FOR explode = 26 TO 30
  CIRCLE (x + 2, y + 2), explode, 45
  SOUND s, 1
  s = s + 10
  NEXT explode
   
    FOR explode2 = 1 TO 31
    CIRCLE (x + 2, y + 2), explode, 16
    explode = explode - 1
    SOUND s, 1
    s = s - 10
    NEXT explode2


KEY(0) ON
CLS
SCREEN 12: COLOR 15
whatsay = INT(RND * 3 + 1)
IF whatsay = 1 THEN
PRINT "You hit an astroid and are destroyed. The far off transport ship waits for"
PRINT "you patiently, yet you never arrive. They eventualy run out of oxygen and"
PRINT "slowly sufficate to death out in the middle of space. The ship is found"
PRINT "many years later by another race of beings. They dispose of the bodies, and"
PRINT "use the ship to haul the garbage of thier planet into the far off reaches"
PRINT "of space. Your race of people is now extinct and forgotten."
END IF

IF whatsay = 2 THEN
PRINT "Your ship is destroyed by an astroid. Your people wait for you inside of"
PRINT "the transport ship hoping you will make it. After many hours of sitting"
PRINT "there, a huge astroid slowly floats past them and they are pulled down into"
PRINT "it by its powerful gravitational force. The transport ship breaks apart"
PRINT "when it crashes into the astroid and the people fly helplessly into space"
PRINT "dieing quickly in the soundless, lightless, astroid field. There is no"
PRINT "survivors of your species. You are forgotten and extinct."
END IF

IF whatsay = 3 THEN
PRINT "The transport ship waits as you crash into an astroid and are killed. An"
PRINT "enemy ship you missed on your last mission, also picks up the SOS signal"
PRINT "sent by the transport ship. It passes through the astroid field unharmed"
PRINT "right after you foolishly plunged head on into a floating rock! It single"
PRINT "handedly destroys the helpless ship and gets its revenge on the species"
PRINT "that killed its own. It reforms an army and goes through out the universe"
PRINT "slaughtering all living creatures, becoming the only race alive. You, and"
PRINT "every other race except the enemy are now dead. Look what you did!"
END IF

LOCATE 13, 1
PRINT "If you have no clue to what this has to do with anything, then watch the intro!"
IF whatsay = 3 THEN
LOCATE 14, 1
PRINT "                      And get Space Quest 1!"
END IF
LOCATE 20, 20
PRINT "-----Press ESC to Continue-----"
DO
LOOP UNTIL INKEY$ = CHR$(27)
END SUB

SUB EndIt
KEY(0) OFF
SCREEN 12: COLOR 15: CLS
PRINT "Thank you for downloading! I hope you enjoyed this game! If you have"
PRINT "any comments, questions, or if you want some of my other games,"
PRINT "then e-mail me at TOM672 on AOL."
PRINT
PRINT "If you don't have Space Quest 1 then e-mail me. You get to fight a"
PRINT "bunch of enemies."
PRINT
PRINT "---------------------------------Credits-----------------------------------"
PRINT "Writer----------   Tom Ford"
PRINT "Lead Programer--   Thomas Ford"
PRINT "Producer--------   Thomas"
PRINT "Artist----------   Tom"
PRINT "Director--------   Mr. Ford"
PRINT "Camera Man------   Se"; CHR$(164); "or Ford"
PRINT "Special Thanks--   To Elcheapo Productions, for their cool screen fade!..."
PRINT "                   watch, just press any key!"
DO
LOOP UNTIL INKEY$ <> ""
fade
SCREEN 13
PRINT "Wasn't that just great!!!"
PRINT "You know it was."
PRINT "Thanks Elcheapo!!!"
END
END SUB

SUB EndItCool
KEY(0) OFF
SHARED DifLev, cheating
SCREEN 13
CLS
  FOR Stars = 1 TO 80
  Sx = INT(RND * 320)
  Sy = INT(RND * 200)
  Sc = INT(RND * 15 + 16)
  PSET (Sx, Sy), Sc
  NEXT Stars
x = 280
y = 100
LINE (x, y)-(x - 10, y - 10), 29
LINE (x, y)-(x - 10, y + 10), 29
LINE (x - 10, y - 10)-(x - 15, y - 10), 29
LINE (x - 10, y + 10)-(x - 15, y + 10), 29
LINE (x - 15, y - 10)-(x - 25, y - 15), 29
LINE (x - 15, y + 10)-(x - 25, y + 15), 29
LINE (x - 25, y - 15)-(x - 25, y + 15), 29
PAINT (x - 15, y), 29, 29
'LINE (x - 26, y - 1)-(x - 31, y - 6), 42
'LINE (x - 31, y - 6)-(x - 26, y - 11), 42
'LINE (x - 26, y - 11)-(x - 26, y - 1), 42
'LINE (x - 26, y + 1)-(x - 31, y + 6), 42
'LINE (x - 31, y + 6)-(x - 26, y + 11), 42
'LINE (x - 26, y + 11)-(x - 26, y + 1), 42
'PAINT (x - 27, y - 6), 42, 42
'PAINT (x - 27, y + 6), 42, 42
FOR HoldOn = 1 TO 20000
NEXT HoldOn
y1 = 100
FOR x1 = 1 TO 264
LINE (x1 - 1, y1 - 1)-(x1 + 5, y1 + 5), 16, B
y1 = y1 + .11
LINE (x1, y1)-(x1 + 4, y1 + 4), 42, BF
FOR Slower = 1 TO 300
NEXT Slower
NEXT x1
 DO
 LINE (x1 - 1, y1 + 5)-(x1 + 5, y1 + 5), 16, B
 y1 = y1 - 1
 LINE (x1, y1)-(x1 + 4, y1 + 4), 42, BF
 FOR Slower = 1 TO 800
 NEXT Slower
 LOOP UNTIL y1 < 112
    FOR dumb = 1 TO 10000
    NEXT dumb
   w = 5
   FOR InUh = 1 TO 6
   LINE (x1 - 1, y1 + w)-(x1 + 5, y1 + w), 16, B
   FOR Slower = 1 TO 3400
   NEXT Slower
   w = w - 1
   NEXT InUh
FOR JustWait = 1 TO 50000
NEXT JustWait
x = 280
y = 100
 DO
 LINE (x, y)-(x - 10, y - 10), 29
 LINE (x, y)-(x - 10, y + 10), 29
 LINE (x - 10, y - 10)-(x - 15, y - 10), 29
 LINE (x - 10, y + 10)-(x - 15, y + 10), 29
 LINE (x - 15, y - 10)-(x - 25, y - 15), 29
 LINE (x - 15, y + 10)-(x - 25, y + 15), 29
 LINE (x - 25, y - 15)-(x - 25, y + 15), 29
 LINE (x - 26, y - 1)-(x - 31, y - 6), 42
 LINE (x - 31, y - 6)-(x - 26, y - 11), 42
 LINE (x - 26, y - 11)-(x - 26, y - 1), 42
 LINE (x - 26, y + 1)-(x - 31, y + 6), 42
 LINE (x - 31, y + 6)-(x - 26, y + 11), 42
 LINE (x - 26, y + 11)-(x - 26, y + 1), 42
 PAINT (x - 27, y - 6), 42, 42
 PAINT (x - 27, y + 6), 42, 42
     FOR LookGood = 1 TO 1000
     NEXT LookGood
 PSET (x - 26, y), 26
 LINE (x - 27, y)-(x - 32, y - 6), 16
 LINE (x - 32, y - 6)-(x - 27, y - 11), 16
 LINE (x - 27, y)-(x - 32, y + 6), 16
 LINE (x - 32, y + 6)-(x - 27, y + 11), 16
  LINE (x - 26, y - 15)-(x - 26, y - 12), 16
  LINE (x - 26, y + 15)-(x - 26, y + 12), 16
  x = x + 1
 LOOP UNTIL x > 350
x1 = INT(RND * 300)
x2 = INT(RND * 300)
x3 = INT(RND * 300)
x4 = INT(RND * 300)
x5 = INT(RND * 300)
 y1 = INT(RND * 100 - 120)
 y2 = INT(RND * 100 - 120)
 y3 = INT(RND * 100 - 120)
 y4 = INT(RND * 100 - 120)
 y5 = INT(RND * 100 - 120)
  FOR Dang = 1 TO 1200
  LINE (x1, y1)-(x1 + 20, y1 + 20), 114, BF
  LINE (x2, y2)-(x2 + 20, y2 + 20), 114, BF
  LINE (x3, y3)-(x3 + 20, y3 + 20), 114, BF
  LINE (x4, y4)-(x4 + 20, y4 + 20), 115, BF
  LINE (x5, y5)-(x5 + 20, y5 + 20), 115, BF
  LINE (x1 - 1, y1 - 1)-(x1 + 21, y1 + 21), 16, B
  LINE (x2 - 1, y2 - 1)-(x2 + 21, y2 + 21), 16, B
  LINE (x3 - 1, y3 - 1)-(x3 + 21, y3 + 21), 16, B
  LINE (x4 - 1, y4 - 1)-(x4 + 21, y4 + 21), 16, B
  LINE (x5 - 1, y5 - 1)-(x5 + 21, y5 + 21), 16, B
    y1 = y1 + 1
    y2 = y2 + 1
    y3 = y3 + 1
    y4 = y4 + 1
    y5 = y5 + 1
     IF y1 > 202 THEN y1 = -20: x1 = INT(RND * 300)
     IF y2 > 202 THEN y2 = -20: x2 = INT(RND * 300)
     IF y3 > 202 THEN y3 = -20: x3 = INT(RND * 300)
     IF y4 > 202 THEN y4 = -20: x4 = INT(RND * 300)
     IF y5 > 202 THEN y5 = -20: x5 = INT(RND * 300)
  NEXT Dang
fade
SCREEN 9
SCREEN 12: COLOR 15
IF DifLev = 1000 AND cheating < 3 THEN
PRINT "You have saved your people and your race has survived. You recolonize"
PRINT "on a new planet, and live a long, prosperous life. You have won..."
PRINT "but you won on the Easy mode, so that's not really winning the game."
PRINT "You tried to take the easy way out of things, and that's not how you"
PRINT "should do it! Because of this I will only tell you one letter of the"
PRINT "secret cheat code, that letter is O. If you want the rest then beat the "
PRINT "game on hard mode. Best of luck!"
END IF
IF DifLev = 3000 AND cheating < 3 THEN
PRINT "You have saved your people and your race has survived. You recolonize"
PRINT "on a new planet, and live a long, prosperous life. But you don't have"
PRINT "the cheat code. You don't have it because you didn't play on hard mode;"
PRINT "sorry, I don't give away the code to people who take the easy way out."
PRINT "But, since you won something, I will tell you two letters of the code."
PRINT "They are M and O. Beat the game on hard. Good luck."
END IF
IF DifLev = 5000 AND cheating < 3 THEN
PRINT "You have saved your people and your race has survived. You recolonize"
PRINT "on a new planet, and live a long, prosperous life. Congradulations!!!"
PRINT "You actually won one hard mode!!! Are you ready for the code? Do you"
PRINT "think you can handle it? Well anyway, it is T O M. Just type that in"
PRINT "while you are playing, and nothing will harm you! I don't know why you"
PRINT "need it now, but enjoy! Have fun and by the way...your the best!"
PRINT "Well actually I am, but that's not the point!"
END IF
IF cheating = 3 THEN
PRINT "Hey! You cheated! That's no fun! Just for that, I'm not going to tell"
PRINT "the secret code....hey...wait a minute....you already have the code!"
PRINT "Now you made me really mad! Press ESC to go to a secret level!"
DO
LOOP UNTIL INKEY$ = CHR$(27)
PRINT
PRINT "Your really dumb to fall for that one!!! HA HA HA!!!"
PRINT "Your helpless now, there is nothing you can do!"
PRINT "Your stuck, because the program has ended, and"
PRINT "as soon as you press a button, you will be back in the "
PRINT "same place you started! This is your reward for trying so"
PRINT "hard to get the code...now I am beginning to feel sorry, "
PRINT "but it's too late. What's done is done! Thanks for playing!"
PRINT "Hope you had fun! Did you really think I would make a secret"
PRINT "level for cheaters like yourself! Well think again!"
END
END IF
LOCATE 20, 10
PRINT "Press SPACE to continue..."
DO
LOOP UNTIL INKEY$ = " "
CLS
KEY(0) ON
END SUB

SUB fade
CL = 115
        FOR FD = 0 TO 63
                FOR F = 0 TO CL
                        OUT &H3C7, F
                        R = INP(&H3C9) - 1: IF R = -1 THEN R = 0
                        G = INP(&H3C9) - 1: IF G = -1 THEN G = 0
                        B = INP(&H3C9) - 1: IF B = -1 THEN B = 0
                        OUT &H3C8, F
                        OUT &H3C9, R
                        OUT &H3C9, G
                        OUT &H3C9, B
                NEXT F
        NEXT FD
END SUB

SUB Instruct
KEY(0) OFF                                                                            '
SCREEN 12                                                                             '
CLS                                                                                   '
COLOR 15                                                                              '
                                                                                      '
PRINT "------------------------------------CONTROLS------------------------------------"
PRINT "To move up press "; CHR$(24)
PRINT "To move down press "; CHR$(25)
PRINT "To stop press RIGHT SHIFT"
PRINT
PRINT "--------------------------------OBJECT OF THE GAME------------------------------"
PRINT "Don't be hit by any of the astroids or you will die...that's pretty much it."
PRINT "The astroids will get faster and bigger, so watch out! Make it to the end of the"
PRINT "astroid field, and save the transport ship to win the game....you will get a"
PRINT "cheat code when you win!!!"
PRINT
PRINT "---------------------------OTHER STUFF ABOUT THIS GAME--------------------------"
PRINT "When you hit the bottom or top of the screen, you will bounce off in the other"
PRINT "direction. I did that because the astroids don't go there very often, and it"
PRINT "is easy to just stay in that spot the whole entire game...sorry no cheating..."
PRINT "unless you win and get the cheat codes of course!!!"
PRINT
PRINT "--------------------------ABOUT ME AND EVEN MORE STUFF--------------------------"
PRINT "My name is Thomas Ford, and I am 14 years old. I live in Cathedral City in the"
PRINT "state of California (Cathedral City is right next to Palm Springs in case you"
PRINT "don't know). I've been programming on QBasic for a little more then a year...or"
PRINT "maybe it was more then two, I can't remember that far! Anyways my screen name is"
PRINT "TOM672. If you have any comments, questions, whatever, then E-mail me. If you"
PRINT "don't have Space Quest 1 and want it then find it in the software center under"
PRINT "development/programming, basic games. If you can't find it then E-mail me. Look"
PRINT "for more wonderful games by me in the future! Bye for now!"
PRINT "----------------------------------Press ESC-------------------------------------"
DO
LOOP UNTIL INKEY$ = CHR$(27)
CLS
KEY(0) ON
END SUB

SUB Intro
SCREEN 13
CLS
FOR FadeText = 16 TO 31
COLOR FadeText
 FOR slow = 1 TO 1000
 NEXT slow
LOCATE 1, 1
PRINT "        An unexpected threat"
LOCATE 2, 1
PRINT "      came from another galaxy."
NEXT FadeText
 FOR FadeText = 16 TO 30
 COLOR FadeText
 FOR slow = 1 TO 1000
 NEXT slow
 LOCATE 3, 1
 PRINT "   They came suddenly and quickly"
 LOCATE 4, 1
 PRINT "    in their heavily armed ships."
 NEXT FadeText
  FOR FadeText = 16 TO 29
  COLOR FadeText
 FOR slow = 1 TO 1000
 NEXT slow
  LOCATE 5, 1
  PRINT "Your people and planet were unprepared"
  LOCATE 6, 1
  PRINT " and were destroyed by the enemies..."
  NEXT FadeText
   FOR FadeText = 16 TO 28
   COLOR FadeText
 FOR slow = 1 TO 1000
 NEXT slow
   LOCATE 7, 1
   PRINT "         or so you thought."
   LOCATE 8, 1
   PRINT "                       "
   NEXT FadeText
    FOR FadeText = 16 TO 27
    COLOR FadeText
 FOR slow = 1 TO 1000
 NEXT slow
    LOCATE 9, 1
    PRINT " Several families boarded a transport"
    LOCATE 10, 1
    PRINT " ship. They left the planet before it"
    LOCATE 11, 1
    PRINT "        was demolished......"
    NEXT FadeText
     FOR FadeText = 16 TO 26
     COLOR FadeText
 FOR slow = 1 TO 1000
 NEXT slow
     LOCATE 13, 1
     PRINT "    but enemy craft was in pursuit"
     LOCATE 14, 1
     PRINT "           close behind..."
     NEXT FadeText
DO
LOOP UNTIL INKEY$ <> ""
fade
SCREEN 12
SCREEN 13
x = 240
y = 100
sx1 = INT(RND * 320)
sx2 = INT(RND * 320)
sx3 = INT(RND * 320)
sx4 = INT(RND * 320)
sx5 = INT(RND * 320)
sx6 = INT(RND * 320)
sx7 = INT(RND * 320)
sx8 = INT(RND * 320)
sx9 = INT(RND * 320)
sx10 = INT(RND * 320)
sy1 = INT(RND * 85)
sy2 = INT(RND * 85)
sy3 = INT(RND * 85)
sy4 = INT(RND * 85)
sy5 = INT(RND * 85)
sy6 = INT(RND * 85 + 115)
sy7 = INT(RND * 85 + 115)
sy8 = INT(RND * 85 + 115)
sy9 = INT(RND * 85 + 115)
sy10 = INT(RND * 85 + 115)
sc1 = INT(RND * 7 + 24)
sc2 = INT(RND * 7 + 24)
sc3 = INT(RND * 7 + 24)
sc4 = INT(RND * 7 + 24)
sc5 = INT(RND * 7 + 24)
sc6 = INT(RND * 7 + 24)
sc7 = INT(RND * 7 + 24)
sc8 = INT(RND * 7 + 24)
sc9 = INT(RND * 7 + 24)
sc10 = INT(RND * 7 + 24)
x1 = -10
x2 = -10
x3 = -10
nx1 = x - 20
nx2 = x - 20
y1 = 76
y2 = 101
y3 = 133
z = 7
w = 24
DO
  PSET (sx1, sy1), 16
  PSET (sx2, sy2), 16
  PSET (sx3, sy3), 16
  PSET (sx4, sy4), 16
  PSET (sx5, sy5), 16
  PSET (sx6, sy6), 16
  PSET (sx7, sy7), 16
  PSET (sx8, sy8), 16
  PSET (sx9, sy9), 16
  PSET (sx10, sy10), 16
    sx1 = sx1 - 1
    sx2 = sx2 - 1
    sx3 = sx3 - 1
    sx4 = sx4 - 1
    sx5 = sx5 - 1
    sx6 = sx6 - 1
    sx7 = sx7 - 1
    sx8 = sx8 - 1
    sx9 = sx9 - 1
    sx10 = sx10 - 1
       PSET (sx1, sy1), sc1
       PSET (sx2, sy2), sc2
       PSET (sx3, sy3), sc3
       PSET (sx4, sy4), sc4
       PSET (sx5, sy5), sc5
       PSET (sx6, sy6), sc6
       PSET (sx7, sy7), sc7
       PSET (sx8, sy8), sc8
       PSET (sx9, sy9), sc9
       PSET (sx10, sy10), sc10
   IF sx1 < -1 THEN sx1 = 320: sy1 = (RND * 85): sc1 = INT(RND * z + w)
   IF sx2 < -1 THEN sx2 = 320: sy2 = (RND * 85): sc2 = INT(RND * z + w)
   IF sx3 < -1 THEN sx3 = 320: sy3 = (RND * 85): sc3 = INT(RND * z + w)
   IF sx4 < -1 THEN sx4 = 320: sy4 = (RND * 85): sc4 = INT(RND * z + w)
   IF sx5 < -1 THEN sx5 = 320: sy5 = (RND * 85): sc5 = INT(RND * z + w)
   IF sx6 < -1 THEN sx6 = 320: sy6 = (RND * 85 + 115): sc6 = INT(RND * z + w)
   IF sx7 < -1 THEN sx7 = 320: sy7 = (RND * 85 + 115): sc7 = INT(RND * z + w)
   IF sx8 < -1 THEN sx8 = 320: sy8 = (RND * 85 + 115): sc8 = INT(RND * z + w)
   IF sx9 < -1 THEN sx9 = 320: sy9 = (RND * 85 + 115): sc9 = INT(RND * z + w)
   IF sx10 < -1 THEN sx10 = 320: sy10 = (RND * 85 + 115): sc10 = INT(RND * z + w)
IF x1 + 5 < nx1 THEN x1 = x1 + .084
IF x2 + 5 < nx1 THEN x2 = x2 + .088
IF x3 + 5 < nx1 THEN x3 = x3 + .08
 IF x1 + 5 > nx1 THEN x1 = x1 - 1
 IF x2 + 5 > nx1 THEN x2 = x2 - 1
 IF x3 + 5 > nx1 THEN x3 = x3 - 1
LINE (x, y)-(x - 10, y - 10), 29
LINE (x, y)-(x - 10, y + 10), 29
LINE (x - 10, y - 10)-(x - 15, y - 10), 29
LINE (x - 10, y + 10)-(x - 15, y + 10), 29
LINE (x - 15, y - 10)-(x - 25, y - 15), 29
LINE (x - 15, y + 10)-(x - 25, y + 15), 29
LINE (x - 25, y - 15)-(x - 25, y + 15), 29
PAINT (x - 15, y), 29, 29
LINE (x - 26, y - 1)-(x - 31, y - 6), 42
LINE (x - 31, y - 6)-(x - 26, y - 11), 42
LINE (x - 26, y - 11)-(x - 26, y - 1), 42
LINE (x - 26, y + 1)-(x - 31, y + 6), 42
LINE (x - 31, y + 6)-(x - 26, y + 11), 42
LINE (x - 26, y + 11)-(x - 26, y + 1), 42
PAINT (x - 27, y - 6), 42, 42
PAINT (x - 27, y + 6), 42, 42
   IF x1 > -5 THEN LINE (x1, y1)-(x1 + 5, y1 + 5), 40, BF
   LINE (x1 - 1, y1 - 1)-(x1 + 6, y1 + 6), 16, B
    IF x2 > -5 THEN LINE (x2, y2)-(x2 + 5, y2 + 5), 40, BF
    LINE (x2 - 1, y2 - 1)-(x2 + 6, y2 + 6), 16, B
     IF x3 > -5 THEN LINE (x3, y3)-(x3 + 5, y3 + 5), 40, BF
     LINE (x3 - 1, y3 - 1)-(x3 + 6, y3 + 6), 16, B
        IF x1 > 160 AND net = 0 THEN net = 1: nx1 = x - 32: ny1 = y: nx2 = nx1: ny2 = ny1
           IF net = 1 THEN
            LINE (nx1 - 2, ny1 - 2)-(nx1 + 2, ny1 + 2), 16, B
            LINE (nx2 - 2, ny2 - 2)-(nx2 + 2, ny2 + 2), 16, B
            LINE (nx1, ny1)-(nx2, ny2), 16
           IF ny1 > 40 THEN ny1 = ny1 - 1
           nx1 = nx1 - 1
           IF ny2 < 160 THEN ny2 = ny2 + 1
           nx2 = nx2 - 1
           LINE (nx1 - 1, ny1 - 1)-(nx1 + 1, ny1 + 1), 32, BF
           LINE (nx2 - 1, ny2 - 1)-(nx2 + 1, ny2 + 1), 32, BF
           LINE (nx1, ny1)-(nx2, ny2), 32
           END IF
            IF nx1 < -3 AND thereb = 0 THEN
            thereb = 1
            z = 3: w = 113
            rocks = 1
            net = 0: LINE (-6, -6)-(3, 200), 16, BF
            LINE (nx1 - 2, ny1 - 2)-(nx1 + 2, ny1 + 2), 16, B
            LINE (nx2 - 2, ny2 - 2)-(nx2 + 2, ny2 + 2), 16, B
            LINE (nx1, ny1)-(nx2, ny2), 16
            END IF
        IF rocks = 1 THEN
        rx1 = INT(RND * 320 + 320)
        ry1 = INT(RND * 60)
        rc1 = 113
        ra1 = (RND * 1 + 1)
         rx2 = INT(RND * 320 + 320)
         ry2 = INT(RND * 60)
         rc2 = 113
         ra2 = (RND * 1 + 1)
        rx3 = INT(RND * 320 + 320)
        ry3 = INT(RND * 60 + 135)
        rc3 = 113
        ra3 = (RND * 1 + 1)
         rx4 = INT(RND * 320 + 320)
         ry4 = INT(RND * 60 + 135)
         rc4 = 113
         ra4 = (RND * 1 + 1)
        rocks = 2
        END IF
       IF rocks = 2 THEN
       thisC = thisC + 1
       rx1 = rx1 - ra1
       LINE (rx1, ry1)-(rx1 + 4, ry1 + 4), rc1, BF
       LINE (rx1 - 1, ry1 - 1)-(rx1 + 5, ry1 + 5), 16, B
       LINE (rx1 - 2, ry1 - 2)-(rx1 + 6, ry1 + 6), 16, B
       IF rx1 < -5 THEN rx1 = 321: ry1 = INT(RND * 60): ra1 = (RND * 1 + 1): LINE (rx1, ry1)-(rx1 + 4, ry1 + 4), 16, BF
        rx2 = rx2 - ra2
        LINE (rx2, ry2)-(rx2 + 4, ry2 + 4), rc2, BF
        LINE (rx2 - 1, ry2 - 1)-(rx2 + 5, ry2 + 5), 16, B
        LINE (rx2 - 2, ry2 - 2)-(rx2 + 6, ry2 + 6), 16, B
        IF rx2 < -5 THEN rx2 = 321: ry2 = INT(RND * 60): ra2 = (RND * 1 + 1): LINE (rx2, ry2)-(rx2 + 4, ry2 + 4), 16, BF
       rx3 = rx3 - ra3
       LINE (rx3, ry3)-(rx3 + 4, ry3 + 4), rc3, BF
       LINE (rx3 - 1, ry3 - 1)-(rx3 + 5, ry3 + 5), 16, B
       LINE (rx3 - 2, ry3 - 2)-(rx3 + 6, ry3 + 6), 16, B
       IF rx3 < -5 THEN rx3 = 321: ry3 = INT(RND * 60 + 135): ra3 = (RND * 1 + 1): LINE (rx3, ry3)-(rx3 + 4, ry3 + 4), 16, BF
        rx4 = rx4 - ra4
        LINE (rx4, ry4)-(rx4 + 4, ry4 + 4), rc4, BF
        LINE (rx4 - 1, ry4 - 1)-(rx4 + 5, ry4 + 5), 16, B
        LINE (rx4 - 2, ry4 - 2)-(rx4 + 6, ry4 + 6), 16, B
        IF rx4 < -5 THEN rx4 = 321: ry4 = INT(RND * 60 + 135): ra4 = (RND * 1 + 1): LINE (rx4, ry4)-(rx4 + 4, ry4 + 4), 16, BF
       END IF
LOOP UNTIL thisC > 900
CLS
 FOR FadeText = 16 TO 31
 COLOR FadeText
 FOR slow = 1 TO 1000
 NEXT slow
 LOCATE 1, 1
 PRINT " The transport ship was able to escape"
 LOCATE 2, 1
 PRINT "  some enemy ships using a space net,"
 NEXT FadeText
  FOR FadeText = 16 TO 30
  COLOR FadeText
 FOR slow = 1 TO 1000
 NEXT slow
  LOCATE 3, 1
  PRINT "   and then entered a giant astroid"
  LOCATE 4, 1
  PRINT "    field to hide from the others."
  NEXT FadeText
   FOR FadeText = 16 TO 29
 FOR slow = 1 TO 1000
 NEXT slow
   COLOR FadeText
   LOCATE 5, 1
   PRINT "  The transport ship had extra tough"
   LOCATE 6, 1
   PRINT " armor to protect it from astroid hits,"
   NEXT FadeText
    FOR FadeText = 16 TO 28
    COLOR FadeText
 FOR slow = 1 TO 1000
 NEXT slow
    LOCATE 7, 1
    PRINT "  but one astroid was able to puncture"
    LOCATE 8, 1
    PRINT " the fuel tank, and the ship lost power."
    NEXT FadeText
     FOR FadeText = 16 TO 27
     COLOR FadeText
 FOR slow = 1 TO 1000
 NEXT slow
     LOCATE 9, 1
     PRINT " Now...in a last attempt at survival..."
     LOCATE 10, 1
     PRINT "  the ship sends out an SOS signal..."
     LOCATE 11, 1
     PRINT "   so that someone might save them."
     NEXT FadeText
DO
LOOP UNTIL INKEY$ <> ""
fade
SCREEN 12
SCREEN 13
FOR SpaceStars = 1 TO 50
SSc = INT(RND * 15 + 16)
SSx = INT(RND * 320)
SSy = INT(RND * 200)
PSET (SSx, SSy), SSc
NEXT SpaceStars
  FOR Astroids = 1 TO 150
  Ac = INT(RND * 3 + 113)
  Ax = INT(RND * 320)
  Ay = INT(RND * 200)
  PSET (Ax, Ay), Ac
  NEXT Astroids
LINE (150, 90)-(170, 110), 16, BF
LINE (159, 100)-(161, 100), 29
LINE (158, 99)-(160, 101), 29, BF
OSx = 161
OSy = 99
 FOR Stall = 1 TO 100000
 NEXT Stall
  DO
  FOR slow = 1 TO 900
  NEXT slow
  PSET (OSx, OSy), 16
  OSx = OSx + 1
  PSET (OSx, OSy), 31
  LOOP UNTIL OSx > 340
fade
SCREEN 12
SCREEN 13
 FOR FadeText = 16 TO 31
 COLOR FadeText
 FOR slow = 1 TO 1000
 NEXT slow
 LOCATE 1, 1
 PRINT "You...after defeating all the enemies"
 LOCATE 2, 1
 PRINT " about an hour ago...pick up the SOS."
 NEXT FadeText
  FOR FadeText = 16 TO 30
  COLOR FadeText
 FOR slow = 1 TO 1000
 NEXT slow
  LOCATE 3, 1
  PRINT " You quickly turn your ship around,"
  LOCATE 4, 1
  PRINT " and head towards the astroid field."
  NEXT FadeText
   FOR FadeText = 16 TO 29
   COLOR FadeText
 FOR slow = 1 TO 1000
 NEXT slow
   LOCATE 7, 1
   PRINT "    YOU MUST SAVE YOUR PEOPLE..."
   LOCATE 8, 1
   PRINT "    OR ELSE YOUR KIND IS DOOMED!"
   NEXT FadeText
DO
LOOP UNTIL INKEY$ <> ""
fade
SCREEN 12
SCREEN 13
END SUB

SUB Menus
SHARED MenX, MenY, menu$, MenMove, HasSelected
CLS
KEY(15) ON
KEY(16) ON
KEY(17) ON

SCREEN 13
  FOR Stars = 1 TO 200
  MSx = INT(RND * 320)
  MSy = INT(RND * 200)
  MSc = INT(RND * 15 + 16)
  PSET (MSx, MSy), MSc
  NEXT Stars
     FOR roids = 1 TO 150
     MSx = INT(RND * 320)
     MSy = INT(RND * 200)
     MSc = INT(RND * 3 + 113)
     PSET (MSx, MSy), MSc
     NEXT roids
LOCATE 2, 1: COLOR 31
PRINT "    Use UP and DOWN to move cursor."
PRINT "     Press RIGHT SHIFT to select."
PRINT "      Turn CAPS and NUM lock off."

IF menu$ = "main" THEN
LOCATE 10, 18
PRINT "Play"
LOCATE 12, 18
PRINT "Instructions"
LOCATE 14, 18
PRINT "Introduction"
LOCATE 16, 18
PRINT "Adjust Speed"
LOCATE 18, 18
PRINT "Quit"

END IF
  IF menu$ = "play" THEN
  LOCATE 8, 10
  PRINT "Select the difficulty level."
  LOCATE 10, 18
  PRINT "Short cut (Easy)"
  LOCATE 12, 18
  PRINT "Normal path (Normal)"
  LOCATE 14, 18
  PRINT "Scenic route (Hard)"
  LOCATE 16, 18
  PRINT "Main menu"
  END IF
CurMove:
MenMove = 0
LINE (MenX - 2, MenY - 2)-(MenX + 2, MenY + 2), 42, BF

DO
IF MenMove = 1 THEN GOTO CurMove
IF HasSelected = 1 THEN GOTO Leave
LOOP

Leave:
KEY(15) OFF
KEY(16) OFF
KEY(17) OFF
END SUB

SUB ReadyScreen
KEY(0) OFF
SHARED x, y, dir$
y = 100
dir$ = "stop"
SCREEN 13
CLS
FOR Stars = 1 TO 300
Sx = INT(RND * 320)
Sy = INT(RND * 200)
Sc = INT(RND * 15 + 16)
PSET (Sx, Sy), Sc
NEXT Stars

LOCATE 10, 17: COLOR 28
PRINT "GET READY"
LOCATE 12, 17: COLOR 28
PRINT "PRESS ESC"
x = 180
y = 140
LINE (x, y)-(x - 10, y - 10), 29
LINE (x, y)-(x - 10, y + 10), 29
LINE (x - 10, y - 10)-(x - 15, y - 10), 29
LINE (x - 10, y + 10)-(x - 15, y + 10), 29
LINE (x - 15, y - 10)-(x - 25, y - 15), 29
LINE (x - 15, y + 10)-(x - 25, y + 15), 29
LINE (x - 25, y - 15)-(x - 25, y + 15), 29
PAINT (x - 15, y), 29, 29

DO
LOOP UNTIL INKEY$ = CHR$(27)
fade
SCREEN 9
SCREEN 13
x = 10
y = 98
KEY(0) ON
END SUB

