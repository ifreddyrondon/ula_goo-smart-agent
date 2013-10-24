planificador_rumba(Out):-
	findall(Tipo,planificador_rumba(Tipo,_),Tipo),
	findall(Atributos,planificador_rumba(_,Atributos),Atributos),
	string_planificador(Tipo,Atributos,O1),list_string(O1,Out).
	
string_planificador([],[],[]):-!.
string_planificador([X1|Y1],[X2|Y2],[X3|Y3]):-
	list_string_ptoComa(X2,Atributos),
	concat('[',X1,O1),concat(O1,':',O2),concat(O2,Atributos,O3),concat(O3,']',X3),
	string_planificador(Y1,Y2,Y3).