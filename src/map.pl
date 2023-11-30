benua(usa, northAmerica).
benua(canada, northAmerica).
benua(bermuda, northAmerica).
benua(guatemala, northAmerica).
benua(panama, northAmerica).
benua(brazil, southAmerica).
benua(argentine, southAmerica).
benua(uganda, africa).
benua(libya, africa).
benua(egypt, africa).
benua(germany, europe).
benua(france, europe).
benua(ukraine, europe).
benua(rusia, europe).
benua(unitedKingdom, europe).
benua(australia, australia).
benua(newZealand, australia).
benua(northKorea, asia).
benua(southKorea, asia).
benua(palestine,asia).
benua(indonesia,asia).
benua(israel,asia).
benua(china,asia).
benua(unitedArabEmirates,asia).

negara(canada).
negara(usa).
negara(bermuda).
negara(guatemala).
negara(panama).
negara(unitedKingdom).
negara(france).
negara(germany).
negara(ukraine).
negara(rusia).
negara(brazil).
negara(argentine).
negara(uganda).
negara(libya).
negara(egypt).
negara(newZealand).
negara(australia).
negara(northKorea).
negara(palestine).
negara(indonesia).
negara(unitedArabEmirates).
negara(china).
negara(southKorea).
negara(israel).

kodeNegara(canada,na1).
kodeNegara(usa,na2).
kodeNegara(bermuda,na3).
kodeNegara(guatemala,na4).
kodeNegara(panama,na5).
kodeNegara(unitedKingdom,eu1).
kodeNegara(france,eu2).
kodeNegara(germany,eu3).
kodeNegara(ukraine,eu4).
kodeNegara(rusia,eu5).
kodeNegara(brazil,sa1).
kodeNegara(argentine,sa2).
kodeNegara(uganda,af1).
kodeNegara(libya,af2).
kodeNegara(egypt,af3).
kodeNegara(newZealand,au2).
kodeNegara(australia,au1).
kodeNegara(northKorea,asia1).
kodeNegara(palestine,asia2).
kodeNegara(indonesia,asia024).
kodeNegara(unitedArabEmirates,asia3).
kodeNegara(china,asia4).
kodeNegara(southKorea,asia5).
kodeNegara(israel,asia6).

jumlahNegaraDiBenua(northAmerica,5).
jumlahNegaraDiBenua(southAmerica,2).
jumlahNegaraDiBenua(africa,3).
jumlahNegaraDiBenua(europe,5).
jumlahNegaraDiBenua(australia,2).
jumlahNegaraDiBenua(asia,7).

berdampingan(canada, usa).
berdampingan(canada,unitedKingdom).

berdampingan(usa, canada).
berdampingan(usa, bermuda).
berdampingan(usa, unitedKingdom).

berdampingan(bermuda, usa).
berdampingan(bermuda,guatemala).
berdampingan(bermuda, panama).

berdampingan(guatemala, bermuda).
berdampingan(guatemala, panama).

berdampingan(panama, bermuda).
berdampingan(panama, brazil).
berdampingan(panama, guatemala).

berdampingan(unitedKingdom, usa).
berdampingan(unitedKingdom, france).
berdampingan(unitedKingdom, canada).
berdampingan(unitedKingdom, ukraine).

berdampingan(france, unitedKingdom).
berdampingan(france, germany).
berdampingan(france, ukraine).
berdampingan(france,rusia).

berdampingan(germany, ukraine).
berdampingan(germany, france).

berdampingan(ukraine, france).
berdampingan(ukraine, germany).
berdampingan(ukraine,unitedKingdom).

berdampingan(rusia, france).
berdampingan(rusia, israel).

berdampingan(israel, china).
berdampingan(israel,palestine).

berdampingan(palestine,indonesia).
berdampingan(palestine,israel).
berdampingan(palestine,unitedArabEmirates).
berdampingan(palestine,egypt).

berdampingan(indonesia,china).

berdampingan(china,israel).
berdampingan(china,northKorea).
berdampingan(china,southKorea).

berdampingan(northKorea,china).
berdampingan(northKorea,southKorea).

berdampingan(southKorea,northKorea).
berdampingan(southKorea,newZealand).

berdampingan(newZealand,southKorea).
berdampingan(newZealand,australia).

berdampingan(australia,newZealand).
berdampingan(australia,unitedArabEmirates).

berdampingan(unitedArabEmirates,palestine).
berdampingan(unitedArabEmirates,egypt).
berdampingan(unitedArabEmirates,australia).

berdampingan(egypt,palestine).
berdampingan(egypt,libya).
berdampingan(egypt,unitedArabEmirates).

berdampingan(libya,egypt).
berdampingan(libya,uganda).

berdampingan(uganda,libya).
berdampingan(uganda,argentine).

berdampingan(argentine,uganda).
berdampingan(argentine,brazil).

berdampingan(brazil,panama).
berdampingan(brazil,argentine).

initializeTentaraAwalWilayah:-
    assertz(jumlahTentaraWilayah(canada, 0)),
    assertz(jumlahTentaraWilayah(usa, 0)),
    assertz(jumlahTentaraWilayah(bermuda, 0)),
    assertz(jumlahTentaraWilayah(guatemala, 0)),
    assertz(jumlahTentaraWilayah(panama, 0)),
    assertz(jumlahTentaraWilayah(brazil, 0)),
    assertz(jumlahTentaraWilayah(argentine, 0)),
    assertz(jumlahTentaraWilayah(uganda, 0)),
    assertz(jumlahTentaraWilayah(libya, 0)),
    assertz(jumlahTentaraWilayah(egypt, 0)),
    assertz(jumlahTentaraWilayah(germany, 0)),
    assertz(jumlahTentaraWilayah(france, 0)),
    assertz(jumlahTentaraWilayah(ukraine, 0)),
    assertz(jumlahTentaraWilayah(rusia, 0)),
    assertz(jumlahTentaraWilayah(unitedKingdom, 0)),
    assertz(jumlahTentaraWilayah(australia, 0)),
    assertz(jumlahTentaraWilayah(newZealand, 0)),
    assertz(jumlahTentaraWilayah(northKorea, 0)),
    assertz(jumlahTentaraWilayah(southKorea, 0)),
    assertz(jumlahTentaraWilayah(indonesia, 0)),
    assertz(jumlahTentaraWilayah(palestine, 0)),
    assertz(jumlahTentaraWilayah(israel, 0)),
    assertz(jumlahTentaraWilayah(china, 0)),
    assertz(jumlahTentaraWilayah(unitedArabEmirates, 0)).


displayMaps :-
    jumlahTentaraWilayah(canada, A),
    jumlahTentaraWilayah(usa, B),
    jumlahTentaraWilayah(bermuda, C),
    jumlahTentaraWilayah(guatemala, D),
    jumlahTentaraWilayah(panama, E),
    jumlahTentaraWilayah(brazil, F),
    jumlahTentaraWilayah(argentine, G),
    jumlahTentaraWilayah(uganda, H),
    jumlahTentaraWilayah(libya, I),
    jumlahTentaraWilayah(egypt, J),
    jumlahTentaraWilayah(germany, K),
    jumlahTentaraWilayah(france, L),
    jumlahTentaraWilayah(ukraine, M),
    jumlahTentaraWilayah(rusia, N),
    jumlahTentaraWilayah(unitedKingdom, O),
    jumlahTentaraWilayah(australia, P),
    jumlahTentaraWilayah(newZealand, Q),
    jumlahTentaraWilayah(northKorea, R),
    jumlahTentaraWilayah(southKorea, S),
    jumlahTentaraWilayah(indonesia, T),
    jumlahTentaraWilayah(palestine, U),
    jumlahTentaraWilayah(israel, V),
    jumlahTentaraWilayah(china, W),
    jumlahTentaraWilayah(unitedArabEmirates, X),

    format('#########################################################################################################################################################',[]),nl,
    format('#              North America                 #                  Europe                          #                      Asia                             #',[]),nl,
    format('#        Canada                              #                                                  #                                                       #',[]),nl,
    format('#         [~d]                                #                                                  #                                                       #',[A]),nl,
    format('#          |-------------------------------------------- United Kingdom                         #                                                       #',[]),nl,
    format('#          |                                 #              |  [~d]                              #                                                       #',[O]),nl,
    format('#         USA                                #              |---------- France ------ Rusia-------------|                         North Korea           #',[]),nl,
    format('#         [~d]                                #              |            [~d]           [~d]      #       |                             [~d]               #',[B,L,N,R]),nl,
    format('#          |                                 #            Ukraine          |                    #       |                              |                #',[]),nl,
    format('#          |                                 #              [~d]            |                    #    Isntreal-------------China--------|                #',[M]),nl,
    format('#    |------Bermuda-------- Guatemala        #              |---------------                    #      [~d]                   [~d]       |                #',[V,W]),nl,
    format('#    |       [~d]    |          [~d]           #                      |                           #       |                              |                #',[C,D]),nl,
    format('#----|              |                        #                      |                           #       |                         South Korea           #',[]),nl,
    format('#                   |                        #                    Germany                       #    Palestine----------Indonesia     [~d]               #',[S]),nl,
    format('#                   |                        #                    [~d]                           #      [~d]                 [~d]         |                #',[K,U,T]),nl,
    format('#                 Panama                     # ##################################################       |                              |                #',[]),nl,
    format('###################[~d]############################                    Africa                    #       |                              |                #',[E]),nl,
    format('#           South   | America                #                                                  #       |                              |                #',[]),nl,
    format('#                   |                        #                                                  #       |                              |                #',[]),nl,
    format('#   |-------------Brazil ------ Argentine --------- Uganda-----------Libya-------Egypt------------------|                              |                #',[]),nl,
    format('#   |              [~d]            [~d]        #       [~d]             [~d]          [~d]           #       |                              |                #',[F,G,H,I,J]),nl,
    format('#   |                                        #                                                  #  United Arab Emirates                |                #',[]),nl,
    format('#   |                                        #                                                  ###### [~d] ########################### | ################',[X]),nl,
    format('#   |                                        #                                                  #       |             Australia        |                #',[]),nl,
    format('#   |                                        #                                                  #       |                              |                #',[]),nl,
    format('#---|                                        #                                                  #    Australia---------------------New Zealand----------#',[]),nl,
    format('#                                            #                                                  #       [~d]                          [~d]                #',[P,Q]),nl,
    format('#                                            #                                                  #                                                       #',[]),nl,
    format('#                                            #                                                  #                                                       #',[]),nl,
    format('#########################################################################################################################################################',[]).   