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

profesor(feli, paradigmas, k2002)



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