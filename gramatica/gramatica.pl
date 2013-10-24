%GRAMATICA
	%LADILLADO
		% SUGERIR
			%que puedo hacer
			orden(ladillado(sugerencia,yo,Verbo,hacer,P,_)) --> adverbio(_,interrogativo),verbo(Verbo,primera_persona),[hacer],predicado(P).
			%estoy [aburrido | ladillado]
			orden(ladillado(sugerencia,yo,Verbo,Edo,P,_)) --> verbo(Verbo,primera_persona),edo(Edo,ladillado),predicado(P).
			%no tengo nada que hacer
			orden(ladillado(sugerencia,yo,Verbo,Edo,P,_)) --> adverbio(_,negacion),verbo(Verbo,primera_persona),adverbio(_,cantidad),pronombres_relativos,verbo(Edo,normales),predicado(P).
	%HAMBRE
		% SUGERIR
			%donde puedo comer
			orden(hambre(sugerencia,yo,Verbo,Edo,P,_)) --> adverbio(Verbo,interrogativo),verbo(_,primera_persona),verbo(Edo,hambre),predicado(P).
			%donde puedo ir a comer
			orden(hambre(sugerencia,yo,Verbo,Edo,P,_)) --> adverbio(Verbo,interrogativo),verbo(_,primera_persona),verbo(_,normales),preposiciones,verbo(Edo,hambre),predicado(P).
			%tengo hambre, %tengo mucha hambre
			orden(hambre(sugerencia,yo,Verbo,Edo,P,_)) --> verbo(Verbo,primera_persona),((adverbio(_,cantidad),edo(Edo,hambre));(edo(Edo,hambre))),predicado(P).
			%tengo ganas de [desayunar,almorzar,merendar]
			orden(hambre(sugerencia,yo,[Verbo,Verbo2],Edo,P,_)) --> verbo(Verbo,primera_persona),sustantivo(Verbo2,femenino),preposiciones,verbo(Edo,hambre),predicado(P).
			%quiero comer en P->Restaurant
			orden(hambre(sugerencia_lugar,yo,Verbo,Edo,P,_)) --> verbo(Verbo,primera_persona),verbo(Edo,hambre),preposiciones,predicado(P).
			%quiero comer [hambre]
			orden(hambre(sugerencia,yo,Verbo,Edo,P,_)) --> verbo(Verbo,primera_persona),verbo(Edo,hambre),predicado(P).
		% CONSULTAR	
			%que comida me gusta mas
			orden(hambre(consultar,yo,[Verbo,Verbo2],Edo,_,_)) --> adverbio(_,interrogativo),edo(Edo,hambre),pronombres_personales(Verbo,atonos),verbo(Verbo2,me),adverbio(_,cantidad).
			%cual es mi comida favorita
			orden(hambre(consultar,yo,Verbo,Edo,P,_)) --> adverbio(_,interrogativo),verbo(Verbo,tercera_persona),pronombres_personales(_,tonicos),edo(Edo,hambre),edo(P,todos).
			%comida favorita
			orden(hambre(consultar,yo,es,Edo,P,_)) --> edo(Edo,hambre),edo(P,todos).
	%ENFERMO
		% SUGERIR
			%que puedo tomar para el dolor
			orden(enfermo(sugerencia,yo,[Verbo,tomar],Edo,P,_)) --> adverbio(_,interrogativo),verbo(Verbo,primera_persona),[tomar],preposiciones,articulos_determinados,edo(Edo,medico),predicado(P).
			%tengo dolor de 
			orden(enfermo(sugerencia,yo,Verbo,Edo,P,_)) --> verbo(Verbo,primera_persona),edo(Edo,medico),((preposiciones,predicado(P));predicado(P)).
			%me duele [la | el] ..
			orden(enfermo(sugerencia,yo,Verbo,Edo,P,_)) --> pronombres_personales(Verbo,atonos),verbo(Edo,me),(articulos_determinados;articulos_indeterminados),predicado(P).
			%me siento mal
			orden(enfermo(sugerencia,yo,[Verbo,Verbo2],Edo,P,_)) --> pronombres_personales(Verbo,atonos),verbo(Verbo2,me),edo(Edo,medico),predicado(P).	
	%ESTUDIANDO
		% PREGUNTAR
			%quiero saber el significado de
			orden(estudiando(pregunta,yo,[Verbo,Verbo2],Edo,P,_)) --> verbo(Verbo,primera_persona), verbo(Verbo2,normales), articulos_determinados, edo(Edo,estudiando), preposiciones, predicado(P).
			%significado de 
			orden(estudiando(pregunta,yo,saber,Edo,P,_)) --> (edo(Edo,estudiando), preposiciones, predicado(P));(edo(Edo,estudiando), predicado(P)).
			%cual es el [significado|valor] de 
			orden(estudiando(pregunta,yo,Verbo,Edo,P,_)) --> adverbio(_,interrogativo), verbo(Verbo,tercera_persona), articulos_determinados,edo(Edo,estudiando),(preposiciones;(preposiciones,articulos_determinados);contracciones), predicado(P).
		% SUGERIR
			%quiero leer 
			%orden(estudiando(sugerencia,yo,Verbo,Edo,P,_)) --> verbo(Verbo,primera_persona),verbo(Edo,estudiar), predicado(P).
			%voy a leer
	%RUMBA 
		% PREGUNTAR
			%donde puedo tomar [rumba]
			%orden(rumba(pregunta,yo,[Verbo,Verbo2],Edo,P,_)) --> adverbio(_,interrogativo),verbo(Verbo,primera_persona),verbo(Verbo2,rumba),edo(Edo,rumba),predicado(P).
			%puedo tomar [rumba], quiero tomar [rumba]
			%orden(rumba(pregunta,yo,[Verbo,Verbo2],Edo,P,_)) --> (verbo(Verbo,primera_persona);verbo(Verbo,primera_persona)),verbo(Verbo2,rumba),edo(Edo,rumba),predicado(P).
		% SUGERIR
			%tengo ganas de [rumbiar|bailar|salir]
			orden(rumba(sugerencia,yo,[Verbo,Verbo2],Edo,P,_)) --> verbo(Verbo,primera_persona),sustantivo(Verbo2,femenino),preposiciones,verbo(Edo,rumba),predicado(P).
			%quiero ir a [rumbiar|bailar|salir]
			orden(rumba(sugerencia,yo,[Verbo,Verbo2],Edo,P,_)) --> verbo(Verbo,primera_persona), verbo(Verbo2,normales),preposiciones,verbo(Edo,rumba),predicado(P).
			%quiero [rumbiar|bailar|salir]
			orden(rumba(sugerencia,yo,Verbo,Edo,P,_)) --> verbo(Verbo,primera_persona), verbo(Edo,rumba),predicado(P).
	%DEPORTISTA
		% SUGERIR
			%quiero hacer [deporte | ejercicio], 
			orden(deportista(sugerencia,yo,[Verbo,Verbo2],Edo,P,_)) --> verbo(Verbo,primera_persona), verbo(Verbo2,normales),edo(Edo,deporte),predicado(P).
			%quiero hacer algun [deporte | ejercicio], 
			orden(deportista(sugerencia,yo,[Verbo,Verbo2],Edo,P,_)) --> verbo(Verbo,primera_persona), verbo(Verbo2,normales),[algun],edo(Edo,deporte),predicado(P).
			%quiero jugar Predicado
			orden(deportista(sugerencia,yo,[Verbo,Verbo2],_,P,_)) --> verbo(Verbo,primera_persona), verbo(Verbo2,deporte),predicado(P).
			%estoy muy [flaco | flaca], %estoy  [flaco | flaca]		
			orden(deportista(sugerencia,yo,Verbo,Edo,P,_)) --> verbo(Verbo,primera_persona), ((adverbio(_,cantidad),edo(Edo,deporte));(edo(Edo,deporte))),predicado(P).
			%me siento [flaco | flaca | gordo]
			orden(deportista(sugerencia,yo,[Verbo,Verbo2],Edo,P,_)) --> pronombres_personales(Verbo,atonos),verbo(Verbo2,me),((adverbio(_,cantidad),edo(Edo,deporte));edo(Edo,deporte)),predicado(P).
	%DESVARIADO
		%que hora es
			orden(tiempo(pregunta,yo,Verbo,Edo,_,_)) --> adverbio(_,interrogativo),edo(Edo,todos),verbo(Verbo,tercera_persona).
		%que horas son
			orden(tiempo(pregunta,yo,Verbo,Edo,_,_)) --> adverbio(_,interrogativo),edo(Edo,todos),verbo(Verbo,tercera_persona).
		%probabilidad
			%cual es la probabilidad de [comida | hambre]
			orden(probabilidad(pregunta,yo,Verbo,Edo,comida,_)) --> adverbio(_,interrogativo),verbo(Verbo,tercera_persona),articulos_determinados,edo(Edo,probabilidad),preposiciones,([comida];[hambre]).
			%cual es la probabilidad de deporte
			orden(probabilidad(pregunta,yo,Verbo,Edo,deporte,_)) --> adverbio(_,interrogativo),verbo(Verbo,tercera_persona),articulos_determinados,edo(Edo,probabilidad),preposiciones,[deporte].
			%cual es la probabilidad de tiempo
			orden(probabilidad(pregunta,yo,Verbo,Edo,tiempo,_)) --> adverbio(_,interrogativo),verbo(Verbo,tercera_persona),articulos_determinados,edo(Edo,probabilidad),preposiciones,[tiempo].
	
	%APRENDER NUEVO
		%quiero ir a ... %quiero hacer..
		orden(aprender(Verbo,P)) --> verbo(_,primera_persona), verbo(Verbo,normales),((preposiciones,predicado(P));predicado(P)).
		%voy a ir a %voy a ir al 
		orden(aprender(Verbo,P)) --> verbo(_,primera_persona), preposiciones, verbo(Verbo,normales), (preposiciones;contracciones), predicado(P).
		 
	% PLANIFICADOR
		% quiero hacer una fiesta
		orden(planificador(fiesta,yo,[Verbo,Verbo2],Edo,P,_)) --> verbo(Verbo,primera_persona), verbo(Verbo2,normales), articulos_indeterminados, edo(Edo,rumba),predicado(P).
		% voy a hacer una fiesta
		orden(planificador(fiesta,yo,Verbo,Edo,P,_)) --> verbo(_,primera_persona), preposiciones, verbo(Verbo,normales), articulos_indeterminados, edo(Edo,rumba),predicado(P).
		% voy a planificar una fiesta
		orden(planificador(fiesta,yo,Verbo,Edo,P,_)) --> verbo(_,primera_persona), preposiciones, verbo(Verbo,normales), articulos_indeterminados, edo(Edo,rumba),predicado(P).
		% quiero estudiar
		orden(planificador(estudiar,yo,Verbo,Edo,P,_)) --> verbo(Verbo,primera_persona), edo(Edo,estudiando), predicado(P).
		
	%SALUDO
		% hola 
		orden(saludo(_,_,_,_,_,_)) --> saldudo.

%TERMINALES
	verbo(Verbo,primera_persona) -->[Verbo], {member(Verbo,[quiero,quisiera,necesito,voy,tengo,hago,muestro,veo,edito,cambio,modifico,siento,como,desayuno,almuerzo,ceno,meriendo,puedo,tomo,estoy])}.
	verbo(Verbo,me) -->[Verbo], {member(Verbo,[duele,gusta,rio,quiere,siento])}.
	verbo(Verbo,tercera_persona) -->[Verbo], {member(Verbo,[es,son])}.
	verbo(Verbo,hambre) -->[Verbo], {member(Verbo,[comer,desayunar,almorzar,cenar,merendar,comerme])}.
	verbo(Verbo,estudiar) -->[Verbo], {member(Verbo,[leer])}.
	verbo(Verbo,rumba) --> [Verbo], {member(Verbo,[tomar,beber,rumbiar,bailar,rumbear,salir])}.
	verbo(Verbo,deporte) -->[Verbo], {member(Verbo,[jugar,practicar])}.
	verbo(Verbo,normales) -->[Verbo], {member(Verbo,[querer,necesitar,ir,tener,hacer,mostrar,ver,editar,cambiar,modificar,sentir,poder,saber,tomar,jugar,planificar])}.
	edo(Edo,ladillado) -->[Edo], {member(Edo,[ladillado,aburrido,ladilado])}.
	edo(Edo,medico) -->[Edo], {member(Edo,[medico,medicina,doctor,paciente,operacion,sintoma,duele,dolor,mal])}.
	edo(Edo,hambre) -->[Edo], {member(Edo,[comida,restaurant,restaurante,rapida,gourmet,light,hambre,hambriento])}.
	edo(Edo,estudiando) -->[Edo], {member(Edo,[significado,valor])}.
	edo(Edo,estudiando) -->[Edo], {member(Edo,[estudiar])}.
	edo(Edo,rumba) -->[Edo], {member(Edo,[vino,cerveza,licor,miche,whisky,brandy,ginebra,ron,birra,frias,fria,rascar,rascarme,rumba,fiesta])}.
	edo(Edo,deporte) -->[Edo], {member(Edo,[deporte,ejercicio,flaco,flaca,gordo,gorda])}.
	edo(Edo,probabilidad) -->[Edo], {member(Edo,[probabilidad])}.
	edo(Edo,todos) -->[Edo], {member(Edo,[favorita,hora,horas])}.
	
	
	pronombres_personales(Pro,tonicos) -->[Pro], {member(Pro,[yo,tu,el,mi,ti,si])}.
	pronombres_personales(Pro,atonos) -->[Pro], {member(Pro,[me,te,se,le,lo,la,nos,os])}.
	pronombres_personales(Pro,posesivos) -->[Pro], {member(Pro,[mi,tuyo,tuya,suyo,suya,vuestro,nuestro])}.
	adverbio(Adv,lugar) -->[Adv], {member(Adv,[aqui,ahi,alli,alla,cerca,lejos,fuera,dentro,arriba,abajo,encima,detras])}.
	adverbio(Adv,modo) -->[Adv], {member(Adv,[bien,mal,asi,despacio,claramente,lentamente,regular])}.
	adverbio(Adv,duda)-->[Adv],{member(Adv,[acaso,quiza,quizas,probablemente])}.		
	adverbio(Adv,afirmacion)-->[Adv],{member(Adv,[si,tambien,ciertamente,efectivamente])}.		
	adverbio(Adv,negacion)-->[Adv],{member(Adv,[no,tampoco,nunca,jamas])}.		
	adverbio(Adv,tiempo) -->[Adv],{member(Adv,[hoy,ayer,manana,anoche,ahora,luego,antes,enseguida,despues,tarde,pronto,ya])}.
	adverbio(Adv,cantidad)-->[Adv],{member(Adv,[mucho,mucha,poco,muy,casi,bastante,tan,tanto,nada,mas,menos,suficiente,demasiado,demasiada])}.	
	adverbio(Adv,interrogativo)-->[Adv],{member(Adv,[como,cuando,donde,por,que,cuales,cual,cuantos,cuanto])}.	
	sustantivo(Sus,femenino) -->[Sus], {member(Sus,[ganas])}.
	preposiciones --> [a];[ante];[con];[para];[por];[segun];[sin];[de];[desde];[hacia];[en].
	conjunciones --> [y];[ni];[o];[u];[e].
	pronombres_relativos --> [quien];[que];[cual].
	articulos_determinados --> [el];[la];[los];[las].
	articulos_indeterminados --> [un];[una];[unos];[unas].
	contracciones --> [del];[al].
	predicado(Salida,Salida,[]).
	
	saldudo --> [hola];['HOLA'];['Hola'].
	
%PROCESAR LO ESCRITO
	procesar_predicado(P,P2):-
			elim_l1_de_l2([yo,tu,el,mi,ti,si,me,te,se,le,lo,la,nos,os,mi,tuyo,tuya,suyo,suya,vuestro,nuestro,aqui,ahi,alli,alla,cerca,lejos,fuera,dentro,arriba,abajo,encima,detras,bien,mal,asi,despacio,claramente,lentamente,regular,acaso,quiza,quizas,probablemente,si,tambien,ciertamente,efectivamente,no,tampoco,nunca,jamas,hoy,ayer,manana,anoche,ahora,luego,antes,enseguida,despues,tarde,pronto,ya,mucho,mucha,poco,muy,casi,bastante,tan,tanto,nada,mas,menos,suficiente,demasiado,demasiada	,como,cuando,donde,por,que,cuales,cual,cuantos,cuanto,ganas,a,ante,con,para,por,segun,sin,de,desde,hacia,y,ni,o,u,e,quien,que,cual,el,la,los,las,un,una,unos,unas,del,al],P,P2).
	
	procesar_respuesta_si_no(P,R):-
		Si = ['SI','Si','sI','si','S','s','YES','Yes','yEs','yeS','yes','Y','y'], No = ['NO','No','nO','no','N','n'],
		length(P,N),
		((N \= 1,R is 0);(P == [],R is 0);
		(N == 1,elim_l1_de_l2(Si,P,P2), P2 == [], R is 1);
		(N == 1,elim_l1_de_l2(No,P,P2), P2 == [], R is -1);
		(R is 0)).
	