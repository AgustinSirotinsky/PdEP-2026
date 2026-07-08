linea(a,[plazaMayo,peru,lima,congreso,miserere,rioJaneiro,primeraJunta,nazca]).
linea(b,[alem,pellegrini,callao,pueyrredonB,gardel,medrano,malabia,lacroze,losIncas,urquiza]).
linea(c,[retiro,diagNorte,avMayo,independenciaC,plazaC]).
linea(d,[catedral,nueveJulio,medicina,pueyrredonD,plazaItalia,carranza,congresoTucuman]).
linea(e,[bolivar,independenciaE,pichincha,jujuy,boedo,varela,virreyes]).
linea(h,[lasHeras,santaFe,corrientes,once,venezuela,humberto1ro,inclan,caseros]).
linea(t,[aaa,eee]).

combinacion([lima, avMayo,aaa]).
combinacion([once, miserere]).
combinacion([pellegrini, diagNorte, nueveJulio]).
combinacion([independenciaC, independenciaE]).
combinacion([jujuy, humberto1ro]).
combinacion([santaFe, pueyrredonD]).
combinacion([corrientes, pueyrredonB]).

% No hay dos estaciones con el mismo nombre.

% Se pide armar un programa Prolog que a partir de esta información permita consultar:
% estaEn/2: en qué línea está una estación.
estaEn(Linea,Estacion) :-
    linea(Linea,ListaDeEstacione),
    member(Estacion,ListaDeEstacione).
% distancia/3: dadas dos estaciones de la misma línea, cuántas estaciones hay entre ellas: por ejemplo, entre Perú y Primera Junta hay 5 estaciones.
distancia(Estacion1, Estacion2, Cuantas):-
    linea(Linea, ListaDeEstacione),
    estaEn(Linea,Estacion1),
    estaEn(Linea,Estacion2),
    nth1(PosicionEstacion1, ListaDeEstacione, Estacion1),
    nth1(PosicionEstacion2, ListaDeEstacione, Estacion2),
    Cuantas is PosicionEstacion2 - PosicionEstacion1,
    abs(Cuantas,Cuantas).
%Mejor derivar EstarEn como Estar en la misma 

% mismaAltura/2: dadas dos estaciones de distintas líneas, si están a la misma altura (o sea, las dos terceras, las dos quintas, etc.), por ejemplo: Pellegrini y Santa Fe están ambas segundas.
mismaAltura(Estacion1,Estacion2):-
    linea(Linea1, ListaDeEstacione),
    linea(Linea2, ListaDeEstacione2),
    Linea1 \= Linea2,
    nth1(Posicion,ListaDeEstacione2,Estacion2),
    nth1(Posicion,ListaDeEstacione,Estacion1).

% granCombinacion/1: se cumple para una combinación de más de dos estaciones.
granCombinacion(ListaDeEstaciones) :-
    combinacion(ListaDeEstaciones),
    length(ListaDeEstaciones,Cuantas),
    Cuantas  >= 3.

% cuantasCombinan/2: dada una línea, relaciona esa línea con la cantidad de estaciones de esa línea que tienen alguna combinación. Por ejemplo, la línea C tiene 3 estaciones que combinan (avMayo, diagNorte e independenciaC).
cuantasCombinan(Linea, CuantasEstaciones):-
    linea(Linea,ListaDeEstacione),
    nth1(_, ListaDeEstacione, Estacion),
    findall(Estacion,(member(Estacion,combinacion(_))),ListaCombinacion),
    length(ListaCombinacion,CuantasEstaciones).

%% MALL
% lineaMasLarga/1: es verdadero para la línea con más estaciones.
 

% viajeFacil/2: dadas dos estaciones, si puedo llegar fácil de una a la otra; esto es, si están en la misma línea, o bien puedo llegar con una sola combinación.
