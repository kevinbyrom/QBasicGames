DEFINT A-Z
DECLARE SUB DrawTexture (texture, position, x, y)
DECLARE SUB StatusBar ()
DECLARE SUB SetPalette (index, red, green, blue)
DECLARE SUB DrawObject (object, ox, oy)
DECLARE SUB ViewField (cellrow, cellcol)
DECLARE SUB Intro ()
DECLARE SUB Menu ()
DECLARE SUB PlayerWalk (px, py, PlayerState)
DECLARE SUB GameLoop ()
DECLARE SUB TimeDelay (clicks!)
DECLARE SUB SaveGame ()
DECLARE SUB GetPalette (index, red, green, blue)
DECLARE SUB LoadGame ()
DECLARE SUB PlayerDie (x, y)
DECLARE SUB Instructions ()
DECLARE SUB UpdateLives ()
DECLARE SUB NextLevel ()
DECLARE SUB LoadLevel (Level)
DECLARE SUB DrawDeadSoldier (x, y, EnemyType)
DECLARE SUB HowToOrder ()
DECLARE SUB OutText (x, y, textcolor, text$)
DECLARE SUB SightGun (gunx, guny)
DECLARE SUB UpdateHealth ()
DECLARE SUB DrawEnemy (x, y, EnemyType)
DECLARE SUB SetDefaults ()
DECLARE SUB DrawGun (x, y, weapon, PlayerState)
DECLARE SUB HowToOrder ()
DECLARE SUB UpdateAmmo ()
DECLARE SUB FireWeapon (x, y, weapon)
DECLARE SUB DrawChar (x, y, PlayerState, arms, legs)
DECLARE SUB UpdatePoints ()
DECLARE SUB DrawDoor (texture, position, x, y)
DECLARE SUB UpdateWeapon ()
'$DYNAMIC

CONST TRUE = -1
CONST FALSE = 0

CONST MIDPOS = 1
CONST LEFTPOS = 2
CONST RIGHTPOS = 3
CONST LOWERPOS = 4

CONST BRICK = 1
CONST STONE = 2

CONST SOUTH = 1
CONST NORTH = 2
CONST EAST = 3
CONST WEST = 4

CONST STAND = 1
CONST WALK1 = 2
CONST WALK2 = 3
CONST WALK3 = 4

CONST ARMSDOWN = 1
CONST GUNDRAWN = 2

CONST PISTOL = 1
CONST SHOTGUN = 2
CONST FLAMER = 3

CONST EXTRALIFE = 1
CONST HEALTHBONUS = 2
CONST NEWWEAPON = 3
CONST AMMOCLIP = 4
CONST MONEYBAG = 5
CONST DEADSOLDIER = 6

CONST GUARD = 1
CONST OFFICER = 2
CONST BADASS = 3
CONST BADDOG = 4

CONST SPEEDCONST! = .02

CONST FLOORCONST = 18

DIM SHARED map$(100), Buffer%(10000), Sight%(100), getcode$, EBuffer%(10000), EGun%(100)
DIM SHARED cellpx, cellpy, cellx, celly, px, py, gunx, guny, ex, ey, PlayerState, GunRaise

DIM SHARED Health, Ammo, Points, CurrWeapon, MaxWeapon, NumLives, NumHits
DIM SHARED UnlimitedAmmo, UnlimitedHealth, Enemy, EnemyType, MaxHits, EnemyAlive

DIM SHARED Level

DIM SHARED ELife%(200), HBonus%(200), NWeapon%(200), AClip%(200), MBag%(200)
DIM SHARED xx, ax, mx, wx, hx, xy, ay, my, wy, hy, ecol, erow, NewLevel

DIM SHARED red(256), green(256), blue(256)

DIM SHARED ENTER AS STRING, ESC AS STRING, SPACE AS STRING
DIM SHARED LEFT AS STRING, RIGHT AS STRING, UP AS STRING, DOWN AS STRING
DIM SHARED F1 AS STRING, BKSPC AS STRING

ENTER = CHR$(13): ESC = CHR$(27): SPACE = CHR$(32)
LEFT = CHR$(0) + "K": RIGHT = CHR$(0) + "M"
UP = CHR$(0) + "H": DOWN = CHR$(0) + "P"
F1 = CHR$(0) + ";": BKSPC = CHR$(8)

 map$(1) = "  bbbbbbbbbbdbb"
 map$(2) = "  b  b  b  d  b           "
 map$(3) = "  b  d  b  b  b"
 map$(4) = "  bdbbbbbbbbdbb"
 map$(5) = "  b  b     b  b"
 map$(6) = "  b  b     b  b"
 map$(7) = "  bdbbbbb  bdbb"
 map$(8) = "  b  b  b      "
 map$(9) = "  b  d  b      "
map$(10) = "  bdbbbbb      "
map$(11) = "  b  b         "
map$(12) = "  b  b         "
map$(13) = "  bdbbbbb      "
map$(14) = "  b  b  b      "
map$(15) = "  b  d  b      "
map$(16) = "  bdbbbbb      "
map$(17) = "  b  b  b      "
map$(18) = "  b  d  b      "
map$(19) = "  bbbbbbb"

SetDefaults
LoadLevel Level
Intro
Menu

REM $STATIC
SUB DrawChar (x, y, PlayerState, arms, legs)
face = 65: hair = 6: shirt = 40: pants = 54: shoes = 210

SELECT CASE PlayerState
CASE SOUTH
LINE (x, y)-(x + 4, y + 4), face, BF: LINE (x + 1, y + 4)-(x + 3, y + 5), face, BF
LINE (x + 1, y + 2)-(x + 1, y + 2), hair: LINE (x + 3, y + 2)-(x + 3, y + 2), hair
LINE (x, y - 1)-(x + 4, y - 1), hair: LINE (x + 2, y)-(x + 4, y), hair
LINE (x + 3, y + 3)-(x + 3, y + 3), 15: LINE (x + 1, y + 3)-(x + 1, y + 3), 15
LINE (x + 2, y + 5)-(x + 2, y + 5), 15: LINE (x + 2, y + 6)-(x + 2, y + 6), face
LINE (x, y)-(x, y + 1), hair: LINE (x + 4, y + 1)-(x + 4, y + 2), hair
LINE (x - 1, y + 7)-(x + 6, y + 13), shirt, BF: LINE (x, y + 14)-(x + 4, y + 17), shirt, BF
LINE (x - 1, y + 8)-(x - 4, y + 10), shirt, BF: LINE (x + 7, y + 8)-(x + 8, y + 10), shirt, BF
LINE (x, y + 17)-(x + 4, y + 18), face, BF: LINE (x - 1, y + 19)-(x + 5, y + 32), pants, BF

IF legs = 1 THEN
LINE (x + 3, y + 33)-(x + 5, y + 34), shoes, BF: LINE (x - 1, y + 33)-(x + 2, y + 34), shoes, BF
LINE (x + 2, y + 34)-(x + 2, y + 24), 0
END IF

IF legs = 4 THEN
LINE (x + 3, y + 33)-(x + 5, y + 34), shoes, BF: LINE (x - 1, y + 32)-(x + 2, y + 33), shoes, BF
LINE (x + 2, y + 34)-(x + 2, y + 24), 0: LINE (x - 1, y + 26)-(x + 2, y + 26), 0
END IF

IF legs = 3 THEN
LINE (x + 3, y + 32)-(x + 5, y + 33), shoes, BF: LINE (x - 1, y + 33)-(x + 2, y + 34), shoes, BF
LINE (x + 2, y + 34)-(x + 2, y + 24), 0
END IF

IF legs = 2 THEN
LINE (x + 3, y + 32)-(x + 5, y + 33), shoes, BF: LINE (x - 1, y + 33)-(x + 2, y + 34), shoes, BF
LINE (x + 2, y + 34)-(x + 2, y + 24), 0: LINE (x + 5, y + 26)-(x + 2, y + 26), 0
END IF

IF arms = ARMSDOWN THEN
LINE (x + 6, y + 11)-(x + 8, y + 14), face, BF: LINE (x + 7, y + 15)-(x + 8, y + 19), face, BF
LINE (x - 4, y + 11)-(x - 2, y + 14), face, BF: LINE (x - 4, y + 15)-(x - 3, y + 19), face, BF
ELSE
LINE (x + 6, y + 11)-(x + 8, y + 14), face, BF: LINE (x + 7, y + 15)-(x + 8, y + 19), face, BF
LINE (x - 4, y + 11)-(x - 2, y + 14), face, BF: LINE (x - 4, y + 15)-(x - 3, y + 16), 66, BF
DrawGun x - 4, y + 13, CurrWeapon, SOUTH
END IF


CASE NORTH
LINE (x, y)-(x + 4, y + 4), hair, BF: LINE (x + 1, y + 4)-(x + 3, y + 5), hair, BF
LINE (x + 2, y + 6)-(x + 2, y + 6), face: LINE (x, y)-(x, y + 1), hair
LINE (x + 4, y + 1)-(x + 4, y + 2), hair: LINE (x - 1, y + 7)-(x + 6, y + 13), shirt, BF
LINE (x, y + 14)-(x + 4, y + 17), shirt, BF: LINE (x - 1, y + 8)-(x - 4, y + 10), shirt, BF
LINE (x + 7, y + 8)-(x + 8, y + 10), shirt, BF: LINE (x, y + 17)-(x + 4, y + 18), face, BF
LINE (x - 1, y + 19)-(x + 5, y + 32), pants, BF

IF legs = 1 THEN
LINE (x + 3, y + 33)-(x + 5, y + 34), shoes, BF: LINE (x - 1, y + 33)-(x + 2, y + 34), shoes, BF
LINE (x + 2, y + 34)-(x + 2, y + 24), 0
END IF

IF legs = 2 THEN
LINE (x + 3, y + 33)-(x + 5, y + 34), shoes, BF: LINE (x - 1, y + 32)-(x + 2, y + 33), shoes, BF
LINE (x + 2, y + 34)-(x + 2, y + 24), 0: LINE (x - 1, y + 26)-(x + 2, y + 26), 0
END IF

IF legs = 3 THEN
LINE (x + 3, y + 33)-(x + 5, y + 34), shoes, BF: LINE (x - 1, y + 32)-(x + 2, y + 33), shoes, BF
LINE (x + 2, y + 34)-(x + 2, y + 24), 0
END IF

IF legs = 4 THEN
LINE (x + 3, y + 32)-(x + 5, y + 33), shoes, BF: LINE (x - 1, y + 33)-(x + 2, y + 34), shoes, BF
LINE (x + 2, y + 34)-(x + 2, y + 24), 0: LINE (x + 5, y + 26)-(x + 2, y + 26), 0
END IF

IF arms = ARMSDOWN THEN
LINE (x + 6, y + 11)-(x + 8, y + 14), face, BF: LINE (x + 7, y + 15)-(x + 8, y + 19), face, BF
LINE (x - 4, y + 11)-(x - 2, y + 14), face, BF: LINE (x - 4, y + 15)-(x - 3, y + 19), face, BF
ELSE
LINE (x + 6, y + 11)-(x + 8, y + 14), face, BF: LINE (x + 7, y + 15)-(x + 8, y + 15), face, BF
LINE (x - 4, y + 11)-(x - 2, y + 14), face, BF: LINE (x - 4, y + 15)-(x - 3, y + 19), face, BF
DrawGun x + 6, y + 11, CurrWeapon, NORTH
END IF

CASE WEST
LINE (x, y)-(x + 3, y + 4), face, BF
LINE (x - 1, y - 1)-(x + 4, y - 1), hair
LINE (x + 4, y - 1)-(x + 4, y + 3), hair
LINE (x + 3, y)-(x + 3, y + 2), hair
LINE (x + 1, y + 1)-(x + 1, y + 1), hair
LINE (x + 1, y + 2)-(x + 1, y + 2), 15
LINE (x, y + 4)-(x, y + 4), 15
LINE (x + 1, y + 5)-(x + 2, y + 6), face, BF
LINE (x, y + 7)-(x + 4, y + 8), shirt, BF
LINE (x - 1, y + 9)-(x + 5, y + 16), shirt, BF
LINE (x, y + 17)-(x + 4, y + 18), face, BF
LINE (x + 1, y + 11)-(x + 4, y + 14), 64, BF
LINE (x + 2, y + 15)-(x + 4, y + 18), 64, BF
LINE (x, y + 19)-(x + 5, y + 22), pants, BF
LINE (x, y + 22)-(x + 4, y + 32), pants, BF
LINE (x + 3, y + 33)-(x - 1, y + 34), shoes, BF

IF arms = ARMSDOWN THEN
LINE (x + 1, y + 11)-(x + 4, y + 14), face, BF
LINE (x + 2, y + 15)-(x + 4, y + 20), face, BF
ELSE
LINE (x + 1, y + 11)-(x + 4, y + 14), face, BF
LINE (x + 4, y + 15)-(x - 4, y + 16), face, BF
DrawGun x - 3, y + 13, CurrWeapon, WEST
END IF

IF legs = 2 THEN
LINE (x - 2, y + 21)-(x - 5, y + 25), 16
LINE (x - 1, y + 21)-(x - 1, y + 27), 16
LINE (x - 1, y + 27)-(x - 5, y + 25), 16
PAINT (x - 2, y + 25), pants, 16
LINE (x + 5, y + 24)-(x + 6, y + 28), shoes, BF
END IF

IF legs = 3 THEN
LINE (x - 1, y + 20)-(x - 1, y + 24), 16
LINE (x - 1, y + 20)-(x - 6, y + 25), 16
LINE (x - 6, y + 25)-(x - 6, y + 32), 16
LINE (x - 6, y + 32)-(x - 1, y + 32), 16
LINE (x - 1, y + 32)-(x - 1, y + 24), 16
PAINT (x - 5, y + 30), pants, 16
LINE (x - 3, y + 33)-(x - 8, y + 34), shoes, BF
END IF

IF legs = 4 THEN
LINE (x + 4, y + 23)-(x - 1, y + 32), 16
LINE (x - 1, y + 20)-(x - 6, y + 32), 16
LINE (x - 1, y + 32)-(x - 5, y + 32), 16
LINE (x + 5, y + 22)-(x + 5, y + 19), 16
LINE (x + 1, y + 19)-(x - 1, y + 19), 16
LINE (x + 1, y + 20)-(x + 1, y + 21), 16
LINE (x + 2, y + 21)-(x + 5, y + 21), 16
LINE (x - 3, y + 33)-(x - 8, y + 34), shoes, BF
PAINT (x - 3, y + 30), pants, 16
END IF

CASE EAST
LINE (x, y)-(x + 4, y + 4), face, BF
LINE (x + 2, y + 5)-(x + 3, y + 6), face, BF
LINE (x, y - 1)-(x + 5, y - 1), hair
LINE (x + 5, y)-(x + 5, y), hair
LINE (x + 5, y)-(x + 5, y), hair
LINE (x, y)-(x + 1, y + 2), hair, BF
LINE (x + 3, y + 1)-(x + 3, y + 1), hair
LINE (x + 3, y + 2)-(x + 3, y + 2), 15
LINE (x + 4, y + 4)-(x + 4, y + 4), 15
LINE (x + 1, y + 7)-(x + 4, y + 8), shirt, BF
LINE (x - 1, y + 9)-(x + 5, y + 16), shirt, BF
LINE (x, y + 17)-(x + 4, y + 18), face, BF
LINE (x - 1, y + 19)-(x + 4, y + 22), pants, BF
LINE (x, y + 23)-(x + 4, y + 32), pants, BF
LINE (x + 1, y + 33)-(x + 5, y + 34), shoes, BF

IF arms = ARMSDOWN THEN
LINE (x + 1, y + 11)-(x + 4, y + 14), face, BF
LINE (x + 1, y + 15)-(x + 3, y + 20), face, BF
ELSE
LINE (x + 1, y + 11)-(x + 4, y + 14), face, BF
LINE (x + 1, y + 15)-(x + 8, y + 16), face, BF
DrawGun x + 6, y + 13, CurrWeapon, EAST
END IF


IF legs = 2 THEN
LINE (x + 5, y + 20)-(x + 9, y + 23), 16
LINE (x + 5, y + 20)-(x + 5, y + 26), 16
LINE (x + 5, y + 26)-(x + 8, y + 23), 16
PAINT (x + 7, y + 23), pants, 16
LINE (x - 1, y + 25)-(x - 2, y + 29), shoes, BF
END IF

IF legs = 3 THEN
LINE (x + 5, y + 20)-(x + 9, y + 23), 16
LINE (x + 9, y + 23)-(x + 9, y + 32), 16
LINE (x + 9, y + 32)-(x + 5, y + 32), 16
LINE (x + 5, y + 32)-(x + 5, y + 20), 16
PAINT (x + 8, y + 27), pants, 16
LINE (x + 7, y + 33)-(x + 11, y + 34), shoes, BF
END IF

IF legs = 4 THEN
LINE (x + 4, y + 19)-(x + 10, y + 32), 16
LINE (x + 4, y + 19)-(x + 4, y + 21), 16
LINE (x + 4, y + 21)-(x + 1, y + 21), 16
LINE (x, y + 21)-(x, y + 19), 16
LINE (x, y + 19)-(x - 1, y + 19), 16
LINE (x - 2, y + 19)-(x - 2, y + 22), 16
LINE (x - 2, y + 22)-(x + 5, y + 32), 16
LINE (x + 5, y + 32)-(x + 10, y + 32), 16
PAINT (x + 7, y + 28), pants, 16
LINE (x + 7, y + 33)-(x + 11, y + 34), shoes, BF
END IF

END SELECT

END SUB

SUB DrawDeadSoldier (x, y, EnemyType)
SELECT CASE EnemyType
CASE GUARD: hat = 118: hat2 = 115: shirt = 215: pants = 139: shoes = 187
CASE OFFICER: hat = 32: hat2 = 1: shirt = 127: pants = 199: shoes = 187
END SELECT

CIRCLE (x, y + 30), 10, 4, , , .25: PAINT (x, y + 30), 4
LINE (x - 15, y + 25)-(x - 10, y + 28), 64, BF
LINE (x - 15, y + 25)-(x - 15, y + 28), hat2
LINE (x - 16, y + 25)-(x - 16, y + 29), hat
LINE (x - 14, y + 25)-(x - 13, y + 25), hat2
LINE (x - 13, y + 28)-(x - 13, y + 28), 4
LINE (x - 11, y + 28)-(x - 11, y + 28), 14
LINE (x - 9, y + 27)-(x - 9, y + 25), 64
LINE (x - 8, y + 24)-(x + 5, y + 28), shirt, BF
LINE (x - 5, y + 26)-(x - 5, y + 28), pants
LINE (x - 3, y + 26)-(x - 3, y + 28), pants
LINE (x - 5, y + 29)-(x - 4, y + 31), 64, BF
LINE (x - 11, y + 32)-(x - 4, y + 33), 64, BF
LINE (x - 5, y + 23)-(x - 4, y + 23), 64, BF
LINE (x + 6, y + 24)-(x + 11, y + 27), pants, BF
LINE (x + 9, y + 24)-(x + 12, y + 32), pants, BF
LINE (x + 12, y + 29)-(x + 19, y + 32), pants, BF
LINE (x + 12, y + 24)-(x + 26, y + 28), pants, BF
LINE (x + 19, y + 28)-(x + 14, y + 28), 0
LINE (x + 14, y + 28)-(x + 14, y + 26), 0
LINE (x + 20, y + 30)-(x + 21, y + 33), shoes, BF
LINE (x + 27, y + 25)-(x + 28, y + 29), shoes, BF
END SUB

SUB DrawDoor (texture, position, x, y)
DrawTexture texture, position, x, y

SELECT CASE position
CASE MIDPOS
LINE (x + 20, y + 72)-(x + 52, y + 28), 53, BF
LINE (x + 20, y + 72)-(x + 52, y + 27), 16, B
LINE (x + 36, y + 72)-(x + 36, y + 27), 16

CASE LEFTPOS
LINE (x - 5, y + 85)-(x - 15, y + 105), 16
LINE (x - 15, y + 105)-(x - 15, y + 58), 16
LINE (x - 5, y + 85)-(x - 5, y + 40), 16
LINE (x - 15, y + 58)-(x - 5, y + 40), 16
PAINT (x - 10, y + 60), 53, 16
LINE (x - 10, y + 49)-(x - 10, y + 94), 16

CASE RIGHTPOS
LINE (x + 5, y + 85)-(x + 15, y + 105), 16
LINE (x + 15, y + 105)-(x + 15, y + 58), 16
LINE (x + 5, y + 85)-(x + 5, y + 40), 16
LINE (x + 15, y + 58)-(x + 5, y + 40), 16
PAINT (x + 10, y + 60), 53, 16
LINE (x + 10, y + 49)-(x + 10, y + 94), 16

CASE LOWERPOS
LINE (x + 34, y)-(x + 72, y + 16), 53, BF
LINE (x + 34, y)-(x + 72, y + 16), 16, B
LINE (x + 53, y)-(x + 53, y + 16), 16

END SELECT

END SUB

SUB DrawEnemy (x, y, EnemyType)
SELECT CASE EnemyType
CASE GUARD: hat = 118: hat2 = 115: shirt = 215: pants = 139: shoes = 187
CASE OFFICER: hat = 32: hat2 = 1: shirt = 127: pants = 199: shoes = 187
END SELECT

GET (x - 5, y - 2)-(x + 10, y + 35), EBuffer%
LINE (x, y + 2)-(x + 4, y + 6), 64, BF
LINE (x + 1, y + 7)-(x + 3, y + 7), 64, BF
LINE (x, y + 1)-(x + 4, y + 1), hat2
LINE (x - 1, y)-(x + 5, y), hat
LINE (x + 1, y + 3)-(x + 1, y + 3), 4
LINE (x + 3, y + 3)-(x + 3, y + 3), 4
LINE (x + 2, y + 5)-(x + 2, y + 5), 15
LINE (x - 1, y + 8)-(x + 5, y + 15), shirt, BF
LINE (x - 1, y + 16)-(x + 4, y + 18), shirt, BF
LINE (x - 2, y + 9)-(x - 4, y + 11), shirt, BF
LINE (x + 4, y + 9)-(x + 7, y + 11), shirt, BF
LINE (x - 1, y + 19)-(x + 5, y + 20), pants, BF
LINE (x - 2, y + 21)-(x + 6, y + 33), pants, BF
LINE (x - 1, y + 34)-(x + 2, y + 34), shoes, BF
LINE (x + 3, y + 34)-(x + 5, y + 34), shoes, BF
LINE (x + 2, y + 34)-(x + 2, y + 25), 0
LINE (x + 6, y + 12)-(x + 7, y + 20), 64, BF
LINE (x - 4, y + 12)-(x - 2, y + 16), 64, BF

IF EnemyType = GUARD THEN
DrawGun x - 3.5, y + 13, PISTOL, SOUTH
ELSE
DrawGun x - 3.5, y + 13, SHOTGUN, SOUTH
END IF

LINE (x - 4, y + 15)-(x - 2, y + 16), 65, BF
GET (x - 6, y + 10)-(x, y + 15), EGun%
END SUB

SUB DrawGun (x, y, weapon, PlayerState)
SELECT CASE PlayerState
CASE SOUTH
SELECT CASE weapon
CASE PISTOL
LINE (x, y)-(x + 1, y + 1), 8, BF

CASE SHOTGUN
LINE (x, y)-(x + 1, y + 1), 8, BF
LINE (x, y + 1)-(x + 1, y + 1), 6

CASE FLAMER
CIRCLE (x + 1, y), 1, 0: PAINT (x + 1, y), 0
LINE (x + 3, y - 6)-(x + 4, y + 3), 190, BF
LINE (x + 7, y - 6)-(x + 8, y + 3), 190, BF
END SELECT


CASE EAST
SELECT CASE weapon
CASE PISTOL
LINE (x, y)-(x + 5, y + 1), 8, BF

CASE SHOTGUN
LINE (x, y + 1)-(x + 8, y + 1), 8, BF
LINE (x + 1, y)-(x + 10, y), 8, BF
LINE (x + 5, y + 1)-(x + 8, y + 1), 6

CASE FLAMER
LINE (x + 1, y + 1)-(x + 15, y - 1), 0, BF
LINE (x - 7, y - 5)-(x - 9, y + 5), 190, BF
LINE (x - 9, y - 3)-(x - 11, y + 5), 190, BF
END SELECT


CASE WEST
SELECT CASE weapon
CASE PISTOL
LINE (x, y)-(x - 5, y + 1), 8, BF

CASE SHOTGUN
LINE (x, y + 1)-(x - 8, y + 1), 8, BF
LINE (x - 1, y)-(x - 10, y), 8, BF
LINE (x - 5, y + 1)-(x - 8, y + 1), 6

CASE FLAMER
LINE (x - 1, y + 1)-(x - 15, y - 1), 0, BF
LINE (x + 8, y - 5)-(x + 10, y + 5), 190, BF
LINE (x + 10, y - 3)-(x + 12, y + 5), 190, BF

END SELECT

CASE NORTH
IF weapon = FLAMER THEN
LINE (x - 6, y - 3)-(x - 1, y + 6), 190, BF
LINE (x - 5, y - 4)-(x - 5, y + 3), 190
LINE (x - 2, y - 4)-(x - 2, y + 3), 190
END IF
END SELECT

END SUB

SUB DrawObject (object, ox, oy)
face = 65: hair = 6: shirt = 40: pants = 54: shoes = 210

SELECT CASE object
CASE EXTRALIFE
GET (ox - 10, oy - 10)-(ox + 13, oy + 5), ELife%
LINE (ox - 10, oy - 5)-(ox + 10, oy + 5), 90, BF
LINE (ox - 10, oy - 5)-(ox + 10, oy + 5), 16, B
LINE (ox + 10, oy + 5)-(ox + 12, oy + 3), 16
LINE (ox + 12, oy + 3)-(ox + 12, oy - 7), 16
LINE (ox + 12, oy - 7)-(ox + 10, oy - 5), 16
PAINT (ox + 11, oy), 90, 16
LINE (ox + 12, oy - 7)-(ox - 8, oy - 7), 16
LINE (ox - 8, oy - 7)-(ox - 10, oy - 5), 16
PAINT (ox, oy - 6), 90, 16
LINE (ox - 1, oy - 4)-(ox + 1, oy - 4), hair
LINE (ox - 1, oy - 3)-(ox + 1, oy - 2), face, BF
LINE (ox - 1, oy - 1)-(ox + 1, oy + 1), shirt, BF
LINE (ox - 1, oy + 2)-(ox + 1, oy + 3), pants, BF
LINE (ox - 1, oy + 4)-(ox + 2, oy + 4), shoes

CASE HEALTHBONUS
GET (ox - 10, oy - 10)-(ox + 13, oy + 5), HBonus%
LINE (ox - 10, oy - 5)-(ox + 10, oy + 5), 90, BF
LINE (ox - 10, oy - 5)-(ox + 10, oy + 5), 16, B
LINE (ox + 10, oy + 5)-(ox + 12, oy + 3), 16
LINE (ox + 12, oy + 3)-(ox + 12, oy - 7), 16
LINE (ox + 12, oy - 7)-(ox + 10, oy - 5), 16
PAINT (ox + 11, oy), 90, 16
LINE (ox + 12, oy - 7)-(ox - 8, oy - 7), 16
LINE (ox - 8, oy - 7)-(ox - 10, oy - 5), 16
PAINT (ox, oy - 6), 90, 16
LINE (ox - 1, oy - 3)-(ox + 1, oy + 3), 40, BF
LINE (ox - 3, oy - 1)-(ox + 3, oy + 1), 40, BF

CASE NEWWEAPON
GET (ox - 10, oy - 10)-(ox + 13, oy + 5), NWeapon%
LINE (ox - 10, oy - 5)-(ox + 10, oy + 5), 90, BF
LINE (ox - 10, oy - 5)-(ox + 10, oy + 5), 16, B
LINE (ox + 10, oy + 5)-(ox + 12, oy + 3), 16
LINE (ox + 12, oy + 3)-(ox + 12, oy - 7), 16
LINE (ox + 12, oy - 7)-(ox + 10, oy - 5), 16
PAINT (ox + 11, oy), 90, 16
LINE (ox + 12, oy - 7)-(ox - 8, oy - 7), 16
LINE (ox - 8, oy - 7)-(ox - 10, oy - 5), 16
PAINT (ox, oy - 6), 90, 16
LINE (ox - 5, oy - 1)-(ox - 3, oy + 3), 6, BF
LINE (ox - 5, oy - 1)-(ox + 3, oy - 1), 16
LINE (ox - 4, oy - 2)-(ox + 3, oy - 2), 16

CASE AMMOCLIP
GET (ox - 10, oy - 10)-(ox + 13, oy + 5), AClip%
LINE (ox - 10, oy - 5)-(ox + 10, oy + 5), 90, BF
LINE (ox - 10, oy - 5)-(ox + 10, oy + 5), 16, B
LINE (ox + 10, oy + 5)-(ox + 12, oy + 3), 16
LINE (ox + 12, oy + 3)-(ox + 12, oy - 7), 16
LINE (ox + 12, oy - 7)-(ox + 10, oy - 5), 16
PAINT (ox + 11, oy), 90, 16
LINE (ox + 12, oy - 7)-(ox - 8, oy - 7), 16
LINE (ox - 8, oy - 7)-(ox - 10, oy - 5), 16
PAINT (ox, oy - 6), 90, 16
LINE (ox - 1, oy - 2)-(ox + 1, oy + 3), 42, BF
LINE (ox - 1, oy - 2)-(ox + 1, oy + 3), 16, B
LINE (ox, oy - 3)-(ox, oy - 3), 16

CASE MONEYBAG
GET (ox - 10, oy - 10)-(ox + 13, oy + 5), MBag%
LINE (ox - 10, oy - 5)-(ox + 10, oy + 5), 90, BF
LINE (ox - 10, oy - 5)-(ox + 10, oy + 5), 16, B
LINE (ox + 10, oy + 5)-(ox + 12, oy + 3), 16
LINE (ox + 12, oy + 3)-(ox + 12, oy - 7), 16
LINE (ox + 12, oy - 7)-(ox + 10, oy - 5), 16
PAINT (ox + 11, oy), 90, 16
LINE (ox + 12, oy - 7)-(ox - 8, oy - 7), 16
LINE (ox - 8, oy - 7)-(ox - 10, oy - 5), 16
PAINT (ox, oy - 6), 90, 16
CIRCLE (ox, oy), 3, 0, , , 1.5: PAINT (ox, oy), 42, 0

END SELECT
END SUB

SUB DrawTexture (texture, position, x, y)
SELECT CASE texture
CASE BRICK
tcolor = 111: gcolor = 186
CASE STONE
tcolor = 23: gcolor = 17
END SELECT

SELECT CASE position
CASE MIDPOS
LINE (x, y)-(x + 72, y + 72), tcolor, BF
LINE (x, y + 9)-(x + 72, y + 9), gcolor
LINE (x + 18, y + 9)-(x + 18, y), gcolor
LINE (x + 36, y + 9)-(x + 36, y), gcolor
LINE (x + 54, y + 9)-(x + 54, y), gcolor
LINE (x + 72, y + 9)-(x + 72, y), gcolor
LINE (x, y + 18)-(x + 72, y + 18), gcolor
LINE (x + 9, y + 18)-(x + 9, y + 9), gcolor
LINE (x + 27, y + 18)-(x + 27, y + 9), gcolor
LINE (x + 45, y + 18)-(x + 45, y + 9), gcolor
LINE (x + 63, y + 18)-(x + 63, y + 9), gcolor
LINE (x, y + 27)-(x + 72, y + 27), gcolor
LINE (x + 18, y + 27)-(x + 18, y + 18), gcolor
LINE (x + 36, y + 27)-(x + 36, y + 18), gcolor
LINE (x + 54, y + 27)-(x + 54, y + 18), gcolor
LINE (x + 72, y + 27)-(x + 72, y + 18), gcolor
LINE (x, y + 36)-(x + 72, y + 36), gcolor
LINE (x + 9, y + 36)-(x + 9, y + 27), gcolor
LINE (x + 27, y + 36)-(x + 27, y + 27), gcolor
LINE (x + 45, y + 36)-(x + 45, y + 27), gcolor
LINE (x + 63, y + 36)-(x + 63, y + 27), gcolor
LINE (x, y + 45)-(x + 72, y + 45), gcolor
LINE (x + 18, y + 45)-(x + 18, y + 36), gcolor
LINE (x + 36, y + 45)-(x + 36, y + 36), gcolor
LINE (x + 54, y + 45)-(x + 54, y + 36), gcolor
LINE (x + 72, y + 45)-(x + 72, y + 36), gcolor
LINE (x, y + 54)-(x + 72, y + 54), gcolor
LINE (x + 9, y + 54)-(x + 9, y + 45), gcolor
LINE (x + 27, y + 54)-(x + 27, y + 45), gcolor
LINE (x + 45, y + 54)-(x + 45, y + 45), gcolor
LINE (x + 63, y + 54)-(x + 63, y + 45), gcolor
LINE (x, y + 63)-(x + 72, y + 63), gcolor
LINE (x + 18, y + 63)-(x + 18, y + 54), gcolor
LINE (x + 36, y + 63)-(x + 36, y + 54), gcolor
LINE (x + 54, y + 63)-(x + 54, y + 54), gcolor
LINE (x + 72, y + 63)-(x + 72, y + 54), gcolor
LINE (x, y + 72)-(x + 72, y + 72), gcolor
LINE (x + 9, y + 72)-(x + 9, y + 63), gcolor
LINE (x + 27, y + 72)-(x + 27, y + 63), gcolor
LINE (x + 45, y + 72)-(x + 45, y + 63), gcolor
LINE (x + 63, y + 72)-(x + 63, y + 63), gcolor

CASE LEFTPOS
LINE (x, y)-(x, y + 72), tcolor
LINE (x, y)-(x - 24, y + 48), tcolor
LINE (x - 24, y + 48)-(x - 24, y + 120), tcolor
LINE (x - 24, y + 120)-(x, y + 72), tcolor
PAINT (x - 10, y + 40), tcolor
LINE (x, y + 9)-(x - 24, y + 55), gcolor
LINE (x - 18, y + 45)-(x - 18, y + 37), gcolor
LINE (x - 12, y + 35)-(x - 12, y + 25), gcolor
LINE (x - 6, y + 23)-(x - 6, y + 13), gcolor
LINE (x, y + 10)-(x, y + 2), gcolor
LINE (x, y + 18)-(x - 24, y + 64), gcolor
LINE (x - 21, y + 60)-(x - 21, y + 50), gcolor
LINE (x - 15, y + 50)-(x - 15, y + 40), gcolor
LINE (x - 9, y + 38)-(x - 9, y + 28), gcolor
LINE (x - 3, y + 27)-(x - 3, y + 18), gcolor
LINE (x, y + 27)-(x - 24, y + 73), gcolor
LINE (x - 18, y + 63)-(x - 18, y + 54), gcolor
LINE (x - 12, y + 52)-(x - 12, y + 42), gcolor
LINE (x - 6, y + 40)-(x - 6, y + 30), gcolor
LINE (x, y + 10)-(x, y + 2), gcolor
LINE (x, y + 36)-(x - 24, y + 82), gcolor
LINE (x - 21, y + 78)-(x - 21, y + 68), gcolor
LINE (x - 15, y + 68)-(x - 15, y + 58), gcolor
LINE (x - 9, y + 56)-(x - 9, y + 46), gcolor
LINE (x - 3, y + 45)-(x - 3, y + 36), gcolor
LINE (x, y + 45)-(x - 24, y + 91), gcolor
LINE (x - 18, y + 81)-(x - 18, y + 72), gcolor
LINE (x - 12, y + 70)-(x - 12, y + 60), gcolor
LINE (x - 6, y + 58)-(x - 6, y + 48), gcolor
LINE (x, y + 28)-(x, y + 20), gcolor
LINE (x, y + 54)-(x - 24, y + 100), gcolor
LINE (x - 21, y + 96)-(x - 21, y + 86), gcolor
LINE (x - 15, y + 86)-(x - 15, y + 76), gcolor
LINE (x - 9, y + 74)-(x - 9, y + 64), gcolor
LINE (x - 3, y + 63)-(x - 3, y + 54), gcolor
LINE (x, y + 63)-(x - 24, y + 109), gcolor
LINE (x - 18, y + 99)-(x - 18, y + 90), gcolor
LINE (x - 12, y + 88)-(x - 12, y + 78), gcolor
LINE (x - 6, y + 76)-(x - 6, y + 66), gcolor
LINE (x, y + 46)-(x, y + 38), gcolor
LINE (x, y + 72)-(x - 24, y + 118), gcolor
LINE (x - 21, y + 114)-(x - 21, y + 104), gcolor
LINE (x - 15, y + 104)-(x - 15, y + 94), gcolor
LINE (x - 9, y + 92)-(x - 9, y + 82), gcolor
LINE (x - 3, y + 81)-(x - 3, y + 72), gcolor

CASE RIGHTPOS
LINE (x, y)-(x, y + 72), tcolor
LINE (x, y)-(x + 24, y + 48), tcolor
LINE (x + 24, y + 48)-(x + 24, y + 120), tcolor
LINE (x + 24, y + 120)-(x, y + 72), tcolor
PAINT (x + 10, y + 40), tcolor
LINE (x, y + 9)-(x + 24, y + 55), gcolor
LINE (x + 18, y + 45)-(x + 18, y + 37), gcolor
LINE (x + 12, y + 35)-(x + 12, y + 25), gcolor
LINE (x + 6, y + 23)-(x + 6, y + 13), gcolor
LINE (x, y + 10)-(x, y + 2), gcolor
LINE (x, y + 18)-(x + 24, y + 64), gcolor
LINE (x + 21, y + 60)-(x + 21, y + 50), gcolor
LINE (x + 15, y + 50)-(x + 15, y + 40), gcolor
LINE (x + 9, y + 38)-(x + 9, y + 28), gcolor
LINE (x + 3, y + 27)-(x + 3, y + 18), gcolor
LINE (x, y + 27)-(x + 24, y + 73), gcolor
LINE (x + 18, y + 63)-(x + 18, y + 54), gcolor
LINE (x + 12, y + 52)-(x + 12, y + 42), gcolor
LINE (x + 6, y + 40)-(x + 6, y + 30), gcolor
LINE (x, y + 10)-(x, y + 2), gcolor
LINE (x, y + 36)-(x + 24, y + 82), gcolor
LINE (x + 21, y + 78)-(x + 21, y + 68), gcolor
LINE (x + 15, y + 68)-(x + 15, y + 58), gcolor
LINE (x + 9, y + 56)-(x + 9, y + 46), gcolor
LINE (x + 3, y + 45)-(x + 3, y + 36), gcolor
LINE (x, y + 45)-(x + 24, y + 91), gcolor
LINE (x + 18, y + 81)-(x + 18, y + 72), gcolor
LINE (x + 12, y + 70)-(x + 12, y + 60), gcolor
LINE (x + 6, y + 58)-(x + 6, y + 48), gcolor
LINE (x, y + 28)-(x, y + 20), gcolor
LINE (x, y + 54)-(x + 24, y + 100), gcolor
LINE (x + 21, y + 96)-(x + 21, y + 86), gcolor
LINE (x + 15, y + 86)-(x + 15, y + 76), gcolor
LINE (x + 9, y + 74)-(x + 9, y + 64), gcolor
LINE (x + 3, y + 63)-(x + 3, y + 54), gcolor
LINE (x, y + 63)-(x + 24, y + 109), gcolor
LINE (x + 18, y + 99)-(x + 18, y + 90), gcolor
LINE (x + 12, y + 88)-(x + 12, y + 78), gcolor
LINE (x + 6, y + 76)-(x + 6, y + 66), gcolor
LINE (x, y + 46)-(x, y + 38), gcolor
LINE (x, y + 72)-(x + 24, y + 118), gcolor
LINE (x + 21, y + 114)-(x + 21, y + 104), gcolor
LINE (x + 15, y + 104)-(x + 15, y + 94), gcolor
LINE (x + 9, y + 92)-(x + 9, y + 82), gcolor
LINE (x + 3, y + 81)-(x + 3, y + 72), gcolor

CASE LOWERPOS
LINE (x, y)-(x + 106, y + 24), tcolor, BF
LINE (x, y + 4)-(x + 106, y + 4), gcolor
LINE (x + 26, y + 4)-(x + 26, y), gcolor
LINE (x + 52, y + 4)-(x + 52, y), gcolor
LINE (x + 78, y + 4)-(x + 78, y), gcolor
LINE (x + 106, y + 4)-(x + 106, y), gcolor
LINE (x, y + 8)-(x + 106, y + 8), gcolor
LINE (x + 13, y + 8)-(x + 13, y + 4), gcolor
LINE (x + 39, y + 8)-(x + 39, y + 4), gcolor
LINE (x + 65, y + 8)-(x + 65, y + 4), gcolor
LINE (x + 91, y + 8)-(x + 91, y + 4), gcolor
LINE (x, y + 12)-(x + 106, y + 12), gcolor
LINE (x + 26, y + 12)-(x + 26, y + 8), gcolor
LINE (x + 52, y + 12)-(x + 52, y + 8), gcolor
LINE (x + 78, y + 12)-(x + 78, y + 8), gcolor
LINE (x + 106, y + 12)-(x + 106, y + 8), gcolor
LINE (x, y + 16)-(x + 106, y + 16), gcolor
LINE (x + 13, y + 16)-(x + 13, y + 12), gcolor
LINE (x + 39, y + 16)-(x + 39, y + 12), gcolor
LINE (x + 65, y + 16)-(x + 65, y + 12), gcolor
LINE (x + 91, y + 16)-(x + 91, y + 12), gcolor
LINE (x, y + 20)-(x + 106, y + 20), gcolor
LINE (x + 26, y + 20)-(x + 26, y + 16), gcolor
LINE (x + 52, y + 20)-(x + 52, y + 16), gcolor
LINE (x + 78, y + 20)-(x + 78, y + 16), gcolor
LINE (x + 106, y + 20)-(x + 106, y + 16), gcolor
LINE (x, y + 24)-(x + 106, y + 24), gcolor
LINE (x + 13, y + 24)-(x + 13, y + 20), gcolor
LINE (x + 39, y + 24)-(x + 39, y + 20), gcolor
LINE (x + 65, y + 24)-(x + 65, y + 20), gcolor
LINE (x + 91, y + 24)-(x + 91, y + 20), gcolor
END SELECT
END SUB

SUB FireWeapon (gunx, guny, weapon)
IF Ammo > 0 THEN
SELECT CASE weapon
CASE PISTOL
PSET (gunx, guny), 8
TimeDelay .0001
PSET (gunx, guny), 4
TimeDelay .0001
PSET (gunx, guny), 40
TimeDelay .0001
PSET (gunx, guny), 42
TimeDelay .0001
PUT (gunx - 5, guny - 5), Sight%, PSET:

CASE SHOTGUN
CIRCLE (gunx, guny), 2, 8
TimeDelay .0001
CIRCLE (gunx, guny), 2, 4
TimeDelay .0001

CIRCLE (gunx, guny), 2, 40
TimeDelay .0001

CIRCLE (gunx, guny), 2, 42
TimeDelay .0001

CIRCLE (gunx, guny), 2, 14: PAINT (gunx, guny), 42, 14
TimeDelay .0001
PUT (gunx - 5, guny - 5), Sight%, PSET:

CASE FLAMER
DIM Smoke%(200)
CIRCLE (gunx, guny), 4, 8: PAINT (gunx, guny), 8
TimeDelay .0001
CIRCLE (gunx, guny), 4, 4: PAINT (gunx, guny), 4
TimeDelay .0001
CIRCLE (gunx, guny), 4, 40: PAINT (gunx, guny), 40
TimeDelay .0001
CIRCLE (gunx, guny), 4, 42: PAINT (gunx, guny), 42
TimeDelay .0001
CIRCLE (gunx, guny), 4, 14: PAINT (gunx, guny), 14
TimeDelay .0001
CIRCLE (gunx, guny), 4, 42: PAINT (gunx, guny), 42
TimeDelay .0001
CIRCLE (gunx, guny), 4, 40: PAINT (gunx, guny), 40
TimeDelay .0001
CIRCLE (gunx, guny), 4, 4: PAINT (gunx, guny), 4
TimeDelay .0001
CIRCLE (gunx, guny), 4, 8: PAINT (gunx, guny), 8
TimeDelay .0001
CIRCLE (gunx, guny), 4, 0: PAINT (gunx, guny), 42, 0
TimeDelay .0001
PUT (gunx - 5, guny - 5), Sight%, PSET:
END SELECT
END IF

IF UnlimitedAmmo = FALSE THEN
Ammo = Ammo - 1: UpdateAmmo
ELSE
PUT (gunx - 5, guny - 5), Sight%, PSET:
END IF

IF gunx >= ex - 5 AND gunx <= ex + 10 AND guny >= ey - 2 AND guny <= ey + 34 AND EnemyAlive = TRUE THEN
SELECT CASE weapon
CASE PISTOL: NumHits = NumHits + 1
CASE SHOTGUN: NumHits = NumHits + 2
CASE FLAMER: NumHits = NumHits + 3
END SELECT

IF NumHits >= MaxHits THEN

CIRCLE (ex + 2, ey + 12), 3, 4, , , 1.5
PAINT (ex + 2, ey + 12), 4
TimeDelay SPEEDCONST! * 5

PUT (px - 25, py - 10), Buffer%, PSET
PUT (ex - 5, ey - 2), EBuffer%, PSET

DrawDeadSoldier ex, ey, EnemyType

GET (px - 25, py - 10)-(px + 25, py + 40), Buffer%
DrawChar px, py, PlayerState, 2, 1
IF EnemyType = GUARD THEN MID$(map$(erow), ecol) = "g":
IF EnemyType = OFFICER THEN MID$(map$(erow), ecol) = "j":


NumHits = 0: Points = Points + (50 * EnemyType): UpdatePoints: EnemyAlive = FALSE


END IF
END IF
END SUB

SUB GameLoop

ReplayGame:

cellx = cellpx: celly = cellpy

ViewField cellpy, cellpx
StatusBar


CheckEnemy:
IF cellpy < 1 THEN END
IF EnemyAlive = TRUE THEN now! = TIMER

Move:
GunRaise = FALSE
IF px < 30 THEN px = px + 25: PlayerState = EAST: GOTO Move
IF px > 290 THEN px = px - 25: PlayerState = WEST: GOTO Move

SELECT CASE PlayerState
CASE SOUTH, NORTH, EAST: shoex = px + 5: shoey = py + 34
CASE WEST: shoex = px - 1: shoey = py + 34
END SELECT

IF POINT(shoex, shoey) <> FLOORCONST AND px > 30 AND px < 270 AND py > 50 AND py < 120 THEN
Item = TRUE
SELECT CASE MID$(map$(celly), cellx, 1)
CASE "a": PUT (ax - 10, ay - 10), AClip%, PSET:
MID$(map$(celly), cellx, 1) = " ": Ammo = Ammo + 10: UpdateAmmo: Item = FALSE: GOTO Move

CASE "x": PUT (xx - 10, xy - 10), ELife%, PSET:
MID$(map$(celly), cellx, 1) = " ": NumLives = NumLives + 1: UpdateLives: Item = FALSE: GOTO Move

CASE "h": PUT (hx - 10, hy - 10), HBonus%, PSET:
MID$(map$(celly), cellx, 1) = " ": Health = Health + 10: UpdateHealth: Item = FALSE: GOTO Move

CASE "w": PUT (wx - 10, wy - 10), NWeapon%, PSET:
MID$(map$(celly), cellx, 1) = " ": CurrWeapon = CurrWeapon + 1: UpdateWeapon: Item = FALSE: GOTO Move

CASE "m": PUT (mx - 10, my - 10), MBag%, PSET:
MID$(map$(celly), cellx, 1) = " ": Points = Points + 50: UpdatePoints: GOTO Move

END SELECT
END IF

IF POINT(shoex, shoey) <> FLOORCONST AND Item = FALSE OR POINT(shoex, shoey) <> FLOORCONST AND Enemy = TRUE THEN
SELECT CASE PlayerState
CASE SOUTH: py = py - 15:
CASE WEST: px = px + 30:
CASE NORTH: py = py + 15
CASE EAST: px = px - 30
END SELECT
END IF

IF px <= 180 THEN cellx = cellpx + 1
IF px > 179 THEN cellx = cellpx + 2
IF py <= 80 THEN celly = cellpy + 1
IF py > 80 THEN celly = cellpy + 2

IF LEN(getcode$) >= 9 THEN
SELECT CASE RIGHT$(getcode$, 9)
CASE "MCUNLTDAM":
IF UnlimitedAmmo = TRUE THEN UnlimitedAmmo = FALSE
IF UnlimitedAmmo = FALSE THEN UnlimitedAmmo = TRUE
getcode$ = ""
SetPalette 0, 63, 0, 63: TimeDelay SPEEDCONST! * 2: SetPalette 0, 0, 0, 0
CASE "MCUNLTDHT":
IF UnlimitedHealth = TRUE THEN UnlimitedHealth = FALSE
IF UnlimitedHealth = FALSE THEN UnlimitedHealth = TRUE
getcode$ = ""
SetPalette 0, 0, 0, 63: TimeDelay SPEEDCONST! * 2: SetPalette 0, 0, 0, 0
CASE "MCMXWEPON": MaxWeapon = FLAMER: getcode$ = ""
SetPalette 0, 0, 63, 0: TimeDelay SPEEDCONST! * 2: SetPalette 0, 0, 0, 0
END SELECT
END IF

'LOCATE 1, 1: PRINT SPACE$(40);
'LOCATE 1, 1: PRINT px; py; cellx; celly; cellpx; celly; MID$(map$(celly), cellx, 1)

GET (px - 10, py - 10)-(px + 10, py + 40), Buffer%
DrawChar px, py, PlayerState, ARMSDOWN, STAND

IF EnemyAlive = TRUE THEN
IF TIMER - now! >= 1.5 THEN
CIRCLE (ex - 4, ey + 12), 2, 42: PAINT (ex - 4, ey + 12), 42
TimeDelay SPEEDCONST! / 2: PUT (ex - 6, ey + 10), EGun%, PSET
IF UnlimitedHealth = FALSE THEN
Health = Health - 3: UpdateHealth: now! = TIMER
END IF
END IF
END IF

DO: kbd$ = INKEY$:
IF EnemyAlive = TRUE THEN
IF TIMER - now! >= 1.5 THEN
CIRCLE (ex - 4, ey + 12), 2, 42: PAINT (ex - 4, ey + 12), 42
TimeDelay SPEEDCONST! / 2: PUT (ex - 6, ey + 10), EGun%, PSET
IF UnlimitedHealth = FALSE THEN
Health = Health - 3: UpdateHealth: now! = TIMER
END IF
END IF
END IF
LOOP WHILE kbd$ = ""

SELECT CASE kbd$
CASE IS >= CHR$(65): getcode$ = getcode$ + UCASE$(kbd$):
PUT (px - 10, py - 10), Buffer%, PSET: GOTO Move

CASE LEFT: PUT (px - 10, py - 10), Buffer%, PSET: PlayerState = WEST
PlayerWalk px, py, PlayerState: GOTO Move

CASE RIGHT: PUT (px - 10, py - 10), Buffer%, PSET: PlayerState = EAST
PlayerWalk px, py, PlayerState: GOTO Move

CASE UP: PUT (px - 10, py - 10), Buffer%, PSET: PlayerState = NORTH
PlayerWalk px, py, PlayerState: GOTO Move

CASE DOWN: PUT (px - 10, py - 10), Buffer%, PSET: PlayerState = SOUTH
PlayerWalk px, py, PlayerState: GOTO Move

CASE "1"
IF MaxWeapon >= 1 THEN
CurrWeapon = PISTOL: UpdateWeapon
END IF

PUT (px - 10, py - 10), Buffer%, PSET: GOTO Move

CASE "2"
IF MaxWeapon >= 2 THEN
CurrWeapon = SHOTGUN: UpdateWeapon
END IF

PUT (px - 10, py - 10), Buffer%, PSET: GOTO Move

CASE "3"
IF MaxWeapon >= 3 THEN
CurrWeapon = FLAMER: UpdateWeapon
END IF

PUT (px - 10, py - 10), Buffer%, PSET: GOTO Move

CASE SPACE
IF EnemyAlive = FALSE THEN
IF MID$(map$(celly + 1), cellx, 1) = "d" OR MID$(map$(celly + 1), cellx, 1) = "l" THEN
CLS : cellpy = cellpy + 3: cellpx = cellpx
ViewField cellpy, cellpx: py = 50: StatusBar: GOTO Move
END IF

IF MID$(map$(celly), cellx + 1, 1) = "d" OR MID$(map$(celly), cellx + 1, 1) = "l" THEN
CLS : cellpy = cellpy: cellpx = cellpx + 3
ViewField cellpy, cellpx: px = 50: StatusBar: GOTO Move
END IF

IF MID$(map$(celly - 1), cellx, 1) = "d" OR MID$(map$(celly - 1), cellx, 1) = "l" THEN
CLS : cellpy = cellpy - 3: cellpx = cellpx:
IF cellpy < 1 THEN NextLevel: GOTO ReplayGame
ViewField cellpy, cellpx: py = 120: StatusBar: GOTO Move
END IF

IF MID$(map$(celly), cellx - 1, 1) = "d" OR MID$(map$(celly), cellx - 1, 1) = "l" THEN
CLS : cellpy = cellpy: cellpx = cellpx - 3
ViewField cellpy, cellpx: px = 270: StatusBar: GOTO Move
END IF

IF MID$(map$(celly), cellx - 1, 1) <> "d" AND MID$(map$(celly), cellx + 1, 1) <> "d" AND MID$(map$(celly + 1), cellx, 1) <> "d" AND MID$(map$(celly - 1), cellx, 1) <> "d" THEN
PUT (px - 10, py - 10), Buffer%, PSET: GOTO Move
END IF

IF MID$(map$(celly), cellx - 1, 1) <> "l" AND MID$(map$(celly), cellx + 1, 1) <> "l" AND MID$(map$(celly + 1), cellx, 1) <> "l" AND MID$(map$(celly - 1), cellx, 1) <> "l" THEN
PUT (px - 10, py - 10), Buffer%, PSET: GOTO Move
END IF

END IF

CASE F1:
IF Ammo > 0 THEN
PUT (px - 10, py - 10), Buffer%, PSET
GET (px - 25, py - 10)-(px + 25, py + 40), Buffer%
DrawChar px, py, PlayerState, GUNDRAWN, STAND
gunx = px: guny = py: gx = gunx: gy = guny:
SightGun gx, gy:  GOTO Move
ELSE
PUT (px - 10, py - 10), Buffer%, PSET: GOTO Move
END IF

CASE CHR$(27)
IF EnemyAlive = FALSE THEN
CLS : Menu
ELSE
PUT (px - 10, py - 10), Buffer%, PSET: GOTO Move
END IF

CASE ELSE
PUT (px - 10, py - 10), Buffer%, PSET: GOTO Move

END SELECT

END SUB

SUB GetPalette (index, red, green, blue)
OUT &H3C6, &HFF
OUT &H3C7, index
red = INP(&H3C9)
green = INP(&H3C9)
blue = INP(&H3C9)

END SUB

SUB HowToOrder
SCREEN 13
CLS
SetPalette 0, 23, 0, 0

OutText 118, 5, 40, "How To Order"
OutText 119, 6, 32, "How To Order"

OutText 20, 20, 15, "Send $5 and your E-Mail Address to:"
OutText 50, 30, 15, "Mark Conner"
OutText 50, 40, 15, "4610 W 78 Terr"
OutText 50, 50, 15, "Prairie Village, KS 66208"
OutText 15, 70, 15, "You will receive all ten levels of Freedom"
OutText 15, 80, 15, "Fighter and a list of cheat codes."
OutText 15, 110, 15, "You will also be put on my mailing list for"
OutText 15, 120, 15, "further versions (or a sequel perhaps), and"
OutText 15, 130, 15, "BASIC tools to help you."
OutText 15, 150, 15, "If you have no E-Mail Address, send $10"
OutText 15, 160, 15, "to cover shipping costs for the disks."
OutText 73, 180, 40, "Press any key to continue"
OutText 74, 181, 32, "Press any key to continue"
DO: kbd$ = INKEY$: LOOP WHILE kbd$ = ""
CLS

END SUB

SUB Instructions
SCREEN 13
CLS
SetPalette 0, 23, 0, 0
OutText 118, 25, 40, "Instructions"
OutText 119, 26, 32, "Instructions"

OutText 96, 50, 14, "Keyboard Controls"

OutText 20, 80, 15, "F1": OutText 260 - LEN("DRAW") / 16, 80, 15, "DRAW"
OutText 20, 90, 15, "ENTER": OutText 260 - LEN("FIRE") / 16, 90, 15, "FIRE"
OutText 20, 100, 15, "ARROWS": OutText 260 - LEN("MOVE") / 16, 100, 15, "MOVE"
OutText 20, 110, 15, "SPACE": OutText 226 - LEN("Open Door") / 8, 110, 15, "OPEN DOOR"
OutText 20, 120, 15, "1": OutText 246 - LEN("PISTOL") / 16, 120, 15, "PISTOL"
OutText 20, 130, 15, "2": OutText 238 - LEN("SHOTGUN") / 16, 130, 15, "SHOTGUN"
OutText 20, 140, 15, "3": OutText 205 - LEN("FLAMETHROWER") / 16, 140, 15, "FLAMETHROWER"
OutText 20, 150, 15, "ESC": OutText 226 - LEN("MAIN MENU") / 16, 150, 15, "MAIN MENU"
OutText 73, 180, 40, "Press any key to continue"
OutText 74, 181, 32, "Press any key to continue"
DO: kbd$ = INKEY$: LOOP WHILE kbd$ = ""
CLS

END SUB

SUB Intro
x = 160: y = 100
SCREEN 13
LINE (0, 73)-(320, 200), FLOORCONST, BF
DrawTexture BRICK, MIDPOS, 0, 10
DrawTexture BRICK, MIDPOS, 73, 10
DrawTexture BRICK, MIDPOS, 146, 10
DrawTexture BRICK, MIDPOS, 219, 10
DrawTexture BRICK, MIDPOS, 292, 10
LINE (x - 0, y - 0)-(x - 0, y + 6), 65
LINE (x - 1, y + 5)-(x - 1, y + 7), 65
LINE (x - 2, y + 8)-(x - 5, y + 8), 65
LINE (x - 6, y + 7)-(x - 6, y + 5), 65
LINE (x - 7, y + 6)-(x - 7, y - 0), 65
LINE (x - 7, y - 0)-(x - 0, y - 1), 65
PAINT (x - 4, y + 2), 65
LINE (x + 1, y + 1)-(x + 1, y - 2), 6
LINE (x + 1, y - 2)-(x - 5, y - 2), 6
LINE (x - 6, y - 1)-(x - 7, y - 1), 6
LINE (x - 8, y - 0)-(x - 8, y + 1), 6
LINE (x + 1, y - 3)-(x - 6, y - 3), 6
LINE (x - 6, y - 2)-(x - 7, y - 2), 6
LINE (x - 8, y - 1)-(x - 8, y + 1), 6
LINE (x - 5, y + 2)-(x - 6, y + 1), 6
LINE (x - 2, y + 2)-(x - 1, y + 1), 6
LINE (x - 5, y + 3)-(x - 6, y + 3), 15
LINE (x - 2, y + 3)-(x - 1, y + 3), 15
LINE (x - 5, y + 3)-(x - 5, y + 3), 4
LINE (x - 1, y + 3)-(x - 1, y + 3), 4
LINE (x - 3, y + 6)-(x - 4, y + 6), 15
LINE (x - 4, y + 9)-(x - 3, y + 10), 64, BF
LINE (x - 5, y + 11)-(x - 2, y + 11), 40
LINE (x - 6, y + 12)-(x - 1, y + 12), 40
LINE (x - 8, y + 13)-(x - 0, y + 13), 40
LINE (x - 9, y + 14)-(x + 1, y + 18), 40, BF
LINE (x - 8, y + 19)-(x - 0, y + 30), 40, BF
LINE (x - 9, y + 19)-(x + 1, y + 23), 40, BF
LINE (x - 5, y + 24)-(x - 0, y + 26), 40, BF
LINE (x - 10, y + 15)-(x - 10, y + 19), 64
LINE (x - 10, y + 14)-(x - 12, y + 13), 64
LINE (x - 13, y + 13)-(x - 15, y + 14), 64
LINE (x - 10, y + 19)-(x - 12, y + 20), 64
LINE (x - 13, y + 20)-(x - 15, y + 19), 64
LINE (x - 16, y + 19)-(x - 19, y + 17), 64
LINE (x - 15, y + 14)-(x - 17, y + 3), 64
LINE (x - 19, y + 17)-(x - 20, y + 3), 64
LINE (x - 17, y + 3)-(x - 15, y - 0), 64
LINE (x - 15, y - 0)-(x - 16, y - 1), 64
LINE (x - 16, y - 1)-(x - 16, y - 3), 64
LINE (x - 16, y - 3)-(x - 17, y - 4), 64
LINE (x - 17, y - 4)-(x - 21, y - 4), 64
LINE (x - 21, y - 3)-(x - 21, y + 2), 64
PAINT (x - 19, y - 2), 64
LINE (x - 12, y + 20)-(x - 9, y + 20), 40
LINE (x - 12, y + 20)-(x - 9, y + 23), 40
LINE (x - 10, y + 21)-(x - 10, y + 21), 40
LINE (x + 2, y + 25)-(x + 2, y + 25), 40
LINE (x + 4, y + 23)-(x + 4, y + 23), 40
LINE (x + 4, y + 23)-(x + 3, y + 25), 40
LINE (x + 4, y + 23)-(x + 1, y + 23), 40
LINE (x + 3, y + 24)-(x + 3, y + 24), 40
LINE (x + 2, y + 24)-(x + 2, y + 24), 40
LINE (x + 2, y + 15)-(x + 6, y + 15), 64
LINE (x + 7, y + 16)-(x + 10, y + 31), 64
LINE (x + 2, y + 16)-(x + 2, y + 22), 64
LINE (x + 2, y + 23)-(x + 5, y + 23), 64
LINE (x + 5, y + 24)-(x + 4, y + 25), 64
LINE (x + 4, y + 25)-(x + 6, y + 32), 64
LINE (x + 6, y + 33)-(x + 4, y + 35), 64
LINE (x + 4, y + 35)-(x + 5, y + 36), 64
LINE (x + 6, y + 37)-(x + 7, y + 39), 64
LINE (x + 7, y + 39)-(x + 11, y + 39), 64
LINE (x + 11, y + 39)-(x + 10, y + 32), 64
PAINT (x + 8, y + 38), 64
LINE (x - 8, y + 21)-(x - 5, y + 21), 4
LINE (x - 3, y + 21)-(x - 0, y + 21), 4
LINE (x - 4, y + 19)-(x - 4, y + 23), 4
LINE (x - 4, y + 25)-(x - 4, y + 29), 4
LINE (x - 6, y + 27)-(x - 2, y + 27), 4
LINE (x - 7, y + 25)-(x - 7, y + 29), 4
LINE (x - 1, y + 25)-(x - 1, y + 29), 4
LINE (x - 7, y + 31)-(x - 1, y + 32), 65, BF
LINE (x - 8, y + 33)-(x - 0, y + 33), 32
LINE (x - 8, y + 33)-(x - 10, y + 38), 32
LINE (x - 10, y + 38)-(x - 13, y + 58), 32
LINE (x - 0, y + 34)-(x + 5, y + 32), 32
LINE (x + 5, y + 32)-(x + 4, y + 34), 32
LINE (x + 3, y + 34)-(x + 4, y + 36), 32
LINE (x + 4, y + 37)-(x + 6, y + 39), 32
LINE (x + 11, y + 30)-(x + 18, y + 28), 32
LINE (x + 18, y + 28)-(x + 19, y + 46), 32
LINE (x + 19, y + 46)-(x + 10, y + 46), 32
LINE (x + 9, y + 46)-(x + 10, y + 40), 32
LINE (x + 10, y + 40)-(x + 7, y + 40), 32
LINE (x - 13, y + 58)-(x - 5, y + 59), 32
LINE (x - 4, y + 58)-(x - 1, y + 42), 32
LINE (x - 1, y + 42)-(x + 6, y + 41), 32
PAINT (x - 5, y + 37), 32
LINE (x + 4, y + 32)-(x + 4, y + 32), 32
LINE (x + 4, y + 33)-(x + 4, y + 33), 32
LINE (x + 11, y + 30)-(x + 11, y + 34), 32
LINE (x + 12, y + 34)-(x + 12, y + 40), 32
LINE (x + 12, y + 40)-(x + 11, y + 40), 32
PAINT (x + 14, y + 42), 32
LINE (x - 8, y + 33)-(x - 11, y + 59), 1
LINE (x + 1, y + 41)-(x + 3, y + 39), 1
LINE (x + 3, y + 38)-(x + 5, y + 38), 1
LINE (x + 11, y + 40)-(x + 11, y + 46), 1
LINE (x - 11, y + 59)-(x - 7, y + 59), 6
LINE (x - 12, y + 59)-(x - 14, y + 68), 6
LINE (x - 7, y + 60)-(x - 10, y + 68), 6
LINE (x - 11, y + 69)-(x - 13, y + 69), 6
PAINT (x - 11, y + 67), 6
LINE (x + 7, y + 60)-(x + 23, y + 60), 22
LINE (x + 7, y + 60)-(x + 9, y + 55), 22
LINE (x + 9, y + 55)-(x + 13, y + 52), 22
LINE (x + 13, y + 52)-(x + 16, y + 51), 22
LINE (x + 17, y + 52)-(x + 20, y + 53), 22
LINE (x + 20, y + 54)-(x + 23, y + 56), 22
LINE (x + 24, y + 60)-(x + 23, y + 57), 22
PAINT (x + 16, y + 58), 22
LINE (x + 11, y + 47)-(x + 17, y + 47), 6
LINE (x + 11, y + 47)-(x + 11, y + 52), 6
LINE (x + 18, y + 48)-(x + 26, y + 51), 6
LINE (x + 26, y + 52)-(x + 11, y + 52), 6
PAINT (x + 16, y + 50), 6

y = 80: letter = 42
LINE (x - 68, y - 54)-(x - 52, y - 54), 32
LINE (x - 52, y - 54)-(x - 52, y - 49), 32
LINE (x - 52, y - 49)-(x - 54, y - 51), 32
LINE (x - 54, y - 51)-(x - 66, y - 51), 32
LINE (x - 66, y - 51)-(x - 66, y - 47), 32
LINE (x - 66, y - 47)-(x - 61, y - 47), 32
LINE (x - 61, y - 47)-(x - 59, y - 48), 32
LINE (x - 59, y - 48)-(x - 59, y - 44), 32
LINE (x - 60, y - 44)-(x - 61, y - 45), 32
LINE (x - 61, y - 45)-(x - 66, y - 45), 32
LINE (x - 66, y - 45)-(x - 66, y - 36), 32
LINE (x - 66, y - 36)-(x - 64, y - 35), 32
LINE (x - 64, y - 35)-(x - 69, y - 35), 32
LINE (x - 70, y - 35)-(x - 68, y - 36), 32
LINE (x - 69, y - 37)-(x - 69, y - 54), 32
PAINT (x - 68, y - 37), letter, 32
LINE (x - 46, y - 54)-(x - 46, y - 36), 32
LINE (x - 47, y - 35)-(x - 43, y - 35), 32
LINE (x - 44, y - 35)-(x - 44, y - 42), 32
LINE (x - 44, y - 42)-(x - 40, y - 42), 32
LINE (x - 40, y - 43)-(x - 39, y - 43), 32
LINE (x - 39, y - 42)-(x - 36, y - 36), 32
LINE (x - 37, y - 35)-(x - 33, y - 35), 32
LINE (x - 33, y - 35)-(x - 37, y - 44), 32
LINE (x - 36, y - 44)-(x - 34, y - 45), 32
LINE (x - 34, y - 45)-(x - 33, y - 53), 32
LINE (x - 35, y - 54)-(x - 46, y - 54), 32
LINE (x - 44, y - 52)-(x - 44, y - 46), 32
LINE (x - 44, y - 52)-(x - 37, y - 52), 32
LINE (x - 37, y - 52)-(x - 37, y - 49), 32
LINE (x - 37, y - 49)-(x - 44, y - 46), 32
LINE (x - 34, y - 54)-(x - 34, y - 54), 32
PAINT (x - 35, y - 52), letter, 32
LINE (x - 26, y - 54)-(x - 14, y - 54), 32
LINE (x - 26, y - 54)-(x - 24, y - 52), 32
LINE (x - 25, y - 52)-(x - 25, y - 36), 32
LINE (x - 27, y - 35)-(x - 14, y - 35), 32
LINE (x - 14, y - 35)-(x - 14, y - 39), 32
LINE (x - 14, y - 40)-(x - 16, y - 38), 32
LINE (x - 16, y - 38)-(x - 22, y - 38), 32
LINE (x - 23, y - 38)-(x - 23, y - 43), 32
LINE (x - 23, y - 43)-(x - 20, y - 43), 32
LINE (x - 20, y - 43)-(x - 19, y - 42), 32
LINE (x - 19, y - 42)-(x - 19, y - 45), 32
LINE (x - 20, y - 45)-(x - 22, y - 45), 32
LINE (x - 23, y - 45)-(x - 23, y - 51), 32
LINE (x - 23, y - 51)-(x - 15, y - 51), 32
LINE (x - 14, y - 54)-(x - 14, y - 50), 32
PAINT (x - 17, y - 52), letter, 32
PAINT (x - 24, y - 50), letter, 32
LINE (x - 8, y - 54)-(x + 4, y - 54), 32
LINE (x - 7, y - 53)-(x - 7, y - 36), 32
LINE (x + 4, y - 54)-(x + 4, y - 50), 32
LINE (x + 3, y - 51)-(x - 3, y - 51), 32
LINE (x - 4, y - 51)-(x - 4, y - 45), 32
LINE (x - 4, y - 45)-(x - 0, y - 45), 32
LINE (x - 0, y - 45)-(x - 0, y - 42), 32
LINE (x - 1, y - 43)-(x - 3, y - 43), 32
LINE (x - 3, y - 43)-(x - 3, y - 38), 32
LINE (x - 9, y - 35)-(x + 4, y - 35), 32
LINE (x + 4, y - 35)-(x + 4, y - 38), 32
LINE (x + 3, y - 37)-(x - 3, y - 37), 32
PAINT (x - 6, y - 37), letter, 32
LINE (x + 9, y - 35)-(x + 18, y - 35), 32
LINE (x + 10, y - 36)-(x + 10, y - 54), 32
LINE (x + 8, y - 54)-(x + 18, y - 54), 32
LINE (x + 19, y - 53)-(x + 19, y - 52), 32
LINE (x + 20, y - 52)-(x + 20, y - 36), 32
LINE (x + 19, y - 36)-(x + 19, y - 37), 32
LINE (x + 12, y - 51)-(x + 17, y - 49), 32
LINE (x + 12, y - 51)-(x + 12, y - 38), 32
LINE (x + 12, y - 38)-(x + 16, y - 38), 32
LINE (x + 16, y - 38)-(x + 17, y - 48), 32
PAINT (x + 17, y - 37), letter, 32
LINE (x + 28, y - 54)-(x + 38, y - 54), 32
LINE (x + 27, y - 53)-(x + 27, y - 52), 32
LINE (x + 26, y - 52)-(x + 26, y - 36), 32
LINE (x + 39, y - 53)-(x + 39, y - 52), 32
LINE (x + 40, y - 52)-(x + 40, y - 36), 32
LINE (x + 39, y - 35)-(x + 27, y - 35), 32
LINE (x + 29, y - 50)-(x + 36, y - 50), 32
LINE (x + 29, y - 50)-(x + 29, y - 38), 32
LINE (x + 36, y - 50)-(x + 36, y - 38), 32
LINE (x + 35, y - 39)-(x + 30, y - 38), 32
PAINT (x + 38, y - 39), letter, 32
LINE (x + 46, y - 54)-(x + 50, y - 54), 32
LINE (x + 47, y - 53)-(x + 47, y - 36), 32
LINE (x + 49, y - 53)-(x + 56, y - 43), 32
LINE (x + 45, y - 35)-(x + 50, y - 35), 32
LINE (x + 49, y - 35)-(x + 49, y - 47), 32
LINE (x + 49, y - 48)-(x + 54, y - 42), 32
LINE (x + 56, y - 44)-(x + 62, y - 53), 32
LINE (x + 60, y - 54)-(x + 66, y - 54), 32
LINE (x + 65, y - 54)-(x + 65, y - 35), 32
LINE (x + 66, y - 35)-(x + 61, y - 35), 32
LINE (x + 62, y - 36)-(x + 62, y - 48), 32
LINE (x + 62, y - 48)-(x + 58, y - 42), 32
LINE (x + 57, y - 42)-(x + 54, y - 41), 32
PAINT (x + 53, y - 45), letter, 32
PAINT (x + 58, y - 45), letter, 32
LINE (x - 69, y - 28)-(x - 52, y - 28), 32
LINE (x - 70, y - 28)-(x - 70, y - 9), 32
LINE (x - 72, y - 9)-(x - 66, y - 9), 32
LINE (x - 67, y - 9)-(x - 67, y - 18), 32
LINE (x - 67, y - 18)-(x - 62, y - 18), 32
LINE (x - 62, y - 18)-(x - 61, y - 16), 32
LINE (x - 61, y - 16)-(x - 61, y - 21), 32
LINE (x - 62, y - 20)-(x - 67, y - 20), 32
LINE (x - 67, y - 20)-(x - 67, y - 24), 32
LINE (x - 67, y - 24)-(x - 53, y - 24), 32
LINE (x - 53, y - 24)-(x - 52, y - 22), 32
LINE (x - 52, y - 22)-(x - 52, y - 27), 32
PAINT (x - 65, y - 25), letter, 32
LINE (x - 47, y - 28)-(x - 33, y - 28), 32
LINE (x - 43, y - 27)-(x - 43, y - 9), 32
LINE (x - 38, y - 27)-(x - 38, y - 9), 32
LINE (x - 48, y - 9)-(x - 33, y - 9), 32
PAINT (x - 41, y - 11), letter, 32
LINE (x - 26, y - 28)-(x - 14, y - 28), 32
LINE (x - 27, y - 27)-(x - 27, y - 26), 32
LINE (x - 28, y - 26)-(x - 28, y - 10), 32
LINE (x - 27, y - 9)-(x - 14, y - 9), 32
LINE (x - 14, y - 10)-(x - 14, y - 16), 32
LINE (x - 14, y - 17)-(x - 20, y - 17), 32
LINE (x - 21, y - 19)-(x - 21, y - 14), 32
LINE (x - 21, y - 15)-(x - 17, y - 15), 32
LINE (x - 17, y - 15)-(x - 17, y - 12), 32
LINE (x - 17, y - 12)-(x - 25, y - 12), 32
LINE (x - 25, y - 12)-(x - 25, y - 25), 32
LINE (x - 25, y - 25)-(x - 14, y - 25), 32
LINE (x - 14, y - 28)-(x - 14, y - 24), 32
PAINT (x - 16, y - 27), letter, 32
LINE (x - 9, y - 28)-(x - 5, y - 28), 32
LINE (x - 5, y - 28)-(x - 4, y - 28), 32
LINE (x - 8, y - 28)-(x - 8, y - 9), 32
LINE (x - 10, y - 9)-(x - 4, y - 9), 32
LINE (x - 5, y - 9)-(x - 5, y - 17), 32
LINE (x - 5, y - 18)-(x + 2, y - 18), 32
LINE (x + 2, y - 18)-(x + 2, y - 9), 32
LINE (x - 0, y - 9)-(x + 6, y - 9), 32
LINE (x + 5, y - 9)-(x + 5, y - 28), 32
LINE (x + 1, y - 28)-(x + 7, y - 28), 32
LINE (x + 2, y - 28)-(x + 2, y - 21), 32
LINE (x + 2, y - 21)-(x - 5, y - 21), 32
LINE (x - 5, y - 21)-(x - 5, y - 27), 32
PAINT (x - 6, y - 20), letter, 32
LINE (x + 10, y - 28)-(x + 21, y - 28), 32
LINE (x + 10, y - 27)-(x + 10, y - 24), 32
LINE (x + 10, y - 25)-(x + 14, y - 25), 32
LINE (x + 21, y - 28)-(x + 21, y - 24), 32
LINE (x + 21, y - 25)-(x + 18, y - 25), 32
LINE (x + 14, y - 25)-(x + 14, y - 9), 32
LINE (x + 17, y - 25)-(x + 17, y - 9), 32
LINE (x + 18, y - 9)-(x + 12, y - 9), 32
PAINT (x + 15, y - 11), letter, 32
LINE (x + 26, y - 28)-(x + 39, y - 28), 32
LINE (x + 27, y - 27)-(x + 27, y - 9), 32
LINE (x + 26, y - 9)-(x + 39, y - 9), 32
LINE (x + 39, y - 9)-(x + 39, y - 13), 32
LINE (x + 39, y - 12)-(x + 31, y - 12), 32
LINE (x + 31, y - 12)-(x + 31, y - 16), 32
LINE (x + 31, y - 16)-(x + 35, y - 16), 32
LINE (x + 31, y - 19)-(x + 35, y - 19), 32
LINE (x + 35, y - 20)-(x + 35, y - 15), 32
LINE (x + 31, y - 20)-(x + 31, y - 24), 32
LINE (x + 31, y - 24)-(x + 39, y - 24), 32
LINE (x + 39, y - 28)-(x + 39, y - 23), 32
PAINT (x + 28, y - 26), letter, 32
LINE (x + 46, y - 28)-(x + 46, y - 9), 32
LINE (x + 46, y - 28)-(x + 61, y - 28), 32
LINE (x + 62, y - 27)-(x + 62, y - 19), 32
LINE (x + 61, y - 19)-(x + 56, y - 19), 32
LINE (x + 45, y - 9)-(x + 50, y - 9), 32
LINE (x + 49, y - 9)-(x + 49, y - 19), 32
LINE (x + 49, y - 19)-(x + 52, y - 19), 32
LINE (x + 52, y - 19)-(x + 58, y - 9), 32
LINE (x + 56, y - 19)-(x + 61, y - 9), 32
LINE (x + 57, y - 9)-(x + 63, y - 9), 32
LINE (x + 49, y - 25)-(x + 49, y - 22), 32
LINE (x + 49, y - 25)-(x + 56, y - 25), 32
LINE (x + 49, y - 22)-(x + 56, y - 23), 32
LINE (x + 56, y - 24)-(x + 56, y - 25), 32
PAINT (x + 56, y - 22), letter, 32

OutText 97, 12, 2, "Shareware Version"
OutText 98, 13, 10, "Shareware Version"
OutText 76, 80, 32, "Idealistic Software Inc."
OutText 77, 81, 14, "Idealistic Software Inc."
OutText 73, 180, 40, "Press any key to continue"
OutText 74, 181, 32, "Press any key to continue"
DO: kbd$ = INKEY$: LOOP WHILE kbd$ = ""
CLS

END SUB

SUB LoadGame
SCREEN 13
CLS
SetPalette 0, 23, 0, 0
OutText 129, 25, 40, "Load Game"
OutText 130, 25, 32, "Load Game"

OutText 20, 50, 14, "Enter name of game to load (No .'s, \'s)"

cursor = 120

GetNameofLoadedGame:
LINE (cursor, 70)-(cursor, 80), 42

DO: kbd$ = INKEY$: LOOP WHILE kbd$ = ""
SELECT CASE kbd$
CASE IS >= SPACE:
IF LEN(file$) < 8 THEN
LINE (cursor, 70)-(cursor, 80), 0
file$ = file$ + kbd$:
OutText cursor, 71, 40, kbd$:
END IF
GOTO GetNameofLoadedGame

CASE BKSPC
IF LEN(file$) > 0 THEN
LINE (cursor, 70)-(cursor, 80), 0, BF

file$ = LEFT$(file$, LEN(file$) - 1)
OutText cursor, 71, 40, kbd$: cursor = cursor - 14
LINE (cursor, 70)-(cursor + 8, 80), 0, BF
END IF
GOTO GetNameofLoadedGame

CASE ENTER
OPEN file$ + ".SGM" FOR RANDOM AS #1
GET #1, 1, Level
GET #1, 2, NumLives
GET #1, 3, Health
GET #1, 4, Ammo
GET #1, 5, CurrWeapon
GET #1, 6, MaxWeapon
GET #1, 7, Points
GET #1, 8, PlayerState
GET #1, 9, px
GET #1, 10, py
GET #1, 11, cellpx
GET #1, 12, cellpy
GET #1, 13, UnlimitedHealth
GET #1, 14, UnlimitedAmmo
FOR a = 1 TO 19
GET #1, a + 14, map$(a)
NEXT
CLOSE #1
CLS
EXIT SUB
END SELECT

END SUB

SUB LoadLevel (Level)
OPEN "frefight.00" + LTRIM$(STR$(Level)) FOR RANDOM AS #1
FOR a = 1 TO 19
GET #1, a, map$(a)
NEXT a
CLOSE #1

END SUB

SUB Menu
DrawScreen:

SCREEN 13
SetPalette 0, 23, 0, 0
OutText 108, 25, 40, "FREEDOM FIGHTER"
OutText 109, 25, 40, "FREEDOM FIGHTER"
OutText 110, 26, 32, "FREEDOM FIGHTER"

OutText 120, 80, 44, "Play Game"
OutText 120, 90, 44, "Load Game"
OutText 120, 100, 44, "Save Game"
OutText 120, 110, 44, "Instructions"
OutText 120, 120, 44, "How To Order"
OutText 120, 130, 44, "Exit to DOS"
OutText 76, 180, 32, "Idealistic Software Inc."
OutText 77, 181, 14, "Idealistic Software Inc."

choice = 1: menuy = 80

GetChoice:
IF choice < 1 THEN menuy = 130: choice = 6
IF choice > 6 THEN menuy = 80: choice = 1

LINE (100, menuy)-(100, menuy + 8), 2
LINE (100, menuy)-(110, menuy + 4), 2
LINE (100, menuy + 8)-(110, menuy + 4), 2
PAINT (105, menuy + 4), 2

DO: kbd$ = INKEY$: LOOP WHILE kbd$ <> UP AND kbd$ <> DOWN AND kbd$ <> ENTER
SELECT CASE kbd$
CASE UP: LINE (100, menuy)-(110, menuy + 8), 0, BF:
choice = choice - 1: menuy = menuy - 10: GOTO GetChoice

CASE DOWN: LINE (100, menuy)-(110, menuy + 8), 0, BF:
choice = choice + 1: menuy = menuy + 10: GOTO GetChoice

CASE ENTER:
SELECT CASE choice
CASE 1: CLS : SetPalette 0, 0, 0, 0: GameLoop
CASE 2: LoadGame: GOTO DrawScreen
CASE 3: SaveGame: GOTO DrawScreen
CASE 4: Instructions: GOTO DrawScreen
CASE 5: HowToOrder: GOTO DrawScreen
CASE 6: SetPalette 0, 0, 0, 0: SCREEN 0: WIDTH 80, 25: SYSTEM

END SELECT
END SELECT
END SUB

SUB NextLevel
FOR a = 1 TO 19
map$(a) = ""
NEXT

cellpx = 3: cellpy = 16: px = 160: py = 100:
PlayerState = NORTH: EnemyAlive = FALSE:

CLS
SetPalette 0, 13, 0, 0
OutText 111, 90, 40, "LEVEL COMPLETE"
OutText 112, 91, 32, "LEVEL COMPLETE"
OutText 73, 180, 40, "Press any key to continue"
OutText 74, 181, 32, "Press any key to continue"
DO: kbd$ = INKEY$: LOOP WHILE kbd$ = ""
SetPalette 0, 0, 0, 0
CLS

IF Level = 3 THEN
SetPalette 0, 23, 0, 0
OutText 97, 25, 40, "Thanks for playing"
OutText 98, 26, 32, "Thanks for playing"
OutText 15, 80, 15, "This game is shareware.  It only includes"
OutText 15, 90, 15, "three levels.  Be sure to select How To"
OutText 15, 100, 15, "Order from the main menu."
OutText 73, 180, 40, "Press any key to continue"
OutText 74, 181, 32, "Press any key to continue"
DO: kbd$ = INKEY$: LOOP WHILE kbd$ = ""
CLS : SetPalette 0, 0, 0, 0
Health = 100
Ammo = 10
CurrWeapon = PISTOL
MaxWeapon = CurrWeapon
Points = 0
NumLives = 5
Level = 1

px = 160: py = 100: cellpx = 3: cellpy = 16: PlayerState = NORTH
LoadLevel 1
Menu
ELSE
Level = Level + 1: NewLevel = TRUE
LoadLevel Level: GameLoop
END IF


END SUB

SUB OutText (x, y, textcolor, text$)
FOR a = 1 TO LEN(text$)
B$ = MID$(text$, a, 1)
SELECT CASE B$
CASE "A"
LINE (x + 2, y)-(x + 2, y), textcolor
LINE (x + 1, y + 1)-(x + 1, y + 1), textcolor
LINE (x, y + 2)-(x, y + 8), textcolor
LINE (x + 3, y + 1)-(x + 3, y + 1), textcolor
LINE (x + 4, y + 2)-(x + 4, y + 8), textcolor
LINE (x, y + 4)-(x + 4, y + 4), textcolor

CASE "a"
LINE (x, y + 3)-(x, y + 3), textcolor
LINE (x + 1, y + 2)-(x + 1, y + 2), textcolor
LINE (x + 2, y + 2)-(x + 3, y + 2), textcolor
LINE (x + 4, y + 3)-(x + 4, y + 8), textcolor
LINE (x + 1, y + 5)-(x + 3, y + 5), textcolor
LINE (x, y + 6)-(x, y + 7), textcolor
LINE (x + 1, y + 8)-(x + 3, y + 8), textcolor

CASE "B"
LINE (x, y)-(x, y + 8), textcolor
LINE (x, y + 8)-(x + 3, y + 8), textcolor
LINE (x + 4, y + 5)-(x + 4, y + 7), textcolor
LINE (x + 1, y + 4)-(x + 3, y + 4), textcolor
LINE (x + 4, y + 1)-(x + 4, y + 3), textcolor
LINE (x, y)-(x + 3, y), textcolor

CASE "b"
LINE (x, y)-(x, y + 8), textcolor
LINE (x, y + 8)-(x + 3, y + 8), textcolor
LINE (x + 4, y + 5)-(x + 4, y + 7), textcolor
LINE (x + 1, y + 4)-(x + 3, y + 4), textcolor

CASE "C"
LINE (x + 1, y)-(x + 3, y), textcolor
LINE (x + 4, y + 1)-(x + 4, y + 1), textcolor
LINE (x, y + 1)-(x, y + 7), textcolor
LINE (x + 1, y + 8)-(x + 3, y + 8), textcolor
LINE (x + 4, y + 7)-(x + 4, y + 7), textcolor

CASE "c"
LINE (x + 1, y + 3)-(x + 3, y + 3), textcolor
LINE (x + 4, y + 4)-(x + 4, y + 4), textcolor
LINE (x, y + 4)-(x, y + 7), textcolor
LINE (x + 1, y + 8)-(x + 3, y + 8), textcolor
LINE (x + 4, y + 7)-(x + 4, y + 7), textcolor

CASE "D"
LINE (x, y)-(x, y + 8), textcolor
LINE (x, y + 8)-(x + 3, y + 8), textcolor
LINE (x + 4, y + 1)-(x + 4, y + 7), textcolor
LINE (x + 1, y)-(x + 3, y), textcolor

CASE "d"
LINE (x + 1, y + 3)-(x + 4, y + 3), textcolor
LINE (x, y + 4)-(x, y + 7), textcolor
LINE (x + 1, y + 8)-(x + 4, y + 8), textcolor
LINE (x + 4, y)-(x + 4, y + 8), textcolor

CASE "E"
LINE (x, y)-(x, y + 8), textcolor
LINE (x, y + 8)-(x + 4, y + 8), textcolor
LINE (x, y + 4)-(x + 2, y + 4), textcolor
LINE (x, y)-(x + 4, y), textcolor

CASE "e"
LINE (x + 1, y + 3)-(x + 3, y + 3), textcolor
LINE (x + 4, y + 4)-(x + 4, y + 5), textcolor
LINE (x, y + 4)-(x, y + 7), textcolor
LINE (x + 1, y + 8)-(x + 4, y + 8), textcolor
LINE (x + 1, y + 6)-(x + 4, y + 6), textcolor

CASE "F"
LINE (x, y)-(x, y + 8), textcolor
LINE (x, y)-(x + 4, y), textcolor
LINE (x, y + 4)-(x + 2, y + 4), textcolor

CASE "f"
LINE (x, y + 1)-(x, y + 8), textcolor
LINE (x + 1, y)-(x + 3, y), textcolor
LINE (x + 4, y + 1)-(x + 4, y + 1), textcolor
LINE (x, y + 4)-(x + 2, y + 4), textcolor

CASE "G"
LINE (x + 1, y)-(x + 3, y), textcolor
LINE (x + 4, y + 1)-(x + 4, y + 1), textcolor
LINE (x, y + 1)-(x, y + 7), textcolor
LINE (x + 1, y + 8)-(x + 3, y + 8), textcolor
LINE (x + 4, y + 5)-(x + 4, y + 7), textcolor
LINE (x + 2, y + 5)-(x + 4, y + 5), textcolor

CASE "g"
LINE (x + 1, y + 3)-(x + 4, y + 3), textcolor
LINE (x, y + 4)-(x, y + 7), textcolor
LINE (x + 1, y + 8)-(x + 4, y + 8), textcolor
LINE (x + 4, y + 3)-(x + 4, y + 10), textcolor
LINE (x + 1, y + 11)-(x + 3, y + 11), textcolor

CASE "H"
LINE (x, y)-(x, y + 8), textcolor
LINE (x + 4, y)-(x + 4, y + 8), textcolor
LINE (x + 1, y + 4)-(x + 4, y + 4), textcolor

CASE "h"
LINE (x, y)-(x, y + 8), textcolor
LINE (x, y + 4)-(x + 3, y + 4), textcolor
LINE (x + 4, y + 5)-(x + 4, y + 8), textcolor

CASE "I"
LINE (x, y)-(x + 4, y), textcolor
LINE (x + 2, y)-(x + 2, y + 8), textcolor
LINE (x, y + 8)-(x + 4, y + 8), textcolor

CASE "i"
LINE (x + 2, y + 3)-(x + 2, y + 8), textcolor
LINE (x, y + 8)-(x + 4, y + 8), textcolor
LINE (x + 2, y + 1)-(x + 2, y + 1), textcolor

CASE "J"
LINE (x, y)-(x + 4, y), textcolor
LINE (x + 2, y)-(x + 2, y + 7), textcolor
LINE (x, y + 8)-(x + 1, y + 8), textcolor
LINE (x, y + 7)-(x, y + 7), textcolor

CASE "j"
LINE (x + 2, y + 2)-(x + 2, y + 2), textcolor
LINE (x + 2, y + 4)-(x + 2, y + 8), textcolor
LINE (x, y + 9)-(x + 1, y + 9), textcolor
LINE (x - 1, y + 8)-(x - 1, y + 8), textcolor

CASE "K"
LINE (x, y)-(x, y + 8), textcolor
LINE (x, y + 4)-(x + 4, y + 8), textcolor
LINE (x + 1, y + 4)-(x + 1, y + 4), textcolor
LINE (x + 2, y + 3)-(x + 2, y + 3), textcolor
LINE (x + 3, y + 2)-(x + 3, y + 2), textcolor
LINE (x + 4, y + 1)-(x + 4, y + 1), textcolor
LINE (x + 4, y)-(x + 4, y), textcolor

CASE "k"
LINE (x, y)-(x, y + 8), textcolor
LINE (x, y + 4)-(x + 4, y + 8), textcolor
LINE (x + 1, y + 4)-(x + 1, y + 4), textcolor
LINE (x + 2, y + 3)-(x + 2, y + 3), textcolor
LINE (x + 3, y + 2)-(x + 3, y + 2), textcolor

CASE "L"
LINE (x, y)-(x, y + 8), textcolor
LINE (x, y + 8)-(x + 4, y + 8), textcolor

CASE "l"
LINE (x + 2, y)-(x + 2, y + 8), textcolor: LINE (x + 1, y + 8)-(x + 3, y + 8), textcolor
LINE (x + 1, y)-(x + 2, y), textcolor

CASE "M"
LINE (x, y)-(x, y + 8), textcolor
LINE (x, y)-(x + 2, y + 4), textcolor
LINE (x + 4, y)-(x + 4, y + 8), textcolor
LINE (x + 3, y + 3)-(x + 3, y + 3), textcolor
LINE (x + 3, y + 1)-(x + 3, y + 1), textcolor
LINE (x + 3, y + 2)-(x + 3, y + 2), textcolor

CASE "m"
LINE (x, y + 3)-(x, y + 8), textcolor
LINE (x + 1, y + 4)-(x + 1, y + 4), textcolor
LINE (x + 2, y + 5)-(x + 2, y + 6), textcolor
LINE (x + 3, y + 4)-(x + 3, y + 4), textcolor
LINE (x + 4, y + 3)-(x + 4, y + 8), textcolor

CASE "N"
LINE (x, y)-(x, y + 8), textcolor
LINE (x + 4, y)-(x + 4, y + 8), textcolor
LINE (x, y)-(x + 3, y + 8), textcolor

CASE "n"
LINE (x, y + 3)-(x, y + 8), textcolor
LINE (x + 1, y + 4)-(x + 3, y + 4), textcolor
LINE (x + 4, y + 5)-(x + 4, y + 8), textcolor

CASE "O"
LINE (x + 1, y)-(x + 3, y), textcolor
LINE (x, y + 1)-(x, y + 7), textcolor
LINE (x + 1, y + 8)-(x + 3, y + 8), textcolor
LINE (x + 4, y + 1)-(x + 4, y + 7), textcolor

CASE "o"
LINE (x + 1, y + 3)-(x + 3, y + 3), textcolor
LINE (x, y + 4)-(x, y + 7), textcolor
LINE (x + 1, y + 8)-(x + 3, y + 8), textcolor
LINE (x + 4, y + 4)-(x + 4, y + 7), textcolor

CASE "P"
LINE (x, y)-(x, y + 8), textcolor
LINE (x, y)-(x + 3, y), textcolor
LINE (x + 4, y + 1)-(x + 4, y + 3), textcolor
LINE (x + 1, y + 4)-(x + 3, y + 4), textcolor

CASE "p"
LINE (x, y + 3)-(x, y + 10), textcolor
LINE (x, y + 3)-(x + 3, y + 3), textcolor
LINE (x + 4, y + 4)-(x + 4, y + 6), textcolor
LINE (x + 1, y + 7)-(x + 3, y + 7), textcolor

CASE "Q"
LINE (x + 1, y)-(x + 3, y), textcolor
LINE (x + 4, y + 1)-(x + 4, y + 7), textcolor
LINE (x + 1, y + 8)-(x + 3, y + 8), textcolor
LINE (x, y + 1)-(x, y + 7), textcolor
LINE (x + 3, y + 9)-(x + 4, y + 9), textcolor

CASE "q"
LINE (x + 1, y + 3)-(x + 3, y + 3), textcolor
LINE (x + 4, y + 4)-(x + 4, y + 10), textcolor
LINE (x, y + 4)-(x, y + 6), textcolor
LINE (x + 1, y + 7)-(x + 3, y + 7), textcolor

CASE "R"
LINE (x, y)-(x, y + 8), textcolor
LINE (x, y)-(x + 3, y), textcolor
LINE (x + 4, y + 1)-(x + 4, y + 3), textcolor
LINE (x + 1, y + 4)-(x + 3, y + 4), textcolor
LINE (x, y + 4)-(x + 4, y + 8), textcolor

CASE "r"
LINE (x, y + 4)-(x, y + 8), textcolor
LINE (x + 1, y + 5)-(x + 1, y + 5), textcolor
LINE (x + 2, y + 4)-(x + 3, y + 4), textcolor
LINE (x + 4, y + 5)-(x + 4, y + 5), textcolor

CASE "S"
LINE (x, y + 1)-(x, y + 3), textcolor
LINE (x + 1, y)-(x + 3, y), textcolor
LINE (x + 4, y + 1)-(x + 4, y + 1), textcolor
LINE (x + 1, y + 4)-(x + 3, y + 4), textcolor
LINE (x + 4, y + 5)-(x + 4, y + 7), textcolor
LINE (x + 1, y + 8)-(x + 3, y + 8), textcolor
LINE (x, y + 7)-(x, y + 7), textcolor

CASE "s"
LINE (x + 1, y + 2)-(x + 3, y + 2), textcolor
LINE (x + 4, y + 3)-(x + 4, y + 3), textcolor
LINE (x, y + 3)-(x, y + 4), textcolor
LINE (x + 1, y + 5)-(x + 3, y + 5), textcolor
LINE (x + 4, y + 6)-(x + 4, y + 7), textcolor
LINE (x + 1, y + 8)-(x + 3, y + 8), textcolor
LINE (x, y + 7)-(x, y + 7), textcolor

CASE "T"
LINE (x, y)-(x + 4, y), textcolor: LINE (x + 2, y)-(x + 2, y + 8), textcolor

CASE "t"
LINE (x + 2, y + 2)-(x + 2, y + 8), textcolor: LINE (x + 1, y + 4)-(x + 3, y + 4), textcolor

CASE "U"
LINE (x, y + 1)-(x, y + 7), textcolor: LINE (x + 1, y + 8)-(x + 3, y + 8), textcolor
LINE (x + 4, y + 1)-(x + 4, y + 7), textcolor

CASE "u"
LINE (x, y + 3)-(x, y + 7), textcolor: LINE (x + 1, y + 8)-(x + 3, y + 8), textcolor
LINE (x + 4, y + 7)-(x + 4, y + 3), textcolor

CASE "V"
LINE (x, y)-(x + 2, y + 8), textcolor: LINE (x + 2, y + 8)-(x + 4, y), textcolor

CASE "v"
LINE (x, y + 3)-(x + 2, y + 8), textcolor: LINE (x + 2, y + 8)-(x + 4, y + 3), textcolor

CASE "W"
LINE (x, y)-(x, y + 8), textcolor
LINE (x + 4, y)-(x + 4, y + 8), textcolor
LINE (x + 1, y + 8)-(x + 1, y + 8), textcolor
LINE (x + 2, y + 7)-(x + 2, y + 7), textcolor
LINE (x + 2, y + 6)-(x + 2, y + 6), textcolor
LINE (x + 2, y + 5)-(x + 2, y + 5), textcolor
LINE (x + 3, y + 8)-(x + 3, y + 8), textcolor

CASE "w"
LINE (x, y + 3)-(x, y + 8), textcolor
LINE (x + 4, y + 3)-(x + 4, y + 8), textcolor
LINE (x + 1, y + 8)-(x + 1, y + 8), textcolor
LINE (x + 2, y + 7)-(x + 2, y + 7), textcolor
LINE (x + 2, y + 6)-(x + 2, y + 6), textcolor
LINE (x + 2, y + 5)-(x + 2, y + 5), textcolor
LINE (x + 3, y + 8)-(x + 3, y + 8), textcolor

CASE "X"
LINE (x, y)-(x + 4, y + 8), textcolor: LINE (x + 4, y)-(x, y + 8), textcolor

CASE "x"
LINE (x, y + 3)-(x + 4, y + 8), textcolor: LINE (x + 4, y + 3)-(x, y + 8), textcolor

CASE "Y"
LINE (x, y)-(x + 2, y + 3), textcolor: LINE (x + 2, y + 4)-(x + 4, y), textcolor
LINE (x + 2, y + 5)-(x + 2, y + 8), textcolor

CASE "y"
LINE (x, y + 3)-(x, y + 6), textcolor
LINE (x + 1, y + 7)-(x + 4, y + 7), textcolor
LINE (x + 4, y + 3)-(x + 4, y + 9), textcolor
LINE (x + 1, y + 10)-(x + 3, y + 10), textcolor
LINE (x, y + 9)-(x, y + 9), textcolor

CASE "Z"
LINE (x, y)-(x + 4, y), textcolor: LINE (x + 4, y)-(x, y + 8), textcolor
LINE (x, y + 8)-(x + 4, y + 8), textcolor

CASE "z"
LINE (x, y + 3)-(x + 4, y + 3), textcolor: LINE (x + 4, y + 3)-(x, y + 8), textcolor
LINE (x, y + 8)-(x + 4, y + 8), textcolor

CASE "1"
LINE (x + 2, y)-(x + 2, y + 8), textcolor: LINE (x + 1, y + 8)-(x + 3, y + 8), textcolor
LINE (x + 1, y + 1)-(x + 2, y), textcolor

CASE "2"
LINE (x - 1, y + 1)-(x - 1, y + 2), textcolor
LINE (x - 1, y + 1)-(x, y + 1), textcolor
LINE (x, y)-(x, y + 1), textcolor
LINE (x, y)-(x + 3, y), textcolor
LINE (x + 3, y)-(x + 3, y + 1), textcolor
LINE (x + 3, y + 1)-(x + 4, y + 1), textcolor
LINE (x + 4, y + 1)-(x + 4, y + 2), textcolor
LINE (x + 4, y + 2)-(x + 4, y + 3), textcolor
LINE (x + 3, y + 3)-(x + 4, y + 3), textcolor
LINE (x + 3, y + 3)-(x + 3, y + 5), textcolor
LINE (x + 2, y + 5)-(x + 3, y + 5), textcolor
LINE (x + 2, y + 5)-(x + 2, y + 6), textcolor
LINE (x + 1, y + 6)-(x + 2, y + 6), textcolor
LINE (x + 1, y + 6)-(x + 1, y + 7), textcolor
LINE (x, y + 7)-(x + 1, y + 7), textcolor
LINE (x, y + 7)-(x, y + 8), textcolor
LINE (x, y + 8)-(x + 4, y + 8), textcolor

CASE "3"
LINE (x, y)-(x + 4, y), textcolor
LINE (x + 4, y)-(x + 4, y + 1), textcolor
LINE (x + 2, y + 2)-(x + 4, y + 2), textcolor
LINE (x + 3, y + 2)-(x + 3, y + 3), textcolor
LINE (x + 1, y + 3)-(x + 3, y + 3), textcolor
LINE (x + 2, y + 4)-(x + 3, y + 4), textcolor
LINE (x + 4, y + 5)-(x + 4, y + 7), textcolor
LINE (x, y + 8)-(x + 3, y + 8), textcolor

CASE "4"
LINE (x, y)-(x, y + 4), textcolor
LINE (x, y + 4)-(x + 4, y + 4), textcolor
LINE (x + 3, y)-(x + 3, y + 8), textcolor

CASE "5"
LINE (x, y)-(x, y + 4), textcolor
LINE (x, y)-(x + 4, y), textcolor
LINE (x, y + 4)-(x + 3, y + 4), textcolor
LINE (x + 4, y + 5)-(x + 4, y + 7), textcolor
LINE (x, y + 8)-(x + 3, y + 8), textcolor

CASE "6"
LINE (x + 3, y)-(x + 4, y), textcolor
LINE (x + 3, y + 1)-(x + 3, y + 1), textcolor
LINE (x + 2, y + 1)-(x + 3, y + 1), textcolor
LINE (x + 2, y + 1)-(x + 2, y + 2), textcolor
LINE (x + 1, y + 2)-(x + 2, y + 2), textcolor
LINE (x + 1, y + 2)-(x + 1, y + 7), textcolor
LINE (x + 2, y + 8)-(x + 3, y + 8), textcolor
LINE (x + 4, y + 5)-(x + 4, y + 7), textcolor
LINE (x + 2, y + 4)-(x + 3, y + 4), textcolor

CASE "7"
LINE (x, y)-(x + 4, y), textcolor
LINE (x + 4, y)-(x + 4, y + 1), textcolor
LINE (x + 3, y + 2)-(x + 3, y + 2), textcolor
LINE (x + 2, y + 3)-(x + 2, y + 3), textcolor
LINE (x + 2, y + 4)-(x + 2, y + 5), textcolor
LINE (x + 2, y + 5)-(x + 2, y + 8), textcolor

CASE "8"
LINE (x + 1, y)-(x + 3, y), textcolor
LINE (x, y + 1)-(x, y + 3), textcolor
LINE (x + 4, y + 1)-(x + 4, y + 3), textcolor
LINE (x + 1, y + 4)-(x + 3, y + 4), textcolor
LINE (x + 4, y + 5)-(x + 4, y + 7), textcolor
LINE (x, y + 5)-(x, y + 7), textcolor
LINE (x + 1, y + 8)-(x + 3, y + 8), textcolor

CASE "9"
LINE (x + 1, y)-(x + 4, y), textcolor
LINE (x, y + 1)-(x, y + 3), textcolor
LINE (x + 1, y + 4)-(x + 4, y + 4), textcolor
LINE (x + 4, y + 1)-(x + 4, y + 6), textcolor
LINE (x + 3, y + 7)-(x + 3, y + 7), textcolor
LINE (x + 3, y + 8)-(x + 3, y + 8), textcolor

CASE "0"
LINE (x + 1, y)-(x + 3, y), textcolor
LINE (x, y + 1)-(x, y + 7), textcolor
LINE (x + 1, y + 8)-(x + 3, y + 8), textcolor
LINE (x + 4, y + 1)-(x + 4, y + 7), textcolor

CASE "%"
LINE (x, y)-(x, y), textcolor: LINE (x + 4, y)-(x, y + 8), textcolor
LINE (x + 4, y + 8)-(x + 4, y + 8), textcolor

CASE "$"
LINE (x, y + 1)-(x, y + 3), textcolor
LINE (x + 1, y)-(x + 3, y), textcolor
LINE (x + 4, y + 1)-(x + 4, y + 1), textcolor
LINE (x + 1, y + 4)-(x + 3, y + 4), textcolor
LINE (x + 4, y + 5)-(x + 4, y + 7), textcolor
LINE (x + 1, y + 8)-(x + 3, y + 8), textcolor
LINE (x, y + 7)-(x, y + 7), textcolor
LINE (x + 2, y - 1)-(x + 2, y + 9), textcolor

CASE "!"
LINE (x + 2, y)-(x + 2, y + 6), textcolor: LINE (x + 2, y + 8)-(x + 2, y + 8), textcolor

CASE ":": LINE (x + 2, y + 2)-(x + 2, y + 2), textcolor: LINE (x + 2, y + 6)-(x + 2, y + 6), textcolor

CASE ".": LINE (x + 2, y + 8)-(x + 2, y + 8), textcolor

CASE "/":
LINE (x + 4, y)-(x, y + 8), textcolor

CASE "\"
LINE (x + 4, y + 8)-(x, y), textcolor

CASE "'"
LINE (x + 2, y)-(x + 2, y + 2), textcolor

CASE ","
LINE (x + 2, y + 8)-(x + 2, y + 8), textcolor: LINE (x + 3, y + 8)-(x + 3, y + 9), textcolor

CASE "("
LINE (x, y + 2)-(x, y + 6), textcolor: LINE (x, y + 2)-(x + 2, y), textcolor: LINE (x, y + 6)-(x + 2, y + 8), textcolor

CASE ")"
LINE (x + 4, y + 2)-(x + 4, y + 6), textcolor: LINE (x + 4, y + 2)-(x + 2, y), textcolor: LINE (x + 4, y + 6)-(x + 2, y + 8), textcolor

CASE "-"
LINE (x + 4, y + 3)-(x, y + 3), textcolor
END SELECT
x = x + 7
NEXT


END SUB

SUB PlayerDie (x, y)
face = 65: hair = 6: shirt = 40: pants = 54: shoes = 210

IF GunRaise = FALSE THEN
PUT (px - 10, py - 10), Buffer%, PSET:
ELSE
PUT (px - 25, py - 10), Buffer%, PSET
END IF

CIRCLE (x, y + 30), 10, 4, , , .25: PAINT (x, y + 30), 4
LINE (x - 15, y + 25)-(x - 10, y + 28), 64, BF
LINE (x - 15, y + 25)-(x - 15, y + 28), hair
LINE (x - 16, y + 25)-(x - 16, y + 29), hair
LINE (x - 14, y + 25)-(x - 13, y + 25), hair
LINE (x - 13, y + 28)-(x - 13, y + 28), 15
LINE (x - 11, y + 28)-(x - 11, y + 28), 15
LINE (x - 9, y + 27)-(x - 9, y + 25), 65
LINE (x - 8, y + 24)-(x + 5, y + 28), shirt, BF
LINE (x - 5, y + 26)-(x - 5, y + 28), 0
LINE (x - 3, y + 26)-(x - 3, y + 28), 0
LINE (x - 5, y + 29)-(x - 4, y + 31), 65, BF
LINE (x - 11, y + 32)-(x - 4, y + 33), 65, BF
LINE (x - 5, y + 23)-(x - 4, y + 23), 65, BF
LINE (x + 6, y + 24)-(x + 11, y + 27), pants, BF
LINE (x + 9, y + 24)-(x + 12, y + 32), pants, BF
LINE (x + 12, y + 29)-(x + 19, y + 32), pants, BF
LINE (x + 12, y + 24)-(x + 26, y + 28), pants, BF
LINE (x + 19, y + 28)-(x + 14, y + 28), 0
LINE (x + 14, y + 28)-(x + 14, y + 26), 0
LINE (x + 20, y + 30)-(x + 21, y + 33), shoes, BF
LINE (x + 27, y + 25)-(x + 28, y + 29), shoes, BF
SetPalette 0, 13, 0, 0
OutText 135, 90, 40, "YOU DIE"
OutText 136, 91, 32, "YOU DIE"
OutText 73, 180, 40, "Press any key to continue"
OutText 74, 181, 32, "Press any key to continue"
DO: kbd$ = INKEY$: LOOP WHILE kbd$ = ""

NumLives = NumLives - 1: CLS :

IF NumLives > 0 THEN
px = 160: py = 100: cellpx = 3: cellpy = 16: PlayerState = NORTH:
Health = 100: Ammo = 10: CurrWeapon = PISTOL: MaxWeapon = CurrWeapon:
EnemyAlive = FALSE: Enemy = FALSE
SetPalette 0, 0, 0, 0
GameLoop
END IF

IF NumLives = 0 THEN
CLS
SetPalette 0, 13, 0, 0
OutText 129, 90, 40, "GAME OVER"
OutText 130, 91, 32, "GAME OVER"
OutText 73, 180, 40, "Press any key to continue"
OutText 74, 181, 32, "Press any key to continue"
DO: kbd$ = INKEY$: LOOP WHILE kbd$ = ""
END IF
SetPalette 0, 0, 0, 0: SCREEN 0: CLS : WIDTH 80, 25:
SYSTEM
END SUB

SUB PlayerWalk (px, py, PlayerState)
DIM WalkBuffer%(1000)
SELECT CASE PlayerState
CASE SOUTH
GET (px - 20, py - 1)-(px + 15, py + 34), WalkBuffer%
DrawChar px, py, PlayerState, ARMSDOWN, STAND
TimeDelay SPEEDCONST!
PUT (px - 20, py - 1), WalkBuffer%, PSET
py = py + 3
GET (px - 20, py - 1)-(px + 15, py + 34), WalkBuffer%
DrawChar px, py, PlayerState, ARMSDOWN, WALK1
TimeDelay SPEEDCONST!
PUT (px - 20, py - 1), WalkBuffer%, PSET
py = py + 3
GET (px - 20, py - 1)-(px + 15, py + 34), WalkBuffer%
DrawChar px, py, PlayerState, ARMSDOWN, WALK2
TimeDelay SPEEDCONST!
PUT (px - 20, py - 1), WalkBuffer%, PSET
py = py + 3
GET (px - 20, py - 1)-(px + 15, py + 34), WalkBuffer%
DrawChar px, py, PlayerState, ARMSDOWN, WALK3
TimeDelay SPEEDCONST!
PUT (px - 20, py - 1), WalkBuffer%, PSET
py = py + 3

CASE WEST
GET (px - 20, py - 1)-(px + 15, py + 34), WalkBuffer%
DrawChar px, py, PlayerState, ARMSDOWN, STAND
TimeDelay SPEEDCONST!
PUT (px - 20, py - 1), WalkBuffer%, PSET
px = px - 3
GET (px - 20, py - 1)-(px + 15, py + 34), WalkBuffer%
DrawChar px, py, PlayerState, ARMSDOWN, WALK1
TimeDelay SPEEDCONST!
PUT (px - 20, py - 1), WalkBuffer%, PSET
px = px - 3
GET (px - 20, py - 1)-(px + 15, py + 34), WalkBuffer%
DrawChar px, py, PlayerState, ARMSDOWN, WALK2
TimeDelay SPEEDCONST!
PUT (px - 20, py - 1), WalkBuffer%, PSET
px = px - 3
GET (px - 20, py - 1)-(px + 15, py + 34), WalkBuffer%
DrawChar px, py, PlayerState, ARMSDOWN, WALK3
TimeDelay SPEEDCONST!
PUT (px - 20, py - 1), WalkBuffer%, PSET
px = px - 3

CASE EAST
GET (px - 20, py - 1)-(px + 15, py + 34), WalkBuffer%
DrawChar px, py, PlayerState, ARMSDOWN, STAND
TimeDelay SPEEDCONST!
PUT (px - 20, py - 1), WalkBuffer%, PSET
px = px + 3
GET (px - 20, py - 1)-(px + 15, py + 34), WalkBuffer%
DrawChar px, py, PlayerState, ARMSDOWN, WALK1
TimeDelay SPEEDCONST!
PUT (px - 20, py - 1), WalkBuffer%, PSET
px = px + 3
GET (px - 20, py - 1)-(px + 15, py + 34), WalkBuffer%
DrawChar px, py, PlayerState, ARMSDOWN, WALK2
TimeDelay SPEEDCONST!
PUT (px - 20, py - 1), WalkBuffer%, PSET
px = px + 3
GET (px - 20, py - 1)-(px + 15, py + 34), WalkBuffer%
DrawChar px, py, PlayerState, ARMSDOWN, WALK3
TimeDelay SPEEDCONST!
PUT (px - 20, py - 1), WalkBuffer%, PSET
px = px + 3

CASE NORTH
GET (px - 20, py - 1)-(px + 15, py + 34), WalkBuffer%
DrawChar px, py, PlayerState, ARMSDOWN, STAND
TimeDelay SPEEDCONST!
PUT (px - 20, py - 1), WalkBuffer%, PSET
py = py - 3
GET (px - 20, py - 1)-(px + 15, py + 34), WalkBuffer%
DrawChar px, py, PlayerState, ARMSDOWN, WALK1
TimeDelay SPEEDCONST!
PUT (px - 20, py - 1), WalkBuffer%, PSET
py = py - 3
GET (px - 20, py - 1)-(px + 15, py + 34), WalkBuffer%
DrawChar px, py, PlayerState, ARMSDOWN, WALK2
TimeDelay SPEEDCONST!
PUT (px - 20, py - 1), WalkBuffer%, PSET
py = py - 3
GET (px - 20, py - 1)-(px + 15, py + 34), WalkBuffer%
DrawChar px, py, PlayerState, ARMSDOWN, WALK3
TimeDelay SPEEDCONST!
PUT (px - 20, py - 1), WalkBuffer%, PSET
py = py - 3
END SELECT
EXIT SUB

END SUB

SUB SaveGame
SCREEN 13
CLS
SetPalette 0, 23, 0, 0
OutText 129, 25, 40, "Save Game"
OutText 130, 25, 32, "Save Game"

OutText 20, 50, 14, "Enter name of game to save (No .'s, \'s)"

cursor = 120

GetNameofSavedGame:
LINE (cursor, 70)-(cursor, 80), 42

DO: kbd$ = INKEY$: LOOP WHILE kbd$ = ""
SELECT CASE kbd$
CASE IS >= SPACE:
IF LEN(file$) < 8 THEN
LINE (cursor, 70)-(cursor, 80), 0
file$ = file$ + kbd$:
OutText cursor, 71, 40, kbd$:
END IF
GOTO GetNameofSavedGame

CASE BKSPC
IF LEN(file$) > 0 THEN
LINE (cursor, 70)-(cursor, 80), 0, BF

file$ = LEFT$(file$, LEN(file$) - 1)
OutText cursor, 71, 40, kbd$: cursor = cursor - 14
LINE (cursor, 70)-(cursor + 8, 80), 0, BF
END IF
GOTO GetNameofSavedGame

CASE ENTER
OPEN file$ + ".SGM" FOR RANDOM AS #1
PUT #1, 1, Level
PUT #1, 2, NumLives
PUT #1, 3, Health
PUT #1, 4, Ammo
PUT #1, 5, CurrWeapon
PUT #1, 6, MaxWeapon
PUT #1, 7, Points
PUT #1, 8, PlayerState
PUT #1, 9, px
PUT #1, 10, py
PUT #1, 11, cellpx
PUT #1, 12, cellpy
PUT #1, 13, UnlimitedHealth
PUT #1, 14, UnlimitedAmmo
FOR a = 1 TO 19
PUT #1, a + 14, map$(a)
NEXT
CLOSE #1
CLS
EXIT SUB
END SELECT

END SUB

SUB SetDefaults
Health = 100
Ammo = 10
CurrWeapon = PISTOL
MaxWeapon = CurrWeapon
Points = 0
NumLives = 5
Level = 1
LoadLevel Level

px = 160: py = 100: cellpx = 3: cellpy = 16: PlayerState = NORTH

END SUB

SUB SetPalette (index, red, green, blue)
OUT &H3C6, &HFF
OUT &H3C8, index
OUT &H3C9, red
OUT &H3C9, green
OUT &H3C9, blue
END SUB

SUB SightGun (gunx, guny)
Sight:
IF Ammo < 0 THEN PUT (gunx - 5, guny - 5), Sight%, PSET: EXIT SUB

GunRaise = TRUE
GET (gunx - 5, guny - 5)-(gunx + 5, guny + 5), Sight%
CIRCLE (gunx, guny), 2, 15
LINE (gunx, guny - 3)-(gunx, guny + 3), 15
LINE (gunx - 3, guny)-(gunx + 3, guny), 15

IF EnemyAlive = TRUE THEN
IF TIMER - now! >= 1.5 THEN
CIRCLE (ex - 4, ey + 12), 2, 42: PAINT (ex - 4, ey + 12), 42
TimeDelay SPEEDCONST! / 2: PUT (ex - 6, ey + 10), EGun%, PSET
IF UnlimitedHealth = FALSE THEN Health = Health - 3: UpdateHealth: now! = TIMER
END IF
END IF

DO:
IF EnemyAlive = TRUE THEN
IF TIMER - now! >= 1.5 THEN
CIRCLE (ex - 4, ey + 12), 2, 42: PAINT (ex - 4, ey + 12), 42
TimeDelay SPEEDCONST! / 3: PUT (ex - 6, ey + 10), EGun%, PSET
IF UnlimitedHealth = FALSE THEN Health = Health - 5: UpdateHealth: now! = TIMER
END IF
END IF

kbd$ = INKEY$: LOOP WHILE kbd$ = ""
SELECT CASE kbd$
CASE RIGHT: PUT (gunx - 5, guny - 5), Sight%, PSET: gunx = gunx + 10: GOTO Sight
CASE LEFT: PUT (gunx - 5, guny - 5), Sight%, PSET: gunx = gunx - 10: GOTO Sight
CASE UP: PUT (gunx - 5, guny - 5), Sight%, PSET: guny = guny - 10: GOTO Sight
CASE DOWN: PUT (gunx - 5, guny - 5), Sight%, PSET: guny = guny + 10: GOTO Sight
CASE F1:
PUT (gunx - 5, guny - 5), Sight%, PSET:
PUT (px - 25, py - 10), Buffer%, PSET:
EXIT SUB

CASE ENTER
IF Ammo > 0 THEN FireWeapon gunx, guny, CurrWeapon:
GOTO Sight

CASE ELSE
PUT (gunx - 5, guny - 5), Sight%, PSET: GOTO Sight
END SELECT
END SUB

SUB StatusBar
face = 65: hair = 6: shirt = 40: pants = 54: shoes = 210

LINE (0, 0)-(320, 13), 7, BF
LINE (0, 0)-(320, 14), 0, B
LINE (20, 3)-(30, 11), 15, BF
LINE (20, 3)-(30, 12), 0, B
LINE (24, 5)-(26, 10), 40, BF
LINE (22, 8)-(28, 7), 40, BF
UpdateHealth

LINE (90, 3)-(92, 12), 42, BF
LINE (90, 3)-(92, 12), 0, B
LINE (90, 3)-(91, 2), 0
UpdateAmmo

UpdateWeapon

LINE (220, 3)-(222, 3), hair
LINE (220, 4)-(221, 6), face, BF
LINE (220, 7)-(221, 9), shirt, BF
LINE (220, 10)-(221, 12), pants, BF
LINE (220, 12)-(222, 12), shoes
UpdateLives

OutText 275, 3, 0, "$"
OutText 276, 3, 10, "$"
UpdatePoints
END SUB

SUB TimeDelay (clicks!)
now! = TIMER
WHILE (ABS(TIMER - now!) < clicks!): WEND
END SUB

SUB UpdateAmmo
LINE (95, 2)-(115, 12), 7, BF
OutText 95, 3, 0, LTRIM$(STR$(Ammo))
OutText 96, 3, 0, LTRIM$(STR$(Ammo))
OutText 97, 3, 54, LTRIM$(STR$(Ammo))

END SUB

SUB UpdateHealth
IF Health > 100 THEN Health = 100
LINE (32, 2)-(60, 12), 7, BF
OutText 32, 3, 0, LTRIM$(STR$(Health)) + "%"
OutText 33, 3, 0, LTRIM$(STR$(Health)) + "%"
OutText 34, 3, 54, LTRIM$(STR$(Health)) + "%"
IF Health <= 0 THEN
PlayerDie px, py
END IF

END SUB

SUB UpdateLives
LINE (225, 2)-(245, 12), 7, BF
OutText 226, 3, 0, LTRIM$(STR$(NumLives))
OutText 227, 3, 0, LTRIM$(STR$(NumLives))
OutText 228, 3, 54, LTRIM$(STR$(NumLives))
END SUB

SUB UpdatePoints
LINE (280, 2)-(320, 12), 7, BF
OutText 282, 3, 0, LTRIM$(STR$(Points))
OutText 283, 3, 0, LTRIM$(STR$(Points))
OutText 284, 3, 54, LTRIM$(STR$(Points))
END SUB

SUB UpdateWeapon
IF CurrWeapon > MaxWeapon THEN MaxWeapon = CurrWeapon
LINE (160, 3)-(195, 12), 7, BF
SELECT CASE CurrWeapon
CASE PISTOL
LINE (160, 5)-(160, 7), 0
LINE (160, 7)-(159, 7), 0
LINE (160, 5)-(162, 5), 0
LINE (162, 5)-(162, 7), 0
LINE (162, 7)-(163, 7), 0
LINE (159, 7)-(159, 12), 0
LINE (163, 7)-(163, 12), 0
LINE (163, 12)-(159, 12), 0
PAINT (161, 10), 6, 0
LINE (162, 5)-(175, 6), 0, BF
LINE (163, 4)-(175, 4), 0
LINE (175, 3)-(175, 3), 0

CASE SHOTGUN
LINE (160, 5)-(160, 7), 0
LINE (160, 7)-(159, 7), 0
LINE (160, 5)-(162, 5), 0
LINE (162, 5)-(162, 7), 0
LINE (162, 7)-(163, 7), 0
LINE (159, 7)-(159, 12), 0
LINE (163, 7)-(163, 12), 0
LINE (163, 12)-(159, 12), 0
PAINT (161, 10), 6, 0
LINE (160, 7)-(173, 5), 0, BF
LINE (160, 5)-(175, 6), 0, BF
LINE (168, 7)-(173, 6), 6, BF

CASE FLAMER
LINE (160, 6)-(175, 9), 0, BF
CIRCLE (174, 8), 1, 8
END SELECT

END SUB

SUB ViewField (cellrow, cellcol)
SCREEN 13
row = cellrow: col = cellcol: wallx = 50: wally = 10

LINE (50, 83)-(269, 83), FLOORCONST
LINE (50, 83)-(13, 157), FLOORCONST
LINE (269, 83)-(306, 157), FLOORCONST
LINE (13, 157)-(306, 157), FLOORCONST
PAINT (100, 100), FLOORCONST

DO
IF col > cellcol + 2 THEN
col = cellcol: row = row + 1
END IF

IF MID$(map$(row), col, 1) = "a" THEN
ax = (col - cellcol) * 100: ay = ((row - cellrow) * 50) + 50
DrawObject AMMOCLIP, ax, ay
col = col + 1:
END IF

IF MID$(map$(row), col, 1) = "x" THEN
xx = (col - cellcol) * 100: xy = ((row - cellrow) * 50) + 50
DrawObject EXTRALIFE, xx, xy
col = col + 1:
END IF

IF MID$(map$(row), col, 1) = "h" THEN
hx = (col - cellcol) * 100: hy = ((row - cellrow) * 50) + 50
DrawObject HEALTHBONUS, hx, hy
col = col + 1:
END IF

IF MID$(map$(row), col, 1) = "m" THEN
mx = (col - cellcol) * 100: my = ((row - cellrow) * 50) + 50
DrawObject MONEYBAG, mx, my
col = col + 1:
END IF

IF MID$(map$(row), col, 1) = "w" THEN
wx = (col - cellcol) * 100: wy = ((row - cellrow) * 50) + 50
DrawObject NEWWEAPON, wx, wy
col = col + 1:
END IF

IF MID$(map$(row), col, 1) = "e" THEN
ex = (col - cellcol) * 100: ey = ((row - cellrow) * 50) + 10
DrawEnemy ex, ey, GUARD: ecol = col: erow = row: Enemy = TRUE: EnemyAlive = TRUE
EnemyType = GUARD: MaxHits = 1: col = col + 1:
END IF

IF MID$(map$(row), col, 1) = "o" THEN
ex = (col - cellcol) * 100: ey = ((row - cellrow) * 50) + 10
DrawEnemy ex, ey, OFFICER: ecol = col: erow = row: Enemy = TRUE: EnemyAlive = TRUE
EnemyType = OFFICER: MaxHits = 3: col = col + 1:
END IF

IF MID$(map$(row), col, 1) = "g" THEN
dx = (col - cellcol) * 100: dy = ((row - cellrow) * 50) + 10
DrawDeadSoldier dx, dy, GUARD
col = col + 1:
END IF

IF MID$(map$(row), col, 1) = "j" THEN
dx = (col - cellcol) * 100: dy = ((row - cellrow) * 50) + 10
DrawDeadSoldier dx, dy, OFFICER
col = col + 1:
END IF

IF MID$(map$(row), col, 1) = "b" AND row = cellrow THEN
DrawTexture BRICK, MIDPOS, wallx, wally
wallx = wallx + 73: col = col + 1
END IF

IF MID$(map$(row), col, 1) = " " THEN
col = col + 1
END IF


IF MID$(map$(row), col, 1) = "b" AND row = cellrow + 1 AND col = cellcol THEN
wallx = 50: wally = 10
DrawTexture BRICK, LEFTPOS, wallx, wally
col = col + 1
END IF

IF MID$(map$(row), col, 1) = "b" AND row = cellrow + 1 AND col = cellcol + 3 THEN
wallx = 269: wally = 10
DrawTexture BRICK, RIGHTPOS, wallx, wally
col = col + 1
END IF

IF MID$(map$(row), col, 1) = "b" AND row = cellrow + 2 AND col = cellcol THEN
wallx = 25: wally = 58
DrawTexture BRICK, LEFTPOS, wallx, wally
col = col + 1
END IF

IF MID$(map$(row), col, 1) = "b" AND row = cellrow + 2 AND col = cellcol + 3 THEN
wallx = 294: wally = 58
DrawTexture BRICK, RIGHTPOS, wallx, wally
col = col + 1:
END IF

IF MID$(map$(row), col, 1) = "b" AND row = cellrow + 3 THEN
DrawTexture BRICK, LOWERPOS, 1 + ((col - cellcol) * 107), 158
col = col + 1:
END IF

IF MID$(map$(row), col, 1) = "s" AND row = cellrow THEN
DrawTexture STONE, MIDPOS, wallx, wally
wallx = wallx + 73: col = col + 1
END IF

IF MID$(map$(row), col, 1) = "s" AND row = cellrow + 1 AND col = cellcol THEN
wallx = 50: wally = 10
DrawTexture STONE, LEFTPOS, wallx, wally
col = col + 1
END IF

IF MID$(map$(row), col, 1) = "s" AND row = cellrow + 1 AND col = cellcol + 3 THEN
wallx = 269: wally = 10
DrawTexture STONE, RIGHTPOS, wallx, wally
col = col + 1
END IF

IF MID$(map$(row), col, 1) = "s" AND row = cellrow + 2 AND col = cellcol THEN
wallx = 25: wally = 58
DrawTexture STONE, LEFTPOS, wallx, wally
col = col + 1
END IF

IF MID$(map$(row), col, 1) = "s" AND row = cellrow + 2 AND col = cellcol + 3 THEN
wallx = 294: wally = 58
DrawTexture STONE, RIGHTPOS, wallx, wally
col = col + 1:
END IF

IF MID$(map$(row), col, 1) = "s" AND row = cellrow + 3 THEN
DrawTexture STONE, LOWERPOS, 1 + ((col - cellcol) * 107), 158
col = col + 1:
END IF

IF MID$(map$(row), col, 1) = "d" AND row = cellrow THEN
DrawDoor BRICK, MIDPOS, wallx, wally
wallx = wallx + 73: col = col + 1
END IF

IF MID$(map$(row), col, 1) = "d" AND row = cellrow + 1 AND col = cellcol THEN
wallx = 50: wally = 10
DrawDoor BRICK, LEFTPOS, wallx, wally
col = col + 1
END IF

IF MID$(map$(row), col, 1) = "d" AND row = cellrow + 1 AND col = cellcol + 3 THEN
wallx = 269: wally = 10
DrawDoor BRICK, RIGHTPOS, wallx, wally
col = col + 1
END IF

IF MID$(map$(row), col, 1) = "d" AND row = cellrow + 2 AND col = cellcol THEN
wallx = 25: wally = 58
DrawDoor BRICK, LEFTPOS, wallx, wally
col = col + 1
END IF

IF MID$(map$(row), col, 1) = "d" AND row = cellrow + 2 AND col = cellcol + 3 THEN
wallx = 294: wally = 58
DrawDoor BRICK, RIGHTPOS, wallx, wally
col = col + 1:
END IF

IF MID$(map$(row), col, 1) = "d" AND row = cellrow + 3 THEN
DrawDoor BRICK, LOWERPOS, 1 + ((col - cellcol) * 107), 158
col = col + 1:
END IF

IF MID$(map$(row), col, 1) = "l" AND row = cellrow THEN
DrawDoor STONE, MIDPOS, wallx, wally
wallx = wallx + 73: col = col + 1
END IF

IF MID$(map$(row), col, 1) = "l" AND row = cellrow + 1 AND col = cellcol THEN
wallx = 50: wally = 10
DrawDoor STONE, LEFTPOS, wallx, wally
col = col + 1
END IF

IF MID$(map$(row), col, 1) = "l" AND row = cellrow + 1 AND col = cellcol + 3 THEN
wallx = 269: wally = 10
DrawDoor STONE, RIGHTPOS, wallx, wally
col = col + 1
END IF

IF MID$(map$(row), col, 1) = "l" AND row = cellrow + 2 AND col = cellcol THEN
wallx = 25: wally = 58
DrawDoor STONE, LEFTPOS, wallx, wally
col = col + 1
END IF

IF MID$(map$(row), col, 1) = "l" AND row = cellrow + 2 AND col = cellcol + 3 THEN
wallx = 294: wally = 58
DrawDoor STONE, RIGHTPOS, wallx, wally
col = col + 1:
END IF

IF MID$(map$(row), col, 1) = "l" AND row = cellrow + 3 THEN
DrawDoor STONE, LOWERPOS, 1 + ((col - cellcol) * 107), 158
col = col + 1:
END IF


LOOP UNTIL col = cellcol + 3 AND row = cellrow + 3
END SUB

