:- include('startgame.pl').

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
    write('  ============================================================'), nl,
    write('   PANDUAN DAN REGULASI PERMAINAN UNI'), nl,
    write('  ============================================================'), nl, nl,

    write('  [1] CARA MEMULAI GAME'), nl,
    write('  ------------------------------------------------------------'), nl,
    write('  Ketik "start." di menu utama.'), nl,
    write('  Pilih mode:'), nl,
    write('    1. Mode Klasik  - 2 hingga 4 pemain, individu.'), nl,
    write('    2. Mode Turnamen - tepat 4 pemain, sistem tim 2v2.'), nl,
    write('  Masukkan nama tiap pemain (diawali huruf kapital, unik).'), nl,
    write('  Setiap pemain otomatis mendapat 7 kartu acak.'), nl, nl,

    write('  [2] ALUR GILIRAN'), nl,
    write('  ------------------------------------------------------------'), nl,
    write('  Pada giliranmu, tersedia aksi utama dan aksi pendukung.'), nl,
    write('  Ketik "lihatCommand." untuk melihat daftar aksi tersedia.'), nl, nl,
    write('  AKSI UTAMA (mengakhiri giliranmu):'), nl,
    write('    mainkanKartu(N)  : Mainkan kartu ke-N dari tanganmu.'), nl,
    write('    ambilKartu.      : Ambil 1 kartu dari deck jika tidak'), nl,
    write('                       ada kartu yang bisa dimainkan.'), nl,
    write('    uni(N).          : Wajib dipakai saat kartumu tepat 2,'), nl,
    write('                       dan ingin memainkan 1 kartu.'), nl,
    write('    tantang.         : Tantang Wild Draw Four lawan (lihat [5]).'), nl,
    write('    sembunyikanKartu(N). : Sembunyikan kartu ke-N (lihat [7]).'), nl, nl,
    write('  AKSI PENDUKUNG (tidak mengakhiri giliranmu):'), nl,
    write('    lihatKartu.      : Lihat kartu di tanganmu.'), nl,
    write('    cekInfo.         : Lihat status meja dan jumlah kartu.'), nl,
    write('    lihatCommand.    : Tampilkan daftar perintah tersedia.'), nl, nl,

    write('  [3] SYARAT KARTU SAH'), nl,
    write('  ------------------------------------------------------------'), nl,
    write('  Kartu bisa dimainkan jika SALAH SATU syarat terpenuhi:'), nl,
    write('    a) Warna kartu sama dengan warna aktif di meja.'), nl,
    write('    b) Jenis/angka kartu sama dengan kartu teratas di meja.'), nl,
    write('    c) Kartu Wild atau Wild Draw Four (bisa kapan saja),'), nl,
    write('       kecuali jika masih ada kartu warna lain di tangan.'), nl, nl,

    write('  [4] KARTU SPESIAL'), nl,
    write('  ------------------------------------------------------------'), nl,
    write('    Skip       : Pemain berikutnya kehilangan gilirannya.'), nl,
    write('    Reverse    : Arah permainan berbalik (kanan <-> kiri).'), nl,
    write('    Draw Two   : Pemain berikutnya wajib ambil 2 kartu'), nl,
    write('                 dan kehilangan giliran.'), nl,
    write('    Wild       : Boleh dimainkan kapan saja. Pemain yang'), nl,
    write('                 memainkannya memilih warna aktif berikutnya.'), nl,
    write('    Wild Draw Four : Pemain berikutnya ambil 4 kartu.'), nl,
    write('                 Hanya sah jika pemain TIDAK punya kartu warna'), nl,
    write('                 lain yang cocok. Bisa ditantang (lihat [5]).'), nl, nl,

    write('  [5] FITUR TANTANG (Tantang Wild Draw Four)'), nl,
    write('  ------------------------------------------------------------'), nl,
    write('  Jika pemain sebelummu memainkan Wild Draw Four, kamu bisa'), nl,
    write('  menantangnya dengan "tantang." sebelum ambil kartu.'), nl,
    write('    - Tantangan BERHASIL: Jika lawan ternyata masih punya'), nl,
    write('      kartu warna/jenis yang cocok, lawan yang kena 4 kartu.'), nl,
    write('      Giliranmu tetap berlanjut.'), nl,
    write('    - Tantangan GAGAL: Jika lawan memang tidak punya kartu'), nl,
    write('      lain yang cocok, kamu kena 6 kartu (4+2 penalti) dan'), nl,
    write('      giliranmu dilewati.'), nl, nl,

    write('  [6] SERUAN UNI DAN TANGKAP'), nl,
    write('  ------------------------------------------------------------'), nl,
    write('  Saat kartumu tepat tersisa 2 dan ingin mainkan 1, WAJIB'), nl,
    write('  gunakan "uni(N)." bukan "mainkanKartu(N)."'), nl,
    write('  Jika lupa, pemain lain bisa ketik "tangkap(NamaTarget)."'), nl,
    write('  sebelum pemain berikutnya memulai aksinya.'), nl,
    write('    - Tangkap BERHASIL: Target dapat 2 kartu penalti.'), nl,
    write('    - Tangkap GAGAL (salah tuduh): Penangkap dapat 1 kartu.'), nl,
    write('    - Tidak bisa ditangkap jika target punya kartu tersembunyi.'), nl, nl,

    write('  [7] FITUR SEMBUNYIKAN KARTU'), nl,
    write('  ------------------------------------------------------------'), nl,
    write('  Ketik "sembunyikanKartu(N)." untuk menyembunyikan kartu ke-N.'), nl,
    write('  Kartu tersembunyi tidak bisa dilihat pemain lain.'), nl,
    write('  Efek:'), nl,
    write('    - Pemain dengan kartu tersembunyi TIDAK BISA ditangkap.'), nl,
    write('    - Untuk menampilkan kembali, ketik "tampilkanKartu."'), nl,
    write('    - Tidak bisa sembunyikan jika hanya tersisa 1 kartu.'), nl,
    write('    - Sembunyikan kartu mengakhiri giliranmu.'), nl, nl,

    write('  [8] FITUR GOD''S HAND'), nl,
    write('  ------------------------------------------------------------'), nl,
    write('  Ketik "godsHand." pada giliranmu untuk mencoba keberuntungan.'), nl,
    write('  Peluang sukses: 15%.'), nl,
    write('    - SUKSES : 1 kartu acak dari pemain acak berpindah ke'), nl,
    write('               tangan pemain acak lainnya. Giliran berganti.'), nl,
    write('    - GAGAL  : Tidak ada efek. Giliranmu tetap berlanjut.'), nl,
    write('  God''s Hand hanya bisa dipakai SEKALI per giliran.'), nl,
    write('  God''s Hand tidak bekerja jika semua pemain hanya punya 1 kartu.'), nl, nl,

    write('  [9] FITUR MIMIC CARD'), nl,
    write('  ------------------------------------------------------------'), nl,
    write('  Kartu Mimic (hitam-mimic) menyalin efek kartu AKSI terakhir'), nl,
    write('  yang dimainkan di sesi ini.'), nl,
    write('    - Jika aksi terakhir adalah Skip/Reverse/Draw Two,'), nl,
    write('      kamu diminta memilih warna aktif, lalu efek disalin.'), nl,
    write('    - Jika aksi terakhir adalah Wild atau Wild Draw Four,'), nl,
    write('      efeknya langsung disalin termasuk pemilihan warna.'), nl,
    write('    - Jika belum ada kartu aksi yang pernah dimainkan,'), nl,
    write('      Mimic berlaku sebagai Wild biasa.'), nl, nl,

    write('  [10] MODE TURNAMEN'), nl,
    write('  ------------------------------------------------------------'), nl,
    write('  Hanya untuk 4 pemain. Pemain dibagi acak menjadi 2 tim (2v2).'), nl,
    write('  Permainan berlangsung seperti biasa hingga 1 pemain habis kartu.'), nl,
    write('  Fitur eksklusif turnamen:'), nl,
    write('    lihatKartu.           : Juga menampilkan kartu teman setim.'), nl,
    write('    cekInfo.              : Menampilkan pembagian tim.'), nl,
    write('    swapKartu(NoKu, NoTeman). : Tukar 1 kartu dengan teman setim.'), nl,
    write('      Syarat swap: kartu pemain aktif > 1, kartu teman > 1,'), nl,
    write('      indeks valid, hanya sekali per giliran.'), nl,
    write('      Swap adalah aksi utama (mengakhiri giliran).'), nl,
    write('  Pemenang: Tim dengan total poin sisa kartu LEBIH KECIL.'), nl, nl,

    write('  [11] SAVE & LOAD GAME'), nl,
    write('  ------------------------------------------------------------'), nl,
    write('  "saveGame." : Simpan kondisi permainan ke file .txt.'), nl,
    write('              Tidak bisa dilakukan saat ada efek Wild Draw Four.'), nl,
    write('  "loadGame." : Muat kembali permainan dari file .txt.'), nl,
    write('  File disimpan di direktori aktif saat gprolog dijalankan.'), nl, nl,

    write('  [12] NILAI KARTU (untuk perhitungan poin akhir)'), nl,
    write('  ------------------------------------------------------------'), nl,
    write('    Kartu 0              : 1 poin'), nl,
    write('    Kartu angka (1-9)    : sesuai angkanya'), nl,
    write('    Skip, Reverse, Draw Two : 10 poin'), nl,
    write('    Wild, Wild Draw Four : 20 poin'), nl,
    write('    Mimic                : 20 poin'), nl, nl,

    write('  ============================================================'), nl,
    write('  Ketik "help." saat bermain untuk melihat daftar perintah.'), nl,
    write('  ============================================================'), nl, nl.

start :- startGame.

help :-
    (giliranSekarang(_) ->
        nl,
        write(' --- DAFTAR PERINTAH AKTIF PERMAINAN ---'), nl,
        write('  +-------------------------------------------------------------------------+'), nl,
        write('  | AKSI UTAMA (mengakhiri giliran):                                        |'), nl,
        write('  |   mainkanKartu(N).        : Mainkan kartu ke-N.                         |'), nl,
        write('  |   uni(N).                 : Mainkan kartu ke-N saat kartu tepat 2.      |'), nl,
        write('  |   ambilKartu.             : Ambil kartu dari deck.                      |'), nl,
        write('  |   tantang.                : Tantang Wild Draw Four lawan.               |'), nl,
        write('  |   sembunyikanKartu(N).    : Sembunyikan kartu ke-N.                     |'), nl,
        write('  |   tampilkanKartu.         : Tampilkan kembali kartu tersembunyi.        |'), nl,
        write('  |   godsHand.               : Coba keberuntungan (peluang 15%).           |'), nl,
        (modeTurnamen ->
            write('  |   swapKartu(NoKu,NoTeman). : Tukar kartu dgn teman setim (Turnamen).    |'), nl
        ; true),
        write('  | AKSI PENDUKUNG (tidak mengakhiri giliran):                              |'), nl,
        write('  |   lihatKartu.             : Lihat kartu di tanganmu.                    |'), nl,
        write('  |   cekInfo.                : Lihat status meja & jumlah kartu.           |'), nl,
        write('  |   lihatCommand.           : Tampilkan aksi yang tersedia.               |'), nl,
        write('  |   tangkap(Nama).          : Tangkap pemain yang lupa UNI.               |'), nl,
        write('  |   saveGame.               : Simpan permainan.                           |'), nl,
        write('  |   loadGame.               : Muat permainan tersimpan.                   |'), nl,
        write('  +-------------------------------------------------------------------------+'), nl,
        write('  Ketik "panduan." untuk penjelasan lengkap setiap perintah.'), nl, nl
    ;
        write('Silakan ketik "start." untuk memulai permainan.'), nl).
exit :-
    \+ giliranSekarang(_), !,
    write(' Anda sudah keluar sebelumnya, tidak ada permainan yang sedang berjalan. '), nl. 

exit :- 
    giliranSekarang(_), !, 
    write('Permainan sedang berjalan, simpan permainan saat ini sebelum keluar? (y/n): '), 
    read(Pilihan), nl,
    ((Pilihan == yes ; Pilihan == 'y') -> write('Melanjutkan ke proses penyimpanan game...'), saveGame, nl, 
        exit_aksi ; (Pilihan == no ; Pilihan == 'n') -> write('Keluar tanpa menyimpan...'), nl,
        exit_aksi ; write('Pilihan tidak valid! Masukkan "y." atau "n."'), nl, exit).

exit :-
    exit_aksi.

exit_aksi :-
    hapusDataLama,
    write('Terima kasih telah bermain UNI! Sampai jumpa lagi. '), nl.

:- initialization(main).