% Import predicates
:- include('attack.pl').
:- include('cheatAmbilPaksa.pl').
:- include('cheatUnlimitedTentara.pl').
:- include('checkPlayer.pl').
:- include('distributeTroops.pl').
:- include('draftTroops.pl').
:- include('endTurn.pl').
:- include('help.pl').
:- include('infoWilayah.pl').
:- include('jumlahPlayer.pl'). 
:- include('map.pl').  
:- include('move.pl').
:- include('placeAutomatic.pl').
:- include('placeManual.pl').
:- include('readPlayer.pl').
:- include('risk.pl').
:- include('takeLocation.pl').
:- include('cheatTakeRisk.pl').  

% Fakta tentang jumlah pemain
:-dynamic(jumlahPemain/1).
% Buat fakta tentang player, /1 menandakan bahwa player adalah fakta dengan 1 argumen.
:-dynamic(player/1).    % player(Player)
% tentaraAktifPlayer/2 berisi nama pemain dan jumlah tentara aktif yang dimiliki
:-dynamic(tentaraAktifPlayer/2).    % tentaraAktifPlayer(Player, JumlahTentara)
% tentaraTambahanPlayer/2 berisi nama pemain dan jumlah tentara tambahan yang dimiliki
:-dynamic(tentaraTambahanPlayer/2).     % tentaraTambahanPlayer(Player, JumlahTentara)
% hasilKocokDadu/2 berisi nama pemain dan hasil kocokan dadu yang dimiliki
:-dynamic(hasilKocokDadu/2).    % hasilKocokDadu(Player, HasilKocokDadu)
% Buat fakta dinamis untuk wilayah yang berisi nama wilayah dan pemiliknya
:-dynamic(wilayah/2).   % wilayah(Wilayah, Player)
% Buat fakta dinamis untuk jumlah tentara yang berisi nama wilayah dan jumlah tentara yang ada di wilayah
:-dynamic(jumlahTentaraWilayah/2).  % jumlahTentaraWilayah(Wilayah, JumlahTentara)
% Buat fakta dinamis untuk turn player yang berisi nama player dan turn nya (turn = 0 berarti giliran pertama, turn = 1 berarti giliran kedua, dst)
:-dynamic(turn/5).  % turn(Player, Turn, Move, Attack, Risk)
% Fakta untuk mengetahui player sudah menguasai negara + benuanya
:-dynamic(menguasai/3). % (Player, Wilayah, Benua)
% Fakta untuk mengetahui player sudah menguasai benua apa aja
:-dynamic(conquer/2). %(player,benua yang dikuasai)
% Fakta untuk mengetahui player yang lagi giliran
:-dynamic(currentPlayer/2). % currentPlayer(Player, Turn atau Index)

%%% Fakta dynamic yang berkaitan dengan RISK %%%
% Fakta untuk mengetahui player mendapatkan risk Ceasefire Order atau tidak
:-dynamic(ceasefire/1). % ceasefire(Player)
% Fakta untuk mengetahui player mendapatkan risk Super Soldier Serum atau tidak
:-dynamic(superSoldier/1). % superSoldier(Player)
% Fakta untuk mengetahui player mendapatkan risk Auxiliary Troops / Supply Chain Issue atau tidak (itu parameter Multiply di suruh ama bacin)
:-dynamic(auxSupTroops/2). % auxSupTroops(Player, Multiply)
% Fakta untuk mengetahui player mendapatkan risk Disease Outbreak atau tidak
:-dynamic(diseaseOutbreak/1). % diseaseOutbreak(Player)


% Call displayMaps
displayMap :-
    displayMaps.

help:-
    bantuan.

startGame :-
    retractall(jumlahPemain(_)),
    retractall(player(_)),
    retractall(tentaraAktifPlayer(_,_)),
    retractall(tentaraTambahanPlayer(_,_)),
    retractall(hasilKocokDadu(_,_)),
    retractall(wilayah(_,_)),
    retractall(jumlahTentaraWilayah(_,_)),
    retractall(turn(_,_,_,_,_)),
    retractall(menguasai(_,_,_)),
    retractall(conquer(_,_)),
    retractall(currentPlayer(_,_)),
    initializeTentaraAwalWilayah,
    intro,
    write('Masukkan jumlah pemain: '),
    getPlayer(JumlahPemain),
    readPlayers(JumlahPemain, 1, JumlahPemain,[], Players),
    nl,
    printTurns(Players), 
    % Find the first player
    firstPlayer(FirstPlayer),
    % Find the index of the first player
    playerIndex(FirstPlayer, Index, Players),
    % Tambahin fakta buat turn player
    tambahTurn(Index, Players, JumlahPemain, 0),
    findall(Player, turn(Player,_,_,_,_), ListPlayer),nl,
    format('Berikut urutan player: ~w~n', [ListPlayer]),nl,  
    assertz(currentPlayer(FirstPlayer, 0)),
    % Play the game for a certain number of turns
    chooseLocation(0, Index, Players,JumlahPemain),
    startDistributeTroops(0, JumlahPemain, Index, Players),
    turn(FirstPlayer, 0,_,_,_),
    currentPlayer(FirstPlayer, 0),
    nl,
    format('Giliran pertama dimulai oleh ~w~n', [FirstPlayer]).


checkPlayerDetail(NumberPlayer) :-
    printPlayerDetails(NumberPlayer).

checkPlayerTerritories(NumberPlayer) :-
    printPlayerTerritories(NumberPlayer).

checkIncomingTroops(NumberPlayer):-
    printIncomingTroops(NumberPlayer).
    
    
draft(KodeWilayah, TroopsTentara) :-
    currentPlayer(CurrentPlayer, _),
    kodeNegara(Wilayah, KodeWilayah) -> 
    draf(CurrentPlayer, Wilayah, TroopsTentara);
    write('Kode Wilayah tidak valid!'), nl,!.

endTurn :-
    currentPlayer(CurrentPlayer, _),
    endTurns(CurrentPlayer).