loadGame :- 
    giliranSekarang(_), !, 
    write('Permainan sedang berjalan, simpan permainan saat ini? (y/n): '), 
    read(Pilihan), nl,
    ((Pilihan == yes ; Pilihan == 'y') -> saveGame,
        nl, write('Melanjutkan ke proses pemuatan game...'), nl,
        loadGame_Aksi ; (Pilihan == no ; Pilihan == 'n') -> write('Melanjutkan tanpa menyimpan...'), nl,
        loadGame_Aksi ; write('Pilihan tidak valid! Masukkan "y." atau "n."'), nl,
        loadGame).

loadGame :-
    loadGame_Aksi.

loadGame_Aksi :-
    write('Masukkan nama file yang akan dimuat: '),
    read(InputFile),
    gabungAtomManual(InputFile, '.txt', NamaFile),
    (file_exists(NamaFile) -> prosesLoadData(NamaFile) ; format('Gagal! File ~w tidak ditemukan di direktori.~n', [NamaFile])).

prosesLoadData(NamaFile) :-
    hapusDataLama,
    % catch untuk file corrupt
    catch((open(NamaFile, read, Stream),
            bacaIsiFile(Stream),
            close(Stream)),
        _Error,
        (write('File rusak atau format tidak valid. Load dibatalkan.'), nl,
            fail)),
    (sisaDeck(_) -> true ; assertz(sisaDeck([]))),
    % Fallback jika file klasik tidak punya data mode 
    (modeTurnamen -> true ; true),
    giliranSekarang(Pemain),
    format('Status permainan berhasil dimuat dari ~w.~n', [NamaFile]),
    format('Melanjutkan giliran ~w.~n', [Pemain]).

/* Baca term satu per satu sampai end_of_file */
bacaIsiFile(Stream) :-
    read(Stream, Data),
    (   Data == end_of_file -> true ;
        tafsirData(Data),
        bacaIsiFile(Stream)).

/* Penafsiran setiap baris term dalam file */
tafsirData(mode:turnamen)        :- !, assertz(modeTurnamen).
tafsirData(mode:klasik)          :- !.
tafsirData(tim1:T1)              :- !, assertz(tim1(T1)).
tafsirData(tim2:T2)              :- !, assertz(tim2(T2)).
tafsirData(urutan_pemain:UP)     :- !, assertz(urutanPemain(UP)).
tafsirData(giliran:GS)           :- !, assertz(giliranSekarang(GS)).
tafsirData(warna_aktif:WA)       :- !, assertz(warnaAktif(WA)).
tafsirData(arah_permainan:AP)    :- !, assertz(arahPermainan(AP)).
tafsirData(status_UNI:SU)        :- !, assertz(statusUni(SU)).
tafsirData(status_ancaman:SA)    :- !, assertz(statusAncaman(SA)).
tafsirData(warna_sebelumnya:WS)  :- !, assertz(warnaSebelumnya(WS)).
tafsirData(jenis_sebelumnya:JS)  :- !, assertz(jenisSebelumnya(JS)).
tafsirData(pemain_sebelumnya:PS) :- !, assertz(pemainSebelumnya(PS)).
tafsirData(discard_top:W-angka(N)) :- !,
    assertz(kartuTeratas(kartu(W, angka(N)))).
tafsirData(discard_top:W-J) :- !,
    assertz(kartuTeratas(kartu(W, J))).
tafsirData(kartu(P):ListAtom) :- !,
    konversiListKartu(ListAtom, ListKartu),
    assertz(kartuTangan(P, ListKartu)).
tafsirData(sisa_deck:ListAtom) :- !,
    konversiListKartu(ListAtom, ListKartu),
    assertz(sisaDeck(ListKartu)).
tafsirData(kartu_aksi_terakhir:none) :- !.
tafsirData(kartu_aksi_terakhir:W-angka(N)-P-G) :- !,
    assertz(kartuAksiTerakhir(kartu(W, angka(N)), P, G)).
tafsirData(kartu_aksi_terakhir:W-J-P-G) :- !,
    assertz(kartuAksiTerakhir(kartu(W, J), P, G)).
tafsirData(tersembunyi(P):Indeks) :- !,
    assertIndeksTersembunyi(P, Indeks).
tafsirData(_).

/* Konversi list atom Warna-angka(N)/Warna-Jenis ke list kartu/2 */
konversiListKartu([], []).
konversiListKartu([W-angka(N)|T], [kartu(W, angka(N))|TC]) :- !,
    konversiListKartu(T, TC).
konversiListKartu([W-J|T], [kartu(W, J)|TC]) :-
    konversiListKartu(T, TC).

/* Pulihkan indeks kartu tersembunyi */
assertIndeksTersembunyi(_, []).
assertIndeksTersembunyi(P, [I|T]) :-
    assertz(kartuTersembunyi(P, I)),
    assertIndeksTersembunyi(P, T).

/* Helper atom string */
gabungAtomManual(Atom1, Atom2, HasilAtom) :-
    name(Atom1, List1),
    name(Atom2, List2),
    gabungListManual(List1, List2, HasilList),
    name(HasilAtom, HasilList).

gabungListManual([], List, List).
gabungListManual([Head|Tail], List, [Head|HasilTail]) :-
    gabungListManual(Tail, List, HasilTail).