inputNamaPemain(0, Acc, Pemain) :-
    balikList(Acc, Pemain).

inputNamaPemain(N, Acc, Pemain) :-
    N > 0,
    hitungPanjang(Acc, Idx0), Idx is Idx0 + 1,
    format('Masukkan nama pemain ~w: ', [Idx]),
    read(Nama),
    validasiNama(Nama, N, Acc, Pemain).

validasiNama(Nama, N, Acc, Pemain) :-
    (   isAtom(Nama)
    ->  (   isHurufKapital(Nama)
        ->  (   \+ isMember(Nama, Acc)
            ->  N1 is N - 1,
                inputNamaPemain(N1, [Nama|Acc], Pemain)
            ;   write('Nama sudah digunakan. Masukkan nama lain: '),
                read(Next), validasiNama(Next, N, Acc, Pemain)
            )
        ;   write('Nama harus diawali huruf besar. Masukkan nama lain: '),
            read(Next), validasiNama(Next, N, Acc, Pemain)
        )
    ;   write('Input tidak valid. Masukkan nama lain: '),
        read(Next), validasiNama(Next, N, Acc, Pemain)
    ).

% pengganti atom/1 (maaf kak saya ga nemu cara yg lebih manual)
isAtom(X) :-
    \+ var(X),
    \+ number(X),
    \+ compound(X).

isHurufKapital(NamaAtom) :-
    atom_chars(NamaAtom, [HurufPertama|_]), % izin menggunakan atom_chars karena tidak berhasil mencari solusi manualnya
    hurufKapital(HurufKapitalTabel),
    HurufPertama == HurufKapitalTabel, !.

/* Tabel huruf kapital A–Z */
hurufKapital('A'). hurufKapital('B'). hurufKapital('C'). hurufKapital('D').
hurufKapital('E'). hurufKapital('F'). hurufKapital('G'). hurufKapital('H').
hurufKapital('I'). hurufKapital('J'). hurufKapital('K'). hurufKapital('L').
hurufKapital('M'). hurufKapital('N'). hurufKapital('O'). hurufKapital('P').
hurufKapital('Q'). hurufKapital('R'). hurufKapital('S'). hurufKapital('T').
hurufKapital('U'). hurufKapital('V'). hurufKapital('W'). hurufKapital('X').
hurufKapital('Y'). hurufKapital('Z').

% helper
isMember(X, [X|_]) :- !.
isMember(X, [_|T]) :- isMember(X, T).

balikList(List, Rev) :- balikListAcc(List, [], Rev).
balikListAcc([], Acc, Acc).
balikListAcc([H|T], Acc, Rev) :- balikListAcc(T, [H|Acc], Rev).