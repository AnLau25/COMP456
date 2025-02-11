countAtoms(L) :- count(L, C), write('No. of atoms: '), write(C).

count([], 0).
count([H|T], C) :- atom(H), count(T, C1), C is C1 + 1.
count([H|T], C) :- is_list(H), count(H, C1), count(T, C2), C is C1 + C2.
