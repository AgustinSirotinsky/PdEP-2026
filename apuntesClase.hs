--clase 3
import Text.Show.Functions --Muestra el tipo de las funciones
p :: Int --force el tipo a p. se puede hacer en funciones tambien 

-----------MAYUSCULA EN EL TIPO------------

p = 2 --Defino variable

sumar2 = (+) 2

-- Es una funcion cuyo dominio lo asume a partir del 2 (no lo defini)
sumar3 = (+ 2)
--Es lo mismo, es otra forma de escribir la suma. Ademas (2 +) es lo msimo es comutativa  
-- "sumarx = x +" no sirve, es necesario los parentesis
-- algo que no e ve es   q en cada igual para cada func, es como decir "x = (+) 2 x"
-- x es el parametro. pero como esta en cada lado se simplifica. Las Funciones son implici

sumar4 x = (+ 2) x --X de forma explicita

siguiente :: Int -> Int
siguiente numero = numero + 1


siguienteDelSiguiente unNumero =
    (siguiente.siguiente) unNumero --otra forma "siguiente.siguiente $ unNumero" o "($) (sig.sig) unNumero
-- si yo invoco un Una sola funcion si parentesis.
-- ($) :: ____ - _____ - ______    "FUNCION APLICACION"
--     (int-int) int      unNumero (int)

-- IMPORTANTE LAS OPERACIONES MAYOR IMPORTANCIA POR ESO NO PARENTESIS EN EL PRIMER $

--length es como even,funcion ya prehecha, te indica la cantidad de letras de un sting. Devuelve un numero

--Miyuki herraminta de ejercicio. Te resuelve y te da par mejorar

--        funcion se pude  llamar cualquier cosa. Al ser algo seguido por otra, auto. es un FUNC desp PARA.
--           !
darVuelta funcion a b = --tres parametros a y b y funcion.   YA EXISTE, ES "FLIP"
    funcion b a

    -- darVuelta :: (___--___--___)-- a -- B -- c
    --                b    a    c               

aplicar f a = f a
-- :: (a--b)-- a -- b 

-- MAYOR precedencia, es lo ultimo que se hace

--const una funcion que da el primer parametro. Si lo uno con flip, me deolvera el originalmente segundo
--const :: a--b--a           ESPERA DOS PARAMETROS

--flip servira para comppsicion

reaplicar f a = f $ f a -- (f.f) a 
-- replicar :: (  a  --  a  ) -- a -- a 
-- Se refiere que la func obtiene algo del tipo a, y devuelve asi algo de a

-- not es negador tal cual 

-- si uso const con replicar funciona. Porque le da a const dos paranetros.

-- Composicion de funciones de forma prefija? osea antes. Si, podes "((.) f f) a"
-- compoicion F G x = F(G(X))

--x y z t w = (w y . z) t + y

b y z t w = w y . z










--Clase 4

palabraPar :: String -> Bool -- recibe string y devolvera bool

palabraPar a = even (length a) --even recibe numero y devuelve boolenao (te ddice si un numero es par)
    --  (even.Lenght) a
    -- even.lenght $ a  

multiploDe :: Int -> Int -> Bool --LAS FUNCIONES QUE SE hacEn ULTIMA VAN ANTES 
multiploDe b c =  mod b c == 0 --RECORDAR LAS FUNCIONES COMO EN C. Y sabia que devuelve bool "== 0" es una funcion por si sola

palabraQuintuplo ::  String -> Bool
palabraQuintuplo = -- flip.multiploDe 5.length
                  flip multiploDe 5.length


--Nuevo tipo de esctructura: LISTAS
    -- [1, 2, 3] asi se escriben. NO PUEDO ESCRIBIR UNA MEZCLA DE TIPOS. osea no mezclasr int con strings por ejemplos
    -- [1, 2, 3] :: [Int]  -- 2 :: Int
    -- Las listas son estructuras HOMOGENEA
    -- Si puedo hacaer una lista de funciones pero que me devuelvan el mismo tipo EJEMPLO: [1, 2, 2+1] :: [Int] (lista int)
    -- Listas de listas, pero lo mismo. MISMO TIPO. Ej [[5+3],[800]] :: [Int] // Importante: [1, [80]] No sirve pq el tipo es !=
    -- al escribir ['a','j','o'] al presionar enter  te devuelve "ajo" 
    -- Neccesito el import Text.Show.Functions para que me meustre que es una funcion de una lista
    -- (!!) te permite agarrar el elemento de  la posicion que quieras: (!!) [1, 2 , 3] 0// 1  
    -- Eso quiere decir que es indexado. Tiene indices.
    -- SE PUEDEN CONCATENAR con la funcion (++), las une! (++):: [a]--[a]--[a]
    -- Otra funcion es (:) agrega un elemento al principio: (:) 2 [3,4] // [2,3,4] (!!)::a--[a]--[a]
    -- (reverse) voltea la lista [1,2,3]//[3,2,1] (reverse)::[a]--[a]
    -- (head) me da el primer elemento de la lista (head)::[a]--a
    -- (tail) me da LOS ultimo elementos de la lista: tail [1,2,3]//[2,3]  TODO MENOS EL PRIMERO (tail):: [a]--[a]
    -- (length) este ya lo conocemos Length::[a]--a
    -- (Last) este si te da el ultimo elemento
    -- (init) todos MENOS el ultimo
    -- El string es una lista
    -- (map) mapea la funcion a cada uno de los elemen. Basicamente si uso length en una lista, aplica cada elem y lo pone en otra   map:: (a-b) -- [a]--[b]
    -- (filter) ayuda para quedarte con x criterio, por ejemplo los pares (even)-- filter even [1,2,3]//2 filter:: (a-bool) -- Num[a] --[a]
    -- (all) si todos los elem de la lista cumplen all:: ( a - bool )-- [a] -- Bool
    -- (any) contrario a all = tiene el mismo tipo que all
    -- Puedo tener una lista de funciones y con all o any,  y hacer ej: any ($ 2) [even, odd] esto me da false porque 2 no es odd
            --si uso map le aplica 2 a cada funcion



filtrarPar a = filter even a
letrasPares :: String -> Bool
letrasPares = even.length
-- Listas y dus fubciones de ORden Superior

--EXPRESIONES LANDA--Funciones Anonimas 
sumaTres x y z = x + y + z
-- (\x y z -> x+y+z) 3 2 3  8! si yo le doy un sol ovalor me devuelve una funcion pero buscando lso valores restantes
-- \x -> \y  -> \z -> x + y +z
-- (\x y z -> x+y+z)2)3)3) esto significa que primero se le asigna a x devolviendo una funcion que busca y, y se repite hasta z y dar un resultado
--para haskell no existen funciones de mas de un parametro, realmetnte entiendo que develve una funcion que recibe un parameto y sucesivamente
    -- Esto es CURRIFICACION, todas las funciones recibe UN parametro. Es una especie de composicion hasta dar ccon un numero
     -- Solo es conceptual, no se va usar... a lo mejor casi nada 
--Todas las funciones espera un parametro
--EJERCICIO DE UNA GUIA  funcion triple punto ----- (.)(.)(.) head filter :: (c - bool) - [c] - c


-- ========================CLASE 5===========================
-- EJERCICIO---- es nuy probable que utilizemos jugadas con listas cono para validar que la ultima letra de un string (sea una lsita)
-- utilizar last
lista = ['a','j','o']

--MODELAR SUSTANCIAS

--hidrogeno = ["Hidrogeno", 1] aunque seria piola no funca no mismo tipo

--tupla??
-- Una forma es haciendo lo siguiente:
hidrogenoNombre = "Hidrogeno"
hidrogenoNum = 1 
-- el tema que cada sustancia se vuelve muy molesto recompilar y asa
-- o sin´o

nombreDeElementos = ["hidro", "carbo"] 
--lo mismo pero con los numeros

--DATA (basicamente estructura del c++)

data Elemento = Elemento String Int String
    deriving (Show, Eq) 
-- "data" crea un tipo Elemento, es como un Int  *IMPORTANTE* con mayuscula como cualquier tipo
--              Constructor parametros

--Hay un import Text.Show.Functions para los data es "deriving Show" y si ponemos "(Show, Eq)" Permite comparar == elementos campo por campo

hidrogeno = Elemento "Hidrogeno" 1 "Gas" -- :t hidrogeno me devuelve Elemento

                        --   NOmbre Cant. Mol.
data Componente = Componente String Int
data Compuesto = Compuesto String String [Componente]
--                          NOMBRE GRUPO COMPONENTES

--TUPLAS   Junto el uso de parentesis podremos permitir
estudiante :: (String, Int)
estudiante = ("Tiago", 2222346)

minMax :: (Num a , Ord a) => a -> a -> (a, a) -- Puedo poner m´as de una restriccion Num y Ord con la '( , )'
minMax x y = (min x y, max x y) --Puedo comparar Tuplas entre si mientras sean del mismo tipo

--SOLO PARA TUPLA existen funciones para primer y segundo elemento "fst" y "snd" para el primer y segun elementos de la tupla

--PUEDO CREAR TIPOS (simpre puntos)

type Puto = (String, Int, String) -- mas rapido para tuplas

--Conclusion hay dos formas para crear tipos: "data" lo crean en listas   y "tuplas" este  es en parentesis no te va a permitir hacer mucho




-- Patern matiching --Revisa caso y los revisa de forma ordenada. CONSISTE EN ESCRIBIR el patron uno mismo
esVocal :: Char -> Bool
esVocal 'a' = True --Yo aca puedo hacer una devolucion personalizada Ej; "Hola" ++ otro ++"como vas" --> devuelve "hola otro como vas"
esVocal 'e' = True --SI O SI, tiene que ser e, porqe si uso E. yo defini con e, por lo que en estecaso no reconoce E
esVocal 'i' = True
esVocal 'o' = True
esVocal 'u' = True
esVocal letra = False

numeroAtiomico :: Elemento -> Int
numeroAtiomico (Elemento _ valorAtomico _) = valorAtomico -- _ es generico
nombreElemento :: Elemento -> String
nombreElemento (Elemento nombre _ _) = nombre 

--Lo que cree aca es el fst y snd de data. muy util

-- agua = Compuesto "Agua" 

--EXISTEN DOS TIPOS DE DATA. LOS SIMPLES (un constructor) O COMPLEJAS (mas de un cosntructor)

--Sustancia --> 
    --      --> 
--data Sustancia     = Elemento Int String String String   | Compuesto String String [(Sustancia, Int)]  deriving (Show, Eq)

--conduceBien :: String -> Sustancia -> Bool
{-
conduceBien _ (Elemento _ _ "metal") = True
conduceBien _ (Compuesto _ "metal" _) = True
conduceBien "Calor" (Compuesto _ "halogeno" _) = True
conduceBien "electricidad" (Compuesto _ "metal" _) = True
conduceBien _ _ = False --AL FINAL LO DEMAS
-}

-- GUARDAS (usadas para pattern con funcione) caminos distintos basicamente
-- modulo numero       NO SE PONE IGUAL ACA
--  |numero MAYOR=0 = numero
--  |numero MENOR 0 = negate Numero          
--  (Booleano)

-- NUNCA USAR GUARDAS Y PONGER |algo = True  MALLLL  ya da true de por si es un BOOL. 


-- puedo asegurame que una lista tenga tres con Funcion(c1:c2:cola)=... porque busca un elem para c1, y asi
--                                                fuerzo un patron

--para el punto tres


nombreUnion :: String -> String
nombreUnion nombreElemento 
    | (esVocal.last) nombreElemento = (init nombreElemento) ++ "uro"
    | otherwise = nombreElemento ++ "uro"

nombreUnion2 :: Elemento -> String
nombreUnion2 (Elemento nomb _ _) 
    | (esVocal.last) nomb = (init nomb) ++ "uro"
    | otherwise =  nomb ++ "uro"

-----CLASE 6----
-- DIF ENTRE TUPLA Y DATA ------------------------------------------------------------------------
{-
    ("Fede", 5000) (tupla) -- agrupar cosas de forma rapida, no le vas a dar mucha semantica -- no va a saber que es un docente 
    data Docente = Docente String Int  -- Mas fuerte, yo pueddo saber realmente bien como esta armado 
                            (String, Int) -- puedo meter una tupla dentro de un data

Otra dif e sue Tupla viene ya con dos funciones prehechas. DATA no. hay que armarlas con PATTERN MACHING: nombre (Docente unNombre _)= unNombre

TAmbien puedo poner nombre = fst -- puedo usarlo para saber de que hablo
-------------------------------------------------------------------------------------------------
TYPE

type String = [Char]

type Docente = (String, Int)

-- es tambien como un tipo de dato, puedo usar ahora Docente para crear Tuplas mas rapido
--------------------------------------------------------------------------------------------------
Creacion de Bool

data Bool = False | True 

--------------------------------------------------------------------------------------------------

IMPORTANTE nunca hacer un data y una Tupla al mismo tiempo osea del mismo nombre. Se rompe toodo

--------------------------------------------------------------------------------------------------

FUNCION FACTORIAL (Solo ejemplo de guardas y recursividad)

factorial :: Int -- Int
factorial n
    | n == 0 = 1
    | otherwise = n * factorial (n-1)

factorial' 0 = 1                      --Caso base
factorial' n = n * factorial  (n-1)   -- Caso recusivo

"_" usarlo solo en caso que no lo uses despues del igual. SI SE USA  DESPUES ESTA MAL.  Es usado par cuanto no lo necesito saber. ACA SI

*RECURSIVIDAD: se vuelve a usar en si misma*

fibo 0 = 1                          
fibo 1 = 1                            --los dos primeros son los casos Base
fibo n = fibo (n-1) + fibo (n-2)
-----------------------------------------------------------------------------------------------------------------------------
LISTAS

Lista es recursiva

    1 : 2 : 3 : [] = [1, 2, 3]

Definicion de lista (o lista vacia)
data [a] = []        ||     a : [a]          ---------- :t []
                                                        [a]

Definicion de head
    head (x:xs) = x  -- le estoy dando como variable una lista para que me devuelvan x --  x:xs lista de almenos un elem
    -- "recive algo con cabeza y cola" 
Def. Tail
    tail (x:xs) = xs  

En este caso usar "_" es legal! porque por ejemplo head (x:_) = x --- Ves no me interesa lo de _, no lo uso del otro lado :)

Length

length :: String - Int
length [] = 0 --- es paso base
lenght (x:xs) = 1 + length xs ----- guarda este 1 en una variable temporal y te devuelve eso

Reverse
    reverse [] = []
    reverse (x:xs) = reverse xs ++ [x]

IMPORTANTE ":" NO PODES USARLO PARA QUE AGREGUE UNA LISTA a otra. Es un elemento a una lista
    ++ te suma 2  listas. habra que meter x en una 

CONCATENAR
    (++) [] lista2 = lista2
    (++) (x:xs) lista2 = x : (xs ++ lista2)

SUM (sumatoria de listas de numeros)
    Sum []= 0
    sum (x:xs) = xs + sum xs

PRODUCT (Product)
    product [] = 1
    product (x:xs) = x * product (xs)


AND (recive una lista de booleanos para cuando todos cumple true or sino false)
    and [] = False
    and (x:xs) = x && and xs

Or (al menos un true)
    or []= False
    or (x:xs) = x || or xs

Concat (listas de listas y las une en una )
    concat [] = []
    concat (xs:xss) = xs ++ concat xss

MAP (daba la poscion que queres)
    map f [] = []
    map f (x:xs) = fx : map f xs

Filter (escribe los valores que cumplan con cietta condicion)
    filter condicion [] = []
    filter condicion (x:xs) 
        | condicion x = x : filter condicion xs
        | otherwise = filter condicion xs


Puedo hacer guardas y hacer pattern maching en una funcion afuera



PLEGAR: puedo usarla para acortar funciones q definimos antes  (vi: valor inicial) (op: operacion)
    plegar op vi [] = vi
    plegar op vi (x:xs) = op x (plegar op vi xs)

Fold
    es igual a plegar  (tambien esta el foldl) --ESPERA EL NUMERO DESPUES LA FUNCION
    foldr :: ( b - a - a) -  a - [b] - a

    foldl :: (a - b -a) - a - [b] - a

--foldr // foldl es una especia de bucle

HAY QUE USARLOS CON UN ($) si lo vamos a hacer ejecutar a una tupla por ejemplo
        RECIBE PRIMERO LA FUNCION Y DESPUES LA LA VARIABLE

r significa que empieza de atras para adelante
l empieza de izquierda a derecha



----------------------------------------------------------------------------------------------------------------------------


EMPEZAR A USAR LAMBDA \argumentos -> cuerpo

    SIRVE COMO PARA HACER UNA CONSIGNA EN UN CASO ESPECIFICO/RESTRUCTURAR 
        EJ: en un caso de usar un FOLDL y quiero ordenarlo para que lea los argumentos
        en el orden que yo los pongo --> foldl (\tupla efecto -> efecto tupla)      tupla  (efecto pocion) 
----------------------------------------- ----- ORIGINAL-----(mi modificacion temp)----------efectos + relectura
-}

{-

SE USA $ SOBRETODO cuando usas muchas funciones para una variable sola
---------------------------------------- CLASE 7 --------------------------------------------------------

DIF ENTRE MAP Y FOLD
    *MAP le paso una funcion y lista   y a todos le aplica por separado
    *FOLD REDUCE TODOS A UNO, Los fuciona  Ademas lo puedo hacer en direcciones distintas
    foldr1 NECESITA LSITA LLENA SI O SI
    foldr -- Foldable t = (a - b - b) - b - t a - b
                                            t es lista de a 
    foldl -- Foldable t = (b - a - b ) - b - t a - b
    
        foldr trabaja de derecha a izq(RECIBE FUNCION Y DESPUES VALOR)/ foldl trabaja de izq a derecha (RECIBE EL VALOR Y DESPUES FUNCION)
        Otra cosa mas....
    puedo usar LAMBDA par a cambiar el orden de las argumentos fold(/x f -> f x) agarra la funcion al reves
                                                            barrita pal otro lado
----------------------------------------------------------------------------------------------------------
    lista n m    --Es logico que m debe ser mayor a n en este caso
        | n == m =  [n]
        | otherwise = n :  lista (n+1) m 
    ---------------------IMPORTANTE cuando debemos hacer un bucle re llamar la funcion-------------------------------------------
---------------------------------------------------------------------------------------------------------

OTRAS FUNCIONES CON LISTAS (BUCLES INFINITOS)

        Los DOS puntos
            Puedo haer que haskell entienda solito  como sera mi lista con ".."
            Ej:  [1..10] haskell me devuelve [1,2,3,4,5,6,7,8,9,10]

        REPEAT
            repetir una letra o num infinitamentes

        REPLICATE
            Te repite x cantidad de veces a (puede ser funcion, letra, etc) -- replicate x a  
                            ---EL REPLICATE ES BASICAMENTE EL TAKE X DE REPEAT A

        CYCLE
            Repite una lista todo el tiempo.

        ITERATE 
            Recibe una funcion y elementos y lo aplica infinitamente
--------------------------------------------------------------------------------------------------------------

        TAKE
            toma los x valores que quieras de una lista  y devuelve una lista de esos valores 
                    Util para ejercicios cuando hay que comparar que termina con ejmpl "sos" 
                    entonces un reverse take 3 algo asi, te lo muestra1

        ELEM
            Esta funcion  te devuelve un BOOl en el caso de que X este en la lsita -- elem x [a]

---------------------------------------------------------------------------------------------------------
        Las funciones que reciben listas siempre se declara con 
        (x:xs) = .....
        cabeza y cuerpo
---------------------------------------------------------------------------------------------------------
    LAZY EVALUATION
        Esto es cuando invoca la funcion primero y despues calcula el elemento
        (HASKELL)
            Evaluo lo justo y necesario. Evaluo error cuando aplique la funcion

    EAGER EVALUATION
        Esto es cuando primero calcula el elemento y depues invoca la funcion
        (otro codigo como C)
            Es util cuando queiro destectar errores temprano

              ======== doble (2+3) =========
                doble 5  | (2+3) + (2+3)
                   5 + 5 |  5 + 5
                    10   |   10
                         |
                EAGER    |   LAZY (HASKELL)
              ==============================

----------------------------------------------------------------------------------------------------------------------
    UNDERFINED 
        Es una variable para que te tire error, quizas para encontrar problemas. ES todo los tipos al mismo timepo
----------------------------------------------------------------------------------------------------------------------
    Evalucion diferida :)
    Trasparencia referencial --- HAskell la tiene automatica





-}