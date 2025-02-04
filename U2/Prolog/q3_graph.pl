edge(a, b, 3).
edge(b, c, 1).
edge(b, d, 5).
edge(c, d, 2).
edge(d, b, 2).

findPath(X, Y): path(X, Y, []).
path(X, Y, L):-

//Horsy algorithm but u know graph