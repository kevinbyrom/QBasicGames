'                                SECURITY
'                             BY SEAN BUGEL
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

90
100 FOR X = 1 TO 12: PRINT : NEXT X
110 PRINT "                    ** STAND BY FOR SECURITY CLEARANCE **"
120 FOR X = 1 TO 12: PRINT : NEXT X
130 PLAY "MN L8 O3 T75"
140 FOR X = 1 TO 10
150 PLAY "C4"
160 A$ = INKEY$
170 IF A$ <> "|" GOTO 190
180 SYSTEM
190 NEXT X
200 SCREEN 1
210 COLOR 4, 15, 15
220 FOR X = 1 TO 11: PRINT : NEXT X
230 PRINT "             INTRUDER ALERT"
240 PRINT : PRINT
250 PRINT "     UNAUTHORIZED OPERATOR DETECTED"
260 FOR X = 1 TO 11: PRINT : NEXT X
270 FOR X = 440 TO 1000 STEP 10: SOUND X, .1: NEXT X: GOTO 280
280 FOR X = 440 TO 1000 STEP 10: SOUND X, .1: NEXT X: GOTO 290
290 FOR X = 440 TO 1000 STEP 10: SOUND X, .1: NEXT X: GOTO 300
300 FOR X = 440 TO 1000 STEP 10: SOUND X, .1: NEXT X: GOTO 310
310 FOR X = 440 TO 1000 STEP 10: SOUND X, .1: NEXT X: GOTO 320
320 FOR X = 440 TO 1000 STEP 10: SOUND X, .1: NEXT X: GOTO 330
330 SCREEN 1
340 COLOR 4
350 FOR X = 1 TO 11: PRINT : NEXT X
LOCATE 10, 27: PRINT "PLEASE ENTER BYPASS CODE"
PRINT "  ..1"
PRINT "  ..2"
PRINT "  ..3"
PRINT "  ..4"
PRINT "  ..5"
PRINT "  ..6"
PRINT "  ..7"
PRINT "  ..8"
PRINT "  ..9"
PRINT "  ..10"

INPUT N
IF N = 1 THEN GOTO A
IF N = 2 THEN GOTO A
IF N = 3 THEN GOTO A
IF N = 4 THEN GOTO A
IF N = 5 THEN GOTO B
IF N = 6 THEN GOTO A
IF N = 7 THEN GOTO A
IF N = 8 THEN GOTO A
IF N = 9 THEN GOTO A
IF N = 10 THEN GOTO A
    
A:
CLS
PRINT "INCORRECT CODE ACTIVATING VIRUS"
PRINT "FORMATTING C:\ NO TURNING BACK"
PRINT "          10%"
SLEEP (1)
PRINT "          20%"
SLEEP (1)
PRINT "          30%"
SLEEP (1)
PRINT "          40%"
SLEEP (1)
PRINT "          50%"
SLEEP (1)
PRINT "          60%"
SLEEP (1)
PRINT "          70%"
SLEEP (1)
PRINT "          80%"
SLEEP (1)
PRINT "          90%"
SLEEP (1)
PRINT "          100%"
SLEEP (2)
1 :
LOCATE 23, 27: PRINT " ALL C:\ FILES DELETED NO HOPE FOR YOU"
SLEEP (2)
END

2 :
CLS
B:
Menu:
CLS
COLOR 4, 15, 15
PRINT "      CORRECT, ENTERING SYSTEM FILES!!!"
PRINT "                   CHOOSE ONE"
PRINT CHR$(14)
PRINT "   (1)STAR WARS"
PRINT "   (2)FLINTSTONES"
PRINT "   (3)     "
PRINT "   (4)     "
PRINT "   (5) Quit"
PRINT "What Is Your Selection?"

INPUT N
IF N = 1 THEN GOTO A2
IF N = 2 THEN GOTO B2
IF N = 3 THEN GOTO C2
IF N = 4 THEN GOTO D2
IF N = 5 THEN GOTO E2


A2:
CLS
COLOR 15, 0
LOCATE 10, 35: PRINT " STAR WARS "
PLAY "mn t150 o1 l4 g g g l8 e-. b-16 g4 l8 e-. b-16 g2"
PLAY "o2 l4 d d d l8 e-. o1 b-16 f+4 l8 e-. b-16 g2"
PLAY "o2 g4 o1 g8. g16 o2 g4 f+8. f16 e16 e-16 mse8 p8"
PLAY "o1 g+8 ml o2 mn c+4 c8. o1 b16 b-16 a16ms b-8 p8"
PLAY "e-8 ml f+4 mn e-8. f+16 b-4 g8. b-16 o2 d2"
PLAY "g4 o1 g8. g16 o2 g4 f+8. f16 e16 e-16 ms e8 p8"
PLAY "o1 g+8 ml o2 mn c+4 c8. o1 b16 b-16 a16 ms b-8 p8"
PLAY "e-8 ml f+4 mn e-8. b-16 g4 e-8. b-16 g2"
GOTO Menu


B2:
PLAY "t195 c <f"
PLAY ">l8fdl4c<f>"
PLAY "l8c<b-aab->c<l4fgl2a"
PLAY "p4>l4c <f"
PLAY ">l8fdl4c<f>"
PLAY "l8c<b-aab->c<l4fgl2f"
PLAY "p4>l4 e<a>l8feeddel4d d<g >l8eddccdl4c"
PLAY "c<F l8>fdl4c<f >l8c<b-aab->Cl4<fg l8 ab->c<l4fg l8 ab->c l4 fgl2f"
GOTO Menu

C2:
GOTO Menu

D2:
GOTO Menu

E2:
CLS
COLOR 4, 15
start = TIMER: WHILE TIMER < (start + 1): WEND
LOCATE 10, 25: PRINT "  EXITING SYSTEM! CLOSING ALL FILES!! "
SLEEP (2)
LOCATE 11, 25: PRINT " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
LOCATE 12, 25: PRINT " IT IS NOW SAFE TO SHUT DOWN NETWORK!!"
SLEEP (2)
PLAY "mfo3l12ap24emfo3l12ap24e"
CLS
COLOR 0, 15
LOCATE 9, 25: PRINT "   THANK YOU FOR USING MY SOFTWARE!!!! "
LOCATE 10, 25: PRINT " ************************************* "
LOCATE 11, 23: PRINT " DON'T FORGET TO ORDER. IT'S A BARGAIN! "
SLEEP (3)
END


