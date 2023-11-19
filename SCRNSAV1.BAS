' This program shows animations of two objects, a sun and a galixy.
' The images were made using the Sprite graphics editor and demonstraits
' using .spr files to animate images. Distribute this program freely.
'
' Questions or comments :
' AOL - Tim Truman
' Compuserve - 74734,2203
'
' Enjoy!
'
'**                            **
'**  Select image file to use  **
'**                            **
'
'Filename$ = "galixy1.spr"
Filename$ = "sun1.spr"


DEFINT A-Z

TYPE HUES                                'type for palette
  red AS INTEGER
  grn AS INTEGER
  blu AS INTEGER
END TYPE

SCREEN 13                                'change mode

DIM Pal(255) AS HUES                     'dim array for palette
DEF SEG = VARSEG(Pal(0))                 'point to it
BLOAD "default.pal", 0                   'load the goods
OUT &H3C8, 0                             'inform vga
FOR atrib = 0 TO 255                     'entire palette
 OUT &H3C9, Pal(atrib).red               'send red component
 OUT &H3C9, Pal(atrib).grn               'send grn component
 OUT &H3C9, Pal(atrib).blu               'send blu component
NEXT atrib                               'next attribute


OPEN Filename$ FOR BINARY AS #1          'open file
filesize& = LOF(1)                       'get file size
CLOSE #1                                 'close the file


Bytes = (filesize& - 7) \ 2 - 1          'BSAVE & BLOAD use 7 bytes
DIM Images(Bytes)                        'dim the sprite array
DEF SEG = VARSEG(Images(0))              'point to it
BLOAD Filename$, 0                       'load the sprite file
Imagewidth = Images(0) \ 8               'calc Image width
Imageheight = Images(1)                  'calc Image height

ElmPerImage = ((Imagewidth * Imageheight) \ 2) + 3  'cacl elements per image
NumOfImages = Bytes / ElmPerImage                   'calc number of images

x = 120                                             'set screen location
y = 70                                              'ditto

CLS                                                 'clear the screen

'Use this loop to play images forward

DO
 FOR offset = 0 TO NumOfImages - 1
   PUT (x, y), Images(offset * ElmPerImage), PSET  'PUT image
   Time1! = TIMER                                  'sample timer
   DO: LOOP UNTIL TIMER - Time1! > .16             'delay
 NEXT
LOOP UNTIL LEN(INKEY$)

'Use this loop to play images backward

DO
 FOR offset = NumOfImages - 1 TO 0 STEP -1
   PUT (x, y), Images(offset * ElmPerImage), PSET  'PUT image
   Time1! = TIMER                                  'sample timer
   DO: LOOP UNTIL TIMER - Time1! > .16             'delay
 NEXT
LOOP UNTIL LEN(INKEY$)


WIDTH 80                               'reset screen
SCREEN 0

