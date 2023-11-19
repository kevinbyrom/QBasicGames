'                                   CLOCK
'                               BY SEAN BUGEL
'    ***********************************************************************
'    * Hello, this has been yet another product by SEAN BUGEL.             *
'    * If you like these songs send ($2) - CASH ONLY- and you will be put  *
'    * immediately onto my mailing list A.S.A.P. In my special package you *
'    * will recieve up to 10 items. Send a letter saying how many games or *
'    * songs would like.                                                   *
'    * For example: Yes SEAN BUGEL put me on the list. My $2 is enclosed   *
'    * and I would like 6 of your best games and 4 of your best songs. If  *
'    * You have ordered before make a list of games you already own        *
'    *                                                                     *
'    * That is my special 10 reply.   THANK YOU                            *
'    *                                        John Doe                     *
'    *                                        123 ABC LANE                 *
'    *                                        town, state zip              *
'    ***********************************************************************
'                        Press Shift & F5 to begin







1
p15 = 0
SCREEN 12
CLS
'set our palettes to black
PALETTE 9, 0
PALETTE 6, 0
PALETTE 1, 0
PALETTE 8, 0
PALETTE 15, 0

'draw our clock shape...
'there are many possibilities for
'analog and digital clock designs
CIRCLE (319, 239), 230, 9
CIRCLE (319, 239), 229, 9
CIRCLE (319, 239), 228, 6
CIRCLE (319, 239), 227, 6
CIRCLE (319, 239), 226, 1
CIRCLE (319, 239), 225, 1
CIRCLE (319, 239), 224, 8
PAINT (319, 239), 8


'a little info
COLOR 9
LOCATE 1, 70: PRINT DATE$
LOCATE 1, 1: PRINT "PrEsS [S] To SeT cLoCk"
LOCATE 28, 1
PRINT "PrEsS [C] FoR a CuCkOo!"
LOCATE 28, 63
PRINT "PrEsS eSc To QuIt"



'turn on the colors
PALETTE 8, 65536 * 10
PALETTE 9, (65536 * 63) + (257 * 15)
PALETTE 6, 65536 * 63
PALETTE 1, 65536 * 20

'draw the white squares around the clock face
'("ta" is a DRAW rotation command)
ta = -30
FOR sq = 1 TO 11
ta$ = "ta" + STR$(ta)
PRESET (319, 239)
DRAW ta$ + "c15bu210nl6r6d12l12u12"
ta = ta - 30
NEXT



'draw the number "12" at the top (looks better than a PRINT 12)
PRESET (315, 25)
DRAW "c15ta0d10r1nu10br6r6u1l6u4r6u1nl6u4l6u1r6bl12l2"



'fade in our white squares
DO
p15 = p15 + (65536 + 257)
PALETTE 15, p15
FOR pause = 1 TO 250
NEXT
LOOP UNTIL p15 = (65536 + 257) * 63

'Get the initial "hour hand" setting
min$ = LEFT$(TIME$, 5)
m = VAL(RIGHT$(min$, 2))
m = m / 12
m = INT(m)
h = VAL(LEFT$(TIME$, 2))
IF h > 11 THEN h = h - 12
h = h + (m / 5)
h = (h * 5) * -6
hh$ = "ta" + STR$(h)

'turn on our ESC and C keys...
'I set two each: one for NUM LOCK "on" and one for NUM LOCK "off"
KEY 15, CHR$(32) + CHR$(1)
ON KEY(15) GOSUB endit
KEY(15) ON

KEY 16, CHR$(0) + CHR$(1)
ON KEY(16) GOSUB endit
KEY(16) ON

KEY 17, CHR$(0) + CHR$(46)
ON KEY(17) GOSUB cuckoo
KEY(17) ON

KEY 18, CHR$(32) + CHR$(46)
ON KEY(18) GOSUB cuckoo
KEY(18) ON

KEY 19, CHR$(0) + CHR$(31)
ON KEY(19) GOSUB setclock
KEY(19) ON

KEY 20, CHR$(32) + CHR$(31)
ON KEY(20) GOSUB setclock
KEY(20) ON







GOTO newminute

hourshift: '(draws the new hour hand position)
'cuckoo evey new hour
IF (m / -6) = 0 THEN
PALETTE 8, 65536 * 63
PLAY "mfo3l12ap24e"
PALETTE 8, 65536 * 10
END IF

LOCATE 1, 70: PRINT DATE$
PRESET (319, 239)
DRAW hh$ + "c8h10u110e10f10d110g10"
h = h / -6
h = h + 1
IF h > 59 THEN h = 0

h = h * -6
hh$ = "ta" + STR$(h)
PRESET (319, 239)
DRAW hh$ + "c9h10u110e10f10d110g10"


hryes = 0


newminute: '(draws the new minute hand position)
PRESET (319, 239)
DRAW mh$ + "c8h10u168e10f10d168g10"
min$ = LEFT$(TIME$, 5)
m = VAL(RIGHT$(min$, 2)) * -6
mh$ = "ta" + STR$(m)
PRESET (319, 239)
DRAW mh$ + "c9h10u168e10f10d168g10"
PRESET (319, 239)
DRAW hh$ + "c9h10u110e10f10d110g10"
'For every 12 minutes (00,12,24,36,48), the hour hand moves 1 "minute space"
'Just about like a real clock!!!!  Whooopeeeeeeee!!!!

mx = (m / -6) / 12
IF mx = INT(mx) AND s = 0 AND hryes = 1 THEN GOTO hourshift
hryes = 1

DO
IF s <> VAL(RIGHT$(TIME$, 2)) * -6 THEN
PRESET (319, 239)
DRAW sh$ + "c8u180nl4r4h4g4"
s = VAL(RIGHT$(TIME$, 2)) * -6
sh$ = "ta" + STR$(s)

'constantly redraw all 3 hands (else the "seconds" hand would
'black out the others when redrawn)
PRESET (319, 239)
DRAW sh$ + "c9u180nl4r4h4g4"
PRESET (319, 239)
DRAW mh$ + "c9h10u168e10f10d168g10"
PRESET (319, 239)
DRAW hh$ + "c9h10u110e10f10d110g10"
IF VAL(RIGHT$(TIME$, 2)) = 0 THEN GOTO newminute

END IF
LOOP


endit:
x = 638
y = 0
FOR x = 638 TO 0 STEP -2
LINE (x, y)-(x, y + 479), 6
NEXT


x = 0
y = 0
FOR x = 1 TO 639 STEP 2
LINE (x, y)-(x, y + 479), 6
NEXT
PALETTE 0, 65536 * 63
COLOR 15

LOCATE 12, 23
PRINT "This has been a SEAN BUGEL production"
LOCATE 14, 26
PRINT "*******************************"
LOCATE 16, 29
PRINT "Support BASIC programming."
LOCATE 20, 32

PLAY "mfo3l12ap24e"
SLEEP

pp = 65536 * 63
pw = (65536 + 257) * 63
FOR p = 1 TO 63
pp = pp - 65536
pw = pw - (65536 + 257)
PALETTE 6, pp
PALETTE 15, pw
PALETTE 0, pp
NEXT
KEY(0) OFF

CLS
END

cuckoo:
KEY(17) STOP
KEY(18) STOP
PALETTE 8, 65536 * 63
PLAY "mfo3l12ap24e"
PALETTE 8, 65536 * 10
KEY(17) ON
KEY(18) ON
RETURN


setclock:
CLS
SHELL "TIME"
GOTO 1
'RUN "111clock.bas"

