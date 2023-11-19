SCREEN 13
CLS
LINE (50, 75)-(110, 125), 15, B
LINE (210, 75)-(270, 125), 15, B
rd = 10
rd2 = 10
xadd = 0
DO
rd = 10
rd2 = 10
xadd = 0

FOR i = 1 TO 10
CIRCLE (60, 85), 5, 15
CIRCLE (220, 85), 5, 15

CIRCLE (80 - xadd, 100), rd, 15
CIRCLE (240 + xadd, 100), rd, 15

FOR t = 1 TO 1000
NEXT
xadd = xadd + 1
rd = rd + 1
LINE (51, 76)-(109, 124), 0, BF
LINE (211, 76)-(269, 124), 0, BF

NEXT
FOR i = 1 TO 20
CIRCLE (60, 85), 5, 15
CIRCLE (220, 85), 5, 15

CIRCLE (80 - xadd, 100), rd, 15
CIRCLE (240 + xadd, 100), rd, 15

FOR t = 1 TO 1000
NEXT
xadd = xadd - 1
rd = rd - 1
LINE (51, 76)-(109, 124), 0, BF
LINE (211, 76)-(269, 124), 0, BF

NEXT
FOR i = 1 TO 10
CIRCLE (60, 85), 5, 15
CIRCLE (220, 85), 5, 15

CIRCLE (80 - xadd, 100), rd, 15
CIRCLE (240 + xadd, 100), rd, 15

FOR t = 1 TO 1000
NEXT
xadd = xadd + 1
rd = rd + 1
LINE (51, 76)-(109, 124), 0, BF
LINE (211, 76)-(269, 124), 0, BF

NEXT


LOOP

