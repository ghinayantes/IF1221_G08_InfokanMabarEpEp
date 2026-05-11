inputNamaPemain(0, Acc, Pemain) :-
    reverse(Acc, Pemain).

inputNamaPemain(N, Acc, Pemain) :-
    N > 0,
    length(Acc, Idx0), Idx is Idx0 + 1,
    format('Masukkan nama pemain ~w: ', [Idx]),
    read(Nama),
    validasiNama(Nama, N, Acc, Pemain).

validasiNama(Nama, N, Acc, Pemain) :-
    (atom(Nama) -> (isHurufKapital(Nama) -> (\+ member(Nama, Acc) ->
    N1 is N - 1, inputNamaPemain(N1, [Nama|Acc], Pemain) ; write('Nama sudah digunakan. Masukkan nama lain: '),
    read(Next), validasiNama(Next, N, Acc, Pemain)) ; write('Nama harus diawali huruf besar. Masukkan nama lain: '),
    read(Next), validasiNama(Next, N, Acc, Pemain)) ; write('Input tidak valid. Masukkan nama lain: '),
    read(Next), validasiNama(Next, N, Acc, Pemain)).

isHurufKapital(NamaAtom) :-
    atom_codes(NamaAtom, [First|_]),
    First >= 65, First =< 90.