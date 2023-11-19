'                              ภฤฤฤฤฤฤยฤฤฤฤฤฤู
'ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
'ณ                   Q B a s i c  K e y  T r a p p e r                    ณ
'ณ                                                                        ณ
'ณ          (c) copyright 1995 by Molnar \ Kucalaba Productions           ณ
'ณ                                                                        ณ
'ณ     This program will display the codes you can you when trapping      ณ
'ณ keys. Some keys, such as the Lock keys, Shift, Control, and Alt I have ณ
'ณ         no idea how to trap. I hope you find this useful.              ณ
'ณ                                                                        ณ
'ณ                      email: Blood 225@aol.com                          ณ
'ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
'                                     ณ
'                                     ณ
'             ีอออออออออออออออออออออออฯออออออออออออออออออออออออธ
'             ณ Coming Soon from Molnar \ Kucalaba Productions:ณ
'ีออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออฯอออออออออออออธ
'ณ                                                                           ณ
'ณ QBasic Crossword Puzzle (maybe): First in line of M\K games to have full  ณ
'ณ  mouse interface. Includes Load\Save option in addition to 63 questions.  ณ
'ณ                    Available: Early June 1995.                            ณ
'ณ                                                                           ณ
'ณ QBasic Pieces: Second M\K game to fully operate with mouse. Piece togetherณ
'ณ   complicated jigsaw puzzle. Contains 150 pieces and 5+ puzzles. Also has ณ
'ณ            handy Load\Save feature. Available June 1995.                  ณ
'ณ                                                                           ณ
'ณ  Ambush at South Range II: Big time game. Dragon Warrior-like interface,  ณ
'ณbut better than any other Dragon Warrior-type game. Contains a whole schoolณ
'ณ   to explore, 7 bosses, 15+ items, and Sound Blaster compatibility.       ณ
'ณ                       Available: Mid June 1995                            ณ
'ณ                                                                           ณ
'ณ  As is the case for all of our other games, these do not ask for any      ณ
'ณ                          registration fee.                                ณ
'ิอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออพ


' Main Program right here 

DECLARE SUB Center (row!, text$)
DECLARE SUB FancyBorder ()
DECLARE SUB Slide (speed!, row!, text$)
CLS
SCREEN 12
FancyBorder
Center 3, "A simple BASIC keytrapping program"
Center 10, "If sonso$ = "
Center 14, "Then do this and that"
inky: aa$ = INKEY$: IF aa$ = "" THEN GOTO inky
LOCATE 12, 34: PRINT SPACE$(15)
SELECT CASE ASC(aa$)
  CASE 0: paren$ = CHR$(34) + aa$ + CHR$(34)
  Center 12, "chr$(0) + " + paren$
  CASE 13: Center 12, "chr$(13)"
  CASE 9: Center 12, "chr$(9)"
  CASE ELSE: Center 12, CHR$(34) + aa$ + CHR$(34)
END SELECT
GOTO inky

SUB Center (row, text$)
LOCATE row, 41 - LEN(text$) / 2
PRINT text$
END SUB

SUB FancyBorder
' do you like my "colon encryption"?
LOCATE 1, 80: PRINT "ป": LOCATE 1, 1: PRINT "ษ": LOCATE 28, 1: PRINT "ศ"
LOCATE 28, 80: PRINT "ผ": FOR i = 2 TO 79: LOCATE 1, i: PRINT "อ": NEXT
FOR i = 2 TO 27: LOCATE i, 1: PRINT "บ": LOCATE i, 80: PRINT "บ"
NEXT: FOR i = 2 TO 79: LOCATE 28, i: PRINT "อ": NEXT: FOR i = 9 TO 15
LOCATE i, 28: PRINT "ณ": LOCATE i, 52: PRINT "ณ": NEXT: LOCATE 16, 28: PRINT "ภ"
LOCATE 16, 52: PRINT "ู": LOCATE 8, 28: PRINT "ฺ": LOCATE 8, 52: PRINT "ฟ"
FOR i = 29 TO 51: LOCATE 16, i: PRINT "ฤ": LOCATE 8, i: PRINT "ฤ": NEXT
LOCATE 16, 39: PRINT "า": FOR i = 17 TO 27: LOCATE i, 39: PRINT "บ": NEXT
LOCATE 28, 39: PRINT "ส": LOCATE 12, 28: PRINT "ต": FOR i = 2 TO 27: LOCATE 12, i: PRINT "อ"
NEXT: LOCATE 12, 1: PRINT "ฬ": LOCATE 12, 52: PRINT "ฦ": FOR i = 53 TO 79
LOCATE 12, i: PRINT "อ": NEXT: LOCATE 12, 80: PRINT "น": LOCATE 8, 39: PRINT "ะ"
FOR i = 5 TO 7: LOCATE i, 39: PRINT "บ": NEXT: FOR i = 22 TO 58: LOCATE 4, i: PRINT "ฤ"
LOCATE 2, i: PRINT "ฤ": NEXT: LOCATE 4, 39: PRINT "า": LOCATE 4, 59: PRINT "ฝ"
LOCATE 3, 59: PRINT "บ": LOCATE 2, 59: PRINT "ท": LOCATE 4, 22: PRINT "ำ"
LOCATE 3, 22: PRINT "บ": LOCATE 2, 22: PRINT "ึ": LOCATE 2, 39: PRINT "ะ": LOCATE 1, 39: PRINT "ห"
END SUB

