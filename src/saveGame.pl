:- dynamic(penampungKartuTersembunyi/1).

saveGame :- 
    giliranSekarang(_),
    write('Masukkan nama file penyimpanan: '), read (InputFile), nl,
    gabungAtomManual(InputFile, '.txt', NamaFile),
    open(NamaFile, write, Stream),
    set_output(Stream),

    giliranSekarang(GS),
    kartuTeratas(KT),
    warnaAktif(WA),
    arahPermainan(AP),
    urutanPemain(UP),
    statusUni(SU),
    statusAncaman(SA),
    warnaSebelumnya(WS),
    jenisSebelumnya(JS),
    pemainSebelumnya(PS),

    format('urutan_pemain:~q.~n', [UP]),
    format('giliran:~q.~n', [GS]),
    write('discard_top:'), cetakKartu(KT), write('.'), nl, 
    format('warna_aktif:~w.~n', [WA]),
    format('arah_permainan:~w.~n', [AP]),
    format('status_UNI:~q.~n', [SU]),
    format('status_ancaman:~w.~n', [SA]),
    format('warna_sebelumnya:~w.~n', [WS]),
    format('jenis_sebelumnya:~w.~n', [JS]),
    format('pemain_Sebelumnya:~q.~n', [PS]),
    
    SemuaKartuPemain(UP),
    %bonus kartu tersembunyi
    SemuaKartuTersembunyi(UP),

    %bonus mimic card
    (kartu_aksi_terakhir(KartuAksi, PemainLama, GiliranLama) ->
        format('kartu_aksi_terakhir(~w, ~q, ~w).~n', [KartuAksi, PemainLama, GiliranLama])
    ;   
        format('kartu_aksi_terakhir:tidak ada kartu aksi yang dimainkan.~n', [])
    ),

    close(Stream),
    set_output(user_output),
    format('Status permainan berhasil disimpan ke ~w.~n', [NamaFile]).

SemuaKartuPemain([]).
SemuaKartuPemain([H|T]):-
    kartuTangan(H, ListKartu),
    format('kartu(~q):', [H]),
    write('['),
    tampilkanKartu(ListKartu),
    write('].'), nl,
    SemuaKartuPemain(T).

%bonus kartu tersembunyi
SemuaKartuTersembunyi([]).
SemuaKartuTersembunyi([H|T]) :- 
    kumpulkanKartuTersembunyi(H),
    masukkanKeList(ListHidden),

    format('kartu_tersembunyi ~q:', [H]),
    write('['),
    tampilkanKartu(ListHidden),
    write('].'), nl,
    SemuaKartuTersembunyi(T).

kumpulkanKartuTersembunyi(Pemain) :- 
    kartuTerhidden(Pemain, Kartu),
    assertz(penampungKartuTersembunyi(Kartu)), fail.
    kumpulkanKartuTersembunyi(_).

masukkanKeList([H|T]) :- 
    retract(penampungKartuTersembunyi(H)), !,
    masukkanKeList(T).
masukkanKeList([]).

tampilkanKartu([]).
tampilkanKartu([H|T]) :- !,
    cetakKartu(H),
    tampilkanSisaKartu(T).

tampilkanSisaKartu([]).
tampilkanSisaKartu([H|T]) :- !,
    write(','),            
    cetakKartu(H),
    tampilkanSisaKartu(T).