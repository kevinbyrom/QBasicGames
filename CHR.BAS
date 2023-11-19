'       You may (and are encouraged to) use and distribute this freely
'                   (just don't upload it as shareware)
'
'          Hold <CONTROL> and press <PAUSE BREAK> to stop
'
CLS
'  Beginning of loop
st:
'  Put keypress in i$
i$ = INKEY$


'                    F1  =  CHR$(0) + CHR$(59)
IF i$ = CHR$(0) + CHR$(59) THEN CLS : PRINT : PRINT : PRINT : PRINT , "F1"


'                    F2  =  CHR$(0) + CHR$(60)
IF i$ = CHR$(0) + CHR$(60) THEN CLS : PRINT : PRINT : PRINT : PRINT , "F2"


'                    F3  =  CHR$(0) + CHR$(61)
IF i$ = CHR$(0) + CHR$(61) THEN CLS : PRINT : PRINT : PRINT : PRINT , "F3"


'                    F4  =  CHR$(0) + CHR$(62)
IF i$ = CHR$(0) + CHR$(62) THEN CLS : PRINT : PRINT : PRINT : PRINT , "F4"


'                    F5  =  CHR$(0) + CHR$(63)
IF i$ = CHR$(0) + CHR$(63) THEN CLS : PRINT : PRINT : PRINT : PRINT , "F5"


'                    F6  =  CHR$(0) + CHR$(64)
IF i$ = CHR$(0) + CHR$(64) THEN CLS : PRINT : PRINT : PRINT : PRINT , "F6"


'                    F7  =  CHR$(0) + CHR$(65)
IF i$ = CHR$(0) + CHR$(65) THEN CLS : PRINT : PRINT : PRINT : PRINT , "F7"


'                    F8  =  CHR$(0) + CHR$(66)
IF i$ = CHR$(0) + CHR$(66) THEN CLS : PRINT : PRINT : PRINT : PRINT , "F8"


'                    F9  =  CHR$(0) + CHR$(67)
IF i$ = CHR$(0) + CHR$(67) THEN CLS : PRINT : PRINT : PRINT : PRINT , "F9"


'                    F10  =  CHR$(0) + CHR$(68)
IF i$ = CHR$(0) + CHR$(68) THEN CLS : PRINT : PRINT : PRINT : PRINT , "F10"


'                    F11  =  CHR$(0) + CHR$(133)
IF i$ = CHR$(0) + CHR$(133) THEN CLS : PRINT : PRINT : PRINT : PRINT , "F11"


'                    F12  =  CHR$(0) + CHR$(134)
IF i$ = CHR$(0) + CHR$(134) THEN CLS : PRINT : PRINT : PRINT : PRINT , "F12"


'                        Tab  =  CHR$(9)
IF i$ = CHR$(9) THEN CLS : PRINT : PRINT : PRINT : PRINT , "Tab"


'                        ESC  =  CHR$(27)
IF i$ = CHR$(27) THEN CLS : PRINT : PRINT : PRINT : PRINT , "Esc"


'                        Up  =  CHR$(0) + "H"
IF i$ = CHR$(0) + "H" THEN CLS : PRINT : PRINT : PRINT : PRINT , "Up arrow key"


'                      Down  =  CHR$(0) + "P"
IF i$ = CHR$(0) + "P" THEN CLS : PRINT : PRINT : PRINT : PRINT , "Down arrow key"


'                      Left  =  CHR$(0) + "K"
IF i$ = CHR$(0) + "K" THEN CLS : PRINT : PRINT : PRINT : PRINT , "Left arrow key"


'                     Right  =  CHR$(0) + "M"
IF i$ = CHR$(0) + "M" THEN CLS : PRINT : PRINT : PRINT : PRINT , "Right arrow key"


'                           Enter  =  CHR$(13)
IF i$ = CHR$(13) THEN CLS : PRINT : PRINT : PRINT : PRINT , "Enter"


'                        Space Bar  =  CHR$(32)
IF i$ = CHR$(32) THEN CLS : PRINT : PRINT : PRINT : PRINT , "Space Bar"

GOTO st

