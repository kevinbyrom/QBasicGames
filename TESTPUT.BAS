DECLARE SUB loadsprite (file$, iheight!, iwidth!)
DECLARE SUB placeimg (x!, y!, iheight!, iwidth!)
COMMON SHARED sprite()

SCREEN 7, 0, 1, 0
loadsprite "face", 30, 30
FOR n = 0 TO 180 STEP 30
FOR m = 0 TO 300 STEP 30
placeimg m, n, 30, 30
NEXT
NEXT
PCOPY 1, 0

SUB loadsprite (file$, iheight, iwidth)
REDIM sprite(iwidth, iheight)
FileName$ = file$ + ".pcx"

   OPEN FileName$ FOR INPUT AS 1
        FOR h = 1 TO iheight
           FOR i = 1 TO iwidth
               INPUT #1, sprite(i, h)
           NEXT
        NEXT
   CLOSE #1


END SUB

SUB placeimg (x, y, iheight, iwidth)
    FOR s = 1 TO iheight
        FOR t = 1 TO iwidth
             PSET (t + x - 1, s + y - 1), sprite(t, s)
        NEXT
    NEXT

END SUB

