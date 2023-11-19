'*****************************************************************************
'       WELCOME TO
'
'    /--\     /----  -------  ------  -----\    /---\   -------   -----\
'   /    \   /          |     |       |     |  |     |     |       |    |
'  /------\  |          |     |       |     |  |     |     |       |    |
'  |      |   \---\     |     ---     -----/   |     |     |       |    |
'  |      |       |     |     |       | \      |     |     |       |    |
'  |      |       |     |     |       |  \     |     |     |       |    |
'  |      |  -----/     |     |-----  |   \     \---/   -------   -----/
'
'                /------    /--\    --------   /------   |     |
'               |          /    \      |      |          |     |
'               |         /------\     |      |          |-----|
'               |         |      |     |      |          |     |
'               |         |      |     |      |          |     |
'                \------  |      |     |       \------   |     |
'
'BY JEFF BRAUNSTEIN
'PRESS F5 TO PLAY!!!
'*****************************************************************************
DECLARE SUB game ()
CALL game

SUB game
RANDOMIZE TIMER
CLS
LET lives = 5
LET level = 1
LET soundnum = 1
increment = 30
toughness = 40
tough$ = "medium"
extenders = 3
epower = 2000
ereset = 2000
extend$ = "inactive"
catches = 0
GOSUB TitleScreen
GOSUB game
END
'*****************************************************************************
game:
SCREEN 12
afall = 1
LET colPos = INT(RND * 620) + 10
LET RowPos = 10
GOSUB asteroid
col = 350
row = 450
time = 1
GOSUB ship
IF level = 1 THEN increment = 50
IF level = 2 THEN increment = 60
IF level = 3 THEN increment = 70
IF level = 4 THEN increment = 80
IF level = 5 THEN increment = 90
IF level = 6 THEN increment = 100
IF level = 7 THEN increment = 110
IF level = 8 THEN increment = 130
IF level = 9 THEN increment = 150
IF level = 10 THEN increment = 200
DO
IF time = 100 THEN
  CIRCLE (colPos, RowPos), 20, 0
  PAINT (colPos, RowPos), 0
  RowPos = RowPos + increment
  time = 1
  IF soundnum = 1 THEN SOUND 200, .5
END IF
GOSUB asteroid
IF afall = 1 THEN
 CLS
END IF
afall = 2
keyval = 0
keystroke$ = INKEY$
IF LEN(keystroke$) THEN keyval = ASC(keystroke$)
IF keyval THEN
 GOSUB delship
END IF
IF keyval = 52 THEN col = col - 15
IF keyval = 54 THEN col = col + 15
IF keyval = 32 AND extend$ = "active" THEN
  CLS
  COLOR 15
  PRINT "One at a time, pal!"
  GOTO 40
END IF
IF keyval = 32 THEN
  extenders = extenders - 1
  IF extenders < 0 THEN 40
  toughness = toughness + 10
  extend$ = "active"
END IF
IF extend$ = "active" THEN
  epower = epower - 1
  IF epower = 0 THEN
    epower = ereset
    toughness = toughness - 10
    LINE (col, 450)-((col - toughness), (450 - 20)), 3, B
    CLS
    extend$ = "inactive"
  END IF
END IF
40 IF col < 20 THEN col = 21
IF col > 640 THEN col = 639
GOSUB ship
time = time + 1
IF RowPos = (row - 20) AND colPos - 10 >= col - toughness AND colPos + 10 <= col THEN GOSUB catch
IF RowPos = (row - 20) THEN GOSUB miss
GOSUB dotscreen
LOOP
RETURN
'*****************************************************************************
TitleScreen:
20 SCREEN 0
CLS
LOCATE 5, 20
COLOR 7
PRINT "Welcome to ....."
COLOR 2
PRINT : PRINT : PRINT : PRINT : PRINT :
PRINT "                                 ASTEROID"
PRINT "                                      CATCH!!!"
LOCATE 14, 31: PRINT "By JEFF BRAUNSTEIN"
LOCATE 16, 33
COLOR 15
PRINT "Choose one:"
PRINT "                                1. Start Game"
PRINT "                                2. Instructions"
PRINT "                                3. Story"
PRINT "                                4. Options"
PRINT "                                5. Exit"
COLOR 14
INPUT "                                Your Choice"; choice
IF choice = 0 THEN GOTO 20
IF choice = 1 THEN RETURN
IF choice = 2 THEN GOSUB INSTRUCTIONS
IF choice = 3 THEN GOSUB story
IF choice = 4 THEN GOSUB options
IF choice = 5 THEN END
RETURN
'*****************************************************************************
asteroid:
SCREEN 12
CIRCLE (colPos, RowPos), 10, 6
PAINT (colPos, RowPos), 6
IF RowPos > row - 20 THEN RowPos = row - 20
RETURN
'*****************************************************************************
catch:
  CIRCLE (colPos, RowPos), 10, 0
  PAINT (colPos, RowPos), 0
  RowPos = 10
  colPos = INT(RND * 620) + 10
  catches = catches + 1
  IF catches > 10 THEN catches = 1
  CLS
  COLOR 15
  PRINT "Catches:"; catches; "out of 10"
  IF soundnum = 1 THEN
    SOUND 500, 3
    SOUND 1000, 3
  END IF
  IF catches = 10 THEN GOSUB nextlevel
RETURN
'*****************************************************************************
miss:
  lives = lives - 1
  IF lives < 0 THEN GOSUB lose
  IF soundnum = 1 THEN
    SOUND 1000, 3
    SOUND 500, 3
  END IF
  LOCATE 10, 5
  COLOR 7
  CLS
  IF lives <> 0 THEN PRINT "Too bad.  You let an asteroid fall into the sun.  You can only let"; lives; "more go."
  IF lives = 0 THEN PRINT "Uh oh.  You'd better not let any more asteroids fall!"
  LOCATE 24, 1
  PRINT "Press space bar to continue..."
  DO
  keystroke$ = INKEY$
  IF LEN(keystroke$) THEN keyval = ASC(keystroke$)
  LOOP WHILE keyval <> 32
60
  RowPos = 10
  colPos = INT(RND * 620) + 10
  IF lives < 0 THEN GOSUB lose
  CLS
RETURN
'*****************************************************************************
options:
10 CLS
SCREEN 0
LOCATE 7, 37
COLOR 15
PRINT "OPTIONS:"
LOCATE 9, 35
COLOR 2
PRINT "1. Lives = "; lives
LOCATE 11, 35
PRINT "2. Level = "; level
LOCATE 13, 35
IF soundnum = 1 THEN sound$ = "on"
IF soundnum = 2 THEN sound$ = "off"
PRINT "3. Sound = "; sound$
LOCATE 15, 35
PRINT "4. Toughness = "; tough$
LOCATE 17, 35
PRINT "5. Exit"
LOCATE 19, 35
COLOR 14
INPUT "Your Choice"; opchoice
IF opchoice = 5 THEN GOTO 20
IF opchoice = 0 THEN 10
IF opchoice > 4 THEN 10
IF opchoice = 1 THEN
 LOCATE 19, 35
 INPUT "New number of lives(1-7)"; lives
 IF lives > 7 THEN lives = 7
 GOTO 10
END IF
IF opchoice = 2 THEN
  LOCATE 19, 35
  INPUT "Enter new level(1-10)"; level
  IF level = 0 THEN level = 1
  IF level > 10 THEN level = 10
  GOTO 10
END IF
IF opchoice = 3 THEN
  LOCATE 19, 35
  INPUT "Type 'on' or 'off'"; sound$
  IF sound$ = "on" THEN soundnum = 1
  IF sound$ = "off" THEN soundnum = 2
  GOTO 10
END IF
IF opchoice = 4 THEN
  LOCATE 19, 35
  INPUT "Easy, medium, or hard"; tough$
30 IF tough$ = "easy" THEN
     toughness = 60
     extenders = 5
     epower = 3000
     ereset = 3000
   END IF
  IF tough$ = "medium" THEN
    toughness = 40
    extenders = 3
    epower = 3000
    ereset = 3000
  END IF
  IF tough$ = "hard" THEN
    toughness = 30
    extenders = 1
    epower = 1000
    ereset = 1000
  END IF
  IF tough$ <> "easy" AND tough$ <> "medium" AND tough$ <> "hard" THEN
    LOCATE 19, 35
    INPUT "Type 'easy', 'medium', or 'hard'"; tough$
    GOTO 30
  END IF
GOTO 10
END IF
GOTO 10
RETURN
'*****************************************************************************
INSTRUCTIONS:
SCREEN 0
CLS
COLOR 15
LOCATE 3, 34
PRINT "INSTRUCTIONS"
COLOR 7
PRINT
PRINT "       Welcome to Asteroids.  In this game you are at the cockpit of a spaceship"
PRINT "at the bottom of the screen.  Due to technical problems, only the tip of the"
PRINT "ship is shown.  Anyway, you must use the numeric keypad to play, and make sure"
PRINT "that NumLock is ON.  The left arrow moves the ship left, and the right arrow"
PRINT "moves the ship right.  When catching an asteroid, make sure that the ENTIRE"
PRINT "asteroid fits in the basket on your ship.  Otherwise it will be counted as a"
PRINT "miss.  You are equipped with a special weapon that will extend the length of"
PRINT "your ship for a short period of time.  To activate it, simply press space bar."
PRINT "After 10 catches, you will advance to the next level.  There are 10 normal "
PRINT "levels in all.  If you miss an asteroid, it falls past you toward the sun. "
PRINT "If more than 5 asteroids fall, the explosion will still occur.(see STORY.)"
PRINT "It may seem easy at first, but it gets harder, trust me."
COLOR 15
PRINT : PRINT "                   DIFFERENCE BETWEEN EASY, MEDIUM AND HARD"
COLOR 7
PRINT "       In the EASY setting, the ship is longer, you have 5 extenders, the"
PRINT "extender is longer and the extender lasts longer. In the MEDIUM setting, you"
PRINT "have 3 extenders. And in the HARD setting, your ship is very short, you only "
PRINT "have 1 extender, it isn't very long, and it lasts for a short time."
COLOR 15
PRINT "                                 GOOD LUCK!!"
PRINT
INPUT "press enter to continue..."; a$
GOTO 20
RETURN
'*****************************************************************************
lose:
SCREEN 12
CLS
CIRCLE (320, 240), 100, 14
PAINT (320, 240), 14
FOR a = 1 TO 20000
NEXT
column = 15
DO
CIRCLE (column, 180), 15, 6
CIRCLE ((column - 15), 250), 15, 6
CIRCLE ((column - 5), 290), 15, 6
CIRCLE ((column - 25), 215), 15, 6
CIRCLE ((column - 40), 275), 15, 6
PAINT (column, 180), 6
PAINT ((column - 15), 250), 6
PAINT ((column - 5), 290), 6
PAINT ((column - 25), 215), 6
PAINT ((column - 40), 275), 6
CIRCLE (column, 180), 15, 0
CIRCLE ((column - 15), 250), 15, 0
CIRCLE ((column - 5), 290), 15, 0
CIRCLE ((column - 25), 215), 15, 0
CIRCLE ((column - 40), 275), 15, 0
PAINT (column, 180), 0
PAINT ((column - 15), 250), 0
PAINT ((column - 5), 290), 0
PAINT ((column - 25), 215), 0
PAINT ((column - 40), 275), 0
column = column + 10
IF soundnum = 1 THEN SOUND 500, .3
LOOP WHILE column <> 325
rad = 2
DO
CIRCLE (320, 240), rad, 4
rad = rad + 1
LET n = rad * 10 + 37
IF soundnum = 1 THEN SOUND n, .1
LOOP WHILE rad <> 400
CLS
50 CIRCLE (640, 240), 15, 15
PAINT (639, 239), 15
CIRCLE (500, 239), 30, 1
PAINT (500, 239), 1
CIRCLE (400, 239), 8, 4
PAINT (400, 239), 4
CIRCLE (125, 239), 150, 4
PAINT (125, 239), 4
rad = 2
DO
CIRCLE (700, 239), rad, 4
rad = rad + 1
LET n = rad * 10 + 37
IF soundnum = 1 THEN SOUND n, .1
LOOP WHILE rad <> 400
COLOR 15
PRINT "Press any key to continue..."
DO
keystroke$ = INKEY$
IF LEN(keystroke$) THEN keyval = ASC(keystroke$)
IF keyval THEN a = 2
LOOP WHILE a <> 2
SCREEN 0
CLS
COLOR 7
LOCATE 5, 10
PRINT "        Too bad.  Because you failed, the asteroids hit the sun and blew up"
PRINT "half of the solar system.  Now, humanity no longer exists.  Humans will now"
PRINT "never reach their destiny of exploring space.  All known life has ceased. "
PRINT "Good job.  Have a nice day!!"
COLOR 15
LOCATE 24, 1
INPUT "Press any key to continue..."; a$
GOSUB theend
GOTO 20
RETURN
'*****************************************************************************
nextlevel:
SCREEN 12
CLS
LOCATE 10, 30
COLOR 15
PRINT "Good Job!"
LOCATE 15, 1
COLOR 7
level = level + 1
IF level > 10 THEN GOSUB win
PRINT "        You passed the level. Press enter to proceed to level"; level; "."
LOCATE 24, 1
INPUT "Press enter to continue..."; a$
CLS
RowPos = 10
colPos = INT(RND * 620) + 10
IF level = 1 THEN increment = 50
IF level = 2 THEN increment = 60
IF level = 3 THEN increment = 70
IF level = 4 THEN increment = 80
IF level = 5 THEN increment = 90
IF level = 6 THEN increment = 100
IF level = 7 THEN increment = 110
IF level = 8 THEN increment = 130
IF level = 9 THEN increment = 150
IF level = 10 THEN increment = 200
RETURN
'*****************************************************************************
story:
SCREEN 0
CLS
LOCATE 3, 35
COLOR 15
PRINT "THE STORY"
PRINT : PRINT
COLOR 7
PRINT "        The year is 2100.  With the almost total control of computerized police"
PRINT "forces, crime has almost completely been eliminated from Earth.  The new "
PRINT "RLE's(Robotic Law Enforcers) are handling the job quite well.  Peace treaties"
PRINT "have been signed with every nation of the world, and world peace has been "
PRINT "attained.  Poverty is slowly being eliminated; with the help of all nations"
PRINT "working together, Earth has become prosperous.  With the invention of super-"
PRINT "conductors, no further pollution is created.  And as for space exploration, "
PRINT "Earth has two Space Stations orbiting earth, one orbiting Mars, one around"
PRINT "Jupiter, and others are being built.  A colony has been created on mars, and"
PRINT "is advancing at an amazing rate.  And a new program, Search the Stars, has been"
PRINT "started with plans to send a fully loaded spacecraft with 10,000 colonists to "
PRINT "enter the blackness of space and explore.  Everyone's hopes are high; everyone"
PRINT "is happy. But not for long.  On may 18, A huge asteroid shifted trajectory from"
PRINT "the Mars-Jupiter belt and began a head on collision course with the Sun. The "
PRINT "predicted explosion would engulf all planets out to Jupiter.  Earth, in a "
PRINT "desperate attempt to stop the collision, sent a nuclear device to rondezvous"
PRINT "with the asteroid about one month before the predicted explosion."
PRINT
INPUT "Press enter for more..."; a$
CLS
LOCATE 5, 1
PRINT "According to the given data, the hit on the asteroid should force it to change"
PRINT "course to barely miss the impact with the sun.  But unfortunately, that's not "
PRINT "what happened. The scientists made a slight error in calculating the positioning"
PRINT "of the device.  The result was devastating.  Instead of hitting the side of the"
PRINT "asteroid, the nuclear device hit smack in the center of it, splitting it into"
PRINT "hundreds of pieces.  Now instead of one massive asteroid heading toward the Sun,"
PRINT "hundreds were.  But not all hope was lost.  In less than one week, a spceship"
PRINT "was built that could catch and dispose of chunks of asteroid.  Because of the"
PRINT "speed the ship needed to have to get to the asteroid in time, it was very small,"
PRINT "a little bigger than a chunk of the rock.  Only one man could pilot this device."
PRINT "Now you, a lone hero, must go into the blackness of space and stop the asteroids"
PRINT "from hitting the sun.  A device has been attatched to your ship to make it a "
PRINT "little longer for a short period of time.  Being the brave hero you are, at once"
PRINT "you set out on your mission. Good luck.  You're going to need it."
PRINT
INPUT "Press enter to continue..."; a$
GOTO 20
RETURN
'*****************************************************************************
ship:
LINE (col, 450)-((col - toughness), 450), 3
LINE ((col - toughness), 450)-((col - toughness), 430), 3
LINE (col, 450)-(col, 430), 3
'LINE (col - (toughness / 2), 451)-(col, 480), 8
'LINE (col - (toughness / 2), 451)-((col - toughness), 480), 8
'PAINT ((col - (toughness / 2)), 469), 8
'CIRCLE ((col - (toughness / 2)), 463), 5, 1
'PAINT ((col - (toughness / 2)), 463), 1
RETURN
'*****************************************************************************
delship:
LINE (col, 450)-((col - toughness), 450), 0
LINE ((col - toughness), 450)-((col - toughness), 430), 0
LINE (col, 450)-(col, 430), 0
'LINE (col - (toughness / 2), 451)-(col, 480), 0
'LINE (col - (toughness / 2), 451)-((col - toughness), 480), 0
'PAINT ((col - (toughness / 2)), 469), 0
'CIRCLE ((col - (toughness / 2)), 463), 5, 0
'PAINT ((col - (toughness / 2)), 463), 0
RETURN
'*****************************************************************************
win:
SCREEN 12
CLS
INPUT "press enter to continue..."; a$
CLS
IF tough$ = "easy" THEN
  COLOR 14
  PRINT : PRINT : PRINT : PRINT : PRINT : PRINT : PRINT
  PRINT "                               CONGRATULATIONS!!!"
  PRINT : PRINT
  COLOR 15
  PRINT "    You saved humanity!  Now man can fulfill their destiny of exploring space."
  PRINT "As you return home, you're greeted by thousands of people.  You are a hero to"
  PRINT "millions.  Hundreds of people idolize you, you get your own TV show.  Tens of"
  PRINT "thousands of dollars have been made by the sales of your T-shirts, action "
  PRINT "figures, and other merchandise.  The day is made an international holiday,"
  PRINT "and everyone you meet wants your autograph.  You meet with many different "
  PRINT "leaders throughout the world and are greatly thanked.  But somehow, even with"
  PRINT "this fame, you don't quite feel like you've accomplished much.  I mean, that"
  PRINT "was pretty easy.  Maybe you should try a more difficult toughness."
  PRINT : PRINT : PRINT : PRINT
  INPUT "press any key to continue..."; a$
  GOSUB theend
  GOTO 20
END IF
IF tough$ = "medium" THEN
  COLOR 14
  PRINT : PRINT : PRINT : PRINT : PRINT : PRINT : PRINT
  PRINT "                    HURRAAAYY!!  HURRAAAYY!!  HURRAAAYY!!"
  COLOR 15
  PRINT : PRINT "   You saved humanity! Now man can fulfill their destiny of eploring space."
  PRINT "As you return home, you are greeted by thousands and thousands of fans.  You are"
  PRINT "a hero to billions.  Your day of arrival is named an interplanetary holiday; you"
  PRINT "have your own TV show and star in a movie. Millions of dollars have been made on"
  PRINT "your action figures, T-shirts, and other merchandise.  The president of the"
  PRINT "United States has promised to name the next known planet after you.  You are an"
  PRINT "idle to millions; a hero to billions.  People worship you and grovel at your "
  PRINT "feet.  Congratulations."
  PLAY "MBT160O1l4cl3eL5eee-eL2fL2eL4eL3dL5ddcdl2el3cL4cL3el5eee-e"
  PLAY "MBT160O1L2fL5gL1aL5agggL3fL5dL1c"
  PRINT : PRINT : PRINT : PRINT
  INPUT "press any key to continue..."; a$
  GOSUB theend
  GOTO 20
END IF
IF tough$ = "hard" THEN
  COLOR 15
  PRINT : PRINT : PRINT : PRINT : PRINT : PRINT : PRINT
  PRINT "Holy mackerel!  Howdja do that?!  As you return to earth, millions and millions"
  PRINT "of people are welcoming you.  People do anything just to take a snapshot, to get"
  PRINT "close, or to touch you.  You recieve a solid gold medal for your efforts. Nobody"
  PRINT "is worthy to stand before you.  Your best-selling book, 'How I Saved the Solar"
  PRINT "System', made you a millionare, as did the sale of T-shirts and dolls, about YOU"
  PRINT "You are a god to the people; a hero, an idle, and a god.  You are promised that"
  PRINT "the next galaxy will be named after you.  And what's more, you've been nominated"
  PRINT "to pilot the Search the Stars vessel!!  You couldn't be happier.  But the STS "
  PRINT "mission isn't going to be easy.  So prepare yourself for an adventure!!"
  PLAY "MBL8O2DDL15CL15<BL7BL15B-BL3BL15B-BL8BL15B-BL8>DL15<B>DL4C<L6A"
  PLAY "MBL15AL8AL15A-AL8AL15A-AL4>CL15<BABL8>DL15DL8EEL3<A"
  PLAY "MBL8O2DDL15CL15<BL7BL15B-BL3bL15B-BL8BL15B-BL15>DC<AGL4AGL15GL7G"
  PLAY "MBO1L15G-GL8B-L15AGL3>GL15<GAB>D<GAB>D<DEBL4AL7GL10>G"
  PRINT : PRINT : INPUT "press enter to continue..."; a
  GOTO 70
END IF
END
'*****************************************************************************
dotscreen:
SCREEN 12
PSET (10, 10), 15
PSET (138, 27), 15
PSET (476, 365), 15
PSET (266, 206), 15
PSET (95, 409), 15
PSET (453, 35), 15
PSET (284, 400), 15
PSET (100, 100), 15
PSET (300, 300), 15
PSET (400, 200), 15
PSET (100, 300), 15
PSET (300, 75), 15
PSET (560, 200), 15
RETURN
'*****************************************************************************
70 GOSUB theend
'*****************************************************************************
theend:
SCREEN 13
'LINE (300, 50)-(20, 100), 67, B
'T
LINE (50, 100)-(35, 50), 67, B
PAINT (49, 99), 67
LINE (20, 50)-(65, 60), 67, B
PAINT (21, 51), 67
PAINT (51, 51), 67
'H
LINE (70, 50)-(80, 100), 67, B
PAINT (71, 51), 67
LINE (105, 50)-(95, 100), 67, B
PAINT (96, 51), 67
LINE (70, 68)-(105, 78), 67, B
PAINT (90, 69), 67
'E
LINE (110, 50)-(120, 100), 67, B
PAINT (111, 51), 67
LINE (110, 50)-(140, 60), 67, B
PAINT (121, 51), 67
LINE (110, 68)-(130, 78), 67, B
PAINT (121, 69), 67
LINE (110, 100)-(140, 90), 67, B
PAINT (121, 91), 67
'E
LINE (170, 50)-(180, 100), 67, B
PAINT (171, 51), 67
LINE (170, 50)-(200, 60), 67, B
PAINT (181, 51), 67
LINE (170, 68)-(190, 78), 67, B
PAINT (181, 69), 67
LINE (170, 100)-(200, 90), 67, B
PAINT (181, 91), 67
'N
LINE (205, 50)-(215, 100), 67, B
PAINT (206, 51), 67
LINE (245, 50)-(235, 100), 67, B
PAINT (236, 51), 67
LINE (205, 50)-(235, 100), 67
LINE (215, 50)-(245, 100), 67
PAINT (216, 53), 67
'D
LINE (250, 50)-(260, 100), 67, B
PAINT (251, 51), 67
LINE (270, 65)-(280, 83), 67, B
PAINT (271, 66), 67
LINE (250, 50)-(270, 65), 67
LINE (260, 50)-(280, 65), 67
PAINT (261, 53), 67
LINE (250, 100)-(270, 83), 67
LINE (260, 100)-(280, 83), 67
PAINT (261, 91), 67


END SUB

