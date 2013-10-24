%ESTUDIANDO
	pregunta_estudiando(_,_,_,P,Out):-
		procesar_predicado(P,P2),list_string(P2,S),agregar_hecho(busquedas(estudiando,S,_)),
		concat('estudiando',',',O1),concat(O1,S,Out).