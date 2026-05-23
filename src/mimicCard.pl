efekMimic(mimic) :-
    write('Menelusuri riwayat permainan...'), nl, nl,
    
    (   kartu_aksi_terakhir(kartu(WarnaAksi, JenisAksi), PemainLama, GiliranLama) ->
        
        giliranSekarang(Sekarang), 
        Selisih is Sekarang - GiliranLama,
        
        format('Kartu aksi terakhir yang dimainkan: ~w-~w (oleh ~w, ~w giliran lalu)~n', [WarnaAksi, JenisAksi, PemainLama, Selisih]),
        format('Kartu mimic menyalin efek ~w!~n', [JenisAksi]),
        
        /* jika wild/wildDrawFour, dari fungsi aslinya sudah ada "read(WarnaBaru)" */
        /* jika efek aksi berwarna, minta warna manual dulu, baru eksekusi efek */
        (   (JenisAksi == wild ; JenisAksi == wildDrawFour) ->
            eksekusiEfek(JenisAksi)
        ;   
            pilihWarnaMimic,
            eksekusiEfek(JenisAksi)
        )
        
    ;   /* gaada kartu aksi samsek */
        write('Belum ada kartu aksi yang dimainkan sebelumnya.'), nl,
        write('Kartu mimic berlaku seperti wild biasa!'), nl,
        eksekusiEfek(wild)
    ).

/* helperpilih warna (jika menyalin Skip/Reverse/DrawTwo) */
pilihWarnaMimic :-
    write('Pilih warna (merah, kuning, hijau, biru): '), nl, read(WarnaBaru),
    (   member(WarnaBaru, [merah, kuning, hijau, biru]) ->
        retract(warnaAktif(_)),
        assertz(warnaAktif(WarnaBaru)),
        format('Warna aktif sekarang: ~w.~n', [WarnaBaru])
    ;   
        write('Warna tidak valid! Pilih kembali.'), nl,
        pilihWarnaMimic
    ).
