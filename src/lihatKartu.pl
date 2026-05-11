lihatKartu :-
    giliranSekarang(Player),
    kartuTangan(Player, Cards),
    write('Berikut kartu yang anda miliki:'), nl,
    tampilkanKartu(Cards, 1).

tampilkanKartu([], _).

tampilkanKartu([kartu(Warna, angka(N))|T], Idx) :- !,
    format('~w. ~w-~w~n', [Idx, Warna, N]),
    NextIdx is Idx + 1,
    tampilkanKartu(T, NextIdx).

tampilkanKartu([kartu(Warna, Jenis)|T], Idx) :-
    format('~w. ~w-~w~n', [Idx, Warna, Jenis]),
    NextIdx is Idx + 1,
    tampilkanKartu(T, NextIdx).