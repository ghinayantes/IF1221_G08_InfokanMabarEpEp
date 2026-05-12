bagiKartuPemain([], Deck, Deck).
bagiKartuPemain([P|SisaP], Deck, DeckAkhir) :-
    ambilTujuh(7, Deck, Tangan, SisaD),
    assertz(kartuTangan(P, Tangan)),
    bagiKartuPemain(SisaP, SisaD, DeckAkhir).

ambilTujuh(0, D, [], D) :- !.
ambilTujuh(N, [K|R], [K|Ks], D) :-
    N > 0, N1 is N - 1,
    ambilTujuh(N1, R, Ks, D).

cekKartuValid(kartu(W, J)) :-
    W \= hitam,
    \+ member(J, [skip, reverse, drawTwo, wild, wildDrawFour]).

setKartuAwal([K|R], K, R) :- cekKartuValid(K), !.
setKartuAwal([_|R], K, D) :- setKartuAwal(R, K, D).

acakList([], []) :- !.
acakList(List, [Item|SisaAcak]) :-
    hitungPanjang(List, Len),
    random(0, Len, I),
    ambilElemen(I, List, Item),
    hapusElemen(Item, List, Sisa),
    acakList(Sisa, SisaAcak).

hitungPanjang([], 0) :- !.
hitungPanjang([_|T], Len) :-
    hitungPanjang(T, Prev),
    Len is Prev + 1.

ambilElemen(0, [H|_], H) :- !.
ambilElemen(I, [_|T], Elem) :-
    I > 0, I1 is I - 1,
    ambilElemen(I1, T, Elem).

hapusElemen(_X, [], []) :- !.
hapusElemen(H, [H|T], T) :- !.
hapusElemen(X, [H|T], [H|R]) :-
    hapusElemen(X, T, R).

cetakKartu(kartu(Warna, angka(N))) :- !,
    format('~w-~w', [Warna, N]).
cetakKartu(kartu(Warna, Jenis)) :-
    format('~w-~w', [Warna, Jenis]).

tampilkanUrutan([H]) :-
    format('~w', [H]), !.
tampilkanUrutan([H|T]) :-
    format('~w - ', [H]),
    tampilkanUrutan(T).

buatDeckBaru(Deck) :-
    DaftarWarna = [merah, kuning, hijau, biru],
    DaftarAngka = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
    DaftarAksi = [skip, reverse, drawTwo],
    DaftarHitam = [wild, wildDrawFour],
    
    kumpulkanSemuaKartu(DaftarWarna, DaftarAngka, DaftarAksi, DaftarHitam, Semua),
    acakList(Semua, Deck).

kumpulkanSemuaKartu(Warnas, Angkas, Aksis, Hitams, Hasil) :-
    buatKartuAngka(Warnas, Angkas, BagianAngka),
    buatKartuAksi(Warnas, Aksis, BagianAksi),
    buatKartuHitam(Hitams, BagianHitam),
    append(BagianAngka, BagianAksi, Temp),
    append(Temp, BagianHitam, Hasil).

% Rekursi untuk kartu angka(N)
buatKartuAngka([], _, []).
buatKartuAngka([W|RestW], Angkas, Hasil) :-
    kombinasiAngka(W, Angkas, KartuWarna),
    buatKartuAngka(RestW, Angkas, RestHasil),
    append(KartuWarna, RestHasil, Hasil).

kombinasiAngka(_, [], []).
kombinasiAngka(W, [N|RestN], [kartu(W, angka(N)), kartu(W, angka(N)) | RestHasil]) :-
    N \= 0, !,
    kombinasiAngka(W, RestN, RestHasil).
kombinasiAngka(W, [0|RestN], [kartu(W, angka(0)) | RestHasil]) :-
    kombinasiAngka(W, RestN, RestHasil).

% Rekursi untuk kartu aksi (skip, reverse, drawTwo)
buatKartuAksi([], _, []).
buatKartuAksi([W|RestW], Aksis, Hasil) :-
    kombinasiAksi(W, Aksis, KartuWarna),
    buatKartuAksi(RestW, Aksis, RestHasil),
    append(KartuWarna, RestHasil, Hasil).

kombinasiAksi(_, [], []).
kombinasiAksi(W, [A|RestA], [kartu(W, A), kartu(W, A) | RestHasil]) :-
    kombinasiAksi(W, RestA, RestHasil).

% Rekursi untuk kartu hitam
buatKartuHitam([], []).
buatKartuHitam([H|RestH], [kartu(hitam, H), kartu(hitam, H), kartu(hitam, H), kartu(hitam, H) | RestHasil]) :-
    buatKartuHitam(RestH, RestHasil).
