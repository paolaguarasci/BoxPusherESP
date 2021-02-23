%% setOnActuator(scrivoDir(gameManager(gameManager(x(X))))):-
%% setOnActuator(scrivoDir(gameManager(gameManager(y(X))))):-
%% readDir(random(randomDirection(direction(X)))).
%% readGriglia(griglia(griglia(player(x(X))))).
%% readGriglia(griglia(griglia(player(y(X))))).
%% readGriglia(griglia(griglia(mappa(X,cella(x(V)))))).
%% readGriglia(griglia(griglia(mappa(X,cella(y(V)))))).
%% readGriglia(griglia(griglia(mappa(X,cella(val(V)))))).

%% direzioneLetta(D) :- readDir(random(randomDirection(direction(D)))).

% setOnActuator(scrivoDir(gameManager(gameManager(x(X))))) :- direzioneLetta(D), direction(D,X,Y).
% setOnActuator(scrivoDir(gameManager(gameManager(y(Y))))) :- direzioneLetta(D), direction(D,X,Y).



direction(0,0,0). %% fermo
direction(1,1,0). %% sopra
direction(2,-1,0).  %% sotto
direction(3,0,1). %% destra
direction(4,0,-1).  %% sinitra

direzioneLetta(D) :- readDir(random(randomDirection(direction(D)))).

celle(A, B, C) :- readGriglia(griglia(griglia(mappa(I,cella(x(A)))))), readGriglia(griglia(griglia(mappa(I,cella(y(B)))))), readGriglia(griglia(griglia(mappa(I,cella(val(C)))))).

player(X, Y) :- celle(X, Y, C), C = 5.
target(X, Y) :- celle(X, Y, C), C = 3.
box(X, Y) :- celle(X, Y, C), C = 4.
muro(X, Y) :- celle(X, Y, C), C = 2.

nextMove(D) | noNextMove(D) :- direction(D, _, _).

%% Non posso andare sui muri
:- nextMove(D), direction(D, Dx, Dy), player(X, Y), muro(A, B), A=X+Dx, B=Y+Dy.
%% Non posso andare in piu' di una direzione per volta
:- #count {D: nextMove(D)} != 1.
%% Preferisco muovermi
:~ nextMove(D), D=0. [1@1]

boxProssimi(X,Y,D) :- player(A, B), box(X,Y), X=A+1, D=1. 
boxProssimi(X,Y,D) :- player(A, B), box(X,Y), X=A-1, D=2.
boxProssimi(X,Y,D) :- player(A, B), box(X,Y), Y=A+1, D=3.
boxProssimi(X,Y,D) :- player(A, B), box(X,Y), Y=A-1, D=4.

boxDaMuovere(X,Y) :- box(X,Y), not target(X,Y).
targetLiberi(X,Y) :- target(X,Y), not box(X,Y).

setOnActuator(scrivoDir(gameManager(gameManager(x(X))))) :- nextMove(D), direction(D,X,Y).
setOnActuator(scrivoDir(gameManager(gameManager(y(Y))))) :- nextMove(D), direction(D,X,Y).