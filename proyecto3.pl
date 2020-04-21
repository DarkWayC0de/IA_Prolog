extraer(X,[X|L],L).
extraer(X,[Y|T],[Y|R]):-
    extraer(X,T,R).
%extraer([],L,L).
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
viaja([],Y,_):-
    permutacion(Y,[pasto,lobo,oveja,col]),
    write("| "),
    write(Y),
    nl.
viaja(X,Y,W):-
    permutacion(Xpermu,X),
    extraer(pastor,Xpermu,Xsinpastor),
    extraer(Z,Xsinpastor,XsinpastoryZ),
    termina(XsinpastoryZ,[pastor,Z|Y],W),
    viaja(XsinpastoryZ,[pastor,Z|Y],[X,Y]).
viaja(X,Y,W):-
    permutacion(Ypermu,Y),
    extraer(pastor,Ypermu,Ysinpastor),
    extraer(Z,Ysinpastor,YsinpastoryZ),
    termina([pastor,Z|X],YsinpastoryZ,W),
    viaja([pastor,Z|X],YsinpastoryZ,[X,Y]).
%viaja([pastor|X],Y,W):-
%    termina(X1,[pastor|Y],W),
%    viaja(X1,[pastor|Y],[[pastor|X],Y]).
%viaja(X,[pastor|Y],W):-
%    termina([pastor|X],Y1,W),
%    viaja([pastor|X],Y1,[X,[pastor|Y]]).
termina(X,Y,W):-
    orilla(X,Y),
    comprobarlista(W,X,Y),
    printlist(X),
    write("| "),
    printlist(Y),
    nl.
comprobarlista([],_,_).
comprobarlista([R|C],X,Y):-
  permutacion(X,X1),
  permutacion(Y,Y1),
  dif(R,X1),
  dif(C,Y1).
resolverProblema(_):-
   viaja([pastor,lobo,oveja,col],[],[]). 
printlist([]).
printlist([X|List]) :-
	write(X),
    write(" "),
    printlist(List).