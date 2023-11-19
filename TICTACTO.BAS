DECLARE SUB MakeScreen ()
DECLARE SUB MainGame ()
CLS
LOCATE 10, 36: PRINT "TIC TAC TOE"
SLEEP 2
CLS
LOCATE 10, 35: PRINT "Created by"
LOCATE 13, 27: PRINT "Barry Smith and Steven Boyd"
SLEEP 2
CLS
PRINT "How many players? (1/2)"
41 a$ = INKEY$: IF a$ = "" THEN GOTO 41
IF a$ <> "1" AND a$ <> "2" THEN GOTO 41
CLS
INPUT "Player 1: What's your name?", name$
IF a$ = "2" THEN INPUT "Player 2: What's your name?", nametwo$
IF a$ = "1" THEN GOTO gofirstt
IF a$ = "2" THEN GOTO whofirstt
gofirstt:
PRINT "Do you want to go first?"
PRINT
PRINT "(1) Yes"
PRINT "(2) No"
42 c$ = INKEY$: IF c$ = "" THEN GOTO 42
IF c$ = "1" THEN GOTO yesonet
IF c$ = "2" THEN GOTO noonet
GOTO 42
yesonet:
c.p. = 1
GOTO dumbt
noonet:
c.p. = 2
GOTO dumbt
whofirstt:
IF a$ = "2" THEN PRINT "Who goes first?"
PRINT
PRINT "(1) "; name$
PRINT "(2) "; nametwo$
43 e$ = INKEY$: IF e$ = "" THEN GOTO 43
IF e$ = "1" THEN GOTO yesonet
IF e$ = "2" THEN GOTO noonet
GOTO 43
dumbt:
IF a$ = "1" THEN
        PRINT "What computer skill level?"
        PRINT
        PRINT "(1) Piece a' cake"
        PRINT "(2) Easy"
        PRINT "(3) Normal"
        PRINT "(4) Hard"
44      F$ = INKEY$: IF F$ = "" THEN GOTO 44
        IF F$ = "1" THEN skill = 1: GOTO stupid
        IF F$ = "2" THEN skill = 2: GOTO stupid
        IF F$ = "3" THEN skill = 3: GOTO stupid
        IF F$ = "4" THEN skill = 4: GOTO stupid
        GOTO 44
END IF
stupid:
MakeScreen
MainGame

SUB MainGame
SHARED a$
SHARED c.p.
SHARED name$
SHARED nametwo$
SHARED skill
SHARED c$
compturns% = 1
LOCATE 1, 1
PRINT "                                       "
LOCATE 1, 1
IF c.p. = 2 AND a$ = "1" THEN GOTO compbrain
IF c.p. = 1 THEN PRINT "What number, "; name$
IF c.p. = 2 THEN PRINT "What number, "; nametwo$
12 b$ = INKEY$: IF b$ = "" THEN GOTO 12
IF b$ = "1" OR b$ = "2" OR b$ = "3" OR b$ = "4" OR b$ = "5" OR b$ = "6" OR b$ = "7" OR b$ = "8" OR b$ = "9" THEN GOTO 15
GOTO 12
15
LOCATE 1, 1
PRINT "                                       "
GOTO Brain
Brain:
IF b$ = "1" THEN IF one$ = "occu1" OR one$ = "occu2" THEN GOTO occupied
IF b$ = "2" THEN IF two$ = "occu1" OR two$ = "occu2" THEN GOTO occupied
IF b$ = "3" THEN IF tre$ = "occu1" OR tre$ = "occu2" THEN GOTO occupied
IF b$ = "4" THEN IF for$ = "occu1" OR for$ = "occu2" THEN GOTO occupied
IF b$ = "5" THEN IF fiv$ = "occu1" OR fiv$ = "occu2" THEN GOTO occupied
IF b$ = "6" THEN IF six$ = "occu1" OR six$ = "occu2" THEN GOTO occupied
IF b$ = "7" THEN IF svn$ = "occu1" OR svn$ = "occu2" THEN GOTO occupied
IF b$ = "8" THEN IF eit$ = "occu1" OR eit$ = "occu2" THEN GOTO occupied
IF b$ = "9" THEN IF nin$ = "occu1" OR nin$ = "occu2" THEN GOTO occupied
IF b$ = "1" AND c.p. = 1 THEN one$ = "occu1"
IF b$ = "1" AND c.p. = 2 THEN one$ = "occu2"
IF b$ = "2" AND c.p. = 1 THEN two$ = "occu1"
IF b$ = "2" AND c.p. = 2 THEN two$ = "occu2"
IF b$ = "3" AND c.p. = 1 THEN tre$ = "occu1"
IF b$ = "3" AND c.p. = 2 THEN tre$ = "occu2"
IF b$ = "4" AND c.p. = 1 THEN for$ = "occu1"
IF b$ = "4" AND c.p. = 2 THEN for$ = "occu2"
IF b$ = "5" AND c.p. = 1 THEN fiv$ = "occu1"
IF b$ = "5" AND c.p. = 2 THEN fiv$ = "occu2"
IF b$ = "6" AND c.p. = 1 THEN six$ = "occu1"
IF b$ = "6" AND c.p. = 2 THEN six$ = "occu2"
IF b$ = "7" AND c.p. = 1 THEN svn$ = "occu1"
IF b$ = "7" AND c.p. = 2 THEN svn$ = "occu2"
IF b$ = "8" AND c.p. = 1 THEN eit$ = "occu1"
IF b$ = "8" AND c.p. = 2 THEN eit$ = "occu2"
IF b$ = "9" AND c.p. = 1 THEN nin$ = "occu1"
IF b$ = "9" AND c.p. = 2 THEN nin$ = "occu2"
IF b$ = "1" AND c.p. = 1 THEN DRAW "bm53,33": GOTO ex
IF b$ = "1" AND c.p. = 2 THEN DRAW "bm53,33": GOTO oh
IF b$ = "2" AND c.p. = 1 THEN DRAW "bm159,33": GOTO ex
IF b$ = "2" AND c.p. = 2 THEN DRAW "bm159,33": GOTO oh
IF b$ = "3" AND c.p. = 1 THEN DRAW "bm265,33": GOTO ex
IF b$ = "3" AND c.p. = 2 THEN DRAW "bm265,33": GOTO oh
IF b$ = "4" AND c.p. = 1 THEN DRAW "bm53,99": GOTO ex
IF b$ = "4" AND c.p. = 2 THEN DRAW "bm53,99": GOTO oh
IF b$ = "5" AND c.p. = 1 THEN DRAW "bm159,99": GOTO ex
IF b$ = "5" AND c.p. = 2 THEN DRAW "bm159,99": GOTO oh
IF b$ = "6" AND c.p. = 1 THEN DRAW "bm265,99": GOTO ex
IF b$ = "6" AND c.p. = 2 THEN DRAW "bm265,99": GOTO oh
IF b$ = "7" AND c.p. = 1 THEN DRAW "bm53,165": GOTO ex
IF b$ = "7" AND c.p. = 2 THEN DRAW "bm53,165": GOTO oh
IF b$ = "8" AND c.p. = 1 THEN DRAW "bm159,165": GOTO ex
IF b$ = "8" AND c.p. = 2 THEN DRAW "bm159,165": GOTO oh
IF b$ = "9" AND c.p. = 1 THEN DRAW "bm265,165": GOTO ex
IF b$ = "9" AND c.p. = 2 THEN DRAW "bm265,165": GOTO oh
occupied:       
LOCATE 1, 1: PRINT "That space is occupied."
SLEEP
LOCATE 1, 1
PRINT "                                       "
LOCATE 1, 1
IF c.p. = 1 THEN PRINT "What number, "; name$
IF c.p. = 2 THEN PRINT "What number, "; nametwo$
GOTO 12
oh:
DRAW "c2br5d3g2l1h2u6e2r1f2d3"
IF c.p. = 1 THEN c.p. = 2: GOTO somewhere
IF c.p. = 2 THEN c.p. = 1: GOTO somewhere
ex:
DRAW "c1e5g10e5f5h10"
IF c.p. = 1 THEN c.p. = 2: GOTO somewhere
IF c.p. = 2 THEN c.p. = 1: GOTO somewhere
somewhere:
IF one$ = "occu1" AND two$ = "occu1" AND tre$ = "occu1" THEN GOTO onewon
IF for$ = "occu1" AND fiv$ = "occu1" AND six$ = "occu1" THEN GOTO onewon
IF svn$ = "occu1" AND eit$ = "occu1" AND nin$ = "occu1" THEN GOTO onewon
IF one$ = "occu1" AND for$ = "occu1" AND svn$ = "occu1" THEN GOTO onewon
IF two$ = "occu1" AND fiv$ = "occu1" AND eit$ = "occu1" THEN GOTO onewon
IF tre$ = "occu1" AND six$ = "occu1" AND nin$ = "occu1" THEN GOTO onewon
IF one$ = "occu1" AND fiv$ = "occu1" AND nin$ = "occu1" THEN GOTO onewon
IF tre$ = "occu1" AND fiv$ = "occu1" AND svn$ = "occu1" THEN GOTO onewon
IF one$ = "occu2" AND two$ = "occu2" AND tre$ = "occu2" THEN GOTO twowon
IF for$ = "occu2" AND fiv$ = "occu2" AND six$ = "occu2" THEN GOTO twowon
IF svn$ = "occu2" AND eit$ = "occu2" AND nin$ = "occu2" THEN GOTO twowon
IF one$ = "occu2" AND for$ = "occu2" AND svn$ = "occu2" THEN GOTO twowon
IF two$ = "occu2" AND fiv$ = "occu2" AND eit$ = "occu2" THEN GOTO twowon
IF tre$ = "occu2" AND six$ = "occu2" AND nin$ = "occu2" THEN GOTO twowon
IF one$ = "occu2" AND fiv$ = "occu2" AND nin$ = "occu2" THEN GOTO twowon
IF tre$ = "occu2" AND fiv$ = "occu2" AND svn$ = "occu2" THEN GOTO twowon
check1:
IF one$ = "occu1" OR one$ = "occu2" THEN GOTO check2
GOTO anywhere
check2:
IF two$ = "occu1" OR two$ = "occu2" THEN GOTO check3
GOTO anywhere
check3:
IF tre$ = "occu1" OR tre$ = "occu2" THEN GOTO check4
GOTO anywhere
check4:
IF for$ = "occu1" OR for$ = "occu2" THEN GOTO check5
GOTO anywhere
check5:
IF fiv$ = "occu1" OR fiv$ = "occu2" THEN GOTO check6
GOTO anywhere
check6:
IF six$ = "occu1" OR six$ = "occu2" THEN GOTO check7
GOTO anywhere
check7:
IF svn$ = "occu1" OR svn$ = "occu2" THEN GOTO check8
GOTO anywhere
check8:
IF eit$ = "occu1" OR eit$ = "occu2" THEN GOTO check9
GOTO anywhere
check9:
IF nin$ = "occu1" OR nin$ = "occu2" THEN GOTO gametie
GOTO anywhere
gametie:
LOCATE 1, 1: PRINT "Game is tied."
SLEEP
END
anywhere:
IF c.p. = 2 AND a$ = "1" THEN GOTO compbrain
LOCATE 1, 1: PRINT "Next player..."
SLEEP 1
LOCATE 1, 1
PRINT "                                       "
LOCATE 1, 1
IF c.p. = 1 THEN PRINT "What number, "; name$
IF c.p. = 2 THEN PRINT "What number, "; nametwo$
GOTO 12
compbrain:
IF skill = 4 THEN
 IF c$ = "2" AND compturns% = 1 THEN
31
  compchoice% = INT(RND * 10)
  IF compchoice% = 1 OR compchoice% = 3 OR compchoice% = 7 OR compchoice% = 9 THEN GOTO good
  GOTO 31
good:
  GOTO compturn
 END IF
 IF c$ = "2" AND fiv$ = "occu1" AND compturns% = 2 THEN
  IF one$ = "occu2" THEN compchoice% = 9: GOSUB compturn
  IF tre$ = "occu2" THEN compchoice% = 7: GOSUB compturn
  IF svn$ = "occu2" THEN compchoice% = 3: GOSUB compturn
  IF nin$ = "occu2" THEN compchoice% = 1: GOSUB compturn
 END IF
 IF c$ = "2" AND fiv$ <> "occu1" AND compturns% = 2 THEN
  IF one$ = "occu2" AND nin$ = "occu1" THEN compchoice% = 3: GOSUB compturn
  IF one$ = "occu2" AND eit$ = "occu1" THEN compchoice% = 7: GOSUB compturn
  IF one$ = "occu2" AND svn$ = "occu1" THEN compchoice% = 3: GOSUB compturn
  IF one$ = "occu2" AND six$ = "occu1" THEN compchoice% = 7: GOSUB compturn
  IF one$ = "occu2" AND for$ = "occu1" THEN compchoice% = 3: GOSUB compturn
  IF one$ = "occu2" AND tre$ = "occu1" THEN compchoice% = 7: GOSUB compturn
  IF tre$ = "occu2" AND eit$ = "occu1" THEN compchoice% = 9: GOSUB compturn
  IF tre$ = "occu2" AND svn$ = "occu1" THEN compchoice% = 1: GOSUB compturn
  IF tre$ = "occu2" AND six$ = "occu1" THEN compchoice% = 1: GOSUB compturn
  IF tre$ = "occu2" AND for$ = "occu1" THEN compchoice% = 9: GOSUB compturn
  IF tre$ = "occu2" AND two$ = "occu1" THEN compchoice% = 9: GOSUB compturn
  IF tre$ = "occu2" AND one$ = "occu1" THEN compchoice% = 9: GOSUB compturn
  IF svn$ = "occu2" AND nin$ = "occu1" THEN compchoice% = 1: GOSUB compturn
  IF svn$ = "occu2" AND eit$ = "occu1" THEN compchoice% = 1: GOSUB compturn
  IF svn$ = "occu2" AND six$ = "occu1" THEN compchoice% = 9: GOSUB compturn
  IF svn$ = "occu2" AND for$ = "occu1" THEN compchoice% = 9: GOSUB compturn
  IF svn$ = "occu2" AND tre$ = "occu1" THEN compchoice% = 1: GOSUB compturn
  IF svn$ = "occu2" AND two$ = "occu1" THEN compchoice% = 9: GOSUB compturn
  IF svn$ = "occu2" AND one$ = "occu1" THEN compchoice% = 9: GOSUB compturn
  IF nin$ = "occu2" AND eit$ = "occu1" THEN compchoice% = 3: GOSUB compturn
  IF nin$ = "occu2" AND svn$ = "occu1" THEN compchoice% = 3: GOSUB compturn
  IF nin$ = "occu2" AND six$ = "occu1" THEN compchoice% = 7: GOSUB compturn
  IF nin$ = "occu2" AND for$ = "occu1" THEN compchoice% = 3: GOSUB compturn
  IF nin$ = "occu2" AND tre$ = "occu1" THEN compchoice% = 7: GOSUB compturn
  IF nin$ = "occu2" AND two$ = "occu1" THEN compchoice% = 3: GOSUB compturn
  IF nin$ = "occu2" AND one$ = "occu1" THEN compchoice% = 7: GOSUB compturn
 END IF
 IF c$ = "2" AND fiv$ = "occu1" AND compturns% = 3 THEN GOTO normal
 IF c$ = "2" AND fiv$ <> "occu1" AND compturns% = 3 THEN
  IF one$ = "occu2" AND tre$ = "occu2" AND for$ <> "occu1" THEN compchoice% = 7: GOSUB compturn
  IF one$ = "occu2" AND svn$ = "occu2" AND two$ <> "occu1" THEN compchoice% = 3: GOSUB compturn
  IF tre$ = "occu2" AND one$ = "occu2" AND six$ <> "occu1" THEN compchoice% = 9: GOSUB compturn
  IF tre$ = "occu2" AND nin$ = "occu2" AND two$ <> "occu1" THEN compchoice% = 1: GOSUB compturn
  IF svn$ = "occu2" AND one$ = "occu2" AND eit$ <> "occu1" THEN compchoice% = 9: GOSUB compturn
  IF svn$ = "occu2" AND nin$ = "occu2" AND for$ <> "occu1" THEN compchoice% = 1: GOSUB compturn
  IF nin$ = "occu2" AND tre$ = "occu2" AND eit$ <> "occu1" THEN compchoice% = 7: GOSUB compturn
  IF nin$ = "occu2" AND svn$ = "occu2" AND six$ <> "occu1" THEN compchoice% = 3: GOSUB compturn
 END IF
 IF c$ = "1" AND compturns% = 1 THEN
  IF fiv$ = "occu1" THEN GOTO 52
  compchoice% = 5: GOTO compturn
 END IF
 IF c$ = "1" AND compturns% = 2 THEN
 IF one$ = "occu2" AND two$ = "occu2" AND tre$ <> "occu1" THEN compchoice% = 3: GOSUB compturn
 IF one$ = "occu2" AND tre$ = "occu2" AND two$ <> "occu1" THEN compchoice% = 2: GOSUB compturn
 IF two$ = "occu2" AND tre$ = "occu2" AND one$ <> "occu1" THEN compchoice% = 1: GOSUB compturn
 IF for$ = "occu2" AND fiv$ = "occu2" AND six$ <> "occu1" THEN compchoice% = 6: GOSUB compturn
 IF for$ = "occu2" AND six$ = "occu2" AND fiv$ <> "occu1" THEN compchoice% = 5: GOSUB compturn
 IF fiv$ = "occu2" AND six$ = "occu2" AND for$ <> "occu1" THEN compchoice% = 4: GOSUB compturn
 IF svn$ = "occu2" AND eit$ = "occu2" AND nin$ <> "occu1" THEN compchoice% = 9: GOSUB compturn
 IF svn$ = "occu2" AND nin$ = "occu2" AND eit$ <> "occu1" THEN compchoice% = 8: GOSUB compturn
 IF eit$ = "occu2" AND nin$ = "occu2" AND svn$ <> "occu1" THEN compchoice% = 7: GOSUB compturn
 IF one$ = "occu2" AND for$ = "occu2" AND svn$ <> "occu1" THEN compchoice% = 7: GOSUB compturn
 IF one$ = "occu2" AND svn$ = "occu2" AND for$ <> "occu1" THEN compchoice% = 4: GOSUB compturn
 IF for$ = "occu2" AND svn$ = "occu2" AND for$ <> "occu1" THEN compchoice% = 1: GOSUB compturn
 IF two$ = "occu2" AND fiv$ = "occu2" AND eit$ <> "occu1" THEN compchoice% = 8: GOSUB compturn
 IF two$ = "occu2" AND eit$ = "occu2" AND fiv$ <> "occu1" THEN compchoice% = 5: GOSUB compturn
 IF fiv$ = "occu2" AND eit$ = "occu2" AND two$ <> "occu1" THEN compchoice% = 2: GOSUB compturn
 IF tre$ = "occu2" AND six$ = "occu2" AND nin$ <> "occu1" THEN compchoice% = 9: GOSUB compturn
 IF tre$ = "occu2" AND nin$ = "occu2" AND six$ <> "occu1" THEN compchoice% = 6: GOSUB compturn
 IF six$ = "occu2" AND nin$ = "occu2" AND tre$ <> "occu1" THEN compchoice% = 3: GOSUB compturn
 IF one$ = "occu2" AND fiv$ = "occu2" AND nin$ <> "occu1" THEN compchoice% = 9: GOSUB compturn
 IF one$ = "occu2" AND nin$ = "occu2" AND fiv$ <> "occu1" THEN compchoice% = 5: GOSUB compturn
 IF fiv$ = "occu2" AND nin$ = "occu2" AND one$ <> "occu1" THEN compchoice% = 1: GOSUB compturn
 IF tre$ = "occu2" AND fiv$ = "occu2" AND svn$ <> "occu1" THEN compchoice% = 7: GOSUB compturn
 IF tre$ = "occu2" AND svn$ = "occu2" AND fiv$ <> "occu1" THEN compchoice% = 5: GOSUB compturn
 IF fiv$ = "occu2" AND svn$ = "occu2" AND tre$ <> "occu1" THEN compchoice% = 3: GOSUB compturn
END IF
IF skill = 2 OR skill = 3 OR skill = 4 THEN
 IF one$ = "occu1" AND two$ = "occu1" AND tre$ <> "occu2" THEN compchoice% = 3: GOSUB compturn
 IF one$ = "occu1" AND tre$ = "occu1" AND two$ <> "occu2" THEN compchoice% = 2: GOSUB compturn
 IF two$ = "occu1" AND tre$ = "occu1" AND one$ <> "occu2" THEN compchoice% = 1: GOSUB compturn
 IF for$ = "occu1" AND fiv$ = "occu1" AND six$ <> "occu2" THEN compchoice% = 6: GOSUB compturn
 IF for$ = "occu1" AND six$ = "occu1" AND fiv$ <> "occu2" THEN compchoice% = 5: GOSUB compturn
 IF fiv$ = "occu1" AND six$ = "occu1" AND for$ <> "occu2" THEN compchoice% = 4: GOSUB compturn
 IF svn$ = "occu1" AND eit$ = "occu1" AND nin$ <> "occu2" THEN compchoice% = 9: GOSUB compturn
 IF svn$ = "occu1" AND nin$ = "occu1" AND eit$ <> "occu2" THEN compchoice% = 8: GOSUB compturn
 IF eit$ = "occu1" AND nin$ = "occu1" AND svn$ <> "occu2" THEN compchoice% = 7: GOSUB compturn
 IF one$ = "occu1" AND for$ = "occu1" AND svn$ <> "occu2" THEN compchoice% = 7: GOSUB compturn
 IF one$ = "occu1" AND svn$ = "occu1" AND for$ <> "occu2" THEN compchoice% = 4: GOSUB compturn
 IF for$ = "occu1" AND svn$ = "occu1" AND one$ <> "occu2" THEN compchoice% = 1: GOSUB compturn
 IF two$ = "occu1" AND fiv$ = "occu1" AND eit$ <> "occu2" THEN compchoice% = 8: GOSUB compturn
 IF two$ = "occu1" AND eit$ = "occu1" AND fiv$ <> "occu2" THEN compchoice% = 5: GOSUB compturn
 IF fiv$ = "occu1" AND eit$ = "occu1" AND two$ <> "occu2" THEN compchoice% = 2: GOSUB compturn
 IF tre$ = "occu1" AND six$ = "occu1" AND nin$ <> "occu2" THEN compchoice% = 9: GOSUB compturn
 IF tre$ = "occu1" AND nin$ = "occu1" AND six$ <> "occu2" THEN compchoice% = 6: GOSUB compturn
 IF six$ = "occu1" AND nin$ = "occu1" AND tre$ <> "occu2" THEN compchoice% = 3: GOSUB compturn
 IF one$ = "occu1" AND fiv$ = "occu1" AND nin$ <> "occu2" THEN compchoice% = 9: GOSUB compturn
 IF one$ = "occu1" AND nin$ = "occu1" AND fiv$ <> "occu2" THEN compchoice% = 5: GOSUB compturn
 IF fiv$ = "occu1" AND nin$ = "occu1" AND one$ <> "occu2" THEN compchoice% = 1: GOSUB compturn
 IF tre$ = "occu1" AND fiv$ = "occu1" AND svn$ <> "occu2" THEN compchoice% = 7: GOSUB compturn
 IF tre$ = "occu1" AND svn$ = "occu1" AND fiv$ <> "occu2" THEN compchoice% = 5: GOSUB compturn
 IF fiv$ = "occu1" AND svn$ = "occu1" AND tre$ <> "occu2" THEN compchoice% = 3: GOSUB compturn
  
  IF one$ = "occu1" AND fiv$ = "occu1" AND nin$ = "occu2" THEN compchoice% = 7: GOSUB compturn
  IF tre$ = "occu1" AND fiv$ = "occu1" AND svn$ = "occu2" THEN compchoice% = 1: GOSUB compturn
52 compchoice% = INT(RND * 10)
  IF compchoice% > 9 OR compchoice% < 1 THEN GOTO 52
  IF compchoice% = 2 OR compchoice% = 4 OR compchoice% = 6 OR compchoice% = 8 THEN GOTO 52
  IF compchoice% = 1 AND two$ = "occu1" THEN GOTO 52
  IF compchoice% = 3 AND two$ = "occu1" THEN GOTO 52
  IF compchoice% = 7 AND two$ = "occu1" THEN GOTO 52
  IF compchoice% = 9 AND two$ = "occu1" THEN GOTO 52
  IF compchoice% = 1 AND two$ = "occu2" THEN GOTO 52
  IF compchoice% = 3 AND two$ = "occu2" THEN GOTO 52
  IF compchoice% = 7 AND two$ = "occu2" THEN GOTO 52
  IF compchoice% = 9 AND two$ = "occu2" THEN GOTO 52
  GOSUB compturn
 END IF
END IF
normal:
IF skill = 3 OR skill = 4 THEN
 IF one$ = "occu2" AND two$ = "occu2" AND tre$ <> "occu1" THEN compchoice% = 3: GOSUB compturn
 IF one$ = "occu2" AND tre$ = "occu2" AND two$ <> "occu1" THEN compchoice% = 2: GOSUB compturn
 IF two$ = "occu2" AND tre$ = "occu2" AND one$ <> "occu1" THEN compchoice% = 1: GOSUB compturn
 IF for$ = "occu2" AND fiv$ = "occu2" AND six$ <> "occu1" THEN compchoice% = 6: GOSUB compturn
 IF for$ = "occu2" AND six$ = "occu2" AND fiv$ <> "occu1" THEN compchoice% = 5: GOSUB compturn
 IF fiv$ = "occu2" AND six$ = "occu2" AND for$ <> "occu1" THEN compchoice% = 4: GOSUB compturn
 IF svn$ = "occu2" AND eit$ = "occu2" AND nin$ <> "occu1" THEN compchoice% = 9: GOSUB compturn
 IF svn$ = "occu2" AND nin$ = "occu2" AND eit$ <> "occu1" THEN compchoice% = 8: GOSUB compturn
 IF eit$ = "occu2" AND nin$ = "occu2" AND svn$ <> "occu1" THEN compchoice% = 7: GOSUB compturn
 IF one$ = "occu2" AND for$ = "occu2" AND svn$ <> "occu1" THEN compchoice% = 7: GOSUB compturn
 IF one$ = "occu2" AND svn$ = "occu2" AND for$ <> "occu1" THEN compchoice% = 4: GOSUB compturn
 IF for$ = "occu2" AND svn$ = "occu2" AND for$ <> "occu1" THEN compchoice% = 1: GOSUB compturn
 IF two$ = "occu2" AND fiv$ = "occu2" AND eit$ <> "occu1" THEN compchoice% = 8: GOSUB compturn
 IF two$ = "occu2" AND eit$ = "occu2" AND fiv$ <> "occu1" THEN compchoice% = 5: GOSUB compturn
 IF fiv$ = "occu2" AND eit$ = "occu2" AND two$ <> "occu1" THEN compchoice% = 2: GOSUB compturn
 IF tre$ = "occu2" AND six$ = "occu2" AND nin$ <> "occu1" THEN compchoice% = 9: GOSUB compturn
 IF tre$ = "occu2" AND nin$ = "occu2" AND six$ <> "occu1" THEN compchoice% = 6: GOSUB compturn
 IF six$ = "occu2" AND nin$ = "occu2" AND tre$ <> "occu1" THEN compchoice% = 3: GOSUB compturn
 IF one$ = "occu2" AND fiv$ = "occu2" AND nin$ <> "occu1" THEN compchoice% = 9: GOSUB compturn
 IF one$ = "occu2" AND nin$ = "occu2" AND fiv$ <> "occu1" THEN compchoice% = 5: GOSUB compturn
 IF fiv$ = "occu2" AND nin$ = "occu2" AND one$ <> "occu1" THEN compchoice% = 1: GOSUB compturn
 IF tre$ = "occu2" AND fiv$ = "occu2" AND svn$ <> "occu1" THEN compchoice% = 7: GOSUB compturn
 IF tre$ = "occu2" AND svn$ = "occu2" AND fiv$ <> "occu1" THEN compchoice% = 5: GOSUB compturn
 IF fiv$ = "occu2" AND svn$ = "occu2" AND tre$ <> "occu1" THEN compchoice% = 3: GOSUB compturn
END IF
IF skill = 2 OR skill = 3 OR skill = 4 THEN
 IF one$ = "occu1" AND two$ = "occu1" AND tre$ <> "occu2" THEN compchoice% = 3: GOSUB compturn
 IF one$ = "occu1" AND tre$ = "occu1" AND two$ <> "occu2" THEN compchoice% = 2: GOSUB compturn
 IF two$ = "occu1" AND tre$ = "occu1" AND one$ <> "occu2" THEN compchoice% = 1: GOSUB compturn
 IF for$ = "occu1" AND fiv$ = "occu1" AND six$ <> "occu2" THEN compchoice% = 6: GOSUB compturn
 IF for$ = "occu1" AND six$ = "occu1" AND fiv$ <> "occu2" THEN compchoice% = 5: GOSUB compturn
 IF fiv$ = "occu1" AND six$ = "occu1" AND for$ <> "occu2" THEN compchoice% = 4: GOSUB compturn
 IF svn$ = "occu1" AND eit$ = "occu1" AND nin$ <> "occu2" THEN compchoice% = 9: GOSUB compturn
 IF svn$ = "occu1" AND nin$ = "occu1" AND eit$ <> "occu2" THEN compchoice% = 8: GOSUB compturn
 IF eit$ = "occu1" AND nin$ = "occu1" AND svn$ <> "occu2" THEN compchoice% = 7: GOSUB compturn
 IF one$ = "occu1" AND for$ = "occu1" AND svn$ <> "occu2" THEN compchoice% = 7: GOSUB compturn
 IF one$ = "occu1" AND svn$ = "occu1" AND for$ <> "occu2" THEN compchoice% = 4: GOSUB compturn
 IF for$ = "occu1" AND svn$ = "occu1" AND one$ <> "occu2" THEN compchoice% = 1: GOSUB compturn
 IF two$ = "occu1" AND fiv$ = "occu1" AND eit$ <> "occu2" THEN compchoice% = 8: GOSUB compturn
 IF two$ = "occu1" AND eit$ = "occu1" AND fiv$ <> "occu2" THEN compchoice% = 5: GOSUB compturn
 IF fiv$ = "occu1" AND eit$ = "occu1" AND two$ <> "occu2" THEN compchoice% = 2: GOSUB compturn
 IF tre$ = "occu1" AND six$ = "occu1" AND nin$ <> "occu2" THEN compchoice% = 9: GOSUB compturn
 IF tre$ = "occu1" AND nin$ = "occu1" AND six$ <> "occu2" THEN compchoice% = 6: GOSUB compturn
 IF six$ = "occu1" AND nin$ = "occu1" AND tre$ <> "occu2" THEN compchoice% = 3: GOSUB compturn
 IF one$ = "occu1" AND fiv$ = "occu1" AND nin$ <> "occu2" THEN compchoice% = 9: GOSUB compturn
 IF one$ = "occu1" AND nin$ = "occu1" AND fiv$ <> "occu2" THEN compchoice% = 5: GOSUB compturn
 IF fiv$ = "occu1" AND nin$ = "occu1" AND one$ <> "occu2" THEN compchoice% = 1: GOSUB compturn
 IF tre$ = "occu1" AND fiv$ = "occu1" AND svn$ <> "occu2" THEN compchoice% = 7: GOSUB compturn
 IF tre$ = "occu1" AND svn$ = "occu1" AND fiv$ <> "occu2" THEN compchoice% = 5: GOSUB compturn
 IF fiv$ = "occu1" AND svn$ = "occu1" AND tre$ <> "occu2" THEN compchoice% = 3: GOSUB compturn
END IF
randnum:
13                                           
compchoice% = INT(RND * 10)
IF compchoice% > 9 THEN GOTO 13
IF compchoice% < 1 THEN GOTO 13
IF compchoice% = 1 AND one$ = "occu2" THEN GOTO 13
IF compchoice% = 2 AND two$ = "occu2" THEN GOTO 13
IF compchoice% = 3 AND tre$ = "occu2" THEN GOTO 13
IF compchoice% = 4 AND for$ = "occu2" THEN GOTO 13
IF compchoice% = 5 AND fiv$ = "occu2" THEN GOTO 13
IF compchoice% = 6 AND six$ = "occu2" THEN GOTO 13
IF compchoice% = 7 AND svn$ = "occu2" THEN GOTO 13
IF compchoice% = 8 AND eit$ = "occu2" THEN GOTO 13
IF compchoice% = 9 AND nin$ = "occu2" THEN GOTO 13
IF compchoice% = 1 AND one$ = "occu1" THEN GOTO 13
IF compchoice% = 2 AND two$ = "occu1" THEN GOTO 13
IF compchoice% = 3 AND tre$ = "occu1" THEN GOTO 13
IF compchoice% = 4 AND for$ = "occu1" THEN GOTO 13
IF compchoice% = 5 AND fiv$ = "occu1" THEN GOTO 13
IF compchoice% = 6 AND six$ = "occu1" THEN GOTO 13
IF compchoice% = 7 AND svn$ = "occu1" THEN GOTO 13
IF compchoice% = 8 AND eit$ = "occu1" THEN GOTO 13
IF compchoice% = 9 AND nin$ = "occu1" THEN GOTO 13
GOTO compturn
onewon:
LOCATE 1, 1: PRINT name$; " won!!"
SLEEP
END
twowon:
LOCATE 1, 1
IF a$ = "2" THEN PRINT nametwo$; " won!!"
IF a$ = "1" THEN PRINT "Player 2 (computer) won!!"
SLEEP
END
compturn:
compturns% = compturns% + 1
SLEEP 1
IF compchoice% = 1 AND one$ = "occu2" THEN RETURN
IF compchoice% = 2 AND two$ = "occu2" THEN RETURN
IF compchoice% = 3 AND tre$ = "occu2" THEN RETURN
IF compchoice% = 4 AND for$ = "occu2" THEN RETURN
IF compchoice% = 5 AND fiv$ = "occu2" THEN RETURN
IF compchoice% = 6 AND six$ = "occu2" THEN RETURN
IF compchoice% = 7 AND svn$ = "occu2" THEN RETURN
IF compchoice% = 8 AND eit$ = "occu2" THEN RETURN
IF compchoice% = 9 AND nin$ = "occu2" THEN RETURN
IF compchoice% = 1 AND one$ = "occu1" THEN RETURN
IF compchoice% = 2 AND two$ = "occu1" THEN RETURN
IF compchoice% = 3 AND tre$ = "occu1" THEN RETURN
IF compchoice% = 4 AND for$ = "occu1" THEN RETURN
IF compchoice% = 5 AND fiv$ = "occu1" THEN RETURN
IF compchoice% = 6 AND six$ = "occu1" THEN RETURN
IF compchoice% = 7 AND svn$ = "occu1" THEN RETURN
IF compchoice% = 8 AND eit$ = "occu1" THEN RETURN
IF compchoice% = 9 AND nin$ = "occu1" THEN RETURN
IF compchoice% = 1 AND c.p. = 2 THEN one$ = "occu2"
IF compchoice% = 2 AND c.p. = 2 THEN two$ = "occu2"
IF compchoice% = 3 AND c.p. = 2 THEN tre$ = "occu2"
IF compchoice% = 4 AND c.p. = 2 THEN for$ = "occu2"
IF compchoice% = 5 AND c.p. = 2 THEN fiv$ = "occu2"
IF compchoice% = 6 AND c.p. = 2 THEN six$ = "occu2"
IF compchoice% = 7 AND c.p. = 2 THEN svn$ = "occu2"
IF compchoice% = 8 AND c.p. = 2 THEN eit$ = "occu2"
IF compchoice% = 9 AND c.p. = 2 THEN nin$ = "occu2"
IF compchoice% = 1 AND c.p. = 2 THEN DRAW "bm53,33": GOTO oh
IF compchoice% = 2 AND c.p. = 2 THEN DRAW "bm159,33": GOTO oh
IF compchoice% = 3 AND c.p. = 2 THEN DRAW "bm265,33": GOTO oh
IF compchoice% = 4 AND c.p. = 2 THEN DRAW "bm53,99": GOTO oh
IF compchoice% = 5 AND c.p. = 2 THEN DRAW "bm159,99": GOTO oh
IF compchoice% = 6 AND c.p. = 2 THEN DRAW "bm265,99": GOTO oh
IF compchoice% = 7 AND c.p. = 2 THEN DRAW "bm53,165": GOTO oh
IF compchoice% = 8 AND c.p. = 2 THEN DRAW "bm159,165": GOTO oh
IF compchoice% = 9 AND c.p. = 2 THEN DRAW "bm265,165": GOTO oh
END SUB

SUB MakeScreen
SCREEN 1
DRAW "p0,0"
DRAW "c17bm106,0m106,200bm212,0m212,200bm0,66m320,66bm0,132m320,132"
COLOR 1
LOCATE 7, 11: PRINT 1
LOCATE 7, 24: PRINT 2
LOCATE 7, 37: PRINT 3
LOCATE 15, 11: PRINT 4
LOCATE 15, 24: PRINT 5
LOCATE 15, 37: PRINT 6
LOCATE 23, 11: PRINT 7
LOCATE 23, 24: PRINT 8
LOCATE 23, 37: PRINT 9
END SUB

