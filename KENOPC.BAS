 DECLARE SUB drawgrid ()
SCREEN 13
CLS
CLS


REDIM xball(1 TO 80)
REDIM yball!(1 TO 80)
      num = 1
      FOR y = 1 TO 8
         FOR x = 1 TO 10
           xball(num) = 16 + ((x * 32) - 32)
           yball!(num) = 12.5 + ((y * 25) - 25)
         num = num + 1
         NEXT
      NEXT




'LOCATE 2, 6
'PRINT "10"

REDIM nums(80)







RANDOMIZE TIMER

FOR y = 1 TO 100
PRINT y
REDIM num(1 TO 20)

FOR i = 1 TO 20

roll:
    num(i) = INT(80 * RND) + 1
    FOR t = 1 TO 20
        IF t <> i THEN
           IF num(t) = num(i) THEN GOTO roll
         END IF
    NEXT
NEXT

FOR x = 1 TO 20
    nums(num(x)) = nums(num(x)) + 1
NEXT


NEXT

FOR s = 1 TO 80
    COLOR INT(14 * RND) + 1
    PRINT s; "="; nums(s); " ";
NEXT

SUB drawgrid

SCREEN 7, 0, 0, 2
num = 1
y = 2
DO

FOR x = 1 TO 37 STEP 4

LOCATE y, x
PRINT num
num = num + 1

NEXT
y = y + 3
IF y = 14 THEN y = 15
IF y = 24 THEN y = 23


LOOP UNTIL y = 26

LINE (0, 0)-(319, 199), 15, B
FOR x = 32 TO 320 STEP 32
   LINE (x, 0)-(x, 200), 15
NEXT
FOR y = 25 TO 200 STEP 25
   LINE (0, y)-(320, y), 15
NEXT

FOR y = 0 TO 150 STEP 50
  FOR x = 0 TO 256 STEP 64
     PAINT (x + 1, y + 1), 1, 15
  NEXT
NEXT


FOR y = 25 TO 250 STEP 50
  FOR x = 32 TO 288 STEP 64
     PAINT (x + 1, y + 1), 1, 15
  NEXT
NEXT



FOR y = 0 TO 150 STEP 50
  FOR x = 32 TO 288 STEP 64
     PAINT (x + 1, y + 1), 3, 15
  NEXT
NEXT


FOR y = 25 TO 250 STEP 50
  FOR x = 0 TO 256 STEP 64
     PAINT (x + 1, y + 1), 3, 15
  NEXT
NEXT
PCOPY 0, 1

END SUB

