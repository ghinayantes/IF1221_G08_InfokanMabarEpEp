/* helper pengganti nth1 */
ambilKartuAtIndeks(1, [Kartu|_], Kartu).
ambilKartuAtIndeks(N, [_|SisaTangan], Kartu) :-
    N > 1,
    N1 is N - 1,
    ambilKartuAtIndeks(N1, SisaTangan, Kartu).

uni(NomorUrut) :-
    giliranSekarang(Pemain),
    kartuTangan(Pemain, Tangan),
    hitungKartu(Tangan, JumlahKartu),

    (JumlahKartu =:= 2 ->
        ambilKartuAtIndeks(NomorUrut, Tangan, KartuPilihan),
        KartuPilihan = kartu(Warna, Jenis),
        
        cekValid(Warna, Jenis),
        !,
        
        warnaAktif(WarnaLama),
        kartuTeratas(kartu(_, JenisLama)),

        hapusKartuDariTangan(KartuPilihan, Tangan, SisaTangan), % BUG FIX: select -> hapusKartuDariTangan
        retract(kartuTangan(Pemain, _)),
        assertz(kartuTangan(Pemain, SisaTangan)),

        % Hapus indeks tersembunyi untuk kartu yang dimainkan, geser indeks lebih besar
        updateIndeksTersembunyi(Pemain, NomorUrut),

        retract(kartuTeratas(_)),
        assertz(kartuTeratas(KartuPilihan)), 
        updateWarnaAktif(Warna), 
        
        (SisaTangan == [] ->
            nl, endGame, !
        ;
            % 1. Kondisi ancaman khusus Wild Draw Four
            (Jenis == wildDrawFour -> 
                retractall(statusAncaman(_)), asserta(statusAncaman(aktif)) ; 
                retractall(statusAncaman(_)), asserta(statusAncaman(aman))),

            retractall(warnaSebelumnya(_)), asserta(warnaSebelumnya(WarnaLama)),
            retractall(jenisSebelumnya(_)), asserta(jenisSebelumnya(JenisLama)),
            retractall(pemainSebelumnya(_)), asserta(pemainSebelumnya(Pemain)),

            updateWarnaAktif(Warna),

            format('~w memainkan kartu: ', [Pemain]), cetakKartu(KartuPilihan), write('.'), nl,
            format('~w menyerukan UNI!~n', [Pemain]),
            tandaiAman(Pemain),

            % Interupsi giliran khusus Wild Draw Four
            (Jenis == wildDrawFour -> 
                gantiGiliran, 
                giliranSekarang(Next),
                format('Giliran ~w.~n', [Next]) 
            ; 
                eksekusiEfek(Jenis)
            )
        )
    ;
        /* kartu di tangan bukan 2 (sisa tidak akan 1) */
        write('Perintah tidak valid! Kartu tidak membuat sisa tangan menjadi 1.'), nl,
        format('~w mendapatkan 1 kartu penalti acak.~n', [Pemain]),
     
        ambilKartu(Pemain, 1),
        gantiGiliran
    ).

uni(_) :-
    write('Gagal! Kartu yang dipilih tidak valid, tidak cocok dengan kartu di meja, atau indeks di luar batas.'), nl.

/* Jika sudah ada, tidak tambah duplikat */
tandaiAman(Pemain) :-
    statusUni(ListAman),
    isMember(Pemain, ListAman), !.  % sudah ada, tidak perlu ditambahkan
tandaiAman(Pemain) :-
    retract(statusUni(ListAman)),
    asserta(statusUni([Pemain|ListAman])).