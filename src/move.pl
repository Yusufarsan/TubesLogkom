% CurrentPlayer adalah pemain yang lagi giliran %

% Cek apakah Asal dan Tujuan merupakan wilayah yang sama
move(Asal, Tujuan, JumlahTentara) :-
    % Dapatkan pemain yang sedang giliran
    currentPlayer(CurrentPlayer, _),
    
    Asal == Tujuan,
    nl,
    format('~w memindahkan ~d tentara dari ~w ke ~w.', [CurrentPlayer, JumlahTentara, Asal, Tujuan]), nl, nl,
    write('Wilayah asal dan tujuan tidak boleh sama.'), nl,
    write('Pemindahan dibatalkan.'), nl,
    !.

% Cek apakah Move == 0, jika iya maka gagal melakukan move
move(Asal, Tujuan, JumlahTentara) :-
    % Dapatkan pemain yang sedang giliran
    currentPlayer(CurrentPlayer, _),
    turn(CurrentPlayer, _, Move, _, _),
    
    Move =:= 0,
    nl,
    format('~w memindahkan ~d tentara dari ~w ke ~w.', [CurrentPlayer, JumlahTentara, Asal, Tujuan]), nl, nl,
    format('~w telah melakukan move sebanyak 3 kali.', [CurrentPlayer]), nl, 
    write('Tunggu giliran berikutnya untuk dapat menjalankan move.'), nl,
    write('Pemindahan dibatalkan.'), nl,
    !.

% Cek apakah Asal dan Tujuan merupakan wilayah dari Player yang saat ini sedang jalan
move(Asal, Tujuan, JumlahTentara) :-
    % Dapatkan pemain yang sedang giliran
    currentPlayer(CurrentPlayer, _),
    
    (
        (\+wilayah(Asal, CurrentPlayer), nl, format('~w tidak memiliki wilayah ~w.', [Asal]))  
        ;
    (\+wilayah(Tujuan, CurrentPlayer), nl, format('~w tidak memiliki wilayah ~w.', [CurrentPlayer, Tujuan]))
    ),
    nl,
    write('Pemindahan dibatalkan.'),
    nl, !.

% Jika JumlahTentara > jumlah tentara di Asal - 1, maka gagal melakukan move
move(Asal, Tujuan, JumlahTentara) :-
    % Dapatkan pemain yang sedang giliran
    currentPlayer(CurrentPlayer, _),
    
    % Dapatkan jumlah tentara di Asal
    jumlahTentaraWilayah(Asal, JumlahTentaraAsal),
    JumlahTentara > JumlahTentaraAsal - 1,
    nl,
    format('~w memindahkan ~d tentara dari ~w ke ~w.', [CurrentPlayer, JumlahTentara, Asal, Tujuan]), nl, nl,
    write('Tentara tidak mencukupi.'), nl, 
    write('Pemindahan dibatalkan.'), nl,
    !.

% Melakukan move dan memperbarui jumlah tentara di Asal dan Tujuan
move(Asal, Tujuan, JumlahTentara) :-
    nl,
    % Dapatkan pemain yang sedang giliran
    currentPlayer(CurrentPlayer, _),
    turn(CurrentPlayer, Turn, Move, Attack, Risk), 
    
    % Dapatkan jumlah tentara di Asal dan Tujuan
    jumlahTentaraWilayah(Asal, JumlahTentaraAsal),
    jumlahTentaraWilayah(Tujuan, JumlahTentaraTujuan),
    
    % Print pemindahan ke terminal
    format('~w memindahkan ~d tentara dari ~w ke ~w.', [CurrentPlayer, JumlahTentara, Asal, Tujuan]), nl, nl,
    
    % Hapus fakta jumlahTentaraWilayah
    retract(jumlahTentaraWilayah(Asal, JumlahTentaraAsal)),
    retract(jumlahTentaraWilayah(Tujuan, JumlahTentaraTujuan)),
    
    % Update fakta jumlahTentaraWilayah
    NewJumlahTentaraAsal is JumlahTentaraAsal - JumlahTentara,
    NewJumlahTentaraTujuan is JumlahTentaraTujuan + JumlahTentara,
    assertz(jumlahTentaraWilayah(Tujuan, NewJumlahTentaraTujuan)),
    assertz(jumlahTentaraWilayah(Asal, NewJumlahTentaraAsal)),
    
    % Print jumlah tentara di Asal dan Tujuan
    format('Jumlah tentara di ~w: ~d', [Asal, NewJumlahTentaraAsal]), nl,
    format('Jumlah tentara di ~w: ~d', [Tujuan, NewJumlahTentaraTujuan]), nl,
    
    % Mengurangi Move sebanyak 1
    NewMove is Move - 1,
    retract(turn(CurrentPlayer, Turn, Move, Attack, Risk)),
    assertz(turn(CurrentPlayer, Turn, NewMove, Attack, Risk)),
    !.
