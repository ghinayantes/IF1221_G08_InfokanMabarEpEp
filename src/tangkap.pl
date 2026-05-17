tangkap(Target) :-
    giliranSekarang(Penangkap),
    kartuTangan(Target, TanganTarget),
    hitungKartu(TanganTarget, JumlahTarget),
    
    ((JumlahTarget =:= 1, \+ status_uni(Target)) ->
    /* ketika tidak menyerukan uni (kasus pertama) */
        write(Target), write(' tertangkap tidak menyerukan UNI.'), nl,
        write(Target), write(' mendapatkan 2 kartu penalti.'), nl,
        
        hukumAmbilKartu(Target, 2),
        gantiGiliran
    ;
        /* kasus kedua kalo tuduhan salah (kartu > 1 atau sudah teriak uni) */
        write('Tuduhan salah! Target tidak melanggar aturan.'), nl.
        write(Penangkap), write(' mendapatkan 1 kartu penalti secara acak.'), nl,
        
        hukumAmbilKartu(Penangkap, 1),
        gantiGiliran
    ).

/* helper menggantikan length untuk menghitung isi list */
hitungKartu([], 0).
hitungKartu([_ | Tail], Jumlah) :-
    hitungKartu(Tail, Sisa),
    Jumlah is Sisa + 1.

/* helper status aman uni */
tandaiAman(Pemain) :-
    status_uni(Pemain), !.
tandaiAman(Pemain) :-
    assertz(status_uni(Pemain)).
