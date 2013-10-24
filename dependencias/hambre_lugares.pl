% Agregar Lugar General
agregar_lugar_general(ObjetoSugerido,LugarAprender,Out) :-
	((agregar_hecho(hambre_lugar(ObjetoSugerido,LugarAprender,_)),Out = 'lugar_comida_agregado,Nuevo lugar agregado, se tomara en cuenta para las proximas sugerencias');
	 (Out = 'lugar_comida_agregado,No se puedo agregar el lugar nuevo, intenta de nuevo mas tarde')).

%	nl,write('No conozco ningun lugar para '),write(AccionObjetoSugerido),tab(2),write(ObjetoSugerido),nl,write('Desea agregar uno: (Si/No)'),read_atomics(Input),
%	procesar_respuesta_si_no(Input,Respuesta),
%	((Respuesta == -1,nl,write('Ninguna sugerencia de lugar'));						
%	 (Respuesta == 1,nl,write('Escriba el nombre del lugar:'),nl,read_atomics(Lugar),list_string_espacios(Lugar,LugarString),agregar_hecho(hambre_lugar(ObjetoSugerido,LugarString,_)),nl,write('Nuevo lugar agregado, se tomara en cuenta para las proximas sugerencias'));
%	 (Respuesta == 0, nl,write('Debe responder SI o NO'),agregar_lugar_general(ObjetoSugerido,AccionObjetoSugerido))
%	).

sugerencia_lugar(P,ComidaSugerida,Lugar):-
	procesar_predicado(P,P2),list_string_espacios(P2,Lugar),
	((hambre_lugar(ComidaSugerida,Lugar,_),agregar_hecho(hambre_lugar(ComidaSugerida,Lugar,_)));(ComidaSugerida= 'false')).