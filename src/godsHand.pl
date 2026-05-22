godsHand :-
    % Lempar dadu probabilitas (10–20%)
    random(0, 100, Roll),
    Roll < 15,          % ~15% kemungkinan terjadi
    !,
    godsHandEksekusi.

godsHand :-             % Jika Roll >= 15, tidak ada efek, giliran tetap
    write('Tidak ada kejadian spesial.'), nl.

godsHandEksekusi :-
    urutanPemain(SemuaPemain),

    ( semuaPemainSatuKartu(SemuaPemain) ->
        true  ; pilihPemainAcakDenganKartu(SemuaPemain, PemainSumber),
        kartuTangan(PemainSumber, TanganSumber),

        % Pilih kartu acak dari tangan sumber
        hitungPanjang(TanganSumber, JumlahKartu),
        random(0, JumlahKartu, IdxAcak),  
        IdxSatu is IdxAcak + 1,           
        ambilKartuAtIndeks(IdxSatu, TanganSumber, KartuPilihan),

        % Pilih pemain tujuan secara acak 
        hapusElemen(PemainSumber, SemuaPemain, PemainLain),
        pilihAcakDariList(PemainLain, PemainTujuan),

        % Pindahkan kartu: hapus dari sumber, tambahkan ke tujuan
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

% helper utk cek apakah semua pemain hanya punya 1 kartu
semuaPemainSatuKartu([]).
semuaPemainSatuKartu([P|T]) :-
    kartuTangan(P, Tangan),
    hitungPanjang(Tangan, 1),
    semuaPemainSatuKartu(T).

% helper utk pilih pemain acak yg tangannya tidak kosong
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