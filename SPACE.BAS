

SCREEN 12
FOR I% = 0 TO 4
COLOR I%
NEXT I%
123 CLS
PRINT ""
PRINT ""
PRINT ""
PRINT "           /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\"
PRINT "           /\/\/\/\/\/\/\/\/\/\Lazer Warz Main menu/\/\/\/\/\/\/\/\/\/\"
PRINT "           /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\"
PRINT ""
PRINT ""
PRINT ""
PRINT "           1. Play Lazer Warz!!!"
PRINT "           2. Read play control directions."
PRINT "           3. See some of the Ideas for the next lazer Warz version."
PRINT "           4. See the credits of this totaly awsome (sort of...) game!"
PRINT "           5. This game sounds to violent, so I'd better leave..."
INPUT menu$
IF menu$ = "1" THEN GOTO 1
IF menu$ = "2" THEN GOTO 2
IF menu$ = "3" THEN GOTO 1000000
IF menu$ = "4" THEN GOTO 1234
IF menu$ = "5" THEN GOTO 5 ELSE
CLS
PRINT "press 1, 2, 3, or 4... Sheesh! people these days just can't follow directions!"
SLEEP 2
GOTO 123
1234 CLS
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT "          /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\"
PRINT ""
PRINT "                                 LEAD PROGRAMER"
PRINT "                                   Maven Isen"
PRINT ""
PRINT "                              SECONDARY PROGRAMING"
PRINT "                                   Dave Levin"
PRINT ""
PRINT "                                   SOUND FX'S"
PRINT "                                   Maven Isen"
PRINT ""
PRINT "                                    MUSIC BY"
PRINT "                                   Dave Levin"
PRINT ""
PRINT "          /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\"
SLEEP 5
GOTO 123
5 CLS
PRINT "          /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\"
PRINT "           Are you sure you want to leave mass carnage behind Y or N"
PRINT "          /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\"
INPUT carnage$
IF carnage$ = "y" THEN GOTO 34081 ELSE
GOTO 123
34081 END
2 CLS
PRINT "                                    CONTROLS:"
PRINT "                     4 = MOVE LEFT             6 = MOVE RIGHT"
PRINT "                                    5 = SHOOT"
SLEEP 2
PRINT "DIRECTIONS:"
PRINT "            YOU ARE THE RED SHIP AT THE BOTTOM.  YOU MUST DESTROY THE       "
PRINT "  ENEMY SHIP BEFORE HE DESTROYS YOU.  WHEN THE ENEMY SHIP TURNS MAGENTA,"
PRINT "  WATCH OUT, BECAUSE HE IS CHARGING HIS WEAPON AND WILL SHOOT IN THE NEXT FEW"
PRINT "  SECONDS.  GOOD LUCK!"
SLEEP 7
GOTO 123

'************************************************************************************************

1 SCREEN 7
CLS
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT "             * MISSION 1 *"
scale$ = "CDDCCDEF"
PLAY "L8"
FOR I% = 0 TO 0
PLAY "O" + STR$(I%)
PLAY "X" + VARPTR$(scale$)
NEXT I%
SLEEP 2


SCREEN 12
CLS

    x = 320: bx = 320
    Y = 440: by = 50
    z = 40: bz = 50: bz2 = 30
    c = 4: bc = 0
           bm = 1
    dam = 0: bdam = 0
    



FOR t = 1 TO 1D+30
                   PAINT (x, Y), c, c
                   LINE (3, 3)-(637, 477), 3, BF
                
40  GOSUB 200
                   IF ammoshort > 0 THEN LET ammoshort = ammoshort - 1
                   IF bshoot > 2 THEN 405
                   IF bshoot > 1 THEN LET bshoot = bshoot + 1
                             IF bc = 5 THEN GOSUB 700
    CIRCLE (x, Y), z, c, , , .1
      m$ = INKEY$
      IF m$ = "" THEN 50
         IF m$ = "5" THEN GOSUB 300
50    IF m$ = "4" THEN lr = -10 ELSE lr = 0
      IF m$ = "6" THEN lr = 10
        IF x > 640 THEN LET x = 640
        IF x < 0 THEN LET x = 0
     
      x = x + lr
NEXT t







200   CIRCLE (bx, by), bz, bc, , , .1
        IF bx = 640 THEN bm = -1
        IF bx = 0 THEN bm = 1
LET bx = bx + bm
               RANDOMIZE TIMER
               ON INT(RND(1) * 40) + 1 GOTO 400, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290

290 RETURN

                    


300 IF ammoshort > 0 THEN 40

                                   
SOUND 9000, 2
 LINE (x, 430)-(x, 50), 1, , &HFF00
        IF x > bx - 40 AND x < bx + 40 THEN LET bdam = bdam + 1: SOUND 100, 2: SOUND 50, 2: SOUND 150, 2
        IF bdam = 20 THEN GOTO 500
                 LET ammoshort = 20
RETURN





                                                   

400 LET bc = 5: LET bshoot = bshoot + 1: GOTO 290
405
410             LINE (bx, 60)-(bx, 440), 5: SOUND 6500, 1
                        IF bx > x - 40 AND bx < x + 40 THEN LET dam = dam + 1: SOUND 40, 2: SOUND 45, 2: SOUND 37, 2
                        IF dam = 15 THEN 600
        LET bc = 0
        LET bshoot = 0
GOTO 40








500 CIRCLE (bx, by), 40, 4: PAINT (bx, by), 4, 4: GOSUB 1000
CIRCLE (bx - 41, by + 10), 30, 4: PAINT (bx - 41, by + 10), 4, 4: GOSUB 1000
CIRCLE (bx + 41, by - 5), 20, 4: PAINT (bx + 41, by - 5), 4, 4: GOSUB 1000
CLS
CIRCLE (bx, by), 100, 4: PAINT (bx, by), 4, 4: GOSUB 1000
CLS
CIRCLE (bx, by), 200, 4: PAINT (bx, by), 4, 4: GOSUB 1000
CLS
CIRCLE (bx, by), 300, 4: PAINT (bx, by), 4, 4: GOSUB 1000
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
CLS
PRINT "                                 you win!"
PLAY "o2l4t100a"
PLAY "mso3l4t100ddeea"
PLAY "mso3t100p8"
PLAY "mso3l8t100f#"
PLAY "mso3l4t100dd"
PLAY "mso2l4t100a"
PLAY "mso3l8t100g"
PLAY "p16"
PLAY "mso3l16t100g"
PLAY "mso3l4t100f#e"
PLAY "mso3l3t100d"
SLEEP 2
GOTO 21






FOR Y% = 0 TO 400 STEP 4
CLS
CIRCLE (x, Y), Y%, 4
PAINT (x, Y), 4, 4
CIRCLE (bx, by), 50, 5, , , .1
NEXT Y%
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
600 CLS
PRINT "                                 you lose!"
PLAY "mso2l4t90ggg"
PLAY "mso2l4t90b-"
PLAY "mso2l16t90a"
PLAY "mso2l4t90a"
PLAY "mso2l16t90g"
PLAY "mso2l4t90g"
PLAY "mso2l16t90f#"
PLAY "mso2l4t90g"
CLS
PRINT
PRINT
PRINT
PRINT
PRINT
PRINT
PRINT
PRINT "      What kind of Pethedic losser are you, losing on the first level"
PRINT "                      Do you want to try again Y or N"
INPUT a1$
IF a1$ = "y" THEN GOTO 1 ELSE
CLS
PRINT "   Due to your total lack of comitment, earth will be invaded and eventuly"
PRINT "                        destroyed. Have a nice day =)"

END





700  LINE (bx - 5, by - 5)-(bx + 5, by + 5), 5, BF
RETURN






1000 FOR I% = 0 TO 25000
NEXT I%
FOR I% = 0 TO 25000
NEXT I%
FOR I% = 0 TO 25000
NEXT I%
FOR I% = 0 TO 25000
NEXT I%
FOR I% = 0 TO 25000
NEXT I%
RETURN


'*****************************************************************************************

21 SCREEN 7
CLS
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT "             * MISSION 2 *"
scale$ = "CDDCCDEF"
PLAY "L8"
FOR I% = 0 TO 0
PLAY "O" + STR$(I%)
PLAY "X" + VARPTR$(scale$)
NEXT I%
SLEEP 2


SCREEN 12
CLS

    x = 320: bx = 320
    Y = 440: by = 50
    z = 40: bz = 30
    c = 4: bc = 0
           bm = 1
    dam = 0: bdam = 0
   



FOR t = 1 TO 1D+30
                   PAINT (x, Y), c, c
                   LINE (3, 3)-(637, 477), 14, BF
               
240  GOSUB 200
                   IF ammoshort > 0 THEN LET ammoshort = ammoshort - 1
                   IF bshoot > 2 THEN 2405
                   IF bshoot > 1 THEN LET bshoot = bshoot + 1
                             IF bc = 5 THEN GOSUB 2700
    CIRCLE (x, Y), z, c, , , .1
      m$ = INKEY$
      IF m$ = "" THEN 250
         IF m$ = "5" THEN GOSUB 2300
250    IF m$ = "4" THEN lr = -10 ELSE lr = 0
       IF m$ = "6" THEN lr = 10
        IF x > 640 THEN LET x = 640
        IF x < 0 THEN LET x = 0
       
    x = x + lr
NEXT t







2200   CIRCLE (bx, by), bz, bc, , , .1
        IF bx = 640 THEN bm = -1
        IF bx = 0 THEN bm = 1
LET bx = bx + bm
               RANDOMIZE TIMER
               ON INT(RND(1) * 40) + 1 GOTO 2400, 2290, 2290, 2290, 2290, 2290, 2290, 2290, 2290, 2290, 2290, 2290, 2290, 2290, 2290, 2290, 2290, 2290, 2290, 2290, 2290, 2290, 2290, 2290, 2290, 2290, 2290, 2290, 2290, 2290, 2290, 2290, 2290, 2290, 2290, 2290, 2290, 2290, 2290, 2290

2290 RETURN

                   


2300 IF ammoshort > 0 THEN 240

                                  
SOUND 9000, 2
 LINE (x, 430)-(x, 50), 1, , &HFF00
        IF x > bx - 30 AND x < bx + 30 THEN LET bdam = bdam + 1: SOUND 100, 2: SOUND 50, 2: SOUND 150, 2
        IF bdam = 25 THEN GOTO 2500
                 LET ammoshort = 20
RETURN





                                                  

2400 LET bc = 5: LET bshoot = bshoot + 1: GOTO 2290
2405
2410             LINE (bx, 60)-(bx, 440), 5: SOUND 6500, 1
                        IF bx > x - 40 AND bx < x + 40 THEN LET dam = dam + 1: SOUND 40, 2: SOUND 45, 2: SOUND 37, 2
                        IF dam = 15 THEN 2600
        LET bc = 0
        LET bshoot = 0
GOTO 240








2500 CIRCLE (bx, by), 40, 4: PAINT (bx, by), 4, 4: GOSUB 21000
CIRCLE (bx - 41, by + 10), 30, 4: PAINT (bx - 41, by + 10), 4, 4: GOSUB 21000
CIRCLE (bx + 41, by - 5), 20, 4: PAINT (bx + 41, by - 5), 4, 4: GOSUB 21000
CLS
CIRCLE (bx, by), 100, 4: PAINT (bx, by), 4, 4: GOSUB 21000
CLS
CIRCLE (bx, by), 200, 4: PAINT (bx, by), 4, 4: GOSUB 21000
CLS
CIRCLE (bx, by), 300, 4: PAINT (bx, by), 4, 4: GOSUB 21000
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT "                                 you win!"
PLAY "o2l4t100a"
PLAY "mso3l4t100ddeea"
PLAY "mso3t100p8"
PLAY "mso3l8t100f#"
PLAY "mso3l4t100dd"
PLAY "mso2l4t100a"
PLAY "mso3l8t100g"
PLAY "p16"
PLAY "mso3l16t100g"
PLAY "mso3l4t100f#e"
PLAY "mso3l3t100d"

SLEEP 2
GOTO 31






2600 FOR Y% = 0 TO 400 STEP 4
CLS
CIRCLE (x, Y), Y%, 4
PAINT (x, Y), 4, 4
CIRCLE (bx, by), 50, 5, , , .1
NEXT Y%
CLS
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT "                                 you lose!"
PLAY "mso2l4t90ggg"
PLAY "mso2l4t90b-"
PLAY "mso2l16t90a"
PLAY "mso2l4t90a"
PLAY "mso2l16t90g"
PLAY "mso2l4t90g"
PLAY "mso2l16t90f#"
PLAY "mso2l4t90g"

SLEEP 2
CLS
PRINT "                 My drunk grandpa could do better then you!!!"
PRINT "                    would you like to try again Y or N?"
INPUT a2$
IF a2$ = "y" THEN GOTO 21 ELSE
CLS
PRINT "   Due to your total lack of comitment, earth will be invaded and eventuly"
PRINT "                        destroyed. Have a nice day =)"
SLEEP 2
END




2700  LINE (bx - 5, by - 5)-(bx + 5, by + 5), 5, BF
RETURN






21000 FOR I% = 0 TO 25000
NEXT I%
FOR I% = 0 TO 25000
NEXT I%
FOR I% = 0 TO 25000
NEXT I%
FOR I% = 0 TO 25000
NEXT I%
FOR I% = 0 TO 25000
NEXT I%
RETURN


'************************************************************************************


31 SCREEN 7
CLS
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT "             * MISSION 3 *"
scale$ = "CDDCCDEF"
PLAY "L8"
FOR I% = 0 TO 0
PLAY "O" + STR$(I%)
PLAY "X" + VARPTR$(scale$)
NEXT I%
SLEEP 2


SCREEN 12
CLS

    x = 320: bx = 320
    Y = 440: by = 50
    z = 40: bz = 40
    c = 4: bc = 0
           bm = 1.25
    dam = 0: bdam = 0
   



FOR t = 1 TO 1D+30
                   PAINT (x, Y), c, c
                   LINE (3, 3)-(637, 477), 10, BF
               
340  GOSUB 3200
                   IF ammoshort > 0 THEN LET ammoshort = ammoshort - 1
                   IF bshoot > 1 THEN 3405
                   IF bshoot > 1 THEN LET bshoot = bshoot + 1
                             IF bc = 5 THEN GOSUB 3700
    CIRCLE (x, Y), z, c, , , .1
      m$ = INKEY$
      IF m$ = "" THEN 350
         IF m$ = "5" THEN GOSUB 3300
350    IF m$ = "4" THEN lr = -10 ELSE lr = 0
       IF m$ = "6" THEN lr = 10
        IF x > 640 THEN LET x = 640
        IF x < 0 THEN LET x = 0
       
    x = x + lr
NEXT t







3200   CIRCLE (bx, by), bz, bc, , , .1
        IF bx > 640 THEN bm = -1.25
        IF bx < 0 THEN bm = 1.25
LET bx = bx + bm
               RANDOMIZE TIMER
               ON INT(RND(1) * 40) + 1 GOTO 3400, 3290, 3290, 3290, 3290, 3290, 3290, 3290, 3290, 3290, 3290, 3290, 3290, 3290, 3290, 3290, 3290, 3290, 3290, 3290, 3290, 3290, 3290, 3290, 3290, 3290, 3290, 3290, 3290, 3290, 3290, 3290, 3290, 3290, 3290, 3290, 3290, 3290, 3290, 3290

3290 RETURN

                   


3300 IF ammoshort > 0 THEN 340

                                  
SOUND 9000, 2
 LINE (x, 430)-(x, 50), 1, , &HFF00
        IF x > bx - 40 AND x < bx + 40 THEN LET bdam = bdam + 1: SOUND 100, 2: SOUND 50, 2: SOUND 150, 2
        IF bdam = 25 THEN GOTO 3500
                 LET ammoshort = 20
RETURN





                                                  

3400 LET bc = 5: LET bshoot = bshoot + 1: GOTO 3290
3405
3410             LINE (bx, 60)-(bx, 440), 5: SOUND 6500, 1
                        IF bx > x - 40 AND bx < x + 40 THEN LET dam = dam + 1: SOUND 40, 2: SOUND 45, 2: SOUND 37, 2
                        IF dam = 15 THEN 3600
        LET bc = 0
        LET bshoot = 0
GOTO 340








3500 CIRCLE (bx, by), 40, 4: PAINT (bx, by), 4, 4: GOSUB 31000
CIRCLE (bx - 41, by + 10), 30, 4: PAINT (bx - 41, by + 10), 4, 4: GOSUB 31000
CIRCLE (bx + 41, by - 5), 20, 4: PAINT (bx + 41, by - 5), 4, 4: GOSUB 31000
CLS
CIRCLE (bx, by), 100, 4: PAINT (bx, by), 4, 4: GOSUB 31000
CLS
CIRCLE (bx, by), 200, 4: PAINT (bx, by), 4, 4: GOSUB 31000
CLS
CIRCLE (bx, by), 300, 4: PAINT (bx, by), 4, 4: GOSUB 31000
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT "                                 you win!"

PLAY "o2l4t100a"
PLAY "mso3l4t100ddeea"
PLAY "mso3t100p8"
PLAY "mso3l8t100f#"
PLAY "mso3l4t100dd"
PLAY "mso2l4t100a"
PLAY "mso3l8t100g"
PLAY "p16"
PLAY "mso3l16t100g"
PLAY "mso3l4t100f#e"
PLAY "mso3l3t100d"
SLEEP 2
GOTO 41






3600 FOR Y% = 0 TO 400 STEP 4
CLS
CIRCLE (x, Y), Y%, 4
PAINT (x, Y), 4, 4
CIRCLE (bx, by), 50, 5, , , .1
NEXT Y%
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT "                                 you lose!"
PLAY "mso2l4t90ggg"
PLAY "mso2l4t90b-"
PLAY "mso2l16t90a"
PLAY "mso2l4t90a"
PLAY "mso2l16t90g"
PLAY "mso2l4t90g"
PLAY "mso2l16t90f#"
PLAY "mso2l4t90g"
SLEEP 2
CLS
PRINT "                        you smell like rhino pizzle"
PRINT "                    would you like to try again Y or N?"
INPUT a2$
IF a2$ = "y" THEN GOTO 31 ELSE
CLS
PRINT "   Due to your total lack of comitment, earth will be invaded and eventuly"
PRINT "                        destroyed. Have a nice day =)"
SLEEP 2
END





3700  LINE (bx - 5, by - 5)-(bx + 5, by + 5), 5, BF
RETURN






31000 FOR I% = 0 TO 25000
NEXT I%
FOR I% = 0 TO 25000
NEXT I%
FOR I% = 0 TO 25000
NEXT I%
FOR I% = 0 TO 25000
NEXT I%
FOR I% = 0 TO 25000
NEXT I%
RETURN




'************************************************************************************************

41 SCREEN 7
CLS
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT "             * MISSION 4 *"
scale$ = "CDDCCDEF"
PLAY "L8"
FOR I% = 0 TO 0
PLAY "O" + STR$(I%)
PLAY "X" + VARPTR$(scale$)
NEXT I%
SLEEP 2


SCREEN 12
CLS

    x = 320: bx = 320
    Y = 440: by = 50
    z = 40: bz = 40
    c = 4: bc = 0
           bm = 1
    dam = 0: bdam = 0
   



FOR t = 1 TO 1D+30
                   PAINT (x, Y), c, c
                   LINE (3, 3)-(637, 477), 0, BF
               
440  GOSUB 4200
                   IF ammoshort > 0 THEN LET ammoshort = ammoshort - 1
                   IF bshoot > 1 THEN 4405
                   IF bshoot > 1 THEN LET bshoot = bshoot + 1
                             IF bc = 5 THEN GOSUB 4700
    CIRCLE (x, Y), z, c, , , .1
      m$ = INKEY$
      IF m$ = "" THEN 450
         IF m$ = "5" THEN GOSUB 4300
450    IF m$ = "4" THEN lr = -10 ELSE lr = 0
       IF m$ = "6" THEN lr = 10
        IF x > 640 THEN LET x = 640
        IF x < 0 THEN LET x = 0
       
    x = x + lr
NEXT t







4200   CIRCLE (bx, by), bz, bc, , , .1
        IF bx = 640 THEN bm = -1
        IF bx = 0 THEN bm = 1
LET bx = bx + bm
               RANDOMIZE TIMER
               ON INT(RND(1) * 40) + 1 GOTO 4400, 4290, 4290, 4290, 4290, 4290, 4290, 4290, 4290, 4290, 4290, 4290, 4290, 4290, 4290, 4290, 4290, 4290, 4290, 4290, 4290, 4290, 4290, 4290, 4290, 4290, 4290, 4290, 4290, 4290, 4290, 4290, 4290, 4290, 4290, 4290, 4290, 4290, 4290, 4290

4290 RETURN

                   


4300 IF ammoshort > 0 THEN 440

                                  
SOUND 9000, 2
 LINE (x, 430)-(x, 50), 1, , &HFF00
        IF x > bx - 40 AND x < bx + 40 THEN LET bdam = bdam + 1: SOUND 100, 2: SOUND 50, 2: SOUND 150, 2
        IF bdam = 25 THEN GOTO 4500
                 LET ammoshort = 20
RETURN





                                                  

4400 LET bc = 5: LET bshoot = bshoot + 1: GOTO 4290
4405
4410             LINE (bx, 60)-(bx, 440), 5: SOUND 6500, 1
                        IF bx > x - 40 AND bx < x + 40 THEN LET dam = dam + 1: SOUND 40, 2: SOUND 45, 2: SOUND 37, 2
                        IF dam = 15 THEN 4600
        LET bc = 0
        LET bshoot = 0
GOTO 440








4500 CIRCLE (bx, by), 40, 4: PAINT (bx, by), 4, 4: GOSUB 41000
CIRCLE (bx - 41, by + 10), 30, 4: PAINT (bx - 41, by + 10), 4, 4: GOSUB 41000
CIRCLE (bx + 41, by - 5), 20, 4: PAINT (bx + 41, by - 5), 4, 4: GOSUB 41000
CLS
CIRCLE (bx, by), 100, 4: PAINT (bx, by), 4, 4: GOSUB 41000
CLS
CIRCLE (bx, by), 200, 4: PAINT (bx, by), 4, 4: GOSUB 41000
CLS
CIRCLE (bx, by), 300, 4: PAINT (bx, by), 4, 4: GOSUB 41000
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT "                                 you win!"
PLAY "o2l4t100a"
PLAY "mso3l4t100ddeea"
PLAY "mso3t100p8"
PLAY "mso3l8t100f#"
PLAY "mso3l4t100dd"
PLAY "mso2l4t100a"
PLAY "mso3l8t100g"
PLAY "p16"
PLAY "mso3l16t100g"
PLAY "mso3l4t100f#e"
PLAY "mso3l3t100d"

SLEEP 2
GOTO 51






4600 FOR Y% = 0 TO 400 STEP 4
CLS
CIRCLE (x, Y), Y%, 4
PAINT (x, Y), 4, 4
CIRCLE (bx, by), 50, 5, , , .1
NEXT Y%
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT "                                 you lose!"
PLAY "mso2l4t90ggg"
PLAY "mso2l4t90b-"
PLAY "mso2l16t90a"
PLAY "mso2l4t90a"
PLAY "mso2l16t90g"
PLAY "mso2l4t90g"
PLAY "mso2l16t90f#"
PLAY "mso2l4t90g"
SLEEP 2
CLS
PRINT "                   Getting better... but you still stink!"
PRINT "                    would you like to try again Y or N?"
INPUT a2$
IF a2$ = "y" THEN GOTO 41 ELSE
CLS
PRINT "   Due to your total lack of comitment, earth will be invaded and eventuly"
PRINT "                        destroyed. Have a nice day =)"
SLEEP 2
END





4700  LINE (bx - 5, by - 5)-(bx + 5, by + 5), 5, BF
RETURN






41000 FOR I% = 0 TO 25000
NEXT I%
FOR I% = 0 TO 25000
NEXT I%
FOR I% = 0 TO 25000
NEXT I%
FOR I% = 0 TO 25000
NEXT I%
FOR I% = 0 TO 25000
NEXT I%
RETURN


'************************************************************************************************

51 CLEAR
SCREEN 7
CLS
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT "             * MISSION 5 *"
scale$ = "CDDCCDEF"
PLAY "L8"
FOR I% = 0 TO 0
PLAY "O" + STR$(I%)
PLAY "X" + VARPTR$(scale$)
NEXT I%
SLEEP 2


SCREEN 12
CLS

    x = 320: bx = 320
    Y = 440: by = 50
    z = 40: bz = 30
    c = 4: bc = 0
           bm = 1.25
    dam = 0: bdam = 0
   



FOR t = 1 TO 1D+30
                   PAINT (x, Y), c, c
                   LINE (3, 3)-(637, 477), 5, BF
               
540  GOSUB 200
                   IF ammoshort > 0 THEN LET ammoshort = ammoshort - 1
                   IF bshoot > 1 THEN 5405
                   IF bshoot > 1 THEN LET bshoot = bshoot + 1
                             IF bc = 5 THEN GOSUB 5700
    CIRCLE (x, Y), z, c, , , .1
      m$ = INKEY$
      IF m$ = "" THEN 550
         IF m$ = "5" THEN GOSUB 5300
550    IF m$ = "4" THEN lr = -10 ELSE lr = 0
       IF m$ = "6" THEN lr = 10
        IF x > 640 THEN LET x = 640
        IF x < 0 THEN LET x = 0
       
    x = x + lr
NEXT t







5200   CIRCLE (bx, by), bz, bc, , , .1
        IF bx > 640 THEN bm = -1.25
        IF bx < 0 THEN bm = 1.25
LET bx = bx + bm
               RANDOMIZE TIMER
               ON INT(RND(1) * 40) + 1 GOTO 5400, 5290, 5290, 5290, 5290, 5290, 5290, 5290, 5290, 5290, 5290, 5290, 5290, 5290, 5290, 5290, 5290, 5290, 5290, 5290, 5290, 5290, 5290, 5290, 5290, 5290, 5290, 5290, 5290, 5290, 5290, 5290, 5290, 5290, 5290, 5290, 5290, 5290, 5290, 5290

5290 RETURN

                   


5300 IF ammoshort > 0 THEN 540

SOUND 9000, 2
 LINE (x, 430)-(x, 50), 1, , &HFF00
        IF x > bx - 30 AND x < bx + 30 THEN LET bdam = bdam + 1: SOUND 100, 2: SOUND 50, 2: SOUND 150, 2
        IF bdam = 25 THEN GOTO 5500
                 LET ammoshort = 20
RETURN





                                                  

5400 LET bc = 5: LET bshoot = bshoot + 1: GOTO 5290
5405
5410             LINE (bx, 60)-(bx, 440), 2: SOUND 6500, 1
                        IF bx > x - 40 AND bx < x + 40 THEN LET dam = dam + 1: SOUND 40, 2: SOUND 45, 2: SOUND 37, 2
                        IF dam = 15 THEN 5600
        LET bc = 0
        LET bshoot = 0
GOTO 540








5500 CIRCLE (bx, by), 40, 4: PAINT (bx, by), 4, 4: GOSUB 51000
CIRCLE (bx - 41, by + 10), 30, 4: PAINT (bx - 41, by + 10), 4, 4: GOSUB 51000
CIRCLE (bx + 41, by - 5), 20, 4: PAINT (bx + 41, by - 5), 4, 4: GOSUB 51000
CLS
CIRCLE (bx, by), 100, 4: PAINT (bx, by), 4, 4: GOSUB 51000
CLS
CIRCLE (bx, by), 200, 4: PAINT (bx, by), 4, 4: GOSUB 51000
CLS
CIRCLE (bx, by), 300, 4: PAINT (bx, by), 4, 4: GOSUB 51000
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT "                                 you win!"
PLAY "o2l4t100a"
PLAY "mso3l4t100ddeea"
PLAY "mso3t100p8"
PLAY "mso3l8t100f#"
PLAY "mso3l4t100dd"
PLAY "mso2l4t100a"
PLAY "mso3l8t100g"
PLAY "p16"
PLAY "mso3l16t100g"
PLAY "mso3l4t100f#e"
PLAY "mso3l3t100d"

SLEEP 2
GOTO 61






5600 FOR Y% = 0 TO 400 STEP 4
CLS
CIRCLE (x, Y), Y%, 4
PAINT (x, Y), 4, 4
CIRCLE (bx, by), 50, 5, , , .1
NEXT Y%
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT "                                 you lose!"
PLAY "mso2l4t90ggg"
PLAY "mso2l4t90b-"
PLAY "mso2l16t90a"
PLAY "mso2l4t90a"
PLAY "mso2l16t90g"
PLAY "mso2l4t90g"
PLAY "mso2l16t90f#"
PLAY "mso2l4t90g"
SLEEP 2
CLS
PRINT "                   Not to shabby... Almost as good as me."
PRINT "                    would you like to try again Y or N?"
INPUT a2$
IF a2$ = "y" THEN GOTO 51 ELSE
CLS
PRINT "   Due to your total lack of comitment, earth will be invaded and eventuly"
PRINT "                        destroyed. Have a nice day =)"
SLEEP 2
END





5700  LINE (bx - 5, by - 5)-(bx + 5, by + 5), 5, BF
RETURN






51000 FOR I% = 0 TO 25000
NEXT I%
FOR I% = 0 TO 25000
NEXT I%
FOR I% = 0 TO 25000
NEXT I%
FOR I% = 0 TO 25000
NEXT I%
FOR I% = 0 TO 25000
NEXT I%
RETURN


'*****************************************************************************************


61 SCREEN 7
CLS
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT "             * MISSION 6 *"
scale$ = "CDDCCDEF"
PLAY "L8"
FOR I% = 0 TO 0
PLAY "O" + STR$(I%)
PLAY "X" + VARPTR$(scale$)
NEXT I%
SLEEP 2


SCREEN 12
CLS

    x = 320: bx = 320
    Y = 440: by = 50
    z = 40: bz = 150
    c = 4: bc = 0
           bm = 1
    dam = 0: bdam = 0
   



FOR t = 1 TO 1D+30
                   PAINT (x, Y), c, c
                   LINE (3, 3)-(637, 477), 3, BF
               
640  GOSUB 6200
                   IF ammoshort > 0 THEN LET ammoshort = ammoshort - 1
                   IF bshoot > 2 THEN 6405
                   IF bshoot > 1 THEN LET bshoot = bshoot + 1
                             IF bc = 5 THEN GOSUB 6700
    CIRCLE (x, Y), z, c, , , .1
      m$ = INKEY$
      IF m$ = "" THEN 650
         IF m$ = "5" THEN GOSUB 6300
650    IF m$ = "4" THEN lr = -10 ELSE lr = 0
       IF m$ = "6" THEN lr = 10
        IF x > 640 THEN LET x = 640
        IF x < 0 THEN LET x = 0
       
    x = x + lr
NEXT t







6200   CIRCLE (bx, by), bz, bc, , , .1
       CIRCLE (bx - 50, by), 10, bc
       CIRCLE (bx + 50, by), 10, bc
        IF bx = 640 THEN bm = -1
        IF bx = 0 THEN bm = 1
LET bx = bx + bm
               RANDOMIZE TIMER
               ON INT(RND(1) * 40) + 1 GOTO 6400, 6290, 6290, 6290, 6290, 6290, 6290, 6290, 6290, 6290, 6290, 6290, 6290, 6290, 6290, 6290, 6290, 6290, 6290, 6290, 6290, 6290, 6290, 6290, 6290, 6290, 6290, 6290, 6290, 6290, 6290, 6290, 6290, 6290, 6290, 6290, 6290, 6290, 6290, 6290

6290 RETURN

                   


6300 IF ammoshort > 0 THEN 640

                                  
SOUND 9000, 2
 LINE (x, 430)-(x, 50), 1, , &HFF00
        IF x > bx - 60 AND x < bx - 40 THEN LET bdam = bdam + 1: SOUND 100, 2: SOUND 50, 2: SOUND 150, 2
        IF x < bx + 60 AND x > bx + 40 THEN LET bdam = bdam + 1: SOUND 100, 2: SOUND 50, 2: SOUND 150, 2
        IF bdam = 20 THEN GOTO 6500
                 LET ammoshort = 20
RETURN





                                                  

6400 LET bc = 5: LET bshoot = bshoot + 1: GOTO 6290
6405
6410             LINE (bx - 50, 60)-(bx - 50, 440), 5: SOUND 6500, 1
                 LINE (bx + 50, 60)-(bx + 50, 440), 5: SOUND 6500, 1
                        IF bx + 50 > x - 40 AND bx + 50 < x + 40 THEN LET dam = dam + 1: SOUND 40, 2: SOUND 45, 2: SOUND 37, 2
                        IF bx - 50 > x - 40 AND bx - 50 < x + 40 THEN LET dam = dam + 1: SOUND 40, 2: SOUND 45, 2: SOUND 37, 2
                        IF dam = 15 THEN 6600
        LET bc = 0
        LET bshoot = 0
GOTO 640




6500 CIRCLE (bx, by), 40, 4: PAINT (bx, by), 4, 4: GOSUB 61000
CIRCLE (bx - 41, by + 10), 30, 4: PAINT (bx - 41, by + 10), 4, 4: GOSUB 61000
CIRCLE (bx + 41, by - 5), 20, 4: PAINT (bx + 41, by - 5), 4, 4: GOSUB 61000
CLS
CIRCLE (bx, by), 100, 4: PAINT (bx, by), 4, 4: GOSUB 61000
CLS
CIRCLE (bx, by), 200, 4: PAINT (bx, by), 4, 4: GOSUB 61000
CLS
CIRCLE (bx, by), 300, 4: PAINT (bx, by), 4, 4: GOSUB 61000
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT "                                 you win!"
SLEEP 2
CLS
PRINT "       Cogradulations you have saved earth from impending doom!!!"
PLAY "o2l4t100a"
PLAY "mso3l4t100ddeea"
PLAY "mso3t100p8"
PLAY "mso3l8t100f#"
PLAY "mso3l4t100dd"
PLAY "mso2l4t100a"
PLAY "mso3l8t100g"
PLAY "p16"
PLAY "mso3l16t100g"
PLAY "mso3l4t100f#e"
PLAY "mso3l3t100d"
SLEEP 5
CLS
PRINT "    If you like this cheeze game and you want more, challenging levels"
PRINT "                           E-mail me at DaveLevin@aol.com"
SLEEP 5
END






6600 FOR Y% = 0 TO 400 STEP 4
CLS
CIRCLE (x, Y), Y%, 4
PAINT (x, Y), 4, 4
CIRCLE (bx, by), 50, 5, , , .1
NEXT Y%
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT "                                 you lose!"
PLAY "mso2l4t90ggg"
PLAY "mso2l4t90b-"
PLAY "mso2l16t90a"
PLAY "mso2l4t90a"
PLAY "mso2l16t90g"
PLAY "mso2l4t90g"
PLAY "mso2l16t90f#"
PLAY "mso2l4t90g"
SLEEP 2
CLS
PRINT "                 You've almost got it... Don't give up now!!!"
PRINT "                    would you like to try again Y or N?"
INPUT a2$
IF a2$ = "y" THEN GOTO 61 ELSE
CLS
PRINT "   Due to your total lack of comitment, earth will be invaded and eventuly"
PRINT "                        destroyed. Have a nice day =)"
SLEEP 2
END





6700  LINE (bx - 5, by - 5)-(bx + 5, by + 5), 5, BF
RETURN






61000 FOR I% = 0 TO 25000
NEXT I%
FOR I% = 0 TO 25000
NEXT I%
FOR I% = 0 TO 25000
NEXT I%
FOR I% = 0 TO 25000
NEXT I%
FOR I% = 0 TO 25000
NEXT I%
END

1000000 CLS
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT "      /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\"
PRINT "      Version 1.2 of Lazer Warz is still rather prmitive but "
PRINT "      many great improvments have been made."
PRINT "      Some of the upgrades that were made from version "
PRINT "      1.0 are the menu, the cool critcizim after death, and the "
PRINT "      victory song. For future versions we wish to include a system"
PRINT "      of money, so that if you pass a level you can buy different "
PRINT "      types of lazers, and shields. Also we will make the ships much"
PRINT "      more detailed looking, And randomize the movment of the enemy"
PRINT "      ship. And possibly include more than one enemy at a time. If"
PRINT "      you have any Ideas E-Mail them to DaveLevin@aol.com and we will"
PRINT "      try our hardest to work it into the game. Or better yet if you"
PRINT "      can program in the QBasic language add to it yourself and send"
PRINT "      me the copy of it via, E-mail so I can add your name to the list"
PRINT "      of credits!!! Of course this is freeware so there is no charge"
PRINT "      for using it, but we ask you to get our writen concent before you "
PRINT "      up load it to another server.     - Maven & Dave-"
PRINT "      /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\"
INPUT future$
IF future$ = "1" GOTO 123 ELSE
GOTO 123

'*****************************************************************************************

