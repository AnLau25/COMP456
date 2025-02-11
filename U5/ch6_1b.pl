countItems(L):-count(L, 0).
count([], C):- write('No. of items: '), write(C).
count([_|L], C):- Ncount is C+1, count(L, Ncount).