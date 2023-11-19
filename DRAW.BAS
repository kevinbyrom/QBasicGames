'                                Draw v2.1
'                           By: Raymond Tedstrom
'
'     Please distribute this program to everyone you know that has a computer.
'If you like it, PLEASE send me $5 to $10.  I'm only 13, so that can really
'help.  I want to learn C++, but that's very expensive.  I have also
'programmed "Escape" and I'm working on a sequel to it.  You can contact me on
'America Online under the name Tedstrom or you can send mail to:
'                               108 Avon Dr.
'                             Taylors, SC 29687
'Thank you.

colord:
        CLS
        PRINT "                         Draw v2.1"
        PRINT "                    By: Raymond Tedstrom"
        PRINT
        INPUT "Do you want instructions"; inst$
        IF inst$ = "Y" OR inst$ = "y" THEN GOTO instructions
        PRINT " 1) Blue"
        PRINT " 2) Green"
        PRINT " 3) Cyan"
        PRINT " 4) Red"
        PRINT " 5) Magenta"
        PRINT " 6) Brown"
        PRINT " 7) White"
        PRINT " 8) Gray"
        PRINT " 9) Light Blue"
        PRINT "10) Light Green"
        PRINT "11) Light Cyan"
        PRINT "12) Light Red"
        PRINT "13) Light Magenta"
        PRINT "14) Yellow"
        PRINT "15) High-Intensity White"
        INPUT "What color would you like to use"; col
       
startp:   
        PRINT " 1) Center"
        PRINT " 2) Top-Left Corner"
        PRINT " 3) Top-Right Corner"
        PRINT " 4) Bottom-Left Corner"
        PRINT " 5) Bottom-Right Corner"
        INPUT "Where do you want to start"; loca
        IF loca = 1 THEN GOTO center
        IF loca = 2 THEN GOTO tl
        IF loca = 3 THEN GOTO tr
        IF loca = 4 THEN GOTO bl
        IF loca = 5 THEN GOTO br
        GOTO beginning
        
instructions:
        CLS
        PRINT "     This is sort of an Etch-a-Sketch for a computer.  Use the"
        PRINT "arrow keys on the numeritic keypad to draw.  Type q to exit"
        PRINT "Press enter to continue"
        INPUT enter: GOTO colord
       
beginning:
        SCREEN 12
        ON ERROR GOTO errorhandler
       
main:  
        COLOR col
        KEY(0) ON
        LINE (x, y)-(x, y)
        ON KEY(11) GOSUB up
        ON KEY(12) GOSUB left
        ON KEY(13) GOSUB right
        ON KEY(14) GOSUB down
        WHILE a$ <> "q"
        a$ = INKEY$
        WEND
        END

up:
        LET y = y - 1
        LINE (x, y)-(x, y)
        IF y < 0 THEN LET y = y + 1
        RETURN

left:
        LET x = x - 1
        LINE (x, y)-(x, y)
        IF x < 0 THEN LET x = x + 1
        RETURN

right:
        LET x = x + 1
        LINE (x, y)-(x, y)
        IF x > 639 THEN LET x = x - 1
        RETURN

down:
        LET y = y + 1
        LINE (x, y)-(x, y)
        IF y > 479 THEN LET y = y - 1
        RETURN

errorhandler:
        PRINT "You made an error"
        SLEEP 1
        GOTO beginning

center:
        x = 320
        y = 240
        GOTO beginning

tl:
        x = 0: y = 0
        GOTO beginning

tr:
        x = 639: y = 0
        GOTO beginning

bl:
        x = 0: y = 479
        GOTO beginning

br:
        x = 639: y = 479
        GOTO beginning

