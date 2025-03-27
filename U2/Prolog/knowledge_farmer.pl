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

%Explenations_for_safe_state
is_safe_explained(state(Farmer, Wolf, Goat, Choux), Explain):- 
    (((Farmer == Wolf, Farmer==Goat, Farmer==Choux), Explain = ['All on the same side, so no one eats no one'], !);
    (((Goat \= Wolf), Explain1 = ['Wolf and Goat not on the same side, wolf cannot eat goat']); ((Farmer == Wolf, Farmer==Goat), Explain1 = ['Wolf and Goat are with Farmer, Wolf cannot eat Goat']),
    ((Goat \= Choux), append(Explain1, ['Goat and Cabbage not on the same side, Goat cannot eat Cabbage'], Explain2)); ((Farmer == Choux, Farmer==Goat), (Explain1, ['Cabbage and Goat are with Farmer, Goat cannot eat Cabbage'], Explain2)), Explain = Explain2, !)).

%Define_posible_moves


