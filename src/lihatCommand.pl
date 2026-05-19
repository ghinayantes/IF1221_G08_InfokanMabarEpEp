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
    write('3. uni'), nl,
    write('4. sembunyikanKartu(NomorUrut)'), nl,
    tampilkanCommandTampilkan,
    tampilkanAksiPendukung.

tampilkanCommandTampilkan :-
    giliranSekarang(Pemain),
    kartuTersembunyi(Pemain, _),
    write('5. tampilkanKartu'), nl.

tampilkanCommandTampilkan.

tampilkanAksiPendukung :-
    write('Aksi pendukung yang tersedia:'), nl,
    write('1. lihatCommand'), nl,
    write('2. lihatKartu'), nl,
    write('3. cekInfo'), nl.
