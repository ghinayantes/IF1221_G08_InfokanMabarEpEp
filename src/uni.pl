/* helper pengganti nth1 */
ambilKartu(1, [Kartu|_], Kartu).
ambilKartu(N, [_|SisaTangan], Kartu) :-
    N > 1,
    N1 is N - 1,
    ambilKartu(N1, SisaTangan, Kartu).

uni(NomorUrut) :-
    giliranSekarang(Pemain),
    kartuTangan(Pemain, Tangan),
    hitungKartu(Tangan, JumlahKartu),

    (JumlahKartu =:= 2 ->
        /* kartu di tangan ada 2, dimainkan 1 jadi sisa 1 */
        ambilKartu(NomorUrut, Tangan, KartuPilihan),
        KartuPilihan = kartu(Warna, Jenis),
        
        cekValid(Warna, Jenis),
        !,
        
        select(KartuPilihan, Tangan, SisaTangan),
        retract(kartuTangan(Pemain, _)),
        assertz(kartuTangan(Pemain, SisaTangan)), 
        
        retract(kartuTeratas(_)),
        assertz(kartuTeratas(KartuPilihan)), 
        updateWarnaAktif(Warna), 
        
        write(Pemain), write(' memainkan kartu: '), write(Warna), write('-'), write(Jenis), nl,
        write(Pemain), write(' menyerukan UNI!'), nl,
        
        /* tandai pemain ini aman dari tangkapan */
        tandaiAman(Pemain),
        
        eksekusiEfek(Jenis),
        gantiGiliran
    ;
        /* kartu di tangan bukan 2 (sisa tidak akan 1) */
        write('Perintah tidak valid! Kartu tidak membuat sisa tangan menjadi 1.'), nl,
        write(Pemain), write(' mendapatkan 1 kartu penalti acak.'), nl,
     
        hukumAmbilKartu(Pemain, 1), 
        gantiGiliran
    ).

uni(_) :-
    write('Gagal! Kartu yang dipilih tidak valid, tidak cocok dengan kartu di meja, atau indeks di luar batas.'), nl.
