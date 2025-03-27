%World_definition
init_State(e, e, e, e).
goal_State(w, w, w, w).

%Travel_to_opposite_side
opp(e, w).
opp(w, e).

%Define_safe_states
is_safe(state(Farmer, Wolf, Goat, Choux)):-
    ((Farmer == Wolf, Farmer==Goat, Farmer==Choux);
    (Goat \= Wolf; Farmer == Wolf, Farmer==Goat),
    (Goat \= Choux; Farmer == Choux, Farmer==Goat)).

%Explanations_for_safe_state
is_safe_explained(state(Farmer, Wolf, Goat, Choux), Explain):- 
    (((Farmer == Wolf, Farmer==Goat, Farmer==Choux), Explain = ['All on the same side, so no one eats no one'], !);
    (((Goat \= Wolf), Explain1 = ['Wolf and Goat not on the same side, wolf cannot eat goat']); ((Farmer == Wolf, Farmer==Goat), Explain1 = ['Wolf and Goat are with Farmer, Wolf cannot eat Goat']),
    ((Goat \= Choux), append(Explain1, ['Goat and Cabbage not on the same side, Goat cannot eat Cabbage'], Explain2)); ((Farmer == Choux, Farmer==Goat), (Explain1, ['Cabbage and Goat are with Farmer, Goat cannot eat Cabbage'], Explain2)), Explain = Explain2, !)).

%Define_posible_moves
move(state(F1, W1, G1, C1), state(F2, W2, G2, C2), 'Farmer takes self'):-
    opp(F1, F2),
    W1 = W2,
    G1 = G2,
    C1 = C2.

move(state(F1, W1, G1, C1), state(F2, W2, G2, C2), 'Farmer takes Wolf'):-
    F1 = W1,
    opp(F1, F2),
    opp(W1, W2),
    G1 = G2,
    C1 = C2.

move(state(F1, W1, G1, C1), state(F2, W2, G2, C2), 'Farmer takes Goat'):-
    F1 = G1,
    opp(F1, F2),
    W1 = W2,
    opp(G1, G2),
    C1 = C2.

move(state(F1, W1, G1, C1), state(F2, W2, G2, C2), 'Farmer takes Cabbage'):-
    F1 = G1,
    opp(F1, F2),
    W1 = W2,
    G1 = G2,
    opp(C1, C2).

%Interactions
askable(start, 'Start search? (y/n)').
askable(see_sln, 'See a first solution? (y/n)').
askable(see_othr, 'See diferent a diferent solution? (y/n)').
askable(explain, 'See solution explanation? (y/n)').