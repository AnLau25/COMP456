% Get_world
:- dynamic fact/1, rule/1, askable/2.
consult('C:/Users/User/Documents/A_UNI/YOff/Atha/COMP456/U2/Prolog/knowledge_farmer.pl').

% Handle_communication_with_user
abbrev(n, no).
abbrev(y, yes).
abbrev(q, quit).
abbrev(X, X).

print_help:-
    writeln('Nano can read the following commands:'), nl,
    writeln('   no.   (n) - to disagree'), nl,
    writeln('   yes.  (y) - to agree'), nl,
    writeln('   quit. (q) - to leave system'), nl,
    writeln('   help.     - to have Nano remind you the commands'), nl.

ask(Question, Ans):-
    writeln(Question),
    read(A),
    abbrev(A, Ans),
    nl, !.

interact(_, _, quit, _):- writeln('Bye!'), halt.
interact(start, _, no, _):- interact(_, _, quit, _).
interact(start, _, yes, One_Soln):- search_Engine(One_Soln), writeln('Got the solutions!'), nl.

interact(see_sln, _, no, _).
interact(see_sln, _, yes, One_Soln):- writeln('Here is your first solution:'), nl, write_Soln(One_Soln).

interact(explain, _, no, _).
interact(explain, _, yes, Moves):- write_Explain(Moves), writeln('Goal reached!'), nl.

interact(see_othr, _, no, _).
interact(see_othr, _, yes, []):- nl, write_Soln([]).
interact(see_othr, _, yes, T):- writeln('Here is an alternative solution:'), nl, write_Soln(T).

% Search_algorithm_definition
search_Engine(One_Soln):-  
    fact(init_State(I)),  
    setof((Soln, Moves), dfs([I], ['Initial state'], [], Soln, Moves), Solutions),  
    (Solutions \= [] -> One_Soln = Solutions ;  
     writeln("No solutions found!"), fail).  

dfs(Path, Inv_Moves, Visited, Soln, Moves):-
    [H|_] = Path, 
    fact(goal_State(H)),
    reverse(Path, Soln),
    reverse(Inv_Moves, Moves).

dfs(Path, Inv_Moves, Visited, Soln, Moves):-  
    [H|_] = Path,  
    rule(move(H, Nstate, Current)),  
    \+ member(Nstate, Path),  
    fact(is_safe(Nstate)),  
    fact(is_safe_explained(H, Inv_New_Explained)),  

    reverse(Inv_New_Explained, New_Explained),  
    New_Inv_Moves = [New_Explained|Inv_Moves],  

    dfs([Nstate|Path], [Current|New_Inv_Moves], [H|Visited], Soln, Moves).  

% Solution_display
writelist([]).  
writelist([H]):- write(H), write('.'), nl, nl.  
writelist([H | T]):- write(H), write(','), nl, writelist(T).  

write_Explain([H|[]]):- writeln(H), nl.
write_Explain([Move, Explanation | RestMoves]) :-
    writeln('So I chose:'),
    writeln(Move), nl,
    writeln('I saw:'),
    writelist(Explanation),
    write_Explain(RestMoves).

write_Soln_inWords([H|[]]):- write(H), nl, nl.
write_Soln_inWords([H|[_|T2]]):- write(H), write(','), nl, nl, write_Soln_inWords(T2).

write_Soln([]):- writeln('Those were all the solutions found'), nl.
write_Soln([(Soln, Moves)|T]):- 
    writeln('Sides of the river:'), 
    writeln('We have e = east and w = west for the two shores'), nl,
    writeln('States format:'),
    writeln('state(Farmer, Wolf, Goat, Cabbage)'), nl,
    writelist(Soln),
    writeln('Goal reached!'), nl,

    writeln('Transitions: '), nl,
    write_Soln_inWords(Moves),
    writeln('Goal reached!'), nl, nl,

    askable(explain, ExplainQ),
    ask(ExplainQ, ExplainAns),
    interact(explain, ExplainQ, ExplainAns, Moves), nl, nl,

    askable(see_othr, Question),
    ask(Question, Ans),
    interact(see_othr, Question, Ans, T).

% Expert_coms_I_named_it_Nano
nano:-
    nl, writeln("Hi! I'm Nano, your puzzle expert system."),
    nl, writeln("Let's solve the Farmer, Wolf, Goat, Cabbage problem together!"),
    print_help,

    askable(start, Quest1),
    ask(Quest1, Ans1),
    interact(start, Quest1, Ans1, One_Soln),

    askable(see_sln, Quest2),
    ask(Quest2, Ans2),
    interact(see_sln, Quest2, Ans2, One_Soln),

    writeln('Well, that was fun, see you next time.'),
    nl, writeln('Nano, out!').
