nodo(1).
nodo(2).
nodo(3).
nodo(4).
nodo(5).
nodo(6).
nodo(7).
nodo(8).
nodo(9).
nodo(10).
nodo(11).

arc(1,2).
arc(1,5).

arc(2,3).
arc(2,7).

arc(5,6).
arc(5,10).

arc(7,8).

arc(8,4).

arc(10,9).
arc(10,11).

start(1,1).
stop(1,8).
start(2,5).
stop(2,11).
start(3,2).
stop(3,3).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% arc(X,Y) :- arc(Y,X).

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
distMin(M) :- #min{N: lunghezze(C,N)} = M.
camminoMin(C) :- distMin(M), lunghezze(C,M).
