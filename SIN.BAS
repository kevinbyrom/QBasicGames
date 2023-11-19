SCREEN 13
CLS
WINDOW (0, -4)-(12.56, 4)

hght! = 2.1 * RND

FOR x! = 0 TO 3 STEP .1
oldx! = 0
oldy! = 0
clr = INT(15 * RND) + 1
FOR col! = 0 TO 6.28 STEP .01
LINE (col! - x!, SIN(hght! * 2 + col! * 2) + x!)-(oldx - x!, oldy + x!), clr
oldx = col!
oldy = SIN(hght! * 2 + col! * 2)
NEXT

NEXT

