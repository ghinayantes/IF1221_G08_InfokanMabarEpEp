%bonus tantang------------------------------------------------
mainkanKartu(_) :- %jika sedang di tantang tidak bisa mainkan kartu
    statusAncaman(aktif),
    write('Anda sedang terkena efek Wild Draw Four!'), nl,
    write('Pilih perintah: "tantang." atau "ambilKartu."'), nl,
    !, fail. 
%------------------------------------------------------------

mainkanKartu(NomorUrut) :-
    giliranSekarang(Pemain),
    kartuTangan(Pemain, Tangan),
    
    nth1(NomorUrut, Tangan, KartuPilihan),
    KartuPilihan = kartu(Warna, Jenis),
    
    cekValid(Warna, Jenis),
    !,
    
    select(KartuPilihan, Tangan, SisaTangan),
    retract(kartuTangan(Pemain, _)),
    asserta(kartuTangan(Pemain, SisaTangan)),
    
    retract(kartuTeratas(_)),
    asserta(kartuTeratas(KartuPilihan)),

    %bonus tantang------------------------------------------------
    warnaAktif(WarnaLama),
    retractall(warnaSebelumnya(_)),
    asserta(warnaSebelumnya(WarnaLama)),
    retractall(pemainSebelumnya(_)),
    asserta(pemainSebelumnya(Pemain)),

    (Jenis==wildDrawFour -> retractall(statusAncaman(_)), asserta(statusAncaman(aktif))
                            ;
                            retractall(statusAncaman(_)), asserta(statusAncaman(aman))
                            ),
    %------------------------------------------------------------

    updateWarnaAktif(Warna),
    
    write('Berhasil memainkan: '), cetakKartu(KartuPilihan), nl,

    eksekusiEfek(Jenis).

mainkanKartu(_) :-
    write('Gagal memainkan. Nomor urut salah atau kartu tidak cocok dengan meja!'), nl.

/* helper syarat validasi kartu */
/* dilempar jika warnanya sama dengan warna aktif di meja */
cekValid(WarnaPilihan, _) :-
    warnaAktif(WarnaAktif),
    WarnaPilihan == WarnaAktif.

/* dilempar jika jenisnya (angka/simbol) sama dengan kartu di meja */
cekValid(_, JenisPilihan) :-
    kartuTeratas(kartu(_, JenisTop)),
    JenisPilihan == JenisTop.

/* dilempar jika itu kartu hitam (wild/wild draw four) */
cekValid(hitam, _).

/* helper update warna aktif */
/* Jika kartu hitam, jangan ubah warna meja di sini */
updateWarnaAktif(hitam) :- !.

/* jika bukan hitam, ubah warna meja sesuai kartu */
updateWarnaAktif(Warna) :-
    retract(warnaAktif(_)),
    asserta(warnaAktif(Warna)).

/* helper pindah giliran */
gantiGiliran :-
    urutanPemain(ListPemain), 
    giliranSekarang(Sekarang), 
    arahPermainan(Arah),

    tentukanSelanjutnya(Arah, Sekarang, ListPemain, Next),
    
    retract(giliranSekarang(_)),
    asserta(giliranSekarang(Next)),
    write('Giliran pindah ke: '), write(Next), nl.
    
/* main ke kanan, pemain masih di tengah urutan */
tentukanSelanjutnya(kanan, Sekarang, ListPemain, Next) :-
    sebelahKanan(Sekarang, Next, ListPemain), !.

/* main ke kanan, pemain di urutan terakhir */
tentukanSelanjutnya(kanan, _, ListPemain, Next) :-
    ListPemain = [Next|_], !.

/* main ke kiri, pemain masih di tengah urutan */
tentukanSelanjutnya(kiri, Sekarang, ListPemain, Next) :-
    sebelahKiri(Sekarang, Next, ListPemain), !.

/* main ke kiri, pemain di urutan pertama */
tentukanSelanjutnya(kiri, _, ListPemain, Next) :-
    cariTerakhir(ListPemain, Next), !.

/* helper pengganti append */
/* sebelahKanan: Next adalah elemen tepat setelah Sekarang */
sebelahKanan(Sekarang, Next, [Sekarang, Next | _]).
sebelahKanan(Sekarang, Next, [_ | Tail]) :- 
    sebelahKanan(Sekarang, Next, Tail).

/* sebelahKiri: Next adalah elemen tepat sebelum Sekarang */
sebelahKiri(Sekarang, Next, [Next, Sekarang | _]).
sebelahKiri(Sekarang, Next, [_ | Tail]) :- 
    sebelahKiri(Sekarang, Next, Tail).

/* cariTerakhir: mencari elemen paling ujung (terakhir) dari list */
cariTerakhir([X], X).
cariTerakhir([_ | Tail], Terakhir) :- 
    cariTerakhir(Tail, Terakhir).

%bonus tantang------------------------------------------------
tantang :- 
    statusAncaman(aktif), !, %ada yang tantang
    giliranSekarang(Penantang),
    pemainSebelumnya(Tertantang),
    warnaSebelumnya(WarnaLama),
    write('Tantangan dilakukan!'), nl,
    write('Memeriksa kartu '), write(Tertantang), write('...'), nl,

    kartuTangan(Tertantang, TanganTertantang), 
    (member(kartu(WarnaLama, _), TanganTertantang) -> %cek apakah kartu di meja ada di tangan tertantang
        %kartu di meja ada di tangan tertantang
        write('Tantangan berhasil! '), write(Tertantang), write(' mendapatkan 4 kartu.'), nl,
        ambilKartu(Tertantang, 4),
        retractall(statusAncaman(_)), 
        asserta(statusAncaman(aman))
    ;   %kartu di meja tidak ada di tangan tertantang
        format('Tantangan gagal. ~w mendapatkan 6 kartu acak. ~n', [Penantang]), 
        ambilKartu(Penantang, 6),
        retractall(statusAncaman(_)),
        asserta(statusAncaman(aman)),
        gantiGiliran
    ).
%tidak ada yang tantang
tantang :- write ('Tidak ada kartu Wild Draw Four yang bisa ditantang saat ini.'), nl.
%------------------------------------------------------------