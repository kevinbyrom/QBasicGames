'Hey, wassup, this is KB 49ers again.  I decided to come up with this little
'proggie just for you programmers out there.  It shows a very simple process
'of paralax scrolling, using video pages. Go ahead and mess around with this
'code to help your own codes. 
'
'Look for my up and coming games :
'
'             -Dragoon Legacy (available in May)
'                    A role playing game set in a world which once was
'                    ruled by an ancient race called the Dragoons. The
'                    Dragoons mortal enemies, the Reptilians, waged a
'                    great war against the Dragoons.
'                    The Dragoons win the "Great War" and drive the
'                    reptilians into the dark underworld.  However,
'                    the Dragoons start to mysteriously disappear.
'                    Centuries later, the Dragoons are figured to be
'                    extinct and the Reptilians rise from the
'                    underworld, causing great chaos on the world.
'                    You control Kain, a soldier with an unknown past.
'                    Your journey will be one of uncovering the secrets
'                    of the past, and to drive the Reptilians back to the
'                    underworld.
'
'
'             -Monday Night Football 96 (available Summer 96)  
'                    Set..hut....hut....HIKE!!! Get ready for an even
'                    harder hitting football game then its origin,
'                    Monday Night Football. This game has it all, every
'                    team (including expansions), different plays (run &
'                    pass) and much, much more.
'
'Prepare yourselves, because starting May, things are gonna get hot,
'courtesy of yours truly, KB 49ers!
'
'If you have any questions or comments, or even suggestions on some
'of my games, E-Mail me at KB MaiL
'
' ** SCROLL.BAS
' ** 1996 KB 49ers

DEFINT A-Z                                       'default type = integer



RANDOMIZE TIMER




REDIM starsbrx(1 TO 20)
REDIM starsbry(1 TO 20)
REDIM starsx(1 TO 20)
REDIM starsy(1 TO 20)
REDIM starsltx(1 TO 20)
REDIM starslty(1 TO 20)
REDIM starsclx!(1 TO 5)
REDIM starscly!(1 TO 5)
REDIM statsclr(1 TO 5)
FOR i = 1 TO 5
    starsclx!(i) = INT(319 * RND) + 1
    starscly!(i) = INT(199 * RND) + 1
    starsclr(i) = INT(6 * RND) + 1
NEXT

FOR i = 1 TO 20
    starsbrx(i) = INT(319 * RND) + 1
    starsx(i) = INT(319 * RND) + 1
    starsltx(i) = INT(319 * RND) + 1
    starsbry(i) = INT(199 * RND) + 1
    starsy(i) = INT(199 * RND) + 1
    starslty(i) = INT(199 * RND) + 1
NEXT


DO
SCREEN 7, 0, 0, 1
CLS
FOR i = 1 TO 5
   PSET (starsclx!(i), starscly!(i)), 1
NEXT
FOR i = 1 TO 20
    PSET (starsbrx(i), starsbry(i)), 15
    PSET (starsx(i), starsy(i)), 7
    PSET (starsltx(i), starslty(i)), 8
NEXT
PCOPY 0, 1
DO
a$ = INKEY$
LOOP UNTIL a$ <> ""
IF a$ = CHR$(0) + CHR$(77) THEN
   FOR i = 1 TO 5
   starsclx!(i) = starsclx!(i) - .1
    IF starsclx!(i) < 0 THEN starsclx!(i) = 320 + starsclx!(i)
   NEXT
  
   FOR i = 1 TO 20
       starsbrx(i) = starsbrx(i) - 4
       starsx(i) = starsx(i) - 2
       starsltx(i) = starsltx(i) - 1
     
       IF starsbrx(i) < 0 THEN starsbrx(i) = 320 + starsbrx(i)
       IF starsx(i) < 0 THEN starsx(i) = 320 + starsx(i)
       IF starsltx(i) < 0 THEN starsltx(i) = 320 + starsltx(i)
    
      
   NEXT
END IF
IF a$ = CHR$(0) + CHR$(80) THEN
   FOR i = 1 TO 5
    starscly!(i) = starscly!(i) - .1
     IF starscly!(i) < 0 THEN starscly!(i) = 200 + starscly!(i)
   NEXT
  
   FOR i = 1 TO 20
       starsbry(i) = starsbry(i) - 4
       starsy(i) = starsy(i) - 2
       starslty(i) = starslty(i) - 1
     
       IF starsbry(i) < 0 THEN starsbry(i) = 200 + starsbry(i)
       IF starsy(i) < 0 THEN starsy(i) = 200 + starsy(i)
       IF starslty(i) < 0 THEN starslty(i) = 200 + starslty(i)
   NEXT
END IF
IF a$ = CHR$(0) + CHR$(75) THEN
   FOR i = 1 TO 5
      starsclx!(i) = starsclx!(i) + .1
     IF starsclx!(i) > 319 THEN starsclx!(i) = starsclx!(i) - 320
   NEXT

   FOR i = 1 TO 20
       starsbrx(i) = starsbrx(i) + 4
       starsx(i) = starsx(i) + 2
       starsltx(i) = starsltx(i) + 1
       IF starsbrx(i) > 319 THEN starsbrx(i) = starsbrx(i) - 320
       IF starsx(i) > 319 THEN starsx(i) = starsx(i) - 320
       IF starsltx(i) > 319 THEN starsltx(i) = starsltx(i) - 320
     
     
  
   NEXT
END IF
IF a$ = CHR$(0) + CHR$(72) THEN
   FOR i = 1 TO 5
    starscly!(i) = starscly!(i) + .1
    IF starscly!(i) > 199 THEN starscly!(i) = starscly!(i) - 200
   NEXT
   FOR i = 1 TO 20
       starsbry(i) = starsbry(i) + 4
       starsy(i) = starsy(i) + 2
       starslty(i) = starslty(i) + 1
      
     
       IF starsbry(i) > 199 THEN starsbry(i) = starsbry(i) - 200
       IF starsy(i) > 199 THEN starsy(i) = starsy(i) - 200
       IF starslty(i) > 199 THEN starslty(i) = starslty(i) - 200
      
                
  
   NEXT
END IF
LOOP

