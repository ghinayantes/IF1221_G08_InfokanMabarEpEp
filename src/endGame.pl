/* Nilai kartu */
hitungNilaiKartu(kartu(_, angka(N)), N).
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
nth1Manual(1, [H|_], H).

nth1Manual(N, [_|T], X) :-
    N > 1,
    N1 is N - 1,
    nth1Manual(N1, T, X).

nth1Manual(_, [], _) :-
    fail.

/* Data pemain */

dataPemain(Player, data(Player, Poin, JumlahKartu, Urutan)) :-
    kartuTangan(Player, Tangan),
    hitungTotalPoin(Tangan, Poin),
    hitungJumlahKartu(Tangan, JumlahKartu),
    urutanPemain(ListUrutan),
    nth1Manual(Urutan, ListUrutan, Player).

/* Kumpulkan data pemain */
semuaDataPemain(Hasil) :-
    urutanPemain(ListPemain),
    kumpulkanDataPemain(ListPemain, Hasil).

kumpulkanDataPemain([], []).

kumpulkanDataPemain([P|Sisa], [Data|SisaData]) :-
    dataPemain(P, Data),
    kumpulkanDataPemain(Sisa, SisaData).

/* Compare ranking */
comparePeringkat(Result,
    data(_, P1, J1, U1),
    data(_, P2, J2, U2)) :-

    (
        P1 < P2 -> Result = '<'
    ;   P1 > P2 -> Result = '>'
    ;   J1 < J2 -> Result = '<'
    ;   J1 > J2 -> Result = '>'
    ;   U1 < U2 -> Result = '<'
    ;   Result = '>'
    ).

/* Sorting manual */
harusTukar(A, B) :-
    comparePeringkat('>', A, B).

insertSorted(X, [], [X]).

insertSorted(X, [H|T], [X,H|T]) :-
    harusTukar(X, H).

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

/* Cetak kartu menjadi format warna-isi */
cetakKartu(kartu(Warna, angka(N))) :-
    write(Warna), write('-'), write(N).

cetakKartu(kartu(Warna, skip)) :-
    write(Warna), write('-skip').

cetakKartu(kartu(Warna, reverse)) :-
    write(Warna), write('-reverse').

cetakKartu(kartu(Warna, drawTwo)) :-
    write(Warna), write('-drawTwo').

cetakKartu(kartu(Warna, wild)) :-
    write(Warna), write('-wild').

cetakKartu(kartu(Warna, wildDrawFour)) :-
    write(Warna), write('-wildDrawFour').


/* Cetak perhitungan poin */
cetakPerhitungan([], 0).

cetakPerhitungan([K], Total) :-
    cetakKartu(K),
    hitungNilaiKartu(K, Nilai),
    write(' = '),
    write(Nilai),
    Total is Nilai.

cetakPerhitungan([K|Sisa], Total) :-
    cetakKartu(K),
    hitungNilaiKartu(K, Nilai),
    write(' = '),
    write(Nilai),
    write(' + '),

    cetakPerhitungan(Sisa, TotalSisa),
    Total is Nilai + TotalSisa.


/* Cari pemain dengan kartu habis */
pemainMenang(Pemain) :-
    kartuTangan(Pemain, []).


/* Tampilkan detail poin tiap pemain */
tampilkanPoinPemain([]).

tampilkanPoinPemain([P|Sisa]) :-
    write(P), write(': '),
    kartuTangan(P, Tangan),
    (Tangan = []-> write('kartu habis = 0 poin') ;
        cetakPerhitungan(Tangan, Total),
        write(' = '),
        write(Total),
        write(' poin')),
    nl,
    tampilkanPoinPemain(Sisa).

/* END GAME */
endGame :-
    pemainMenang(Pemenang),
    nl,
    write('Permainan selesai! '),
    write(Pemenang),
    write(' menghabiskan semua kartunya!'),
    nl, nl,
    write('Berikut perhitungan poin sisa kartu.'), nl,

    urutanPemain(ListPemain),
    tampilkanPoinPemain(ListPemain),nl,
    semuaDataPemain(Data),
    urutkanRanking(Data, HasilUrut),

    write('Urutan pemenang:'), nl,
    tampilkanRanking(HasilUrut), nl,
    write('Selamat, '),
    write(Pemenang),
    write(' menjadi pemenang!'),
    nl.


