edge(a, b, 3).
edge(b, c, 1).
edge(b, d, 5).
edge(c, d, 2).
edge(d, b, 2).

findPath(Start_node, Goal_node) :- 
    path([(0, Start_node, [Start_node])], Goal_node, Distance, L), 
    write('Distance: '), write(Distance), nl, reverse(L, R),
    write('Path: '), write(R), nl.

path([(Distance, Goal_node, L)| _], Goal_node, Distance, L).
path([(S, Current_node, P)| R], Goal_node, Distance_total, L) :- findall((Z, N, [N|P]), (edge(Current_node, N, W), \+ member(N, P), Z is S + W), Children), 
                                                                 append(R, Children, Q), sort(Q, Sorted_Q), path(Sorted_Q, Goal_node, Distance_total, L).

member(X, [X | _]).
member(X, [_ | T]) :- member(X, T).
