DECLARE SUB FONT (A$, X%, Y%, stepX%, stepY%, CO%, Background%, SHADOW%)
DECLARE SUB SETHUES (HUE() AS ANY, SC%, EC%)
'$DYNAMIC
DEFINT A-Z
 TYPE HUES
  RED AS INTEGER
  GRN AS INTEGER
  BLU AS INTEGER
 END TYPE

CLS : SCREEN 13
 REDIM PAL(255) AS HUES         'Dim the palette array as HUES
 DEF SEG = VARSEG(PAL(0))        'Point to the pal array
 BLOAD "SET.PAL", 0           'Load the palette file
 SETHUES PAL(), 0, 255              'Set the system colors w/pal array

   FOR I = 125 TO 115 STEP -1
  FONT "TURBO PONG", 110, 90, 8, 0, I, 0, 0
   FOR N = 1 TO 30000
    IF N = 1 THEN S = 2
   NEXT N
   NEXT I
   SLEEP 1
   FOR I = 115 TO 125
  FONT "TURBO PONG", 110, 90, 8, 0, I, 0, 0
   FOR N = 1 TO 30000
    IF N = 1 THEN S = 2
   NEXT N
   NEXT I
   SLEEP 1
   CLS

 OPEN "TP_SCR1.QBI" FOR INPUT AS #1
  FILESIZE& = LOF(1)
 CLOSE
  ARY = (FILESIZE& - 7) / 2 - 1
REDIM SCR1(32002)
DEF SEG = VARSEG(SCR1(1))
BLOAD "TP_SCR1.QBI", VARPTRIM(SCR1(1))

PUT (0, 0), SCR1, PSET
SLEEP 5
 OPEN "TP_SCR2.QBI" FOR INPUT AS #1
  FILESIZE& = LOF(1)
 CLOSE
  ARY = (FILESIZE& - 7) / 2 - 1
REDIM SCR1(32002)
DEF SEG = VARSEG(SCR1(1))
BLOAD "TP_SCR2.QBI", VARPTRIM(SCR1(1))

PUT (0, 0), SCR1, PSET
SLEEP 5
CLS
   FOR I = 125 TO 115 STEP -1
  FONT "Road Warrior", 100, 90, 8, 0, I, 0, 0
   FOR N = 1 TO 30000
    IF N = 1 THEN S = 2
   NEXT N
   NEXT I
   SLEEP 1
   FOR I = 115 TO 125
  FONT "Road Warrior", 100, 90, 8, 0, I, 0, 0
   FOR N = 1 TO 30000
    IF N = 1 THEN S = 2
   NEXT N
   NEXT I
   SLEEP 1
   CLS
 OPEN "RW_SCR1.QBI" FOR INPUT AS #1
  FILESIZE& = LOF(1)
 CLOSE
  ARY = (FILESIZE& - 7) / 2 - 1
REDIM SCR1(32002)
DEF SEG = VARSEG(SCR1(1))
BLOAD "RW_SCR1.QBI", VARPTRIM(SCR1(1))

PUT (0, 0), SCR1, PSET
SLEEP 6
  CLS
 OPEN "RW_SCR2.QBI" FOR INPUT AS #1
  FILESIZE& = LOF(1)
 CLOSE
  ARY = (FILESIZE& - 7) / 2 - 1
REDIM SCR1(32002)
DEF SEG = VARSEG(SCR1(1))
BLOAD "RW_SCR2.QBI", VARPTRIM(SCR1(1))

PUT (0, 0), SCR1, PSET
SLEEP 6
CLS
   FOR I = 125 TO 115 STEP -1
  FONT "MEGA MAZE 3D", 105, 90, 8, 0, I, 0, 0
   FOR N = 1 TO 30000
    IF N = 1 THEN S = 2
   NEXT N
   NEXT I
   SLEEP 1
   FOR I = 115 TO 125
  FONT "MEGA MAZE 3D", 105, 90, 8, 0, I, 0, 0
   FOR N = 1 TO 30000
    IF N = 1 THEN S = 2
   NEXT N
   NEXT I
   SLEEP 1
   CLS
 OPEN "MM3D.QBI" FOR INPUT AS #1
  FILESIZE& = LOF(1)
 CLOSE
  ARY = (FILESIZE& - 7) / 2 - 1
REDIM SCR1(ARY)
DEF SEG = VARSEG(SCR1(1))
BLOAD "MM3D.QBI", VARPTRIM(SCR1(1))

PUT (0, 0), SCR1, PSET
SLEEP 8

CLS
SYSTEM

REM $STATIC
SUB FONT (A$, X%, Y%, stepX%, stepY%, CO%, Background%, SHADOW%)
extX% = stepX%: extY% = stepY%
DEF SEG = &HFFA6
 FOR I% = 1 TO LEN(A$)
   addr% = 8 * ASC(MID$(A$, I%)) + 14
IF Background% THEN
IF Background% = 256 THEN BG% = false ELSE BG% = Background%
                                                         
IF I% = LEN(A$) THEN extX% = false: extY% = false
LINE (X%, Y%)-(X% + 7 + extX%, Y% + 7 + extY%), BG%, BF
END IF
FOR j% = 0 TO 7
mask% = PEEK(addr% + j%) * 128
IF SHADOW% > 0 THEN
LINE (X% + 9, Y% + j% + 2)-(X% + 2, Y% + j% + 2), SHADOW%, , mask%
END IF
LINE (X% + 7, Y% + j%)-(X%, Y% + j%), CO%, , mask%
NEXT
X% = X% + extX%
Y% = Y% + extY%
NEXT
DEF SEG
END SUB

SUB SETHUES (HUE() AS HUES, SC, EC)
DEFINT A-Z
 OUT &H3C8, SC
 FOR I = SC TO EC
   OUT &H3C9, HUE(I).RED: OUT &H3C9, HUE(I).GRN: OUT &H3C9, HUE(I).BLU
 NEXT

END SUB

