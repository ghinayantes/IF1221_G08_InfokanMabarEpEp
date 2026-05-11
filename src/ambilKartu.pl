ambilKartu :-
    giliranSekarang(Pemain),
    sisaDeck([KartuBaru|SisaDeckBaru]),
    !,
    
    kartuTangan(Pemain, TanganLama),
    append(TanganLama, [KartuBaru], TanganBaru),
    
    retract(sisaDeck(_)),
    asserta(sisaDeck(SisaDeckBaru)),
    retract(kartuTangan(Pemain, _)),
    asserta(kartuTangan(Pemain, TanganBaru)),
    
    write('Anda mengambil kartu: '), writeln(KartuBaru),
    gantiGiliran.

ambilKartu :-
    writeln('Gagal memainkan. Deck kosong!').

/* untuk efek kartu Draw Two (+2) atau Wild Draw Four (+4) */
ambilKartu(Pemain, Jumlah) :-
    sisaDeck(DeckLama),
    
    ambilN(Jumlah, DeckLama, KartuDiambil, SisaDeckBaru),
    
    kartuTangan(Pemain, TanganLama),
    append(TanganLama, KartuDiambil, TanganBaru),
    
    retract(sisaDeck(_)),
    asserta(sisaDeck(SisaDeckBaru)),
    retract(kartuTangan(Pemain, _)),
    asserta(kartuTangan(Pemain, TanganBaru)),
    
    write(Pemain), write(' mengambil '), write(Jumlah), writeln(' kartu dari deck.').

/* helper ambil N kartu dari deck */

ambilN(0, Deck, [], Deck) :- !.
ambilN(N, [K|RestDeck], [K|RestAmbil], SisaDeck) :-
    N > 0,
    N1 is N - 1,
    ambilN(N1, RestDeck, RestAmbil, SisaDeck).
