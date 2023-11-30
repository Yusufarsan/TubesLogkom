% Kondisi awal
% Semua wilayah pasti dimiliki tiap orang (total 24 wilayah)
% 2 Player: tiap orang miliki 12 wilayah
% 3 Player: tiap orang miliki 8 wilayah
% 4 Player: tiap orang miliki 6 wilayah
% Setiap orang memiliki jumlah troops awal
% 2 Player: 24
% 3 Player: 16
% 4 Player: 12
% I.S. Setiap player memiliki jumlah tentara tambahan = jmlh tentara tambahan default - 1
% F.S. Setiap player memiliki jumlah tentara tambahan = 0 dibagi-bagi ke setiap wilayah yang dipunyai

% Base case
% Kasus wilayah sudah di iterate semua
placeAutomatic(CurrentPlayer, []) :-
  format('Seluruh tentara ~w sudah diletakkan.', [CurrentPlayer]), nl, nl. % Cetak pesan

% Rekurens
% Kasus wilayah belum di iterate semua
placeAutomatic(CurrentPlayer, [Wilayah | SisaWilayah]) :-
  % Cari jumlah tentara tambahan awal dari player
  kodeNegara(Wilayah, KodeNegara),
  tentaraTambahanPlayer(CurrentPlayer, TentaraTambahanAwal),
  (
    TentaraTambahanAwal =:= 0 ->
      % KASUS TENTARA TAMBAHAN SUDAH HABIS
      % Cetak pesan
      format('~w meletakkan 0 tentara di wilayah ~w', [CurrentPlayer, KodeNegara]), nl,
      % Lanjut ke wilayah selanjutnya
      placeAutomatic(CurrentPlayer, SisaWilayah)
    ;
      % KASUS TENTARA TAMBAHAN BELUM HABIS
      (
        SisaWilayah = [] -> 
          % KASUS WILAYAH TERAKHIR, DEPLOY SISANYA
          JumlahDeploy is TentaraTambahanAwal,
          format('~w meletakkan ~d tentara di wilayah ~w', [CurrentPlayer, JumlahDeploy, KodeNegara]), nl,
          % Update jumlah tentara player
          TentaraTambahanAkhir is 0,
          retract(tentaraTambahanPlayer(CurrentPlayer, TentaraTambahanAwal)),
          assertz(tentaraTambahanPlayer(CurrentPlayer, TentaraTambahanAkhir)),
          % Update jumlah tentara wilayah
          jumlahTentaraWilayah(Wilayah, TentaraAktifAwal),
          TentaraAktifAkhir is TentaraAktifAwal + JumlahDeploy,
          retract(jumlahTentaraWilayah(Wilayah, TentaraAktifAwal)),
          assertz(jumlahTentaraWilayah(Wilayah, TentaraAktifAkhir)),
          % Lanjut ke wilayah selanjutnya
          placeAutomatic(CurrentPlayer, SisaWilayah)
        ;
          % KASUS WILAYAH BUKAN TERAKHIR, DEPLOY RANDOM
          % Dapatkan random angka dari 1 sampai jumlah tentara tambahan
          BatasRandom is TentaraTambahanAwal + 1,
          random(1, BatasRandom, JumlahDeploy),
          % Cetak pesan
          format('~w meletakkan ~d tentara di wilayah ~w', [CurrentPlayer, JumlahDeploy, KodeNegara]), nl,
          % Update jumlah tentara player
          TentaraTambahanAkhir is TentaraTambahanAwal - JumlahDeploy,
          retract(tentaraTambahanPlayer(CurrentPlayer, TentaraTambahanAwal)),
          assertz(tentaraTambahanPlayer(CurrentPlayer, TentaraTambahanAkhir)),
          % Update jumlah tentara wilayah
          jumlahTentaraWilayah(Wilayah, TentaraAktifAwal),
          TentaraAktifAkhir is TentaraAktifAwal + JumlahDeploy,
          retract(jumlahTentaraWilayah(Wilayah, TentaraAktifAwal)),
          assertz(jumlahTentaraWilayah(Wilayah, TentaraAktifAkhir)),
          % Lanjut ke wilayah selanjutnya
          placeAutomatic(CurrentPlayer, SisaWilayah)
      )
  ).
