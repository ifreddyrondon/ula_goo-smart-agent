% NUMEROS

% Recibe Num1 y Num2 y determina cual es el mayor
mayor(Num1,Num2,Sol):- 
	((Num1 > Num2), Sol is Num1);((Num2 > Num1), Sol is Num2).

% Recibe X y retorna 1 si es positivo, -1 si es negativo y 0 si es 0 (neutro)
numero_pos_neg_neu(X,Y) :- 
		(X>0,Y is 1);(X<0,Y is -1);(X=0,Y is 0).
	
	
% FECHAS

% Recibe un mes en formato numero y me devuelve la cantidad de dias que tiene ese mes
cantidad_dias_mes(M,C):- 
	(M==1,C is 31);(M==2,C is 28);(M==3,C is 31);(M==4,C is 30);(M==5,C is 31);(M==6,C is 30);
	(M==7,C is 31);(M==8,C is 31);(M==9,C is 30);(M==10,C is 31);(M==11,C is 30);(M==12,C is 31).
% Devuelve Dias, Mes, Ano
today(D,M,Y) :- 
	get_time(T), stamp_date_time(T, date(Y, M, D, _, _, _, _, _, _), 'local').
% Devuelve Dias, Mes, Ano en formato String	
today_string(Hoy) :- 
	get_time(X), format_time(atom(Hoy), '%d/%m/%Y', X).
% Devuelve Hora, Minuto y Segundo
hora(H,M,S) :-	
	get_time(T), stamp_date_time(T, date(_, _, _, H, M, S, _, _, _), 'local').
	
%Calcula nombre del dia
nombre_del_dia(DiaNombre):-
	today(D,M,Y),day(M,D,Y,DiaNumero),dayname(DiaNumero,DiaNombre).
day(_month,_day,_year,D):- 
  A is (14-_month)//12, 
  Y is _year-A, 
  M is round(_month+(12*A)-2), 
  D is (_day+Y+(Y//4)-(Y//100)+(Y//400)+(round(31*M)//12)) mod 7. 
dayname(_daynum,_dayname):- 
  %nth1(?Index, ?List, ?Elem) 
  _daywords = ['domingo','lunes','martes','miercoles','jueves','viernes','sabado'], 
  _daynums = [0,1,2,3,4,5,6], 
  nth1(_numindex,_daynums,_daynum), 
  nth1(_numindex,_daywords,_dayname).