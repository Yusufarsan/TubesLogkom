% Case 1: Wilayah valid dimiliki player dan jumlah tentara tambahan mencukupi untuk troops tentara
draf(CurrentPlayer, Wilayah, TroopsTentara):-
    integer(TroopsTentara), % Check if TroopsTentara is an integer
    TroopsTentara > 0,
    tentaraTambahanPlayer(CurrentPlayer, PrevTentaraTambahan),
    PrevTentaraTambahan >= TroopsTentara,
    % Update jumlah tentara tambahan player
    NewTentaraTambahan is PrevTentaraTambahan - TroopsTentara,
    retract(tentaraTambahanPlayer(CurrentPlayer,PrevTentaraTambahan)),
    assertz(tentaraTambahanPlayer(CurrentPlayer,NewTentaraTambahan)),
    % Update jumlah tentara aktif player
    tentaraAktifPlayer(CurrentPlayer,TentaraAktif),
    NewTentaraAktif is TentaraAktif + TroopsTentara,
    retract(tentaraAktifPlayer(CurrentPlayer,TentaraAktif)),
    assertz(tentaraAktifPlayer(CurrentPlayer,NewTentaraAktif)),
    % Update jumlah tentara wilayah
    jumlahTentaraWilayah(Wilayah, TentaraWilayah),
    NewTentaraWilayah is TentaraWilayah + TroopsTentara,
    retract(jumlahTentaraWilayah(Wilayah, TentaraWilayah)),
    assertz(jumlahTentaraWilayah(Wilayah, NewTentaraWilayah)),
    % Display
    format('Player ~w meletakkan ~d tentara tambahan di ~w.', [CurrentPlayer, TroopsTentara, Wilayah]), nl,
    format('Tentara total di ~w: ~d', [Wilayah, NewTentaraAktif]), nl,
    format('Jumlah Pasukan Tambahan Player ~w: ~d', [CurrentPlayer, NewTentaraTambahan]), nl,!.

% Case 2: Wilayah tidak valid dimiliki player
draf(CurrentPlayer, Wilayah, _):-
    \+ wilayah(Wilayah, CurrentPlayer),
    format('Player ~w tidak memiliki wilayah ~w.', [CurrentPlayer, Wilayah]), nl,!.

% Case 3: Jumlah tentara tambahan tidak mencukupi untuk troops tentara
draf(CurrentPlayer, _, TroopsTentara):-
    tentaraTambahanPlayer(CurrentPlayer, PrevTentaraTambahan),
    PrevTentaraTambahan < TroopsTentara,
    format('Player ~w tidak mencukupi.', [CurrentPlayer]), nl,
    format('Jumlah Pasukan Tambahan Player ~w: ~d', [CurrentPlayer, PrevTentaraTambahan]), nl,
    write('draft Dibatalkan'), nl,!.

% Case 4: TroopsTentara is 0 or not an integer
draf(CurrentPlayer, _, TroopsTentara):-
    \+ integer(TroopsTentara), % Check if TroopsTentara is not an integer
    format('Input troops tentara harus integer.', [CurrentPlayer]), nl,
    write('draft Dibatalkan'), nl;
    TroopsTentara =< 0,
    format('Player ~w, jumlah tentara yang akan ditempatkan tidak boleh kurang dari sama dengan 0.', [CurrentPlayer]), nl,
    write('draft Dibatalkan'), nl,!.

% Case 5: Player doesn't have any troops left
draf(CurrentPlayer, _, _):-
    tentaraTambahanPlayer(CurrentPlayer, PrevTentaraTambahan),
    PrevTentaraTambahan =:= 0,
    format('Player ~w, tidak memiliki tentara tambahan.', [CurrentPlayer]), nl,
    write('draft Dibatalkan'), nl,!.
