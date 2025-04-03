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
rule(move(state(F, W, G, C), state(Fn, Wn, Gn, Cn), 'Farmer takes self')):-
    rule(opp(F, Fn)),
    W = Wn,
    G = Gn,
    C = Cn.

rule(move(state(F, W, G, C), state(Fn, Wn, Gn, Cn), 'Farmer takes Wolf')):-
    F = W,
    rule(opp(F, Fn)),
    rule(opp(W, Wn)),
    G = Gn,
    C = Cn.

rule(move(state(F, W, G, C), state(Fn, Wn, Gn, Cn), 'Farmer takes Goat')):-
    F = G,
    rule(opp(F, Fn)),
    W = Wn,
    rule(opp(G, Gn)),
    C = Cn.

rule(move(state(F, W, G, C), state(Fn, Wn, Gn, Cn), 'Farmer takes Cabbage')):-
    F = C,
    rule(opp(F, Fn)),
    W = Wn,
    G = Gn,
    rule(opp(C, Cn)).

%Interactions
query(see_sln, 'See a first solution? (y/n)').
query(see_othr, 'See a different solution? (y/n)').
query(explain, 'See solution explanation? (y/n)').