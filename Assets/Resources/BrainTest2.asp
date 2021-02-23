readGriglia(griglia(griglia(mappa(1,cella(x(0)))))).
readGriglia(griglia(griglia(mappa(1,cella(y(0)))))).
readGriglia(griglia(griglia(mappa(1,cella(val(2)))))).

readGriglia(griglia(griglia(mappa(2,cella(x(0)))))).
readGriglia(griglia(griglia(mappa(2,cella(y(1)))))).
readGriglia(griglia(griglia(mappa(2,cella(val(2)))))).

readGriglia(griglia(griglia(mappa(3,cella(x(0)))))).
readGriglia(griglia(griglia(mappa(3,cella(y(2)))))).
readGriglia(griglia(griglia(mappa(3,cella(val(2)))))).

readGriglia(griglia(griglia(mappa(4,cella(x(0)))))).
readGriglia(griglia(griglia(mappa(4,cella(y(3)))))).
readGriglia(griglia(griglia(mappa(4,cella(val(2)))))).

readGriglia(griglia(griglia(mappa(5,cella(x(0)))))).
readGriglia(griglia(griglia(mappa(5,cella(y(4)))))).
readGriglia(griglia(griglia(mappa(5,cella(val(2)))))).

readGriglia(griglia(griglia(mappa(6,cella(x(1)))))).
readGriglia(griglia(griglia(mappa(6,cella(y(0)))))).
readGriglia(griglia(griglia(mappa(6,cella(val(2)))))).

readGriglia(griglia(griglia(mappa(7,cella(x(1)))))).
readGriglia(griglia(griglia(mappa(7,cella(y(1)))))).
readGriglia(griglia(griglia(mappa(7,cella(val(5)))))).

readGriglia(griglia(griglia(mappa(8,cella(x(1)))))).
readGriglia(griglia(griglia(mappa(8,cella(y(2)))))).
readGriglia(griglia(griglia(mappa(8,cella(val(4)))))).

readGriglia(griglia(griglia(mappa(9,cella(x(1)))))).
readGriglia(griglia(griglia(mappa(9,cella(y(3)))))).
readGriglia(griglia(griglia(mappa(9,cella(val(3)))))).

readGriglia(griglia(griglia(mappa(10,cella(x(1)))))).
readGriglia(griglia(griglia(mappa(10,cella(y(4)))))).
readGriglia(griglia(griglia(mappa(10,cella(val(2)))))).

readGriglia(griglia(griglia(mappa(11,cella(x(2)))))).
readGriglia(griglia(griglia(mappa(11,cella(y(0)))))).
readGriglia(griglia(griglia(mappa(11,cella(val(2)))))).

readGriglia(griglia(griglia(mappa(12,cella(x(2)))))).
readGriglia(griglia(griglia(mappa(12,cella(y(1)))))).
readGriglia(griglia(griglia(mappa(12,cella(val(2)))))).

readGriglia(griglia(griglia(mappa(13,cella(x(2)))))).
readGriglia(griglia(griglia(mappa(13,cella(y(2)))))).
readGriglia(griglia(griglia(mappa(13,cella(val(2)))))).

readGriglia(griglia(griglia(mappa(14,cella(x(2)))))).
readGriglia(griglia(griglia(mappa(14,cella(y(3)))))).
readGriglia(griglia(griglia(mappa(14,cella(val(2)))))).

readGriglia(griglia(griglia(mappa(15,cella(x(2)))))).
readGriglia(griglia(griglia(mappa(15,cella(y(4)))))).
readGriglia(griglia(griglia(mappa(15,cella(val(2)))))).

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
:- #count {D: nextMove(D)} > 1.
%% Preferisco muovermi
:~ nextMove(D), D=0. [1@1]

boxProssimi(X,Y) :- player(A, B), box(X,Y), X=A+1. 
boxProssimi(X,Y) :- player(A, B), box(X,Y), X=A-1. 
boxProssimi(X,Y) :- player(A, B), box(X,Y), Y=A+1. 
boxProssimi(X,Y) :- player(A, B), box(X,Y), Y=A-1. 


% setOnActuator(scrivoDir(gameManager(gameManager(x(X))))) :- nextMove(D), direction(D,X,Y).
% setOnActuator(scrivoDir(gameManager(gameManager(y(Y))))) :- nextMove(D), direction(D,X,Y).
