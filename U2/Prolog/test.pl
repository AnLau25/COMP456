likes(lucy, wine).
likes(lucy, linmanuel).
likes(lucy, f1).
likes(lucy, coding).

writelist([]).
writelist([H | T]):- write(H), nl, writelist(T).

rev_writelist([]).
rev_writelist([H | T]):- rev_writelist(T), write(H), nl.

