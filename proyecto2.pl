extraer(X,[X|L],L).
extraer(X,[Y|T],[Y|R]):-
    extraer(X,T,R).

%Variables solo a la izquierda
permutacion([],[]).
permutacion([A|X],B):-
    extraer(A,B,C),
    permutacion(X,C).

nocome([pastor|_]).
nocome([]).
nocome([oveja]).
nocome([lobo]).
nocome([col]).
nocome([lobo,col]).

orilla(X,Y):-
    nocome(X),
    nocome(Y),
   length(X,W),
   length(Y,V),
    4 is W + V.
viaja([],[pastor,lobo,oveja,col],_):-
    write("|pastor,lobo,oveja,col"), 
    nl.
viaja([pastor|X],Y,W):-
    extraer(Z,X,X1),
    orilla(X1,[pastor,Z|Y]),
    comprobarlista(W,X1,[pastor,Z|Y]),
    printlist(X1),
    write("|"),
    printlist([pastor,Z|Y]),
    nl,
    viaja(X1,[pastor,Z|Y],[pastor|X],Y]).
viaja(X,[pastor|Y],W):-
    extraer(Z,Y,Y1),
    orilla([pastor,Z|X],Y1),
    comprobarlista(W,[pastor,Z|X],Y1),
    printlist([pastor,Z|X]),
    write("|"),
    printlist(Y1),
    nl,
    viaja([pastor,Z|X],Y1,[X,[pastor|Y]]).
 comprobarlista([R|C],X,Y):-
    R =X,
    C =Y.
printlist([]).
printlist([X|List]) :-
	write(X),
    write(" "),
    printlist(List).