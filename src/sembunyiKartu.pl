%hitungPanjang(List, Hasil)

hitungPanjang([], 0).

hitungPanjang([_|T], Hasil) :-
    hitungPanjang(T, Temp),
    Hasil is Temp + 1.

%ambilKartu(List, Index, Kartu)

ambilKartu([H|_], 1, H).

ambilKartu([_|T], Index, Kartu) :-
    Index > 1,
    NextIndex is Index - 1,
    ambilKartu(T, NextIndex, Kartu).

%sembunyikanKartu(NomorUrut)

sembunyikanKartu(NomorUrut) :-
    giliranSekarang(Pemain),
    kartuTangan(Pemain, Tangan),
    hitungPanjang(Tangan, JumlahKartu),
    
    % Gabisa kalau kartu tinggal 1
    JumlahKartu > 1,
    ambilKartu(Tangan, NomorUrut, Kartu),
    asserta(kartuTersembunyi(Pemain, Kartu)),

    write('Kartu '),
    cetakKartu(Kartu),
    write(' berhasil disembunyikan.'),
    nl, nl,

    write('Giliran '),
    write(Pemain),
    write('.'),
    nl.
