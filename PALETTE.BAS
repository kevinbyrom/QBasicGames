' ** Palette.BAS
' ** 1993 Fred Sexton Jr.
' ** Requires: QBasic Extender TSR
' **
DEFINT A-Z
TYPE Hues                                        'define the type for hues
    red AS INTEGER                               'red component
  green AS INTEGER                               'green component
   blue AS INTEGER                               'blue component
END TYPE

DECLARE FUNCTION QBEX (ExtNum)                   'TSR interface
DECLARE SUB GetColors (pal() AS Hues, fc, lc)    'SUB to retieve palette
DECLARE SUB GetFileList ()                       'SUB to get list of files
DECLARE SUB SetColors (pal() AS Hues, fc, lc)    'SUB to modify palette
DECLARE SUB MilliDelay (msecs)                   'SUB to create delays
DECLARE SUB WaitLetGo ()                         'SUB to give user time
DECLARE FUNCTION GetKeyMask ()                   'FUNCTION to handle keyboard
DECLARE FUNCTION InPutFileName$ ()               'FUNCTION to get a file name
DECLARE FUNCTION PullDown (menu$(), dpick)       'FUNCTION for menus

'---------- define the variables used by the Extender TSR ----------
COMMON SHARED ExtKeyOfs, ExtKeySeg
COMMON SHARED MouseLeft, MouseRight, MouseX, MouseY
COMMON SHARED FileName$, FileSize&, FileSpec$, FileList$()
'-------------------------------------------------------------------

IF NOT QBEX(0) THEN                              'verify presence of TSR
   PRINT "QBasic Extender TSR not found"
   END
END IF
IF NOT QBEX(1) THEN                              'verify presence of mouse
   PRINT "Mouse not found"
   END
END IF

SCREEN 13                                        '320x200 with 256 colors

REDIM pal(255) AS Hues                           'array for palette
REDIM UndoPal(255) AS Hues                       'array for Undo-ing changes
GetColors pal(), 0, 255                          'fill 'em both
GetColors UndoPal(), 0, 255                      'with standard palette

FOR y = 104 TO 194 STEP 6
   FOR x = 8 TO 294 STEP 19
      LINE (x, y)-(x + 17, y + 4), clr, BF       'draw color chart
      clr = clr + 1                              'do all colors 0-255
   NEXT
NEXT

REDIM rbox(36)                                   'array for red box
REDIM gbox(36)                                   'array for green box
REDIM bbox(36)                                   'array for blue box

rbx = 216: mrbx = 229                            'values box positions
gbx = 248: mgbx = 261                            'ditto
bbx = 280: mbbx = 293                            'ditto
rby = 88: gby = 88: bby = 88                     'ditto
boty = 93: topy = boty - 69                      'ditto

LINE (rbx - 1, topy)-(mrbx + 1, boty), 7, B      'outline for red
LINE (gbx - 1, topy)-(mgbx + 1, boty), 7, B      'outline for green
LINE (bbx - 1, topy)-(mbbx + 1, boty), 7, B      'outline for blue
boty = boty - 1                                  'adjust
LINE (rbx, rby)-(mrbx, boty), 4, BF              'draw box
GET (rbx, rby)-(mrbx, boty), rbox                'capture it
LINE (gbx, gby)-(mgbx, boty), 2, BF              'draw box
GET (gbx, gby)-(mgbx, boty), gbox                'capture it
LINE (bbx, bby)-(mbbx, boty), 1, BF              'draw box
GET (bbx, bby)-(mbbx, boty), bbox                'capture it
boty = 88                                        'adjust

CurClr = 23                                      'start with color 23
ccx = (CurClr MOD 16) * 19 + 7                   'calc outline corner
ccy = (CurClr \ 16) * 6 + 103                    'ditto

REDIM menu$(1 TO 6)                              'array for menu text
menu$(1) = "Undo"                                'menu text
menu$(2) = "Copy"                                'ditto
menu$(3) = "Paste"                               'ditto
menu$(4) = "Load"                                'ditto
menu$(5) = "Save"                                'ditto
menu$(6) = "Exit"                                'ditto

REDIM over$(1 TO 2)                              'array for menu text
over$(1) = "Cancel"                              'menu text
over$(2) = "OverWrite"                           'ditto

FileSpec$ = "*.pal"                              'palette files
z = QBEX(5)                                      'mouse cursor on

DO                                               'start main loop
   z = QBEX(2)                                   'get button status
   z = QBEX(3)                                   'get mouse position

   IF MouseRight THEN                            'right button brings up menu
      pick = PullDown(menu$(), lPick)            'get the selection
      lPick = pick                               'set for next time
      SELECT CASE pick
      CASE 1                                                       'Undo
         SetColors UndoPal(), 0, 255             'reset 'em
         GetColors pal(), 0, 255                 'store 'em
         UpdateBoxes = NOT UpdateBoxes           'update 'em

      CASE 2                                     'Copy
         red = pal(CurClr).red                   'get component value
         green = pal(CurClr).green               'ditto
         blue = pal(CurClr).blue                 'ditto

      CASE 3                                     'Paste
         GetColors UndoPal(), 0, 255             'in case they decide to undo
         pal(CurClr).red = red                   'set component value
         pal(CurClr).green = green               'ditto
         pal(CurClr).blue = blue                 'ditto
         SetColors pal(), CurClr, CurClr         'set system color
         UpdateBoxes = NOT UpdateBoxes           'update 'em

      CASE 4                                     'Load
         GetFileList                             'find all the files
         FileName$ = FileList$(PullDown(FileList$(), 1))   'let em pick one
         DEF SEG = VARSEG(pal(0))                'point to pal array
         BLOAD FileName$, 0                      'load the palette file
         GetColors UndoPal(), 0, 255             'in case they decide to undo
         SetColors pal(), 0, 255                 'set system colors
         UpdateBoxes = NOT UpdateBoxes           'update 'em

      CASE 5                                     'Save
         sure = -1                               'assume ok
         FileName$ = InPutFileName$              'get the name
         IF LEN(FileName$) THEN                  'legit?
            FileName$ = FileName$ + ".PAL"       'add extension
            IF QBEX(9) THEN                     'see if it exists
               sure = PullDown(over$(), 1) - 1   'ask if ok to overwrite
            END IF
            IF sure THEN                         'ok to save
               DEF SEG = VARSEG(pal(0))          'point to array
               BSAVE FileName$, 0, 1536          'save it
            END IF
         END IF
      CASE 6                                     'Exit
         EXIT DO                                 'outta here
      END SELECT

   ELSEIF MouseLeft THEN

      SELECT CASE MouseY                         'see where click is at
      CASE 25 TO boty                            'in color component boxes
         nv = boty - MouseY                      'the new value
         IF nv <> lv THEN                        'same as last time?
            lv = nv                              'save for next time
            SELECT CASE MouseX                   'which box is it in?
            CASE rbx TO mrbx                     'red box
               pal(CurClr).red = nv              'set red
            CASE gbx TO mgbx                     'green box
               pal(CurClr).green = nv            'set green
            CASE bbx TO mbbx                     'blue box
               pal(CurClr).blue = nv             'set blue
            END SELECT
            SetColors pal(), CurClr, CurClr      'set system color
            UpdateBoxes = NOT UpdateBoxes           'update 'em
         END IF

      CASE 104 TO 199                            'on color chart

         IF (MouseY - 103) MOD 6 THEN            'make sure its on a color
            IF (MouseX - 7) MOD 19 THEN          'ditto
               GetColors UndoPal(), CurClr, CurClr    'save changes
               z = QBEX(6)                            'mouse cursor off
               CurClr = POINT(MouseX, MouseY)         'get the color
               z = QBEX(5)                                 'mouse cursor on
               GetColors UndoPal(), CurClr, CurClr         'for undo
            END IF
         END IF

      END SELECT
   END IF

   IF CurClr <> LastColor THEN
      COLOR 15                                   'might've changed
      z = QBEX(6)                                'mouse cursor off
      LINE (ccx, ccy)-(ccx + 19, ccy + 6), 0, B  'clear outline
      ccx = (CurClr MOD 16) * 19 + 7             'calc position
      ccy = (CurClr \ 16) * 6 + 103              'ditto
      LINE (ccx, ccy)-(ccx + 19, ccy + 6), 7, B  'outline new color
      LOCATE 3, 11
      PRINT USING "###"; CurClr;                 'current color
      LINE (8, 24)-(30, 93), (CurClr - 2) AND 255, BF      'two
      LINE (32, 24)-(54, 93), (CurClr - 1) AND 255, BF     'below
      LINE (56, 24)-(126, 93), CurClr, BF                  'current
      LINE (128, 24)-(150, 93), (CurClr + 1) AND 255, BF   '& two
      LINE (152, 24)-(174, 93), (CurClr + 2) AND 255, BF   'above
      z = QBEX(5)                                'mouse cursor on
      UpdateBoxes = NOT UpdateBoxes              'update 'em
      LastColor = CurClr                         'for next time
   END IF

   IF UpdateBoxes THEN
      UpdateBoxes = NOT UpdateBoxes              'reset
      LOCATE 3, 26
      COLOR 15                                   'might have been changed
      z = QBEX(6)                                'mouse cursor off
      r = pal(CurClr).red                        'get component value
      g = pal(CurClr).green                      'ditto
      B = pal(CurClr).blue                       'ditto
      PRINT USING "####"; r; g; B;               'the component values
      PUT (rbx, rby), rbox                       'erase old box
      rby = boty - pal(CurClr).red               'calc new position
      PUT (rbx, rby), rbox                       'display new box
      PUT (gbx, gby), gbox                       'erase old box
      gby = boty - pal(CurClr).green             'calc new position
      PUT (gbx, gby), gbox                       'display new box
      PUT (bbx, bby), bbox                       'erase old box
      bby = boty - pal(CurClr).blue              'calc new position
      PUT (bbx, bby), bbox                       'display new box
      z = QBEX(5)                                'mouse cursor on
   END IF

LOOP                                             'end of main loop

z = QBEX(6)                                      'mouse cursor off

END

SUB GetColors (pal() AS Hues, fc, lc)
   OUT &H3C7, fc                       'tell controller to get ready
   FOR t = fc TO lc                    'from first to last
      pal(t).red = INP(&H3C9)          'get red component
      pal(t).green = INP(&H3C9)        'get green component
      pal(t).blue = INP(&H3C9)         'get blue component
   NEXT
END SUB

SUB GetFileList

   count = QBEX(10)                              'count files
   IF count THEN                                 'find any?
      REDIM FileList$(1 TO count)                'size the array
      FOR t = 1 TO count                         'set 'em all
         FileList$(t) = SPACE$(12)               '            to 12 spaces
      NEXT
      z = QBEX(11)                               'get names into array
      FOR t = 1 TO count                         'get rid of
         FileList$(t) = RTRIM$(FileList$(t))     '           extra spaces
      NEXT
   END IF

   DO                                            'bubble sort
      flag = 0                                   'assume sorted
      FOR t = 1 TO (count - 1)                   'top to bottom
         IF FileList$(t) > FileList$(t + 1) THEN 'bigger is lower in alphabet
            SWAP FileList$(t), FileList$(t + 1)  'swap 'em
            flag = t                             'set flag
         END IF
      NEXT
      count = flag                               'up to last swap
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

   DEF SEG
   hbptr = VARPTR(highbyte)
   POKE hbptr + 1, PEEK(hbptr)
   POKE hbptr, 0

   GetKeyMask = lowbyte OR highbyte
      
END FUNCTION

FUNCTION InPutFileName$

   bksp$ = CHR$(8)                     'BackSpace
   ent$ = CHR$(13)                     'Enter
   esc$ = CHR$(27)                     'Escape
   valid$ = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_^$~!#%&-{}()@'`"
   COLOR 15
   LOCATE 1, 1
   PRINT "File Name?"                 'the question
   
   DO                                  'input loop
      k$ = UCASE$(INKEY$)              'check for key
      IF LEN(k$) THEN                  'got one
         tl = LEN(tmp$)                'length of current name
         IF INSTR(valid$, k$) THEN     'is it ok?
            IF tl < 8 THEN tmp$ = tmp$ + k$      'add it - character max
         ELSEIF k$ = bksp$ THEN                  'backspace
            IF tl THEN tmp$ = LEFT$(tmp$, tl - 1)'delete last character
         ELSEIF k$ = esc$ THEN                   'Escape
            tmp$ = ""                            'no file name
            EXIT DO                              'outta here
         END IF
         LINE (96, 0)-(159, 7), 0, BF            'erase screen area
         LOCATE 1, 13
         PRINT tmp$;                             'show the name
      END IF
   LOOP UNTIL k$ = ent$                          'wait for Enter

   LINE (0, 0)-(159, 7), 0, BF                   'erase screen area

   InPutFileName$ = tmp$                         'return the name

END FUNCTION

SUB MilliDelay (msecs) STATIC

    IF sysfact& THEN                   'Did we calc- system speed yet?
        IF msecs THEN                  'have to want a delay
            count& = (sysfact& * msecs) \ -54    'calc- # of loops needed
            DO
                count& = count& + 1         'negative - add to get to 0
                IF count& = z THEN EXIT DO  'when its 0 we're done
            LOOP UNTIL t2 = PEEK(&H6C)      'make it the same as loop below
        END IF
    ELSE                               'if sysfact& is 0, calc- system speed
        DEF SEG = &H40                 'point to low memory
        t1 = PEEK(&H6C)                'get tick count
        DO
            t2 = PEEK(&H6C)            'get tick count
        LOOP UNTIL t2 <> t1            'wait 'til its a new tick
        DO
            sysfact& = sysfact& + 1         'count number of loops
            IF sysfact& = z THEN EXIT DO    'make it the same as loop above
        LOOP UNTIL t2 <> PEEK(&H6C)         'keep going 'til its a new tick
        t2 = 256                            'prevent the above UNTIL
    END IF
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
         MinMX = MinMX * 2           'adjust for screen mode
         MaxMX = MaxMX * 2           'adjust for screen mode
         CALL ABSOLUTE(ExtNum, MinMX, MaxMX, TSRofs)
         MinMX = MinMX \ 2           'adjust for screen mode
         MaxMX = MaxMX \ 2           'adjust for screen mode
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
      REDIM ary(46)                         'array to hold machine code
      DEF SEG = VARSEG(ary(0))              'point to its seg
      BLOAD "CallMult.FPS", 0               'load machine code
      CALL ABSOLUTE(TSRofs, TSRseg, 0)      'call the code
      ERASE ary                             'done with the array
      IF TSRseg THEN                        'TSR was found
         QBEX = QBEX(0)                     'call Extender function 0
      ELSE                                  'TSR not found
         QBEX = 0                           'return false
      END IF
   END IF
END FUNCTION

SUB SetColors (pal() AS Hues, fc, lc)
      OUT &H3C8, fc                    'tell controller to get ready
   FOR t = fc TO lc                    'from first to last
      OUT &H3C9, pal(t).red            'send red component
      OUT &H3C9, pal(t).green          'send green component
      OUT &H3C9, pal(t).blue           'send blue component
   NEXT
END SUB

SUB WaitLetGo
   DO
      z = QBEX(2)                           'get button status
   LOOP WHILE MouseLeft OR GetKeyMask       'wait 'til user lets go
END SUB

