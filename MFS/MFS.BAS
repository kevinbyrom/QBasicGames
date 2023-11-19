DIM b1(3050)
DIM a$(90)
SCREEN 13
DEF SEG = VARSEG(b1(0))
BLOAD "title.img", 0
PUT (118, 38), b1, PSET
LOCATE 24, 1: PRINT "(c)1997, ver.1.1, by Mario LaRosa";
OPEN "FIGHT.SNG" FOR INPUT AS #1
FOR x = 1 TO 89
INPUT #1, a$(x)
NEXT
CLOSE #1
BLOAD "title.img", 0
FOR x = 1 TO 89
AA$ = INKEY$
IF AA$ <> "" THEN GOTO 100
PLAY a$(x)
NEXT
B$ = "P64"
FOR x = 1 TO 100: PLAY B$: NEXT
100 RUN "register.prg"

