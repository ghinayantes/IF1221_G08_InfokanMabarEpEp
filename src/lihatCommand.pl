lihatCommand :- 
    \+ giliranSekarang(_), !, % JIKA tidak ada giliran aktif, baru cetak error
    write('Tidak ada permainan yang sedang berjalan. Ketik "start." untuk mulai.'), nl.

lihatCommand :-
    (kartuTeratas(kartu(hitam, wildDrawFour)) -> commandDrawFour ; commandNormal).

commandDrawFour :-
    write('Aksi utama yang tersedia:'), nl,
    write('1. ambilKartu'), nl,
    write('2. tantang'), nl,
    tampilkanAksiPendukung.

commandNormal :-
    write('Aksi utama yang tersedia:'), nl,
    write('1. mainkanKartu(NomorUrut)'), nl,
    write('2. ambilKartu'), nl,
    write('3. uni(NomorUrut)'), nl,
    write('4. sembunyikanKartu(NomorUrut)'), nl,
    write('5. godsHand.'), nl,
    % Tampilkan swapKartu jika mode turnamen
    (modeTurnamen -> write('6. swapKartu(NomorUrutKartuKu, NomorUrutKartuTeman)'), nl
    ; true),
    tampilkanCommandTampilkan,
    tampilkanAksiPendukung.

% Tampilkan opsi "tampilkanKartu" hanya jika pemain aktif punya kartu tersembunyi
tampilkanCommandTampilkan :-
    giliranSekarang(Pemain),
    kartuTersembunyi(Pemain, _), !,
    write('7. tampilkanKartu'), nl.

tampilkanCommandTampilkan.

tampilkanAksiPendukung :-
    write('Aksi pendukung yang tersedia:'), nl,
    write('1. lihatCommand'), nl,
    write('2. lihatKartu'), nl,
    write('3. cekInfo'), nl.