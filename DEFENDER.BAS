 ' Defender.bas
 ' Tim Truman
 ' 4/28/95
 ' Copyright (c) 1995,1996 Tim Truman
 ' Distribute this program freely.
 '
 '
 DEFINT A-Z

 DECLARE SUB printme ()

 DECLARE SUB setfxmode ()
 DECLARE SUB herosprite ()               '  draw and initalize main sprite
 DECLARE SUB starfield ()
 DECLARE SUB processgpi ()               '  process game play input
 
 DECLARE SUB printtime ()                 ' debbugger tool
 DECLARE SUB printins ()


 DECLARE SUB p3x5numfnt (x, y, num, colour)        ' fonts
 DECLARE SUB p5x7ascfnt (x, y, text$, colour)

 DECLARE SUB createhero ()
 DECLARE SUB createherolaser ()


 DECLARE SUB createchunks (x, y)
 DECLARE SUB createalienbolt (x, y)
 DECLARE SUB createalienshot (x, y)
 DECLARE SUB createimplode (x, y)
 DECLARE SUB createcolonists ()
 DECLARE SUB creategrabber ()
 DECLARE SUB createmutant (x, y)
 DECLARE SUB createbomer ()
 DECLARE SUB createblocker ()
 DECLARE SUB createspinner ()
 DECLARE SUB createbomb (x, y)
 DECLARE SUB createchaser ()
 DECLARE SUB createspinette (x, y)
 DECLARE SUB createtracker ()
     

 DECLARE SUB killsprites ()
 DECLARE SUB collision ()
 DECLARE SUB levels ()
 DECLARE SUB newgame ()
 DECLARE SUB endgame ()

 DECLARE SUB traitshero ()
 DECLARE SUB traitsgrabber (a)            ' inteligence for aliens
 DECLARE SUB traitsmutant (a)
 DECLARE SUB traitsbomer (a)
 DECLARE SUB traitsblocker ()
 DECLARE SUB traitsspinner (a)
 DECLARE SUB traitschaser (a)
 DECLARE SUB traitscolonist (a)
 DECLARE SUB traitsspinette ()
 DECLARE SUB traitstracker (a%)
 DECLARE SUB traitsalienshot ()

 DECLARE SUB drawplayscreen ()
 DECLARE SUB drawboundrys ()
 DECLARE SUB movesprites ()
 

 DECLARE FUNCTION strobe ()              ' returns color
 DECLARE FUNCTION timepassed (n, tsecs!) ' check for passage of time
 DECLARE FUNCTION keyboard ()           ' returns ascii value of key press
 DECLARE FUNCTION joystick ()            ' returns direction of movement
 DECLARE FUNCTION joybutt ()             ' returns number of button pressed

 DECLARE FUNCTION adlib ()               ' detects presence of adlib
 DECLARE SUB WriteReg (reg, value)       ' write to adlibs registers
 DECLARE SUB adlibfx (num)               ' plays the sounds

 CONST false = 0
 CONST TRUE = NOT false

 'CONST speed = 1                  ' set higher for slower computers
 'CONST pageswap = TRUE            ' set page swap (fast computers only)
 'CONST delay = false              ' slow down the game


 TYPE sprite
    x       AS INTEGER     ' virtual location
    y       AS INTEGER     '
    oldx    AS INTEGER     ' old location for erase
    oldy    AS INTEGER     '
    px      AS INTEGER     ' physical x
    py      AS INTEGER     ' physical y
    cx      AS INTEGER     ' counter
    cy      AS INTEGER     '
    vx      AS INTEGER     ' velocity
    vy      AS INTEGER     '
    rx      AS INTEGER     ' radar x
    ry      AS INTEGER     '
    oldrx   AS INTEGER
    oldry   AS INTEGER
    dirx    AS INTEGER     '
    diry    AS INTEGER
    h       AS INTEGER     ' hight
    w       AS INTEGER     ' width
    mem1    AS INTEGER     ' save something
    mem2    AS INTEGER     '
    eras    AS INTEGER     ' erase
    health  AS INTEGER     ' alive
    dir     AS INTEGER     ' various, usually referenced for movement
    thrust  AS INTEGER     ' for hero ship
    mode    AS INTEGER     ' various
    toplay  AS INTEGER     ' how many to play
    played  AS INTEGER     ' how many have been played
 END TYPE

 TYPE explode
   set      AS INTEGER
   x        AS INTEGER
   y        AS INTEGER
   size     AS INTEGER
   colour   AS INTEGER
   c1       AS INTEGER
   c2       AS INTEGER
 END TYPE

 'global variables

 COMMON SHARED Pageswap, speed, keyspeed, delay

 COMMON SHARED minx, miny, maxx, maxy, topy, boty, qtrx, thrdx
 COMMON SHARED fieldw, fieldh, fieldx
 COMMON SHARED radarx, radary, radarsx, radarsy, radarw, radarh, radarwrapx
 COMMON SHARED pickup
 COMMON SHARED level, newlevel

 COMMON SHARED maxaliensinplay, aliensinplay
 COMMON SHARED hero AS sprite, heroimage()   AS INTEGER
 COMMON SHARED grabber() AS sprite, maxgrabbers, numgrabbers
 COMMON SHARED chaser AS sprite
 COMMON SHARED mutant() AS sprite
 COMMON SHARED bomer() AS sprite, maxbomers, numbomers
 COMMON SHARED bomb AS sprite
 COMMON SHARED blocker AS sprite, maxblockers
 COMMON SHARED spinner AS sprite, maxspinners
 COMMON SHARED spinette AS sprite
 COMMON SHARED col() AS sprite, maxcolonists
 COMMON SHARED herolaser() AS sprite, maxherolasers
 COMMON SHARED alienshot AS sprite
 COMMON SHARED alienbolt() AS sprite, maxalienbolts
 COMMON SHARED tracker AS sprite

 COMMON SHARED chunk() AS sprite, maxchunks
 COMMON SHARED exp1 AS explode

                                 '  set variables to maximum array sizes
 maxaliensinplay = 10            '  most on playfield
 maxherolasers = 0               '
 maxalienbolts = 0
 maxcolonists = 10
 maxgrabbers = 15
 maxbomers = 2
 maxchunks = 20

 speed = 1
 keyspeed = 8
 delay = 0

 DIM herolaser(maxherolasers) AS sprite
 DIM alienbolt(maxalienbolts) AS sprite
 DIM col(maxcolonists)  AS sprite
 DIM grabber(maxgrabbers) AS sprite
 DIM mutant(maxcolonists) AS sprite
 DIM bomer(maxbomers) AS sprite
 DIM chunk(maxchunks)  AS sprite
 

 RANDOMIZE TIMER
 DEF fnrnd (num) = INT(RND * num)         ' returns random number

 OUT &H60, &HF3         ' fast typematic rate with min delay
 SLEEP (1)              ' let hardware settle
 OUT &H60, 0

 printme
 printins

 IF adlib THEN
    adlibsound = TRUE
    PRINT "Adlib detected"
    SLEEP (1)
 END IF
 
 IF joystick = -99 THEN
    PRINT joystick
    PRINT "There was no joystick detected. Unfortunatly QBdefender will"
    PRINT "not opperate correctly without one. You may use the numeric"
    PRINT "keypad to move and shoot but the control will be disapointing."
    PRINT "Press any key."
    DO: LOOP WHILE INKEY$ = ""
 END IF

 

 a = timepassed(20, 0)                    ' set up counters
 setfxmode                                ' set screen mode and variables

 p3x5numfnt -999, 0, 0, 0                   ' load fonts
 p5x7ascfnt -999, 0, "", 0

createhero

  DO
    levels
    endgame
    starfield
    processgpi
    collision
    movesprites
    creategrabber
    createbomer
    createchaser
    createspinner
    createtracker
    IF Pageswap THEN PCOPY 1, 0
    FOR i = 1 TO delay: NEXT
    'LOCATE 1, 1: PRINT delay
  LOOP

FUNCTION adlib

  '  Detects an AdLib-compatible card.
  '  Returns 1 (true) if detected and 0 (false) if not.
  
 
   CALL WriteReg(&H4, &H60)  '  Resets both Timers
   CALL WriteReg(&H4, &H80)  '  Enables Interrupts
   b = INP(&H388)            '  Store the result
   CALL WriteReg(&H2, &HFF)  '  Write FFh to register 2 (Timer 1)
   CALL WriteReg(&H4, &H21)  '  Start Timer 1

   FOR x = 0 TO 130          '  Delay for 80 Microseconds
      a = INP(&H388)
   NEXT x

   c = INP(&H388)                 '  Store the result
   CALL WriteReg(&H4, &H60)       '  Reset Timers
   CALL WriteReg(&H4, &H80)       '  Reset Interrrupts
   Success = 0
   IF (b AND &HE0) = &H0 THEN     '  Test result
     IF (c AND &HE0) = &HC0 THEN  '  Test Result
       Success = 1
       FOR q = 1 TO &HF5          '  clear registers
         CALL WriteReg(q, 0)
       NEXT q
     END IF
   END IF
   adlib = Success


END FUNCTION

SUB adlibfx (num)

 SELECT CASE (num)

 CASE (0)                    '   mutant exploding

 
   WriteReg &HB0, &H0
   numberl = 60
   numberh = 1
   block = 0
                                 ' Modulator
   CALL WriteReg(&H20, &H0)      ' Multiple - 0 to F
   CALL WriteReg(&H40, &H0)      ' Attenuation Level -  0 to 3F
   CALL WriteReg(&H60, &HA5)     ' Attack: (High byte)    Decay: (Low byte)
   CALL WriteReg(&H80, &H0)      ' Sustain: (High byte)   Release: (Low byte)
   CALL WriteReg(&HE0, &HF0)     ' Waveform select  0 to 3
                                ' Carrier
   CALL WriteReg(&H23, &H0)      ' Multiple  - 0 to F
   CALL WriteReg(&H43, &H0)      ' Attenuation level -  0 to 3F
   CALL WriteReg(&H63, &HA6)     ' Attack: (High byte)   Decay:(low byte)
   CALL WriteReg(&H83, &HAA)     ' Sustain: (High Byte)  Release:(low byte)
   CALL WriteReg(&HE1, &HF0)     ' Waveform select  0 to 3

   keyon% = &H20

   Byte% = keyon% + (block * 4) + numberh%

   CALL WriteReg(&HA0, numberl)     ' F-Number(L)  0 to 255
   CALL WriteReg(&HB0, Byte%)     ' Sound voice ,Set block ,Set F-Number(H)


 CASE 1                 'hero firing

  WriteReg &HB1, &H0

  numberl = 230
  numberh = 1
  block = 1
                              ' Modulator
  CALL WriteReg(&H21, &H10)    ' Multiple - 0 to F
  CALL WriteReg(&H41, &H0)    ' Attenuation Level -  0 to 3F
  CALL WriteReg(&H61, &H66)   ' Attack: (High byte)    Decay: (Low byte)
  CALL WriteReg(&H81, &HF6)   ' Sustain: (High byte)   Release: (Low byte)
  CALL WriteReg(&HE1, &HF2)   ' Waveform select  0 to 3
                              ' Carrier
  CALL WriteReg(&H24, &H0)    ' Multiple  - 0 to F
  CALL WriteReg(&H44, &H6)    ' Attenuation level -  0 to 3F
  CALL WriteReg(&H64, &H63)   ' Attack: (High byte)   Decay:(low byte)
  CALL WriteReg(&H84, &HF8)    ' Sustain: (High Byte)  Release:(low byte)
  CALL WriteReg(&HE4, &HF0)   ' Waveform select  0 to 3

  keyon = &H20

  Byte = keyon + (block * 4) + (numberh)

  CALL WriteReg(&HC1, 0)            ' conection
  CALL WriteReg(&HC1, 0)            ' conection
  CALL WriteReg(&HA1, numberl)     ' F-Number(L)  0 to 255
  CALL WriteReg(&HB1, Byte)     ' Sound voice ,Set block ,Set F-Number(H)

  '  WriteReg &HB1, &H0          ' stop noise

  '  numberl = 10
  '  numberh = 0
   ' block = 7
                                ' Modulator
  '  CALL WriteReg(&H21, &H3)     ' Multiple - 0 to F
  '  CALL WriteReg(&H41, &H0)    ' Attenuation Level -  0 to 3F
  '  CALL WriteReg(&H61, &H99)   ' Attack: (High byte)    Decay: (Low byte)
  '  CALL WriteReg(&H81, &HFF)   ' Sustain: (High byte)   Release: (Low byte)
  '  CALL WriteReg(&HE1, &HF0)   ' Waveform select  0 to 3
                                ' Carrier
  '  CALL WriteReg(&H24, &H1)    ' Multiple  - 0 to F
  '  CALL WriteReg(&H44, &H0)    ' Attenuation level -  0 to 3F
  '  CALL WriteReg(&H64, &HAD)   ' Attack: (High byte)   Decay:(low byte)
   ' CALL WriteReg(&H84, &H55)   ' Sustain: (High Byte)  Release:(low byte)
  '  CALL WriteReg(&HE4, &HF0)   ' Waveform select  0 to 3

  '  keyon% = &H20

  '  Byte% = keyon% + (block * 4) + numberh

  ' CALL WriteReg(&HA1, numberl)     ' F-Number(L)  0 to 255
  ' CALL WriteReg(&HB1, Byte)     ' Sound voice ,Set block ,Set F-Number(H)



 CASE 2                       ' colonist pick up warning

  WriteReg &HB2, &H0          ' stop noise

  numberl = 255
  numberh = 3
  block = 2
                              ' Modulator
  CALL WriteReg(&H22, &H3)    ' Multiple - 0 to F
  CALL WriteReg(&H42, &H0)    ' Attenuation Level -  0 to 3F
  CALL WriteReg(&H62, &H5F)   ' Attack: (High byte)    Decay: (Low byte)
  CALL WriteReg(&H82, &HFF)   ' Sustain: (High byte)   Release: (Low byte)
  CALL WriteReg(&HE2, &HF0)   ' Waveform select  0 to 3
                              ' Carrier
  CALL WriteReg(&H25, &H0)    ' Multiple  - 0 to F
  CALL WriteReg(&H45, &H9)    ' Attenuation level -  0 to 3F
  CALL WriteReg(&H65, &H5F)   ' Attack: (High byte)   Decay:(low byte)
  CALL WriteReg(&H85, &HFF)   ' Sustain: (High Byte)  Release:(low byte)
  CALL WriteReg(&HE5, &HF0)   ' Waveform select  0 to 3

  keyon% = &H20

  Byte% = keyon% + (block * 4) + numberh

  CALL WriteReg(&HA2, numberl)     ' F-Number(L)  0 to 255
  CALL WriteReg(&HB2, Byte)     ' Sound voice ,Set block ,Set F-Number(H)


 CASE 3                         ' mutant converted
    WriteReg &HB3, &H0

    numberl = 10
    numberh = 0
    block = 5
                                ' Modulator
    CALL WriteReg(&H28, &H5)     ' Multiple - 0 to F
    CALL WriteReg(&H48, &H0)    ' Attenuation Level -  0 to 3F
    CALL WriteReg(&H68, &H99)   ' Attack: (High byte)    Decay: (Low byte)
    CALL WriteReg(&H88, &HFF)   ' Sustain: (High byte)   Release: (Low byte)
    CALL WriteReg(&HE8, &HF0)   ' Waveform select  0 to 3
                                ' Carrier
    CALL WriteReg(&H2B, &H0)    ' Multiple  - 0 to F
    CALL WriteReg(&H4B, &H0)    ' Attenuation level -  0 to 3F
    CALL WriteReg(&H6B, &HAD)   ' Attack: (High byte)   Decay:(low byte)
    CALL WriteReg(&H8B, &H55)   ' Sustain: (High Byte)  Release:(low byte)
    CALL WriteReg(&HEB, &HF0)   ' Waveform select  0 to 3

    keyon% = &H20
 
    Byte% = keyon% + (block * 4) + numberh

   CALL WriteReg(&HA3, numberl)     ' F-Number(L)  0 to 255
   CALL WriteReg(&HB3, Byte)     ' Sound voice ,Set block ,Set F-Number(H)

 CASE 4           ' mutant firing

    WriteReg &HB4, &H0          ' stop noise

    numberl = 10
    numberh = 0
    block = 1
                                ' Modulator
    CALL WriteReg(&H29, &H5)     ' Multiple - 0 to F
    CALL WriteReg(&H49, &H0)    ' Attenuation Level -  0 to 3F
    CALL WriteReg(&H69, &H87)   ' Attack: (High byte)    Decay: (Low byte)
    CALL WriteReg(&H89, &HFF)   ' Sustain: (High byte)   Release: (Low byte)
    CALL WriteReg(&HE9, &HF0)   ' Waveform select  0 to 3
                                ' Carrier
    CALL WriteReg(&H2C, &H1)    ' Multiple  - 0 to F
    CALL WriteReg(&H4C, &H9)    ' Attenuation level -  0 to 3F
    CALL WriteReg(&H6C, &HA5)   ' Attack: (High byte)   Decay:(low byte)
    CALL WriteReg(&H8C, &H55)   ' Sustain: (High Byte)  Release:(low byte)
    CALL WriteReg(&HEC, &HF0)   ' Waveform select  0 to 3

    keyon% = &H20

    Byte% = keyon% + (block * 4) + numberh

   CALL WriteReg(&HA4, numberl)     ' F-Number(L)  0 to 255
   CALL WriteReg(&HB4, Byte)     ' Sound voice ,Set block ,Set F-Number(H)
 
 CASE 5

   'PRINT " bomer noise"
   WriteReg &HB5, &H0          ' stop noise

    numberl = 60
    numberh = 1
    block = 2
                                ' Modulator
    CALL WriteReg(&H2A, &H0)    ' Multiple - 0 to F
    CALL WriteReg(&H4A, &H0)    ' Attenuation Level -  0 to 3F
    CALL WriteReg(&H6A, &H55)   ' Attack: (High byte)    Decay: (Low byte)
    CALL WriteReg(&H8A, &HAA)   ' Sustain: (High byte)   Release: (Low byte)
    CALL WriteReg(&HEA, &HF3)   ' Waveform select  0 to 3
                                ' Carrier
    CALL WriteReg(&H2D, &H0)    ' Multiple  - 0 to F
    CALL WriteReg(&H4D, &H0)    ' Attenuation level -  0 to 3F
    CALL WriteReg(&H6D, &HFF)   ' Attack: (High byte)   Decay:(low byte)
    CALL WriteReg(&H8D, &HAA)   ' Sustain: (High Byte)  Release:(low byte)
    CALL WriteReg(&HED, &HF3)   ' Waveform select  0 to 3


   CALL WriteReg(&HC5, 1)            ' conection

   keyon% = &H20

   Byte% = keyon% + (block * 4) + numberh

   CALL WriteReg(&HA5, numberl)     ' F-Number(L)  0 to 255
   CALL WriteReg(&HB5, Byte)     ' Sound voice ,Set block ,Set F-Number(H)


  CASE 6

   WriteReg &HB4, &H0
   numberl = 130
   numberh = 0
   block = 0
                                 ' Modulator
   CALL WriteReg(&H29, &H0)      ' Multiple - 0 to F
   CALL WriteReg(&H49, &H0)      ' Attenuation Level -  0 to 3F
   CALL WriteReg(&H69, &HA5)     ' Attack: (High byte)    Decay: (Low byte)
   CALL WriteReg(&H89, &H0)      ' Sustain: (High byte)   Release: (Low byte)
   CALL WriteReg(&HE9, &HF0)     ' Waveform select  0 to 3
                                ' Carrier
   CALL WriteReg(&H2C, &H0)      ' Multiple  - 0 to F
   CALL WriteReg(&H4C, &H0)      ' Attenuation level -  0 to 3F
   CALL WriteReg(&H6C, &HA6)     ' Attack: (High byte)   Decay:(low byte)
   CALL WriteReg(&H8C, &H55)     ' Sustain: (High Byte)  Release:(low byte)
   CALL WriteReg(&HEC, &HF0)     ' Waveform select  0 to 3

   keyon% = &H20

   Byte% = keyon% + (block * 4) + numberh%

   CALL WriteReg(&HA4, numberl)     ' F-Number(L)  0 to 255
   CALL WriteReg(&HB4, Byte%)     ' Sound voice ,Set block ,Set F-Number(H)



 END SELECT

END SUB

SUB collision

 ' detect collisions

 SHARED collidex, collidey    ' for chunks
 SHARED pickup

 STATIC top(), left(), bottom(), right(), didthis

  IF didthis = 0 THEN
    DIM top(1)
    DIM left(1)
    DIM bottom(1)
    DIM right(1)
    didthis = 1
  END IF

 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³
 '³³³³³³³³³³³³³³³³³³³ Check hero ship against grabbers. ³³³³³³³³³³³³³³³³³³³³³


  FOR a = 0 TO maxgrabbers
    IF NOT (grabber(a).x < 0) OR (grabber(a).x > maxx) THEN
      'IF (grabber(a).y > hero.y + hero.h) THEN EXIT FOR
      'IF (grabber(a).y + grabber(a).h < hero.y) THEN EXIT FOR
      IF (grabber(a).health > 0) AND (hero.health > 0) THEN
     
       top(0) = hero.y
       left(0) = hero.x
       bottom(0) = hero.y + hero.h
       right(0) = hero.x + hero.w
  
       top(1) = grabber(a).y
       left(1) = grabber(a).x
       bottom(1) = grabber(a).y + grabber(a).h
       right(1) = grabber(a).x + grabber(a).w

    IF (left(0) >= right(1)) OR (left(1) > right(0)) OR (top(0) > bottom(1)) OR (top(1) > bottom(0)) THEN
    
    ELSE
      grabber(a).health = grabber(a).health - 1
      hero.health = hero.health - 1
    END IF
  END IF
  END IF

 NEXT

 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³
 '³³³³³³³³³³³³³³³³³³³ Check hero ship against mutants. ³³³³³³³³³³³³³³³³³³³³³³


  FOR a = 0 TO maxcolonists
    IF NOT (mutant(a).x < 0) OR (mutant(a).x > maxx) THEN
      'IF (mutant(a).y > hero.y + hero.h) THEN EXIT FOR
      'IF (mutant(a).y + mutant(a).h < hero.y) THEN EXIT FOR
      IF mutant(a).health THEN 'AND hero.health THEN
    
       top(0) = hero.y
       left(0) = hero.x
       bottom(0) = hero.y + hero.h
       right(0) = hero.x + hero.w
 
       top(1) = mutant(a).y
       left(1) = mutant(a).x
       bottom(1) = mutant(a).y + mutant(a).h
       right(1) = mutant(a).x + mutant(a).w

    IF (left(0) >= right(1)) OR (left(1) > right(0)) OR (top(0) > bottom(1)) OR (top(1) > bottom(0)) THEN
   
    ELSE
      mutant(a).health = mutant(a).health - 1
      hero.health = hero.health - 1
      createchunks hero.x, hero.y
    END IF
  END IF
  END IF

NEXT


 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³
 '³³³³³³³³³³³³³³³³³³³ Check hero ship against alienshots. ³³³³³³³³³³³³³³³³³³³
 
      IF alienshot.health THEN
      
       top(0) = hero.y
       left(0) = hero.x
       bottom(0) = hero.y + hero.h
       right(0) = hero.x + hero.w

       top(1) = alienshot.y
       left(1) = alienshot.x
       bottom(1) = alienshot.y + alienshot.h
       right(1) = alienshot.x + alienshot.w

    IF (left(0) >= right(1)) OR (left(1) > right(0)) OR (top(0) > bottom(1)) OR (top(1) > bottom(0)) THEN
    ELSE
      alienshot.health = 0
      IF hero.mode = 1 THEN              ' holding coloinist
        col(hero.mem1).health = 0        ' colonist takes shot
        pickup = 0                       ' another may be picked up
        hero.mode = 0
      ELSE
        hero.health = hero.health - 1
      END IF
      createchunks hero.x, hero.y
    END IF
  END IF

 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³
 '³³³³³³³³³³³³³³³³³³³ Check hero ship against spinettes. ³³³³³³³³³³³³³³³³³³³³

    
      IF spinette.health THEN
     
       top(0) = hero.y
       left(0) = hero.x
       bottom(0) = hero.y + hero.h
       right(0) = hero.x + hero.w

       top(1) = spinette.y
       left(1) = spinette.x
       bottom(1) = spinette.y + spinette.h
       right(1) = spinette.x + spinette.w

    IF (left(0) >= right(1)) OR (left(1) > right(0)) OR (top(0) > bottom(1)) OR (top(1) > bottom(0)) THEN
    ELSE
      spinette.health = 0
      IF hero.mode = 1 THEN              ' holding coloinist
        col(hero.mem1).health = 0        ' colonist takes shot
        pickup = 0                       ' another may be picked up
        hero.mode = 0
      ELSE
        hero.health = hero.health - 1
      END IF
      createchunks hero.x, hero.y
    END IF
  END IF


 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³
 '³³³³³³³³³³³³³³³³³³³ Check hero ship against colonists. ³³³³³³³³³³³³³³³³³³³³


  FOR a = 0 TO maxcolonists
      IF col(a).health AND col(a).mode = 1 AND col(a).dir = 0 THEN
  
      IF (col(a).y > hero.y + hero.h) THEN EXIT FOR
      IF (col(a).y + col(a).h < hero.y) THEN EXIT FOR
        
       top(0) = hero.y
       left(0) = hero.x
       bottom(0) = hero.y + hero.h
       right(0) = hero.x + hero.w

       top(1) = col(a).y
       left(1) = col(a).x
       bottom(1) = col(a).y + col(a).h
       right(1) = col(a).x + col(a).w

    IF (left(0) >= right(1)) OR (left(1) > right(0)) OR (top(0) > bottom(1)) OR (top(1) > bottom(0)) THEN
 
    ELSE
      
      col(a).mode = 2
      hero.mode = 1
      hero.mem1 = a
      
    END IF
 
  END IF

NEXT


 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³
 '³³³³³³³³³³³³³³³³³³³ Check hero lasers against grabbers. ³³³³³³³³³³³³³³³³³³³
   
    FOR a = 0 TO maxherolasers
     IF herolaser(a).health THEN    ' don't bother if missle is dead
        IF herolaser(a).dir = 1 THEN
         top(0) = herolaser(a).y
         left(0) = herolaser(a).x
         bottom(0) = herolaser(a).y
         right(0) = herolaser(a).x
         ELSEIF herolaser(a).dir = 0 THEN
         top(0) = herolaser(a).y
         left(0) = herolaser(a).x
         bottom(0) = herolaser(a).y
         right(0) = herolaser(a).x
        END IF



      FOR b = 0 TO maxgrabbers
      IF (grabber(b).x > minx) OR (grabber(b).x < maxx) THEN
        IF grabber(b).health THEN       ' don't bother if grabber is dead

          top(1) = grabber(b).y
          left(1) = grabber(b).x
          bottom(1) = grabber(b).y + grabber(b).h
          right(1) = grabber(b).x + grabber(b).w
           
          IF (left(0) >= right(1)) OR (left(1) > right(0)) OR (top(0) > bottom(1)) OR (top(1) > bottom(0)) THEN

          ELSE
            grabber(b).health = grabber(b).health - 1
            herolaser(a).health = false
            IF grabber(b).health = 0 THEN
             adlibfx (0)
             'adlibfx (6)
             IF exp1.set = 0 THEN
              exp1.set = 1
              exp1.x = herolaser(a).x
              exp1.y = herolaser(a).y
              exp1.size = 15
              exp1.colour = 2
             END IF
             END IF
          END IF
        END IF
       END IF
       NEXT b
     
    END IF
   NEXT a

 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³
 '³³³³³³³³³³³³³³³³³³³ Check hero lasers against mutants ³³³³³³³³³³³³³³³³³³³³³

    FOR a = 0 TO maxherolasers
     IF herolaser(a).health THEN

         top(0) = herolaser(a).y
         left(0) = herolaser(a).x
         bottom(0) = herolaser(a).y
         right(0) = herolaser(a).x
     
      FOR b = 0 TO maxcolonists

         IF mutant(b).health THEN       ' don't bother if mutant is dead
          top(1) = mutant(b).y
          left(1) = mutant(b).x
          bottom(1) = mutant(b).y + mutant(b).h
          right(1) = mutant(b).x + mutant(b).w
          
          IF (left(0) >= right(1)) OR (left(1) > right(0)) OR (top(0) > bottom(1)) OR (top(1) > bottom(0)) THEN

          ELSE
            mutant(b).health = mutant(b).health - 1
            herolaser(a).health = false
            adlibfx (0)
            IF mutant(b).health = 0 THEN
             createchunks herolaser(a).x, herolaser(a).y
             adlibfx (0)
             IF exp1.set = 0 THEN
              exp1.set = 1
              exp1.x = herolaser(a).x
              exp1.y = herolaser(a).y
              exp1.size = 15
              exp1.colour = 4
             END IF

            END IF
           
          END IF
        END IF
        NEXT b
     END IF
    
   NEXT a

 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³
 '³³³³³³³³³³³³³³³³³³³ Check hero lasers against bomers. ³³³³³³³³³³³³³³³³³³³³³


    FOR a = 0 TO maxherolasers
     IF herolaser(a).health THEN
     IF herolaser(a).dir THEN
         top(0) = herolaser(a).y
         left(0) = herolaser(a).x
         bottom(0) = herolaser(a).y
         right(0) = herolaser(a).x
       ELSE
         top(0) = herolaser(a).y
         left(0) = herolaser(a).x
         bottom(0) = herolaser(a).y
         right(0) = herolaser(a).x
       END IF

      FOR b = 0 TO maxbomers
        IF (bomer(b).x > minx) AND (bomer(b).x < maxx) THEN
         IF bomer(b).health THEN
          top(1) = bomer(b).y
          left(1) = bomer(b).x
          bottom(1) = bomer(b).y + bomer(b).h
          right(1) = bomer(b).x + bomer(b).w
         
          IF (left(0) >= right(1)) OR (left(1) > right(0)) OR (top(0) > bottom(1)) OR (top(1) > bottom(0)) THEN

          ELSE
            bomer(b).health = bomer(b).health - 1
            herolaser(a).health = false
            adlibfx (0)
            IF bomer(b).health = 0 THEN
             createchunks herolaser(a).x, herolaser(a).y
             'adlibfx (0)
             adlibfx (6)
             IF exp1.set = 0 THEN
              exp1.set = 1
              exp1.x = herolaser(a).x
              exp1.y = herolaser(a).y
              exp1.size = 15
              exp1.colour = 3
             END IF

            END IF
          
          END IF
        END IF
        END IF
       NEXT b
     END IF
   
   NEXT a

 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³
 '³³³³³³³³³³³³³³³³³³³ Check hero lasers against blockers. ³³³³³³³³³³³³³³³³³³³

    FOR a = 0 TO maxherolasers
     IF herolaser(a).health THEN       ' don't bother if missle is dead
       IF herolaser(a).dir THEN
         top(0) = herolaser(a).y
         left(0) = herolaser(a).x
         bottom(0) = herolaser(a).y
         right(0) = herolaser(a).x
       ELSE
         top(0) = herolaser(a).y
         left(0) = herolaser(a).x
         bottom(0) = herolaser(a).y
         right(0) = herolaser(a).x
       END IF

       IF (blocker.x > minx) AND (blocker.x < maxx) THEN
         IF blocker.health THEN       ' don't bother if mutant is dead
          top(1) = blocker.y
          left(1) = blocker.x
          bottom(1) = blocker.y + blocker.h
          right(1) = blocker.x + blocker.w
        
          IF (left(0) >= right(1)) OR (left(1) > right(0)) OR (top(0) > bottom(1)) OR (top(1) > bottom(0)) THEN

          ELSE
            blocker.health = blocker.health - 1
            createchunks herolaser(a).x, herolaser(a).y
            blocker.vy = 0
            IF blocker.health = 0 THEN
            hero.vx = hero.mem2           ' restore hero x velocity
             adlibfx (0)
            END IF
         
          END IF
        END IF
        END IF
       
     END IF
  
   NEXT a

 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³
 '³³³³³³³³³³³³³³³³³³³ Check hero lasers against spinners ³³³³³³³³³³³³³³³³³³³³


    FOR a = 0 TO maxherolasers
     IF herolaser(a).health THEN       ' don't bother if laser is dead

         top(0) = herolaser(a).y
         left(0) = herolaser(a).x
         bottom(0) = herolaser(a).y
         right(0) = herolaser(a).x
      
      
        IF (spinner.x > minx) AND (spinner.x < maxx) THEN
         IF spinner.health THEN       ' don't bother if mutant is dead
          top(1) = spinner.y - spinner.w
          left(1) = spinner.x - spinner.w
          bottom(1) = spinner.y + spinner.w
          right(1) = spinner.x + spinner.w
       
          IF (left(0) >= right(1)) OR (left(1) > right(0)) OR (top(0) > bottom(1)) OR (top(1) > bottom(0)) THEN

          ELSE
            spinner.health = spinner.health - 1
            createchunks herolaser(a).x, herolaser(a).y
            herolaser(a).health = 0
            IF spinner.health = 0 THEN
              adlibfx (0)
              adlibfx (6)
              IF exp1.set = 0 THEN
               exp1.set = 1
               exp1.x = herolaser(a).x
               exp1.y = herolaser(a).y
               exp1.size = 15
               exp1.colour = 9
              END IF
            END IF
          END IF
        END IF
        END IF
       
     END IF
 
   NEXT a
 

 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³
 '³³³³³³³³³³³³³³³³³³³ Check hero ship against blockers. ³³³³³³³³³³³³³³³³³³³³³
 
    
     IF blocker.health THEN
       IF (blocker.x > minx) AND (blocker.x < maxx) THEN

         top(0) = hero.y
         left(0) = hero.x
         bottom(0) = hero.y + hero.h
         right(0) = hero.x + hero.w
        
         top(1) = blocker.y
         left(1) = blocker.x
         bottom(1) = blocker.y + blocker.h
         right(1) = blocker.x + blocker.w
        
         IF (left(0) >= right(1)) OR (left(1) > right(0)) OR (top(0) > bottom(1)) OR (top(1) > bottom(0)) THEN
         ELSE
          IF blocker.mem1 = hero.dir THEN hero.vx = 0
              hero.y = blocker.y
            END IF
      END IF
     END IF
   
  
 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³
 '³³³³³³³³³³³³³³³³³³³ Check hero ship against chasers. ³³³³³³³³³³³³³³³³³³³³³³

  
     IF chaser.health THEN
       IF (chaser.x > minx) AND (chaser.x < maxx) THEN

          top(0) = hero.y
          left(0) = hero.x
          bottom(0) = hero.y + hero.h
          right(0) = hero.x + hero.w
        
          top(1) = chaser.y
          left(1) = chaser.x
          bottom(1) = chaser.y + chaser.h
          right(1) = chaser.x + chaser.w

        
         IF (left(0) >= right(1)) OR (left(1) > right(0)) OR (top(0) > bottom(1)) OR (top(1) > bottom(0)) THEN

         ELSE
          
      '      hero.health = hero.health - 1
            chaser.health = 0
            adlibfx (0)
            createchunks chaser.x, chaser.y
            createchunks chaser.x, chaser.y

         END IF
       END IF
      END IF
 

 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³
 '³³³³³³³³³³³³³³³³³³³ Check hero lasers against chasers. ³³³³³³³³³³³³³³³³³³³³

  
     IF chaser.health THEN
       IF (chaser.x > minx) AND (chaser.x < maxx) THEN
         IF NOT (chaser.y > hero.y + hero.h) AND NOT (chaser.y < hero.y) THEN

           FOR a = 0 TO maxherolasers

            top(0) = herolaser(a).y
            left(0) = herolaser(a).x
            bottom(0) = herolaser(a).y
            right(0) = herolaser(a).x
        
            top(1) = chaser.y
            left(1) = chaser.x
            bottom(1) = chaser.y + chaser.h
            right(1) = chaser.x + chaser.w

        
         IF (left(0) >= right(1)) OR (left(1) > right(0)) OR (top(0) > bottom(1)) OR (top(1) > bottom(0)) THEN

         ELSE
           
            chaser.health = 0
            createchunks chaser.x, chaser.y
            adlibfx (0)
            adlibfx (6)
             IF exp1.set = 0 THEN
              exp1.set = 1
              exp1.x = herolaser(a).x
              exp1.y = herolaser(a).y
              exp1.size = 15
              exp1.colour = 15
             END IF

         END IF
       NEXT a
       END IF
       END IF
      END IF
 


 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³
 '³³³³³³³³³³³³³³³³³³³ Check hero ship against alienbombs. ³³³³³³³³³³³³³³³³³³³
 
 
     IF bomb.health THEN
       top(0) = hero.y
       left(0) = hero.x
       bottom(0) = hero.y + hero.h
       right(0) = hero.x + hero.w

       top(1) = bomb.y
       left(1) = bomb.x
       bottom(1) = bomb.y + bomb.h
       right(1) = bomb.x + bomb.w

      
         IF (left(0) >= right(1)) OR (left(1) > right(0)) OR (top(0) > bottom(1)) OR (top(1) > bottom(0)) THEN

         ELSE
           
           bomb.health = 0
           hero.health = hero.health - 1
           createchunks bomb.x, bomb.y
           createchunks bomb.x, bomb.y
           createchunks bomb.x, bomb.y
         END IF
       END IF
      
    
  


 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³
 '³³³³³³³³³³³³³³³³³³³ Check hero lasers against colonists. ³³³³³³³³³³³³³³³³³³


'    FOR a = 0 TO maxherolasers
'     IF col(a).y < maxy - col(a).h THEN
'      IF (col(a).x > minx) AND (col(a).x < maxx) THEN
'       IF herolaser(a).health THEN
'         IF herolaser(a).dir THEN
'           top(0) = herolaser(a).y
'           left(0) = herolaser(a).x
'           bottom(0) = herolaser(a).y
'           right(0) = herolaser(a).x
'         ELSE
'           top(0) = herolaser(a).y
'           left(0) = herolaser(a).x
'           bottom(0) = herolaser(a).y
'           right(0) = herolaser(a).x
'         END IF
'
'      FOR b = 0 TO maxcolonists
'        IF col(b).health THEN
'          top(1) = col(b).y
'          left(1) = col(b).x
'          bottom(1) = col(b).y + col(b).h
'          right(1) = col(b).x + col(b).w
        
'          IF (left(0) >= right(1)) OR (left(1) > right(0)) OR (top(0) > bottom(1)) OR (top(1) > bottom(0)) THEN

'          ELSE
'             grabber(col(b).mem1).mode = 0
'             col(b).mem1 = 0                    ' clear memory
'             col(b).mode = 0
'             col(b).health = 0
'             pickup = 0                         ' set for another
'             herolaser(a).health = FALSE
'             createchunks herolaser(a).x, herolaser(a).y
'             adlibfx
'          END IF
          
          
'        END IF
'       NEXT b
'     END IF
'    END IF
'   END IF
'   NEXT a


END SUB

SUB createalienbolt (x, y)
    
  FOR a = 0 TO maxalienbolts
     IF alienbolt(a).health = 0 AND alienbolt(a).eras = 0 THEN   '  empty spot
       
        IF timepassed(2, .6) = 0 THEN EXIT SUB
        
        alienbolt(a).x = x + 5
        alienbolt(a).y = y + 5
        alienbolt(a).mem1 = x
        alienbolt(a).mem2 = y
        alienbolt(a).oldx = alienbolt(a).x
        alienbolt(a).oldy = alienbolt(a).y
        alienbolt(a).vx = hero.x
        alienbolt(a).vy = hero.y
        alienbolt(a).h = 1
        alienbolt(a).w = 1
        alienbolt(a).eras = 0
        alienbolt(a).health = 20
        alienbolt(a).thrust = 0
        EXIT FOR
     END IF
  NEXT a




END SUB

SUB createalienshot (x, y)
 
  '  Finds an empty spot in the alienshot array and initalize it
  '  with a shot. Figures aim based on location of our hero.
  
  '  x = physical x location to shoot from
  '  y = physical y location to shot from
    
   IF alienshot.health = 0 AND alienshot.eras = 0 THEN
          
          adlibfx (4)
        alienshot.health = maxx
         
        '  x = x + fnrnd(-5)
        '  y = y + fnrnd(-5)

        IF x > hero.x THEN alienshot.dirx = 0
        IF x < hero.x THEN alienshot.dirx = 1
        IF y > hero.y THEN alienshot.diry = 0
        IF y < hero.y THEN alienshot.diry = 1


        '  IF hero.x < x THEN
        '    alienshot.dir = 1
        '  END IF

        '  IF hero.x > x THEN
        '     alienshot.dir = 0
        '  END IF

          alienshot.vx = 6
          alienshot.vy = 6
          alienshot.x = x
          alienshot.y = y
          alienshot.oldx = alienshot.x
          alienshot.oldy = alienshot.y
          alienshot.mem2 = 0
          alienshot.h = 2
          alienshot.w = 2
          alienshot.eras = 0
          alienshot.thrust = 0
         END IF

       

END SUB

 SUB createblocker

    
     IF blocker.health = 0 AND blocker.eras = 0 THEN
         blocker.vy = 1
         blocker.px = 0
         blocker.py = 0
         blocker.dir = fnrnd(2)
         blocker.h = 10
         blocker.w = 10
         blocker.eras = 0
         blocker.health = 10
         blocker.mem1 = 0
         blocker.mem2 = 0
         blocker.thrust = 0
         blocker.x = fnrnd(fieldw)
         blocker.y = 100
         blocker.cy = 0
         blocker.oldx = blocker.x
         blocker.oldy = blocker.y
   END IF

END SUB

SUB createbomb (x, y)


  IF bomb.health = 0 AND bomb.eras = 0 THEN
          IF timepassed(10, .5) = 0 THEN EXIT SUB
          adlibfx (5)
          bomb.health = (maxy * 5)
         

          IF hero.y < y THEN
            bomb.dir = 1
            END IF

          IF hero.y > y THEN
             bomb.dir = 0
            END IF
         
          IF x > hero.x THEN
            bomb.vx = 1
          END IF

          IF x < hero.x THEN
            bomb.vx = -1
          END IF


          bomb.vy = 8
          'bomb.cy = 10
          bomb.x = x
          bomb.y = y
          bomb.oldx = bomb.x
          bomb.oldy = bomb.y
        
          bomb.mem2 = 0
          bomb.h = 2
          bomb.w = 2
          bomb.eras = 0
          bomb.thrust = 0
         END IF

END SUB

SUB createbomer
 
  
  IF bomer(0).played = bomer(0).toplay THEN EXIT SUB
  IF timepassed(3, .9) = 0 THEN EXIT SUB
  
  FOR a = 0 TO maxbomers
     IF bomer(a).health = 0 AND bomer(a).eras = 0 THEN
     
         bomer(a).px = 0
         bomer(a).py = 0
         bomer(a).dir = fnrnd(2)
         bomer(a).h = 6
         bomer(a).w = 6
         bomer(a).eras = 0
         bomer(a).health = 1
         bomer(a).mem1 = 0
         bomer(a).mem2 = 0
         bomer(a).thrust = 0
         bomer(a).mode = 0
         bomer(a).x = (fnrnd(fieldw - maxx)) + maxx
         bomer(a).y = fnrnd(maxy - (25 + 35)) + 35
         bomer(a).oldx = bomer(a).x
         bomer(a).oldy = bomer(a).y

         bomer(0).played = bomer(0).played + 1
         EXIT SUB
         END IF
   NEXT a









END SUB

SUB createchaser

  IF timepassed(4, 1) = 0 THEN EXIT SUB
    IF chaser.toplay = chaser.played THEN EXIT SUB

     IF (chaser.health = 0 AND chaser.eras = 0) THEN
         chaser.cx = 0
         chaser.cy = 0
         chaser.px = 0
         chaser.py = 0
         chaser.h = 3
         chaser.w = 15
         chaser.eras = 0
         chaser.health = 1
         chaser.mem1 = 0
         chaser.mem2 = 0
         chaser.thrust = 0
         chaser.mode = 0
         chaser.x = (fnrnd(fieldw - maxx)) + maxx
         chaser.y = fnrnd(maxy - (25 + 35)) + 35
         chaser.oldx = chaser.x
         chaser.oldy = chaser.y
         chaser.played = chaser.played + 1
         EXIT SUB
         END IF
 





END SUB

 SUB createchunks (x, y)
 
  ' Find an empty spot in the array and initalize it with a chunk
  ' Chunks fly out when things collide .
 
  FOR a = 0 TO maxchunks
     IF chunk(a).health = 0 AND chunk(a).eras = 0 THEN     ' empty spot
         chunk(a).x = x
         chunk(a).y = y
         chunk(a).oldx = chunk(a).x
         chunk(a).oldy = chunk(a).y
         
         IF fnrnd(2) THEN                   ' randomly select velocitys
            chunk(a).vx = fnrnd(2) + speed
         ELSE
            chunk(a).vx = fnrnd(-2) - speed
         END IF

         IF fnrnd(2) THEN
             chunk(a).vy = fnrnd(2) + speed
         ELSE
             chunk(a).vy = fnrnd(-2) - speed
         END IF
        
         chunk(a).h = 1
         chunk(a).w = 1
         chunk(a).eras = 0                 ' erase flag
         chunk(a).health = 50              ' life of a chunk
         chunk(a).thrust = 0
         IF ct = 5 THEN EXIT FOR                          ' found one
         ct = ct + 1
     END IF
  NEXT a




END SUB

SUB createcolonists
 
  FOR a = 0 TO maxcolonists
     col(a).x = fnrnd(fieldw)
     col(a).y = (fieldh - 5)
     col(a).oldx = col(a).x
     col(a).oldy = col(a).y
     col(a).vx = 0
     col(a).vy = 0
     col(a).dir = 0
     col(a).h = 5
     col(a).w = 2
     col(a).eras = 0
     col(a).health = 1
     col(a).mode = 0
     col(a).mem1 = 0
     col(a).mem2 = 0
   NEXT a
 
END SUB

SUB creategrabber

  ' create grabber

  

  IF grabber(0).played = grabber(0).toplay THEN
    IF timepassed(0, 8) THEN grabber(0).played = grabber(0).played - 1
    EXIT SUB
  END IF

  IF timepassed(1, .9) = 0 THEN EXIT SUB     ' aliens appear about 1 per sec

  FOR a = 0 TO maxgrabbers
     IF (grabber(a).health = 0 AND grabber(a).eras = 0 AND grabber(a).mode = 0) THEN
         grabber(a).cx = 0
         grabber(a).cy = 0
         grabber(a).px = 0
         grabber(a).py = 0
         grabber(a).dirx = fnrnd(2)
         grabber(a).h = 8
         grabber(a).w = 8
         grabber(a).eras = 0
         grabber(a).health = 1
         grabber(a).mem1 = 0           ' used when picking up colonist
         grabber(a).mem2 = 0           ' used to determine if fired missle
         grabber(a).thrust = 0
         grabber(a).mode = 0
         grabber(a).x = (fnrnd(fieldw - maxx)) + maxx
         grabber(a).y = fnrnd(maxy - (25 + 35)) + 35
         grabber(a).oldx = grabber(a).x
         grabber(a).oldy = grabber(a).y
         grabber(0).played = grabber(0).played + 1
         EXIT SUB
         END IF
  NEXT a




END SUB

DEFSNG A-Z
SUB createhero
DEFINT A-Z

  'hero ship is draw here and its variables initialized.
  'This will possible be loaded from disk in the future
  
    
  IF hero.x = 0 THEN
    DIM heroimage(75, 1) AS INTEGER
    
    LINE (0, 0)-(25, 15), 0, BF      ' clear the area
    PSET (0, 0), 0                   ' set graphics cursor
    LINE -(10, 10), 0                ' move down and over a little
    LINE -(5, 15), 9                 ' defender facing right
    LINE -(25, 15), 9
    LINE -(10, 10), 9
    PAINT STEP(2, 2), 1, 9


    LINE (30, 0)-(55, 15), 0, BF      ' clear the area
    PSET (30, 0), 0                   ' set graphics cursor
    LINE -(50, 10), 0                 ' move down and over a little
    LINE -(55, 15), 9                 ' defender facing left
    LINE -(35, 15), 9
    LINE (37, 15)-(49, 11), 9
    PAINT STEP(2, 2), 1, 9


    GET (5, 10)-(25, 15), heroimage(0, 0)   ' get facing right
    GET (35, 10)-(55, 15), heroimage(0, 1)  ' get facing left

    PUT (5, 10), heroimage(0, 0)   ' hide the evidence
    PUT (35, 10), heroimage(0, 1)

 END IF
    
    hero.x = 130             ' set sprite variables for
    hero.y = maxy / 2        ' starting location
    hero.oldx = hero.x       ' so old location can be erased
    hero.oldy = hero.y
    hero.vx = 5
    hero.vy = 2
    hero.mem2 = hero.vx
    hero.h = 5               ' highth of image
    hero.w = 20              ' width of image
    hero.eras = 0            ' erase flag
    hero.health = 4          ' sprite active
    hero.thrust = 0
    hero.cx = 10
END SUB

SUB createherolaser
 
  ' find an empty spot in the heromissle array and initalizes with a
  ' new missle.
  

  FOR a = 0 TO maxherolasers
     IF herolaser(a).health = 0 AND hero.health THEN
         IF hero.dir THEN                       ' firing left
           herolaser(a).x = hero.x
           herolaser(a).y = hero.y + hero.h
           herolaser(a).dir = 1
         ELSE                                   ' firing right
           herolaser(a).x = hero.x + hero.w
           herolaser(a).y = hero.y + hero.h
           herolaser(a).dir = 0
         END IF
         herolaser(a).oldx = herolaser(a).x
         herolaser(a).oldy = herolaser(a).y
         herolaser(a).mem1 = herolaser(a).oldx
         herolaser(a).mem2 = herolaser(a).oldy
         herolaser(a).vx = 4 + speed
         herolaser(a).vy = 0
         herolaser(a).h = 1
         herolaser(a).w = 50
         herolaser(a).eras = 0
         herolaser(a).health = 1
         adlibfx (1)
         EXIT FOR
     END IF
  NEXT a
 
END SUB

SUB createmutant (x, y)

  ' create mutant

 
  FOR a = 0 TO maxcolonists
     IF mutant(a).health = 0 AND mutant(a).eras = 0 THEN
         mutant(a).px = 0
         mutant(a).py = 0
         mutant(a).dir = 0
         mutant(a).h = 8
         mutant(a).w = 8
         mutant(a).eras = 0
         mutant(a).health = 1
         mutant(a).mem1 = 0           ' used when picking up colonist
         mutant(a).mem2 = 0           ' used to determine if fired missle
         mutant(a).thrust = 0
         mutant(a).mode = 0
         mutant(a).x = x
         mutant(a).y = y
         mutant(a).oldx = mutant(a).x
         mutant(a).oldy = mutant(a).y
         EXIT FOR
         END IF
  NEXT a








END SUB

SUB createspinette (x, y)


 IF spinette.health = 0 AND spinette.eras = 0 THEN
   
    IF timepassed(8, .5) = 0 THEN EXIT SUB

   IF x > hero.x THEN spinette.dirx = 1
   IF x < hero.x THEN spinette.dirx = 0
   IF y > hero.y THEN spinette.diry = 0
   IF y < hero.y THEN spinette.diry = 1

  
   spinette.vx = 5
   spinette.vy = 5
   spinette.px = x
   spinette.py = y
   spinette.x = x
   spinette.y = y
   spinette.oldx = spinette.x
   spinette.oldy = spinette.y
   spinette.mem1 = 0
   spinette.mem2 = 0
   spinette.h = 2
   spinette.w = 2
   spinette.health = 1
  END IF




END SUB

SUB createspinner

  
  IF spinner.toplay = spinner.played THEN EXIT SUB

  IF (spinner.health = 0 AND spinner.eras = 0) THEN
    IF timepassed(5, 1) = 0 THEN EXIT SUB
    spinner.cx = 0
    spinner.cy = 0
    spinner.px = 0
    spinner.py = 0
    spinner.h = 8
    spinner.w = 8
    spinner.eras = 0
    spinner.health = 3
    spinner.mem1 = -6
    spinner.mem2 = -1
    spinner.thrust = 0
    spinner.mode = 0
    spinner.x = (fnrnd(fieldw - maxx)) + maxx
    spinner.y = fnrnd(maxy - topy) + topy
    spinner.oldx = spinner.x
    spinner.oldy = spinner.y
    spinner.played = spinner.played + 1
  END IF

   







END SUB

SUB createtracker
  
  IF tracker.toplay = tracker.played THEN EXIT SUB

  IF (tracker.health = 0 AND tracker.eras = 0) THEN
    'IF timepassed(5, 1) = 0 THEN EXIT SUB
    
    tracker.cx = 0
    tracker.cy = 0
    tracker.px = 0
    tracker.py = 0
    tracker.h = 8
    tracker.w = 8
    tracker.eras = 0
    tracker.health = 1
    tracker.mem1 = 150
    tracker.mem2 = 0
    tracker.thrust = 0
    tracker.mode = 0
    tracker.x = (fnrnd(fieldw - maxx)) + maxx
    tracker.y = fnrnd(maxy - topy) + topy
    tracker.oldx = tracker.x
    tracker.oldy = tracker.y
    tracker.played = tracker.played + 1
  END IF




END SUB

SUB drawboundrys


LINE (minx, maxy - 6)-(maxx, maxy - 6), 1
LINE (minx, miny + 35)-(maxx, miny + 35), 1


END SUB

SUB drawplayscreen

 ' draws stationary elements of the playscreen

 
  LINE (radarx - 31, radary)-(radarx + radarw - 28, radary + radarh), 1, B
  'LINE (radarx - (radarw / 2), radary)-(radarx + radarw - (radarw / 3), radary + radarh), 1, B
  LINE (radarx, radary + 1)-(radarx + 20, radary + 1), 1

  LINE (minx, topy - 1)-(maxx, topy - 1), 1


  p5x7ascfnt 5, 5, "Level", 2
  p5x7ascfnt 30, 5, STR$(level), 2

END SUB

SUB endgame
     
 STATIC a, b, c

 IF hero.health <= 1 THEN
     IF a = 0 THEN
       IF timepassed(6, 2) THEN a = 1
       createchunks hero.x + fnrnd(25), hero.y + fnrnd(10)
       IF exp1.set = 0 THEN
         exp1.set = 1
         exp1.x = hero.x + fnrnd(25)
         exp1.y = hero.y + fnrnd(25)
         exp1.size = fnrnd(35)
         exp1.colour = 14
       END IF
     ELSEIF a = 1 THEN
       exp1.set = 1
       exp1.x = hero.x + fnrnd(25)
       exp1.y = hero.y + fnrnd(10)
       exp1.size = 100
       exp1.colour = 14
       hero.health = 0
       a = 2
     ELSEIF a = 2 THEN

     IF timepassed(7, 6) THEN
       CLS
       a = 0
       COLOR 7
       PRINT "Play again (y,n) ?";
       
      IF usepages THEN PCOPY 1, 0
       DO
         a$ = INKEY$
       LOOP WHILE a$ = ""
       IF a$ = "n" OR a$ = "N" THEN END
       CLS

       level = 0
       hero.health = 4
      
     END IF
   
    END IF

 END IF


END SUB

FUNCTION joybutt
 
  STATIC hold
  ' returns the current joystick button pressed.
 
  joybyte = INP(&H201)
  joybut1 = 16 AND joybyte
  joybut2 = 32 AND joybyte
 
  IF (NOT (joybut1 AND 16) = 16) THEN joybutt = 1
  IF (NOT (joybut2 AND 32) = 32) THEN joybutt = 2

 'DO                                    ' Wait for user to press a button
 '   joystickbyte = INP(&H201)
 '  status1 = BUTTA1MASK AND joystickbyte
 '  status2 = BUTTA2MASK AND joystickbyte
 ' LOOP WHILE ((status1 AND 16) = 16) AND ((status2 AND 32) = 32)
  
 'DO                                        ' Wait for user to let go
 ' joystickbyte = INP(&H201)
 ' status1 = BUTTA1MASK AND joystickbyte
 ' status2 = BUTTA2MASK AND joystickbyte
 'LOOP WHILE status1 = 0 OR status2 = 0


  
END FUNCTION

FUNCTION joystick


 ' Routine detects, calibrates, and calculates joystick values.
 ' which procedures depend on the value of joystat.
 ' joystat = 1 - joystick detected - calibrate
 ' joystat = 2 - calibrated
 ' joystat = 3 - use stick
 ' joystat = 4 - dont use stick


 STATIC up, down, left, right, highcount '  referance variables
 SHARED joystat                '  check this value in other routines
 

 ' @ @ detect

 IF joystat = 0 THEN

   CONST detectmask = 1     ' joystat bit masks
   CONST calibmask = 2
   CONST respondmask = 4

   CONST XAXISAMASK = 1     ' Mask to isolate bit for x-axis on joysyick A
   CONST YAXISAMASK = 2     ' Mask to isolate bit for y-axis on joystick A
   CONST BUTTA1MASK = 16    ' Mask to isolate bit for button 1 on joystick A
   CONST BUTTA2MASK = 32    ' Mask to isolate bit for button 2 on joystick A
   CONST ButtB1mask = 64    ' Mask to isolate bit for button 1 on joystick B
   CONST buttB2mask = 128   ' Mask to isolate bit for button 2 on joystick B
   CONST Maxintvalue = 32767     ' Maximum value a signed integer can hold
  


   sx = 0                                  ' Prepare counter
   OUT &H201, 0                            ' set joystick bits to 1
   DO
     joybyte = INP(&H201)              ' Get joystick byte
     IF XAXISAMASK AND joybyte THEN    ' Mask unwanted bits
       sx = sx + 1                          ' Increment counter
     ELSE
       EXIT DO                              ' Bit is zero ,stop counting
     END IF
   LOOP WHILE sx < Maxintvalue             ' keep counting unless sx= 32767

   IF sx = Maxintvalue THEN
     joystat = -1
     joystick = -99
     EXIT FUNCTION
   ELSE
     joystat = 1
   END IF
 
 END IF

 ' @ @ calibrate

'   joyminx = 2: joyminy = 2           ' put this here so I wont have
'   joycenx = 56: joyceny = 54         ' to calibrate every time
'   joymaxx = 99: joymaxy = 95
'    highcount = 100
'   joystat = 2

 IF joystat = 1 THEN
   COLOR 7, 1
   CLS

   joyminx = 999      ' initalize minimum values to some big value
   joyminy = 999      ' that minimum joystick values will never equal
   boxx = 25
   boxy = 6
   curx = 1: oldcurx = 1
   cury = 1: oldcury = 1

  ' LOCATE boxy - 3, boxx - 15
   PRINT
   PRINT
   PRINT "                          Circle pad or joystick. "
   PRINT "              Calibration is complete when values stop changing,   "
   PRINT " "
  ' LOCATE boxy + 0, boxx:  PRINT "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
  ' LOCATE boxy + 1, boxx:  PRINT "³             ³             ³"
  ' LOCATE boxy + 2, boxx:  PRINT "³             ³             ³"
  ' LOCATE boxy + 3, boxx:  PRINT "³             ³             ³"
  ' LOCATE boxy + 4, boxx:  PRINT "³          Ú  ³  ¿          ³"
  ' LOCATE boxy + 5, boxx:  PRINT "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
  ' LOCATE boxy + 6, boxx:  PRINT "³          À  ³  Ù          ³"
  ' LOCATE boxy + 7, boxx:  PRINT "³             ³             ³"
  ' LOCATE boxy + 8, boxx:  PRINT "³             ³             ³"
  ' LOCATE boxy + 9, boxx:  PRINT "³             ³             ³"
  ' LOCATE boxy + 10, boxx: PRINT "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
   
    
   DO
     
     'LOCATE oldcury + boxy, oldcurx + boxx: PRINT CHR$(char)
     'char = SCREEN(cury + boxy, curx + boxx)
     'LOCATE cury + boxy, curx + boxx: PRINT "Û"
   
     LOCATE boxy + 2, boxx - 2: PRINT "Minimum x ="; joyminx
     LOCATE boxy + 3, boxx - 2: PRINT "Maximum x ="; joymaxx
     LOCATE boxy + 4, boxx - 2: PRINT "Center  x ="; joycenx; "  "
     'LOCATE boxy + 5, boxx-2: PRINT "Current x ="; joyx; "  "

     LOCATE boxy + 2, boxx + 17: PRINT "Minimum y ="; joyminy
     LOCATE boxy + 3, boxx + 17: PRINT "Maximum y ="; joymaxy
     LOCATE boxy + 4, boxx + 17: PRINT "Center  y ="; joyceny; "  "
     'LOCATE boxy + 5, boxx + 17: PRINT "Current y ="; joyy; "  "

     'LOCATE boxy + 16, boxx: PRINT "Highcount"; highcount
     LOCATE boxy + 8, boxx - 6: PRINT "   Press a joystick button to continue"
     
    
    'for i = 1 to 10000:next           'may need a delay right here

    joyy = 0: joyx = 0: c = 0: b = 0           ' Prepare counters
    
    OUT &H201, 0                           ' set joystick bits to 1
    DO
      joybyte = INP(&H201)                 ' Get joystickbyte
      IF YAXISAMASK AND joybyte THEN       ' Mask unwanted bits
        joyy = joyy + 1                    ' Increment until bit turns 0
      ELSE                                 ' do same thing to keep
        c = c + 1                          ' count accuracy
      END IF
      IF XAXISAMASK AND joybyte THEN  ' Mask unwanted bits
        joyx = joyx + 1                    ' Increment until bit turns 0
      ELSE                                 ' do same thing to keep
        c = c + 1                          ' count accuracy
      END IF
      b = b + 1
      IF (XAXISAMASK AND joybyte) = 0 AND (YAXISAMASK AND joybyte) = 0 THEN
        EXIT DO
      END IF
  
    LOOP


     IF joyx < joyminx THEN
       joyminx = joyx
     END IF

     IF joyy < joyminy THEN
       joyminy = joyy
     END IF

     IF joyx > joymaxx THEN
       joymaxx = joyx
     END IF

     IF joyy > joymaxy THEN
       joymaxy = joyy
     END IF
  
     IF b > highcount THEN
       highcount = b
     END IF


     oldcurx = curx
     oldcury = cury
  
     IF joymaxx > 27 THEN               ' scale x cooridinates into box
       xdivisor = ((joymaxx - joyminx) / 27)
       IF xdivisor < 1 THEN xdivisor = 1
       curx = joyx / xdivisor
       IF curx > 27 THEN curx = 27
       IF curx < 1 THEN curx = 1
     END IF

     IF joymaxy > 9 THEN                ' scale y cooridinates into box
       ydivisor = ((joymaxy - joyminy) / 9)
       IF ydivisor < 1 THEN ydivisor = 1
       cury = joyy / ydivisor
       IF cury > 9 THEN cury = 9
       IF cury < 1 THEN cury = 1
     END IF

     joycenx = (joymaxx + joyminx) / 2
     joyceny = (joymaxy + joyminy) / 2
  
  
     joybyte = INP(&H201)
     joybut1 = BUTTA1MASK AND joybyte
     joybut2 = BUTTA2MASK AND joybyte

   LOOP WHILE ((joybut1 AND 16) = 16) AND ((joybut2 AND 32) = 32)
   joystat = 2

 END IF


 ' Now that we have calibration information we can do what we want with it.
 ' the routines below would change to suit the application.
 '
 ' @ @ calculate referance values
 
 IF joystat = 2 THEN  'figures 80% of calibrated values in four directions
   up = joyceny - ((joyceny - joyminy) * .8)
   down = ((joymaxy - joyceny) * .8) + joyceny
   left = joycenx - ((joycenx - joyminx) * .8)
   right = ((joymaxx - joycenx) * .8) + joycenx
   joystat = 3    ' don't need to do this every time
 END IF


' @ @ calculate return values
'     I am using return value that equals the direction of the push
'     relative to degrees. I realize that a portion of the code
'     is a repeat from above. This is for speed.

 IF joystat = 3 THEN
   
  
   joyy = 0: joyx = 0: c = 0: b = 0           ' Prepare counters
   
   OUT &H201, 0                           ' set joystick bits to 1
   DO
     joybyte = INP(&H201)                 ' Get joystickbyte
     IF YAXISAMASK AND joybyte THEN       ' Mask unwanted bits
       joyy = joyy + 1                    ' Increment until bit turns 0
     ELSE                                 ' do same thing to keep
       c = c + 1                          ' count accuracy
     END IF
     IF XAXISAMASK AND joybyte THEN  ' Mask unwanted bits
       joyx = joyx + 1                    ' Increment until bit turns 0
     ELSE                                 ' do same thing to keep
       c = c + 1                          ' count accuracy
     END IF
      b = b + 1
     IF (XAXISAMASK AND joybyte) = 0 AND (YAXISAMASK AND joybyte) = 0 THEN
      IF b > highcount THEN EXIT DO
     END IF
 
   LOOP

   'LOCATE 1, 1: PRINT c
   'DO
   '  joybyte = INP(&H201)
   '  c = c + 1
   'LOOP UNTIL c >= joymax


   IF joyy <= up THEN                            ' north
     angle = 1
   END IF
  
   IF joyx >= right THEN                         ' east
     angle = 90
   END IF
  
   IF joyy >= down THEN                          ' south
     angle = 180
   END IF
  
   IF joyx <= left THEN                          ' west
     angle = 270
   END IF
                                               
   IF (joyy <= up) AND (joyx >= right) THEN      ' north east
     angle = 45
   END IF

   IF joyx >= right AND joyy >= down THEN        ' south east
     angle = 135
   END IF

   IF joyx <= left AND joyy >= down THEN         ' southwest
     angle = 225
   END IF

   IF joyy <= left AND joyx <= left THEN         ' northwest
     angle = 315
   END IF
  
 END IF

    joystick = angle

END FUNCTION

FUNCTION keyboard



 STATIC chold, althold
 aski = 0                         ' Reset aski%

 DEF SEG = &H40                   ' Check state of alt and Ctrl keys
 IF PEEK(&H17) AND &H4 THEN       ' Mask unwanted bits
   IF chold = 0 THEN              ' If Ctrl key isn't being held
     aski = Ctrl                  ' Then process it.
   END IF
   chold = 1                      ' Assume the key will be held
 ELSE
   chold = 0                      ' Ctrl key was let go
 END IF
                                
IF PEEK(&H17) AND &H8 THEN        ' Mask unwanted bits
   IF althold = 0 THEN            ' If alt key isn't being held
     aski = Alt                   ' Process the key
   END IF
   althold = 1                    ' Assume the key will be held
 ELSE
   althold = 0                    ' Alt key was let go
 END IF

    
   
 kee$ = INKEY$                     ' Get a key from the keyboard buffer
     
 IF kee$ <> "" THEN                ' If nothing was there why go on ?
   IF LEN(kee$) = 1 THEN           ' If length = 1 then its a
     aski = ASC(kee$)              ' regular key code
   ELSE                            ' Otherwise its an extended
     aski = -ASC(RIGHT$(kee$, 1))  ' key code
   END IF
 END IF


 keyboard = aski


END FUNCTION

SUB killsprites
 
  FOR a = 0 TO maxcolonists
      mutant(a).health = 0
  NEXT a
 
  FOR a = 0 TO maxchunks
    chunk(a).health = 0
  NEXT a

  FOR a = 0 TO maxgrabbers
    grabber(a).health = 0
  NEXT a
  grabber(0).played = 0
 
 
  FOR a = 0 TO maxcolonists
   mutant(a).health = 0
  NEXT a

  FOR a = 0 TO maxbomers
   bomer(a).health = 0
  NEXT a

  blocker.health = 0
  shot.health = 0
  bomb.health = 0
  chaser.health = 0

  chaser.played = 0
  bomer(0).played = 0
  grabber(0).played = 0

  exp1.set = 0


END SUB

SUB levels


 ' If all aliens have been killed next level is set up.


 STATIC proceed
 
 IF (aliensinplay = 0 AND timepassed(9, 4) = 1) OR level = 0 THEN ' delay a little
 
   CLS
   IF usepages THEN PCOPY 1, 0
   SLEEP (1)                                   '  delay a little
   killsprites                                 '  reset sprites
  
   SELECT CASE (level)

   CASE 0
     maxgrabbers = 3                           '  on playfield at once
     grabber(0).toplay = 5                     '  amount to play
     grabber(0).vx = 6: grabber(0).vy = 6      '  velocitys

     alienshot.vx = 5

     ' tracker.toplay = 4
     ' tracker.vx = 6: tracker.vy = 6

     mutant(0).vx = 6: mutant(0).vy = 6
    
     'chaser.toplay = 2
     'chaser.vx = 4: chaser.vy = 8
  
     maxbomers = 0: bomer(0).toplay = 0

     maxcolonists = 1

     'spinner.toplay = 1
     'spinner.vy = 40

     maxbomers = 1
     bomer(0).toplay = 3
     bomer(0).vx = 10: bomer(0).vy = 10
    
     'blocker.mode = 1
     'createblocker
  
   CASE 1
     maxgrabbers = 6                           '  on playfield at once
     grabber(0).toplay = 8                     '  amount to play
     grabber(0).vx = 6: grabber(0).vy = 6      '  velocitys

     alienshot.vx = 5

     mutant(0).vx = 6: mutant(0).vy = 6
   
    ' chaser.toplay = 2
    ' chaser.vx = 4: chaser.vy = 8
 
     maxbomers = 1: bomer(0).toplay = 1

     maxcolonists = 5
    
     maxbomers = 1
     bomer(0).toplay = 3
     bomer(0).vx = 10: bomer(0).vy = 10
   
     
   CASE 2
     maxgrabbers = 6                           '  on playfield at once
     grabber(0).toplay = 10                     '  amount to play
     grabber(0).vx = 5: grabber(0).vy = 5      '  velocitys

     alienshot.vx = 4

     mutant(0).vx = 5: mutant(0).vy = 5
    
     maxcolonists = 5
    
     maxbomers = 1
     bomer(0).toplay = 3
     bomer(0).vx = 8: bomer(0).vy = 8
 

   CASE 3

     maxgrabbers = 8                           '  on playfield at once
     grabber(0).toplay = 12                     '  amount to play
     grabber(0).vx = 5: grabber(0).vy = 5      '  velocitys

     alienshot.vx = 4

     ' tracker.toplay = 4
     ' tracker.vx = 6: tracker.vy = 6

     mutant(0).vx = 5: mutant(0).vy = 5
   
     'chaser.toplay = 2
     'chaser.vx = 4: chaser.vy = 8
 
   
     'spinner.toplay = 1
     'spinner.vy = 40

     maxbomers = 2
     bomer(0).toplay = 4
     bomer(0).vx = 8: bomer(0).vy = 8
   
     'blocker.mode = 1
     'createblocker

    maxcolonists = 6
  

   CASE 4
    
     maxgrabbers = 8                           '  on playfield at once
     grabber(0).toplay = 12                     '  amount to play
     grabber(0).vx = 5: grabber(0).vy = 5      '  velocitys

     alienshot.vx = 4

     ' tracker.toplay = 4
     ' tracker.vx = 6: tracker.vy = 6

     mutant(0).vx = 4: mutant(0).vy = 4
  
     'chaser.toplay = 2
     'chaser.vx = 4: chaser.vy = 8

  
     'spinner.toplay = 1
     'spinner.vy = 40

     maxbomers = 2
     bomer(0).toplay = 5
     bomer(0).vx = 7: bomer(0).vy = 7
  
     'blocker.mode = 1
     'createblocker

    maxcolonists = 7
 

    

   CASE 5
    
     maxgrabbers = 8                           '  on playfield at once
     grabber(0).toplay = 16                     '  amount to play
     grabber(0).vx = 4: grabber(0).vy = 4      '  velocitys

     alienshot.vx = 3

     ' tracker.toplay = 4
     ' tracker.vx = 6: tracker.vy = 6

     mutant(0).vx = 4: mutant(0).vy = 4
 
     'chaser.toplay = 2
     'chaser.vx = 4: chaser.vy = 8

 
     spinner.toplay = 1
     spinner.vy = 40

     maxbomers = 2
     bomer(0).toplay = 5
     bomer(0).vx = 6: bomer(0).vy = 6
 
     maxcolonists = 7



  CASE 6

     maxgrabbers = 8                           '  on playfield at once
     grabber(0).toplay = 18                     '  amount to play
     grabber(0).vx = 3: grabber(0).vy = 3      '  velocitys

     alienshot.vx = 3

     ' tracker.toplay = 4
     ' tracker.vx = 6: tracker.vy = 6

     mutant(0).vx = 3: mutant(0).vy = 3

     chaser.toplay = 2
     chaser.vx = 4: chaser.vy = 7


     spinner.toplay = 3
     spinner.vy = 20

     maxbomers = 2
     bomer(0).toplay = 5
     bomer(0).vx = 5: bomer(0).vy = 5

     maxcolonists = 7
  
    
   CASE 7

     maxgrabbers = 8                           '  on playfield at once
     grabber(0).toplay = 18                     '  amount to play
     grabber(0).vx = 2: grabber(0).vy = 2      '  velocitys

     alienshot.vx = 3

     ' tracker.toplay = 4
     ' tracker.vx = 6: tracker.vy = 6

     mutant(0).vx = 3: mutant(0).vy = 3

     chaser.toplay = 4
     chaser.vx = 2: chaser.vy = 3
    
     spinner.toplay = 3
     spinner.vy = 4

     maxbomers = 2
     bomer(0).toplay = 5
     bomer(0).vx = 3: bomer(0).vy = 3

     maxcolonists = 8
    
  
   CASE 8

     maxgrabbers = 8                           '  on playfield at once
     grabber(0).toplay = 18                     '  amount to play
     grabber(0).vx = 2: grabber(0).vy = 2      '  velocitys

     alienshot.vx = 3

     ' tracker.toplay = 4
     ' tracker.vx = 6: tracker.vy = 6

     mutant(0).vx = 2: mutant(0).vy = 2

     chaser.toplay = 4
     chaser.vx = 1: chaser.vy = 3
   
     spinner.toplay = 3
     spinner.vy = 4

     maxbomers = 2
     bomer(0).toplay = 5
     bomer(0).vx = 2: bomer(0).vy = 2

     maxcolonists = 8
  
   CASE 9

     maxgrabbers = 8                           '  on playfield at once
     grabber(0).toplay = 18                     '  amount to play
     grabber(0).vx = 2: grabber(0).vy = 2      '  velocitys

     alienshot.vx = 3

     ' tracker.toplay = 4
     ' tracker.vx = 6: tracker.vy = 6

     mutant(0).vx = 2: mutant(0).vy = 2

     chaser.toplay = 4
     chaser.vx = 2: chaser.vy = 3
  
     spinner.toplay = 5
     spinner.vy = 1

     maxbomers = 2
     bomer(0).toplay = 6
     bomer(0).vx = 1: bomer(0).vy = 1

     maxcolonists = 8


   CASE 10
    
     maxgrabbers = 8                           '  on playfield at once
     grabber(0).toplay = 18                     '  amount to play
     grabber(0).vx = 1: grabber(0).vy = 1      '  velocitys

     alienshot.vx = 3

     ' tracker.toplay = 4
     ' tracker.vx = 6: tracker.vy = 6

     mutant(0).vx = 2: mutant(0).vy = 2

     chaser.toplay = 4
     chaser.vx = 2: chaser.vy = 3
 
     spinner.toplay = 5
     spinner.vy = 1

     maxbomers = 2
     bomer(0).toplay = 6
     bomer(0).vx = 1: bomer(0).vy = 1

     maxcolonists = 8
  
   CASE ELSE
    CLS
    SCREEN 0
    WIDTH 80
    PRINT " Thats all for now. "
    PRINT " Hope to here from ya. "
    PRINT " "
    PRINT ""
    PRINT " "
    END

   END SELECT


                                '  cleanup variables
   pickup = 0                   '  allow colonist pickups
   level = level + 1            '  advance level
  
   drawplayscreen
   createcolonists
END IF


END SUB

SUB movesprites



 STATIC c1

 aliensinplay = 0                  ' reset grabber body count

 
 ' Handle movement of all sprites based on user input or there movement
 ' algorithms. Sprites are drawn and removed here .Radar positions
 ' are calculated and placed on screen

 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³
 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³ grabber ³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³
  

  FOR a = 0 TO maxgrabbers
    PSET (grabber(a).oldrx, grabber(a).oldry), 0
  
    IF NOT ((grabber(a).x < -10) OR (grabber(a).x > maxx)) THEN  ' Colonist on screen
     IF grabber(a).eras THEN
       LINE (grabber(a).oldx, grabber(a).y)-(grabber(a).oldx + grabber(a).w, grabber(a).y + grabber(a).h), 0, BF
     END IF
    END IF
    grabber(a).eras = false
                                                     ' Shot while desending ?
    IF grabber(a).health = 0 AND grabber(a).mode = 1 THEN
       pickup = 0                                     ' reset  pickup
       grabber(a).mode = 0                            ' reset grabber
    END IF
  
    IF grabber(a).health THEN
      aliensinplay = aliensinplay + 1

      traitsgrabber a                      '  personality and movement

      grabber(a).rx = (grabber(a).x / radarsx) + radarx       ' radar location
      grabber(a).ry = grabber(a).y / radarsy + radary

     
      IF grabber(a).rx > (radarwrapx + radarx) THEN grabber(a).rx = grabber(a).rx - radarw
    
      grabber(a).oldrx = grabber(a).rx
      grabber(a).oldry = grabber(a).ry

      grabber(a).oldx = grabber(a).x
      grabber(a).eras = TRUE
   
     IF NOT ((grabber(a).x < -10) OR (grabber(a).x > maxx)) THEN ' visable ?
       LINE (grabber(a).x, grabber(a).y)-(grabber(a).x + grabber(a).w, grabber(a).y + grabber(a).h), 2, BF
       'p3x5nfnt grabber(a).x, grabber(a).y, a, 2
       grabber(a).px = POINT(0)
       grabber(a).py = POINT(1)
     END IF
     PSET (grabber(a).rx, grabber(a).ry), 2
   END IF
 
  NEXT

 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³
 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³ mutant ³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³

  FOR a = 0 TO maxcolonists

    PSET (mutant(a).oldrx, mutant(a).oldry), 0
    IF (mutant(a).x > -10) AND (mutant(a).x < maxx) THEN
     IF mutant(a).eras THEN
       LINE (mutant(a).oldx, mutant(a).y)-(mutant(a).oldx + mutant(a).w, mutant(a).y + mutant(a).h), 0, BF
     END IF
    END IF
  mutant(a).eras = false
  
  IF mutant(a).health THEN
    aliensinplay = aliensinplay + 1

    traitsmutant a                      ' personality and movement

    mutant(a).rx = (mutant(a).x / radarsx) + radarx       ' radar location
    mutant(a).ry = mutant(a).y / radarsy + radary
   
    IF mutant(a).rx > (radarwrapx + radarx) THEN mutant(a).rx = mutant(a).rx - radarw
    mutant(a).oldrx = mutant(a).rx
    mutant(a).oldry = mutant(a).ry
  
    mutant(a).oldx = mutant(a).x
    mutant(a).oldy = mutant(a).y

    IF (mutant(a).x > miny) AND (mutant(a).x < maxx) THEN
      LINE (mutant(a).x, mutant(a).y)-(mutant(a).x + mutant(a).w, mutant(a).y + mutant(a).h), 4, BF
      mutant(a).px = POINT(0)
      mutant(a).py = POINT(1)
    END IF
      PSET (mutant(a).rx, mutant(a).ry), 4
      mutant(a).eras = TRUE
  END IF

  NEXT

 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³
 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³ chaser ³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³

   PSET (chaser.oldrx, chaser.oldry), 0
    IF (chaser.x > -10) AND (chaser.x < maxx) THEN
     IF chaser.eras THEN
       LINE (chaser.oldx, chaser.y)-(chaser.oldx + chaser.w, chaser.y + chaser.h), 0, BF
     END IF
    END IF
   chaser.eras = false
 
  IF chaser.health THEN
    aliensinplay = aliensinplay + 1

    traitschaser a                      ' personality and movement

    chaser.rx = (chaser.x / radarsx) + radarx       ' radar location
    chaser.ry = chaser.y / radarsy + radary
  
    IF chaser.rx > (radarwrapx + radarx) THEN chaser.rx = chaser.rx - radarw
    chaser.oldrx = chaser.rx
    chaser.oldry = chaser.ry
 
    chaser.oldx = chaser.x
    chaser.oldy = chaser.y

    IF (chaser.x > miny) AND (chaser.x < maxx) THEN
      LINE (chaser.x, chaser.y)-(chaser.x + chaser.w, chaser.y + chaser.h), 15, B
      chaser.px = POINT(0)
      chaser.py = POINT(1)
    END IF
      PSET (chaser.rx, chaser.ry), 15
      chaser.eras = TRUE
  END IF

  

 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³
 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³ bomer ³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³


  FOR a = 0 TO maxbomers
    PSET (bomer(a).oldrx, bomer(a).oldry), 0
 
    IF NOT ((bomer(a).x < -10) OR (bomer(a).x > maxx)) THEN
     IF bomer(a).eras THEN
       LINE (bomer(a).oldx, bomer(a).y)-(bomer(a).oldx + bomer(a).w, bomer(a).y + bomer(a).h), 0, BF
       LINE (bomer(a).oldx + bomer(a).w, bomer(a).oldy + bomer(a).h)-(bomer(a).oldx + bomer(a).w + bomer(a).w, bomer(a).oldy + bomer(a).h + bomer(a).h), 0, B
     END IF
    END IF
    bomer(a).eras = false

    IF bomer(a).health THEN
     
      aliensinplay = aliensinplay + 1

      traitsbomer a                      '  personality and movement

      bomer(a).rx = (bomer(a).x / radarsx) + radarx       ' radar location
      bomer(a).ry = bomer(a).y / radarsy + radary

    
     IF bomer(a).rx > (radarwrapx + radarx) THEN bomer(a).rx = bomer(a).rx - radarw
   
      bomer(a).oldrx = bomer(a).rx
      bomer(a).oldry = bomer(a).ry

      bomer(a).oldx = bomer(a).x
      bomer(a).oldy = bomer(a).y

      bomer(a).eras = TRUE
  
     IF NOT ((bomer(a).x < -10) OR (bomer(a).x > maxx)) THEN ' visable ?
       LINE (bomer(a).x, bomer(a).y)-(bomer(a).x + bomer(a).w, bomer(a).y + bomer(a).h), 3, B
       LINE (bomer(a).x + bomer(a).w, bomer(a).y + bomer(a).h)-(bomer(a).x + bomer(a).w + bomer(a).w, bomer(a).y + bomer(a).h + bomer(a).h), 3, B

       bomer(a).px = POINT(0)
       bomer(a).py = POINT(1)
     END IF
     PSET (bomer(a).rx, bomer(a).ry), 3
   END IF

  NEXT

 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³
 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³ spinner ³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³

  
    PSET (spinner.oldrx, spinner.oldry), 0

    IF NOT ((spinner.x < -10) OR (spinner.x > maxx)) THEN
     IF spinner.eras THEN
      CIRCLE (spinner.oldx, spinner.oldy), spinner.w, 0, spinner.mem1, spinner.mem2
      'p5x7ascfnt spinner.oldx, spinner.oldy, "", 0
     END IF
    END IF
    spinner.eras = false

    IF spinner.health THEN
    
      aliensinplay = aliensinplay + 1

      traitsspinner a                      '  personality and movement

      spinner.rx = (spinner.x / radarsx) + radarx       ' radar location
      spinner.ry = spinner.y / radarsy + radary

   
     IF spinner.rx > (radarwrapx + radarx) THEN spinner.rx = spinner.rx - radarw
  
      spinner.oldrx = spinner.rx
      spinner.oldry = spinner.ry

      spinner.oldx = spinner.x
      spinner.oldy = spinner.y

      spinner.eras = TRUE
 
     IF NOT ((spinner.x < -10) OR (spinner.x > maxx)) THEN ' visable ?

       c1 = (c1 + 1) MOD 16
       IF c1 = 15 THEN
        spinner.mem1 = spinner.mem1 + 1
        spinner.mem2 = spinner.mem2 + 1

        IF spinner.mem1 = 0 THEN spinner.mem1 = -6
        IF spinner.mem2 = 0 THEN spinner.mem2 = -6
       END IF
    CIRCLE (spinner.x, spinner.y), spinner.w, 9, spinner.mem1, spinner.mem2
     '  p5x7ascfnt spinner.x, spinner.y, "", 9
       spinner.px = POINT(0)
       spinner.py = POINT(1)
     END IF
     PSET (spinner.rx, spinner.ry), 9
   END IF

 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³
 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³ spinette ³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³
 '                            (spinners weapon)
   
    IF NOT ((spinette.x < minx - spinette.w) OR (spinette.x > maxx + spinette.w)) THEN
     IF spinette.eras THEN
      CIRCLE (spinette.oldx, spinette.oldy), spinette.w, 0
      PSET (spinette.x, spinette.y), 0
     END IF
    END IF
    spinette.eras = false

    IF spinette.health THEN
      aliensinplay = aliensinplay + 1
     
      traitsspinette                       '  movement
      spinette.eras = TRUE

      spinette.oldx = spinette.x
      spinette.oldy = spinette.y
   IF NOT ((spinette.x < minx - spinette.w) OR (spinette.x > maxx + spinette.w)) THEN
     CIRCLE (spinette.x, spinette.y), spinette.w, 9
     PSET (spinette.x, spinette.y), strobe
   END IF
       
   END IF
    
  
 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³
 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³ tracker ³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³

   
    IF NOT ((tracker.x < -10) OR (tracker.x > maxx)) THEN
     IF tracker.eras THEN
       p5x7ascfnt tracker.oldx, tracker.oldy, "", 0
     END IF
    END IF
    tracker.eras = false

    IF tracker.health THEN
   
      aliensinplay = aliensinplay + 1

      traitstracker a                      '  personality and movement
     
     IF tracker.rx > (radarwrapx + radarx) THEN tracker.rx = tracker.rx - radarw
 
      tracker.oldx = tracker.x
      tracker.oldy = tracker.y

      tracker.eras = TRUE

     IF NOT ((tracker.x < -10) OR (tracker.x > maxx)) THEN ' visable ?
       p5x7ascfnt tracker.x, tracker.y, "", 9
     END IF
     
   END IF

 
 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³
 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³ blocker ³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³
 
   
    PSET (blocker.oldrx, blocker.oldry), 0

    IF NOT ((blocker.x < -10) OR (blocker.x > maxx)) THEN
     IF blocker.eras THEN
       LINE (blocker.oldx, blocker.y)-(blocker.oldx + blocker.w, blocker.y + blocker.h), 0, BF
     END IF
    END IF
    blocker.eras = false

    IF blocker.health THEN
     
      traitsblocker                  '  personality and movement

      blocker.rx = (blocker.x / radarsx) + radarx       ' radar location
      blocker.ry = blocker.y / radarsy + radary

   
     IF blocker.rx > (radarwrapx + radarx) THEN blocker.rx = blocker.rx - radarw
  
      blocker.oldrx = blocker.rx
      blocker.oldry = blocker.ry

      blocker.oldx = blocker.x
      blocker.oldy = blocker.y

      blocker.eras = TRUE
 
     IF NOT ((blocker.x < -10) OR (blocker.x > maxx)) THEN ' visable ?
     'LINE (blocker(a).x, blocker(a).y)-(blocker(a).x + blocker(a).w, blocker(a).y + blocker(a).h), 3, BF
     PSET (blocker.x, blocker.y), 3
     LINE -(blocker.x + blocker.w, blocker.y), 3
     LINE -(blocker.x + (blocker.w) / 2, blocker.y + blocker.h), 3
     LINE -(blocker.x, blocker.y), 2
       'blocker(a).px = POINT(0)
       'blocker(a).py = POINT(1)
     END IF
     PSET (blocker.rx, blocker.ry), 3
   END IF


 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³
 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³ hero lasers ³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³

 FOR a = 0 TO maxherolasers
 
   IF herolaser(a).eras THEN                  '  erase old location
     LINE (herolaser(a).oldx, herolaser(a).oldy)-(herolaser(a).mem1, herolaser(a).mem2), 0
     herolaser(a).eras = false
   END IF

   IF herolaser(a).health THEN

     herolaser(a).oldx = herolaser(a).x          '  save old location
     herolaser(a).oldy = herolaser(a).y
    
     SELECT CASE herolaser(a).dir
   
     CASE 1                                       '  fired left

       IF herolaser(a).x > minx THEN
         herolaser(a).x = herolaser(a).x - herolaser(a).vx
         IF herolaser(a).mem1 > herolaser(a).x + herolaser(a).w THEN
           herolaser(a).mem1 = herolaser(a).mem1 - herolaser(a).vx
         END IF
       ELSE
         herolaser(a).mem1 = herolaser(a).mem1 - herolaser(a).vx
       END IF
    
      LINE (herolaser(a).x, herolaser(a).y)-(herolaser(a).mem1, herolaser(a).mem2), 7
        
       
      herolaser(a).eras = TRUE                     '  set erase flag
     
      IF herolaser(a).mem1 < minx THEN
         herolaser(a).health = false               ' restore array element
      END IF
  
     CASE 0                                              ' fired right
      
       IF herolaser(a).x < maxx THEN
         herolaser(a).x = herolaser(a).x + herolaser(a).vx
         IF herolaser(a).mem1 < herolaser(a).x - herolaser(a).w THEN
           herolaser(a).mem1 = herolaser(a).mem1 + herolaser(a).vx
         END IF
       ELSE
         herolaser(a).mem1 = herolaser(a).mem1 + herolaser(a).vx
       END IF
      
      LINE (herolaser(a).x, herolaser(a).y)-(herolaser(a).mem1, herolaser(a).mem2), 7
     
      IF herolaser(a).mem1 > maxx THEN
         herolaser(a).health = false               ' restore array element
      END IF
 
   END SELECT

      herolaser(a).eras = TRUE                     '  set erase flag

  END IF
 NEXT


 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³
 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³ chunks ³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³

 FOR a = 0 TO maxchunks

   IF chunk(a).eras THEN    ' erase old location
     PSET (chunk(a).oldx, chunk(a).oldy), 0
     chunk(a).eras = false
   END IF
  
   IF chunk(a).health THEN                            ' dead chunk ?
      
      chunk(a).oldx = chunk(a).x                      ' save old location
      chunk(a).oldy = chunk(a).y
      aliensinplay = aliensinplay + 1
      
      IF chunk(a).y > topy AND chunk(a).y < boty THEN   ' bounds check
        PSET (chunk(a).x, chunk(a).y), strobe           ' draw chunks
        chunk(a).thrust = chunk(a).thrust + 1
        IF chunk(a).thrust = 4 THEN                     '    slow movement
         chunk(a).x = chunk(a).x + chunk(a).vx
         chunk(a).y = chunk(a).y + chunk(a).vy           '  move chunk
         chunk(a).eras = TRUE                            '  erase later
         chunk(a).health = chunk(a).health - 1          '  shorten life
         chunk(a).thrust = 0
       END IF

      ELSE
        chunk(a).health = false                  '  open array element
      END IF
   END IF
 NEXT


 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³
 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³ explosion 1 ³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³


  IF exp1.set THEN
     IF exp1.size > exp1.y - topy THEN exp1.size = exp1.y - topy
       IF exp1.x < maxx THEN
       exp1.c1 = exp1.c1 + 1
       IF exp1.c1 < exp1.size THEN
         CIRCLE (exp1.x, exp1.y), exp1.c1, exp1.colour
         PAINT (exp1.x, exp1.y), exp1.colour, exp1.colour
         exp1.c2 = ABS(exp1.c1 - 2)
         CIRCLE (exp1.x, exp1.y), exp1.c2, 0
         PAINT (exp1.x, exp1.y), 0, 0
         
       ELSEIF exp1.c1 >= exp1.size THEN
         CIRCLE (exp1.x, exp1.y), exp1.size, 13
         PAINT (exp1.x, exp1.y), 1, 13
         CIRCLE (exp1.x, exp1.y), exp1.size, 0
         PAINT (exp1.x, exp1.y), 0, 0
         createchunks exp1.x, exp1.y
         createchunks exp1.x, exp1.y
          exp1.c1 = 0
          exp1.set = 0
         END IF
    END IF
  END IF


 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³
 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³ hero ³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³


  IF hero.eras THEN
     LINE (hero.oldx, hero.oldy)-(hero.oldx + hero.w, hero.oldy + hero.h), 0, BF
     hero.eras = false
  END IF
 
   PSET (hero.oldrx, hero.oldry), 0

  IF hero.health > 0 THEN

    hero.oldrx = hero.rx: hero.oldry = hero.ry     ' radar
    hero.rx = (hero.x / radarsx) + radarx
    hero.ry = hero.y / radarsy + radary
    IF hero.rx > (radarwrapx + radarx) THEN col(a).rx = col(a).rx - radarw
    PSET (hero.rx, hero.ry), 7
   
    
    traitshero                                       'controled user input
    processgpi

     IF hero.dir THEN                                 ' facing left
       IF hero.x <= thrdx THEN                        ' fall back ?
          hero.x = hero.x + speed                     ' fall to left
       '   hero.thrust = hero.thrust - speed
       END IF
     
       PUT (hero.x, hero.y), heroimage(0, 1), PSET
     
      LINE (hero.x + hero.w - 3, hero.y)-(hero.x + hero.w, hero.y + 3), strobe
     ELSE                                            ' facing right
       IF hero.x >= qtrx THEN                       ' fall back ?
         hero.x = hero.x - speed                         ' fall to left
       '  hero.thrust = hero.thrust + speed
       END IF
         PUT (hero.x, hero.y), heroimage(0, 0), PSET
       LINE (hero.x + 3, hero.y)-(hero.x, hero.y + 3), strobe
     END IF
  END IF


 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³
 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³ alien shots ³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³

  
   IF alienshot.eras THEN                          '  erase old location
     LINE (alienshot.x, alienshot.y)-(alienshot.x + alienshot.w, alienshot.y + alienshot.h), 0, B
     alienshot.eras = false
   END IF
  
   IF alienshot.health THEN

       
       traitsalienshot
      
       alienshot.oldx = alienshot.x          '  save old location
       alienshot.oldy = alienshot.y
     
       LINE (alienshot.x, alienshot.y)-(alienshot.x + alienshot.w, alienshot.y + alienshot.h), 14, B
       
       alienshot.eras = TRUE
   END IF
   
  
 

 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³
 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³ alien bombs ³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³


   IF bomb.eras THEN                          '  erase old location
     LINE (bomb.x, bomb.y)-(bomb.x + bomb.w, bomb.y + bomb.h), 0, BF
     bomb.eras = false
   END IF


   IF bomb.health THEN
    
     IF (bomb.x > minx) AND (bomb.x < maxx) AND (bomb.y > topy) AND (bomb.y < boty) THEN

       bomb.x = bomb.x - hero.thrust
       IF bomb.dir = 1 THEN
         bomb.cy = bomb.cy + 1
         IF bomb.cy = bomb.vy THEN
           bomb.y = bomb.y - speed
           bomb.x = bomb.x - speed - bomb.vx
           bomb.cy = 0
         END IF
       ELSEIF bomb.dir = 0 THEN
          bomb.cy = bomb.cy + 1
         IF bomb.cy = bomb.vy THEN
           bomb.y = bomb.y + speed
           bomb.x = bomb.x + speed + bomb.vx
           bomb.cy = 0
         END IF
       END IF
      
       

       bomb.oldx = bomb.x          '  save old location
       bomb.oldy = bomb.y
       colour = strobe
       LINE (bomb.x, bomb.y)-(bomb.x + bomb.w, bomb.y + bomb.h), colour, BF
       bomb.health = bomb.health - 1    ' shorten life
       bomb.eras = TRUE
     ELSE
      bomb.health = 0
     END IF
   
  END IF
 

 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³
 '³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³ colonists ³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³³

  FOR a = 0 TO maxcolonists

   PSET (col(a).oldrx, col(a).oldry), 0

   IF NOT ((col(a).x < -10) OR (col(a).x > maxx)) THEN  ' Colonist on screen
     IF col(a).eras THEN
       LINE (col(a).oldx, col(a).y)-(col(a).oldx + col(a).w, col(a).y + col(a).h), 0, BF
     END IF
   END IF

   col(a).eras = false

   IF col(a).health THEN                         ' sprite is alive
  
     traitscolonist a

     col(a).rx = (col(a).x / radarsx) + radarx   '  radar location
     col(a).ry = col(a).y / radarsy + radary
       
     IF col(a).rx > (radarwrapx + radarx) THEN col(a).rx = col(a).rx - radarw
     col(a).oldrx = col(a).rx                '  save old spot
     col(a).oldry = col(a).ry
       

     col(a).oldx = col(a).x                  '  save old spot
     col(a).oldy = col(a).y

     col(a).eras = TRUE                     ' erase it later

      IF NOT ((col(a).x < -10) OR (col(a).x > maxx)) THEN  ' Colonist on screen
        LINE (col(a).x, col(a).y)-(col(a).x + col(a).w, col(a).y + col(a).h), 14, BF
        'col(a).px = POINT(0)
        'col(a).py = POINT(1)
        'p3x5numfnt col(a).px - col(a).w, col(a).py - col(a).h, a, 4
      END IF
      PSET (col(a).rx, col(a).ry), 14

    END IF
  NEXT


END SUB

SUB p3x5numfnt (x, y, num, colour)
 
  ' Print num at location (x,y) in attribute colour.
 
  STATIC a3x5numfnt()
  
  IF x = -999 THEN
    DIM a3x5numfnt(9, 2, 4)
    DEF SEG = VARSEG(a3x5numfnt(0, 0, 0))         ' load in image file
    BLOAD "NUM3X5.FNT", 0
    DEF SEG
  END IF
 
  text$ = LTRIM$(STR$(num))
  length = LEN(text$) - 1

   FOR ptr = 0 TO length
     n = ASC(MID$(text$, ptr + 1, 1)) - 48
      FOR h = 0 TO 4
       FOR w = 0 TO 2
         IF a3x5numfnt(n, w, h) = 1 THEN PSET (w + x + kernx, y + h), colour
       NEXT w
     NEXT h
     kernx = kernx + 4
   NEXT ptr

END SUB

SUB p5x7ascfnt (x, y, text$, colour)

 ' x and y set screen location to start printing contents of text$.
 ' Text$ can contain any valid ascii character between 0 and 127.
 ' colour is the color you would like

  STATIC a5x7ascfnt()
 
  IF x = -999 THEN
    DIM a5x7ascfnt(127, 4, 6)
    DEF SEG = VARSEG(a5x7ascfnt(0, 0, 0))         ' load in image file
    BLOAD "ASCII5X7.FNT", 0
    DEF SEG
  END IF
 

  l = LEN(text$)                 ' How many times to loop?
  IF l = 0 THEN EXIT SUB         ' Nothing to do.

  FOR ptr = 0 TO l - 1       ' -1 is for Mid$ unability to deal with a zero

   piece$ = MID$(text$, ptr + 1, 1)   ' look at each piece of string

   n = ASC(piece$)                     ' assign it's ascii value
 
  SELECT CASE (piece$)      ' adjust lower case letter down where nessesary
                            ' looks nice
   CASE "g"
     kerny = kerny + 2
   CASE "j"
     kerny = kerny + 2
   CASE "p"
     kerny = kerny + 2
   CASE "q"
     kerny = kerny + 2
   CASE "y"
     kerny = kerny + 2
   END SELECT

                                ' write the character
  FOR h = 0 TO 6
   FOR w = 0 TO 4
     IF a5x7ascfnt(n, w, h) = 1 THEN
       PSET (x + w + kernx, y + h + kerny), colour
     END IF
   NEXT
  NEXT

  SELECT CASE (piece$)         ' Kern adjusment
                               ' adjust x value for even spacing
   CASE "i"
     kernx = kernx + 2
   CASE "j"
     kernx = kernx + 5
   CASE "l"
     kernx = kernx + 2
   CASE "r"
     kernx = kernx + 5
   CASE "."
     kernx = kernx + 3
   CASE "("
     kernx = kernx + 3
   CASE ")"
     kernx = kernx + 3
   CASE "'"
     kernx = kernx + 2
   CASE "!"
    kernx = kernx + 2
   CASE ELSE
     kernx = kernx + 6
  END SELECT

   kerny = 0

NEXT


END SUB

 SUB printins

 CLS
 PRINT " To Play : "
 PRINT " "
 PRINT " Use the joystick to move the ship around and press either"
 PRINT " joystick button to fire. But a gamepad will provide better "
 PRINT " respose."
 PRINT " Fire at everything. If a green alien grabs a colonist"
 PRINT " at the bottom shoot him before he reaches the top of the screen."
 PRINT " If you fail to do this the colonist will be converted to a"
 PRINT " mutant who will try to attack you. If you shoot the green alien"
 PRINT " before he reaches the top with the colonist, the colonist will fall."
 PRINT " Try to catch him with your ship and bring him to the bottom before"
 PRINT " he lets go from exhaustion and drops to his death."
 PRINT ""
 COLOR 14
 PRINT " During the game press :"
 PRINT " +    to speed up game"
 PRINT " -    to slow it down "
 PRINT " esc  to end the game"
 PRINT : PRINT
 PRINT "Press any key to continue."


DO: LOOP WHILE INKEY$ = ""
END SUB

SUB printme
CLS
PRINT " Thanks for downloading the program. "
PRINT " "
PRINT " I was messing around with the old Atari 2600 and though I would"
PRINT " give defender a try. This is just a test to see what it would "
PRINT " involve and may not work correctly on all systems. Speaking of "
PRINT " which the program is far form perfect. The control is a little"
PRINT " difficult and there are a few occasions when it acts wierdly."
PRINT " But I thougt it was interesting so I fiqured I'd see what everybody"
PRINT " else thinks."
PRINT " "
PRINT " Questions, Comments or Critisims :"
PRINT " AOL -Tim Truman"
PRINT " Compuserve - 74734,2203"
PRINT " "
COLOR 14
'PRINT "Use pages (y,n)?"; : COLOR 7: PRINT "     Select y if your pc is very fast"
'DO
'  a$ = INKEY$
'LOOP UNTIL LCASE$(a$) = "y" OR LCASE$(a$) = "n"
'IF LCASE$(a$) = "y" THEN
'  Pageswap = TRUE
'ELSE
  Pageswap = false
'END IF
COLOR 7
PRINT
PRINT "Press any key. "

DO: LOOP WHILE INKEY$ = ""


END SUB

SUB processgpi


 aski = keyboard
 

 SELECT CASE (aski)

 CASE 8                                  ' Backspace key
           
 CASE 9                                  ' Tab key
           
 CASE 13                                 ' Return
           
 CASE 27                                 ' Escape key
   END
 CASE 32, 53                             ' Space bar ,Five Key
   createherolaser
 CASE 43, 61                                ' + , =
   delay = delay - 100
   IF delay < 0 THEN
     delay = 0
     speed = speed + 1
     IF speed > 6 THEN speed = 6
   END IF

 CASE 45, 95                                ' - , _
   speed = speed - 1
   IF speed < 1 THEN speed = 1
   delay = delay + 100
   
 'CASE 22 TO 127                          ' Letter keys
           
 CASE -59                                ' Function key 1
   level = level + 1
 CASE -60                                ' Function key 2
           
 CASE -61                                ' Function key 3
           
 CASE -62                                ' Function key 4
           
 CASE -63                                ' Function key 5
           
 CASE -64                                ' Function key 6

 CASE -65                                ' Function key 7
           
 CASE -66                                ' Function key 8
           
 CASE -67                                ' Function key 9
           
 CASE -68                                ' Function key 10
           
 CASE -133                               ' Function key 11
           
 CASE -134                               ' Function key 12
           
 CASE -71                                ' Home

 CASE -72, 56                            ' Up key ,Eight key
  
    'hero.cy = hero.cy + 1
    'IF hero.cy >= hero.vy THEN
      hero.y = hero.y - speed - keyspeed
      'hero.cy = 0
    'END IF

 CASE -75, 52                             ' Left key
    hero.thrust = -speed - keyspeed
    hero.dir = 1

 CASE -77, 54                               ' Right key
    hero.thrust = speed + keyspeed
    hero.dir = 0

 CASE -79                                ' End key

 CASE -80, 50                               ' Down key
    'hero.y = hero.y + hero.vy
    'hero.cy = hero.cy + 1
    'IF hero.cy >= hero.vy THEN
      hero.y = hero.y + speed + keyspeed
      hero.cy = 0
    'END IF
  
 CASE -82                                ' Insert key

 CASE -83                                ' Delete key

 CASE Ctrl

 CASE Alt

 CASE ELSE                               ' do nothing
                 
 END SELECT

 IF hero.y < topy THEN hero.y = topy
 IF hero.y > maxy - col(0).h - hero.h - 2 THEN hero.y = maxy - col(0).h - hero.h - 2
 

 IF hero.x < 0 THEN hero.x = minx
 IF hero.x > (maxx - hero.vx - hero.w) THEN hero.x = maxx - hero.w - 1


END SUB

SUB setfxmode

  ' setscreen and scales relavent varables


  
  IF Pageswap THEN
     SCREEN 7, , 1, 0
  ELSE
    SCREEN 13
  END IF


  minx = 0               ' actual physical coordinates of screen mode
  miny = 0

 'maxx = 649
 'maxy = 199

  maxx = 319
  maxy = 199


 qtrx = maxx / 4
 thrdx = qtrx * 3

 topy = miny + (maxy / 7)' + 28       ' top and bottom physical boundrys
 boty = maxy - 5

 fieldw = maxx * 4      ' virtual play field
 fieldh = maxy

 radarsx = 16                 ' radar scale down
 radarsy = 8

 radarw = fieldw / radarsx    ' physical radar size
 radarh = fieldh / radarsy

 radarx = (maxx / 2) - 10        ' physical radar location
 radary = 1

 radarwrapx = (radarw / 2) + (radarw / 9)  ' for radar wrap
 radar2thrd = radar1thrd * 2


END SUB

SUB starfield

 SHARED maxx, maxy
 STATIC first, oldstarx() AS INTEGER, oldstary() AS INTEGER
 STATIC starx() AS INTEGER, stary() AS INTEGER, starspeed() AS INTEGER
 STATIC starvx() AS INTEGER, ns

  IF ns = 0 THEN                     ' First time here initialize values
    ns = 25                          ' Number of stars
    DIM oldstarx(ns)   AS INTEGER
    DIM oldstary(ns)   AS INTEGER
    DIM starx(ns)      AS INTEGER
    DIM stary(ns)      AS INTEGER
    DIM starspeed(ns)  AS INTEGER
    DIM starvx(ns)    AS INTEGER
    FOR c = 0 TO ns
        stary(c) = fnrnd(maxy - (25 + 35)) + 35
        starx(c) = fnrnd(maxx)
        starspeed(c) = 1'fnrnd(2) + 1
     NEXT
 END IF



  FOR c = 0 TO ns                                 '    erase old points
     PSET (starx(c), stary(c)), 0
  NEXT

  ' ** use a delay here if you dont use page switching  **
  'FOR x! = 0 TO 1000: NEXT

 'IF hero.thrust THEN LOCATE 1, 1: PRINT hero.dir; hero.thrust
  IF (hero.dir = 1) AND hero.thrust THEN
    FOR c = 0 TO ns

      oldstary(c) = stary(c)           '   save position to erase oldstar
      oldstarx(c) = starx(c)
    
      IF oldstary(c) = 0 THEN
        stary(c) = fnrnd(maxy - (topy + 35)) + 35
        starspeed(c) = 1'fnrnd(2) + 1
        oldstary(c) = stary(c)
      END IF
   
    'starvx(c) = ((starvx(c) + 1) MOD 4)
    'IF starvx(c) = 3 THEN starx(c) = starx(c) + starspeed(c)

      starx(c) = starx(c) - hero.thrust

    IF starx(c) > maxx THEN
      stary(c) = 0
      starx(c) = 0
    END IF
   NEXT
  END IF

   IF hero.dir = 0 AND hero.thrust THEN

    FOR c = 0 TO ns

      oldstary(c) = stary(c)           '   save position to erase oldstar
      oldstarx(c) = starx(c)
    
      IF oldstary(c) = maxy THEN
        stary(c) = fnrnd(maxy - (topy + 35)) + 35
        starspeed(c) = 1'fnrnd(2) + 1
        oldstary(c) = stary(c)
      END IF
    
         
      'starvx(c) = ((starvx(c) + 1) MOD 4)
      'IF starvx(c) = 3 THEN starx(c) = starx(c) - starspeed(c)
   
      starx(c) = starx(c) - hero.thrust
      IF starx(c) < 1 THEN
        stary(c) = maxy
        starx(c) = maxx
      END IF

   NEXT
   END IF

   FOR c = 0 TO ns
      PSET (starx(c), stary(c)), 7
   NEXT






END SUB

FUNCTION strobe

  ' returns next color
  STATIC colour
  colour = (colour + 1) MOD 16
  strobe = colour


END FUNCTION

FUNCTION timepassed (n, tsecs!)

  STATIC getclock(), oldtsecs!(), time1!()

  IF tsecs! = 0 THEN
    DIM getclock(n)
    DIM oldtsecs!(n)
    DIM time1!(n)
  END IF


 IF tsecs! <> oldtsecs!(n) THEN getclock(n) = 0

 IF getclock(n) = 0 THEN
   time1!(n) = TIMER
   getclock(n) = 1
   oldtsecs!(n) = tsecs!
 ELSE
   IF ABS(TIMER - time1!(n)) >= tsecs! THEN
       timepassed = 1
       getclock(n) = 0
   ELSE
       timepassed = 0
   END IF
 END IF


END FUNCTION

SUB traitsalienshot

'     IF (alienshot.x > minx) AND (alienshot.x < maxx) AND (alienshot.y > topy) AND (alienshot.y < boty) THEN
'       alienshot.x = alienshot.x - hero.thrust
'       IF alienshot.dir = 1 THEN
'         alienshot.cx = alienshot.cx + 1
'         IF alienshot.cx = alienshot.vx THEN
'           alienshot.x = alienshot.x - speed
'           alienshot.cx = 0
'         END IF
     
'       ELSEIF alienshot.dir = 0 THEN
'         alienshot.cx = alienshot.cx + 1
'         IF alienshot.cx = alienshot.vx THEN
'           alienshot.x = alienshot.x + speed
'           alienshot.cx = 0
'         END IF
'
'       END IF
     
'       alienshot.y = alienshot.y + alienshot.vy


  IF hero.thrust THEN alienshot.x = alienshot.x - hero.thrust

   IF alienshot.dirx = 0 THEN
      alienshot.cx = alienshot.cx + 1
      IF alienshot.cx > alienshot.vx THEN
        alienshot.x = alienshot.x - speed
        alienshot.cx = 0
      END IF
   END IF

   IF alienshot.dirx = 1 THEN
      alienshot.cx = alienshot.cx + 1
      IF alienshot.cx > alienshot.vx THEN
        alienshot.x = alienshot.x + speed
        alienshot.cx = 0
       
      END IF
   END IF

   IF alienshot.diry = 0 THEN
      alienshot.cy = alienshot.cy + 1
      IF alienshot.cy > alienshot.vy THEN
        alienshot.y = alienshot.y - speed
        alienshot.cy = 0
      END IF
   END IF

   IF alienshot.diry = 1 THEN
      alienshot.cy = alienshot.cy + 1
      IF alienshot.cy > alienshot.vy THEN
        alienshot.y = alienshot.y + speed
        alienshot.cy = 0
      END IF
   END IF

 

  IF alienshot.x > maxx OR alienshot.x < minx THEN alienshot.health = 0

  IF alienshot.x > fieldw THEN alienshot.x = 0        ' bounds check
  IF alienshot.x < 0 THEN alienshot.x = fieldw

  IF alienshot.y < topy + alienshot.h THEN
    alienshot.health = 0
    'PRINT "ahloha"
  END IF

  IF alienshot.y > boty - alienshot.h THEN
    alienshot.health = 0
    
  END IF

END SUB

SUB traitsblocker


  IF hero.thrust THEN blocker.x = blocker.x - hero.thrust

     blocker.cy = blocker.cy + 1
     IF blocker.cy = blocker.vy THEN
       IF blocker.dir THEN
         blocker.y = blocker.y + speed
       ELSE
         blocker.y = blocker.y - speed
      END IF
      blocker.cy = 0
     END IF


  IF blocker.x > fieldw THEN blocker.x = 0        ' bounds check
  IF blocker.x < 0 THEN blocker.x = fieldw


  IF blocker.y > boty - blocker.h THEN     ' bounds check
  '  IF blocker.mode = 0 THEN
  '    blocker.y = topy
  '  ELSEIF blocker.mode = 1 THEN
      blocker.dir = 0
  '  END IF
  END IF

  IF blocker.y < topy + blocker.vy THEN
  '  IF blocker.mode = 0 THEN
  '    blocker.y = boty - blocker.h
  '  ELSEIF blocker.mode = 1 THEN
      blocker.dir = 1
  '  END IF
  END IF




END SUB

SUB traitsbomer (a)

   IF hero.thrust THEN bomer(a).x = bomer(a).x - hero.thrust

   IF (bomer(a).x > minx) AND (bomer(a).x < maxx - bomer(a).w) THEN '  Shoot at hero.
      createbomb bomer(a).px, bomer(a).py
   END IF


     bomer(a).cx = bomer(a).cx + 1
     IF bomer(0).vx < bomer(a).cx THEN
       IF bomer(a).dir THEN
         bomer(a).x = bomer(a).x + speed
        ELSE
         bomer(a).x = bomer(a).x - speed
       END IF
       bomer(a).cx = 0
     END IF
   
     bomer(a).cy = bomer(a).cy + 1
     IF bomer(0).vy < bomer(a).cy THEN
       IF bomer(a).dir THEN
         bomer(a).y = bomer(a).y + speed
       ELSE
         bomer(a).y = bomer(a).y - speed
      END IF
      bomer(a).cy = 0
     END IF

  IF bomer(a).x > fieldw THEN bomer(a).x = 0        ' bounds check
  IF bomer(a).x < 0 THEN bomer(a).x = fieldw
 
  IF bomer(a).y > boty - bomer(a).h THEN bomer(a).y = topy + bomer(a).h  ' bounds check
  IF bomer(a).y < topy + bomer(a).h THEN bomer(a).y = boty - bomer(a).h


END SUB

SUB traitschaser (a)

    IF hero.thrust THEN chaser.x = chaser.x - hero.thrust

    
    ' match hero.y when on screen
    IF chaser.x > minx AND chaser.x < maxx THEN

       IF chaser.y < hero.y THEN
        chaser.cy = chaser.cy + 1
        IF chaser.vy = chaser.cy THEN
          chaser.y = chaser.y + speed
          chaser.cy = 0
        END IF
       END IF

       IF chaser.y > hero.y THEN
        chaser.cy = chaser.cy + 1
        IF chaser.vy = chaser.cy THEN
          chaser.y = chaser.y - speed
          chaser.cy = 0
        END IF
       END IF
  
      chaser.mem1 = 1
    END IF

    ' find hero.x after being found

    IF chaser.mem1 = 1 THEN

    IF chaser.x < minx OR chaser.px > maxx THEN speedier = 1 ELSE speedier = 0


     chaser.cx = chaser.cx + 1
      
     IF chaser.x > hero.x THEN
      IF chaser.vx <= chaser.cx THEN
         chaser.x = chaser.x - speed - speedier
         chaser.cx = 0
      END IF
     ELSEIF chaser.x < hero.x THEN
      IF chaser.vx <= chaser.cx THEN
         chaser.x = chaser.x + speed + speedier
         chaser.cx = 0
      END IF
     END IF
   
   
   END IF

  IF chaser.x > fieldw THEN chaser.x = 0        ' bounds check
  IF chaser.x < 0 THEN chaser.x = fieldw

  IF chaser.y < topy THEN chaser.y = topy
  IF chaser.y > boty - chaser.h THEN chaser.y = boty - chaser.h



END SUB

SUB traitscolonist (a)

     'IF hero.thrust THEN                         ' move according to hero
       col(a).x = col(a).x - hero.thrust
       IF col(a).x > fieldw THEN col(a).x = 0
       IF col(a).x < 0 THEN col(a).x = fieldw
       col(a).eras = TRUE
     'END IF
 

    IF col(a).mode = 1 THEN                      '  grabber has colonist
       IF (grabber(col(a).mem1).health > 0) THEN
          col(a).cx = col(a).cx + 1
          IF col(a).cx >= grabber(0).vy THEN
            col(a).y = col(a).y - speed
            col(a).cx = 0
          END IF
          col(a).mem2 = col(a).y                 ' in case grabber gets shot
       ELSE                                      ' grabber was shot
         col(a).cx = ((col(a).cx + 1) MOD 8)
         IF col(a).vy >= col(a).cx THEN          ' slow down the drop
           col(a).y = col(a).y + speed
           IF col(a).y > maxy - 6 THEN
             grabber(col(a).mem1).mode = 0       ' reset variables
             col(a).mem1 = 0
             col(a).mode = 0
             col(a).dir = 0
             pickup = 0
             b = timepassed(11, 1)               ' reset timer 11
             IF col(a).mem2 < maxy - 75 THEN
               createchunks col(a).x, col(a).y - 10
               col(a).health = 0
             END IF
           END IF
         END IF
       END IF

   ELSEIF col(a).mode = 2 THEN             ' hero got em

     col(a).x = hero.x: col(a).y = hero.y
     col(a).dir = 1
     col(a).mem2 = col(a).y
     IF timepassed(11, 3) THEN col(a).mode = 1
     IF hero.y > boty - 10 THEN col(a).mode = 1
 
   END IF





END SUB

SUB traitsgrabber (a)

  '  Grabber personality defined here.
   
   SHARED pickup
   STATIC ctr1, ctr2, ctr3
  'IF hero.thrust THEN
   grabber(a).x = grabber(a).x - hero.thrust
 
   IF (grabber(a).x > minx) AND (grabber(a).x < maxx) THEN   '  Shoot at hero.
      createalienshot grabber(a).px, grabber(a).py
   END IF


  SELECT CASE grabber(a).mode

  CASE 0                                         ' looking for colonist
    
     grabber(a).cx = grabber(a).cx + 1
     IF grabber(0).vx <= grabber(a).cx THEN
      IF grabber(a).dirx = 0 THEN
        grabber(a).x = grabber(a).x + speed
      ELSEIF grabber(a).dirx = 1 THEN
        grabber(a).x = grabber(a).x - speed
      END IF
      'ctr1 = ctr1 + 1
     grabber(a).cx = 0
    END IF

    IF level < 5 THEN
     
      IF ctr1 > 200 THEN grabber(a).diry = 1
      IF ctr1 > 310 THEN grabber(a).diry = 3
      IF ctr1 > 400 THEN grabber(a).diry = 0
      IF ctr1 > 490 THEN ctr1 = 0


       IF ctr1 > 200 AND ctr1 < 490 THEN
        grabber(a).cy = grabber(a).cy + 1
        IF grabber(0).vy = grabber(a).cy THEN
          IF grabber(a).diry = 0 THEN
            grabber(a).y = grabber(a).y + speed
          ELSEIF grabber(a).diry = 1 THEN
            grabber(a).y = grabber(a).y - speed
          END IF
         grabber(a).cy = 0
        END IF
      END IF
    ELSE
   

    END IF
   
    IF pickup = 0 THEN
     ' COLOR strobe
     ' LOCATE 1, 1: PRINT "looking"
      FOR b = 0 TO maxcolonists         '  pick up when visible 
       ' IF (col(b).x > 0) AND (col(b).x < maxx) AND col(b).health THEN
          IF col(b).health THEN
            IF grabber(a).x = col(b).x THEN         ' got that sucker
              IF fnrnd(2) = 0 THEN                  ' pick at random
               grabber(a).mode = 1                   ' pick up  mode
               grabber(a).mem1 = b                   ' remember the colonist
               col(b).mem1 = a                       ' remember the grabber
               pickup = 1
              END IF
            END IF
          END IF
       ' END IF
     NEXT
    END IF
   
  
  CASE 1                                         '  desend over victom  ;)
    'COLOR strobe
    'LOCATE 1, 10: PRINT "desending"
    grabber(a).cy = grabber(a).cy + 1
   
    IF grabber(a).cy = grabber(0).vy THEN
      grabber(a).y = grabber(a).y + speed
      grabber(a).cy = 0
    END IF

    IF grabber(a).y > maxy - grabber(a).h - 5 THEN
      grabber(a).y = maxy - grabber(a).h - 5
      grabber(a).mode = 2
      adlibfx (2)
    END IF

  CASE 2                                          ' pick up victom

    'COLOR strobe
    'LOCATE 1, 20: PRINT "Picking up"

    grabber(a).cy = grabber(a).cy + 1
    IF grabber(a).cy = grabber(0).vy THEN
      grabber(a).y = grabber(a).y - speed
      col(grabber(a).mem1).mode = 1
      grabber(a).cy = 0
    END IF
     
    IF grabber(a).y < topy THEN     ' did grabber reach top ?
      grabber(a).y = topy
      grabber(a).mode = 3
    END IF
                                      ' convert to mental grabber
    CASE 3
       'COLOR strobe
       'LOCATE 1, 31: PRINT "Mental  "
       col(grabber(a).mem1).health = 0
       col(grabber(a).mem1).mode = 0
       grabber(a).mode = 0
       grabber(a).mem1 = 0
       grabber(a).health = 0
       pickup = 0
       adlibfx (3)
       createmutant grabber(a).x, grabber(a).y
   
  END SELECT


  IF grabber(a).y > boty - grabber(a).h THEN grabber(a).y = topy ' bounds check
  IF grabber(a).y < topy THEN grabber(a).y = boty - grabber(a).h

    
  IF grabber(a).x > fieldw THEN grabber(a).x = 0        ' bounds check
  IF grabber(a).x < 0 THEN grabber(a).x = fieldw


END SUB

SUB traitshero

 ' hero controled by user input

 hero.oldy = hero.y
 hero.oldx = hero.x
 hero.eras = TRUE
 
 degrees = joystick

 hero.thrust = false

 'IF hero.x <= thrdx THEN                        ' fall back ?
 '  hero.x = hero.x + speed                      ' fall to left
 '  'hero.thrust = hero.thrust - speed
 '  degrees = 270
 'END IF
 'IF hero.x >= qtrx THEN                       ' fall back ?
 '   hero.x = hero.x - speed                         ' fall to left
 '  hero.thrust = hero.thrust + speed
 ' degrees = 90
 'END IF


 SELECT CASE (degrees)
 CASE 1                                   '  north
    hero.cy = hero.cy + 1
    IF hero.cy >= hero.vy THEN
      hero.y = hero.y - speed
      hero.cy = 0
    END IF
 CASE 45                                  '  north east
    'hero.y = hero.y - hero.vy
    hero.cy = hero.cy + 1
    IF hero.cy >= hero.vy THEN
      hero.y = hero.y - speed
      hero.cy = 0
    END IF

    hero.thrust = speed
    hero.dir = 0
 CASE 90                                  '  east
    hero.thrust = speed
    hero.dir = 0
 CASE 135                                 '  south east
    
    hero.cy = hero.cy + 1
    IF hero.cy >= hero.vy THEN
      hero.y = hero.y + speed
      hero.cy = 0
    END IF

    hero.thrust = speed
    hero.dir = 0
 CASE 180                                 '  south
    'hero.y = hero.y + hero.vy
    hero.cy = hero.cy + 1
    IF hero.cy >= hero.vy THEN
      hero.y = hero.y + speed
      hero.cy = 0
    END IF

 CASE 225                                 '  south west
    
    hero.cy = hero.cy + 1
    IF hero.cy >= hero.vy THEN
      hero.y = hero.y + speed
      hero.cy = 0
    END IF

    hero.thrust = -speed
    hero.dir = 1
 CASE 270                                    '  west
      hero.thrust = -speed
      hero.dir = 1
 CASE 315                                 '  north west
    'hero.y = hero.y - hero.vy
    hero.cy = hero.cy + 1
    IF hero.cy >= hero.vy THEN
      hero.y = hero.y - speed
      hero.cy = 0
    END IF

    hero.thrust = -speed
    hero.dir = 1
 END SELECT


 ' joystick buttons

 SELECT CASE (joybutt)

 CASE (1)
   createherolaser
 CASE (2)
   createherolaser
 END SELECT



 IF hero.y < topy THEN hero.y = topy
 IF hero.y > maxy - col(0).h - hero.h - 2 THEN hero.y = maxy - col(0).h - hero.h - 2
  

 IF hero.x < 0 THEN hero.x = minx
 IF hero.x > (maxx - hero.vx - hero.w) THEN hero.x = maxx - hero.w - 1





END SUB

SUB traitsmutant (a)
 
  ' mutant is aggresive and pissed off

  IF hero.thrust THEN mutant(a).x = mutant(a).x - hero.thrust

  'IF mutant(a).x > minx AND mutant(a).x < maxx THEN   ' mutant on screen
   
     'createalienbolt mutant(a).x, mutant(a).y

     mutant(a).cx = (mutant(a).cx + 1) MOD (mutant(0).vx + 1)
     IF mutant(0).vx = mutant(a).cx THEN
      IF mutant(a).px > hero.x THEN mutant(a).x = mutant(a).x - fnrnd(speed + 1)
      IF mutant(a).px < hero.x THEN mutant(a).x = mutant(a).x + fnrnd(speed + 1)
     END IF
    
     mutant(a).cy = (mutant(a).cy + 1) MOD (mutant(0).vy + 1)
     IF mutant(0).vy = mutant(a).cy THEN
      IF mutant(a).y > hero.y THEN mutant(a).y = mutant(a).y - fnrnd(speed + 1)
      IF mutant(a).y < hero.y THEN mutant(a).y = mutant(a).y + fnrnd(speed + 1)
     END IF


     IF fnrnd(2) THEN
       mutant(a).y = mutant(a).y + fnrnd(speed + 1)
      ELSE
       mutant(a).y = mutant(a).y - fnrnd(speed + 1)
     END IF

     IF fnrnd(2) THEN
       mutant(a).x = mutant(a).x + fnrnd(speed + 1)
      ELSE
       mutant(a).x = mutant(a).x - fnrnd(speed + 1)
     END IF

 
  IF mutant(a).x > fieldw THEN mutant(a).x = 0        ' bounds check
  IF mutant(a).x < 0 THEN mutant(a).x = fieldw

  IF mutant(a).y < topy THEN mutant(a).y = topy
  IF mutant(a).y > boty - mutant(a).h THEN mutant(a).y = boty - mutant(a).h



END SUB

SUB traitsspinette
 
  
  IF hero.thrust THEN spinette.x = spinette.x - hero.thrust

   IF spinette.dirx = 0 THEN
      spinette.cx = spinette.cx + 1
      IF spinette.cx > spinette.vx THEN
        spinette.x = spinette.x - speed
        spinette.cx = 0
      END IF
   END IF

   IF spinette.dirx = 1 THEN
      spinette.cx = spinette.cx + 1
      IF spinette.cx > spinette.vx THEN
        spinette.x = spinette.x + speed
        spinette.cx = 0
        
      END IF
   END IF

   IF spinette.diry = 0 THEN
      spinette.cy = spinette.cy + 1
      IF spinette.cy > spinette.vy THEN
        spinette.y = spinette.y - speed
        spinette.cy = 0
      END IF
   END IF

   IF spinette.diry = 1 THEN
      spinette.cy = spinette.cy + 1
      IF spinette.cy > spinette.vy THEN
        spinette.y = spinette.y + speed
        spinette.cy = 0
      END IF
   END IF

  

  IF spinette.x > maxx OR spinette.x < minx THEN spinette.health = 0

  IF spinette.x > fieldw THEN spinette.x = 0        ' bounds check
  IF spinette.x < 0 THEN spinette.x = fieldw

  IF spinette.y < topy + spinette.h + spinette.h THEN spinette.health = 0'spinette.y = boty - spinette.h
  IF spinette.y > boty - spinette.h THEN spinette.health = 0 'spinette.y = topy + spinette.h



END SUB

SUB traitsspinner (a)

  STATIC c1

  IF hero.thrust THEN spinner.x = spinner.x - hero.thrust

   IF (spinner.x > minx) AND (spinner.x < maxx) THEN    '  Shoot at hero.
      createspinette spinner.x, spinner.y
   END IF



   spinner.cy = spinner.cy + 1

   IF spinner.dir = 0 THEN
      IF spinner.cy >= spinner.vy THEN
        spinner.y = spinner.y + speed
        spinner.cy = 0
        c1 = (c1 + 1) MOD 20: IF c1 = 0 THEN spinner.dir = 1
      END IF
   ELSEIF spinner.dir = 1 THEN
      IF spinner.cy >= spinner.vy THEN
        spinner.y = spinner.y - speed
        spinner.cy = 0
        c1 = (c1 + 1) MOD 20: IF c1 = 0 THEN spinner.dir = 0
      END IF
   END IF

  IF spinner.x > fieldw THEN spinner.x = 0        ' bounds check
  IF spinner.x < 0 THEN spinner.x = fieldw

  IF spinner.y < topy + spinner.h THEN spinner.y = boty - spinner.h
  IF spinner.y > boty - spinner.h THEN spinner.y = topy + spinner.h


END SUB

SUB traitstracker (a)

   LOCATE 1, 1: PRINT tracker.x

   IF hero.thrust THEN tracker.x = tracker.x - hero.thrust

   IF (tracker.x > minx) AND (tracker.x < maxx) THEN    '  Shoot at hero.
       'createalienshot tracker.x, tracker.y
  
   END IF
  

   IF tracker.x > hero.x + (tracker.mem1) THEN

     'tracker.x = tracker.x + 1

   END IF


   IF tracker.x < hero.x - (tracker.mem1) THEN

     'tracker.x = tracker.x - 1

   END IF

 
 

  IF tracker.x > fieldw THEN tracker.x = 0             ' bounds check
  IF tracker.x < 0 THEN tracker.x = fieldw

  IF tracker.y < topy + tracker.h THEN tracker.y = boty - tracker.h
  IF tracker.y > boty - tracker.h THEN tracker.y = topy + tracker.h


END SUB

SUB WriteReg (reg, value)

' Writes to AdLib's registers the delays required when writing to these
' ports are present.
'
' Reg is the register to write to. Value is the data to send.


OUT &H388, reg     '  388h = Register/Status port
                   '  Tells the SB what register we want to write to

                   '  Calling the register port 6 times creates an
                   '  accurate delay of 3.3ms. This delay is required
FOR x = 0 TO 5     '  after writing to the register port.
   a = INP(&H388)
NEXT x

OUT &H389, value   '  389h = data port
                   '  send data that corrisponds with the requested register.

                   '  Calling the data port 35 times creates an
                   '  accurate delay of 23ms. This delay is required.
FOR x = 0 TO 34    '  after writing to the data port.
   a = INP(&H388)
NEXT x


END SUB

