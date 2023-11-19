DECLARE SUB credits ()
DECLARE SUB shower ()
DECLARE SUB arms ()
DECLARE SUB intro ()
DECLARE SUB cheat ()
DECLARE SUB stgf3 ()
DECLARE SUB jjohn ()
DECLARE SUB stgf2 ()
DECLARE SUB raidf ()
DECLARE SUB scorpf ()
DECLARE SUB stgf1 ()
DECLARE SUB cagef ()
DECLARE SUB splp1 ()
DECLARE SUB splp2 ()
DECLARE SUB spin1 ()
DECLARE SUB spin2 ()
DECLARE SUB sup1 ()
DECLARE SUB sup2 ()
DECLARE SUB spear1 ()
DECLARE SUB spear2 ()
DECLARE SUB kanof ()
DECLARE SUB hitl ()
DECLARE SUB onevic ()
DECLARE SUB twovic ()
DECLARE SUB onefall ()
DECLARE SUB twofall ()
DECLARE SUB chrs1 ()
DECLARE SUB chrs2 ()
DECLARE SUB chrscrn ()
DECLARE SUB kickl ()
DECLARE SUB punchl ()
DECLARE SUB hit ()
DECLARE SUB punch ()
DECLARE SUB kick ()
COMMON SHARED one%, two%, three%, four%, c1%, c2%, p2s%, p2p%, p1s%, p1p%, charecter$, bkrnd$, cheater$, dfight$, dumbass$, onedev$, twodev$, twosupsat$, onesupsat$, onerep$, tworep$, blindf$, acidfight$, jiffy$, msyd$, giligin$, goro$, goodbuy$
cheesy:
intro
        IF goodbuy$ = "on" THEN
        credits
        GOTO creds:
        END IF
life1% = 200
life2% = 200
one% = 200
two% = 300
three% = 400
four% = 300
'c1% = 1
'c2% = 3
egin:
bkrnd$ = "csite"
IF jiffy$ = "on" THEN bkrnd$ = "jiffjohn"
chrscrn
IF cheater$ = "on" THEN
cheat
cheater$ = "off"
GOTO egin:
END IF
onech$ = charecter$
CLS
chrscrn
IF cheater$ = "on" THEN
cheat
cheater$ = "off"
GOTO egin:
END IF
RANDOMIZE TIMER
tardo% = INT(RND * 4) + 1
IF tardo% = 1 THEN
shower
END IF
IF goro$ = "on" THEN
CLS
arms
GOTO cheesy:
END IF
twoch$ = charecter$
IF onech$ = "kano" THEN
p1s% = 6
p1p% = 8
c1% = 6
END IF
IF onech$ = "raiden" THEN
p1s% = 5
p1p% = 9
c1% = 7
END IF
IF onech$ = "cage" THEN
p1s% = 9
p1p% = 6
c1% = 3
END IF
IF onech$ = "scorp" THEN
p1s% = 7
p1p% = 7
c1% = 14
END IF
IF twoch$ = "kano" THEN
p2s% = 6
p2p% = 8
c2% = 6
END IF
IF twoch$ = "raiden" THEN
p2s% = 5
p2p% = 9
c2% = 7
END IF
IF twoch$ = "cage" THEN
p2s% = 9
p2p% = 6
c2% = 3
END IF
IF twoch$ = "scorp" THEN
p2s% = 7
p2p% = 7
c2% = 14
END IF
life1% = 200
life2% = 200
one% = 200
'two% = 300
three% = 400
'four% = 300
'c1% = 1
'c2% = 3
'secret guy tests
        IF onedev$ = "on" THEN
        p1s% = 50
        p1p% = 50
        c1% = 4
        END IF
        IF twodev$ = "on" THEN
        p2s% = 50
        p2p% = 50
        c2% = 4
        END IF
        IF twosupsat$ = "on" THEN
        p2s% = 100
        p2p% = 100
        c2% = 4
        END IF
        IF onesupsat$ = "on" THEN
        p1s% = 100
        p1p% = 100
        c1% = 4
        END IF
'reptile tests
        IF tworep$ = "on" THEN
        p2s% = 30
        p2p% = 70
        c2% = 2
        END IF
        IF onerep$ = "on" THEN
        p1s% = 30
        p1p% = 70
        c1% = 2
        END IF

start:
IF combo1! = 10010 AND life2% < 50 AND three% > 400 AND three% < 600 AND one% > 100 AND one% < 300 THEN
CLS
FOR dly! = 1 TO 9999
NEXT dly!
stgf1
GOTO stinker:
END IF
IF combo2! = 10010 AND life1% < 50 AND one% > 100 AND one% < 300 THEN
CLS
FOR dly! = 1 TO 9999
NEXT dly!
stgf2
GOTO stinker:
END IF

'     cage fatality test
        IF combo1! = 13000 AND life2% < 50 AND onech$ = "cage" AND three% - one% < 150 THEN
        CLS
        FOR dly! = 1 TO 9999
        NEXT dly!
        cagef
        GOTO stinker:
        END IF
        IF combo2! = 13000 AND life1% < 50 AND twoch$ = "cage" AND three% - one% < 150 THEN
        CLS
        FOR dly! = 1 TO 9999
        NEXT dly!
        cagef
        GOTO stinker:
        END IF
'     kano fatality test
        IF combo1! = 9020 AND life2% < 50 AND onech$ = "kano" AND three% - one% < 150 THEN
        CLS
        FOR dly! = 1 TO 9999
        NEXT dly!
        kanof
        GOTO stinker:
        END IF
        IF combo2! = 9020 AND life1% < 50 AND twoch$ = "kano" AND three% - one% < 150 THEN
        CLS
        FOR dly! = 1 TO 9999
        NEXT dly!
        kanof
        GOTO stinker:
        END IF
'     raiden fatality test
        IF combo1! = 10020 AND life2% < 50 AND onech$ = "raiden" AND three% - one% > 200 THEN
        CLS
        FOR dly! = 1 TO 9999
        NEXT dly!
        raidf
        GOTO stinker:
        END IF
        IF combo2! = 10020 AND life1% < 50 AND twoch$ = "raiden" AND three% - one% > 200 THEN
        CLS
        FOR dly! = 1 TO 9999
        NEXT dly!
        raidf
        GOTO stinker:
        END IF
'     scorp fatality test
        IF combo1! = 6020 AND life2% < 50 AND onech$ = "scorp" AND three% - one% > 150 THEN
        CLS
        FOR dly! = 1 TO 9999
        NEXT dly!
        scorpf
        GOTO stinker:
        END IF
        IF combo2! = 6020 AND life1% < 50 AND twoch$ = "scorp" AND three% - one% > 150 THEN
        CLS
        FOR dly! = 1 TO 9999
        NEXT dly!
        scorpf
        GOTO stinker:
        END IF


IF combo2! = 8010 AND twoch$ = "scorp" AND three% - one% > 200 THEN
        spear2
        jjohn
        hit
        life1% = life1% - 70
        combo2! = 0
        END IF
        IF combo1! = 8010 AND onech$ = "scorp" AND three% - one% > 200 THEN
        spear1
        jjohn
        hitl
        life2% = life2% - 70
        combo1! = 0
        END IF

        IF combo2! = 2020 AND twoch$ = "kano" AND three% - one% < 200 THEN
        spin2
        hit
        life1% = life1% - 60
        combo2! = 0
        END IF
        IF combo1! = 2020 AND onech$ = "kano" AND three% - one% < 200 THEN
        spin1
        hitl
        life2% = life2% - 60
        combo1! = 0
        END IF

        IF combo2! = 5010 AND twoch$ = "raiden" AND three% - one% > 200 THEN
        sup2
        hit
        life1% = life1% - 40
        combo2! = 0
        END IF
        IF combo1! = 5010 AND onech$ = "raiden" AND three% - one% > 200 THEN
        sup1
        hitl
        life2% = life2% - 40
        combo1! = 0
        END IF

        IF combo2! = 9010 AND twoch$ = "cage" AND three% - one% < 130 THEN
        splp2
        hit
        life1% = life1% - 70
        combo2! = 0
        END IF
        IF combo1! = 9010 AND onech$ = "cage" AND three% - one% < 130 THEN
        splp1
        hitl
        life2% = life2% - 70
        combo1! = 0
        END IF



IF combo2! = 9010 AND twoch$ = "cage" THEN
splp2
combo2! = 0
END IF
IF combo1! = 9010 AND onech$ = "cage" THEN
splp1
combo1! = 0
END IF

CLS
jjohn
SCREEN 12
IF dumbass$ = "on" THEN two% = 100: four% = 500
IF blindf$ = "on" THEN two% = 700: four% = 700
DO
IF msyd$ = "on" THEN c1% = INT(RND * 15) + 1: c2% = INT(RND * 15) + 1: one% = INT(RND * 600) + 1: two% = INT(RND * 600) + 1: three% = INT(RND * 400) + 1: four% = INT(RND * 400) + 1
IF acidfight$ = "on" THEN c1% = INT(RND * 15) + 1: c2% = INT(RND * 15) + 1
stc! = stc! + 1
    IF dfight$ = "on" THEN
    DRAW "bm " + STR$(one%) + "," + STR$(two%) + "bd30c15l20r40u50r20u20l80d20r20d50br2bu2p15,15 "
    DRAW "bm " + STR$(three%) + "," + STR$(four%) + "bd30c15l20r40u50r20u20l80d20r20d50br2bu2p15,15 "
    END IF

    Triangle$ = "bm10,10 R" + STR$(life1%)
    DRAW "C4 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm630,10 l" + STR$(life2%)
    DRAW "C4 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)

    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C" + STR$(c1%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C" + STR$(c2%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
IF stc! > 99 THEN
combo2! = 0
combo1! = 0
stc! = 0
END IF
LOCATE 2, 1: PRINT "COMBO METER"; combo1!
LOCATE 2, 60: PRINT "COMBO METER"; combo2!
key$ = INKEY$
LOOP UNTIL key$ <> ""
    IF key$ = "^" AND onesupsat$ = "on" OR key$ = "^" AND twosupsat$ = "on" THEN GOTO boomer:
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
IF one% + 30 >= three% - 30 THEN
one% = one% - 10
three% = three% + 10
END IF
                        IF one% <= 100 AND bkrnd$ = "csite" THEN
                        stgf3
                        GOTO crappy:
                        END IF
                        IF three% >= 500 AND bkrnd$ = "csite" THEN
                        stgf3
                        GOTO crappy:
                        END IF
IF one% <= 40 THEN one% = one% + 12
IF three% >= 600 THEN three% = three% - 12
IF MID$(key$, 2, 1) = "M" THEN
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
three% = three% + p2s% - 2
  
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 g80 e80 l40 f80 "
    DRAW "C" + STR$(c2%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
combo2! = 0
FOR wdly% = 1 TO 2222
NEXT wdly%

END IF
IF MID$(key$, 2, 1) = "K" THEN
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
three% = three% - p2s%
   
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 g80 e80 l40 f80 "
    DRAW "C" + STR$(c2%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    combo2! = combo2! + 4000
FOR wdly% = 1 TO 2222
NEXT wdly%
END IF
IF MID$(key$, 2, 1) = "P" AND one% + 50 >= three% - 50 THEN
kickl
hit
life1% = life1% - p2p%
IF life1% < 5 THEN GOTO death1:
combo2! = combo2! + 10
GOTO start:
END IF
IF MID$(key$, 2, 1) = "P" THEN
kickl
combo2! = combo2! + 10
END IF
IF MID$(key$, 2, 1) = "H" AND one% + 50 >= three% - 50 THEN
punchl
combo2! = combo2! + 1000

hit
life1% = life1% - p2p% - 5
IF life1% < 5 THEN GOTO death1:
GOTO start:
END IF
IF MID$(key$, 2, 1) = "H" THEN
punchl
combo2! = combo2! + 1000
END IF
IF key$ = "w" AND one% + 50 >= three% - 50 THEN
combo1! = combo1! + 1000
punch
hitl
life2% = life2% - p1p% - 5
IF life2% < 5 THEN GOTO death2:
GOTO start:
END IF
IF key$ = "w" THEN
combo1! = combo1! + 1000
punch
END IF
IF key$ = "x" AND one% + 50 >= three% - 50 THEN
kick
hitl
combo1! = combo! + 10
life2% = life2% - p1p%
IF life2% < 5 THEN GOTO death2:
GOTO start:
END IF
IF key$ = "x" THEN
combo1! = combo1! + 10
kick
END IF
IF key$ = "d" THEN
combo1! = combo1! + 4000
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
one% = one% + p1s%
 
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 g80 e80 l40 f80 "
    DRAW "C" + STR$(c1%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR wdly% = 1 TO 2222
NEXT wdly%

END IF
IF key$ = "a" THEN
combo1! = 0
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
one% = one% - p1s% - 2

    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 g80 e80 l40 f80 "
    DRAW "C" + STR$(c1%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR wdly% = 1 TO 2222
NEXT wdly%
END IF
GOTO start
death1:
CLS
jjohn
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C" + STR$(c2%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)

onefall
twovic
GOTO hooha:
death2:
CLS
jjohn
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C" + STR$(c1%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)

twofall
onevic
hooha:
stinker:
crappy:
giligin$ = "on"
GOTO cheesy:
boomer:
SCREEN 12
one% = 300
two% = 350
hel1% = one%
hel2% = two%
FOR blood% = 1 TO 900
RANDOMIZE TIMER
bld1% = INT(RND * 600) - 300
bld2% = INT(RND * 600) - 300
LINE (hel1%, hel2%)-(hel1% + bld1%, hel2% + bld2%), 4
NEXT blood%
LOCATE 1, 1: PRINT "Whell nice going dumbass!! you just blew the crap out of the"
PRINT "entire world!!Just for that I'm gonna kick you out!!!!"
creds:
FOR dly! = 1 TO 999
NEXT dly!
CLS
PRINT "NOTE TO BASIC PROGRAMMERS."
PRINT "I JUST WOULD LIKE TO COMMEND ALL OTHER MEMBERS OF THE BASIC "
PRINT "REVOLUTION. I KNOW HOW IT FEELS TO HAVE BIG COMPANIES WITH"
PRINT "BIG STAFFS MAKING TONS OF CASH OF OF IDEAS THAT AREN'T HALF"
PRINT "OF WHAT YOU COULD THINK OF. I KNOW HOW IT FEELS TO BE TIRED"
PRINT "OF PLAYING SOMEONE ELSES GAME AND PAYING A TON FOR IT. I ALSO"
PRINT "HAVE A SOLUTION TO THESE PROBLEMS, KEEP MAKING GAMES, KEEP "
PRINT "LEARNING NEW TECHNIQUIES AND KEEP UPLOADING. I CAN TELL YOU "
PRINT "RIGHT NOW THAT YOU HAVE AN AUDIENCE FOR YOUR GAMES. EVERY "
PRINT "TIME YOU UPLOAD A GAME FROM NOW ON TRY DOWNLOADING 10, GIVE "
PRINT "THEM A TRY AND WRITE TO THE AUTHOR. I DOESN'T MATTER WEATHER "
PRINT "OR NOT YOUR GAME HAS GRAPHICS OR SOUNDS WHAT MAKES A GAME GOOD"
PRINT "IS THE IDEAS THAT DRIVE IT."

SUB arms
CLS
SCREEN 12
oneg% = 500
twog% = 200
one% = 380
two% = 200
hel1% = one%
hel2% = two% - 30

FOR gf% = 1 TO 20
FOR blood% = 1 TO 100
RANDOMIZE TIMER
bld1% = INT(RND * 100) - 50
bld2% = INT(RND * 100) - 50
LINE (hel1%, hel2%)-(hel1% + bld1%, hel2% + bld2%), 4
NEXT blood%
LINE (hel1% - 50, hel2% - 50)-(hel1% + 50, hel2% + 50), 0, BF

        Triangle$ = "bm " + STR$(oneg%) + "," + STR$(twog%) + "u100 d50 h50 g50 bd50 f50 e50 d100 r30 d150 u150 l60 d150"'fatality scene2
        DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
        Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r70 l70 d75 r5 r100 u5 "'legs and arms straight
        DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)

        Triangle$ = "bm " + STR$(oneg%) + "," + STR$(twog%) + "u100 d50 h100 f100 d50 g100 e100 d100 r30 d150 u150 l60 d150"'fatality scene1
        DRAW "C2 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
        Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 e50 g50 d75 r5 f80 e5 "'normal player hit
        DRAW "C2 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly% = 1 TO 9999
NEXT dly%
        Triangle$ = "bm " + STR$(oneg%) + "," + STR$(twog%) + "u100 d50 h100 f100 d50 g100 e100 d100 r30 d150 u150 l60 d150"'fatality scene1
        DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
        Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 e50 g50 d75 r5 f80 e5 "'normal player hit
        DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)

        Triangle$ = "bm " + STR$(oneg%) + "," + STR$(twog%) + "u100 d50 h50 g50 bd50 f50 e50 d100 r30 d150 u150 l60 d150"'fatality scene2
        DRAW "C2 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
        Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r70 l70 d75 r5 r100 u5 "'legs and arms straight
        DRAW "C2 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly% = 1 TO 9999
NEXT dly%
NEXT gf%

        Triangle$ = "bm " + STR$(oneg%) + "," + STR$(twog%) + "u100 d50 h50 g50 bd50 f50 e50 d100 r30 d150 u150 l60 d150"'fatality scene2
        DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
        Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r70 l70 d75 r5 r100 u5 "'legs and arms straight
        DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)

Triangle$ = "bm " + STR$(oneg%) + "," + STR$(twog%) + "u100 d50 e100 d70 u70 g100 h100 d70 u70 f100 d50 f100 u30 d30 d90 r10 l10 u90 h100 g100 u30 d30 d90 l10 r10 u90 e100 d100 r30 d150 u150 l60 d150"'victory with limbs
DRAW "C2 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
c% = 0
FOR spin% = 1 TO 20
two% = two% + 20
one% = one% - 10
c% = c% + 10
Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u50 d100"'normal player hit
DRAW "C2 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly% = 1 TO 9999
NEXT dly%
Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u50 d100"'normal player hit
DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
NEXT spin%

END SUB

SUB cagef
CLS
SCREEN 12
one% = 200
two% = 300
three% = 300
four% = 300
ho% = two% - 70
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 l60 r60 d75 l5 d100 l5 "
    DRAW "C2 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)

    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C2 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    FOR dly! = 1 TO 9999
    NEXT dly!
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two% + 30) + " u100 d25 r30 f60 h60 l60 d60 u60 r30 d75 r 20 f70 h70 l40 g70 "
    DRAW "C2 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    FOR dly! = 1 TO 9999
    NEXT dly!
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two% + 100) + " u100 d25 r90 l120 d60 u60 r30 d75 r100 l200 "
    DRAW "C2 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    FOR dly! = 1 TO 9999
    NEXT dly!
  
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two% + 100) + " u100 d25 r90 l120 d60 u60 r30 d75 r100 l200 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two% + 30) + " u100 d25 r30 f60 h60 l60 d60 u60 r30 d75 r 20 f70 h70 l40 g70  "
    DRAW "C2 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    FOR dly! = 1 TO 9999
    NEXT dly!
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two% + 30) + " u100 d25 r30 f60 h60 l60 d60 u60 r30 d75 r 20 f70 h70 l40 g70 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r90 l90 l30 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C2 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    CIRCLE (one% + 90, two% - 75), 4, 4
    CIRCLE (one% + 85, two% - 75), 4, 4
  
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 l60 r60 d75 l5 d100 l5 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)

FOR fall% = 1 TO 30
 c% = c% - 10
 four% = four% + 10
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 l60 r60 d75 l5 d100 l5 "
    DRAW "C2 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    FOR dly% = 1 TO 9999
    NEXT dly%
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 l60 r60 d75 l5 d100 l5 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r90 l90 l30 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C2 TA" + STR$(y%) + " X" + VARPTR$(Triangle$)
    NEXT fall%
SCREEN 12
gogo:
ho% = two% - 70
g% = 5
FOR bldf% = 1 TO 30
FOR fill% = 1 TO 5
g% = g% - 1
CIRCLE (one% + 92, ho%), g%, 4
NEXT fill%
g% = 5
FOR dly% = 1 TO 999
NEXT dly%
FOR fil% = 1 TO 5
g% = g% - 1
CIRCLE (one% + 92, ho%), g%, 0
NEXT fil%
ho% = ho% + 10
g% = 5
NEXT bldf%
GOTO gogo:

END SUB

SUB cheat
FOR cheaty% = 1 TO 40
PRINT "CHEATER!!"
NEXT cheaty%
CLS
LOCATE 10, 10
DRAW "c4"
INPUT "Diaper? ", diaper$
IF diaper$ = "total" THEN goro$ = "on"
IF diaper$ = "MSYD" THEN msyd$ = "on"
IF diaper$ = "poopoo" THEN dfight$ = "on"
IF diaper$ = "MM" THEN dumbass$ = "on"
IF diaper$ = "satan" THEN onedev$ = "on"
IF diaper$ = "lucifer" THEN twodev$ = "on"
IF diaper$ = "clinton" THEN onesupsat$ = "on"
IF diaper$ = "sox" THEN twosupsat$ = "on"
IF diaper$ = "stinky" THEN COLOR 4, 0
IF diaper$ = "gates" THEN
CLS
DO
PRINT
INPUT "C:\>", dkkdjdkjd$
PRINT "HAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHA"
LOOP
END IF
IF diaper$ = "st.pat" THEN onerep$ = "on"
IF diaper$ = "mask" THEN tworep$ = "on"
IF diaper$ = "nancy" THEN blindf$ = "on"
IF diaper$ = "crapper" THEN jiffy$ = "on"
IF diaper$ = "LSD" THEN acidfight$ = "on": PRINT "IM HAVIN ONE HELL OF AN ACID FLASHBACK MAN!!!"
INPUT "YOU WORTHLESS CHEATER!! PRESS ANYKEY TO CONTINUE ", jfsdjkfdjkfdjkjkfsd$
END SUB

SUB chrs1
IF onech$ = "kano" THEN
p1s% = 6
p1p% = 8
END IF
IF onech$ = "raiden" THEN
p1s% = 5
p1p% = 9
END IF
IF onech$ = "cage" THEN
p1s% = 9
p1p% = 6
END IF
IF onech$ = "scorp" THEN
p1s% = 7
p1p% = 7
END IF
END SUB

SUB chrs2
IF twoch$ = "kano" THEN
p2s% = 6
p2p% = 8
END IF
IF twoch$ = "raiden" THEN
p2s% = 5
p2p% = 9
END IF
IF twoch$ = "cage" THEN
p2s% = 9
p2p% = 6
END IF
IF twoch$ = "scorp" THEN
p2s% = 7
p2p% = 7
END IF
END SUB

SUB chrscrn
CLS
SCREEN 12
chr% = 3
COLOR 4
LOCATE 1, 1
PRINT "                               CHOOSE YOUR FIGHTER "
elect:
    Triangle$ = "bm20,20 r100 d100 l100 u100 d100 r45 u15 r10 d15 u15 r20 u60 u10 d10 l10 u10 d10 l10 u10 d10 l10 u10 d10 l10 u10 d10 l10 u10 d70 r40 bu10 l30 u10 r30 d10 bu30 l15 bl5 d7 u15 l20 d15 r20 l10 bu10 r5 d5 l5 u5"'kano
    DRAW "C6 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)

    Triangle$ = "bm150,20 r100 d100 l100 u100 d100 r45 u15 r10 d15 u15 r20 u60 d15 r20 h30 l30 g30 r20 u15 r50 l50 d60 r40 bu10 u5 l30 d5 r30 bu30 l10 bl10 l10"'raiden
    DRAW "C7 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)

    Triangle$ = "bm280,20 r100 d100 l100 u100 d100 r60 bu5 u10 bu10 u5 l20 u30 r30 u30 l50 d30 r5"'question????
    DRAW "C4 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)

    Triangle$ = "bm410,20 r100 d100 l100 u100 d100 r45 u15 r10 d15 u15 r20 u60 u10 d10 l10 u10 d10 l10 u10 d10 l10 u10 d10 l10 u10 d10 l10 u10 d70 r40 bu15 l30 bl10 u35 r50 d20 l20 u7 l10 d7 l20"'cage
    DRAW "C3 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)

    Triangle$ = "bm538,20 r100 d100 l100 u100 d100 r45 u15 r10 d15 u15 r20 u60 l50 d60 r50 u20 l20 h5 g5 l20 u30 r50 d20 bl10 u10 l10 d10 r10 bl20 l10 u10 r10 d10"
    DRAW "C14 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
DRAW "C16"
IF chr% = 1 THEN
DRAW "bm20,20 r100 d100 l100 u100 d100 "
cl% = 6
END IF
IF chr% = 2 THEN
DRAW "bm150,20 r100 d100 l100 u100 d100 "
cl% = 7
END IF
IF chr% = 3 THEN
DRAW "bm410,20 r100 d100 l100 u100 d100 "
cl% = 3
END IF
IF chr% = 4 THEN
DRAW "bm538,20 r100 d100 l100 u100 d100 "
cl% = 14
END IF
DO
    Triangle$ = "bm320,300 u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C" + STR$(cl%) + " TA" + STR$(c%) + " X" + VARPTR$(Triangle$)

key$ = INKEY$
LOOP UNTIL key$ <> ""
IF key$ = "c" THEN GOTO pooper:
IF MID$(key$, 2, 1) = "M" THEN chr% = chr% + 1
IF MID$(key$, 2, 1) = "K" THEN chr% = chr% - 1
IF key$ = " " THEN GOTO vict:
IF chr% = 5 THEN chr% = 4
IF chr% = 0 THEN chr% = 1
GOTO elect:


vict:
one% = 320
two% = 300

    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "c" + STR$(cl%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly! = 1 TO 999
NEXT dly!
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r90 l180 r90 d75 r 20 d100 u100 l40 d100 "
    DRAW "c" + STR$(cl%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly! = 1 TO 999
NEXT dly!
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r90 l180 r90 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 e60 g60 l60 h60 f60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "c" + STR$(cl%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)


IF chr% = 1 THEN charecter$ = "kano"
IF chr% = 2 THEN charecter$ = "raiden"
IF chr% = 3 THEN charecter$ = "cage"
IF chr% = 4 THEN charecter$ = "scorp"
GOTO skipperdoo:
pooper:
cheater$ = "on"

skipperdoo:
END SUB

SUB credits
CLS
DRAW "c4"
PRINT "DIRECTOR  RYEBACK"
FOR dly! = 1 TO 9999: NEXT dly!
PRINT
PRINT
PRINT "EXECUTIVE DIRECTOR RYEBACK"
FOR dly! = 1 TO 9999: NEXT dly!
PRINT
PRINT
PRINT "PRODUCER RYEBACK"
FOR dly! = 1 TO 9999: NEXT dly!
PRINT
PRINT
PRINT "EXECUTIVE PRODUCER RYEBACK"
FOR dly! = 1 TO 9999: NEXT dly!
PRINT
PRINT
PRINT "SCREEN PLAY BY RYEBACK"
FOR dly! = 1 TO 9999: NEXT dly!
PRINT
PRINT
PRINT "KANO PLAYED BY RYEBACK"
FOR dly! = 1 TO 9999: NEXT dly!
PRINT
PRINT
PRINT "SCORPION PLAYED BY RYEBACK"
FOR dly! = 1 TO 9999: NEXT dly!
PRINT
PRINT
PRINT "RAIDEN PLAYED BY RYEBACK"
FOR dly! = 1 TO 9999: NEXT dly!
PRINT
PRINT
PRINT "JOHNY CAGE PLAYED BY RYEBACK"
FOR dly! = 1 TO 9999: NEXT dly!
PRINT
PRINT
PRINT "ART DESIGNER RYEBACK"
FOR dly! = 1 TO 9999: NEXT dly!
PRINT
PRINT
PRINT "MARKETING RYEBACK"
FOR dly! = 1 TO 9999: NEXT dly!
PRINT
PRINT
PRINT "CREATIVE DIRECTOR RYEBACK"
FOR dly! = 1 TO 9999: NEXT dly!
PRINT
PRINT
PRINT "CHIEF EXECUTIVE PRODUCER RYEBACK"
FOR dly! = 1 TO 9999: NEXT dly!
PRINT
PRINT
PRINT "DESIGN TEAM RYEBACK RYEBACK AND RYEBACK"
FOR dly! = 1 TO 9999: NEXT dly!
PRINT
PRINT
PRINT "CORIOGRAPHER RYEBACK"
FOR dly! = 1 TO 9999: NEXT dly!
PRINT
PRINT
PRINT "COORDINATOR RYEBACK"
FOR dly! = 1 TO 9999: NEXT dly!
PRINT
PRINT
PRINT "STUNT COORDINATOR RYEBACK"
FOR dly! = 1 TO 9999: NEXT dly!
PRINT
PRINT
PRINT "PROGRAMMER RYEBACK"
FOR dly! = 1 TO 9999: NEXT dly!
PRINT
PRINT
PRINT "EXECUTIVE PROGRAMMER RYEBACK"
FOR dly! = 1 TO 9999: NEXT dly!
PRINT
PRINT
PRINT "CO-PROGRAMMER RYEBACK"
FOR dly! = 1 TO 9999: NEXT dly!
PRINT
PRINT
PRINT "CO-EXECUTIVE PROGRAMMER RYEBACK"
FOR dly! = 1 TO 9999: NEXT dly!
PRINT
PRINT
PRINT "CHEIF PROGRAMMER RYEBACK"
FOR dly! = 1 TO 9999: NEXT dly!
PRINT
PRINT
PRINT "EDITOR RYEBACK"
FOR dly! = 1 TO 9999: NEXT dly!
PRINT
PRINT
PRINT "SPECIAL THANKS TO RYEBACK"
FOR dly! = 1 TO 9999: NEXT dly!
PRINT
PRINT
PRINT "EXTRA SPECIAL THANKS TO RYEBACK"
FOR dly! = 1 TO 9999: NEXT dly!
PRINT
PRINT
PRINT "CREDITS RYEBACK"
FOR dly! = 1 TO 9999: NEXT dly!
PRINT
PRINT
PRINT "THANKS FOR PLAYING SFF, LOOK FOR FUTURE VERSIONS ON-LINE!!!!"
PRINT "I THINK THAT FOR A BASIC GAME THIS IS DAMN GOOD, TELL ME WHAT"
PRINT "YOU THINK BY WRITING TO RYEBACK ON AMERICA ON LINE! I'LL BE "
PRINT "GLAD TO KNOW WHAT YOU THINK."
PRINT
PRINT "LOOK FOR MY NEWEST AND COOLEST TITLE ARENA THE 3-D BATTLE GAME!!"
INPUT "press enter to kontinue.", djkfdjkdfjkfdkjfdfdjkdfkjdfjkfddfjkfdjk$
END SUB

SUB hit
SCREEN 12
hel1% = one% - 40
hel2% = two% - 30
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C" + STR$(c2%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR blood% = 1 TO 100
RANDOMIZE TIMER
bld1% = INT(RND * 100) - 50
bld2% = INT(RND * 100) - 50
LINE (hel1%, hel2%)-(hel1% + bld1%, hel2% + bld2%), 4
NEXT blood%
'LINE (150, 150)-(250, 250), 0, BF
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C" + STR$(c1%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)

    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r60 l60 d75 r5 d100 r5 "
    DRAW "C" + STR$(c1%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    FOR htdly% = 1 TO 9999
    NEXT htdly%
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r60 l60 d75 r5 d100 r5 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one% - 50) + "," + STR$(two%) + " u100 d25 e50 g50 d75 r5 f80 e5 "
    DRAW "C" + STR$(c1%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR blood% = 1 TO 100
RANDOMIZE TIMER
bld1% = INT(RND * 100) - 50
bld2% = INT(RND * 100) - 50
LINE (hel1%, hel2%)-(hel1% + bld1%, hel2% + bld2%), 4
NEXT blood%
'LINE (hel1% - 50, hel2% - 50)-(hel1% + 50, hel2% + 50), 0, BF
    FOR htdly% = 1 TO 9999
    NEXT htdly%
'    Triangle$ = "bm " + STR$(one% - 40) + "," + STR$(two%) + "u100 d25 e50 g50 d75 r5 f80 e5 "
'    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    
    

END SUB

SUB hitl

SCREEN 12
hel1% = three% + 40
hel2% = four% - 30
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C" + STR$(c1%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR blood% = 1 TO 100
RANDOMIZE TIMER
bld1% = INT(RND * 100) - 50
bld2% = INT(RND * 100) - 50
LINE (hel1%, hel2%)-(hel1% + bld1%, hel2% + bld2%), 4
NEXT blood%
LINE (hel1% - 50, hel2% - 50)-(hel1% + 50, hel2% + 50), 0, BF
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 l60 r60 d75 l5 d100 l5 "
    DRAW "C" + STR$(c2%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C" + STR$(c1%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    FOR htdly% = 1 TO 9999
    NEXT htdly%
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 l60 r60 d75 l5 d100 l5 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(three% + 50) + "," + STR$(four%) + " u100 d25 h50 f50 d75 l5 g80 u5 "
    DRAW "C" + STR$(c2%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C" + STR$(c1%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    FOR blood% = 1 TO 100
RANDOMIZE TIMER
bld1% = INT(RND * 100) - 50
bld2% = INT(RND * 100) - 50
LINE (hel1%, hel2%)-(hel1% + bld1%, hel2% + bld2%), 4
NEXT blood%
LINE (hel1% - 50, hel2% - 50)-(hel1% + 50, hel2% + 50), 0, BF
    FOR htdly% = 1 TO 9999
    NEXT htdly%
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 h50 f50 d75 l5 g80 u5 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)

END SUB

SUB intro
IF giligin$ = "on" THEN GOTO whiz:
newnew:
SCREEN 12
SCREEN 12
adder% = 0
two% = 0
FOR dly! = 1 TO 99
LOCATE 1, 1
PRINT "press enter now to skip the cool intro"
IF INKEY$ <> "" THEN GOTO farter:
NEXT dly!
'kano
CLS
FOR zz% = 1 TO 25
adder% = adder% + 10
one% = 300
two% = two% + 10
    DRAW "c6bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
 
    DRAW "c6bm" + STR$(adder%) + ",350 r100 d100 l100 u100 d100 r45 u15 r10 d15 u15 r20 u60 u10 d10 l10 u10 d10 l10 u10 d10 l10 u10 d10 l10 u10 d10 l10 u10 d70 r40 bu10 l30 u10 r30 d10 bu30 l15 bl5 d7 u15 l20 d15 r20 l10 bu10 r5 d5 l5 u5"'kano
    FOR dly% = 1 TO 9999
    NEXT dly%
    DRAW "c0bm" + STR$(adder%) + ",350 r100 d100 l100 u100 d100 r45 u15 r10 d15 u15 r20 u60 u10 d10 l10 u10 d10 l10 u10 d10 l10 u10 d10 l10 u10 d10 l10 u10 d70 r40 bu10 l30 u10 r30 d10 bu30 l15 bl5 d7 u15 l20 d15 r20 l10 bu10 r5 d5 l5 u5"'kano
 
    DRAW "c0bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
NEXT zz%
    DRAW "c6bm" + STR$(adder%) + ",350 r100 d100 l100 u100 d100 r45 u15 r10 d15 u15 r20 u60 u10 d10 l10 u10 d10 l10 u10 d10 l10 u10 d10 l10 u10 d10 l10 u10 d70 r40 bu10 l30 u10 r30 d10 bu30 l15 bl5 d7 u15 l20 d15 r20 l10 bu10 r5 d5 l5 u5"'kano

    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C6 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly! = 1 TO 999
NEXT dly!
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r90 l180 r90 d75 r 20 d100 u100 l40 d100 "
    DRAW "C6 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly! = 1 TO 999
NEXT dly!
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r90 l180 r90 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 e60 g60 l60 h60 f60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C6 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly! = 1 TO 9999
NEXT dly!
'raiden
CLS
adder% = 0
two% = 0
FOR z% = 1 TO 25
adder% = adder% + 10
one% = 300
two% = two% + 10
    DRAW "c7bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "

    DRAW "c7bm" + STR$(adder%) + ",350r100 d100 l100 u100 d100 r45 u15 r10 d15 u15 r20 u60 d15 r20 h30 l30 g30 r20 u15 r50 l50 d60 r40 bu10 u5 l30 d5 r30 bu30 l10 bl10 l10"
    FOR dly% = 1 TO 9999
    NEXT dly%
    DRAW "c0bm" + STR$(adder%) + ",350r100 d100 l100 u100 d100 r45 u15 r10 d15 u15 r20 u60 d15 r20 h30 l30 g30 r20 u15 r50 l50 d60 r40 bu10 u5 l30 d5 r30 bu30 l10 bl10 l10"

    DRAW "c0bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
NEXT z%
    DRAW "c7bm" + STR$(adder%) + ",350r100 d100 l100 u100 d100 r45 u15 r10 d15 u15 r20 u60 d15 r20 h30 l30 g30 r20 u15 r50 l50 d60 r40 bu10 u5 l30 d5 r30 bu30 l10 bl10 l10"'kano

    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C7 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly! = 1 TO 999
NEXT dly!
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r90 l180 r90 d75 r 20 d100 u100 l40 d100 "
    DRAW "C7 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly! = 1 TO 999
NEXT dly!
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r90 l180 r90 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 e60 g60 l60 h60 f60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C7 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly! = 1 TO 9999
NEXT dly!

'johny cage
CLS
adder% = 0
two% = 0
FOR z% = 1 TO 25
adder% = adder% + 10
one% = 300
two% = two% + 10
    DRAW "c3bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "

    DRAW "c7bm" + STR$(adder%) + ",350c3 r100 d100 l100 u100 d100 r45 u15 r10 d15 u15 r20 u60 u10 d10 l10 u10 d10 l10 u10 d10 l10 u10 d10 l10 u10 d10 l10 u10 d70 r40 bu15 l30 bl10 u35 r50 d20 l20 u7 l10 d7 l20"
    FOR dly% = 1 TO 9999
    NEXT dly%
    DRAW "c0bm" + STR$(adder%) + ",350 r100 d100 l100 u100 d100 r45 u15 r10 d15 u15 r20 u60 u10 d10 l10 u10 d10 l10 u10 d10 l10 u10 d10 l10 u10 d10 l10 u10 d70 r40 bu15 l30 bl10 u35 r50 d20 l20 u7 l10 d7 l20"

    DRAW "c0bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
NEXT z%
    DRAW "c3bm" + STR$(adder%) + ",350 r100 d100 l100 u100 d100 r45 u15 r10 d15 u15 r20 u60 u10 d10 l10 u10 d10 l10 u10 d10 l10 u10 d10 l10 u10 d10 l10 u10 d70 r40 bu15 l30 bl10 u35 r50 d20 l20 u7 l10 d7 l20"'kano

    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C3 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly! = 1 TO 999
NEXT dly!
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r90 l180 r90 d75 r 20 d100 u100 l40 d100 "
    DRAW "C3 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly! = 1 TO 999
NEXT dly!
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r90 l180 r90 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 e60 g60 l60 h60 f60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C3 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly! = 1 TO 9999
NEXT dly!

'scorpion
CLS
adder% = 0
two% = 0
FOR z% = 1 TO 25
adder% = adder% + 10
one% = 300
two% = two% + 10
    DRAW "c14bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "

    DRAW "c14bm" + STR$(adder%) + ",350 r100 d100 l100 u100 d100 r45 u15 r10 d15 u15 r20 u60 l50 d60 r50 u20 l20 h5 g5 l20 u30 r50 d20 bl10 u10 l10 d10 r10 bl20 l10 u10 r10 d10"
    FOR dly% = 1 TO 9999
    NEXT dly%
    DRAW "c0bm" + STR$(adder%) + ",350 r100 d100 l100 u100 d100 r45 u15 r10 d15 u15 r20 u60 l50 d60 r50 u20 l20 h5 g5 l20 u30 r50 d20 bl10 u10 l10 d10 r10 bl20 l10 u10 r10 d10"

    DRAW "c0bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
NEXT z%
    DRAW "c14bm" + STR$(adder%) + ",350 r100 d100 l100 u100 d100 r45 u15 r10 d15 u15 r20 u60 l50 d60 r50 u20 l20 h5 g5 l20 u30 r50 d20 bl10 u10 l10 d10 r10 bl20 l10 u10 r10 d10"

    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C14 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly! = 1 TO 999
NEXT dly!
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r90 l180 r90 d75 r 20 d100 u100 l40 d100 "
    DRAW "C14 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly! = 1 TO 999
NEXT dly!
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r90 l180 r90 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 e60 g60 l60 h60 f60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C14 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
CLS
DRAW "c15"
one% = 350
two% = 340
    DRAW "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
FOR drop% = 1 TO 440
DRAW "c4bm300," + STR$(drop%) + "r100u100l100d100r25u75r35d20e20d7u7g20bd25f20u7d7h20bu13r15e6g6f6h6l15bl5bu20l5br10bd35d28"
FOR dly% = 1 TO 599
NEXT dly%
DRAW "c0bm300," + STR$(drop%) + "r100u100l100d100r25u75r35d20e20d7u7g20bd25f20u7d7h20bu13r15e6g6f6h6l15bl5bu20l5br10bd35d28"
NEXT drop%
DRAW "c4bm300," + STR$(drop%) + "r100u100l100d100r25u75r35d20e20d7u7g20bd25f20u7d7h20bu13r15e6g6f6h6l15bl5bu20l5br10bd35d28"
DRAW "c4bm350,450r100l200e10r180f10bl5bu2p4,4"
PRINT "The once ruling all powerful shang tsung has been slaughtered by a falling"
PRINT "logo"
FOR dly! = 1 TO 39999
NEXT dly!
PRINT "Now the tournament is in chaos(not to mention 2-d graphics)scorpion,kano,raiden "
PRINT "and johny cage are now trapped in this cheap rip-off BASIC program for two"
FOR dly! = 1 TO 39999
NEXT dly!
PRINT "players. Rumor has it that these four are not alone. There are others....."
PRINT "................... I like these dots....................................."
FOR dly! = 1 TO 39999
NEXT dly!
CLS
DRAW "c4"
PRINT "D T B software presents stick figure fighting"
FOR dly! = 1 TO 39999
NEXT dly!
whiz:
farter:
CLS
FOR slower% = 1 TO 200
DRAW "c6bm100," + STR$(slower%) + "r100u100l100d100r20bu10r70u40l70u40r70"
FOR dly% = 1 TO 99
NEXT dly%
DRAW "c0bm100," + STR$(slower%) + "r100u100l100d100r20bu10r70u40l70u40r70"
NEXT slower%
DRAW "c6bm100," + STR$(slower%) + "r100u100l100d100r20bu10r70u40l70u40r70"

FOR flower% = 1 TO 200
DRAW "c6bm220," + STR$(flower%) + "r100u100l100d100r20bu10u80r70l70d35r70"
FOR dly% = 1 TO 99
NEXT dly%
DRAW "c0bm220," + STR$(flower%) + "r100u100l100d100r20bu10u80r70l70d35r70"
NEXT flower%
DRAW "c6bm220," + STR$(slower%) + "r100u100l100d100r20bu10u80r70l70d35r70"

FOR flower% = 1 TO 200
DRAW "c6bm340," + STR$(flower%) + "r100u100l100d100r20bu10u80r70l70d35r70"
FOR dly% = 1 TO 99
NEXT dly%
DRAW "c0bm340," + STR$(flower%) + "r100u100l100d100r20bu10u80r70l70d35r70"
NEXT flower%
DRAW "c6bm340," + STR$(slower%) + "r100u100l100d100r20bu10u80r70l70d35r70"
rere:
LOCATE 1, 15
INPUT "TYPE 1 FOR INTRO (AGAIN) TYPE 2 FOR TWO PLAYER BATTLE (DO THIS) OR , IF YOUR SMART TYPE 3 FOR DIRECTIONS OR TYPE 4 TO EXIT(DON'T DO THIS!)", chooser$
IF chooser$ = "1" THEN GOTO newnew:
IF chooser$ = "2" THEN GOTO finer:
IF chooser$ = "3" THEN GOTO goose:
IF chooser$ = "4" THEN goodbuy$ = "on": GOTO finer:
IF chooser$ <> "1" OR chooser$ <> "2" OR chooser$ <> "3" OR chooser$ <> "4" THEN PRINT "I DON'T THINK YOU UNDERSTAND": GOTO rere:
goose:
CLS
PRINT "********PLAYER ONE CONTROLLS*************PLAYER TWO CONTROLLS****************"
PRINT
PRINT "PUNCH           W                            UP ARROW"
PRINT "KICK            X                            DOWN ARROW"
PRINT "FORWARD         D                            LEFT ARROW"
PRINT "BACKWARD        A                            RIGHT ARROW"
PRINT
PRINT
PRINT
PRINT "SFF IS A GAME OF QUICK-ACTION. TO GET THE MAXIMUM ENJOYMENT OUT OF"
PRINT "IT YOU MUST FOLLOW A FEW SIMPLE RULES (CHEATERS DON'T FOLLOW THESE"
PRINT "RULES, AND CHEATERS GO TO HELL!!!!!) "
PRINT "RULE #1 :DON'T HOLD DOWN ON THE KEYS!! JUST TAP, IT'S MORE FUN THIS"
PRINT "WAY!!"
PRINT "RULE #2 :DON'T CHEAT WITH SECRET GUYS IN A SERIOUS MATCH! OOOPS I "
PRINT "GUESS I GAVE THAT AWAY. WHELL THERE ARE SECRET GUYS , AND SECRET"
PRINT "KODES!!! FIND 'EM DAMNIT."
PRINT "BYE THE WAY, WHAT IS THAT COMBO METER ? HMMMMMMM.........."
PRINT
PRINT
INPUT "PRESS ENTER TO KONTINUE.", fjjsjks$
finer:

END SUB

SUB jjohn
SCREEN 12
IF bkrnd$ = "jiffjohn" THEN
        DRAW "c2bl200bu100r150d200l150u200r40bd50r75d140l75u140d20r75br35bu70f30d140g30 "
        LOCATE 11, 20
        PRINT "JIFFY JOHN"
        DRAW "bm600,240c2bl200bu100r150d200l150u200r40bd50r75d140l75u140d20r75br35bu70f30d140g30 "
        LOCATE 11, 55
        PRINT "JIFFY JOHN"
        GOTO hart:
END IF
IF bkrnd$ = "csite" THEN
SCREEN 12
DRAW "c15bd100bl200r400u10l400d10h50u10f50r400h50l400u300d300f50u400d400r400u400d400h50u400d400"
DRAW "bl50u400d400bd60d400u400br50bd10bl10d100r100u100l100bu100r100u100l100d100bu300 r100d100l100u100"
four% = 200
two% = 200
GOTO hart:
END IF
hart:
END SUB

SUB kanof
CLS
'one% = 400
'two% = 200
'three% = 500
'four% = 200
SCREEN 12
c% = c% + 0
    Triangle$ = "bm " + STR$(one% - 50) + "," + STR$(two% + 100) + " r5 l5 u100 l5 u75 r5 d60 u60 l5 u25 "
    DRAW "C2 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)

    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C2 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    FOR dly! = 1 TO 9999
    NEXT dly!
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r60 l60 d75 r5 d100 r5 "
    DRAW "C2 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    FOR dly! = 1 TO 9999
    NEXT dly!
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r60 l60 d75 r5 d100 r5 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " r5 d100 r5 "
    DRAW "C2 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    FOR fart% = 1 TO 90
    c% = c% - 1
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r60 l60 d75 "
    DRAW "C2 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r60 l60 d75 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    NEXT fart%
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r60 l60 d75 "
    DRAW "C2 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
c% = 0
FOR farter% = 1 TO 7
hel1% = one%
hel2% = two%
FOR blood% = 1 TO 100
RANDOMIZE TIMER
bld1% = INT(RND * 100) - 100
bld2% = INT(RND * 100) - 50
LINE (hel1%, hel2%)-(hel1% + bld1%, hel2% + bld2%), 6
NEXT blood%
LINE (hel1% - 100, hel2% - 50)-(hel1%, hel2% + 50), 0, BF
NEXT farter%
    Triangle$ = "bm " + STR$(one% - 50) + "," + STR$(two% + 100) + " r5 l5 u100 l5 u75 r5 d60 u60 l5 u25 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)

FOR fall% = 1 TO 9
c% = c% + 10
    Triangle$ = "bm " + STR$(one% - 50) + "," + STR$(two% + 100) + " r5 l5 u100 l5 u75 r5 d60 u60 l5 u25 "
    DRAW "C2 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    FOR dly% = 1 TO 9999
    NEXT dly%
    Triangle$ = "bm " + STR$(one% - 50) + "," + STR$(two% + 100) + " r5 l5 u100 l5 u75 r5 d60 u60 l5 u25 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
NEXT fall%
    Triangle$ = "bm " + STR$(one% - 50) + "," + STR$(two% + 100) + " r5 l5 u100 l5 u75 r5 d60 u60 l5 u25 "
    DRAW "C2 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)


END SUB

SUB kick
        FOR htdly% = 1 TO 9999
        NEXT htdly%
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l30 d100 "
    DRAW "C" + STR$(c1%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
        FOR htdly% = 1 TO 9999
        NEXT htdly%
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l30 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 f80 e5 g5 h80 l10 d100 "
    DRAW "C" + STR$(c1%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
        FOR htdly% = 1 TO 9999
        NEXT htdly%
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 f80 e5 g5 h80 l10 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r100 u5 d5 l100 l10 d100 "
    DRAW "C" + STR$(c1%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
        FOR htdly% = 1 TO 9999
        NEXT htdly%
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r100 u5 d5 l100 l10 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 f80 e5 g5 h80 l10 d100 "
    DRAW "C" + STR$(c1%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 f80 e5 g5 h80 l10 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)

END SUB

SUB kickl
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C" + STR$(c1%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)

    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l30 d100 "
    DRAW "C" + STR$(c2%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
        FOR htdly% = 1 TO 9999
        NEXT htdly%
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l30 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C" + STR$(c1%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 l100 u5 d5 r100 r10 d100 "
    DRAW "C" + STR$(c2%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
        FOR htdly% = 1 TO 9999
        NEXT htdly%
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 l100 u5 d5 r100 r10 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 g80 h5 f5 e80 r10 d100 "
    DRAW "C" + STR$(c2%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C" + STR$(c1%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)

        FOR htdly% = 1 TO 9999
        NEXT htdly%
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 g80 h5 f5 e80 r10 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)

END SUB

SUB lefty
three% = 500
four% = 200
CLS
SCREEN 12
c% = c% + 0

    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
 '   draw "C" + str$(c1%) +"ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 l60 bd5 r60 d70 r10 d100 bl10 u100 r10"
 '   draw "C" + str$(c1%) +"ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l30 d100 "
 '   draw "C" + str$(c1%) +"ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 l100 u5 d5 r100 r10 d100 "
 '   draw "C" + str$(c1%) +"ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 g80 h5 f5 e80 r10 d100 "
 '   draw "C" + str$(c1%) +"ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 l60 r60 d75 l5 d100 l5 "
 '   draw "C" + str$(c1%) +"ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 h50 f50 d75 l5 g80 u5 "
  '  draw "C" + str$(c1%) +"ta" + STR$(c%) + " X" + VARPTR$(Triangle$)

END SUB

SUB onefall
FOR fall% = 1 TO 9
c% = c% + 10
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two% + 100) + " r5 l5 u100 l5 u75 r5 d60 u60 l5 u25 "
    DRAW "C" + STR$(c1%) + " TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    FOR dly% = 1 TO 9999
    NEXT dly%
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two% + 100) + " r5 l5 u100 l5 u75 r5 d60 u60 l5 u25 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
NEXT fall%
END SUB

SUB onevic
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "c" + STR$(c1%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly! = 1 TO 999
NEXT dly!
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r90 l180 r90 d75 r 20 d100 u100 l40 d100 "
    DRAW "c" + STR$(c1%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly! = 1 TO 999
NEXT dly!
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r90 l180 r90 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 e60 g60 l60 h60 f60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "c" + STR$(c1%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
END SUB

SUB punch
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r60 bd5 l60 d70 r10 d100 bl10 u100 r10"
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C" + STR$(c1%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
        FOR htdly% = 1 TO 9999
        NEXT htdly%
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r60 bd5 l60 d70 r10 d100 bl10 u100 r10"
    DRAW "C" + STR$(c1%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
        FOR htdly% = 1 TO 9999
        NEXT htdly%
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r60 bd5 l60 d70 r10 d100 bl10 u100 r10"
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C" + STR$(c1%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    FOR htdly% = 1 TO 9999
    NEXT htdly%

END SUB

SUB punchl
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 ta" + STR$(c%) + " X" + VARPTR$(Triangle$)

    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C" + STR$(c1%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)

    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 l60 bd5 r60 d70 r5 d100 bl10 u100 r10"
    DRAW "C" + STR$(c2%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
        FOR htdly% = 1 TO 9999
        NEXT htdly%
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 l60 bd5 r60 d70 r10 d100 bl10 u100 r10"
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 l60 bd5 r60 d70 r5 d100 bl10 u100 r10"
    DRAW "C" + STR$(c2%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 l60 bd5 r60 d70 r5 d100 bl10 u100 r10"
    DRAW "C0 ta" + STR$(c%) + " X" + VARPTR$(Triangle$)

END SUB

SUB raidf
SCREEN 12
one% = 200
two% = 200
c1% = 2
    Triangle$ = "bm " + STR$(one% + 200) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C2 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)

FOR spin% = 1 TO 9
c% = c% - 10
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r10 u60 d60 l10 d75 r5 d100 r5 "
    DRAW "C" + STR$(c1%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    FOR dly% = 1 TO 5999
    NEXT dly%
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r10 u60 d60 l10 d75 r5 d100 r5 "
    DRAW "C0 ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
NEXT spin%
FOR fly% = 1 TO 10
flu% = flu% + 20
one% = one% + flu%
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r10 u60 d60 l10 d75 r5 d100 r5 "
    DRAW "C" + STR$(c1%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    FOR dly% = 1 TO 5999
    NEXT dly%
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r10 u60 d60 l10 d75 r5 d100 r5 "
    DRAW "C0 ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
NEXT fly%
SCREEN 12
c% = 0
hel1% = one%
hel2% = two%
one% = 400
two% = 200
aa% = one%
aaa% = two%
bb% = one%
bbb% = two%
cc% = one%
ccc% = two%
dd% = one%
ddd% = two%
hel1% = one%
hel2% = two%
FOR blood% = 1 TO 100
RANDOMIZE TIMER
bld1% = INT(RND * 100) - 50
bld2% = INT(RND * 100) - 50
LINE (hel1%, hel2%)-(hel1% + bld1%, hel2% + bld2%), 4
NEXT blood%
LINE (one% - 50, two% - 50)-(one% + 50, two% + 50), 0, BF

CLS
FOR spin% = 1 TO 20
two% = two% - 20
one% = one% - 10
aa% = aa% + 20
aaa% = aaa% - 10
bb% = bb% + 15
bbb% = bbb% + 20
cc% = cc% - 20
ccc% = ccc% - 20
dd% = dd% - 20
ddd% = ddd% + 20
c% = c% + 10
e% = e% - 10
f% = f% + 10
g% = g% - 10
h% = h% + 10
Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u50 d100"'normal player hit
DRAW "C2 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
        Triangle$ = "bm " + STR$(aa% + 40) + "," + STR$(aaa%) + "l40 r100  "'normal player hit
        DRAW "C2 TA" + STR$(e%) + " X" + VARPTR$(Triangle$)
Triangle$ = "bm " + STR$(bb% - 40) + "," + STR$(bbb%) + " r40 l100"'normal player hit
DRAW "C2 TA" + STR$(f%) + " X" + VARPTR$(Triangle$)
        Triangle$ = "bm " + STR$(cc%) + "," + STR$(ccc% + 50) + "f100"'normal player hit
        DRAW "C2 TA" + STR$(g%) + " X" + VARPTR$(Triangle$)
Triangle$ = "bm " + STR$(dd%) + "," + STR$(ddd% + 50) + "g100"'normal player hit
DRAW "C2 TA" + STR$(h%) + " X" + VARPTR$(Triangle$)
FOR dly% = 1 TO 9999
NEXT dly%
Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u50 d100"'normal player hit
DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
        Triangle$ = "bm " + STR$(aa% + 40) + "," + STR$(aaa%) + "l40 r100  "'normal player hit
        DRAW "C0 TA" + STR$(e%) + " X" + VARPTR$(Triangle$)
Triangle$ = "bm " + STR$(bb% - 40) + "," + STR$(bbb%) + " r40 l100"'normal player hit
DRAW "C0 TA" + STR$(f%) + " X" + VARPTR$(Triangle$)
        Triangle$ = "bm " + STR$(cc%) + "," + STR$(ccc% + 50) + "f100"'normal player hit
        DRAW "C0 TA" + STR$(g%) + " X" + VARPTR$(Triangle$)
Triangle$ = "bm " + STR$(dd%) + "," + STR$(ddd% + 50) + "g100"'normal player hit
DRAW "C0TA" + STR$(h%) + " X" + VARPTR$(Triangle$)
NEXT spin%

END SUB

SUB scorpf
one% = 200
two% = 200
CLS
one% = 200
two% = 200
SCREEN 12
c% = c% + 0
    Triangle$ = "bm " + STR$(one% + 350) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C2 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)

    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r60 bd5 l60 d70 r10 d100 bl10 u100 r10"
    DRAW "C2 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR fly% = 1 TO 250
DRAW "c14"
DRAW "bm " + STR$(fly% + 260) + ",125 u5 r10 u5 f5 g5 u5 l20"
DRAW "c0"
DRAW "bm " + STR$(fly% + 260) + ",125 u5 r10 u5 f5 g5 u5 l20"
NEXT fly%

SCREEN 12
c% = 0
one% = 550
two% = 150
hel1% = one%
hel2% = two%
aa% = one%
aaa% = two%
bb% = one%
bbb% = two%
cc% = one%
ccc% = two%
dd% = one%
ddd% = two%
FOR slide% = 1 TO 10
LINE (hel1% - 50, hel2% - 50)-(hel1% + 50, hel2% + 50), 0, BF
one% = one% + 5
FOR blood% = 1 TO 100
RANDOMIZE TIMER
bld1% = INT(RND * 100) - 50
bld2% = INT(RND * 100) - 50
LINE (hel1%, hel2%)-(hel1% + bld1%, hel2% + bld2%), 4
NEXT blood%
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two% + 50) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C2 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly% = 1 TO 9999
NEXT dly%
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two% + 50) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
one% = one% - 5
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two% + 50) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C2 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly% = 1 TO 9999
NEXT dly%
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two% + 50) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)

NEXT slide%
LINE (hel1% - 50, hel2% - 50)-(hel1% + 50, hel2% + 50), 0, BF
'Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 e50 g50 d75 r5 f80 e5 "'normal player hit
FOR spin% = 1 TO 20
two% = two% - 20
one% = one% - 10
aa% = aa% + 20
aaa% = aaa% - 10
bb% = bb% + 15
bbb% = bbb% + 20
cc% = cc% - 20
ccc% = ccc% - 20
dd% = dd% - 20
ddd% = ddd% + 20
c% = c% + 10
e% = e% - 10
f% = f% + 10
g% = g% - 10
h% = h% + 10
Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u50 d100"'normal player hit
DRAW "C2 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
        Triangle$ = "bm " + STR$(aa% + 40) + "," + STR$(aaa%) + "l40 r100  "'normal player hit
        DRAW "C2 TA" + STR$(e%) + " X" + VARPTR$(Triangle$)
Triangle$ = "bm " + STR$(bb% - 40) + "," + STR$(bbb%) + " r40 l100"'normal player hit
DRAW "C2 TA" + STR$(f%) + " X" + VARPTR$(Triangle$)
        Triangle$ = "bm " + STR$(cc%) + "," + STR$(ccc% + 50) + "f100"'normal player hit
        DRAW "C2 TA" + STR$(g%) + " X" + VARPTR$(Triangle$)
Triangle$ = "bm " + STR$(dd%) + "," + STR$(ddd% + 50) + "g100"'normal player hit
DRAW "C2 TA" + STR$(h%) + " X" + VARPTR$(Triangle$)
FOR dly% = 1 TO 9999
NEXT dly%
Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u50 d100"'normal player hit
DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
        Triangle$ = "bm " + STR$(aa% + 40) + "," + STR$(aaa%) + "l40 r100  "'normal player hit
        DRAW "C0 TA" + STR$(e%) + " X" + VARPTR$(Triangle$)
Triangle$ = "bm " + STR$(bb% - 40) + "," + STR$(bbb%) + " r40 l100"'normal player hit
DRAW "C0 TA" + STR$(f%) + " X" + VARPTR$(Triangle$)
        Triangle$ = "bm " + STR$(cc%) + "," + STR$(ccc% + 50) + "f100"'normal player hit
        DRAW "C0 TA" + STR$(g%) + " X" + VARPTR$(Triangle$)
Triangle$ = "bm " + STR$(dd%) + "," + STR$(ddd% + 50) + "g100"'normal player hit
DRAW "C0TA" + STR$(h%) + " X" + VARPTR$(Triangle$)
NEXT spin%


END SUB

SUB shower
CLS
SCREEN 12
ome:
three% = 320
four% = 340
secret% = 0
cyc% = 0
RANDOMIZE TIMER
RANDOMIZE TIMER
guy% = INT(RND * 4) + 1
'guy% = 4
IF guy% = 1 THEN cyc% = 4: ctext$ = "MY EVIL IS ETERNAL!!! J'AI DEUX NOMMES."
IF guy% = 2 THEN cyc% = 4: ctext$ = "REGARDEZ, LA MAISON BLANCHE"
IF guy% = 3 THEN cyc% = 2: ctext$ = "C'ANT MAKE THE SCENE IF YOU DON'T HAVE THE GREEN!"
IF guy% = 4 THEN cyc% = strange%: ctext$ = "WOW MAN"
FOR ecret% = 1 TO 30
secret% = secret% + 10
IF guy% = 4 THEN cyc% = INT(RND * 15) + 1
    DRAW "c" + STR$(cyc%) + "bm " + STR$(three%) + "," + STR$(secret%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    FOR dly% = 1 TO 999
    NEXT dly%
    DRAW "c0bm " + STR$(three%) + "," + STR$(secret%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
NEXT ecret%
    DRAW "c" + STR$(cyc%) + "bm " + STR$(three%) + "," + STR$(secret%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    LOCATE 10, 10
    DRAW "c15"
    PRINT ctext$
    FOR dly! = 1 TO 599
    IF guy% = 4 THEN cyc% = INT(RND * 15) + 1
    DRAW "c" + STR$(cyc%) + "bm " + STR$(three%) + "," + STR$(secret%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    NEXT dly!
    DRAW "c0bm " + STR$(three%) + "," + STR$(secret%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
FOR ecret% = 1 TO 300
IF guy% = 4 THEN cyc% = INT(RND * 15) + 1
secret% = secret% - 10
    DRAW "c" + STR$(cyc%) + "bm " + STR$(three%) + "," + STR$(secret%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    FOR dly% = 1 TO 999
    NEXT dly%
    DRAW "c0bm " + STR$(three%) + "," + STR$(secret%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
NEXT ecret%
CLS

END SUB

SUB spear1
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 ta" + STR$(c%) + " X" + VARPTR$(Triangle$)

    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r60 bd5 l60 d70 r10 d100 bl10 u100 r10"
    DRAW "C" + STR$(c1%) + " TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR spear% = 1 TO three% - one% - 50
DRAW "bm " + STR$(one% + 50) + "," + STR$(two% - 73) + "r" + STR$(spear%)
NEXT spear%
FOR back% = one% TO three% - 100
hoha% = hoha% - 1
    Triangle$ = "bm " + STR$(three% + hoha%) + "," + STR$(four%) + " u100 d25 h50 f50 d75 l5 g80 u5 "
    DRAW "C" + STR$(c2%) + " TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(three% + hoha%) + "," + STR$(four%) + " u100 d25 h50 f50 d75 l5 g80 u5 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
NEXT back%
    Triangle$ = "bm " + STR$(three% + hoha%) + "," + STR$(four%) + " u100 d25 h50 f50 d75 l5 g80 u5 "
    DRAW "C" + STR$(c2%) + " TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
  
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r60 bd5 l60 d70 r10 d100 bl10 u100 r10"
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)

    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 e60 bd5 g60 d70 r10 d100 bl10 u100 r10"
    DRAW "C" + STR$(c1%) + " TA" + STR$(c%) + " X" + VARPTR$(Triangle$)

hel1% = three% + hoha%
hel2% = four% - 75
FOR blood% = 1 TO 100
RANDOMIZE TIMER
bld1% = INT(RND * 100) - 50
bld2% = INT(RND * 100) - 50
LINE (hel1%, hel2%)-(hel1% + bld1%, hel2% + bld2%), 4
NEXT blood%
three% = three% + hoha%
CLS
END SUB

SUB spear2
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 ta" + STR$(c%) + " X" + VARPTR$(Triangle$)

    Triangle$ = "bm " + STR$(one% + hoha%) + "," + STR$(two%) + " u100 d25 e50 g50 d75 r5 f80 e5 "
    DRAW "C" + STR$(c1%) + " TA" + STR$(c%) + " X" + VARPTR$(Triangle$)

    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 l60 bd5 r60 d70 r10 d100 bl10 u100 r10"
    DRAW "C" + STR$(c2%) + " TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR spear% = 1 TO three% - one% - 50
DRAW "bm " + STR$(three% - 50) + "," + STR$(four% - 73) + "r" + STR$(-spear%)
NEXT spear%
    Triangle$ = "bm " + STR$(one% + hoha%) + "," + STR$(two%) + " u100 d25 e50 g50 d75 r5 f80 e5 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)

FOR back% = one% TO three% - 100

hoha% = hoha% + 1
    Triangle$ = "bm " + STR$(one% + hoha%) + "," + STR$(two%) + " u100 d25 e50 g50 d75 r5 f80 e5 "
    DRAW "C" + STR$(c1%) + " TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one% + hoha%) + "," + STR$(two%) + " u100 d25 e50 g50 d75 r5 f80 e5 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
NEXT back%
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 l60 bd5 r60 d70 r10 d100 bl10 u100 r10"
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)

    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 h60 bd5 f60 d70 r10 d100 bl10 u100 r10"
    DRAW "C" + STR$(c2%) + " TA" + STR$(c%) + " X" + VARPTR$(Triangle$)

    Triangle$ = "bm " + STR$(one% + hoha%) + "," + STR$(two%) + " u100 d25 e50 g50 d75 r5 f80 e5 "
    DRAW "C" + STR$(c1%) + " TA" + STR$(c%) + " X" + VARPTR$(Triangle$)

hel1% = one% + hoha%
hel2% = two% - 75
FOR blood% = 1 TO 100
RANDOMIZE TIMER
bld1% = INT(RND * 100) - 50
bld2% = INT(RND * 100) - 50
LINE (hel1%, hel2%)-(hel1% + bld1%, hel2% + bld2%), 4
NEXT blood%
one% = one% + hoha%
CLS
END SUB

SUB spin1
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 ta" + STR$(c%) + " X" + VARPTR$(Triangle$)

FOR ick% = 1 TO 35
one% = one% + 2
M% = M% + 10
three% = three% + 2
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r10 u60 d60 l10 d75 r5 d100 r5 "
    DRAW "C" + STR$(c1%) + "ta" + STR$(M%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 h50 f50 d75 l5 g80 u5 "
    DRAW "C" + STR$(c2%) + " TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    FOR dly% = 1 TO 999
    NEXT dly%
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r10 u60 d60 l10 d75 r5 d100 r5 "
    DRAW "C0 ta" + STR$(M%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 h50 f50 d75 l5 g80 u5 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
NEXT ick%

END SUB

SUB spin2
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 ta" + STR$(c%) + " X" + VARPTR$(Triangle$)

FOR ck% = 1 TO 35
one% = one% - 2
M% = M% - 10
three% = three% - 2
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 l10 u60 d60 r10 d75 l5 d100 l5 "
    DRAW "C" + STR$(c2%) + "ta" + STR$(M%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + "u100 d25 e50 g50 d75 r5 f80 e5 "
    DRAW "C" + STR$(c1%) + "TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    FOR dly% = 1 TO 999
    NEXT dly%
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 l10 u60 d60 r10 d75 l5 d100 l5 "
    DRAW "C0 ta" + STR$(M%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + "u100 d25 e50 g50 d75 r5 f80 e5 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
NEXT ck%

END SUB

SUB splp1
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "c" + STR$(c1%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    FOR dly! = 1 TO 999
    NEXT dly!
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two% + 30) + " u100 d25 r30 f60 h60 l60 d60 u60 r30 d75 r 20 f70 h70 l40 g70 "
    DRAW "c" + STR$(c1%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    FOR dly! = 1 TO 999
    NEXT dly!
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two% + 100) + " u100 d25 r90 l120 d60 u60 r30 d75 r100 l200 "
    DRAW "c" + STR$(c1%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    FOR dly! = 1 TO 999
    NEXT dly!
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two% + 100) + " u100 d25 r90 l120 d60 u60 r30 d75 r100 l200 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two% + 30) + " u100 d25 r30 f60 h60 l60 d60 u60 r30 d75 r 20 f70 h70 l40 g70  "
    DRAW "c" + STR$(c1%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    FOR dly! = 1 TO 999
    NEXT dly!
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two% + 30) + " u100 d25 r30 f60 h60 l60 d60 u60 r30 d75 r 20 f70 h70 l40 g70 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "c" + STR$(c1%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)

END SUB

SUB splp2
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "c" + STR$(c2%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    FOR dly! = 1 TO 999
    NEXT dly!
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four% + 30) + " u100 d25 r30 d60 u60 l60 g60 e60 r30 d75 r 20 f70 h70 l40 g70 "
    DRAW "c" + STR$(c2%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    FOR dly! = 1 TO 999
    NEXT dly!
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four% + 100) + " u100 d25 l90 r120 d60 u60 l30 d75 r100 l200 "
    DRAW "c" + STR$(c2%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    FOR dly! = 1 TO 999
    NEXT dly!
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four% + 30) + " u100 d25 r30 d60 u60 l60 g60 e60 r30 d75 r 20 f70 h70 l40 g70  "
    DRAW "c" + STR$(c2%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    FOR dly! = 1 TO 999
    NEXT dly!
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "c" + STR$(c2%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)

END SUB

SUB stgf1
SCREEN 12
one% = 200
two% = 350
spike% = 20
one% = 500
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "c8 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
one% = 200
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r90 l90 d75 r20 d100  "
    DRAW "c8 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly! = 1 TO 9999
NEXT dly!
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + "  u100 d25 r90 l90 d75 r20 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " d50 u100 d25 f30 u30 d30 h30 d75 r50 d50 "
    DRAW "c8 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly! = 1 TO 9999
NEXT dly!
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + "d50 u100 d25 f30 u30 d30 h30 d75 r50 d50 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + "d100 u100 d25 f30 u30 d30 h30 d75 e40 d40"
    DRAW "c8 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)

one% = 500
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "c8 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly! = 1 TO 9999
NEXT dly!
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r90 l180 r90 d75 r 20 d100 u100 l40 d100 "
    DRAW "c8 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly! = 1 TO 9999
NEXT dly!
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r90 l180 r90 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 e60 g60 l60 h60 f60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "c8 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly! = 1 TO 9999
NEXT dly!
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 e60 g60 l60 h60 f60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)

FOR fall% = 1 TO 37
spike% = spike% + 5
        Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + "u100 d25 e50 g50 d75 r5 f80 e5 "
        DRAW "c8 TA" + STR$(n%) + " X" + VARPTR$(Triangle$)
Triangle$ = "bm 20," + STR$(spike%) + " r600 l50 d50 u50 l50 d50 u50 l50 d50 u50 l50 d50 u50 l50 d50 u50 l50 d100 u100 l200 d100 u100 l50 d50 u50 l50 d50"
DRAW "c8 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly! = 1 TO 999
NEXT dly!
        Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + "u100 d25 e50 g50 d75 r5 f80 e5 "
        DRAW "C0 TA" + STR$(n%) + " X" + VARPTR$(Triangle$)
Triangle$ = "bm 20," + STR$(spike%) + " r600 l50 d50 u50 l50 d50 u50 l50 d50 u50 l50 d50 u50 l50 d50 u50 l50 d100 u100 l200 d100 u100 l50 d50 u50 l50 d50"
DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
NEXT fall%
Triangle$ = "bm 20," + STR$(spike%) + " r600 l50 d50 u50 l50 d50 u50 l50 d50 u50 l50 d50 u50 l50 d50 u50 l50 d100 u100 l200 d100 u100 l50 d50 u50 l50 d50"
DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)

FOR fall% = 1 TO 30
spike% = spike% + 5
n% = n% + 5
IF n% >= 70 THEN n% = n% - 5
two% = two% + 5
IF two% >= 410 THEN two% = two% - 5

        Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + "u100 d25 e50 g50 d75 r5 f80 e5 "
        DRAW "c8 TA" + STR$(n%) + " X" + VARPTR$(Triangle$)
Triangle$ = "bm 20," + STR$(spike%) + " r600 l50 d50 u50 l50 d50 u50 l50 d50 u50 l50 d50 u50 l50 d50 u50 l50 d100 u100 l200 d100 u100 l50 d50 u50 l50 d50"
DRAW "c8 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
hel1% = one%
hel2% = two%
FOR blood% = 1 TO 100
RANDOMIZE TIMER
bld1% = INT(RND * 100) - 50
bld2% = INT(RND * 100) - 50
LINE (hel1%, hel2%)-(hel1% + bld1%, hel2% + bld2%), 4
NEXT blood%
LINE (one% - 50, two% - 50)-(one% + 50, two% + 50), 0, BF

FOR dly! = 1 TO 99
NEXT dly!
        Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + "u100 d25 e50 g50 d75 r5 f80 e5 "
        DRAW "C0 TA" + STR$(n%) + " X" + VARPTR$(Triangle$)
Triangle$ = "bm 20," + STR$(spike%) + " r600 l50 d50 u50 l50 d50 u50 l50 d50 u50 l50 d50 u50 l50 d50 u50 l50 d100 u100 l200 d100 u100 l50 d50 u50 l50 d50"
DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
NEXT fall%
FOR fall% = 1 TO 80
spike% = spike% - 5
two% = two% - 5
        Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + "u100 d25 e50 g50 d75 r5 f80 e5 "
        DRAW "c8 TA" + STR$(n%) + " X" + VARPTR$(Triangle$)
Triangle$ = "bm 20," + STR$(spike%) + " r600 l50 d50 u50 l50 d50 u50 l50 d50 u50 l50 d50 u50 l50 d50 u50 l50 d100 u100 l200 d100 u100 l50 d50 u50 l50 d50"
DRAW "c8 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly! = 1 TO 999
NEXT dly!
        Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + "u100 d25 e50 g50 d75 r5 f80 e5 "
        DRAW "C0 TA" + STR$(n%) + " X" + VARPTR$(Triangle$)
Triangle$ = "bm 20," + STR$(spike%) + " r600 l50 d50 u50 l50 d50 u50 l50 d50 u50 l50 d50 u50 l50 d50 u50 l50 d100 u100 l200 d100 u100 l50 d50 u50 l50 d50"
DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
NEXT fall%
Triangle$ = "bm 20," + STR$(spike%) + " r600 l50 d50 u50 l50 d50 u50 l50 d50 u50 l50 d50 u50 l50 d50 u50 l50 d100 u100 l200 d100 u100 l50 d50 u50 l50 d50"
DRAW "c8 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)

        Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + "u100 d25 e50 g50 d75 r5 f80 e5 "
        DRAW "c8 TA" + STR$(n%) + " X" + VARPTR$(Triangle$)
one% = 200
two% = 350
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + "d100 u100 d25 f30 u30 d30 h30 d75 e40 d40"
    DRAW "c8 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly! = 1 TO 999
NEXT dly!
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + "d100 u100 d25 f30 u30 d30 h30 d75 e40 d40"
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " d50 u100 d25 f30 u30 d30 h30 d75 r50 d50 "
    DRAW "c8 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly! = 1 TO 999
NEXT dly!
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " d50 u100 d25 f30 u30 d30 h30 d75 r50 d50 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r90 l90 d75 r20 d100  "
    DRAW "c8 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly! = 1 TO 999
NEXT dly!

    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "c8 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly! = 1 TO 9999
NEXT dly!
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r90 l180 r90 d75 r 20 d100 u100 l40 d100 "
    DRAW "c8 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly! = 1 TO 9999
NEXT dly!
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r90 l180 r90 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r30 e60 g60 l60 h60 f60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "c8 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly! = 1 TO 9999
NEXT dly!


DO
RANDOMIZE TIMER
hogo% = INT(RND * 100) + 1
ho% = 10
g% = 5
FOR bldf% = 1 TO 50
FOR fill% = 1 TO 5
g% = g% - 1
CIRCLE (400 + hogo%, ho%), g%, 4
NEXT fill%
g% = 5
FOR dly% = 1 TO 999
NEXT dly%
FOR fil% = 1 TO 5
g% = g% - 1
CIRCLE (400 + hogo%, ho%), g%, 0
NEXT fil%
ho% = ho% + 10
g% = 5
NEXT bldf%
LOOP UNTIL INKEY$ <> ""

END SUB

SUB stgf2
SCREEN 12
e% = 0
one% = 200
two% = 350
begin:
  
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r60 l60 d75 r5 d100 r5 "
    DRAW "C2 TA" + STR$(e%) + " X" + VARPTR$(Triangle$)
FOR d% = 1 TO 35
c% = c% - 10
IF c% < -189 THEN GOTO hooho:
DRAW "C2"             'Set color to magenta.
axe$ = "bm 320,100 r200 g30 r100 h30 e30 l100 f30"  'Draw a triangle.
DRAW "C2 TA" + STR$(c%) + " X" + VARPTR$(axe$)
DRAW "BD10"           'Move down into the triangle.
DRAW " P7,2 "'Paint interior.
      
        IF c% = -100 THEN
        hel1% = one%
        hel2% = two% - 50
        FOR blood% = 1 TO 100
        RANDOMIZE TIMER
        bld1% = INT(RND * 100) - 50
        bld2% = INT(RND * 100) - 50
        LINE (hel1%, hel2%)-(hel1% + bld1%, hel2% + bld2%), 4
        NEXT blood%
        LINE (one% - 50, two% - 50)-(one% + 50, two% + 50), 0, BF
        END IF

FOR dly% = 1 TO 9999
NEXT dly%
DRAW "C0"             'Set color to magenta.
axe$ = "bm 320,100 r200 g30 r100 h30 e30 l100 f30"  'Draw a triangle.
DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(axe$)
DRAW "BD10"           'Move down into the triangle.
DRAW " P0,0 "           'Paint interior.

NEXT d%
hooho:


END SUB

SUB stgf3
SCREEN 12
CLS
c2% = 2
three% = 200
four% = 200
loser% = 1

DO
four% = four% + 30
IF four% > 480 THEN
faller% = faller% + 1
four% = 1
hoy% = 0
END IF
IF faller% >= 10 THEN GOTO final:
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + "u5d5r100u5r100l25u60 "
    DRAW "C" + STR$(c2%) + " TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
loser% = loser% + 1
IF loser% > 30 THEN loser% = loser% - 1
hoy% = hoy% - loser%
IF hoy% < -200 THEN hoy% = 0
DRAW "c15"
DRAW "bm320,240bd100bbl200br400bu10bl400bd10bh50bu10bf50br400bh50bl400bu300bd300bf50bu400bd400br400bu400bd400bh50bu400bd400"
DRAW "bl50u400d400d60d400u400br50"
DRAW "bd" + STR$(hoy%) + " bl10d100r100u100l100bu100r100u100l100d100bu300 r100d100l100u100"
  
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + "u5d5r100u5r100l25u60 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
DRAW "c0"
DRAW "bm320,240bd100bbl200br400bu10bl400bd10bh50bu10bf50br400bh50bl400bu300bd300bf50bu400bd400br400bu400bd400bh50bu400bd400"
DRAW "bl50u400d400d60d400u400br50"
DRAW "bd" + STR$(hoy%) + " bl10d100r100u100l100bu100r100u100l100d100bu300 r100d100l100u100"
LOOP

final:
DRAW "bm640,480"
FOR spd% = 1 TO 64
RANDOMIZE TIMER
hoo% = INT(RND * 100) + 100
DRAW "c15"
DRAW "l10u" + STR$(hoo%) + "d" + STR$(hoo%)
NEXT spd%
four% = 1
FOR fall% = 1 TO 20
four% = four% + 20
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + "u5d5r100u5r100l25u60 "
    DRAW "C" + STR$(c2%) + " TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly% = 1 TO 999
NEXT dly%
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + "u5d5r100u5r100l25u60 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
NEXT fall%
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + "u5d5r100u5r100l25u60 "
    DRAW "C" + STR$(c2%) + " TA" + STR$(c%) + " X" + VARPTR$(Triangle$)

INPUT "", fdfsljkj$
END SUB

SUB sup1
FOR spin% = 1 TO 9
c% = c% - 10
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r10 u60 d60 l10 d75 r5 d100 r5 "
    DRAW "C" + STR$(c1%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    FOR dly% = 1 TO 5999
    NEXT dly%
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r10 u60 d60 l10 d75 r5 d100 r5 "
    DRAW "C0 ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
NEXT spin%
FOR fly% = 1 TO 7
flu% = flu% + 10
one% = one% + flu%
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r10 u60 d60 l10 d75 r5 d100 r5 "
    DRAW "C" + STR$(c1%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    FOR dly% = 1 TO 5999
    NEXT dly%
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r10 u60 d60 l10 d75 r5 d100 r5 "
    DRAW "C0 ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
NEXT fly%
FOR fly% = 1 TO 7
flu% = flu% - 10
one% = one% - flu%
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r10 u60 d60 l10 d75 r5 d100 r5 "
    DRAW "C" + STR$(c1%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    FOR dly% = 1 TO 5999
    NEXT dly%
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r10 u60 d60 l10 d75 r5 d100 r5 "
    DRAW "C0 ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
NEXT fly%
FOR spin% = 1 TO 9
c% = c% + 10
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r10 u60 d60 l10 d75 r5 d100 r5 "
    DRAW "C" + STR$(c1%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    FOR dly% = 1 TO 5999
    NEXT dly%
    Triangle$ = "bm " + STR$(one%) + "," + STR$(two%) + " u100 d25 r10 u60 d60 l10 d75 r5 d100 r5 "
    DRAW "C0 ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
NEXT spin%
c% = 0

END SUB

SUB sup2
FOR spin% = 1 TO 9
c% = c% + 10
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 l10 u60 d60 r10 d75 l5 d100 l5 "
    DRAW "C" + STR$(c2%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    FOR dly% = 1 TO 5999
    NEXT dly%
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 l10 u60 d60 r10 d75 l5 d100 l5 "
    DRAW "C0 ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
NEXT spin%
FOR fly% = 1 TO 7
flu% = flu% - 10
three% = three% + flu%
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 l10 u60 d60 r10 d75 l5 d100 l5 "
    DRAW "C" + STR$(c2%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    FOR dly% = 1 TO 5999
    NEXT dly%
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 l10 u60 d60 r10 d75 l5 d100 l5"
    DRAW "C0 ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
NEXT fly%
FOR fly% = 1 TO 7
flu% = flu% + 10
three% = three% - flu%
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 l10 u60 d60 r10 d75 l5 d100 l5 "
    DRAW "C" + STR$(c2%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    FOR dly% = 1 TO 5999
    NEXT dly%
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 l10 u60 d60 r10 d75 l5 d100 l5"
    DRAW "C0 ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
NEXT fly%
FOR spin% = 1 TO 9
c% = c% - 10
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 l10 u60 d60 r10 d75 l5 d100 l5"
    DRAW "C" + STR$(c2%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
    FOR dly% = 1 TO 5999
    NEXT dly%
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 l10 u60 d60 r10 d75 l5 d100 l5 "
    DRAW "C0 ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
NEXT spin%
c% = 0

END SUB

SUB twofall
FOR fall% = 1 TO 9
c% = c% - 10
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four% + 100) + "l5 r5 u100 r5 u75 l10 d60 u60 r10 u25 "
    DRAW "C" + STR$(c2%) + " TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    FOR dly% = 1 TO 9999
    NEXT dly%
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four% + 100) + " l5 r5 u100 r5 u75 l10 d60 u60 r10 u25 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    NEXT fall%
END SUB

SUB twovic
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "c" + STR$(c2%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly! = 1 TO 999
NEXT dly!
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 d60 u60 l60 d60 u60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r90 l180 r90 d75 r 20 d100 u100 l40 d100 "
    DRAW "c" + STR$(c2%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
FOR dly! = 1 TO 999
NEXT dly!
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r90 l180 r90 d75 r 20 d100 u100 l40 d100 "
    DRAW "C0 TA" + STR$(c%) + " X" + VARPTR$(Triangle$)
    Triangle$ = "bm " + STR$(three%) + "," + STR$(four%) + " u100 d25 r30 e60 g60 l60 h60 f60 r30 d75 r 20 d100 u100 l40 d100 "
    DRAW "c" + STR$(c2%) + "ta" + STR$(c%) + " X" + VARPTR$(Triangle$)
END SUB

