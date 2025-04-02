%Get_world
:- use_module(library(readutil)).
:- dynamic fact/1, rule/1, askable/2.

get_kbase:-
    writeln('Input your knowledge base, so we can start:'),
        read_line_to_string(user_input, File),
        (File == "quit." -> nl, interact(_, _, quit, _); 
        (exists_file(File) ->
            (catch(consult(File), _, fail) ->
                nl, writeln('File consulted, knowledge retrieved!'), nl, nl, !;
            nl, writeln('Error consulting the file. Please check your path and try again.'), nl, get_kbase);
            nl, writeln('Invalid file path. Please try again.'), nl, get_kbase)).  
    




%User_Interaction
get_help:-
    writeln('Nano can read the following commands:'), nl,
    writeln('   no.   -> to say no'), nl,
    writeln('   yes.  -> to say yes'), nl,
    writeln('   quit. -> to leave the system'), nl,
    writeln('   help. -> to have Nano remind you the commands'), nl.

ask(Question, Ans):-
    writeln(Question),
    read(Ans),
    nl, nl, !.

interact(Question, ExplainQ, Invalid_Ans, Arg):-  
    \+ member(Invalid_Ans, [help, yes, no, quit]),  
    writeln("Nano's commands only include no, yes, quit and help."), nl,  
    ask(ExplainQ, Ans),  
    interact(Question, ExplainQ, Ans, Arg).  

interact(Question, ExplainQ, help, Arg):-
    get_help,
    ask(ExplainQ, Ans),
    interact(Question, ExplainQ, Ans, Arg).

interact(_, _, quit, _):- writeln('Bye!'), !, fail.
interact(start, _, no, _):- interact(_, _, quit, _).
interact(start, _, yes, L):- search(L), writeln('Got the solutions!'), nl, nl.

interact(see_sln, _, no, _).
interact(see_sln, _, yes, L):- writeln('Here is your first solution:'), nl, write_Soln(L).

interact(explain, _, no, _).
interact(explain, _, yes, Moves):- write_Explain(Moves), writeln('Goal reached!'), nl, nl.

interact(see_othr, _, no, _).
interact(see_othr, _, yes, []):- write_Soln([]).
interact(see_othr, _, yes, T):- writeln('Here is an alternative solution:'), nl, write_Soln(T).





%Search_algorithm_definition
search(L):-  
    fact(init_State(I)),  
    setof((Soln, Moves), dfs([I], ['Initial state'], Soln, Moves), Solutions),  
    (Solutions \= [] -> L = Solutions ;  
     writeln("No solutions found!"), fail).  

dfs(Path, Inv_Moves, Soln, Moves):-
    [H|_] = Path, 
    fact(goal_State(H)),
    reverse(Path, Soln),
    reverse(Inv_Moves, Moves).

dfs(Path, Inv_Moves, Soln, Moves):-  
    [H|_] = Path,  
    rule(move(H, Nstate, Current)),  
    \+ member(Nstate, Path),  
    fact(is_safe(Nstate)),  
    fact(is_safe_explained(H, Inv_New_Explained)),  

    reverse(Inv_New_Explained, New_Explained),  
    New_Inv_Moves = [New_Explained|Inv_Moves],  

    dfs([Nstate|Path], [Current|New_Inv_Moves], Soln, Moves).  





%Solution_display
writelist([]).  
writelist([H]):- write(H), write('.'), nl, nl.  
writelist([H | T]):- write(H), write(','), nl, writelist(T).  

write_Explain([H|[]]):- writeln('So I chose:'), writeln(H), nl.
write_Explain([Move, Explanation | RestMoves]) :-
    writeln('So I chose:'),
    writeln(Move), nl,
    writeln('I saw:'),
    writelist(Explanation),
    write_Explain(RestMoves).

write_Soln([S|[]], [M|[]]):- write(S), write(': '), write(M), nl.
write_Soln([S|Solns], [M|[_|Moves]]) :- write(S), write(': '), write(M), nl, write_Soln(Solns, Moves).

write_Soln([]):- writeln('Those were all the solutions found.'), nl.
write_Soln([(Soln, Moves)|T]):- 
    writeln('Sides of the river:'), 
    writeln('We have e = east and w = west for the two shores'), nl,
    writeln('States format:'),
    writeln('state(Farmer, Wolf, Goat, Cabbage)'), nl,
    write_Soln(Soln, Moves), nl,
    writeln('Goal reached!'), nl, nl,

    askable(explain, ExplainQ),
    ask(ExplainQ, ExplainAns),
    interact(explain, ExplainQ, ExplainAns, Moves),

    askable(see_othr, Question),
    ask(Question, Ans),
    interact(see_othr, Question, Ans, T).





%Expert_coms_I_named_it_Nano
nano:-
    nl, writeln("Hi! I'm Nano, your puzzle expert system."),
    nl, writeln("Let's solve the Farmer, Wolf, Goat, Cabbage problem together!"), nl,
    get_help,

    get_kbase,

    askable(start, Quest1),
    ask(Quest1, Ans1),
    interact(start, Quest1, Ans1, L),

    askable(see_sln, Quest2),
    ask(Quest2, Ans2),
    interact(see_sln, Quest2, Ans2, L),

    writeln('Well, that was fun, see you next time.'), nl, 
    writeln('Nano, out!'), nl.

