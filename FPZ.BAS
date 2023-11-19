'ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
'Û      Fig's e-mail address:                      PANTERA55@aol.com         Û
'Û      Fig's web site      :        http://members.aol.com/PANTERA55        Û
'Û      Sabin24601's e-mail address:               Sabin24601@aol.com        Û
'ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
' Press F5 to start playing right now.                                      
'ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
'Û      Fig Presents Fantasy Power Zone                                      Û
'Û                                                                           Û
'Û Welcome to Fantasy Power Zone, a RolePlaying game by Sabin24601, a new    Û
'Û member of Fig. This is my first QBasic game, so please send me feedback.  Û
'Û To control the game, enter numerical choices when given the option to do  Û
'Û so, or use the arrow keys to move when in towns or dungeons. Please, I'm  Û
'Û begging you, tell me what you think of this game, and give me ideas for   Û
'Û other games I should make. To quit my game, either die or hit escape when Û
'Û you are in a town. So go ahead, Hit F5, NOW!!!!                           Û
'Û                                                                           Û
'Û      P.S There are two secrets in the game, so if you want them, then you Û
'Û have to e-mail me with comments on the game! And oh yeah, do NOT make     Û
'Û changes to this program!!!!                                               Û
'ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ

'ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
'º   Other games that have been made by Fig:                                 º
'º        RISE - A one or two player space battle.  Uses gravity, has many   º
'º   weapons, etc..  Fun game to play.  O.K graphics.                        º
'º                              BY FIG            ******* / 10 stars         º
'º                                                                           º
'º       THE CONJURING VOLUME 1 CHAPTER 1 - RPG game.  A decent RPG.  It's  º
'º   O.K.  Very short, though.  This game was rushed a bit.                  º
'º                              BY DELFIGALLO       ***** / 10 stars         º
'º                                                                           º
'º        '97 HOCKEY SHOOTOUT - A hockey game.  Go 1 on 1 with the goalie.   º
'º     A good game with GET and PUT.  Fun game to play.                      º
'º                              BY FIG               **** / 10 stars         º
'º                                                                           º
'º        DUNGEON MASTER - Good RPG style fighting game.  Choose from three  º
'º   characters: a fighter, mage or cleric.  My first game.                  º
'º                              BY FIG             ****** / 10 stars         º
'º                                                                           º
'º       HELLPIT I - RPG game.  Very fun and addictive.  Two characters,    º
'º   magics, weapons, armors, levels, etc..  Very, very fun.                 º
'º                              BY FIG           ******** / 10 stars         º
'º                                                                           º
'º       HELLPIT II - Sequel to HELLPIT I.  This is a fun game to play.     º
'º   This is the game.  Play for yourself.  Amazing RPG!                     º
'º                              BY FIG          ********* / 10 stars         º
'º                                                                           º                                                                              º
'º       BIRTH OF THE DEVIL - Doom style side view shooting game.  Three    º
'º   weapons, three levels, three bosses.  Animations, too.                  º
'º                              BY FIG           ******** / 10 stars         º
'º    Means that the game is on AOL, E-Mail Pantera55@aol.com if you want   º                             
'º   it and it isn't on AOL.                                                 º
'ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼

'²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²
'²   Look for these games soon:                                              ²
'²        DUNGEON MASTER VERSION 1.1                     (FIG)               ²
'²        HELLPIT III                                    (FIG)               ²
'²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²


















DECLARE SUB Dungeon4 ()
DECLARE SUB Dungeon3 ()
DECLARE SUB Lvlchk ()
DECLARE SUB Status ()
DECLARE SUB Dungeon2 ()
DECLARE SUB Wshop ()
DECLARE SUB Ashop ()
DECLARE SUB Inn ()
DECLARE SUB Sword ()
DECLARE SUB Dungeon1 ()
DECLARE SUB Town ()
DECLARE SUB Wiseguy ()
DECLARE SUB Chatter ()
DECLARE SUB DrawFoe ()
DECLARE SUB FoeAttack ()
DECLARE SUB battle (foehp, foedef, foestr)
DECLARE SUB delay ()
DECLARE SUB Snd (whichsound, length, length2)
DECLARE SUB BOOM ()
DECLARE SUB Intro ()
DECLARE SUB MakeChr (left)
DECLARE SUB InputWait ()
DECLARE SUB DrawScreen ()
DIM SHARED weapon AS STRING
DIM SHARED str AS INTEGER
DIM SHARED strb AS INTEGER
DIM SHARED defense AS INTEGER
DIM SHARED magic AS INTEGER
DIM SHARED hp AS INTEGER
DIM SHARED Foename AS STRING
DIM SHARED atktyp AS STRING
DIM SHARED totxp AS INTEGER
DIM SHARED armor AS STRING
DIM SHARED currhp AS INTEGER
DIM SHARED currmp AS INTEGER
DIM SHARED Dungeonnum AS INTEGER
DIM SHARED gold AS INTEGER
DIM SHARED level AS INTEGER
DIM SHARED defen2 AS INTEGER
DIM SHARED wepower AS INTEGER
DIM SHARED armpower AS INTEGER
hp = 0
armpower = 0
wepower = 0
defen2 = 0
level = 1
gold = 100
strb = 0
magic = 0
defense = 0
Dungeonnum = 1
armor = "Clothing"
weapon = "Dagger"
totxp = 0
Foename = "Ballzak"
CALL Intro
CALL DrawScreen
LOCATE 4, 2
PRINT "Welcome to my first attempt at an RPG for QBasic. I'm sort of an inexperienced  basic programer, so please send me feedback, or any useful qbasic help, at      Sabin24601@aol.com . You may also send Comments and Questions, I enjoy any type of feedback."
LOCATE 8, 2
CALL InputWait
PRINT "First you must design your character, you get 25 stat points to use in the      categories : MAGIC, ATTACK, DEFENSE."
CALL InputWait
CALL MakeChr(25)
CALL InputWait
atktyp = "Punch"
Foename = "Ballzak"
CALL battle(100, 5, 5)
CLS
CALL Chatter
CALL Town

SUB Ashop
CLS
SCREEN 12
PAINT (1, 1), 4
PRINT "YE OLDE ARMOR SHOPE"
LINE (30, 70)-(120, 100), 6, BF
LINE (50, 100)-(100, 160), 6, BF
DO
LOCATE 12, 1
PRINT "What armor dost thou want?"
PRINT "1.LeatherArmor 200GOLD"
PRINT "2.ChainArmor 600GOLD"
PRINT "3.SteelArmor 1300GOLD"
PRINT "4.Spirit Armor 2000GOLD"
PRINT "5.Nothing"
INPUT choice
LOOP UNTIL choice = 1 OR choice = 2 OR choice = 3 OR choice = 4 OR choice = 5
IF choice = 1 THEN
IF 200 > gold THEN PRINT "YOU CHEAPSKATE! YOU DONT HAVE THAT MUCH MONEY!!!"
IF 200 <= gold THEN
gold = gold - 250
armor = "LeatherArmor"
armpower = 10
END IF
END IF
IF choice = 2 THEN
IF 600 > gold THEN PRINT "YOU CHEAPSKATE! YOU DONT HAVE THAT MUCH MONEY!!!"
IF 600 <= gold THEN
gold = gold - 600
armor = "ChainArmor"
armpower = 20
END IF
END IF
IF choice = 3 THEN
IF 1300 > gold THEN PRINT "YOU CHEAPSKATE! YOU DONT HAVE THAT MUCH MONEY!!!"
IF 1300 <= gold THEN
gold = gold - 1300
armor = "SteelArmor"
armpower = 30
END IF
END IF
IF choice = 4 THEN
IF 2000 > gold THEN PRINT "YOU CHEAPSKATE! YOU DONT HAVE THAT MUCH MONEY!!!"
IF 2000 <= gold THEN
gold = gold - 2000
armor = "SpiritArmor"
armpower = 40
END IF
END IF
IF choice = 5 THEN
PRINT "Hey! No browsing! If you're not gonna buy anything then GET OUT!"
CALL InputWait
END IF
defense = defen2 + armpower
PAINT (1, 1), 8
LINE (20, 20)-(620, 460), 10, BF
END SUB

SUB battle (foehp, foedef, foestr)
COLOR 15
CALL DrawScreen
CALL DrawFoe
COLOR 15
RANDOMIZE TIMER
blarg% = INT(2 * RND) + 1
300 CALL DrawScreen
CALL DrawFoe
COLOR 15
SELECT CASE blarg%
CASE 1
DO
LOCATE 28, 1
PRINT "HP: "; currhp; " Magic: "; currmp; " Opponent: "; Foename
INPUT "1.Attack 2.Magic: ", F%
LOOP UNTIL F% = 1 OR F% = 2
IF F% = 1 THEN
CALL Sword
attack = 0
FOR g% = 1 TO str
RANDOMIZE TIMER
attack = attack + INT(RND * 3) + 1
NEXT g%
EnemyDef = 0
FOR H% = 1 TO BallDef
RANDOMIZE TIMER
EnemyDef = EnemyDef + INT(RND * 3) + 1
NEXT H%
Totdam = attack - EnemyDef
IF attack > EnemyDef THEN
LOCATE 28, 1
PRINT "You have done "; Totdam; " Damage to "; Foename; "!"
foehp = foehp - Totdam
CALL InputWait
END IF
IF attack <= EnemyDef THEN
LOCATE 28, 1
PRINT Foename; " blocked your attack!"
CALL InputWait
END IF
END IF
blarg% = 2
IF F% = 2 THEN
INPUT "How much magic will you use?", Maguse%
IF Maguse% > currmp THEN
LOCATE 28, 1
PRINT "You dont have that many!"
CALL InputWait
ELSE
blarg% = 2
CLS
CALL DrawFoe
LINE (320, 240)-(0, 480), 6
LINE (320, 240)-(640, 480), 6
PAINT (320, 470), 4, 6
LINE (240, 320)-(400, 160), 13
LINE (240, 160)-(400, 320), 13
LOCATE 1, 1
PRINT "IT'S MAAAAAAAAAAAAAAAAAAAAAGIC!"
CALL Snd(200, .06, 4000)
CALL InputWait
magatk = 0
FOR counter = 1 TO Maguse%
RANDOMIZE TIMER
magatk = magatk + INT(RND * 5) + 1
NEXT counter
CALL DrawScreen
CALL DrawFoe
LOCATE 28, 1
PRINT "Your Magic attack did "; magatk; " Damage to "; Foename; "!"
blarg% = 2
CALL InputWait
foehp = foehp - magatk
currmp = currmp - Maguse%
CALL DrawScreen
CALL DrawFoe
END IF
END IF
IF foehp <= 0 THEN
dead = 1
CALL DrawScreen
CALL DrawFoe
COLOR 15
LOCATE 28, 1
PRINT "AAARRRGGGHHH!!! THOU HAST SLAIN ME!!! THOU SHALT PAY DEARLY FOR THIS!!!"
PLAY "L41CCAL21BEDL11O4AGAFDEB"
CALL InputWait
CALL BOOM
END IF
blarg% = 2
CASE 2
CALL FoeAttack
attack = 0
FOR g% = 1 TO foestr
RANDOMIZE TIMER
attack = attack + INT(RND * 3) + 1
NEXT g%
YourDef = 0
FOR H% = 1 TO defense
RANDOMIZE TIMER
YourDef = YourDef + INT(RND * 3) + 1
NEXT H%
Totdam = attack - YourDef
IF attack > YourDef THEN
LOCATE 28, 1
PRINT Foename; " has done "; Totdam; " Damage to you!"
CALL InputWait
currhp = currhp - Totdam
END IF
IF attack <= YourDef THEN
LOCATE 28, 1
PRINT "You blocked "; Foename; "'s attack!"
CALL InputWait
END IF
IF currhp <= 0 THEN
PLAY "MBMSL8fefefedefefed"
PRINT "YOU DIE! YOU STINK SO BADLY YOU DON'T DESERVE A COOL ENDING SCREEN! YOU DIED AT THE HANDS OF "; Foename; "! *muffled laughter heard from the background*."
CALL InputWait
dead = 2
END IF
blarg% = 1
END SELECT
IF dead = 0 THEN GOTO 300
IF dead = 1 THEN
LOCATE 15, 30
XP = (foedef + foestr) / 2
goldget = (foestr + foestr) / 3
PRINT "Thou hast defeated thine enemy, o noblest warrior! You hath earned "; XP; " points of experience, and "; goldget; " gold coins."
PLAY "MBO4L8agagbbba"
totxp = totxp + XP
gold = gold + goldget
CALL InputWait
END IF
IF dead = 2 THEN
PLAY "MBO1L8cbcbcbaaag"
PRINT "You disgust me. >:P"
END
END IF
CALL Lvlchk
END SUB

SUB BOOM
SCREEN 12
FOR a% = 1 TO 400
SOUND 200 + s, .06           'sound 200 + s (1 to 4000), .06 is the length
RANDOMIZE TIMER
B% = INT(RND * 13)
CIRCLE (320, 240), a%, B%
NEXT a%
END SUB

SUB Chatter
LOCATE 1, 1
PRINT "YOU: That'll teach those boring balls whose boss! ME! Wait a minute... that     crappy excuse for a basketball seems to have left a note here. It says..."
CALL InputWait
PRINT "YOU: 'To the loser without a castle...' HEY! I'm offended! What does this jerk  want? 'HAHAHA. You stink. I dare you to kill me. Really. Go ahead and try!            -10642Nibas' Hmm... that name seems familiar. Oh well. YOU'RE DEAD MEAT    JERK, CAUSE NOW I'M REALLY PISSED OFF!"
CALL InputWait
PRINT "NARRATOR: Suddenly, a voice from the distance screams: HAH! YOU CAN'T KILL ME   CASTLE-LESS TWIT! YOU WILL NEVER DEFEAT ME! HAHAHAHAHA. Now take those threats  back."
CALL InputWait
PRINT "YOU: Wait a minute, I knew the name 10642Nibas was familiar! My Castle has been knocked down by the author of this game! You're not the Narrator, you're that   lousy author! I want my castle back!"
CALL InputWait
PRINT "SABIN24601: No you can't have it back I knocked it down and theres nothing you  can do about it. I created this game for the purpose of a good RPG, not a       slapstick RPG! Your revenge is unimportant in my game, now shutup and let me    start the plot!"
CALL InputWait
PRINT "YOU: Not without a fight! You can't start the plot without my cooperation,      you'll need to stop me first!"
CALL InputWait
PRINT "SABIN24601: So be it. I can create anything and everything to stop you, but I am a fair author, although now I won't let you choose a different name besides    'YOU'. You now have a slim chance, have a nice day."
CALL InputWait
PRINT "YOU: Oh well, no one likes an easy RPG, but what now? Isn't there supposed to be a town or something?"
CALL InputWait
PRINT "SABIN24601: Yeah yeah just hold on, last minute programming is a pain, and      thanks to you there will be a lot of it. I wish I hadn't sent you those notes   now. I only knocked it down indirectly, I'm not even supposed to even be in this game."
CALL InputWait
PRINT "YOU: You should've thought of that before knocking over my castle!"
CALL InputWait
PRINT "SABIN24601: Look, I'm going to kill you, either me or Pantera55, the co-author. I feel like that guy who wrote the reluctant sorcerer series, in which one      character fought with the narrator for control. I need an asprin..."
CALL InputWait
END SUB

SUB delay
FOR d = 1 TO 4000
NEXT d
END SUB

SUB DrawFoe
IF Foename = "Ballzak" THEN
FOR E% = 100 TO 120
CIRCLE (320, 240), E%, 6
NEXT E%
CIRCLE (290, 200), 20, 10
CIRCLE (350, 200), 20, 10
CIRCLE (320, 280), 40, 10
LOCATE 29, 1
PRINT STRING$(0, 205);
END IF
IF Foename = "Ballzak XIV" THEN
CIRCLE (320, 200), 50, 15
PAINT (320, 200), 15
CIRCLE (320, 145), 32, 1
PAINT (320, 150), 1
CIRCLE (310, 140), 5, 4
CIRCLE (330, 140), 5, 4
PAINT (310, 140), 4
PAINT (330, 140), 4
CIRCLE (320, 163), 8, 4
PAINT (320, 163), 4
CIRCLE (260, 190), 30, 14
CIRCLE (380, 190), 30, 14
PAINT (260, 190), 14
PAINT (380, 190), 14
CIRCLE (260, 200), 23, 6
CIRCLE (380, 200), 23, 6
PAINT (260, 200), 6
PAINT (380, 200), 6
CIRCLE (260, 200), 13, 0
CIRCLE (380, 200), 13, 0
PAINT (260, 200), 0
PAINT (380, 200), 0
CIRCLE (290, 255), 27, 8
CIRCLE (350, 255), 27, 8
PAINT (290, 255), 8
PAINT (340, 255), 8
CIRCLE (290, 298), 22, 10
CIRCLE (350, 298), 22, 10
PAINT (290, 298), 10
PAINT (350, 298), 10
CIRCLE (290, 275), 18, 4
CIRCLE (350, 275), 18, 4
PAINT (290, 275), 4
PAINT (350, 275), 4
CIRCLE (290, 318), 14, 3
CIRCLE (350, 318), 14, 3
PAINT (350, 318), 3
PAINT (290, 318), 3
END IF
IF Foename = "Swordman" THEN
SCREEN 12
COLOR 4
LINE (300, 60)-(340, 120), , BF
COLOR 15
LINE (300, 120)-(320, 100)
LINE (320, 100)-(340, 120)
LINE (300, 120)-(340, 120)
LINE (303, 80)-(337, 90), , BF
LINE (270, 120)-(370, 240), , BF
LINE (270, 240)-(250, 300)
LINE (250, 300)-(290, 380), , BF
LINE (290, 300)-(320, 240)
LINE (320, 240)-(370, 400), , BF
LINE (270, 120)-(160, 150), , BF
LINE (370, 120)-(430, 150), , BF
LINE (400, 150)-(430, 180), , BF
PAINT (280, 280), 15
COLOR 2
LINE (435, 130)-(375, 200), , BF
LINE (375, 200)-(405, 220)
LINE (405, 220)-(435, 200)
PAINT (405, 215), 2
LINE (140, 150)-(130, 260)
LINE (130, 260)-(150, 280)
LINE (150, 280)-(170, 260)
LINE (170, 260)-(160, 150)
LINE (160, 150)-(140, 150)
PAINT (150, 155), 2
COLOR 4
LINE (270, 240)-(370, 230), , BF
LINE (390, 150)-(420, 190), , BF
LINE (160, 120)-(140, 150), , BF
END IF
IF Foename = "Dark Knight" THEN
SCREEN 12
COLOR 4
LINE (300, 60)-(340, 120), , BF
COLOR 0
LINE (300, 120)-(320, 100)
LINE (320, 100)-(340, 120)
LINE (300, 120)-(340, 120)
LINE (303, 80)-(337, 90), , BF
LINE (270, 120)-(370, 240), , BF
LINE (270, 240)-(250, 300)
LINE (250, 300)-(290, 380), , BF
LINE (290, 300)-(320, 240)
LINE (320, 240)-(370, 400), , BF
LINE (270, 120)-(160, 150), , BF
LINE (370, 120)-(430, 150), , BF
LINE (400, 150)-(430, 180), , BF
PAINT (280, 280), 0
COLOR 8
LINE (435, 130)-(375, 200), , BF
LINE (375, 200)-(405, 220)
LINE (405, 220)-(435, 200)
PAINT (405, 215), 8
LINE (140, 150)-(130, 260)
LINE (130, 260)-(150, 280)
LINE (150, 280)-(170, 260)
LINE (170, 260)-(160, 150)
LINE (160, 150)-(140, 150)
PAINT (150, 155), 8
COLOR 4
LINE (270, 240)-(370, 230), , BF
LINE (390, 150)-(420, 190), , BF
LINE (160, 120)-(140, 150), , BF
END IF
IF Foename = "Mr. Small" THEN
SCREEN 12
COLOR 14
LINE (250, 160)-(390, 260), , BF
COLOR 14
LINE (280, 160)-(200, 210), , BF
LINE (360, 160)-(440, 210), , BF
LINE (180, 160)-(230, 280), , BF
LINE (410, 160)-(460, 280), , BF
CIRCLE (310, 120), 5
CIRCLE (330, 120), 5
COLOR 5
LINE (250, 260)-(390, 240), , BF
LINE (250, 260)-(310, 350), , BF
LINE (330, 260)-(390, 350), , BF
CIRCLE (320, 130), 50, 0
PAINT (320, 130), 0
COLOR 14
LINE (313, 120)-(313, 130)
LINE (313, 130)-(290, 110)
LINE (290, 110)-(313, 120)
LINE (327, 120)-(327, 130)
LINE (327, 130)-(350, 110)
LINE (350, 110)-(327, 120)
PAINT (310, 125), 14
PAINT (330, 125), 14
CIRCLE (320, 159), 20, 14
PAINT (320, 159), 14
COLOR 0
LINE (330, 350)-(360, 380)
LINE (360, 380)-(390, 350)
LINE (390, 350)-(330, 350)
PAINT (360, 360), 0
LINE (250, 350)-(280, 380)
LINE (280, 380)-(310, 350)
LINE (310, 350)-(250, 350)
PAINT (280, 360), 0
LINE (180, 280)-(205, 320)
LINE (205, 320)-(230, 280)
LINE (180, 280)-(230, 280)
PAINT (205, 290), 0
LINE (410, 280)-(435, 320)
LINE (435, 320)-(460, 280)
LINE (460, 280)-(410, 280)
PAINT (435, 290), 0
END IF
IF Foename = "Tiny" THEN
SCREEN 12
COLOR 4
LINE (250, 160)-(390, 260), , BF
COLOR 4
LINE (280, 160)-(200, 210), , BF
LINE (360, 160)-(440, 210), , BF
LINE (180, 160)-(230, 280), , BF
LINE (410, 160)-(460, 280), , BF
CIRCLE (310, 120), 5
CIRCLE (330, 120), 5
COLOR 8
LINE (250, 260)-(390, 240), , BF
LINE (250, 260)-(310, 350), , BF
LINE (330, 260)-(390, 350), , BF
CIRCLE (320, 130), 50, 0
PAINT (320, 130), 0
COLOR 4
LINE (313, 120)-(313, 130)
LINE (313, 130)-(290, 110)
LINE (290, 110)-(313, 120)
LINE (327, 120)-(327, 130)
LINE (327, 130)-(350, 110)
LINE (350, 110)-(327, 120)
PAINT (310, 125), 4
PAINT (330, 125), 4
CIRCLE (320, 159), 20, 4
PAINT (320, 159), 4
COLOR 0
LINE (330, 350)-(360, 380)
LINE (360, 380)-(390, 350)
LINE (390, 350)-(330, 350)
PAINT (360, 360), 0
LINE (250, 350)-(280, 380)
LINE (280, 380)-(310, 350)
LINE (310, 350)-(250, 350)
PAINT (280, 360), 0
LINE (180, 280)-(205, 320)
LINE (205, 320)-(230, 280)
LINE (180, 280)-(230, 280)
PAINT (205, 290), 0
LINE (410, 280)-(435, 320)
LINE (435, 320)-(460, 280)
LINE (460, 280)-(410, 280)
PAINT (435, 290), 0
END IF
IF Foename = "Snake" THEN
SCREEN 12
CIRCLE (320, 300), 45, 2
PAINT (320, 300), 2
COLOR 0
CIRCLE (320, 300), 45
CIRCLE (320, 270), 35, 2
PAINT (320, 250), 2
COLOR 0
CIRCLE (320, 270), 35
CIRCLE (320, 240), 25, 2
PAINT (320, 233), 2
COLOR 0
CIRCLE (320, 240), 25
COLOR 2
LINE (290, 180)-(350, 180)
LINE (290, 180)-(315, 230)
LINE (325, 230)-(350, 180)
LINE (315, 230)-(325, 230)
PAINT (320, 200), 2
COLOR 0
LINE (290, 180)-(350, 180)
LINE (290, 180)-(315, 230)
LINE (325, 230)-(350, 180)
LINE (315, 230)-(325, 230)
COLOR 4
LINE (310, 200)-(315, 205), , BF
LINE (325, 200)-(330, 205), , BF
LINE (315, 230)-(325, 280), , BF
END IF
IF Foename = "Sneaky Snake" THEN
SCREEN 12
CIRCLE (320, 300), 45, 9
PAINT (320, 300), 9
COLOR 0
CIRCLE (320, 300), 45
CIRCLE (320, 270), 35, 9
PAINT (320, 250), 9
COLOR 0
CIRCLE (320, 270), 35
CIRCLE (320, 240), 25, 9
PAINT (320, 233), 9
COLOR 0
CIRCLE (320, 240), 25
COLOR 9
LINE (290, 180)-(350, 180)
LINE (290, 180)-(315, 230)
LINE (325, 230)-(350, 180)
LINE (315, 230)-(325, 230)
PAINT (320, 200), 9
COLOR 0
LINE (290, 180)-(350, 180)
LINE (290, 180)-(315, 230)
LINE (325, 230)-(350, 180)
LINE (315, 230)-(325, 230)
COLOR 4
LINE (310, 200)-(315, 205), , BF
LINE (325, 200)-(330, 205), , BF
LINE (315, 230)-(325, 280), , BF
END IF
IF Foename = "Snake of DOOM!" THEN
SCREEN 12
CIRCLE (320, 300), 45, 13
PAINT (320, 300), 13
COLOR 0
CIRCLE (320, 300), 45
CIRCLE (320, 270), 35, 13
PAINT (320, 250), 13
COLOR 0
CIRCLE (320, 270), 35
CIRCLE (320, 240), 25, 13
PAINT (320, 233), 13
COLOR 0
CIRCLE (320, 240), 25
COLOR 13
LINE (290, 180)-(350, 180)
LINE (290, 180)-(315, 230)
LINE (325, 230)-(350, 180)
LINE (315, 230)-(325, 230)
PAINT (320, 200), 13
COLOR 0
LINE (290, 180)-(350, 180)
LINE (290, 180)-(315, 230)
LINE (325, 230)-(350, 180)
LINE (315, 230)-(325, 230)
COLOR 4
LINE (310, 200)-(315, 205), , BF
LINE (325, 200)-(330, 205), , BF
LINE (315, 230)-(325, 280), , BF
END IF
IF Foename = "PANTERA55" THEN
SCREEN 12
COLOR 10
LINE (250, 160)-(390, 260), , BF
COLOR 10
LINE (280, 160)-(200, 210), , BF
LINE (360, 160)-(440, 210), , BF
LINE (180, 160)-(230, 280), , BF
LINE (410, 160)-(460, 280), , BF
CIRCLE (310, 120), 5
CIRCLE (330, 120), 5
COLOR 14
LINE (250, 260)-(390, 240), , BF
LINE (250, 260)-(310, 350), , BF
LINE (330, 260)-(390, 350), , BF
CIRCLE (320, 130), 50, 0
PAINT (320, 130), 0
COLOR 10
LINE (313, 120)-(313, 130)
LINE (313, 130)-(290, 110)
LINE (290, 110)-(313, 120)
LINE (327, 120)-(327, 130)
LINE (327, 130)-(350, 110)
LINE (350, 110)-(327, 120)
PAINT (310, 125), 10
PAINT (330, 125), 10
CIRCLE (320, 159), 20, 10
PAINT (320, 159), 10
COLOR 0
LINE (330, 350)-(360, 380)
LINE (360, 380)-(390, 350)
LINE (390, 350)-(330, 350)
PAINT (360, 360), 0
LINE (250, 350)-(280, 380)
LINE (280, 380)-(310, 350)
LINE (310, 350)-(250, 350)
PAINT (280, 360), 0
LINE (180, 280)-(205, 320)
LINE (205, 320)-(230, 280)
LINE (180, 280)-(230, 280)
PAINT (205, 290), 0
LINE (410, 280)-(435, 320)
LINE (435, 320)-(460, 280)
LINE (460, 280)-(410, 280)
PAINT (435, 290), 0
END IF
IF Foename = "Knight of DOOM!" THEN
SCREEN 12
COLOR 4
LINE (300, 60)-(340, 120), , BF
COLOR 12
LINE (300, 120)-(320, 100)
LINE (320, 100)-(340, 120)
LINE (300, 120)-(340, 120)
LINE (303, 80)-(337, 90), , BF
LINE (270, 120)-(370, 240), , BF
LINE (270, 240)-(250, 300)
LINE (250, 300)-(290, 380), , BF
LINE (290, 300)-(320, 240)
LINE (320, 240)-(370, 400), , BF
LINE (270, 120)-(160, 150), , BF
LINE (370, 120)-(430, 150), , BF
LINE (400, 150)-(430, 180), , BF
PAINT (280, 280), 12
COLOR 10
LINE (435, 130)-(375, 200), , BF
LINE (375, 200)-(405, 220)
LINE (405, 220)-(435, 200)
PAINT (405, 215), 10
LINE (140, 150)-(130, 260)
LINE (130, 260)-(150, 280)
LINE (150, 280)-(170, 260)
LINE (170, 260)-(160, 150)
LINE (160, 150)-(140, 150)
PAINT (150, 155), 10
COLOR 4
LINE (270, 240)-(370, 230), , BF
LINE (390, 150)-(420, 190), , BF
LINE (160, 120)-(140, 150), , BF
END IF

END SUB

SUB DrawScreen
CLS
SCREEN 12
COLOR 15
LINE (0, 0)-(639, 470), 1, BF
LOCATE 1, 1
PRINT CHR$(201);
LOCATE 1, 80
PRINT CHR$(187);
LOCATE 3, 1
PRINT CHR$(200);
LOCATE 3, 80
PRINT CHR$(188);
LOCATE 2, 1
PRINT CHR$(186);
LOCATE 2, 80
PRINT CHR$(186);
LOCATE 1, 2
PRINT STRING$(78, 205);
LOCATE 3, 2
PRINT STRING$(78, 205);
LOCATE 28, 1
PRINT STRING$(20, 176);
LOCATE 28, 21
PRINT STRING$(20, 177);
LOCATE 28, 41
PRINT STRING$(20, 178);
LOCATE 28, 61
PRINT STRING$(20, 219);
LOCATE 2, 2
PRINT "##@@@!!!FANTASY POWER ZONE  - FANTASY POWER ZONE  - FANTASY POWER ZONE!!!@@@##"
END SUB

SUB Dungeon1
SCREEN 12
x = 4
Y = 4

6
RANDOMIZE TIMER
Bloobus = INT(RND * 7) + 1
IF Bloobus = 1 THEN
RANDOMIZE TIMER
Sploobus = INT(RND * 2) + 1
IF Sploobus = 1 THEN
atktyp = "Bite"
Foename = "Snake"
CALL battle(50, 9, 8)
CLS
END IF
IF Sploobus = 2 THEN
atktyp = "Bite"
Foename = "Sneaky Snake"
CALL battle(75, 10, 9)
CLS
END IF
END IF
101 PAINT (1, 1), 5
LINE (20, 20)-(620, 460), 12, BF
LOCATE Y, x
COLOR 14
PRINT ""
LOCATE 28, 77
COLOR 13
PRINT ""
LOCATE 3, 4
PRINT " "
7

DO
a$ = INKEY$
IF a$ = CHR$(0) + "K" THEN x = x - 1: GOTO 7.5
IF a$ = CHR$(0) + "M" THEN x = x + 1: GOTO 7.5
IF a$ = CHR$(0) + "H" THEN Y = Y - 1: GOTO 7.5
IF a$ = CHR$(0) + "P" THEN Y = Y + 1: GOTO 7.5
IF a$ = CHR$(27) THEN END
IF a$ = CHR$(13) THEN
CALL Status
GOTO 101
END IF
LOOP

7.5
IF x = 3 THEN x = x + 1     '
IF x = 78 THEN x = x - 1    ' restrictions (borders)
IF Y = 2 THEN Y = Y + 1     '
IF Y = 29 THEN Y = Y - 1
IF x = 4 AND Y = 3 THEN CALL Town
IF x = 77 AND Y = 28 THEN
LOCATE 1, 1
COLOR 15
CLS
PRINT "BALLZAK XIV: I am a stupid idiot here to kill you hahaha. THIS IS SO DAMN LAME! WHY CAN'T I EVEN GET A CASTLE! THIS STINKS I QUIT!"
PLAY "N18L23N25l23n52l12O4ABACBBAO1CL23AL11CL62O5AL5BL3"
CALL InputWait
PRINT "YOU: No you can't! I didn't and you wont, I'm going to kill you! No one ruins   the author's plot but me!"
CALL InputWait
PRINT "SABIN24601: Great, here we go again, another rebellious monster. Please kill    him. This is a very bad trend."
CALL InputWait
atktyp = "Punch"
Foename = "Ballzak XIV"
CALL battle(100, 25, 25)
PRINT "SABIN24601: You beat the first dungeon! I bet it was just luck."
PLAY "O1L12BGBGEAO3L22BEBADGGEGADDFAAGL34ACAGAEADAFA"
CALL InputWait
PRINT "YOU: LUCK??? I BEAT HIM UP FAIR AND SQUARE!"
CALL InputWait
PRINT "SABIN24601: YEAH YEAH OK WHATEVER."
CALL InputWait
Dungeonnum = 2
CALL Town
END IF
GOTO 6



'ENTER = CHR$(13): ESC = CHR$(27): SPACE = CHR$(32)
'LEFT = CHR$(0) + "K": RIGHT = CHR$(0) + "M"
'UP = CHR$(0) + "H": DOWN = CHR$(0) + "P"
'F1 = CHR$(0) + ";": BKSPC = CHR$(8)
END SUB

SUB Dungeon2
SCREEN 12
x = 76
Y = 28

8
RANDOMIZE TIMER
Bloobus = INT(RND * 7) + 1
IF Bloobus = 1 THEN
RANDOMIZE TIMER
Sploobus = INT(RND * 2) + 1
IF Sploobus = 1 THEN
atktyp = "Sword"
Foename = "Swordman"
CALL battle(100, 15, 15)
CLS
END IF
IF Sploobus = 2 THEN
atktyp = "Sword"
Foename = "Dark Knight"
CALL battle(125, 20, 20)
CLS
END IF
END IF
102 PAINT (1, 1), 5
LINE (20, 20)-(620, 460), 12, BF
LOCATE Y, x
COLOR 14
PRINT ""
LOCATE 3, 4
COLOR 13
PRINT ""
LOCATE 28, 77
PRINT " "
9

DO
a$ = INKEY$
IF a$ = CHR$(0) + "K" THEN x = x - 1: GOTO 9.5
IF a$ = CHR$(0) + "M" THEN x = x + 1: GOTO 9.5
IF a$ = CHR$(0) + "H" THEN Y = Y - 1: GOTO 9.5
IF a$ = CHR$(0) + "P" THEN Y = Y + 1: GOTO 9.5
IF a$ = CHR$(27) THEN END
IF a$ = CHR$(13) THEN
CALL Status
GOTO 102
END IF
LOOP

9.5
IF x = 3 THEN x = x + 1     '
IF x = 78 THEN x = x - 1    ' restrictions (borders)
IF Y = 2 THEN Y = Y + 1     '
IF Y = 29 THEN Y = Y - 1
IF x = 77 AND Y = 28 THEN CALL Town
IF x = 4 AND Y = 3 THEN
LOCATE 1, 1
COLOR 15
CLS
PRINT "BALLZAK XIV: You can't kill me! Every time you do, the author will simply revive me to stop you!!!!"
PLAY "N18L23N25l23n52l12O4ABACBBAO1CL23AL11CL62O5AL5BL3"
CALL InputWait
PRINT "YOU: HEY! Thats not fair!"
CALL InputWait
PRINT "SABIN24601: It's perfectly fair, I can do anything, especially since you refuse to follow my plot!!! Kill him Ballzak XIV!"
CALL InputWait
atktyp = "Punch"
Foename = "Ballzak XIV"
CALL battle(150, 35, 35)
PRINT "SABIN24601: You beat the second dungeon! I bet you're cheating."
PLAY "O1L12BGBGEAO3L22BEBADGGEGADDFAAGL34ACAGAEADAFA"
CALL InputWait
PRINT "YOU: Am not!"
CALL InputWait
PRINT "SABIN24601: ARE TOO! I don't want to start a shouting match, get out of here!"
Dungeonnum = 3
CALL Town
END IF
GOTO 8



'ENTER = CHR$(13): ESC = CHR$(27): SPACE = CHR$(32)
'LEFT = CHR$(0) + "K": RIGHT = CHR$(0) + "M"
'UP = CHR$(0) + "H": DOWN = CHR$(0) + "P"
'F1 = CHR$(0) + ";": BKSPC = CHR$(8)

END SUB

SUB Dungeon3
SCREEN 12
x = 4
Y = 4

10
RANDOMIZE TIMER
Bloobus = INT(RND * 7) + 1
IF Bloobus = 1 THEN
RANDOMIZE TIMER
Sploobus = INT(RND * 6) + 1
IF Sploobus = 1 THEN
atktyp = "Punch"
Foename = "Tiny"
CALL battle(175, 30, 30)
CLS
END IF
IF Sploobus = 2 THEN
atktyp = "Punch"
Foename = "Mr. Small"
CALL battle(150, 40, 40)
CLS
END IF
END IF
103 PAINT (1, 1), 5
LINE (20, 20)-(620, 460), 12, BF
LOCATE Y, x
COLOR 14
PRINT ""
LOCATE 28, 77
COLOR 13
PRINT ""
LOCATE 3, 4
PRINT " "
11

DO
a$ = INKEY$
IF a$ = CHR$(0) + "K" THEN x = x - 1: GOTO 11.5
IF a$ = CHR$(0) + "M" THEN x = x + 1: GOTO 11.5
IF a$ = CHR$(0) + "H" THEN Y = Y - 1: GOTO 11.5
IF a$ = CHR$(0) + "P" THEN Y = Y + 1: GOTO 11.5
IF a$ = CHR$(27) THEN END
IF a$ = CHR$(13) THEN
CALL Status
GOTO 103
END IF
LOOP

11.5
IF x = 3 THEN x = x + 1     '
IF x = 78 THEN x = x - 1    ' restrictions (borders)
IF Y = 2 THEN Y = Y + 1     '
IF Y = 29 THEN Y = Y - 1
IF x = 4 AND Y = 3 THEN CALL Town
IF x = 77 AND Y = 28 THEN
LOCATE 1, 1
COLOR 15
CLS
PRINT "BALLZAK XIV: Guess who's back loser!"
PLAY "N18L23N25l23n52l12O4ABACBBAO1CL23AL11CL62O5AL5BL3"
CALL InputWait
PRINT "YOU: Oh shut up. Sabin24601, you have absolutley no imagination."
CALL InputWait
PRINT "SABIN24601: I think I have to much, I let THIS happen!"
CALL InputWait
atktyp = "Punch"
Foename = "Ballzak XIV"
CALL battle(300, 55, 55)
PRINT "SABIN24601: You beat the third dungeon! I think its about time I kicked you butt."
PLAY "O1L12BGBGEAO3L22BEBADGGEGADDFAAGL34ACAGAEADAFA"
CALL InputWait
PRINT "YOU: You mean YOU intend to kick MY Butt?!?! I Don't Think So!"
CALL InputWait
PRINT "SABIN24601: Wait and see, foolish one."
CALL InputWait
Dungeonnum = 4
CALL Town
END IF
GOTO 10



'ENTER = CHR$(13): ESC = CHR$(27): SPACE = CHR$(32)
'LEFT = CHR$(0) + "K": RIGHT = CHR$(0) + "M"
'UP = CHR$(0) + "H": DOWN = CHR$(0) + "P"
'F1 = CHR$(0) + ";": BKSPC = CHR$(8)

END SUB

SUB Dungeon4
SCREEN 12
x = 76
Y = 28

12
RANDOMIZE TIMER
Bloobus = INT(RND * 7) + 1
IF Bloobus = 1 THEN
RANDOMIZE TIMER
Sploobus = INT(RND * 2) + 1
IF Sploobus = 1 THEN
atktyp = "Sword"
Foename = "Knight of DOOM!"
CALL battle(300, 75, 55)
CLS
END IF
IF Sploobus = 2 THEN
atktyp = "Bite"
Foename = "Snake of DOOM!"
CALL battle(300, 55, 75)
CLS
END IF
END IF
104 PAINT (1, 1), 5
LINE (20, 20)-(620, 460), 12, BF
LOCATE Y, x
COLOR 14
PRINT ""
LOCATE 3, 4
COLOR 13
PRINT ""
LOCATE 28, 77
PRINT " "
13

DO
a$ = INKEY$
IF a$ = CHR$(0) + "K" THEN x = x - 1: GOTO 13.5
IF a$ = CHR$(0) + "M" THEN x = x + 1: GOTO 13.5
IF a$ = CHR$(0) + "H" THEN Y = Y - 1: GOTO 13.5
IF a$ = CHR$(0) + "P" THEN Y = Y + 1: GOTO 13.5
IF a$ = CHR$(27) THEN END
IF a$ = CHR$(13) THEN
CALL Status
GOTO 104
END IF
LOOP

13.5
IF x = 3 THEN x = x + 1     '
IF x = 78 THEN x = x - 1    ' restrictions (borders)
IF Y = 2 THEN Y = Y + 1     '
IF Y = 29 THEN Y = Y - 1
IF x = 77 AND Y = 28 THEN CALL Town
IF x = 4 AND Y = 3 THEN
LOCATE 1, 1
COLOR 15
CLS
PRINT "YOU: Ok Ballzak XIV! To heck with mindless chatter! Show yourself!!!"
PLAY "N18L23N25l23n52l12O4ABACBBAO1CL23AL11CL62O5AL5BL3"
CALL InputWait
PRINT "SABIN24601: Ballzak isn't coming today. But someone else is."
CALL InputWait
PRINT "YOU: Oh? Then who is, maybe Ballzak XV!!! Or Ballzaks 2 though 13????"
CALL InputWait
PRINT "SABIN24601: No, but my Co-Author is. Say hello to Pantera55!!!!"
CALL InputWait
atktyp = "Punch"
Foename = "PANTERA55"
CALL battle(400, 100, 100)
PRINT "SABIN24601: NOOOOO! How could this be????? You killed my co-author!!! NOW       What'll I do??????"
PLAY "O1L12BGBGEAO3L22BEBADGGEGADDFAAGL34ACAGAEADAFA"
CALL InputWait
PRINT "YOU: GIMMIE BACK MY CASTLE!!!!!!"
CALL InputWait
PRINT "SABIN24601: ABSOLUTLEY NOT! You'll never see your precious castle again, I'm too lazy to make the graphics, and my Co-Author can't because you killed him!!! As punishment, this Game ends NOW!!!!!"
PRINT "                             THE END"
CALL InputWait
CLS
PRINT "                             CREDITS"
PRINT "Main Programming and a few lousy graphics: Sabin24601 (Sam Kaplan)"
PRINT "Cool graphics and a little programming: PANTERA55 (Anthony Figliuzzi)"
PRINT "Really Neato music and Game Tester: Shadow532 (Anonymous)"
PRINT "Superlevel Code: Backspace during town scene (<---Backspace)"
PRINT "100 Gold code: F1 during town scene (F1)"
PLAY "O1L12BGBGEAO3L22BEBADGGEGADDFAAGL34ACAGAEADAFA"
PLAY "O2L21C<CA>GL18EGDC>CA>GEG"
PLAY "O1L17BEBAL20BABECBAGGFEFBACL10BAGECDAL31BEBEBEGL14EEAGBBACFE"
PLAY "L41CCAL21BEDL11O4AGAFDEB"
PLAY "N18L23N25l23n52l12O4ABACBBAO1CL23AL11CL62O5AL5BL3"
PLAY "L21BEACAO1CEAO5EAGG"
PRINT "Thank you for playing! Send me feedback OR ELSE!!!!!!!!!"
END
END IF
GOTO 12



'ENTER = CHR$(13): ESC = CHR$(27): SPACE = CHR$(32)
'LEFT = CHR$(0) + "K": RIGHT = CHR$(0) + "M"
'UP = CHR$(0) + "H": DOWN = CHR$(0) + "P"
'F1 = CHR$(0) + ";": BKSPC = CHR$(8)

END SUB

SUB FoeAttack
IF atktyp = "Punch" THEN
CIRCLE (150, 320), 70, 4
PAINT (150, 320), 4
CIRCLE (150, 330), 50, 14
PAINT (150, 330), 14
CIRCLE (150, 350), 55, 9
PAINT (150, 350), 9
SOUND 50, 5
FOR s = 1 TO 90
CIRCLE (150, 350), s, 12
SOUND 200 + s - s, .06
NEXT s
END IF
IF atktyp = "Bite" THEN
LINE (120, 120)-(280, 120), 4
LINE (120, 120)-(160, 200), 4
LINE (160, 200)-(200, 120), 4
LINE (200, 120)-(240, 200), 4
LINE (240, 200)-(280, 120), 4
PAINT (160, 160), 4
PAINT (240, 160), 4
LINE (120, 460)-(360, 460), 4
LINE (120, 460)-(160, 380), 4
LINE (160, 380)-(200, 460), 4
LINE (280, 460)-(320, 380), 4
LINE (320, 380)-(360, 460), 4
PAINT (160, 440), 4
PAINT (320, 440), 4
END IF
IF atktyp = "Sword" THEN
LINE (110, 0)-(50, 300), 8
LINE (50, 300)-(160, 350), 8
LINE (160, 350)-(270, 300), 8
LINE (270, 300)-(210, 0), 8
LINE (110, 0)-(210, 0), 8
PAINT (160, 20), 8
LINE (160, 0)-(160, 350), 0
END IF
END SUB

SUB Inn
CLS
DO
LOCATE 1, 1
cost = level * 25
PRINT "would ye wish to stay at mine inn? The cost would be "; cost; " gold coins. do ye wish to stay?"
INPUT "1.yes/2.no"; choice
LOOP UNTIL choice = 1 OR choice = 2
IF choice = 1 THEN
IF cost > gold THEN PRINT "YOU CHEAPSKATE! YOU DONT HAVE THAT MUCH MONEY!!!"
IF cost <= gold THEN
PLAY "O2L21C<CA>GL18EGDC>CA>GEG"
gold = gold - cost
currhp = hp
currmp = mp
OPEN "Fpz.sav" FOR OUTPUT AS #1
WRITE #1, gold, hp, magic, level, Dungeonnum, wepower, armpower, strb, defen2, totxp, armor, weapon: CLOSE
PRINT "Thou art rested, and ready to return to thy quest, and thine game is saved."
CALL InputWait
END IF
END IF
PAINT (1, 1), 8
LINE (20, 20)-(620, 460), 10, BF
END SUB

SUB InputWait
DO
LOOP UNTIL INKEY$ <> ""
END SUB

SUB Intro
SCREEN 12
PAINT (1, 1), 1
COLOR 14
LINE (20, 20)-(620, 460), , BF
COLOR 4
LINE (0, 0)-(660, 480)
PAINT (1, 470), 4
COLOR 1
LINE (100, 100)-(130, 250), , BF
LINE (100, 100)-(200, 130), , BF
LINE (100, 160)-(180, 190), , BF
LINE (270, 100)-(370, 130), , BF
LINE (305, 100)-(335, 250), , BF
LINE (270, 220)-(370, 250), , BF
LINE (440, 100)-(540, 130), , BF
LINE (440, 100)-(470, 250), , BF
LINE (470, 250)-(540, 220), , BF
LINE (540, 250)-(510, 200), , BF
LINE (540, 200)-(490, 170), , BF
COLOR 15
LOCATE 23, 20
PRINT "PROUDLY PRESENTS FANTASY POWER ZONE"
CALL InputWait
FOR sizers = 0 TO 320 STEP 1
CIRCLE (320, 240), sizers, 0, , , .9
SOUND 100 + (sizers * .8), .04
LINE (sizers, 0)-(sizers, 480), 0, B
LINE (640 - sizers, 0)-(640 - sizers, 480), 0, B
NEXT sizers
COLOR 2                          ' The text will be black, so I change it.
CLS                              ' Clears screen of the message question
SCREEN 13  ' Lets you use 256 colors
PLAY "MBMSL8gfegfegfefefefefefL2eL8fL2eL8fL2eL8fL2eL8fL2e"
FOR col = 16 TO 31               ' Sets the colors to dark grey through white
COLOR col                        ' Makes the color = col (16 to 31)
FOR dela = 1 TO 20              ' Makes text show up slow. Add more for slower
LOCATE 1, 1                      ' Prints the text in the same spot each time
PRINT "Fantasy Power Zone"
NEXT dela                       ' Starts the delay loop for the text
NEXT col                         ' Starts with the next text color
SCREEN 13                        ' Lets you use 256 colors
FOR col = 31 TO 16 STEP -1       ' The colors white to dark grey
COLOR col                        ' Makes the color = col (16 to 31)
FOR dela = 1 TO 20              ' Makes text show up slow. Add more for slower
LOCATE 1, 1                      ' Prints the text in the same spot each time
PRINT "Fantasy Power Zone"
NEXT dela                       ' Starts the delay loop for the text
NEXT col
FOR t = 1 TO 15
COLOR t
FOR Y = 1 TO 10
PRINT " Fantasy Power Zone Fantasy Power Zone"   ' Puts text on screen
NEXT Y                   ' Makes the whole thing change color
NEXT t                   ' Makes text change to next color, in order ( 1,2..)
SCREEN 12
CLS
DO
PAINT (320, 240), 5
FOR a% = 150 TO 400
RANDOMIZE TIMER
B% = INT(RND * 13)
CIRCLE (320, 240), a%, B%
NEXT a%
LOCATE 15, 24
PRINT "Welcome to the Fantasy Power Zone"
LOOP UNTIL INKEY$ <> ""
CLS
DO
LOCATE 1, 1
INPUT "Watch the story? 1.Yes/2.No:", CHOOSE
LOOP UNTIL CHOOSE = 1 OR CHOOSE = 2
IF CHOOSE = 1 THEN
SCREEN 12
LOCATE 1, 1
PAINT (480, 240), 11, 10
PLAY "MBMSL8<<<gbgbbL16gbL8gbcbaL16aggabb"
PRINT "So far your day has been REALLY lousy. First, a deranged band of monsters blow  up your castle while you're away."
CALL delay
FOR E% = 60 TO 80
CIRCLE (320, 360), E%, 6
NEXT E%
CIRCLE (290, 320), 10, 5
CIRCLE (350, 320), 10, 5
CIRCLE (320, 400), 20, 5
PLAY "MBMSL8g<eee>g<efeL4dL16dcdcdcb"
PRINT "Second, a ball-like creature named Bando keeps laughing at you and calling you a loser because your castle blew up."
CALL delay
PLAY "MBMS>>>>L8bgcbcba"
PRINT "The fiends who did this must pay. There's only 1 thing to do..."
CALL delay
PLAY "MBMSL8g<eee>g<efeL4dL16dcdcdcb"
PRINT "Knock down their castle and laugh at them!!!!!!!!!!!!!!!! But First, lets attend to Bando, shall we???? Hit a key to DESTROY BANDO!"
CALL InputWait
SCREEN 8, 0  'My favorite
PAINT (1, 1), 14 'whole screen
LINE (50, 20)-(590, 180), 1, BF 'box inside
CIRCLE (600, 140), 70, 10
PAINT (600, 140), 10
CIRCLE (600, 100), 30, 13
PAINT (600, 100), 6, 13
CIRCLE (585, 94), 6, 0
PAINT (585, 94), 0
CIRCLE (615, 94), 6, 0
PAINT (615, 94), 0
CIRCLE (600, 106), 10, 0
PAINT (600, 106), 0
PCOPY 0, 1  'From video screen 0 to 1 without erasing
FOR g = 1 TO 600 STEP 7  'g moves picture across y axis (is the x coordinates)

CIRCLE (g, 100), 20, 4 'circle    '
COLOR 12                          '
LINE (g, 93)-(g, 107)             '
LINE (g, 93)-(g - 130, 100)       '   All of this is the picture I'm drawing
LINE -(g, 107)                    '   G is going to move across the screen
PAINT (g - 1, 100), 12            '   because I made a FOR statement 1 to 600
COLOR 4                           '
LINE (g + 11, 92)-(g - 20, 86)    '   using (g + 21) and (g - 45) makes the
LINE -(g - 15, 90)                '   picture wider
LINE -(g - 70, 100)               '   The y coordinate is always the same
LINE -(g - 15, 110)               '   so you dont need a FOR statement for
LINE -(g - 20, 114)               '   your Y coordinates (although you can)
LINE -(g + 11, 108)               '
PAINT (g, 100), 4                 '
PAINT (g - 30, 100), 4            '
LINE (g - 20, 86)-(g - 60, 86)    '
LINE (g - 70, 100)-(g - 110, 100) '
LINE (g - 20, 114)-(g - 60, 114)  '
PCOPY 1, 0
NEXT g
SCREEN 12
CALL DrawFoe
PLAY "MBMSL8<<<<<gbgbbL16gbL8gbcbaL16aggabb"
PRINT "That'll shut him up good. Wait a minute... OH NO! It's Bando's Bigger Meaner    brother Ballzak!"
CALL delay
PLAY "MBMSL8g<eee>g<efeL4dL16dcdcdcb"
PRINT "'You Meanie! You killed my brother! Prepare to die!'"
CALL delay
PRINT "Thats what you think BALL BRAIN!"
PLAY "MFMS>>>>L8bgcbcbaabcbabag"
CALL InputWait
END IF
INPUT "Load game? 1.Yes/2.No", ysn
IF ysn = 1 THEN
OPEN "Fpz.sav" FOR INPUT AS #1
INPUT #1, gold, hp, magic, level, Dungeonnum, wepower, armpower, strb, defen2, totxp, armor, weapon: CLOSE
currhp = hp: currmp = magic
defense = defen2 + armpower
str = wepower + strb
CALL Town
END IF
END SUB

SUB Lvlchk
IF totxp >= (200 * level) + (125 * level / 3) + (50 * level / 2) THEN
PRINT "Congratulations!!!"
PLAY "O1L17BEBAL20BABECBAGGFEFBACL10BAGECDAL31BEBEBEGL14EEAGBBACFE"
level = level + 1
CLS
PRINT "Thou hast raised a level!"
CALL InputWait
MakeChr (10)
END IF
END SUB

SUB MakeChr (left)
100 DO
CLS
PRINT "Strength:"; strb; "   Defense:"; defen2; "   Magic:"; magic; "   Remaining Points:"; left
INPUT "Which atribute?(str.1, def.2, mag.3)", choice
LOOP UNTIL choice > 0 AND choice < 4
INPUT "How much into this ability?", HM
IF HM > left THEN
PRINT "You dont have that many!"
CALL InputWait
ELSE
IF HM <= left THEN
SELECT CASE choice
CASE 1
strb = HM + strb
left = left - HM
CASE 2
defen2 = HM + defen2
left = left - HM
CASE 3
magic = HM + magic
left = left - HM
END SELECT
END IF
END IF
choice = 0
IF left > 0 THEN GOTO 100
CLS
RANDOMIZE TIMER
hp = hp + (INT(RND * 20) + 30)
PRINT "Your final Stats are:"
PRINT "Strength:"; strb; "   Defense:"; defen2; "   Magic:"; magic; "   HP:"; hp
PRINT "Weapon:"; weapon; "   Armor:"; armor; "   Gold:"; gold
PRINT
PRINT "Return now to thy game....."
str = strb + wepower
defense = defen2 + armpower
currhp = hp
currmp = magic
END SUB

SUB MoveScreen
SCREEN 8
CLS
x% = 1
Y% = 1
299
CLS
LOCATE x%, Y%
PRINT CHR$(2)
DO
move$ = INKEY$
LOOP UNTIL move$ = "8" OR move$ = "6" OR move$ = "4" OR move$ = "2" OR move$ = "5"
SELECT CASE move$
CASE "2"
x% = x% + 1
GOTO 298
CASE "4"
Y% = Y% - 1
GOTO 298
CASE "6"
Y% = Y% + 1
GOTO 298
CASE "8"
x% = x% - 1
GOTO 298
CASE "5"
LOCATE 1, 1
PRINT "Goodbye"
GOTO 297
END SELECT
298
IF x% > 23 THEN x% = 23
IF x% < 1 THEN x% = 1
IF Y% > 79 THEN Y% = 79
IF Y% < 1 THEN Y% = 1
GOTO 299
297
END SUB

SUB MyHelp
'From PANTERA55 (FIG)

'Here are some tricks for QBasic

'First of all, I was a LOT worse than you when I first attempted to make a
'QBasic game.  The games were so bad that I erased them from my hard drive.

'Now, I should tell you the first QBasic secret:
'Screen 7, 8 and 9 are the best
'I like screen 8 most (640 x 200) because you can have three things moving at
'the same time (which I don't use yet, but I plan to).
'Screen 13 is good for colors ONLY!
'Screens 7, 8 and 9 allow the use of PCOPY (I'll show you how more down on
'this file).  PCOPY allows you to move things across the screen without having
'to GET or PUT it, and it doesn't copy over your background.  The only problem
'is that the thing that you are PCOPYing flashes a bit

'Second secret:
'Palettes allow you to make more than 256 colors anyways.  In fact, there are
'over 250,000 colors using palettes


SCREEN 8, 0  'My favorite

PAINT (1, 1), 14 'whole screen
LINE (50, 20)-(590, 180), 1, BF 'box inside

PCOPY 0, 1  'From video screen 0 to 1 without erasing
FOR g = 1 TO 600 STEP 7  'g moves picture across y axis (is the x coordinates)
CIRCLE (g, 100), 20, 4 'circle    '
COLOR 12                          '
LINE (g, 93)-(g, 107)             '
LINE (g, 93)-(g - 130, 100)       '   All of this is the picture I'm drawing
LINE -(g, 107)                    '   G is going to move across the screen
PAINT (g - 1, 100), 12            '   because I made a FOR statement 1 to 600
COLOR 4                           '
LINE (g + 11, 92)-(g - 20, 86)    '   using (g + 21) and (g - 45) makes the
LINE -(g - 15, 90)                '   picture wider
LINE -(g - 70, 100)               '   The y coordinate is always the same
LINE -(g - 15, 110)               '   so you dont need a FOR statement for
LINE -(g - 20, 114)               '   your Y coordinates (although you can)
LINE -(g + 11, 108)               '
PAINT (g, 100), 4                 '
PAINT (g - 30, 100), 4            '
LINE (g - 20, 86)-(g - 60, 86)    '
LINE (g - 70, 100)-(g - 110, 100) '
LINE (g - 20, 114)-(g - 60, 114)  '
PCOPY 1, 0
NEXT g

COLOR 15
PRINT "THAT WAS PCOPY"

'Neat, eh?

'Now, here's a y - FOR statement one:

PCOPY 0, 1
FOR Y = 1 TO 200 STEP 1
CIRCLE (320, Y), 20, 4
PAINT (320, Y), 4
PCOPY 1, 0
NEXT Y

PRINT "THAT WAS PCOPY GOING UP AND DOWN"

delay   'This is a time sub


'That's PCOPY.

'Now, here are some more tricks

CLS
COLOR 15
PRINT "HERE'S SOME MORE"

CIRCLE (320, 100), 20, 4, , , .34     '.34 warps the circle
delay
PRINT "Ovals ANY WAY"
delay
SLEEP

CLS
PRINT "NOW, A GOOD GAME MUST HAVE SOUND"
delay
FOR s = 1 TO 4000 STEP 10    'for statements work anywhere
SOUND 200 + s, .06           'sound 200 + s (1 to 4000), .06 is the length
NEXT s                       'Next always at end of FOR statement
delay
delay
PRINT "THAT WAS USING 'SOUND' STATEMENT"
delay
delay

PLAY "l9o2el6o1el8el10o2eo1bl6a#"   ' Enter Sandman Notes
PLAY "l9o2el6o1el8el10o2eo1bl6a#"
PLAY "l9o2el6o1el8el10o2eo1bl6a#"
PLAY "l7o1egl9ef#gf#gf#l5eL9e"
PLAY "l10o2eo1bl6a#"
delay
delay
PRINT "THAT WAS USING 'PLAY' STATEMENT (USUALLY FOR MUSIC)"
PRINT "CHECK PLAY UNDER HELP FOR ALL OF THE COMMANDS"
delay
delay
SLEEP

CLS

PRINT "I could show you more (LIKE GET AND PUT), but your game doesn't use"
PRINT "those things, I think (If it does, e-mail me)."
PRINT "Sounds are important, as are graphics, but the most important part"
PRINT "of a game is the storyline.  Make sure that you put a storyline into the game"
PRINT "That's it for now!"


END SUB

SUB Snd (whichsound, length, length2)
FOR s = 1 TO length2 STEP 10
SOUND whichsound + s, length
NEXT s
END SUB

SUB Status
CLS
PRINT "HP: "; currhp; "/"; hp; ""
PRINT "MP: "; currmp; "/"; magic; ""
PRINT "LEVEL: "; level
PRINT "STRENGTH: "; str
PRINT "DEFENSE: "; defense
PRINT "WEAPON: "; weapon
PRINT "ARMOR: "; armor
PRINT "GOLD: "; gold
PRINT "EXPERIENCE: "; totxp
CALL InputWait
END SUB

SUB Sword
SCREEN 12
LINE (310, 480)-(310, 180), 8
LINE (310, 180)-(360, 130), 8
LINE (360, 130)-(410, 180), 8
LINE (410, 180)-(410, 480), 8
LINE (310, 480)-(410, 480), 8
PAINT (360, 440), 8
LINE (360, 480)-(360, 130), 0
END SUB

SUB Town
SCREEN 12
x = 40
Y = 20

11111
PAINT (1, 1), 8
LINE (20, 20)-(620, 460), 10, BF

1
COLOR 15
LOCATE 7, 37
PRINT "ÛÛÛ"
LOCATE 8, 37
PRINT "Û Û  Fantasy Power Zone"

LOCATE 14, 26
PRINT "ÛÛÛ"
LOCATE 15, 26
PRINT "Û Û  Inn"

LOCATE 18, 57
PRINT "ÛÛÛ"
LOCATE 19, 57
PRINT "Û Û  Weaponry"

LOCATE 22, 9
PRINT "ÛÛÛ"
LOCATE 23, 9
PRINT "Û Û  Armory"

LOCATE 25, 46
PRINT "ÛÛÛ"
LOCATE 26, 46
PRINT "Û Û  Wise Man"

LOCATE Y, x
COLOR 1
PRINT ""

2

DO
a$ = INKEY$
IF a$ = CHR$(0) + "K" THEN LOCATE Y, x: COLOR 10: PRINT "Û": x = x - 1: GOTO 2.5
IF a$ = CHR$(0) + "M" THEN LOCATE Y, x: COLOR 10: PRINT "Û": x = x + 1: GOTO 2.5
IF a$ = CHR$(0) + "H" THEN LOCATE Y, x: COLOR 10: PRINT "Û": Y = Y - 1: GOTO 2.5
IF a$ = CHR$(0) + "P" THEN LOCATE Y, x: COLOR 10: PRINT "Û": Y = Y + 1: GOTO 2.5
IF a$ = CHR$(27) THEN END
IF a$ = CHR$(8) THEN
MakeChr (50)
GOTO 11111
END IF
IF a$ = CHR$(13) THEN
CALL Status
GOTO 11111
END IF
IF a$ = CHR$(0) + ";" THEN gold = gold + 100
LOOP

2.5
IF x = 3 THEN x = x + 1     '
IF x = 78 THEN x = x - 1    ' restrictions (borders)
IF Y = 2 THEN Y = Y + 1     '
IF Y = 29 THEN Y = Y - 1    '
                           
IF x = 47 AND Y = 26 THEN CALL Wiseguy
IF x = 38 AND Y = 8 THEN
PLAY "L21BEACAO1CEAO5EAGG"
IF Dungeonnum = 1 THEN CALL Dungeon1
IF Dungeonnum = 2 THEN CALL Dungeon2
IF Dungeonnum = 3 THEN CALL Dungeon3
IF Dungeonnum = 4 THEN CALL Dungeon4
END IF
IF x = 27 AND Y = 15 THEN CALL Inn
IF x = 10 AND Y = 23 THEN CALL Ashop
IF x = 58 AND Y = 19 THEN CALL Wshop
                            ' Now this is where you have to put the
                            'coordinates for the doors.  If you want me
                            'to do it, I can, but e-mail me back on Saturday
                            'or else it'll take another week


GOTO 1



'ENTER = CHR$(13): ESC = CHR$(27): SPACE = CHR$(32)   ' These are the keys
'LEFT = CHR$(0) + "K": RIGHT = CHR$(0) + "M"          'codes.  You should use
'UP = CHR$(0) + "H": DOWN = CHR$(0) + "P"             'SPACE or ENTER as a
'F1 = CHR$(0) + ";": BKSPC = CHR$(8)                  'status screen like in
                                                      'HELLPIT
END SUB

SUB Wiseguy
CLS
PRINT "*********************************WISE MAN'S HUT*********************************"
PRINT "Closed, due to death of the wise man."
CALL InputWait
PRINT "YOU: DANG! I wanted his advice!"
CALL InputWait
PRINT "SABIN24601: If you hadn't ruined my plot I wouldn't have run over him with a    Jeep! Pick your foes wisely goofus!"
CALL InputWait
PRINT "YOU: Give it a rest! No one cares about your plot, now gimmie back my castle!"
CALL InputWait
PRINT "SABIN24601: ENOUGH MINDLESS CHATTER! YOU WILL GO INTO THE FANTASY POWER ZONE AND KILL STUFF NOW!"
CALL InputWait
PRINT "YOU: Whats with this Fantasy Power Zone anyway, what IS it?"
CALL InputWait
PRINT "SABIN24601: It is the ghost of a dead plot. NOW GET OUT OF THIS HUT."
CALL InputWait
CLS
PAINT (1, 1), 8
LINE (20, 20)-(620, 460), 10, BF
END SUB

SUB Wshop
CLS
SCREEN 12
PAINT (1, 1), 11
PRINT "YE OLDE WEAPON SHOPE"
LINE (60, 60)-(70, 90), 6, BF
LINE (40, 90)-(90, 100), 6, BF
DRAW "C9 BM55, 100 D50 F10 E10 U50"
DO
LOCATE 12, 1
PRINT "What weapon shall ye be needing?"
PRINT "1.Shortsword 250GOLD"
PRINT "2.Longsword 550GOLD"
PRINT "3.Q-Sword 1150GOLD"
PRINT "4.Spirit Sword 2000GOLD"
PRINT "5.Nothing"
INPUT choice
LOOP UNTIL choice = 1 OR choice = 2 OR choice = 3 OR choice = 4 OR choice = 5
IF choice = 1 THEN
IF 250 > gold THEN PRINT "YOU CHEAPSKATE! YOU DONT HAVE THAT MUCH MONEY!!!"
IF 250 <= gold THEN
gold = gold - 250
weapon = "ShortSword"
wepower = 10
END IF
END IF
IF choice = 2 THEN
IF 550 > gold THEN PRINT "YOU CHEAPSKATE! YOU DONT HAVE THAT MUCH MONEY!!!"
IF 550 <= gold THEN
gold = gold - 550
weapon = "LongSword"
wepower = 20
END IF
END IF
IF choice = 3 THEN
IF 1150 > gold THEN PRINT "YOU CHEAPSKATE! YOU DONT HAVE THAT MUCH MONEY!!!"
IF 1150 <= gold THEN
gold = gold - 1150
weapon = "Q-Sword"
wepower = 30
END IF
END IF
IF choice = 4 THEN
IF 2000 > gold THEN PRINT "YOU CHEAPSKATE! YOU DONT HAVE THAT MUCH MONEY!!!"
IF 2000 <= gold THEN
gold = gold - 2000
weapon = "SpiritSword"
wepower = 40
END IF
END IF
IF choice = 5 THEN
PRINT "Hey! No browsing! If you're not gonna buy anything then GET OUT!"
CALL InputWait
END IF
str = strb + wepower
PAINT (1, 1), 8
LINE (20, 20)-(620, 460), 10, BF
END SUB

