dewoLover:-
    write('Cheat Code Activated'), nl,
    write('Masukkan nama player:'), nl,
    read(Nama),
    (player(Nama) ->
        write('Masukkan jumlah tentara yang diinginkan:'), nl,
        read(X),
        integer(X),
        retract(tentaraTambahanPlayer(Nama, _)),
        asserta(tentaraTambahanPlayer(Nama, X)),
        format('Jumlah Tentara Tambahan anda yang baru adalah ~d', [X]), nl
    ;
        write('Player tidak ditemukan'), nl, !
    ).
