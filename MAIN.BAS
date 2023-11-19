'============================================================================`            
'                                Hey you!!!                                  `
'                      Do you like to surph the web?                         `
'                       Then visit my web site! Now!                         `
'                                                                            `
'                       http://members.aol.com/rjd42                         `
'                                                                            `
'                    Write it down so you don't forget!                      `
'============================================================================`               
'            Are you having trouble getting this program to start?           `
'              page down about 6 times till you see a space with             `
'          lots of lines like ======.  Then read what it says there.         `
'============================================================================`               
'    Guess what?  Do you like this game?  At my web site you can download    `
'     a program I made called GQ2SE (Grako Quest 2 Stage Editor) so that     `
'      you can MAKE YOUR OWN STAGES FOR THIS GAME.  It's tons of fun and     `
'                          it's free!  Go get it!                            `
'       At my web site you can also download extra stages for this game.     `
'                        What are you waiting for?!                          `
'                       http://members.aol.com/rjd42                         `
'============================================================================`              












'Here's the programming... don't edit it!
'You are not allowed to edit this programming.
'Grako Quest 2
'Copyright Noah Daleo 1996
DECLARE SUB batattack ()
DECLARE SUB checkfilename (x$)
DECLARE SUB chooselevel ()
DECLARE SUB DetectSB ()
DECLARE SUB drawbat ()
DECLARE SUB batdata ()
DECLARE SUB beardata ()
DECLARE SUB drawbear ()
DECLARE SUB youfell ()
DECLARE SUB menu ()
DECLARE SUB jumpbackwards ()
DECLARE SUB crowdata ()
DECLARE SUB drawcrow ()
DECLARE SUB youwin ()
DECLARE SUB youlose ()
DECLARE SUB snakeexplosion (xxh%, xxv%, shd%)
DECLARE SUB checkdown ()
DECLARE SUB lastguylower2 ()
DECLARE SUB drawlastguy ()
DECLARE SUB intro ()
DECLARE SUB cone (ch%, cv%, height%, size%)
DECLARE SUB statusbar ()
DECLARE SUB lastguylower ()
DECLARE SUB explosion (xh%, xv%, es%)
DECLARE SUB drawsnake ()
DECLARE SUB snakedata ()
DECLARE SUB drawdog ()
DECLARE SUB dogdata ()
DECLARE SUB echeck4fall ()
DECLARE SUB jumpacross ()
DECLARE SUB gameplay ()
DECLARE SUB tile (ulh%, ulv%, tylestyle$)
DECLARE SUB background ()
DECLARE SUB drawplayer ()
DECLARE SUB delay (break)
DECLARE SUB checkleft ()
DECLARE SUB checkright ()
DECLARE SUB jumpstraightup ()
DECLARE SUB checkup ()
DIM SHARED ph%, pv%, af%, dir$, okay$, jumping$, liftoff%
DIM SHARED justfell$, screennum%, exitsubs$, enemy$, eh%, ev%
DIM SHARED efall%, edir$, echeck$, life%, falling$, sidego$
DIM SHARED B$, B%, go$, yupup$, level%, lev$, enemy2$, ev2%
DIM SHARED eh2%, edir2$, yaba$, ev3%, eh3%, edir3$, enemy3$
DIM SHARED a1$, a2$, a3$, a4$, a5$, a6$, a7$, a8$, a9$
DIM SHARED b1$, b2$, b3$, b4$, b5$, b6$, b7$, b8$, b9$
DIM SHARED c1$, c2$, c3$, c4$, c5$, c6$, c7$, c8$, c9$
DIM SHARED d1$, d2$, d3$, d4$, d5$, d6$, d7$, d8$, d9$
DIM SHARED e1$, e2$, e3$, e4$, e5$, e6$, e7$, e8$, e9$
DIM SHARED f1$, f2$, f3$, f4$, f5$, f6$, f7$, f8$, f9$
DIM SHARED LGUY%, note%, music$, sounds$, stage$, lguyl$, pluskey$, bbcounter
DIM SHARED lguyl2$, lgt%, lglunge%, aff%, lunging$, jumpingup$, bloodbath$
DIM SHARED fallingdown$, olo$, dst%, dlf%, break, bgc%, musicnumbergooga%
DIM SHARED crushnow$, crush%, crushnow3$, crush3%, kills%, player$
DIM SHARED gun%, starttime$, secrets%, jolopolu$, klopted$, batwait%
DIM SHARED goh%, gov%, passme$, dogdead$, diff%, ndemo$, nogoodname$
DIM SHARED dstoptimer%, screentype%, fdir$, ddsounds$, thefilename$
DIM SHARED ddcolors$, ddeffect%, p1z$, p1$, p2$, p3$, p4$, BasePort%
DIM SHARED p5$, p6$, p7$, p8$, p10$, p11$, p12$, shogo$, canhavemusic$
DIM SHARED fellfrom%, stagetitle$, author$, ammo%, lives%, DetectedSB
DIM SHARED score%, xbh%, xbv%, getout$, hh%, hv%, ah%, av%, sblocation
DIM SHARED xh%, xv%, strh%, strv%, up1h%, up1v%, mapname$, itsfallin$
DIM SHARED Ichose$, userdeffedlev$, syu%, berh%, berv%, bedir$, notenumber
DIM SHARED befall%, syyu%, bath%, batv%, bcnt%, bmu%, bml%, bmr%, bmd%
DECLARE SUB LoadIns (filename$)
DECLARE SUB PlayMusic ()
DECLARE SUB Translate (x$, Channel%)
DECLARE SUB SBInit ()
DECLARE SUB closechannels ()
DECLARE SUB SetIns (Channel%)
DECLARE SUB WriteReg (Reg%, value%)
DECLARE FUNCTION SpaceLess$ (x$)
CONST MaxChannel% = 3
CONST MaxNotes% = 400
CONST MaxPlay% = -1
TYPE InsType
MMult AS INTEGER
MLevel AS INTEGER
MAttack AS INTEGER
MSustain AS INTEGER
CMult AS INTEGER
CLevel AS INTEGER
CAttack AS INTEGER
CSustain AS INTEGER
END TYPE
TYPE ChannelType
Defined AS INTEGER
Speed AS SINGLE
SongPtr AS INTEGER
PStat AS SINGLE
Octave AS INTEGER
WaveForm AS INTEGER
Flag AS INTEGER
Flag2 AS INTEGER
IsPlaying AS INTEGER
IsDone AS INTEGER
END TYPE
DIM SHARED ChannelStat(1 TO MaxChannel%) AS ChannelType
DIM SHARED Songbuf(1 TO (MaxChannel% + 1) * MaxNotes%) AS INTEGER
DIM SHARED CurrentIns AS InsType
ON ERROR GOTO oops




'=============================================================================         
'=============================================================================              
'HERE IT IS!!!!!
'IF YOU CAN'T GET THIS TO START, THEN TYPE IN THE LOCATION OF THE FILES
'IN THE SPACE BELOW.  REPLACE DIRECTORY WITH THE NAME OF THE DIRECTORY YOU
'HAVE ALL OF THE FILES IN.  THEN REMOVE THE WORD REM
'THEN SAVE THIS FILE AND TRY RUNNING THE PROGRAM AGAIN.

REM CHDIR "C:\DIRECTORY"
'=============================================================================               
'=============================================================================             




545
pluskey$ = "NO"
canhavemusic$ = "NO"
DetectSB
player$ = "NORMAL"
bloodbath$ = "NO"
itsfallin$ = "NO"
Ichose$ = "NO"
starttime$ = TIME$
screentype% = 13
diff% = 2
sounds$ = "YES"
music$ = canhavemusic$'if you have a SB then the default is YES and vice versa
CALL intro
menucaller:
CALL menu
IF RIGHT$(ddsounds$, 3) = "NOT" THEN sounds$ = "NO": dsounds$ = "NO": music$ = "NO"
78 COLOR 15
score% = 0
gun% = 1
lives% = 5
olo$ = "NO"
fallingdown$ = "YES"
stage$ = "1"
9 IF olo$ = "NOPO" THEN stage$ = "4": olo$ = "NO"
screennum% = 1
dir$ = "STOPPED"
life% = 100 * diff%
ammo% = 100
IF Ichose$ = "YES" THEN mapname$ = userdeffedlev$: GOTO gopassed
gopassed:
CLS : SCREEN screentype%
OPEN mapname$ FOR INPUT AS #1
INPUT #1, null$
INPUT #1, stagetitle$
INPUT #1, author$
INPUT #1, null$
INPUT #1, null$
INPUT #1, null$
INPUT #1, musicnumbergooga%
INPUT #1, bgc%
CLOSE #1

DO
SELECT CASE musicnumbergooga%
CASE IS = 1
Channel1$ = "P(.1) ABCDEF"
CALL Translate(Channel1$, 1)                              ''
Channel2$ = "P(8.5) T(1) D P(1) T(.5) EFE T(.25) FEF P(.5) D T(.1) A T(.25) P(.25) E T(.1) A T(.25) P(.25) D T(.1) A T(.25) P(.25) E T(.1) A T(.25)"
CALL Translate(Channel2$, 2)
Channel3$ = "P(.1) FEDCBA"
CALL Translate(Channel3$, 3)
LoadIns "standard.ins"
SetIns 1
LoadIns "trumpet.ins"
SetIns 2
LoadIns "standard.ins"
SetIns 3
EXIT DO
CASE IS = 2
Channel1$ = "P(.25) O(2) ABCDEF"
CALL Translate(Channel1$, 1)
Channel2$ = "T(2.5) O(1) ABCDEF"
CALL Translate(Channel2$, 2)
LoadIns "standard.ins"
SetIns 1
LoadIns "bells.ins"
SetIns 2
EXIT DO
CASE IS = 3
Channel1$ = "P(4) EEFGBBCCDC P(2) EEFGBBCCDCBABCDEFG P(3) EEEFEEEAAA P(.5) EFFFFEFFEEFFDDCDCFFE"
CALL Translate(Channel1$, 1)
Channel2$ = "T(.1) AAFF"
CALL Translate(Channel2$, 2)
Channel3$ = "P(4) EEFGBBCCDC P(2) EEFGBBCCDCBABCDEFG P(3) EEEFEEEAAA P(.5) EFFFFEFFEEFFDDCDCFFE"
CALL Translate(Channel3$, 3)
LoadIns "trumpet.ins"
SetIns 1
LoadIns "bells.ins"
SetIns 2
LoadIns "bells.ins"
SetIns 3
EXIT DO
CASE IS = 4
Channel1$ = "P(1) O(6) T(1) D T(.75) E T(.5) F T(.25) G"
CALL Translate(Channel1$, 1)
Channel2$ = "P(10) T(.5) D T(.25) E T(1) C T(.25) A T(.5) B P(5) T(.25) DEFGFGFEABDEFGFGFEABDGEFDEGF P(9)"
CALL Translate(Channel2$, 2)
Channel3$ = "P(12) T(.5) D T(.25) E T(1) C T(.25) A T(.5) B P(12) T(.25) DEFGFGFEABDEFGFGFEABDGEFDEGF"
CALL Translate(Channel3$, 3)
LoadIns "trumpet.ins"
SetIns 1
LoadIns "trumpet.ins"
SetIns 2
LoadIns "standard.ins"
SetIns 3
EXIT DO
CASE IS = 5
Channel1$ = "P(1) T(.25) ab P(1) ab P(1) b T(1) cb T(.75) a T(.5) g T(.25) FED T(1) E P(1) T(.5) def T(.25) P(.25) ba P(.25) a T(.5) c"
CALL Translate(Channel1$, 1)
Channel2$ = "P(.25) abcfedabc"
CALL Translate(Channel2$, 2)
Channel3$ = "P(.25) abcfedabc"
CALL Translate(Channel3$, 3)
LoadIns "drops.ins"
SetIns 1
LoadIns "marbles.ins"
SetIns 2
LoadIns "drips.ins"
SetIns 3
EXIT DO
CASE ELSE
CLS : SCREEN 9: PRINT "ERROR: That stage file has a bad music number": PRINT : SYSTEM
END SELECT
LOOP

center = 20 - (LEN(stagetitle$) / 2)
LOCATE 12, center: PRINT stagetitle$
center = 20 - (LEN(author$) / 2)
LOCATE 13, center: PRINT author$
delay 10
DO
SELECT CASE INKEY$
CASE IS <> ""
EXIT DO
END SELECT
LOOP
10 IF olo$ = "YES" THEN olo$ = "NOPO": screennum% = 16


IF screennum% > 15 THEN
CLS : SCREEN 9: COLOR 3
lives% = 5
IF music$ = "YES" THEN closechannels
PRINT : PRINT "You did it!  You beat the stage!"
PRINT "Care to try another one?"
PRINT "(enter Y/N)"
DO
SELECT CASE UCASE$(INKEY$)
CASE IS = "Y"
GOTO menucaller
CASE IS = "N"
PRINT
PRINT "Quitter."
PRINT "Hey you!  Now that you're done playing, go visit my web site!"
COLOR 9: PRINT "http://members.aol.com/rjd42": COLOR 3
PRINT "Go there and you can download more quality games like this, and"
PRINT "even add-on stages for this game that can't be found anywhere else!"
PRINT "That's right, there's files to download that you can't even get in"
PRINT "the file libraries of AOL.  Why are you still reading this?"
PRINT "You should be at my web site by now downloading cool stuff!"
PRINT
COLOR 12
PRINT "Guess what?  Do you like this game?  At my web site you can download"
PRINT "a program I made called GQ2SE (Grako Quest 2 Stage Editor) so that"
PRINT "you can MAKE YOUR OWN STAGES FOR THIS GAME.  It's tons of fun and"
PRINT "it's free!  And you can download extra stages for this game, too!"
SLEEP
CLS : COLOR 0: CLS : SYSTEM
END SELECT
LOOP
GOTO 78
END IF


itsfallin$ = "NO"
yaba$ = "NO"
yupup$ = "NO"
go$ = "NO"
B% = -10
efall% = 0
befall% = 0
B$ = "NO"
exitsubs$ = "NO"
okay$ = "NO"
jumping$ = "NO"
justfell$ = "NO"
getout$ = "NO"
IF stage$ = "9" THEN music$ = "NO"
CALL background
CALL gameplay
IF getout$ = "YES" THEN getout$ = "NO": GOTO 9
IF jolopolu$ = "YES" THEN jolopolu$ = "NO": extisubs$ = "NO": GOTO 9
IF life% < 0 THEN CALL youlose
IF go$ = "YES" THEN go$ = "NO": GOTO 10
exitsubs$ = "NO": screennum% = screennum% + 1: GOTO 10
oops:
CLS : SCREEN 0
COLOR 17: LOCATE 6, 1: PRINT "ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR"
COLOR 3
LOCATE 8, 1: PRINT "An unexpected error has occured."
LOCATE 9, 1: PRINT "Sorry for the inconvenience."
LOCATE 10, 1: PRINT "Please restart Grako Quest 2 and try again"
LOCATE 12, 1: PRINT "If the error continues, then Grako Quest 2 is not compatible with your computer."
LOCATE 14, 1: PRINT "ERROR CODE: "; ERR
COLOR 17: LOCATE 16, 1: PRINT "ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR"
IF ERR = 53 THEN
LOCATE 18, 1: COLOR 15: PRINT "A file was not found!"
END IF
COLOR 3
delay 50
SLEEP
SYSTEM

SUB background
itsfallin$ = "NO"
berh% = 400: berv% = 226
xbh% = 400: xbv% = 226
ah% = 400: av% = 226
IF Ichose$ = "YES" THEN mapname$ = userdeffedlev$: GOTO goherenow
goherenow:
OPEN mapname$ FOR INPUT AS #1
INPUT #1, null$
INPUT #1, null$
INPUT #1, null$
INPUT #1, null$
INPUT #1, null$
INPUT #1, null$
INPUT #1, null$
INPUT #1, null$
IF screennum% = 1 THEN GOTO skipit
FOR downfile% = 1 TO ((screennum% - 1) * 76)
INPUT #1, null$
NEXT downfile%
skipit:
INPUT #1, ph%
INPUT #1, pv%
INPUT #1, a1$
INPUT #1, a2$
INPUT #1, a3$
INPUT #1, a4$
INPUT #1, a5$
INPUT #1, a6$
INPUT #1, a7$
INPUT #1, a8$
INPUT #1, a9$
INPUT #1, b1$
INPUT #1, b2$
INPUT #1, b3$
INPUT #1, b4$
INPUT #1, b5$
INPUT #1, b6$
INPUT #1, b7$
INPUT #1, b8$
INPUT #1, b9$
INPUT #1, c1$
INPUT #1, c2$
INPUT #1, c3$
INPUT #1, c4$
INPUT #1, c5$
INPUT #1, c6$
INPUT #1, c7$
INPUT #1, c8$
INPUT #1, c9$
INPUT #1, d1$
INPUT #1, d2$
INPUT #1, d3$
INPUT #1, d4$
INPUT #1, d5$
INPUT #1, d6$
INPUT #1, d7$
INPUT #1, d8$
INPUT #1, d9$
INPUT #1, e1$
INPUT #1, e2$
INPUT #1, e3$
INPUT #1, e4$
INPUT #1, e5$
INPUT #1, e6$
INPUT #1, e7$
INPUT #1, e8$
INPUT #1, e9$
INPUT #1, f1$
INPUT #1, f2$
INPUT #1, f3$
INPUT #1, f4$
INPUT #1, f5$
INPUT #1, f6$
INPUT #1, f7$
INPUT #1, f8$
INPUT #1, f9$
INPUT #1, eh%
INPUT #1, ev%
INPUT #1, eh2%
INPUT #1, ev2%
INPUT #1, xbh%
INPUT #1, xbv%
INPUT #1, hh%
INPUT #1, hv%
INPUT #1, ah%
INPUT #1, av%
INPUT #1, strh%
INPUT #1, strv%
INPUT #1, xh%
INPUT #1, xv%
INPUT #1, up1h%
INPUT #1, up1v%
INPUT #1, berh%
INPUT #1, berv%
INPUT #1, bath%
INPUT #1, batv%
CLOSE #1
CLS : SCREEN screentype%
PAINT (1, 1), 8
LINE (14, 4)-(303, 197), 0, B
LINE (15, 5)-(302, 196), bgc%, BF
tile 13, 4, a1$
tile 45, 4, a2$
tile 77, 4, a3$
tile 109, 4, a4$
tile 141, 4, a5$
tile 173, 4, a6$
tile 205, 4, a7$
tile 237, 4, a8$
tile 269, 4, a9$
tile 13, 36, b1$
tile 45, 36, b2$
tile 77, 36, b3$
tile 109, 36, b4$
tile 141, 36, b5$
tile 173, 36, b6$
tile 205, 36, b7$
tile 237, 36, b8$
tile 269, 36, b9$
 tile 13, 68, c1$
tile 45, 68, c2$
 tile 77, 68, c3$
tile 109, 68, c4$
tile 141, 68, c5$
 tile 173, 68, c6$
 tile 205, 68, c7$
tile 237, 68, c8$
 tile 269, 68, c9$
tile 13, 100, d1$
 tile 45, 100, d2$
tile 77, 100, d3$
tile 109, 100, d4$
 tile 141, 100, d5$
tile 173, 100, d6$
 tile 205, 100, d7$
tile 237, 100, d8$
 tile 269, 100, d9$
 tile 13, 132, e1$
tile 45, 132, e2$
tile 77, 132, e3$
tile 109, 132, e4$
tile 141, 132, e5$
tile 173, 132, e6$
tile 205, 132, e7$
tile 237, 132, e8$
tile 269, 132, e9$
tile 13, 164, f1$
tile 45, 164, f2$
tile 77, 164, f3$
tile 109, 164, f4$
tile 141, 164, f5$
tile 173, 164, f6$
tile 205, 164, f7$
tile 237, 164, f8$
tile 269, 164, f9$
IF a1$ = "2" THEN tile 13, 4, "1"
IF a2$ = "2" THEN tile 45, 4, "1"
IF a3$ = "2" THEN tile 77, 4, "1"
IF a4$ = "2" THEN tile 109, 4, "1"
IF a5$ = "2" THEN tile 141, 4, "1"
IF a6$ = "2" THEN tile 173, 4, "1"
IF a7$ = "2" THEN tile 205, 4, "1"
IF a8$ = "2" THEN tile 237, 4, "1"
IF a9$ = "2" THEN tile 269, 4, "1"
IF b1$ = "2" THEN tile 13, 36, "1"
IF b2$ = "2" THEN tile 45, 36, "1"
IF b3$ = "2" THEN tile 77, 36, "1"
IF b4$ = "2" THEN tile 109, 36, "1"
IF b5$ = "2" THEN tile 141, 36, "1"
IF b6$ = "2" THEN tile 173, 36, "1"
IF b7$ = "2" THEN tile 205, 36, "1"
IF b8$ = "2" THEN tile 237, 36, "1"
IF b9$ = "2" THEN tile 269, 36, "1"
IF c1$ = "2" THEN tile 13, 68, "1"
IF c2$ = "2" THEN tile 45, 68, "1"
IF c3$ = "2" THEN tile 77, 68, "1"
IF c4$ = "2" THEN tile 109, 68, "1"
IF c5$ = "2" THEN tile 141, 68, "1"
IF c6$ = "2" THEN tile 173, 68, "1"
IF c7$ = "2" THEN tile 205, 68, "1"
IF c8$ = "2" THEN tile 237, 68, "1"
IF c9$ = "2" THEN tile 269, 68, "1"
IF d1$ = "2" THEN tile 13, 100, "1"
IF d2$ = "2" THEN tile 45, 100, "1"
IF d3$ = "2" THEN tile 77, 100, "1"
IF d4$ = "2" THEN tile 109, 100, "1"
IF d5$ = "2" THEN tile 141, 100, "1"
IF d6$ = "2" THEN tile 173, 100, "1"
IF d7$ = "2" THEN tile 205, 100, "1"
IF d8$ = "2" THEN tile 237, 100, "1"
IF d9$ = "2" THEN tile 269, 100, "1"
IF e1$ = "2" THEN tile 13, 132, "1"
IF e2$ = "2" THEN tile 45, 132, "1"
IF e3$ = "2" THEN tile 77, 132, "1"
IF e4$ = "2" THEN tile 109, 132, "1"
IF e5$ = "2" THEN tile 141, 132, "1"
IF e6$ = "2" THEN tile 173, 132, "1"
IF e7$ = "2" THEN tile 205, 132, "1"
IF e8$ = "2" THEN tile 237, 132, "1"
IF e9$ = "2" THEN tile 269, 132, "1"
IF f1$ = "2" THEN tile 13, 164, "1"
IF f2$ = "2" THEN tile 45, 164, "1"
IF f3$ = "2" THEN tile 77, 164, "1"
IF f4$ = "2" THEN tile 109, 164, "1"
IF f5$ = "2" THEN tile 141, 164, "1"
IF f6$ = "2" THEN tile 173, 164, "1"
IF f7$ = "2" THEN tile 205, 164, "1"
IF f8$ = "2" THEN tile 237, 164, "1"
IF f9$ = "2" THEN tile 269, 164, "1"
IF VAL(a1$) > 2 THEN a1$ = "1"
IF VAL(a2$) > 2 THEN a2$ = "1"
IF VAL(a3$) > 2 THEN a3$ = "1"
IF VAL(a4$) > 2 THEN a4$ = "1"
IF VAL(a5$) > 2 THEN a5$ = "1"
IF VAL(a6$) > 2 THEN a6$ = "1"
IF VAL(a7$) > 2 THEN a7$ = "1"
IF VAL(a8$) > 2 THEN a8$ = "1"
IF VAL(a9$) > 2 THEN a9$ = "1"
IF VAL(b1$) > 2 THEN b1$ = "1"
IF VAL(b2$) > 2 THEN b2$ = "1"
IF VAL(b3$) > 2 THEN b3$ = "1"
IF VAL(b4$) > 2 THEN b4$ = "1"
IF VAL(b5$) > 2 THEN b5$ = "1"
IF VAL(b6$) > 2 THEN b6$ = "1"
IF VAL(b7$) > 2 THEN b7$ = "1"
IF VAL(b8$) > 2 THEN b8$ = "1"
IF VAL(b9$) > 2 THEN b9$ = "1"
IF VAL(c1$) > 2 THEN c1$ = "1"
IF VAL(c2$) > 2 THEN c2$ = "1"
IF VAL(c3$) > 2 THEN c3$ = "1"
IF VAL(c4$) > 2 THEN c4$ = "1"
IF VAL(c5$) > 2 THEN c5$ = "1"
IF VAL(c6$) > 2 THEN c6$ = "1"
IF VAL(c7$) > 2 THEN c7$ = "1"
IF VAL(c8$) > 2 THEN c8$ = "1"
IF VAL(c9$) > 2 THEN c9$ = "1"
IF VAL(d1$) > 2 THEN d1$ = "1"
IF VAL(d2$) > 2 THEN d2$ = "1"
IF VAL(d3$) > 2 THEN d3$ = "1"
IF VAL(d4$) > 2 THEN d4$ = "1"
IF VAL(d5$) > 2 THEN d5$ = "1"
IF VAL(d6$) > 2 THEN d6$ = "1"
IF VAL(d7$) > 2 THEN d7$ = "1"
IF VAL(d8$) > 2 THEN d8$ = "1"
IF VAL(d9$) > 2 THEN d9$ = "1"
IF VAL(e1$) > 2 THEN e1$ = "1"
IF VAL(e2$) > 2 THEN e2$ = "1"
IF VAL(e3$) > 2 THEN e3$ = "1"
IF VAL(e4$) > 2 THEN e4$ = "1"
IF VAL(e5$) > 2 THEN e5$ = "1"
IF VAL(e6$) > 2 THEN e6$ = "1"
IF VAL(e7$) > 2 THEN e7$ = "1"
IF VAL(e8$) > 2 THEN e8$ = "1"
IF VAL(e9$) > 2 THEN e9$ = "1"
IF VAL(f1$) > 2 THEN f1$ = "1"
IF VAL(f2$) > 2 THEN f2$ = "1"
IF VAL(f3$) > 2 THEN f3$ = "1"
IF VAL(f4$) > 2 THEN f4$ = "1"
IF VAL(f5$) > 2 THEN f5$ = "1"
IF VAL(f6$) > 2 THEN f6$ = "1"
IF VAL(f7$) > 2 THEN f7$ = "1"
IF VAL(f8$) > 2 THEN f8$ = "1"
IF VAL(f9$) > 2 THEN f9$ = "1"
enemy$ = "SNAKE"
enemy2$ = "SPIKES"
edir$ = "LEFT"
bedir$ = "LEFT"
IF LEFT$(enemy2$, 7) = "SPIKES+" THEN ev3% = ev2%: eh3% = VAL(RIGHT$(enemy2$, 3)): enemy2$ = "SPIKES": enemy3$ = "SPIKES"
IF LEFT$(enemy2$, 5) = "MINE+" THEN ev3% = ev2%: eh3% = VAL(RIGHT$(enemy2$, 3)): enemy2$ = "MINE": enemy3$ = "MINE"
IF enemy2$ = "SPIKES" THEN cone eh2%, ev2% + 3, 12, 5
IF enemy3$ = "SPIKES" THEN cone eh3%, ev3% + 3, 12, 5
IF enemy2$ = "MINE" THEN LINE (eh2% - 5, ev2% + 4)-(eh2% + 5, ev2%), 0, B: PAINT (eh2%, ev2% + 2), 4, 0
IF enemy3$ = "MINE" THEN LINE (eh3% - 5, ev3% + 4)-(eh3% + 5, ev3%), 0, B: PAINT (eh3%, ev3% + 2), 4, 0
IF enemy$ = "DOG" THEN dlf% = 3: dst% = 32767
IF LEFT$(enemy2$, 8) = "CRUSHER+" THEN enemy3$ = "CRUSHER": ev3% = ev2%: eh3% = VAL(RIGHT$(enemy2$, 3)): crushnow3$ = "NO": crush3% = 31: enemy2$ = "CRUSHER"
IF enemy2$ = "CRUSHER" THEN crushnow$ = "YES": crush% = 1
IF enemy$ = "CROW" THEN eh% = 32500
'LOCATE 1, 1: PRINT screennum%
dogdead$ = "NO"

LINE (xbh% + 12, xbv% + 2)-(xbh% - 16, xbv% - 26), 2, BF

CIRCLE (hh% - 3, hv% - 8), 4, 4
PAINT (hh% - 3, hv% - 8), 4, 4
CIRCLE (hh% + 3, hv% - 8), 4, 4
PAINT (hh% + 3, hv% - 8), 4, 4
LINE (hh% + 6, hv% - 6)-(hh%, hv% - 2), 4
LINE (hh% - 6, hv% - 6)-(hh%, hv% - 2), 4
PAINT (hh%, hv% - 4), 4, 4
LINE (hh% + 6, hv% - 6)-(hh% + 1, hv% - 2), 4
PSET (hh%, hv% - 10), bgc%
PSET (hh%, hv% - 1), 4

LINE (ah% - 7, av% - 8)-(ah% + 15, av%), 0, B
LINE (ah% - 6, av% - 7)-(ah% + 14, av% - 1), 3, BF
LINE (ah% - 5, av% - 6)-(ah% - 3, av% - 2), 0, B
PSET (ah% - 4, av% - 2), 3
PSET (ah% - 4, av% - 4), 0
LINE (ah% - 1, av% - 6)-(ah% + 1, av% - 2), 0, B
PSET (ah%, av% - 2), 3
LINE (ah% + 1, av% - 6)-(ah% + 3, av% - 2), 0, B
PSET (ah% + 2, av% - 2), 3
LINE (ah% + 5, av% - 6)-(ah% + 7, av% - 2), 0, B
PSET (ah% + 6, av% - 2), 3
LINE (ah% + 7, av% - 6)-(ah% + 9, av% - 2), 0, B
PSET (ah% + 8, av% - 2), 3
LINE (ah% + 11, av% - 6)-(ah% + 13, av% - 2), 0, B

LINE (strh% - 5, strv% - 10)-(strh%, strv% - 5), 0
LINE (strh% - 5, strv% - 10)-(strh% + 2, strv% - 8), 0
LINE (strh% + 4, strv% - 13)-(strh% + 2, strv% - 8), 0
LINE (strh% + 5, strv% - 13)-(strh% + 7, strv% - 8), 0
LINE (strh% + 13, strv% - 10)-(strh% + 7, strv% - 7), 0
LINE (strh% + 13, strv% - 10)-(strh% + 9, strv% - 5), 0
LINE (strh% + 13, strv%)-(strh% + 9, strv% - 5), 0
LINE (strh% + 13, strv%)-(strh% + 5, strv% - 3), 0
LINE (strh% - 4, strv%)-(strh% + 5, strv% - 3), 0
LINE (strh% - 4, strv% - 1)-(strh%, strv% - 5), 0
PAINT (strh% + 7, strv% - 6), 15, 0

CIRCLE (xh%, xv% - 3), 4, 0
PAINT (xh%, xv% - 3), 0, 0

CIRCLE (up1h%, up1v% - 4), 7, 0
PAINT (up1h%, up1v% - 4), 10, 0
PSET (up1h% - 2, up1v% - 5), 0
PSET (up1h% + 2, up1v% - 5), 0
LINE (up1h% - 2, up1v% - 2)-(up1h% + 2, up1v% - 2), 0
PSET (up1h% - 3, up1v% - 3), 0
PSET (up1h% + 3, up1v% - 3), 0

syu% = 0
syyu% = 0
END SUB

DEFINT A-Z
SUB batattack
IF music$ = "YES" THEN closechannels
LINE (bath% - 17, batv% - 13)-(bath% + 14, batv% - 2), bgc%, BF
CALL drawbat
startdive% = batv%
FOR timestodive% = 1 TO (4 - diff%)
FOR batv% = startdive% TO pv% STEP 5
LINE (bath% - 17, batv% - 18)-(bath% + 14, batv% + 2), bgc%, BF
CALL drawbat
delay .1
NEXT batv%
life% = life% - (25 / (4 - diff%))
LINE (25, 180)-(127, 190), 0, B
LINE (26, 181)-(125 - (100 - (life% / diff%)), 189), 2, BF
LINE (126 - (100 - (life% / diff%)), 181)-(126, 189), 4, BF
FOR blood% = 1 TO 10
RANDOMIZE TIMER
a% = INT(RND * 10) + 1
B% = INT(RND * 10) + 1
CIRCLE (ph% + (a% - 5), pv% + (B% - 5)), 1, 4
NEXT blood%
IF sounds$ = "YES" THEN
SOUND 75, 2
SOUND 100, 2
SOUND 50, 5
END IF
FOR batv% = pv% TO startdive% STEP -5
LINE (bath% - 17, batv% - 18)-(bath% + 14, batv% + 2), bgc%, BF
CALL drawbat
delay .1
NEXT batv%
NEXT timestodive%
LINE (bath% - 17, batv% - 16)-(bath% + 14, batv% + 2), bgc%, BF
END SUB

DEFSNG A-Z
SUB batdata
IF bath% > 320 OR batv% > 200 THEN EXIT SUB
LINE (bath% - 17, batv% - 13)-(bath% + 14, batv% - 2), bgc%, BF
IF batwait% <> 0 THEN GOTO aftermove
IF bmr% > 0 THEN bath% = bath% + 1: bmr% = bmr% - 1
IF bml% > 0 THEN bath% = bath% - 1: bml% = bml% - 1
aftermove:
CALL drawbat

IF batwait% > 0 AND bath% <> ph% THEN batwait% = 0

IF bath% = ph% AND dir$ = "STOPPED" AND jumpingup$ <> "YES" AND batwait% = 0 THEN
batwait% = 2
bml% = 0
bmr% = 0
END IF
IF batwait% > 0 THEN
batwait% = batwait% - 1
IF batwait% = 0 THEN CALL batattack
END IF

IF bml% <> 0 OR bmr% <> 0 THEN EXIT SUB
IF batwait% = 0 THEN GOTO afterchoose


afterchoose:
RANDOMIZE TIMER
dtg% = INT(RND * 2) + 1
IF bath% > ph% THEN dtg% = 1
IF bath% < ph% THEN dtg% = 2
IF dtg% = 1 AND bath% > 50 THEN
bml% = 32
END IF
IF dtg% = 2 AND bath% < 270 THEN
bmr% = 32
END IF

END SUB

SUB beardata
IF fallingdown$ = "YES" THEN CALL checkdown
IF B% - 15 < berh% AND B% > berh% AND pv% = berv% THEN
CALL drawplayer
PSET (B%, pv% - 9), bgc%
'duh' THEN PSET (B%, pv% - 7), bgc%
IF gun% = 3 THEN PSET (B%, pv% - 7), bgc%: PSET (B%, pv% - 5), bgc%
IF gun% = 1 AND syyu% <= 3 THEN
IF sounds$ = "YES" THEN SOUND 50, 2
syyu% = syyu% + 1: GOTO yepy
END IF
snakeexplosion berh%, berv% - 3, 1
score% = score% + 2
LINE (berh% - 6, berv% - 23)-(berh% + 5, berv% + 4), bgc%, BF
berh% = 400: berv% = 226
yepy: B% = -10: B$ = "NO"
EXIT SUB
END IF
IF falling$ = "YES" OR sidego$ = "YES" THEN GOTO 156
IF dir$ = "RIGHT" THEN CALL checkright
IF dir$ = "RIGHT" AND okay$ = "YES" THEN ph% = ph% + 1: okay$ = "NO"
IF dir$ = "LEFT" THEN CALL checkleft
IF dir$ = "LEFT" AND okay$ = "YES" THEN ph% = ph% - 1: okay$ = "NO"
156 FOR ssp% = 1 TO 2 STEP 1
IF bedir$ = "LEFT" THEN
oldph% = ph%
oldpv% = pv%
ph% = berh%
pv% = berv%
CALL checkleft
IF okay$ = "NO" THEN bedir$ = "RIGHT"
ph% = oldph%
pv% = oldpv%
END IF
IF bedir$ = "RIGHT" THEN
oldph% = ph%
oldpv% = pv%
ph% = berh%
pv% = berv%
echeck$ = "YES"
CALL checkright
echeck$ = "NO"
IF okay$ = "NO" THEN bedir$ = "LEFT"
ph% = oldph%
pv% = oldpv%
END IF
IF befall% <> 0 THEN okay$ = "NO"
oldeh% = eh%
oldev% = ev%
eh% = berh%
ev% = berv%
IF befall% = 0 THEN CALL echeck4fall      'ECHECK4FALL CHCKS W/ EV EH
IF okay$ = "YES" THEN befall% = 32
eh% = oldeh%
ev% = oldev%
LINE (berh% - 6, berv% - 23)-(berh% + 5, berv% + 4), bgc%, BF
IF befall% = 0 AND bedir$ = "LEFT" THEN berh% = berh% - 1'twice
IF befall% = 0 AND bedir$ = "RIGHT" THEN berh% = berh% + 1'twice(thrice?)
IF befall% > 0 THEN befall% = befall% - 1: berv% = berv% + 1
IF berh% - 10 < ph% AND berh% > ph% AND berv% = pv% THEN 'get hit
IF sounds$ = "YES" THEN SOUND 100, 1: SOUND 50, 1
IF ph% > 30 THEN
FOR mm% = 1 TO 10
CALL checkleft
IF okay$ = "YES" THEN
ph% = ph% - 1
IF dir$ = "LEFT" THEN LINE (ph% - 5, pv% - 19)-(ph% + 6, pv% + 4), bgc%, BF
IF dir$ <> "LEFT" THEN LINE (ph% - 5, pv% - 19)-(ph% + 5, pv% + 4), bgc%, BF
END IF
NEXT mm%
FOR blood% = 1 TO 10
RANDOMIZE TIMER
a% = INT(RND * 10) + 1
B% = INT(RND * 10) + 1
CIRCLE (ph% + (a% - 5), pv% + (B% - 5)), 1, 4
NEXT blood%
IF okay$ = "YES" THEN life% = life% - 10
IF okay$ = "NO" THEN life% = life% - 1
IF okay$ = "NO" AND stage$ = "9" THEN life% = life% - 1
END IF
END IF
IF berh% + 10 > ph% AND berh% < ph% AND berv% = pv% THEN 'get hit
IF sounds$ = "YES" THEN SOUND 100, 1: SOUND 50, 1
IF ph% < 280 THEN
FOR mm% = 1 TO 10
IF okay$ = "YES" THEN
ph% = ph% + 1
IF dir$ = "LEFT" THEN LINE (ph% - 5, pv% - 19)-(ph% + 6, pv% + 4), bgc%, BF
IF dir$ <> "LEFT" THEN LINE (ph% - 5, pv% - 19)-(ph% + 5, pv% + 4), bgc%, BF
END IF
NEXT mm%
FOR blood% = 1 TO 10
RANDOMIZE TIMER
a% = INT(RND * 10) + 1
B% = INT(RND * 10) + 1
CIRCLE (ph% + (a% - 5), pv% + (B% - 5)), 1, 4
NEXT blood%
IF okay$ = "YES" THEN life% = life% - 10
IF okay$ = "NO" THEN life% = life% - 1
IF okay$ = "NO" AND stage$ = "9" THEN life% = life% - 1
END IF
END IF
IF enemy2$ = "SPIKES" AND yaba$ <> "YES" AND pv% < ev2% + 1 AND pv% > ev2% - 12 AND ph% > eh2% - 11 AND ph% < eh2% + 11 THEN
IF dir$ = "LEFT" THEN LINE (ph% - 5, pv% - 20)-(ph% + 6, pv% + 4), bgc%, BF
IF dir$ <> "LEFT" THEN LINE (ph% - 5, pv% - 20)-(ph% + 5, pv% + 4), bgc%, BF
IF sounds$ = "YES" THEN SOUND 100, 1: SOUND 50, 1
IF ph% > 30 THEN
FOR mm% = 1 TO 21
CALL checkleft
IF okay$ = "YES" THEN
ph% = ph% - 1
IF dir$ = "LEFT" THEN LINE (ph% - 5, pv% - 19)-(ph% + 6, pv% + 4), bgc%, BF
IF dir$ <> "LEFT" THEN LINE (ph% - 5, pv% - 19)-(ph% + 5, pv% + 4), bgc%, BF
END IF
NEXT mm%
IF okay$ = "YES" THEN life% = life% - 16
END IF
cone eh2%, ev2% + 3, 12, 5
dir$ = "STOPPED"
END IF
IF enemy3$ = "SPIKES" AND yaba$ <> "YES" AND pv% < ev3% + 1 AND pv% > ev3% - 12 AND ph% > eh3% - 11 AND ph% < eh3% + 11 THEN
IF dir$ = "LEFT" THEN LINE (ph% - 5, pv% - 20)-(ph% + 6, pv% + 4), bgc%, BF
IF dir$ <> "LEFT" THEN LINE (ph% - 5, pv% - 20)-(ph% + 5, pv% + 4), bgc%, BF
IF sounds$ = "YES" THEN SOUND 100, 1: SOUND 50, 1
IF ph% > 30 THEN
FOR mm% = 1 TO 21
CALL checkleft
IF okay$ = "YES" THEN
ph% = ph% - 1
IF dir$ = "LEFT" THEN LINE (ph% - 5, pv% - 19)-(ph% + 6, pv% + 4), bgc%, BF
IF dir$ <> "LEFT" THEN LINE (ph% - 5, pv% - 19)-(ph% + 5, pv% + 4), bgc%, BF
END IF
NEXT mm%
IF okay$ = "YES" THEN life% = life% - 16
END IF
cone eh3%, ev3% + 3, 12, 5
dir$ = "STOPPED"
END IF
IF enemy2$ = "MINE" AND yaba$ <> "YES" AND pv% < ev2% + 1 AND pv% > ev2% - 12 AND ph% > eh2% - 11 AND ph% < eh2% + 11 THEN
explosion eh2%, ev2%, 5
IF dir$ = "LEFT" THEN LINE (ph% - 5, pv% - 20)-(ph% + 6, pv% + 4), bgc%, BF
IF dir$ <> "LEFT" THEN LINE (ph% - 5, pv% - 20)-(ph% + 5, pv% + 4), bgc%, BF
IF ph% > 30 THEN
FOR mm% = 1 TO 21
CALL checkleft
IF okay$ = "YES" THEN
ph% = ph% - 1
IF dir$ = "LEFT" THEN LINE (ph% - 5, pv% - 19)-(ph% + 6, pv% + 4), bgc%, BF
IF dir$ <> "LEFT" THEN LINE (ph% - 5, pv% - 19)-(ph% + 5, pv% + 4), bgc%, BF
END IF
NEXT mm%
IF okay$ = "YES" THEN life% = life% - 32
END IF
LINE (eh2% - 5, ev2% + 4)-(eh2% + 5, ev2%), bgc%, BF
dir$ = "STOPPED"
eh2% = 400: ev2% = 226
END IF
IF enemy3$ = "MINE" AND yaba$ <> "YES" AND pv% < ev3% + 1 AND pv% > ev3% - 12 AND ph% > eh3% - 11 AND ph% < eh3% + 11 THEN
explosion eh3%, ev3%, 5
IF dir$ = "LEFT" THEN LINE (ph% - 5, pv% - 20)-(ph% + 6, pv% + 4), bgc%, BF
IF dir$ <> "LEFT" THEN LINE (ph% - 5, pv% - 20)-(ph% + 5, pv% + 4), bgc%, BF
IF ph% > 30 THEN
FOR mm% = 1 TO 21
CALL checkleft
IF okay$ = "YES" THEN
ph% = ph% - 1
IF dir$ = "LEFT" THEN LINE (ph% - 5, pv% - 19)-(ph% + 6, pv% + 4), bgc%, BF
IF dir$ <> "LEFT" THEN LINE (ph% - 5, pv% - 19)-(ph% + 5, pv% + 4), bgc%, BF
END IF
NEXT mm%
IF okay$ = "YES" THEN life% = life% - 32
END IF
LINE (eh3% - 5, ev3% + 4)-(eh3% + 5, ev3%), bgc%, BF
dir$ = "STOPPED"
eh3% = 400: ev3% = 226
END IF
IF life% < 0 THEN CALL youlose
IF getout$ = "YES" THEN EXIT SUB
NEXT ssp%
END SUB

SUB checkdown

IF player$ = "SNAKE" THEN ammo% = 0

IF bloodbath$ = "YES" THEN
bbcounter = bbcounter + 1
IF bbcounter > 50 THEN
bbcounter = 0
life% = life% - 1
END IF
END IF

LOCATE 22, 4: PRINT "Life:"
LINE (25, 180)-(127, 190), 0, B
LINE (26, 181)-(125 - (100 - (life% / diff%)), 189), 2, BF
LINE (126 - (100 - (life% / diff%)), 181)-(126, 189), 4, BF

LOCATE 22, 26: PRINT "Ammo:"
LINE (200, 180)-(302, 190), 0, B
LINE (201, 181)-(302 - (100 - (ammo%)), 189), 2, BF
LINE (301 - (100 - (ammo%)), 181)-(301, 189), 4, BF

LOCATE 2, 4: PRINT "Lives: "
FOR oik% = 1 TO lives%
LOCATE 2, 10 + oik%: PRINT CHR$(3)
NEXT oik%

LOCATE 2, 25: PRINT "Points:"; score%

IF ph% > hh% - 14 AND ph% < hh% + 14 AND pv% = hv% THEN
LINE (hh% - 14, hv% - 14)-(hh% + 14, hv%), bgc%, BF
CALL drawplayer
hh% = 400: hv% = 226
FOR i% = 1 TO 50
IF life% >= 100 * diff% THEN GOTO 1125
life% = life% + diff%
LINE (26, 181)-(125 - (100 - (life% / diff%)), 189), 2, BF
LINE (126 - (100 - (life% / diff%)), 181)-(126, 189), 4, BF
IF sounds$ = "YES" THEN SOUND 50 + (i% * 10), .3
IF life% >= 100 * diff% THEN GOTO 1125
NEXT i%
END IF


IF ph% > ah% - 18 AND ph% < ah% + 20 AND pv% = av% THEN
LINE (ah% - 14, av% - 14)-(ah% + 14, av%), bgc%, BF
CALL drawplayer
ah% = 400: av% = 226
FOR i% = 1 TO 50
IF ammo% >= 100 THEN GOTO 1125
ammo% = ammo% + 1
LINE (201, 181)-(302 - (100 - (ammo%)), 189), 2, BF
LINE (301 - (100 - (ammo%)), 181)-(301, 189), 4, BF
IF sounds$ = "YES" THEN SOUND 50 + (i% * 10), .3
IF ammo% >= 100 THEN GOTO 1125
NEXT i%
END IF

IF ph% > strh% - 20 AND ph% < strh% + 18 AND pv% = strv% THEN
LINE (strh% - 14, strv% - 14)-(strh% + 14, strv%), bgc%, BF
CALL drawplayer
strh% = 400: strv% = 226
score% = score% + 10
IF sounds$ = "YES" THEN
FOR y% = 500 TO 600 STEP 10
SOUND y%, .3
NEXT y%
END IF
END IF

IF ph% > xh% - 14 AND ph% < xh% + 14 AND pv% = xv% THEN
LINE (xh% - 14, xv% - 14)-(xh% + 14, xv%), bgc%, BF
CALL drawplayer
xh% = 400: xv% = 226
FOR i% = 1 TO 100
IF ammo% < 100 THEN ammo% = ammo% + 1
IF life% < 100 * diff% THEN life% = life% + diff%
LINE (26, 181)-(125 - (100 - (life% / diff%)), 189), 2, BF
LINE (126 - (100 - (life% / diff%)), 181)-(126, 189), 4, BF
LINE (201, 181)-(302 - (100 - (ammo%)), 189), 2, BF
LINE (301 - (100 - (ammo%)), 181)-(301, 189), 4, BF
IF sounds$ = "YES" THEN SOUND 50 + (i% * 10), .3
NEXT i%
END IF

IF ph% > up1h% - 14 AND ph% < up1h% + 14 AND pv% = up1v% THEN
LINE (up1h% - 14, up1v% - 14)-(up1h% + 14, up1v% + 2), bgc%, BF
CALL drawplayer
up1h% = 400: up1v% = 226
IF lives% < 10 THEN lives% = lives% + 1
IF sounds$ = "YES" THEN
FOR y% = 500 TO 1000 STEP 10
SOUND y%, .3
NEXT y%
END IF
END IF

1125 IF ndemo$ = "YES" THEN
LINE (0, 0)-(0, 200), 8
END IF

IF music$ = "YES" THEN PlayMusic

END SUB

DEFINT A-Z
SUB checkfilename (x$)

'Removes all spaces and makes the name uppercase
FOR c% = 1 TO LEN(x$)
IF MID$(x$, c%, 1) <> " " THEN k$ = k$ + MID$(x$, c%, 1)
NEXT
thefilename$ = UCASE$(k$)

'Makes sure that the name is the right length
IF LEN(thefilename$) < 1 THEN GOTO nogood
IF LEN(thefilename$) > 12 THEN GOTO nogood
IF RIGHT$(thefilename$, 4) <> ".GQ2" THEN
IF LEN(thefilename$) > 8 THEN GOTO nogood
thefilename$ = thefilename$ + ".GQ2"
END IF

'Opens the file to make sure it exists
OPEN thefilename$ FOR APPEND AS #1
IF LOF(1) < 5 THEN
CLOSE #1
KILL thefilename$
GOTO nogood
END IF
CLOSE #1
EXIT SUB

nogood:
LOCATE 1, 1: PRINT "THAT IS NOT A VALID FILENAME!"
BEEP: BEEP: BEEP: SLEEP 1
LOCATE 1, 1: PRINT "                             "
LOCATE 4, 1: PRINT "                             "
nogoodname$ = "YES"

END SUB

DEFSNG A-Z
SUB checkleft
okay$ = "YES"

IF ph% = 20 THEN okay$ = "NO"

IF ph% = 52 AND pv% = 192 AND f1$ = "1" THEN okay$ = "NO"
IF ph% = 84 AND pv% = 192 AND f2$ = "1" THEN okay$ = "NO"
IF ph% = 116 AND pv% = 192 AND f3$ = "1" THEN okay$ = "NO"
IF ph% = 148 AND pv% = 192 AND f4$ = "1" THEN okay$ = "NO"
IF ph% = 180 AND pv% = 192 AND f5$ = "1" THEN okay$ = "NO"
IF ph% = 212 AND pv% = 192 AND f6$ = "1" THEN okay$ = "NO"
IF ph% = 244 AND pv% = 192 AND f7$ = "1" THEN okay$ = "NO"
IF ph% = 276 AND pv% = 192 AND f8$ = "1" THEN okay$ = "NO"
IF ph% = 308 AND pv% = 192 AND f9$ = "1" THEN okay$ = "NO"

IF ph% = 52 AND pv% = 160 AND e1$ = "1" THEN okay$ = "NO"
IF ph% = 84 AND pv% = 160 AND e2$ = "1" THEN okay$ = "NO"
IF ph% = 116 AND pv% = 160 AND e3$ = "1" THEN okay$ = "NO"
IF ph% = 148 AND pv% = 160 AND e4$ = "1" THEN okay$ = "NO"
IF ph% = 180 AND pv% = 160 AND e5$ = "1" THEN okay$ = "NO"
IF ph% = 212 AND pv% = 160 AND e6$ = "1" THEN okay$ = "NO"
IF ph% = 244 AND pv% = 160 AND e7$ = "1" THEN okay$ = "NO"
IF ph% = 276 AND pv% = 160 AND e8$ = "1" THEN okay$ = "NO"
IF ph% = 308 AND pv% = 160 AND e9$ = "1" THEN okay$ = "NO"
IF ph% = 52 AND pv% = 128 AND d1$ = "1" THEN okay$ = "NO"
IF ph% = 84 AND pv% = 128 AND d2$ = "1" THEN okay$ = "NO"
IF ph% = 116 AND pv% = 128 AND d3$ = "1" THEN okay$ = "NO"
IF ph% = 148 AND pv% = 128 AND d4$ = "1" THEN okay$ = "NO"
IF ph% = 180 AND pv% = 128 AND d5$ = "1" THEN okay$ = "NO"
IF ph% = 212 AND pv% = 128 AND d6$ = "1" THEN okay$ = "NO"
IF ph% = 244 AND pv% = 128 AND d7$ = "1" THEN okay$ = "NO"
IF ph% = 276 AND pv% = 128 AND d8$ = "1" THEN okay$ = "NO"
IF ph% = 308 AND pv% = 128 AND d9$ = "1" THEN okay$ = "NO"
IF ph% = 52 AND pv% = 96 AND c1$ = "1" THEN okay$ = "NO"
IF ph% = 84 AND pv% = 96 AND c2$ = "1" THEN okay$ = "NO"
IF ph% = 116 AND pv% = 96 AND c3$ = "1" THEN okay$ = "NO"
IF ph% = 148 AND pv% = 96 AND c4$ = "1" THEN okay$ = "NO"
IF ph% = 180 AND pv% = 96 AND c5$ = "1" THEN okay$ = "NO"
IF ph% = 212 AND pv% = 96 AND c6$ = "1" THEN okay$ = "NO"
IF ph% = 244 AND pv% = 96 AND c7$ = "1" THEN okay$ = "NO"
IF ph% = 276 AND pv% = 96 AND c8$ = "1" THEN okay$ = "NO"
IF ph% = 308 AND pv% = 96 AND c9$ = "1" THEN okay$ = "NO"
IF ph% = 52 AND pv% = 64 AND b1$ = "1" THEN okay$ = "NO"
IF ph% = 84 AND pv% = 64 AND b2$ = "1" THEN okay$ = "NO"
IF ph% = 116 AND pv% = 64 AND b3$ = "1" THEN okay$ = "NO"
IF ph% = 148 AND pv% = 64 AND b4$ = "1" THEN okay$ = "NO"
IF ph% = 180 AND pv% = 64 AND b5$ = "1" THEN okay$ = "NO"
IF ph% = 212 AND pv% = 64 AND b6$ = "1" THEN okay$ = "NO"
IF ph% = 244 AND pv% = 64 AND b7$ = "1" THEN okay$ = "NO"
IF ph% = 276 AND pv% = 64 AND b8$ = "1" THEN okay$ = "NO"
IF ph% = 308 AND pv% = 64 AND b9$ = "1" THEN okay$ = "NO"
IF ph% = 52 AND pv% = 32 AND a1$ = "1" THEN okay$ = "NO"
IF ph% = 84 AND pv% = 32 AND a2$ = "1" THEN okay$ = "NO"
IF ph% = 116 AND pv% = 32 AND a3$ = "1" THEN okay$ = "NO"
IF ph% = 148 AND pv% = 32 AND a4$ = "1" THEN okay$ = "NO"
IF ph% = 180 AND pv% = 32 AND a5$ = "1" THEN okay$ = "NO"
IF ph% = 212 AND pv% = 32 AND a6$ = "1" THEN okay$ = "NO"
IF ph% = 244 AND pv% = 32 AND a7$ = "1" THEN okay$ = "NO"
IF ph% = 276 AND pv% = 32 AND a8$ = "1" THEN okay$ = "NO"
IF ph% = 308 AND pv% = 32 AND a9$ = "1" THEN okay$ = "NO"
IF enemy2$ = "CRUSHER" AND crush% > 10 AND ph% = eh2% + 21 THEN okay$ = "NO"
IF enemy3$ = "CRUSHER" AND crush3% > 10 AND ph% = eh3% + 21 THEN okay$ = "NO"
IF ph% = xbh% + 18 AND pv% = xbv% THEN okay$ = "NO"
END SUB

SUB checkright
IF ph% = 297 AND echeck$ <> "YES" AND yupup$ <> "YES" AND sidego$ <> "YES" THEN exitsubs$ = "YES": EXIT SUB
IF ph% = 297 AND echeck$ <> "YES" AND yupup$ = "YES" AND sidego$ <> "YES" THEN okay$ = "NO": EXIT SUB
IF jumping$ <> "YES" THEN okay$ = "YES"

IF ph% = 265 AND pv% = 192 AND f9$ = "1" THEN okay$ = "NO"
IF ph% = 233 AND pv% = 192 AND f8$ = "1" THEN okay$ = "NO"
IF ph% = 201 AND pv% = 192 AND f7$ = "1" THEN okay$ = "NO"
IF ph% = 169 AND pv% = 192 AND f6$ = "1" THEN okay$ = "NO"
IF ph% = 137 AND pv% = 192 AND f5$ = "1" THEN okay$ = "NO"
IF ph% = 105 AND pv% = 192 AND f4$ = "1" THEN okay$ = "NO"
IF ph% = 73 AND pv% = 192 AND f3$ = "1" THEN okay$ = "NO"
IF ph% = 41 AND pv% = 192 AND f2$ = "1" THEN okay$ = "NO"
IF ph% = 9 AND pv% = 192 AND f1$ = "1" THEN okay$ = "NO"

IF ph% = 265 AND pv% = 160 AND e9$ = "1" THEN okay$ = "NO"
IF ph% = 233 AND pv% = 160 AND e8$ = "1" THEN okay$ = "NO"
IF ph% = 201 AND pv% = 160 AND e7$ = "1" THEN okay$ = "NO"
IF ph% = 169 AND pv% = 160 AND e6$ = "1" THEN okay$ = "NO"
IF ph% = 137 AND pv% = 160 AND e5$ = "1" THEN okay$ = "NO"
IF ph% = 105 AND pv% = 160 AND e4$ = "1" THEN okay$ = "NO"
IF ph% = 73 AND pv% = 160 AND e3$ = "1" THEN okay$ = "NO"
IF ph% = 41 AND pv% = 160 AND e2$ = "1" THEN okay$ = "NO"
IF ph% = 9 AND pv% = 160 AND e1$ = "1" THEN okay$ = "NO"
IF ph% = 265 AND pv% = 128 AND d9$ = "1" THEN okay$ = "NO"
IF ph% = 233 AND pv% = 128 AND d8$ = "1" THEN okay$ = "NO"
IF ph% = 201 AND pv% = 128 AND d7$ = "1" THEN okay$ = "NO"
IF ph% = 169 AND pv% = 128 AND d6$ = "1" THEN okay$ = "NO"
IF ph% = 137 AND pv% = 128 AND d5$ = "1" THEN okay$ = "NO"
IF ph% = 105 AND pv% = 128 AND d4$ = "1" THEN okay$ = "NO"
IF ph% = 73 AND pv% = 128 AND d3$ = "1" THEN okay$ = "NO"
IF ph% = 41 AND pv% = 128 AND d2$ = "1" THEN okay$ = "NO"
IF ph% = 9 AND pv% = 128 AND d1$ = "1" THEN okay$ = "NO"
IF ph% = 265 AND pv% = 96 AND c9$ = "1" THEN okay$ = "NO"
IF ph% = 233 AND pv% = 96 AND c8$ = "1" THEN okay$ = "NO"
IF ph% = 201 AND pv% = 96 AND c7$ = "1" THEN okay$ = "NO"
IF ph% = 169 AND pv% = 96 AND c6$ = "1" THEN okay$ = "NO"
IF ph% = 137 AND pv% = 96 AND c5$ = "1" THEN okay$ = "NO"
IF ph% = 105 AND pv% = 96 AND c4$ = "1" THEN okay$ = "NO"
IF ph% = 73 AND pv% = 96 AND c3$ = "1" THEN okay$ = "NO"
IF ph% = 41 AND pv% = 96 AND c2$ = "1" THEN okay$ = "NO"
IF ph% = 9 AND pv% = 96 AND c1$ = "1" THEN okay$ = "NO"
IF ph% = 265 AND pv% = 64 AND b9$ = "1" THEN okay$ = "NO"
IF ph% = 233 AND pv% = 64 AND b8$ = "1" THEN okay$ = "NO"
IF ph% = 201 AND pv% = 64 AND b7$ = "1" THEN okay$ = "NO"
IF ph% = 169 AND pv% = 64 AND b6$ = "1" THEN okay$ = "NO"
IF ph% = 137 AND pv% = 64 AND b5$ = "1" THEN okay$ = "NO"
IF ph% = 105 AND pv% = 64 AND b4$ = "1" THEN okay$ = "NO"
IF ph% = 73 AND pv% = 64 AND b3$ = "1" THEN okay$ = "NO"
IF ph% = 41 AND pv% = 64 AND b2$ = "1" THEN okay$ = "NO"
IF ph% = 9 AND pv% = 64 AND b1$ = "1" THEN okay$ = "NO"
IF ph% = 265 AND pv% = 32 AND a9$ = "1" THEN okay$ = "NO"
IF ph% = 233 AND pv% = 32 AND a8$ = "1" THEN okay$ = "NO"
IF ph% = 201 AND pv% = 32 AND a7$ = "1" THEN okay$ = "NO"
IF ph% = 169 AND pv% = 32 AND a6$ = "1" THEN okay$ = "NO"
IF ph% = 137 AND pv% = 32 AND a5$ = "1" THEN okay$ = "NO"
IF ph% = 105 AND pv% = 32 AND a4$ = "1" THEN okay$ = "NO"
IF ph% = 73 AND pv% = 32 AND a3$ = "1" THEN okay$ = "NO"
IF ph% = 41 AND pv% = 32 AND a2$ = "1" THEN okay$ = "NO"
IF ph% = 9 AND pv% = 32 AND a1$ = "1" THEN okay$ = "NO"
IF ph% = 297 AND echeck$ = "YES" THEN okay$ = "NO"
FOR yuper% = 14 TO 18 STEP 1
IF dogdead$ = "NO" AND ph% = eh% - yuper% AND enemy$ = "DOG" AND ev% <> 226 AND dlf% > 0 THEN okay$ = "NO":  EXIT SUB
NEXT yuper%
IF enemy2$ = "CRUSHER" AND crush% > 10 AND ph% = eh2% - 24 THEN okay$ = "NO"
IF enemy3$ = "CRUSHER" AND crush3% > 10 AND ph% = eh3% - 24 THEN okay$ = "NO"
IF ph% = xbh% - 22 AND pv% = xbv% THEN okay$ = "NO"
END SUB

SUB checkup
okay$ = "YES"
IF ph% > 265 AND ph% < 308 AND pv% = 224 AND f9$ = "1" THEN okay$ = "NO"
IF ph% > 233 AND ph% < 276 AND pv% = 224 AND f8$ = "1" THEN okay$ = "NO"
IF ph% > 201 AND ph% < 244 AND pv% = 224 AND f7$ = "1" THEN okay$ = "NO"
IF ph% > 169 AND ph% < 212 AND pv% = 224 AND f6$ = "1" THEN okay$ = "NO"
IF ph% > 137 AND ph% < 180 AND pv% = 224 AND f5$ = "1" THEN okay$ = "NO"
IF ph% > 105 AND ph% < 148 AND pv% = 224 AND f4$ = "1" THEN okay$ = "NO"
IF ph% > 73 AND ph% < 116 AND pv% = 224 AND f3$ = "1" THEN okay$ = "NO"
IF ph% > 41 AND ph% < 84 AND pv% = 224 AND f2$ = "1" THEN okay$ = "NO"
IF ph% > 9 AND ph% < 52 AND pv% = 224 AND f1$ = "1" THEN okay$ = "NO"
IF ph% > 265 AND ph% < 308 AND pv% = 192 AND e9$ = "1" THEN okay$ = "NO"
IF ph% > 233 AND ph% < 276 AND pv% = 192 AND e8$ = "1" THEN okay$ = "NO"
IF ph% > 201 AND ph% < 244 AND pv% = 192 AND e7$ = "1" THEN okay$ = "NO"
IF ph% > 169 AND ph% < 212 AND pv% = 192 AND e6$ = "1" THEN okay$ = "NO"
IF ph% > 137 AND ph% < 180 AND pv% = 192 AND e5$ = "1" THEN okay$ = "NO"
IF ph% > 105 AND ph% < 148 AND pv% = 192 AND e4$ = "1" THEN okay$ = "NO"
IF ph% > 73 AND ph% < 116 AND pv% = 192 AND e3$ = "1" THEN okay$ = "NO"
IF ph% > 41 AND ph% < 84 AND pv% = 192 AND e2$ = "1" THEN okay$ = "NO"
IF ph% > 9 AND ph% < 52 AND pv% = 192 AND e1$ = "1" THEN okay$ = "NO"
IF ph% > 265 AND ph% < 308 AND pv% = 160 AND d9$ = "1" THEN okay$ = "NO"
IF ph% > 233 AND ph% < 276 AND pv% = 160 AND d8$ = "1" THEN okay$ = "NO"
IF ph% > 201 AND ph% < 244 AND pv% = 160 AND d7$ = "1" THEN okay$ = "NO"
IF ph% > 169 AND ph% < 212 AND pv% = 160 AND d6$ = "1" THEN okay$ = "NO"
IF ph% > 137 AND ph% < 180 AND pv% = 160 AND d5$ = "1" THEN okay$ = "NO"
IF ph% > 105 AND ph% < 148 AND pv% = 160 AND d4$ = "1" THEN okay$ = "NO"
IF ph% > 73 AND ph% < 116 AND pv% = 160 AND d3$ = "1" THEN okay$ = "NO"
IF ph% > 41 AND ph% < 84 AND pv% = 160 AND d2$ = "1" THEN okay$ = "NO"
IF ph% > 9 AND ph% < 52 AND pv% = 160 AND d1$ = "1" THEN okay$ = "NO"
IF ph% > 265 AND ph% < 308 AND pv% = 128 AND c9$ = "1" THEN okay$ = "NO"
IF ph% > 233 AND ph% < 276 AND pv% = 128 AND c8$ = "1" THEN okay$ = "NO"
IF ph% > 201 AND ph% < 244 AND pv% = 128 AND c7$ = "1" THEN okay$ = "NO"
IF ph% > 169 AND ph% < 212 AND pv% = 128 AND c6$ = "1" THEN okay$ = "NO"
IF ph% > 137 AND ph% < 180 AND pv% = 128 AND c5$ = "1" THEN okay$ = "NO"
IF ph% > 105 AND ph% < 148 AND pv% = 128 AND c4$ = "1" THEN okay$ = "NO"
IF ph% > 73 AND ph% < 116 AND pv% = 128 AND c3$ = "1" THEN okay$ = "NO"
IF ph% > 41 AND ph% < 84 AND pv% = 128 AND c2$ = "1" THEN okay$ = "NO"
IF ph% > 9 AND ph% < 52 AND pv% = 128 AND c1$ = "1" THEN okay$ = "NO"
IF ph% > 265 AND ph% < 308 AND pv% = 96 AND b9$ = "1" THEN okay$ = "NO"
IF ph% > 233 AND ph% < 276 AND pv% = 96 AND b8$ = "1" THEN okay$ = "NO"
IF ph% > 201 AND ph% < 244 AND pv% = 96 AND b7$ = "1" THEN okay$ = "NO"
IF ph% > 169 AND ph% < 212 AND pv% = 96 AND b6$ = "1" THEN okay$ = "NO"
IF ph% > 137 AND ph% < 180 AND pv% = 96 AND b5$ = "1" THEN okay$ = "NO"
IF ph% > 105 AND ph% < 148 AND pv% = 96 AND b4$ = "1" THEN okay$ = "NO"
IF ph% > 73 AND ph% < 116 AND pv% = 96 AND b3$ = "1" THEN okay$ = "NO"
IF ph% > 41 AND ph% < 84 AND pv% = 96 AND b2$ = "1" THEN okay$ = "NO"
IF ph% > 9 AND ph% < 52 AND pv% = 96 AND b1$ = "1" THEN okay$ = "NO"
IF ph% > 265 AND ph% < 308 AND pv% = 64 AND a9$ = "1" THEN okay$ = "NO"
IF ph% > 233 AND ph% < 276 AND pv% = 64 AND a8$ = "1" THEN okay$ = "NO"
IF ph% > 201 AND ph% < 244 AND pv% = 64 AND a7$ = "1" THEN okay$ = "NO"
IF ph% > 169 AND ph% < 212 AND pv% = 64 AND a6$ = "1" THEN okay$ = "NO"
IF ph% > 137 AND ph% < 180 AND pv% = 64 AND a5$ = "1" THEN okay$ = "NO"
IF ph% > 105 AND ph% < 148 AND pv% = 64 AND a4$ = "1" THEN okay$ = "NO"
IF ph% > 73 AND ph% < 116 AND pv% = 64 AND a3$ = "1" THEN okay$ = "NO"
IF ph% > 41 AND ph% < 84 AND pv% = 64 AND a2$ = "1" THEN okay$ = "NO"
IF ph% > 9 AND ph% < 52 AND pv% = 64 AND a1$ = "1" THEN okay$ = "NO"
IF ph% > 265 AND ph% < 308 AND pv% = 32 THEN okay$ = "NO"
IF ph% > 233 AND ph% < 276 AND pv% = 32 THEN okay$ = "NO"
IF ph% > 201 AND ph% < 244 AND pv% = 32 THEN okay$ = "NO"
IF ph% > 169 AND ph% < 212 AND pv% = 32 THEN okay$ = "NO"
IF ph% > 137 AND ph% < 180 AND pv% = 32 THEN okay$ = "NO"
IF ph% > 105 AND ph% < 148 AND pv% = 32 THEN okay$ = "NO"
IF ph% > 73 AND ph% < 116 AND pv% = 32 THEN okay$ = "NO"
IF ph% > 41 AND ph% < 84 AND pv% = 32 THEN okay$ = "NO"
IF ph% > 9 AND ph% < 52 AND pv% = 32 THEN okay$ = "NO"
IF lunging$ = "YES" THEN okay$ = "NO"
IF ph% > xbh% - 22 AND ph% < xbh% + 18 AND pv% = xbv% + 32 THEN okay$ = "NO"
END SUB

DEFINT A-Z
SUB chooselevel
CLS : SCREEN 9: COLOR 3
PRINT : PRINT : PRINT : PRINT : PRINT
SHELL "dir /b *.gq2"
LOCATE 2, 1: PRINT "Below are the map files you have."
LOCATE 3, 1: PRINT "Please enter the name of the one you want to play."
enterlevname:
LOCATE 4, 1: INPUT "", userdeffedlev$
checkfilename userdeffedlev$
IF nogoodname$ = "YES" THEN nogoodname$ = "NO": GOTO enterlevname
userdeffedlev$ = thefilename$
END SUB

DEFSNG A-Z
SUB closechannels
IF MaxChannel% > 4 THEN FirstLoop% = 3 ELSE FirstLoop% = MaxChannel%
 FOR Channel% = 0 TO FirstLoop%
  WriteReg &HB0 + Channel%, 0
 NEXT
 IF FirstLoop% = MaxChannel% THEN EXIT SUB
 FOR Channel% = Channel% TO MaxChannel%
  WriteReg &HB0 + Channel% + 5, 0
 NEXT
END SUB

SUB cone (ch%, cv%, height%, size%)
oldsize% = size%: oldcv% = cv%
56 CIRCLE (ch%, cv%), size%, col%
FOR this% = 1 TO (height% / 16)
CIRCLE (ch%, cv% + this%), size%, col%
NEXT this%
IF size% > 1 THEN size% = size% - 1: cv% = cv% - height% / oldsize%: GOTO 56
size% = oldsize%: cv% = oldcv%  ':col%=col%+1
CIRCLE (ch%, cv%), size%, 8
LINE (ch%, cv% - height%)-(ch%, cv% + size% - (size% / 5)), 30
LINE (ch%, cv% - height%)-(ch%, cv% - size% + (size% / 5)), 30
LINE (ch%, cv% - height%)-(ch% - size%, cv%), 16
LINE (ch%, cv% - height%)-(ch% + size%, cv%), 16
LINE (ch%, cv% - height%)-(ch% + (size% * .75), cv% + ((size% - (size% / 5)) * .75) - 1), 24
LINE (ch%, cv% - height%)-(ch% - (size% * .75), cv% + ((size% - (size% / 5)) * .75) - 1), 24
LINE (ch%, cv% - height%)-(ch% + (size% * .75), cv% - ((size% - (size% / 5)) * .75) + 1), 24
LINE (ch%, cv% - height%)-(ch% - (size% * .75), cv% - ((size% - (size% / 5)) * .75) + 1), 24
LINE (ch%, cv% - height%)-(ch% + (size% * .4), cv% + ((size% - (size% / 5)) * .9) - 1), 28
LINE (ch%, cv% - height%)-(ch% - (size% * .4), cv% + ((size% - (size% / 5)) * .9) - 1), 28
LINE (ch%, cv% - height%)-(ch% + (size% * .4), cv% - ((size% - (size% / 5)) * .9) + 1), 28
LINE (ch%, cv% - height%)-(ch% - (size% * .4), cv% - ((size% - (size% / 5)) * .9) + 1), 28
LINE (ch%, cv% - height%)-(ch% + (size% * .9), cv% + ((size% - (size% / 5)) * .4) - 1), 20
LINE (ch%, cv% - height%)-(ch% - (size% * .9), cv% + ((size% - (size% / 5)) * .4) - 1), 20
LINE (ch%, cv% - height%)-(ch% + (size% * .9), cv% - ((size% - (size% / 5)) * .4) + 1), 20
LINE (ch%, cv% - height%)-(ch% - (size% * .9), cv% - ((size% - (size% / 5)) * .4) + 1), 20
LINE (ch%, cv% - height%)-(ch% + (size% * .85), cv% + ((size% - (size% / 5)) * .6) - 1), 22
LINE (ch%, cv% - height%)-(ch% - (size% * .85), cv% + ((size% - (size% / 5)) * .6) - 1), 22'col%: col% = col% - 1
LINE (ch%, cv% - height%)-(ch% + (size% * .85), cv% - ((size% - (size% / 5)) * .6) + 1), 22'col%: col% = col% - 1
LINE (ch%, cv% - height%)-(ch% - (size% * .85), cv% - ((size% - (size% / 5)) * .6) + 1), 22'col%: col% = col% - 1
LINE (ch%, cv% - height%)-(ch% + (size% * .6), cv% + ((size% - (size% / 5)) * .85) - 1), 26'col%: col% = col% - 1
LINE (ch%, cv% - height%)-(ch% - (size% * .6), cv% + ((size% - (size% / 5)) * .85) - 1), 26'col%: col% = col% - 1
LINE (ch%, cv% - height%)-(ch% + (size% * .6), cv% - ((size% - (size% / 5)) * .85) + 1), 26'col%: col% = col% - 1
LINE (ch%, cv% - height%)-(ch% - (size% * .6), cv% - ((size% - (size% / 5)) * .85) + 1), 26'col%: col% = col% - 1
LINE (ch%, cv% - height%)-(ch% + (size% * .2), cv% + ((size% - (size% / 5)) * 1) - 1), 30'col%: col% = col% - 1
LINE (ch%, cv% - height%)-(ch% - (size% * .2), cv% + ((size% - (size% / 5)) * 1) - 1), 30'col%: col% = col% - 1
LINE (ch%, cv% - height%)-(ch% + (size% * .2), cv% - ((size% - (size% / 5)) * 1) + 1), 30'col%: col% = col% - 1
LINE (ch%, cv% - height%)-(ch% - (size% * .2), cv% - ((size% - (size% / 5)) * 1) + 1), 30'col%: col% = col% - 1
LINE (ch%, cv% - height%)-(ch% + (size% * .95), cv% + ((size% - (size% / 5)) * .2) - 1), 18'col%: col% = col% - 1
LINE (ch%, cv% - height%)-(ch% - (size% * .95), cv% + ((size% - (size% / 5)) * .2) - 1), 18'col%: col% = col% - 1
LINE (ch%, cv% - height%)-(ch% + (size% * .95), cv% - ((size% - (size% / 5)) * .2) + 1), 18'col%: col% = col% - 1
LINE (ch%, cv% - height%)-(ch% - (size% * .95), cv% - ((size% - (size% / 5)) * .2) + 1), 18'col%: col% = col% - 1
END SUB

SUB delay (break)
oldtimer = TIMER
DO
IF TIMER > oldtimer + (break / 10) THEN EXIT SUB
LOOP
END SUB

DEFINT A-Z
SUB DetectSB

CLS : SCREEN 9: COLOR 3
PRINT "Searching for Sound Blaster..."


DetectedSB = 0
sbport = &H210              'set starting port

DO WHILE (sbport <= &H260)  'stay within DSP port usage

  OUT sbport + &H6, &H1     'reset port
  samp! = TIMER             'wait at least three millisecs
  DO: LOOP WHILE ABS(TIMER - samp!) > .5
  OUT sbport + &H6, &H0     'write a 0

  FOR crt2 = 0 TO 30        'cycle a few times in case of fast machine

    DO WHILE (SByte AND &H80) = 0  'Loop while bit 7 = 0
      SByte = INP(sbport + &HE)    'check to see if bit 7 is 1
      ctr = ctr + 1                'increment the fail counter
      IF ctr = 200 THEN EXIT DO    'fail the test
    LOOP

    IF SByte = 0 THEN    'detection has failed
      'DetectSB = 0     'set result incase of last pass
      EXIT FOR
    END IF

    DByte = INP(sbport + &HA)   'read a byte from the data port

    IF DByte = &HAA THEN        'found it
      DetectedSB = 1
      EXIT DO
    END IF

  NEXT

  sbport = sbport + &H10         'Try next port

LOOP

IF DetectedSB = 1 THEN
  PRINT "Sound Blaster found at port &H"; HEX$(sbport)
  BasePort% = sbport
  canhavemusic$ = "YES"
  ELSE
  PRINT "Sound Blaster not found."
  PRINT "You can have the sounds, but the music must stay turned OFF."
END IF
SLEEP 4


END SUB

DEFSNG A-Z
SUB drawbat
bath% = bath% - 2
batv% = batv% - 8
CIRCLE (bath%, batv%), 4, 0
LINE (bath% - 3, batv% - 2)-(bath% + 3, batv% + 2), 0, BF
PSET (bath% - 2, batv%), 10
PSET (bath% + 2, batv%), 10
LINE (bath%, batv%)-(bath% - 10, batv% - 5), 0
LINE (bath% - 15, batv%)-(bath% - 10, batv% - 5), 0
LINE (bath% - 15, batv% + 1)-(bath% - 10, batv% - 1), 0
LINE (bath% - 5, batv% + 1)-(bath% - 10, batv% - 1), 0
LINE (bath%, batv%)-(bath% + 10, batv% - 5), 0
LINE (bath% + 15, batv%)-(bath% + 10, batv% - 5), 0
LINE (bath% + 15, batv% + 1)-(bath% + 10, batv% - 1), 0
LINE (bath% + 5, batv% + 1)-(bath% + 10, batv% - 1), 0
PAINT (bath% + 7, batv% - 1), 8, 0
PAINT (bath% - 7, batv% - 1), 8, 0
PSET (bath% + 14, batv%), 8
LINE (bath% - 3, batv% + 3)-(bath% - 3, batv% + 4), 0
PSET (bath% - 2, batv% + 5), 0
LINE (bath% + 3, batv% + 3)-(bath% + 2, batv% + 5), 0
bath% = bath% + 2
batv% = batv% + 8
END SUB

SUB drawbear
berv% = berv% - 19
LINE (berh% - 3, berv% - 3)-(berh% + 3, berv% + 3), 6, BF
LINE (berh% - 4, berv% - 2)-(berh% + 4, berv%), 6, BF
LINE (berh% - 2, berv% - 4)-(berh% + 2, berv% + 4), 6, BF
LINE (berh% - 4, berv% + 3)-(berh% - 3, berv% + 4), 6
PSET (berh% - 5, berv%), 0
PSET (berh% - 3, berv% - 1), 0
LINE (berh% - 2, berv% + 5)-(berh% + 3, berv% + 15), 6, BF
LINE (berh% - 5, berv% + 6)-(berh% - 2, berv% + 8), 6, BF
PSET (berh% - 6, berv% + 6), 6
PSET (berh% - 6, berv% + 8), 6
LINE (berh% - 3, berv% + 15)-(berh% + 1, berv% + 20), 6, BF
LINE (berh% - 4, berv% + 21)-(berh%, berv% + 23), 6, BF
berv% = berv% + 19
END SUB

SUB drawplayer


IF bloodbath$ = "YES" THEN
FOR blood% = 1 TO 10
RANDOMIZE TIMER
Alud% = INT(RND * 10) + 1
Blud% = INT(RND * 15) + 1
CIRCLE (ph% + (Alud% - 5), pv% + (Blud% - 10)), 1, 4
NEXT blood%
END IF


IF player$ = "SNAKE" THEN
oldedir$ = edir$
oldev% = ev%
oldeh% = eh%
ev% = pv%
eh% = ph%
edir$ = dir$
IF dir$ = "STOPPED" THEN edir$ = "RIGHT"
CALL drawsnake
edir$ = oldedir$
ev% = oldev%
eh% = oldeh%
EXIT SUB
END IF

'af% = ANIMATION FRAME

IF af% = 8 THEN
CIRCLE (ph% - 1, pv% - 14), 2, 4
CIRCLE (ph%, pv% - 14), 2, 4
CIRCLE (ph%, pv% - 16), 4, 0
LINE (ph% - 3, pv% - 17)-(ph% + 3, pv% - 15), 15, BF
LINE (ph% - 1, pv% - 18)-(ph% + 1, pv% - 14), 15, BF
PSET (ph%, pv% - 16), 0
PSET (ph% + 2, pv% - 16), 0
LINE (ph% - 4, pv% - 12)-(ph% - 4, pv% - 9), 0
LINE (ph% - 2, pv% - 7)-(ph% - 4, pv% - 9), 0
LINE (ph% - 2, pv% - 7)-(ph% + 2, pv% - 7), 0
LINE (ph% - 1, pv% - 9)-(ph% + 2, pv% - 9), 0
LINE (ph% - 2, pv% - 10)-(ph% - 2, pv% - 11), 0
PSET (ph% + 3, pv% - 8), 15
LINE (ph% + 2, pv% - 7)-(ph% + 4, pv% - 9), 0, B
LINE (ph% + 1, pv% - 8)-(ph% - 2, pv% - 8), 4
PSET (ph% - 2, pv% - 9), 4
LINE (ph% - 3, pv% - 9)-(ph% - 3, pv% - 12), 4
PSET (ph% - 2, pv% - 12), 4
LINE (ph% - 3, pv% - 7)-(ph% + 2, pv% - 5), 0, B
LINE (ph% - 2, pv% - 6)-(ph% + 1, pv% - 6), 4
LINE (ph% + 2, pv% - 5)-(ph% + 2, pv% - 11), 0, B
LINE (ph% - 1, pv% - 10)-(ph% + 1, pv% - 11), 4, BF
LINE (ph% + 2, pv% - 5)-(ph% + 4, pv% + 2), 0
LINE (ph% - 3, pv% - 5)-(ph% - 4, pv% + 2), 0
LINE (ph%, pv% - 3)-(ph% + 1, pv% + 2), 0
LINE (ph%, pv% - 3)-(ph% - 1, pv% + 2), 0
LINE (ph% - 4, pv% + 1)-(ph% - 1, pv% + 3), 0, B
LINE (ph% + 1, pv% + 2)-(ph% + 4, pv% + 4), 0, B
LINE (ph% - 3, pv% + 2)-(ph% - 2, pv% + 2), 8
LINE (ph% + 2, pv% + 3)-(ph% + 3, pv% + 3), 8
LINE (ph% + 2, pv%)-(ph% + 3, pv% + 1), 6, BF
LINE (ph% - 2, pv% + 1)-(ph% - 3, pv% + 1), 6, BF
LINE (ph% + 1, pv% - 1)-(ph% + 2, pv% - 4), 6, BF
LINE (ph% - 1, pv% - 4)-(ph% - 2, pv%), 6, BF
PSET (ph%, pv% - 4), 6
LINE (ph% - 3, pv% + 1)-(ph% - 2, pv% + 1), 0
af% = 1: EXIT SUB
END IF

IF af% = 7 THEN
CIRCLE (ph% - 1, pv% - 14), 2, 4
CIRCLE (ph%, pv% - 14), 2, 4
CIRCLE (ph%, pv% - 16), 4, 0
LINE (ph% - 3, pv% - 17)-(ph% + 3, pv% - 15), 15, BF
LINE (ph% - 1, pv% - 18)-(ph% + 1, pv% - 14), 15, BF
PSET (ph%, pv% - 16), 0
PSET (ph% + 2, pv% - 16), 0
LINE (ph% - 4, pv% - 12)-(ph% - 4, pv% - 9), 0
LINE (ph% - 2, pv% - 7)-(ph% - 4, pv% - 9), 0
LINE (ph% - 2, pv% - 7)-(ph% + 2, pv% - 7), 0
LINE (ph% - 1, pv% - 9)-(ph% + 2, pv% - 9), 0
LINE (ph% - 2, pv% - 10)-(ph% - 2, pv% - 11), 0
PSET (ph% + 3, pv% - 8), 15
LINE (ph% + 2, pv% - 7)-(ph% + 4, pv% - 9), 0, B
LINE (ph% + 1, pv% - 8)-(ph% - 2, pv% - 8), 4
PSET (ph% - 2, pv% - 9), 4
LINE (ph% - 3, pv% - 9)-(ph% - 3, pv% - 12), 4
PSET (ph% - 2, pv% - 12), 4
LINE (ph% - 3, pv% - 7)-(ph% + 2, pv% - 5), 0, B
LINE (ph% - 2, pv% - 6)-(ph% + 1, pv% - 6), 4
LINE (ph% + 2, pv% - 5)-(ph% + 2, pv% - 11), 0, B
LINE (ph% - 1, pv% - 10)-(ph% + 1, pv% - 11), 4, BF
LINE (ph% + 2, pv% - 5)-(ph% + 4, pv% + 2), 0
LINE (ph% - 3, pv% - 5)-(ph% - 3, pv% + 3), 0
LINE (ph%, pv% - 3)-(ph% + 1, pv% + 2), 0
LINE (ph%, pv% - 3)-(ph% - 1, pv% + 2), 0
LINE (ph% - 2, pv%)-(ph%, pv% + 3), 0, B
LINE (ph% + 1, pv% + 2)-(ph% + 4, pv% + 4), 0, B
LINE (ph% - 3, pv% + 1)-(ph% - 2, pv% + 1), 8
LINE (ph% + 2, pv% + 3)-(ph% + 3, pv% + 3), 8
LINE (ph% + 2, pv%)-(ph% + 3, pv% + 1), 6, BF
LINE (ph% - 2, pv% + 1)-(ph% - 3, pv% + 1), 6, BF
LINE (ph% + 1, pv% - 1)-(ph% + 2, pv% - 4), 6, BF
LINE (ph% - 1, pv% - 4)-(ph% - 2, pv%), 6, BF
PSET (ph%, pv% - 4), 6
LINE (ph% - 2, pv% + 1)-(ph% - 1, pv% + 2), 8, BF
LINE (ph% - 3, pv%)-(ph% - 2, pv%), 0
PSET (ph% - 3, pv% + 1), 0
PSET (ph% - 1, pv%), 0
af% = 8
END IF

IF af% = 6 THEN
CIRCLE (ph% - 1, pv% - 14), 2, 4
CIRCLE (ph%, pv% - 14), 2, 4
CIRCLE (ph%, pv% - 16), 4, 0
LINE (ph% - 3, pv% - 17)-(ph% + 3, pv% - 15), 15, BF
LINE (ph% - 1, pv% - 18)-(ph% + 1, pv% - 14), 15, BF
PSET (ph%, pv% - 16), 0
PSET (ph% + 2, pv% - 16), 0
LINE (ph% - 4, pv% - 12)-(ph% - 4, pv% - 9), 0
LINE (ph% - 2, pv% - 7)-(ph% - 4, pv% - 9), 0
LINE (ph% - 2, pv% - 7)-(ph% + 2, pv% - 7), 0
LINE (ph% - 1, pv% - 9)-(ph% + 2, pv% - 9), 0
LINE (ph% - 2, pv% - 10)-(ph% - 2, pv% - 11), 0
PSET (ph% + 3, pv% - 8), 15
LINE (ph% + 2, pv% - 7)-(ph% + 4, pv% - 9), 0, B
LINE (ph% + 1, pv% - 8)-(ph% - 2, pv% - 8), 4
PSET (ph% - 2, pv% - 9), 4
LINE (ph% - 3, pv% - 9)-(ph% - 3, pv% - 12), 4
PSET (ph% - 2, pv% - 12), 4
LINE (ph% - 3, pv% - 7)-(ph% + 2, pv% - 5), 0, B
LINE (ph% - 2, pv% - 6)-(ph% + 1, pv% - 6), 4
LINE (ph% + 2, pv% - 5)-(ph% + 2, pv% - 11), 0, B
LINE (ph% - 1, pv% - 10)-(ph% + 1, pv% - 11), 4, BF
LINE (ph% + 2, pv% - 5)-(ph% + 4, pv% + 2), 0
LINE (ph% - 3, pv% - 5)-(ph% - 4, pv% + 2), 0
LINE (ph%, pv% - 3)-(ph% + 1, pv% + 2), 0
LINE (ph%, pv% - 3)-(ph% - 1, pv% + 2), 0
LINE (ph% - 4, pv% + 1)-(ph% - 1, pv% + 3), 0, B
LINE (ph% + 1, pv% + 2)-(ph% + 4, pv% + 4), 0, B
LINE (ph% - 3, pv% + 2)-(ph% - 2, pv% + 2), 8
LINE (ph% + 2, pv% + 3)-(ph% + 3, pv% + 3), 8
LINE (ph% + 2, pv%)-(ph% + 3, pv% + 1), 6, BF
LINE (ph% - 2, pv% + 1)-(ph% - 3, pv% + 1), 6, BF
LINE (ph% + 1, pv% - 1)-(ph% + 2, pv% - 4), 6, BF
LINE (ph% - 1, pv% - 4)-(ph% - 2, pv%), 6, BF
PSET (ph%, pv% - 4), 6
LINE (ph% - 3, pv% + 1)-(ph% - 2, pv% + 1), 0
af% = 7
END IF

IF af% = 5 THEN
CIRCLE (ph% - 1, pv% - 14), 2, 4
CIRCLE (ph%, pv% - 14), 2, 4
CIRCLE (ph%, pv% - 16), 4, 0
LINE (ph% - 3, pv% - 17)-(ph% + 3, pv% - 15), 15, BF
LINE (ph% - 1, pv% - 18)-(ph% + 1, pv% - 14), 15, BF
PSET (ph%, pv% - 16), 0
PSET (ph% + 2, pv% - 16), 0
LINE (ph% - 4, pv% - 12)-(ph% - 4, pv% - 9), 0
LINE (ph% - 2, pv% - 7)-(ph% - 4, pv% - 9), 0
LINE (ph% - 2, pv% - 7)-(ph% + 2, pv% - 7), 0
LINE (ph% - 1, pv% - 9)-(ph% + 2, pv% - 9), 0
LINE (ph% - 2, pv% - 10)-(ph% - 2, pv% - 11), 0
PSET (ph% + 3, pv% - 8), 15
LINE (ph% + 2, pv% - 7)-(ph% + 4, pv% - 9), 0, B
LINE (ph% + 1, pv% - 8)-(ph% - 2, pv% - 8), 4
PSET (ph% - 2, pv% - 9), 4
LINE (ph% - 3, pv% - 9)-(ph% - 3, pv% - 12), 4
PSET (ph% - 2, pv% - 12), 4
LINE (ph% - 3, pv% - 7)-(ph% + 2, pv% - 5), 0, B
LINE (ph% - 2, pv% - 6)-(ph% + 1, pv% - 6), 4
LINE (ph% + 2, pv% - 5)-(ph% + 2, pv% - 11), 0, B
LINE (ph% - 1, pv% - 10)-(ph% + 1, pv% - 11), 4, BF
LINE (ph% + 2, pv% - 5)-(ph% + 4, pv% + 2), 0
LINE (ph% - 3, pv% - 5)-(ph% - 4, pv% + 2), 0
LINE (ph%, pv% - 3)-(ph% + 1, pv% + 2), 0
LINE (ph%, pv% - 3)-(ph% - 1, pv% + 2), 0
LINE (ph% - 4, pv% + 2)-(ph% - 1, pv% + 4), 0, B
LINE (ph% + 1, pv% + 2)-(ph% + 4, pv% + 4), 0, B
LINE (ph% - 3, pv% + 3)-(ph% - 2, pv% + 3), 8
LINE (ph% + 2, pv% + 3)-(ph% + 3, pv% + 3), 8
LINE (ph% + 2, pv%)-(ph% + 3, pv% + 1), 6, BF
LINE (ph% - 2, pv% + 1)-(ph% - 3, pv% + 1), 6, BF
LINE (ph% + 1, pv% - 1)-(ph% + 2, pv% - 4), 6, BF
LINE (ph% - 1, pv% - 4)-(ph% - 2, pv%), 6, BF
PSET (ph%, pv% - 4), 6
af% = 6
END IF

IF af% = 4 THEN
CIRCLE (ph%, pv% - 15), 4, 0
LINE (ph% - 3, pv% - 16)-(ph% + 3, pv% - 14), 15, BF
LINE (ph% - 1, pv% - 17)-(ph% + 1, pv% - 13), 15, BF
PSET (ph%, pv% - 15), 0
PSET (ph% + 2, pv% - 15), 0
LINE (ph% - 4, pv% - 12)-(ph% - 4, pv% - 9), 0
LINE (ph% - 2, pv% - 7)-(ph% - 4, pv% - 9), 0
LINE (ph% - 2, pv% - 7)-(ph% + 2, pv% - 7), 0
LINE (ph% - 1, pv% - 9)-(ph% + 2, pv% - 9), 0
LINE (ph% - 2, pv% - 10)-(ph% - 2, pv% - 11), 0
PSET (ph% + 3, pv% - 8), 15
LINE (ph% + 2, pv% - 7)-(ph% + 4, pv% - 9), 0, B
LINE (ph% + 1, pv% - 8)-(ph% - 2, pv% - 8), 4
PSET (ph% - 2, pv% - 9), 4
LINE (ph% - 3, pv% - 9)-(ph% - 3, pv% - 12), 4
PSET (ph% - 2, pv% - 12), 4
LINE (ph% - 3, pv% - 7)-(ph% + 2, pv% - 5), 0, B
LINE (ph% - 2, pv% - 6)-(ph% + 1, pv% - 6), 4
LINE (ph% + 2, pv% - 5)-(ph% + 2, pv% - 11), 0, B
LINE (ph% - 1, pv% - 10)-(ph% + 1, pv% - 11), 4, BF
LINE (ph% + 2, pv% - 5)-(ph% + 4, pv% + 2), 0
LINE (ph% - 3, pv% - 5)-(ph% - 4, pv% + 2), 0
LINE (ph%, pv% - 3)-(ph% + 1, pv% + 2), 0
LINE (ph%, pv% - 3)-(ph% - 1, pv% + 2), 0
LINE (ph% - 4, pv% + 2)-(ph% - 1, pv% + 4), 0, B
LINE (ph% + 1, pv% + 1)-(ph% + 4, pv% + 3), 0, B
LINE (ph% - 3, pv% + 3)-(ph% - 2, pv% + 3), 8
LINE (ph% + 2, pv% + 2)-(ph% + 3, pv% + 2), 8
LINE (ph% + 2, pv% + 1)-(ph% + 3, pv% + 1), 0
LINE (ph% + 2, pv%)-(ph% + 3, pv% + 0), 6, BF
LINE (ph% - 2, pv% + 1)-(ph% - 3, pv% + 1), 6, BF
LINE (ph% + 1, pv% - 1)-(ph% + 2, pv% - 4), 6, BF
LINE (ph% - 1, pv% - 4)-(ph% - 2, pv%), 6, BF
PSET (ph%, pv% - 4), 6
af% = 5
END IF

IF af% = 3 THEN
CIRCLE (ph%, pv% - 15), 4, 0
LINE (ph% - 3, pv% - 16)-(ph% + 3, pv% - 14), 15, BF
LINE (ph% - 1, pv% - 17)-(ph% + 1, pv% - 13), 15, BF
PSET (ph%, pv% - 15), 0
PSET (ph% + 2, pv% - 15), 0
LINE (ph% - 4, pv% - 12)-(ph% - 4, pv% - 9), 0
LINE (ph% - 2, pv% - 7)-(ph% - 4, pv% - 9), 0
LINE (ph% - 2, pv% - 7)-(ph% + 2, pv% - 7), 0
LINE (ph% - 1, pv% - 9)-(ph% + 2, pv% - 9), 0
LINE (ph% - 2, pv% - 10)-(ph% - 2, pv% - 11), 0
PSET (ph% + 3, pv% - 8), 15
LINE (ph% + 2, pv% - 7)-(ph% + 4, pv% - 9), 0, B
LINE (ph% + 1, pv% - 8)-(ph% - 2, pv% - 8), 4
PSET (ph% - 2, pv% - 9), 4
LINE (ph% - 3, pv% - 9)-(ph% - 3, pv% - 12), 4
PSET (ph% - 2, pv% - 12), 4
LINE (ph% - 3, pv% - 7)-(ph% + 2, pv% - 5), 0, B
LINE (ph% - 2, pv% - 6)-(ph% + 1, pv% - 6), 4
LINE (ph% + 2, pv% - 5)-(ph% + 2, pv% - 11), 0, B
LINE (ph% - 1, pv% - 10)-(ph% + 1, pv% - 11), 4, BF
LINE (ph% + 2, pv% - 5)-(ph% + 5, pv% - 1), 0
LINE (ph% - 3, pv% - 5)-(ph% - 4, pv% + 2), 0
LINE (ph%, pv% - 3)-(ph% - 1, pv% + 2), 0
LINE (ph% - 4, pv% + 2)-(ph% - 1, pv% + 4), 0, B
LINE (ph% + 2, pv%)-(ph% + 5, pv% + 2), 0, B
LINE (ph% - 3, pv% + 3)-(ph% - 2, pv% + 3), 8
LINE (ph% + 3, pv% + 1)-(ph% + 4, pv% + 1), 8
LINE (ph% + 3, pv%)-(ph% + 4, pv%), 0
LINE (ph% + 2, pv% - 1)-(ph% + 3, pv% - 1), 6, BF
LINE (ph% - 2, pv% + 1)-(ph% - 3, pv% + 1), 6, BF
LINE (ph% + 1, pv% - 1)-(ph% + 2, pv% - 4), 6, BF
LINE (ph% - 1, pv% - 4)-(ph% - 2, pv%), 6, BF
PSET (ph%, pv% - 4), 6
PSET (ph% + 1, pv% - 1), 0
LINE (ph% + 4, pv% - 1)-(ph% + 3, pv% - 2), 6
LINE (ph% + 4, pv% - 2)-(ph% + 3, pv% - 3), 6
af% = 4
END IF

IF af% = 2 THEN
CIRCLE (ph%, pv% - 15), 4, 0
LINE (ph% - 3, pv% - 16)-(ph% + 3, pv% - 14), 15, BF
LINE (ph% - 1, pv% - 17)-(ph% + 1, pv% - 13), 15, BF
PSET (ph%, pv% - 15), 0
PSET (ph% + 2, pv% - 15), 0
LINE (ph% - 4, pv% - 12)-(ph% - 4, pv% - 9), 0
LINE (ph% - 2, pv% - 7)-(ph% - 4, pv% - 9), 0
LINE (ph% - 2, pv% - 7)-(ph% + 2, pv% - 7), 0
LINE (ph% - 1, pv% - 9)-(ph% + 2, pv% - 9), 0
LINE (ph% - 2, pv% - 10)-(ph% - 2, pv% - 11), 0
PSET (ph% + 3, pv% - 8), 15
LINE (ph% + 2, pv% - 7)-(ph% + 4, pv% - 9), 0, B
LINE (ph% + 1, pv% - 8)-(ph% - 2, pv% - 8), 4
PSET (ph% - 2, pv% - 9), 4
LINE (ph% - 3, pv% - 9)-(ph% - 3, pv% - 12), 4
PSET (ph% - 2, pv% - 12), 4
LINE (ph% - 3, pv% - 7)-(ph% + 2, pv% - 5), 0, B
LINE (ph% - 2, pv% - 6)-(ph% + 1, pv% - 6), 4
LINE (ph% + 2, pv% - 5)-(ph% + 2, pv% - 11), 0, B
LINE (ph% - 1, pv% - 10)-(ph% + 1, pv% - 11), 4, BF
LINE (ph% + 2, pv% - 5)-(ph% + 4, pv% + 2), 0
LINE (ph% - 3, pv% - 5)-(ph% - 4, pv% + 2), 0
LINE (ph%, pv% - 3)-(ph% + 1, pv% + 2), 0
LINE (ph%, pv% - 3)-(ph% - 1, pv% + 2), 0
LINE (ph% - 4, pv% + 2)-(ph% - 1, pv% + 4), 0, B
LINE (ph% + 1, pv% + 1)-(ph% + 4, pv% + 3), 0, B
LINE (ph% - 3, pv% + 3)-(ph% - 2, pv% + 3), 8
LINE (ph% + 2, pv% + 2)-(ph% + 3, pv% + 2), 8
LINE (ph% + 2, pv% + 1)-(ph% + 3, pv% + 1), 0
LINE (ph% + 2, pv%)-(ph% + 3, pv% + 0), 6, BF
LINE (ph% - 2, pv% + 1)-(ph% - 3, pv% + 1), 6, BF
LINE (ph% + 1, pv% - 1)-(ph% + 2, pv% - 4), 6, BF
LINE (ph% - 1, pv% - 4)-(ph% - 2, pv%), 6, BF
PSET (ph%, pv% - 4), 6
af% = 3
END IF

IF af% = 1 THEN
CIRCLE (ph%, pv% - 15), 4, 0
LINE (ph% - 3, pv% - 16)-(ph% + 3, pv% - 14), 15, BF
LINE (ph% - 1, pv% - 17)-(ph% + 1, pv% - 13), 15, BF
PSET (ph%, pv% - 15), 0
PSET (ph% + 2, pv% - 15), 0
LINE (ph% - 4, pv% - 12)-(ph% - 4, pv% - 9), 0
LINE (ph% - 2, pv% - 7)-(ph% - 4, pv% - 9), 0
LINE (ph% - 2, pv% - 7)-(ph% + 2, pv% - 7), 0
LINE (ph% - 1, pv% - 9)-(ph% + 2, pv% - 9), 0
LINE (ph% - 2, pv% - 10)-(ph% - 2, pv% - 11), 0
PSET (ph% + 3, pv% - 8), 15
LINE (ph% + 2, pv% - 7)-(ph% + 4, pv% - 9), 0, B
LINE (ph% + 1, pv% - 8)-(ph% - 2, pv% - 8), 4
PSET (ph% - 2, pv% - 9), 4
LINE (ph% - 3, pv% - 9)-(ph% - 3, pv% - 12), 4
PSET (ph% - 2, pv% - 12), 4
LINE (ph% - 3, pv% - 7)-(ph% + 2, pv% - 5), 0, B
LINE (ph% - 2, pv% - 6)-(ph% + 1, pv% - 6), 4
LINE (ph% + 2, pv% - 5)-(ph% + 2, pv% - 11), 0, B
LINE (ph% - 1, pv% - 10)-(ph% + 1, pv% - 11), 4, BF
LINE (ph% + 2, pv% - 5)-(ph% + 4, pv% + 2), 0
LINE (ph% - 3, pv% - 5)-(ph% - 4, pv% + 2), 0
LINE (ph%, pv% - 3)-(ph% + 1, pv% + 2), 0
LINE (ph%, pv% - 3)-(ph% - 1, pv% + 2), 0
LINE (ph% - 4, pv% + 2)-(ph% - 1, pv% + 4), 0, B
LINE (ph% + 1, pv% + 2)-(ph% + 4, pv% + 4), 0, B
LINE (ph% - 3, pv% + 3)-(ph% - 2, pv% + 3), 8
LINE (ph% + 2, pv% + 3)-(ph% + 3, pv% + 3), 8
LINE (ph% + 2, pv%)-(ph% + 3, pv% + 1), 6, BF
LINE (ph% - 2, pv% + 1)-(ph% - 3, pv% + 1), 6, BF
LINE (ph% + 1, pv% - 1)-(ph% + 2, pv% - 4), 6, BF
LINE (ph% - 1, pv% - 4)-(ph% - 2, pv%), 6, BF
PSET (ph%, pv% - 4), 6
af% = 2
END IF

END SUB

SUB drawsnake

CALL drawbear

IF edir$ = "LEFT" THEN
CIRCLE (eh% - 3, ev% - 2), 2, 2
LINE (eh% - 4, ev% - 3)-(eh% - 1, ev%), 2, BF
PSET (eh% - 4, ev% - 2), 0
PSET (eh% - 2, ev% - 2), 0
LINE (eh% - 3, ev%)-(eh% - 1, ev% + 4), 2, BF
LINE (eh% + 1, ev% + 2)-(eh% - 1, ev% + 4), 2, BF
PSET (eh% - 3, ev% + 4), bgc%
LINE (eh% + 1, ev% - 1)-(eh% + 3, ev% + 4), 2, BF
PSET (eh% + 3, ev% + 4), bgc%
LINE (eh% + 2, ev% - 2)-(eh% + 3, ev%), 2, BF
LINE (eh% + 3, ev% - 3)-(eh% + 4, ev% - 2), 2, BF
END IF
IF edir$ = "RIGHT" THEN
CIRCLE (eh% + 3, ev% - 2), 2, 2
LINE (eh% + 4, ev% - 3)-(eh% + 1, ev%), 2, BF
PSET (eh% + 4, ev% - 2), 0
PSET (eh% + 2, ev% - 2), 0
LINE (eh% + 3, ev%)-(eh% + 1, ev% + 4), 2, BF
LINE (eh% - 1, ev% + 2)-(eh% + 1, ev% + 4), 2, BF
PSET (eh% + 3, ev% + 4), bgc%
LINE (eh% - 1, ev% - 1)-(eh% - 3, ev% + 4), 2, BF
PSET (eh% - 3, ev% + 4), bgc%
LINE (eh% - 2, ev% - 2)-(eh% - 3, ev%), 2, BF
LINE (eh% - 3, ev% - 3)-(eh% - 4, ev% - 2), 2, BF
END IF
END SUB

SUB echeck4fall
IF ev% > 190 THEN
ev% = 225: efall% = 0
IF stage$ = "9" THEN eh% = 201: ev% = 64: edir$ = "LEFT"
END IF
okay$ = "YES"
oldev% = ev%
ev% = ev% + 64
IF eh% > 265 AND eh% < 308 AND ev% = 224 AND f9$ = "1" THEN okay$ = "NO"
IF eh% > 233 AND eh% < 276 AND ev% = 224 AND f8$ = "1" THEN okay$ = "NO"
IF eh% > 201 AND eh% < 244 AND ev% = 224 AND f7$ = "1" THEN okay$ = "NO"
IF eh% > 169 AND eh% < 212 AND ev% = 224 AND f6$ = "1" THEN okay$ = "NO"
IF eh% > 137 AND eh% < 180 AND ev% = 224 AND f5$ = "1" THEN okay$ = "NO"
IF eh% > 105 AND eh% < 148 AND ev% = 224 AND f4$ = "1" THEN okay$ = "NO"
IF eh% > 73 AND eh% < 116 AND ev% = 224 AND f3$ = "1" THEN okay$ = "NO"
IF eh% > 41 AND eh% < 84 AND ev% = 224 AND f2$ = "1" THEN okay$ = "NO"
IF eh% > 9 AND eh% < 52 AND ev% = 224 AND f1$ = "1" THEN okay$ = "NO"
IF eh% > 265 AND eh% < 308 AND ev% = 192 AND e9$ = "1" THEN okay$ = "NO"
IF eh% > 233 AND eh% < 276 AND ev% = 192 AND e8$ = "1" THEN okay$ = "NO"
IF eh% > 201 AND eh% < 244 AND ev% = 192 AND e7$ = "1" THEN okay$ = "NO"
IF eh% > 169 AND eh% < 212 AND ev% = 192 AND e6$ = "1" THEN okay$ = "NO"
IF eh% > 137 AND eh% < 180 AND ev% = 192 AND e5$ = "1" THEN okay$ = "NO"
IF eh% > 105 AND eh% < 148 AND ev% = 192 AND e4$ = "1" THEN okay$ = "NO"
IF eh% > 73 AND eh% < 116 AND ev% = 192 AND e3$ = "1" THEN okay$ = "NO"
IF eh% > 41 AND eh% < 84 AND ev% = 192 AND e2$ = "1" THEN okay$ = "NO"
IF eh% > 9 AND eh% < 52 AND ev% = 192 AND e1$ = "1" THEN okay$ = "NO"
IF eh% > 265 AND eh% < 308 AND ev% = 160 AND d9$ = "1" THEN okay$ = "NO"
IF eh% > 233 AND eh% < 276 AND ev% = 160 AND d8$ = "1" THEN okay$ = "NO"
IF eh% > 201 AND eh% < 244 AND ev% = 160 AND d7$ = "1" THEN okay$ = "NO"
IF eh% > 169 AND eh% < 212 AND ev% = 160 AND d6$ = "1" THEN okay$ = "NO"
IF eh% > 137 AND eh% < 180 AND ev% = 160 AND d5$ = "1" THEN okay$ = "NO"
IF eh% > 105 AND eh% < 148 AND ev% = 160 AND d4$ = "1" THEN okay$ = "NO"
IF eh% > 73 AND eh% < 116 AND ev% = 160 AND d3$ = "1" THEN okay$ = "NO"
IF eh% > 41 AND eh% < 84 AND ev% = 160 AND d2$ = "1" THEN okay$ = "NO"
IF eh% > 9 AND eh% < 52 AND ev% = 160 AND d1$ = "1" THEN okay$ = "NO"
IF eh% > 265 AND eh% < 308 AND ev% = 128 AND c9$ = "1" THEN okay$ = "NO"
IF eh% > 233 AND eh% < 276 AND ev% = 128 AND c8$ = "1" THEN okay$ = "NO"
IF eh% > 201 AND eh% < 244 AND ev% = 128 AND c7$ = "1" THEN okay$ = "NO"
IF eh% > 169 AND eh% < 212 AND ev% = 128 AND c6$ = "1" THEN okay$ = "NO"
IF eh% > 137 AND eh% < 180 AND ev% = 128 AND c5$ = "1" THEN okay$ = "NO"
IF eh% > 105 AND eh% < 148 AND ev% = 128 AND c4$ = "1" THEN okay$ = "NO"
IF eh% > 73 AND eh% < 116 AND ev% = 128 AND c3$ = "1" THEN okay$ = "NO"
IF eh% > 41 AND eh% < 84 AND ev% = 128 AND c2$ = "1" THEN okay$ = "NO"
IF eh% > 9 AND eh% < 52 AND ev% = 128 AND c1$ = "1" THEN okay$ = "NO"
IF eh% > 265 AND eh% < 308 AND ev% = 96 AND b9$ = "1" THEN okay$ = "NO"
IF eh% > 233 AND eh% < 276 AND ev% = 96 AND b8$ = "1" THEN okay$ = "NO"
IF eh% > 201 AND eh% < 244 AND ev% = 96 AND b7$ = "1" THEN okay$ = "NO"
IF eh% > 169 AND eh% < 212 AND ev% = 96 AND b6$ = "1" THEN okay$ = "NO"
IF eh% > 137 AND eh% < 180 AND ev% = 96 AND b5$ = "1" THEN okay$ = "NO"
IF eh% > 105 AND eh% < 148 AND ev% = 96 AND b4$ = "1" THEN okay$ = "NO"
IF eh% > 73 AND eh% < 116 AND ev% = 96 AND b3$ = "1" THEN okay$ = "NO"
IF eh% > 41 AND eh% < 84 AND ev% = 96 AND b2$ = "1" THEN okay$ = "NO"
IF eh% > 9 AND eh% < 52 AND ev% = 96 AND b1$ = "1" THEN okay$ = "NO"
IF eh% > 265 AND eh% < 308 AND ev% = 64 AND a9$ = "1" THEN okay$ = "NO"
IF ph% > 233 AND eh% < 276 AND ev% = 64 AND a8$ = "1" THEN okay$ = "NO"
IF eh% > 201 AND eh% < 244 AND ev% = 64 AND a7$ = "1" THEN okay$ = "NO"
IF eh% > 169 AND eh% < 212 AND ev% = 64 AND a6$ = "1" THEN okay$ = "NO"
IF eh% > 137 AND eh% < 180 AND ev% = 64 AND a5$ = "1" THEN okay$ = "NO"
IF eh% > 105 AND eh% < 148 AND ev% = 64 AND a4$ = "1" THEN okay$ = "NO"
IF eh% > 73 AND eh% < 116 AND ev% = 64 AND a3$ = "1" THEN okay$ = "NO"
IF eh% > 41 AND eh% < 84 AND ev% = 64 AND a2$ = "1" THEN okay$ = "NO"
IF eh% > 9 AND eh% < 52 AND ev% = 64 AND a1$ = "1" THEN okay$ = "NO"
IF eh% > 265 AND eh% < 308 AND ev% = 32 THEN okay$ = "NO"
IF eh% > 233 AND eh% < 276 AND ev% = 32 THEN okay$ = "NO"
IF eh% > 201 AND eh% < 244 AND ev% = 32 THEN okay$ = "NO"
IF eh% > 169 AND eh% < 212 AND ev% = 32 THEN okay$ = "NO"
IF eh% > 137 AND eh% < 180 AND ev% = 32 THEN okay$ = "NO"
IF eh% > 105 AND eh% < 148 AND ev% = 32 THEN okay$ = "NO"
IF eh% > 73 AND eh% < 116 AND ev% = 32 THEN okay$ = "NO"
IF eh% > 41 AND eh% < 84 AND ev% = 32 THEN okay$ = "NO"
IF eh% > 9 AND eh% < 52 AND ev% = 32 THEN okay$ = "NO"
ev% = oldev%
END SUB

SUB explosion (xh%, xv%, es%)
FOR y% = 0 TO es% STEP 1
IF bgc% <> 4 THEN CIRCLE (xh%, xv%), y%, 4
IF bgc% = 4 THEN CIRCLE (xh%, xv%), y%, 12
IF sounds$ = "YES" THEN SOUND (y% * 50) + 50, 1
IF sounds$ <> "YES" THEN delay .5
NEXT y%
FOR y% = es% TO 0 STEP -1
CIRCLE (xh%, xv%), y%, bgc%
IF sounds$ = "YES" THEN SOUND (y% * 50) + 50, 1
IF sounds$ <> "YES" THEN delay .5
NEXT y%
END SUB

SUB gameplay
IF olo$ = "NOPO" THEN EXIT SUB
LINE (25, 180)-(127, 190), 0, B
LINE (26, 181)-(126, 189), 2, BF
IF ndemo$ = "YES" THEN GOTO afterdo
DO
afterdo:
IF player$ = "SNAKE" THEN ammo% = 0
IF life% < 0 THEN CALL youlose
IF getout$ = "YES" THEN EXIT SUB
IF dst% > 0 THEN dst% = dst% - 1
1135
LINE (126 - (100 - (life% / diff%)), 181)-(126, 189), 4, BF
IF enemy$ = "SNAKE" THEN CALL drawsnake
CALL drawbear
IF exitsubs$ = "YES" THEN EXIT SUB
IF pv% = 192 AND enemy2$ <> "FALLSCREEN" THEN go$ = "YES": CALL youfell: EXIT SUB'go$="YES"?

IF pv% = 192 AND enemy2$ = "FALLSCREEN" THEN EXIT SUB
IF justfell$ = "YES" THEN af% = 1
bcount% = bcount% + 1
IF dir$ = "STOPPED" THEN af% = 1
CALL drawplayer                                                   'blink
IF dir$ = "STOPPED" AND bcount% = 25 AND player$ <> "SNAKE" THEN PSET (ph%, pv% - 15), 15: PSET (ph% + 2, pv% - 15), 15: delay .5: bcount% = 0
IF justfell$ = "YES" THEN GOTO 11
IF B$ = "YES" THEN
PSET (B%, pv% - 9), bgc%
'duh' THEN PSET (B%, pv% - 7), bgc%
IF gun% = 3 THEN PSET (B%, pv% - 7), bgc%: PSET (B%, pv% - 5), bgc%
oldoldph% = ph%
FOR bb% = 0 TO 11
oldph% = ph%
ph% = B%
okay$ = "YES"
CALL checkright
IF okay$ = "YES" THEN B% = B% + 1
IF okay$ = "NO" THEN
B$ = "NO": PSET (B%, pv% - 9), bgc%: ph% = oldoldph%: B% = -10
'duh' THEN PSET (B%, pv% - 7), bgc%
IF gun% = 3 THEN PSET (B%, pv% - 7), bgc%: PSET (B%, pv% - 5), bgc%
IF stage$ = "9" THEN
123
END IF
GOTO 16
END IF
ph% = oldph%
NEXT bb%
PSET (B%, pv% - 9), 0
'duh' THEN PSET (B%, pv% - 7), 0
IF gun% = 3 THEN PSET (B%, pv% - 7), 0: PSET (B%, pv% - 5), 0
END IF
IF B$ = "YES" AND B% > 285 THEN
'duh' THEN PSET (B%, pv% - 7), bgc%
IF gun% = 3 THEN PSET (B%, pv% - 7), bgc%: PSET (B%, pv% - 5), bgc%
B$ = "NO": PSET (B%, pv% - 9), bgc%: B% = -10
END IF



IF ndemo$ = "YES" THEN GOTO afterkeypresses
SELECT CASE INKEY$
CASE IS = " "
IF player$ = "SNAKE" THEN ammo% = 0
IF ammo% = 0 THEN GOTO 16
IF ph% > 275 THEN GOTO 16
IF B$ = "NO" THEN
oldoldph% = ph%
FOR bb% = 0 TO 10
ph% = oldoldph% + bb%
okay$ = "YES"
CALL checkright
IF okay$ = "NO" THEN ph% = oldoldph%: GOTO 16
NEXT bb%
17 ph% = oldoldph%
LINE (ph% + 3, pv% - 10)-(ph% + 5, pv% - 10), 0
delay 2
IF sounds$ = "YES" THEN SOUND 50, 2
LINE (ph% + 3, pv% - 10)-(ph% + 5, pv% - 10), bgc%
IF ammo% < 3 THEN ammo% = 0: GOTO shkip
ammo% = ammo% - 3
shkip:
B$ = "YES": B% = ph% + 5
END IF
CASE IS = "+"
IF pluskey$ = "YES" THEN EXIT SUB
CASE IS = CHR$(27)
lives% = 0: CALL youlose
16 CASE IS = CHR$(0) + "H"
IF dir$ = "STOPPED" THEN CALL jumpstraightup: GOTO 11
IF dir$ = "RIGHT" THEN CALL jumpacross: GOTO 11
IF dir$ = "LEFT" THEN CALL jumpbackwards: GOTO 11
11 CASE IS = CHR$(0) + "P"
IF dir$ <> "STOPPED" THEN LINE (ph% - 5, pv% - 19)-(ph% + 5, pv% + 4), bgc%, BF
dir$ = "STOPPED"
bcount% = 0
CASE IS = CHR$(0) + "M"
CALL checkright
IF okay$ = "YES" THEN dir$ = "RIGHT": okay$ = "NO"
CASE IS = CHR$(0) + "K"
CALL checkleft
IF okay$ = "YES" THEN dir$ = "LEFT": okay$ = "NO"
END SELECT
afterkeypresses:

'bnm

14 IF fallingdown$ = "YES" THEN CALL checkdown
IF olo$ = "YES" THEN EXIT SUB
IF justfell$ = "YES" THEN justfell$ = "NO": GOTO 13
CALL beardata
IF enemy$ = "SNAKE" THEN CALL snakedata
13 oldpv% = pv%
pv% = pv% + 64
okay$ = "YES"
CALL checkup
pv% = oldpv%
IF okay$ = "YES" THEN
IF itsfallin$ = "NO" THEN LINE (ph% - 7, pv% - 19)-(ph% + 7, pv% + 4), bgc%, BF
itsfallin$ = "YES"
pv% = oldpv%: GOSUB falldown
GOTO skipitsfallinchange
END IF
itsfallin$ = "NO"
skipitsfallinchange:

'jkl

IF dir$ = "LEFT" THEN LINE (ph% - 5, pv% - 19)-(ph% + 8, pv% + 4), bgc%, BF
IF dir$ = "RIGHT" THEN LINE (ph% - 7, pv% - 19)-(ph% + 5, pv% + 4), bgc%, BF
'iF dir$ = "STOPPED" THEN LINE (ph% - 5, pv% - 19)-(ph% + 5, pv% + 4), bgc%, BF
IF ndemo$ = "YES" THEN EXIT SUB
12 IF ndemo$ = "YES" THEN EXIT SUB
IF B$ = "YES" THEN
IF B% > (xbh% - 33) AND B% < (xbh% - 22) AND pv% = xbv% THEN
CALL drawplayer
PSET (B%, pv% - 9), bgc%
explosion xbh% - 2, xbv% - 12, 14
LINE (xbh% + 12, xbv% + 2)-(xbh% - 16, xbv% - 26), bgc%, BF
xbh% = 400: xbv% = 226
B% = 400: B$ = "NO"
END IF
END IF
LOOP


falldown:
B$ = "NO": PSET (B%, pv% - 9), bgc%
IF gun% = 2 THEN PSET (B%, pv% - 7), bgc%
IF gun% = 3 THEN PSET (B%, pv% - 7), bgc%: PSET (B%, pv% - 5), bgc%
ts% = 0
fellfrom% = pv%
DO
IF enemy$ = "SNAKE" THEN CALL drawsnake
CALL drawbear
af% = 1
CALL drawplayer
SELECT CASE INKEY$
CASE IS = ""
CASE ELSE
END SELECT
'LINE (ph% - 5, pv% - 19)-(ph% + 5, pv% + 4), bgc%, BF
IF ts% < 16 THEN ts% = ts% + 1: pv% = pv% + 2

IF NOT (ts% < 16) THEN justfell$ = "YES":  EXIT DO'GOTO 12
falling$ = "YES"
CALL beardata
IF enemy$ = "SNAKE" THEN CALL snakedata
falling$ = "NO"
LINE (ph% - 5, pv% - 21)-(ph% + 5, pv% + 2), bgc%, BF
IF dir$ = "LEFT" THEN
oldpv% = pv%
pv% = fellfrom% + 32
CALL checkleft
pv% = oldpv%
ok$ = okay$
oldpv% = pv%
pv% = fellfrom%
CALL checkleft
pv% = oldpv%
IF okay$ = "YES" AND ok$ = "YES" THEN
ph% = ph% - 1
IF dir$ = "LEFT" THEN LINE (ph% - 5, pv% - 19)-(ph% + 6, pv% + 4), bgc%, BF
IF dir$ <> "LEFT" THEN LINE (ph% - 5, pv% - 19)-(ph% + 5, pv% + 4), bgc%, BF
END IF
END IF
IF dir$ = "RIGHT" THEN
oldpv% = pv%
pv% = fellfrom% + 32
CALL checkright
pv% = oldpv%
ok$ = okay$
oldpv% = pv%
pv% = fellfrom%
CALL checkright
pv% = oldpv%
IF okay$ = "YES" AND ok$ = "YES" THEN
ph% = ph% + 1
IF dir$ = "RIGHT" THEN LINE (ph% - 5, pv% - 19)-(ph% + 5, pv% + 4), bgc%, BF
IF dir$ <> "RIGHT" THEN LINE (ph% - 5, pv% - 19)-(ph% + 5, pv% + 4), bgc%, BF
END IF
END IF
LOOP
LINE (ph% - 5, pv% - 21)-(ph% + 5, pv% + 2), bgc%, BF
CALL drawplayer
GOTO 12
RETURN
lhitme:
IF dir$ = "LEFT" THEN LINE (ph% - 5, pv% - 20)-(ph% + 6, pv% + 4), bgc%, BF
IF dir$ <> "LEFT" THEN LINE (ph% - 5, pv% - 20)-(ph% + 5, pv% + 4), bgc%, BF
IF sounds$ = "YES" THEN SOUND 100, 1: SOUND 50, 1
FOR mm% = 1 TO 21
CALL checkleft
IF okay$ = "YES" THEN
ph% = ph% - 1
IF dir$ = "LEFT" THEN LINE (ph% - 5, pv% - 19)-(ph% + 6, pv% + 4), bgc%, BF
IF dir$ <> "LEFT" THEN LINE (ph% - 5, pv% - 19)-(ph% + 5, pv% + 4), bgc%, BF
END IF
NEXT mm%
IF okay$ = "YES" THEN life% = life% - 20
IF okay$ = "NO" THEN life% = life% - 40
dir$ = "STOPPED"
RETURN
END SUB

SUB intro
CLS : SCREEN 13: COLOR 15
LOCATE 13, 20: PRINT "S+G SOFTWARE"
LOCATE 14, 20: PRINT "PRESENTS..."
colo% = 1
a% = 50: B% = 100: c% = 100: d% = 100
120 DO
y% = y% + 1
IF y% = 100 THEN F% = 1
FOR ry% = 1 TO 42
LINE (a%, B%)-(c%, d%), colo%
FOR ddd% = 1 TO 100: NEXT ddd%
SELECT CASE INKEY$
CASE IS <> ""
IF y% > 10 THEN F% = 1
END SELECT
a% = a% + 1
B% = B% - 1
c% = c% - 1
d% = d% + 1
NEXT ry%
FOR ry% = 1 TO 42
FOR ddd% = 1 TO 100: NEXT ddd%
SELECT CASE INKEY$
CASE IS <> ""
IF y% > 10 THEN F% = 1
END SELECT
IF F% = 1 THEN e% = e% + 1
IF e% = 50 THEN e% = 0: dog% = dog% + 1: EXIT DO
LINE (a%, B%)-(c%, d%), colo%
a% = a% + 1
B% = B% + 1
c% = c% - 1
d% = d% - 1
NEXT ry%
FOR ry% = 1 TO 42
LINE (a%, B%)-(c%, d%), colo%
IF colo% = 16 THEN EXIT DO
FOR ddd% = 1 TO 100: NEXT ddd%
SELECT CASE INKEY$
CASE IS <> ""
IF y% > 10 THEN F% = 1
END SELECT
a% = a% - 1
B% = B% + 1
c% = c% + 1
d% = d% - 1
NEXT ry%
FOR ry% = 1 TO 42
LINE (a%, B%)-(c%, d%), colo%
FOR ddd% = 1 TO 100: NEXT ddd%
SELECT CASE INKEY$
CASE IS <> ""
IF y% > 10 THEN F% = 1
END SELECT
a% = a% - 1
B% = B% - 1
c% = c% + 1
d% = d% + 1
NEXT ry%
colo% = colo% + 1
IF colo% = 15 THEN colo% = 1
LOOP
IF dog% > 3 THEN GOTO 121
ef% = 1: GOTO 120
121
FOR ty% = 1 TO 100
CIRCLE (75, 100), ty%, ty% + 64
FOR dll% = 1 TO 200: NEXT dll%
NEXT ty%
FOR ty% = 1 TO 50
CIRCLE (150, 80), ty%, ty% + 64
FOR dll% = 1 TO 200: NEXT dll%
NEXT ty%
FOR ty% = 1 TO 50
CIRCLE (250, 140), ty%, ty% + 64
FOR dll% = 1 TO 200: NEXT dll%
NEXT ty%
LINE (0, 0)-(320, 200), 15, BF
FOR dll% = 1 TO 500: NEXT dll%
CLS
SHELL "z bynoah.gif /q /p"
IF canhavemusic$ = "YES" THEN
Channel1$ = "P(1) AABBCBABCDEF"
CALL Translate(Channel1$, 1)
LoadIns "kewlbass.ins"
SetIns 1
a! = TIMER
DO
PlayMusic
IF TIMER > a! + 4.5 THEN EXIT DO
LOOP
ELSE
delay 20
END IF
COLOR 15
CLS
SHELL "z snake.gif /q /p"
IF canhavemusic$ = "YES" THEN
Channel1$ = "P(2) BBCCDC"
CALL Translate(Channel1$, 2)
Channel2$ = "P(1) AABBCBABCDEF"
CALL Translate(Channel2$, 2)
Channel3$ = "T(1) AF"
CALL Translate(Channel3$, 3)
LoadIns "trumpet.ins"
SetIns 1
LoadIns "trumpet.ins"
SetIns 2
LoadIns "trumpet.ins"
SetIns 3
a! = TIMER
DO
PlayMusic
IF TIMER > a! + 4.5 THEN EXIT DO
LOOP
closechannels
delay 5
ELSE
delay 30
END IF
COLOR 15
END SUB

SUB jumpacross
'duh' THEN PSET (B%, pv% - 7), bgc%
IF gun% = 3 THEN PSET (B%, pv% - 7), bgc%: PSET (B%, pv% - 5), bgc%
B$ = "NO": PSET (B%, pv% - 9), bgc%: B% = -10
ph% = ph% - 1
liftoff% = pv%
okay$ = "YES"
CALL checkup
IF okay$ <> "YES" THEN EXIT SUB
yupup$ = "YES"
ts% = 0
yaba$ = "YES"
DO
IF enemy$ = "SNAKE" THEN CALL drawsnake
CALL drawbear
af% = 3
CALL drawplayer
SELECT CASE INKEY$
CASE IS = ""
CASE ELSE
END SELECT
IF ts% < 16 THEN ts% = ts% + 1: pv% = pv% - 2: ph% = ph% + 1
oldpv% = pv%
pv% = liftoff% - 32
okay$ = "YES"
CALL checkright
IF okay$ <> "YES" THEN sd$ = "YES": yaba$ = "NO": pv% = oldpv%: EXIT DO
pv% = oldpv%
IF NOT (ts% < 16) THEN yaba$ = "NO": EXIT DO
oldpv% = pv%
pv% = liftoff%
okay$ = "YES"
CALL checkright
IF okay$ <> "YES" THEN sd$ = "YES": pv% = oldpv%: yaba$ = "NO": EXIT DO
pv% = oldpv%
oldpv% = pv%
pv% = liftoff%
okay$ = "YES"
CALL checkup
IF okay$ <> "YES" THEN sd$ = "YES": yaba$ = "NO": pv% = oldpv%: EXIT DO
pv% = oldpv%
IF NOT (ts% < 16) THEN yaba$ = "NO": EXIT DO
sidego$ = "YES"
IF enemy$ = "SNAKE" THEN CALL snakedata
IF enemy2$ = "CRUSHER" THEN GOSUB crushdata11
IF enemy3$ = "CRUSHER" THEN GOSUB crush3data11
sidego$ = "NO"
LINE (ph% - 6, pv% - 17)-(ph% + 4, pv% + 6), bgc%, BF
LOOP
yaba$ = "NO"
ts% = 0
LINE (ph% - 6, pv% - 17)-(ph% + 4, pv% + 6), bgc%, BF '9!
DO
IF enemy$ = "SNAKE" THEN CALL drawsnake
IF sd$ = "YES" THEN EXIT DO
af% = 3
CALL drawplayer
SELECT CASE INKEY$
CASE IS = ""
CASE ELSE
END SELECT
'LINE (ph% - 5, pv% - 19)-(ph% + 5, pv% + 4), bgc%, BF
IF ts% < 16 THEN ts% = ts% + 1: ph% = ph% + 1
okay$ = "YES"
CALL checkright
IF okay$ <> "YES" THEN sd$ = "YES": EXIT DO
IF NOT (ts% < 16) THEN EXIT DO
sidego$ = "YES"
IF enemy$ = "SNAKE" THEN CALL snakedata
IF enemy2$ = "CRUSHER" THEN GOSUB crushdata11
IF enemy3$ = "CRUSHER" THEN GOSUB crush3data11
sidego$ = "NO"
LINE (ph% - 6, pv% - 19)-(ph% + 4, pv% + 4), bgc%, BF
LOOP
oldpv% = pv%
oldph% = ph%
okay$ = "YES"
ph% = ph% + 1
pv% = pv% + 64
CALL checkup
IF okay$ <> "YES" THEN
pv% = oldpv%: yupup$ = "NO"
LINE (ph% - 6, pv% - 20)-(ph% + 5, pv% + 4), bgc%, BF '9!
CALL drawplayer
EXIT SUB
END IF
okay$ = "NO"
pv% = oldpv%
ph% = oldph%
ts% = 0
DO
IF enemy$ = "SNAKE" THEN CALL drawsnake
af% = 3
CALL drawplayer
SELECT CASE INKEY$
CASE IS = ""
CASE ELSE
END SELECT
IF ts% < 16 THEN
ts% = ts% + 1: pv% = pv% + 2
IF sd$ <> "YES" THEN ph% = ph% + 1
END IF
IF pv% = liftoff% THEN EXIT DO
oldpv% = pv%
oldph% = ph%
pv% = liftoff%
ph% = ph% + 1
okay$ = "YES"
CALL checkup
IF okay$ <> "YES" THEN sd$ = "YES"': pv% = oldpv%: EXIT DO
pv% = oldpv%
ph% = oldph%
oldpv% = pv%
pv% = liftoff%
okay$ = "YES"
CALL checkright
IF okay$ <> "YES" THEN sd$ = "YES"': pv% = oldpv%: EXIT DO
pv% = oldpv%
IF NOT (ts% < 16) THEN EXIT DO
sidego$ = "YES"
IF enemy$ = "SNAKE" THEN CALL snakedata
IF enemy2$ = "CRUSHER" THEN GOSUB crushdata11
IF enemy3$ = "CRUSHER" THEN GOSUB crush3data11
sidego$ = "NO"
IF sd$ <> "YES" THEN LINE (ph% - 6, pv% - 21)-(ph% + 4, pv% + 2), bgc%, BF
IF sd$ = "YES" THEN LINE (ph% - 6, pv% - 21)-(ph% + 5, pv% + 2), bgc%, BF
LOOP
sd$ = "NO"
yupup$ = "NO"
LINE (ph% - 5, pv% - 20)-(ph% + 5, pv% + 4), bgc%, BF '9!
CALL drawplayer
EXIT SUB

crushdata11:
IF ph% > eh2% - 23 AND ph% < eh2% + 21 AND crush% > 12 THEN
IF sounds$ = "YES" THEN SOUND 50, 3
LINE (ph% - 5, pv% - 20)-(ph% + 6, pv% + 4), bgc%, BF
life% = life% - 25: ph% = ph% - 48
END IF
IF ctt% = 0 OR ctt% = 1 THEN ctt% = ctt% + 1: GOTO 6911
IF ctt% = 2 THEN ctt% = 0
LINE (eh2% - 18, ev2% - 28)-(eh2% + 15, ev2% - 28 + crush%), bgc%, BF
IF crush% > 31 AND crushnow$ = "YES" THEN crushnow$ = "NO": GOTO 6811
IF crush% = 0 AND crushnow$ = "NO" THEN crushnow$ = "YES"
6811 IF crush% < 32 AND crushnow$ = "YES" THEN crush% = crush% + 1
IF crush% > 0 AND crushnow$ = "NO" THEN crush% = crush% - 1
LINE (eh2% - 18, ev2% - 28)-(eh2% + 15, ev2% - 28 + crush%), 6, BF
6911 RETURN
crush3data11:
IF ph% > eh3% - 23 AND ph% < eh3% + 21 AND crush3% > 12 THEN
IF sounds$ = "YES" THEN SOUND 50, 3
LINE (ph% - 5, pv% - 20)-(ph% + 6, pv% + 4), bgc%, BF
life% = life% - 25: ph% = ph% - 48
END IF
IF ctt3% = 0 OR ctt3% = 1 THEN ctt3% = ctt3% + 1: GOTO 69311
IF ctt3% = 2 THEN ctt3% = 0
LINE (eh3% - 17, ev3% - 28)-(eh3% + 14, ev3% - 28 + crush3%), bgc%, BF
IF crush3% > 31 AND crushnow3$ = "YES" THEN crushnow3$ = "NO": GOTO 68311
'duh' crushnow3$ = "NO" THEN crushnow3$ = "YES"
68311 IF crush3% < 32 AND crushnow3$ = "YES" THEN crush3% = crush3% + 1
IF crush3% > 0 AND crushnow3$ = "NO" THEN crush3% = crush3% - 1
LINE (eh3% - 17, ev3% - 28)-(eh3% + 14, ev3% - 28 + crush3%), 6, BF
69311 RETURN
END SUB

SUB jumpbackwards
'duh' THEN PSET (B%, pv% - 7), bgc%
IF gun% = 3 THEN PSET (B%, pv% - 7), bgc%: PSET (B%, pv% - 5), bgc%
B$ = "NO": PSET (B%, pv% - 9), bgc%: B% = -10
CALL checkleft
IF okay$ <> "YES" THEN EXIT SUB
ph% = ph% - 1
CALL checkleft
IF okay$ <> "YES" THEN EXIT SUB
liftoff% = pv%
okay$ = "YES"
CALL checkup
IF okay$ <> "YES" THEN EXIT SUB
yupup$ = "YES"
ts% = 0
yaba$ = "YES"
LINE (ph% - 5, pv% - 20)-(ph% + 7, pv% + 4), bgc%, BF '9!
DO
IF enemy$ = "SNAKE" THEN CALL drawsnake
CALL drawbear
af% = 3
CALL drawplayer
SELECT CASE INKEY$
CASE IS = ""
CASE ELSE
END SELECT
IF ts% < 16 THEN ts% = ts% + 1: pv% = pv% - 2: ph% = ph% - 1
oldpv% = pv%
pv% = liftoff% - 32
okay$ = "YES"
CALL checkleft
IF okay$ <> "YES" THEN sd$ = "YES": yaba$ = "NO": pv% = oldpv%: EXIT DO
pv% = oldpv%
IF NOT (ts% < 16) THEN yaba$ = "NO": EXIT DO
oldpv% = pv%
pv% = liftoff%
okay$ = "YES"
CALL checkleft
IF okay$ <> "YES" THEN sd$ = "YES": pv% = oldpv%: yaba$ = "NO": EXIT DO
pv% = oldpv%
oldpv% = pv%
pv% = liftoff%
okay$ = "YES"
CALL checkup
IF okay$ <> "YES" THEN sd$ = "YES": yaba$ = "NO": pv% = oldpv%: EXIT DO
pv% = oldpv%
IF NOT (ts% < 16) THEN yaba$ = "NO": EXIT DO
sidego$ = "YES"
IF enemy$ = "SNAKE" THEN CALL snakedata
IF enemy2$ = "CRUSHER" THEN GOSUB crushdata11b
IF enemy3$ = "CRUSHER" THEN GOSUB crush3data11b
sidego$ = "NO"
LINE (ph% - 5, pv% - 17)-(ph% + 6, pv% + 6), bgc%, BF
LOOP
yaba$ = "NO"
ts% = 0
LINE (ph% - 5, pv% - 17)-(ph% + 6, pv% + 6), bgc%, BF '9!
DO
IF enemy$ = "SNAKE" THEN CALL drawsnake
IF sd$ = "YES" THEN EXIT DO
af% = 3
CALL drawplayer
SELECT CASE INKEY$
CASE IS = ""
CASE ELSE
END SELECT
'LINE (ph% - 5, pv% - 19)-(ph% + 6, pv% + 4), bgc%, BF
IF ts% < 16 THEN ts% = ts% + 1: ph% = ph% - 1
okay$ = "YES"
CALL checkleft
IF okay$ <> "YES" THEN sd$ = "YES": EXIT DO
IF NOT (ts% < 16) THEN EXIT DO
sidego$ = "YES"
IF enemy$ = "SNAKE" THEN CALL snakedata
IF enemy2$ = "CRUSHER" THEN GOSUB crushdata11b
IF enemy3$ = "CRUSHER" THEN GOSUB crush3data11b
sidego$ = "NO"
LINE (ph% - 5, pv% - 19)-(ph% + 6, pv% + 4), bgc%, BF
LOOP
oldpv% = pv%
oldph% = ph%
okay$ = "YES"
ph% = ph% - 1
pv% = pv% + 64
CALL checkup
IF okay$ <> "YES" THEN
pv% = oldpv%: yupup$ = "NO"
LINE (ph% - 5, pv% - 20)-(ph% + 7, pv% + 4), bgc%, BF '9!
CALL drawplayer
EXIT SUB
END IF
okay$ = "NO"
pv% = oldpv%
ph% = oldph%
ts% = 0
LINE (ph% - 5, pv% - 20)-(ph% + 7, pv% + 4), bgc%, BF '9!
DO
IF enemy$ = "SNAKE" THEN CALL drawsnake
af% = 3
CALL drawplayer
SELECT CASE INKEY$
CASE IS = ""
CASE ELSE
END SELECT
IF ts% < 16 THEN
ts% = ts% + 1: pv% = pv% + 2
IF sd$ <> "YES" THEN ph% = ph% - 1
END IF
IF pv% = liftoff% THEN EXIT DO
oldpv% = pv%
oldph% = ph%
pv% = liftoff%
ph% = ph% - 1
okay$ = "YES"
CALL checkup
IF okay$ <> "YES" THEN sd$ = "YES"': pv% = oldpv%: EXIT DO
pv% = oldpv%
ph% = oldph%
oldpv% = pv%
pv% = liftoff%
okay$ = "YES"
CALL checkleft
IF okay$ <> "YES" THEN sd$ = "YES"': pv% = oldpv%: EXIT DO
pv% = oldpv%
IF NOT (ts% < 16) THEN EXIT DO
sidego$ = "YES"
IF enemy$ = "SNAKE" THEN CALL snakedata
IF enemy2$ = "CRUSHER" THEN GOSUB crushdata11b
IF enemy3$ = "CRUSHER" THEN GOSUB crush3data11b
sidego$ = "NO"
IF sd$ <> "YES" THEN LINE (ph% - 5, pv% - 21)-(ph% + 6, pv% + 2), bgc%, BF
IF sd$ = "YES" THEN LINE (ph% - 5, pv% - 21)-(ph% + 6, pv% + 2), bgc%, BF
LOOP
sd$ = "NO"
yupup$ = "NO"
LINE (ph% - 5, pv% - 20)-(ph% + 6, pv% + 4), bgc%, BF '9!
CALL drawplayer
EXIT SUB

crushdata11b:
IF ph% > eh2% - 23 AND ph% < eh2% + 21 AND crush% > 12 THEN
IF sounds$ = "YES" THEN SOUND 50, 3
LINE (ph% - 5, pv% - 20)-(ph% + 6, pv% + 4), bgc%, BF
life% = life% - 25: ph% = ph% - 48
END IF
IF ctt% = 0 OR ctt% = 1 THEN ctt% = ctt% + 1: GOTO 69112
IF ctt% = 2 THEN ctt% = 0
LINE (eh2% - 18, ev2% - 28)-(eh2% + 15, ev2% - 28 + crush%), bgc%, BF
IF crush% > 31 AND crushnow$ = "YES" THEN crushnow$ = "NO": GOTO 68112
IF crush% = 0 AND crushnow$ = "NO" THEN crushnow$ = "YES"
68112 IF crush% < 32 AND crushnow$ = "YES" THEN crush% = crush% + 1
IF crush% > 0 AND crushnow$ = "NO" THEN crush% = crush% - 1
LINE (eh2% - 18, ev2% - 28)-(eh2% + 15, ev2% - 28 + crush%), 6, BF
69112 RETURN
crush3data11b:
IF ph% > eh3% - 23 AND ph% < eh3% + 21 AND crush3% > 12 THEN
IF sounds$ = "YES" THEN SOUND 50, 3
LINE (ph% - 5, pv% - 20)-(ph% + 6, pv% + 4), bgc%, BF
life% = life% - 25: ph% = ph% - 48
END IF
IF ctt3% = 0 OR ctt3% = 1 THEN ctt3% = ctt3% + 1: GOTO 693112
IF ctt3% = 2 THEN ctt3% = 0
LINE (eh3% - 17, ev3% - 28)-(eh3% + 14, ev3% - 28 + crush3%), bgc%, BF
IF crush3% > 31 AND crushnow3$ = "YES" THEN crushnow3$ = "NO": GOTO 683112
'duh' crushnow3$ = "NO" THEN crushnow3$ = "YES"
683112 IF crush3% < 32 AND crushnow3$ = "YES" THEN crush3% = crush3% + 1
IF crush3% > 0 AND crushnow3$ = "NO" THEN crush3% = crush3% - 1
LINE (eh3% - 17, ev3% - 28)-(eh3% + 14, ev3% - 28 + crush3%), 6, BF
693112 RETURN
END SUB

SUB jumpstraightup
jumpingup$ = "YES"
IF enemy$ = "DOG" AND ph% + 50 > eh% AND ph% < eh% THEN EXIT SUB
'duh' THEN PSET (B%, pv% - 7), bgc%
IF gun% = 3 THEN PSET (B%, pv% - 7), bgc%: PSET (B%, pv% - 5), bgc%
B$ = "NO": PSET (B%, pv% - 9), bgc%: B% = -10
CALL checkup
IF okay$ <> "YES" THEN jumpingup$ = "NO": EXIT SUB
ts% = 0
DO
IF enemy$ = "SNAKE" THEN CALL drawsnake
af% = 1
CALL drawplayer
SELECT CASE INKEY$
CASE IS = ""
CASE ELSE
END SELECT
IF ts% < 16 THEN ts% = ts% + 1: pv% = pv% - 2
IF NOT (ts% < 16) THEN EXIT DO
sidego$ = "YES"
IF enemy$ = "SNAKE" THEN CALL snakedata
IF enemy2$ = "CRUSHER" THEN GOSUB crushdata22
IF enemy3$ = "CRUSHER" THEN GOSUB crush3data22
sidego$ = "NO"
LINE (ph% - 5, pv% - 21)-(ph% + 5, pv% + 6), bgc%, BF
LOOP
LINE (ph% - 5, pv% - 21)-(ph% + 5, pv% + 6), bgc%, BF
ts% = 0
DO
IF enemy$ = "SNAKE" THEN CALL drawsnake
af% = 1
CALL drawplayer
SELECT CASE INKEY$
CASE IS = ""
CASE ELSE
END SELECT
IF ts% < 16 THEN ts% = ts% + 1: pv% = pv% + 2
IF NOT (ts% < 16) THEN EXIT DO
sidego$ = "YES"
IF enemy$ = "SNAKE" THEN CALL snakedata
IF enemy2$ = "CRUSHER" THEN GOSUB crushdata22
IF enemy3$ = "CRUSHER" THEN GOSUB crush3data22
sidego$ = "NO"
LINE (ph% - 5, pv% - 21)-(ph% + 5, pv% + 2), bgc%, BF
LOOP
LINE (ph% - 5, pv% - 21)-(ph% + 5, pv% + 2), bgc%, BF
CALL drawplayer
jumpingup$ = "NO"
EXIT SUB

crushdata22:
IF ph% > eh2% - 23 AND ph% < eh2% + 21 AND crush% > 12 THEN
IF sounds$ = "YES" THEN SOUND 50, 3
LINE (ph% - 5, pv% - 20)-(ph% + 6, pv% + 4), bgc%, BF
life% = life% - 25: ph% = ph% - 48
END IF
IF ctt% = 0 OR ctt% = 1 THEN ctt% = ctt% + 1: GOTO 6922
IF ctt% = 2 THEN ctt% = 0
LINE (eh2% - 18, ev2% - 28)-(eh2% + 15, ev2% - 28 + crush%), bgc%, BF
IF crush% > 31 AND crushnow$ = "YES" THEN crushnow$ = "NO": GOTO 6822
IF crush% = 0 AND crushnow$ = "NO" THEN crushnow$ = "YES"
6822 IF crush% < 32 AND crushnow$ = "YES" THEN crush% = crush% + 1
IF crush% > 0 AND crushnow$ = "NO" THEN crush% = crush% - 1
LINE (eh2% - 18, ev2% - 28)-(eh2% + 15, ev2% - 28 + crush%), 6, BF
6922 RETURN
crush3data22:
IF ph% > eh3% - 23 AND ph% < eh3% + 21 AND crush3% > 12 THEN
IF sounds$ = "YES" THEN SOUND 50, 3
LINE (ph% - 5, pv% - 20)-(ph% + 6, pv% + 4), bgc%, BF
life% = life% - 25: ph% = ph% - 48
END IF
IF ctt3% = 0 OR ctt3% = 1 THEN ctt3% = ctt3% + 1: GOTO 69322
IF ctt3% = 2 THEN ctt3% = 0
LINE (eh3% - 17, ev3% - 28)-(eh3% + 14, ev3% - 28 + crush3%), bgc%, BF
IF crush3% > 31 AND crushnow3$ = "YES" THEN crushnow3$ = "NO": GOTO 68322
'duh' crushnow3$ = "NO" THEN crushnow3$ = "YES"
68322 IF crush3% < 32 AND crushnow3$ = "YES" THEN crush3% = crush3% + 1
IF crush3% > 0 AND crushnow3$ = "NO" THEN crush3% = crush3% - 1
LINE (eh3% - 17, ev3% - 28)-(eh3% + 14, ev3% - 28 + crush3%), 6, BF
69322 RETURN

END SUB

SUB LoadIns (filename$)
OPEN filename$ FOR BINARY AS #1
 IF LOF(1) < 2 THEN
  BEEP
  CLOSE
  KILL filename$
  EXIT SUB
 END IF
 GET #1, , CurrentIns
CLOSE #1
END SUB

SUB menu
CLS : SCREEN 9
COLOR 15
CLS : SCREEN 13
cv% = 6
mainmenu:
LINE (1, 1)-(320, 200), 8, BF
LOCATE 3, 15: PRINT "MAIN MENU:"
LOCATE 8, 15: PRINT "START"
LOCATE 10, 15: PRINT "OPTIONS"
LOCATE 12, 15: PRINT "HELP"
LOCATE 14, 15: PRINT "EXIT"
LOCATE 22, 2: PRINT "Use the arrow keys to move the cursor,"
LOCATE 23, 2: PRINT " and press enter to choose something. "
DO
LOCATE cv%, 13: PRINT CHR$(1)
SELECT CASE UCASE$(INKEY$)
CASE IS = CHR$(0) + "P"
IF cv% < 14 THEN cv% = cv% + 2: GOTO mainmenu
CASE IS = CHR$(0) + "H"
IF cv% > 8 THEN cv% = cv% - 2: GOTO mainmenu
CASE IS = CHR$(13)
EXIT DO
CASE IS = CHR$(27)
CLS : COLOR 0: CLS : SYSTEM'                MAKE THIS CALL YOULOSE
END SELECT
LOOP
IF cv% = 6 THEN GOTO mainmenu
IF cv% = 8 THEN GOTO newgame
IF cv% = 10 THEN cv% = 8: GOTO options
IF cv% = 12 THEN GOTO help
IF cv% = 14 THEN
CLS : COLOR 0: CLS : SYSTEM'                MAKE THIS CALL YOULOSE
END IF
CLS : SCREEN 13
cv% = 8
options:
IF diff% = 1 THEN skill$ = "HARD"
IF diff% = 2 THEN skill$ = "MEDIUM"
IF diff% = 3 THEN skill$ = "EASY"
LINE (1, 1)-(320, 200), 8, BF
LOCATE 3, 15: PRINT "OPTIONS:"
LOCATE 8, 15: PRINT "SOUNDS: " + sounds$
LOCATE 10, 15: PRINT "MUSIC: " + music$
LOCATE 12, 15: PRINT "SKILL: " + skill$
LOCATE 14, 15: PRINT "DONE!"
LOCATE 22, 2: PRINT "Use the arrow keys to move the cursor,"
LOCATE 23, 2: PRINT " and press enter to choose something. "
DO
LOCATE cv%, 13: PRINT CHR$(1)
SELECT CASE UCASE$(INKEY$)
CASE IS = "$"
IF cv% = 14 THEN cv% = 8: GOTO cheat
CASE IS = CHR$(0) + "P"
IF cv% < 14 THEN cv% = cv% + 2: GOTO options
CASE IS = CHR$(0) + "H"
IF cv% > 8 THEN cv% = cv% - 2: GOTO options
CASE IS = CHR$(13)
EXIT DO
CASE IS = CHR$(27)
cv% = 8: GOTO mainmenu
END SELECT
LOOP
IF cv% = 8 THEN
IF sounds$ = "YES" THEN sounds$ = "NO": GOTO options
IF sounds$ = "NO" THEN sounds$ = "YES": GOTO options
END IF
IF cv% = 10 THEN
IF canhavemusic$ = "NO" THEN GOTO options
IF music$ = "YES" THEN music$ = "NO": GOTO options
IF music$ = "NO" THEN music$ = "YES": GOTO options
END IF
IF cv% = 12 THEN
IF diff% = 1 THEN diff% = 2: GOTO options
IF diff% = 2 THEN diff% = 3: GOTO options
IF diff% = 3 THEN diff% = 1: GOTO options
END IF
IF cv% = 14 THEN cv% = 8: GOTO mainmenu
cheat:
'If you are reading this then you are a cheater.
'That's fine by me, cause there's nothing I can do about it.
LINE (1, 1)-(320, 200), 8, BF
LOCATE 3, 15: PRINT "CHEATS:"
LOCATE 8, 15: PRINT "PLAYER: " + player$
LOCATE 10, 15: PRINT "BLOODBATH: " + bloodbath$
LOCATE 12, 15: PRINT "PLUS KEY: " + pluskey$
LOCATE 14, 15: PRINT "DONE!"
LOCATE 22, 2: PRINT "Use the arrow keys to move the cursor,"
LOCATE 23, 2: PRINT " and press enter to choose something. "
DO
LOCATE cv%, 13: PRINT CHR$(1)
SELECT CASE UCASE$(INKEY$)
CASE IS = CHR$(0) + "P"
IF cv% < 14 THEN cv% = cv% + 2: GOTO cheat
CASE IS = CHR$(0) + "H"
IF cv% > 8 THEN cv% = cv% - 2: GOTO cheat
CASE IS = CHR$(13)
EXIT DO
CASE IS = CHR$(27)
cv% = 8: GOTO mainmenu
END SELECT
LOOP
IF cv% = 8 THEN
IF player$ = "NORMAL" THEN player$ = "SNAKE": GOTO cheat
IF player$ = "SNAKE" THEN player$ = "NORMAL": GOTO cheat
END IF
IF cv% = 10 THEN
IF bloodbath$ = "NO" THEN bloodbath$ = "YES": GOTO cheat
IF bloodbath$ = "YES" THEN bloodbath$ = "NO": GOTO cheat
END IF
IF cv% = 12 THEN
IF pluskey$ = "NO" THEN pluskey$ = "YES": GOTO cheat
IF pluskey$ = "YES" THEN pluskey$ = "NO": GOTO cheat
END IF
IF cv% = 14 THEN cv% = 8: GOTO mainmenu
help:
COLOR 3: CLS : SCREEN 9
PRINT : PRINT "INSTRUCTIONS:"
PRINT : PRINT "The object is to get to the end, which means you have to get from left to right."
PRINT "The control is simple, unless you are a complete moron."
PRINT "Then, and only then, should you have trouble."
PRINT "The arrow keys are used to move you, but you have to know how to use the keys..."
PRINT "You simply tap the direction you want to move in, and you'll start walking."
PRINT "You do NOT hold down the keys!  If you want to go left, you tap left once,      and your character will start moving left."
PRINT "When you want to stop walking, either press down to come to a complete stop, or press the oppisite arrow key to start walking the other way."
PRINT "Up jumps, and if you are standing still or walking backwards, you will jump     straight up."
PRINT "If you press up and you are walking forward, then you will jump forward.  Use   this to jump over things."
PRINT "The space bar shoots.  Don't hold down this key, either.  Just tap it once and  you will shoot your gun."
PRINT : PRINT "It's simple. Just remember not to hold down any keys (or press them too rapidly)and remember the arrow keys move you, space shoots, and you'll be fine."
PRINT : PRINT "Press any key.": SLEEP: CLS : SCREEN 13: COLOR 15: GOTO mainmenu
newgame:
IF music$ = "YES" THEN
SBInit
END IF
Ichose$ = "YES"
chooselevel
END SUB

SUB PlayMusic

FOR Channel% = 1 TO MaxChannel%

  IF ChannelStat(Channel%).Defined = 0 THEN GOTO NoGotosPlease

  RChan% = Channel% - 1

  IF ChannelStat(Channel%).IsDone = 1 THEN
   ChannelStat(Channel%).PStat = TIMER + ChannelStat(Channel%).Speed
   ChannelStat(Channel%).SongPtr = ChannelStat(Channel%).SongPtr + MaxChannel%
   ChannelStat(Channel%).IsDone = 0
   ChannelStat(Channel%).IsPlaying = 0
  END IF

   IF ChannelStat(Channel%).IsPlaying = 0 AND Songbuf(ChannelStat(Channel%).SongPtr + Channel% - 1) <> 0 THEN
    ChannelStat(Channel%).PStat = TIMER + ChannelStat(Channel%).Speed
     SELECT CASE Songbuf(ChannelStat(Channel%).SongPtr + RChan%)
       CASE 68   ' "D"
         WriteReg &HA0 + RChan%, &H81
         WriteReg &HB0 + RChan%, &H21 + 4 * ChannelStat(Channel%).Octave
       CASE 69   ' "E"
         WriteReg &HA0 + RChan%, &HB0
         WriteReg &HB0 + RChan%, &H21 + 4 * ChannelStat(Channel%).Octave
       CASE 70   ' "F"
         WriteReg &HA0 + RChan%, &HCA
         WriteReg &HB0 + RChan%, &H21 + 4 * ChannelStat(Channel%).Octave
       CASE 71    ' "G"
         WriteReg &HA0 + RChan%, &H2
         WriteReg &HB0 + RChan%, &H22 + 4 * ChannelStat(Channel%).Octave
       CASE 65 ' "A"
         WriteReg &HA0 + RChan%, &H41
         WriteReg &HB0 + RChan%, &H22 + 4 * ChannelStat(Channel%).Octave
       CASE 66   ' "B"
         WriteReg &HA0 + RChan%, &H87
         WriteReg &HB0 + RChan%, &H22 + 4 * ChannelStat(Channel%).Octave
       CASE 67  '  "C"
         WriteReg &HA0 + RChan%, &HAE
         WriteReg &HB0 + RChan%, &H22 + 4 * ChannelStat(Channel%).Octave
       CASE 17 ' "C#"
         WriteReg &HA0 + RChan%, &H6B
         WriteReg &HB0 + RChan%, &H21 + 4 * ChannelStat(Channel%).Octave
       CASE 18 ' "D#"
         WriteReg &HA0 + RChan%, &H98
         WriteReg &HB0 + RChan%, &H21 + 4 * ChannelStat(Channel%).Octave
       CASE 20 ' F#"
         WriteReg &HA0 + RChan%, &HE5
         WriteReg &HB0 + RChan%, &H21 + 4 * ChannelStat(Channel%).Octave
       CASE 21 ' "G#"
         WriteReg &HA0 + RChan%, &H20
         WriteReg &HB0 + RChan%, &H22 + 4 * ChannelStat(Channel%).Octave
       CASE 15 ' "A#"
         WriteReg &HA0 + RChan%, &H63
         WriteReg &HB0 + RChan%, &H22 + 4 * ChannelStat(Channel%).Octave
        
       CASE 255
         ChannelStat(Channel%).IsPlaying = 1
         ChannelStat(Channel%).PStat = TIMER + Songbuf(ChannelStat(Channel%).SongPtr + Channel% - 1 + MaxChannel%) / 100
         ChannelStat(Channel%).Flag = -1
       CASE 254
         ChannelStat(Channel%).Octave = Songbuf(ChannelStat(Channel%).SongPtr + Channel% - 1 + MaxChannel%)
         ChannelStat(Channel%).SongPtr = ChannelStat(Channel%).SongPtr + MaxChannel%
       CASE 253
         ChannelStat(Channel%).Speed = Songbuf(ChannelStat(Channel%).SongPtr + Channel% - 1 + MaxChannel%) / 100
         ChannelStat(Channel%).SongPtr = ChannelStat(Channel%).SongPtr + MaxChannel%
       CASE 252
         ChannelStat(Channel%).WaveForm = Songbuf(ChannelStat(Channel%).SongPtr + Channel% - 1 + MaxChannel%) - 300
         ChannelStat(Channel%).SongPtr = ChannelStat(Channel%).SongPtr + MaxChannel%
         IF RChan% > 2 THEN RRChan% = RChan% + 6 ELSE RRChan% = 0
         WriteReg &HE0 + RChan% + RRChan%, ChannelStat(Channel%).WaveForm
       CASE 251
         ChannelStat(1).Flag2 = -1
          FOR MaxChan% = 1 TO MaxChannel%
           ChannelStat(MaxChan%).SongPtr = 1
           ChannelStat(MaxChan%).IsPlaying = 0
           ChannelStat(MaxChan%).IsDone = 0
          NEXT
         closechannels
         EXIT SUB
     END SELECT
   END IF

    IF ChannelStat(Channel%).IsPlaying = 1 THEN
     IF TIMER >= ChannelStat(Channel%).PStat THEN
      WriteReg &HB0 + RChan%, 0
      ChannelStat(Channel%).IsDone = 1
       IF ChannelStat(Channel%).Flag = -1 THEN
        ChannelStat(Channel%).SongPtr = ChannelStat(Channel%).SongPtr + MaxChannel%
        ChannelStat(Channel%).Flag = 0
       END IF
     END IF
    END IF
   
   IF ChannelStat(Channel%).SongPtr > MaxChannel% + 1 THEN
     IF Songbuf(ChannelStat(Channel%).SongPtr + RChan%) <> 0 AND Songbuf(ChannelStat(Channel%).SongPtr - MaxChannel% + RChan%) < 250 THEN
       IF ChannelStat(Channel%).IsPlaying = 0 THEN ChannelStat(Channel%).IsPlaying = 1
     END IF
   END IF

NoGotosPlease:
NEXT Channel%


FOR Channel% = 1 TO MaxChannel%

 IF ChannelStat(Channel%).IsPlaying = 0 THEN
  ChannelStat(Channel%).SongPtr = ChannelStat(Channel%).SongPtr + MaxChannel%
  IF ChannelStat(Channel%).SongPtr >= UBOUND(Songbuf) / MaxChannel% THEN
   ChannelStat(Channel%).SongPtr = 1
  END IF
  END IF
NEXT Channel%

END SUB

SUB SBInit
   FOR z% = 1 TO &HF5
     CALL WriteReg(z%, 0)
   NEXT z%
END SUB

SUB SetIns (Channel%)
' Sets the Current Instrument.
CarChan% = Channel% - 1

IF Channel% > 3 THEN CarChan% = CarChan% + 5
IF Channel% > 6 THEN CarChan% = CarChan% + 5


WriteReg &H20 + CarChan%, CurrentIns.CMult  'Plays carrier note at specified octave ch. 1
WriteReg &H23 + CarChan%, CurrentIns.MMult  'Plays modulator note at specified octave ch. 1
WriteReg &H40 + CarChan%, CurrentIns.CLevel   'Set carrier total level to softest ch. 1
WriteReg &H43 + CarChan%, CurrentIns.MLevel   'Set modulator level to loudest ch. 1
WriteReg &H60 + CarChan%, CurrentIns.CAttack  'Set carrier attack and decay ch. 1
WriteReg &H63 + CarChan%, CurrentIns.MAttack  'Set modulator attack and decay ch. 1
WriteReg &H80 + CarChan%, CurrentIns.CSustain 'Set carrier sustain and release ch. 1
WriteReg &H83 + CarChan%, CurrentIns.MSustain 'Set modulator sustain and release ch. 1

END SUB

SUB snakedata
CALL batdata
CALL drawbear
CALL beardata
IF fallingdown$ = "YES" THEN CALL checkdown
LINE (eh% - 5, ev% - 5)-(eh% + 5, ev% + 4), bgc%, BF
IF B% - 15 < eh% AND B% > eh% AND pv% = ev% AND stage$ <> "9" THEN
CALL drawplayer
PSET (B%, pv% - 9), bgc%
'duh' THEN PSET (B%, pv% - 7), bgc%
IF gun% = 3 THEN PSET (B%, pv% - 7), bgc%: PSET (B%, pv% - 5), bgc%
IF gun% = 1 AND syu% = 0 THEN
IF sounds$ = "YES" THEN SOUND 50, 2
syu% = 1: GOTO yep
END IF
snakeexplosion eh%, ev% - 3, 0
eh% = 400: ev% = 226
IF stage$ = "9" THEN eh% = 201: ev% = 64
yep: B% = -10: B$ = "NO"
EXIT SUB
END IF
IF falling$ = "YES" OR sidego$ = "YES" THEN GOTO 15
IF dir$ = "RIGHT" THEN CALL checkright
IF dir$ = "RIGHT" AND okay$ = "YES" THEN ph% = ph% + 1: okay$ = "NO"
IF dir$ = "LEFT" THEN CALL checkleft
IF dir$ = "LEFT" AND okay$ = "YES" THEN ph% = ph% - 1: okay$ = "NO"
15 FOR ssp% = 1 TO 2 STEP 1
IF edir$ = "LEFT" THEN
oldph% = ph%
oldpv% = pv%
ph% = eh%
pv% = ev%
CALL checkleft
IF okay$ = "NO" THEN edir$ = "RIGHT"
ph% = oldph%
pv% = oldpv%
END IF
IF edir$ = "RIGHT" THEN
oldph% = ph%
oldpv% = pv%
ph% = eh%
pv% = ev%
echeck$ = "YES"
CALL checkright
echeck$ = "NO"
IF okay$ = "NO" THEN edir$ = "LEFT"
ph% = oldph%
pv% = oldpv%
END IF
IF efall% <> 0 THEN okay$ = "NO"
IF efall% = 0 THEN CALL echeck4fall
IF okay$ = "YES" THEN efall% = 32
IF efall% = 0 AND edir$ = "LEFT" THEN eh% = eh% - 1'twice
IF efall% = 0 AND edir$ = "RIGHT" THEN eh% = eh% + 1'twice(thrice?)
IF efall% > 0 THEN
efall% = efall% - 1: ev% = ev% + 1'twice(check between)
IF edir$ = "RIGHT" THEN
oldph% = ph%
oldpv% = pv%
ph% = eh%
pv% = ev% - (32 - efall%)
CALL checkright
ph% = eh%
pv% = ev% + efall%
CALL checkright
ph% = oldph%
pv% = oldpv%
END IF
IF edir$ = "RIGHT" AND okay$ = "YES" THEN eh% = eh% + 1: okay$ = "NO"
IF edir$ = "LEFT" THEN
oldph% = ph%
oldpv% = pv%
ph% = eh%
pv% = ev% - (32 - efall%)
CALL checkleft
ph% = eh%
pv% = ev% + efall%
CALL checkleft
ph% = oldph%
pv% = oldpv%
END IF
IF edir$ = "LEFT" AND okay$ = "YES" THEN eh% = eh% - 1: okay$ = "NO"
END IF
IF eh% - 10 < ph% AND eh% > ph% AND ev% = pv% THEN 'get hit
IF sounds$ = "YES" THEN SOUND 100, 1: SOUND 50, 1
IF ph% > 30 THEN
FOR mm% = 1 TO 10
CALL checkleft
IF okay$ = "YES" THEN
ph% = ph% - 1
IF dir$ = "LEFT" THEN LINE (ph% - 5, pv% - 19)-(ph% + 6, pv% + 4), bgc%, BF
IF dir$ <> "LEFT" THEN LINE (ph% - 5, pv% - 19)-(ph% + 5, pv% + 4), bgc%, BF
END IF
NEXT mm%
FOR blood% = 1 TO 10
RANDOMIZE TIMER
a% = INT(RND * 10) + 1
B% = INT(RND * 10) + 1
CIRCLE (ph% + (a% - 5), pv% + (B% - 5)), 1, 4
NEXT blood%
IF okay$ = "YES" THEN life% = life% - 10
IF okay$ = "NO" THEN life% = life% - 1
IF okay$ = "NO" AND stage$ = "9" THEN life% = life% - 1
END IF
END IF
IF eh% + 10 > ph% AND eh% < ph% AND ev% = pv% THEN 'get hit
IF sounds$ = "YES" THEN SOUND 100, 1: SOUND 50, 1
IF ph% < 280 THEN
FOR mm% = 1 TO 10
IF okay$ = "YES" THEN
ph% = ph% + 1
IF dir$ = "LEFT" THEN LINE (ph% - 5, pv% - 19)-(ph% + 6, pv% + 4), bgc%, BF
IF dir$ <> "LEFT" THEN LINE (ph% - 5, pv% - 19)-(ph% + 5, pv% + 4), bgc%, BF
END IF
NEXT mm%
FOR blood% = 1 TO 10
RANDOMIZE TIMER
a% = INT(RND * 10) + 1
B% = INT(RND * 10) + 1
CIRCLE (ph% + (a% - 5), pv% + (B% - 5)), 1, 4
NEXT blood%
IF okay$ = "YES" THEN life% = life% - 10
IF okay$ = "NO" THEN life% = life% - 1
IF okay$ = "NO" AND stage$ = "9" THEN life% = life% - 1
END IF
END IF
IF enemy2$ = "SPIKES" AND yaba$ <> "YES" AND pv% < ev2% + 1 AND pv% > ev2% - 12 AND ph% > eh2% - 11 AND ph% < eh2% + 11 THEN
IF dir$ = "LEFT" THEN LINE (ph% - 5, pv% - 20)-(ph% + 6, pv% + 4), bgc%, BF
IF dir$ <> "LEFT" THEN LINE (ph% - 5, pv% - 20)-(ph% + 5, pv% + 4), bgc%, BF
IF sounds$ = "YES" THEN SOUND 100, 1: SOUND 50, 1
IF ph% > 30 THEN
FOR mm% = 1 TO 21
CALL checkleft
IF okay$ = "YES" THEN
ph% = ph% - 1
IF dir$ = "LEFT" THEN LINE (ph% - 5, pv% - 19)-(ph% + 6, pv% + 4), bgc%, BF
IF dir$ <> "LEFT" THEN LINE (ph% - 5, pv% - 19)-(ph% + 5, pv% + 4), bgc%, BF
END IF
NEXT mm%
IF okay$ = "YES" THEN life% = life% - 16
END IF
cone eh2%, ev2% + 3, 12, 5
dir$ = "STOPPED"
END IF
IF enemy3$ = "SPIKES" AND yaba$ <> "YES" AND pv% < ev3% + 1 AND pv% > ev3% - 12 AND ph% > eh3% - 11 AND ph% < eh3% + 11 THEN
IF dir$ = "LEFT" THEN LINE (ph% - 5, pv% - 20)-(ph% + 6, pv% + 4), bgc%, BF
IF dir$ <> "LEFT" THEN LINE (ph% - 5, pv% - 20)-(ph% + 5, pv% + 4), bgc%, BF
IF sounds$ = "YES" THEN SOUND 100, 1: SOUND 50, 1
IF ph% > 30 THEN
FOR mm% = 1 TO 21
CALL checkleft
IF okay$ = "YES" THEN
ph% = ph% - 1
IF dir$ = "LEFT" THEN LINE (ph% - 5, pv% - 19)-(ph% + 6, pv% + 4), bgc%, BF
IF dir$ <> "LEFT" THEN LINE (ph% - 5, pv% - 19)-(ph% + 5, pv% + 4), bgc%, BF
END IF
NEXT mm%
IF okay$ = "YES" THEN life% = life% - 16
END IF
cone eh3%, ev3% + 3, 12, 5
dir$ = "STOPPED"
END IF
IF enemy2$ = "MINE" AND yaba$ <> "YES" AND pv% < ev2% + 1 AND pv% > ev2% - 12 AND ph% > eh2% - 11 AND ph% < eh2% + 11 THEN
explosion eh2%, ev2%, 5
IF dir$ = "LEFT" THEN LINE (ph% - 5, pv% - 20)-(ph% + 6, pv% + 4), bgc%, BF
IF dir$ <> "LEFT" THEN LINE (ph% - 5, pv% - 20)-(ph% + 5, pv% + 4), bgc%, BF
IF ph% > 30 THEN
FOR mm% = 1 TO 21
CALL checkleft
IF okay$ = "YES" THEN
ph% = ph% - 1
IF dir$ = "LEFT" THEN LINE (ph% - 5, pv% - 19)-(ph% + 6, pv% + 4), bgc%, BF
IF dir$ <> "LEFT" THEN LINE (ph% - 5, pv% - 19)-(ph% + 5, pv% + 4), bgc%, BF
END IF
NEXT mm%
IF okay$ = "YES" THEN life% = life% - 32
END IF
LINE (eh2% - 5, ev2% + 4)-(eh2% + 5, ev2%), bgc%, BF
dir$ = "STOPPED"
eh2% = 400: ev2% = 226
END IF
IF enemy3$ = "MINE" AND yaba$ <> "YES" AND pv% < ev3% + 1 AND pv% > ev3% - 12 AND ph% > eh3% - 11 AND ph% < eh3% + 11 THEN
explosion eh3%, ev3%, 5
IF dir$ = "LEFT" THEN LINE (ph% - 5, pv% - 20)-(ph% + 6, pv% + 4), bgc%, BF
IF dir$ <> "LEFT" THEN LINE (ph% - 5, pv% - 20)-(ph% + 5, pv% + 4), bgc%, BF
IF ph% > 30 THEN
FOR mm% = 1 TO 21
CALL checkleft
IF okay$ = "YES" THEN
ph% = ph% - 1
IF dir$ = "LEFT" THEN LINE (ph% - 5, pv% - 19)-(ph% + 6, pv% + 4), bgc%, BF
IF dir$ <> "LEFT" THEN LINE (ph% - 5, pv% - 19)-(ph% + 5, pv% + 4), bgc%, BF
END IF
NEXT mm%
IF okay$ = "YES" THEN life% = life% - 32
END IF
LINE (eh3% - 5, ev3% + 4)-(eh3% + 5, ev3%), bgc%, BF
dir$ = "STOPPED"
eh3% = 400: ev3% = 226
END IF
IF life% < 0 THEN CALL youlose
IF getout$ = "YES" THEN EXIT SUB
NEXT ssp%
END SUB

SUB snakeexplosion (xxh%, xxv%, shd%)
IF shd% = 0 THEN score% = score% + 1
FOR plogomo% = 1 TO 5
IF shd% = 0 THEN CIRCLE (xxh% - 3, xxv% - 2 - plogomo% * 3), 2, 2
IF shd% = 0 THEN LINE (xxh% - 4, xxv% - 3 - plogomo% * 3)-(xxh% - 1, xxv% - plogomo% * 3), 2, BF
IF shd% = 0 THEN PSET (xxh% - 4, xxv% - 2 - plogomo% * 3), 0
IF shd% = 0 THEN PSET (xxh% - 2, xxv% - 2 - plogomo% * 3), 0
LINE (xxh% - (plogomo%) - 1, xxv% - (plogomo%) - 1)-(xxh% - (plogomo%), xxv% - (plogomo%)), 4, BF
LINE (xxh% + (plogomo%) - 1, xxv% + (plogomo%) - 1)-(xxh% + (plogomo%), xxv% + (plogomo%)), 4, BF
LINE (xxh% - (plogomo%) - 1, xxv% + (plogomo%) - 1)-(xxh% - (plogomo%), xxv% + (plogomo%)), 4, BF
LINE (xxh% + (plogomo%) - 1, xxv% - (plogomo%) - 1)-(xxh% + (plogomo%), xxv% - (plogomo%)), 4, BF
LINE (xxh% + (plogomo% * 2) - 1, xxv% + (plogomo% / 2) - 1)-(xxh% + (plogomo% * 2), xxv% + (plogomo% / 2)), 4, BF
LINE (xxh% - (plogomo% * 2) - 1, xxv% - (plogomo% / 2) - 1)-(xxh% - (plogomo% * 2), xxv% - (plogomo% / 2)), 4, BF
delay .5
IF sounds$ = "YES" THEN SOUND 100 - (plogomo% * 10), 2
LINE (xxh% - (plogomo%) - 1, xxv% - (plogomo%) - 1)-(xxh% - (plogomo%), xxv% - (plogomo%)), bgc%, BF
LINE (xxh% + (plogomo%) - 1, xxv% + (plogomo%) - 1)-(xxh% + (plogomo%), xxv% + (plogomo%)), bgc%, BF
LINE (xxh% - (plogomo%) - 1, xxv% + (plogomo%) - 1)-(xxh% - (plogomo%), xxv% + (plogomo%)), bgc%, BF
LINE (xxh% + (plogomo%) - 1, xxv% - (plogomo%) - 1)-(xxh% + (plogomo%), xxv% - (plogomo%)), bgc%, BF
LINE (xxh% + (plogomo% * 2) - 1, xxv% + (plogomo% / 2) - 1)-(xxh% + (plogomo% * 2), xxv% + (plogomo% / 2)), bgc%, BF
LINE (xxh% - (plogomo% * 2) - 1, xxv% - (plogomo% / 2) - 1)-(xxh% - (plogomo% * 2), xxv% - (plogomo% / 2)), bgc%, BF
CIRCLE (xxh% - 3, xxv% - 2 - plogomo% * 3), 2, bgc%
LINE (xxh% - 4, xxv% - 3 - plogomo% * 3)-(xxh% - 1, xxv% - plogomo% * 3), bgc%, BF
PSET (xxh% - 4, xxv% - 2 - plogomo% * 3), bgc%
PSET (xxh% - 2, xxv% - 2 - plogomo% * 3), bgc%
NEXT plogomo%
IF shd% = 1 THEN EXIT SUB
CIRCLE (xxh% - 3, xxv% - 2 - plogomo% * 3), 2, 2
LINE (xxh% - 4, xxv% - 3 - plogomo% * 3)-(xxh% - 1, xxv% - plogomo% * 3), 2, BF
PSET (xxh% - 4, xxv% - 2 - plogomo% * 3), 0
PSET (xxh% - 2, xxv% - 2 - plogomo% * 3), 0
delay 1
CIRCLE (xxh% - 3, xxv% - 2 - plogomo% * 3), 2, bgc%
LINE (xxh% - 4, xxv% - 3 - plogomo% * 3)-(xxh% - 1, xxv% - plogomo% * 3), bgc%, BF
PSET (xxh% - 4, xxv% - 2 - plogomo% * 3), bgc%
PSET (xxh% - 2, xxv% - 2 - plogomo% * 3), bgc%
END SUB

FUNCTION SpaceLess$ (x$)
' Removes all spaces from a string
FOR c% = 1 TO LEN(x$)
 IF MID$(x$, c%, 1) <> " " THEN k$ = k$ + MID$(x$, c%, 1)
NEXT
SpaceLess$ = UCASE$(k$)
END FUNCTION

SUB tile (ulh%, ulv%, tylestyle$)
SELECT CASE tylestyle$
CASE IS = "1"
FOR o2i% = 0 TO 15
cy% = 19 + o2i%
IF o2i% > 10 THEN cy% = 29
LINE (ulh% + 2 + o2i%, ulv% + 1 + o2i%)-(ulh% + 33 - o2i%, ulv% + 32 - o2i%), cy%, B
NEXT o2i%
CASE IS = "4"
z1% = ulh% + 2
z2% = ulv% + 1
DO
RANDOMIZE TIMER
chc% = INT(RND * 200) + 1
LINE (z1%, z2%)-(z1% + 4, z2% + 4), chc%, BF
IF z1% < ulh% + 34 THEN z1% = z1% + 5
IF z1% >= ulh% + 34 THEN z1% = ulh%: z2% = z2% + 5
IF z2% >= ulv% + 32 THEN EXIT DO
LOOP
CASE IS = "5"
FOR o2i% = 0 TO 5
cy% = 19 + o2i%
IF o2i% > 10 THEN cy% = 29
LINE (ulh% + 2 + o2i%, ulv% + 1 + o2i%)-(ulh% + 33 - o2i%, ulv% + 32 - o2i%), cy%, B
NEXT o2i%
FOR o2i% = 6 TO 10
cy% = 30 - o2i%
IF o2i% > 10 THEN cy% = 29
LINE (ulh% + 2 + o2i%, ulv% + 1 + o2i%)-(ulh% + 33 - o2i%, ulv% + 32 - o2i%), cy%, B
NEXT o2i%
CASE IS = "6"
LINE (ulh% + 2, ulv% + 1)-(ulh% + 33, ulv% + 32), 6, BF
CASE IS = "7"
LINE (ulh% + 2, ulv% + 1)-(ulh% + 33, ulv% + 32), 6
LINE (ulh% + 2, ulv% + 1)-(ulh% + 33, ulv% + 1), 6
LINE (ulh% + 33, ulv% + 32)-(ulh% + 33, ulv% + 1), 6
PAINT (ulh% + 10, ulv% + 5), 6, 6
CASE IS = "8"
LINE (ulh% + 2, ulv% + 32)-(ulh% + 33, ulv% + 1), 6
LINE (ulh% + 2, ulv% + 1)-(ulh% + 33, ulv% + 1), 6
LINE (ulh% + 2, ulv% + 32)-(ulh% + 2, ulv% + 1), 6
PAINT (ulh% + 5, ulv% + 5), 6, 6
END SELECT
END SUB

SUB Translate (x$, Channel%)

ChannelStat(Channel%).SongPtr = 1   ' These values are all just
ChannelStat(Channel%).Octave = 4    ' back ups if the user never defines
ChannelStat(Channel%).Speed = .25   ' them.
ChannelStat(Channel%).WaveForm = 2
IF Channel% > 3 THEN RChan% = Channel% + 4
WriteReg &HE0 + RChan%, 2

TempBuf! = 0       ' We'll use a temporary single precision value in parsing
TempBuffer% = 0    ' ...as well as a temporary integer.
Temp$ = ""         ' ...as well as a temporary string.

x$ = SpaceLess(x$) ' Remove all spaces from the string

FOR StringLen% = 1 TO LEN(x$)
  CurCommand$ = MID$(x$, StringLen%, 1)
  
    SELECT CASE CurCommand$

      CASE "T":  ' Duration command was issued
                Temp$ = ""
                IF MID$(x$, StringLen% + 1, 1) <> "(" THEN
                  PRINT "Invalid duration command issued :  No control parenthesis! (  )"
                  END
                END IF
                TempBuffer% = 2
                DO UNTIL MID$(x$, StringLen% + TempBuffer%, 1) = ")"
                 Temp$ = Temp$ + MID$(x$, StringLen% + TempBuffer%, 1)
                 TempBuffer% = TempBuffer% + 1
                LOOP
                StringLen% = StringLen% + TempBuffer%
                TempBuf! = VAL(Temp$)
                Songbuf(Channel% + ChannelStat(Channel%).SongPtr - 1) = 253
                Songbuf(Channel% + ChannelStat(Channel%).SongPtr - 1 + MaxChannel%) = TempBuf! * 100
                ChannelStat(Channel%).SongPtr = ChannelStat(Channel%).SongPtr + MaxChannel%
      
       CASE "X": ' Exit song command was issued
                Songbuf(Channel% + ChannelStat(Channel%).SongPtr - 1) = 251
       CASE "W": ' Wave Form command was issued
                Temp$ = ""
                IF MID$(x$, StringLen% + 1, 1) <> "(" THEN
                  PRINT "Invalid wave form command issued :  No control parenthesis! (  )"
                  END
                END IF
                TempBuffer% = 2
                DO UNTIL MID$(x$, StringLen% + TempBuffer%, 1) = ")"
                 Temp$ = Temp$ + MID$(x$, StringLen% + TempBuffer%, 1)
                 TempBuffer% = TempBuffer% + 1
                LOOP
                StringLen% = StringLen% + TempBuffer%
                Songbuf(Channel% + ChannelStat(Channel%).SongPtr - 1) = 252
                Songbuf(Channel% + ChannelStat(Channel%).SongPtr - 1 + MaxChannel%) = VAL(Temp$) + 300
                ChannelStat(Channel%).SongPtr = ChannelStat(Channel%).SongPtr + MaxChannel%

       CASE "P": ' Pause command was issued
                Temp$ = ""
                IF MID$(x$, StringLen% + 1, 1) <> "(" THEN
                  PRINT "Invalid pause command issued :  No control parenthesis! (  )"
                  END
                END IF
                TempBuffer% = 2
                DO UNTIL MID$(x$, StringLen% + TempBuffer%, 1) = ")"
                 Temp$ = Temp$ + MID$(x$, StringLen% + TempBuffer%, 1)
                 TempBuffer% = TempBuffer% + 1
                LOOP
                StringLen% = StringLen% + TempBuffer%
                TempBuf! = VAL(Temp$)
                Songbuf(Channel% + ChannelStat(Channel%).SongPtr - 1) = 255
                Songbuf(Channel% + ChannelStat(Channel%).SongPtr - 1 + MaxChannel%) = TempBuf! * 100
                ChannelStat(Channel%).SongPtr = ChannelStat(Channel%).SongPtr + MaxChannel%
        
         ' An octave command was issued
         CASE "O": Temp$ = MID$(x$, StringLen% + 1, 1)
                   Songbuf(Channel% + ChannelStat(Channel%).SongPtr - 1) = 254
                   Songbuf(Channel% + ChannelStat(Channel%).SongPtr - 1 + MaxChannel%) = VAL(Temp$)
                   StringLen% = StringLen% + 1
                   ChannelStat(Channel%).SongPtr = ChannelStat(Channel%).SongPtr + MaxChannel%

      ' A note command was issued
      CASE "C", "D", "E", "F", "G", "A", "B":
      IF MID$(x$, StringLen% + 1, 1) <> "#" THEN
       Songbuf(Channel% + ChannelStat(Channel%).SongPtr - 1) = ASC(CurCommand$)
      ELSE
       Songbuf(Channel% + ChannelStat(Channel%).SongPtr - 1) = ASC(CurCommand$) - 50
       StringLen% = StringLen% + 1
      END IF

    END SELECT

ChannelStat(Channel%).SongPtr = ChannelStat(Channel%).SongPtr + MaxChannel%
NEXT

ChannelStat(Channel%).Defined = 1

END SUB

DEFINT A-Z
SUB WriteReg (Reg%, value%)

 OUT BasePort% + 8, Reg%
  FOR x% = 0 TO 5
     Buf% = INP(BasePort% + 8)
   NEXT
 OUT BasePort% + 9, value%
   FOR x% = 0 TO 33
     Buf% = INP(BasePort% + 9)
   NEXT

END SUB

DEFSNG A-Z
SUB youfell
IF music$ = "YES" THEN closechannels
CLS : SCREEN 13
IF player$ = "SNAKE" THEN EXIT SUB
LINE (1, 0)-(320, 175), bgc%, BF
LINE (1, 200)-(320, 176), 6, BF
eh% = 100: evv% = -100
col1% = 6
col2% = 4
col3% = 15
DO
CIRCLE (eh% + 22, evv% + 47), 4, 0
LINE (eh% + 18, evv% + 50)-(eh% + 9, evv% + 44), 0, B
LINE (eh% + 16, evv% + 48)-(eh% + 11, evv% + 46), 0, B
LINE (eh% + 22, evv% + 46)-(eh% + 22, evv% + 46), 0
PAINT (eh% + 15, evv% + 47), col3%, 0
PAINT (eh% + 17, evv% + 48), col2%, 0
PAINT (eh% + 22, evv% + 48), col3%, 0
LINE (eh% + 9, evv% + 45)-(eh% + 0, evv% + 50), 0, B
PAINT (eh% + 8, evv% + 46), col1%, 0
LINE (eh% + 0, evv% + 49)-(eh% - 2, evv% + 44), 0, BF
delay .25
CIRCLE (eh% + 22, evv% + 47), 4, bgc%
LINE (eh% + 18, evv% + 50)-(eh% + 9, evv% + 44), bgc%, B
LINE (eh% + 16, evv% + 48)-(eh% + 11, evv% + 46), bgc%, B
LINE (eh% + 22, evv% + 46)-(eh% + 22, evv% + 46), bgc%
PAINT (eh% + 15, evv% + 47), bgc%, bgc%
PAINT (eh% + 17, evv% + 48), bgc%, bgc%
PAINT (eh% + 22, evv% + 48), bgc%, bgc%
LINE (eh% + 9, evv% + 45)-(eh% + 0, evv% + 50), bgc%, B
PAINT (eh% + 8, evv% + 46), bgc%, bgc%
LINE (eh% + 0, evv% + 49)-(eh% - 2, evv% + 44), bgc%, BF
evv% = evv% + 4
IF evv% >= 125 THEN EXIT DO
IF evv% < 25 THEN eh% = eh% + 1
LOOP
CIRCLE (eh% + 22, evv% + 47), 4, 0
LINE (eh% + 18, evv% + 50)-(eh% + 9, evv% + 44), 0, B
LINE (eh% + 16, evv% + 48)-(eh% + 11, evv% + 46), 0, B
LINE (eh% + 22, evv% + 46)-(eh% + 22, evv% + 46), 0
PAINT (eh% + 15, evv% + 47), col3%, 0
PAINT (eh% + 17, evv% + 48), col2%, 0
PAINT (eh% + 22, evv% + 48), col3%, 0
LINE (eh% + 9, evv% + 45)-(eh% + 0, evv% + 50), 0, B
PAINT (eh% + 8, evv% + 46), col1%, 0
LINE (eh% + 0, evv% + 49)-(eh% - 2, evv% + 44), 0, BF
snakeexplosion 145, 173, 1
snakeexplosion 147, 170, 1
snakeexplosion 143, 173, 1
snakeexplosion 150, 170, 1
snakeexplosion 140, 173, 1
IF lives% = 1 THEN
delay 5
FOR yup% = -1 TO 175 STEP 3
LINE (130, yup%)-(170, yup% - 20), 8, BF
delay .01
LINE (130, yup%)-(170, yup% - 20), bgc%, BF
NEXT yup%
IF sounds$ = "YES" THEN SOUND 50, 2
LINE (130, yup%)-(170, yup% - 20), 8, BF
END IF
LINE (1, 0)-(320, 175), bgc%, BF
LINE (1, 200)-(320, 176), 6, BF
IF lives% = 1 THEN LINE (130, yup%)-(170, yup% - 20), 8, BF
delay 5
IF lives% = 1 THEN
FOR l% = 1 TO 30
LINE (150 + l%, 176)-(150 - l%, 176), 4
delay .5
NEXT l%
delay 5
END IF
CALL youlose'
END SUB

SUB youlose
IF music$ = "YES" THEN closechannels
IF getout$ = "YES" THEN EXIT SUB
lives% = lives% - 1
IF lives% > 0 THEN getout$ = "YES": EXIT SUB
IF lives% <= 0 THEN
CLS : LOCATE 10, 15: COLOR 4: PRINT "GAME OVER"
LOCATE 12, 12: PRINT "TRY AGAIN? (Y/N)"
IF sounds$ = "YES" THEN SOUND 130, 10: SOUND 75, 10
DO
SELECT CASE UCASE$(INKEY$)
CASE IS = "N"
EXIT DO
CASE IS = "Y"
RUN
CASE ELSE
END SELECT
LOOP
IF music$ = "YES" THEN
closechannels
SBInit
END IF
CLS : SCREEN 9: COLOR 3
PRINT "Hey you!  Now that you're done playing, go visit my web site!"
COLOR 9: PRINT "http://members.aol.com/rjd42": COLOR 3
PRINT "Go there and you can download more quality games like this, and"
PRINT "even add-on stages for this game that can't be found anywhere else!"
PRINT "That's right, there's files to download that you can't even get in"
PRINT "the file libraries of AOL.  Why are you still reading this?"
PRINT "You should be at my web site by now downloading cool stuff!"
PRINT
COLOR 12
PRINT "Guess what?  Do you like this game?  At my web site you can download"
PRINT "a program I made called GQ2SE (Grako Quest 2 Stage Editor) so that"
PRINT "you can MAKE YOUR OWN STAGES FOR THIS GAME.  It's tons of fun and"
PRINT "it's free!  And you can download extra stages for this game, too!"
SLEEP
CLS : COLOR 0: CLS : SYSTEM
END IF
END SUB

