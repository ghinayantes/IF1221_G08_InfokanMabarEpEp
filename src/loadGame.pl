loadGame :-
    write('Masukkan nama file yang akan dimuat: '),
    read(InputFile), 
    
    gabungAtomManual(InputFile, '.txt', NamaFile),
    
    (   file_exists(NamaFile) ->
        prosesLoadData(NamaFile)
    ;   
        format('Gagal! File ~w tidak ditemukan di direktori.~n', [NamaFile])
    ).

prosesLoadData(NamaFile) :-
    hapusDataLama,
    
    retractall(kartuTerhidden(_, _)),
    retractall(kartu_aksi_terakhir(_, _, _)),
    
    open(NamaFile, read, Stream),
    bacaIsiFile(Stream),
    close(Stream),
    
    giliranSekarang(Pemain),
    
    format('Status permainan berhasil dimuat dari ~w.~n', [NamaFile]),
    format('Melanjutkan giliran ~w.~n', [Pemain]).

/* helper looping membaca file baris per baris sampai habis (end_of_file) */
bacaIsiFile(Stream) :-
    read(Stream, Data),
    (   Data == end_of_file -> 
        true
    ;   
        tafsirData(Data), 
        bacaIsiFile(Stream)
    ).

%bonus mimic card
%ubah format file ke dynamic
tafsirData(urutan_pemain:UP)     :- !, assertz(urutanPemain(UP)).
tafsirData(giliran:GS)           :- !, assertz(giliranSekarang(GS)).
tafsirData(warna_aktif:WA)       :- !, assertz(warnaAktif(WA)).
tafsirData(arah_permainan:AP)    :- !, assertz(arahPermainan(AP)).
tafsirData(status_UNI:SU)        :- !, assertz(statusUni(SU)).
tafsirData(status_ancaman:SA)    :- !, assertz(statusAncaman(SA)).
tafsirData(warna_sebelumnya:WS)  :- !, assertz(warnaSebelumnya(WS)).
tafsirData(jenis_sebelumnya:JS)  :- !, assertz(jenisSebelumnya(JS)).
tafsirData(pemain_sebelumnya:PS) :- !, assertz(pemainSebelumnya(PS)).

tafsirData(discard_top:Warna-Jenis) :- !, 
    assertz(kartuTeratas(kartu(Warna, Jenis))).

tafsirData(kartu(Pemain):ListKartu) :- !, 
    assertz(kartuTangan(Pemain, ListKartu)).

tafsirData(kartu_tersembunyi(Pemain):ListHidden) :- !,
    memulihkanKartuHidden(Pemain, ListHidden).

tafsirData(kartu_aksi_terakhir:none) :- !.
tafsirData(kartu_aksi_terakhir:Kartu-PemainLama-GiliranLama) :- !,
    assertz(kartu_aksi_terakhir(Kartu, PemainLama, GiliranLama)).

%bonus sembunyikan kartu
memulihkanKartuHidden(_, []).
memulihkanKartuHidden(Pemain, [Kartu|Sisa]) :-
    assertz(kartuTerhidden(Pemain, Kartu)),
    memulihkanKartuHidden(Pemain, Sisa).
