bentukTim([P1, P2, P3, P4]) :-
    asserta(tim1([P1, P3])),
    asserta(tim2([P2, P4])).

% Tampilkan info tim
tampilkanTim :-
    tim1([A, B]),
    tim2([C, D]),
    format('Tim 1 : ~w, ~w~n', [A, B]),
    format('Tim 2 : ~w, ~w~n', [C, D]).

% Hitung poin tim — klausa berurutan tanpa wrapper terpisah (fix discontiguous)
hitungPoinTim([], 0).
hitungPoinTim([P|Sisa], Total) :-
    kartuTangan(P, Tangan),
    hitungTotalPoin(Tangan, Poin),
    hitungPoinTim(Sisa, SisaPoin),
    Total is Poin + SisaPoin.

endGameTurnamen :-
    \+ tim1(_), !,
    write('Data tim tidak ditemukan. Menjalankan endGame mode klasik.'), nl,
    endGameKlasik.

endGameTurnamen :-
    pemainMenang(Pemenang),
    nl,
    format('Permainan selesai! ~w menghabiskan semua kartunya!~n~n', [Pemenang]),
    write('Berikut perhitungan poin sisa kartu.'), nl,

    urutanPemain(ListPemain),
    tampilkanPoinPemain(ListPemain), nl,

    tim1(Tim1),
    tim2(Tim2),
    hitungPoinTim(Tim1, PoinTim1),
    hitungPoinTim(Tim2, PoinTim2),

    write('Berikut perhitungan poin untuk masing-masing tim.'), nl,
    Tim1 = [T1A, T1B],
    Tim2 = [T2A, T2B],

    kartuTangan(T1A, TanganT1A), hitungTotalPoin(TanganT1A, P1A),
    kartuTangan(T1B, TanganT1B), hitungTotalPoin(TanganT1B, P1B),
    kartuTangan(T2A, TanganT2A), hitungTotalPoin(TanganT2A, P2A),
    kartuTangan(T2B, TanganT2B), hitungTotalPoin(TanganT2B, P2B),

    format('Tim 1 (~w, ~w) : ~w + ~w = ~w poin~n', [T1A, T1B, P1A, P1B, PoinTim1]),
    format('Tim 2 (~w, ~w) : ~w + ~w = ~w poin~n', [T2A, T2B, P2A, P2B, PoinTim2]),
    nl,

    (PoinTim1 < PoinTim2 -> NomorTim = 1
    ; PoinTim2 < PoinTim1 -> NomorTim = 2
    ; NomorTim = 0),
    (NomorTim =:= 0 -> write('Seri! Kedua tim memiliki poin yang sama.') ;
        format('Selamat, Tim ~w menjadi pemenang!~n', [NomorTim])), nl.