SCREEN 13
COLOR 15
LOCATE 15, 14
PRINT "Jonoware"
SLEEP 1
FOR i = 30 TO 16 STEP -1
COLOR i
LOCATE 15, 14
PRINT "Jonoware"
start = TIMER: WHILE TIMER < (start + .05): WEND
NEXT i

COLOR 15
LOCATE 15, 14
PRINT "Presents"
SLEEP 1
FOR i = 30 TO 16 STEP -1
COLOR i
LOCATE 15, 14
PRINT "Presents"
start = TIMER: WHILE TIMER < (start + .05): WEND
NEXT i

COLOR 15
LOCATE 15, 14
PRINT "Guessing Game"
SLEEP 1
FOR i = 30 TO 16 STEP -1
COLOR i
LOCATE 15, 14
PRINT "Guessing Game"
start = TIMER: WHILE TIMER < (start + .05): WEND
NEXT i


COLOR 15
CLS
SCREEN 12
COLOR 14
PRINT "Guessing Game -- By Jonathan Weinraub"
PRINT
PRINT
COLOR 12
PRINT "I am thinking of a number from 1 to a 100."
COLOR 9
PRINT "Could you guess what it is?"
PRINT
COLOR 13

RANDOMIZE TIMER

randNum% = INT(RND * 100)
numGuesses% = 0

DO
    INPUT "What is your guess? ", guess%
    SELECT CASE guess%
       CASE IS = randNum%
           PRINT "Congratulations!!"
       CASE IS < randNum% - 10
           PRINT "Brrr!  You're cold!  Try a bigger number."
       CASE IS > randNum% + 10
           PRINT "Brrr!  You're cold!  Try a smaller number."
       CASE IS <> randNum%
           PRINT "You're warm..."
    END SELECT

    numGuesses% = numGuesses% + 1
    PRINT

LOOP UNTIL guess% = randNum%
COLOR 11
PRINT "You guessed the number in"; numGuesses%; "tries!"
PRINT
PRINT
COLOR 13

PRINT
PRINT
PRINT "If you like this program, please send $1.00 to"
PRINT
COLOR 14
PRINT "Jonathan Weinraub"
COLOR 9
PRINT "802 Albemarle St."
COLOR 12
PRINT "Wyckoff, NJ 07481"
END




