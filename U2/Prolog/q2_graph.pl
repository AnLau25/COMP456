%Test graph
edge(a, b).
edge(a, c).
edge(b, c).
edge(b, d).
edge(b, e).
edge(c, d).
edge(d, f).
edge(e, h).
edge(e, g).
edge(f, h).
edge(f, g).

bi_direction(X, Y):- edge(X, Y).
bi_direction(Y, X):- edge(X, Y).

findPath(Start_node, Goal_node) :- 
    path(Start_node, Goal_node, [Start_node]).

path(Current_node, Goal_node, L):- bi_direction(Current_node, Goal_node),
                                 reverse([Goal_node| L], R), write('Path: '), write(R), nl.

path(Current_node, Goal_node, L) :- bi_direction(Current_node, Z), Z \= Goal_node, \+ member(Z, L), path(Z, Goal_node, [Z | L]).



