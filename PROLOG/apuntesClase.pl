/*
    Cambio de Paradigma

        Algunos conceptos se mantienen como declaratvidad y expresividad.
        Mantener el delegar lo mas que se pueda

        PARECE SER EL mAS DECLARATIVO DE LOS TRES


    PROLOG 
        el interprete es SWI - Prolog (es decir el ghci de prolog)
         IMPORTANTE DESPUES DE USAR EL "prlog noombre.pl"  PONER EN LA CONSOLA "[nombre]."
        es menos usado de los paradigmas
        Relacion con base de datos
        Es usado mas para deduccion y almacenamiento (?)

        Los archivos van como .pl -- INSTALAR EXTENSION PROLOG

        TERMINOLOGIAS
            No hay funciones (no estamos en funcional)-- No hay tantas restricciones de tipo
            BASE DE CONOCIMIENTO 
                Vamos a almacenar todas las cosas que consideramos ciertas
                Ej: 

*/
materia(fisica, 1).
materia(paradigmas, 2).
materia(operativos, 2).
materia(desarrolloSW, 3). 
/*Cada uno de esos  son CLAUSULAS DEL PREDICADO MATERIA
    Los predicados son la unidad principal de trabajo. 
    NO HAY FUNCIONES, HAY PREDICADOS
    
    PREDICADOS
        2 CARACT 
            Nombre ---- materia
            Aridad (se puede entender como cuantos parametros tine)---- 2
            
            se escriben asi para entnder:

                materia/2


                nombre materia y aridad 2
        
        pueden existir juntos un materia/2 con un materia/1 son cosas distintas (aunque no tiene sentido)

        PUEDEN SER PROPIEDADDES (aridad es igual a 1) o RELACIONES (mas de una aridad)
    
    INDIVIDUO (las aridades)
        Pueden ser simples o compuestos
            Los simples son numeroes y ´atomos
            Los compuestos son funciones (Functores) y listas

                Los atomos son strings (creo)  van sin "
    CONSOLA

        El ":r" de prolog es make. --- Si te da true todo bien

        podes hacer prefuntas como "materia(paradigma,2)"

    Vamos hacer cosas que son ciertas y que no. porque en la consola te devuelve true


    NO TENEMOS DOMINIO,IMAGEN Y DEVOLVER

    hacemos PREGUNTAS. ALGO CIERTO NOMAS


    Lo de adentro (_) son individuos
    cuando yo pregunto "materia(blah,blah2). 

    ESTO ES UNA PREGUNTA INDIVIDUAL
    ------------------------------------------------------------------------------------

    Podemos hacer cosas mas interesante....

        puedo preguntar si existen por ejmplo materias de tercer año

        "materia(_,3)" devuelve true

        VUELVE EL USO DE _ para cuando no nos interesa

    ESTO ES UNA PREGUNTA EXISTENCIAL

    -------------------------------------------------------------------------------------

    Puedo preguntar cosas como cuales CUMPLEN
        "materia(Que,2)" debe ser EN MAYUS
        te devuelve "Que= paradigmas" si se queda esperando,
            bueno con "n" te da el siguiente (si es que hay)
            Si no hay mas y le mando "n" te devuelve un "falso" pero es que no encontro mas


        Con "." corta la pregunta

        Puedo preguntarle "materia(Que,Anio)."  y me va mostrando todos (debo usar next)
        PREGUNTA VARIABLE

    ======================================================================================
        TRES PREGUNTAS PRINCIPALES

            PREGUNTAS INDIVIDUALES 
            PREGUNTAS EXISTENCIALES --Con guion abajo
            PREGUNTAS VARIABLES-- Con mayus
    ======================================================================================

    

*/

profesor(vinokur, fisica, k2026)
                    
/*
    Predicados estan compuestos por Clausulas 

                HECHOS (axiomas) -- Definidas
                REGLAS (implicaciones) -- Como


    Ej: esFacil(legislacion) -- esto es porque yo fui agregando varias materias  
        HECHO
            

        una mejor forma es hacerlo como REGLA

        esFacil(Materia) :-
            materia(Materia, Anio), 
            Anio (simbolo mayor) 3


*/

esFacil(paradigma).

esFacil(Materia) :-
    materia(Materia, Anio),  % En ambos casos hace como una validacion, primero que exista Materia en materia y despues el año
    Anio > 1.

/*
    LA COMAS SON && (osea y)

    PUEDO HACER MUCHAS CLAUSuLAS, ESTOS SON || (osea o)
    
    Resuelve las clausulas EN ORDEN

    te duevelve todas las que cumplen, puede repetir

    Si uso en la terminal "esFacil(Materia)" 
        me va a devolver todos los que cumplen
    

    PRINCIPIO DE UNIVERSO CERRADO (nuestra base de ocnociemiento se rige por este principio)
        es decir todo lo que le damos a la base de conocimiento (nuestro codigo), lo que no esta ES FALSO


    Si en un predicado, uso una variable que contiene 3 cosas, si no lo uso PONGO "_"
    
    EXISTE RECURSIVIDAD 

    Atento a las boludeces como que necesito o no usar  uno de los individuos y asa 

*/

profesor(feli, paradigmas, k2002).



/* Ejercicio 

    expertoEnElTema (Profesor) :- 
        profesor(Profesor, Materia, _),
        profesor(Profesor, Materia2,_),
        sonCorrelativas(Materia2, Materia). 

    UNA CLAUSULA ES UNA DISYUNCION, POR LO QUE VA A RESOLVER TODAS LAS POSIBILIDADES POSIBLES. POR ESO EL ORDEN DE VARIABLES 
        NO IMPORTA. xq resulve un caso, despues otro, otro y los une con un v (||, o) entonces por eso da true de una forma y 
        otra.

    Ligar-- osea que sigue una variablee por decir asi


    EJERCICIO 2

    masDeUnCurso (Profesor,Materia):-
        profesor (Profesor,Materia, Curso1),
        prosesor (Profesor,Materia, Curso2),
        Curso1 (barraInclinda izquierda)= Curso2.

    IMPORTANTE EL ORDEN, porque no puedo igualar sin haber declarado antes.


*/



/*
    clase 2
        Ejercicio de los simpsons
            declaras los hijos

            tienteHijo(Personaje):-
                padreDe(Personaje,_).

            tieneHijo(Personaje):-
                madreDe(Personaje,_).

                (se hace dos veces porque cada clausula es una disyuncion, la coma conjuncion serian  que se cumlan simul)
            
            hermanos (Personaje1, Personaje2):-
                madreDe(Madre, Personaje1),
                madreDe(Madre,Personaje2),----- y lo mismo qye padres

                (el poner Madre ya se queda con la misma Mddre)

            ACORDAR DE DIFERENCIAR 

            medioHermanos(P,P2):-
                (hacer clausula en para un progenitor)


            RECORDAR DE DELEGAR LO QUE MAS PUEDA 
            PONER VARIABLE DISTINTA IGUALMANTE EL CASO DE QUE SEAN IGUALES  LO VA A PROBAR  \= para decirle que no a tal cosa

            CLAUSULAS IGUALES TODAS JUNTAS O ERROR AL COMPILAR

            tioDe(Tio,Sobrino):-
                (agarro el padre)
                padreDe(Padre, Sobrino),
                hermano (Tio,Padre).

            Lo mismo con madre


            no importa el orden y al mismo tiempo si. Importa mas para las restricciones y ligar valores.

            USAR RECURSIVVIDAD (sobretodo en ejercicio que no aclara cuantas veces)


            NO IMPORTA QUE REPITA RESULT, ESTA BIEN


        NEGACION
            not(_).
                recibe UN VALOR DE VERDAD, NOs va a importar el orden. osea le meto una funcion que sabemos que se cumple o no
                    O al menos lo resolvmos antes en la clausula o en otro predicado
                    LAS NEGACIONES AL FINALLLLLL O NUNCA PRIMERO AL MENOS. Porque agarra a las madre y devuelve false, si devuelve false ya 
                    esta 

            Siempre queremos que al not().  entren variables ya definidas. Por eso va abajo o despues en genereal.
            sin eso como que pierden la gracia


            NO SE USA EL NOT PARA QUE AVERIGUE VARIABLE, SE LAS TENGO QUE DAr YO. pueden ser ochocientas pero ya las busque yo
            no tiene porque buscar en toda la base de conocimiento. Solo en los datos que les doy yo.

            aunque solo necesites buscar una Variable IGUAL. Siempre primero hacelo 

        INVERSIBILIDAD
            Cuando la dar vuelta predicados funciona igual y asa´
            Que tengan valor de verdad creo? -- LIGADAS

        Con preguntas existenciales me devuelven algo distinto a bool
            "is" puedo ussar esto para que me divuelva calculos
            NOMBREVARIABLE is OPERACIONMATEMATICA esto 
                Es como decir especificamente lo que es la variable, como decir que Promedio is blah  blah. 
                En consola cuando pregunte por el Promedio me va a dar el numero

            El is se puede usar par consultar "2 if 2+0." devuelve true
            Es similar a not. PREGUNTAR ANTES POR LAS VaRIABLES. porque sin definir no puede.
            el is se puede escbir asi: 
                                        is(X,2+2)
                    similar a haskell

        Prolog es pesimo resoludor matematico. No busca eso-.
        

        FUNCIONES UTILES ========================================================================================

            not(_). ---  Negar. Es similar al \=

            (_) is (expresion matematica) --- es como para fijar que esa variable va algo trabajado

        =========================================================================================================

            IMPORTANTE en ambos casos tenemos que definir previamente la varaible, es decir saber de donde salen
                De donde la base de datos est´a, que cumplen

                IS ES SOLO PARA CUENTA MATEMATICA (no usarlo para que sea que sea igual a un numero tipo "is 6/0")
                                                                DA MAL. ASI NO

        pueden haber varios predicados  dentro del not peroooo ENTRE PARENTESIS   

*/

/*
    Clase 3

    Ejercicio de mundial 
      *base de datos*
       HECHOS --- 
      gano (argentina,argelia).
      
      REGLA
      gano (Pais, OtroPais, Goles, GolesOtro ):-
         partido (Pais, OtroPais, Goles, GolesOtro ),
         Goles *Mayor* GolesOtro.

      Perdio (se repite)

      resultado (Pais,OtroPais,perdio) :-
        *se escribe lo que pasa si pierde
      resultado (Pais,OtroPais, gano):-
        *Como gana*

        Este caso es rado porque ya se que gano o perdio

                Mal
        empato (Pais, OtroPais):-
           partido (Pais, OtroPais, GolesPais, GolesOtro). NO SE PUEDE USAR =. DEbes usar la misma variable
                
                BIEN
        empato (Pais, OtroPais):-
           partido (Pais, OtroPais, GolesPais, GolesPais). Aca le estoy diciendo que toma la imism variable

        Si Quiero usar una basse de dato, pero que funcione de un sentido y el otro
            partido ( Pais, OtroPais, Goles, OtrosGoles):-
                partido(otroPais, Pais, OtrosGoles, Goles).

        Tiene un problema, ES RECURSIVO INFININTAMENTE, igualmente EN logico no generea un problema realmente
        solo que los resultados van a ser infinitos. No importa, lo que queremos es que nos devuelva al menos una
        respuesta

        invicto (Pais):-
            partido(Pais,_,_,_),  ---------------------- generar el pais
            not(perdio(pais,_)). 

         Inversiblilidad es preguntar con variables y funciona (su no entiendi mal)

        Como vas a tener que generar el pais mil veces s e puede hace una general!
            pais(Pais):-
                partido(Pais,_,_;_).


        Se Puede Negar dos veces. PEROOOOO dentro de la negacion tener que declar (creo).
        Escribir la oracion puede ayudar


        FORALL
            en este declaras adentro  creo (decalar) adentro y afuera --- despues la funcion

        el declarar adentro es cuadno necesitas una varaible libre, que entre todo
        medio como algebra.  ej: (y-x,y, z-y)---- y(1-1,1,1-1) entonces y es varaible libre. se entiende? o cuando x= 3y y z=2y
        Ambos son en funcion de y. Es esto lo que tenes que hacer

            se lo puede entender como V x:{ x e R/...}  son para TODOS los x (declarado afuera) 

        ============================================================================================================
            Cosas Nuevas!!

                Generar una Declarador General ------ algo(Vaiable):-
                                                            predicado(Variable....).

                NO se usa el = para igaular. Debes usar el mismo nombre de varaible.

                Menor/Mayor e igual son caras tristes end distinta

        ============================================================================================================
*/

/*
    Clase 4
        Functores y listas propediades o relaciones compuesta de individuos

        LISTAS
            Pueden ser muchas cosas dentro, puedo inclusive hacer lsitas de listas
            No siempre necesario, puedo armar grupos. PEro hay casos que si o si
            
            Se  escribien entre corchetes
                [algo,....,otra]
            Como no hay tipos estrictos como en otros codigos, puedo armar una lista de numeros y palabras. todo mezclado

                (los strings son atomos)


            Existe un predicado para el largo llamada "length/2"
                length (Atomo, Largo). 
                Es parcialmente inversible limitado AL DOMINIO no podes mandarle largo negativo
                Cuando pregunto por length (_,3).  Me devuelve [_,_,_] un wacho
                Si yo le doy length (Lista, Largo). me va delvoer como arriba (si es que no tengo nada en la base de dato, obvio)


                ALGO OPCIONAL (no le vemos)
                    como en haskell tenemos (x:xs) para simbolizar una lsita
                    en Prolog tenemos Cabeza|Cola   por eso a veces te puede devolver [Cosistas|...] indincando que continua

            Tenemos tambien un Elem (indicaba si esta en una lista algo). Tenemos "memeber/2"
                member(Individuo,Lista).
                Es inversible (recordar aca que inversible es que yo puedo usar una variable para ver cuales cumpla en cualquier aridad)

            nth0/3 es otra. Es busqueda por indice. PErmite ver en que posicion. (Cuenta el cero)
                    nth0(Posicion, Lista, Individuo). 
                    El cero de siboliza que numero es el primero, si uso nth0 o nth1 varia el valor de la posicion


            Las listas son utiles para poder saber el orden de las cosas. 

            append/3 es para concatenear (lista, otraLista, ListaNeuva)
            union/3 -- Union matematica
            interseccion/3 --Intersecion matematica
            Max_memeber/2 --EL MAYOR DE Lista (la lista es segunda creoooo)
            min_member/2 -- EL MINIMO


            Predicado que me responde cuales cumplen algo ---- findall/3 ---- Sirve para trabajarlo como CONJUNTO (da una lsita)
             findall(VariableDeItneres, Consulta, Lsita ) La consulta son predicados. ESTO  QUIERE DECIR QUE HAY QUE DECLARARRRRRRR

            

            Cuando yo creo funciones para averiguar ALGo, esta bueno usar como una aridad mas para que ese sea el resultado. Como como
             el aprend y asi

            Predicado de suma de los elementos de lista. es sumlist(Lista, Resultado).
                su inversibilidad es particular porque pueden existir infintas listas que suman. POR LO QUE NO ES TOTALMENTE INVERSIBLE
                No permite devolver lsitas asi libremente. Tira error porque hay infinitas combinaciones de listas

            Algo es parcialmente inversible si es que me puede devolver las varaibles de una de sus aridades. Si las dos funcionan
             esTotalmente inversible



            ================================================================================================================
                Listas
                    Van entre corchetes y puede variar

                    predicados utiles (est´an en la guia de lenguajes)
                        length(Lista, Largo).
                        member(Individuo, ListaALaQuePertenece). (ES LA UNICA QUE VA LA LISTA SEGUNDA)
                        nth0 (POsicion, Lista, Individuo).
                        append/3 es para concatenear (lista, otraLista, ListaNeuva)
                        union/3 -- Union matematica
                        interseccion/3 --Intersecion matematica
                        Max_memeber/2 --EL MAYOR DE Lista (la lista es segunda creoooo)
                        min_member/2 -- EL MINIMO
                        findall(VariableDeItneres, Consulta, Lsita )
                        sumlist/2 (Lista,Ressultado). 
            ================================================================================================================


 cntrl + k + c     para comentar lo seleccionado

*/

/*
    CLASE 5
    listas-> [x,Y|xs] la cabeza es x, la cola es xs. para separar elementos es coma y para la cola es |

    Estar atento a lso casos que contempla una func

    Funtctores 
        tienen arida como los predicado.
        Son individuos Compuestos. Nos permite guarar lo que queremos de ahi! 
        Podemos usarlas para guardar listas creo

        como usarlo?, basicamente cuando uses una funcion, como ultimo argumento que le das nomre_Functor(), dentro de () son lso datos utlites 
        es un poco como un tipo de datos.

        Despues los usas como lista en la cual buscar!  Osea en un findall (Trabajador, trabajaEn (Pelicula, Trabajador),Trabajadores)  ESto quiere decir que me va dejar buscar todos lso trabajadores que cumpla

        LOS FUNCTORES RELACIONAN COSAS

    Polimorfismo
        esto se refiere cunao un predicado puede recibir distintos tipos de individuos. Por ejemplo un predicado que reciba un atomo o un numero.
        ===========================================================================================================================================
            Crear lista que cumplan (filter) -> findAll (algo, condicion(...,algo), ALGOES) 
            Functores -> individuos compuestos,guardas lo que quieras. -> preicado (blah, blah, functor(....)) e esta manera podes tener istntas tipos para una misma funcion.
                functor vacios es sin los ()
        ===========================================================================================================================================

        Las funciones principales en un examen  deben ser inversibles


*/