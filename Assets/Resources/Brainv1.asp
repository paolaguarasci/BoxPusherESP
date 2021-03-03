
direction(0,0,0). %% fermo
direction(1,1,0). %% sopra
direction(2,-1,0).  %% sotto
direction(3,0,1). %% destra
direction(4,0,-1).  %% sinitra

% direction(0,0,0). %% fermo
% direction(1,20,10). %% sopra
% direction(2,0,10).  %% sotto
% direction(3,10,20). %% destra
% direction(4,10,0).  %% sinitra

celle(X, Y, I, C) :- readGriglia(griglia(griglia(mappa(I,cella(x(X)))))), readGriglia(griglia(griglia(mappa(I,cella(y(Y)))))), readGriglia(griglia(griglia(mappa(I,cella(val(C)))))).

nodo(I) :- readGriglia(griglia(griglia(mappa(I,cella(x(A)))))).

% Cosi andiamo a destra e a sinistra
arc(I1, I2) :- nodo(I1), nodo(I2), celle(X1,Y1,I1,C1), celle(X2,Y2,I2,C2), I1 != I2, Y1 = Y2, X2 = X1 + 1, C1 != 2, C2 != 2.   
arc(I1, I2) :- nodo(I1), nodo(I2), celle(X1,Y1,I1,C1), celle(X2,Y2,I2,C2), I1 != I2, Y1 = Y2, X2 = X1 - 1, C1 != 2, C2 != 2.   
% Cosi andiamo sopra e sotto
arc(I1, I2) :- nodo(I1), nodo(I2), celle(X1,Y1,I1,C1), celle(X2,Y2,I2,C2), I1 != I2, Y1 = Y2 + 1, X2 = X1, C1 != 2, C2 != 2.   
arc(I1, I2) :- nodo(I1), nodo(I2), celle(X1,Y1,I1,C1), celle(X2,Y2,I2,C2), I1 != I2, Y1 = Y2 - 1, X2 = X1, C1 != 2, C2 != 2.   
% Simmetria in modo piu veloce
% arc(X,Y) :- arc(Y,X).

quantiArchi(X) :- #count{A,B: arc(A,B)} = X.

player(X, Y, I) :- celle(X, Y, I, C), C = 5.
target(X, Y, I) :- celle(X, Y, I, C), C = 3.
box(X, Y, I)  :- celle(X, Y, I, C), C = 4.
muro(X, Y, I) :- celle(X, Y, I, C), C = 2.
libero(X, Y, I) :- celle(X, Y, I, C), C = 0.

boxProssimi(X,Y,D) :- player(A, B, IP), box(X, Y, IB), X=A+1, D=1. 
boxProssimi(X,Y,D) :- player(A, B, IP), box(X, Y, IB), X=A-1, D=2.
boxProssimi(X,Y,D) :- player(A, B, IP), box(X, Y, IB), Y=B+1, D=3.
boxProssimi(X,Y,D) :- player(A, B, IP), box(X, Y, IB), Y=B-1, D=4.

boxDaMuovere(X,Y, I) :- box(X,Y,I), not target(X,Y,I).
targetLiberi(X,Y, I) :- target(X,Y,I), not box(X,Y,I).

numBoxDaSistemare(N) :- #count{I: box(X, Y, I)} = N.

numCammini(C) :- start(C,_), stop(C, _).
progCammini(1).
progCammini(C) :- progCammini(X), numCammini(Z), C <= Z, C = X + 1. 
inPath(X,Y, C) | outPath(X,Y,C) :- arc(X,Y), numCammini(C).
:- inPath(X,Y,C), inPath(X,Y1,C), Y != Y1.
:- inPath(X,Y,C), inPath(X1,Y,C), X != X1. 
reached(C,X) :- start(C,X).
reached(C,X) :- reached(C, Y), inPath(Y,X,C).
:- stop(C,X), not reached(C, X).
:- stop(C,X), inPath(X,Y,C).
% :- reached(C, X), box(A, B, X), stop(Q,W), X != W.

cammini(X,Y, C) :- reached(C, X), inPath(X,Y,C), reached(C, Y). 
lunghezze(C,N) :- numCammini(C), #count{C, X, Y: cammini(X,Y,C)} = N.

% Pago la lunghezza del cammino a lv 1
:~ progCammini(L), #count{X,Y: inPath(X,Y,L)} = C. [C@1]

% Tra cammini di uguale lunghezza preferisco quello che mi fa muovere verso sinistra e in alto.
:~ inPath(A,B,N), start(N,A), D = A-B, A > B. [D@2]
:~ inPath(A,B,N), start(N,A), D = B-A, A < B. [D@2]

distanzeScatolePlayer(IB, D) :- player(_, _, IP), box(_, _, IB), D = IP - IB, IP > IB.
distanzeScatolePlayer(IB, D) :- player(_, _, IP), box(_, _, IB), D = IB - IP, IB > IP.
scatolaPiuVicina(IB, X) :- distanzeScatolePlayer(IB, X), #min{D: distanzeScatolePlayer(I, D)} = X. 
start(N, I) :- player(_, _, I), N = 1.
stop(N, I) :- boxDaMuovere(_, _, I), scatolaPiuVicina(I, _), N = 1.
% stop(N, I) :- targetLiberi(_, _, I), N = 1.
% stop(1,58).

direzioneDaPrendere(D) :- inPath(PI, SI, _), player(_, _, PI), PI = SI - 9, D = 1. %% sopra
direzioneDaPrendere(D) :- inPath(PI, SI, _), player(_, _, PI), PI = SI + 9, D = 2. %% sotto
direzioneDaPrendere(D) :- inPath(PI, SI, _), player(_, _, PI), PI = SI - 1, D = 3. %% destra
direzioneDaPrendere(D) :- inPath(PI, SI, _), player(_, _, PI), PI = SI + 1, D = 4. %% sinistra

%% Parte 1 - mi avvicino ad una scatola
setOnActuator(scrivoDir(gameManager(gameManager(x(X))))) :- direzioneDaPrendere(D), direction(D,X,Y).
setOnActuator(scrivoDir(gameManager(gameManager(y(Y))))) :- direzioneDaPrendere(D), direction(D,X,Y).




%% Parte 2 - Mi muovo verso un target
  
