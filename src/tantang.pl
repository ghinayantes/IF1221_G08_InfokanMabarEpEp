tantang :- 
    \+ giliranSekarang(_), !,
    write('Tidak ada permainan yang sedang berjalan. Ketik "start." untuk mulai.'), nl.
tantang :-
    statusAncaman(aktif), !, 
    giliranSekarang(Penantang),
    pemainSebelumnya(Tertantang),
    warnaSebelumnya(WarnaLama),
    jenisSebelumnya(JenisTop), 

    write('Tantangan dilakukan!'), nl,
    format('Memeriksa kartu ~w...~n', [Tertantang]), nl,

    kartuTangan(Tertantang, TanganTertantang),
    
    ( ( isMember(kartu(WarnaLama, _), TanganTertantang) 
      ; isMember(kartu(_, JenisTop), TanganTertantang) 
      ) -> 
        format('Tantangan berhasil! ~w secara ilegal memainkan Wild Draw Four dan mendapatkan 4 kartu acak.~n', [Tertantang]),
        ambilKartu(Tertantang, 4),
        retractall(statusAncaman(_)),
        asserta(statusAncaman(aman)),
        
        giliranSekarang(Next),
        format('Giliran ~w.~n', [Next])
    ;   
        % jika tantangan gagal
        format('Tantangan gagal. ~w mendapatkan 6 kartu acak.~n', [Penantang]), nl,
        ambilKartu(Penantang, 6),
        retractall(statusAncaman(_)),
        asserta(statusAncaman(aman)),
        
        % Karena tantangan gagal, giliran Penantang hangus, lanjut skip ke pemain berikutnya 
        gantiGiliran, 
        giliranSekarang(Next),
        format('Giliran ~w.~n', [Next])
    ).
% else
tantang :- 
    write('Tidak ada kartu Wild Draw Four yang bisa ditantang saat ini.'), nl.
