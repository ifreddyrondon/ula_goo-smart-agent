sugerencias_rumba(_,Out):-
	hora(H,_,_),horario(H,StringHora),agregar_hecho(tiempo(rumbiar,rumbiar,StringHora,_)),
	Out = 'rumbiar,rumbiar'.