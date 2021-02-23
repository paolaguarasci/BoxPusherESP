direction(0,10,10). %% fermo
direction(1,20,10). %% sopra
direction(2,0,10).  %% sotto
direction(3,10,20). %% destra
direction(4,10,0).  %% sinitra

direzioneLetta(D) :- readDir(random(randomDirection(direction(D)))).

setOnActuator(scrivoDir(gameManager(gameManager(x(X))))) :- direzioneLetta(D), direction(D,X,Y).
setOnActuator(scrivoDir(gameManager(gameManager(y(Y))))) :- direzioneLetta(D), direction(D,X,Y).
