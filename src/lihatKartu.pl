lihatKartu :-
    giliranSekarang(Player),
    kartuTangan(Player, Cards),
    write('Berikut kartu yang anda miliki:'), nl,
    tampilkanKartu(Cards, 1, Player).

tampilkanKartu([], _, _).

tampilkanKartu([kartu(Warna, angka(N))|T], Idx, Player) :- !,
    (kartuTersembunyi(Player, Idx) ->
        format('~w. ~w-~w (Kartu tersembunyi)~n', [Idx, Warna, N])
    ;
        format('~w. ~w-~w~n', [Idx, Warna, N])
    ),
    NextIdx is Idx + 1,
    tampilkanKartu(T, NextIdx, Player).

tampilkanKartu([kartu(Warna, Jenis)|T], Idx, Player) :-
    (kartuTersembunyi(Player, Idx) ->
        format('~w. ~w-~w (Kartu tersembunyi)~n', [Idx, Warna, Jenis])
    ;
        format('~w. ~w-~w~n', [Idx, Warna, Jenis])
    ),
    NextIdx is Idx + 1,
    tampilkanKartu(T, NextIdx, Player).