move(1,6).
move(1,8).
move(2,7).
move(2,9).
move(3,4).
move(3,8).
move(4,3).
move(4,9).
move(6,1).
move(6,7).
move(7,2).
move(7,6).
move(8,1).
move(8,3).
move(9,2).
move(9,4).

%OG knight algorithm
path(Z, Z, L) :- writelist(L).
path(X, Y, L) :- move(X,Z), not(member(Z,L)), path(Z, Y, [Z|L]).

member(X, [X | _]). 
member(X, [_ | T]) :- member(X, T).

writelist([]). 
writelist([H | T]) :- writelist(T), write(H), nl.

%Nothing borken, its quicker but no fail, so inf loop
pathB(Z, Z).
pathB(X, Y) :- pathB(X, W), move(W, Y).

%prunning, no hay nada que evite que Y=X, so it will technicaly be falce on the algorithm, but not really
pathC(Z, Z).
pathC(X, Y) :- move(X, Z), move(Z, W), move(W, Y). 