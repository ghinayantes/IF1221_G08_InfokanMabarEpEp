/* Nilai kartu */
hitungNilaiKartu(kartu(_, angka(N)), N) :- !.
hitungNilaiKartu(kartu(_, skip), 10).
hitungNilaiKartu(kartu(_, reverse), 10).
hitungNilaiKartu(kartu(_, drawTwo), 10).
hitungNilaiKartu(kartu(_, wild), 20).
hitungNilaiKartu(kartu(_, wildDrawFour), 20).

/* Hitung total poin */
hitungTotalPoin([], 0).
hitungTotalPoin([K|Sisa], Total) :-
    hitungNilaiKartu(K, Nilai),
    hitungTotalPoin(Sisa, TotalSisa),
    Total is Nilai + TotalSisa.

/* Hitung jumlah kartu */
hitungJumlahKartu([], 0).
hitungJumlahKartu([_|Sisa], Jumlah) :-
    hitungJumlahKartu(Sisa, JmlSisa),
    Jumlah is JmlSisa + 1.

/* nth1 manual */
nth1Manual(1, [H|_], H) :- !.
nth1Manual(N, [_|T], X) :-
    N > 1,
    N1 is N - 1,
    nth1Manual(N1, T, X).
nth1Manual(_, [], _) :- fail.

/* cariIndeks: cari posisi (1-based) suatu elemen dalam list */
cariIndeks(Elem, [Elem|_], 1) :- !.
cariIndeks(Elem, [_|Sisa], N) :-
    cariIndeks(Elem, Sisa, N1),
    N is N1 + 1.

/* Data pemain */
dataPemain(Player, data(Player, Poin, JumlahKartu, Urutan)) :-
    kartuTangan(Player, Tangan),
    hitungTotalPoin(Tangan, Poin),
    hitungJumlahKartu(Tangan, JumlahKartu),
    urutanPemain(ListUrutan),
    cariIndeks(Player, ListUrutan, Urutan).

/* Kumpulkan data pemain */
semuaDataPemain(Hasil) :-
    urutanPemain(ListPemain),
    kumpulkanDataPemain(ListPemain, Hasil).

kumpulkanDataPemain([], []).
kumpulkanDataPemain([P|Sisa], [Data|SisaData]) :-
    dataPemain(P, Data),
    kumpulkanDataPemain(Sisa, SisaData).

/* Compare ranking */
comparePeringkat('<', data(_, P1, _, _), data(_, P2, _, _)) :- 
    P1 < P2, !.
comparePeringkat('>', data(_, P1, _, _), data(_, P2, _, _)) :- 
    P1 > P2, !.

comparePeringkat('<', data(_, _, J1, _), data(_, _, J2, _)) :- 
    J1 < J2, !.
comparePeringkat('>', data(_, _, J1, _), data(_, _, J2, _)) :- 
    J1 > J2, !.

comparePeringkat('<', data(_, _, _, U1), data(_, _, _, U2)) :- 
    U1 < U2, !.
comparePeringkat('>', _, _).

/* Sorting manual */
harusTukar(A, B) :-
    comparePeringkat('>', A, B).

insertSorted(X, [], [X]).
insertSorted(X, [H|T], [X,H|T]) :-
    harusTukar(X, H), !.
insertSorted(X, [H|T], [H|R]) :-
    \+ harusTukar(X, H),
    insertSorted(X, T, R).

sortManual([], []).
sortManual([H|T], Sorted) :-
    sortManual(T, SortedT),
    insertSorted(H, SortedT, Sorted).

urutkanRanking(Data, HasilUrut) :-
    sortManual(Data, HasilUrut).

/* Cetak ranking */
cetakPeringkat([], _).
cetakPeringkat([data(Nama, Poin, _, _)|Sisa], No) :-
    write(No), write('. '),
    write(Nama),
    write(' ('), write(Poin), write(' poin)'), nl,
    NoBaru is No + 1,
    cetakPeringkat(Sisa, NoBaru).

tampilkanRanking(HasilUrut) :-
    cetakPeringkat(HasilUrut, 1).

/* Cetak nama-nama kartu dipisah ' + ' */
cetakNamaKartu([K]) :- !,
    cetakKartu(K).
cetakNamaKartu([K|Sisa]) :-
    cetakKartu(K),
    write(' + '),
    cetakNamaKartu(Sisa).

/* Cetak nilai-nilai kartu dipisah ' + ' */
cetakNilaiKartu([K]) :- !,
    hitungNilaiKartu(K, Nilai),
    write(Nilai).
cetakNilaiKartu([K|Sisa]) :-
    hitungNilaiKartu(K, Nilai),
    write(Nilai),
    write(' + '),
    cetakNilaiKartu(Sisa).

/* Cari pemain dengan kartu habis */
pemainMenang(Pemain) :-
    kartuTangan(Pemain, []).

/* Tampilkan detail poin tiap pemain */
tampilkanPoinPemain([]).
tampilkanPoinPemain([P|Sisa]) :-
    format('~w: ', [P]),
    kartuTangan(P, Tangan),
    (Tangan == [] ->
        write('kartu habis = 0 poin')
    ;
        cetakNamaKartu(Tangan),
        write(' = '),
        cetakNilaiKartu(Tangan),
        hitungTotalPoin(Tangan, Total),
        format(' = ~w poin', [Total])
    ),
    nl,
    tampilkanPoinPemain(Sisa).

endGame :-
    pemainMenang(Pemenang),
    nl,
    format('Permainan selesai! ~w menghabiskan semua kartunya!~n~n', [Pemenang]),
    write('Berikut perhitungan poin sisa kartu.'), nl,

    urutanPemain(ListPemain),
    tampilkanPoinPemain(ListPemain), nl,
    semuaDataPemain(Data),
    urutkanRanking(Data, HasilUrut),

    write('Urutan pemenang:'), nl,
    tampilkanRanking(HasilUrut), nl,
    format('Selamat, ~w menjadi pemenang!~n', [Pemenang]).