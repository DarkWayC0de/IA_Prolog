extraer(K,[K|L],L).
extraer(K,[D|T],[D|R]):-
    extraer(K,T,R).
%Variables solo a la izquierda
permutacion([],[]).
permutacion([A|K],B):-
    extraer(A,B,C),
    permutacion(K,C).
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
    nocome(YY).
   %length(X,W),
   %length(Y,V),
   %4 is W + V.
    
comprobarLista([],_,_).
comprobarLista([E|C],X,Y):-
    comprobarEtapa(E,X,Y),
    comprobarLista(C,X,Y).
comprobarEtapa([],_,_).  %si el paso anterior es vacia, correcto
comprobarEtapa([K|[]],X,_):-  %si paso anterior solo tiene un elemento lo comparamos con nuesta primera orilla
    not(lista(K,X)).
comprobarEtapa([K|Z],X,Y):- %si el paso anterior tiene dos elemntos comparamos primero con la primera orilla 
    not(lista(K,X)),        % y segundo con la segunda orilla
    not(lista(Z,Y)).
lista([],[]).
lista([Cabeza|Cola],Y):-
    extraer(Cabeza,Y,Y1),
    lista(Cola,Y1).
viaja([],Y,W):-                           % Condicion final
    permutacion(Y,[pastor,lobo,oveja,col]),
    imprimeSolucion([[[],Y]|W]),
    write("*************************************************************************"),
    nl.
viaja(X,Y,W):-                            %Si pastor se encuentra en la primera orilla(X)
    permutacion(Xpermu,X),
    extraer(pastor,Xpermu,Xsinpastor),    
    viajaSoloOAcompanadoX(Xsinpastor,X,Y,W).    
viaja(X,Y,W):-                            %Si pastor se encuentra en la segunda orilla(Y)
    permutacion(Ypermu,Y),
    extraer(pastor,Ypermu,Ysinpastor),
    viajaSoloOAcompanadoY(Ysinpastor,X,Y,W).
viajaSoloOAcompanadoY(Ysinpastor,X,Y,W):- %Si pastor se encuentra en la segunda orilla(Y) y viaja solo
    evaluarReglas([pastor|X],Ysinpastor,W),
    viaja([pastor|X],Ysinpastor,[[X,Y]|W]).
viajaSoloOAcompanadoY(Ysinpastor,X,Y,W):-%Si pastor se encuentra en la segunda orilla(Y) y viaja acompañado
    extraer(Z,Ysinpastor,YsinpastoryZ),
    evaluarReglas([pastor,Z|X],YsinpastoryZ,W),
    viaja([pastor,Z|X],YsinpastoryZ,[[X,Y]|W]).
viajaSoloOAcompanadoX(Xsinpastor,X,Y,W):-%Si pastor se encuentra en la segunda orilla(X) y viaja solo
    evaluarReglas(Xsinpastor,[pastor|Y],W),
    viaja(Xsinpastor,[pastor|Y],[[X,Y]|W]).
viajaSoloOAcompanadoX(Xsinpastor,X,Y,W):-%Si pastor se encuentra en la segunda orilla(X) y viaja acompañado
    extraer(Z,Xsinpastor,XsinpastoryZ),
    evaluarReglas(XsinpastoryZ,[pastor,Z|Y],W),
    viaja(XsinpastoryZ,[pastor,Z|Y],[[X,Y]|W]).
evaluarReglas(X,Y,W):-   
    orilla(X,Y),        %comprueba que la orilla es valida
    comprobarLista(W,X,Y).   %Comprueba que no se repita el paso anterio
imprimeSolucion([]).
imprimeSolucion([[X|Y]|L]):-
    imprimeSolucion(L),
    printList(X),
    write(" | "),
    printList(Y),
    nl.
resolverProblema(_):-                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%llamada de prolog%%%%%%%%%%%%%%%%%%
    viaja([pastor,lobo,oveja,col],[],[]). 
printList([]).                           %imprime lista vacia termina
printList([X|List]) :-                   % imprime lista
	write(X),
    write(" "),
    printList(List).