% Perintah risk bersifat opsional dan pemain hanya dapat memanggilnya sekali tiap giliran

% Nge random 6 jenis risk (Ceasefire order, Super soldier serum, Auxiliary Troops, Rebellion, Disease outbreak, Supply chain issue)
random_risk(JenisRisk) :-
    random(1, 7, RandomNumber),  % Generates a random number between 1 and 6
    get_risk(RandomNumber, JenisRisk).

% Definisi tiap representasi angka dengan risk
get_risk(1, 'ceasefire_order').
get_risk(2, 'super_soldier_serum').
get_risk(3, 'auxiliary_troops').
get_risk(4, 'rebellion').
get_risk(5, 'disease_outbreak').
get_risk(6, 'supply_chain_issue').

% Risk == 0, tidak bisa mengambil risk
risk :- 
    currentPlayer(CurrentPlayer, _), % Dapatkan pemain yang sedang giliran
    turn(CurrentPlayer, _, _, _, Risk), 
    Risk =:= 0,
    nl,
    format('~w sudah pernah memanggil risk.', [CurrentPlayer]), nl,
    write('Pemain hanya dapat memanggil risk maksimum sekali tiap giliran.'), nl,
    write('Tunggu giliran berikutnya untuk dapat memanggil risk.'), nl,
    !.

% Fungsi risk yang awal-awal
risk :-
    random_risk(JenisRisk),
    proses_risk(JenisRisk).

% JenisRisk = 'ceasefire_order' -> 
proses_risk(JenisRisk) :- 
    JenisRisk == 'ceasefire_order',
    currentPlayer(CurrentPlayer, _), % Dapatkan pemain yang sedang giliran
    turn(CurrentPlayer, _, _, _, Risk), 
    
    % Inti proses_risk
    asserta(ceasefire(CurrentPlayer)), nl, 
    format('Player ~w mendapatkan risk card CEASEFIRE ORDER.', [CurrentPlayer]), nl,
    write('Hingga giliran berikutnya, wilayah pemain tidak dapat diserang oleh lawan.'), nl,
    
    % Mengurangi jumlah Risk
    NewRisk is Risk - 1,
    retract(turn(CurrentPlayer, Turn, Move, Attack, Risk)),
    assertz(turn(CurrentPlayer, Turn, Move, Attack, NewRisk)),
    !.

% JenisRisk = 'super_soldier_serum' ->
proses_risk(JenisRisk) :- 
    JenisRisk = 'super_soldier_serum',
    currentPlayer(CurrentPlayer, _),
    turn(CurrentPlayer, Turn, Move, Attack, Risk),
    
    % Inti proses_risk
    asserta(superSoldier(CurrentPlayer)), nl,
    format('Player ~w mendapatkan risk card SUPER SOLDIER SERUM.', [CurrentPlayer]), nl,
    write('Hingga giliran berikutnya,\nsemua hasil lemparan dadu saat penyerangan dan pertahanan akan bernilai 6.'), nl,
    
    % Mengurangi jumlah Risk
    NewRisk is Risk - 1,
    retract(turn(CurrentPlayer, Turn, Move, Attack, Risk)),
    assertz(turn(CurrentPlayer, Turn, Move, Attack, NewRisk)),
    !.

% JenisRisk = 'auxiliary_troops' ->
proses_risk(JenisRisk) :- 
    JenisRisk = 'auxiliary_troops',
    currentPlayer(CurrentPlayer, _),
    turn(CurrentPlayer, Turn, Move, Attack, Risk),
    
    % Inti proses_risk
    auxSupTroops(CurrentPlayer, Multiply),
    NewMultiply is 2,
    retract(auxSupTroops(CurrentPlayer, Multiply)),
    asserta(auxSupTroops(CurrentPlayer, NewMultiply)),
    format('Player ~w mendapatkan risk card AUXILIARY TROOPS.', [CurrentPlayer]), nl,
    write('Pada giliran berikutnya,\ntentara tambahan yang didapatkan pemain akan bernilai 2 kali lipat.'), nl,
    
    % Mengurangi jumlah Risk
    NewRisk is Risk - 1,
    retract(turn(CurrentPlayer, Turn, Move, Attack, Risk)),
    assertz(turn(CurrentPlayer, Turn, Move, Attack, NewRisk)),
    !.

% JenisRisk = 'rebellion' ->
proses_risk(JenisRisk) :- 
    JenisRisk = 'rebellion',
    currentPlayer(CurrentPlayer, _),
    turn(CurrentPlayer, Turn, Move, Attack, Risk),
    
    % Inti proses_risk
    nl,
    findall(Wilayah, wilayah(Wilayah, CurrentPlayer), WilayahList),     % Dapatkan semua wilayah yang dimiliki player
    random_permutation(WilayahList, [Head|_]),                          % Randomize urutan list wilayah dan mengambil headnya
    retract(wilayah(Head, CurrentPlayer)),                              % Menghapus kepemilikan wilayah Head dari CurrentPlayer
    randomize_player(CurrentPlayer, RandomizedPlayer),                  % Ngedapetin player random selain CurrentPlayer
    asserta(wilayah(Head, RandomizedPlayer)),                           % Memperbarui kepemilikan wilayah Head ke RandomizedPlayer
    kodeNegara(Head, KodeNegara),
    format('Player ~w mendapatkan risk card REBELLION.', [CurrentPlayer]), nl,
    write('Salah satu wilayah acak pemain akan berpindah kekuasaan menjadi milik lawan.'), nl, nl,
    format('Wilayah ~w sekarang dikuasai oleh Player ~w', [KodeNegara, CurrentPlayer]), nl,
    
    % Mengurangi jumlah Risk
    NewRisk is Risk - 1,
    retract(turn(CurrentPlayer, Turn, Move, Attack, Risk)),
    assertz(turn(CurrentPlayer, Turn, Move, Attack, NewRisk)),
    !.

% JenisRisk = 'disease_outbreak' ->
proses_risk(JenisRisk) :- 
    JenisRisk = 'disease_outbreak',
    currentPlayer(CurrentPlayer, _),
    turn(CurrentPlayer, Turn, Move, Attack, Risk),
    
    % Inti proses_risk
    asserta(diseaseOutbreak(CurrentPlayer)), nl,
    format('Player ~w mendapatkan risk card DISEASE OUTBREAK.', [CurrentPlayer]), nl,
    write('Hingga giliran berikutnya,\nsemua hasil lemparan dadu saat penyerangan dan pertahanan akan bernilai 1.'), nl, 
    
    % Mengurangi jumlah Risk
    NewRisk is Risk - 1,
    retract(turn(CurrentPlayer, Turn, Move, Attack, Risk)),
    assertz(turn(CurrentPlayer, Turn, Move, Attack, NewRisk)),
    !.

% JenisRisk = 'supply_chain_issue' ->
proses_risk(JenisRisk) :- 
    JenisRisk = 'supply_chain_issue',
    currentPlayer(CurrentPlayer, _),
    turn(CurrentPlayer, Turn, Move, Attack, Risk),
    
    % Inti proses_risk
    auxSupTroops(CurrentPlayer, Multiply),
    NewMultiply is 0,
    retract(auxSupTroops(CurrentPlayer, Multiply)),
    asserta(auxSupTroops(CurrentPlayer, NewMultiply)),
    format('Player ~w mendapatkan risk card SUPPLY CHAIN ISSUE.', [CurrentPlayer]), nl,
    write('Pada giliran berikutnya,\npemain tidak mendapatkan tentara tambahan'), nl,
    
    % Mengurangi jumlah Risk
    NewRisk is Risk - 1,
    retract(turn(CurrentPlayer, Turn, Move, Attack, Risk)),
    assertz(turn(CurrentPlayer, Turn, Move, Attack, NewRisk)),
    !.



% Rules tambahan untuk randomize player selain CurrentPlayer
randomize_player(CurrentPlayer, RandomizedPlayer) :-
    findall(Player, player(Player), PlayerList),
    delete(PlayerList, CurrentPlayer, RandomizedPlayerList),
    random_permutation(RandomizedPlayerList, [RandomizedPlayer|_]).