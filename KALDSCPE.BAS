' ** KaldScpe.BAS ** (kaleidoscope)
' ** 1993 Fred Sexton Jr.
' **
DEFINT A-Z                             'set default variable type to integer
DECLARE SUB RandPal ()                 'SUB to randomize the palette

SCREEN 12                              'high resolution graphics mode
RANDOMIZE TIMER                        'seed random number generator
FourMode = NOT FourMode                'set initial mode flag to -1
MaxRandomX = 319                       'half width (starts at 0)
MaxRandomY = 239                       'half height (starts at 0)

RandPal                                'randomize the palette

DO                                     'start of main loop

    COLOR RND * 14 + 1                 'set current color to random (1 to 15)
    X1 = RND * MaxRandomX              'set X1 to a random (0 to max)
    Y1 = RND * MaxRandomY              'ditto for Y1
    X2 = RND * MaxRandomX              'ditto for X2
    Y2 = RND * MaxRandomY              'ditto for Y2

    StepX1 = RND * 4 - 2               'set StepX1 to random (-2 to 2)
    StepY1 = RND * 4 - 2               'ditto for StepY1
    StepX2 = RND * 4 - 2               'ditto for StepX2
    StepY2 = RND * 4 - 2               'ditto for StepY2
    
    IF FourMode THEN                   'do the appropriate mode
                                       'four part mode
        FOR Times = 1 TO 30            'do 30 sets of lines

            X3 = 639 - X1              'calculate points for
            X4 = 639 - X2              '4 lines
            Y3 = 479 - Y1              '4 X values
            Y4 = 479 - Y2              '4 Y values

            LINE (X1, Y1)-(X2, Y2)     'draw the lines
            LINE (X3, Y1)-(X4, Y2)
            LINE (X1, Y3)-(X2, Y4)
            LINE (X3, Y3)-(X4, Y4)

            X1 = X1 + StepX1           'adjust with step value
            Y1 = Y1 + StepY1           'ditto
            X2 = X2 + StepX2           'ditto
            Y2 = Y2 + StepY2           'ditto
        NEXT
   
    ELSE
                                       '16 part mode
        FOR Times = 1 TO 30            'do 30 sets of lines

            X3 = 319 - X1              'calculate points for
            X4 = 319 - X2              '16 lines
            X5 = X1 + 320              '8 X values
            X6 = X2 + 320
            X7 = X3 + 320
            X8 = X4 + 320

            Y3 = 239 - Y1              '8 Y values
            Y4 = 239 - Y2
            Y5 = Y1 + 240
            Y6 = Y2 + 240
            Y7 = Y3 + 240
            Y8 = Y4 + 240

            LINE (X1, Y1)-(X2, Y2)     'draw the lines
            LINE (X3, Y1)-(X4, Y2)
            LINE (X1, Y3)-(X2, Y4)
            LINE (X3, Y3)-(X4, Y4)

            LINE (X5, Y1)-(X6, Y2)
            LINE (X7, Y1)-(X8, Y2)
            LINE (X5, Y3)-(X6, Y4)
            LINE (X7, Y3)-(X8, Y4)

            LINE (X1, Y5)-(X2, Y6)
            LINE (X3, Y5)-(X4, Y6)
            LINE (X1, Y7)-(X2, Y8)
            LINE (X3, Y7)-(X4, Y8)

            LINE (X5, Y5)-(X6, Y6)
            LINE (X7, Y5)-(X8, Y6)
            LINE (X5, Y7)-(X6, Y8)
            LINE (X7, Y7)-(X8, Y8)

            X1 = X1 + StepX1           'adjust with step value
            Y1 = Y1 + StepY1           'ditto
            X2 = X2 + StepX2           'ditto
            Y2 = Y2 + StepY2           'ditto
        NEXT

    END IF

    LoopCount = LoopCount + 1          'count the number of loops
    IF LoopCount = 100 THEN            'after 100 loops
        LoopCount = 0                  'reset loop count
        FourMode = NOT FourMode        'toggle mode flag
        IF FourMode THEN               'set maxes for next mode
            MaxRandomX = 319           'half width (starts at 0)
            MaxRandomY = 239           'half height (starts at 0)
        ELSE
            MaxRandomX = 159           'quarter width (starts at 0)
            MaxRandomY = 119           'quarter height (starts at 0)
        END IF
        CLS                            'clear the screen
        RandPal                        'randomize the palette
    END IF

    KeyStroke$ = INKEY$                'get any keystrokes
    IF LEN(KeyStroke$) THEN KeyVal = ASC(KeyStroke$)   'convert to an integer

LOOP WHILE KeyVal <> 27                'keep going until escape is pressed

END

SUB RandPal

    FOR WorkColor = 1 TO 15            'do colors 1 to 15

        red = RND * 63                 'random red intensity value (0-63)
        green = RND * 63               'ditto for green
        blue = RND * 63                'ditto for blue

        PALETTE WorkColor, 65536 * blue + 256 * green + red
                                       'set each color to random intensities
    NEXT

END SUB
