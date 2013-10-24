%DEPORTISTA	
	sugerencias_deporte(_,_,Edo,P,Out):-
		%Si pregunta por su peso
		(Edo == gordo,sugerir(deporte(_,_),DeporteSugerido),concat('deporte',',',O1),concat(O1,DeporteSugerido,O2),concat(O2,', para bajar de peso, tu perfil fisico es: ',O3),perfil(Perfil),concat(O3,Perfil,Out));
		(Edo == flaco,((va_al_gym(_),sugerir(comida(_,_),ComidaSugerida),concat('deporte,gym o comer ',ComidaSugerida,O1),concat(O1,', para ganar peso, tu perfil fisico es: ',O2),perfil(Perfil),concat(O2,Perfil,Out));(sugerir(comida(_,_),ComidaSugerida),concat('deporte',',',O1),concat(O1,ComidaSugerida,O2),concat(O2,' para ganar peso, tu perfil fisico es: ',O3),perfil(Perfil),concat(O3,Perfil,Out))));
		%Si el predicado esta vacio
		P == [],sugerir(deporte(_,_),DeporteSugerido),concat('deporte',',',O1),concat(O1,DeporteSugerido,Out);
		%Si hay algo en el predicado aprende
		procesar_predicado(P,P2),list_string(P2,S),agregar_hecho(deporte(S,_)),hora(H,_,_),horario(H,StringHora),agregar_hecho(tiempo(S,deporte,StringHora,_)).
		
	
		