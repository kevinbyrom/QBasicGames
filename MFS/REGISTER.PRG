SCREEN 0: CLS : COLOR 2

PRINT "This is Micro.Football.Simulator version 1.1, the Public Domain version."
PRINT "This means you may freely distribute this version with all files unaltered."
PRINT "You may only keep this copy for a trial time of 30 days !"
PRINT "When your trial period is up you must delete all files of this version,"
PRINT "and you'll be under no further obligations."
PRINT "You must register this version if you wish to keep it any longer than 30 days."
PRINT "When you register M.F.S ver.1.1, you will recieve ver.1.2 free !"
PRINT "What's so special about version 1.2 ???   ----------------------"
PRINT
PRINT "Version 1.2 contains..."
PRINT "* A leauge editor. (change team colors, names, players, attributes)"
PRINT "* A schedule editor. (schedules generate randomly, or manually)"
PRINT "* A stat recorder. (records all stats to a text file)"
PRINT "* Play a whole season, and an eight team championship tournament."
PRINT "* Break new records for single games, and entire seasons."
PRINT "* Plus, the pro'96, pro'95, and pro'94 leauges.
PRINT "* Can you take your favorite team to the championship ?"
PRINT
PRINT "To register version 1.1, send $10.00, check, money order, or U.S currency to,"
PRINT
PRINT ".                            Charles M. LaRosa"
PRINT ". (note:leave a return       3054 Woodside Ave."
PRINT ".       address)             Graham N.C 27253"

lupe: a$ = INKEY$: IF a$ = "" THEN GOTO lupe
      RUN "menu.prg"

