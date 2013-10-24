% Determina si lo que recibe es una lista
lista([]):-!.
lista([_|Y]):-lista(Y).

% Tamano de cada intervalo de lista anidada, devuelve otra lista con los tamanos
length_nested_list([],[]):- !.
 length_nested_list([X|Y],[X2|Y2]):-
 	length(X,X2),length_nested_list(Y,Y2).

% Determina si un elemento X pertenece a una lista
pert(X,[X|_]):-!.
pert(X,[_|M]):-pert(X,M).

% Concatena dos listas
concatenar([],L,L).
concatenar([X|M],L,[X|Z]):-concatenar(M,L,Z).

% Suma los elementos de una lista
sum_elements_list([], S, S).
sum_elements_list([X|Xs], T, S):-
	T2 is T + X,sum_elements_list(Xs, T2, S).

% Divide cada elem de la lista por un #
div_by_elements_list([],_,[]).
div_by_elements_list([X|X1], Divisor, [Y|Y2]) :-
	Y is X/Divisor, div_by_elements_list(X1,Divisor,Y2).
	
% Divide una lista entre otra
div_list_by_other_list([],[],[]):-!.
div_list_by_other_list([X|Y],[X2|Y2],[X3|Y3]):-
	X3 is X2/X,
	div_list_by_other_list(Y,Y2,Y3).
	
% Inserta un elemento en la posicion N sima
insertar(L,1,X,[X|L]):-!.
insertar([X|Y],N,R,[X|L]):-N1 is N-1, insertar(Y,N1,R,L).

% DEFINIDO EN GOO	
% Elimina el elemento que se encuentra en la Nsima posicion
%sacapos([_|Y],1,Y).
%sacapos([X|Y],N,[X|R]):- N1 is N-1, sacapos(Y,N1,R).
	
%Reemplaza la aparici¢n de un elemento X en una lista, en todos los niveles, por otro elemento Y
reemplazar(_,_,[],[]):-!.
reemplazar(X,Y,[X|M],[Y|Z]):-reemplazar(X,Y,M,Z),!.
reemplazar(X,Y,[L|M],Z):-reemplazar(X,Y,L,T),reemplazar(X,Y,M,R),!,
                 concatenar([T],R,Z).
reemplazar(X,Y,[L|M],[L|Z]):-reemplazar(X,Y,M,Z),!.
	
% Elimina el elemento x de la lista en todos los niveles
elimina_x([],_,[]):-!.
elimina_x([X],X,[]):-!.
elimina_x([X|M],X,S):-elimina_x(M,X,S),!.
elimina_x([R|M],X,S):-lista(R), elimina_x(R,X,T), elimina_x(M,X,P), concatenar([T],P,S).
elimina_x([R|M],X,S):-elimina_x(M,X,T), concatenar([R],T,S).

% Elimina todos los elementos de la lista 1 que est n en la 2
elim_l1_de_l2([],L,L):-!.
elim_l1_de_l2([X|M],L,S):-elimina_x(L,X,T),elim_l1_de_l2(M,T,S).

% Elimina el primer elemento X que aparece en la lista
elim_prim_pos(_,[],[]):-!.
elim_prim_pos(X,[X|M],M):-!.
elim_prim_pos(X,[R|M],[R|L]):-elim_prim_pos(X,M,L).

% Elimina los elementos repetidos que est n en una lista	
elim_repet([],[]).
elim_repet([H|T],S):-member(H,T),!,elim_repet(T,S).
elim_repet([H|T],[H|S]):-elim_repet(T,S).
	
% Suma los elementos contiguos de la lista
generar_intervalos([], []).
generar_intervalos([X], [X]).
generar_intervalos([X, Y|Ys], [Z|Zs]):- Z is X + Y, generar_intervalos([Z|Ys], Zs).

% Da como resultado una lista, que es la intersecci¢n de las dos
interseccion(_,[],[]):-!.
interseccion([],_,[]):-!.
interseccion([X|L],[X|H],[X|Z]):-
	interseccion(L,H,Z),!.
interseccion([X|L],[R|H],[X|Z]):-
	pert(X,H),elim_prim_pos(X,[R|H],L2),interseccion(L,L2,Z),!.
interseccion([_|L],[R|H],Z):-
	interseccion(L,[R|H],Z),!.

% Arma una lista con todas las posiciones del elemento X en la lista
list_posic(_,[],_,[]):-!.
list_posic(X,[X|M],N,L):-
	N1 is N + 1,list_posic(X,M,N1,G),P is N + 1,concatenar([P],G,L).
list_posic(X,[_|M],N,L):-
	N1 is N + 1,list_posic(X,M,N1,L).

% Crea una lista de listas con las posiciones donde se encuentra cada elemento X de la primera lista
posicion_lista_lista([],_,[]):- !.
posicion_lista_lista([X1|Y1],TipoHorario,[X2|Y2]):-
	list_posic(X1,TipoHorario,0,X2),
	posicion_lista_lista(Y1,TipoHorario,Y2).

% Invierte la lista que recibe en el primer nivel
invertir([X],[X]).
invertir([X|M],Z):-
	invertir(M,S), concatenar(S,[X],Z).

% Invierte una lista en todos sus niveles
invertir_tot([],[]):-!.
invertir_tot([X|M],S):-lista(X),invertir_tot(X,P),invertir_tot(M,T),concatenar(T,[P],S).
invertir_tot([X|M],S):-invertir_tot(M,T),concatenar(T,[X],S),!.

% Da como resultado los n primeros elementos de una lista
da_n_pri([],0,[]):-!.
da_n_pri([],_,[]):-!.
da_n_pri([X|_],1,[X]):-!.
da_n_pri([X|M],N,S):-N1 is N - 1,da_n_pri(M,N1,T),concatenar([X],T,S).

% Muestra los ultimos n elementos de la lista
da_n_ultim(L,N,S):-
	invertir_tot(L,T),da_n_pri(T,N,R),invertir_tot(R,S).

% Revisar de que intervalo (Superitor) es miembro R
n_is_member([],_,[]).
n_is_member([X],_,[X]).
n_is_member([X|Xs],R, L):-
          (X<R, n_is_member(Xs,R, L));
          (L is X,n_is_member([X],_,[X])).

 % Calcula la primer posicion donde aparece el elemento X en la lista
prim_pos(_,[],0):-!.
prim_pos(X,[X|_],1):-!.
prim_pos(X,[_|M],S):-prim_pos(X,M,T),S is T + 1.

% Devuelve el elemento que se encuentra en la enesima posicion
posicion_n([],_,[]):-!.
posicion_n([X|_],1,X):-!.
posicion_n([_|R],N,S):-M is N - 1,posicion_n(R,M,S).

% Calcula el maximo elemento de una lista
maximo([X],X):-!.
maximo([X,Y|M],X):-maximo([Y|M],Z),X>=Z.
maximo([X|M],Z):-maximo(M,Z),Z>X.

% Arma una lista con todos los elementos en secuencia creciente a partir de X
mayores(_,[],[]).
mayores(X,[Y|M],[Y|S]):-X=<Y,mayores(Y,M,S).
mayores(X,[_|M],S):-mayores(X,M,S).

% Arma una lista en orden decreciente a partir del elemento X
menores(_,[],[]).
menores(X,[Y|Z],[Y|R]):-X>=Y,menores(Y,Z,R).
menores(X,[_|Z],R):-menores(X,Z,R).

% Ordena una lista en orden ascendente
ord_ascend([],[]):-!.
ord_ascend(L,R):-
	maximo(L,X),elim_prim_pos(X,L,L1),ord_ascend(L1,L2),!,concatenar(L2,[X],R).
	
% Ordena una lista en orden descendente
ord_descend(L,L2):-
	ord_ascend(L,L3),invertir(L3,L2).

% Listas a String separado por ,
list_codes([], "").
list_codes([Atom], Codes) :- atom_codes(Atom, Codes).
list_codes([Atom|ListTail], Codes) :-
	atom_codes(Atom, AtomCodes),
    	append(AtomCodes, ",", AtomCodesWithComma),append(AtomCodesWithComma, ListTailCodes, Codes),
    	list_codes(ListTail, ListTailCodes).
list_string(List, String) :-
	ground(List),list_codes(List, Codes),atom_codes(String, Codes).
list_string(List, String) :-
    	ground(String),atom_codes(String, Codes),
    	list_codes(List, Codes).
    	    	
    	
 % Listas a String separado por espacio
list_codes2([], "").
list_codes2([Atom], Codes) :- atom_codes(Atom, Codes).
list_codes2([Atom|ListTail], Codes) :-
	atom_codes(Atom, AtomCodes),
    	append(AtomCodes, " ", AtomCodesWithComma),append(AtomCodesWithComma, ListTailCodes, Codes),
    	list_codes2(ListTail, ListTailCodes).
list_string_espacios(List, String) :-
	ground(List),list_codes2(List, Codes),atom_codes(String, Codes).
list_string_espacios(List, String) :-
    	ground(String),atom_codes(String, Codes),
    	list_codes2(List, Codes).

% Listas a String separado por NADA
list_codes3([], "").
list_codes3([Atom], Codes) :- atom_codes(Atom, Codes).
list_codes3([Atom|ListTail], Codes) :-
	atom_codes(Atom, AtomCodes),
    	append(AtomCodes, "", AtomCodesWithComma),append(AtomCodesWithComma, ListTailCodes, Codes),
    	list_codes3(ListTail, ListTailCodes).
list_string_vacio(List, String) :-
	ground(List),list_codes3(List, Codes),atom_codes(String, Codes).
list_string_vacio(List, String) :-
    	ground(String),atom_codes(String, Codes),
    	list_codes3(List, Codes).

% Listas a String separado por ;
list_codes4([], "").
list_codes4([Atom], Codes) :- atom_codes(Atom, Codes).
list_codes4([Atom|ListTail], Codes) :-
	atom_codes(Atom, AtomCodes),
    	append(AtomCodes, ";", AtomCodesWithComma),append(AtomCodesWithComma, ListTailCodes, Codes),
    	list_codes4(ListTail, ListTailCodes).
list_string_ptoComa(List, String) :-
	ground(List),list_codes4(List, Codes),atom_codes(String, Codes).
list_string_ptoComa(List, String) :-
    	ground(String),atom_codes(String, Codes),
    	list_codes4(List, Codes).    	



% LISTAS ANIDADAS 

% de lista anidada a simple
anidada_simple(X,[X]) :- \+ is_list(X).
anidada_simple([],[]).
anidada_simple([X|Xs],Zs) :- anidada_simple(X,Y), anidada_simple(Xs,Ys), append(Y,Ys,Zs).

%agrupacion para crearlas
%Group the elements of a set into disjoint subsets.
% Problem a)

% group3(G,G1,G2,G3) :- distribute the 9 elements of G into G1, G2, and G3,
%    such that G1, G2 and G3 contain 2,3 and 4 elements respectively

group3(G,G1,G2,G3) :- 
   selectN(2,G,G1),
   subtract(G,G1,R1),
   selectN(3,R1,G2),
   subtract(R1,G2,R2),
   selectN(4,R2,G3),
   subtract(R2,G3,[]).

% selectN(N,L,S) :- select N elements of the list L and put them in 
%    the set S. Via backtracking return all posssible selections, but
%    avoid permutations; i.e. after generating S = [a,b,c] do not return
%    S = [b,a,c], etc.

selectN(0,_,[]) :- !.
selectN(N,L,[X|S]) :- N > 0, 
   el(X,L,R), 
   N1 is N-1,
   selectN(N1,R,S).

el(X,[X|L],L).
el(X,[_|L],R) :- el(X,L,R).

% subtract/3 is predefined

% Problem b): Generalization

% group(G,Ns,Gs) :- distribute the elements of G into the groups Gs.
%    The group sizes are given in the list Ns.

group([],[],[]).
group(G,[N1|Ns],[G1|Gs]) :- 
   selectN(N1,G,G1),
   subtract(G,G1,R),
   group(R,Ns,Gs).