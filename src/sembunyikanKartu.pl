sembunyikanKartu(NomorUrut) :-
    giliranSekarang(Pemain),
    kartuTangan(Pemain, Tangan),
    hitungPanjang(Tangan, JumlahKartu), 
    
    % Validasi jika kartu di tangan tinggal 1 tidak bisa disembunyikan
    JumlahKartu > 1,
    ambilKartuAtIndeks(NomorUrut, Tangan, Kartu), 
    asserta(kartuTerhidden(Pemain, Kartu)), 

    write('Kartu '),
    cetakKartu(Kartu),
    write(' berhasil disembunyikan.'),
    nl, nl,

    gantiGiliran,
    giliranSekarang(Next),
    format('Giliran ~w.~n', [Next]).
