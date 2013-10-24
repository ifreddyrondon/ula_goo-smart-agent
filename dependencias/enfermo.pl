 agregar_enfermedad_medicamento_nuevo(Enfermedad):-
 	nl,write('No conozco ningun medicamento para la/el '),write(Enfermedad),tab(2),nl,write('Desea agregar uno: (Si/No)'),read_atomics(Input),
 	procesar_respuesta_si_no(Input,Respuesta),
 	((Respuesta == -1,nl,write('Ninguna sugerencia de Medicamento'));						
	 (Respuesta == 1,nl,write('Escriba el nombre del Medicamento:'),nl,read_atomics(Medicamento),list_string_espacios(Medicamento,MedicamentoString),agregar_enfermedad_medicamento(Enfermedad,MedicamentoString),nl,write('Nuevo Medicamento agregado, se tomara en cuenta para las proximas sugerencias'));
	 (Respuesta == 0, nl,write('Debe responder SI o NO'),agregar_enfermedad_medicamento_nuevo(Enfermedad))
	).
agregar_enfermedad_medicamento(X,Y):-
	(enfermo(X,Y,_),aumentar_enfermedad_medicamento(X,Y));
	(assert(enfermo(X,Y,1)),
	tell('hechos/enfermo_hechos.pl'),
	listing(enfermo/3), told).
	
agregar_enfermedad_medicamento(X,Y,Z):-
	(enfermo(X,Y,_),aumentar_enfermedad_medicamento(X,Y));
	(assert(enfermo(X,Y,Z)),
	tell('hechos/enfermo_hechos.pl'),
	listing(enfermo/3), told).
	
aumentar_enfermedad_medicamento(X,Y):-
	enfermo(X,Y,Z2),
	retract(enfermo(X,Y,Z2)),
	Z is Z2 +1,
	assert(enfermo(X,Y,Z)),
	tell('hechos/enfermo_hechos.pl'),
	listing(enfermo/3), told.
	
aumentar_enfermedad_medicamento(X):-
	enfermo(X,Y,Z2),
	retract(enfermo(X,Y,Z2)),
	Z is Z2 +1,
	assert(enfermo(X,Y,Z)),
	tell('hechos/enfermo_hechos.pl'),
	listing(enfermo/3), told.
	
editar_enfermedad_medicamento(X,Y,Z):-
	enfermo(X,Y,Z2),
	retract(enfermo(X,Y,Z2)),
	assert(enfermo(X,Y,Z)),
	tell('hechos/enfermo_hechos.pl'),
	listing(enfermo/3), told.

editar_enfermedad_medicamento(X,Medicamento):-
	enfermo(X,Y,Z),
	retract(enfermo(X,Y,Z)),
	concat(Y, ', ', Y2),concat(Y2, Medicamento, Y3),
	assert(enfermo(X,Y3,Z)),
	tell('hechos/enfermo_hechos.pl'),
	listing(enfermo/3), told.
	
ver_enfermedad_medicamento :-
	listing(enfermo/3).
	
procesar_varios_medicamentos_en_sugerencias(Enfermedad):-
	nl,write('Quieres agregar otro medicamento: (Si/No)'),read_atomics(Input),procesar_respuesta_si_no(Input,Respuesta),
	((Respuesta == -1,nl,write('Si el dolor persiste, debes consultar al medico'));
	 (Respuesta == 1,nl,write('Escriba el nombre del Medicamento:'),nl,read_atomics(Medicamento),list_string_espacios(Medicamento,MedicamentoString),editar_enfermedad_medicamento(Enfermedad,MedicamentoString),nl,write('Nuevo Medicamento agregado, se tomara en cuenta para las proximas sugerencias'));
	 (Respuesta == 0, nl,write('Debe responder SI o NO'),procesar_varios_medicamentos_en_sugerencias(Enfermedad))
	).
	
preguntar_por_sintomas:-
	nl,write('Que sientes'),nl,read_atomics(Input),procesar_predicado(Input,Input2),
	elim_l1_de_l2([medico,medicina,doctor,paciente,operacion,sintoma,duele,dolor,mal,siento,tengo],Input2,Sintomas),
	write(Sintomas).
		
		
	%ENFERMO
	sugerencias_enfermo(_,_,_,P,Out):-
		% Si no hay predicado preguntar por los sintomas
		%P == [],preguntar_por_sintomas;
		P == [],Out = 'enfermo,sintomas';
		% Si hay predicado
		procesar_predicado(P,P2),list_string(P2,Enfermedad),sugerir(enfermo(Enfermedad,_,_),MedicamentoSugerido),
		((MedicamentoSugerido == [], concat('enfermo',',',O1),concat(O1,Enfermedad,O2),concat(O2,',',O3), concat(O3,'false',Out));
		(aumentar_enfermedad_medicamento(Enfermedad),concat('enfermo',',',O1),concat(O1,Enfermedad,O2),concat(O2,',',O3),concat(O3,MedicamentoSugerido,Out))).
		