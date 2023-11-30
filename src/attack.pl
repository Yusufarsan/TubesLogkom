% Wilayah mulai bukan milik attacker
attack :-
  % Dapatkan player sekarang
  currentPlayer(PlayerAttack, _),
  % Dapatkan turn player sekarang
  turn(PlayerAttack, Turn, Move, Attack, Risk),

  % Kasus attack sudah habis
  (
    Attack =:= 0 ->
      % Kasus attack sudah habis
      write('Anda sudah tidak memiliki kesempatan untuk menyerang.'), nl, nl
    ;
      % Kasus attack masih ada
      % Pesan giliran player
      format('Sekarang giliran Player ~w menyerang.', [PlayerAttack]), nl, nl,
    
      % Pilih daerah attack
      chooseDaerahMulaiAttack(PlayerAttack, DaerahAttack),
      kodeNegara(DaerahAttack, KodeDaerahAttack),
    
      % Pesan daerah mulai dan banyak tentara di daerah tersebut
      format('Player ~w ingin memulai penyerangan dari daerah ~w.', [PlayerAttack, KodeDaerahAttack]), nl,
      % Dapatkan jumlah tentara di daerah tersebut
      jumlahTentaraWilayah(DaerahAttack, TentaraTotal),
      format('Dalam daerah ~w, Anda memiliki sebanyak ~d tentara.', [KodeDaerahAttack, TentaraTotal]), nl, nl,
      
      % Pilih jumlah tentara untuk attack
      chooseTentaraAttack(DaerahAttack, TentaraAttack),
    
      % Cetak pesan total tentara dikirim + daerah yang bisa diserbu
      format('Player ~w mengirim sebanyak ~d tentara untuk berperang.', [PlayerAttack, TentaraAttack]), nl,
      % Dapatkan wilayah sekitar yang bisa diserbu
      getWilayahSekitar(DaerahAttack, WilayahSekitar),
      getWilayahSekitarBisaDiserbu(PlayerAttack, WilayahSekitar, WilayahSekitarBisaDiserbu),
      write('Pilihlah daerah yang ingin Anda serang.'), nl,
      cetakListDaerah(1, WilayahSekitarBisaDiserbu),
      
      % Pilih daerah target attack
      chooseDaerahTargetAttack(WilayahSekitarBisaDiserbu, DaerahDefend),
    
      % Start peperangan.
      startPerang(PlayerAttack, DaerahAttack, TentaraAttack, DaerahDefend)
  ).

% Get wilayah sekitar dari suatu daerah
% getWilayahSekitar(Input, Output)
getWilayahSekitar(Daerah, WilayahSekitar) :-
  findall(Wilayah, berdampingan(Daerah, Wilayah), WilayahSekitar).

% Check wilayah sekitar daerah mulai ada yang dimiliki pemain lain atau tidak
% Basis, jika tidak ada wilayah sekitar yang dimiliki pemain lain maka false
isAdaWilayahSekitarBisaDiserbu(_, []) :- false.
% Rekurens, jika ada wilayah sekitar yang dimiliki pemain lain maka true
isAdaWilayahSekitarBisaDiserbu(PlayerAttack, [Wilayah | SisaWilayah]) :-
  % Cek apakah wilayah sekitar dimiliki pemain lain
  (
    \+ wilayah(Wilayah, PlayerAttack) ->
      true
    ;
      isAdaWilayahSekitarBisaDiserbu(PlayerAttack, SisaWilayah)
  ).

% Get lists wilayah sekitar yang bisa diserbu
% Basis, jika tidak ada wilayah sekitar maka kosong
getWilayahSekitarBisaDiserbu(_, [], []).
% Rekurens
getWilayahSekitarBisaDiserbu(PlayerAttack, [Wilayah | SisaWilayah], WilayahSekitarBisaDiserbu) :-
  % Cek apakah wilayah sekitar bisa diserbu
  (
    \+ wilayah(Wilayah, PlayerAttack) ->
      % Wilayah sekitar bisa diserbu jika bukan milik attacker
      getWilayahSekitarBisaDiserbu(PlayerAttack, SisaWilayah, SisaWilayahSekitarBisaDiserbu),
      WilayahSekitarBisaDiserbu = [Wilayah | SisaWilayahSekitarBisaDiserbu]
    ;
      % Wilayah sekitar tidak bisa diserbu
      getWilayahSekitarBisaDiserbu(PlayerAttack, SisaWilayah, WilayahSekitarBisaDiserbu)
  ).

% Basis cetak List Daerah
% 1. Foo
% 2. Bar
% 3. Baz
cetakListDaerah(_, []) :- nl.
% Rekurens cetak List Daerah
cetakListDaerah(Urutan, [Wilayah | SisaWilayah]) :-
  kodeNegara(Wilayah, KodeDaerah),
  format('~w. ~w', [Urutan, KodeDaerah]), nl,
  UrutanBaru is Urutan + 1,
  cetakListDaerah(UrutanBaru, SisaWilayah).

% Input KODE NEGARA mulai attack
chooseDaerahMulaiAttack(PlayerAttack, DaerahAttack) :-
  % Pesan pilih daerah mulai attack
  write('Pilihlah daerah yang ingin Anda mulai untuk melakukan penyerangan: '),
  % Input KODE NEGARA mulai
  read(InputKodeDaerah), nl,
  (
    \+ kodeNegara(_, InputKodeDaerah) -> 
      % Daerah tidak valid
      write('Daerah tidak valid. Silahkan input kembali.'), nl, nl,
      % Ulang input
      chooseDaerahMulaiAttack(PlayerAttack, DaerahAttack)
    ;
      % Dapatkan Input Daerah
      kodeNegara(InputDaerah, InputKodeDaerah),
      (
        \+ wilayah(InputDaerah, PlayerAttack) ->
          % Daerah bukan milik attacker
          write('Daerah bukan milik Anda. Silahkan input kembali.'), nl, nl,
          chooseDaerahMulaiAttack(PlayerAttack, DaerahAttack)
        ;
          % Dapatkan wilayah sekitar
          findall(Wilayah, berdampingan(InputDaerah, Wilayah), WilayahSekitar),
          (
            \+ isAdaWilayahSekitarBisaDiserbu(PlayerAttack, WilayahSekitar) ->
              % Tidak ada wilayah sekitar yang bisa diserbu
              write('Tidak ada wilayah sekitar yang bisa diserbu. Silahkan input kembali.'), nl, nl,
              chooseDaerahMulaiAttack(PlayerAttack, DaerahAttack)
            ;
              % Validasi jumlah tentara harus > 1 di wilayah tersebut
              jumlahTentaraWilayah(InputDaerah, JumlahTentara),
              (
                JumlahTentara < 2 ->
                  % Jumlah tidak cukup untuk perang
                  write('Jumlah tentara pada negara yang ingin perang harus > 1. Silahkan input kembali.'), nl, nl,
                  chooseDaerahMulaiAttack(PlayerAttack, DaerahAttack)
                ;
                  % Negara Valid
                  % Negara milik attacker
                  % Ada wilayah sekitar yang bisa diserbu
                  % Jumlah tentara cukup untuk perang
                  DaerahAttack = InputDaerah
              )
          )
      )
  ).

% Input tentara
chooseTentaraAttack(DaerahAttack, JumlahTentara) :- 
  % Pesan pilih jumlah tentara
  write('Masukkan banyak tentara yang akan bertempur: '),
  % Input jumlah tentara
  read(InputTentara),
  (
    \+ integer(InputTentara) ->
      % Jumlah tentara bukan integer
      nl, write('Jumlah tentara harus berupa integer. Silahkan input kembali.'), nl, nl,
      chooseTentaraAttack(DaerahAttack, JumlahTentara)
    ;
      (
        InputTentara < 1 ->
          % Jumlah tentara < 1
          nl, write('Banyak tentara tidak valid. Silahkan input kembali.'), nl, nl,
          chooseTentaraAttack(DaerahAttack, JumlahTentara)
        ;
          % Dapatkan jumlah tentara di wilayah
          jumlahTentaraWilayah(DaerahAttack, TotalTentaraWilayah),
          (
            InputTentara >= TotalTentaraWilayah ->
              % Jumlah tentara >= jumlah total tentara di wilayah
              nl, write('Banyak tentara tidak valid (Ingat juga bahwa Anda harus menyisakan satu tentara di daerah asal). Silahkan input kembali.'), nl, nl,
              chooseTentaraAttack(DaerahAttack, JumlahTentara)
            ;
              % Jumlah tentara valid
              JumlahTentara = InputTentara
          )
      )
  ).

% Choose daerah target diserang
chooseDaerahTargetAttack(WilayahSekitarBisaDiserbu, DaerahDefend) :-
  % Pesan pilih daerah target
  write('Pilih: '),
  % Input daerah target
  read(InputIndexDaerah), nl,
  (
    \+ integer(InputIndexDaerah) ->
      % Input bukan integer
      write('Input harus berupa integer. Silahkan input kembali.'), nl, nl,
      chooseDaerahTargetAttack(WilayahSekitarBisaDiserbu, DaerahDefend)
    ;
      (
        InputIndexDaerah < 1 ->
          % Input < 1
          write('Input tidak valid. Silahkan input kembali.'), nl, nl,
          chooseDaerahTargetAttack(WilayahSekitarBisaDiserbu, DaerahDefend)
        ;
          length(WilayahSekitarBisaDiserbu, JumlahWilayahSekitarBisaDiserbu),
          InputIndexDaerah > JumlahWilayahSekitarBisaDiserbu ->
            % Input > panjang wilayah sekitar bisa diserbu
            write('Input tidak valid. Silahkan input kembali.'), nl, nl,
            chooseDaerahTargetAttack(WilayahSekitarBisaDiserbu, DaerahDefend)
          ;
            % Validasi RISK CEASEFIRE ORDER
            wilayah(DaerahDefend, PlayerDefend),
            (
              % Dapatkan player pemilik daerah defend
              ceasefire(PlayerDefend) ->
                % Player defend sedang cease fire
                write('Tidak bisa menyerang!'), nl,
                write('Wilayah ini dalam pengaruh CEASEFIRE ORDER.'), nl, nl,
                chooseDaerahTargetAttack(WilayahSekitarBisaDiserbu, DaerahDefend)
              ;
                % Input valid
                nth1(InputIndexDaerah, WilayahSekitarBisaDiserbu, DaerahDefend)
            )
      )
  ).

% Start perang
startPerang(PlayerAttack, DaerahAttack, TentaraAttack, DaerahDefend) :-
  % Pesan awal perang
  write('Perang telah dimulai.'), nl,

  % Kode negara attack
  kodeNegara(DaerahAttack, KodeDaerahAttack),

  % Dapatkan data defender
  wilayah(DaerahDefend, PlayerDefend),
  kodeNegara(DaerahDefend, KodeDaerahDefend),
  jumlahTentaraWilayah(DaerahDefend, TentaraDefend),
  
  % Cetak attacker
  format('Player ~w', [PlayerAttack]), nl,
  scoreAttack(1, PlayerAttack, TentaraAttack, ScoreAttack),
  format('Total score: ~d.', [ScoreAttack]), nl, nl,

  % Cetak defender
  format('Player ~w', [PlayerDefend]), nl,
  scoreAttack(1, PlayerDefend, TentaraDefend, ScoreDefend),
  format('Total score: ~d.', [ScoreDefend]), nl, nl,

  % Kasus jika attacker menang
  (
    ScoreAttack > ScoreDefend ->
      % Kasus attacker menang
      format('Player ~w menang! Wilayah ~w sekarang dikuasai oleh Player ~w.', [PlayerAttack, KodeDaerahDefend, PlayerAttack]), nl,
      format('Silahkan tentukan banyaknya tentara yang menetap di wilayah ~w.', [KodeDaerahDefend]), nl, nl,

      % Input banyak tentara stay
      tentaraStayAfterWin(DaerahDefend, TentaraAttack, TentaraStay),

      % Update dynamic variable
      % Wilayah kekuasaan defender berkurang
      % Wilayah kekuasaan attacker bertambah
      retract(wilayah(DaerahDefend, PlayerDefend)),
      assertz(wilayah(DaerahDefend, PlayerAttack)),
      % Jumlah tentara defender berkurang
      % Jumlah tentara attacker tetap, namun mungkin beberapa berpindah mungkin tidak.
      jumlahTentaraWilayah(DaerahDefend, TentaraWilayahDefendAwal),
      jumlahTentaraWilayah(DaerahAttack, TentaraWilayahAttackAwal),
      TentaraWilayahDefendBaru is TentaraStay,
      TentaraWilayahAttackBaru is TentaraWilayahAttackAwal - TentaraStay,
      retract(jumlahTentaraWilayah(DaerahDefend, TentaraWilayahDefendAwal)),
      assertz(jumlahTentaraWilayah(DaerahDefend, TentaraWilayahDefendBaru)),
      retract(jumlahTentaraWilayah(DaerahAttack, TentaraWilayahAttackAwal)),
      assertz(jumlahTentaraWilayah(DaerahAttack, TentaraWilayahAttackBaru)),

      % Cetak jumlah tentara di wilayah daerah mulai & daerah target setelah menang
      format('Tentara di wilayah ~w: ~d.', [KodeDaerahAttack, TentaraWilayahAttackBaru]), nl,
      format('Tentara di wilayah ~w: ~d.', [KodeDaerahDefend, TentaraWilayahDefendBaru]), nl, nl,

      % Validasi jika attacker menang
      checkPlayerLoss(PlayerDefend),
      checkPlayerWin(PlayerAttack),

      % Update turn
      turn(PlayerAttack, Turn, Move, Attack, Risk),
      NewAttack is 0,
      retract(turn(PlayerAttack, Turn, Move, Attack, Risk)),
      assertz(turn(PlayerAttack, Turn, Move, NewAttack, Risk))
    ;
      % Kasus attacker kalah
      format('Player ~w menang! Sayang sekali penyerangan Anda gagal :(.', [PlayerDefend]), nl, nl,

      % Update dynamic variable
      % Wilayah kekausaaan attacker & defender tidak berubah
      % Jumlah tentara attacker yang menyerang hangus karena kalah
      % Jumlah tentara defender tidak berubah.
      jumlahTentaraWilayah(DaerahAttack, TentaraWilayahAttackAwal),
      TentaraWilayahAttackBaru is TentaraWilayahAttackAwal - TentaraAttack,
      retract(jumlahTentaraWilayah(DaerahAttack, TentaraWilayahAttackAwal)),
      asserta(jumlahTentaraWilayah(DaerahAttack, TentaraWilayahAttackBaru)),

      % Cetak jumlah tentara di wilayah daerah mulai & daerah target setelah kalah
      format('Tentara di wilayah ~w: ~d.', [KodeDaerahAttack, TentaraWilayahAttackBaru]), nl,
      format('Tentara di wilayah ~w: ~d.', [KodeDaerahDefend, TentaraDefend]), nl, nl,

      % Update turn
      turn(PlayerAttack, Turn, Move, Attack, Risk),
      NewAttack is 0,
      retract(turn(PlayerAttack, Turn, Move, Attack, Risk)),
      assertz(turn(PlayerAttack, Turn, Move, NewAttack, Risk))
      
  ).

% Basis
scoreAttack(Urutan, Player, TotalTentara, Score) :-
  Urutan > TotalTentara,
  Score is 0.
  
% Rekurens
scoreAttack(Urutan, Player, TotalTentara, Score) :-
  Urutan =< TotalTentara,
  (
    superSoldier(Player) ->
      % Super soldier
      HasilDadu is 6,
      format('Dadu ~d: ~d.', [Urutan, HasilDadu]), nl,
      % Urutan berikutnya
      UrutanBaru is Urutan + 1,
      % Rekurens
      scoreAttack(UrutanBaru, Player, TotalTentara, ScoreBaru),
      % Score berikutnya
      Score is HasilDadu + ScoreBaru
    ;
    (
      diseaseOutbreak(Player) ->
        % Outbreak
        HasilDadu is 1,
        format('Dadu ~d: ~d.', [Urutan, HasilDadu]), nl,
        % Urutan berikutnya
        UrutanBaru is Urutan + 1,
        % Rekurens
        scoreAttack(UrutanBaru, Player, TotalTentara, ScoreBaru),
        % Score berikutnya
        Score is HasilDadu + ScoreBaru
      ;
        % Biasa
        % Generate dadu random 1~6
        random(1, 7, HasilDadu),
        % Cetak hasil dadu
        format('Dadu ~d: ~d.', [Urutan, HasilDadu]), nl,
        % Urutan berikutnya
        UrutanBaru is Urutan + 1,
        % Rekurens
        scoreAttack(UrutanBaru, Player, TotalTentara, ScoreBaru),
        % Score berikutnya
        Score is HasilDadu + ScoreBaru
    )
  ).

% Input berapa tentara yang stay di daerah target
tentaraStayAfterWin(DaerahDefend, TentaraAttack, TentaraStay) :-
  % Kode negara daerah defend
  kodeNegara(DaerahDefend, KodeDaerahDefend),

  % Pesan input
  format('Silahkan tentukan banyaknya tentara yang menetap di wilayah ~w: ', [KodeDaerahDefend]),
  % Input banyak tentara stay
  read(InputTentaraStay), nl,
  (
    \+ integer(InputTentaraStay) ->
      % Input bukan integer
      write('Input harus berupa integer. Silahkan input kembali.'), nl, nl,
      tentaraStayAfterWin(DaerahDefend, TentaraAttack, TentaraStay)
    ;
      (
        InputTentaraStay < 1 ->
          % Input < 1
          % Minimal 1. Karena 1 tentara harus stay di daerah target
          write('Input tidak valid. Silahkan input kembali.'), nl, nl,
          tentaraStayAfterWin(DaerahDefend, TentaraAttack, TentaraStay)
        ;
          (
            InputTentaraStay > TentaraAttack ->
              % Input jumlah tentara stay lebih besar dari pada tentara yang menyerang
              write('Input tidak valid. Silahkan input kembali.'), nl, nl,
              tentaraStayAfterWin(DaerahDefend, TentaraAttack, TentaraStay)
            ;
              % Jumlah tentara valid
              TentaraStay = InputTentaraStay
          )
      )
  ).
