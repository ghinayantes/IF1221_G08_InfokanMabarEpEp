swapKartu(_, _) :-
    \+ giliranSekarang(_), !,
    write('Tidak ada permainan yang sedang berjalan. Ketik "start." untuk mulai.'), nl.

swapKartu(_, _) :-
    \+ modeTurnamen, !,
    write('Perintah swapKartu hanya tersedia di mode turnamen.'), nl.

swapKartu(_, _) :-
    sudahSwap, !,
    write('Kamu sudah melakukan swapKartu di giliran ini!'), nl,
    write('Silakan mainkanKartu(NomorUrut). atau ambilKartu.'), nl.

swapKartu(IdxMilikku, IdxTemanku) :-
    giliranSekarang(Pemain),
    % validasi
    (cariTemanSetim(Pemain, _) -> true ;
        write('Data tim tidak ditemukan. Pastikan game dimulai dalam mode turnamen.'), nl,
        fail),
        
    cariTemanSetim(Pemain, Teman),
    kartuTangan(Pemain, TanganKu),
    kartuTangan(Teman, TanganTeman),

    hitungPanjang(TanganKu, LenKu),
    hitungPanjang(TanganTeman, LenTeman),
    (LenKu > 1 -> true ;
        write('Tidak bisa swap: kartumu hanya tersisa 1.'), nl, fail),
    (LenTeman > 1 -> true ;
        format('Tidak bisa swap: kartu ~w hanya tersisa 1.~n', [Teman]), fail),

    (IdxMilikku >= 1, IdxMilikku =< LenKu -> true ;
        format('Nomor kartu ~w di luar batas (kamu punya ~w kartu).~n', [IdxMilikku, LenKu]), fail),
    (IdxTemanku >= 1, IdxTemanku =< LenTeman -> true ;
        format('Nomor kartu ~w milik ~w di luar batas (~w punya ~w kartu).~n', [IdxTemanku, Teman, Teman, LenTeman]), fail),

    ambilKartuAtIndeks(IdxMilikku, TanganKu, KartuKu),
    ambilKartuAtIndeks(IdxTemanku, TanganTeman, KartuTeman),

    gantikKartuDiIndeks(IdxMilikku, TanganKu, KartuTeman, TanganKuBaru),
    gantikKartuDiIndeks(IdxTemanku, TanganTeman, KartuKu, TanganTemanBaru),

    retract(kartuTangan(Pemain, _)),
    asserta(kartuTangan(Pemain, TanganKuBaru)),
    retract(kartuTangan(Teman, _)),
    asserta(kartuTangan(Teman, TanganTemanBaru)),

    asserta(sudahSwap),

    format('~w menukar ', [Pemain]),
    cetakKartu(KartuKu),
    format(' dengan kartu ', []),
    cetakKartu(KartuTeman),
    format(' milik ~w.~n', [Teman]),
    write('Pertukaran kartu berhasil.'), nl,

    gantiGiliran,
    giliranSekarang(Next),
    format('Giliran ~w.~n', [Next]).

swapKartu(_, _) :-
    write('swapKartu gagal. Periksa kembali nomor kartu dan kondisi permainan.'), nl.

% helper
gantikKartuDiIndeks(1, [_|T], KartuBaru, [KartuBaru|T]) :- !.
gantikKartuDiIndeks(N, [H|T], KartuBaru, [H|Hasil]) :-
    N > 1,
    N1 is N - 1,
    gantikKartuDiIndeks(N1, T, KartuBaru, Hasil).

% helper
cariTemanSetim(Pemain, Teman) :-
    tim1(Tim1),
    isMember(Pemain, Tim1), !,
    hapusElemen(Pemain, Tim1, [Teman|_]).

cariTemanSetim(Pemain, Teman) :-
    tim2(Tim2),
    isMember(Pemain, Tim2), !,
    hapusElemen(Pemain, Tim2, [Teman|_]).