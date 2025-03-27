%Get_world
consult('knowledge_farmer.pl').

%Handle_communication_with_user
abbrev(X, X).
abbrev(n, no).
abbrev(y, yes).
abbrev(q, quit).

print_help:-
    writeln('Nano can read the following commands:'), nl,
    writeln('   no.   (n) - to disagree'), nl,
    writeln('   yes.  (y) - to agree'), nl,
    writeln('   quit. (q) - to leave system'), nl,
    writeln('   help.     - to have Nano remind you the commands'), nl. 

interact(Question, ExplainQ, Inavlid_Ans, Arg):-
    not(member(Inavlid_Ans,[help, yes, no, quit])),
    writeln("Nano's commands only include (n)o, (y)es, (q)uit and help."), nl,
    ask(ExplainQ, Ans),
    interact(Question, ExplainQ, Ans, Arg).

interact(Question, ExplainQ, help, Arg):-
    print_help,
    ask(ExplainQ, Ans),
    interact(Question, ExplainQ, Ans, Arg).

interact(_, _, quit, _):- writeln('Bye!'), halt.

interact(start, _, no, -):- interact(_, _, quit, _).
interact(start, _, yes, One_Soln):- search_Engine(One_Soln), writeln('Got the solutions!'), nl.

interact(see_sln, _, no, _).
interact(see_sln, _, yes, One_Soln):- writeln('Here is your first solution:'), nl, write_Soln(One_Soln).

interact(explain, _, no, _).
interact(explain, _, yes, Moves):- write_Explain(Moves), write('Goal reached!'), nl.

interact(see_othr, _, no, _).
interact(see_othr, _, yes, T):- writeln('Here is an alternative solution:'), nl, write_Soln(One_Soln).

%Handle_questions
ask(Question, Ans):-
    writeln(Question),
    read(A),
    abbrev(A, Ans),
    nl, !.

%Search_algorithm_definition
search_Engine(One_Soln):-.

%Solution_display

%Expert_coms_I_named_it_Nano
Nano:-
    nl, writeln("Hi! I'm Nano, your puzzle expert system."),
    nl, writeln("Let's solve the Farmer, Wolf, Goat, Cabbage problem together!")
    print_help,

    %Start_search?
    askable(start, Quest1),
    ask(Quest1, Ans1),
    interact(start, Quest1, Ans1, One_Soln),

    %See_firs_solution?
    askable(see_sln, Quest2),
    ask(Quest2, Ans2),
    interact(see_sln, Quest2, Ans2, One_Soln),

    %See_more_solutions?
    writeln('Well, that was fun, see you next time.'),
    nl, writeln('Nano, out!').

