SCREEN 12 '640,480
CLS
LINE (0, 240)-(640, 240), 2
LINE (320, 0)-(320, 480), 2
strt = -1000
x = strt
oldx = strt
oldy = SQR(((x + 2) ^ 2) * 2)

FOR x = strt TO 1000

y = SQR(((x + 2) ^ 2) * 2)

LINE (oldx + 320, oldy + 240)-(x + 320, y + 240), 1
oldx = x
oldy = y


NEXT

