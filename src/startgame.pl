:- dynamic(urutanPemain/1).
:- dynamic(giliranSekarang/1).
:- dynamic(kartuTeratas/1).
:- dynamic(kartuTangan/2).
:- dynamic(warnaAktif/1).
:- dynamic(arahPermainan/1).
:- dynamic(statusUni/1).
:- dynamic(sisaDeck/1).
%bonus tantang
:- dynamic(pemainSebelumnya/1).
:- dynamic(warnaSebelumnya/1).
:- dynamic(statusAncaman/1).
:- dynamic(jenisSebelumnya/1).
% bonus sembunyikan kartu
:- dynamic(kartuTersembunyi/2).
%bonus mimic card
:- dynamic(kartuAksiTerakhir/3).

:- include('kartu.pl').
:- include('pemain.pl').
:- include('distribusiKartu.pl').
:- include('lihatKartu.pl').
:- include('lihatCommand.pl').
:- include('ambilKartu.pl').
:- include('mainkanKartu.pl').
:- include('cekInfo.pl').
:- include('tantang.pl').
:- include('tangkap.pl').
:- include('uni.pl').
:- include('endGame.pl').
:- include('sembunyikanKartu.pl').
:- include('godsHand.pl').

startGame :-
    write('Masukkan jumlah pemain: '),
    read(N),
    (N >= 2, N =< 4 -> nl, inputNamaPemain(N, [], DaftarNama),
    inisialisasiGame(DaftarNama) ; write('Mohon masukkan angka antara 2 - 4.'), nl, startGame).

inisialisasiGame(DaftarNama) :-
    hapusDataLama,
    acakList(DaftarNama, UrutanBaru),
    buatDeckBaru(DeckLengkap),
    bagiKartuPemain(UrutanBaru, DeckLengkap, DeckSisa),

    (setKartuAwal(DeckSisa, KartuAwal, DeckFinal) -> true ; 
        write('Gagal menetapkan kartu awal!'), nl, fail),
    
    assertz(urutanPemain(UrutanBaru)),
    UrutanBaru = [P1|_], 
    assertz(giliranSekarang(P1)),
    assertz(kartuTeratas(KartuAwal)),
    
    KartuAwal = kartu(W, _), 
    assertz(warnaAktif(W)),
    
    assertz(arahPermainan(kanan)),
    assertz(statusUni([])),
    assertz(sisaDeck(DeckFinal)), nl,

    write('Urutan pemain: '), tampilkanUrutan(UrutanBaru), write('.'), nl, nl,
    write('Setiap pemain mendapatkan 7 kartu acak.'), nl, nl,
    write('Kartu discard top: '), cetakKartu(KartuAwal), nl, nl,
    format('Giliran ~w.~n', [P1]), !.

hapusDataLama :-
    retractall(urutanPemain(_)),
    retractall(giliranSekarang(_)),
    retractall(kartuTeratas(_)),
    retractall(kartuTangan(_, _)),
    retractall(warnaAktif(_)),
    retractall(arahPermainan(_)),
    retractall(statusUni(_)),
    retractall(sisaDeck(_)),
    % bonus tantang
    retractall(pemainSebelumnya(_)),
    retractall(warnaSebelumnya(_)),
    retractall(statusAncaman(_)),
    retractall(jenisSebelumnya(_)),
    % bonus sembunyikan kartu
    retractall(kartuTersembunyi(_, _)).

%bonus mimic card
updateAksiTerakhir(kartu(Warna, Jenis)) :-
    giliranKe(N), !, 
    giliranSekarang(Pemain),
    retractall(kartuAksiTerakhir(_, _, _)),
    assertz(kartuAksiTerakhir(kartu(Warna, Jenis), Pemain, N)).

updateAksiTerakhir(kartu(Warna, Jenis)) :-
    giliranSekarang(Pemain),
    retractall(kartuAksiTerakhir(_, _, _)),
    assertz(kartuAksiTerakhir(kartu(Warna, Jenis), Pemain, 0)).

/* 
Daftar Query yang dapat digunakan:

urutanPemain(X).: Melihat daftar seluruh pemain sesuai urutan giliran hasil pengacakan.

giliranSekarang(X).: Mengetahui nama pemain yang saat ini sedang memegang giliran untuk bermain.

kartuTeratas(X).: Melihat kartu aktif yang sedang ada di meja (discard pile).

kartuTangan(NamaPemain, X).: Melihat daftar 7 kartu yang sedang dipegang oleh pemain tertentu secara spesifik (Contoh: kartuTangan('Ghina', X).).

warnaAktif(X).: Melihat warna kartu yang sedang berlaku di meja (sangat berguna setelah kartu wildcard dimainkan).

arahPermainan(X).: Mengetahui arah putaran permainan saat ini, apakah searah jarum jam (kanan) atau berlawanan (kiri).

sisaDeck(X).: Melihat tumpukan seluruh kartu yang masih tersisa di deck dan belum diambil.

statusUni(X).: Melihat daftar nama pemain yang sudah berteriak "UNI" karena kartunya sisa satu.

buatDeckBaru(X).: Menghasilkan daftar 108 kartu UNI yang sudah teracak sempurna.

bagiKartuPemain(DaftarNama, DeckIn, DeckOut).: Menjalankan proses pembagian 7 kartu ke masing-masing pemain dan menyimpannya ke memori.

cekKartuValid(Kartu).: Memastikan kartu pertama di discard pile bukan kartu spesial (skip, reverse, draw_two, wild) sesuai aturan.

hapusDataLama.: Membersihkan seluruh data permainan sebelumnya dari memori agar tidak terjadi bentrok saat memulai sesi baru.

lihatKartu.: Muncul daftar kartu milik pemain yang sedang giliran 

lihatCommand.: Muncul daftar perintah yang bisa diketik. Jika kartu di meja bukan wild draw four, maka opsi mainkanKartu harus muncul.

kartuTangan('NamaPemain', X), tampilkanKartu(X, 1). : Mengetes fungsi penampil kartu secara manual untuk pemain tertentu.
*/