% Basis.
printList([]) :-!.
% Rekurens untuk print wilayah yang berdampingan.
printList([_-Tetangga|Countries]) :-
    format('~w.~n', [Tetangga]),
    printList(Countries).

% Fungsi untuk mengecek info suatu wilayah. 
checkLocationDetail(KodeNegara) :-
    (\+ kodeNegara(_,KodeNegara) -> 
    write('Kode tidak valid!'),nl,!
    ;
    kodeNegara(Negara,KodeNegara),
    (negara(Negara) ->
        wilayah(Negara,Owner),
        kodeNegara(Negara,Kode),
        jumlahTentaraWilayah(Negara,JumlahTentara),
        findall(Negara-Y, berdampingan(Negara,Y), List),
        write('Kode: '), write(Kode), nl,
        write('Nama: '), write(Negara), nl,
        format('Pemilik: ~w', [Owner]), nl,
        format('Jumlah Tentara: ~w', [JumlahTentara]), nl,
        write('Wilayah Berdampingan: '), nl,
        printList(List), nl,!
        ;
        write('Kode tidak valid!'),nl,!
    )
    ).