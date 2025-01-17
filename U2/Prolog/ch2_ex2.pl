member(X, [X | T]) :- write(X), nl, writelist(T). 
member(X, [Y | T]) :- write(Y), nl, member(X, T). 

writelist([]). 
writelist([H | T]) :- write(H), nl, writelist(T).

/*
['filename'].
for re-load
*/