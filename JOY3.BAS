'ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
'บ                    Qbasic's First 3d Space Simulator                      บ
'บ                                                                           บ
'บ      Created at CrOnline, This demo is similar to LucasArt's "X-Wing" and บ
'บ "Tie Fighter".  Situated in a realistic, 3d space environment, this demo  บ
'บ features playability and ACTUAL entertainment that surpasses any game thatบ
'บ has been released on AOL using Microsoft's Qbasic up to date.             บ            บ
'บ      Because this is a product of CrOnline's Shareware Group, it is yours บ
'บ to distribute, but of course we don't want you to modify this game withoutบ
'บ expressed consent from CrOnline.  If you have any suggestions or comment  บ
'บ relating to this program please feel free to contact the following addressบ
'บ at America Online:                                                        บ
'บ                                                                           บ
'บ Benito4      (Lead Programmer)                                            บ                    
'บ                                                                           บ
'บ He will be happy to answer any questions you might have aswell.           บ                                                           บ
'บ                                                                           บ
'บ    Because CrOnline is a new company, Our staff is expanding to include   บ
'บ many new programmers, illustrators, and writers.  If you are interested   บ
'บ E-Mail the above address and include your Name, experience programming in บ
'บ Qbasic and preference (programmer, artist, musician, writer).             บ
'บ                            -enjoy-                                        บ
'ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
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
'

DEFINT A-Z
DECLARE SUB speed ()
DECLARE SUB CALIBRATION ()
DECLARE SUB Graphics ()
DECLARE SUB Title ()
DECLARE SUB Options ()
DECLARE SUB JoyStick ()
DECLARE SUB LEFT ()
DECLARE SUB right ()
DECLARE SUB UP ()
DECLARE SUB DOWN ()
DECLARE SUB Mission1 ()
DECLARE SUB Mission2 ()
DECLARE SUB Mission3 ()
DECLARE SUB Mission4 ()
DECLARE SUB makestars ()
DECLARE SUB enem ()
DIM SHARED counter, counterm, u, l, d, x2, y2, F, g, r, s, X, y, sp1, SP2, direction, rightm, leftm
DIM SHARED ENEMY(900)
DIM SHARED LOGO(300)
DEF FNR (X) = INT(RND * X) + 1
DIM SHARED E1(150), E2(50), E3(15), s1(500) ' dim arrays
DIM SHARED S2(500), F1(70), f2(40), R1(200)
DIM SHARED CX(50), CY(50), CT(50)
DIM SHARED TEMP(500)
DIM SHARED sx(50), sy(50), ST(50)
DIM SHARED COCKPIT(19000)
DIM SHARED enemydot(10)

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
 
CLS
FOR I = 1 TO 15000: NEXT
COLOR 7, 13

PRINT "ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป"
PRINT "บ                                                                              บ"
PRINT "บ                                                                              บ"
PRINT "บ                                                                              บ"
PRINT "บ                                                                              บ"
PRINT "บ                                                                              บ"
PRINT "บ                                                                              บ"
PRINT "บ                                                                              บ"
PRINT "บ                                                                              บ"
PRINT "บ                                                                              บ"
PRINT "บ                                                                              บ"
PRINT "บ                                                                              บ"
PRINT "ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ"
r2 = 3
cp = 15
sp = 2
SP2 = 2
1
READ d$
IF d$ = "c" THEN FOR I = 1 TO 10000: NEXT: cp = 10: r2 = r2 + 1: GOTO 1
IF d$ = "d" THEN cp = 31:   GOTO 1
IF d$ = "eof" THEN COLOR 0, 0: GOTO 2
a = LEN(d$) / 2
B = 40
r2 = r2 + 1
posx = B - a
LOCATE r2, posx: COLOR cp: PRINT d$
GOTO 1
DATA CrOnline ShareWare Group,Presents...,c,,QBasic's First 3d Space Simulator,d,,,press a key to continue, eof
2
r$ = INPUT$(1)
 
 
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
  '

  '
  '
  '
  '
  '
  '
  '

  SCREEN 7, 0, 1, 0
COLOR 8
LINE (27, 18)-(35, 22), , B
PAINT (28, 19), 7.3, 8
LINE (13, 18)-(5, 22), , B
PAINT (10, 19), 7, 8
LINE (5, 8)-(5, 32)
LINE (35, 8)-(35, 32)
CIRCLE (20, 20), 8
PAINT (20, 20), 7, 8
GET (4, 8)-(36, 33), ENEMY

                
CLS
COLOR 15
LINE (62, 74)-(64, 69)
LINE (64, 69)-(66, 73)
LINE (66, 73)-(70, 71)
LINE (62, 74)-(58, 76)
LINE (59, 76)-(62, 77)
LINE (70, 71)-(68, 75)
LINE -(72, 78)
LINE (62, 77)-(63, 81)
LINE (64, 81)-(66, 78)
LINE -(71, 79)
PAINT (63, 77), 12, 15
PSET (69, 72), 12
PSET (71, 78), 12
GET (57, 68)-(73, 82), LOGO

CLS
COLOR 9
CIRCLE (150, 90), 91
CIRCLE (150, 90), 87
LINE (147, 14)-(152, 1), 9, B
LINE (241, 88)-(300, 93), 9, B
LINE (59, 93)-(10, 88), 9, B
CIRCLE (30, 25), 18
CIRCLE (277, 25), 18
PAINT (50, 90), 1, 9
PAINT (240, 90), 1, 9
PAINT (243, 90), 1, 9
PAINT (10, 90), 1, 9
PAINT (149, 13), 1, 9
COLOR 15:
LINE (1, 1)-(315, 190), , B
LINE (5, 5)-(310, 185), , B
PAINT (2, 2), 9, 15
w2 = LEN("CrOnline") / 2
f2 = 20 - w2
LOCATE 23, f2: COLOR 1: PRINT "CrOnline"
LOCATE 22, 29: COLOR 15: PRINT "Benito4"
GET (1, 1)-(316, 190), COCKPIT


 CLS
COLOR 12:
PSET (10, 10)
GET (10, 10)-(10, 10), enemydot
CLS
CALIBRATION
makestars
'Graphics
'Title
'Options
' JoyStick
r = 10
counter = 10
LEFT

SUB CALIBRATION
 
SCREEN 7, 0, 1, 0



SCREEN 7, 0, 2, 0
COLOR , 7
LOCATE 1, 1: PRINT "                                    "
COLOR 15: LINE (50, 50)-(260, 150), , B
PAINT (1, 1), 3, 15
COLOR 15: LINE (260, 50)-(50, 50)
LINE -(50, 150)
COLOR 8: LINE (50, 150)-(260, 150)
         LINE -(260, 51)



SCREEN 7, 0, 2, 0: LOCATE 8, 13: PRINT "Move Joystick to"
                   LOCATE 9, 13: COLOR 15: PRINT "upper left"; : COLOR 8: PRINT " and "
                   LOCATE 10, 13: PRINT "press space."
PCOPY 2, 0
DO
SCREEN 7, 0, 2, 0: LOCATE 12, 13: COLOR 9: PRINT "                  ": LOCATE 12, 13: PRINT "("; a; ","; B; ")": PCOPY 2, 0
a = STICK(0)
B = STICK(1)
LOOP UNTIL INKEY$ = CHR$(32)
SCREEN 7, 0, 2, 0: COLOR 8: LOCATE 8, 13: PRINT "Move Joystick to"
                   LOCATE 9, 13: COLOR 15: PRINT "lower right "; : COLOR 8: PRINT "and"
                   LOCATE 10, 13: PRINT "press space."
PCOPY 2, 0
DO
SCREEN 7, 0, 2, 0: LOCATE 12, 13: COLOR 9: PRINT "("; a1; ","; b1; ")": PCOPY 2, 0
a1 = STICK(0)
b1 = STICK(1)
LOOP UNTIL INKEY$ = CHR$(32)
F = (a1 + a) / 2
g = (b1 + B) / 2
SCREEN 7, 0, 2, 0: LOCATE 1, 1: PRINT c, d
               CLS
               PCOPY 2, 0
               PCOPY 0, 0

END SUB

SUB enem
u = 1
d = 1

 IF X < F - 30 THEN LET u = 12
 IF X > F + 30 THEN LET u = -12

 
  IF sp1 < 4 THEN u = 0
   r = r + u
 
 

 
 IF r > 280 THEN r = 10: counter = -210

 IF r < 1 AND direction = rightm THEN LET counterm = -50
 
 IF r < 10 AND direction = rightm THEN
 IF r < -240 THEN r = 280: counter = 280
 IF X > F + 30 THEN LET counterm = counterm + 4
 IF counterm > 1 THEN
 r = 280
 counter = 280
 END IF
 END IF
 IF s < 10 THEN LET s = 180
 IF s > 180 THEN LET s = 10
 IF counter > 1 AND counter < 10 THEN r = 10
END SUB

SUB JoyStick
DO
X = STICK(0)
y = STICK(1)
  '  IF x > f + 30 THEN Right
    IF X < F - 30 THEN LEFT


LOOP

END SUB

'
'
SUB LEFT




COLOR , 0
T = 1
 DIM J(1 TO 100)
   DO
     T = T - 1
     O = O - 1
     IF T = -80 THEN ENEMY = 1:
     IF ENEMY = 1 THEN
     
      END IF
     X = STICK(0)
     y = STICK(1)
     IF X > F + 30 THEN direction = rightm: right
     IF X < F - 30 THEN direction = leftm
     IF y < g - 30 THEN k = 2
     IF y > g + 30 THEN k = 1
     IF NOT (y > g + 30) AND NOT (y < g - 30) THEN k = 0
    
     speed
    
     PCOPY 2, 0
    FOR I = 1 TO 50  'move & display stars
      IF ST(I) = 1 THEN c = 7 ELSE c = 15
      PSET (sx(I), sy(I)), c
 
      IF sp1 = 0 THEN GOTO 4
   
   ' SELECT CASE direction

  '  CASE LEFTm
      sx(I) = sx(I) + ST(I) + sp1
4
       IF k = 1 THEN
      sy(I) = sy(I) + ST(I) + 9
      IF sy(I) > 200 THEN sy(I) = 1
      END IF
  
      IF k = 2 THEN
      sy(I) = sy(I) + ST(I) - 9
      IF sy(I) < 1 THEN sy(I) = 200
      END IF
    
     
      IF sx(I) > 320 THEN
        sx(I) = 1: sy(I) = FNR(199)
        'st(i) = FNR(i)
      END IF

    NEXT I
 enem
IF counter > 1 THEN
PUT (r, s), ENEMY, OR
END IF
20

'LOCATE 1, 1: PRINT counter
IF counter > 1 OR counterm > 1 THEN
PUT (30, 25), enemydot, OR
LOCATE 22, 3: COLOR 8: PRINT "in front"
ELSE
PUT (277, 25), enemydot, OR
LOCATE 22, 3: COLOR 8: PRINT " behind "
END IF
IF y > g + 30 THEN s = s + 5: IF s > 150 THEN s = 10
IF y < g - 30 THEN s = s - 5: IF s < 10 THEN s = 150
PUT (102, 170), LOGO, OR
PUT (1, 1), COCKPIT, OR
PCOPY 0, 1  'copy template to viewing screen
ET = ET + 1  'cycle timer (add delays if too fast)
IF ET = 30 THEN  'activate enemies
EX = 350: EY = 200: ED = 1: EXD = -23: EYD = -8
END IF
d$ = INKEY$
c$ = UCASE$(INKEY$)
IF INKEY$ = "Q" THEN END
LOOP UNTIL INKEY$ = "Q"

 END SUB

SUB makestars
  SCREEN , , 0, 1  ' set paging mode
   CLS : PCOPY 0, 2  'prepare our "background" page
  FOR I = 1 TO 50  'sprinkle some stars
    sx(I) = FNR(319): sy(I) = FNR(199)
    ST(I) = FNR(2)
  NEXT
x2 = 30
y2 = 25
r = 30
s = 50

END SUB

SUB right
enem
COLOR , 0
                                                        
 SP2 = 0
   DO
     X = STICK(0)
     y = STICK(1)
     IF X < F - 30 THEN LEFT
     IF y < g - 30 THEN k = 2
     IF y > g + 30 THEN k = 1
     IF NOT (y > g + 30) AND NOT (y < g - 30) THEN k = 0

   speed
 '  enem
     PCOPY 2, 0
    FOR I = 1 TO 50  'move & display stars
      IF ST(I) = 1 THEN c = 7 ELSE c = 15
      PSET (sx(I), sy(I)), c
      IF SP2 = 0 THEN GOTO 6
     
      sx(I) = sx(I) + ST(I) + SP2
6
       IF k = 1 THEN
      sy(I) = sy(I) + ST(I) + 9
      IF sy(I) > 200 THEN sy(I) = 1
      END IF
 
      IF k = 2 THEN
      sy(I) = sy(I) + ST(I) - 9
      IF sy(I) < 1 THEN sy(I) = 200
      END IF
   
       
      IF sx(I) < 1 THEN
        sx(I) = 320: sy(I) = FNR(199)
        'st(i) = FNR(i)
      END IF
    NEXT
    'END IF
IF y > g + 30 THEN s = s + 5: IF s > 150 THEN s = 10
IF y < g - 30 THEN s = s - 5: IF s < 10 THEN s = 150
IF X > F + 30 THEN r = r - 10
IF r < 1 THEN LET counter = -280
IF counter > 1 THEN
PUT (r, s), ENEMY, OR
END IF
'LOCATE 1, 1: PRINT counter
'LOCATE 2, 1: PRINT counterm
'LOCATE 3, 1: PRINT "r="; r
PUT (1, 1), COCKPIT, OR
PUT (102, 170), LOGO, OR
IF counter > 1 OR counterm > 1 THEN
PUT (30, 25), enemydot, OR
LOCATE 22, 3: COLOR 8: PRINT "in front"
ELSE
PUT (277, 25), enemydot, OR
LOCATE 22, 3: COLOR 8: PRINT " behind"


END IF

PCOPY 0, 1  'copy template to viewing screen
ET = ET + 1  'cycle timer (add delays if too fast)
IF ET = 30 THEN  'activate enemies
EX = 350: EY = 200: ED = 1: EXD = -23: EYD = -8
END IF
    
     
  

LOOP UNTIL INKEY$ <> ""

END SUB

SUB speed
 
 IF direction = leftm THEN
    IF X < F - 30 THEN sp1 = sp1 + 2.5 ELSE sp1 = sp1 - 2.5:
    IF X < F - 30 THEN counter = counter + 12
  
     
    IF sp1 < 1 THEN LET sp1 = 0
    IF sp1 > 20 THEN sp1 = 20

 END IF
    IF direction = rightm THEN
    IF X > F + 30 THEN counter = counter - 12
    IF X > F - 30 THEN SP2 = SP2 - 2.5:
    IF SP2 < -20 THEN LET SP2 = -20
    IF X < F + 30 THEN SP2 = 0
 

 END IF
 
 

 
END SUB

