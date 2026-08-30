paisContinente(americaDelSur, argentina).
paisContinente(americaDelSur, bolivia).
paisContinente(americaDelSur, brasil).
paisContinente(americaDelSur, chile).
paisContinente(americaDelSur, ecuador).
paisContinente(europa, alemania).
paisContinente(europa, espania).
paisContinente(europa, francia).
paisContinente(europa, inglaterra).
paisContinente(asia, aral).
paisContinente(asia, china).
paisContinente(asia, india).
paisContinente(asia, afganistan).
paisContinente(asia, nepal).

paisImportante(argentina).
paisImportante(alemania).

limitrofes(argentina, brasil).
limitrofes(bolivia, brasil).
limitrofes(bolivia, argentina).
limitrofes(argentina, chile).
limitrofes(espania, francia).
limitrofes(alemania, francia).
limitrofes(nepal, india).
limitrofes(china, india).
limitrofes(nepal, china).
limitrofes(afganistan, china).
limitrofes(Pais1, Pais2):-
    limitrofes(Pais2, Pais1).

ocupa(argentina, azul).
ocupa(bolivia, rojo).
ocupa(brasil, verde).
ocupa(chile, negro).
ocupa(ecuador, rojo).
ocupa(alemania, azul).
ocupa(espania, azul).
ocupa(francia, azul).
ocupa(inglaterra, azul).
ocupa(aral, verde).
ocupa(china, negro).
ocupa(india, verde).
ocupa(afganistan, verde).

continente(americaDelSur).
continente(europa).
continente(asia).

%%estaEnContinente/2 - relaciona un jugador y un continente si el jugador ocupa al menos un pais en el continente.

estaEnContinente(Jugador,Continente):-
    ocupa(Pais,Jugador),
    paisContinente(Continente,Pais).

%%ocupaContinente/2 - relaciona un jugador y un continente si el jugador ocupa totalmente el continente.
ocupaContinente(Jugador, Continente):-
    continente(Continente),
    forall(paisContinente(Continente,Pais), ocupa(Pais,Jugador)).

%%cubaLibre/1 - es verdadero para un país si nadie lo ocupa.
cubaLibre(Pais):-
    paisContinente(_,Pais),
    not(ocupa(Pais,_)).

%%leFaltaMucho/2 
leFaltaMucho(Jugador,Continente):-
    estaEnContinente(Jugador,Continente),
    not(ocupeDosPaisesOMas(Jugador,Continente)).

ocupeDosPaisesOMas(Jugador,Continente):-
    paisContinente(Continente,Pais1),
    paisContinente(Continente,Pais2),
    ocupa(Pais1,Jugador),
    ocupa(Pais2,Jugador),
    Pais1 \= Pais2.

%%es como decir que el conntinente tiene almenos 2 distintos y no tiene ninguno
sonLimitrofes(Pais1, Pais2):-

    limitrofes(Pais1,Pais2).

tipoImportante(Jugador):-
    ocupa(_,Jugador),
    forall(paisImportante(Pais),ocupa(Pais,Jugador)).


estaEnElHorno(Pais):-
    ocupaEn(Continente,Jugador,Pais),
    ocupaEn(Continente,Rival,_)
    paisContinente(_,Pais),
    Jugador =\ Rival,
    forall(sonLimitrofes(Pais,Paises), ocupa(Paises,Rival))
