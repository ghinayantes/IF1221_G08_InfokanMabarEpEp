cekInfo:-
    kartuTeratas(KT),
    warnaAktif(WA),
    urutanPemain(L), nl,
    write(' '), nl,
    write('Kartu discard top: '), cetakKartu(KT), format(' (Warna aktif: ~w)', [WA]), nl,
    write(' '), nl,
    write('Urutan pemain: '), tampilkanUrutan(L), nl,
    write(' '), nl,

    tampilkanDetailPemain([], _).
    tampilkanDetailPemain(L, 1).
    tampilkanDetailPemain(,[H|T] No):-
        kartuTangan(H, ListK),
        hitungPanjang(ListK, Jumlah),
        format('Nama pemain ~w: ~w~n', [No, H]),
        format('Jumlah kartu: ~w~n~n', [Jumlah]),
        NextNo is No+1,
        tampilkanDetailPemain(T, NextNo).
    
