saveGame :- 
    giliranSekarang(_),
    write('Masukkan nama file penyimpanan: '), read (NamaFile), nl,
    open(NamaFile, write, Stream),
    set_output(Stream),

    giliranSekarang(GS),
    cetakKartu(CK),
    warnaAktif(WA),
    arahPermainan(AP),
    urutanPemain(UP),
    statusUni (SU),

    format('urutan_pemain:~q.~n', [UP]),
    format('giliran:~q.~n', [GS]),
    format('discard_top:~w.~n', [CK]), 
    format('warna_aktif:~w.~n', [WA]),
    format('arah_permainan:~w.~n', [AP]),
    format('status_UNI:~q.~n', [SU]),
    
    close(Stream),
    set_output(user_output),
    format('Status permainan berhasil disimpan ke ~w.~n', [NamaFile]).
