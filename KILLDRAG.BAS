Start:
 a% = 60
 b% = 17
Picture:
 CLS
 COLOR 12
 PRINT "    _________________"
 PRINT "   /                 \"
 PRINT "  /                   \"
 PRINT " /                     \_________"
 PRINT "                                 \"
 PRINT "                                  \"
 PRINT "                                   \"
 PRINT "                     /-v--v--v--v--- "
 PRINT "                    ("
 PRINT "                     \_/\__/\__/\___"
 PRINT "                                   /"
 PRINT "_________________________________ /"
 LOCATE 4, 12
 PRINT " _____"
 LOCATE 5, 12
 PRINT "(__*__)"
target:
 COLOR 5
 LOCATE b%, a%
 PRINT "/-\"
 LOCATE b% + 1, a%
 PRINT "\-/"
Move:
 mve$ = INKEY$
 IF mve$ = "u" THEN b% = b% - 1
 IF mve$ = "j" THEN b% = b% + 1
 IF mve$ = "h" THEN a% = a% - 1
 IF mve$ = "k" THEN a% = a% + 1
 IF mve$ = "q" THEN END
 IF mve$ = "f" THEN GOTO fire
 SLEEP 1
 GOTO Picture
fire:
 IF a% = 13 OR a% = 14 OR a% = 15 AND b% = 11 OR b% = 12 THEN GOTO win
lose:
 CLS
 COLOR 14
 PRINT "You Lose"
 END
win:
 CLS
 COLOR 12
 PRINT "    _________________"
 PRINT "   /                 \"
 PRINT "  /                   \"
 PRINT " /                     \_________"
 PRINT "                                 \"
 PRINT "                                  \"
 PRINT "                                   \"
 PRINT "                     /-v--v--v--v--- "
 PRINT "                    ("
 PRINT "                     \_/\__/\__/\___"
 PRINT "                                   /"
 PRINT "_________________________________ /"
 LOCATE 4, 12
 PRINT " _____"
 LOCATE 5, 12
 PRINT "(__*__)"
 LOCATE 5, 15
 COLOR 4
 PRINT "^"
 LOCATE 6, 14
 PRINT "/ \"
 LOCATE 7, 14
 PRINT "| |"
 LOCATE 8, 14
 PRINT "| |"
 LOCATE 9, 14
 PRINT "| |"
 LOCATE 10, 14
 PRINT "| |"
 LOCATE 11, 14
 PRINT "| |"
 LOCATE 12, 14
 PRINT "| |"
 LOCATE 13, 14
 PRINT "| |"
 LOCATE 14, 14
 PRINT "| |"
 LOCATE 15, 14
 PRINT "| |"
 LOCATE 16, 14
 PRINT "| |"
 LOCATE 17, 14
 PRINT "| |"
 LOCATE 18, 14
 PRINT "| |"
 LOCATE 19, 14
 PRINT "| |"
 LOCATE 20, 13
 PRINT "/---\"
 LOCATE 21, 14
 PRINT "| |"
 LOCATE 22, 14
 PRINT "| |"
 LOCATE 23, 14
 PRINT "\_/"
 COLOR 3
 LOCATE 20, 50
 PRINT "YOU WIN"
 COLOR 2

