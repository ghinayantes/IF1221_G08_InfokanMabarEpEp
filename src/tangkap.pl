tangkap(Target) :-
    giliranSekarang(Penangkap),
    kartuTangan(Target, TanganTarget),
    hitungKartu(TanganTarget, JumlahTarget),
    
    (JumlahTarget =:= 1, \+ statusUni(Target) -> 
    /* ketika tidak menyerukan uni (kasus pertama) */
        format('~w tertangkap tidak menyerukan UNI.~n', [Target]),
        format('~w mendapatkan 2 kartu penalti.~n', [Target]),
        
        ambilKartu(Target, 2),
        gantiGiliran
    ;
        /* kasus kedua kalo tuduhan salah (kartu > 1 atau sudah teriak uni) */
        write('Tuduhan salah! Target tidak melanggar aturan.'), nl, % <-- Ganti titik jadi koma
        format('~w mendapatkan 1 kartu penalti secara acak.~n', [Penangkap]),
        
        ambilKartu(Penangkap, 1),
        gantiGiliran
    ). 

/* helper menggantikan length untuk menghitung isi list */
hitungKartu([], 0).

hitungKartu([_ | Tail], Jumlah) :-
    hitungKartu(Tail, Sisa),
    Jumlah is Sisa + 1.

/* helper status aman uni */
tandaiAman(Pemain) :-
    statusUni(Pemain), !.
tandaiAman(Pemain) :-
    assertz(statusUni(Pemain)).