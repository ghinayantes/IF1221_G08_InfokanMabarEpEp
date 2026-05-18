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
    bersihkanStateLama,
    
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
        assertz(Data), 
        bacaIsiFile(Stream)
    ).

/* helper membersihkan semua fakta lama sebelum ditimpa data save-an */
bersihkanStateLama :-
    retractall(urutanPemain(_)),
    retractall(kartuTangan(_, _)),
    retractall(kartuTeratas(_)),
    retractall(giliranSekarang(_)),
    retractall(arahPermainan(_)),
    retractall(warnaAktif(_)),
    retractall(statusAncaman(_)),
    retractall(warnaSebelumnya(_)),
    retractall(jenisSebelumnya(_)),
    retractall(pemainSebelumnya(_)),
    retractall(statusUni(_)).

/* ubah ke txt manual tanpa atomconcat */
gabungAtomManual(Atom1, Atom2, HasilAtom) :-
    name(Atom1, List1),                   % ubah input pemain jadi list ASCII
    name(Atom2, List2),                   % ubah '.txt' jadi list ASCII
    gabungListManual(List1, List2, HasilList),  % gabungkan list secara manual
    name(HasilAtom, HasilList).

/* helper pengganti append/3 untuk list */
gabungListManual([], List, List).
gabungListManual([Head | Tail], List, [Head | HasilTail]) :-
    gabungListManual(Tail, List, HasilTail).
