%World_definition
fact(init_State(state(e, e, e, e))).
fact(goal_State(state(w, w, w, w))).

%Define_safe_states
fact(is_safe(state(Farmer, Wolf, Goat, Choux))):-
    ((Farmer == Wolf, Farmer==Goat, Farmer==Choux);
    (Goat \= Wolf; Farmer == Wolf, Farmer==Goat),
    (Goat \= Choux; Farmer == Choux, Farmer==Goat)).

%Explanations_for_safe_state
fact(is_safe_explained(state(Farmer, Wolf, Goat, Choux), Explain)) :- 
    (Farmer == Wolf, Farmer == Goat, Farmer == Choux -> 
        Explain = ['All on the same side, so no one eats anyone']
    ; 
        findall(E, (
            (Goat \= Wolf -> E = 'Wolf and Goat are not on the same side, so the Wolf cannot eat the Goat' ; 
             Farmer == Wolf, Farmer == Goat -> E = 'Wolf and Goat are with the Farmer, so the Wolf cannot eat the Goat');
            (Goat \= Choux -> E = 'Goat and Cabbage are not on the same side, so the Goat cannot eat the Cabbage' ; 
             Farmer == Choux, Farmer == Goat -> E = 'Goat and Cabbage are with the Farmer, so the Goat cannot eat the Cabbage')
        ), Explain)
    ).

%Travel_to_opposite_side
rule(opp(e, w)).
rule(opp(w, e)).

%Define_posible_moves
rule(move(state(F1, W1, G1, C1), state(F2, W2, G2, C2), 'Farmer takes self')):-
    rule(opp(F1, F2)),
    W1 = W2,
    G1 = G2,
    C1 = C2.

rule(move(state(F1, W1, G1, C1), state(F2, W2, G2, C2), 'Farmer takes Wolf')):-
    F1 = W1,
    rule(opp(F1, F2)),
    rule(opp(W1, W2)),
    G1 = G2,
    C1 = C2.

rule(move(state(F1, W1, G1, C1), state(F2, W2, G2, C2), 'Farmer takes Goat')):-
    F1 = G1,
    rule(opp(F1, F2)),
    W1 = W2,
    rule(opp(G1, G2)),
    C1 = C2.

rule(move(state(F1, W1, G1, C1), state(F2, W2, G2, C2), 'Farmer takes Cabbage')):-
    F1 = C1,
    rule(opp(F1, F2)),
    W1 = W2,
    G1 = G2,
    rule(opp(C1, C2)).

%Interactions
askable(start, 'Start search? (y/n)').
askable(see_sln, 'See a first solution? (y/n)').
askable(see_othr, 'See a different solution? (y/n)').
askable(explain, 'See solution explanation? (y/n)').