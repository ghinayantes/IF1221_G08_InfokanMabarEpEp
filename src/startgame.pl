:- dynamic(urutanPemain/1).
:- dynamic(giliranSekarang/1).
:- dynamic(kartuTeratas/1).
:- dynamic(kartuTangan/2).
:- dynamic(warnaAktif/1).
:- dynamic(arahPermainan/1).
:- dynamic(statusUni/1).
:- dynamic(sisaDeck/1).

:- include('kartu.pl').

startGame :-
    write('Masukkan jumlah pemain: '),
    read(N),
    (integer(N), N >= 2, N =< 4 -> nl, inputNamaPemain(N, [], DaftarNama),
    inisialisasiGame(DaftarNama) ; write('Mohon masukkan angka antara 2 - 4.'), nl, startGame).

isHurufKapital(NamaAtom) :-
    atom_codes(NamaAtom, [First|_]),
    First >= 65, First =< 90.

inputNamaPemain(0, Acc, Pemain) :-
    reverse(Acc, Pemain).

inputNamaPemain(N, Acc, Pemain) :-
    N > 0,
    length(Acc, Idx0), Idx is Idx0 + 1,
    format('Masukkan nama pemain ~w: ', [Idx]),
    read(Nama),
    validasiNama(Nama, N, Acc, Pemain).

validasiNama(Nama, N, Acc, Pemain) :-
    (atom(Nama) -> (isHurufKapital(Nama) -> (\+ member(Nama, Acc) ->
    N1 is N - 1, inputNamaPemain(N1, [Nama|Acc], Pemain) ; write('Nama sudah digunakan. Masukkan nama lain: '),
    read(Next), validasiNama(Next, N, Acc, Pemain)) ; write('Nama harus diawali huruf besar. Masukkan nama lain: '),
    read(Next), validasiNama(Next, N, Acc, Pemain)) ; write('Input tidak valid. Masukkan nama lain: '),
    read(Next), validasiNama(Next, N, Acc, Pemain)).

inisialisasiGame(DaftarNama) :-
    hapusDataLama,
    acakList(DaftarNama, UrutanBaru),
    buatDeckBaru(DeckLengkap),
    % Bagian Distribusi Kartu:
    bagiKartuPemain(UrutanBaru, DeckLengkap, DeckSisa),
    % Bagian Discard Pile Awal:
    setKartuAwal(DeckSisa, KartuAwal, DeckFinal),
    
    assertz(urutanPemain(UrutanBaru)),
    UrutanBaru = [Pertama|_],
    assertz(giliranSekarang(Pertama)),
    assertz(kartuTeratas(KartuAwal)),
    KartuAwal = kartu(W, _), assertz(warnaAktif(W)),
    assertz(arahPermainan(kanan)),
    assertz(statusUni([])),
    assertz(sisaDeck(DeckFinal)),
    
    nl,
    format('Urutan pemain: ', []),
    tampilkanUrutan(UrutanBaru),
    write('.'), nl, nl,
    format('Setiap pemain mendapatkan 7 kartu acak.', []), nl, nl,
    format('Kartu discard top: ', []),
    cetakKartu(KartuAwal),
    nl, nl,
    format('Giliran ~w.~n', [Pertama]),
    !.

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
    \+ member(J, [skip, reverse, drawTwo]).

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

cetakKartu(kartu(Warna, Jenis)) :-
    format('~w-~w', [Warna, Jenis]).

tampilkanUrutan([H]) :-
    format('~w', [H]), !.
tampilkanUrutan([H|T]) :-
    format('~w - ', [H]),
    tampilkanUrutan(T).

buatDeckBaru(Deck) :-
    findall(kartu(W, J), bentukKartu(W, J), Base),
    findall(kartu(W, J), (bentukKartu(W, J), W \= hitam, J \= 0), Extra),
    append(Base, Extra, Gabungan),
    acakList(Gabungan, Deck).

hapusDataLama :-
    retractall(urutanPemain(_)),
    retractall(giliranSekarang(_)),
    retractall(kartuTeratas(_)),
    retractall(kartuTangan(_, _)),
    retractall(warnaAktif(_)),
    retractall(arahPermainan(_)),
    retractall(statusUni(_)),
    retractall(sisaDeck(_)).


/* 
Daftar Query yang bisa digunakan:

urutanPemain(X).: Melihat daftar seluruh pemain sesuai urutan giliran hasil pengacakan.

giliranSekarang(X).: Mengetahui nama pemain yang saat ini sedang memegang giliran untuk bermain.

kartuTeratas(X).: Melihat kartu aktif yang sedang ada di meja (discard pile).

kartuTangan(NamaPemain, X).: Melihat daftar 7 kartu yang sedang dipegang oleh pemain tertentu secara spesifik (Contoh: kartuTangan('Ghina', X).).

warnaAktif(X).: Melihat warna kartu yang sedang berlaku di meja (sangat berguna setelah kartu wildcard dimainkan).

arahPermainan(X).: Mengetahui arah putaran permainan saat ini, apakah searah jarum jam (kanan) atau berlawanan (kiri).

sisaDeck(X).: Melihat tumpukan seluruh kartu yang masih tersisa di deck dan belum diambil.

statusUni(X).: Melihat daftar nama pemain yang sudah berteriak "UNI" karena kartunya sisa satu. 
*/
