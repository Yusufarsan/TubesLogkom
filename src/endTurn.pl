% Fakta bonus benua
bonusBenua(northAmerica, 3).
bonusBenua(southAmerica, 2).
bonusBenua(africa, 2).
bonusBenua(europe, 3).
bonusBenua(asia, 5).
bonusBenua(australia, 1).

% Menambahkan tentara ke pemain yang memiliki benua
tambahTentaraBonus(Player, Tentara) :-
    % Mencari semua benua yang dikuasai oleh pemain
    findall(Bonus, (conquer(Player, Benua), bonusBenua(Benua, Bonus)), ListBonus),
    % Jika tidak ada benua yang dikuasai, kembalikan 0
    (   ListBonus = [] -> Tentara is 0
    ;   % Jika ada benua yang dikuasai, hitung total bonus tentara
        sum_list(ListBonus, TotalBonus),
        % Menambahkan bonus tentara ke total tentara pemain
        Tentara is TotalBonus
    ).


getNextTurn(Turn, TurnBaru, JumlahPemain) :-
    % Cek apakah player dengan turn = Turn masih ada di permainan
    turn(Player, Turn, _, _, _),
    \+ player(Player),
    % Jika tidak ada, maka giliran akan diberikan ke player selanjutnya
    NextTurn is (Turn + 1) mod JumlahPemain,
    getNextTurn(NextTurn, TurnBaru, JumlahPemain).

getNextTurn(Turn, Turn, _).
    


% Perintah endTurn
endTurns(FirstPlayer) :-
    currentPlayer(FirstPlayer, TurnLama),
    % Update turn player
    jumlahPemain(JumlahPemain),
    TurnBaru1 is (TurnLama + 1) mod JumlahPemain,
    % Cetak pesan ke console
    format('Player ~w mengakhiri giliran.~n', [FirstPlayer]), nl,
    turn(NextPlayer, TurnBaru1, _, _, _),
    getNextTurn(TurnBaru1, TurnBaru, JumlahPemain),
    retract(currentPlayer(FirstPlayer, _)),
    asserta(currentPlayer(NextPlayer, TurnBaru)),
    retract(turn(NextPlayer, TurnBaru, _, _, _)),
    asserta(turn(NextPlayer, TurnBaru, 3, 1, 1)),
    format('Sekarang giliran Player ~w!~n', [NextPlayer]),
    % Hitung jumlah wilayah yang dimiliki player
    findall(W, wilayah(W, NextPlayer), ListWilayah),
    length(ListWilayah, JumlahWilayah),
    % Hitung jumlah tentara tambahan berdasarkan jumlah wilayah
    TentaraTambahanWilayah is div(JumlahWilayah, 2),
    % Hitung bonus tentara tambahan berdasarkan benua yang dimiliki player
    % tambahTentaraBonus(NextPlayer, BonusBenua),
    (findall(Benua, (benua(W, Benua), forall(benua(Wilayah2, Benua), member(Wilayah2, ListWilayah))), BenuaList),
    list_to_set(BenuaList, BenuaSet) ->
        findall(Bonus, (member(Benua, BenuaSet), bonusBenua(Benua, Bonus)), ListBonus),
        sum_list(ListBonus, BonusBenua)
    ;
        BonusBenua is 0
    ),
    % Mendapatkan nilai auxSupTroops
    auxSupTroops(NextPlayer, AuxSupTroops),
    % Total tentara tambahan adalah jumlah tentara tambahan berdasarkan jumlah wilayah ditambah bonus benua
    TotalTentara is TentaraTambahanWilayah + BonusBenua,
    TotalTentaraTambahan is TotalTentara * AuxSupTroops,
    % Update jumlah tentara tambahan player
    tentaraTambahanPlayer(NextPlayer, TentaraTambahanSebelumnya),
    TotalTentaraTambahanUbah is TentaraTambahanSebelumnya + TotalTentaraTambahan,
    retract(tentaraTambahanPlayer(NextPlayer, _)),
    asserta(tentaraTambahanPlayer(NextPlayer, TotalTentaraTambahanUbah)), 
    format('Player ~w mendapatkan ~w tentara tambahan.~n', [NextPlayer, TotalTentaraTambahan]), 
    % Reset auxSupTroops
    retract(auxSupTroops(NextPlayer, _)),
    asserta(auxSupTroops(NextPlayer, 1)),
    % Reset superSoldier, diseaseOutbreak, dan ceaseFire
    (superSoldier(NextPlayer) -> retract(superSoldier(NextPlayer)) ; true),
    (diseaseOutbreak(NextPlayer) -> retract(diseaseOutbreak(NextPlayer)); true),
    (ceaseFire(NextPlayer) -> retract(ceaseFire(NextPlayer)); true), !.
