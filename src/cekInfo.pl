cekInfo:- 
    \+ giliranSekarang(_), !,
    write('Tidak ada permainan yang sedang berjalan. Ketik "start." untuk mulai.'), nl.
cekInfo:-
    kartuTeratas(KT),
    urutanPemain(L), nl,
    write('Kartu discard top: '), cetakKartu(KT), write('.'), nl, nl,
    % Tampilkan info tim jika mode turnamen
    (modeTurnamen -> tim1([T1A, T1B]),
        tim2([T2A, T2B]),
        format('Tim 1 : ~w, ~w~n', [T1A, T1B]),
        format('Tim 2 : ~w, ~w~n', [T2A, T2B]), nl ; true),
    write('Urutan pemain: '), tampilkanUrutan(L), write('.'), nl, nl,
    tampilkanDetailPemain(L, 1).

% Hitung jumlah kartu yang tersembunyi berdasarkan indeks
hitungKartuTersembunyi(Pemain, ListK, Jumlah) :-
    hitungPanjang(ListK, Total),
    hitungIndeksTersembunyi(Pemain, 1, Total, Jumlah).

hitungIndeksTersembunyi(_, Idx, Total, 0) :-
    Idx > Total, !.
hitungIndeksTersembunyi(Pemain, Idx, Total, Jumlah) :-
    Idx =< Total,
    IdxNext is Idx + 1,
    (kartuTersembunyi(Pemain, Idx) -> hitungIndeksTersembunyi(Pemain, IdxNext, Total, Temp),
        Jumlah is Temp + 1 ;
        hitungIndeksTersembunyi(Pemain, IdxNext, Total, Jumlah)).

% base case
tampilkanDetailPemain([], _).

% Rekursi list pemain
tampilkanDetailPemain([H|T], No) :-
    kartuTangan(H, ListK),
    hitungPanjang(ListK, Total),
    hitungKartuTersembunyi(H, ListK, JumlahTersembunyi),
    Jumlah is Total - JumlahTersembunyi,
    format('Nama pemain ~w: ~w~n', [No, H]),
    format('Jumlah kartu : ~w~n~n', [Jumlah]), 
    NextNo is No + 1,
    tampilkanDetailPemain(T, NextNo).