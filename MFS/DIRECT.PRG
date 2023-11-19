SCREEN 0: COLOR 2: CLS
PRINT "When starting an exhibition game you must first choose player one's team,"
PRINT "then choose the computer's team."
PRINT "To change teams use the ARROW KEYS."
PRINT "To select a team use the ENTER KEY."
PRINT "After you've selected teams there will be a coin toss."
PRINT "Winning team of the coin toss, always recieve the kickoff."
PRINT
PRINT "On offense, you have 6 plays to choose from..."
PRINT "run, short pass, medium pass, long pass, field goal, and punt"
PRINT "Use run, and short pass for little gains, but better chance for completion."
PRINT "Use medium pass for longer yardage, and 1st down conversions."
PRINT "The long pass gains massive yards, but is difficult to complete."
PRINT
PRINT "The defense has 3 plays. Plus, a blitz option to choose from..."
PRINT "4-3, zone, 3-4, blitz (on or off)"
PRINT "The 4-3 defense concentrates on the run."
PRINT "The zone formation spreads out more, and looks for, runs or passes."
PRINT "While the 3-4 defense controls the passing game."
PRINT "Blitzing puts more pressure on the offensive line, and quarterback."
PRINT "Beware, an offense calling a run play while deffense calls a 3-4 blitz,"
PRINT "could result in a big gain for the offense."
PRINT "Calling a 4-3 blitz vs. run would be a much smarter call."

PRINT : PRINT "Press a key.";
lupe1: a$ = INKEY$: IF a$ = "" THEN GOTO lupe1
CLS
PRINT "Here's a couple of factors that M.F.S ver.1.1,"
PRINT "differs from traditional football..."
PRINT "When a team's offense is penalized they lose a down, up to 4th down."
PRINT "When a team's defense is penalized the offense gains a down, up to 1st down."
PRINT "After a reciever catches the ball, and proceeds to run, he never fumbles."
PRINT "When the defense intercepts the ball that team's offense gets the ball,"
PRINT "1st and 10 at the line of scrimage."
PRINT "Quarterbacks don't fumble, or run the ball."
PRINT "Running backs cannot recieve passes, nor can recievers run from scrimage."
PRINT "There's no injuries, or weather variables."
PRINT "There's no extra point field goal after a touchdown."
PRINT "Touchdowns count as 7 points."
PRINT
PRINT "enjoy..."
lupe2: a$ = INKEY$: IF a$ = "" THEN GOTO lupe2
       RUN "menu.prg"

