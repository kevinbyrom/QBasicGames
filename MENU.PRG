0 DIM TM$(30), WINS(30), LOSS(30)
1 SCREEN 13
PALETTE 0, 10752
CLS
OPEN "CURRENT.VAR" FOR INPUT AS #1
INPUT #1, leauge$
INPUT #1, player$
CLOSE #1
COLOR 15
GOSUB border: GOTO start
border: LINE (0, 0)-(317, 0): LINE -(317, 199): LINE -(0, 199): LINE -(0, 0): RETURN


start:
COLOR 4: LOCATE 2, 9: PRINT "M"; : COLOR 15: PRINT "icro."
COLOR 4: LOCATE 2, 15: PRINT "F"; : COLOR 15: PRINT "ootball."
COLOR 4: LOCATE 2, 24: PRINT "S"; : COLOR 15: PRINT "imulator"

COLOR 4: LOCATE 4, 18: PRINT "M"; : COLOR 15: PRINT "."; : COLOR 4: PRINT "F"; : COLOR 15: PRINT "."; : COLOR 4: PRINT "S"

COLOR 15: LINE (0, 42)-(317, 42)
LOCATE 8, 2: PRINT "(1) PLAY EXHIBITION GAME"
LOCATE 10, 2: PRINT "(2) CHANGE # OF PLAYERS"
LOCATE 12, 2: PRINT "(3) CLEAR STANDINGS"
LOCATE 14, 2: PRINT "(4) VIEW STANDINGS"
LOCATE 16, 2: PRINT "(5) REGISTER"
LOCATE 18, 2: PRINT "(6) DIRECTIONS"
LOCATE 20, 2: PRINT "(7) QUIT"
LOCATE 22, 6: PRINT "CURRENT LEAGUE: "
LOCATE 24, 6: PRINT "CURRENT PLAYERS: ";
leauge: COLOR 4: LOCATE 22, 22: PRINT leauge$
player: COLOR 4: LOCATE 24, 23: PRINT player$; "     ";
COLOR 15
100 a$ = INKEY$: IF a$ = "" THEN GOTO 100
    IF a$ = "1" THEN RUN "MFTBLS.PRG"
    IF a$ = "2" AND player$ = "ONE" THEN player$ = "TWO": GOSUB 2000: GOTO player
    IF a$ = "2" AND player$ = "TWO" THEN player$ = "COMPUTER": GOSUB 2000: GOTO player
    IF a$ = "2" AND player$ = "COMPUTER" THEN player$ = "ONE": GOSUB 2000: GOTO player
    IF a$ = "3" THEN GOTO 3000
    IF a$ = "4" THEN GOTO 4000
    IF a$ = "5" THEN RUN "REGISTER.PRG"
    IF a$ = "6" THEN RUN "DIRECT.PRG"
    IF a$ = "7" THEN RUN "QUIT.PRG"

GOTO 100

2000 'CHANGE PLAYERS
      OPEN "CURRENT.VAR" FOR OUTPUT AS #1
      PRINT #1, leauge$
      PRINT #1, player$
      CLOSE #1
      RETURN

3000 'CLEAR STANDINGS
      CLS : GOSUB border
      LOCATE 2, 2: PRINT "All standings will reset to 0 - 0."
      LOCATE 4, 2: PRINT "Do you wish to proceed? (y,n). "

3005  a$ = INKEY$: IF a$ = "" THEN GOTO 3005
      IF a$ = "y" OR a$ = "Y" THEN GOTO 3010
      IF a$ = "n" OR a$ = "N" THEN RUN
      GOTO 3005

3010  OPEN "standings" FOR OUTPUT AS #1
      FOR X = 1 TO 30
      PRINT #1, ""
      PRINT #1, 0
      PRINT #1, 0
      TM$(X) = "": WINS(X) = 0: LOSS(X) = 0
      NEXT
      CLOSE #1
      GOTO 4010
END
4000 'view standings
      OPEN "standings" FOR INPUT AS #1
      FOR X = 1 TO 30
      INPUT #1, TM$(X)
      INPUT #1, WINS(X)
      INPUT #1, LOSS(X)
      NEXT

4010  CLS : GOSUB border
      FOR X = 1 TO 30
      IF X > 15 THEN LOCATE X - 14, 22: PRINT TM$(X): LOCATE X - 14, 32: PRINT WINS(X); "-"; LOSS(X)
      IF X < 16 THEN LOCATE X + 1, 2: PRINT TM$(X): LOCATE X + 1, 12: PRINT WINS(X); "-"; LOSS(X)
      NEXT
4015  LOCATE 19, 2: PRINT "Press a key."
4020  a$ = INKEY$: IF a$ = "" THEN GOTO 4020
      RUN

END

