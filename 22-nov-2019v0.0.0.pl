contadorlista([_|T],Acc,R):-
    Acc2 is Acc+1,
    contadorlista(T,Acc2,R).
contadorlista([],Acc,R):-
    Acc = R.
    
hmi(L,R):- 
    contadorlista(L,0,R).