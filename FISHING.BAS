10 CLS
20 PRINT "Welcome to my new fishing game."
30 PRINT ""
40 PRINT ""
50 COLOR 25
60 PRINT "This game was made by Jonathan Reinberg @1993"
61 PRINT ""
62 PRINT ""
63 PRINT "Remmember, all inputs must be in lower case"
70 COLOR 7
80 PRINT ""
90 PRINT ""
100 PRINT ""
110 PRINT "Please press enter to start"
120 INPUT enter$
130 CLS
140 PRINT "You are standing at the edge of the pier. You think"
150 PRINT "to yesterday, when you had no food, so you came here"
160 PRINT "to catch some. You haven't got a thing. But today, the"
170 PRINT "fish have started biting.  So get ready to play!"
180 PRINT ""
190 PRINT ""
200 PRINT ""
210 PRINT ""
220 PRINT "Press I for instructions, or enter to start."
230 INPUT instruction$
240 IF instruction$ = "i" THEN GOTO 260
250 GOTO 310
260 CLS
265 PRINT "You will be prompted for what bait # to use, and where to drop it"
270 PRINT "and then you'll see if you'll catch any fish"
280 PRINT "press enter to start"
290 INPUT enter2$
300 GOTO 310
310 CLS
315 PRINT " ABCDEFGHIJKLMNOPQRSTU"
320 COLOR 1
325 PRINT "1 ********************* "
335 PRINT "2 *                   * "
340 COLOR 7
345 PRINT "3 ##########          * "
355 PRINT "4 ##########          * "
360 COLOR 1
365 PRINT "5 *                   * "
375 PRINT "6 *                   * "
385 PRINT "7 ********************* "
390 COLOR 7
392 PRINT ""
393 PRINT "Type quit at anytime to quit"
395 PRINT ""
400 PRINT ""
410 PRINT "The above image is the dock in the water. The # is the dock and the * is the water edge"
420 PRINT ""
425 PRINT "What bait # do you want to use? (1-30)"
430 INPUT bait$
440 COLOR 7
450 PRINT "Okay. Now what coordinates do you want to drop your hook in?"
460 INPUT place$
470 IF place$ = "a1" THEN GOTO 1010
480 IF place$ = "b1" THEN GOTO 1010
490 IF place$ = "c1" THEN GOTO 1010
500 IF place$ = "d1" THEN GOTO 1010
510 IF place$ = "e1" THEN GOTO 1010
520 IF place$ = "f4" THEN GOTO 1010
530 IF place$ = "u7" THEN GOTO 1010
540 IF place$ = "b6" THEN GOTO 1010
550 IF place$ = "b5" THEN GOTO 1010
560 IF place$ = "q6" THEN GOTO 1010
570 IF place$ = "t6" THEN GOTO 1010
580 IF place$ = "m5" THEN GOTO 1010
590 IF place$ = "n3" THEN GOTO 1010
600 IF place$ = "d7" THEN GOTO 1010
610 IF place$ = "p3" THEN GOTO 1010
620 IF place$ = "e6" THEN GOTO 1010
630 IF place$ = "f2" THEN GOTO 1010
640 IF place$ = "f1" THEN GOTO 1010
650 IF place$ = "t3" THEN GOTO 1010
660 IF place$ = "h5" THEN GOTO 1010
670 IF place$ = "i2" THEN GOTO 1010
680 IF place$ = "j4" THEN GOTO 1010
690 IF place$ = "j7" THEN GOTO 1010
700 IF place$ = "k2" THEN GOTO 1010
710 IF place$ = "a3" THEN GOTO 1010
720 IF place$ = "q4" THEN GOTO 1010
730 IF place$ = "u2" THEN GOTO 1010
740 IF place$ = "u1" THEN GOTO 1010
750 IF place$ = "quit" THEN GOTO 2000
1000 GOTO 1490
1010 PRINT "You have caught a fish "
1020 COLOR 1
1030 PRINT "   *     "
1040 PRINT " *   **** "
1050 PRINT "********* "
1060 PRINT "  **     *": GOTO 315
1490 PRINT "Sorry, you didn't catch one this time. Try again"
1500 COLOR 4
1520 PRINT "  *   *  "
1525 PRINT "   * *   "
1530 PRINT "    *    "
1540 PRINT "   * *   "
1550 PRINT "  *   *  "
1570 COLOR 7
1580 GOTO 315
2000 CLS
2010 PRINT "So did you like the game?"
2020 PRINT ""
2030 PRINT ""
2040 PRINT ""
2050 PRINT ""
2060 PRINT ""
2070 PRINT ""
2080 PRINT "Send me exactly what you thought of the game to:"
2090 PRINT "Screen name: Jonfish2"
2100 PRINT ""
2200 PRINT "Press enter to end"
2300 INPUT end$
2400 END

