10 CLS
15 PRINT "THIS GAME IS CALLED TRUTH DARE OR CONSIQUENSES (GET THE OTHER PLAYER OUT OF THE ROOM)"
20 INPUT "PLAYER ONE: WHAT'S THE TRUTH QUESTION"; T$
30 INPUT "PLAYER ONE: WHAT'S THE CONSIQUENCE"; C$
40 INPUT "PLAYER ONE: WHAT'S THE DARE"; D$
50 INPUT "TELL THE NAME OF THE VICTIM: ", N$
CLS
60 PRINT "PLAYER TWO MAY ENTER (HIT ANY KEY WHEN READY)"
65 DO
   LOOP UNTIL INKEY$ <> ""
70 PRINT "HI "; N$
80 PRINT ""
90 INPUT "WHAT IS IT (T)RUTH (D)ARE OR (C)ONSIQUENCE"; W$
100 IF W$ = "T" OR W$ = "t" THEN PRINT T$
110 IF W$ = "D" OR W$ = "d" THEN PRINT D$
120 IF W$ = "C" OR W$ = "c" THEN PRINT C$
130 PRINT "PRESS ANY KEY TO CONTINUE"
135 DO
    LOOP UNTIL INKEY$ <> ""
140 IF W$ = "T" OR W$ = "t" THEN INPUT "WHAT IS YOUR ANSWER FOR THE TRUTH"; A$
150 IF W$ <> "T" AND W$ <> "t" THEN GOTO 220
160 CLS
170 PRINT "BRING THE PLAYER ONE IN AND THEN LEAVE THE ROOM (PRESS ANY KEY WHEN READY)"
180 DO
    LOOP UNTIL INKEY$ <> ""
190 CLS
210 PRINT N$; " SAID: "; A$
220 PRINT ""
230 INPUT "DO YOU WISH TO PLAY AGAIN"; P$
240 IF P$ = "Y" OR P$ = "Yes" THEN GOSUB 10
260 CLS
270 PRINT "THIS WAS MADE BY EUGENE IVANYUTIN. EMAIL ME AT GENIUS@AOL.COM"
280 PRINT "THIS WAS MODIFIED AND ENHANCED BY CHARLES ROZAKIS. EMAIL ME AT CHUCKRO15@AOL.COM"
SYSTEM



