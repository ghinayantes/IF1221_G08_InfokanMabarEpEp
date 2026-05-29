lihatKartu :- 
    \+ giliranSekarang(_), !, 
    write('Tidak ada permainan yang sedang berjalan. Ketik "start." untuk mulai.'), nl.

lihatKartu :-
    giliranSekarang(Player),
    kartuTangan(Player, Cards),
    write('Berikut kartu yang anda miliki.'), nl,
    tampilkanKartu(Cards, 1, Player),
    % Jika mode turnamen, tampilkan kartu teman setim
    (modeTurnamen -> nl,
        cariTemanSetim(Player, Teman),
        kartuTangan(Teman, KartuTeman),
        format('Berikut kartu yang teman satu tim anda miliki (~w).~n', [Teman]),
        tampilkanKartuTeman(KartuTeman, 1) ; true).

/* Tampilkan kartu teman (tanpa info tersembunyi — teman bisa lihat semua) */
tampilkanKartuTeman([], _).
tampilkanKartuTeman([kartu(Warna, angka(N))|T], Idx) :- !,
    format('~w. ~w-~w~n', [Idx, Warna, N]),
    NextIdx is Idx + 1,
    tampilkanKartuTeman(T, NextIdx).
tampilkanKartuTeman([kartu(Warna, Jenis)|T], Idx) :-
    format('~w. ~w-~w~n', [Idx, Warna, Jenis]),
    NextIdx is Idx + 1,
    tampilkanKartuTeman(T, NextIdx).

tampilkanKartu([], _, _).

tampilkanKartu([kartu(Warna, angka(N))|T], Idx, Player) :- !,
    (kartuTersembunyi(Player, Idx) ->
        format('~w. ~w-~w (Kartu tersembunyi)~n', [Idx, Warna, N]) ;
        format('~w. ~w-~w~n', [Idx, Warna, N])),
    NextIdx is Idx + 1,
    tampilkanKartu(T, NextIdx, Player).

tampilkanKartu([kartu(Warna, Jenis)|T], Idx, Player) :-
    (kartuTersembunyi(Player, Idx) ->
        format('~w. ~w-~w (Kartu tersembunyi)~n', [Idx, Warna, Jenis]) ;
        format('~w. ~w-~w~n', [Idx, Warna, Jenis])),
    NextIdx is Idx + 1,
    tampilkanKartu(T, NextIdx, Player).