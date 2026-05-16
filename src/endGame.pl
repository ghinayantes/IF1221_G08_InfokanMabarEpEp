/* Menghitung nilai kartu */
hitungNilaiKartu(kartu(_, angka(N)), N).

hitungNilaiKartu(kartu(_, skip), 10).
hitungNilaiKartu(kartu(_, reverse), 10).
hitungNilaiKartu(kartu(_, drawTwo), 10).

hitungNilaiKartu(kartu(_, wild), 20).
hitungNilaiKartu(kartu(_, wildDrawFour), 20).


/* Menghitung total poin tangan */
hitungTotalPoin([], 0).

hitungTotalPoin([K|Sisa], Total) :-
    hitungNilaiKartu(K, Nilai),
    hitungTotalPoin(Sisa, TotalSisa),
    Total is Nilai + TotalSisa.

/* Menampilkan perhitungan pemain */
tampilkanPerhitunganPemain(Player) :-
    kartuTangan(Player, []),
    format('~w: kartu habis = 0 poin~n~n', [Player]).

tampilkanPerhitunganPemain(Player) :-
    kartuTangan(Player, Hand),
    Hand \= [],
    format('~w: ', [Player]),
    tampilkanListKartu(Hand),
    write(' = '),
    tampilkanListNilai(Hand),
    hitungTotalPoin(Hand, Total),
    format(' = ~w poin~n~n', [Total]).

/* Menampilkan list kartu */
tampilkanListKartu([Kartu]) :-
    cetakKartu(Kartu).

tampilkanListKartu([Kartu|Sisa]) :-
    cetakKartu(Kartu),
    write(' + '),
    tampilkanListKartu(Sisa).

/* Menampilkan list nilai kartu */
tampilkanListNilai([Kartu]) :-
    hitungNilaiKartu(Kartu, Nilai),
    write(Nilai).

tampilkanListNilai([Kartu|Sisa]) :-
    hitungNilaiKartu(Kartu, Nilai),
    write(Nilai),
    write(' + '),
    tampilkanListNilai(Sisa).

/* Data pemain untuk ranking */
dataPemain(Player, data(Player, Poin, JumlahKartu, Urutan)) :-
    kartuTangan(Player, Tangan),
    hitungTotalPoin(Tangan, Poin),
    length(Tangan, JumlahKartu),
    urutanPemain(ListUrutan),
    nth1(Urutan, ListUrutan, Player).


/* Mengambil semua data pemain */
semuaDataPemain(Hasil) :-
    urutanPemain(ListPemain),
    findall(Data,(member(P, ListPemain), dataPemain(P, Data)), Hasil).


/* Pembanding ranking */
comparePeringkat(Result, data(_, Poin1, JumlahKartu1, Urutan1), data(_, Poin2, JumlahKartu2, Urutan2)) :- 
    (  Poin1 < Poin2 -> Result = '<';
       Poin1 > Poin2 -> Result = '>';
       JumlahKartu1 < JumlahKartu2 -> Result = '<';
       JumlahKartu1 > JumlahKartu2 -> Result = '>';
       Urutan1 < Urutan2 -> Result = '<';
       Result = '>'
    ).


/* Mengurutkan peringkat */
urutkanPeringkat(Input, Output) :-
    predsort(comparePeringkat, Input, Output).

/* Cetak ranking */
cetakPeringkat([], _).

cetakPeringkat([data(Nama, Poin, _, _)|Sisa], No) :-
    format('~w. ~w (~w poin)~n', [No, Nama, Poin]),
    NoBaru is No + 1,
    cetakPeringkat(Sisa, NoBaru).

/* Cek pemain menang (habis kartu) */
pemainMenang(Player) :-
    kartuTangan(Player, []).

/* Menampilkan semua perhitungan */
tampilkanSemuaPerhitungan([]).

tampilkanSemuaPerhitungan([P|Sisa]) :-
    tampilkanPerhitunganPemain(P),
    tampilkanSemuaPerhitungan(Sisa).


/* =========================
         END GAME
   ========================= */

endGame :-
    pemainMenang(Pemenang),

    nl,
    format('Permainan selesai! ~w menghabiskan semua kartunya!~n', [Pemenang]),

    nl,
    write('Berikut perhitungan poin sisa kartu.'), nl, nl,

    urutanPemain(ListPemain),
    tampilkanSemuaPerhitungan(ListPemain),

    semuaDataPemain(Data),
    urutkanPeringkat(Data, DataUrut),

    nl,
    write('Urutan pemenang:'), nl, nl,

    cetakPeringkat(DataUrut, 1),

    nl,
    format('Selamat, ~w menjadi pemenang!~n', [Pemenang]),
    !.
  

