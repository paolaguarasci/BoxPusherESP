readDir(random(randomDirection(direction(3)))).
readGriglia(griglia(griglia(player(x(8))))).
readGriglia(griglia(griglia(player(y(10))))).

readGriglia(griglia(griglia(mappa(0,cella(x(7)))))).
readGriglia(griglia(griglia(mappa(0,cella(y(9)))))).
readGriglia(griglia(griglia(mappa(0,cella(val(2)))))).

readGriglia(griglia(griglia(mappa(1,cella(x(8)))))).
readGriglia(griglia(griglia(mappa(1,cella(y(9)))))).
readGriglia(griglia(griglia(mappa(1,cella(val(2)))))).

readGriglia(griglia(griglia(mappa(2,cella(x(9)))))).
readGriglia(griglia(griglia(mappa(2,cella(y(9)))))).
readGriglia(griglia(griglia(mappa(2,cella(val(2)))))).

readGriglia(griglia(griglia(mappa(3,cella(x(10)))))).
readGriglia(griglia(griglia(mappa(3,cella(y(9)))))).
readGriglia(griglia(griglia(mappa(3,cella(val(2)))))).

readGriglia(griglia(griglia(mappa(4,cella(x(11)))))).
readGriglia(griglia(griglia(mappa(4,cella(y(9)))))).
readGriglia(griglia(griglia(mappa(4,cella(val(2)))))).

readGriglia(griglia(griglia(mappa(5,cella(x(7)))))).
readGriglia(griglia(griglia(mappa(5,cella(y(10)))))).
readGriglia(griglia(griglia(mappa(5,cella(val(2)))))).

readGriglia(griglia(griglia(mappa(6,cella(x(8)))))).
readGriglia(griglia(griglia(mappa(6,cella(y(10)))))).
readGriglia(griglia(griglia(mappa(6,cella(val(5)))))).

readGriglia(griglia(griglia(mappa(7,cella(x(9)))))).
readGriglia(griglia(griglia(mappa(7,cella(y(10)))))).
readGriglia(griglia(griglia(mappa(7,cella(val(4)))))).

readGriglia(griglia(griglia(mappa(8,cella(x(10)))))).
readGriglia(griglia(griglia(mappa(8,cella(y(10)))))).
readGriglia(griglia(griglia(mappa(8,cella(val(3)))))).

readGriglia(griglia(griglia(mappa(9,cella(x(11)))))).
readGriglia(griglia(griglia(mappa(9,cella(y(10)))))).
readGriglia(griglia(griglia(mappa(9,cella(val(2)))))).

readGriglia(griglia(griglia(mappa(10,cella(x(7)))))).
readGriglia(griglia(griglia(mappa(10,cella(y(11)))))).
readGriglia(griglia(griglia(mappa(10,cella(val(2)))))).

readGriglia(griglia(griglia(mappa(11,cella(x(8)))))).
readGriglia(griglia(griglia(mappa(11,cella(y(11)))))).
readGriglia(griglia(griglia(mappa(11,cella(val(2)))))).

readGriglia(griglia(griglia(mappa(12,cella(x(9)))))).
readGriglia(griglia(griglia(mappa(12,cella(y(11)))))).
readGriglia(griglia(griglia(mappa(12,cella(val(2)))))).

readGriglia(griglia(griglia(mappa(13,cella(x(10)))))).
readGriglia(griglia(griglia(mappa(13,cella(y(11)))))).
readGriglia(griglia(griglia(mappa(13,cella(val(2)))))).

readGriglia(griglia(griglia(mappa(14,cella(x(11)))))).
readGriglia(griglia(griglia(mappa(14,cella(y(11)))))).
readGriglia(griglia(griglia(mappa(14,cella(val(2)))))).

direction(0,0,0). %% fermo
direction(1,1,0). %% sopra
direction(2,-1,0).  %% sotto
direction(3,0,1). %% destra
direction(4,0,-1).  %% sinitra

celle(X, Y, I, C) :- readGriglia(griglia(griglia(mappa(I,cella(x(X)))))), readGriglia(griglia(griglia(mappa(I,cella(y(Y)))))), readGriglia(griglia(griglia(mappa(I,cella(val(C)))))).

nodo(I) :- readGriglia(griglia(griglia(mappa(I,cella(x(A)))))).
% arc(A, B) :- nodo(A), nodo(B), readGriglia(griglia(griglia(mappa(A,cella(x(X)))))), readGriglia(griglia(griglia(mappa(A,cella(y(Y)))))), readGriglia(griglia(griglia(mappa(B,cella(x(X1)))))), readGriglia(griglia(griglia(mappa(B,cella(y(Y1)))))), A != B, Y = Y1, X1 = X + 1.   
% arc(A, B) :- nodo(A), nodo(B), readGriglia(griglia(griglia(mappa(A,cella(x(X)))))), readGriglia(griglia(griglia(mappa(A,cella(y(Y)))))), readGriglia(griglia(griglia(mappa(B,cella(x(X1)))))), readGriglia(griglia(griglia(mappa(B,cella(y(Y1)))))), A != B, Y1 = Y + 1, X = X1.   
% arc(A, B) :- nodo(A), nodo(B), readGriglia(griglia(griglia(mappa(A,cella(x(X)))))), readGriglia(griglia(griglia(mappa(A,cella(y(Y)))))), readGriglia(griglia(griglia(mappa(B,cella(x(X1)))))), readGriglia(griglia(griglia(mappa(B,cella(y(Y1)))))), A != B, Y = Y1, X1 = X - 1.   
% arc(A, B) :- nodo(A), nodo(B), readGriglia(griglia(griglia(mappa(A,cella(x(X)))))), readGriglia(griglia(griglia(mappa(A,cella(y(Y)))))), readGriglia(griglia(griglia(mappa(B,cella(x(X1)))))), readGriglia(griglia(griglia(mappa(B,cella(y(Y1)))))), A != B, Y1 = Y - 1, X = X1.   



% Cosi andiamo a destra e a sinistra
arc(I1, I2) :- nodo(I1), nodo(I2), celle(X1,Y1,I1,C1), celle(X2,Y2,I2,C2), I1 != I2, Y1 = Y2, X2 = X1 + 1. %, C1 != 2, C2 != 2.   
arc(I1, I2) :- nodo(I1), nodo(I2), celle(X1,Y1,I1,C1), celle(X2,Y2,I2,C2), I1 != I2, Y1 = Y2, X2 = X1 - 1. %, C1 != 2, C2 != 2.   
% Cosi andiamo sopra e sotto
arc(I1, I2) :- nodo(I1), nodo(I2), celle(X1,Y1,I1,C1), celle(X2,Y2,I2,C2), I1 != I2, Y1 = Y2 + 1, X2 = X1. %, C1 != 2, C2 != 2.   
arc(I1, I2) :- nodo(I1), nodo(I2), celle(X1,Y1,I1,C1), celle(X2,Y2,I2,C2), I1 != I2, Y1 = Y2 - 1, X2 = X1. %, C1 != 2, C2 != 2.   


quantiArchi(X) :- #count{A,B: arc(A,B)} = X.

player(X, Y, I) :- celle(X, Y, I, C), C = 5.
target(X, Y, I) :- celle(X, Y, I, C), C = 3.
box(X, Y, I)  :- celle(X, Y, I, C), C = 4.
muro(X, Y, I) :- celle(X, Y, I, C), C = 2.
libero(X, Y, I) :- celle(X, Y, I, C), C = 0.

% boxProssimi(X,Y,D) :- player(A, B, IP), box(X, Y, IB), X=A+1, D=1. 
% boxProssimi(X,Y,D) :- player(A, B, IP), box(X, Y, IB), X=A-1, D=2.
% boxProssimi(X,Y,D) :- player(A, B, IP), box(X, Y, IB), Y=B+1, D=3.
% boxProssimi(X,Y,D) :- player(A, B, IP), box(X, Y, IB), Y=B-1, D=4.

boxDaMuovere(X,Y, I) :- box(X,Y,I), not target(X,Y,I).
targetLiberi(X,Y, I) :- target(X,Y,I), not box(X,Y,I).


% numBoxDaSistemare(N) :- #count{I: box(X, Y, I)} = N.
% numBoxDaSistemare(4).
% start(N, I) :- player(X, Y, I), N = 1.
% start(N, I) :- start(N1, I), N = N1 + 1, numBoxDaSistemare(Max), N <= Max.
% stop(N, I) :- box(X, Y, I), N = 1, I = #min{A: box(X,Y,A)}.
% stop(N, I1) :- stop(N1, I), N = N1 + 1, numBoxDaSistemare(Max), N <= Max, box(X, Y, I1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% arc(X,Y) :- arc(Y,X).

% start(1,10).
% stop(1,49).
% start(2,10).
% stop(2,41).
% start(3,10).
% stop(3,39).
% start(4,10).
% stop(4,31).

numCammini(C) :- start(C,_), stop(C, _).

inPath(X,Y, C) | outPath(X,Y,C) :- arc(X,Y), numCammini(C).
:- inPath(X,Y,C), inPath(X,Y1,C), Y <> Y1.
:- inPath(X,Y,C), inPath(X1,Y,C), X <> X1. 
reached(C,X) :- start(C,X).
reached(C,X) :- reached(C, Y), inPath(Y,X,C).
:- stop(C,X), not reached(C, X).
:- stop(C,X), inPath(X,Y,C).

cammini(X,Y, C) :- reached(C, X), inPath(X,Y,C), reached(C, Y).
lunghezze(C,N) :- numCammini(C), #count{C, X, Y: cammini(X,Y,C)} = N.

%% Il minimo da problemi perche' diventa un ciclo insieme al count
%% va trovato un modo diverso, con un weak per esempio.
%% Pago per ogni arco che ho nel cammino! 

% distMin(M) :- #min{N: lunghezze(C,N)} = M. 
% camminoMin(C) :- distMin(M), lunghezze(C,M).

% :~ lunghezze(C, N). [1@1,N]
% nc(Z) :- #count{C: cammini(X, Y, C)} = Z.

% setOnActuator(scrivoDir(gameManager(gameManager(x(X))))) :- nextMove(D), direction(D,X,Y).
% setOnActuator(scrivoDir(gameManager(gameManager(y(Y))))) :- nextMove(D), direction(D,X,Y).

distanzeScatolePlayer(IB, D) :- player(_, _, IP), box(_, _, IB), D = IP - IB, IP > IB.
distanzeScatolePlayer(IB, D) :- player(_, _, IP), box(_, _, IB), D = IB - IP, IB > IP.
scatolaPiuVicina(IB, X) :- distanzeScatolePlayer(IB, X), #min{D: distanzeScatolePlayer(I, D)} = X. 
start(N, I) :- player(_, _, I), N = 1.
stop(N, I) :- boxDaMuovere(_, _, I), scatolaPiuVicina(I, _), N = 1.