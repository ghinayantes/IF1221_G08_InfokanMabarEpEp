/* main.pl */

:- include('startGame.pl').

% Predikat utama untuk menjalankan program
main :-
    write('-------------------------------------------'), nl,
    write('      SELAMAT DATANG DI PERMAINAN UNI      '), nl,
    write('-------------------------------------------'), nl,
    write('Ketik "start." untuk mulai bermain.'), nl,
    write('Ketik "help." untuk melihat daftar perintah.'), nl,
    write('Ketik "exit." untuk keluar dari program.'), nl,
    write('-------------------------------------------'), nl.

% Alias agar lebih mudah memanggil startGame
start :-
    startGame.

% Menampilkan bantuan perintah secara umum
help :-
    write('Daftar Perintah Game:'), nl,
    write('- start.          : Memulai sesi permainan baru.'), nl,
    write('- lihatKartu.     : Melihat kartu di tangan pemain saat ini.'), nl,
    write('- lihatCommand.   : Melihat aksi yang tersedia sesuai kondisi meja.'), nl,
    write('- cekInfo.        : Melihat status giliran, arah, dan warna aktif.'), nl,
    write('- exit.           : Menutup terminal permainan.'), nl.

% Predikat untuk keluar
exit :-
    hapusDataLama.

% Menjalankan tampilan menu utama saat file di-consult
:- initialization(main).