
 'The Almost Mr. Potato Head Game.........Programmed by Chris McGowan
 '    ------            *Music by John McGowan*

 'NOTE:  Please use all lowercase letters if you want the program to work!


'                           Hope you like it!!!



DECLARE SUB bigEar8 ()
DECLARE SUB smallEar8 ()
DECLARE SUB bigEar7 ()
DECLARE SUB smallEar7 ()
DECLARE SUB open4 ()
DECLARE SUB closed4 ()
DECLARE SUB bigEar6 ()
DECLARE SUB smallEar6 ()
DECLARE SUB bigEar5 ()
DECLARE SUB smallEar5 ()
DECLARE SUB open3 ()
DECLARE SUB closed3 ()
DECLARE SUB blue2 ()
DECLARE SUB brown2 ()
DECLARE SUB bigEar4 ()
DECLARE SUB smallEar4 ()
DECLARE SUB open2 ()
DECLARE SUB closed2 ()
DECLARE SUB bigEar3 ()
DECLARE SUB smallEar3 ()
DECLARE SUB bigEar2 ()
DECLARE SUB smallEar2 ()
DECLARE SUB bigEar1 ()
DECLARE SUB smallEar1 ()
DECLARE SUB open1 ()
DECLARE SUB closed1 ()
DECLARE SUB blue1 ()
DECLARE SUB brown1 ()
DECLARE SUB bigEyes ()
DECLARE SUB smallEyes ()
DECLARE SUB bigNose ()
DECLARE SUB smallNose ()
 CLS
 SCREEN 12
 COLOR 12
 PLAY "MB"
 PLAY "L4 E. C+. L8 E E. L16F+. L8 E D C+"
 PLAY "P8"
 PLAY "L4 E. C+. L8 E E. L16F+. L8 E D C+"
 LOCATE 8, 10: PRINT "* * * * * * * * * * * * * * * * * * * * * * * * * * * * *"
 PRINT "         *                                                       *"
 PRINT "         *            The Almost Mr. Potato Head Game            *"
 PRINT "         *                ------                                 *"
 PRINT "         *                                                       *"
 PRINT "         *              Programmed by Chris McGowan              *"
 PRINT "         *                 Music by John McGowan                 *"
 PRINT "         *                                                       *"
 PRINT "         * * * * * * * * * * * * * * * * * * * * * * * * * * * * *"
 FOR I = 1 TO 25000
 NEXT I

 CLS
 SCREEN 12
 LOCATE 5, 17: PRINT "Welcome to The Almost Mr. Potato Head Game"
 FOR I = 1 TO 10000
 NEXT I
 LOCATE 10, 1: INPUT "What is your name"; name$
 PRINT
 PRINT "Thank you for downloading this program, "; name$; "."
 PRINT
 PRINT "Now let's get started....."
 LOCATE 20, 1: INPUT "Press enter to continue", e$
 CLS
 CIRCLE (290, 260), 140, 6, 0, 6, 1.2
 LINE (406, 258)-(400, 308), 6
 LOCATE 5, 19: PRINT "This is Almost Mr. Potato Head's head."
 LOCATE 30, 21: INPUT "Press enter to continue", e$
 CLS

 LOCATE 10, 1: PRINT "Now we will add a nose. You will have a ";
 PRINT "choice of a big nose or small nose."
 PRINT
 INPUT "Would you like a big(b) nose or a small(s) nose"; nose$
 CLS
     IF nose$ = "b" THEN CALL bigNose
     IF nose$ = "s" THEN CALL smallNose

CLS
SCREEN 12
COLOR 12
PLAY "MB"
PLAY "L4 E. C+. L8 E E. L16F+. L8 E D C+"
PLAY "P8"
PLAY "L4 E. C+. L8 E E. L16F+. L8 E D C+"
LOCATE 10, 10: PRINT "*Thank You for playing the Almost Mr. Potato Head Game, "; name$; "*"; ""
LOCATE 13, 30: PRINT "Have a nice day"
COLOR 7
END


SUB bigEar1
CLS
CIRCLE (290, 260), 140, 6, 0, 6, 1.2       'head
LINE (406, 258)-(400, 308), 6              'head repair
CIRCLE (290, 260), 75, 6, 2, 5.3, 2        'nose
CIRCLE (265, 166), 12, 3                   'left eye
PAINT (265, 166), 3
CIRCLE (265, 166), 7, 0                    'left eye black
PAINT (265, 166), 0
CIRCLE (311, 166), 12, 3                   'right eye
PAINT (311, 166), 3
CIRCLE (311, 166), 7, 0                    'right eye black
PAINT (311, 166), 0
CIRCLE (290, 360), 10, 4                   'mouth
CIRCLE (172, 270), 40, 6, 1.4, 4.9, 1.7    'left ear
LINE (162, 250)-(162, 285), 6
CIRCLE (416, 270), 40, 6, 4, 2, 2        'right ear
LINE (418, 250)-(418, 285), 6
LOCATE 5, 13: PRINT "Here is Almost Mr. Potato Head with a big nose, ";
PRINT "                 blue eyes, an open mouth, and big ears."
FOR I = 1 TO 17000
NEXT I



END SUB

SUB bigEar2
CLS
CIRCLE (290, 260), 140, 6, 0, 6, 1.2       'head
LINE (406, 258)-(400, 308), 6              'head repair
CIRCLE (290, 260), 75, 6, 2, 5.3, 2        'nose
CIRCLE (265, 166), 12, 3                   'left eye
PAINT (265, 166), 3
CIRCLE (265, 166), 7, 0                    'left eye black
PAINT (265, 166), 0
CIRCLE (311, 166), 12, 3                   'right eye
PAINT (311, 166), 3
CIRCLE (311, 166), 7, 0                    'right eye black
PAINT (311, 166), 0
LINE (260, 360)-(320, 360), 4              'mouth
CIRCLE (172, 270), 40, 6, 1.4, 4.9, 1.7    'left ear
LINE (162, 250)-(162, 285), 6
CIRCLE (416, 270), 40, 6, 4, 2, 2          'right ear
LINE (418, 250)-(418, 285), 6
LOCATE 5, 14: PRINT "Here is Almost Mr. Potato Head with a big nose, ";
PRINT "                 blue eyes, a closed mouth, and big ears."

FOR I = 1 TO 17000
NEXT I

END SUB

SUB bigEar3
CLS
CIRCLE (290, 260), 140, 6, 0, 6, 1.2       'head
LINE (406, 258)-(400, 308), 6              'head repair
CIRCLE (290, 260), 75, 6, 2, 5.3, 2        'nose
CIRCLE (265, 166), 12, 6                   'left eye
PAINT (265, 166), 6
CIRCLE (265, 166), 7, 0                    'left eye black
PAINT (265, 166), 0
CIRCLE (311, 166), 12, 6                   'right eye
PAINT (311, 166), 6
CIRCLE (311, 166), 7, 0                    'right eye black
PAINT (311, 166), 0
CIRCLE (290, 360), 10, 4                   'mouth
CIRCLE (172, 270), 40, 6, 1.4, 4.9, 1.7    'left ear
LINE (162, 250)-(162, 285), 6
CIRCLE (416, 270), 40, 6, 4, 2, 2        'right ear
LINE (418, 250)-(418, 285), 6
LOCATE 5, 13: PRINT "Here is Almost Mr. Potato Head with a big nose, ";
PRINT "                brown eyes, an open mouth, and big ears."

FOR I = 1 TO 17000
NEXT I

END SUB

SUB bigEar4
CLS
CIRCLE (290, 260), 140, 6, 0, 6, 1.2       'head
LINE (406, 258)-(400, 308), 6              'head repair
CIRCLE (290, 260), 75, 6, 2, 5.3, 2        'nose
CIRCLE (265, 166), 12, 6                   'left eye
PAINT (265, 166), 6
CIRCLE (265, 166), 7, 0                    'left eye black
PAINT (265, 166), 0
CIRCLE (311, 166), 12, 6                   'right eye
PAINT (311, 166), 6
CIRCLE (311, 166), 7, 0                    'right eye black
PAINT (311, 166), 0
LINE (260, 360)-(320, 360), 4              'mouth
CIRCLE (172, 270), 40, 6, 1.4, 4.9, 1.7    'left ear
LINE (162, 250)-(162, 285), 6
CIRCLE (416, 270), 40, 6, 4, 2, 2          'right ear
LINE (418, 250)-(418, 285), 6
LOCATE 5, 14: PRINT "Here is Almost Mr. Potato Head with a big nose, ";
PRINT "                brown eyes, a closed mouth, and big ears."
FOR I = 1 TO 17000
NEXT I

END SUB

SUB bigEar5
CLS
CIRCLE (290, 260), 140, 6, 0, 6, 1.2       'head
LINE (406, 258)-(400, 308), 6              'head repair
CIRCLE (290, 240), 35, 6, 2, 5.3, 2        'nose
CIRCLE (265, 166), 12, 3                   'left eye
PAINT (265, 166), 3
CIRCLE (265, 166), 7, 0                    'left eye black
PAINT (265, 166), 0
CIRCLE (311, 166), 12, 3                   'right eye
PAINT (311, 166), 3
CIRCLE (311, 166), 7, 0                    'right eye black
PAINT (311, 166), 0
CIRCLE (290, 340), 10, 4                   'mouth
CIRCLE (172, 270), 40, 6, 1.4, 4.9, 1.7    'left ear
LINE (162, 250)-(162, 285), 6
CIRCLE (416, 270), 40, 6, 4, 2, 2        'right ear
LINE (418, 250)-(418, 285), 6
LOCATE 5, 13: PRINT "Here is Almost Mr. Potato Head with a small nose, ";
PRINT "                 blue eyes, an open mouth, and big ears."

FOR I = 1 TO 17000
NEXT I
END SUB

SUB bigEar6
CLS
CIRCLE (290, 260), 140, 6, 0, 6, 1.2       'head
LINE (406, 258)-(400, 308), 6              'head repair
CIRCLE (290, 240), 35, 6, 2, 5.3, 2        'nose
CIRCLE (265, 166), 12, 3                   'left eye
PAINT (265, 166), 3
CIRCLE (265, 166), 7, 0                    'left eye black
PAINT (265, 166), 0
CIRCLE (311, 166), 12, 3                   'right eye
PAINT (311, 166), 3
CIRCLE (311, 166), 7, 0                    'right eye black
PAINT (311, 166), 0
LINE (260, 340)-(320, 340), 4              'mouth
CIRCLE (172, 270), 40, 6, 1.4, 4.9, 1.7    'left ear
LINE (162, 250)-(162, 285), 6
CIRCLE (416, 270), 40, 6, 4, 2, 2        'right ear
LINE (418, 250)-(418, 285), 6
LOCATE 5, 13: PRINT "Here is Almost Mr. Potato Head with a small nose, ";
PRINT "                blue eyes, a closed mouth, and big ears."

FOR I = 1 TO 17000
NEXT I
END SUB

SUB bigEar7
CLS
CIRCLE (290, 260), 140, 6, 0, 6, 1.2       'head
LINE (406, 258)-(400, 308), 6              'head repair
CIRCLE (290, 240), 35, 6, 2, 5.3, 2        'nose
CIRCLE (265, 166), 12, 6                   'left eye
PAINT (265, 166), 6
CIRCLE (265, 166), 7, 0                    'left eye black
PAINT (265, 166), 0
CIRCLE (311, 166), 12, 6                   'right eye
PAINT (311, 166), 6
CIRCLE (311, 166), 7, 0                    'right eye black
PAINT (311, 166), 0
CIRCLE (290, 340), 10, 4                   'mouth
CIRCLE (172, 270), 40, 6, 1.4, 4.9, 1.7    'left ear
LINE (162, 250)-(162, 285), 6
CIRCLE (416, 270), 40, 6, 4, 2, 2        'right ear
LINE (418, 250)-(418, 285), 6
LOCATE 5, 13: PRINT "Here is Almost Mr. Potato Head with a small nose, ";
PRINT "                brown eyes, an open mouth, and big ears."

FOR I = 1 TO 17000
NEXT I
END SUB

SUB bigEar8
CLS
CIRCLE (290, 260), 140, 6, 0, 6, 1.2       'head
LINE (406, 258)-(400, 308), 6              'head repair
CIRCLE (290, 240), 35, 6, 2, 5.3, 2        'nose
CIRCLE (265, 166), 12, 6                   'left eye
PAINT (265, 166), 6
CIRCLE (265, 166), 7, 0                    'left eye black
PAINT (265, 166), 0
CIRCLE (311, 166), 12, 6                   'right eye
PAINT (311, 166), 6
CIRCLE (311, 166), 7, 0                    'right eye black
PAINT (311, 166), 0
LINE (260, 340)-(320, 340), 4              'mouth
CIRCLE (172, 270), 40, 6, 1.4, 4.9, 1.7    'left ear
LINE (162, 250)-(162, 285), 6
CIRCLE (416, 270), 40, 6, 4, 2, 2          'right ear
LINE (418, 250)-(418, 285), 6
LOCATE 5, 13: PRINT "Here is Almost Mr. Potato Head with a small nose, ";
PRINT "               brown eyes, a closed mouth, and big ears."

FOR I = 1 TO 17000
NEXT I

END SUB

SUB bigNose
LOCATE 5, 13: PRINT "Here is Almost Mr. Potato Head with his big nose."
CIRCLE (290, 260), 140, 6, 0, 6, 1.2
LINE (406, 258)-(400, 308), 6
CIRCLE (290, 260), 75, 6, 2, 5.3, 2
FOR I = 1 TO 17000
NEXT I
CLS
LOCATE 10, 1: PRINT "Next we will add eyes. You will have a choice of ";
PRINT "blue eyes or brown eyes."
PRINT
INPUT "Would you like blue(bl) eyes or brown(br) eyes"; eyes$
   IF eyes$ = "bl" THEN CALL blue1
   IF eyes$ = "br" THEN CALL brown1

END SUB

SUB blue1
CLS
CIRCLE (290, 260), 140, 6, 0, 6, 1.2       'head
LINE (406, 258)-(400, 308), 6              'head repair
CIRCLE (290, 260), 75, 6, 2, 5.3, 2        'nose
CIRCLE (265, 166), 12, 3                   'left eye
PAINT (265, 166), 3
CIRCLE (265, 166), 7, 0                    'left eye black
PAINT (265, 166), 0
CIRCLE (311, 166), 12, 3                   'right eye
PAINT (311, 166), 3
CIRCLE (311, 166), 7, 0                    'right eye black
PAINT (311, 166), 0
LOCATE 5, 10: PRINT "Here is Almost Mr. Potato Head with a big nose and blue eyes."
FOR I = 1 TO 17000
NEXT I
CLS
LOCATE 10, 1: PRINT "Now we will add a mouth. You will have a choice of an ";
PRINT "open mouth or a closed mouth."
PRINT
INPUT "Would you like an open(o) or closed(c) mouth"; mouth$
    IF mouth$ = "o" THEN CALL open1
    IF mouth$ = "c" THEN CALL closed1
END SUB

SUB blue2
CLS
CIRCLE (290, 260), 140, 6, 0, 6, 1.2       'head
LINE (406, 258)-(400, 308), 6              'head repair
CIRCLE (290, 240), 35, 6, 2, 5.3, 2        'nose
CIRCLE (265, 166), 12, 3                   'left eye
PAINT (265, 166), 3
CIRCLE (265, 166), 7, 0                    'left eye black
PAINT (265, 166), 0
CIRCLE (311, 166), 12, 3                   'right eye
PAINT (311, 166), 3
CIRCLE (311, 166), 7, 0                    'right eye black
PAINT (311, 166), 0
LOCATE 5, 8: PRINT "Here is Almost Mr. Potato Head with a small nose and blue eyes."
FOR I = 1 TO 17000
NEXT I
CLS
LOCATE 10, 1: PRINT "Now we will add a mouth. You will have a choice of an ";
PRINT "open mouth or a closed mouth."
PRINT
INPUT "Would you like an open(o) or closed(c) mouth"; mouth$
    IF mouth$ = "o" THEN CALL open3
    IF mouth$ = "c" THEN CALL closed3

END SUB

SUB brown1
CLS
CIRCLE (290, 260), 140, 6, 0, 6, 1.2       'head
LINE (406, 258)-(400, 308), 6              'head repair
CIRCLE (290, 260), 75, 6, 2, 5.3, 2        'nose
CIRCLE (265, 166), 12, 6                  'left eye
PAINT (265, 166), 6
CIRCLE (265, 166), 7, 0                    'left eye black
PAINT (265, 166), 0
CIRCLE (311, 166), 12, 6                   'right eye
PAINT (311, 166), 6
CIRCLE (311, 166), 7, 0                    'right eye black
PAINT (311, 166), 0
LOCATE 5, 8: PRINT "Here is Almost Mr. Potato Head with a big nose and brown eyes."
FOR I = 1 TO 17000
NEXT I
CLS
LOCATE 10, 1: PRINT "Now we will add a mouth. You will have a choice of an ";
PRINT "open mouth or a closed mouth."
PRINT
INPUT "Would you like an open(o) or closed(c) mouth"; mouth$
    IF mouth$ = "o" THEN CALL open2
    IF mouth$ = "c" THEN CALL closed2

END SUB

SUB brown2
CLS
CIRCLE (290, 260), 140, 6, 0, 6, 1.2       'head
LINE (406, 258)-(400, 308), 6              'head repair
CIRCLE (290, 240), 35, 6, 2, 5.3, 2        'nose
CIRCLE (265, 166), 12, 6                   'left eye
PAINT (265, 166), 6
CIRCLE (265, 166), 7, 0                    'left eye black
PAINT (265, 166), 0
CIRCLE (311, 166), 12, 6                   'right eye
PAINT (311, 166), 6
CIRCLE (311, 166), 7, 0                    'right eye black
PAINT (311, 166), 0
LOCATE 5, 7: PRINT "Here is Almost Mr. Potato Head with a small nose and brown eyes."
FOR I = 1 TO 17000
NEXT I
CLS
LOCATE 10, 1: PRINT "Now we will add a mouth. You will have a choice of an ";
PRINT "open mouth or a closed mouth."
PRINT
INPUT "Would you like an open(o) or closed(c) mouth"; mouth$
    IF mouth$ = "o" THEN CALL open4
    IF mouth$ = "c" THEN CALL closed4

END SUB

SUB closed1
CLS
CIRCLE (290, 260), 140, 6, 0, 6, 1.2       'head
LINE (406, 258)-(400, 308), 6              'head repair
CIRCLE (290, 260), 75, 6, 2, 5.3, 2        'nose
CIRCLE (265, 166), 12, 3                   'left eye
PAINT (265, 166), 3
CIRCLE (265, 166), 7, 0                    'left eye black
PAINT (265, 166), 0
CIRCLE (311, 166), 12, 3                   'right eye
PAINT (311, 166), 3
CIRCLE (311, 166), 7, 0                    'right eye black
PAINT (311, 166), 0
LINE (260, 360)-(320, 360), 4              'mouth

LOCATE 5, 10: PRINT "Here is Almost Mr. Potato Head with a big nose, blue eyes, ";
PRINT "                           and a closed mouth."
FOR I = 1 TO 17000
NEXT I
CLS
LOCATE 10, 1: PRINT "Now we will add ears. You will have a choice of ";
PRINT "big ears or small ears."
PRINT
INPUT "Would you like big(b) ears or small(s) ears"; ears$
   IF ears$ = "b" THEN CALL bigEar2
   IF ears$ = "s" THEN CALL smallEar2
END SUB

SUB closed2
CLS
CIRCLE (290, 260), 140, 6, 0, 6, 1.2       'head
LINE (406, 258)-(400, 308), 6              'head repair
CIRCLE (290, 260), 75, 6, 2, 5.3, 2        'nose
CIRCLE (265, 166), 12, 6                   'left eye
PAINT (265, 166), 6
CIRCLE (265, 166), 7, 0                    'left eye black
PAINT (265, 166), 0
CIRCLE (311, 166), 12, 6                   'right eye
PAINT (311, 166), 6
CIRCLE (311, 166), 7, 0                    'right eye black
PAINT (311, 166), 0
LINE (260, 360)-(320, 360), 4              'mouth

LOCATE 5, 9: PRINT "Here is Almost Mr. Potato Head with a big nose, brown eyes, ";
PRINT "                           and a closed mouth."
FOR I = 1 TO 17000
NEXT I
CLS
LOCATE 10, 1: PRINT "Now we will add ears. You will have a choice of ";
PRINT "big ears or small ears."
PRINT
INPUT "Would you like big(b) ears or small(s) ears"; ears$
   IF ears$ = "b" THEN CALL bigEar4
   IF ears$ = "s" THEN CALL smallEar4

END SUB

SUB closed3
CLS
CIRCLE (290, 260), 140, 6, 0, 6, 1.2       'head
LINE (406, 258)-(400, 308), 6              'head repair
CIRCLE (290, 240), 35, 6, 2, 5.3, 2        'nose
CIRCLE (265, 166), 12, 3                   'left eye
PAINT (265, 166), 3
CIRCLE (265, 166), 7, 0                    'left eye black
PAINT (265, 166), 0
CIRCLE (311, 166), 12, 3                   'right eye
PAINT (311, 166), 3
CIRCLE (311, 166), 7, 0                    'right eye black
PAINT (311, 166), 0
LINE (260, 340)-(320, 340), 4              'mouth
LOCATE 5, 6: PRINT "Here is Almost Mr. Potato Head with a small nose, blue eyes, and a closed mouth."
FOR I = 1 TO 17000
NEXT I
CLS
LOCATE 10, 1: PRINT "Now we will add ears. You will have a choice of ";
PRINT "big ears or small ears."
PRINT
INPUT "Would you like big(b) ears or small(s) ears"; ears$
   IF ears$ = "b" THEN CALL bigEar6
   IF ears$ = "s" THEN CALL smallEar6

END SUB

SUB closed4
CLS
CIRCLE (290, 260), 140, 6, 0, 6, 1.2       'head
LINE (406, 258)-(400, 308), 6              'head repair
CIRCLE (290, 240), 35, 6, 2, 5.3, 2        'nose
CIRCLE (265, 166), 12, 6                   'left eye
PAINT (265, 166), 6
CIRCLE (265, 166), 7, 0                    'left eye black
PAINT (265, 166), 0
CIRCLE (311, 166), 12, 6                   'right eye
PAINT (311, 166), 6
CIRCLE (311, 166), 7, 0                    'right eye black
PAINT (311, 166), 0
LINE (260, 340)-(320, 340), 4              'mouth
LOCATE 5, 5: PRINT "Here is Almost Mr. Potato Head with a small nose, brown eyes, and a closed mouth."
FOR I = 1 TO 17000
NEXT I
CLS
LOCATE 10, 1: PRINT "Now we will add ears. You will have a choice of ";
PRINT "big ears or small ears."
PRINT
INPUT "Would you like big(b) ears or small(s) ears"; ears$
   IF ears$ = "b" THEN CALL bigEar8
   IF ears$ = "s" THEN CALL smallEar8

END SUB

SUB open1
CLS
CIRCLE (290, 260), 140, 6, 0, 6, 1.2       'head
LINE (406, 258)-(400, 308), 6              'head repair
CIRCLE (290, 260), 75, 6, 2, 5.3, 2        'nose
CIRCLE (265, 166), 12, 3                   'left eye
PAINT (265, 166), 3
CIRCLE (265, 166), 7, 0                    'left eye black
PAINT (265, 166), 0
CIRCLE (311, 166), 12, 3                   'right eye
PAINT (311, 166), 3
CIRCLE (311, 166), 7, 0                    'right eye black
PAINT (311, 166), 0
CIRCLE (290, 360), 10, 4                   'mouth
LOCATE 5, 6: PRINT "Here is Almost Mr. Potato Head with a big nose, blue eyes, and an open mouth."
FOR I = 1 TO 17000
NEXT I
CLS
LOCATE 10, 1: PRINT "Now we will add ears. You will have a choice of ";
PRINT "big ears or small ears."
PRINT
INPUT "Would you like big(b) ears or small(s) ears"; ears$
   IF ears$ = "b" THEN CALL bigEar1
   IF ears$ = "s" THEN CALL smallEar1

END SUB

SUB open2
CLS
CIRCLE (290, 260), 140, 6, 0, 6, 1.2       'head
LINE (406, 258)-(400, 308), 6              'head repair
CIRCLE (290, 260), 75, 6, 2, 5.3, 2        'nose
CIRCLE (265, 166), 12, 6                   'left eye
PAINT (265, 166), 6
CIRCLE (265, 166), 7, 0                    'left eye black
PAINT (265, 166), 0
CIRCLE (311, 166), 12, 6                   'right eye
PAINT (311, 166), 6
CIRCLE (311, 166), 7, 0                    'right eye black
PAINT (311, 166), 0
CIRCLE (290, 360), 10, 4                   'mouth
LOCATE 5, 5: PRINT "Here is Almost Mr. Potato Head with a big nose, brown eyes, and an open mouth."
FOR I = 1 TO 17000
NEXT I
CLS
LOCATE 10, 1: PRINT "Now we will add ears. You will have a choice of ";
PRINT "big ears or small ears."
PRINT
INPUT "Would you like big(b) ears or small(s) ears"; ears$
   IF ears$ = "b" THEN CALL bigEar3
   IF ears$ = "s" THEN CALL smallEar3

END SUB

SUB open3
CLS
CIRCLE (290, 260), 140, 6, 0, 6, 1.2       'head
LINE (406, 258)-(400, 308), 6              'head repair
CIRCLE (290, 240), 35, 6, 2, 5.3, 2        'nose
CIRCLE (265, 166), 12, 3                   'left eye
PAINT (265, 166), 3
CIRCLE (265, 166), 7, 0                    'left eye black
PAINT (265, 166), 0
CIRCLE (311, 166), 12, 3                   'right eye
PAINT (311, 166), 3
CIRCLE (311, 166), 7, 0                    'right eye black
PAINT (311, 166), 0
CIRCLE (290, 340), 10, 4                   'mouth
LOCATE 5, 6: PRINT "Here is Almost Mr. Potato Head with a small nose, blue eyes, and an open mouth."
FOR I = 1 TO 17000
NEXT I
CLS
LOCATE 10, 1: PRINT "Now we will add ears. You will have a choice of ";
PRINT "big ears or small ears."
PRINT
INPUT "Would you like big(b) ears or small(s) ears"; ears$
   IF ears$ = "b" THEN CALL bigEar5
   IF ears$ = "s" THEN CALL smallEar5

END SUB

SUB open4
CLS
CIRCLE (290, 260), 140, 6, 0, 6, 1.2       'head
LINE (406, 258)-(400, 308), 6              'head repair
CIRCLE (290, 240), 35, 6, 2, 5.3, 2        'nose
CIRCLE (265, 166), 12, 6                   'left eye
PAINT (265, 166), 6
CIRCLE (265, 166), 7, 0                    'left eye black
PAINT (265, 166), 0
CIRCLE (311, 166), 12, 6                   'right eye
PAINT (311, 166), 6
CIRCLE (311, 166), 7, 0                    'right eye black
PAINT (311, 166), 0
CIRCLE (290, 340), 10, 4                   'mouth
LOCATE 5, 5: PRINT "Here is Almost Mr. Potato Head with a small nose, brown eyes, and an open mouth."
FOR I = 1 TO 17000
NEXT I
CLS
LOCATE 10, 1: PRINT "Now we will add ears. You will have a choice of ";
PRINT "big ears or small ears."
PRINT
INPUT "Would you like big(b) ears or small(s) ears"; ears$
   IF ears$ = "b" THEN CALL bigEar7
   IF ears$ = "s" THEN CALL smallEar7

END SUB

SUB smallEar1
CLS
CIRCLE (290, 260), 140, 6, 0, 6, 1.2       'head
LINE (406, 258)-(400, 308), 6              'head repair
CIRCLE (290, 260), 75, 6, 2, 5.3, 2        'nose
CIRCLE (265, 166), 12, 3                   'left eye
PAINT (265, 166), 3
CIRCLE (265, 166), 7, 0                    'left eye black
PAINT (265, 166), 0
CIRCLE (311, 166), 12, 3                   'right eye
PAINT (311, 166), 3
CIRCLE (311, 166), 7, 0                    'right eye black
PAINT (311, 166), 0
CIRCLE (290, 360), 10, 4                   'mouth
CIRCLE (172, 270), 20, 6, 1.4, 4.9, 1.7    'left ear
LINE (170, 258)-(170, 278), 6
CIRCLE (410, 270), 20, 6, 4, 2, 2        'right ear
LINE (410, 258)-(410, 280), 6
LOCATE 5, 10: PRINT "Here is Almost Mr. Potato Head with a big nose, blue eyes, ";
PRINT "                       an open mouth, and small ears."

FOR I = 1 TO 17000
NEXT I

END SUB

SUB smallEar2
CLS
CIRCLE (290, 260), 140, 6, 0, 6, 1.2       'head
LINE (406, 258)-(400, 308), 6              'head repair
CIRCLE (290, 260), 75, 6, 2, 5.3, 2        'nose
CIRCLE (265, 166), 12, 3                   'left eye
PAINT (265, 166), 3
CIRCLE (265, 166), 7, 0                    'left eye black
PAINT (265, 166), 0
CIRCLE (311, 166), 12, 3                   'right eye
PAINT (311, 166), 3
CIRCLE (311, 166), 7, 0                    'right eye black
PAINT (311, 166), 0
LINE (260, 360)-(320, 360), 4              'mouth
CIRCLE (172, 270), 20, 6, 1.4, 4.9, 1.7    'left ear
LINE (170, 258)-(170, 278), 6
CIRCLE (410, 270), 20, 6, 4, 2, 2          'right ear
LINE (410, 258)-(410, 280), 6
LOCATE 5, 10: PRINT "Here is Almost Mr. Potato Head with a big nose, blue eyes, ";
PRINT "                      a closed mouth, and small ears."

FOR I = 1 TO 17000
NEXT I

END SUB

SUB smallEar3
CLS
CIRCLE (290, 260), 140, 6, 0, 6, 1.2       'head
LINE (406, 258)-(400, 308), 6              'head repair
CIRCLE (290, 260), 75, 6, 2, 5.3, 2        'nose
CIRCLE (265, 166), 12, 6                   'left eye
PAINT (265, 166), 6
CIRCLE (265, 166), 7, 0                    'left eye black
PAINT (265, 166), 0
CIRCLE (311, 166), 12, 6                   'right eye
PAINT (311, 166), 6
CIRCLE (311, 166), 7, 0                    'right eye black
PAINT (311, 166), 0
CIRCLE (290, 360), 10, 4                   'mouth
CIRCLE (172, 270), 20, 6, 1.4, 4.9, 1.7    'left ear
LINE (170, 258)-(170, 278), 6
CIRCLE (410, 270), 20, 6, 4, 2, 2        'right ear
LINE (410, 258)-(410, 280), 6
LOCATE 5, 9: PRINT "Here is Almost Mr. Potato Head with a big nose, brown eyes, ";
PRINT "                       an open mouth, and small ears."

FOR I = 1 TO 17000
NEXT I

END SUB

SUB smallEar4
CLS
CIRCLE (290, 260), 140, 6, 0, 6, 1.2       'head
LINE (406, 258)-(400, 308), 6              'head repair
CIRCLE (290, 260), 75, 6, 2, 5.3, 2        'nose
CIRCLE (265, 166), 12, 6                   'left eye
PAINT (265, 166), 6
CIRCLE (265, 166), 7, 0                    'left eye black
PAINT (265, 166), 0
CIRCLE (311, 166), 12, 6                   'right eye
PAINT (311, 166), 6
CIRCLE (311, 166), 7, 0                    'right eye black
PAINT (311, 166), 0
LINE (260, 360)-(320, 360), 4              'mouth
CIRCLE (172, 270), 20, 6, 1.4, 4.9, 1.7    'left ear
LINE (170, 258)-(170, 278), 6
CIRCLE (410, 270), 20, 6, 4, 2, 2          'right ear
LINE (410, 258)-(410, 280), 6
LOCATE 5, 9: PRINT "Here is Almost Mr. Potato Head with a big nose, brown eyes, ";
PRINT "                      a closed mouth, and small ears."

FOR I = 1 TO 17000
NEXT I

END SUB

SUB smallEar5
CLS
CIRCLE (290, 260), 140, 6, 0, 6, 1.2       'head
LINE (406, 258)-(400, 308), 6              'head repair
CIRCLE (290, 240), 35, 6, 2, 5.3, 2        'nose
CIRCLE (265, 166), 12, 3                   'left eye
PAINT (265, 166), 3
CIRCLE (265, 166), 7, 0                    'left eye black
PAINT (265, 166), 0
CIRCLE (311, 166), 12, 3                   'right eye
PAINT (311, 166), 3
CIRCLE (311, 166), 7, 0                    'right eye black
PAINT (311, 166), 0
CIRCLE (290, 340), 10, 4                   'mouth
CIRCLE (172, 270), 20, 6, 1.4, 4.9, 1.7    'left ear
LINE (170, 258)-(170, 278), 6
CIRCLE (410, 270), 20, 6, 4, 2, 2        'right ear
LINE (410, 258)-(410, 280), 6
LOCATE 5, 9: PRINT "Here is Almost Mr. Potato Head with a small nose, blue eyes, ";
PRINT "                       an open mouth, and small ears."

FOR I = 1 TO 17000
NEXT I

END SUB

SUB smallEar6
CLS
CIRCLE (290, 260), 140, 6, 0, 6, 1.2       'head
LINE (406, 258)-(400, 308), 6              'head repair
CIRCLE (290, 240), 35, 6, 2, 5.3, 2        'nose
CIRCLE (265, 166), 12, 3                   'left eye
PAINT (265, 166), 3
CIRCLE (265, 166), 7, 0                    'left eye black
PAINT (265, 166), 0
CIRCLE (311, 166), 12, 3                   'right eye
PAINT (311, 166), 3
CIRCLE (311, 166), 7, 0                    'right eye black
PAINT (311, 166), 0
LINE (260, 340)-(320, 340), 4              'mouth
CIRCLE (172, 270), 20, 6, 1.4, 4.9, 1.7    'left ear
LINE (170, 258)-(170, 278), 6
CIRCLE (410, 270), 20, 6, 4, 2, 2        'right ear
LINE (410, 258)-(410, 280), 6
LOCATE 5, 9: PRINT "Here is Almost Mr. Potato Head with a small nose, blue eyes, ";
PRINT "                      a closed mouth, and small ears."

FOR I = 1 TO 17000
NEXT I

END SUB

SUB smallEar7
CLS
CIRCLE (290, 260), 140, 6, 0, 6, 1.2       'head
LINE (406, 258)-(400, 308), 6              'head repair
CIRCLE (290, 240), 35, 6, 2, 5.3, 2        'nose
CIRCLE (265, 166), 12, 6                   'left eye
PAINT (265, 166), 6
CIRCLE (265, 166), 7, 0                    'left eye black
PAINT (265, 166), 0
CIRCLE (311, 166), 12, 6                   'right eye
PAINT (311, 166), 6
CIRCLE (311, 166), 7, 0                    'right eye black
PAINT (311, 166), 0
CIRCLE (290, 340), 10, 4                   'mouth
CIRCLE (172, 270), 20, 6, 1.4, 4.9, 1.7    'left ear
LINE (170, 258)-(170, 278), 6
CIRCLE (410, 270), 20, 6, 4, 2, 2        'right ear
LINE (410, 258)-(410, 280), 6
LOCATE 5, 8: PRINT "Here is Almost Mr. Potato Head with a small nose, brown eyes, ";
PRINT "                       an open mouth, and small ears."

FOR I = 1 TO 17000
NEXT I

END SUB

SUB smallEar8
CLS
CIRCLE (290, 260), 140, 6, 0, 6, 1.2       'head
LINE (406, 258)-(400, 308), 6              'head repair
CIRCLE (290, 240), 35, 6, 2, 5.3, 2        'nose
CIRCLE (265, 166), 12, 6                   'left eye
PAINT (265, 166), 6
CIRCLE (265, 166), 7, 0                    'left eye black
PAINT (265, 166), 0
CIRCLE (311, 166), 12, 6                   'right eye
PAINT (311, 166), 6
CIRCLE (311, 166), 7, 0                    'right eye black
PAINT (311, 166), 0
LINE (260, 340)-(320, 340), 4              'mouth
CIRCLE (172, 270), 20, 6, 1.4, 4.9, 1.7    'left ear
LINE (170, 258)-(170, 278), 6
CIRCLE (410, 270), 20, 6, 4, 2, 2        'right ear
LINE (410, 258)-(410, 280), 6
LOCATE 5, 8: PRINT "Here is Almost Mr. Potato Head with a small nose, brown eyes, ";
PRINT "                      a closed mouth, and small ears."

FOR I = 1 TO 17000
NEXT I

END SUB

SUB smallNose
LOCATE 5, 13: PRINT "Here is Almost Mr. Potato Head with his small nose."
CIRCLE (290, 260), 140, 6, 0, 6, 1.2
LINE (406, 258)-(400, 308), 6
CIRCLE (290, 240), 35, 6, 2, 5.3, 2
FOR I = 1 TO 18000
NEXT I
CLS
LOCATE 10, 1: PRINT "Next we will add eyes. You will have a choice of ";
PRINT "blue eyes or brown eyes."
PRINT
INPUT "Would you like blue(bl) eyes or brown(br) eyes"; eyes$
   IF eyes$ = "bl" THEN CALL blue2
   IF eyes$ = "br" THEN CALL brown2

END SUB

