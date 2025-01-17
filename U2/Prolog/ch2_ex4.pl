count1(C, []):- write(C).
count1(C, [H|T]):- NewC is C + 1, count1(NewC, T).

% Base case: when the list is empty, write the value of C.
count2(C, []) :- write(C).

% Recursive case: if the head is a list, increment the counter and process the list.
count2(C, [H|T]) :- is_list(H), NewC is C + 1, count2(NewC, H), count2(NewC, T).

% Recursive case: if the head is not a list, increment the counter and continue with the tail.
count2(C, [H|T]) :- \+ is_list(H), NewC is C + 1, count2(NewC, T).

%ie, u need case for is and isnt, cause what we have is
%is given (C, X) format then do :-