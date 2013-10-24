sugerencias_ladillado(Out):-
	hora(H,_,_),
	sugerir_por_tiempo(H,TipoSugerencia,Sugerencia),
	concat(ladillado,',',O1),concat(O1,TipoSugerencia,O2),concat(O2,',',O3),concat(O3,Sugerencia,Out).
	