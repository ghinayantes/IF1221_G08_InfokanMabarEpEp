%jika sedang ditantang tidak bisa mainkan kartu
mainkanKartu(_) :- 
    statusAncaman(aktif),
    write('Anda sedang terkena efek Wild Draw Four!'), nl,
    write('Pilih perintah: "tantang." atau "ambilKartu."'), nl,
    !, fail. 

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

    % Hapus indeks tersembunyi untuk kartu yang dimainkan, lalu geser indeks lebih besar
    updateIndeksTersembunyi(Pemain, NomorUrut),

    retract(kartuTeratas(_)),
    asserta(kartuTeratas(KartuPilihan)),

    % pengecekan kondisi apakah ada pemain yg sdh menghabiskan kartunya
    (SisaTangan == [] ->
        nl, endGame, ! 
    ;
        % jika tidak ada, lanjutkan alur permainan seperti biasa
        warnaAktif(WarnaLama),
        kartuTeratas(kartu(_, JenisLama)), 
        
        retractall(warnaSebelumnya(_)),
        asserta(warnaSebelumnya(WarnaLama)),
        retractall(jenisSebelumnya(_)),    
        asserta(jenisSebelumnya(JenisLama)), 
        
        retractall(pemainSebelumnya(_)),
        asserta(pemainSebelumnya(Pemain)),

        (Jenis == wildDrawFour -> retractall(statusAncaman(_)), 
        asserta(statusAncaman(aktif)) ; retractall(statusAncaman(_)), asserta(statusAncaman(aman))),

        updateWarnaAktif(Warna),
        format('~w memainkan kartu: ', [Pemain]), cetakKartu(KartuPilihan), write('.'), nl,

        %bonus mimic card
        (   (Jenis = skip ; Jenis = reverse ; Jenis = drawTwo ; Jenis = wild ; Jenis = wildDrawFour) ->
            updateAksiTerakhir(KartuPilihan)
        ;   
            true % Jika kartu angka biasa, lewati saja tanpa mencatat aksi
        ),

        eksekusiEfek(Jenis)
    ).

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
cekValid(hitam, _) :-
    kartuTeratas(kartu(_, JenisTop)),
    % Pastikan kartu teratas di meja bukan wild dan BUKAN wildDrawFour
    \+ isMember(JenisTop, [wild, wildDrawFour]).

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
    asserta(giliranSekarang(Next)).
    
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
/* updateIndeksTersembunyi: hapus indeks yang dimainkan, geser indeks lebih besar ke bawah 1 */
updateIndeksTersembunyi(Pemain, IndeksDimainkan) :-
    % Kumpulkan semua indeks tersembunyi milik pemain ini
    findall(I, kartuTersembunyi(Pemain, I), SemuaIndeks),
    retractall(kartuTersembunyi(Pemain, _)),
    assertIndeksBaru(Pemain, SemuaIndeks, IndeksDimainkan).

assertIndeksBaru(_, [], _).
assertIndeksBaru(Pemain, [I|T], Dimainkan) :-
    (I =:= Dimainkan ->
        % Indeks ini adalah kartu yang dimainkan, buang saja
        true
    ; I > Dimainkan ->
        % Geser turun 1
        IBaru is I - 1,
        asserta(kartuTersembunyi(Pemain, IBaru))
    ;
        % Indeks lebih kecil, tetap sama
        asserta(kartuTersembunyi(Pemain, I))
    ),
    assertIndeksBaru(Pemain, T, Dimainkan).