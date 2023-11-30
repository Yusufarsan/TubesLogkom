distributeTroopsManual(CurrentPlayer):-
    tentaraTambahanPlayer(CurrentPlayer, PrevTentaraTambahan),
    % Tentara tambahan harus ada
    (PrevTentaraTambahan > 0 ->
        write('Masukkan kode lokasi tujuan tentara dialokasikan: '),
        read(KodeWilayah),
        (kodeNegara(Wilayah, KodeWilayah) ->
            % Case wilayah input milik player
            (wilayah(Wilayah, CurrentPlayer) ->
                write('Masukkan jumlah tentara yang akan dialokasikan: '),
                read(TroopsTentara),
                (integer(TroopsTentara) -> % Check if TroopsTentara is an integer
                    (tentaraTambahanPlayer(CurrentPlayer, PrevTentaraTambahan),
                % Case jumlah tentara yang akan di deploy tidak melebihi jumlah tentara tambahan
                    PrevTentaraTambahan >= TroopsTentara, TroopsTentara > 0 ->
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
                    % Display succes

                        format('Player ~w meletakkan ~d tentara tambahan di ~w.', [CurrentPlayer, TroopsTentara, Wilayah]), nl,
                        distributeTroopsManual(CurrentPlayer)
                    ;
                % Case jumlah tentara yang akan di deploy 0
                        TroopsTentara =< 0 ->
                            format('Player ~w, jumlah tentara yang akan ditempatkan tidak boleh kurang dari sama dengan 0.', [CurrentPlayer]), nl,
                            write('Place Troops Dibatalkan'), nl,
                            distributeTroopsManual(CurrentPlayer)
                        ;
                    % Case jumlah tentara yang akan di deploy melebihi jumlah tentara tambahan
                            format('Jumlah Alokasi terlalu banyak, jumlah tentara tambahan tersisa: ~w.',[PrevTentaraTambahan]), nl,
                            write('Place Troops Dibatalkan'), nl,
                            distributeTroopsManual(CurrentPlayer)
                    )
                ;
            % Case wilayah input bukan milik player
                    write('Input harus integer'), nl, % Output message if TroopsTentara is not an integer
                    write('Place Troops Dibatalkan'), nl,
                    distributeTroopsManual(CurrentPlayer)
                )
            ;
                format('Wilayah tidak valid bukan milik ~w.',[CurrentPlayer]), nl,
                distributeTroopsManual(CurrentPlayer)
            )
        ;
        % Case wilayah tidak ditemukan
            write('Wilayah tidak ada'), nl,
            distributeTroopsManual(CurrentPlayer)
        )
    ;
    % Case tentara tambahan  0 sudah dialokasikan 
        format('Semua tentara tambahan ~w sudah dialokasikan.', [CurrentPlayer]), nl, nl
    ).
