7 DECLARE SUB drawgrid ()
SCREEN 7
CLS
INPUT "Number of players?"; numplay
REDIM p1(numplay)
REDIM p2(numplay)
REDIM p3(numplay)
REDIM p4(numplay)
REDIM p5(numplay)
REDIM p6(numplay)
REDIM p7(numplay)
REDIM p8(numplay)

FOR i = 1 TO numplay
  INPUT "player numbers"; p1(i), p2(i), p3(i), p4(i), p5(i), p6(i), p7(i), p8(i)
NEXT

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

drawgrid


'LOCATE 2, 6
'PRINT "10"








RANDOMIZE TIMER

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
PCOPY 0, 2

SCREEN 7, 0, 1, 2

FOR i = 1 TO 20
       clr = INT(3 * RND) + 4
     
      
       FOR rd = 204 TO 3 STEP -3
       PCOPY 0, 1
       CIRCLE (xball(num(i)), yball!(num(i))), rd, clr
       PAINT (xball(num(i)), yball!(num(i))), clr, clr
       
                                                      
       PCOPY 1, 2
       NEXT
      PCOPY 2, 0
NEXT
anykey$ = INPUT$(3)
SCREEN 7, 0, 0, 2
CLS
SCREEN 7, 0, 0, 0
REDIM p(numplay)

FOR i = 1 TO 20
    FOR t = 1 TO numplay
    IF num(i) = p1(t) THEN p(t) = p(t) + 1
    IF num(i) = p2(t) THEN p(t) = p(t) + 1
    IF num(i) = p3(t) THEN p(t) = p(t) + 1
    IF num(i) = p4(t) THEN p(t) = p(t) + 1
    IF num(i) = p5(t) THEN p(t) = p(t) + 1
    IF num(i) = p6(t) THEN p(t) = p(t) + 1
    IF num(i) = p7(t) THEN p(t) = p(t) + 1
    IF num(i) = p8(t) THEN p(t) = p(t) + 1
  
   
    NEXT
NEXT
LOCATE 1
FOR i = 1 TO numplay
   PRINT "Player "; i; " got "; p(i); " number(s)"

NEXT
anykey$ = INPUT$(2)

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

