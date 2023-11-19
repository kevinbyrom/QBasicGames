'NOTE : Max image size is 16000...which is an image 160 x 100

REDIM Sprites(911)  'make room for the image.....911 is the file size (check that in dos)

SCREEN 13           'screen 13 is vga 320 x 200 x 256

DEF SEG = VARSEG(Sprites(0))  'point to the start of the image data

BLOAD "test.spr", 0           'load the sprite

PUT (x, y), Sprites, PSET    'place the image



             


