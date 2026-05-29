%jika sedang ditantang tidak bisa mainkan kartu
mainkanKartu(_) :- 
    statusAncaman(aktif),
    write('Anda sedang terkena efek Wild Draw Four!'), nl,
    write('Pilih perintah: "tantang." atau "ambilKartu."'), nl,
    !, fail. 

mainkanKartu(NomorUrut) :-
    giliranSekarang(Pemain),
    kartuTangan(Pemain, Tangan),
    
    % validasi indeks
    hitungPanjang(Tangan, JumlahKartu),
    (NomorUrut >= 1, NomorUrut =< JumlahKartu -> true ;
        format('Nomor kartu ~w tidak valid (kamu punya ~w kartu).~n', [NomorUrut, JumlahKartu]), fail),

    ambilKartuAtIndeks(NomorUrut, Tangan, KartuPilihan),
    KartuPilihan = kartu(Warna, Jenis),
    
    cekValid(Warna, Jenis),
    !,
    
    hapusKartuDariTangan(KartuPilihan, Tangan, SisaTangan),
    retract(kartuTangan(Pemain, _)),
    asserta(kartuTangan(Pemain, SisaTangan)),

    updateIndeksTersembunyi(Pemain, NomorUrut),

    retract(kartuTeratas(_)),
    asserta(kartuTeratas(KartuPilihan)),

    retractall(statusUni(Pemain)),

    (SisaTangan == [] ->
        nl, endGame, ! 
    ;
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

        (   (Jenis = skip ; Jenis = reverse ; Jenis = drawTwo ; Jenis = wild ; Jenis = wildDrawFour) ->
            updateAksiTerakhir(KartuPilihan)
        ;   
            true
        ),

        eksekusiEfek(Jenis)
    ).

mainkanKartu(_) :-
    write('Gagal memainkan. Nomor urut salah atau kartu tidak cocok dengan meja!'), nl.

/* helper menggantikan select/3 */
hapusKartuDariTangan(_, [], []).
hapusKartuDariTangan(K, [K|T], T) :- !.
hapusKartuDariTangan(K, [H|T], [H|R]) :-
    hapusKartuDariTangan(K, T, R).

/* helper syarat validasi kartu */

/* kartu hitam-mimic bisa dimainkan ke kartu apa saja */
cekValid(hitam, mimic) :- !.

/* kartu hitam-wild bisa dimainkan ke kartu apa saja */
cekValid(hitam, wild) :- !.

/* kartu hitam-wildDrawFour: tidak boleh dimainkan jika kartu teratas juga wild/wildDrawFour */
cekValid(hitam, wildDrawFour) :-
    kartuTeratas(kartu(_, JenisTop)),
    \+ isMember(JenisTop, [wild, wildDrawFour]).

/* dilempar jika warnanya sama dengan warna aktif */
cekValid(WarnaPilihan, _) :-
    warnaAktif(WarnaAktif),
    WarnaPilihan == WarnaAktif.

/* dilempar jika jenisnya sama dengan kartu di meja */
cekValid(_, JenisPilihan) :-
    kartuTeratas(kartu(_, JenisTop)),
    JenisPilihan == JenisTop.

/* helper update warna aktif */
updateWarnaAktif(hitam) :- !.

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

    (counterGiliran(N) -> N1 is N + 1 ; N1 = 1),
    retractall(counterGiliran(_)),
    assertz(counterGiliran(N1)),
    retractall(godsHandDipakai(_)),
    retractall(sudahSwap).
    
tentukanSelanjutnya(kanan, Sekarang, ListPemain, Next) :-
    sebelahKanan(Sekarang, Next, ListPemain), !.

tentukanSelanjutnya(kanan, _, ListPemain, Next) :-
    ListPemain = [Next|_], !.

tentukanSelanjutnya(kiri, Sekarang, ListPemain, Next) :-
    sebelahKiri(Sekarang, Next, ListPemain), !.

tentukanSelanjutnya(kiri, _, ListPemain, Next) :-
    cariTerakhir(ListPemain, Next), !.

sebelahKanan(Sekarang, Next, [Sekarang, Next | _]).
sebelahKanan(Sekarang, Next, [_ | Tail]) :- 
    sebelahKanan(Sekarang, Next, Tail).

sebelahKiri(Sekarang, Next, [Next, Sekarang | _]).
sebelahKiri(Sekarang, Next, [_ | Tail]) :- 
    sebelahKiri(Sekarang, Next, Tail).

cariTerakhir([X], X).
cariTerakhir([_ | Tail], Terakhir) :- 
    cariTerakhir(Tail, Terakhir).

updateIndeksTersembunyi(Pemain, IndeksDimainkan) :-
    kumpulkanIndeksTersembunyi(Pemain, SemuaIndeks),
    retractall(kartuTersembunyi(Pemain, _)),
    assertIndeksBaru(Pemain, SemuaIndeks, IndeksDimainkan).

/* Mengumpulkan semua indeks kartu tersembunyi milik Pemain ke dalam list */
kumpulkanIndeksTersembunyi(Pemain, Hasil) :-
    kumpulkanIndeksTersembunyi_(Pemain, 1, Hasil).

kumpulkanIndeksTersembunyi_(Pemain, I, [I|Sisa]) :-
    kartuTersembunyi(Pemain, I), !,
    I1 is I + 1,
    kumpulkanIndeksTersembunyi_(Pemain, I1, Sisa).
kumpulkanIndeksTersembunyi_(Pemain, I, Sisa) :-
    kartuTersembunyi(Pemain, J), J >= I, !,
    I1 is I + 1,
    kumpulkanIndeksTersembunyi_(Pemain, I1, Sisa).
kumpulkanIndeksTersembunyi_(_, _, []).

assertIndeksBaru(_, [], _).
assertIndeksBaru(Pemain, [I|T], Dimainkan) :-
    (I =:= Dimainkan ->
        true
    ; I > Dimainkan ->
        IBaru is I - 1,
        asserta(kartuTersembunyi(Pemain, IBaru))
    ;
        asserta(kartuTersembunyi(Pemain, I))
    ),
    assertIndeksBaru(Pemain, T, Dimainkan).