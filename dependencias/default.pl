% Funciones de las dependencias		

%AGREGAR HECHO
% para el tiempo	
agregar_hecho(Hecho):-
	copy_term(Hecho, Hecho2),
	arg(4,Hecho2,Numero2),arg(1,Hecho2,_),arg(2,Hecho2,_),arg(3,Hecho2,_),
	arg(4,Hecho,Numero),arg(1,Hecho,_),arg(2,Hecho,_),arg(3,Hecho,_),	
	functor(Hecho, Hecho_Nombre, _),
	concat(Hecho_Nombre,'(_,_,_,_)',HechoString),read_from_string(HechoString, HechoString2),
	Archivo = 'hechos/tiempo_hechos.pl',
	((Hecho,retract(Hecho),Numero2 is Numero + 1,assert(Hecho2),tell(Archivo),listing(HechoString2),told);
	 (Numero2 is 1,assert(Hecho2),tell(Archivo),listing(HechoString2),told)).

agregar_hecho(Hecho):-
	copy_term(Hecho, Hecho2),
	functor(Hecho, Hecho_Nombre, _),
	((arg(3,Hecho2,_),arg(2,Hecho2,ParametroHecho2),arg(3,Hecho2,ParametroNumero2),concat(Hecho_Nombre,'(X,Y,Z)',Hecho_Nuevo),read_from_string(Hecho_Nuevo, Hecho_Nuevo2));
	(arg(2,Hecho2,_),arg(1,Hecho2,ParametroHecho2),arg(2,Hecho2,ParametroNumero2),concat(Hecho_Nombre,'(X,Y)',Hecho_Nuevo),read_from_string(Hecho_Nuevo, Hecho_Nuevo2))),
	((arg(3,Hecho,_),arg(2,Hecho,ParametroHecho),arg(3,Hecho,ParametroNumero));
	(arg(2,Hecho,_),arg(1,Hecho,ParametroHecho),arg(2,Hecho,ParametroNumero))),
	((Hecho,retract(Hecho),ParametroNumero2 is ParametroNumero + 1,assert(Hecho2),concat('hechos/',Hecho_Nombre,FileHechos),concat(FileHechos,'_hechos.pl',FileHechos2),tell(FileHechos2),listing(Hecho_Nuevo2),told);
	(ParametroNumero2 is 1,assert(Hecho2),concat('hechos/',Hecho_Nombre,FileHechos),concat(FileHechos,'_hechos.pl',FileHechos2),tell(FileHechos2),listing(Hecho_Nuevo2),told)),
	calculo_prob(Hecho_Nuevo2).

%VERIFICAR HECHOS (NORMALES,TIEMPO)
verificar_hechos(Hecho):-
	functor(Hecho, Hecho_Nombre, _),
	((arg(3,Hecho,Numero),arg(2,Hecho,Objeto));
	(arg(2,Hecho,Numero),arg(1,Hecho,Objeto))),
	findall(Numero,Hecho,NumeroNormal),findall(NumeroTiempo,tiempo(Objeto,Hecho_Nombre,_,NumeroTiempo),NumeroTiempo),
	sum_elements_list(NumeroNormal,0,NumeroNormalTotal),sum_elements_list(NumeroTiempo,0,NumeroTiempoTotal),
	NumeroNormalTotal == NumeroTiempoTotal.

%SUGERIR
%	Entrada: El hecho completo de la forma ejm: comida_favorita(X,Y),
%			ParametroNumero_ParametroHecho, de la forma [Y,X] para estadisticas
%			ParametroNumero de la forma Z para estadisticas
sugerir(Hecho,ElementoFinal) :-
	((arg(3,Hecho,_),arg(2,Hecho,ParametroHecho),arg(3,Hecho,ParametroNumero));
	(arg(2,Hecho,_),arg(1,Hecho,ParametroHecho),arg(2,Hecho,ParametroNumero))),
 	findall([ParametroNumero,ParametroHecho],Hecho,E),
 	findall(ParametroNumero,Hecho,L),
 	msort(E,E2), 
	% Calculo de la suma de el numero de veces total
	sum_elements_list(L,0,S),
	% Divide el # de veces de cada elemento entre la suma total para generar la prob
	div_by_elements_list(L,S,L1),
	% Ordena de menor a mayor la lista de Prob para generar los intervalos
	msort(L1,L2),
	% Insertar el 0 para generar los intervalos
	insertar(L2,1,0,L3),
	% Genera Intervalos
	generar_intervalos(L3,L4),
	% Cantidad de elementos para eliminar el ultimo elemento basura
	length(L4,S1),
	% Eliminar el 1 basura al fina 
	sacapos(L4,S1,L5),
	% Generar Numero Pseudo Aleatorio
	random(0.0,1.0,R),
	% Revisar de que intervalo (Superitor) es miembro el numero aleatorio generado
	n_is_member(L5,R,S2),
	% Calculo de en que posicion se encuentra el intervalo encontrado
	prim_pos(S2,L5,S3),
	% Mapeo de la posicion encontrada con la lista ordenada de elementos
	posicion_n(E2,S3,E3),
	% Filtrando solo el nombre del elemento
	posicion_n(E3,2,ElementoFinal).

%HECHO FAVORITO
% Encuentra el hecho mas utilizado
%	Entrada: El hecho completo de la forma ejm: comida_favorita(X,Y),
%			ParametroNumero_ParametroHecho, de la forma [Y,X] para estadisticas
%			ParametroNumero de la forma Z para estadisticas
hecho_favorito(Hecho,ElementoFinal):-
	((arg(3,Hecho,_),arg(2,Hecho,ParametroHecho),arg(3,Hecho,ParametroNumero));
	(arg(2,Hecho,_),arg(1,Hecho,ParametroHecho),arg(2,Hecho,ParametroNumero))),
	findall(ParametroNumero,Hecho,E),
	maximo(E,M),prim_pos(M,E,PP),
	findall([ParametroNumero,ParametroHecho],Hecho,F),
	posicion_n(F,PP,F2),
	posicion_n(F2,2,ElementoFinal).

%CLASIFICACION DE TIEMPO
horario(Hora,StringHora):-
	((Hora > 6, Hora =< 8, StringHora = 'manana');
	(Hora > 8, Hora =< 10, StringHora = 'media manana');
	(Hora > 10, Hora =< 13, StringHora = 'medio dia');
	(Hora > 13, Hora =< 17, StringHora = 'tarde');
	(Hora > 17, Hora =< 20, StringHora = 'tarde noche');
	(Hora > 20, Hora =< 23, StringHora = 'noche');
	(Hora =< 6, StringHora = 'madrugada')).	
	
reemplazar_posicion_lista_por_valor_de_otra_lista([],_,[]):-!.
reemplazar_posicion_lista_por_valor_de_otra_lista([X|Y],ListaValores,[X2|Y2]):-
	posicion_n(ListaValores,X,X2),
	reemplazar_posicion_lista_por_valor_de_otra_lista(Y,ListaValores,Y2).	

reemplazar_posicion_lista_anidada_por_valor_de_otra_lista([],_,[]):-!.
reemplazar_posicion_lista_anidada_por_valor_de_otra_lista([X|Y],ListaValores,[X2|Y2]):-
	reemplazar_posicion_lista_por_valor_de_otra_lista(X,ListaValores,X2),
	reemplazar_posicion_lista_anidada_por_valor_de_otra_lista(Y,ListaValores,Y2).

suma_elem_de_sublistas_en_listas_anidadas([],[]):-!.
suma_elem_de_sublistas_en_listas_anidadas([X|Y],[X2|Y2]):-
	sum_elements_list(X,0,X2),
	suma_elem_de_sublistas_en_listas_anidadas(Y,Y2).


sugerir_por_tiempo(Hora,TipoASugerir,HechoSugerido) :-	
	% Revisar en que horario se encuentra la hora
	horario(Hora,Horario),
	% Crear una lista con los tipos de eventos de ese horario
	findall(TipoHecho,tiempo(_,TipoHecho,Horario,_),TipoHorario),
	% Crear una lista con los Numeros de veces de ese horario
	findall(Numero,tiempo(_,_,Horario,Numero),NumeroVeces),
	% Elimina los elementos duplicados para que solo me quede una lista con una sola aparicion
	elim_repet(TipoHorario,TipoHorarioOnce),
	% Crea una lista de listas donde en cada posicion de la lista se encuentra la posicion de cada tipo de evento
	posicion_lista_lista(TipoHorarioOnce,TipoHorario,PosicionElementosEventosListaLista),
	% Crea una lista apartir de la lista de posiciones, reemplazando dichas posiciones por sus valores de Numero de veces
	reemplazar_posicion_lista_anidada_por_valor_de_otra_lista(PosicionElementosEventosListaLista,NumeroVeces,AgrupacionNumeroVeces),
	% Toma la lista anterior y suma los elementos de las sublistas
	suma_elem_de_sublistas_en_listas_anidadas(AgrupacionNumeroVeces,SumaAgrupacionesNumeroVeces),
	% Suma los elementos de la lista anterior para obtener el numero de veces total
	sum_elements_list(SumaAgrupacionesNumeroVeces,0,NumeroVecesTotal),
	% Divide entre el numero de veces total para obtener la probabilidad
	div_by_elements_list(SumaAgrupacionesNumeroVeces,NumeroVecesTotal,ListaProb),
	% Insertar el 0 para generar los intervalos
	insertar(ListaProb,1,0,ListaProb2),
	% Generar Intervalos
	generar_intervalos(ListaProb2,Intervalos),
	% Cantidad de elementos para eliminar el ultimo elemento basura
	length(Intervalos,S1),
	% Eliminar el 1 basura al fina 
	sacapos(Intervalos,S1,Intervalos2),
	% Generar Numero Pseudo Aleatorio
	random(0.0,1.0,R),												
	% Revisar de que intervalo (Superitor) es miembro el numero aleatorio generado
	n_is_member(Intervalos2,R,IntervaloMiembro),
	% Calculo de en que posicion se encuentra el intervalo encontrado
	prim_pos(IntervaloMiembro,Intervalos2,PosicionIntervaloEncontrado),
	% Mapeo de la posicion encontrada con la lista de Tipo
	posicion_n(TipoHorarioOnce,PosicionIntervaloEncontrado,TipoASugerir),
	
	((TipoASugerir == 'estudiar',HechoSugerido = estudiar);
	(TipoASugerir == 'rumbiar',HechoSugerido = rumbiar);
	(
	% Crear una lista con los eventos de ese horario y de ese tipo
	findall([NumeroVeces2,Evento],tiempo(Evento,TipoASugerir,Horario,NumeroVeces2),Evento2),
	% Crear una lista con los Numero de repeticiones de ese horario y de ese tipo
	findall(NumeroVeces3,tiempo(_,TipoASugerir,Horario,NumeroVeces3),NumeroVeces4),
	% Ordena de menor a mayor la lista de Prob para generar los intervalos
	msort(Evento2,Evento3),
	% Ordena de menor a mayor la lista de Numeros para el orden
	msort(NumeroVeces4,NumeroVeces5), 	
	% Calculo de la suma de el numero de veces total
	sum_elements_list(NumeroVeces5,0,NumeroVecesTotal2),
	% Divide el # de veces de cada elemento entre la suma total para generar la prob
	div_by_elements_list(NumeroVeces5,NumeroVecesTotal2,ListaProb3),	
	% Insertar el 0 para generar los intervalos
	insertar(ListaProb3,1,0,ListaProb4),
	% Generar Intervalos
	generar_intervalos(ListaProb4,Intervalos3),
	% Cantidad de elementos para eliminar el ultimo elemento basura
	length(Intervalos3,S2),
	% Eliminar el 1 basura al fina 
	sacapos(Intervalos3,S2,Intervalos4),
	% Generar Numero Pseudo Aleatorio
	random(0.0,1.0,R2),												
	% Revisar de que intervalo (Superitor) es miembro el numero aleatorio generado
	n_is_member(Intervalos4,R2,IntervaloMiembro2),
	% Calculo de en que posicion se encuentra el intervalo encontrado
	prim_pos(IntervaloMiembro2,Intervalos4,PosicionIntervaloEncontrado2),
	% Mapeo de la posicion encontrada con la lista de Tipo
	posicion_n(Evento3,PosicionIntervaloEncontrado2,HechoSugerirCompleto),
	% Mapeo de la posicion encontrada con la lista de Tipo
	posicion_n(HechoSugerirCompleto,2,HechoSugerido)
		
	)).
	
que_hay_pa_hoy(Out):-
	% Vemos que dia es (Nombre)
	nombre_del_dia(NombreDia),
	hora(Hora,_,_),
	% Filtramos la busqueda con ese dia y las horas que son mayores a la hora actual
	findall([Verbo,P],(aprender(NombreDia,_,_,_,H,_,_,Verbo,P), H >= Hora),ListFiltrada),
	((ListFiltrada == [], sugerencias_ladillado(Out));
	(
	% Tamano de la lista para sacar un numero aleatorio
	length(ListFiltrada, TamanoLista),TamanoLista2 is TamanoLista +1,
	% random number entre 1 y la cantidad de elem en la lista anterior
	random(1,TamanoLista2, RandomNumber),
	% devulve el elemento segun el numero aleatorio
	posicion_n(ListFiltrada,RandomNumber,Doble),
	anidada_simple(Doble,ListMedioLista),
	list_string(ListMedioLista,O1),concat('aprender,',O1,Out))).
	
/*****************************************************************************/
% Personales
edad(P,D,M,Y) :- 
	persona(P,fecha(D1,M1,Y1), _, _, _), today(D2,M2,Y2), 
	Y3 is (Y2-Y1), M3 is (M2-M1), D3 is (D2-D1),
	((numero_pos_neg_neu(D3,D4),D4 == -1,I is M2-1,cantidad_dias_mes(I,I2),D is D3 + I2,M4 is M3-1);
	(D is D3,M4 is M3)),
	((numero_pos_neg_neu(M4,M5),M5 == -1,M is M4 + 12,Y is Y3-1);(M is M4,Y is Y3)).
nino(P) :- 
	edad(P,_,_,Y), Y<13.
adolescente(P) :- 
	edad(P,_,_,Y), Y>=13,Y<21.
adulto(P) :- 
	edad(P,_,_,Y), Y>=21,Y<51.
viejo(P) :- 
	edad(P,_,_,Y), Y>=51.
imc(P, IMC):- 
	persona(P,_,_,Estatura,Peso),
	IMC is Peso/((Estatura/100)*(Estatura/100)).
condicion_fisica(P,C) :- imc(P, IMC), ((IMC<16,C = 'Delgadez severa');
	(IMC>=16,IMC<17,C = 'Delgadez moderada');
	(IMC>=17,IMC<18.5,C = 'Delgadez no muy pronunciada');
	(IMC>=18.5,IMC<25,C = 'Normal');(IMC>=25,IMC<30,C = 'Preobeso');
	(IMC>=30,IMC<35,C = 'Obeso tipo I');(IMC>=35,IMC<40,C = 'Obeso tipo II');
	(IMC>=40,C = 'Obeso tipo III')).
indice_broca(P,Minima,Maxima) :- persona(P,_,S,E,_),
	((S == 'hombre',Minima is (E-100)-((E-100)*0.1),Maxima is (E-100)+((E-100)*0.1));
	(S == 'mujer',Minima is (E-100)-((E-100)*0.15),Maxima is (E-100)+((E-100)*0.15))).
deporte_practicado(P,D):- 
	practica_deporte(P), deporte(D).
perfil(P,E,A,Pe,Imc,Min,Max,ConF,Out) :- 
	persona(P,_, _, A, Pe), edad(P,_,_,E), imc(P,Imc),indice_broca(P,Min,Max),condicion_fisica(P,ConF),
	concat('Nombre: ',P,O1),concat(O1,', Edad: ',O2),concat(O2,E,O3),concat(O3,', Indice masa corporal: ',O4),concat(O4,Imc,O5),concat(O5,', Condicion fisica: ',O6),concat(O6,ConF,Out).
	
perfil(Out):-
	persona(P,_,_,_,_),perfil(P,_,_,_,_,_,_,_,Out).