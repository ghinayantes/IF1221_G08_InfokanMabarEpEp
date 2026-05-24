godsHand :-
    % Cek apakah pemain aktif sudah pakai godsHand di giliran ini
    giliranSekarang(Pemain),
    godsHandDipakai(Pemain), !,
    write('Kamu sudah mencoba God\'s Hand di giliran ini!'), nl,
    write('Silakan mainkanKartu(NomorUrut). atau ambilKartu.'), nl.

godsHand :-
    % Lempar dadu probabilitas (~15%)
    random(0, 100, Roll),
    Roll < 15,
    !,
    % Tandai pemain ini sudah pakai godsHand di giliran ini
    giliranSekarang(Pemain),
    asserta(godsHandDipakai(Pemain)),
    godsHandEksekusi.

godsHand :-
    % Roll >= 15, tidak ada efek — tetap tandai sudah dipakai
    giliranSekarang(Pemain),
    asserta(godsHandDipakai(Pemain)),
    write('Tidak ada kejadian spesial.'), nl.

godsHandEksekusi :-
    urutanPemain(SemuaPemain),

    ( semuaPemainSatuKartu(SemuaPemain) ->
        true
    ;
        pilihPemainAcakDenganKartu(SemuaPemain, PemainSumber),
        kartuTangan(PemainSumber, TanganSumber),

        hitungPanjang(TanganSumber, JumlahKartu),
        random(0, JumlahKartu, IdxAcak),
        IdxSatu is IdxAcak + 1,
        ambilKartuAtIndeks(IdxSatu, TanganSumber, KartuPilihan),

        hapusElemen(PemainSumber, SemuaPemain, PemainLain),
        pilihAcakDariList(PemainLain, PemainTujuan),

        hapusElemen(KartuPilihan, TanganSumber, TanganSumberBaru),
        kartuTangan(PemainTujuan, TanganTujuan),
        append(TanganTujuan, [KartuPilihan], TanganTujuanBaru),

        retract(kartuTangan(PemainSumber, _)),
        asserta(kartuTangan(PemainSumber, TanganSumberBaru)),
        retract(kartuTangan(PemainTujuan, _)),
        asserta(kartuTangan(PemainTujuan, TanganTujuanBaru)),

        write('Tuhan telah berkehendak.'), nl,
        write('Kartu '), cetakKartu(KartuPilihan),
        format(' milik ~w berpindah ke tangan ~w!~n', [PemainSumber, PemainTujuan]),
        nl,

        gantiGiliran,
        giliranSekarang(Next),
        format('Giliran ~w.~n', [Next])
    ).

% helper cek semua pemain hanya punya 1 kartu
semuaPemainSatuKartu([]).
semuaPemainSatuKartu([P|T]) :-
    kartuTangan(P, Tangan),
    hitungPanjang(Tangan, 1),
    semuaPemainSatuKartu(T).

% helper pilih pemain acak yang tangannya tidak kosong
pilihPemainAcakDenganKartu(SemuaPemain, Pemain) :-
    filterPemainBerkartu(SemuaPemain, KandidatList),
    pilihAcakDariList(KandidatList, Pemain).

filterPemainBerkartu([], []).
filterPemainBerkartu([P|T], [P|Sisa]) :-
    kartuTangan(P, Tangan),
    Tangan \= [], !,
    filterPemainBerkartu(T, Sisa).
filterPemainBerkartu([_|T], Sisa) :-
    filterPemainBerkartu(T, Sisa).

pilihAcakDariList(List, Elem) :-
    hitungPanjang(List, Len),
    random(0, Len, Idx),
    ambilElemen(Idx, List, Elem).