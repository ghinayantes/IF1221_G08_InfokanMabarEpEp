saveGame :- 
    giliranSekarang(_),
    write('Masukkan nama file penyimpanan: '), read (NamaFile), nl,
    open(NamaFile, write, Stream),
    set_output(Stream),

    giliranSekarang(GS),
    kartuTeratas(KT),
    warnaAktif(WA),
    arahPermainan(AP),
    urutanPemain(UP),
    statusUni (SU),

    format('urutan_pemain:~q.~n', [UP]),
    format('giliran:~q.~n', [GS]),
    write('discard_top:'), cetakKartu(KT), write('.'), nl, 
    format('warna_aktif:~w.~n', [WA]),
    format('arah_permainan:~w.~n', [AP]),
    format('status_UNI:~q.~n', [SU]),
    
    SemuaKartuPemain(UP).

    close(Stream),
    set_output(user_output),
    format('Status permainan berhasil disimpan ke ~w.~n', [NamaFile]).

SemuaKartuPemain([]).
SemuaKartuPemain([H|T]):-
    kartuTangan(H, ListKartu),
    format('kartu(~q):', [H]),
    write('['),
    tampilkanKartu(ListKartu),
    write('].'), nl,
    SemuaKartuPemain(T).

tampilkanKartu([]).
tampilkanKartu([H|T]) :- !,
    cetakKartu(H),
    tampilkanSisaKartu(T).

tampilkanSisaKartu([]).
tampilkanSisaKartu([H|T]) :- !,
    write(','),            
    cetakKartu(H),
    tampilkanSisaKartu(T).