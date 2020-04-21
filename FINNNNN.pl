extraer(K,[K|L],L).
extraer(K,[D|T],[D|R]):-
    extraer(K,T,R).
nocome([pastor|_]).
nocome([]).
nocome([oveja]).
nocome([lobo]).
nocome([col]).
nocome([lobo,col]).
nocome([col,lobo]).
orilla(X,Y):-
    nocome(X),
    nocome(Y).  
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
    imprimeSolucion([[[],Y]|W]),
    write("*************************************************************************"),
    nl.
viaja(X,Y,W):-                            %Si pastor se encuentra en la primera orilla(X)
    extraer(pastor,X,Xsinpastor),    
    viajaSoloOAcompanadoX(Xsinpastor,X,Y,W).    
viaja(X,Y,W):-                            %Si pastor se encuentra en la segunda orilla(Y)
    extraer(pastor,Y,Ysinpastor),
    viajaSoloOAcompanadoY(Ysinpastor,X,Y,W).
viajaSoloOAcompanadoX(Xsinpastor,X,Y,W):-%Si pastor se encuentra en la primera orilla(X) y viaja solo
    evaluarReglas(Xsinpastor,[pastor|Y],W),
    viaja(Xsinpastor,[pastor|Y],[[X,Y]|W]).
viajaSoloOAcompanadoX(Xsinpastor,X,Y,W):-%Si pastor se encuentra en la primera orilla(X) y viaja acompañado
    extraer(Z,Xsinpastor,XsinpastoryZ),
    evaluarReglas(XsinpastoryZ,[pastor,Z|Y],W),
    viaja(XsinpastoryZ,[pastor,Z|Y],[[X,Y]|W]).
viajaSoloOAcompanadoY(Ysinpastor,X,Y,W):- %Si pastor se encuentra en la segunda orilla(Y) y viaja solo
    evaluarReglas([pastor|X],Ysinpastor,W),
    viaja([pastor|X],Ysinpastor,[[X,Y]|W]).
viajaSoloOAcompanadoY(Ysinpastor,X,Y,W):-%Si pastor se encuentra en la segunda orilla(Y) y viaja acompañado
    extraer(Z,Ysinpastor,YsinpastoryZ),
    evaluarReglas([pastor,Z|X],YsinpastoryZ,W),
    viaja([pastor,Z|X],YsinpastoryZ,[[X,Y]|W]).
evaluarReglas(X,Y,W):-   
    orilla(X,Y),  %comprueba que la orilla es valida
    comprobarLista(W,X,Y).   %Comprueba que no se repita el paso anterio

imprimeSolucion([]).
imprimeSolucion([[X|Y]|L]):-
    imprimeSolucion(L),
    write(X),
    write(" | "),
    [Y1|_]= Y,
    write(Y1),
    nl.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%llamada de prolog%%%%%%%%%%%%%%%%%% viaja([pastor,lobo,oveja,col],[],[]). 