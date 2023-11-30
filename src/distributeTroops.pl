% I.S. Pemilihan wilayah selesai
% F.S. Semua tentara tambahan user telah terdistribusi ke wilayah yang dimiliki setiap user
% Basis jika semua user telah meletakkan tentara tambahan
startDistributeTroops(0, JumlahPemain, IndexPlayer, Players) :-
  distributeRemainderTroops(0, JumlahPemain, IndexPlayer, Players).
distributeRemainderTroops(JumlahPemain, JumlahPemain, _, _) :-
  write('Seluruh pemain telah meletakkan sisa tentara.'), nl.

% Fungsi ini digunakan untuk mendistribusikan tentara yang tersisa
distributeRemainderTroops(StartIndex, JumlahPemain, IndexPlayer, Players) :- 
  % Pesan giliran siapa
  
  nth0(IndexPlayer, Players, CurrentPlayer),
  format('Giliran ~w untuk meletakkan tentaranya.', [CurrentPlayer]), nl, nl,
  % Baca perintah
  
  getCommand(Command),
  (
    Command = placeAutomatic ->
      findall(Wilayah, wilayah(Wilayah, CurrentPlayer), ListWilayah),
 % KASUS PLACE AUTOMATIC
      % Cari wilayah yg dimiliki pemain
      placeAutomatic(CurrentPlayer, ListWilayah)
    ;
    % KASUS PLACE MANUAL
    
    Command = placeManual ->
      distributeTroopsManual(CurrentPlayer)
    ;
    distributeRemainderTroops(StartIndex, JumlahPemain, IndexPlayer, Players)
  ),
  NewStartIndex is StartIndex + 1,
  NewIndexPlayer is mod(IndexPlayer + 1, JumlahPemain),
  distributeRemainderTroops(NewStartIndex, JumlahPemain, NewIndexPlayer, Players).

% Rekursi hingga command valid
getCommand(Command) :-
  repeat,
  read(Command), nl,
  (
    ( Command = placeAutomatic ; Command = placeManual )
    -> !  % Jika perintah valid, hentikan pencarian lebih lanjut
    ; write('Perintah tidak valid. Hanya ada placeAutomatic atau placeManual'), nl, nl, fail  % Jika perintah tidak valid, tampilkan pesan kesalahan dan gagalkan pencarian saat ini
  ).
