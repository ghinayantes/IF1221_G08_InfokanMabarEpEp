cekInfo:-
    kartuTeratas(KT),
    urutanPemain(L),
    nl, % Baris kosong setelah command dipanggil
    write('Kartu discard top: '), cetakKartu(KT), write('.'), nl,
    nl, % Baris kosong
    write('Urutan pemain: '), tampilkanUrutan(L), write('.'), nl,
    nl, % Baris kosong sebelum list pemain
    tampilkanDetailPemain(L, 1).

%Menghitung kartu tersembunyi 
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

% Aturan 2: Rekursi list pemain
tampilkanDetailPemain([H|T], No) :-
    kartuTangan(H, ListK),
    hitungPanjang(ListK, Jumlah),
    hitungKartuTersembunyi(H, ListK, JumlahSembunyi),
    Jumlah is TotalKartu - JumlahSembunyi,
    format('Nama pemain ~w: ~w~n', [No, H]),
    format('Jumlah kartu : ~w~n~n', [Jumlah]), 
    NextNo is No + 1,
    tampilkanDetailPemain(T, NextNo).
