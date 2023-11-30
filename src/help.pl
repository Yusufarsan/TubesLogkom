intro:-
    write('Game is starting...'), nl,nl,nl,
    write('     /$$$$$$  /$$           /$$                 /$$        /$$$$$$                                                                /$$         '),nl,
    write('    /$$__  $$| $$          | $$                | $$       /$$__  $$                                                              | $$         '),nl,
    write('   | $$  \\__/| $$  /$$$$$$ | $$$$$$$   /$$$$$$ | $$      | $$  \\__/  /$$$$$$  /$$$$$$$   /$$$$$$  /$$   /$$  /$$$$$$   /$$$$$$$ /$$$$$$   /$$ '),nl,
    write('   | $$ /$$$$| $$ /$$__  $$| $$__  $$ |____  $$| $$      | $$       /$$__  $$| $$__  $$ /$$__  $$| $$  | $$ /$$__  $$ /$$_____/|_  $$_/  |__/ '),nl,
    write('   | $$|_  $$| $$| $$  \\ $$| $$  \\ $$  /$$$$$$$| $$      | $$      | $$  \\ $$| $$  \\ $$| $$  \\ $$| $$  | $$| $$$$$$$$|  $$$$$$   | $$         '),nl,
    write('   | $$  \\ $$| $$| $$  | $$| $$  | $$ /$$__  $$| $$      | $$    $$| $$  | $$| $$  | $$| $$  | $$| $$  | $$| $$_____/ \\____  $$  | $$ /$$ /$$ '),nl,
    write('   |  $$$$$$/| $$|  $$$$$$/| $$$$$$$/|  $$$$$$$| $$      |  $$$$$$/|  $$$$$$/| $$  | $$|  $$$$$$$|  $$$$$$/|  $$$$$$$ /$$$$$$$/  |  $$$$/|__/ '),nl,
    write('    \\______/ |__/ \\______/ |_______/  \\_______/|__/       \\______/  \\______/ |__/  |__/ \\____  $$ \\______/  \\_______/|_______/    \\___/       '),nl,
    write('                                                                                             | $$                                             '),nl,
    write('                                                                                             | $$                                             '),nl,
    write('                                                                                             |__/                                             '),nl,
    write('     /$$$$$$$              /$$       /$$     /$$                  /$$$$$$                             /$$$$$$                                                                                    '),nl,
    write('   | $$__  $$            | $$      | $$    | $$                 /$$__  $$                           /$$__  $$                                                                                    '),nl,
    write('   | $$  \\ $$  /$$$$$$  /$$$$$$   /$$$$$$  | $$  /$$$$$$       | $$  \\__/  /$$$$$$   /$$$$$$       | $$  \\__/ /$$   /$$  /$$$$$$   /$$$$$$   /$$$$$$  /$$$$$$/$$$$   /$$$$$$   /$$$$$$$ /$$   /$$'),nl,
    write('   | $$$$$$$  |____  $$|_  $$_/  |_  $$_/  | $$ /$$__  $$      | $$$$     /$$__  $$ /$$__  $$      |  $$$$$$ | $$  | $$ /$$__  $$ /$$__  $$ /$$__  $$| $$_  $$_  $$ |____  $$ /$$_____/| $$  | $$'),nl,
    write('   | $$__  $$  /$$$$$$$  | $$      | $$    | $$| $$$$$$$$      | $$_/    | $$  \\ $$| $$  \\__/       \\____  $$| $$  | $$| $$  \\ $$| $$  \\__/| $$$$$$$$| $$ \\ $$ \\ $$  /$$$$$$$| $$      | $$  | $$'),nl,
    write('   | $$  \\ $$ /$$__  $$  | $$ /$$  | $$ /$$| $$| $$_____/      | $$      | $$  | $$| $$             /$$  \\ $$| $$  | $$| $$  | $$| $$      | $$_____/| $$ | $$ | $$ /$$__  $$| $$      | $$  | $$'),nl,
    write('   | $$$$$$$/|  $$$$$$$  |  $$$$/  |  $$$$/| $$|  $$$$$$$      | $$      |  $$$$$$/| $$            |  $$$$$$/|  $$$$$$/| $$$$$$$/| $$      |  $$$$$$$| $$ | $$ | $$|  $$$$$$$|  $$$$$$$|  $$$$$$$'),nl,
    write('   |_______/  \\_______/   \\___/     \\___/  |__/ \\_______/      |__/       \\______/ |__/             \\______/  \\______/ | $$____/ |__/       \\_______/|__/ |__/ |__/ \\_______/ \\_______/ \\____  $$'),nl,
    write('                                                                                                                       | $$                                                             /$$  | $$'),nl,
    write('                                                                                                                       | $$                                                            |  $$$$$$/'),nl,
    write('                                                                                                                       |__/                                                             \\______/ '),nl,
    write('Created by: DewoLover'), nl,
    menu.

menu:-
    nl,
    write('Menu: '),nl,
    write('1. Display Map'), nl,
    write('2. List Kode Negara'), nl,
    write('3. Start Game'), nl,
    read(Input),
    option(Input).

printKodeNegara([]).
printKodeNegara([H|T]):-
    write(H),nl,
    printKodeNegara(T).

option(Input):-
    (
    Input = 1 -> displayMap,menu, nl;
    Input = 2 ->write('Berikut adalah list kode negara beserta negaranya: '),nl,
                findall(KodeNegara-Negara, kodeNegara(Negara,KodeNegara),ListKodeNegara),
                printKodeNegara(ListKodeNegara),menu,nl
    ;       
    Input = 3 ->write('Loading...'),nl;
    write('Invalid option'), nl, 
    menu).

bantuan :-
        write('Here are the available commands:'), nl,
        write('1. startGame'), nl,
        write('2. displayMap'), nl,
        write('3. endTurn'), nl,
        write('4. draft(KodeWilayah, JumlahTentara)'), nl,
        write('5. move(WilayahAsal, WilayahTujuan, JumlahTentara)'), nl,
        write('6. attack'), nl,
        write('7. risk'), nl,
        write('8. checkLocationDetail(KodeNegara)'), nl,
        write('9. checkPlayerDetail(NumberPlayer)'), nl,
        write('10. checkPlayerTerritories(NumberPlayer)'), nl,
        write('11. checkIncomingTroops(NumberPlayer)'), nl,
        write('12. cheat ForceTakeLocation : bacinSenpai'), nl,
        write('13. cheat UnlimitedTentaraTambahan : dewoLover'), nl,
        write('14. listWilayah'), nl.

listWilayah:-
    write('Berikut adalah list kode negara beserta negaranya: '),nl,
            findall(KodeNegara-Negara, kodeNegara(Negara,KodeNegara),ListKodeNegara),
            printKodeNegara(ListKodeNegara),nl.