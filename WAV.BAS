CLS
lors:
INPUT "Do you want [L]arge and blocky or [S]mall and detailed"; a$
a$ = UCASE$(a$)
SELECT CASE a$
CASE "L"
scrn% = 13
CASE "S"
scrn% = 12
CASE IS <> "L", "S"
BEEP
PRINT "Please pick `L` or `S`"
GOTO lors
END SELECT
INPUT "Enter filename (including drive, path, & extension if necessary):", file$
SCREEN scrn%
CLS
OPEN file$ FOR BINARY AS #1
GET #1, 1, d%
u = 1
DO
IF j = 2 THEN u = u + .05: j = 0
j = j + 1
GET #1, , d%
d% = d% / 1000
IF u > 320 THEN SLEEP: CLS : u = 1
IF d% < 0 THEN d% = d% * -1: d% = 67 - d%
IF d% > 0 THEN d% = 67 + d%
PSET (u, d%), 2
b = b + 1
IF b > 256 THEN b = 1
LOOP UNTIL EOF(1)

