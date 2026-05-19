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

    gantiGiliran,
    giliranSekarang(Next),
    format('Giliran ~w.~n', [Next]).

tampilkanKartu(Kartu) :-
    giliranSekarang(Pemain),
    kartuTersembunyi(Pemain, Kartu),
    retract(kartuTersembunyi(Pemain, Kartu)),

    write('Kartu '),
    cetakKartu(Kartu),
    write(' berhasil ditampilkan kembali.'),
    nl.
