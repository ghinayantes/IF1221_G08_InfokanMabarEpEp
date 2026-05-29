saveGame :-
    statusAncaman(aktif), !,
    write('Tidak dapat menyimpan saat terkena efek Wild Draw Four.'), nl,
    write('Pilih perintah: "tantang." atau "ambilKartu." terlebih dahulu.'), nl.

saveGame :-
    giliranSekarang(_), !,
    write('Masukkan nama file penyimpanan: '),
    read(InputFile), nl,
    gabungAtomManual(InputFile, '.txt', NamaFile),

    open(NamaFile, write, Stream),

    % Simpan mode permainan dan data tim jika turnamen
    (modeTurnamen -> format(Stream, 'mode:turnamen.~n', []),
        tim1(Tim1), tim2(Tim2),
        format(Stream, 'tim1:~q.~n', [Tim1]),
        format(Stream, 'tim2:~q.~n', [Tim2]) ;
        format(Stream, 'mode:klasik.~n', [])),

    urutanPemain(UP),
    giliranSekarang(GS),
    kartuTeratas(KT),
    warnaAktif(WA),
    arahPermainan(AP),
    statusUni(SU),

    (statusAncaman(SA)    -> true ; SA = aman),
    (warnaSebelumnya(WS)  -> true ; WS = none),
    (jenisSebelumnya(JS)  -> true ; JS = none),
    (pemainSebelumnya(PS) -> true ; PS = none),

    format(Stream, 'urutan_pemain:~q.~n', [UP]),
    format(Stream, 'giliran:~q.~n', [GS]),

    KT = kartu(KW, KJ),
    (KJ = angka(KN) -> format(Stream, 'discard_top:~w-angka(~w).~n', [KW, KN]) ;
        format(Stream, 'discard_top:~w-~w.~n', [KW, KJ])),

    format(Stream, 'warna_aktif:~w.~n', [WA]),
    format(Stream, 'arah_permainan:~w.~n', [AP]),
    format(Stream, 'status_UNI:~q.~n', [SU]),
    format(Stream, 'status_ancaman:~w.~n', [SA]),
    format(Stream, 'warna_sebelumnya:~w.~n', [WS]),
    format(Stream, 'jenis_sebelumnya:~w.~n', [JS]),
    format(Stream, 'pemain_sebelumnya:~q.~n', [PS]),

    simpanKartuPemain(Stream, UP),
    simpanKartuTersembunyi(Stream, UP),

    % Simpan kartu aksi terakhir untuk mimic card
    (kartuAksiTerakhir(KA, KAPemain, KAGiliran) -> KA = kartu(KAW, KAJ),
        format(Stream, 'kartu_aksi_terakhir:~w-~w-~q-~w.~n', [KAW, KAJ, KAPemain, KAGiliran]) ;
        format(Stream, 'kartu_aksi_terakhir:none.~n', [])),

    % Simpan sisa deck 
    sisaDeck(SD),
    format(Stream, 'sisa_deck:[', []),
    tulisListKartu(Stream, SD),
    format(Stream, '].~n', []),

    close(Stream),
    format('Status permainan berhasil disimpan ke ~w.~n', [NamaFile]).

saveGame :-
    write('Tidak ada permainan yang sedang berjalan.'), nl.

/* Tulis kartu tangan tiap pemain */
simpanKartuPemain(_, []).
simpanKartuPemain(Stream, [P|T]) :-
    kartuTangan(P, ListKartu),
    format(Stream, 'kartu(~q):[', [P]),
    tulisListKartu(Stream, ListKartu),
    format(Stream, '].~n', []),
    simpanKartuPemain(Stream, T).

tulisListKartu(_, []).
tulisListKartu(Stream, [K]) :- !,
    tulisKartuAtom(Stream, K).
tulisListKartu(Stream, [K|T]) :-
    tulisKartuAtom(Stream, K),
    write(Stream, ','),
    tulisListKartu(Stream, T).

tulisKartuAtom(Stream, kartu(W, angka(N))) :- !,
    format(Stream, '~w-angka(~w)', [W, N]).
tulisKartuAtom(Stream, kartu(W, J)) :-
    format(Stream, '~w-~w', [W, J]).

/* Tulis indeks kartu tersembunyi tiap pemain */
simpanKartuTersembunyi(_, []).
simpanKartuTersembunyi(Stream, [P|T]) :-
    kumpulkanIndeksTersembunyi(P, Indeks),
    format(Stream, 'tersembunyi(~q):~q.~n', [P, Indeks]),
    simpanKartuTersembunyi(Stream, T).