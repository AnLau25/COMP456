mult(C, [H], Res):- Res is C*H.
mult(C, [H|T], Res):- N_c is C*H, mult(N_c, T, Res).

comp(X, Y):- C=1, mult(C, Y, Res), (Res==X -> write("Is multiple"); Res\=X -> write("Is not multiple.")).