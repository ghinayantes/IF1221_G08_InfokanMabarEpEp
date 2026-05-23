:- include('startGame.pl').

main :-
    write(' +-----------------------------------------------------------------------------+'), nl,
    write(' |    ______      ______         _    _   _   _   _____                        |'), nl,
    write(' |   |      |    |      |       | |  | | | \\ | | |_   _|                       |'), nl,
    write(' |   | <3   |    | ^    |       | |  | | |  \\| |   | |                         |'), nl,
    write(' |   |      |    | v  ^ |       | |  | | | . ` |   | |                         |'), nl,
    write(' |   |  <3  |    |    v |       | |__| | | |\\  |  _| |_                        |'), nl,
    write(' |   |______|    |______|        \\____/  |_| \\_| |_____|                       |'), nl,
    write(' |                                                                             |'), nl,
    write(' |   by: InfokanMabarEpEp - G08                                                |'), nl,
    write(' +-----------------------------------------------------------------------------+'), nl,
    write('                     SELAMAT DATANG DI PERMAINAN UNI                           '), nl, nl,
    write(' Ketik "anggota." untuk melihat daftar anggota kelompok.'), nl, nl,
    write('   COMMAND MENU UTAMA:'), nl,
    write('  +---------------------------------------------------------------------------+'), nl,
    write('  | * start.   : Memulai sesi permainan baru.                                 |'), nl,
    write('  | * anggota. : Melihat daftar tim pengembang game.                          |'), nl,
    write('  | * panduan. : Membaca panduan & regulasi cara bermain.                     |'), nl,
    write('  | * exit.    : Menutup dan keluar dari program.                             |'), nl,
    write('  +---------------------------------------------------------------------------+'), nl, nl.

anggota :-
    write(' |- 1. Ghina Emelia Yantes     - 13525119 '), nl,
    write(' |- 2. Sahla Nailah Salsabilla - 13525134 '), nl,
    write(' |- 3. Cathrine Angel Siburian - 13525138 '), nl,
    write(' |- 4. Nayla Putri Ghaisani    - 13525140 '), nl.

panduan :-
    nl,
    write('  PANDUAN DAN REGULASI PERMAINAN '), nl,
    write(' ============================================================================='), nl,
    write('  1. CARA MEMULAI GAME'), nl,
    write('     Ketik "start." di menu utama, lalu masukkan jumlah pemain (2-4).'), nl,
    write('     Setiap pemain akan otomatis mendapatkan 7 kartu acak.'), nl, nl,
    write('  2. ALUR DAN ATURAN MAIN KARTU'), nl,
    write('     - Ketik "lihatKartu." untuk melihat kartu apa saja yang ada di'), nl,
    write('       tangan pemain pada giliran saat ini.'), nl,
    write('     - Ketik "mainkanKartu(NomorUrut)." untuk melempar kartu ke meja.'), nl,
    write('     - Syarat kartu sah: Warna atau Jenis/Angka harus cocok dengan'), nl,
    write('       kartu teratas di meja ("Discard Pile").'), nl,
    write('     - Jika tidak ada kartu yang sesuai, pemain WAJIB mengetik "ambilKartu."'), nl, nl,
    write('  3. KARTU SPESIAL & WILD DRAW FOUR'), nl,
    write('     - Kartu aksi (Skip, Reverse, Draw Two) memicu efek giliran otomatis.'), nl,
    write('     - Wild Draw Four memaksa pemain berikutnya mengambil 4 kartu.'), nl,
    write('     - Siasat Gertakan: Kamu bisa menantang pemain yang mengeluarkan'), nl,
    write('       Wild Draw Four dengan mengetik "tantang." jika curiga dia'), nl,
    write('       sebenarnya masih punya kartu lain yang dapat dimainkan.'), nl, nl,
    write('  4. MEKANISME SERUAN "UNI"'), nl,
    write('     - Jika kartumu tersisa 2 dan ingin mengeluarkan 1 kartu, kamu'), nl,
    write('       TIDAK BOLEH menggunakan "mainkanKartu". Kamu WAJIB menggunakan'), nl,
    write('       perintah "uni(NomorUrut)." agar sisa kartumu menjadi 1.'), nl,
    write('     - Jika kamu lupa dan sisa kartumu terlanjur 1 tanpa seruan,'), nl,
    write('       pemain lain bisa mengetik "tangkap(NamaTarget)." untuk menghukummu!'), nl,
    write(' ============================================================================='), nl,
    write(' Ketik "help." saat bermain jika kamu lupa daftar perintah aktif.'), nl, nl.

start :-
    startGame.

help :-
    (giliranSekarang(_) ->
        nl,
        write(' --- DAFTAR PERINTAH AKTIF PERMAINAN ---'), nl,
        write('  +-----------------------------------------------------------------------------+'), nl,
        write('  | * lihatKartu.           : Cek kartu di tanganmu saat ini.                   |'), nl,
        write('  | * lihatCommand.         : Melihat aksi utama dan pendukung                  |'), nl,
        write('  | * mainkanKartu(No).     : Melempar kartu ke meja.                           |'), nl,
        write('  | * uni(No).              : Mengeluarkan kartu sisa 2 jadi 1.                 |'), nl,
        write('  | * ambilKartu.           : Mengambil kartu dari tumpukan deck                |'), nl,
        write('  | * tantang.              : Menantang efek Wild Draw Four.                    |'), nl,
        write('  | * tangkap(Nama).        : Menangkap pemain yang lupa "UNI".                 |'), nl,
        write('  | * cekInfo.              : Cek status meja & jumlah kartu.                   |'), nl,
        write('  +-----------------------------------------------------------------------------+'), nl, nl
    ;
        write('Silakan ketik "start." untuk memulai permainan'), nl).

exit :-
    hapusDataLama,
    write(' Terima kasih telah bermain UNI! Sampai jumpa lagi. '), nl.

:- initialization(main).