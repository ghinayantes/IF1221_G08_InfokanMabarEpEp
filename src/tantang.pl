tantang :-
    statusAncaman(aktif), !, 
    giliranSekarang(Penantang),
    pemainSebelumnya(Tertantang),
    warnaSebelumnya(WarnaLama),
    jenisSebelumnya(JenisTop), 

    write('Tantangan dilakukan!'), nl,
    format('Memeriksa kartu ~w...~n', [Tertantang]), nl,

    kartuTangan(Tertantang, TanganTertantang),
    
    % Cek apakah Tertantang punya kartu lain yang sewarna ATAU sejenis/seangka dengan meja sebelumnya
    ( (member(kartu(WarnaLama, _), TanganTertantang) ; member(kartu(_, JenisTop), TanganTertantang)) -> 
        % jika punya tantangan terhasil, yg tertantang kena hukuman ambil 4 kartu
        format('Tantangan berhasil! ~w secara ilegal memainkan Wild Draw Four.~n', [Tertantang]),
        ambilKartu(Tertantang, 4),
        retractall(statusAncaman(_)),
        asserta(statusAncaman(aman)),
        % Setelah tantangan berhasil, giliran tetap berada di penantang 
        giliranSekarang(Next),
        format('Giliran ~w.~n', [Next])
    ;   
        % jika tidak punya, tantangan gagal, penantang kena hukuman ambil 6 kartu
        format('Tantangan gagal. ~w mendapatkan 6 kartu acak.~n', [Penantang]), nl,
        ambilKartu(Penantang, 6),
        retractall(statusAncaman(_)),
        asserta(statusAncaman(aman)),
        
        % Karena tantangan gagal, giliran Penantang hangus, lanjut ke pemain berikutnya
        gantiGiliran, 
        giliranSekarang(Next),
        format('Giliran ~w.~n', [Next])
    ).

% Jika tidak sedang diancam Wild Draw Four
tantang :- 
    write('Tidak ada kartu Wild Draw Four yang bisa ditantang saat ini.'), nl.