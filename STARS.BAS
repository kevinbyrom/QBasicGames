'----------------------------------------------------------------------------
'Starfield scrolling
'----------------------------------------------------------------------------

'Basically, the trick to making the starfield look 3-D and have depth is to
'make about three different layers of stars.  Then, make the farther layer
'move slower than the closest layer.  Then to add more 3-D feel, make the
'farther layer of stars more dark than the close layer.

'Now, we come to the problem of "Flickering" when we put the stars in motion.
'The easiest way to solve this problem is to use multiple video pages for
'our animation.  This does have a down size though, because in order to use
'multiple pages we have to limit ourselves to only 16 colors (bummer! what
'game is good in 16 colors?) Basically, to use the pages properly, designate
'one page as the page you will show, and one page as the one you will draw
'on.  Draw on that page, then copy it to our visual page. 

'Now, lets look at this whole lesson in code...

SCREEN 7, 0, 1, 0  'a good enough mode that has 8 pages to work with
                   'the "1" means that we are drawing to page 1
                   'the second "0" means that we are showing page 0

CLS   'if you don't know what this is for then you don't need to be a programmer!

'Now, lets set aside variables for each of our stars, so we can keep individual track of them
'lets say that 50 stars for each layer is good

REDIM FarLayer(50)
REDIM MidLayer(50)
REDIM CloseLayer(50)

'Lets allocate memory for the stars positions

REDIM FarLayerX(50)
REDIM MidLayerX(50)
REDIM CloseLayerX(50)
REDIM FarLayerY(50)
REDIM MidLayerY(50)
REDIM CloseLayerY(50)


'Now that we set aside memory for the layers, lets give them attributes.

'Lets assign their locations randomly

FOR i = 1 TO 50  'We work will each star in order
    FarLayerX(i) = INT(320 * RND) + 1     '320 because this mode is 320 x 200 x 16
    MidLayerX(i) = INT(320 * RND) + 1     '320 because this mode is 320 x 200 x 16
    CloseLayerX(i) = INT(320 * RND) + 1   '320 because this mode is 320 x 200 x 16

    FarLayerY(i) = INT(320 * RND) + 1     '200 because this mode is 320 x 200 x 16
    MidLayerY(i) = INT(320 * RND) + 1     '200 because this mode is 320 x 200 x 16
    CloseLayerY(i) = INT(320 * RND) + 1   '200 because this mode is 320 x 200 x 16
NEXT

'Okay, now we are ready to rock and get on with the main part of the program

DO                     'start the MAIN loop

'lets draw the stars to page 1

FOR i = 1 TO 50             'Do all the stars
    PSET (FarLayerX(i), FarLayerY(i)), 8       'place the far star with a dark gray
    PSET (MidLayerX(i), MidLayerY(i)), 7       'place the mid star with a mid gray
    PSET (CloseLayerX(i), CloseLayerY(i)), 15  'place the close star with white
NEXT

PCOPY 1, 0    'now we move what we drew in page 1 to our visual page

CLS     'This will only clear page 1, so we have a clean page every time

'Now to keep the loop in constant, we need to pre-move the stars before we draw again
'remember, move the far stars slower than the close ones

FOR i = 1 TO 50             'Again, work with all stars
    FarLayerX(i) = FarLayerX(i) + 1      'moving REAL slow
    MidLayerX(i) = MidLayerX(i) + 2      'moving faster
    CloseLayerX(i) = CloseLayerX(i) + 4  'moving FASTEST

    FarLayerY(i) = FarLayerY(i) + 1      'moving REAL slow
    MidLayerY(i) = MidLayerY(i) + 2      'moving faster
    CloseLayerY(i) = CloseLayerY(i) + 4  'moving FASTEST
NEXT

'Okay, our final problem is making sure that all the stars remain on the screen
'we will fix this by checking each star, if they are off screen, we just put it
'back on the screen like as if the screen was a sphere

'If you are confused....don't worry, you will see what I mean

FOR i = 1 TO 50            'Hmm, what are we doing again?
    IF FarLayerX(i) > 320 THEN FarLayerX(i) = FarLayerX(i) - 320         'make it wrap around the screen
    IF MidLayerX(i) > 320 THEN MidLayerX(i) = MidLayerX(i) - 320         'make it wrap around the screen
    IF CloseLayerX(i) > 320 THEN CloseLayerX(i) = CloseLayerX(i) - 320   'make it wrap around the screen

    IF FarLayerY(i) > 200 THEN FarLayerY(i) = FarLayerY(i) - 200         'make it wrap around the screen
    IF MidLayerY(i) > 200 THEN MidLayerY(i) = MidLayerY(i) - 200         'make it wrap around the screen
    IF CloseLayerY(i) > 200 THEN CloseLayerY(i) = CloseLayerY(i) - 200   'make it wrap around the screen
NEXT

'Now we are done! It will loop until a key is pressed

LOOP UNTIL INKEY$ <> ""


 

