

DEFINT A-Z
'Russian Roulette 1995
'Mono
'Plastic Pithair Software
'
'
'
'
'
'
'
'
'
'
'
'
'
DECLARE SUB bigletter (Word$, Size, Clr, Style, Position)
SCREEN 12
RANDOMIZE TIMER




FOR time = 1 TO 30
LOCATE 30
PRINT
NEXT time

bigletter "Russian", 5, 4, 1, 20

bigletter "Roulette", 3, 3, 3, 90

PRINT "                           PLaSTiC PiTHaiR SoFTWaRe <1995>"
PRINT : PRINT : PRINT : PRINT : PRINT : PRINT : PRINT : PRINT : PRINT : PRINT
COLOR 4
PRINT "DISCLAIMER DISCLAIMER DISCLAIMER DISCLAIMER DISCLAIMER DISCLAIMER DISCLAIMER"
COLOR 15: PRINT "This program is only a GAME. We strongly discourage"
PRINT "playing Russian Roulette anywhere but on your computer"
COLOR 4
PRINT "DISCLAIMER DISCLAIMER DISCLAIMER DISCLAIMER DISCLAIMER DISCLAIMER DISCLAIMER"
COLOR 15: PRINT
INPUT "This is the game of Russian Roulette. Do you need instructions?(y/n) "; a$
IF a$ = "y" THEN GOTO 10000
2
PRINT
PRINT "Nothing happened. Heres the Gun."
INPUT c$
GOTO 3

END
1

PRINT : PRINT : PRINT : PRINT : PRINT : PRINT : PRINT "Here is the loaded revolver. Press return to"
PRINT "to fire the gun."
INPUT B$
3
IF RND(1) > .833333 THEN 70
PRINT
PRINT "Nothing happens. Give the gun to me."
SLEEP 1
IF RND(1) > .833333 THEN 90
GOTO 2
END
90
CLS
bigletter "BANG!", 5, 4, 1, 20
PRINT : PRINT : PRINT : PRINT : PRINT : PRINT : PRINT : PRINT "                                    You win"
GOTO 16
END
70
CLS
bigletter "Bang!", 5, 4, 1, 20
PRINT : PRINT : PRINT : PRINT : PRINT : PRINT : PRINT : PRINT : PRINT "You lose. Condolences will be sent to your loved ones."
PRINT : PRINT "                                   GAME  OVER"
GOTO 16
9999 END
10000   PRINT "                              --Instructions--"
PRINT : PRINT : PRINT : PRINT "One bullet is placed in the cylinder of a revolver. Then, the "
PRINT "cylinder is spun and the gun is placed to your head. You pull"
PRINT "the trigger and if nothing happens, you pass the gun to the"
PRINT "next player. Whoever 'dies' is the loser. "
GOTO 1
END
16 PRINT : PRINT "If you like this program, please let me know! I can be reached online"
PRINT "at MONO 10@AOL.COM. A free game will be sent to all who reply!"
SLEEP 4
END


DEFINT A-Z

SUB bigletter (Word$, Size, Clr, Style, Position)
    COLOR 15
    DIM Box(-1 TO 7, -1 TO 15)
    WordLength = LEN(Word$) * Size * 8
    WordHeight = Size * 16
    WordCenter = 320 - (WordLength / 2)
    PALETTE 15, 0
    FOR Letter = 1 TO LEN(Word$)
        LOCATE 1, 1
        PRINT MID$(Word$, Letter, 1)
        FOR x = 0 TO 7
            FOR y = 0 TO 15
                Box(x, y) = POINT(x, y)
            NEXT y
        NEXT x
        FOR x = 0 TO 7
            Left = WordCenter + (x * Size)
            Right = Left + Size
            LR = (Left + Right) \ 2
            FOR y = 0 TO 15
                Up = Position + (y * Size)
                Down = Up + Size
                UD = (Up + Down) \ 2
                IF Box(x, y) THEN
                    SELECT CASE Style
                        CASE 1
                            'Solid
                            LINE (Left, Up)-(Right, Down), Clr, BF
                        CASE 2
                            'Squares
                            LINE (Left, Up)-(Right, Down), Clr, B
                        CASE 3
                            'Slant (\)
                            LINE (Left, Up)-(Right, Down), Clr
                        CASE 4
                            'Slant II (/)
                            LINE (Right, Up)-(Left, Down), Clr
                        CASE 5
                            'Vertical Lines
                            LINE (LR, Up)-(LR, Down), Clr
                        CASE 6
                            'Horizontal Lines
                            LINE (Left, UD)-(Right, UD), Clr
                        CASE 7
                            'Crosses
                            LINE (LR, Up)-(LR, Down), Clr
                            LINE (Left, UD)-(Right, UD), Clr
                        CASE 8
                            'X's
                            LINE (Left, Up)-(Right, Down), Clr
                            LINE (Right, Up)-(Left, Down), Clr
                        CASE 9
                            'Outline
                            IF Box(x - 1, y) = 0 THEN LINE (Left, Up)-(Left, Down), Clr
                            IF Box(x + 1, y) = 0 THEN LINE (Right, Up)-(Right, Down), Clr
                            IF Box(x, y - 1) = 0 THEN LINE (Left, Up)-(Right, Up), Clr
                            IF Box(x, y + 1) = 0 THEN LINE (Left, Down)-(Right, Down), Clr
                        CASE 10
                            'Spider Web
                            IF Box(x - 1, y) THEN LINE (LR, UD)-(Left, UD), Clr
                            IF Box(x + 1, y) THEN LINE (LR, UD)-(Right, UD), Clr
                            IF Box(x, y - 1) THEN LINE (LR, UD)-(LR, Up), Clr
                            IF Box(x, y + 1) THEN LINE (LR, UD)-(LR, Down), Clr
                            IF Box(x - 1, y - 1) THEN LINE (LR, UD)-(Left, Up), Clr
                            IF Box(x + 1, y - 1) THEN LINE (LR, UD)-(Right, Up), Clr
                            IF Box(x - 1, y + 1) THEN LINE (LR, UD)-(Left, Down), Clr
                            IF Box(x + 1, y + 1) THEN LINE (LR, UD)-(Right, Down), Clr
                        CASE 11
                            'Bubbles
                            CIRCLE (LR, UD), Size \ 2, Clr
                        CASE 12
                            'Circles
                            CIRCLE (LR, UD), Size \ 2, Clr
                            PAINT STEP(0, 0), Clr
                        CASE 13
                            'Shadow
                            IF Box(x + 1, y) = 0 THEN LINE (Right, Up)-(Right, Down), Clr
                            IF Box(x, y + 1) = 0 THEN LINE (Left, Down)-(Right, Down), Clr
                            IF Box(x + 1, y + 1) = 0 THEN PSET (Right, Down), Clr
                        CASE 14
                            'Separated Squares
                            LINE (Left + 1, Up + 1)-(Right - 1, Down - 1), Clr, BF
                        CASE 15
                            LINE (Left, Down)-(LR, Up), Clr
                            LINE STEP(0, 0)-(Right, Down), Clr
                            LINE STEP(0, 0)-(Left, Down), Clr
                            LINE (Left, Up)-(Right, Up), Clr
                        END SELECT
                    END IF
                NEXT y
            NEXT x
            WordCenter = WordCenter + (Size * 8)
        NEXT Letter
        LOCATE 1, 1
        PRINT " "
        PALETTE

END SUB

