REDIM Sprites(911)
SCREEN 13

DEF SEG = VARSEG(Sprites(0))
BLOAD "test.spr", 0
'SpriteEPI = ((Sprites(0) \ 8) * Sprites(1)) \ 2 + 2

PUT (x, y), Sprites, PSET






