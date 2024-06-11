% Place Your solution here

unique([]):-!.
unique([Head|Tail]):-
   member(Head, Tail), !, fail;
   unique(Tail).



man('Алексеев').
man('Борисов').
man('Константинов').
man('Дмитриев').
book('астрономия').
book('поэзия').
book('проза').
book('пьеса').


check([]):-!.
check([passenger(_, XWrite, XBuy, XRead)|T]):- !, not(XRead = XWrite), not(XBuy = XWrite), check(T).

solve(Solve):-
	Solve = [passenger(X, XWrite, XBuy, XRead), passenger(Y, YWrite, YBuy, YRead), passenger(Z, ZWrite, ZBuy, ZRead), passenger(W, WWrite, WBuy, WRead)],
	% 4 разных пасажира
	man(X),
	man(Y),
	man(Z),
	man(W),
	unique([X, Y, Z, W]),
	% каждый написал книгу
	book(XWrite),
	book(YWrite),
	book(ZWrite),
	book(WWrite),
	unique([XWrite, YWrite, ZWrite, WWrite]),
	% каждый купил книгу
	book(XBuy),
	book(YBuy),
	book(ZBuy),
	book(WBuy),
	unique([XBuy, YBuy, ZBuy, WBuy]),
	% каждый читает книгу
	book(XRead),
	book(YRead),
	book(ZRead),
	book(WRead),
	unique([XRead, YRead, ZRead, WRead]),

	% поэт читает пьесу
	member(passenger(_, 'поэзия', _, 'пьеса'), Solve),
	% прозаик читает не астрономию
	not(member(passenger(_, 'проза', _, 'астрономия'), Solve)),
	% прозаик не покупал астрономию
	not(member(passenger(_, 'проза', 'астрономия', _), Solve)),
	% никто не читает и не покупал свою книгу
	check(Solve),
	% алексеев и борисов обменялись книгами
	member(passenger('Алексеев', _, ABuy, ARead), Solve),
	member(passenger('Борисов', _, ARead, ABuy), Solve),
	% Борисов купил произведение Дмитриева
	member(passenger('Дмитриев', DWrite, _, _), Solve),
	member(passenger('Борисов', _, DWrite, _), Solve).

	build_solve(Solve):- solve(Solve), Solve = [passenger('Алексеев', _, _, _), passenger('Борисов', _, _, _), passenger('Константинов', _, _, _), passenger('Дмитриев', _, _, _)].
	