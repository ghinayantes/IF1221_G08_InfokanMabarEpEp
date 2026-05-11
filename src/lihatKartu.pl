:- dynamic currentPlayer/1.
:- dynamic playerCards/2.

lihatKartu :-
    currentPlayer(Player),
    playerCards(Player, Cards),
    write('Berikut kartu yang anda miliki.'), nl,
    tampilkanKartu(Cards, 1).

tampilkanKartu([], _).

tampilkanKartu([kartu(Card, false)|T], N) :-
    write(N),
    write('. '),
    write(Card),
    nl,

    N1 is N + 1,
    tampilkanKartu(T, N1).

tampilkanKartu([kartu(Card, true)|T], N) :-
    write(N),
    write('. '),
    write(Card),
    write(' (disembunyikan)'),
    nl,

    N1 is N + 1,
    tampilkanKartu(T, N1).
