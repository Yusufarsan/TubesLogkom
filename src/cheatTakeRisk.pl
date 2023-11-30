kosongDuaEmpat:-
    write('Cheat Code Activated'), nl,
    write('Masukkan nama player:'), nl,
    read(Nama),
    (player(Nama) ->
        write('Masukkan nama risk yang diinginkan DENGAN FORMAT LOWERCASE, GUNAKAN UNDERSCORE SEBAGAI PENGGANTI SPASI:'), nl,
        read(Risk),
        (get_risk(_,Risk) ->
            proses_cheat_risk(Nama,Risk), nl
            ;
            write('Risk tidak ditemukan'), nl
        )
        ;
        write('Player tidak ditemukan'), nl, !
    ).

% JenisRisk = 'ceasefire_order' -> 
proses_cheat_risk(Nama,JenisRisk) :- 
    JenisRisk == 'ceasefire_order',
    
    % Inti proses_cheat_risk
    asserta(ceasefire(Nama)), nl, 
    format('Player ~w mendapatkan risk card CEASEFIRE ORDER.', [Nama]), nl,
    write('Hingga giliran berikutnya, wilayah pemain tidak dapat diserang oleh lawan.'), nl,
    
    !.

% JenisRisk = 'super_soldier_serum' ->
proses_cheat_risk(Nama,JenisRisk) :- 
    JenisRisk = 'super_soldier_serum',
    
    % Inti proses_cheat_risk
    asserta(superSoldier(Nama)), nl,
    format('Player ~w mendapatkan risk card SUPER SOLDIER SERUM.', [Nama]), nl,
    write('Hingga giliran berikutnya,\nsemua hasil lemparan dadu saat penyerangan dan pertahanan akan bernilai 6.'), nl,
    
    !.

% JenisRisk = 'auxiliary_troops' ->
proses_cheat_risk(Nama,JenisRisk) :- 
    JenisRisk = 'auxiliary_troops',
    
    % Inti proses_cheat_risk
    auxSupTroops(Nama, Multiply),
    NewMultiply is 2,
    retract(auxSupTroops(Nama, Multiply)),
    asserta(auxSupTroops(Nama, NewMultiply)),
    format('Player ~w mendapatkan risk card AUXILIARY TROOPS.', [Nama]), nl,
    write('Pada giliran berikutnya,\ntentara tambahan yang didapatkan pemain akan bernilai 2 kali lipat.'), nl,
    
    !.

% JenisRisk = 'rebellion' ->
proses_cheat_risk(Nama,JenisRisk) :- 
    JenisRisk = 'rebellion',
    
    % Inti proses_cheat_risk
    nl,
    findall(Wilayah, wilayah(Wilayah, Nama), WilayahList),     % Dapatkan semua wilayah yang dimiliki player
    random_permutation(WilayahList, [Head|_]),                 % Randomize urutan list wilayah dan mengambil headnya
    retract(wilayah(Head, Nama)),                              % Menghapus kepemilikan wilayah Head dari Nama
    randomize_player_for_cheat(Nama, RandomizedPlayer),                  % Ngedapetin player random selain Nama
    asserta(wilayah(Head, RandomizedPlayer)),                  % Memperbarui kepemilikan wilayah Head ke RandomizedPlayer
    kodeNegara(Head, KodeNegara),
    format('Player ~w mendapatkan risk card REBELLION.', [Nama]), nl,
    write('Salah satu wilayah acak pemain akan berpindah kekuasaan menjadi milik lawan.'), nl, nl,
    format('Wilayah ~w sekarang dikuasai oleh Player ~w', [KodeNegara, Nama]), nl,
    
    !.

% JenisRisk = 'disease_outbreak' ->
proses_cheat_risk(Nama,JenisRisk) :- 
    JenisRisk = 'disease_outbreak',
    
    % Inti proses_cheat_risk
    asserta(diseaseOutbreak(Nama)), nl,
    format('Player ~w mendapatkan risk card DISEASE OUTBREAK.', [Nama]), nl,
    write('Hingga giliran berikutnya,\nsemua hasil lemparan dadu saat penyerangan dan pertahanan akan bernilai 1.'), nl, 
    
    !.

% JenisRisk = 'supply_chain_issue' ->
proses_cheat_risk(Nama,JenisRisk) :- 
    JenisRisk = 'supply_chain_issue',
    
    % Inti proses_cheat_risk
    auxSupTroops(Nama, Multiply),
    NewMultiply is 0,
    retract(auxSupTroops(Nama, Multiply)),
    asserta(auxSupTroops(Nama, NewMultiply)),
    format('Player ~w mendapatkan risk card SUPPLY CHAIN ISSUE.', [Nama]), nl,
    write('Pada giliran berikutnya,\npemain tidak mendapatkan tentara tambahan'), nl,

    !.


% Rules tambahan untuk randomize player selain CurrentPlayer
randomize_player_for_cheat(CurrentPlayer, RandomizedPlayer) :-
    findall(Player, player(Player), PlayerList),
    delete(PlayerList, CurrentPlayer, RandomizedPlayerList),
    random_permutation(RandomizedPlayerList, [RandomizedPlayer|_]).