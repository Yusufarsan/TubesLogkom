getPlayer(X) :-
    read(X),
    integer(X),
    X >= 2,
    X =< 4,
    assertz(jumlahPemain(X)),!.

getPlayer(X) :-
    write('Mohon masukkan angka antara 2 - 4.\n'),
    write('Masukkan jumlah pemain: '),
    getPlayer(X).