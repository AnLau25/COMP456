mult(M, [], M).
mult(M, [H|T], R):- N_m is M*H, mult(N_m,T, R).

isMult(X,Y):- mult(1, Y, R), (X==R -> write("Is multiple"); X\=R -> write("Is not multiple")).