likes(lucy, wine).
likes(lucy, linmanuel).
likes(lucy, f1).
likes(lucy, coding).

writelist([]).
writelist([H | T]):- write(H), nl, writelist(T).

rev_writelist([]).
rev_writelist([H | T]):- rev_writelist(T), write(H), nl.

%This_is_a_comment_that_I_will_keep_stretching