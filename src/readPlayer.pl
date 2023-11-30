% Buat fakta tentang jumlah tentara aktif berdasarkan jumlah pemain.
startingTentara(2, 24).
startingTentara(3, 16).
startingTentara(4, 12).

% Buat fungsi RNG, pastikan mereka unique numbers dengan menyimpan angka yang telah diambil di RolledSums (array of numbers).
dadu(Total,RolledSums):-
    random(1,7,Dice1),
    random(1,7,Dice2),
    TempTotal is Dice1 + Dice2,
    % Jika total sudah ada di RolledSums, maka ulangi lagi.
    ( member(TempTotal,RolledSums)
    -> dadu(Total,RolledSums);
    Total is TempTotal
    ).  

bacaNamaPlayer(Player,PlayerNumber):-
    format('Masukkan nama pemain ~d: ', [PlayerNumber]), nl,
    read(NewPlayer),
    (player(NewPlayer)->
            write('Nama pemain sudah ada. Silakan masukkan nama pemain lain.'), nl,
            bacaNamaPlayer(Player,PlayerNumber)
    ;
            Player = NewPlayer
    ).

% Lakukan rekursi untuk input players.
% Basis (saat jumlah pemain 0, maka tidak ada pemain yang perlu diinput)
readPlayers(0, _, _,_,[]) :- !.

% Rekursi (input pemain ke-N, lalu input pemain ke-N+1) FixedJumlahPemain untuk mempertahankan total pemain agar tidak berkurang sehingga jumlah tentara awal tetap benar, RolledSums untuk menyimpan angka yang telah diambil oleh RNG sehingga tidak ada angka yang sama,
% Players untuk menyimpan nama pemain yang telah diinput sehingga dapat diprint nanti.
readPlayers(JumlahPemain, PlayerNumber, FixedJumlahPemain, RolledSums, [Player|Players]) :-
    bacaNamaPlayer(Player,PlayerNumber),
        assertz(player(Player)),
        dadu(Urutan,RolledSums),
        assertz(hasilKocokDadu(Player,Urutan)),
        startingTentara(FixedJumlahPemain, TentaraTambahan),
        assertz(tentaraTambahanPlayer(Player, TentaraTambahan)),
        assertz(tentaraAktifPlayer(Player,0)),
        assertz(auxSupTroops(Player,1)),
        NewJumlahPemain is JumlahPemain - 1,
        NewPlayerNumber is PlayerNumber + 1,
        readPlayers(NewJumlahPemain, NewPlayerNumber, FixedJumlahPemain,[Urutan|RolledSums], Players).

% Base case (saat jumlah pemain 0, maka tidak ada pemain yang perlu diinput)
printTurns([]) :- !.
% Rekursi (print pemain ke-N, lalu print pemain ke-N+1)
printTurns([Player|Players]) :-
    hasilKocokDadu(Player,X),
    format('~w melempar dadu dan mendapatkan ~d.', [Player, X]), nl,
    printTurns(Players).

% Base case (saat urutan = jumlah pemain, stop)
tambahTurn(_,_,JumlahPemain,Urutan):-
    Urutan = JumlahPemain,!.

% Rekursi (tambah turn pemain ke-N, lalu tambah turn pemain ke-N+1)
tambahTurn(Index, Players,JumlahPemain,Urutan):-
    playerIndex(CurrentPlayer, Index, Players),
    assertz(turn(CurrentPlayer,Urutan,3,1,1)),    
    NewIndex is (Index + 1) mod JumlahPemain,
    UrutanNew is Urutan + 1,
    tambahTurn(NewIndex, Players,JumlahPemain,UrutanNew).

% Cari player dengan kocokan dadu terbesar
firstPlayer(FirstPlayer) :-
    % Cari semua Number dan masukin ke list of Numbers
    findall(Number, hasilKocokDadu(_, Number), Numbers),
    % Cari max dari list of Numbers dan simpan di MaxNumber
    max_list(Numbers, MaxNumber),
    % Cari pemain yang hasil kocok dadunya sama dengan MaxNumber
    hasilKocokDadu(FirstPlayer, MaxNumber).

% Cari player dengan index tertentu
playerIndex(Player, Index, Players) :-
    % Cari index dari pemain dan simpan di Player
    % Kalau mau make buat nyari index suatu player, cukup masukin nama Player yg indexnya mau dicari dan list of Players 
    % Kalau mau make buat nyari nama suatu player, cukup masukin index Player yg namanya mau dicari dan list of Players
    nth0(Index, Players, Player).

% Base case (setelah semua pemain memilih wilayah)
chooseLocation(24,_,_,_) :- !,
    write('Seluruh wilayah telah diambil pemain.\nMemulai pembagian sisa tentara.\n').

% Mulai pemilihan wilayah
chooseLocation(Count,Index, Players,TotalPlayers) :-
    % Ambil CurrentPlayer berdasarkan Index
    playerIndex(CurrentPlayer, Index, Players),
    % Suruh CurrentPlayer memilih wilayah
    format('Giliran ~w untuk memilih wilayahnya. ', [CurrentPlayer]), nl,
    read(KodeNegara),
    takeLocations(KodeNegara, CurrentPlayer),
    NewIndex is (Index + 1) mod TotalPlayers,
    CountNew is Count + 1,
    chooseLocation(CountNew,NewIndex, Players,TotalPlayers).

% menguasaiBenua(Player,Benua):-
%     findall(Negara, menguasai(Player,Negara,Benua), ListNegaraPlayer),
%     length(ListNegaraPlayer, JumlahNegaraPlayer),
%     jumalahNegaraDiBenua(Benua,JumlahNegara),
%     (JumlahNegaraPlayer = JumlahNegara ->
%         assertz(conquer(Player,Benua))
%     ).
