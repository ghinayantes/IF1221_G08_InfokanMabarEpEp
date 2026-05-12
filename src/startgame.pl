:- dynamic(urutanPemain/1).
:- dynamic(giliranSekarang/1).
:- dynamic(kartuTeratas/1).
:- dynamic(kartuTangan/2).
:- dynamic(warnaAktif/1).
:- dynamic(arahPermainan/1).
:- dynamic(statusUni/1).
:- dynamic(sisaDeck/1).

:- include('kartu.pl').
:- include('pemain.pl').
:- include('distribusiKartu.pl').
:- include('lihatKartu.pl').
:- include('lihatCommand.pl').
:- include('ambilKartu.pl').
:- include('mainkanKartu.pl').

startGame :-
    write('Masukkan jumlah pemain: '),
    read(N),
    prosesInputPemain(N).

inisialisasiGame(DaftarNama) :-
    hapusDataLama,
    acakList(DaftarNama, UrutanBaru),
    buatDeckBaru(DeckLengkap),
    bagiKartuPemain(UrutanBaru, DeckLengkap, DeckSisa),
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
