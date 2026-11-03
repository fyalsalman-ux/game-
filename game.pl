:- dynamic current_letters/1.

start_game :-
    retractall(current_letters(_)),
    assertz(current_letters([a, b, c])),
    menu_loop.

menu_loop :-
    nl,
    write('Hi, This is the "Name Game".'), nl,
    write('You will be given a set of English letters in which you will add, delete or move to create your name.'), nl,
    write('Choose from the following:'), nl,
    write('1- Display the current set of letters'), nl,
    write('2- Add a letter'), nl,
    write('3- Add a letter at the top'), nl,
    write('4- Add a letter at the bottom'), nl,
    write('5- Delete a letter'), nl,
    write('6- Delete all letters'), nl,
    write('7- Exit'), nl,
    write('Enter your choice....'), nl,
    write('|: '),
    read(Choice),
    handle_choice(Choice).


handle_choice(7) :-
    !,
    write('Exiting game. Goodbye!'), nl.


handle_choice(1) :-
    !,
    current_letters(L),
    write('Current set of letters: '), write(L), nl,
    menu_loop.


handle_choice(2) :-
    !,
    write('Enter the letter to add: '), read(X),
    current_letters(L),
    append(L, [X], NewL),
    retract(current_letters(L)),
    assertz(current_letters(NewL)),
    menu_loop.

handle_choice(3) :-
    !,
    write('Enter the letter to add at the top: '), read(X),
    current_letters(L),
    NewL = [X|L],
    retract(current_letters(L)),
    assertz(current_letters(NewL)),
    menu_loop.


handle_choice(4) :-
    !,
    write('Enter the letter to add at the bottom: '), read(X),
    current_letters(L),
    append(L, [X], NewL),
    retract(current_letters(L)),
    assertz(current_letters(NewL)),
    menu_loop.


handle_choice(5) :-
    !,
    write('Enter the letter to delete: '), read(X),
    current_letters(L),
    (   select(X, L, NewL)
    ->  retract(current_letters(L)),
        assertz(current_letters(NewL)),
        write('Letter deleted successfully.'), nl
    ;   write('Letter not found in the set.'), nl
    ),
    menu_loop.


handle_choice(6) :-
    !,
    retract(current_letters(_)),
    assertz(current_letters([])),
    write('All letters deleted.'), nl,
    menu_loop.

handle_choice(_) :-
    write('Invalid choice, please try again.'), nl,
    menu_loop.
