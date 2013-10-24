 /*****************************************************************************/
%Construir Hecho (Functor) apartir de String
read_from_string(String, Term) :-
    string_to_list(String, List),
    read_from_chars(List, Term).
    
% Elimina el elemento que se encuentra en la Nsima posicion
sacapos([_|Y],1,Y).
sacapos([X|Y],N,[X|R]):- N1 is N-1, sacapos(Y,N1,R).

% Elimina Hechos cargados en memoria al compilar para no tener basura
elimina_hechos_memoria_compilar:-
	directory_files('hechos/', Entries),sacapos(Entries,1,Entries2),sacapos(Entries2,1,Entries3),elimina_hechos_memoria_compilar(Entries3).
elimina_hechos_memoria_compilar([]):-!.
elimina_hechos_memoria_compilar([X|Y]):-
	sub_string(X, P, _, _, '_'),sub_string(X,0, P,_, H),concat(H,'(_,_)',H2),concat(H,'(_,_,_)',H3),concat(H,'(_,_,_,_)',H4),read_from_string(H2,H22),read_from_string(H3,H33),read_from_string(H4,H44),retractall(H22),retractall(H33),retractall(H44),elimina_hechos_memoria_compilar(Y).
	
% Carga todas los archivos necesarios
cargar_archivos_necesarios :-
	FileList = ['gramatica/','dependencias/','hechos/','utilidades/'],cargar_archivo(FileList).
cargar_archivo([]):-!.
cargar_archivo([X|Y]):-
	cd(X),directory_files('.', Entries),sacapos(Entries,1,Entries2),sacapos(Entries2,1,Entries3),consult(Entries3),cd(..),cargar_archivo(Y).

% LLamada para hacer pasos anteriores
:-  elimina_hechos_memoria_compilar, cargar_archivos_necesarios.
/*****************************************************************************/
% FUNCIONES DE PATRONES
%ladillado
	ladillado(Accion,Suj,Verbo,Edo,P,Out):-
		guardar_edo_actual(ladillado,Accion,Suj,Verbo,Edo,P),
		Accion == sugerencia, sugerencias_ladillado(Out).
%hambre
	hambre(Accion,Suj,Verbo,Edo,P,Out):-
		guardar_edo_actual(hambre,Accion,Suj,Verbo,Edo,P),
		aprender(hambre,P),
		(Accion == sugerencia, sugerencias_hambre(P,Comida,Lugar);
		Accion == sugerencia_lugar, sugerencia_lugar(P,Comida,Lugar);
		Accion == consultar, consultar_hambre(Comida,Lugar)),
		concat('comida',',',O1),concat(O1,Comida,O2),concat(O2,',',O3),concat(O3,Lugar,Out).	
%enfermo
	enfermo(Accion,Suj,Verbo,Edo,P,Out):-
		guardar_edo_actual(enfermo,Accion,Suj,Verbo,Edo,P),
		Accion == sugerencia, sugerencias_enfermo(Suj,Verbo,Edo,P,Out).
%estudiando
	estudiando(Accion,Suj,Verbo,Edo,P,Out):-
		guardar_edo_actual(estudiando,Accion,Suj,Verbo,Edo,P),
		Accion == pregunta, pregunta_estudiando(Suj,Verbo,Edo,P,Out);
		Accion == sugerencia, sugerencias_estudiando(Suj,Verbo,Edo,P,Out);
		Accion == aprender, aprender_estudiando(Suj,Verbo,Edo,P,Out).
%rumba
	rumba(Accion,Suj,Verbo,Edo,P,Out):-
		guardar_edo_actual(rumba,Accion,Suj,Verbo,Edo,P),
		aprender(rumbiar,P),
		Accion == pregunta, pregunta_rumba(Suj,Verbo,Edo,P,Out);
		Accion == sugerencia, sugerencias_rumba(P,Out);
		Accion == planificador, planificador_rumba(Out).
%deporte
	deportista(Accion,Suj,Verbo,Edo,P,Out):-
		guardar_edo_actual(deportista,Accion,Suj,Verbo,Edo,P),
		aprender(deporte,P),
		Accion == sugerencia, sugerencias_deporte(Suj,Verbo,Edo,P,Out).
		
%planificador
	planificador(Accion,Suj,Verbo,Edo,P,Out):-
		guardar_edo_actual(planificador,Accion,Suj,Verbo,Edo,P),
		planificador(Edo,Out).

%saludo
	saludo(_,_,_,_,_,Out):-
		Out = 'Hola mundo'.
		

%DESVARIADO
		tiempo(Accion,Suj,Verbo,Edo,P,Out):-
			guardar_edo_actual(tiempo,Accion,Suj,Verbo,Edo,P),
			hora(H,M,S),
			concat('desvariado,','Son las  ',O1),concat(O1,H,O2),concat(O2,':',O3),concat(O3,M,O4),concat(O4,':',O5),concat(O5,S,Out).
		probabilidad(Accion,_,_,_,P,Out):-
			Accion == pregunta, pregunta_probabilidad(P,Out).

%APRENDER
	aprender(Verbo,P):-
		hora(H,M,S),
		today(D,Mes,A),
		nombre_del_dia(NombreDia),
		%procesar_predicado(P,P2),
		assert(aprender(NombreDia,D,Mes,A,H,M,S,Verbo,P)),
		tell('hechos/aprender_hechos.pl'),listing(aprender(_,_,_,_,_,_,_,_,_)),told.
			
/*****************************************************************************/
% FUNCIONES DE EDO
:- dynamic edo_actual/4.
	% Guarda el ultimo estado de la persona
	% Parametros: Edo, Hora, Minuto, Segundo
	guardar_edo_actual(Edo,Accion,Suj,Verbo,EdoGramatica,P):-
		retractall(edo_actual(_,_,_,_)),hora(H,M,S),assert(edo_actual(Edo,H,M,S)),
		agregar_log(H,M,S,Edo,Accion,Suj,Verbo,EdoGramatica,P).
	
	agregar_log(H,M,S,Edo,Accion,Suj,Verbo,EdoGramatica,P):-
		today(D,Mes,A),
		nombre_del_dia(NombreDia),
		assert(log(NombreDia,D,Mes,A,H,M,S,Edo,Accion,Suj,Verbo,EdoGramatica,P)),tell('hechos/log_hechos.pl'),listing(log(_,_,_,_,_,_,_,_,_,_,_,_,_)),told.
		
/*****************************************************************************/
/*PRINCIPAL*/

	goo([]):- write('Debe ingresar una sentencia').
	
	goo(String,Out):- 
		clean_string(String,Cleanstring),
        	extract_atomics(Cleanstring,ListOfAtomics),
        	orden(Orden,ListOfAtomics,[]),Orden,arg(6,Orden,Out).
	goo :-
  		write('Base de Conocimiento GOO'),nl,write('> '),
		read_atomics(Input),
		orden(Orden,Input,[]),Orden,arg(6,Orden,Out),
		nl,write(Out).		
