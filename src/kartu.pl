/* Deklarasi Fakta */
/* Variasi Kartu */
angka(0).
angka(1).
angka(2).
angka(3).
angka(4).
angka(5).
angka(6).
angka(7).
angka(8).
angka(9).
kartu(merah, angka(0)).
kartu(kuning, angka(0)).
kartu(hijau, angka(0)).
kartu(biru, angka(0)).
kartu(merah, angka(1)).
kartu(kuning, angka(1)).
kartu(hijau, angka(1)).
kartu(biru, angka(1)).
kartu(merah, angka(2)).
kartu(kuning, angka(2)).
kartu(hijau, angka(2)).
kartu(biru, angka(2)).
kartu(merah, angka(3)).
kartu(kuning, angka(3)).
kartu(hijau, angka(3)).
kartu(biru, angka(3)).
kartu(merah, angka(4)).
kartu(kuning, angka(4)).
kartu(hijau, angka(4)).
kartu(biru, angka(4)).
kartu(merah, angka(5)).
kartu(kuning, angka(5)).
kartu(hijau, angka(5)).
kartu(biru, angka(5)).
kartu(merah, angka(6)).
kartu(kuning, angka(6)).
kartu(hijau, angka(6)).
kartu(biru, angka(6)).
kartu(merah, angka(7)).
kartu(kuning, angka(7)).
kartu(hijau, angka(7)).
kartu(biru, angka(7)).
kartu(merah, angka(8)).
kartu(kuning, angka(8)).
kartu(hijau, angka(8)).
kartu(biru, angka(8)).
kartu(merah, angka(9)).
kartu(kuning, angka(9)).
kartu(hijau, angka(9)).
kartu(biru, angka(9)).
kartu(merah, skip).
kartu(kuning, skip).
kartu(hijau, skip).
kartu(biru, skip).
kartu(merah, reverse).
kartu(kuning, reverse).
kartu(hijau, reverse).
kartu(biru, reverse).
kartu(merah, drawTwo).
kartu(kuning, drawTwo).
kartu(hijau, drawTwo).
kartu(biru, drawTwo).
kartu(hitam, wild).
kartu(hitam, wildDrawFour).

/* Efek Kartu */
eksekusiEfek(skip) :- efekSkip(skip).
eksekusiEfek(reverse) :- efekReverse(reverse).
eksekusiEfek(drawTwo) :- efekDrawtwo(drawTwo).
eksekusiEfek(wild) :- efekWild(wild).
eksekusiEfek(wildDrawFour) :- efekWildrawFour(wildDrawFour).
eksekusiEfek(angka(_)) :- 
    write('Tidak ada efek spesial.'), nl,
    gantiGiliran,
    giliranSekarang(Next),
    format('Giliran ~w.~n', [Next]).

/* Syarat Dasar Permainan */
lempar(kartu(Warna, _), kartu(Warna, _)).
lempar(kartu(_, Jenis), kartu(_, Jenis)).

/* Syarat Kartu Wild */
lempar(kartu(hitam, wild), _).
lempar(kartu(hitam, wildDrawFour), _).

/* Cek Kesamaan Kartu di Tangan dan di Meja*/
cekKesamaan(kartu(W, _), W, _).
cekKesamaan(kartu(_, J), _, J).
cekKesamaan(kartu(_, angka(N)), _, angka(N)).
cekKesamaan(kartu(hitam, wild), _, _).
cekKesamaan(kartu(hitam, wildDrawFour), _, _).

/* Eksekusi Efek Kartu */
efekSkip(skip) :-
    pemainSelanjutnya(Target),
    skipPemain(Target),
    write('Pemain berikutnya telah dilewati'), nl,
    gantiGiliran, 
    giliranSekarang(Next),
    format('Giliran ~w.~n', [Next]).

efekReverse(reverse) :-
    arahPermainan(Arah),
    (Arah == kanan -> ArahBaru = kiri ; ArahBaru = kanan),
    retract(arahPermainan(Arah)),
    asserta(arahPermainan(ArahBaru)),
    write('Arah sukses dibalik'), nl,
    gantiGiliran,
    giliranSekarang(Next),
    format('Giliran ~w.~n', [Next]).

efekDrawtwo(drawTwo) :-
    pemainSelanjutnya(Target),
    ambilKartu(Target, 2),
    skipPemain(Target), 
    write('Pemain selanjutnya ambil 2 kartu'), nl.

pemainSelanjutnya(Target) :-
    arahPermainan(Arah),
    giliranSekarang(Sekarang),
    urutanPemain(List),
    tentukanSelanjutnya(Arah, Sekarang, List, Target).

skipPemain(_) :- 
    gantiGiliran.

efekWild(wild) :-
    write('Pilih warna: (merah, kuning, hijau, biru).'), nl,
    read(WarnaBaru), 
    (member(WarnaBaru, [merah, kuning, hijau, biru]) ->
        retract(warnaAktif(_)),
        asserta(warnaAktif(WarnaBaru)),
        format('Warna berubah menjadi ~w.~n', [WarnaBaru]),
        gantiGiliran,
        giliranSekarang(Next),
        format('Giliran ~w.~n', [Next])
    ;
        write('Warna tidak valid! Pilih kembali.'), nl, 
        efekWild(wild) 
    ).

efekWildrawFour(wildDrawFour) :-
    write('Pilih warna baru untuk Wild Draw Four: (merah, kuning, hijau, biru).'), nl,
    read(WarnaBaru),
    (isMember(WarnaBaru, [merah, kuning, hijau, biru]) ->
        retract(warnaAktif(_)),
        asserta(warnaAktif(WarnaBaru)),
        format('Warna berhasil diubah menjadi ~w.~n', [WarnaBaru]),
        
        write('Pemain selanjutnya harus mengambil 4 kartu atau tantang.'), nl,
        
        gantiGiliran,
        giliranSekarang(Next),
        format('Giliran ~w.~n', [Next])
    ;
        % Jika input warna salah 
        write('Warna tidak valid! Pilih kembali.'), nl,
        efekWildrawFour(wildDrawFour)
    ).