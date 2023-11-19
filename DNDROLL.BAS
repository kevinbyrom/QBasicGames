RANDOMIZE TIMER
SCREEN 12



DO

LOCATE 20
st = INT(6 * RND) + INT(6 * RND) + INT(6 * RND) + 3
dx = INT(6 * RND) + INT(6 * RND) + INT(6 * RND) + 3
cn = INT(6 * RND) + INT(6 * RND) + INT(6 * RND) + 3
in = INT(6 * RND) + INT(6 * RND) + INT(6 * RND) + 3
ws = INT(6 * RND) + INT(6 * RND) + INT(6 * RND) + 3
ch = INT(6 * RND) + INT(6 * RND) + INT(6 * RND) + 3
av = INT((st + in + ws + cn + dx + ch) / 6)

LOCATE 1
COLOR 10
PRINT "D & D auto-roller"
LINE (0, 20)-(150, 20), 12
LINE (150, 165)-(150, 0), 12
LINE (0, 140)-(150, 140), 12
LINE (0, 165)-(150, 165), 12
LOCATE 3
COLOR 1
PRINT "strength"; st
COLOR 2
PRINT "dexterity"; dx
COLOR 3
PRINT "constitution"; cn
COLOR 4
PRINT "intelligence"; in
COLOR 5
PRINT "wisdom"; ws
COLOR 6
PRINT "charisma"; ch
LOCATE 10
COLOR 9
av = INT((st + in + ws + cn + dx + ch) / 6)

PRINT "average"; av

LOOP UNTIL INKEY$ > ""

