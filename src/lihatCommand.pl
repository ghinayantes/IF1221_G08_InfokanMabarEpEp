:- dynamic lastCard/1.

lihatCommand :-
    kondisiDrawFour,
    !,
    commandDrawFour.

lihatCommand :-
    commandNormal.

kondisiDrawFour :-
    lastCard(hitam-wild_draw_four).

commandDrawFour :-
    write('Aksi utama yang tersedia:'), nl,
    write('1. ambilKartu'), nl,
    write('2. tantang'), nl,

    write('Aksi pendukung yang tersedia:'), nl,
    write('1. lihatCommand'), nl,
    write('2. lihatKartu'), nl,
    write('3. cekInfo'), nl.

commandNormal :-
    write('Aksi utama yang tersedia:'), nl,
    write('1. mainkanKartu(NomorUrut)'), nl,
    write('2. ambilKartu'), nl,
    write('3. uni'), nl,
    write('4. godsHand'), nl,
    write('5. sembunyikanKartu(NomorUrut)'), nl,
    write('6. tampilkanKartu'), nl,

    write('Aksi pendukung yang tersedia:'), nl,
    write('1. lihatCommand'), nl,
    write('2. lihatKartu'), nl,
    write('3. cekInfo'), nl.