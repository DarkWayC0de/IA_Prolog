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
    permutacion(XX,X),
    permutacion(YY,Y),
    nocome(XX),
    nocome(YY)%,
   %length(X,W),
   %length(Y,V),
   %4 is W + V
    .
comprobarlista([],_,_).
comprobarlista([X|[]],Y,_):-
    not(lista(X,Y)).
comprobarlista([X|Z],W,Y):-
    not(lista(X,W)),
    not(lista(Z,Y)).
lista([],[]).
lista([Cabeza|Cola],Y):-
    extraer(Cabeza,Y,Y1),
    lista(Cola,Y1).
viaja([],Y,_):-
    permutacion(Y,[pastor,lobo,oveja,col]).
viaja(X,Y,W):-
    permutacion(Xpermu,X),
    extraer(pastor,Xpermu,Xsinpastor),    
    viajasolooacompanadoX(Xsinpastor,X,Y,W).    
viaja(X,Y,W):-
    permutacion(Ypermu,Y),
    extraer(pastor,Ypermu,Ysinpastor),
    viajasolooacompanadoY(Ysinpastor,X,Y,W).
viajasolooacompanadoY(Ysinpastor,X,Y,W):-
    termina([pastor|X],Ysinpastor,W),
    viaja([pastor|X],Ysinpastor,[X,Y]).
viajasolooacompanadoY(Ysinpastor,X,Y,W):-
    extraer(Z,Ysinpastor,YsinpastoryZ),
    termina([pastor,Z|X],YsinpastoryZ,W),
    viaja([pastor,Z|X],YsinpastoryZ,[X,Y]).
viajasolooacompanadoX(Xsinpastor,X,Y,W):-
    termina(Xsinpastor,[pastor|Y],W),
    viaja(Xsinpastor,[pastor|Y],[X,Y]).
viajasolooacompanadoX(Xsinpastor,X,Y,W):-
    extraer(Z,Xsinpastor,XsinpastoryZ),
    termina(XsinpastoryZ,[pastor,Z|Y],W),
    viaja(XsinpastoryZ,[pastor,Z|Y],[X,Y]).
termina(X,Y,W):-
    orilla(X,Y),
    comprobarlista(W,X,Y),
    printlist(X),
    write("| "),
    printlist(Y),
    nl.
resolverProblema(_):-
   viaja([pastor,lobo,oveja,col],[],[]). 
printlist([]).
printlist([X|List]) :-
	write(X),
    write(" "),
    printlist(List).