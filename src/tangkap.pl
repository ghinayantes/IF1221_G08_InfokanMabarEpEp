tangkap(Target) :-
    giliranSekarang(Penangkap),
    kartuTangan(Target, TanganTarget),
    hitungKartu(TanganTarget, JumlahTarget),

    % Cek apakah target punya kartu tersembunyi
    (kartuTersembunyi(Target, _) ->
        /* Target punya kartu tersembunyi → tangkapan tidak valid */
        format('Terdapat kartu yang disembunyikan oleh ~w.~n', [Target]),
        write('Perintah tangkap tidak valid. '),
        format('~w mendapatkan 1 kartu penalti.~n', [Penangkap]),
        ambilKartu(Penangkap, 1),
        gantiGiliran
    ;
        (JumlahTarget =:= 1, \+ statusUni(Target) ->
            /* Target ketahuan tidak menyerukan UNI */
            format('~w tertangkap tidak menyerukan UNI.~n', [Target]),
            format('~w mendapatkan 2 kartu penalti.~n', [Target]),
            ambilKartu(Target, 2),
            gantiGiliran
        ;
            /* Tuduhan salah (kartu > 1 atau sudah teriak UNI) */
            write('Tuduhan salah! Target tidak melanggar aturan.'), nl,
            format('~w mendapatkan 1 kartu penalti secara acak.~n', [Penangkap]),
            ambilKartu(Penangkap, 1),
            gantiGiliran
        )
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