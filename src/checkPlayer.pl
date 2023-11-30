% Mengubah list menjadi set (tanpa duplikat)
list_to_set([], []).
list_to_set([H | T], [H | T1]) :- 
    subtract(T, [H], T2),
    list_to_set(T2, T1).

% Base case: An empty list should return an empty string.
display_list([], '').

% Recursive case: A list with one element should return the element itself.
display_list([Elem], Elem) :- !.

% Recursive case: A list with more than one element should return a string with the elements separated by commas.
display_list([H|T], String) :-
    display_list(T, Rest),
    swritef(String, '%w, %w', [H, Rest]).

printPlayerDetails(PlayerNumber):-
        TurnPlayer is PlayerNumber -1,
        turn(Player,TurnPlayer,_, _,_),
        % Jika player ditemukan pada dinamic fakta
        (player(Player) ->
            tentaraAktifPlayer(Player, TentaraAktif),
            tentaraTambahanPlayer(Player, TentaraTambahan),
            % Dapatkan semua wilayah yang dimiliki player
            findall(Wilayah, wilayah(Wilayah, Player), WilayahList),
            % Dapatkan semua benua yang dimiliki player jika semua wilayah pada benua dimilliki player
            (findall(Benua, (benua(Wilayah, Benua), forall(benua(Wilayah2, Benua), member(Wilayah2, WilayahList))), BenuaList),
            list_to_set(BenuaList, BenuaSet) ->
                display_list(BenuaSet, BenuaDisplay) % Menggabungkan semua benua menjadi satu string, dipisahkan oleh koma
            ;
                BenuaDisplay = 'None'
            ),
            nl,write('PLAYER P'), write(PlayerNumber), nl,nl,
            write('Nama                   : '), write(Player), nl,
            write('Benua                  : '), write(BenuaDisplay), nl, % Mencetak semua benua yang dimiliki pemain
            write('Total Wilayah          : '), length(WilayahList, TotalWilayah), write(TotalWilayah), nl,
            write('Total Tentara Aktif    : '), write(TentaraAktif), nl,
            write('Total Tentara Tambahan : '), write(TentaraTambahan), nl,nl
        ;
        % Kasus ketika player tidak ditemukan pada dinamic fakta
            write('Input bukan player'),nl,nl
        ),!.


% Detail wilayah
printPlayerTerritories(PlayerNumber):-
    TurnPlayer is PlayerNumber -1,
    turn(Player,TurnPlayer,_,_,_),
    % Jika player ditemukan pada dinamic fakta
    (player(Player) ->
        write('Nama: '), write(Player), nl,nl,
        % Dapatkan semua wilayah pada benua yang dimiliki player
        findall(Benua, (benua(Wilayah, Benua), wilayah(Wilayah, Player)), BenuaList),
        list_to_set(BenuaList, BenuaSet), 
        % Display detail willayah di setiap looping Benua
        forall(member(Benua, BenuaSet), (
            findall(Wilayah, (benua(Wilayah, Benua), wilayah(Wilayah, Player)), WilayahList),
            length(WilayahList, NumWilayah),
            findall(Wilayah, benua(Wilayah, Benua), AllWilayahList),
            length(AllWilayahList, TotalWilayah),
            write('Benua '), write(Benua), write(' ('), write(NumWilayah), write('/'), write(TotalWilayah), write(')'), nl,
            forall(member(Wilayah, WilayahList), (
                kodeNegara(Wilayah, KodeNegara),
                write(KodeNegara), nl,
                jumlahTentaraWilayah(Wilayah, JumlahTentara),
                write('Nama           : '), write(Wilayah), nl,
                write('Jumlah Tentara : '), write(JumlahTentara), nl,nl
            ))
        ))
    ;
    % Kasus ketika player tidak ditemukan pada dinamic fakta
        write('Input bukan player')
    ),!.

    printIncomingTroops(PlayerNumber):-
        TurnPlayer is PlayerNumber -1,
        turn(Player,TurnPlayer,_,_,_),
        % Jika player ditemukan pada dinamic fakta
        (player(Player) ->
        % Dapatkan semua wilayah yang dimiliki player
            findall(Wilayah, wilayah(Wilayah, Player), WilayahList),
            length(WilayahList, TotalWilayah),
            write('Nama                    : '), write(Player), nl,
            write('Total wilayah           : '), write(TotalWilayah), nl,
            % Dapatkan jumlah tentara tambahan yang akan didapatkan player berdasarkan jumlah wilayah yang dimiliki
            PredictTentaraTambahan is div(TotalWilayah,2),
            write('Jumlah tentara tambahan dari wilayah: '), write(PredictTentaraTambahan), nl,
            % Dapatkan semua benua yang dimiliki player jika semua wilayah pada benua dimilliki player
            findall(Benua, (benua(Wilayah, Benua), forall(benua(Wilayah2, Benua), member(Wilayah2, WilayahList))), BenuaList),
            list_to_set(BenuaList, BenuaSet),
            length(BenuaSet, TotalBenua),
            % Hitung bonus tentara tambahan dari benua yang dimiliki player
            % (TotalBenua > 0 -> 
            %     forall(member(BenuaGet, BenuaSet), (
            %         bonusBenua(BenuaGet, Bonus), 
            %         write('Bonus tentara benua '), write(BenuaGet), write(': '), write(Bonus), nl,
            %         PredictTentaraTambahan is PredictTentaraTambahan + Bonus
            %     ))
            %     ; 
            %     write('Bonus tentara benua '), write(': '), write(0), nl
            % ),
            write('Total tentara tambahan   : '), write(PredictTentaraTambahan), nl;
                write('Input bukan player')
            ),!.
    
    
% Check if a player has lost
checkPlayerLoss(Player) :-
    \+ wilayah(_, Player),  % The player has no territories
    player(Player),
    retract(player(Player)),  % Remove the player
    retract(tentaraTambahanPlayer(Player, _)),  % Remove the player's additional troops
    assert(tentaraTambahanPlayer(Player, 0)),  % Set the player's additional troops to 0
    write('Jumlah wilayah Player '), write(Player), write(' 0.'), nl,
    write('Player '), write(Player), write(' keluar dari permainan!'), nl.

% Check if a player has won
checkPlayerWin(Player) :-
    \+ (player(OtherPlayer), OtherPlayer \= Player),  % There are no other players
    write('******************************'), nl,
    write('*'), write(Player), write(' telah menguasai dunia*'), nl,
    write('******************************'), nl.
