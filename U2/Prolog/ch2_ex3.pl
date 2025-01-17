% Base case: when the input list is empty, the result is the set.
unique([], Set) :- writelist(Set).

% Recursive case: if the head of the list is already in the set, continue with the tail.
unique([H|T], Set) :- member(H, Set), unique(T, Set).

% Recursive case: if the head of the list is not in the set, add it to the set and continue with the tail.
unique([H|T], Set) :- \+ member(H, Set), unique(T, [H|Set]).

% Check if an element is a member of a list.
member(X, [X|_]).
member(X, [_|T]) :- member(X, T).

% Write each element of the list followed by a newline.
writelist([]).
writelist([H|T]) :- write(H), nl, writelist(T).
