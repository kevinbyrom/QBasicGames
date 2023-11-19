RANDOMIZE TIMER
DEFINT A-Z

DIM b1(16161)
DIM tm$(30), hc(30), jc(30), p(47, 12), dr$(47), px(47), py(47), ol(30), dl(30), lr$(30), lrp(30), rr$(30), rrp(30), te$(30), tep(30), qb$(30), qbp(30), rb$(30), rbp(30)
DIM op1(30), op2(30), op3(30), op4(30), kc$(30), kcp(30)
DIM team$(30), wins(30), loss(30)
DIM dp1(30), dp2(30), dp3(30), db1(30), pnl(30)

OPEN "CURRENT.VAR" FOR INPUT AS #1
INPUT #1, leauge$
INPUT #1, player$
CLOSE #1

OPEN "standings" FOR INPUT AS #1
FOR x = 1 TO 30
INPUT #1, tm$(x)
INPUT #1, wins(x)
INPUT #1, loss(x)
NEXT
CLOSE #1

0 status$ = "exhibition"
clock = 400
speed = 0
player = 0
blitz$ = "off"
sc1 = 0: sc2 = 0
10 SCREEN 13
GOSUB 70000
COLOR 15
30 qq = 0: GOSUB 20000
IF load$ <> "loaded" THEN GOSUB 10000

IF status$ = "EXHIBITION" THEN GOTO 25

25 'EXHIBITION
FOR x = 1 TO 5
LOCATE 13 + x, 1: PRINT tm$(x)
NEXT

FOR x = 6 TO 10
LOCATE 8 + x, 11: PRINT tm$(x)
NEXT

FOR x = 11 TO 15
LOCATE 3 + x, 21: PRINT tm$(x)
NEXT

FOR x = 16 TO 20
LOCATE 4 + x, 1: PRINT tm$(x);
NEXT

FOR x = 21 TO 25
LOCATE x - 1, 11: PRINT tm$(x);
NEXT

FOR x = 26 TO 30
LOCATE x - 6, 21: PRINT tm$(x);
NEXT

COLOR 15
IF player$ = "COMPUTER" THEN LOCATE 14, 31: PRINT "COMPUTER": LOCATE 20, 31: PRINT "COMPUTER"
IF player$ = "ONE" THEN LOCATE 14, 31: PRINT "PLAYER ONE": LOCATE 20, 31: PRINT "COMPUTER"
IF player$ = "TWO" THEN LOCATE 14, 31: PRINT "PLAYER ONE": LOCATE 20, 31: PRINT "PLAYER TWO"

vl = 14
hl = 1

50 FOR x = 1 TO 5
   IF vl = x + 13 AND hl = 1 THEN ht = x
   IF vl = x + 13 AND hl = 11 THEN ht = x + 5
   IF vl = x + 13 AND hl = 21 THEN ht = x + 10
   IF vl = x + 19 AND hl = 1 THEN ht = x + 15
   IF vl = x + 19 AND hl = 11 THEN ht = x + 20
   IF vl = x + 19 AND hl = 21 THEN ht = x + 25
   NEXT


ht$ = tm$(ht)

GOSUB 75: GOTO 100

75 IF qq = 12 THEN GOTO 76
   LOCATE 16 + qq, 31: PRINT "          "
   LOCATE 16 + qq, 31: PRINT ht$
   IF qq = 0 THEN dr$ = "south": xx = 259: yy = 134: helmet = hc(ht): jersey = jc(ht): COLOR 2: LINE (257, 129)-(262, 129): LINE -(262, 135): LINE -(257, 135): LINE -(257, 129): PAINT (xx, yy): GOSUB 30000
   IF qq = 6 THEN dr$ = "south": xx = 259: yy = 182: helmet = hc(ht): jersey = jc(ht): COLOR 2: LINE (257, 177)-(262, 177): LINE -(262, 183): LINE -(257, 183): LINE -(257, 177): PAINT (xx, yy): GOSUB 30000
76 RETURN
 


100  COLOR 4: LOCATE vl, hl: PRINT ht$;
     a$ = INKEY$: IF a$ = "" THEN GOTO 100
     COLOR 15: LOCATE vl, hl: PRINT ht$;
     IF LEN(a$) = 2 THEN a$ = RIGHT$(a$, 1): GOTO 110
     IF ASC(a$) = 13 THEN qq = qq + 6: GOSUB 75: GOTO 200
     GOTO 100


110  IF ASC(a$) = 80 AND vl = 18 THEN vl = 14: GOTO 50
     IF ASC(a$) = 80 AND vl = 24 THEN vl = 20: GOTO 50
     IF ASC(a$) = 80 THEN vl = vl + 1: GOTO 50
     IF ASC(a$) = 72 AND vl = 14 THEN vl = 18: GOTO 50
     IF ASC(a$) = 72 AND vl = 20 THEN vl = 24: GOTO 50
     IF ASC(a$) = 72 THEN vl = vl - 1: GOTO 50
     IF ASC(a$) = 77 AND hl = 21 AND vl > 19 THEN hl = 1: vl = vl - 6: GOTO 50
     IF ASC(a$) = 77 AND hl = 21 THEN hl = 1: vl = vl + 6: GOTO 50
     IF ASC(a$) = 77 THEN hl = hl + 10: GOTO 50
     IF ASC(a$) = 75 AND hl = 1 AND vl > 19 THEN hl = 21: vl = vl - 6: GOTO 50
     IF ASC(a$) = 75 AND hl = 1 THEN hl = 21: vl = vl + 6: GOTO 50
     IF ASC(a$) = 75 THEN hl = hl - 10: GOTO 50
     GOTO 100

200 IF qq = 12 THEN GOTO 205
    home$ = ht$
    ht1 = ht
    GOTO 100

205 visitor$ = ht$
    vt1 = ht
    pl = ht1: cp = vt1
    tm1$ = home$
    tm2$ = visitor$
    
210 IF player$ = "ONE" THEN player = ht1
    IF player$ = "TWO" THEN player2 = vt1: player = ht1
    home$ = "": visitor$ = "": qq = 0: ht = 0: ht1 = 0: vt1 = 0
start: pause = 0
    GOSUB 71000
    GOSUB 20000
    LOCATE 14, 1: PRINT "coin toss..."
    dr$ = "south": yy = 5
300  xx = 160: z = 45: helmet = 15: jersey = 0: GOSUB 35000: GOSUB 30000
     xx = 150: z = 9: helmet = hc(pl): jersey = jc(pl): GOSUB 35000: GOSUB 30000
     xx = 170: z = 32: helmet = hc(cp): jersey = jc(cp): GOSUB 35000: GOSUB 30000
    
302  a! = TIMER
    
305  IF TIMER < a! THEN GOTO 302
     IF TIMER - a! > .1 THEN 310
     GOTO 305
310 IF yy > 49 THEN GOTO 315
    GOSUB 36000: xx = 160: z = 45: GOSUB 36000: xx = 150: z = 9: GOSUB 36000: yy = yy + 2
    GOTO 300

315 GOSUB 20000

LOCATE 14, 1: PRINT tm1$
LOCATE 14, 32: PRINT tm2$
LOCATE 15, 4: PRINT sc1
LOCATE 15, 35: PRINT sc2
LOCATE 17, 2: PRINT wins(pl); "-"; loss(pl): LOCATE 17, 33: PRINT wins(cp); "-"; loss(cp)
GOTO 325
320 xx = 170: z = 32: GOSUB 36000: xx = 160: z = 45: GOSUB 36000: xx = 150: z = 9: GOSUB 36000
    xx = 0: yy = 0
    RETURN

325 IF player = pl OR player = cp THEN pause = 1
    IF player2 = pl OR player2 = cp THEN pause = 1

500 GOSUB clock: IF gtm$ = "ot" THEN LOCATE 18, 1: PRINT "over time"
rr = INT(RND(1) * 100 + 1)
IF rr < 51 THEN team$ = tm$(pl): GOSUB clearer: LOCATE 19, 1: PRINT team$; ", win the toss !": GOSUB pause: GOSUB 320: team$ = "": GOTO 1000
IF rr > 50 THEN team$ = tm$(cp): GOSUB clearer: LOCATE 19, 1: PRINT team$; ", win the toss !": GOSUB pause: GOSUB 320: team$ = "": GOTO 2000

END
1000 REM opponent 2 kick off  cp=opp2    pl=opp1
     side = 2
     ty = 0: down = 1: ytg = 10
     vgr$ = "kickoff": hgr$ = "recieve"
     ydl = 19: GOSUB 50000
     ydl = 71: GOSUB 60000
     byd = 70: GOSUB 66000
     GOSUB clearer
     LOCATE 19, 1: PRINT tm2$; ", kick off."
1001 GOSUB pause
     IF byd >= 70 THEN ko1 = 5
     IF byd < 70 THEN ko1 = 4
     IF byd < 50 THEN ko1 = 3
     IF byd < 40 THEN ko1 = 2
     IF byd < 30 THEN ko1 = 1
     po = INT(kcp(cp) * 4)
     IF ko1 = 5 THEN ko = INT(RND(1) * 40 + po)
     IF ko1 = 4 THEN ko = INT(RND(1) * 30 + po)
     IF ko1 = 3 THEN ko = INT(RND(1) * 20 + po)
     IF ko1 = 2 THEN ko = INT(RND(1) * 10 + po)
     IF ko1 = 1 THEN ko = INT(RND(1) * 5 + po)
LOCATE 19, 1: PRINT "                                       "
LOCATE 19, 1: PRINT ko; " yard, kick off."
     GOSUB pause
     byd = byd - ko: IF byd < 1 THEN byd = 20: GOSUB clearer: LOCATE 19, 1: PRINT "touch back.": GOTO 1006
1005 ko1 = INT(RND(1) * rbp(pl) + 1) / 2
     byd = byd + ko1: ty = ty + ko1: IF byd > 99 THEN GOTO touchdown1
     ko1 = ol(pl)
     ko2 = dl(cp)
     ko3 = ko2 - ko1
     ko1 = INT(RND(1) * 20 + 1) + ko3
     ko2 = INT(RND(1) * 10 + 1) + rbp(pl)
     IF ko2 > ko1 THEN GOTO 1005
     IF ko2 - ko1 < -9 THEN GOSUB clearer: LOCATE 19, 1: PRINT "fumble !": GOSUB pause
     IF ko2 - ko1 < -9 THEN rr = INT(RND(1) * 100 + 1): IF rr > 50 THEN GOSUB clearer: LOCATE 19, 1: PRINT tm1$; " recover.": GOSUB pause: GOTO ft1
     IF ko2 - ko1 < -9 THEN GOSUB clearer: LOCATE 19, 1: PRINT tm2$; " recover.": GOSUB pause: GOTO 1800
ft1: GOSUB clearer
     LOCATE 19, 1: PRINT rb$(pl); ", "; ty; " yard return."
1006 GOSUB pause
     GOSUB clearer
     abyd = byd
     IF byd > 50 THEN abyd = 100 - byd
     LOCATE 19, 1: PRINT "Ball at the, "; abyd; " yard line."
     GOSUB pause
     GOSUB 70000
     GOSUB 65000

1100 REM start opponent 1 possession  pl
     ytg = 10: ty = 0: down = 1: side = 1: bn = 0
1103 IF clock < 1 THEN LOCATE 18, 1: PRINT "game over": GOTO stats
     IF player = pl THEN GOTO player
     IF player2 = pl THEN GOTO player

1104       rr = INT(RND(1) * 100 + 1)
           t1 = 1
           t2 = op1(pl)
           t3 = t2 + 1
           t4 = t2 + op2(pl)
           t5 = t4 + 1
           t6 = t4 + op3(pl)
           t7 = t6 + 1
           t8 = t6 + op4(pl)
           IF rr >= t1 AND rr <= t2 THEN GOTO 1104.05
           IF rr >= t3 AND rr <= t4 THEN GOTO 1104.15
           IF rr >= t5 AND rr <= t6 THEN GOTO 1104.25
           IF rr >= t7 AND rr <= t8 THEN GOTO 1104.35

1104.05    SB$ = rb$(pl): sbp = rbp(pl): hgr$ = "run"
           FOR x = 1 TO INT(ry1 / 100): sbp = rbp(pl) - x: bn = x: NEXT
           GOTO 1105

1104.15    aa$ = "short pass.": hgr$ = "s-pass"
           SB$ = te$(pl): sbp = tep(pl): py1 = 8: py2 = 1: hc = -2
           FOR x = 1 TO INT(rcs1 / 100):  hc = hc + x: bn = x: NEXT
           GOTO 1200

1104.25    aa$ = "medium pass.": hgr$ = "m-pass"
           SB$ = rr$(pl): sbp = rrp(pl): py1 = 9: py2 = 9: hc = 0
           FOR x = 1 TO INT(rcm1 / 100):  hc = hc + x: bn = x: NEXT
           GOTO 1200
      
1104.35    aa$ = "long pass.": hgr$ = "l-pass"
           SB$ = lr$(pl): sbp = lrp(pl): py1 = 10: py2 = 18: hc = 2
           FOR x = 1 TO INT(rcl1 / 100): hc = hc + x: bn = x: NEXT
           GOTO 1200


1105 REM ***** run *****
     IF byd < 1 THEN GOTO 1950
     GOSUB clock
     z = 2: GOSUB defcal
     IF player = cp THEN blitz$ = "off": GOSUB defense
     IF player2 = cp THEN blitz$ = "off": GOSUB defense
     z = 0
     IF a$ = "4-3" AND blitz$ = "on" THEN bn = bn + 3
     IF a$ = "4-3" AND blitz$ = "off" THEN bn = bn + 2
     IF a$ = "3-4" AND blitz$ = "on" THEN bn = bn + -3
     IF a$ = "3-4" AND blitz$ = "off" THEN bn = bn + -2
     IF a$ = "zone" AND blitz$ = "on" THEN rr = INT(RND(1) * 100 + 1): IF rr > 50 THEN bn = 1 ELSE bn = -1
     IF a$ = "zone" AND blitz$ = "off" THEN bn = 0
     GOSUB 70000: GOSUB 65000
     LOCATE 19, 1: PRINT "                                        "
     LOCATE 19, 1: PRINT "Hand off to, "; rb$(pl); "."
     GOSUB pause
     ko1 = 0: ty = 0
     rr = INT(RND(1) * 100 + 1): IF rr <= pnl(cp) THEN GOSUB clearer: LOCATE 19, 1: PRINT "defensive penalty.": down = down - 2: clock = clock + 2: GOTO 1116
     rr = INT(RND(1) * 100 + 1): IF rr <= pnl(pl) THEN GOSUB clearer: LOCATE 19, 1: PRINT "offensive penalty.": aa$ = "penalty": clock = clock + 2: GOTO 1116
1110 byd = byd + ko1: ty = ty + ko1: aa$ = "run": IF byd > 99 THEN GOTO touchdown1
     ko1 = ol(pl)
     ko2 = dl(cp) + bn
     ko3 = ko2 - ko1
     ko1 = INT(RND(1) * 20 + 1) + ko3
     ko2 = INT(RND(1) * 10 + 1) + sbp
     IF ko2 > ko1 THEN ko1 = INT(RND(1) * (sbp) / 3 + 1): GOTO 1110
     IF ko2 - ko1 < -10 THEN GOSUB clearer: LOCATE 19, 1: PRINT "fumble !": GOSUB pause
     IF ko2 - ko1 < -10 THEN rr = INT(RND(1) * 100 + 1): IF rr > 50 THEN GOSUB clearer: LOCATE 19, 1: PRINT tm1$; ", recover.": GOSUB pause: GOTO 1115
     IF ko2 - ko1 < -10 THEN GOSUB clearer: LOCATE 19, 1: PRINT tm2$; ", recover.": r1turn = r1turn + 1: GOSUB pause: GOTO 1800
     IF ko2 - ko1 > -11 AND ko2 - ko1 < -5 THEN ko1 = INT(RND(1) * 3 - 1): byd = byd + ko1: ty = ty + ko1: aa$ = "run": IF byd > 99 THEN GOTO touchdown1
1115 GOSUB clearer
     IF ty < 1 THEN LOCATE 19, 1: PRINT "Stopped cold by the defense.": GOSUB pause
     IF ty > 7 THEN LOCATE 19, 1: PRINT "nice run...": GOSUB pause
     IF ty > 0 AND ty < 8 THEN LOCATE 19, 1: PRINT "He powers through the defense.": GOSUB pause
     GOSUB clearer
     LOCATE 19, 1: PRINT rb$(pl); ", gains "; ty; " yards."
     IF gtm$ = "ot" THEN GOTO 1116
     ry1 = ry1 + ty
1116 GOSUB pause
     IF down = 4 AND aa$ = "penalty" THEN aa$ = "": GOTO 1600
1118 ytg = ytg - ty: IF ytg < 1 THEN ytg = 10: down = 1: GOTO 1120
     down = down + 1: IF down > 3 THEN GOTO 1600
     IF down < 1 THEN down = 1
1120 GOSUB 70000
     GOSUB 65000
     GOTO 1103
END


1200 REM ***** pass *****
     IF byd < 1 THEN GOTO 1950
     GOSUB clock
     z = 2: GOSUB defcal
     IF player = cp THEN blitz$ = "off": GOSUB defense
     IF player2 = cp THEN blitz$ = "off": GOSUB defense
     z = 0
     IF a$ = "4-3" AND blitz$ = "on" THEN bn = -3
     IF a$ = "4-3" AND blitz$ = "off" THEN bn = -2
     IF a$ = "3-4" AND blitz$ = "on" THEN bn = 3
     IF a$ = "3-4" AND blitz$ = "off" THEN bn = 2
     IF a$ = "zone" AND blitz$ = "on" THEN rr = INT(RND(1) * 100 + 1): IF rr > 50 THEN bn = 1:  ELSE bn = -1
     IF a$ = "zone" AND blitz$ = "off" THEN bn = 0
     GOSUB 70000: GOSUB 65000
     GOSUB clearer
     LOCATE 19, 1: PRINT qb$(pl); ", attemps a "; aa$
     GOSUB pause
     ko1 = 0: ty = 0
     rr = INT(RND(1) * 100 + 1): IF rr <= pnl(cp) THEN GOSUB clearer: LOCATE 19, 1: PRINT "defensive penalty.": down = down - 2: clock = clock + 2: GOTO 1216
     rr = INT(RND(1) * 100 + 1): IF rr <= pnl(pl) THEN GOSUB clearer: LOCATE 19, 1: PRINT "offensive penalty.": aa$ = "penalty": clock = clock + 2: GOTO 1216
1210 byd = byd + ko1: ty = ty + ko1: IF byd > 99 THEN GOTO touchdown1
     ko1 = ol(pl)
     ko2 = dl(cp) + bn
     ko3 = ko2 - ko1
     ko1 = INT(RND(1) * 10 + 1) + ko3
     ko2 = INT(RND(1) * 10 + 1) + (qbp(pl) - hc)
     IF ko2 > ko1 THEN GOTO 1220
     IF ko2 <= ko1 AND ko2 - ko1 >= -2 THEN GOSUB clearer: LOCATE 19, 1: PRINT "incomplete": GOTO 1216
     IF ko2 <= ko1 AND ko2 - ko1 < -2 THEN ko = 1 - INT(RND(1) * 5 + 1): ty = ty + ko: byd = byd + ko: GOSUB clearer: LOCATE 19, 1: PRINT qb$(pl); ", is sacked.": GOSUB pause: IF gtm$ = "ot" THEN GOSUB clock: GOSUB stats
1215 LOCATE 19, 1: GOSUB clearer: LOCATE 19, 1: PRINT qb$(pl); ", gains "; ty; " yards."
1216 GOSUB pause
     IF down = 4 AND aa$ = "penalty" THEN aa$ = "": GOTO 1600
1217 ytg = ytg - ty: IF ytg < 1 THEN ytg = 10: down = 1: GOTO 1219
1218 down = down + 1: IF down > 3 THEN GOTO 1600
     IF down < 1 THEN down = 1
1219 GOSUB 70000
     GOSUB 65000
     GOTO 1103
1220 rr = INT(RND(1) * dl(cp) + 1) + hc
     IF (qbp(pl) - bn) > rr THEN GOTO 1225
     GOSUB clearer: LOCATE 19, 1: PRINT "Bad pass, incomplete.": GOTO 1216
1225 GOSUB clearer: LOCATE 19, 1: PRINT "nice pass...": GOSUB pause
     ko1 = ol(pl)
     ko2 = dl(cp) + bn
     ko3 = ko2 - ko1
     ko1 = INT(RND(1) * 15 + 1) + ko3
     ko2 = INT(RND(1) * 10 + 1) + (sbp - hc)
     IF ko2 > ko1 THEN GOTO 1230
     IF ko2 <= ko1 AND ko2 - ko1 >= -7 THEN GOSUB clearer: LOCATE 19, 1: PRINT "Defense, swats the ball away.": GOTO 1216
     IF ko2 <= ko1 AND ko2 - ko1 < -7 THEN GOSUB clearer: LOCATE 19, 1: PRINT "Ball is intercepted !": p1turn = p1turn + 1: GOSUB pause: GOTO 1800
1230 GOSUB clearer: LOCATE 19, 1: PRINT "Pass caught by, "; SB$; ".": GOSUB pause
     rr = INT(RND(1) * py1 + py2)
1231 byd = byd + rr: ty = ty + rr: IF byd > 99 THEN GOTO touchdown1
     ko1 = ol(pl)
     ko2 = dl(cp) + bn
     ko3 = ko2 - ko1
     ko1 = INT(RND(1) * 20 + 1) + ko3
     ko2 = INT(RND(1) * 10 + 1) + sbp
     IF ko2 > ko1 THEN GOTO 1235
     IF ko2 <= ko1 THEN GOSUB clearer: LOCATE 19, 1: PRINT "A "; ty; " yard gain.": GOSUB pause: GOTO 1240

1235 rr = INT(RND(1) * (sbp / 3) + 1): GOTO 1231

1240 IF gmt$ = "ot" THEN GOTO 1217
     ps1 = ps1 + ty
     IF aa$ = "short pass." THEN rcs1 = rcs1 + ty
     IF aa$ = "medium pass." THEN rcm1 = rcm1 + ty
     IF aa$ = "long pass." THEN rcl1 = rcl1 + ty
     GOTO 1217



END

1600 REM kick field goal
     GOSUB 70000: GOSUB 65000
     r2 = 100 - byd
     IF down > 4 THEN GOTO 1800
     IF player = pl THEN GOTO player
     IF player2 = pl THEN GOTO player
     GOSUB clock
     r2 = 120 - byd
     IF r2 > INT(kcp(pl) * 6) THEN GOTO 1700
    
1602 hgr$ = "ogoal": vgr$ = "dgoal"
     GOSUB 70000: GOSUB 65000
     GOSUB clearer: LOCATE 19, 1: PRINT kc$(pl); ", Attemps a"; r2; "yarder.": GOSUB pause
     r1 = INT(kcp(pl) * 5)
     rr = INT(RND(1) * (r1 / 2.5) + r1)
     pp = INT(RND(1) * 100 + 1): IF pp < 5 THEN GOTO 1605
     IF rr >= r2 AND gtm$ = "ot" THEN GOSUB clearer: LOCATE 19, 1: PRINT "Field goal, good !": GOSUB pause: fg1 = fg1 + 3: sc1 = sc1 + 3: GOSUB clock: GOTO stats
     IF rr >= r2 THEN GOSUB clearer: LOCATE 19, 1: PRINT "Field goal, good !": GOSUB pause: fg1 = fg1 + 3: sc1 = sc1 + 3: GOSUB clock: GOSUB 70000: GOTO 2000
    
1605 GOSUB clearer: LOCATE 19, 1: PRINT "Field goal, no good.": GOSUB pause: GOSUB clock: GOSUB 70000: GOSUB 65000: GOTO 2100

1700 REM punt
     IF player = pl OR player2 = pl THEN GOTO 1705
     IF down = 4 AND ytg < 5 AND byd > 50 THEN GOTO 1103
1705 hgr$ = "punt"
     vgr$ = "return"
     GOSUB 70000: GOSUB 65000
     GOSUB clearer: LOCATE 19, 1: PRINT tm1$; ", punt.": GOSUB clock: GOTO 2001

1800 REM turnover
     GOSUB 70000: GOSUB 65000
     side = 2
     GOTO 2100

1950 REM safety
     GOSUB clearer: LOCATE 19, 1: PRINT "safety !": GOSUB pause
     hgr$ = "punt": vgr$ = "return"
     GOSUB 70000: GOSUB 65000
     sc2 = sc2 + 2: GOTO 2000
END
defense: a$ = INKEY$: IF a$ = "" THEN GOTO defense2
         a$ = ""
         GOTO defense
defense2: bn = 0
         GOSUB clearer
         LOCATE 19, 1: PRINT "1)4-3"
         LOCATE 20, 1: PRINT "2)ZONE"
         LOCATE 21, 1: PRINT "3)3-4"
         IF blitz$ = "off" THEN LOCATE 22, 1: PRINT "4)BLITZ OFF"
         IF blitz$ = "on" THEN LOCATE 22, 1: PRINT "4)BLITZ "; : COLOR 4: PRINT "ON": COLOR 15
1955     GOSUB clock: a$ = INKEY$: IF a$ = "" THEN GOTO 1955
         b$ = a$
         GOSUB clearer
         IF a$ = "4" AND blitz$ = "off" THEN blitz$ = "on": GOTO defense
         IF a$ = "4" AND blitz$ = "on" THEN blitz$ = "off": GOTO defense
         IF a$ = "1" THEN a$ = "4-3": IF z = 1 THEN hgr$ = a$:  ELSE vgr$ = a$
         IF a$ = "2" THEN a$ = "zone": IF z = 1 THEN hgr$ = a$:  ELSE vgr$ = a$
         IF a$ = "3" THEN a$ = "3-4": IF z = 1 THEN hgr$ = a$:  ELSE vgr$ = a$
         IF b$ = "1" OR b$ = "2" OR b$ = "3" THEN b$ = "": RETURN
         GOTO defense

END
defcal: a$ = ""
        rr1 = INT(RND(1) * 100 + 1)
        rr = INT(RND(1) * 100 + 1)
        t1 = 1
        t2 = dp1(z)
        t3 = t2 + 1
        t4 = t2 + dp2(z)
        t5 = t4 + 1
        t6 = t4 + dp3(z)
        IF rr1 <= db1(z) THEN blitz$ = "on" ELSE blitz$ = "off"
        IF rr >= t1 AND rr <= t2 THEN a$ = "4-3": IF z = 1 THEN hgr$ = a$ ELSE vgr$ = a$
        IF rr >= t3 AND rr <= t4 THEN a$ = "zone": IF z = 1 THEN hgr$ = a$ ELSE vgr$ = a$
        IF rr >= t5 AND rr <= t6 THEN a$ = "3-4": IF z = 1 THEN hgr$ = a$ ELSE vgr$ = a$
        RETURN


END
player: a$ = INKEY$: IF a$ = "" THEN GOTO player1
        a$ = ""
        GOTO player
player1: GOSUB clearer
        LOCATE 19, 1: PRINT "1)RUN"
        LOCATE 20, 1: PRINT "2)SHORT PASS"
        LOCATE 21, 1: PRINT "3)MEDIUM PASS"
        LOCATE 22, 1: PRINT "4)LONG PASS"
        LOCATE 23, 1: PRINT "5)FIELD GOAL"
        LOCATE 24, 1: PRINT "6)PUNT";
1960    GOSUB clock: a$ = INKEY$: IF a$ = "" THEN GOTO 1960
        GOSUB clearer
        IF a$ = "1" AND side = 1 THEN hgr$ = "run": GOTO 1104.05
        IF a$ = "1" AND side = 2 THEN vgr$ = "run": GOTO 2104.05
        IF a$ = "2" AND side = 1 THEN hgr$ = "s-pass": GOTO 1104.15
        IF a$ = "2" AND side = 2 THEN vgr$ = "s-pass": GOTO 2104.15
        IF a$ = "3" AND side = 1 THEN hgr$ = "m-pass": GOTO 1104.25
        IF a$ = "3" AND side = 2 THEN vgr$ = "m-pass": GOTO 2104.25
        IF a$ = "4" AND side = 1 THEN hgr$ = "l-pass": GOTO 1104.35
        IF a$ = "4" AND side = 2 THEN vgr$ = "l-pass": GOTO 2104.35
        IF a$ = "5" AND side = 1 THEN r2 = 120 - byd: IF r2 > INT(kcp(pl) * 8) THEN GOTO player
        IF a$ = "5" AND side = 2 THEN r2 = byd + 20: IF r2 > INT(kcp(cp) * 8) THEN GOTO player
        IF a$ = "5" AND side = 1 THEN GOTO 1602
        IF a$ = "5" AND side = 2 THEN GOTO 2602
        IF a$ = "6" AND down < 4 THEN GOTO player
        IF a$ = "6" AND side = 1 THEN GOTO 1700
        IF a$ = "6" AND side = 2 THEN GOTO 2700
        GOTO player
END

clearer: FOR x = 19 TO 24: LOCATE x, 1: PRINT "                                       "; : NEXT
         RETURN

END

touchdown1: GOSUB clearer
            ko = byd - 100
            ty = ty - ko
            IF gtm$ = "ot" THEN GOTO skip1
            IF aa$ = "run" THEN ry1 = ry1 + ty: ryp1 = ryp1 + 1
            IF aa$ = "short pass." THEN ps1 = ps1 + ty: rcs1 = rcs1 + ty: psp1 = psp1 + 1: rcsp1 = rcsp1 + 1
            IF aa$ = "medium pass." THEN ps1 = ps1 + ty: rcm1 = rcm1 + ty: psp1 = psp1 + 1: rcmp1 = rcmp1 + 1
            IF aa$ = "long pass." THEN ps1 = ps1 + ty: rcl1 = rcl1 + ty: psp1 = psp1 + 1: rclp1 = rclp1 + 1

skip1:      LOCATE 19, 1: PRINT SB$; ", gains "; ty; " yards."
            LOCATE 21, 1: PRINT "touch down !": GOSUB pause
            LOCATE 21, 1: PRINT "                   "
            IF gtm$ = "ot" THEN sc1 = sc1 + 7: GOSUB clock: GOTO stats
            sc1 = sc1 + 7: GOSUB clock: GOSUB 70000: GOTO 2000





END
2000 REM home kick off
     side = 1
     ty = 0: ytg = 10: down = 1
     hgr$ = "kickoff": vgr$ = "recieve"
     ydl = 29: GOSUB 50000
     ydl = 41: GOSUB 60000
     byd = 30: GOSUB 66000
     GOSUB clearer
     LOCATE 19, 1: PRINT tm1$; ", kick off."
2001 GOSUB pause
     IF byd <= 30 THEN ko1 = 5
     IF byd > 30 THEN ko1 = 4
     IF byd > 50 THEN ko1 = 3
     IF byd > 60 THEN ko1 = 2
     IF byd > 70 THEN ko1 = 1
     po = INT(kcp(pl) * 4)
     IF ko1 = 5 THEN ko = INT(RND(1) * 40 + po)
     IF ko1 = 4 THEN ko = INT(RND(1) * 30 + po)
     IF ko1 = 3 THEN ko = INT(RND(1) * 20 + po)
     IF ko1 = 2 THEN ko = INT(RND(1) * 10 + po)
     IF ko1 = 1 THEN ko = INT(RND(1) * 5 + po)
     GOSUB clearer
     LOCATE 19, 1: PRINT ko; " yard, kick off."
     GOSUB pause
     byd = byd + ko: IF byd > 99 THEN byd = 80: GOSUB clearer: LOCATE 19, 1: PRINT "touch back.": GOTO 2006
2005 ko1 = INT(RND(1) * rbp(cp) + 1) / 2
     byd = byd - ko1: ty = ty + ko1: IF byd < 1 THEN GOTO touchdown2
     ko1 = ol(cp)
     ko2 = dl(pl)
     ko3 = ko2 - ko1
     ko1 = INT(RND(1) * 20 + 1) + ko3
     ko2 = INT(RND(1) * 10 + 1) + rbp(cp)
     IF ko2 > ko1 THEN GOTO 2005
     IF ko2 - ko1 < -9 THEN GOSUB clearer: LOCATE 19, 1: PRINT "fumble !": GOSUB pause
     IF ko2 - ko1 < -9 THEN rr = INT(RND(1) * 100 + 1): IF rr > 50 THEN GOSUB clearer: LOCATE 19, 1: PRINT tm2$; " recover.": GOSUB pause: GOTO ft2
     IF ko2 - ko1 < -9 THEN GOSUB clearer: LOCATE 19, 1: PRINT tm1$; ", recover.": GOSUB pause: GOTO 2800
ft2: GOSUB clearer
     LOCATE 19, 1: PRINT rb$(cp); ", "; ty; " yard return."
2006 GOSUB pause
     GOSUB clearer
     byd = byd
     IF byd > 50 THEN abyd = 100 - byd
     LOCATE 19, 1: PRINT "Ball at the, "; abyd; " yard line.": GOSUB pause
     GOSUB 70000
     GOSUB 65000


2100 REM start opponent 2 possession cp
     ytg = 10: ty = 0: down = 1: side = 2: bn = 0
2103 IF clock < 1 THEN LOCATE 18, 1: PRINT "game over": GOTO stats
     IF byd > 99 THEN GOTO 2950
     IF player = cp THEN GOTO player
     IF player2 = cp THEN GOTO player

2104     rr = INT(RND(1) * 100 + 1)
         t1 = 1
         t2 = op1(cp)
         t3 = t2 + 1
         t4 = t2 + op2(cp)
         t5 = t4 + 1
         t6 = t4 + op3(cp)
         t7 = t6 + 1
         t8 = t6 + op4(cp)
         IF rr >= t1 AND rr <= t2 THEN GOTO 2104.05
         IF rr >= t3 AND rr <= t4 THEN GOTO 2104.15
         IF rr >= t5 AND rr <= t6 THEN GOTO 2104.25
         IF rr >= t7 AND rr <= t8 THEN GOTO 2104.35

2104.05  SB$ = rb$(cp): sbp = rbp(cp): vgr$ = "run"
         FOR x = 1 TO INT(ry2 / 100): sbp = rbp(cp) - x: bn = x: NEXT
         GOTO 2105

2104.15 aa$ = "short pass.": vgr$ = "s-pass"
        SB$ = te$(cp): sbp = tep(cp): py1 = 8: py2 = 1: hc = -2
        FOR x = 1 TO INT(rcs2 / 100): hc = hc + x: bn = x: NEXT
        GOTO 2200

2104.25 aa$ = "medium pass.": vgr$ = "m-pass"
        SB$ = rr$(cp): sbp = rrp(cp): py1 = 9: py2 = 9: hc = 0
        FOR x = 1 TO INT(rcm2 / 100): hc = hc + x: bn = x: NEXT
        GOTO 2200

2104.35 aa$ = "long pass.": vgr$ = "l-pass"
        SB$ = lr$(cp): sbp = lrp(cp): py1 = 10: py2 = 18: hc = 2
        FOR x = 1 TO INT(rcl2 / 100): hc = hc + x: bn = x: NEXT
        GOTO 2200

2105 REM ***** run *****
     IF byd > 99 THEN GOTO 2950
     GOSUB clock
     z = 1: GOSUB defcal
     IF player = pl THEN blitz$ = "off": GOSUB defense
     IF player2 = pl THEN blitz$ = "off": GOSUB defense
     z = 0
     IF a$ = "4-3" AND blitz$ = "on" THEN bn = bn + 3
     IF a$ = "4-3" AND blitz$ = "off" THEN bn = bn + 2
     IF a$ = "3-4" AND blitz$ = "on" THEN bn = bn + -3
     IF a$ = "3-4" AND blitz$ = "off" THEN bn = bn + -2
     IF a$ = "zone" AND blitz$ = "on" THEN rr = INT(RND(1) * 100 + 1): IF rr > 50 THEN bn = 1:  ELSE bn = -1
     IF a$ = "zone" AND blitz$ = "off" THEN bn = 0
     GOSUB 70000: GOSUB 65000
     GOSUB clearer
     LOCATE 19, 1: PRINT "Hand off to, "; rb$(cp); "."
     GOSUB pause
     ko1 = 0: ty = 0
     rr = INT(RND(1) * 100 + 1): IF rr <= pnl(pl) THEN GOSUB clearer: LOCATE 19, 1: PRINT "defensive penalty.": down = down - 2: clock = clock + 2: GOTO 2116
     rr = INT(RND(1) * 100 + 1): IF rr <= pnl(cp) THEN GOSUB clearer: LOCATE 19, 1: PRINT "offensive penalty.": aa$ = "penalty": clock = clock + 2: GOTO 2116
2110 byd = byd - ko1: ty = ty + ko1: aa$ = "run": IF byd < 1 THEN GOTO touchdown2
     ko1 = ol(cp)
     ko2 = dl(pl) + bn
     ko3 = ko2 - ko1
     ko1 = INT(RND(1) * 20 + 1) + ko3
     ko2 = INT(RND(1) * 10 + 1) + sbp
     IF ko2 > ko1 THEN ko1 = INT(RND(1) * (sbp) / 3 + 1): GOTO 2110
     IF ko2 - ko1 < -10 THEN GOSUB clearer: LOCATE 19, 1: PRINT "fumble !": GOSUB pause
     IF ko2 - ko1 < -10 THEN rr = INT(RND(1) * 100 + 1): IF rr > 50 THEN GOSUB clearer: LOCATE 19, 1: PRINT tm2$; ", recover.":  GOSUB pause: GOTO 2115
     IF ko2 - ko1 < -10 THEN GOSUB clearer: LOCATE 19, 1: PRINT tm1$; ", recover.": r2turn = r2turn + 1: GOSUB pause: GOTO 2800
     IF ko2 - ko1 > -11 AND ko2 - ko1 < -5 THEN ko1 = INT(RND(1) * 3 - 1): byd = byd - ko1: ty = ty + ko1: aa$ = "run": IF byd < 1 THEN GOTO touchdown2
2115 GOSUB clearer
     IF ty < 1 THEN LOCATE 19, 1: PRINT "Stopped cold by the defense.": GOSUB pause
     IF ty > 7 THEN LOCATE 19, 1: PRINT "nice run...": GOSUB pause
     IF ty > 0 AND ty < 8 THEN LOCATE 19, 1: PRINT "He powers through the defense.": GOSUB pause
     GOSUB clearer
     LOCATE 19, 1: PRINT rb$(cp); ", gains "; ty; " yards."
     IF gtm$ = "ot" THEN GOTO 2116
     ry2 = ry2 + ty
2116 GOSUB pause
     IF down = 4 AND aa$ = "penalty" THEN aa$ = "": GOTO 2600
2118 ytg = ytg - ty: IF ytg < 1 THEN ytg = 10: down = 1: GOTO 2120
     down = down + 1: IF down > 3 THEN GOTO 2600
     IF down < 1 THEN down = 1
2120 GOSUB 70000: GOSUB 65000: GOTO 2103

2200 REM ***** pass *****
     IF byd > 99 THEN GOTO 2950
     GOSUB clock
     z = 1: GOSUB defcal
     IF player = pl THEN blitz$ = "off": GOSUB defense
     IF player2 = pl THEN blitz$ = "off": GOSUB defense
     z = 0
     IF a$ = "4-3" AND blitz$ = "on" THEN bn = -3
     IF a$ = "4-3" AND blitz$ = "off" THEN bn = -2
     IF a$ = "3-4" AND blitz$ = "on" THEN bn = 3
     IF a$ = "3-4" AND blitz$ = "off" THEN bn = 2
     IF a$ = "zone" AND blitz$ = "on" THEN rr = INT(RND(1) * 100 + 1): IF rr >= 50 THEN bn = 1 ELSE bn = -1
     IF a$ = "zone" AND blitz$ = "off" THEN bn = 0
     GOSUB 70000: GOSUB 65000
     LOCATE 19, 1: PRINT "                                       "
     LOCATE 19, 1: PRINT qb$(cp); ", attemps a "; aa$
     GOSUB pause
     ko1 = 0: ty = 0
     rr = INT(RND(1) * 100 + 1): IF rr <= pnl(pl) THEN GOSUB clearer: LOCATE 19, 1: PRINT "defensive penalty.": down = down - 2: clock = clock + 2: GOTO 2216
     rr = INT(RND(1) * 100 + 1): IF rr <= pnl(cp) THEN GOSUB clearer: LOCATE 19, 1: PRINT "offensive penalty.": aa$ = "penalty": clock = clock + 2: GOTO 2216
2210 byd = byd - ko1: ty = ty + ko1: IF byd < 1 THEN GOTO touchdown2
     ko1 = ol(cp)
     ko2 = dl(pl) + bn
     ko3 = ko2 - ko1
     ko1 = INT(RND(1) * 10 + 1) + ko3
     ko2 = INT(RND(1) * 10 + 1) + (qbp(cp) - hc)
     IF ko2 > ko1 THEN GOTO 2220
     IF ko2 <= ko1 AND ko2 - ko1 >= -2 THEN GOSUB clearer: LOCATE 19, 1: PRINT "incomplete": GOTO 2216
     IF ko2 <= ko1 AND ko2 - ko1 < -2 THEN ko = 1 - INT(RND(1) * 5 + 1): ty = ty + ko: byd = byd - ko: GOSUB clearer: LOCATE 19, 1: PRINT qb$(cp); ", is sacked.": GOSUB pause: IF gmt$ = "ot" THEN GOSUB clock: GOSUB stats
2215 GOSUB clearer: LOCATE 19, 1: PRINT qb$(cp); ", gains, "; ty; " yards."
2216 GOSUB pause
     IF down = 4 AND aa$ = "penalty" THEN aa$ = "": GOTO 2600
2217 ytg = ytg - ty: IF ytg < 1 THEN ytg = 10: down = 1: GOTO 2219
2218 down = down + 1: IF down > 3 THEN GOTO 2600
     IF down < 1 THEN down = 1
2219 GOSUB 70000: GOSUB 65000: GOTO 2103
2220 rr = INT(RND(1) * dl(pl) + 1) + hc
     IF (qbp(cp) - bn) > rr THEN GOTO 2225
     GOSUB clearer: LOCATE 19, 1: PRINT "Bad pass, incomplete.": GOTO 2216
2225 GOSUB clearer: LOCATE 19, 1: PRINT "nice pass...": GOSUB pause
     ko1 = ol(cp)
     ko2 = dl(pl) + bn
     ko3 = ko2 - ko1
     ko1 = INT(RND(1) * 15 + 1) + ko3
     ko2 = INT(RND(1) * 10 + 1) + (sbp - hc)
     IF ko2 > ko1 THEN GOTO 2230
     IF ko2 <= ko1 AND ko2 - ko1 >= -7 THEN GOSUB clearer: LOCATE 19, 1: PRINT "Defense, swats the ball away.": GOTO 2216
     IF ko2 <= ko1 AND ko2 - ko1 < -7 THEN GOSUB clearer: LOCATE 19, 1: PRINT "Ball is intercepted !": p2turn = p2turn + 1: GOSUB pause: GOTO 2800
2230 GOSUB clearer: LOCATE 19, 1: PRINT "Pass caught by, "; SB$; ".": GOSUB pause
     rr = INT(RND(1) * py1 + py2)
2231 byd = byd - rr: ty = ty + rr: IF byd < 1 THEN GOTO touchdown2
     ko1 = ol(cp)
     ko2 = dl(pl) + bn
     ko3 = ko2 - ko1
     ko1 = INT(RND(1) * 20 + 1) + ko3
     ko2 = INT(RND(1) * 10 + 1) + sbp
     IF ko2 > ko1 THEN GOTO 2235
     IF ko2 <= ko1 THEN GOSUB clearer: LOCATE 19, 1: PRINT "A "; ty; " yard gain.": GOSUB pause: GOTO 2240
2235 rr = INT(RND(1) * (sbp / 3) + 1): GOTO 2231
2240 IF gtm$ = "ot" THEN GOTO 2217
     ps2 = ps2 + ty
     IF aa$ = "short pass." THEN rcs2 = rcs2 + ty
     IF aa$ = "medium pass." THEN rcm2 = rcm2 + ty
     IF aa$ = "long pass." THEN rcl2 = rcl2 + ty
     GOTO 2217

END
2600 REM ***** field goal *****
     GOSUB 70000: GOSUB 65000
     IF down > 4 THEN GOTO 2800
     IF player = cp THEN GOTO player
     IF player2 = cp THEN GOTO player
     GOSUB clock
     r2 = byd + 20
     IF r2 > INT(kcp(cp) * 6) THEN GOTO 2700
2602 vgr$ = "ogoal": hgr$ = "dgoal"
     GOSUB 70000: GOSUB 65000: ydl = byd: GOSUB 66000
     GOSUB clearer: LOCATE 19, 1: PRINT kc$(cp); ", attemps a"; r2; "yarder.": GOSUB pause
     r1 = INT(kcp(cp) * 5)
     rr = INT(RND(1) * (r1 / 2.5) + r1)
     pp = INT(RND(1) * 100 + 1): IF pp < 5 THEN GOTO 2605
     IF rr >= r2 AND gtm$ = "ot" THEN GOSUB clearer: LOCATE 19, 1: PRINT "Field goal, good !": GOSUB pause: fg2 = fg2 + 3: sc2 = sc2 + 3: GOSUB clock: GOTO stats
     IF rr >= r2 THEN GOSUB clearer: LOCATE 19, 1: PRINT "Field goal, good !": GOSUB pause: fg2 = fg2 + 3: sc2 = sc2 + 3: GOSUB clock: GOSUB 70000: GOTO 1000
2605 GOSUB clearer: LOCATE 19, 1: PRINT "Field goal, no good.": GOSUB pause: GOSUB clock: GOSUB 70000: GOSUB 65000: GOTO 1100
2700 REM ***** punt *****
     IF player = cp OR player2 = cp THEN GOTO 2705
     IF down = 4 AND ytg < 5 AND byd < 50 THEN GOTO 2103
2705 vgr$ = "punt"
     hgr$ = "return"
     GOSUB 70000: GOSUB 65000
     GOSUB clearer: LOCATE 19, 1: PRINT tm2$; " punt.": GOSUB clock: GOTO 1001
2800 REM ***** turnover *****
     GOSUB 70000: GOSUB 65000
     side = 1
     GOTO 1100

2950 REM ***** safety *****
     GOSUB clearer: LOCATE 19, 1: PRINT "saftey !": GOSUB pause
     vgr$ = "punt": hgr$ = "return"
     GOSUB 70000: GOSUB 65000
     sc1 = sc1 + 2: GOTO 1000
END
touchdown2: GOSUB clearer
            
            ty = ty + byd
            IF gtm$ = "ot" THEN GOTO skip2
            IF aa$ = "run" THEN ry2 = ry2 + ty: ryp2 = ryp2 + 1
            IF aa$ = "short pass." THEN ps2 = ps2 + ty: rcs2 = rcs2 + ty: psp2 = psp2 + 1: rcsp2 = rcsp2 + 1
            IF aa$ = "medium pass." THEN ps2 = ps2 + ty: rcm2 = rcm2 + ty: psp2 = psp2 + 1: rcmp2 = rcmp2 + 1
            IF aa$ = "long pass." THEN ps2 = ps2 + ty: rcl2 = rcl2 + ty: psp2 = psp2 + 1: rclp2 = rclp2 + 1
           
skip2:      LOCATE 19, 1: PRINT SB$; ", gains "; ty; " yards."
            LOCATE 21, 1: PRINT "touchdown !": GOSUB pause
            LOCATE 21, 1: PRINT "                   "
            IF gtm$ = "ot" THEN sc2 = sc2 + 7: GOSUB clock: GOTO stats
            sc2 = sc2 + 7: GOSUB clock: GOSUB 70000: GOTO 1000


END
pause: clock = clock - 1
       a! = TIMER
       GOSUB clock
pause1: IF TIMER < a! THEN clock = clock + 1: GOTO pause
        IF TIMER - a! > pause THEN RETURN
        GOTO pause1

END
9999 a$ = INKEY$: IF a$ = "" THEN GOTO 9999
END
10000 REM teams...
     load$ = "loaded"
OPEN "pro95.lgs" FOR INPUT AS #1
     FOR x = 1 TO 30
     INPUT #1, tm$(x)
     INPUT #1, hc(x)
     INPUT #1, jc(x)
     INPUT #1, ol(x)
     INPUT #1, dl(x)
     INPUT #1, op1(x)
     INPUT #1, op2(x)
     INPUT #1, op3(x)
     INPUT #1, op4(x)
     INPUT #1, dp1(x)
     INPUT #1, dp2(x)
     INPUT #1, dp3(x)
     INPUT #1, db1(x)
     INPUT #1, pnl(x)
     INPUT #1, lr$(x)
     INPUT #1, lrp(x)
     INPUT #1, rr$(x)
     INPUT #1, rrp(x)
     INPUT #1, te$(x)
     INPUT #1, tep(x)
     INPUT #1, qb$(x)
     INPUT #1, qbp(x)
     INPUT #1, rb$(x)
     INPUT #1, rbp(x)
     INPUT #1, kc$(x)
     INPUT #1, kcp(x)
     NEXT
     CLOSE #1

19999 RETURN


END
20000 REM clear text screen
      FOR x = 14 TO 24
      
      LOCATE x, 1: PRINT "                                        ";
      NEXT
      RETURN

30000 REM pic plotter
      COLOR helmet
      PSET (xx, yy): PSET (xx - 1, yy - 1): PSET (xx, yy - 1)
      PSET (xx + 1, yy - 3): PSET (xx + 2, yy - 3): PSET (xx + 1, yy - 4): PSET (xx + 2, yy - 4)
      COLOR jersey
      PSET (xx, yy - 2): PSET (xx + 1, yy - 2): PSET (xx, yy - 3)
      COLOR 6
      PSET (xx + 1, yy - 1)
      IF dr$ = "west" OR dr$ = "south" THEN GOTO 30010
      COLOR 15
      RETURN

30010 COLOR 6
      PSET (xx - 1, yy - 3): PSET (xx + 1, yy - 3)
      COLOR 15
      RETURN

35000 REM pointer so the field dont erase when you draw the pics.
      p(z, 1) = POINT(xx, yy)
      p(z, 2) = POINT(xx - 1, yy - 1)
      p(z, 3) = POINT(xx, yy - 1)
      p(z, 4) = POINT(xx + 1, yy - 1)
      p(z, 5) = POINT(xx, yy - 2)
      p(z, 6) = POINT(xx + 1, yy - 2)
      p(z, 7) = POINT(xx - 1, yy - 3)
      p(z, 8) = POINT(xx, yy - 3)
      p(z, 9) = POINT(xx + 1, yy - 3)
      p(z, 10) = POINT(xx + 2, yy - 3)
      p(z, 11) = POINT(xx + 1, yy - 4)
      p(z, 12) = POINT(xx + 2, yy - 4)
RETURN

36000 REM erase pic with field pointer
      PSET (xx, yy), p(z, 1)
      PSET (xx - 1, yy - 1), p(z, 2)
      PSET (xx, yy - 1), p(z, 3)
      PSET (xx + 1, yy - 1), p(z, 4)
      PSET (xx, yy - 2), p(z, 5)
      PSET (xx + 1, yy - 2), p(z, 6)
      PSET (xx - 1, yy - 3), p(z, 7)
      PSET (xx, yy - 3), p(z, 8)
      PSET (xx + 1, yy - 3), p(z, 9)
      PSET (xx + 2, yy - 3), p(z, 10)
      PSET (xx + 1, yy - 4), p(z, 11)
      PSET (xx + 2, yy - 4), p(z, 12)
RETURN

40000 REM home
      FOR x = 1 TO 11
      z = z + 1
      xx = px(x): yy = py(x)
      jersey = jc(pl): helmet = hc(pl)
      dr$ = dr$(x)
      GOSUB 30000
      NEXT
      z = 12: GOSUB 30000
      z = 0
      RETURN
40100



45000 REM visitor
      FOR x = 1 TO 11
      z = z + 1
      xx = px(x): yy = py(x)
      jersey = jc(cp): helmet = hc(cp)
      dr$ = dr$(x)
      GOSUB 30000
      NEXT
      z = 12: GOSUB 30000
      z = 0
      RETURN



50000 REM ** home formation **
      q = 0: qq = INT(ydl * 2)
      IF hgr$ = "kickoff" THEN GOTO 50800
      IF hgr$ = "huddle" THEN GOTO 51200
      IF hgr$ = "recieve" THEN GOTO 50900
      IF hgr$ = "4-3" THEN GOTO 50500
      IF hgr$ = "zone" THEN GOTO 50600
      IF hgr$ = "3-4" THEN GOTO 50700
      IF hgr$ = "run" THEN GOTO 50100
      IF hgr$ = "s-pass" THEN GOTO 50200
      IF hgr$ = "m-pass" THEN GOTO 50300
      IF hgr$ = "l-pass" THEN GOTO 50400
      IF hgr$ = "ogoal" THEN GOTO 51000
      IF hgr$ = "dgoal" THEN GOTO 51100
      IF hgr$ = "punt" THEN GOTO 51300
      IF hgr$ = "return" THEN GOTO 51400


50100 ' ** RUN **
      FOR x = 1 TO 11
      dr$(x) = "east"
      px(x) = 58 + qq
      IF x > 7 THEN px(x) = 53 + qq
      NEXT
      px(11) = 48 + qq
      py(1) = 20
      py(2) = 40: py(3) = 45: py(4) = 50: py(5) = 55: py(6) = 60
      py(7) = 80
      py(8) = 35: py(9) = 50: py(10) = 65
      py(11) = 50
      GOSUB 40000: hgr$ = "huddle": RETURN

50200 ' ** S-PASS **
      FOR x = 1 TO 11
      dr$(x) = "east"
      px(x) = 58 + qq
      IF x >= 8 THEN px(x) = 53 + qq
      NEXT
      px(11) = 48 + qq
      py(1) = 20
      py(2) = 40: py(3) = 45: py(4) = 50: py(5) = 55: py(6) = 60
      py(7) = 80
      py(8) = 30: py(9) = 50: py(10) = 70
      py(11) = 50
      GOSUB 40000: hgr$ = "huddle": RETURN

50300 ' ** M-PASS **
      FOR x = 1 TO 11
      dr$(x) = "east"
      px(x) = 58 + qq
      IF x >= 8 THEN px(x) = 53 + qq
      NEXT
      px(11) = 48 + qq
      py(1) = 20
      py(2) = 40: py(3) = 45: py(4) = 50: py(5) = 55: py(6) = 60
      py(7) = 80
      py(8) = 25: py(9) = 50: py(10) = 75
      py(11) = 50
      GOSUB 40000: hgr$ = "huddle": RETURN

50400 ' ** L-PASS **
      FOR x = 1 TO 11
      dr$(x) = "east"
      px(x) = 58 + qq
      IF x >= 6 THEN px(x) = 53 + qq
      NEXT
      px(11) = 48 + qq
      py(1) = 20
      py(2) = 45: py(3) = 50: py(4) = 55: py(5) = 80
      py(6) = 25: py(7) = 40: py(8) = 50: py(9) = 60: py(10) = 75
      py(11) = 50
      GOSUB 40000: hgr$ = "huddle": RETURN



50500 '** 4-3 **
      FOR x = 1 TO 11
      dr$(x) = "east"
      px(x) = 58 + qq
      IF x >= 10 THEN px(x) = 53 + qq
      NEXT
      px(11) = 48 + qq
      py(1) = 20
      py(2) = 35: py(3) = 40: py(4) = 45: py(5) = 50: py(6) = 55: py(7) = 60: py(8) = 65
      py(9) = 80
      py(10) = 50: py(11) = 50
      GOSUB 40000: hgr$ = "huddle": RETURN

50600 '** ZONE **
      FOR x = 1 TO 11
      dr$(x) = "east"
      px(x) = 58 + qq
      IF x >= 7 THEN px(x) = 53 + qq
      NEXT
      px(10) = 48 + qq: px(11) = 48 + qq
      py(1) = 20
      py(2) = 40
      py(3) = 45
      py(4) = 55
      py(5) = 60
      py(6) = 80
      py(7) = 35: py(8) = 50: py(9) = 65
      py(10) = 45: py(11) = 55
      GOSUB 40000: hgr$ = "huddle": RETURN

50700 '** 3-4 **
      FOR x = 1 TO 11
      dr$(x) = "east"
      px(x) = 58 + qq
      IF x >= 6 THEN px(x) = 53 + qq: IF x >= 9 THEN px(x) = 48 + qq
      NEXT
      px(11) = 38 + qq
      py(1) = 20
      py(2) = 40: py(3) = 50: py(4) = 60
      py(5) = 80
      py(6) = 25: py(7) = 50: py(8) = 75
      py(9) = 40: py(10) = 60
      py(11) = 50
      GOSUB 40000: hgr$ = "huddle": RETURN



50800 '** KICK OFF **
      FOR x = 1 TO 11
      dr$(x) = "east"
      px(x) = 58 + qq
      py(x) = 20 + (x * 5)
      NEXT
      px(6) = 48 + qq
      GOSUB 40000
      hgr$ = "huddle"
      RETURN
     
50900 '** KICKOFF RECIEVING **
       FOR x = 1 TO 11
       dr$(x) = "east"
       px(x) = 138 + qq: py(x) = 35 + (x * 5)
       IF x >= 6 THEN px(x) = 58 + qq: py(x) = 10 + (x * 5)
       NEXT
       px(11) = 38 + qq: py(11) = 50
       GOSUB 40000
       hgr$ = "huddle"
       RETURN

51000 '** off. field goal **
      FOR x = 1 TO 11
      dr$(x) = "east"
      px(x) = 58 + qq
      IF x >= 8 THEN px(x) = 53 + qq
      NEXT
      px(10) = 48 + qq
      px(11) = 43 + qq
      FOR x = 35 TO 65 STEP 5
      q = q + 1: py(q) = x
      NEXT
      py(8) = 30: py(9) = 70
      py(10) = 50
      py(11) = 45
      GOSUB 40000: hgr$ = "huddle": RETURN

51100 '** Def. field goal **
      FOR x = 1 TO 11
      dr$(x) = "east"
      px(x) = 58 + qq
      IF x >= 8 THEN px(x) = 53 + qq
      NEXT
      px(10) = 48 + qq: px(11) = px(10)
      FOR x = 35 TO 65 STEP 5
      q = q + 1
      py(q) = x
      NEXT
      py(8) = 30: py(9) = 70
      py(10) = 45: py(11) = 55
      GOSUB 40000: hgr$ = "huddle": RETURN



51200 '** HUDDLE **
      FOR x = 1 TO 11
      dr$(x) = "east"
      px(x) = 42 + qq: py(x) = 35 + (x * 5)
      IF x >= 6 THEN px(x) = 47 + qq: py(x) = 10 + (x * 5)
      NEXT
      px(11) = 52 + qq: py(11) = 50: dr$(11) = "west"
      GOSUB 40000: RETURN

51300 '** punt **
      FOR x = 1 TO 11
      dr$(x) = "east"
      px(x) = 58 + qq
      NEXT
      px(8) = 53 + qq: px(9) = px(8)
      px(10) = 48 + qq
      px(11) = 38 + qq
      py(1) = 20
      q = 1
      FOR x = 40 TO 60 STEP 5
      q = q + 1
      py(q) = x
      NEXT
      py(7) = 80
      py(8) = 45: py(9) = 55
      py(10) = 55
      py(11) = 50
      GOSUB 40000: hgr$ = "huddle": RETURN


51400 '** return **
      FOR x = 1 TO 11
      dr$(x) = "east"
      px(x) = 58 + qq
      IF x >= 8 THEN px(x) = 98
      NEXT
      px(11) = 78
      py(1) = 20
      q = 1
      FOR x = 40 TO 60 STEP 5
      q = q + 1
      py(q) = x
      NEXT
      py(7) = 80
      py(8) = 45: py(9) = 50: py(10) = 55
      py(11) = 50
      GOSUB 40000: hgr$ = "huddle": RETURN



END

60000 REM visitor formation
      q = 0: qq = INT(ydl * 2)
      IF vgr$ = "kickoff" THEN GOTO 60800
      IF vgr$ = "recieve" THEN GOTO 60900
      IF vgr$ = "huddle" THEN GOTO 61200
      IF vgr$ = "4-3" THEN GOTO 60500
      IF vgr$ = "zone" THEN GOTO 60600
      IF vgr$ = "3-4" THEN GOTO 60700
      IF vgr$ = "run" THEN GOTO 60100
      IF vgr$ = "s-pass" THEN GOTO 60200
      IF vgr$ = "m-pass" THEN GOTO 60300
      IF vgr$ = "l-pass" THEN GOTO 60400
      IF vgr$ = "ogoal" THEN GOTO 61000
      IF vgr$ = "dgoal" THEN GOTO 61100
      IF vgr$ = "punt" THEN GOTO 61300
      IF vgr$ = "return" THEN GOTO 61400


60100 '** RUN **
      FOR x = 1 TO 11
      dr$(x) = "west"
      px(x) = 61 + qq
      IF x >= 8 THEN px(x) = 66 + qq
      NEXT
      px(11) = 71 + qq
      py(1) = 20
      py(2) = 40: py(3) = 45: py(4) = 50: py(5) = 55: py(6) = 60
      py(7) = 80
      py(8) = 35: py(9) = 50: py(10) = 65
      py(11) = 50
      GOSUB 45000: vgr$ = "huddle": RETURN
      
60200 '** S-PASS **
      FOR x = 1 TO 11
      dr$(x) = "west"
      px(x) = 61 + qq
      IF x >= 8 THEN px(x) = 66 + qq
      NEXT
      px(11) = 71 + qq
      py(1) = 20
      py(2) = 40: py(3) = 45: py(4) = 50: py(5) = 55: py(6) = 60
      py(7) = 80
      py(8) = 30: py(9) = 50: py(10) = 70
      py(11) = 50
      GOSUB 45000: vgr$ = "huddle": RETURN

60300 '** M-PASS **
      FOR x = 1 TO 11
      dr$(x) = "west"
      px(x) = 61 + qq
      IF x >= 8 THEN px(x) = 66 + qq
      NEXT
      px(11) = 71 + qq
      py(1) = 20
      py(2) = 40: py(3) = 45: py(4) = 50: py(5) = 55: py(6) = 60
      py(7) = 80
      py(8) = 25: py(9) = 50: py(10) = 75
      py(11) = 50
      GOSUB 45000: vgr$ = "huddle": RETURN

60400 '** L-PASS **
      FOR x = 1 TO 11
      dr$(x) = "west"
      px(x) = 61 + qq
      IF x >= 6 THEN px(x) = 66 + qq
      NEXT
      px(11) = 71 + qq
      py(1) = 20
      py(2) = 45: py(3) = 50: py(4) = 55
      py(5) = 80
      py(6) = 25
      py(7) = 40: py(8) = 50: py(9) = 60
      py(10) = 75
      py(11) = 50
      GOSUB 45000: vgr$ = "huddle": RETURN

60500 '** 4-3 **
      FOR x = 1 TO 11
      dr$(x) = "west"
      px(x) = 61 + qq
      NEXT
      px(10) = 66 + qq
      px(11) = 71 + qq
      py(1) = 20
      FOR x = 2 TO 8
      py(x) = 25 + INT(x * 5)
      NEXT
      py(9) = 80
      py(10) = 50: py(11) = 50
      GOSUB 45000: vgr$ = "huddle": RETURN

60600 '** zone **
      FOR x = 1 TO 11
      dr$(x) = "west"
      px(x) = 61 + qq
      IF x >= 7 THEN px(x) = 66 + qq: IF x >= 10 THEN px(x) = 71 + qq
      NEXT
      py(1) = 20
      py(2) = 40: py(3) = 45
      py(4) = 55: py(5) = 60
      py(6) = 80
      py(7) = 35: py(8) = 50: py(9) = 65
      py(10) = 45: py(11) = 55
      GOSUB 45000: vgr$ = "huddle": RETURN

60700 '** 3-4 **
      FOR x = 1 TO 11
      dr$(x) = "west"
      px(x) = 61 + qq
      IF x >= 6 THEN px(x) = 66 + qq: IF x >= 9 THEN px(x) = 71 + qq
      NEXT
      px(11) = 81 + qq
      py(1) = 20
      py(2) = 40: py(3) = 50: py(4) = 60
      py(5) = 80
      py(6) = 25: py(7) = 50: py(8) = 75
      py(9) = 40: py(10) = 60
      py(11) = 50
      GOSUB 45000: vgr$ = "huddle": RETURN





60800 '** KICKOFF **
      FOR x = 1 TO 11
      dr$(x) = "west"
      px(x) = 61 + qq
      py(x) = 20 + INT(x * 5)
      NEXT
      px(6) = 71 + qq
      GOSUB 45000: vgr$ = "huddle": RETURN



60900 ' ** RECIEVING KICKOFF **
      FOR x = 1 TO 11
      dr$(x) = "west"
      px(x) = 61 + qq: py(x) = 35 + (x * 5)
      IF x >= 6 THEN px(x) = 141 + qq: py(x) = 10 + (x * 5)
      NEXT
      px(11) = 161 + qq: py(11) = 50
      vgr$ = "huddle"
      GOSUB 45000: RETURN

61000 '** off. field goal **
      FOR x = 1 TO 11
      dr$(x) = "west"
      px(x) = 61 + qq
      NEXT
      px(8) = 66 + qq: px(9) = px(8)
      px(10) = 71 + qq
      px(11) = 76 + qq
      FOR x = 35 TO 65 STEP 5
      q = q + 1
      py(q) = x
      NEXT
      py(8) = 30: py(9) = 70
      py(10) = 50
      py(11) = 45
      GOSUB 45000: vgr$ = "huddle": RETURN



61100 '** def. field goal **
      FOR x = 1 TO 11
      dr$(x) = "west"
      px(x) = 61 + qq
      NEXT
      px(8) = 66 + qq: px(9) = px(8)
      px(10) = 71 + qq: px(11) = px(10)
      FOR x = 35 TO 65 STEP 5
      q = q + 1
      py(q) = x
      NEXT
      py(8) = 30: py(9) = 70
      py(10) = 45: py(11) = 55
      GOSUB 45000: vgr$ = "huddle": RETURN





61200 '** HUDDLE **
        FOR x = 1 TO 11
        dr$(x) = "west"
        px(x) = 78 + INT(ydl * 2): py(x) = 35 + (x * 5)
        IF x >= 6 THEN px(x) = 73 + INT(ydl * 2): py(x) = 10 + (x * 5)
        NEXT
        px(11) = 68 + INT(ydl * 2): py(11) = 50: dr$(11) = "east"
        GOSUB 45000: RETURN

61300 '** punt **
      FOR x = 1 TO 11
      dr$(x) = "west"
      px(x) = 61 + qq
      NEXT
      px(8) = 66 + qq: px(9) = px(8)
      px(10) = 71 + qq
      px(11) = 81 + qq
      py(1) = 20
      q = 1
      FOR x = 40 TO 60 STEP 5
      q = q + 1
      py(q) = x
      NEXT
      py(7) = 80
      py(8) = 45: py(9) = 55
      py(10) = 45
      py(11) = 50
      GOSUB 45000: vgr$ = "huddle": RETURN




61400 '** return **
      FOR x = 1 TO 11
      dr$(x) = "west"
      px(x) = 61 + qq
      NEXT
      px(8) = 221: px(9) = 221: px(10) = 221
      px(11) = 241
      py(1) = 20
      q = 1
      FOR x = 40 TO 60 STEP 5
      q = q + 1
      py(q) = x
      NEXT
      py(7) = 80
      py(8) = 45: py(9) = 50: py(10) = 55
      py(11) = 50
      GOSUB 45000: vgr$ = "huddle": RETURN


END

65000 REM plot ball and team pics
      ydl = byd - 1: GOSUB 50000
      ydl = byd + 1: GOSUB 60000
66000 ball = 60 + INT(byd * 2)
      COLOR 0: PSET (ball, 48): COLOR 15: RETURN

70000 IF binf$ = "loaded" THEN GOTO 71000
      binf$ = "loaded"
      DEF SEG = VARSEG(b1(0))
      BLOAD "field.img", 0
71000 DEF SEG = VARSEG(b1(0))
      PUT (0, 0), b1, PSET
      RETURN


clock: LOCATE 15, 4: PRINT sc1: LOCATE 15, 35: PRINT sc2
       LOCATE 14, 26: PRINT "   "
       LOCATE 14, 13: PRINT "qtr."; INT(5 - (clock / 100))
       LOCATE 14, 21: PRINT "time"; clock
       LOCATE 17, 17: IF side = 1 THEN PRINT " ---> " ELSE LOCATE 17, 17: PRINT " <--- "
       LOCATE 15, 15: PRINT "              "
       LOCATE 15, 15: PRINT down; "and"; ytg
       LOCATE 16, 16: PRINT "at": LOCATE 16, 22: PRINT "ydl."
       IF byd > 50 THEN abyd = 100 - byd
       IF byd < 51 THEN abyd = byd
       LOCATE 16, 18: PRINT abyd
       RETURN

stats: IF sc1 = sc2 THEN gtm$ = "ot": GOSUB 70000: clock = 400: GOTO start
       gtm$ = ""
       a$ = ""
       IF sc1 > sc2 THEN wins(pl) = wins(pl) + 1: loss(cp) = loss(cp) + 1 ELSE loss(pl) = loss(pl) + 1: wins(cp) = wins(cp) + 1
       
       
80000  GOSUB clearer
       LOCATE 19, 1: PRINT rb$(pl); " "; ry1; "yd "; ryp1; "td "; r1turn; "fb"
       PRINT rb$(cp); " "; ry2; "yd "; ryp2; "td "; r2turn; "fb"
       PRINT qb$(pl); " "; ps1; "yd "; psp1; "td "; p1turn; "in"
       PRINT qb$(cp); " "; ps2; "yd "; psp2; "td "; p2turn; "in"
       PRINT te$(pl); " "; rcs1; "yd "; rcsp1; "td"
       PRINT te$(cp); " "; rcs2; "yd "; rcsp2; "td"
       PRINT rr$(pl); " "; rcm1; "yd "; rcmp1; "td"
       PRINT rr$(cp); " "; rcm2; "yd "; rcmp2; "td"
       PRINT lr$(pl); " "; rcl1; "yd "; rclp1; "td"
       PRINT lr$(cp); " "; rcl2; "yd "; rclp2; "td"
       PRINT kc$(pl); " "; fg1; " pt"
       PRINT kc$(cp); " "; fg2; " pt"
      
game:    LOCATE 24, 1: PRINT : PRINT "another game? (y,n)"
another: a$ = INKEY$: IF a$ = "" THEN GOTO another
         IF a$ = "y" OR a$ = "Y" THEN GOTO eraser
         IF a$ = "n" OR a$ = "N" THEN GOTO stndings
         GOTO another

END

eraser: ry1 = 0: ry2 = 0: ps1 = 0: ps2 = 0: rcs1 = 0: rcs2 = 0: rcm1 = 0: rcm2 = 0: rcl1 = 0: rcl2 = 0: fg1 = 0: fg2 = 0
        ryp1 = 0: ryp2 = 0: psp1 = 0: psp2 = 0: rcsp1 = 0: rcsp2 = 0: rcmp1 = 0: rcmp2 = 0: rclp1 = 0: rclp2 = 0
        r1turn = 0: r2turn = 0: p1turn = 0: p2turn = 0
        CLS : GOTO 0


stndings: OPEN "standings" FOR OUTPUT AS #1
          FOR x = 1 TO 30
          PRINT #1, tm$(x)
          PRINT #1, wins(x)
          PRINT #1, loss(x)
          NEXT
          CLOSE #1
          RUN "menu.prg"
          END



