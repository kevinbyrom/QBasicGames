' ** IMG-EDIT.BAS
' ** 1993 Fred Sexton Jr.
' ** Requires: QBasic Extender TSR
' **
DEFINT A-Z                                       'default type = integer

TYPE Hues                                        'define the type for hues
    red AS INTEGER                               'red component
  green AS INTEGER                               'green component
   blue AS INTEGER                               'blue component
END TYPE
DECLARE FUNCTION QBEX (ExtNum)                   'TSR interface
DECLARE SUB CalcImageData ()                     'SUB to calc image data
DECLARE SUB ChangeColors (mode)                  'SUB to change colors
DECLARE SUB CombineSprites (mode)                'SUB to combine sprites
DECLARE SUB DisplayMsg (msg$)                    'SUB to display messages
DECLARE SUB DrawBorder ()                        'SUB to draw the border
DECLARE SUB EditSprite ()                        'SUB to edit images
DECLARE SUB FlipImage ()                         'SUB to flip images
DECLARE SUB GetFileList ()                       'SUB to get file list
DECLARE SUB GPWorkSprite (mode)                  'SUB to get/put all images
DECLARE SUB MilliDelay (msecs)                   'SUB to create delays
DECLARE SUB MirrorImage ()                       'SUB to mirror image
DECLARE SUB SetColors (pal() AS Hues, fc, lc)    'SUB to modify palette
DECLARE SUB SetupSpriteArrays ()                 'SUB redim arrays
DECLARE SUB WaitLetGo ()                         'SUB to give user time
DECLARE FUNCTION GetKeyMask ()                   'FUNCTION to handle keyboard
DECLARE FUNCTION InPutFileName$ ()               'FUNCTION to get a file name
DECLARE FUNCTION InPutNumber (ask$, min, max)    'FUNCTION to input number
DECLARE FUNCTION PullDown (menu$(), dpick)       'FUNCTION for menus
DECLARE FUNCTION SelectColor (mode, defclr)      'FUNCTION to pick color

'---------- define the variables used by the Extender TSR ----------
COMMON SHARED ExtKeyOfs, ExtKeySeg
COMMON SHARED MouseLeft, MouseRight, MouseX, MouseY
COMMON SHARED MinMX, MaxMX, MinMY, MaxMY
COMMON SHARED FileName$, FileSize&, FileSpec$, FileList$()
'-------------------------------------------------------------------
COMMON SHARED ImageWidth, Ximages, Xstart, Xstep, Xend, Xmax
COMMON SHARED ImageHeight, Yimages, Ystart, Ystep, Yend, Ymax
COMMON SHARED MaxImages, ElmPerImage, TotalElms
COMMON SHARED ZoomFact, ZoomSX, ZoomSY, ix, iy, mix, miy
COMMON SHARED ClipBoard(), UndoClipBoard(), WorkSprite()
COMMON SHARED CursorClr, CurrentClr
CONST null$ = "", SelClr$ = "Select New Color"

IF NOT QBEX(0) THEN                              'verify presence of TSR
   PRINT "QBasic Extender TSR not found"
   END
END IF
IF NOT QBEX(1) THEN                              'verify presence of mouse
   PRINT "Mouse not found"
   END
END IF

SCREEN 13                                        '320x200  w/256 colors

REDIM Mainmenu$(1 TO 5)                          'array for main menu
Mainmenu$(1) = "New"                             'assign menu text
Mainmenu$(2) = "Load"
Mainmenu$(3) = "Save"
Mainmenu$(4) = "Setup"
Mainmenu$(5) = "Exit"

REDIM EditMenu$(1 TO 11)                         'array for edit menu
EditMenu$(1) = "Undo"                            'assign menu text
EditMenu$(2) = "Cut"
EditMenu$(3) = "Copy"
EditMenu$(4) = "Paste"
EditMenu$(5) = "Edit"
EditMenu$(6) = "Mirror"
EditMenu$(7) = "Flip"
EditMenu$(8) = "Colors"
EditMenu$(9) = "Arrange"
EditMenu$(10) = "Adjust X"
EditMenu$(11) = "Adjust Y"

REDIM PasteMenu$(1 TO 4)                         'array for paste menu
PasteMenu$(1) = "Pset"                           'assign menu text
PasteMenu$(2) = "In Front"
PasteMenu$(3) = "Behind"
PasteMenu$(4) = "Xor"

REDIM CCMenu$(1 TO 3)                            'array for change color menu
CCMenu$(1) = "Reassign"                          'assign menu text
CCMenu$(2) = "Lighten"
CCMenu$(3) = "Darken"

REDIM SetupMenu$(1 TO 5)                         'array for setup menu
SetupMenu$(1) = "Palette"                        'assign menu text
SetupMenu$(2) = "Image Size"
SetupMenu$(3) = "Cursor Color"
SetupMenu$(4) = "BackGround"
SetupMenu$(5) = "Save Settings"

REDIM TorFmenu$(1 TO 2)                          'array for T/F menu

OPEN "IMG-EDIT.CFG" FOR INPUT AS #1              'open configuration file
INPUT #1, dPal$, DefWidth, DefHeight, CursorClr, BGHue     'read the defaults
CLOSE #1                                         'close file

REDIM pal(255) AS Hues                           'array for palette
DEF SEG = VARSEG(pal(0))                         'point to it
BLOAD dPal$, 0                                   'load from file
pal(0).red = BGHue                               'set to default
pal(0).green = BGHue                             'set to default
pal(0).blue = BGHue                              'set to default
SetColors pal(), 0, 255                          'set system colors

ImageWidth = DefWidth                            'set to default
ImageHeight = DefHeight                          'set to default
CalcImageData                                    'calc all the data
DrawBorder                                       'draw the border
SetupSpriteArrays                                'redim the arrays

CurrentClr = 1                                   'initial color
arrange$ = "Select Images In Order"              'set up for later
MaxMX = 319: MaxMY = 199                         'full screen

z = QBEX(5)                                      'mouse cursor on
DO                                               'start main loop
   z = QBEX(2)                                   'get button status
   z = QBEX(3)                                   'get mouse position
   IF MouseRight THEN                            'right click
      IF lemPick = 9 THEN lemPick = 1            'for edit menu - no undo
      mmPick = PullDown(Mainmenu$(), lmmPick)    'main menu
      SELECT CASE mmPick                         'what do they want?
      CASE 1                                     'new
         ImageWidth = DefWidth                   'set to default
         ImageHeight = DefHeight                 'set to default
         CalcImageData                           'recalc all the data
         z = QBEX(6)                             'mouse cursor off
         CLS                                     'clear screen
         DrawBorder                              'draw the border
         z = QBEX(5)                             'mouse cursor on
         SetupSpriteArrays                       'redim the arrays
      CASE 2                                     'load
         FileSpec$ = "*.spr"                     'sprite files
         GetFileList                             'get all the file names
         IF UBOUND(FileList$) > 1 THEN           'find any?
            listelm = PullDown(FileList$(), 1)   'let 'em pick
         ELSE
            listelm = 0                          'no sprites exist
         END IF
         IF listelm THEN                         'did they pick one?
            FileName$ = FileList$(listelm)       'which one?
            z = QBEX(9)                          'exist/size function
            ldelm = (FileSize& - 7) \ 2 - 1      'BSAVE & BLOAD use 7 bytes
            REDIM loadspr(ldelm)                 'redim the sprite array
            DEF SEG = VARSEG(loadspr(0))         'point to it
            BLOAD FileName$, 0                   'load the sprite file
            LoadWidth = loadspr(0) \ 8           'get image width
            LoadHeight = loadspr(1)              'get image height
            cs = 0                               'assume clearing
            IF (LoadWidth = ImageWidth) AND (LoadHeight = ImageHeight) THEN
               TorFmenu$(1) = "Clear First"      'assign menu text
               TorFmenu$(2) = "Don't Clear"      'ditto
               cs = PullDown(TorFmenu$(), 1) - 1 'ask 'em
            ELSE
               ImageWidth = LoadWidth            'set image width
               ImageHeight = LoadHeight          'set image height
               CalcImageData                     'recalc all the data
               SetupSpriteArrays                 'redim the arrays
            END IF
            z = QBEX(6)                          'mouse cursor off
            IF cs = 0 THEN                       'check clear flag
               CLS                               'clear the screen
               DrawBorder                        'draw the border
            END IF
            x = Xstart + 1: mx = Xend + 1: y = Ystart + 1  'image location
            ofs = 0                              'first image is at 0
            DO
               PUT (x, y), loadspr(ofs), PSET    'display image
               x = x + Xstep                     'adjust location
               IF x > mx THEN                    'end of row?
                  x = Xstart + 1                 'restart
                  y = y + Xstep                  'move down
               END IF
               ofs = ofs + ElmPerImage           'point to next image
            LOOP WHILE ofs < ldelm               'do all the images
            z = QBEX(5)                          'mouse cursor on
            ERASE loadspr                        'done with array
         END IF

      CASE 3                                     'save
         z = QBEX(6)                             'mouse cursor off
         GPWorkSprite 0                          'GET all images
         maxworkX = Xend + Xstep                 'right edge
         maxworkY = Yend + Ystep                 'bottom edge
         lwx = -1: lwy = lwx                     'so <> on first iteration
         MouseX = Xstart + ImageWidth            'first image
         MouseY = Ystart + ImageHeigth           'first image
         z = QBEX(4)                             'set mouse location
         DO                                      'select images loop
            z = QBEX(2)                          'get button status
            z = QBEX(3)                          'get mouse location
            ximg = (MouseX - Xstart) \ Xstep     '# of X images
            yimg = (MouseY - Ystart) \ Ystep     '# of Y images
            workX = (ximg + 1) * Xstep + Xstart  'outline corner
            workY = (yimg + 1) * Ystep + Ystart  'outline corner
            IF workX > maxworkX THEN workX = maxworkX      'has to fit
            IF workY > maxworkY THEN workY = maxworkY      'has to fit
            IF workX <> lwx OR workY <> lwy THEN 'has it moved?
               DrawBorder                        'erase last outline
               LINE (Xstart, Ystart)-(Xstart, workY), 32   'common line
               LINE (Xstart, workY)-(workX, workY), 32     'common line
               IF yimg THEN                                'more than 1 row?
                  workY2 = workY - Ystep                   'top of split row
                  LINE (Xstart, Ystart)-(maxworkX, Ystart), 32  'do the rest
                  LINE (workX, workY2)-(maxworkX, workY2), 32   'ditto
                  LINE (workX, workY2)-(workX, workY), 32       'ditto
                  LINE (maxworkX, Ystart)-(maxworkX, workY2), 32 'ditto
               ELSE                                        'only 1 row
                  LINE (Xstart, Ystart)-(workX, Ystart), 32     'do the rest
                  LINE (workX, Ystart)-(workX, workY), 32       'ditto
               END IF
               lwx = workX: lwy = workY          'for next time
            END IF
         LOOP UNTIL MouseLeft                    'wait for a left click
         DrawBorder                              'erase last outline
         WaitLetGo                               'wait for 'em to let go
         images = (yimg * Ximages) + ximg + 1    'image total
         IF images > MaxImages THEN images = MaxImages     'enforce max
         Bytes& = CLNG(images) * CLNG(ElmPerImage) * 2&    'calc bytes
         sure = -1                               'assume ok
         FileName$ = InPutFileName$              'get the name
         z = QBEX(5)                             'mouse cursor on
         IF LEN(FileName$) THEN                  'legit?
            FileName$ = FileName$ + ".SPR"       'add extension
            IF QBEX(9) THEN                      'see if it exists
               TorFmenu$(1) = "Cancel"           'assign menu text
               TorFmenu$(2) = "OverWrite"        'ditto
               sure = PullDown(TorFmenu$(), 1) - 1    'ask if ok to overwrite
            END IF
            IF sure THEN                         'ok to save
               DEF SEG = VARSEG(WorkSprite(0))   'point to array
               BSAVE FileName$, 0, Bytes&        'save it
            END IF
         END IF

      CASE 4                                     'setup
         smPick = PullDown(SetupMenu$(), lsmPick) 'setup menu
         SELECT CASE smPick                      'what do they want?
         CASE 1                                  'palette
            FileSpec$ = "*.PAL"                  'palette files
            GetFileList                          'get all the file names
            listelm = PullDown(FileList$(), 1)   'let 'em pick
            IF listelm THEN                      'did they pick one?
               dPal$ = FileList$(listelm)        'which one?
               DEF SEG = VARSEG(pal(0))          'point to palette array
               BLOAD dPal$, 0                    'load from file
            END IF
         CASE 2                                  'Image size
            DefWidth = InPutNumber("Default Width?", 10, 160)    'get width
            DefHeight = InPutNumber("Default Height?", 10, 100)  'get height
         CASE 3                                  'Cursor Color
            z = QBEX(6)                          'mouse cursor off
            DisplayMsg SelClr$                   'tell 'em what to do
            CursorClr = SelectColor(1, CursorClr)     'let 'em pick
            DisplayMsg null$                     'erase message
            z = QBEX(5)                          'mouse cursor on
         CASE 4                                  'BackGround
            BGHue = InPutNumber("BackGround Intensity?", 0, 63)  'get hue
         CASE 5                                  'Save Settings
            OPEN "IMG-EDIT.CFG" FOR OUTPUT AS #1 'open configuration file
            WRITE #1, dPal$, DefWidth, DefHeight, CursorClr, BGHue 'write 'em
            CLOSE #1                             'close file
         END SELECT
         lsmPick = smPick                        'for next time
         pal(0).red = BGHue                      'might've changed
         pal(0).green = BGHue                    'might've changed
         pal(0).blue = BGHue                     'might've changed
         SetColors pal(), 0, 255                 'set system colors

      CASE 5                                     'exit
         TorFmenu$(1) = "Save First!"            'assign menu text
         TorFmenu$(2) = "Exit"                   'ditto
         IF (PullDown(TorFmenu$(), 1) - 1) THEN EXIT DO    'outta here
      END SELECT
      lmmPick = mmPick                           'for next time

   ELSEIF MouseLeft THEN                         'left click
      IF MouseX > Xmax THEN MouseX = Xmax        'enforce max
      IF MouseY > Ymax THEN MouseY = Ymax        'ditto
      workX = (((MouseX - Xstart) \ Xstep) * Xstep) + Xstart  'outline corner
      workY = (((MouseY - Ystart) \ Ystep) * Ystep) + Ystart  'outline corner

      ix = workX + 1: mix = workX + ImageWidth   'image corner
      iy = workY + 1: miy = workY + ImageHeight  'image corner
      z = QBEX(6)                                'mouse cursor off
      LINE (workX, workY)-(workX + Xstep, workY + Ystep), 32, B 'outline it
      z = QBEX(5)                                'mouse cursor on
      emPick = PullDown(EditMenu$(), emPick)     'editing menu
      z = QBEX(6)                                'mouse cursor off
      SELECT CASE emPick                         'what do they want?
      CASE 1                                     'undo
         IF lemPick = 9 THEN                     'arrange was last op
            GPWorkSprite 1                       'put 'em back
         ELSE                                    'all other op-s
            IF lix THEN PUT (lix, liy), UndoClipBoard, PSET     'put it back
         END IF

      CASE 2                                     'cut
         GET (ix, iy)-(mix, miy), ClipBoard      'copy it
         GET (ix, iy)-(mix, miy), UndoClipBoard  'so they can undo
         lix = ix: liy = iy                      'ditto
         PUT (ix, iy), ClipBoard                 'cut it

      CASE 3                                     'copy
         GET (ix, iy)-(mix, miy), ClipBoard      'copy it

      CASE 4                                     'paste
         GET (ix, iy)-(mix, miy), UndoClipBoard  'so they can undo
         lix = ix: liy = iy                      'ditto
         z = QBEX(5)                             'mouse cursor on
         mode = PullDown(PasteMenu$(), lpmode)   'paste method?
         lpmode = mode                           'for next time
         z = QBEX(6)                             'mouse cursor off
         IF mode THEN                            'still want to?
            CombineSprites mode                  'combine 'em
         END IF

      CASE 5                                     'edit
         GET (ix, iy)-(mix, miy), UndoClipBoard  'so they can undo
         lix = ix: liy = iy                      'ditto
         EditSprite                              'call the editor

      CASE 6                                     'Mirror
         GET (ix, iy)-(mix, miy), UndoClipBoard  'so they can undo
         lix = ix: liy = iy                      'ditto
         MirrorImage                             'call mirror sub

      CASE 7                                     'Flip
         GET (ix, iy)-(mix, miy), UndoClipBoard  'so they can undo
         lix = ix: liy = iy                      'ditto
         FlipImage                               'call flip sub

      CASE 8                                     'Colors
         GET (ix, iy)-(mix, miy), UndoClipBoard  'so they can undo
         lix = ix: liy = iy                      'ditto
         z = QBEX(5)                             'mouse cursor on
         mode = PullDown(CCMenu$(), 1)           'change color menu
         z = QBEX(6)                             'mouse cursor off
         IF mode THEN                            'still want to?
            ChangeColors mode                    'call change color sub
         END IF

      CASE 9                                     'Arrange
         LINE (workX, workY)-(workX + Xstep, workY + Ystep), 7, B
         GPWorkSprite 0                          'so they can undo
         wrkelms = ElmPerImage - 1               'setup once
         REDIM work1(wrkelms)                    'create two arrays
         REDIM work2(wrkelms)
         OldImg = 0                              'upper left image is 0
         DisplayMsg arrange$                     'tell 'em what to do
         lbx = Xstart: lby = Ystart              'for dest- outline
         by = lby                                'ditto
         LINE (lbx, lby)-(lbx + Xstep, lby + Ystep), 32, B 'dest- outline
         z = QBEX(5)                             'mouse cursor on

         DO                                      'arrange loop
            z = QBEX(2)                          'get button status
            z = QBEX(3)                          'set mouse location
            IF MouseLeft THEN                    'left click
                                      '** calc source and dest- image corners
               OldImgX = ((MouseX - Xstart) \ Xstep) * Xstep + Xstart + 1
               MaxOldImgX = OldImgX + ImageWidth - 1
               OldImgY = ((MouseY - Ystart) \ Ystep) * Ystep + Ystart + 1
               MaxOldImgY = OldImgY + ImageHeight - 1
               NxtImgX = (OldImg MOD Ximages) * Xstep + Xstart + 1
               MaxNxtImgX = NxtImgX + ImageWidth - 1
               NxtImgY = (OldImg \ Ximages) * Ystep + Ystart + 1
               MaxNxtImgY = NxtImgY + ImageHeight - 1
               bx = lbx + Xstep                  'for next dest- outline
               IF bx > Xend THEN                 'ditto
                  bx = Xstart                    'ditto
                  by = by + Ystep                'ditto
               END IF
               z = QBEX(6)                       'mouse cursor off
               DisplayMsg null$                  'erase message
               GET (NxtImgX, NxtImgY)-(MaxNxtImgX, MaxNxtImgY), work1 'get it
               GET (OldImgX, OldImgY)-(MaxOldImgX, MaxOldImgY), work2 'get it
               PUT (NxtImgX, NxtImgY), work2, PSET              'put it
               PUT (OldImgX, OldImgY), work1, PSET              'put it
               LINE (lbx, lby)-(lbx + Xstep, lby + Ystep), 7, B 'erase last
               LINE (bx, by)-(bx + Xstep, by + Ystep), 32, B    'new outline
               DisplayMsg arrange$               'tell 'em what to do
               z = QBEX(5)                       'mouse cursor on
               lbx = bx: lby = by                'for next time
               OldImg = OldImg + 1               'ditto
               IF OldImg > MaxImages THEN EXIT DO     'all done?
               WaitLetGo                         'wait 'til they let go
            END IF
         LOOP UNTIL GetKeyMask OR MouseRight     'wait for key or right click
         z = QBEX(6)                             'mouse cursor off
         DisplayMsg null$                        'erase message
         LINE (lbx, lby)-(lbx + Xstep, lby + Ystep), 7, B 'erase last
         ERASE work1, work2                      'done with arrays

      CASE 10                                    'adjust X
         GET (ix, iy)-(mix, miy), UndoClipBoard  'so they can undo
         lix = ix: liy = iy                      'ditto
         mv = InPutNumber("X shift?", -10, 10)   'get shift
         REDIM work(UBOUND(UndoClipBoard))       'work array
         IF mv < 0 THEN                          'moving left
            amv = ABS(mv)                        'absolute value
            GET (ix + amv, iy)-(mix, miy), work  'get piece
            LINE (ix, iy)-(mix, miy), 0, BF      'clear area
            PUT (ix, iy), work                   'move it
         ELSE                                    'moving right
            GET (ix, iy)-(mix - mv, miy), work   'get piece
            LINE (ix, iy)-(mix, miy), 0, BF      'clear area
            PUT (ix + mv, iy), work              'move it
         END IF
         ERASE work                              'done with it

      CASE 11                                    'adjust Y
         GET (ix, iy)-(mix, miy), UndoClipBoard  'so they can undo
         lix = ix: liy = iy                      'ditto
         mv = InPutNumber("Y shift?", -10, 10)   'get shift
         REDIM work(UBOUND(UndoClipBoard))
         IF mv < 0 THEN                          'moving up
            amv = ABS(mv)
            GET (ix, iy + amv)-(mix, miy), work  'get piece
            LINE (ix, iy)-(mix, miy), 0, BF      'clear area
            PUT (ix, iy), work                   'move it
         ELSE                                    'moving down
            GET (ix, iy)-(mix, miy - mv), work   'get piece
            LINE (ix, iy)-(mix, miy), 0, BF      'clear area
            PUT (ix, iy + mv), work              'move it
         END IF
         ERASE work                              'done with it

      END SELECT
      lemPick = emPick                           'for next time
      LINE (workX, workY)-(workX + Xstep, workY + Ystep), 7, B  'erase last
      z = QBEX(5)                                'mouse cursor on
   END IF

LOOP                                             'end of main loop
z = QBEX(6)                                      'mouse cursor on

END

SUB CalcImageData

   Xstep = ImageWidth + 1                        'width of border box
   Ximages = 319 \ Xstep                         'calc how many fit
   Xstart = (319 MOD Xstep) \ 2                  'center on screen
   Xend = ImageWidth * (Ximages - 1) + Ximages + Xstart - 1     'last box
   Xmax = Xend + ImageWidth
   Ystep = ImageHeight + 1                       'width of border box
   Yimages = 199 \ Ystep                         'calc how many fit
   Ystart = (199 MOD Ystep) \ 2                  'center on screen
   Yend = ImageHeight * (Yimages - 1) + Yimages + Ystart - 1    'last box
   Ymax = Yend + ImageHeight

   MaxImages = Ximages * Yimages                 'calc total images
   ElmPerImage = (ImageWidth * ImageHeight) \ 2 + 2   'elements in one image
   TotalElms = ElmPerImage * MaxImages           'calc total elements

   xfact = 320 \ ImageWidth                      'x axis zoom factor
   yfact = 200 \ ImageHeight                     'y axis zoom factor
   IF xfact < yfact THEN ZoomFact = xfact ELSE ZoomFact = yfact 'zoom evenly
   ZoomSX = (320 - (ImageWidth * ZoomFact)) \ 2  'center on screen
   ZoomSY = (200 - (ImageHeight * ZoomFact)) \ 2 'center on screen

END SUB

SUB ChangeColors (mode)

   ubd = UBOUND(UndoClipBoard)                   'get size
   REDIM work(ubd)                               'work array
   GET (ix, iy)-(mix, miy), work                 'get the image
   DisplayMsg "Select Group to Change"           'tell 'em what to do
   fc = SelectColor(0, 0)                        'let 'em pick
   lc = fc + 15                                  'calc last color
   DisplayMsg null$                              'erase message
   SELECT CASE mode
   CASE 1                                        'reassign
      DisplayMsg "Select New Group"              'tell 'em what to do
      cav = SelectColor(0, 0) - fc               'adjust value
      DisplayMsg null$                           'erase message
   CASE 2                                        'lighten
      fc = fc + 1                                'stay in group
      cav = -1
   CASE 3                                        'darken
      lc = lc - 1                                'stay in group
      cav = 1                                    'adjust value
   END SELECT

   DEF SEG = VARSEG(work(0))                     'point to work array
   ofs = 4                                       'skip image size data
   FOR y = 1 TO ImageHeight                      'top to bottom
      FOR x = 1 TO ImageWidth                    'left to right
         dat = PEEK(ofs)                         'get color
         IF dat >= fc AND dat <= lc THEN         'in range?
            dat = dat + cav                      'adjust
            POKE ofs, dat                        'replace it
         END IF
         ofs = ofs + 1                           'next one
      NEXT
   NEXT
   PUT (ix, iy), work, PSET                      'update screen

END SUB

SUB CombineSprites (mode)

   ubd = UBOUND(ClipBoard)                       'get size
   REDIM work(ubd)                               'work array
   GET (ix, iy)-(mix, miy), work                 'get the image
   Sseg = VARSEG(ClipBoard(0))                   'source segment
   Dseg = VARSEG(work(0))                        'dest- segment
   sofs = 4: dofs = 4                            'starting offsets

   SELECT CASE mode
      CASE 1                                     'pset
         PUT (ix, iy), ClipBoard, PSET           'display it
         
      CASE 2                                     'in front
         FOR y = 1 TO ImageHeight                'top to bottom
            FOR x = 1 TO ImageWidth              'left to right
               DEF SEG = Sseg
               dat = PEEK(sofs)                  'check source color
               IF dat THEN                       'non 0?
                  DEF SEG = Dseg
                  POKE dofs, dat                 'update work image
               END IF
               sofs = sofs + 1: dofs = dofs + 1  'adjust
            NEXT
         NEXT
         PUT (ix, iy), work, PSET                'display it

      CASE 3                                     'behind
         FOR y = 1 TO ImageHeight                'top to bottom
            FOR x = 1 TO ImageWidth              'left to right
               DEF SEG = Sseg
               dat = PEEK(sofs)                  'source point
               DEF SEG = Dseg
               IF PEEK(dofs) = 0 THEN            '0 in dest-?
                  POKE dofs, dat                 'replace with source
               END IF
               sofs = sofs + 1: dofs = dofs + 1  'adjust
            NEXT
         NEXT
         PUT (ix, iy), work, PSET                'display it

      CASE 4                                     'XOR
         PUT (ix, iy), ClipBoard                 'display it

   END SELECT
END SUB

SUB DisplayMsg (msg$) STATIC
   ml = LEN(msg$)                                'message length
   IF ml THEN                                    'display it
      REDIM tmp(1281)                            'array to save area
      GET (0, 192)-(319, 199), tmp               'capture area
      col = 20 - (ml \ 2)                        'center it
      LOCATE 25, col
      COLOR 15
      PRINT msg$;                                'print it
   ELSE                                          'erase it
      PUT (0, 192), tmp, PSET                    'restore screen area
   END IF
END SUB

SUB DrawBorder

   FOR y = Ystart TO Yend STEP Ystep             'top to bottom
      FOR x = Xstart TO Xend STEP Xstep          'left to right
         LINE (x, y)-(x + Xstep, y + Ystep), 7, B     'do a box
      NEXT
   NEXT

END SUB

SUB EditSprite

   GPWorkSprite 0                                'save all the images
   CLS                                           'clear screen

   DEF SEG = VARSEG(UndoClipBoard(0))            'point to image
   ofs = 4                                       'skip image size data
   x = ZoomSX: y = ZoomSY                        'upper left corner
   addv = ZoomFact - 1                           'for boxes
   FOR ih = 1 TO ImageHeight                     'top to bottom
      FOR iw = 1 TO ImageWidth                   'left to right
         dat = PEEK(ofs)                         'get color
         LINE (x, y)-(x + addv, y + addv), dat, BF    'draw a box
         x = x + ZoomFact                        'adjust
         ofs = ofs + 1                           'ditto
      NEXT
      x = ZoomSX                                 'reset
      y = y + ZoomFact                           'adjust
   NEXT

   MinMX = ZoomSX                                'minimum mouse X
   MaxMX = ZoomFact * ImageWidth + ZoomSX - 1    'maximum mouse X
   z = QBEX(7)                                   'set mouse X limits
   MinMY = ZoomSY                                'minimum mouse Y
   MaxMY = ZoomFact * ImageHeight + ZoomSY - 1   'maximum mouse Y
   z = QBEX(8)                                   'set mouse Y limits
   wx = ZoomSX: wy = ZoomSY                      'upper left corner
   lclr = POINT(wx, wy)                          'save color
   LINE (wx, wy)-(wx + addv, wy + addv), CursorClr, BF     'display cursor

   DO
      z = QBEX(2)                                'get button status
      z = QBEX(3)                                'get mouse position
      IF MouseLeft THEN                          'left click
         lclr = CurrentClr                       'change location's color
      ELSEIF MouseRight THEN                     'right click
         savmx = MouseX: savmy = MouseY          'save location
         LINE (wx, wy)-(wx + addv, wy + addv), lclr, BF     'remove cursor
         DisplayMsg SelClr$                      'tell 'em what to do
         CurrentClr = SelectColor(1, CurrentClr) 'pick a color
         DisplayMsg null$                        'erase message
         LINE (wx, wy)-(wx + addv, wy + addv), CursorClr, BF 'display cursor
         MouseX = savmx:  MouseY = savmy         'put it back
         z = QBEX(4)                             'set mouse position
      END IF

      col = (MouseX - ZoomSX) \ ZoomFact         'calc location
      row = (MouseY - ZoomSY) \ ZoomFact         'ditto
      IF col <> lc OR row <> lr THEN             'did it move?
         lc = col: lr = row                      'for next time
         LINE (wx, wy)-(wx + addv, wy + addv), lclr, BF     'remove cursor
         wx = col * ZoomFact + ZoomSX            'calc exact location
         wy = row * ZoomFact + ZoomSY            'calc exact location
         lclr = POINT(wx, wy)                    'save color
         LINE (wx, wy)-(wx + addv, wy + addv), CursorClr, BF 'display cursor
      END IF

   LOOP UNTIL GetKeyMask                         'wait for key press

   LINE (wx, wy)-(wx + addv, wy + addv), lclr, BF     'remove cursor

   ubd = UBOUND(UndoClipBoard)                   'get size
   REDIM work(ubd)                               'work array
   work(0) = ImageWidth * 8                      'set image size data
   work(1) = ImageHeight                         'ditto
   DEF SEG = VARSEG(work(0))                     'point to it
   ofs = 4                                       'skip image size data
   x = ZoomSX: y = ZoomSY                        'upper left corner
   FOR ih = 1 TO ImageHeight                     'top to bottom
      FOR iw = 1 TO ImageWidth                   'left to right
         dat = POINT(x, y)                       'get color
         POKE ofs, dat                           'update work image
         x = x + ZoomFact                        'adjust
         ofs = ofs + 1                           'ditto
      NEXT
      x = ZoomSX                                 'reset
      y = y + ZoomFact                           'adjust
   NEXT

   MinMX = 0: MaxMX = 319                        'full screen
   z = QBEX(7)                                   'set mouse X limits
   MinMY = 0: MaxMY = 199                        'full screen
   z = QBEX(8)                                   'set mouse Y limits
   CLS                                           'clear screen
   DrawBorder                                    'draw the border
   GPWorkSprite 1                                'put 'em all back
   PUT (ix, iy), work, PSET                      'update image

END SUB

SUB FlipImage

   ubd = UBOUND(UndoClipBoard)                   'get size
   REDIM work(ubd)                               'work array
   work(0) = ImageWidth * 8                      'set image size data
   work(1) = ImageHeight                         'ditto

   Sseg = VARSEG(UndoClipBoard(0))               'source segment
   Dseg = VARSEG(work(0))                        'dest- segment

   sofs = ((ImageHeight - 1) * ImageWidth) + 4   'set to bottom row
   sstep = ImageWidth * 2                        'adjustment value
   dofs = 4                                      'skip image size data

   FOR y = 1 TO ImageHeight                      'top to bottom
      FOR x = 1 TO ImageWidth                    'left to right
         DEF SEG = Sseg
         dat = PEEK(sofs)                        'source color
         DEF SEG = Dseg
         POKE dofs, dat                          'update work image
         sofs = sofs + 1                         'adjust
         dofs = dofs + 1                         'adjust
      NEXT
      sofs = sofs - sstep                        'adjust (bottom  to top)
   NEXT
   PUT (ix, iy), work, PSET                      'update image

END SUB

SUB GetFileList

   elm = QBEX(10)                                'count files
   IF elm THEN                                   'find any?
      REDIM FileList$(1 TO elm)                  'size the array
      FOR t = 1 TO elm                           'set 'em all
         FileList$(t) = SPACE$(12)               '            to 12 spaces
      NEXT
      z = QBEX(11)                               'get names into array
      FOR t = 1 TO elm                           'get rid of
         FileList$(t) = RTRIM$(FileList$(t))     '           extra spaces
      NEXT
   END IF

   DO                                            'bubble sort
      flag = 0                                   'assume sorted
      FOR t = 1 TO (elm - 1)                     'top to bottom
         IF FileList$(t) > FileList$(t + 1) THEN 'bigger is lower in alphabet
            SWAP FileList$(t), FileList$(t + 1)  'swap 'em
            flag = t                             'set flag
         END IF
      NEXT
      elm = flag                                 'up to last swap
   LOOP WHILE flag

END SUB

FUNCTION GetKeyMask

   DEF SEG = ExtKeySeg                           'point to QBEX's data
   l = PEEK(ExtKeyOfs + 75) AND 1                'cursor left
   U = PEEK(ExtKeyOfs + 72) AND 2                'cursor up
   r = PEEK(ExtKeyOfs + 77) AND 4                'cursor right
   D = PEEK(ExtKeyOfs + 80) AND 8                'cursor down
   ent = PEEK(ExtKeyOfs + 28) AND 16             'Enter
   SB = PEEK(ExtKeyOfs + 57) AND 32              'Space Bar
   esc = PEEK(ExtKeyOfs + 1) AND 64              'Escape
   PgU = PEEK(ExtKeyOfs + 73) AND 128            'page up

   PgD = PEEK(ExtKeyOfs + 81) AND 1              'page down
   Hm = PEEK(ExtKeyOfs + 71) AND 2
   EndKey = PEEK(ExtKeyOfs + 79) AND 4

   DEF SEG = &H40                      'point head to tail thus emptying
   POKE &H1A, PEEK(&H1C)               'the keyboard buffer

   lowbyte = l OR U OR r OR D OR ent OR SB OR esc OR PgU
   highbyte = PgD OR Hm OR EndKey

   DEF SEG                                       'default segment
   hbptr = VARPTR(highbyte)
   POKE hbptr + 1, PEEK(hbptr)                   'move low byte to high
   POKE hbptr, 0                                 'clear low byte

   GetKeyMask = lowbyte OR highbyte              'return all of it
      
END FUNCTION

SUB GPWorkSprite (mode)

   WStartX = Xstart + 1                          'upper left image corner X
   WEndX = Xend + 1                              'upper right image corner X
   WStartY = Ystart + 1                          'upper left image corner Y
   WEndY = Yend + 1                              'upper right image corner Y
   addw = ImageWidth - 1                         'add value for GET
   addh = ImageHeight - 1                        'ditto
   FOR y = WStartY TO WEndY STEP Ystep           'top to bottom
      FOR x = WStartX TO WEndX STEP Xstep        'left to right
         ofs = i * ElmPerImage                   'offset to image
         IF mode THEN                            'PUT
            PUT (x, y), WorkSprite(ofs), PSET    'do it
         ELSE                                    'GET
            GET (x, y)-(x + addw, y + addh), WorkSprite(ofs)    'do it
         END IF
         i = i + 1                               'next image
      NEXT
   NEXT
END SUB

FUNCTION InPutFileName$

   REDIM tmp(641)
   GET (0, 0)-(159, 7), tmp                      'save screen area
   LINE (0, 0)-(159, 7), 0, BF                   'erase screen area

   bksp$ = CHR$(8)                               'BackSpace
   ent$ = CHR$(13)                               'Enter
   esc$ = CHR$(27)                               'Escape
   valid$ = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_^$~!#%&-{}()@'`"
   COLOR 15
   LOCATE 1, 1
   PRINT "File Name?"                           'the question
   
   DO                                            'input loop
      k$ = UCASE$(INKEY$)                        'check for key
      IF LEN(k$) THEN                            'got one
         tl = LEN(name$)                         'length of current name
         IF INSTR(valid$, k$) THEN               'is it ok?
            IF tl < 8 THEN name$ = name$ + k$    'add it - character max
         ELSEIF k$ = bksp$ THEN                  'backspace
            IF tl THEN name$ = LEFT$(name$, tl - 1)'delete last character
         ELSEIF k$ = esc$ THEN                   'Escape
            name$ = null$                           'no file name
            EXIT DO                              'outta here
         END IF
         LINE (96, 0)-(159, 7), 0, BF            'erase screen area
         LOCATE 1, 13
         PRINT name$;                            'show the name
      END IF
   LOOP UNTIL k$ = ent$                          'wait for Enter

   PUT (0, 0), tmp, PSET                         'restore screen area
   InPutFileName$ = name$                        'return the name

END FUNCTION

FUNCTION InPutNumber (ask$, min, max)

   z = QBEX(6)                                   'mouse cursor off
   maxlen = LEN(STR$(max))                       'max number string length
   al = LEN(ask$) + 1                            'question length
   col = al + 1                                  'column for input
   fx = al * 8                                   'x location
   mx = maxlen * 8 + fx - 1                      'max x location
   
   REDIM tmp((mx + 1) * 4 + 1)                  'temp array
   GET (0, 0)-(mx, 7), tmp                      'save screen area
   LINE (0, 0)-(mx, 7), 0, BF                   'erase screen area

   bksp$ = CHR$(8)                               'BackSpace
   ent$ = CHR$(13)                               'Enter
   esc$ = CHR$(27)                               'Escape
   valid$ = "-0123456789"
   COLOR 15
   LOCATE 1, 1
   PRINT ask$                                    'the question

   DO                                            'input loop
      k$ = UCASE$(INKEY$)                        'check for key
      IF LEN(k$) THEN                            'got one
         tl = LEN(number$)                       'length of current name
         IF INSTR(valid$, k$) THEN               'is it ok?
            IF tl < maxlen THEN number$ = number$ + k$ 'add it
         ELSEIF k$ = bksp$ THEN                  'backspace
            IF tl THEN number$ = LEFT$(number$, tl - 1)'delete last character
         ELSEIF k$ = esc$ THEN                   'Escape
            number$ = "0"                        'no file name
            EXIT DO                              'outta here
         END IF
         LINE (fx, 0)-(mx, 7), 0, BF            'erase screen area
         LOCATE 1, col
         PRINT number$;                          'show the number
      END IF
   LOOP UNTIL k$ = ent$                          'wait for Enter

   PUT (0, 0), tmp, PSET                         'restore screen area
   z = QBEX(5)                                   'mouse cursor on

   num = VAL(number$)                            'convert to integer
   IF num < min THEN num = min                   'enforce range
   IF num > max THEN num = max                   'ditto
   InPutNumber = num
   
END FUNCTION

SUB MilliDelay (msecs) STATIC

    IF sysfact& THEN                             'calc- system speed yet?
        IF msecs THEN                            'have to want a delay
            count& = (sysfact& * msecs) \ -54    'calc- # of loops needed
            DO
                count& = count& + 1              'negative - add to get to 0
                IF count& = z THEN EXIT DO       'when its 0 we're done
            LOOP UNTIL t2 = PEEK(&H6C)           'make it the same as below
        END IF
    ELSE                                         'calc- system speed
        DEF SEG = &H40                           'point to low memory
        t1 = PEEK(&H6C)                          'get tick count
        DO
            t2 = PEEK(&H6C)                      'get tick count
        LOOP UNTIL t2 <> t1                      'wait 'til its a new tick
        DO
            sysfact& = sysfact& + 1              'count number of loops
            IF sysfact& = z THEN EXIT DO         'make it the same as above
        LOOP UNTIL t2 <> PEEK(&H6C)              'wait 'til its a new tick
        t2 = 256                                 'prevent the above UNTIL
    END IF
END SUB

SUB MirrorImage

   ubd = UBOUND(UndoClipBoard)                   'get size
   REDIM work(ubd)                               'work array
   work(0) = ImageWidth * 8                      'set image size data
   work(1) = ImageHeight                         'ditto
   Sseg = VARSEG(UndoClipBoard(0))               'source segment
   Dseg = VARSEG(work(0))                        'dest- segment
   sofs = ImageWidth + 3                         'set to end of row
   sstep = ImageWidth * 2                        'adjustment value
   dofs = 4                                      'skip image size data

   FOR y = 1 TO ImageHeight                      'top to bottom
      FOR x = 1 TO ImageWidth                    'left to right
         DEF SEG = Sseg
         dat = PEEK(sofs)                        'source color
         DEF SEG = Dseg
         POKE dofs, dat                          'update work image
         sofs = sofs - 1                         'adjust (right to left)
         dofs = dofs + 1                         'adjust
      NEXT
      sofs = sofs + sstep                        'adjust
   NEXT
   PUT (ix, iy), work, PSET                      'update image

END SUB

FUNCTION PullDown (menu$(), defpick)

' NOTE : The Mouse Cursor is assumed to be ON when PullDown is called.
' ****   The array passed as menu$() MUST begin with element 1.
' ****   ie.  REDIM menu$( 1 TO Elements )

   x = 4: y = 4                                  'set up values
   barX = 8: barY = 8                            'ditto
   COLOR 7                                       'gray

   totalpicks = UBOUND(menu$)                    'total choices
   FOR t = 1 TO totalpicks                       'check all of 'em
      thisl = LEN(menu$(t))
      IF thisl > maxl THEN maxl = thisl          'find longest string
   NEXT
   maxX = (maxl + 2) * 8 - 5                     'calc box max value
   maxbarX = maxX - 4                            'calc bar max value

   IF totalpicks > 23 THEN                       'fit on screen?
      scrX = maxX + 2                            'set up values
      mscrX = scrX + 6                           'ditto
      maxX = maxX + 11                           'make room for scroll bar
      scrY! = 14                                 'ditto
      lscrY! = scrY!                             'ditto
      scrfact! = 167 / (totalpicks - 1)          'ditto
      MaxRow = 23                                'ditto
      MclickOut = 2                              'have to double click
   ELSE
      MaxRow = totalpicks                        'set up values
      MclickOut = 1                              'single click ok
   END IF
   maxY = (MaxRow + 2) * 8 - 5                   'calc box max value

   REDIM tmp((maxX - 3) * (maxY - 3) \ 2 + 1)    'array to save area
   REDIM bar((maxbarX - 7) * 8 \ 2 + 1)          'array for highlight bar

   z = QBEX(6)                                   'mouse cursor off
   GET (x, y)-(maxX, maxY), tmp                  'save area
   LINE (barX, barY)-(maxbarX, barY + 7), 3, BF  'draw highlight bar
   GET (barX, barY)-(maxbarX, barY + 7), bar     'capture it
   LINE (x, y)-(maxX, maxY), 0, BF               'clear area
   LINE (4, 4)-(maxX, maxY), 1, B                'draw border
   LINE (5, 5)-(maxX - 1, maxY - 1), 1, B        'ditto
   LINE (6, 6)-(maxX - 2, maxY - 2), 9, B        'ditto

   IF scrX THEN                                  'need scroll bar?
      LINE (scrX - 1, 6)-(scrX - 4, 193), 9, B   'border
      LINE (scrX - 2, 4)-(scrX - 3, 195), 1, B   'ditto
      LINE (scrX, 12)-(mscrX, 13), 9, B          'ditto
      LINE (scrX, 186)-(mscrX, 187), 9, B        'ditto
      PSET (scrX + 3, 8), 12                     'up arrow
      LINE (scrX + 2, 9)-(scrX + 4, 9), 12       'ditto
      LINE (scrX + 1, 10)-(scrX + 5, 10), 12     'ditto
      PSET (scrX + 3, 191), 12                   'down arrow
      LINE (scrX + 2, 190)-(scrX + 4, 190), 12   'ditto
      LINE (scrX + 1, 189)-(scrX + 5, 189), 12   'ditto
      REDIM scrbar(19)                           'array for marker
      LINE (scrX, scrY!)-(mscrX, 18), 12, BF     'draw marker
      LINE (scrX, scrY!)-(mscrX, 18), 4, B       'ditto
      GET (scrX, scrY!)-(mscrX, 18), scrbar      'capture it
   END IF
   z = QBEX(5)                                   'mouse cursor on

   IF defpick THEN                               'default pick?
      IF defpick > MaxRow THEN                   'will it be on screen?
         row = MaxRow                            'set it to bottom
         PickAdd = defpick - MaxRow              'adjust to match up
      ELSE
         row = defpick                           'set it to default
      END IF
   ELSE                                          'no default so
      row = 1                                    '              set it to 1
   END IF
   z = QBEX(3)                                   'get mouse position
   savmx = MouseX: savmy = MouseY                'save it
   MouseX = maxX \ 2: MouseY = row * 8 + 4       'set to row
   z = QBEX(4)                                   'get mouse position
   lPickAdd = -1                                 'force print on first loop
   WaitLetGo                                     'wait for 'em to let go

   DO                                            'start of menu loop
      z = QBEX(2)                                'get button status
      z = QBEX(3)                                'get mouse position
      ThisKey = GetKeyMask                       'check the keyboard

      IF MouseLeft THEN                          'left click?
         SELECT CASE MouseX                      'where?
         CASE barX TO maxbarX                    'in menu?
            mouserow = MouseY \ 8                'which row?
            IF mouserow > 0 AND mouserow <= MaxRow THEN  'in menu?
               row = mouserow                            'set it
               IF MouseLeft = MclickOut THEN EXIT DO  'choice made
            ELSE                                      'off of menu
               row = 0                                'return 0
               EXIT DO                                'outta here
            END IF

         CASE scrX TO mscrX                      'on scroll bar?
            IF scrX THEN                         'have to have a scroll bar
               SELECT CASE MouseY                'where at?
               CASE 7 TO 11                      'up arrow
                  ThisKey = ThisKey OR 2         'set UP bit
               CASE 188 TO 192                   'down arrow
                  ThisKey = ThisKey OR 8         'set DOWN bit
               CASE 14 TO 181                    'inside the bar
                  ThisPick = (MouseY - 14) / scrfact! + 1 'calc which pick
                  IF ThisPick < PickAdd + 1 THEN 'off top of screen?
                     row = 1                     'set to top row
                     PickAdd = ThisPick - 1      'adjust to match up
                  ELSEIF ThisPick > PickAdd + 23 THEN 'off bottom of screen?
                     row = 23                    'set to bottom row
                     PickAdd = ThisPick - 23     'adjust to match up
                  ELSE
                     row = ThisPick - PickAdd    'adjust to match up
                  END IF
               END SELECT
            END IF

         CASE IS > maxX                          'outside of menu
            IF MouseLeft = MclickOut THEN
               row = 0                           'return 0
               EXIT DO                           'outta here
            END IF
         END SELECT
      END IF

      IF ThisKey THEN                            'key pressed
         MilliDelay 110                          'give user time to let go
         IF ThisKey AND 2 THEN                   'cursor UP pressed
            IF row > 1 THEN                      'can bar go up
               row = row - 1                     'move bar up
            ELSEIF PickAdd THEN                  'or can text go down
               PickAdd = PickAdd - 1             'move text down
            END IF
         ELSEIF ThisKey AND 8 THEN               'cursor DOWN pressed
            IF row < MaxRow THEN                 'can bar go down
               row = row + 1                     'move bar down
            ELSEIF PickAdd + row < totalpicks THEN    'or can text go up
               PickAdd = PickAdd + 1             'move text up
            END IF
         ELSEIF ThisKey AND 16 THEN              'Enter Key pressed
            EXIT DO                              'choice made
         ELSEIF ThisKey AND 64 THEN              'Escape pressed
            row = 0                              'return 0
            EXIT DO                              'outta here
         ELSEIF ThisKey AND 128 THEN             'Page Up key
            IF row > 1 THEN                      'at the top?
               row = 1                           'move to top
            ELSEIF PickAdd >= 23 THEN            'another page?
               PickAdd = PickAdd - 23            'move a page
            ELSE                                 'not full page
               PickAdd = 0                       'top of list
            END IF
         ELSEIF ThisKey AND 256 THEN             'Page Down key
            IF row < MaxRow THEN                 'at the bottom?
               row = MaxRow                      'move to bottom
            ELSEIF PickAdd + MaxRow + 23 < totalpicks THEN 'another page?
               PickAdd = PickAdd + 23            'move a page
            ELSE                                 'not full page
               PickAdd = totalpicks - MaxRow     'bottom of list
            END IF
         ELSEIF ThisKey AND 512 THEN             'Home key
            row = 1                              'top of screen
            PickAdd = 0                          'top of list
         ELSEIF ThisKey AND 1024 THEN            'End key
            row = MaxRow                         'bottom of screen
            PickAdd = totalpicks - MaxRow        'bottom of list
         END IF
      END IF

      IF PickAdd <> lPickAdd THEN                'need to move text?
         lPickAdd = PickAdd                      'for next time
         z = QBEX(6)                             'mouse cursor off
         LINE (barX, 8)-(maxbarX, maxY - 4), 0, BF    'clear menu
         FOR t = 1 TO MaxRow                     'top to bottom
            LOCATE t + 1, 2
            PRINT menu$(t + PickAdd);            'print text
         NEXT
         PUT (barX, barY), bar                   'display highlight bar
         z = QBEX(5)                             'mouse cursor on
      END IF

      IF row <> lr THEN                          'did the bar move?
         z = QBEX(6)                             'mouse cursor off
         PUT (barX, barY), bar                   'erase last bar
         barY = row * 8                          'calc new position
         PUT (barX, barY), bar                   'show highlight bar
         lr = row                                'for next time
         z = QBEX(5)                             'mouse cursor on
      END IF

      IF scrX THEN                               'is there a scroll bar?
         scrY! = (row + PickAdd - 1) * scrfact! + 14  'calc scroll position
         IF scrY! <> lscrY! THEN                 'did it move?
            z = QBEX(6)                          'mouse cursor off
            PUT (scrX, lscrY!), scrbar           'erase last
            PUT (scrX, scrY!), scrbar            'display new
            z = QBEX(5)                          'mouse cursor on
            lscrY! = scrY!                       'for next time
         END IF
      END IF
      
   LOOP                                          'end of menu loop

   z = QBEX(6)                                   'mouse cursor off
   PUT (x, y), tmp, PSET                         'put the screen back
   z = QBEX(5)                                   'mouse cursor on
   WaitLetGo                                     'wait for 'em to let go
   IF row THEN                                   'choice made
      MouseX = savmx: MouseY = savmy             'reset to saved values
      z = QBEX(4)                                'set mouse position
      row = row + PickAdd                        'adjust
   END IF
   PullDown = row                                'return the selection

END FUNCTION

FUNCTION QBEX (ExtNum) STATIC
   IF TSRseg THEN
      DEF SEG = TSRseg
      SELECT CASE ExtNum
      CASE 0  'get key table address
         CALL ABSOLUTE(ExtNum, ExtKeyOfs, ExtKeySeg, TSRofs)
      CASE 1  'check for mouse
         CALL ABSOLUTE(ExtNum, Blank, Blank, TSRofs)
      CASE 2  'check mouse clicks
         CALL ABSOLUTE(ExtNum, MouseLeft, MouseRight, TSRofs)
      CASE 3 TO 4 'get / set mouse position
         MouseX = MouseX * 2           'adjust for screen mode
         CALL ABSOLUTE(ExtNum, MouseX, MouseY, TSRofs)
         MouseX = MouseX \ 2           'adjust for screen mode
      CASE 5  'turn mouse cursor on
         CALL ABSOLUTE(ExtNum, Blank, Blank, TSRofs)
      CASE 6  'turn mouse cursor off
         CALL ABSOLUTE(ExtNum, Blank, Blank, TSRofs)
      CASE 7  'set min & max mouse X values
         ActMinMX = MinMX * 2           'adjust for screen mode
         ActMaxMX = MaxMX * 2           'adjust for screen mode
         CALL ABSOLUTE(ExtNum, ActMinMX, ActMaxMX, TSRofs)
      CASE 8  'set min & max mouse Y values
         CALL ABSOLUTE(ExtNum, MinMY, MaxMY, TSRofs)
      CASE 9 'check if file exists - if so return size
         CALL ABSOLUTE(ExtNum, FileName$, FileSize&, TSRofs)
      CASE 10 'get file count
         CALL ABSOLUTE(ExtNum, FileSpec$, Blank, TSRofs)
      CASE 11 'get file list
         CALL ABSOLUTE(ExtNum, FileSpec$, FileList$(), TSRofs)
      END SELECT
      QBEX = ExtNum
   ELSE
      REDIM ary(46)                              'array to hold machine code
      DEF SEG = VARSEG(ary(0))                   'point to its seg
      BLOAD "CallMult.FPS", 0                    'load machine code
      CALL ABSOLUTE(TSRofs, TSRseg, 0)           'call the code
      ERASE ary                                  'done with the array
      IF TSRseg THEN                             'TSR was found
         QBEX = QBEX(0)                          'call Extender function 0
      ELSE                                       'TSR not found
         QBEX = 0                                'return false
      END IF
   END IF
END FUNCTION

FUNCTION SelectColor (mode, defclr)

   REDIM tmp(7034)                               'temp array
   GET (87, 51)-(231, 147), tmp                  'capture area
   IF mode THEN                                  'single?
      savmx = MouseX: savmy = MouseY             'save location
      MouseX = (defclr MOD 16) * 9 + 91          'point to current color
      MouseY = (defclr \ 16) * 6 + 54            'ditto
      z = QBEX(4)                                'set mouse location
      sminMX = MinMX: smaxMX = MaxMX             'save current limits
      sminMY = MinMY: smaxMY = MaxMY             'ditto
      MinMX = 0: MaxMX = 319                     'full screen
      z = QBEX(7)                                'set mouse X limits
      MinMY = 0: MaxMY = 199                     'full screen
      z = QBEX(8)                                'set mouse Y limits
   END IF
   MouseRight = 1                                'draw chart on first loop
   z = QBEX(5)                                   'mouse cursor on
   DO                                            'start selection loop
      IF MouseRight THEN                         'right click
         z = QBEX(6)                             'mouse cursor off
         IF chart THEN                           'pop it down
            PUT (87, 51), tmp, PSET              'restore screen area
         ELSE                                    'pop it up
            LINE (87, 51)-(231, 147), 0, BF      'clear area
            FOR y = 52 TO 142 STEP 6             'draw chart
               FOR x = 88 TO 223 STEP 9          'ditto
                  LINE (x, y)-(x + 7, y + 4), clr, BF
                  clr = clr + 1                  'next color
               NEXT
            NEXT
         END IF
         z = QBEX(5)                             'mouse cursor on
         chart = NOT chart                       'toggle it
         WaitLetGo                               'wait for 'em to let go
      END IF
      z = QBEX(2)                                'get button status
      z = QBEX(3)                                'get mouse position
   LOOP UNTIL MouseLeft                          'wait for left click

   z = QBEX(6)                                   'mouse cursor off
   clicked = POINT(MouseX, MouseY)               'get color
   PUT (87, 51), tmp, PSET                       'restore screen area
   WaitLetGo                                     'wait for 'em to let go
   
   IF mode THEN                                  'single?
      MouseX = savmx: MouseY = savmy             'restore position
      z = QBEX(4)                                'set mouse position
      MinMX = sminMX: MaxMX = smaxMX             'reset limits
      MinMY = sminMY: MaxMY = smaxMY             'reset limits
      z = QBEX(7)                                'set mouse X limits
      z = QBEX(8)                                'set mouse Y limits
   ELSE                                          'group?
      clicked = (clicked \ 16) * 16              'first color in the group
   END IF
   SelectColor = clicked                         'return it

END FUNCTION

SUB SetColors (pal() AS Hues, fc, lc)
   OUT &H3C8, fc                                 'tell controller to get ready
   FOR t = fc TO lc                              'from first to last
      OUT &H3C9, pal(t).red                      'send red component
      OUT &H3C9, pal(t).green                    'send green component
      OUT &H3C9, pal(t).blue                     'send blue component
   NEXT
END SUB

SUB SetupSpriteArrays
   wrkelms = ElmPerImage - 1                     'elements for 1 image
   REDIM ClipBoard(wrkelms)                      'redim 'em
   REDIM UndoClipBoard(wrkelms)                  'ditto
   REDIM WorkSprite(TotalElms - 1)               'ditto
   ClipBoard(0) = ImageWidth * 8                 'set width
   UndoClipBoard(0) = ClipBoard(0)               'ditto
   ClipBoard(1) = ImageHeight                    'set height
   UndoClipBoard(1) = ClipBoard(1)               'ditto
END SUB

SUB WaitLetGo
   DO
      z = QBEX(2)                                     'get button status
   LOOP WHILE MouseLeft OR MouseRight OR GetKeyMask   'wait 'til user lets go
END SUB

