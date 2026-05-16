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


tentukanSelanjutnya(kanan, Sekarang, ListPemain, Next) :-
    append(_, [Sekarang, Next|_], ListPemain), !.

tentukanSelanjutnya(kanan, _, ListPemain, Next) :-
    ListPemain = [Next|_], !. 

tentukanSelanjutnya(kiri, Sekarang, ListPemain, Next) :-
    append(_, [Next, Sekarang|_], ListPemain), !.

tentukanSelanjutnya(kiri, Sekarang, ListPemain, Next) :-
    ListPemain = [Sekarang|_], 
    last(ListPemain, Next), !.
