REM***************Advanced Dungeons $ Dragons Character Creator***************
REM                   By: Michael Robert Killoren (May 1994)
CLS
PRINT : PRINT : PRINT : PRINT : PRINT : PRINT : PRINT : PRINT : PRINT
PRINT "            Advanced Dungeons $ Dragons Character Creator"
PRINT "               By: Michael Robert Killoren (May 1994)"
1 REM ** GOSUB MUSIC **
GOSUB 100
REM ** GOSUB QUESTION **
GOSUB 200
REM ** GOSUB SEX **
GOSUB 300
REM ** GOSUB NAME **
GOSUB 400
REM ** GOSUB RACE **
GOSUB 500
REM ** GOSUB CLASS **
IF RA$ = "Human" THEN GOSUB 600
IF RA$ = "Dwarf" THEN GOSUB 700
IF RA$ = "Elf" THEN GOSUB 800
IF RA$ = "Gnome" THEN GOSUB 900
IF RA$ = "Half-Elf" THEN GOSUB 1000
IF RA$ = "Halfling" THEN GOSUB 1100
REM ** GOSUB ABILITY GENERATOR **
GOSUB 1200
REM ** GOSUB ALIGNMENT **
GOSUB 1300
REM ** DEFINE CLASS VARIABLE **
GOSUB 1400
REM ** GOSUB DISPLAY **
GOSUB 1500
REM ** GOSUB PRINT QUESTION **
GOSUB 1600
REM ** GOSUB PRINT OUT **
GOSUB 1700
REM ** RESTART **
GOTO 1
REM____________________________________________________________________________________________________________________
REM ** MUSIC SUB-PROGRAM **
100 mus$ = "MB D E F D G E F E G E F E G D C A G D E D B C B G G F C E D G A A# A D A A# A D G G# G C G G# G C A# D# G1"
PLAY mus$
RETURN
REM___________________________________________________________________________________________________________________________________________
REM ** QUESTION SUB-PROGRAM **
200 CLS
210 PRINT "Would you like to make a Dungeons and Dragons Character?"
INPUT W$
IF W$ = "Y" THEN RETURN
IF W$ = "y" THEN RETURN
IF W$ = "N" THEN END
IF W$ = "n" THEN END
CLS : PRINT "Please type Y or N and press ENTER"
GOTO 210
REM__________________________________________________________________________________________________________________________________________
REM ** SEX SUB-PROGRAM **
300 CLS
PRINT "1. Male"
PRINT "2. Female"
PRINT "Please type the NUMBER of your choice and press ENTER."
INPUT "What sex would you like your character to be"; N
IF N = 1 THEN SEX$ = "Male": RETURN
IF N = 2 THEN SEX$ = "Female": RETURN
GOTO 300
REM_____________________________________________________________________________________________________________________________________
REM ** NAME SUB-PROGRAM **
400 CLS
410 PRINT "What would you like to name your character?"
INPUT NAM$
PRINT "Is this correct?"
INPUT CO$
IF CO$ = "Y" OR CO$ = "y" THEN RETURN
IF CO$ = "N" OR CO$ = "n" THEN CLS : GOTO 400
CLS : PRINT "Please type Y or N and press ENTER."
GOTO 410
REM_____________________________________________________________________________________________________________________________________
REM ** RACE SUB-PROGRAM **
500 CLS
PRINT "1. Human"
PRINT "2. Dwarf"
PRINT "3. Elf"
PRINT "4. Gnome"
PRINT "5. Half-Elf"
PRINT "6. Halfling"
PRINT "Please type the NUMBER of your choice and press ENTER."
INPUT "What race would you like your character to be"; N
IF N = 1 THEN RA$ = "Human"
IF N = 2 THEN RA$ = "Dwarf"
IF N = 3 THEN RA$ = "Elf"
IF N = 4 THEN RA$ = "Gnome"
IF N = 5 THEN RA$ = "Half-Elf"
IF N = 6 THEN RA$ = "Halfling"
IF N = 1 OR N = 2 OR N = 3 OR N = 4 OR N = 5 OR N = 6 THEN RETURN
GOTO 500
REM________________________________________________________________________________________________________
REM ** CLASS SUB-PROGRAM (Human) **
600 CLS
PRINT "1. Fighter"
PRINT "2. Paladin"
PRINT "3. Ranger"
PRINT "4. Magic User"
PRINT "5. Cleric"
PRINT "6. Druid"
PRINT "7. Thief"
PRINT "8. Bard"
PRINT "Please type the NUMBER of the class which you desire and press ENTER."
INPUT "What class would you like your character to be"; N
IF N = 1 THEN C$ = "F": B$ = "F"
IF N = 2 THEN C$ = "P": B$ = "F"
IF N = 3 THEN C$ = "R": B$ = "F": R$ = "Y"
IF N = 4 THEN C$ = "M": B$ = "R": M$ = "Y"
IF N = 5 THEN C$ = "C": B$ = "R": Cl$ = "Y"
IF N = 6 THEN C$ = "D": B$ = "R": D$ = "Y"
IF N = 7 THEN C$ = "T": B$ = "R": T$ = "Y"
IF N = 8 THEN C$ = "B": B$ = "R"
IF N = 1 OR N = 2 OR N = 3 OR N = 4 OR N = 5 OR N = 6 OR N = 7 OR N = 8 THEN RETURN
GOTO 600
REM_______________________________________________________________________________________________________
REM ** CLASS SUB-PROGRAM (Dwarf) **
700 CLS
PRINT "1. Fighter"
PRINT "2. Cleric"
PRINT "3. Thief"
PRINT "4. Fighter/Cleric"
PRINT "5. Fighter/Thief"
PRINT "Please type the NUMBER of the class you desire and press ENTER."
INPUT "What class would you like your character to be"; N
8 IF N = 1 THEN C$ = "F": B$ = "F"
IF N = 2 THEN C$ = "C": B$ = "R": Cl$ = "Y"
IF N = 3 THEN C$ = "T": B$ = "R": T$ = "Y"
IF N = 4 THEN C$ = "F/C": B$ = "F": Cl$ = "Y"
IF N = 5 THEN C$ = "F/T": B$ = "F": T$ = "Y"
IF N = 1 OR N = 2 OR N = 3 OR N = 4 OR N = 5 THEN RETURN
GOTO 700
REM_____________________________________________________________________________________________________
REM ** CLASS SUB-PROGRAM (Elf) **
800 CLS
PRINT "1. Fighter"
PRINT "2. Ranger"
PRINT "3. Mage"
PRINT "4. Cleric"
PRINT "5. Thief"
PRINT "6. Fighter/Thief"
PRINT "7. Fighter/Mage"
PRINT "8. Fighter/Mage/Thief"
PRINT "9. Mage/Thief"
PRINT "Please type the NUMBER of your choice and press ENTER."
INPUT "What class would you like you character to be"; N
IF N = 1 THEN C$ = "F": B$ = "F"
IF N = 2 THEN C$ = "R": B$ = "F": R$ = "Y"
IF N = 3 THEN C$ = "M": B$ = "R": M$ = "Y"
IF N = 4 THEN C$ = "C": B$ = "R": Cl$ = "Y"
IF N = 5 THEN C$ = "T": B$ = "R": T$ = "Y"
IF N = 6 THEN C$ = "F/T": B$ = "F": T$ = "Y"
IF N = 7 THEN C$ = "F/M": B$ = "F": M$ = "Y"
IF N = 8 THEN C$ = "F/M/T": B$ = "F": M$ = "Y": T$ = "Y"
IF N = 9 THEN C$ = "M/T": B$ = "R": M$ = "Y": T$ = "Y"
IF N = 1 OR N = 2 OR N = 3 OR N = 4 OR N = 5 OR N = 6 OR N = 7 OR N = 8 OR N = 9 THEN RETURN
GOTO 800
REM________________________________________________________________________________________________________
REM ** CLASS SUB-PROGRAM (Gnome) **
900 CLS
PRINT "1. Fighter"
PRINT "2. Cleric"
PRINT "3. Thief"
PRINT "4. Fighter/Thief"
PRINT "5. Fighter/Cleric"
PRINT "6. Cleric/Thief"
PRINT "Please type the NUMBER of your choice and press ENTER."
INPUT "What class would you like your character to be"; N
IF N = 1 THEN C$ = "F": B$ = "F"
IF N = 2 THEN C$ = "C": B$ = "R": Cl$ = "Y"
IF N = 3 THEN C$ = "T": B$ = "R": T$ = "Y"
IF N = 4 THEN C$ = "F/T": B$ = "F": T$ = "Y"
IF N = 5 THEN C$ = "F/C": B$ = "F": Cl$ = "Y"
IF N = 6 THEN C$ = "C/T": B$ = "R": Cl$ = "Y": T$ = "Y"
IF N = 1 OR N = 2 OR N = 3 OR N = 4 OR N = 5 OR N = 6 THEN RETURN
GOTO 900
REM__________________________________________________________________________________________________________________
REM ** CLASS SUB-PROGRAM (Half-Elf) **
1000 CLS
PRINT "1. Fighter                 9.  Fighter/Thief"
PRINT "2. Ranger                  10. Fighter/Mage"
PRINT "3. Mage                    11. Fighter/Druid"
PRINT "4. Cleric                  12. Cleric/Ranger"
PRINT "5. Druid                   13. Cleric/Mage"
PRINT "6. Thief                   14. Mage/Thief"
PRINT "7. Bard                    15. Fighter/Mage/Thief"
PRINT "8. Fighter/Cleric          16. Fighter/Mage/Cleric"
PRINT "Please type the NUMBER of your choice and press ENTER."
INPUT "What class would you like your character to be"; N
IF N = 1 THEN C$ = "F": B$ = "F": RETURN
IF N = 2 THEN C$ = "R": B$ = "F": R$ = "Y": RETURN
IF N = 3 THEN C$ = "M": B$ = "R": M$ = "Y": RETURN
IF N = 4 THEN C$ = "C": B$ = "R": Cl$ = "Y": RETURN
IF N = 5 THEN C$ = "D": B$ = "R": D$ = "Y": RETURN
IF N = 6 THEN C$ = "T": B$ = "R": T$ = "Y": RETURN
IF N = 7 THEN C$ = "B": B$ = "R": RETURN
IF N = 8 THEN C$ = "F/C": B$ = "F": Cl$ = "Y": RETURN
IF N = 9 THEN C$ = "F/T": B$ = "F": T$ = "Y": RETURN
IF N = 10 THEN C$ = "F/M": B$ = "F": M$ = "Y": RETURN
IF N = 11 THEN C$ = "F/D": B$ = "F": D$ = "Y": RETURN
IF N = 12 THEN C$ = "C/R": B$ = "F": Cl$ = "Y": R$ = "R": RETURN
IF N = 13 THEN C$ = "C/M": B$ = "R": Cl$ = "Y": M$ = "Y": RETURN
IF N = 14 THEN C$ = "M/T": B$ = "R": M$ = "Y": T$ = "Y": RETURN
IF N = 15 THEN C$ = "F/M/T": B$ = "F": M$ = "Y": T$ = "Y": RETURN
IF N = 16 THEN C$ = "F/M/C": B$ = "F": M$ = "Y": Cl$ = "Y": RETURN
GOTO 1000
REM______________________________________________________________________________________________________
REM ** CLASS SUB-PROGRAM (Halfling) **
1100 CLS
PRINT "1. Fighter"
PRINT "2. Cleric"
PRINT "3. Thief"
PRINT "4. Fighter/Thief"
PRINT "Please type the NUMBER of your choice and press ENTER."
INPUT "What class would you like your character to be"; N
IF N = 1 THEN C$ = "F": B$ = "F"
IF N = 2 THEN C$ = "C": B$ = "R": Cl$ = "Y"
IF N = 3 THEN C$ = "T": B$ = "R": T$ = "Y"
IF N = 4 THEN C$ = "F/T": B$ = "F": T$ = "Y"
IF N = 1 OR N = 2 OR N = 3 OR N = 4 THEN RETURN
GOTO 1100
REM__________________________________________________________________________________________________________________________________________________
REM ** ABILITY GENERATOR SUB-PROGRAM **
1200 CLS
PRINT "The computer will now randomly generate ability scores for your character."
1210 STR = INT(RND(1) * 18 + 1)
EXT = INT(RND(1) * 100 + 1)
IF STR < 3 THEN 1210
IF RA$ = "Halfling" THEN STR = STR - 1
IF STR < 9 AND B$ = "F" THEN GOTO 1210
IF STR < 12 AND C$ = "P" THEN GOTO 1210
IF STR < 13 AND C$ = "R" THEN GOTO 1210
IF STR = 18 AND B$ = "F" THEN PRINT "Strength: "; STR; " ("; EXT; ")"
IF STR = 18 AND B$ = "R" THEN PRINT "Strength: "; STR; ""
IF STR < 18 THEN PRINT "Strength: "; STR; ""
1220 IT = INT(RND(1) * 18 + 1)
IF IT < 3 THEN 1220
IF RA$ = "Gnome" THEN IT = IT + 1
IF IT < 9 AND M$ = "Y" THEN 1220
IF IT < 13 AND C$ = "B" THEN 1220
PRINT "Intelligence: "; IT
1230 WIS = INT(RND(1) * 18 + 1)
IF WIS < 3 THEN 1230
IF RA$ = "Gnome" THEN WIS = WIS - 1
IF RA$ = "Halfling" AND WIS > 17 THEN WIS = 17
IF WIS < 13 AND C$ = "P" THEN 1230
IF WIS < 14 AND R$ = "Y" THEN 1230
IF WIS < 9 AND Cl$ = "Y" THEN 1230
IF WIS < 12 AND D$ = "Y" THEN 1230
PRINT "Wisdom: "; WIS
1240 DEX = INT(RND(1) * 18 + 1)
IF DEX < 3 THEN 1240
IF RA$ = "Elf" OR RA$ = "Halfling" THEN DEX = DEX + 1
IF RA$ = "Dwarf" AND DEX > 17 THEN DEX = 17
IF DEX < 13 AND C$ = "R" OR DEX < 14 AND C$ = "C/R" THEN 1240
IF DEX < 9 AND T$ = "Y" THEN 1240
IF DEX < 12 AND C$ = "B" THEN 1240
PRINT "Dexterity: "; DEX
1250 CON = INT(RND(1) * 18 + 1)
IF CON < 3 THEN 1250
IF RA$ = "Dwarf" THEN CON = CON + 1
IF RA$ = "Elf" THEN CON = CON - 1
IF CON < 9 AND C$ = "P" THEN 1250
IF CON < 14 AND R$ = "Y" THEN 1250
PRINT "Constitution: "; CON
1260 CHA = INT(RND(1) * 18 + 1)
IF CHA < 3 THEN 1260
IF RA$ = "Dwarf" THEN CHA = CHA - 1
IF CHA < 17 AND C$ = "P" THEN 1260
IF CHA < 15 AND D$ = "Y" THEN 1260
IF CHA < 15 AND C$ = "B" THEN 1260
PRINT "Charisma: "; CHA
1270 INPUT "Are these abilities up to your standards"; A$
IF A$ = "N" OR A$ = "n" THEN GOTO 1200
IF A$ = "Y" OR A$ = "y" THEN RETURN
GOTO 1270
REM__________________________________________________________________________________________________________________________________
REM ** ALIGNMENT SUB-PROGRAM **
1300 CLS
IF C$ = "P" THEN AN$ = "Lawful/Good": RETURN
IF D$ = "Y" THEN AN$ = "True Neutral": RETURN
IF R$ = "Y" THEN 1310
IF C$ = "B" THEN 1320
IF T$ = "Y" THEN 1330
GOTO 1340
1310 REM **** CLASS = RANGER ****
PRINT "1. Lawful/Good"
PRINT "2. Neutral/Good"
PRINT "3. Chaotic/Good"
PRINT "Please TYPE the NUMBER for the alignment of your choice and PRESS ENTER"
INPUT C
IF C = 1 THEN AN$ = "Lawful/Good": RETURN
IF C = 2 THEN AN$ = "Neutral/Good": RETURN
IF C = 3 THEN AN$ = "Chaotic/Good": RETURN
GOTO 1310
1320 REM **** CLASS = BARD ****
PRINT "1. Lawful/Neutral"
PRINT "2. Neutral/Good"
PRINT "3. True Neutral"
PRINT "4. Neutral/Evil"
PRINT "5. Chaotic/Neutral"
PRINT "Please type the NUMBER for the alignment of your choice and press ENTER."
INPUT C
IF C = 1 THEN AN$ = "Lawful/Neutral": RETURN
IF C = 2 THEN AN$ = "Neutral/Good": RETURN
IF C = 3 THEN AN$ = "True Neutral": RETURN
IF C = 4 THEN AN$ = "Neutral/Evil": RETURN
IF C = 5 THEN AN$ = "Chaotic/Neutral": RETURN
GOTO 1320
1330 REM **** CLASS = THIEF ****
PRINT "1. Lawful/Neutral"
PRINT "2. Lawful/Evil"
PRINT "3. Neutral/Good"
PRINT "4. True Neutral"
PRINT "5. Neutral/Evil"
PRINT "6. Chaotic/Good"
PRINT "7. Chaotic/Neutral"
PRINT "8. Chaotic/Evil"
PRINT "Please type the NUMBER of your choice and press ENTER."
INPUT "What alignment would you like your character to have"; N
IF N = 1 THEN AN$ = "Lawful/Neutral": RETURN
IF N = 2 THEN AN$ = "Lawful/Evil": RETURN
IF N = 3 THEN AN$ = "Neutral/Good": RETURN
IF N = 4 THEN AN$ = "True Neutral": RETURN
IF N = 5 THEN AN$ = "Neutral/Evil": RETURN
IF N = 6 THEN AN$ = "Chaotic/Good": RETURN
IF N = 7 THEN AN$ = "Chaotic/Neutral": RETURN
IF N = 8 THEN AN$ = "Chaotic/Evil": RETURN
GOTO 1330
1340 REM **** CLASS = GENERAL ****
PRINT "1. Lawful/Good"
PRINT "2. Lawful/Neutral"
PRINT "3. Lawful/Evil"
PRINT "4. Neutral/Good"
PRINT "5. True Neutral"
PRINT "6. Neutral/Evil"
PRINT "7. Chaotic/Good"
PRINT "8. Chaotic/Neutral"
PRINT "9. Chaotic/Evil"
PRINT "Please type the NUMBER of your choice and press ENTER."
INPUT "What alignment would you like your character to have"; N
IF N = 1 THEN AN$ = "Lawful/Good": RETURN
IF N = 2 THEN AN$ = "Lawful/Neutral": RETURN
IF N = 3 THEN AN$ = "Lawful/Evil": RETURN
IF N = 4 THEN AN$ = "Neutral/Good": RETURN
IF N = 5 THEN AN$ = "True Neutral": RETURN
IF N = 6 THEN AN$ = "Neutral/Evil": RETURN
IF N = 7 THEN AN$ = "Chaotic/Good": RETURN
IF N = 8 THEN AN$ = "Chaotic/Neutral": RETURN
IF N = 9 THEN AN$ = "Chaotic/Evil": RETURN
GOTO 1340
REM_________________________________________________________________________________________________________________________________________
REM ** DEFINE CLASS VARIABLE **
1400 CLS
IF C$ = "F" THEN CS$ = "Fighter"
IF C$ = "P" THEN CS$ = "Paladin"
IF C$ = "R" THEN CS$ = "Ranger"
IF C$ = "M" THEN CS$ = "Mage"
IF C$ = "C" THEN CS$ = "Cleric"
IF C$ = "D" THEN CS$ = "Druid"
IF C$ = "T" THEN CS$ = "Thief"
IF C$ = "B" THEN CS$ = "Bard"
IF C$ = "F/C" THEN CS$ = "Fighter/Cleric"
IF C$ = "F/D" THEN CS$ = "Fighter/Druid"
IF C$ = "F/T" THEN CS$ = "Fighter/Thief"
IF C$ = "F/M" THEN CS$ = "Fighter/Mage"
IF C$ = "M/T" THEN CS$ = "Mage/Thief"
IF C$ = "C/T" THEN CS$ = "Cleric/Thief"
IF C$ = "C/R" THEN CS$ = "Cleric/Ranger"
IF C$ = "C/M" THEN CS$ = "Cleric/Mage"
IF C$ = "F/M/T" THEN CS$ = "Fighter/Mage/Thief"
IF C$ = "F/M/C" THEN CS$ = "Fighter/Mage/Cleric"
RETURN
REM_________________________________________________________________________________________________________________________________________
REM ** DISPLAY SUB-PROGRAM **
1500 CLS
PRINT "Name:  "; NAM$; ""
PRINT "Sex:  "; SEX$; ""
PRINT "Race:  "; RA$; ""
PRINT "Class:  "; CS$; ""
PRINT "Alignment:  "; AN$; ""
IF STR < 18 THEN PRINT "Strength: "; STR; ""
IF STR = 18 AND B$ = "F" THEN PRINT "Strength: "; STR; " ("; EXT; ")"
IF STR = 18 AND B$ = "R" THEN PRINT "Strength: "; STR; ""
PRINT "Intelligence: "; IT; ""
PRINT "Wisdom: "; WIS; ""
PRINT "Dexterity: "; DEX; ""
PRINT "Constitution: "; CON; ""
PRINT "Charisma: "; CHA; ""
RETURN
REM_____________________________________________________________________________________________________________________________________________
REM ** PRINT OUT SUB-PROGRAM **
1600 PRINT : INPUT "Would you like a print out"; P$
IF P$ = "Y" OR P$ = "y" THEN RETURN
IF P$ = "N" OR P$ = "n" THEN 1
GOTO 1600
REM ____________________________________________________________________________________________________________________________________________
REM ** PRINT OUT SUB-PROGRAM **
1700 LPRINT : LPRINT : LPRINT : LPRINT "Name:  "; NAM$; ""
LPRINT "Sex:  "; SEX$; ""
LPRINT "Race:  "; RA$; ""
LPRINT "Class:  "; CS$; ""
LPRINT "Alignment:  "; AN$; ""
IF STR < 18 THEN LPRINT "Strength: "; STR; ""
IF STR = 18 AND B$ = "F" THEN LPRINT "Strength: "; STR; " ("; EXT; ")"
IF STR = 18 AND B$ = "R" THEN LPRINT "Strength: "; STR; ""
LPRINT "Intelligence: "; IT; ""
LPRINT "Wisdom: "; WIS; ""
LPRINT "Dexterity: "; DEX; ""
LPRINT "Constitution: "; CON; ""
LPRINT "Charisma: "; CHA; ""
LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT
LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT : LPRINT
RETURN
REM____________________________________________________________________________________________________________________















