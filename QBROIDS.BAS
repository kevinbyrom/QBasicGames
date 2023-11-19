'QB Ateroids  Ver 1.0
'Type       :Freeware
'Created    :12/22/95
'Revised    :05/03/96
'Author     :Tim Truman
'Graphics   :Tim Truman
'Copyright(c) 1995-1996 Nocturnal Creations
' This program may be distributed freely provided no changes
' are made to this program or any of it's support files.
' Functions and subroutines found in this source code may be used
' with permision from the author.
' The author makes no warrenties about the operation of this program,
' expressed or implied.
'
'Questions, comments or work related:
' AOL        - Tim Truman
' Compuserve - 74734,2203
' INTERNET   - TimTruman@aol.com


'-------------------* QB Asteroids
'
' Some how you got ploped right in the middle of an asteroid field.
' Maybe the boss didn't like you, or the ships navigation computer
' is running on a defective Pentium FPU. No time to think.
' Asteroids are hurling themselfs at your ship and to
' make matters worse pesky little ufos seem to have an interest in
' your destruction. Can you survive? Well, you've got the latest in
' shield technology and nuclear tipped dumb fire missles. Shear will
' and determination should get you through it. At least until you
' get the highscore.
'
' About 8 page down keys below are a bunch of program options. Here's
' a general description of how to use them :
'
'   delay!       - Unremark the one nearest your machine speed before
'                  starting. Adjust to suit.
'   reduceflick  - Turn flicker reduction off on slow machines.
'                  Use the simulated vector graphics if flicker persists.
'   gfxselect    - QB Asteroids has 3 graphic sets. Set the gfxselect
'                  varaible according to the graphic set you would like to
'                  play with.
'   starson      - Wouldn't use with the simulated vector graphics. Yuk.
'   walltype     - Images wrap or bounce! You decide.
'   gravitytype  - Select true space or simulated gravity.
'   music        - Remember that old Atari sound ?
'
'
' ------------------* Trouble Shooting
'It keeps making sound ! :
'  If Ctrl Break is used to exit the program and the ufo is on screen
'  it's sound effect will continue to play. Restart the program and exit the
'  game normally by using the Esc key.
'
'Shearing and flicker  :
'  I decided to use screen 13 for this program since it's conception.
'  Unfortunalty this video mode does not have mutilple pages. Unless the
'  delay! varaible is adjusted correctly for your machine you may experiance
'  severe image shearing. Raise the delay until the shearing is replaced by
'  a slight darkening in the images.
'
'Slow game speed:
'
' Here's the setting used on the slowest machine I had,
' A 386sx@16. These settings made the game playable.
'
' delay! = 0
' reduceflick = 0
' gfxselect = 1
' starson = 0
' MaxLargeRoids = 8
' MaxMediumRoids = 8
' MaxSmallRoids = 8
' Maxshots = 3
'
' Have Fun!

DEFINT A-Z

TYPE hues                    ' define the type for hues
  red AS INTEGER             ' red component
  grn AS INTEGER             ' green component
  blu AS INTEGER             ' blue component
END TYPE

TYPE sprite                  'type for sprites that require floating point
  x          AS SINGLE       'current x location
  y          AS SINGLE       'current y location
  lx         AS SINGLE       'last x location
  ly         AS SINGLE       'lasr y location
  vx         AS SINGLE       'x velocity
  vy         AS SINGLE       'y velocity
  w          AS INTEGER      'width of image
  h          AS INTEGER      'height of image
  health     AS INTEGER      'health of sprite
  remove     AS INTEGER      'used for erasing of sprite
  deg        AS SINGLE       'hold angle of ship
  tile       AS INTEGER      'current graphic tile
  ctr        AS INTEGER      'general counter
END TYPE

TYPE intsprite               'type for integer sprites
  x           AS INTEGER     'current x location
  y           AS INTEGER     'current y location
  lx          AS INTEGER     'last x location
  ly          AS INTEGER     'last y location
  vx          AS INTEGER     'x velocity
  vy          AS INTEGER     'y velocity
  w           AS INTEGER     'width of sprite
  h           AS INTEGER     'height of sprite
  health      AS INTEGER     'health of sprite
  remove      AS INTEGER     'used to erase sprite
  tile        AS INTEGER     'curent tile
  ctrx        AS INTEGER     'counter for x positioning (to avoid floats)
  ctry        AS INTEGER     'counter for y positioning (to avoid floats)
  vx2         AS INTEGER     'counter for x velecity (to avoid floats)
  vy2         AS INTEGER     'counter for y velecity (to avoid floats)
  ctr         AS INTEGER     'general counter
  mem         AS INTEGER     'memory storage
END TYPE

TYPE veltype                 'type for velocity data
  vx AS INTEGER
  vy AS INTEGER
END TYPE

TYPE adlibreg
  Attack  AS INTEGER
  Decay   AS INTEGER
  Sustain AS INTEGER
  Release AS INTEGER
  Freq    AS INTEGER
  octave  AS INTEGER
  Multi   AS INTEGER
  Atten   AS INTEGER
  WF      AS INTEGER
  Trem    AS INTEGER
  Vib     AS INTEGER
  FM      AS INTEGER
  FB      AS INTEGER
  Chan    AS INTEGER
END TYPE



DECLARE SUB adlibfx (fx)
DECLARE SUB DoCollisions ()
DECLARE SUB DoGameOver ()
DECLARE SUB DoNextLevel ()
DECLARE SUB DoRoids ()
DECLARE SUB DoShip ()
DECLARE SUB DoUfo ()
DECLARE SUB DoUfoShot ()
DECLARE SUB DoWeapon ()
DECLARE SUB DrawSprites ()
DECLARE SUB EndToDos ()
DECLARE SUB EraseSprites ()
DECLARE SUB InitLargeRoids (NumLargeRoids)
DECLARE SUB InitMediumRoids (i)
DECLARE SUB InitSmallRoids (i)
DECLARE SUB Initstart ()
DECLARE SUB P5x7font (x, y, text$, colour)
DECLARE SUB RestoreBackGround ()
DECLARE SUB TitleScreen ()
DECLARE SUB UpdateScore (points)
DECLARE SUB UpdateShield ()
DECLARE SUB WriteFM (reg, value)

DECLARE FUNCTION ReturnEvent ()
DECLARE FUNCTION TimeIsUp (n, tsecs!)

'globals
COMMON SHARED ClsAsm(), event, font(), gamescore&, music, musicdelay!, starson
COMMON SHARED gfxselect, walltype, gravitytype, gamestate, reduceflick
COMMON SHARED aship(), ship  AS sprite, elmperShip, shipwidth, shipheight
COMMON SHARED Friction!, Mcode()
COMMON SHARED weapon() AS intsprite, maxshots
COMMON SHARED veldata() AS veltype
COMMON SHARED largeroid() AS intsprite, large(), MaxLargeRoids, largewidth
COMMON SHARED largeheight, elmperlarge, NumLargeRoids, numasteroids
COMMON SHARED Mediumroid() AS intsprite, medium(), MaxMediumRoids, mediumwidth
COMMON SHARED mediumheight, elmpermedium
COMMON SHARED smallroid() AS intsprite, Small(), MaxSmallRoids, Smallwidth
COMMON SHARED Smallheight, elmperSmall
COMMON SHARED shield AS intsprite, shieldimg(), shieldwidth, shieldheight, elmpershield
COMMON SHARED ufo AS intsprite, ufoimg(), ufoshot AS intsprite
COMMON SHARED ufowidth, ufoheight, elmperufo
COMMON SHARED r() AS adlibreg
COMMON SHARED star() AS intsprite

'constants
CONST up = -72         'mapped key values
CONST Down = -80
CONST left = -75
CONST right = -77
CONST Eight = 56
CONST Two = 50
CONST Enter = 13
CONST esc = 27
CONST space = 32
CONST minus = 45
CONST equal = 61
CONST minx = 30        'screen
CONST maxx = 280
CONST miny = 30
CONST maxy = 170
CONST gameplay = 1     'for gamestate
CONST gameover = 2
CONST title = 0
CONST true = 1         'other
CONST false = 0
CONST thrust! = .08

'***************************************************************************
'***************************************************************************
'*************************    Game play variables    ***********************
'***************************************************************************
'***************************************************************************

' Set the initial program delay.
' Unrem the delay that best decribes your machine.
' Qbasic users unrem the "\10" part as well.

  Delay! = 2000   '/10   'Pentium90    'tested  - Author
  'Delay! = 1500  '/10   '486dx2@80    'tested  - Kenneth W. Melvin
  'Delay! = 600   '/10   '486dx2@50    'tested  - Author
  'Delay! = 0            '386sx@16     'tested  - Author

' If gameplay is severely slow even without a delay set reduceflick
' to 0. If sprites disapear(screen shear) set the delay higher.
' To use flicker reduction set reduceflick to 1. Because this imposes a
' delay of it's own, you will prabaly need to reduce the delay! variable.

'  0 = No flicker reduction
'  1 = Flicker reduction

  reduceflick = 1

' Set gfxselect to desired graphics.
' 0 = Atari                   ' The memories
' 1 = Simulated Vector        ' Good if flicker is a problem
' 2 = Detailed                ' Now were getting seroius!
  gfxselect = 2

' Set background stars
' 0 = off
' 1 = on

  starson = 1

' Set wall type
' 0 = wrap
' 1 = rubber              'Fun

  walltype = 1

' Set gravity type
' 0 = simulate gravity
' 1 = truespace

  gravitytype = 0

' set max asteroids on screen
' Large values will degrade performance

  MaxLargeRoids = 10
  MaxMediumRoids = 15
  MaxSmallRoids = 15

  NumLargeRoids = 10    'Number of large asteroids on first level + 1
                        'This number can not be set higher then MaxLargeRoids
                            

'Set ships max number of shots at once . Larger values will
'degrade performance exponentialy.

  maxshots = 3

'set music preferance
'0 = off
'1 = on

  music = 1
  

'*-----------------------------Begin game


RANDOMIZE TIMER
bitbucket = TimeIsUp(10, -1)          'set up timers


OUT &H60, &HF3                        'inform keyboard port
FOR D& = 1 TO 800: NEXT               'let hardware settle
OUT &H60, 0                           'send fast typematic rate

SCREEN 13

DIM SHARED r(1) AS adlibreg

REDIM pal(255) AS hues                 'array for palette
DEF SEG = VARSEG(pal(0))               'point to it
BLOAD "default.pal", 0                 'load it
OUT &H3C8, 0                           'inform VGA
FOR c = 0 TO 255                       'entire palette
 OUT &H3C9, pal(c).red                 'send red component
 OUT &H3C9, pal(c).grn                 'send green component
 OUT &H3C9, pal(c).blu                 'send blue component
NEXT                                   'next attribute

DIM font(127, 4, 6)                    'DIM array for fonts
DEF SEG = VARSEG(font(0, 0, 0))        'Point to it
BLOAD "5x7.fnt", 0                     'Load 'em in

'---------------------------------------* Load fighter ship

filename$ = "ship.spr"                 'set file name
filesize& = 5683                        'set file size
bytes = (filesize& - 7) \ 2 - 1         'BSAVE & BLOAD use 7 bytes
DIM aship(bytes)                        'dim the ship  array
DEF SEG = VARSEG(aship(0))              'point to it
BLOAD filename$, 0                      'load the ship file
shipwidth = aship(0) \ 8                'get ship width
shipheight = aship(1)                   'get ship height
elmperShip = ((shipwidth * shipheight) \ 2) + 3  ' elements in one ship image

'----------------------------------------* load large asteroids
filename$ = "large.spr"
filesize& = 19939
bytes = (filesize& - 7) \ 2 - 1
DIM large(bytes)
DEF SEG = VARSEG(large(0))
BLOAD filename$, 0
largewidth = large(0) \ 8
largeheight = large(1)
elmperlarge = ((largewidth * largeheight) \ 2) + 3
DIM largeroid(MaxLargeRoids)  AS intsprite
'------------------------------------------* load medium asteroids
filename$ = "medium.spr"
filesize& = 8939
bytes = (filesize& - 7) \ 2 - 1
DIM medium(bytes)
DEF SEG = VARSEG(medium(0))
BLOAD filename$, 0
mediumwidth = medium(0) \ 8
mediumheight = medium(1)
elmpermedium = ((mediumwidth * mediumheight) \ 2) + 3
DIM Mediumroid(MaxMediumRoids)  AS intsprite
'------------------------------------------* load small asteroids
filename$ = "small.spr"
filesize& = 5067
bytes = (filesize& - 7) \ 2 - 1
DIM Small(bytes)
DEF SEG = VARSEG(Small(0))
BLOAD filename$, 0
Smallwidth = Small(0) \ 8
Smallheight = Small(1)
elmperSmall = ((Smallwidth * Smallheight) \ 2) + 3
DIM smallroid(MaxSmallRoids)  AS intsprite
'------------------------------------------* load small asteroids
filename$ = "shield.spr"
filesize& = 3661
bytes = (filesize& - 7) \ 2 - 1
DIM shieldimg(bytes)
DEF SEG = VARSEG(shieldimg(0))
BLOAD filename$, 0
shieldwidth = shieldimg(0) \ 8
shieldheight = shieldimg(1)
elmpershield = ((shieldwidth * shieldheight) \ 2) + 3
'------------------------------------------* load ufos
filename$ = "ufo.spr"
filesize& = 6909
bytes = (filesize& - 7) \ 2 - 1
DIM ufoimg(bytes)
DEF SEG = VARSEG(ufoimg(0))
BLOAD filename$, 0
ufowidth = ufoimg(0) \ 8
ufoheight = ufoimg(1)
elmperufo = ((ufowidth * ufoheight) \ 2) + 3
ufo.tile = 0
ufo.w = 20
ufo.h = 20
ufoshot.w = 10
ufoshot.h = 10
'-------------------------------------------* intilaize weapons
DIM weapon(maxshots) AS intsprite
FOR i = 0 TO maxshots
  weapon(i).tile = 48
  weapon(i).w = 4
  weapon(i).h = 4
NEXT
DIM veldata(15) AS veltype                'velocity data for weapons
veldata(0).vx = 4:   veldata(0).vy = 0
veldata(1).vx = 3:   veldata(1).vy = 1
veldata(2).vx = 3:  veldata(2).vy = 2
veldata(3).vx = 2:  veldata(3).vy = 3
veldata(4).vx = 0:  veldata(4).vy = 4
veldata(5).vx = -2: veldata(5).vy = 3
veldata(6).vx = -3: veldata(6).vy = 2
veldata(7).vx = -3: veldata(7).vy = 1
veldata(8).vx = -4: veldata(8).vy = 0
veldata(9).vx = -3: veldata(9).vy = -1
veldata(10).vx = -3: veldata(10).vy = -2
veldata(11).vx = -2: veldata(11).vy = -3
veldata(12).vx = 0: veldata(12).vy = -4
veldata(13).vx = 2: veldata(13).vy = -3
veldata(14).vx = 3: veldata(14).vy = -2
veldata(15).vx = 3: veldata(15).vy = -1

IF starson THEN
 DIM star(30) AS intsprite
 FOR i = 0 TO 30
   star(i).x = (RND * maxx - minx) + minx
   star(i).y = (RND * maxy) + miny
 NEXT
END IF


InitSmallRoids (1)                'start intoduction with some small roids
musicdelay! = 1                   'set pause between notes for first level


DO                                           'game over loop
   
  DO                                         'main loop
    FOR x! = 0 TO Delay!: NEXT               'execute delay
    event = ReturnEvent                      'get user input
    IF event = esc THEN EndToDos             'user press escape key?
    DoCollisions                             'check for collisions
    IF gamestate = title THEN TitleScreen    'show title screen ?
    IF gamestate = gameover THEN DoGameOver  'inform palyer game is over ?
    IF gamestate = gameplay THEN             'play game ?
      DoShip                                 'handle ship movement
      DoWeapon                               'handle Weapon movement /creation
    END IF
    IF reduceflick THEN DO: LOOP UNTIL INP(&H3DA) AND 8   'reduce flicker
    EraseSprites                             'erase screen
    DrawSprites                              'redraw screen
    DoNextLevel                              'handle level changes
    DoRoids                                  'asteroid movement
    DoUfo                                    'ufo movement/creation
    DoUfoShot                                'ufo shot movement/creation
    
    
  LOOP UNTIL gamestate = gameover

  IF event = Enter THEN                      'reset gamestate
    gamestate = title: ship.health = 0: shield.health = 0: CLS
  END IF
LOOP


'If you enjoyed this game, check out QB Invaders and QB Defender!


SUB adlibfx (fx)

'produces sound effects through Adlib's FM registers and compatables

IF (adlib <> 4) AND (gamestate = gameover) THEN EXIT SUB

STATIC changenote    ' for sound effect 7

SELECT CASE fx

CASE 0     'ship shot

r(0).Trem = 0: r(1).Trem = 0
r(0).Vib = 0: r(1).Vib = 0
r(0).Multi = 0: r(1).Multi = 0
r(0).Attack = 8: r(1).Attack = 8
r(0).Decay = 1: r(1).Decay = 6
r(0).Sustain = 11: r(1).Sustain = 7
r(0).Release = 1: r(1).Release = 10
r(0).Atten = 0: r(1).Atten = 12
r(0).Freq = 234
r(0).octave = 0
r(0).FB = 7
r(0).FM = 0
r(0).WF = 0
r(1).WF = 0

' reset
WriteFM &HB0, &H0
' Modulator
CALL WriteFM(&H20, r(0).Trem * 128 + r(0).Vib * 64 + r(0).Multi)
CALL WriteFM(&H40, r(0).Atten)
CALL WriteFM(&H60, r(0).Attack * 16 + r(0).Decay)
CALL WriteFM(&H80, r(0).Sustain * 16 + r(0).Release)
CALL WriteFM(&HE0, r(0).WF)
' Carrier
CALL WriteFM(&H23, r(1).Trem * 128 + r(1).Vib * 64 + r(1).Multi)
CALL WriteFM(&H43, r(1).Atten)
CALL WriteFM(&H63, (r(1).Attack * 16) + r(1).Decay)
CALL WriteFM(&H83, (r(1).Sustain * 16) + r(1).Release)
CALL WriteFM(&HE3, r(1).WF)

keyon% = &H20
numberl = r(0).Freq AND &HFF                  'extract low 8 bits
numberh = (r(0).Freq AND &H300) / 255         'extract high 2 bits
byte% = keyon% + (r(0).octave * 4) + numberh  'calc byte%

CALL WriteFM(&HBD, &H3 * 64)                  'tremole /vibrato level
CALL WriteFM(&HC0, r(0).FB * 2 + r(0).FM)     'Feedback , Connection
CALL WriteFM(&HA0, numberl)                   'F-Number(L)
CALL WriteFM(&HB0, byte%)     ' Sound voice ,Set block ,Set F-Number(H)


CASE 1         'thrust

r(0).Trem = 0: r(1).Trem = 0
r(0).Vib = 0: r(1).Vib = 0
r(0).Multi = 0: r(1).Multi = 0
r(0).Attack = 7: r(1).Attack = 12
r(0).Decay = 6: r(1).Decay = 5
r(0).Sustain = 6: r(1).Sustain = 2
r(0).Release = 1: r(1).Release = 15
r(0).Atten = 0: r(1).Atten = 15
r(0).Freq = 450
r(0).octave = 1
r(0).FB = 7
r(0).FM = 0
r(0).WF = 0
r(1).WF = 0

' reset
WriteFM &HB1, &H0
' Modulator
CALL WriteFM(&H21, r(0).Trem * 128 + r(0).Vib * 64 + r(0).Multi)
CALL WriteFM(&H41, r(0).Atten)
CALL WriteFM(&H61, r(0).Attack * 16 + r(0).Decay)
CALL WriteFM(&H81, r(0).Sustain * 16 + r(0).Release)
CALL WriteFM(&HE1, r(0).WF)
' Carrier
CALL WriteFM(&H24, r(1).Trem * 128 + r(1).Vib * 64 + r(1).Multi)
CALL WriteFM(&H44, r(1).Atten)
CALL WriteFM(&H64, (r(1).Attack * 16) + r(1).Decay)
CALL WriteFM(&H84, (r(1).Sustain * 16) + r(1).Release)
CALL WriteFM(&HE4, r(1).WF)

keyon% = &H20
numberl = r(0).Freq AND &HFF                  'extract low 8 bits
numberh = (r(0).Freq AND &H300) / 255         'extract high 2 bits
byte% = keyon% + (r(0).octave * 4) + numberh  'calc byte%

CALL WriteFM(&HBD, &H3 * 64)                  'tremole /vibrato level
CALL WriteFM(&HC1, r(0).FB * 2 + r(0).FM)     'Feedback , Connection
CALL WriteFM(&HA1, numberl)                   'F-Number(L)
CALL WriteFM(&HB1, byte%)     ' Sound voice ,Set block ,Set F-Number(H)

CASE 2    'shot hit asteroid

r(0).Trem = 0: r(1).Trem = 0
r(0).Vib = 0: r(1).Vib = 0
r(0).Multi = 1: r(1).Multi = 1
r(0).Attack = 10: r(1).Attack = 12
r(0).Decay = 8: r(1).Decay = 5
r(0).Sustain = 10: r(1).Sustain = 2
r(0).Release = 14: r(1).Release = 15
r(0).Atten = 2: r(1).Atten = 0

r(0).Freq = 714
r(0).octave = 0
r(0).FB = 7
r(0).FM = 0
r(0).WF = 0
r(1).WF = 0


' reset
WriteFM &HB2, &H0
' Modulator
CALL WriteFM(&H22, r(0).Trem * 128 + r(0).Vib * 64 + r(0).Multi)
CALL WriteFM(&H42, r(0).Atten)
CALL WriteFM(&H62, r(0).Attack * 16 + r(0).Decay)
CALL WriteFM(&H82, r(0).Sustain * 16 + r(0).Release)
CALL WriteFM(&HE2, r(0).WF)
' Carrier
CALL WriteFM(&H25, r(1).Trem * 128 + r(1).Vib * 64 + r(1).Multi)
CALL WriteFM(&H45, r(1).Atten)
CALL WriteFM(&H65, (r(1).Attack * 16) + r(1).Decay)
CALL WriteFM(&H85, (r(1).Sustain * 16) + r(1).Release)
CALL WriteFM(&HE5, r(1).WF)

keyon% = &H20
numberl = r(0).Freq AND &HFF                  'extract low 8 bits
numberh = (r(0).Freq AND &H300) / 255         'extract high 2 bits
byte% = keyon% + (r(0).octave * 4) + numberh  'calc byte%

CALL WriteFM(&HBD, &H3 * 64)                  'tremole /vibrato level
CALL WriteFM(&HC2, r(0).FB * 2 + r(0).FM)     'Feedback , Connection
CALL WriteFM(&HA2, numberl)                   'F-Number(L)
CALL WriteFM(&HB2, byte%)     ' Sound voice ,Set block ,Set F-Number(H)

CASE 3        'bounce

r(0).Trem = 0: r(1).Trem = 0
r(0).Vib = 0: r(1).Vib = 0
r(0).Multi = 0: r(1).Multi = 0
r(0).Attack = 12: r(1).Attack = 9
r(0).Decay = 4: r(1).Decay = 8
r(0).Sustain = 2: r(1).Sustain = 4
r(0).Release = 11: r(1).Release = 6
r(0).Atten = 0: r(1).Atten = 0
r(0).Freq = 456
r(0).octave = 2
r(0).FB = 0
r(0).FM = 0
r(0).WF = 3
r(1).WF = 1

' reset
WriteFM &HB0, &H0
' Modulator
CALL WriteFM(&H20, r(0).Trem * 128 + r(0).Vib * 64 + r(0).Multi)
CALL WriteFM(&H40, r(0).Atten)
CALL WriteFM(&H60, r(0).Attack * 16 + r(0).Decay)
CALL WriteFM(&H80, r(0).Sustain * 16 + r(0).Release)
CALL WriteFM(&HE0, r(0).WF)
' Carrier
CALL WriteFM(&H23, r(1).Trem * 128 + r(1).Vib * 64 + r(1).Multi)
CALL WriteFM(&H43, r(1).Atten)
CALL WriteFM(&H63, (r(1).Attack * 16) + r(1).Decay)
CALL WriteFM(&H83, (r(1).Sustain * 16) + r(1).Release)
CALL WriteFM(&HE3, r(1).WF)

keyon% = &H20
numberl = r(0).Freq AND &HFF                  'extract low 8 bits
numberh = (r(0).Freq AND &H300) / 255         'extract high 2 bits
byte% = keyon% + (r(0).octave * 4) + numberh  'calc byte%

CALL WriteFM(&HBD, &H3 * 64)                  'tremole /vibrato level
CALL WriteFM(&HC0, r(0).FB * 2 + r(0).FM)     'Feedback , Connection
CALL WriteFM(&HA0, numberl)                   'F-Number(L)
CALL WriteFM(&HB0, byte%)     ' Sound voice ,Set block ,Set F-Number(H)

CASE 4   ' ufo appear

r(0).Trem = 1: r(1).Trem = 1
r(0).Vib = 0: r(1).Vib = 0
r(0).Multi = 4: r(1).Multi = 0
r(0).Attack = 7: r(1).Attack = 6
r(0).Decay = 0: r(1).Decay = 0
r(0).Sustain = 0: r(1).Sustain = 0
IF ufo.health THEN
 r(0).Release = 0: r(1).Release = 0
ELSE
 r(0).Release = 15: r(1).Release = 15
 r(0).Attack = 0: r(1).Attack = 0
END IF
r(0).Atten = 15: r(1).Atten = 15
r(0).Freq = 250
r(0).octave = 2
r(0).FB = 1
r(0).FM = 0
r(0).WF = 0
r(1).WF = 0

' reset
WriteFM &HB4, &H0
' Modulator
CALL WriteFM(&H29, r(0).Trem * 128 + r(0).Vib * 64 + r(0).Multi)
CALL WriteFM(&H49, r(0).Atten)
CALL WriteFM(&H69, r(0).Attack * 16 + r(0).Decay)
CALL WriteFM(&H89, r(0).Sustain * 16 + r(0).Release)
CALL WriteFM(&HE9, r(0).WF)
' Carrier
CALL WriteFM(&H2C, r(1).Trem * 128 + r(1).Vib * 64 + r(1).Multi)
CALL WriteFM(&H4C, r(1).Atten)
CALL WriteFM(&H6C, (r(1).Attack * 16) + r(1).Decay)
CALL WriteFM(&H8C, (r(1).Sustain * 16) + r(1).Release)
CALL WriteFM(&HEC, r(1).WF)

keyon% = &H20
numberl = r(0).Freq AND &HFF                  'extract low 8 bits
numberh = (r(0).Freq AND &H300) / 255         'extract high 2 bits
byte% = keyon% + (r(0).octave * 4) + numberh  'calc byte%

CALL WriteFM(&HBD, &H3 * 64)                  'tremole /vibrato level
CALL WriteFM(&HC4, r(0).FB * 2 + r(0).FM)     'Feedback , Connection
CALL WriteFM(&HA4, numberl)                   'F-Number(L)
CALL WriteFM(&HB4, byte%)     ' Sound voice ,Set block ,Set F-Number(H)

CASE 5   'ufo hit ship

r(0).Trem = 0: r(1).Trem = 0
r(0).Vib = 0: r(1).Vib = 0
r(0).Multi = 0: r(1).Multi = 0
r(0).Attack = 15: r(1).Attack = 12
r(0).Decay = 4: r(1).Decay = 6
r(0).Sustain = 5: r(1).Sustain = 10
r(0).Release = 11: r(1).Release = 15
r(0).Atten = 15: r(1).Atten = 0
r(0).Freq = 330
r(0).octave = 7
r(0).FB = 0
r(0).FM = 0
r(0).WF = 1
r(1).WF = 2

WriteFM &HB0, &H0
' Modulator
CALL WriteFM(&H20, r(0).Trem * 128 + r(0).Vib * 64 + r(0).Multi)
CALL WriteFM(&H40, r(0).Atten)
CALL WriteFM(&H60, r(0).Attack * 16 + r(0).Decay)
CALL WriteFM(&H80, r(0).Sustain * 16 + r(0).Release)
CALL WriteFM(&HE0, r(0).WF)
' Carrier
CALL WriteFM(&H23, r(1).Trem * 128 + r(1).Vib * 64 + r(1).Multi)
CALL WriteFM(&H43, r(1).Atten)
CALL WriteFM(&H63, (r(1).Attack * 16) + r(1).Decay)
CALL WriteFM(&H83, (r(1).Sustain * 16) + r(1).Release)
CALL WriteFM(&HE3, r(1).WF)

keyon% = &H20
numberl = r(0).Freq AND &HFF                  'extract low 8 bits
numberh = (r(0).Freq AND &H300) / 255         'extract high 2 bits
byte% = keyon% + (r(0).octave * 4) + numberh  'calc byte%

CALL WriteFM(&HBD, &H3 * 64)                  'tremole /vibrato level
CALL WriteFM(&HC0, r(0).FB * 2 + r(0).FM)     'Feedback , Connection
CALL WriteFM(&HA0, numberl)                   'F-Number(L)
CALL WriteFM(&HB0, byte%)     ' Sound voice ,Set block ,Set F-Number(H)

CASE 6  'ship hit ufo

r(0).Trem = 0: r(1).Trem = 0
r(0).Vib = 0: r(1).Vib = 0
r(0).Multi = 0: r(1).Multi = 0
r(0).Attack = 7: r(1).Attack = 3
r(0).Decay = 4: r(1).Decay = 15
r(0).Sustain = 6: r(1).Sustain = 1
r(0).Release = 15: r(1).Release = 15
r(0).Atten = 0: r(1).Atten = 0
r(0).Freq = 583
r(0).octave = 2
r(0).FB = 0
r(0).FM = 0
r(0).WF = 1
r(1).WF = 1

WriteFM &HB0, &H0
' Modulator
CALL WriteFM(&H20, r(0).Trem * 128 + r(0).Vib * 64 + r(0).Multi)
CALL WriteFM(&H40, r(0).Atten)
CALL WriteFM(&H60, r(0).Attack * 16 + r(0).Decay)
CALL WriteFM(&H80, r(0).Sustain * 16 + r(0).Release)
CALL WriteFM(&HE0, r(0).WF)
' Carrier
CALL WriteFM(&H23, r(1).Trem * 128 + r(1).Vib * 64 + r(1).Multi)
CALL WriteFM(&H43, r(1).Atten)
CALL WriteFM(&H63, (r(1).Attack * 16) + r(1).Decay)
CALL WriteFM(&H83, (r(1).Sustain * 16) + r(1).Release)
CALL WriteFM(&HE3, r(1).WF)

keyon% = &H20
numberl = r(0).Freq AND &HFF                  'extract low 8 bits
numberh = (r(0).Freq AND &H300) / 255         'extract high 2 bits
byte% = keyon% + (r(0).octave * 4) + numberh  'calc byte%

CALL WriteFM(&HBD, &H3 * 64)                  'tremole /vibrato level
CALL WriteFM(&HC0, r(0).FB * 2 + r(0).FM)     'Feedback , Connection
CALL WriteFM(&HA0, numberl)                   'F-Number(L)
CALL WriteFM(&HB0, byte%)     ' Sound voice ,Set block ,Set F-Number(H)


CASE 7  ' music

r(0).Trem = 0: r(1).Trem = 0
r(0).Vib = 0: r(1).Vib = 0
r(0).Multi = 0: r(1).Multi = 0
r(0).Attack = 10: r(1).Attack = 15
r(0).Decay = 3: r(1).Decay = 14
r(0).Sustain = 2: r(1).Sustain = 15
r(0).Release = 12: r(1).Release = 15
r(0).Atten = 0: r(1).Atten = 0
r(0).Freq = 0
r(0).octave = 0
r(0).WF = 2
r(1).WF = 0
r(0).FB = 4
r(0).FM = 1

IF changenote THEN
  r(0).octave = 6
  r(0).Freq = 13
  changenote = NOT changenote
ELSE
  r(0).Freq = 7
  r(0).octave = 7
  changenote = NOT changenote
END IF

' reset
WriteFM &HB3, &H0
' Modulator
CALL WriteFM(&H28, r(0).Trem * 128 + r(0).Vib * 64 + r(0).Multi)
CALL WriteFM(&H48, r(0).Atten)
CALL WriteFM(&H68, r(0).Attack * 16 + r(0).Decay)
CALL WriteFM(&H88, r(0).Sustain * 16 + r(0).Release)
CALL WriteFM(&HE8, r(0).WF)
' Carrier
CALL WriteFM(&H2B, r(1).Trem * 128 + r(1).Vib * 64 + r(1).Multi)
CALL WriteFM(&H4B, r(1).Atten)
CALL WriteFM(&H6B, (r(1).Attack * 16) + r(1).Decay)
CALL WriteFM(&H8B, (r(1).Sustain * 16) + r(1).Release)
CALL WriteFM(&HEB, r(1).WF)

keyon% = &H20
numberl = r(0).Freq AND &HFF                  'extract low 8 bits
numberh = (r(0).Freq AND &H300) / 255         'extract high 2 bits
byte% = keyon% + (r(0).octave * 4) + numberh  'calc byte%

CALL WriteFM(&HBD, &H3 * 64)                  'tremole /vibrato level
CALL WriteFM(&HC3, r(0).FB * 2 + r(0).FM)     'Feedback , Connection
CALL WriteFM(&HA3, numberl)                   'F-Number(L)
CALL WriteFM(&HB3, byte%)     ' Sound voice ,Set block ,Set F-Number(H)


END SELECT
END SUB

SUB DoCollisions

'checks for collision between objects


'----* large ateroids against weapons

FOR n = 0 TO maxshots
 IF weapon(n).health THEN
  FOR i = 0 TO MaxLargeRoids
   IF largeroid(i).health THEN
    IF (largeroid(i).x + 2 < weapon(n).x + weapon(n).w) AND (weapon(n).x < largeroid(i).x + largeroid(i).w - 2) THEN
     IF (largeroid(i).y + 2 < weapon(n).y + weapon(n).h) AND (weapon(n).y < largeroid(i).y + largeroid(i).h - 2) THEN
        largeroid(i).health = false
        PUT (largeroid(i).lx, largeroid(i).ly), large(20 * elmperlarge), PSET
        weapon(n).health = false
        PUT (weapon(n).lx, weapon(n).ly), aship(64 * elmperShip), PSET
        numasteroids = numasteroids - 1
        UpdateScore (20)
        adlibfx (2)
        InitMediumRoids (i)
     END IF
    END IF
   END IF
  NEXT
 END IF
NEXT

'----* Medium ateroids against weapons

FOR n = 0 TO maxshots
 IF weapon(n).health THEN
  FOR j = 0 TO MaxMediumRoids
   IF Mediumroid(j).health THEN
    IF (Mediumroid(j).x < weapon(n).x + weapon(n).w) AND (weapon(n).x < Mediumroid(j).x + Mediumroid(j).w) THEN
     IF (Mediumroid(j).y < weapon(n).y + weapon(n).h) AND (weapon(n).y < Mediumroid(j).y + Mediumroid(j).h) THEN
       numasteroids = numasteroids - 1
       PUT (Mediumroid(j).lx, Mediumroid(j).ly), medium(20 * elmpermedium), PSET
       Mediumroid(j).health = false
       PUT (weapon(n).lx, weapon(n).ly), aship(64 * elmperShip), PSET
       weapon(n).health = false
       UpdateScore (50)
       adlibfx (2)
       InitSmallRoids (j)
     END IF
    END IF
   END IF
  NEXT
 END IF
NEXT


'----* Small ateroids against weapons

FOR n = 0 TO maxshots
  IF weapon(n).health THEN
   FOR k = 0 TO MaxSmallRoids
     IF smallroid(k).health THEN
     IF (smallroid(k).x < weapon(n).x + weapon(n).w) AND (weapon(n).x + weapon(n).w < smallroid(k).x + smallroid(k).w) THEN
     IF (smallroid(k).y < weapon(n).y + weapon(n).h) AND (weapon(n).y + weapon(n).h < smallroid(k).y + smallroid(k).h) THEN

        numasteroids = numasteroids - 1
        PUT (smallroid(k).lx, smallroid(k).ly), Small(20 * elmperSmall), PSET
        smallroid(k).health = false
        PUT (weapon(n).lx, weapon(n).ly), aship(64 * elmperShip), PSET
        weapon(n).health = false
        adlibfx (2)
        UpdateScore (100)
       END IF
       END IF
       END IF
    NEXT

  END IF
NEXT


'large asteriods against ship

FOR i = 0 TO MaxLargeRoids
   IF largeroid(i).health THEN

     IF (largeroid(i).x + 4 < ship.x + ship.w - 2) AND (ship.x + 2 < largeroid(i).x + largeroid(i).w - 4) THEN
     IF (largeroid(i).y + 5 < ship.y + ship.h - 2) AND (ship.y + 2 < largeroid(i).y + largeroid(i).h - 4) THEN
        
          ship.vx = (-largeroid(i).vx)
          ship.vy = (-largeroid(i).vy)


          adlibfx (3)
        IF shield.health THEN
           IF TimeIsUp(7, .09) THEN
             shield.health = shield.health - 1
             UpdateShield
           END IF
        END IF
        
        END IF
       END IF
   END IF
 NEXT

'medium asteriods againt ship

FOR i = 0 TO MaxMediumRoids
   IF Mediumroid(i).health THEN

     IF (Mediumroid(i).x + 2 < ship.x + ship.w - 2) AND (ship.x + 2 < Mediumroid(i).x + Mediumroid(i).w - 2) THEN
     IF (Mediumroid(i).y + 2 < ship.y + ship.h - 2) AND (ship.y + 2 < Mediumroid(i).y + Mediumroid(i).h - 2) THEN

       
          ship.vx = -Mediumroid(i).vx
          ship.vy = -Mediumroid(i).vy

          adlibfx (3)

        IF shield.health THEN
           IF TimeIsUp(7, .09) THEN
             shield.health = shield.health - 1
             UpdateShield
           END IF
        END IF
        END IF
        END IF

   END IF
 NEXT



'small asteriods againt ship

FOR i = 0 TO MaxSmallRoids
   IF smallroid(i).health THEN
     IF (smallroid(i).x + 1 < ship.x + ship.w - 2) AND (ship.x + 2 < smallroid(i).x + smallroid(i).w - 1) THEN
     IF (smallroid(i).y + 1 < ship.y + ship.h - 2) AND (ship.y + 2 < smallroid(i).y + smallroid(i).h - 1) THEN


          ship.vx = smallroid(i).vx
          ship.vy = smallroid(i).vy


          adlibfx (3)
       
        IF shield.health THEN
           IF TimeIsUp(7, .09) THEN
             shield.health = shield.health - 1
             UpdateShield
           END IF
        END IF
        END IF
        END IF

   END IF
 NEXT

'ship againt ufoshot




IF ufoshot.health THEN
IF ship.health THEN
IF (ufoshot.x < ship.x + ship.w - 1) AND (ship.x + 1 < ufoshot.x + ufoshot.w) THEN
IF (ufoshot.y < ship.y + ship.h - 1) AND (ship.y + 1 < ufoshot.y + ufoshot.w) THEN


  
   IF shield.health THEN
      ufoshot.health = 0
      PUT (ufoshot.lx, ufoshot.ly), aship(64 * elmperShip), PSET
      shield.health = shield.health - 5
      UpdateShield
      adlibfx (5)
   END IF
   END IF
   END IF

END IF
END IF



'ship shot against ufo

IF ufo.health THEN
 FOR i = 1 TO maxshots
  IF weapon(i).health THEN
 IF (ufo.x + 1 < weapon(i).x + weapon(i).w) AND (weapon(i).x < ufo.x + ufo.w - 1) THEN
 IF (ufo.y + 6 < weapon(i).y + weapon(i).h) AND (weapon(i).y < ufo.y + ufo.h - 6) THEN

      ufo.health = 0
      ufo.mem = 0
      adlibfx (2)
      adlibfx (6)
      
      adlibfx (2)
      adlibfx (4)             'generate sound effect
      weapon(i).health = 0
      PUT (ufo.lx, ufo.ly), ufoimg(15 * elmperufo), PSET
      PUT (weapon(i).lx, weapon(i).ly), aship(64 * elmperShip), PSET
      UpdateScore (100)
  END IF
  END IF
END IF
NEXT
END IF



END SUB

SUB DoGameOver


P5x7font 130, 100, "Gameover", 14
P5x7font 90, 150, "Press enter to continue.", 250


END SUB

SUB DoNextLevel


IF numasteroids = 0 THEN                                  'no more roids
  NumLargeRoids = ((NumLargeRoids + 1) MOD MaxLargeRoids) 'add 1 to last
  InitLargeRoids (NumLargeRoids)                          'Set 'em up
  musicdelay! = musicdelay! - .05
  IF musicdelay! < .2 THEN musicdelay! = .2
  IF NumLargeRoids = 0 THEN musicdelay! = 1
END IF

IF music THEN
  IF TimeIsUp(5, musicdelay!) THEN adlibfx (7)
END IF

END SUB

SUB DoRoids

'handles asteriod movement

FOR i = 0 TO MaxLargeRoids                'from 1st large roid to last
  IF largeroid(i).health THEN             'is roid alive ?

  largeroid(i).lx = largeroid(i).x       'save old position for erase
  largeroid(i).ly = largeroid(i).y       'ditto
                                         'move asteroids based on velocitys
  largeroid(i).ctrx = (largeroid(i).ctrx + 1) MOD largeroid(i).vx2
  IF largeroid(i).ctrx = 0 THEN largeroid(i).x = largeroid(i).x - largeroid(i).vx
  largeroid(i).ctry = (largeroid(i).ctry + 1) MOD largeroid(i).vy2
  IF largeroid(i).ctry = 0 THEN largeroid(i).y = largeroid(i).y - largeroid(i).vy


  IF walltype THEN                           'rubber wall type ?
    IF largeroid(i).x > maxx THEN            'bounce roids off them
      largeroid(i).vx = -largeroid(i).vx
      largeroid(i).x = maxx
     END IF
    IF largeroid(i).y > maxy THEN
      largeroid(i).vy = -largeroid(i).vy
      largeroid(i).y = maxy
    END IF
    IF largeroid(i).x < minx THEN
      largeroid(i).vx = -largeroid(i).vx
      largeroid(i).x = minx
    END IF
    IF largeroid(i).y < miny THEN
      largeroid(i).vy = -largeroid(i).vy
      largeroid(i).y = miny
    END IF
  ELSE                                          'wrap wall type
    IF largeroid(i).x > maxx THEN largeroid(i).x = minx    'wrap 'em
    IF largeroid(i).x < minx THEN largeroid(i).x = maxx
    IF largeroid(i).y > maxy THEN largeroid(i).y = miny
    IF largeroid(i).y < miny THEN largeroid(i).y = maxy
  END IF

 END IF
NEXT


FOR i = 0 TO MaxMediumRoids                 'from 1st medium roid to last
 IF Mediumroid(i).health THEN

   Mediumroid(i).lx = Mediumroid(i).x
   Mediumroid(i).ly = Mediumroid(i).y

   Mediumroid(i).ctrx = (Mediumroid(i).ctrx + 1) MOD Mediumroid(i).vx2
   IF Mediumroid(i).ctrx = 0 THEN Mediumroid(i).x = Mediumroid(i).x - Mediumroid(i).vx
   Mediumroid(i).ctry = (Mediumroid(i).ctry + 1) MOD Mediumroid(i).vy2
   IF Mediumroid(i).ctry = 0 THEN Mediumroid(i).y = Mediumroid(i).y - Mediumroid(i).vy

   IF walltype THEN
    IF Mediumroid(i).x > maxx THEN
      Mediumroid(i).vx = -Mediumroid(i).vx
      Mediumroid(i).x = maxx
     END IF
    IF Mediumroid(i).y > maxy THEN
      Mediumroid(i).vy = -Mediumroid(i).vy
      Mediumroid(i).y = maxy
    END IF
    IF Mediumroid(i).x < minx THEN
      Mediumroid(i).vx = -Mediumroid(i).vx
      Mediumroid(i).x = minx
    END IF
    IF Mediumroid(i).y < miny THEN
      Mediumroid(i).vy = -Mediumroid(i).vy
      Mediumroid(i).y = miny
    END IF
  ELSE
    IF Mediumroid(i).x > maxx THEN Mediumroid(i).x = minx
    IF Mediumroid(i).x < minx THEN Mediumroid(i).x = maxx
    IF Mediumroid(i).y > maxy THEN Mediumroid(i).y = miny
    IF Mediumroid(i).y < miny THEN Mediumroid(i).y = maxy
  END IF
 END IF
NEXT

FOR i = 0 TO MaxSmallRoids             'from 1st small roid to last
  IF smallroid(i).health THEN

  smallroid(i).lx = smallroid(i).x
  smallroid(i).ly = smallroid(i).y

  smallroid(i).ctrx = (smallroid(i).ctrx + 1) MOD smallroid(i).vx2
  IF smallroid(i).ctrx = 0 THEN smallroid(i).x = smallroid(i).x + smallroid(i).vx
  smallroid(i).ctry = (smallroid(i).ctry + 1) MOD smallroid(i).vy2
  IF smallroid(i).ctry = 0 THEN smallroid(i).y = smallroid(i).y + smallroid(i).vy

  IF walltype THEN
    IF smallroid(i).x > maxx THEN
      smallroid(i).vx = -smallroid(i).vx
      smallroid(i).x = maxx
     END IF
    IF smallroid(i).y > maxy THEN
      smallroid(i).vy = -smallroid(i).vy
      smallroid(i).y = maxy
    END IF
    IF smallroid(i).x < minx THEN
      smallroid(i).vx = -smallroid(i).vx
      smallroid(i).x = minx
    END IF
    IF smallroid(i).y < miny THEN
      smallroid(i).vy = -smallroid(i).vy
      smallroid(i).y = miny
    END IF
  ELSE
    IF smallroid(i).x > maxx THEN smallroid(i).x = minx
    IF smallroid(i).x < minx THEN smallroid(i).x = maxx
    IF smallroid(i).y > maxy THEN smallroid(i).y = miny
    IF smallroid(i).y < miny THEN smallroid(i).y = maxy
  END IF
 END IF
NEXT




END SUB

SUB DoShip

STATIC CtrlH, AltH, CSpin, ASpin, ShiftH

DEF SEG = &H0                                  'point to low memory
kbyte1 = PEEK(&H417)                           'get keyboard byte status
kbyte2 = PEEK(&H418)                           'ditto


IF (kbyte1 AND &H4) THEN                       'ctrl key press
    IF (CtrlH = false) THEN                    'allow rotation
      ship.tile = ship.tile + 1                'rotate ship clockwise
      IF ship.tile > 15 THEN ship.tile = 0     'keep in bounds
      CtrlH = true                             'set ctrl hold
    ELSEIF (CtrlH = true) THEN                 'crtl key is being held
      IF TimeIsUp(0, .16) THEN CSpin = true    'time the rotation
      IF CSpin AND TimeIsUp(1, .04) THEN CtrlH = false  'reset the hold
    END IF
ELSE                                           'ctrl key released
     bitbucket = TimeIsUp(0, 1)                'reset timers
     bitbucket = TimeIsUp(1, 1)                'ditto
     CtrlH = false                             'reset varaible state
     CSpin = false                             'ditto
END IF

IF (kbyte1 AND &H8) THEN                       'alt key press
    IF (AltH = false) THEN                     'allow rotation
      ship.tile = ship.tile - 1                'rotate ship cclockwise
      IF ship.tile = -1 THEN ship.tile = 15    'keep in bounds
      AltH = true                              'set Alt hold
    ELSEIF (AltH = true) THEN                  'Alt key is being held
      IF TimeIsUp(2, .16) THEN ASpin = true    'time the rotation
      IF ASpin AND TimeIsUp(3, .04) THEN AltH = false  'reset the hold
    END IF
ELSE                                           'Alt key released
     bitbucket = TimeIsUp(2, 1)                'reset timers
     bitbucket = TimeIsUp(3, 1)                'ditto
     AltH = false                              'reset varable state
     ASpin = false                             'ditto
END IF

DEF SEG                                        'restore segment

ship.vx = ship.vx * Friction!                  'apply friction
ship.vy = ship.vy * Friction!                  'ditto

ship.deg = ship.tile * 22.5               'calc angle of ship based on tile

IF (kbyte1 AND &H1) THEN                     'right shift pressed
  rad! = ship.deg * .01745                   'calc angle of ship
  ship.vy = ship.vy + SIN(rad!) * thrust!    'calc ship velocity
  ship.vx = ship.vx + COS(rad!) * thrust!    'ditto
  'adlibfx (2)
END IF

ship.lx = ship.x: ship.ly = ship.y           'save ship location for erase

ship.x = ship.x + ship.vx                    'adjust ship location
ship.y = ship.y + ship.vy                    'ditto

IF walltype THEN                             'rubber walls ?
  IF ship.x > maxx THEN                      'then bounce ship off them
    ship.vx = -ship.vx
    ship.x = maxx
    adlibfx (3)
  END IF
  IF ship.y > maxy THEN
    ship.vy = -ship.vy
    ship.y = maxy
    adlibfx (3)
  END IF
  IF ship.x < minx THEN
    ship.vx = -ship.vx
    ship.x = minx
    adlibfx (3)
  END IF
  IF ship.y < miny THEN
    ship.vy = -ship.vy
    ship.y = miny
    adlibfx (3)
  END IF
ELSE                                         'wrap around walls ?
                                             'wrap ship
  IF ship.x > maxx THEN ship.x = minx
  IF ship.x < minx THEN ship.x = maxx
  IF ship.y > maxy THEN ship.y = miny
  IF ship.y < miny THEN ship.y = maxy

END IF

IF gravitytype THEN     'check gravity type setting
  Friction! = .998      'reset friction in case hit by asteroid
ELSE
  Friction! = .9821     'ditto
END IF





END SUB

SUB DoUfo

'handles ufo movement and creation

IF ufo.health = 0 AND ufo.mem THEN            'remember.. ufo.mem is timed
  
  ufo.x = (RND * 319)     'generate a location
  ufo.y = (RND * 199)     'ditto

  IF ufo.x >= 160 THEN ufo.x = maxx
  IF ufo.x < 160 THEN ufo.x = minx + ufo.w + 10
  IF ufo.y >= 100 THEN ufo.y = maxy
  IF ufo.y < 100 THEN ufo.y = miny + ufo.h + 10
 
  ufo.lx = ufo.x                          'save position for erase
  ufo.ly = ufo.y                          'ditto
  ufo.health = 1                          'set it's health
  adlibfx (4)

  IF INT(RND * 2) THEN                    'generate velocity
    ufo.vx = (RND * -2) - 1
  ELSE
    ufo.vx = (RND * 2) + 1
  END IF
  IF INT(RND * 2) THEN                    'ditto
    ufo.vy = (RND * -2) - 1
  ELSE
    ufo.vy = (RND * 2) + 1
  END IF

   ufo.vx2 = (RND * 1) + 4                'generate velocity counters
   ufo.vy2 = (RND * 3) + 4

  

ELSEIF ufo.health THEN                           'ufo alive
 
  ufo.lx = ufo.x: ufo.ly = ufo.y                 'save old position
  ufo.ctrx = (ufo.ctrx + 1) MOD ufo.vx2          'move ufo
  IF ufo.ctrx = 0 THEN ufo.x = ufo.x - ufo.vx
  ufo.ctry = (ufo.ctry + 1) MOD ufo.vy2
  IF ufo.ctry = 0 THEN ufo.y = ufo.y - ufo.vy

  IF walltype THEN                              'rubber walls ?
    IF ufo.x > maxx THEN                        'bounce ufo off 'em
      ufo.vx = -ufo.vx
      ufo.x = maxx
     END IF
    IF ufo.y > maxy THEN
      ufo.vy = -ufo.vy
      ufo.y = maxy
    END IF
    IF ufo.x < minx THEN
      ufo.vx = -ufo.vx
      ufo.x = minx
    END IF
    IF ufo.y < miny THEN
      ufo.vy = -ufo.vy
      ufo.y = miny
    END IF
  ELSE                                           'wrap walls ?
    IF ufo.x > maxx THEN ufo.x = minx            'wrap ufo
    IF ufo.x < minx THEN ufo.x = maxx
    IF ufo.y > maxy THEN ufo.y = miny
    IF ufo.y < miny THEN ufo.y = maxy
  END IF

 END IF

IF ufo.mem = false THEN
   IF TimeIsUp(8, 10) THEN ufo.mem = true       'allow new ufo
END IF

END SUB

SUB DoUfoShot


IF ufo.health AND ufoshot.health = 0 THEN    'allow ufo to shoot ?
  IF TimeIsUp(10, .5) THEN                   'ditto
    ufoshot.health = true                    'set it up
    ufoshot.x = ufo.x                        'ditto
    ufoshot.y = ufo.y                        'ditto
    ufoshot.lx = ufoshot.x                   'ditto
    ufoshot.ly = ufoshot.y                   'ditto
    c = (RND * 4)                            'generate velocity selection
   SELECT CASE c                             'set velocity
   CASE 0
    ufoshot.vx = 0
    ufoshot.vy = -3
   CASE 1
    ufoshot.vx = 0
    ufoshot.vy = 3
   CASE 2
    ufoshot.vx = 3
    ufoshot.vy = 0
   CASE 3
    ufoshot.vx = -3
    ufoshot.vy = 0
  END SELECT

  ufoshot.ctr = 0                           'set distance counter
  ufoshot.tile = (ship.tile + 48)           'set tile
 END IF

ELSEIF ufoshot.health = true THEN           'shot set up ?
                                            
   ufoshot.lx = ufoshot.x                   'save old position for erase
   ufoshot.ly = ufoshot.y                   'ditto

   ufoshot.x = ufoshot.x + ufoshot.vx       'move shot
   ufoshot.y = ufoshot.y + ufoshot.vy       'ditto

  IF walltype THEN                          'rubber wall ?
    IF ufoshot.x > maxx THEN                'bounce shot
      ufoshot.vx = -ufoshot.vx
      'ufoshot.x = maxx
     END IF
    IF ufoshot.y > maxy THEN
       ufoshot.vy = -ufoshot.vy
       'ufoshot.y = maxy
    END IF
    IF ufoshot.x < minx THEN
      ufoshot.vx = -ufoshot.vx
      'ufoshot.x = minx
    END IF
    IF ufoshot.y < miny THEN
      ufoshot.vy = -ufoshot.vy
      'ufoshot.y = miny
    END IF
  ELSE                                        'wrap wall
   IF ufoshot.x > maxx THEN ufoshot.x = minx  'wrap shot
   IF ufoshot.x < minx THEN ufoshot.x = maxx
   IF ufoshot.y > maxy THEN ufoshot.y = miny
   IF ufoshot.y < miny THEN ufoshot.y = maxy
  END IF

   ufoshot.ctr = ufoshot.ctr + 1               'count travel distance
   IF ufoshot.ctr = 60 THEN                    'reached max travel
     ufoshot.health = false                    'kill shot
    PUT (ufoshot.lx, ufoshot.ly), aship(64 * elmperShip), PSET  'erase it
   END IF

 END IF


END SUB

SUB DoWeapon

'generate and move ship weapon


IF event = space THEN                       'player wants to fire ?
 FOR i = 0 TO maxshots                      'first shot to last
  IF weapon(i).health = false THEN          'Is this shot dead ?
    weapon(i).health = true                 'generate a new one
    weapon(i).x = ship.x                    'make location equal ship
    weapon(i).y = ship.y                    'ditto
    weapon(i).lx = weapon(i).x              'save location
    weapon(i).ly = weapon(i).y              'ditto
    weapon(i).vx = veldata(ship.tile).vx    'get velocity based on ship tile
    weapon(i).vy = veldata(ship.tile).vy    'ditto
    weapon(i).ctr = 0                       'reset distance counter
    weapon(i).tile = (ship.tile + 48)       'set tile
    adlibfx (0)                             'sound shot effect
    EXIT FOR                                'all done
  END IF
 NEXT
END IF


FOR i = 0 TO maxshots                         'first to last shot
 IF weapon(i).health THEN                     'Is this shot alive ?

   weapon(i).lx = weapon(i).x                 'save old location
   weapon(i).ly = weapon(i).y                 'ditto

   weapon(i).x = weapon(i).x + weapon(i).vx    'move shot
   weapon(i).y = weapon(i).y + weapon(i).vy    'ditto

  IF walltype THEN                             'rubber walls ?
    IF weapon(i).x > maxx THEN                 'bounce shot off 'em
      weapon(i).vx = -weapon(i).vx
      weapon(i).x = maxx
     END IF
    IF weapon(i).y > maxy THEN
       weapon(i).vy = -weapon(i).vy
       weapon(i).y = maxy
    END IF
    IF weapon(i).x < minx THEN
      weapon(i).vx = -weapon(i).vx
      weapon(i).x = minx
    END IF
    IF weapon(i).y < miny THEN
      weapon(i).vy = -weapon(i).vy
      weapon(i).y = miny
    END IF
  ELSE                                             'wrap walls
   IF weapon(i).x > maxx THEN weapon(i).x = minx   'wrap shot
   IF weapon(i).x < minx THEN weapon(i).x = maxx
   IF weapon(i).y > maxy THEN weapon(i).y = miny
   IF weapon(i).y < miny THEN weapon(i).y = maxy
  END IF

   weapon(i).ctr = weapon(i).ctr + 1               'count travel distance
   IF weapon(i).ctr = 20 THEN                      'reached max travel ?
     weapon(i).health = false                      'kill shot
     PUT (weapon(i).lx, weapon(i).ly), aship(64 * elmperShip), PSET 'erase it
   END IF

  END IF
NEXT


END SUB

SUB DrawSprites


IF starson THEN
  FOR i = 0 TO 30
    PSET (star(i).x, star(i).y), 7
  NEXT
END IF

IF ship.health THEN
  PUT (ship.x, ship.y), aship((ship.tile + (gfxselect * 16)) * elmperShip), XOR
END IF

IF shield.health > 2 THEN
  shield.ctr = (shield.ctr + 1) MOD 2
  IF shield.ctr = 0 THEN shield.tile = (shield.tile + 1) MOD 5
  IF shield.health < 15 THEN shield.tile = 0
  PUT (ship.x - 6, ship.y - 6), shieldimg((shield.tile + 0) * elmpershield), OR
END IF


FOR i = 0 TO maxshots
 IF weapon(i).health THEN
   PUT (weapon(i).x, weapon(i).y), aship(weapon(i).tile * elmperShip), OR
 END IF
NEXT

FOR i = 0 TO MaxLargeRoids
 IF largeroid(i).health THEN
 
   PUT (largeroid(i).x, largeroid(i).y), large(largeroid(i).tile * elmperlarge), OR
 END IF
NEXT

FOR i = 0 TO MaxMediumRoids
 IF Mediumroid(i).health THEN
   PUT (Mediumroid(i).x, Mediumroid(i).y), medium(Mediumroid(i).tile * elmpermedium), OR
 END IF
NEXT

FOR i = 0 TO MaxSmallRoids
 IF smallroid(i).health THEN
   PUT (smallroid(i).x, smallroid(i).y), Small(smallroid(i).tile * elmperSmall), OR
 END IF
NEXT


IF ufo.health THEN
  ufo.ctr = (ufo.ctr + 1) MOD 3
  IF ufo.ctr = 0 THEN ufo.tile = (ufo.tile + 1) MOD 5
  PUT (ufo.x, ufo.y), ufoimg((ufo.tile + (gfxselect * 5)) * elmperufo), OR
END IF

IF ufoshot.health THEN
  LINE (ufoshot.x + 5, ufoshot.y + 5)-(ufoshot.x + 6, ufoshot.y + 6), 14, BF
END IF



END SUB

SUB EndToDos

DIM buffer(1000)               'array to hold background

x1 = 130                       'set window location
x2 = 190                       'ditto
y1 = 90                        'ditto
y2 = 102                       'ditto

GET (x1, y1)-(x2, y2), buffer        'save background

LINE (x1, y1)-(x2, y2), 120, BF      'draw window
LINE (x1, y1)-(x2, y2), 123, B       'ditto
P5x7font x1 + 3, y1 + 3, "Quit? (y/n)", 1   'request player response

DO                                      'input loop
 event = ReturnEvent                    'get user input

 SELECT CASE event                      'process input
 CASE 89, 121                           'Y or y
   EXIT DO                              'drop out of loop
 CASE 78, 110                           'N or n
   PUT (x1, y1), buffer, PSET           'restore background
   EXIT SUB                             'return to game
 END SELECT
LOOP


WIDTH 80                                'reset screen
SCREEN 0, 0, 0                          'ditto

ufo.health = 0                          'kill sprite to
adlibfx (4)                             'kill sound


END                                     'program end

END SUB

SUB EraseSprites

'erase images


IF shield.health THEN
  'PUT (ship.lx, ship.ly), aship((ship.tile + 64) * elmperShip), PSET
  PUT (ship.lx - 5, ship.ly - 5), shieldimg(7 * elmpershield), PSET
END IF


FOR i = 0 TO maxshots
IF weapon(i).health THEN
 PUT (weapon(i).lx, weapon(i).ly), aship(64 * elmperShip), PSET
END IF
NEXT

FOR i = 0 TO MaxLargeRoids
 IF largeroid(i).health THEN
  PUT (largeroid(i).lx, largeroid(i).ly), large(20 * elmperlarge), PSET
 END IF
NEXT

FOR i = 0 TO MaxMediumRoids
 IF Mediumroid(i).health THEN
  PUT (Mediumroid(i).lx, Mediumroid(i).ly), medium(20 * elmpermedium), PSET
 END IF
NEXT

FOR i = 0 TO MaxSmallRoids
 IF smallroid(i).health THEN
  PUT (smallroid(i).lx, smallroid(i).ly), Small(20 * elmperSmall), PSET
 END IF
NEXT


IF ufo.health THEN
  PUT (ufo.lx, ufo.ly), ufoimg(15 * elmperufo), PSET
END IF

IF ufoshot.health THEN
  LINE (ufoshot.lx + 5, ufoshot.ly + 5)-(ufoshot.lx + 6, ufoshot.ly + 6), 0, BF
END IF


END SUB

SUB InitLargeRoids (NumLargeRoids)

'generates large asteroids according to NumLargeRoids

FOR i = 0 TO NumLargeRoids                       'first to last

  DO                                             'x generation loop
    largeroid(i).x = (RND * 270) + 1             'generate x location
    IF largeroid(i).x > ship.x + 40 OR largeroid(i).x < ship.x - 40 THEN
      EXIT DO                                    'done
    END IF
  LOOP

  DO                                              'y generation loop
   largeroid(i).y = (RND * 120) + 21              'generate y location
   IF largeroid(i).y > ship.y + 40 OR largeroid(i).y < ship.y - 40 THEN
     EXIT DO                                   'done
   END IF
  LOOP

 largeroid(i).w = 30                            'set width
 largeroid(i).h = 30                            'set height
 largeroid(i).lx = 100                          'save old location
 largeroid(i).ly = 100                          'ditto
 
 IF INT(RND * 2) THEN                           'generate velocity
   largeroid(i).vx = (RND * -2) - 1
 ELSE
   largeroid(i).vx = (RND * 2) + 1
 END IF
 IF INT(RND * 2) THEN                           'ditto
   largeroid(i).vy = (RND * -2) - 1
 ELSE
   largeroid(i).vy = (RND * 2) + 1
 END IF

 largeroid(i).vx2 = (RND * 1) + 3               'generate velocity counter
 largeroid(i).vy2 = (RND * 3) + 3               'ditto
 largeroid(i).health = 1                        'set health
 largeroid(i).tile = (RND * 4) + (gfxselect * 5)   'generate tile
 numasteroids = numasteroids + 1                'keep count of asteroids

NEXT


END SUB

SUB InitMediumRoids (i)

'generate medium asteroids based on large asteroid location

FOR n = 0 TO MaxMediumRoids                    'first to last
 IF Mediumroid(n).health = 0 THEN              'roid dead ?

   ctr = ctr + 1                                'count number generated

   Mediumroid(n).x = largeroid(i).x + 5        'set locaton
   Mediumroid(n).y = largeroid(i).y + 5        'ditto
   Mediumroid(n).lx = Mediumroid(n).x          'save location
   Mediumroid(n).ly = Mediumroid(n).y          'ditto

   Mediumroid(n).tile = (RND * 4) + (gfxselect * 5)   'generate tile

   IF INT(RND * 2) THEN                        'generate velocity
     Mediumroid(n).vx = (RND * -2) - 1
   ELSE
     Mediumroid(n).vx = (RND * 2) + 1
   END IF
   IF INT(RND * 2) THEN                        'ditto
     Mediumroid(n).vy = (RND * -2) - 1
   ELSE
     Mediumroid(n).vy = (RND * 2) + 1
   END IF

   
   Mediumroid(n).vx2 = (RND * 2) + 3          'generate velocity counter
   Mediumroid(n).vy2 = (RND * 2) + 3          'ditto

   Mediumroid(n).w = 15                       'set width
   Mediumroid(n).h = 15                       'set height
   Mediumroid(n).health = true                'set health
   numasteroids = numasteroids + 1            'keep track of asteroids
  END IF
 
 IF ctr = 2 THEN EXIT FOR                     'done
 
NEXT

END SUB

SUB InitSmallRoids (i)

'generate small atseroids based on medium asteroid location

FOR n = 0 TO MaxSmallRoids                    'first to last
 IF smallroid(n).health = 0 THEN              'roid dead ?

   ctr = ctr + 1                              'count number generated

   smallroid(n).x = Mediumroid(i).x + 5       'set location
   smallroid(n).y = Mediumroid(i).y + 5       'set location

   smallroid(n).lx = smallroid(n).x           'save old position
   smallroid(n).ly = smallroid(n).y           'ditto

   smallroid(n).tile = (RND * 4) + (gfxselect * 5) 'generate tile

   IF INT(RND * 2) THEN                       'generate velocity
     smallroid(n).vx = (RND * -2) - 1
   ELSE
     smallroid(n).vx = (RND * 3) + 1
   END IF
   IF INT(RND * 2) THEN                       'ditto
     smallroid(n).vy = (RND * -3) - 1
   ELSE
     smallroid(n).vy = (RND * 3) + 1
   END IF
  
   smallroid(n).vx2 = (RND * 2) + 3    'generate counter velocity
   smallroid(n).vy2 = (RND * 2) + 3    'ditto

   smallroid(n).w = 10                 'set width
   smallroid(n).h = 10                 'set height

   smallroid(n).health = true          'set health
   numasteroids = numasteroids + 1     'keep track of asteroids

  END IF
  
  IF ctr = 2 THEN EXIT FOR             'done

NEXT




END SUB

SUB Initstart

'get game ready to play

CLS

                                   'initialize ship
ship.x = 160                       'set ship location
ship.y = 100                       'ditto
ship.lx = ship.x + 1               'set old location
ship.ly = ship.y                   'ditto
ship.w = 10                        'set width
ship.h = 10                        'set height
ship.vx = 0                        'set velocity
ship.vy = 0                        'ditto
ship.health = 1                    'set health /actual health based on shield
ship.tile = 0                      'set start tile

                                   'reset timers
FOR i = 0 TO 10                    'first to last
 a = TimeIsUp(i, 0)                'reset 'em
NEXT


                                   'reset sprites
FOR i = 0 TO MaxLargeRoids         'kill large
  largeroid(i).health = 0
NEXT
FOR i = 0 TO MaxMediumRoids        'kill medium
  Mediumroid(i).health = 0
NEXT
FOR i = 0 TO MaxSmallRoids         'kill small
  smallroid(i).health = 0
NEXT
ufoshot.health = 0                 'kill ufo shot
ufo.health = 0                     'kill ufo
ufo.mem = false                    'reset ufo mem

                                   
gamescore& = 0                     'reset score
UpdateScore (0)                    'display it

                                   'reset ship shield
P5x7font 50, 0, "Shield", 54       'draw title
LINE (79, 0)-(179, 8), 54, B       'draw box
shield.health = 50                 'set shield health
UpdateShield                       'draw it

                                   'initilize  asteroids
numasteroids = 0                   'reset number of asteroids
InitLargeRoids (NumLargeRoids)     'generate 1 asteroid

adlibfx (4)

musicdelay! = 1       'set pause between notes for first level
END SUB

SUB P5x7font (x, y, text$, colour)

length = LEN(text$)                    'get characters to print
IF length = 0 THEN EXIT SUB            'check length

FOR char = 0 TO length - 1             'print loop

   piece$ = MID$(text$, char + 1, 1)   'look at each piece of string
   aski = ASC(piece$)                  'assign it's ASCII value

  SELECT CASE (piece$)                 'adjust lower case
   CASE "g": kerny = kerny + 2         'ditto
   CASE "j": kerny = kerny + 2         'ditto
   CASE "p": kerny = kerny + 2         'ditto
   CASE "q": kerny = kerny + 2         'ditto
   CASE "y": kerny = kerny + 2         'ditto
  END SELECT

  FOR ybit = 0 TO 6                               'top to Bottom
   FOR xbit = 0 TO 4                              'left to right
     IF font(aski, xbit, ybit) = 1 THEN           'set bits only
       PSET (x + xbit + kernx, y + ybit + kerny), colour   'PSET data
     END IF
   NEXT
  NEXT

  SELECT CASE (piece$)                'kern adjusment
   CASE "i": kernx = kernx + 2        'ditto
   CASE "j": kernx = kernx + 5        'ditto
   CASE "l": kernx = kernx + 2        'ditto
   CASE "r": kernx = kernx + 5        'ditto
   CASE ".": kernx = kernx + 3        'ditto
   CASE "(": kernx = kernx + 3        'ditto
   CASE ")": kernx = kernx + 3        'ditto
   CASE "'": kernx = kernx + 2        'ditto
   CASE "!": kernx = kernx + 2        'ditto
   CASE ELSE: kernx = kernx + 6       'ditto
  END SELECT

  kerny = 0                           'reset

NEXT


END SUB

FUNCTION ReturnEvent

kee$ = INKEY$                             'get key form keyboard buffer
IF kee$ <> "" THEN                        'got a key ?
  IF LEN(kee$) = 1 THEN                   'a regular key ?
   keycode = ASC(kee$)                    'convert it
  ELSE                                    'extended
   keycode = -ASC(RIGHT$(kee$, 1))        'convert it
  END IF
END IF


ReturnEvent = keycode                                  'return keycode

END FUNCTION

FUNCTION TimeIsUp (n, tsecs!)
' This function is polled to check for passage of time. When the amount of
' time in tsecs has passed timeisup() returns TRUE, otherwise the function
' returns false.
' Initialize this routine with tsecs! = -1 and n = to the number
' of timers to set up.

STATIC getclock(), oldtsecs!(), Time1!()

IF tsecs! = -1 THEN                    ' initialize timers
  DIM getclock(n)
  DIM oldtsecs!(n)
  DIM Time1!(n)
END IF


IF tsecs! <> oldtsecs!(n) THEN getclock(n) = 0

IF getclock(n) = 0 THEN
   Time1!(n) = TIMER
   getclock(n) = 1
   oldtsecs!(n) = tsecs!
ELSE
   IF ABS(TIMER - Time1!(n)) >= tsecs! THEN
      TimeIsUp = 1
      getclock(n) = 0
   ELSE
      TimeIsUp = 0
   END IF
END IF


END FUNCTION

SUB TitleScreen

P5x7font 120, 50, "QB Asteriods", 52
P5x7font 95, 70, "Alt and Ctrl - Spin ship ", 85
P5x7font 103, 80, "Right Shift - Thrust", 197
P5x7font 112, 90, "Space Bar - Fire", 85
P5x7font 130, 110, "Esc - Quit", 250

P5x7font 90, 160, "Press space bar to start", 202

IF event = space THEN
 gamestate = gameplay
 Initstart
END IF

END SUB

SUB UpdateScore (points)

gamescore& = gamescore& + points
score$ = STR$(gamescore&)
LINE (190, 0)-(236, 10), 0, BF
P5x7font 190, 0, score$, 7

END SUB

SUB UpdateShield


LINE (80, 1)-(178, 7), 0, BF                      'erase old bar

IF shield.health > 49 THEN shield.health = 49     'keep in bounds
  shieldlen = (shield.health * 2)                 'calc grapical length
  IF shieldlen >= 0 AND shieldlen <= 25 THEN colour = 51    'shield low
  IF shieldlen >= 26 AND shieldlen <= 49 THEN colour = 53   'shield med
  IF shieldlen >= 50 THEN colour = 59                       'shield high
  IF shieldlen THEN                                       'got shield ?
   LINE (80, 1)-(80 + shieldlen, 7), colour, BF           'display meter
  ELSE                                                    'no shield
   PUT (ship.lx - 5, ship.ly - 5), shieldimg(1 * elmpershield), PSET
  END IF


IF shield.health <= 0 THEN gamestate = gameover         'set game state

END SUB

SUB WriteFM (reg, value)

' Writes to FM chip registers. The delays required when writing to these
' ports are present.
'
' Reg is the register to write to. Value is the data to send.


OUT &H388, reg     '  388h = Register/Status port
                   '  Tells the FM chip what register we want to write to

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

