%% setOnActuator(scrivoDir(gameManager(gameManager(x(X))))):-
%% setOnActuator(scrivoDir(gameManager(gameManager(y(X))))):-
%% readDir(random(randomDirection(direction(X)))).
%% readGriglia(griglia(griglia(player(x(X))))).
%% readGriglia(griglia(griglia(player(y(X))))).
%% readGriglia(griglia(griglia(mappa(X,cella(x(V)))))).
%% readGriglia(griglia(griglia(mappa(X,cella(y(V)))))).
%% readGriglia(griglia(griglia(mappa(X,cella(val(V)))))).

direzioneLetta(D) :- readDir(random(randomDirection(direction(D)))).

setOnActuator(scrivoDir(gameManager(gameManager(x(X))))) :- direzioneLetta(D), direction(D,X,Y).
setOnActuator(scrivoDir(gameManager(gameManager(y(Y))))) :- direzioneLetta(D), direction(D,X,Y).
