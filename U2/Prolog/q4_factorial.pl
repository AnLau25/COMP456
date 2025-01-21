fact(X):- factor(X, 1).

factor(0, R):- write(1).
factor(1, R):- write(R).
factor(X, R):- X > 1, X1 is X-1, R1 is R*X, factor(X1, R1).

