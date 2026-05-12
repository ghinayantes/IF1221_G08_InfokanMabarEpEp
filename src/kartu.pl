:- dynamic(kartudiTangan/2).  % kartudiTangan(Pemain, ListKartu)
:- dynamic(kartuTeratas/2).   % kartuTeratas(Warna, Jenis)
:- dynamic(pemainSaatIni/1).  % Giliran siapa
:- dynamic(arahSaatIni/1).    % berlawanan/searah jarum jam

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
eksekusiEfek(angka(_)) :- writeln('Tidak ada efek spesial.').

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
    write('Pemain '), write(Target), writeln(' telah di skip').

efekReverse(reverse) :-
    arahSaatIni(Arah),
    (Arah == searahJarumJam -> ArahBaru = berlawananJarumJam ; ArahBaru = searahJarumJam),
    retract(arahSaatIni(Arah)),
    asserta(arahSaatIni(ArahBaru)),
    writeln('Arah sukses dibalik').

efekDrawtwo(drawTwo) :-
    pemainSelanjutnya(Target),
    ambilKartu(Target, 2),
    skipPemain(Target), 
    writeln('Pemain selanjutnya ambil 2 kartu').

efekWild(wild) :-
    writeln('Pilih warna: (merah, kuning, hijau, biru).').

efekWildrawFour(wildDrawFour) :-
    pemainSelanjutnya(Target),
    ambilKartu(Target, 4),
    skipPemain(Target),
    writeln('Pemain selanjutnya ambil 4 kartu dan warna berubah').

bisaLemparWilDrawFour(Pemain, WarnaSaatIni) :-
    \+ (kartudiTangan(Pemain, ListKartu), member(kartu(WarnaSaatIni, _), ListKartu)).