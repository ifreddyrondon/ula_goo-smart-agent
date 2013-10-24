:- dynamic prob/3.
% Calculo Prob
calculo_prob(Hecho) :- 
	((arg(3,Hecho,_),arg(2,Hecho,ParametroHecho),arg(3,Hecho,ParametroNumero));
	(arg(2,Hecho,_),arg(1,Hecho,ParametroHecho),arg(2,Hecho,ParametroNumero))),
	findall(ParametroHecho,Hecho,ListaNombre),
 	findall(ParametroNumero,Hecho,L),
	sum_elements_list(L,0,S),
	div_by_elements_list(L,S,ListaProb),
	functor(Hecho, Prob_Name, _),
	retractall(prob(Prob_Name,_,_)),
	p(ListaNombre,ListaProb,Prob_Name).
% para el tiempo	
calculo_prob_tiempo(Hecho):-
	arg(4,Hecho,ParametroNumero),arg(1,Hecho,ParametroHecho),	
	findall(ParametroHecho,Hecho,ListaNombre),
 	findall(ParametroNumero,Hecho,L),
	sum_elements_list(L,0,S),
	div_by_elements_list(L,S,ListaProb),
	functor(Hecho, Prob_Name, _),
	retractall(prob(Prob_Name,_,_)),
	p(ListaNombre,ListaProb,Prob_Name).
				
p([],[],_):-	!.
p([X|Y],[X2|Y2],Prob_Name):-
	assert(prob(Prob_Name,X,X2)),
	p(Y,Y2,Prob_Name).

% El hecho introducido tiene que ser de la forma prob(comida,mexicana,_)
getp(Hecho,Probabilidad):-
	arg(1,Hecho,Tipo),arg(2,Hecho,Dato),prob(Tipo,Dato,Probabilidad).
	
% ejm: getp(prob(comida,mexicana,_),and,prob(busquedas,pi,_),P)
getp(Hecho,and,Hecho2,Probabilidad):-
	arg(1,Hecho,Tipo),arg(2,Hecho,Dato),prob(Tipo,Dato,P),
	arg(1,Hecho2,Tipo2),arg(2,Hecho2,Dato2),prob(Tipo2,Dato2,P2),
	Probabilidad is P*P2.
	
getp(Hecho,or,Hecho2,Probabilidad):-
	arg(1,Hecho,Tipo),arg(2,Hecho,Dato),prob(Tipo,Dato,P),
	arg(1,Hecho2,Tipo2),arg(2,Hecho2,Dato2),prob(Tipo2,Dato2,P2),
	Probabilidad is P+P2.
	
getp(Hecho,dado,Hecho2,Probabilidad):-
	arg(1,Hecho,Tipo),arg(2,Hecho,Dato),prob(Tipo,Dato,P),
	arg(1,Hecho2,Tipo2),arg(2,Hecho2,Dato2),prob(Tipo2,Dato2,P2),
	Divisor is P*P2,
	Probabilidad is Divisor/P2.