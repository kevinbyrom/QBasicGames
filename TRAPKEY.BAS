'                              ���������������
'�������������������������������������������������������������������������Ŀ
'�                   Q B a s i c  K e y  T r a p p e r                    �
'�                                                                        �
'�          (c) copyright 1995 by Molnar \ Kucalaba Productions           �
'�                                                                        �
'�     This program will display the codes you can you when trapping      �
'� keys. Some keys, such as the Lock keys, Shift, Control, and Alt I have �
'�         no idea how to trap. I hope you find this useful.              �
'�                                                                        �
'�                      email: Blood 225@aol.com                          �
'��������������������������������������������������������������������������
'                                     �
'                                     �
'             ������������������������������������������������͸
'             � Coming Soon from Molnar \ Kucalaba Productions:�
'���������������������������������������������������������������������������͸
'�                                                                           �
'� QBasic Crossword Puzzle (maybe): First in line of M\K games to have full  �
'�  mouse interface. Includes Load\Save option in addition to 63 questions.  �
'�                    Available: Early June 1995.                            �
'�                                                                           �
'� QBasic Pieces: Second M\K game to fully operate with mouse. Piece together�
'�   complicated jigsaw puzzle. Contains 150 pieces and 5+ puzzles. Also has �
'�            handy Load\Save feature. Available June 1995.                  �
'�                                                                           �
'�  Ambush at South Range II: Big time game. Dragon Warrior-like interface,  �
'�but better than any other Dragon Warrior-type game. Contains a whole school�
'�   to explore, 7 bosses, 15+ items, and Sound Blaster compatibility.       �
'�                       Available: Mid June 1995                            �
'�                                                                           �
'�  As is the case for all of our other games, these do not ask for any      �
'�                          registration fee.                                �
'���������������������������������������������������������������������������;


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
LOCATE 1, 80: PRINT "�": LOCATE 1, 1: PRINT "�": LOCATE 28, 1: PRINT "�"
LOCATE 28, 80: PRINT "�": FOR i = 2 TO 79: LOCATE 1, i: PRINT "�": NEXT
FOR i = 2 TO 27: LOCATE i, 1: PRINT "�": LOCATE i, 80: PRINT "�"
NEXT: FOR i = 2 TO 79: LOCATE 28, i: PRINT "�": NEXT: FOR i = 9 TO 15
LOCATE i, 28: PRINT "�": LOCATE i, 52: PRINT "�": NEXT: LOCATE 16, 28: PRINT "�"
LOCATE 16, 52: PRINT "�": LOCATE 8, 28: PRINT "�": LOCATE 8, 52: PRINT "�"
FOR i = 29 TO 51: LOCATE 16, i: PRINT "�": LOCATE 8, i: PRINT "�": NEXT
LOCATE 16, 39: PRINT "�": FOR i = 17 TO 27: LOCATE i, 39: PRINT "�": NEXT
LOCATE 28, 39: PRINT "�": LOCATE 12, 28: PRINT "�": FOR i = 2 TO 27: LOCATE 12, i: PRINT "�"
NEXT: LOCATE 12, 1: PRINT "�": LOCATE 12, 52: PRINT "�": FOR i = 53 TO 79
LOCATE 12, i: PRINT "�": NEXT: LOCATE 12, 80: PRINT "�": LOCATE 8, 39: PRINT "�"
FOR i = 5 TO 7: LOCATE i, 39: PRINT "�": NEXT: FOR i = 22 TO 58: LOCATE 4, i: PRINT "�"
LOCATE 2, i: PRINT "�": NEXT: LOCATE 4, 39: PRINT "�": LOCATE 4, 59: PRINT "�"
LOCATE 3, 59: PRINT "�": LOCATE 2, 59: PRINT "�": LOCATE 4, 22: PRINT "�"
LOCATE 3, 22: PRINT "�": LOCATE 2, 22: PRINT "�": LOCATE 2, 39: PRINT "�": LOCATE 1, 39: PRINT "�"
END SUB

