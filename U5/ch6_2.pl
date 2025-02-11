%Test graph
edge(a, b).
edge(a, c).
edge(a, d).
edge(b, e).
edge(b, f).
edge(c, f).
edge(c, g).
edge(e, h).
edge(e, i).
edge(f, j).


findPath(Start_node, Goal_node) :- 
    path([[Start_node]], Goal_node).

path([[Goal_node|L]|_], Goal_node):- reverse([Goal_node| L], R), write('Path: '), write(R), nl.

path([[Current_node|L]| Q], Goal_node) :- findall(([N, Current_node|L]), (edge(Current_node, N), \+ member(N, [Current_node|L])), Children), append(Q, Children, N_q), path(N_q, Goal_node).