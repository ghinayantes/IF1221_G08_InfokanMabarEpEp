:- include('startGame.pl').

main :-
    write('========================================================='), nl,
    write('                 _    _   _   _   _____ '), nl,
    write('                | |  | | | \\ | | |_   _|'), nl,
    write('                | |  | | |  \\| |   | |  '), nl,
    write('                | |  | | | . ` |   | |  '), nl,
    write('                | |__| | | |\\  |  _| |_ '), nl,
    write('                 \\____/  |_| \\_| |_____|'), nl,
    write('                                                         '), nl,
    write('by: InfokanMabarEpEp - G08                               '), nl,
    write('========================================================='), nl,
    write('             SELAMAT DATANG DI PERMAINAN UNI             '), nl, nl,
    write('Ketik "anggota." untuk melihat daftar anggota kelompok.'), nl,
    write('---------------------------------------------------------'), nl,
    write('Ketik "start." untuk mulai bermain.'), nl,
    write('Ketik "help." untuk melihat daftar perintah.'), nl,
    write('Ketik "exit." untuk keluar dari program.'), nl,
    write('---------------------------------------------------------'), nl.

anggota :-
    write('1. Ghina Emelia Yantes     - 13525119 '), nl,
    write('2. Sahla Nailah Salsabilla - 13525134 '), nl,
    write('3. Cathrine Angel Siburian - 13525138 '), nl,
    write('4. Nayla Putri Ghaisani    - 13525140 '), nl.

start :-
    startGame.

% Menampilkan bantuan perintah secara umum
help :-
    write('Daftar Perintah Game:'), nl,
    write('- start.          : Memulai sesi permainan baru.'), nl,
    write('- lihatKartu.     : Melihat kartu di tangan pemain saat ini.'), nl,
    write('- lihatCommand.   : Melihat aksi yang tersedia sesuai kondisi meja.'), nl,
    write('- cekInfo.        : Melihat daftar giliran, kartu teratas, dan jumlah kartu setiap pemain.'), nl,
    write('- exit.           : Menutup permainan.'), nl.

% Predikat untuk keluar
exit :-
    hapusDataLama.

% Menjalankan tampilan menu utama saat file di-consult
:- initialization(main).