cekInfo:-
    kartuTeratas(KT),
    urutanPemain(L),
    nl, 
    write('Kartu discard top: '), cetakKartu(KT), write('.'), nl,
    nl,
    write('Urutan pemain: '), tampilkanUrutan(L), write('.'), nl,
    nl,
    tampilkanDetailPemain(L, 1).

%update perhitungan jumlah kartu saat disembunyikan
hitungKartuTersembunyi(_, [], 0).

hitungKartuTersembunyi(Pemain, [H|T], Jumlah) :-
    kartuTersembunyi(Pemain, H),
    hitungKartuTersembunyi(Pemain, T, Temp),
    Jumlah is Temp + 1.

hitungKartuTersembunyi(Pemain, [H|T], Jumlah) :-
    \+ kartuTersembunyi(Pemain, H),
    hitungKartuTersembunyi(Pemain, T, Jumlah).

% base case
tampilkanDetailPemain([], _).

% Rekursi list pemain
tampilkanDetailPemain([H|T], No) :-
    kartuTangan(H, ListK),
    hitungPanjang(ListK, Jumlah),
    format('Nama pemain ~w: ~w~n', [No, H]),
    format('Jumlah kartu : ~w~n~n', [Jumlah]), 
    NextNo is No + 1,
    tampilkanDetailPemain(T, NextNo).
