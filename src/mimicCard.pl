efekMimic(mimic) :-
    write('Menelusuri riwayat permainan...'), nl, nl,

    (   kartuAksiTerakhir(kartu(WarnaAksi, JenisAksi), PemainLama, GiliranLama) ->

        % counterGiliran berisi angka; hitung selisih giliran dengan aman
        (counterGiliran(Sekarang) -> true ; Sekarang = 0),
        Selisih is Sekarang - GiliranLama,

        format('Kartu aksi terakhir yang dimainkan: ~w-~w (oleh ~w, ~w giliran lalu)~n',
               [WarnaAksi, JenisAksi, PemainLama, Selisih]),
        format('Kartu mimic menyalin efek ~w!~n', [JenisAksi]),

        (   (JenisAksi == wild ; JenisAksi == wildDrawFour) ->
            eksekusiEfek(JenisAksi)
        ;
            /* skip/reverse/drawTwo: minta warna dulu, baru eksekusi */
            pilihWarnaMimic,
            eksekusiEfek(JenisAksi)
        )

    ;   /* belum ada kartu aksi sama sekali */
        write('Belum ada kartu aksi yang dimainkan sebelumnya.'), nl,
        write('Kartu mimic berlaku seperti wild biasa!'), nl,
        eksekusiEfek(wild)
    ).

/* helper pilih warna (jika menyalin Skip/Reverse/DrawTwo) */
pilihWarnaMimic :-
    write('Pilih warna (merah, kuning, hijau, biru): '), nl,
    read(WarnaBaru),
    (   isMember(WarnaBaru, [merah, kuning, hijau, biru]) ->   % BUG FIX: member -> isMember
        retract(warnaAktif(_)),
        asserta(warnaAktif(WarnaBaru)),
        format('Warna aktif sekarang: ~w.~n', [WarnaBaru])
    ;
        write('Warna tidak valid! Pilih kembali.'), nl,
        pilihWarnaMimic
    ).