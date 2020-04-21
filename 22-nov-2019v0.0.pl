sum(X,Y,Z,W):-
    A is X+Y,
    A is Z +W.

append([],X,X).
append([A|Ta],B,[A|R]):-
    append(Ta,B,R).

prefix(A,B):-
    append(A,_,B).

suflix(A,B):-
    append(_,A,B).

sublist(A,B):-
    suflix(C,B),
    prefix(A,C).

rev([A|Ta],Acc,R):-
    rev(Ta,[A|Acc],R).

rev([],Acc,Acc).

rev(L,R):-
    rev(L,[],R).
