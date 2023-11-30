bacinSenpai:-
    write('Cheat Code Activated'), nl,
    write('Masukkan nama player:'), nl,
    read(Nama),
    (player(Nama) ->
        write('Masukkan NAMA WILAYAH (BUKAN KODE) yang ingin diambil paksa:'), nl,
        read(Negara),
        (negara(Negara) ->
            menguasai(Nama, Negara, Benua),
            retract(wilayah(Negara, _)),
            retract(menguasai(Nama, Negara,_)),
            asserta(menguasai(Nama, Negara, Benua)),
            asserta(wilayah(Negara, Nama)),
            format('~w now belongs to ~w', [Negara,Nama]), nl
            ;
            write('Wilayah tidak ditemukan'), nl
        )
        ;
        write('Player tidak ditemukan'), nl, !
    ).