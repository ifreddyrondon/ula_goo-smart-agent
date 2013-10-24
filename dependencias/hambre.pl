 %HAMBRE
	sugerencias_hambre(P,ComidaSugerida,Lugar) :- 
		% Si no hay comida en el predicado sugerir comida por probabilidad
		P == [],sugerir(comida(_,_),ComidaSugerida),
		% Y sugerir lugar por probabilidad segun la comida
		sugerir(hambre_lugar(ComidaSugerida,_,_),LugarSugerido), 
		% Si no existe el lugar agregar uno, preguntando si quiere o no
		%((LugarSugerido == [],agregar_lugar_general(ComidaSugerida,comer));
		((LugarSugerido == [],Lugar='false');
		% Si Existe el lugar mostrarlo
		(Lugar = LugarSugerido));
		% Si hay comida en el predicado
		procesar_predicado(P,P2),list_string(P2,ComidaSugerida),agregar_hecho(comida(ComidaSugerida,_)),hora(H,_,_),horario(H,StringHora),agregar_hecho(tiempo(ComidaSugerida,comida,StringHora,_)),sugerir(hambre_lugar(ComidaSugerida,_,_),LugarSugerido),
		((LugarSugerido == [],Lugar = 'false');
		% Si Existe el lugar mostrarlo
		(Lugar = LugarSugerido)).
		
	consultar_hambre(ComidaFavorita,'') :-
		hecho_favorito(comida(_,_),ComidaFavorita).