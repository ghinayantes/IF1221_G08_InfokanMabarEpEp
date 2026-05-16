cekInfo:-
    kartuTeratas(KT),
    urutanPemain(L),
    nl, % Baris kosong setelah command dipanggil
    write('Kartu discard top: '), cetakKartu(KT), write('.'), nl,
    nl, % Baris kosong
    write('Urutan pemain: '), tampilkanUrutan(L), write('.'), nl,
    nl, % Baris kosong sebelum list pemain
    tampilkanDetailPemain(L, 1).

% base case
tampilkanDetailPemain([], _).

% Aturan 2: Rekursi list pemain
tampilkanDetailPemain([H|T], No) :-
    kartuTangan(H, ListK),
    hitungPanjang(ListK, Jumlah),
    format('Nama pemain ~w: ~w~n', [No, H]),
    format('Jumlah kartu : ~w~n~n', [Jumlah]), % Perhatikan ada spasi sebelum titik dua ( : )
    NextNo is No + 1,
    tampilkanDetailPemain(T, NextNo).