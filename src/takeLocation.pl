% Input the wilayah for the current player and continue with the next player
takeLocations(KodeNegara,Player) :-
    (\+ kodeNegara(_, KodeNegara) ->
        write('Kode tidak valid, silahkan input kode yang valid\n'), nl,
        read(KodeNegaraNew),
        takeLocations(KodeNegaraNew,Player)
        ;
        kodeNegara(Negara, KodeNegara),
        (negara(Negara)->
                kodeNegara(Negara, KodeNegara),
                (\+ wilayah(Negara, _)->
                    assertz(wilayah(Negara, Player)),
                    benua(Negara,Benua),
                    assertz(menguasai(Player,Negara,Benua)),
                    format('~w mengambil wilayah ~w\n', [Player, KodeNegara]), nl,

                    tentaraTambahanPlayer(Player, TentaraTambahan),
                    TentaraTambahanNew is TentaraTambahan - 1,
                    retract(tentaraTambahanPlayer(Player, TentaraTambahan)),
                    assertz(tentaraTambahanPlayer(Player, TentaraTambahanNew)),

                    tentaraAktifPlayer(Player, TentaraAktif),
                    TentaraAktifNew is TentaraAktif + 1,
                    retract(tentaraAktifPlayer(Player, TentaraAktif)),
                    assertz(tentaraAktifPlayer(Player, TentaraAktifNew)),

                    jumlahTentaraWilayah(Negara, Tentara),
                    TentaraNew is Tentara + 1,
                    retract(jumlahTentaraWilayah(Negara,Tentara)),
                    assertz(jumlahTentaraWilayah(Negara,TentaraNew))
                    ;
                    write('Wilayah sudah diambil oleh pemain lain, silahkan pilih wilayah lain\n'), nl,
                    read(NegaraNew),
                    takeLocations(NegaraNew,Player)        
                )
            ;
                write('Wilayah tidak valid, silahkan pilih wilayah lain\n'), nl,
                read(NegaraNew),
                takeLocations(NegaraNew,Player)
        )
    ).

% checkConquer(Player,Benua):-
%     findall(Negara, menguasai(Negara,Player,Benua), List),
%     length(List, LengthKuasai),
%     jumlahNegaraDiBenua(Benua, LengthBenua),
%     format('AMBASSING: ~d,~d',[LengthKuasai,LengthBenua]),nl,
%     (LengthKuasai = LengthBenua ->
%         assertz(conquer(Player, Benua))
%         ;
%         true
%     ).
