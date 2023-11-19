RANDOMIZE TIMER

REDIM planetx(1 TO 3)
FOR i = 1 TO 3
planetx(i) = INT(318 * RND) + 1
NEXT

REDIM planety(1 TO 3)
FOR i = 1 TO 3
planety(i) = INT(198 * RND) + 1
NEXT

REDIM planetrd(1 TO 3)
FOR i = 1 TO 3
planetrd(i) = INT(10 * RND) + 5
NEXT

REDIM planetcl(1 TO 3)
REDIM planetcl2(1 TO 3)
FOR i = 1 TO 3
planetcl(i) = INT(6 * RND) + 1
planetcl2(i) = INT(6 * RND) + 1
NEXT


REDIM x(1 TO 6)
x(1) = 130
x(2) = 150
x(3) = 170
x(4) = 150
x(5) = 170
x(6) = 190
max = 20

REDIM brstarsx(1 TO max)
FOR i = 1 TO max
brstarsx(i) = INT(319 * RND) + 1
NEXT

REDIM starsx(1 TO max)
FOR i = 1 TO max
starsx(i) = INT(319 * RND) + 1
NEXT

REDIM ltstarsx(1 TO max)
FOR i = 1 TO max
ltstarsx(i) = INT(319 * RND) + 1
NEXT

REDIM brstarsy(1 TO max)
FOR i = 1 TO max
brstarsy(i) = INT(198 * RND) + 1
NEXT

REDIM starsy(1 TO max)
FOR i = 1 TO max
starsy(i) = INT(198 * RND) + 1
NEXT

REDIM ltstarsy(1 TO max)
FOR i = 1 TO max
ltstarsy(i) = INT(198 * RND) + 1
NEXT
DO

SCREEN 7, 0, 2, 0
CLS

FOR i = 1 TO 3
CIRCLE (planetx(i), planety(i)), planetrd(i), planetcl(i)
PAINT (planetx(i), planety(i)), planetcl2(i), planetcl(i)
NEXT

FOR i = 1 TO 3
planetx(i) = planetx(i) + 4
IF planetx(i) > 318 THEN
planetx(i) = 1
planety(i) = INT(198 * RND) + 1
planetrd(i) = INT(10 * RND) + 5
planetcl(i) = INT(6 * RND) + 1
planetcl2(i) = INT(6 * RND) + 1
END IF

NEXT


FOR i = 4 TO 6
LINE (160, 70)-(x(i), 100), 1
LINE (160, 130)-(x(i), 100), 1
NEXT

LINE (160, 70)-(130, 100), 3
LINE (160, 130)-(130, 100), 3
LINE (160, 130)-(190, 100), 3
LINE (160, 70)-(190, 100), 3
LINE (130, 100)-(190, 100), 3
FOR i = 1 TO 3
LINE (160, 70)-(x(i), 100), 3
LINE (160, 130)-(x(i), 100), 3
NEXT



'PAINT (159, 99), 3, 1
'PAINT (161, 99), 5, 1
'PAINT (159, 101), 5, 1
'PAINT (161, 101), 4, 1






SCREEN 7, 0, 1, 0
FOR i = 1 TO 3
x(i) = x(i) - 1
IF x(i) < 130 THEN x(i) = 190
NEXT
FOR i = 4 TO 6
x(i) = x(i) + 1
IF x(i) > 190 THEN x(i) = 130
NEXT


PCOPY 2, 1
FOR i = 1 TO max
    IF POINT(ltstarsx(i), ltstarsy(i)) = 0 THEN PSET (ltstarsx(i), ltstarsy(i)), 8
NEXT
FOR i = 1 TO max
    IF POINT(starsx(i), starsy(i)) = 0 THEN PSET (starsx(i), starsy(i)), 7
NEXT
 FOR i = 1 TO max
    IF POINT(brstarsx(i), brstarsy(i)) = 0 THEN PSET (brstarsx(i), brstarsy(i)), 15
NEXT
FOR i = 1 TO max
    brstarsx(i) = brstarsx(i) + 6
    IF brstarsx(i) > 319 THEN
    brstarsx(i) = 0
    brstarsy(i) = INT(199 * RND) + 1
    END IF
NEXT
FOR i = 1 TO max
    starsx(i) = starsx(i) + 2
    IF starsx(i) > 319 THEN
    starsx(i) = 0
    starsy(i) = INT(199 * RND) + 1
    END IF
NEXT
FOR i = 1 TO max
    ltstarsx(i) = ltstarsx(i) + 1
    IF ltstarsx(i) > 319 THEN
    ltstarsx(i) = 0
    ltstarsy(i) = INT(199 * RND) + 1
    END IF
NEXT
PCOPY 1, 0

LOOP

SUB dotriangle

END SUB

