sembunyikanKartu(NomorUrut) :-
    giliranSekarang(Pemain),
    kartuTangan(Pemain, Tangan),
    hitungPanjang(Tangan, JumlahKartu),
 
    % Tidak boleh sembunyikan jika kartu tinggal 1
    (JumlahKartu > 1 ->
        % validasi indeks
        (NomorUrut >= 1, NomorUrut =< JumlahKartu -> true ;
            format('Nomor kartu ~w tidak valid (kamu punya ~w kartu).~n', [NomorUrut, JumlahKartu]), fail),

        ambilKartuAtIndeks(NomorUrut, Tangan, Kartu),
        % Cek apakah indeks ini sudah tersembunyi sebelumnya
        (\+ kartuTersembunyi(Pemain, NomorUrut) ->
            asserta(kartuTersembunyi(Pemain, NomorUrut)),
            write('Kartu '), cetakKartu(Kartu),
            write(' berhasil disembunyikan.'), nl, nl,
            gantiGiliran,
            giliranSekarang(Next),
            format('Giliran ~w.~n', [Next])
        ;
            write('Kartu tersebut sudah dalam status tersembunyi.'), nl
        )
    ;
        write('Tidak bisa menyembunyikan kartu jika hanya tersisa 1 kartu.'), nl
    ).

tampilkanKartu :- 
    \+ giliranSekarang(_), !,
    write('Tidak ada permainan yang sedang berjalan. Ketik "start." untuk mulai.'), nl.

/* tampilkanKartu/0 — ubah semua kartu tersembunyi milik pemain aktif
   kembali ke status normal (hapus fakta kartuTersembunyi) */
tampilkanKartu :-
    giliranSekarang(Pemain),
    (kartuTersembunyi(Pemain, _) ->
        retractall(kartuTersembunyi(Pemain, _)),
        write('Semua kartu tersembunyi milikmu kini ditampilkan kembali.'), nl ;
        write('Tidak ada kartu tersembunyi untuk ditampilkan.'), nl).
 
/* Helper: cek apakah indeks kartu tertentu tersembunyi */
kartuTersembunyi_check(Pemain, Indeks) :-
    kartuTersembunyi(Pemain, Indeks).