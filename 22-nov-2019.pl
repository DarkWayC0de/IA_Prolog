extraer(X,[X|L],L).
extraer(X,[Y|T],[Y|R]):-
    extraer(X,T,R).
%Variables solo a la izquierda
permutacion([],[]).
permutacion([A|X],B):-
    extraer(A,B,C),
    permutacion(X,C).

%  A
% BCD
% EFG
%  H
no_vecino(_,[]).
no_vecino(A,[C|L]):-
    A =\=C+1,
    A =\=C-1,
    no_vecino(A,L).
%% ejecucion calculo(A,X,Y).
calculo(A,[B,C,D],[E,F,G],H):-
    permutacion([A,B,C,D,E,F,G,H],[1,2,3,4,5,6,7,8]),
    no_vecino(A,[B,C,D]),
    no_vecino(B,[C,E,F]),
    no_vecino(C,[D,E,F,G]),
    no_vecino(D,[F,G]),
    no_vecino(E,[F,H]),
    no_vecino(F,[G,H]),
    no_vecino(G,[H]).





orilla([pastor,lobo,oveja,col],[]).
orilla([pastor,lobo,col],[oveja]).
orilla([pastor,oveja,col],[lobo]).
orilla([pastor,lobo,oveja],[col]).
orilla([lobo,col],[pastor,oveja]).
orilla([pastor,oveja],[lobo,col]).
orilla([col],[pastor,lobo,oveja]).
orilla([oveja],[pastor,lobo,col]).
orilla([lobo],[pastor,oveja,col]).
orilla([],[pastor,lobo,oveja,col]).
