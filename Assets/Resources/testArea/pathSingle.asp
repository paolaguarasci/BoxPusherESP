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

start(1).
stop(8).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% arc(X,Y) :- arc(Y,X).

inPath(X,Y) | outPath(X,Y) :- arc(X,Y).
:- inPath(X,Y), inPath(X,Y1), Y <> Y1.
:- inPath(X,Y), inPath(X1,Y), X <> X1. 
% :- node(X), not reached(X).
reached(X) :- start(X).
reached(X) :- reached(Y), inPath(Y,X).
:- stop(X), not reached(X).
:- stop(X), inPath(X,Y).

cammino(X,Y) :- reached(X), inPath(X,Y), reached(Y).