import Text.Show.Functions
--FUNCIONES YA DEFINIDAS
aplicar3 f (a, b, c) = (f a, f b, f c)

invertir3 (a, b, c) = (c, b, a)

suerte (s, _, _) = s
convencimiento (_, c, _) = c
fuerzaFisica (_, _, ff) = ff

sinRepetidos [] = []
sinRepetidos (x:xs)
  | elem x xs = sinRepetidos xs
  | otherwise = x : sinRepetidos xs

maximoF _ [ x ] = x
maximoF f ( x : y : xs)
  | f x > f y = maximoF f (x:xs)
  | otherwise = maximoF f (y:xs)

--DEFINICION DE ALIAS DE TIPO Y/O TIPOS DE DATO NECESARIOS

--The chosen one + others
type Estudiante = (String, (Integer, Integer, Integer)) --SON TUPLAS
harry = ("Harry", (11, 5, 4))
ron = ("Ron", (6, 4, 6))
hermione = ("Hermione", (8, 12, 2))
draco = ("Draco", (7, 9, 6))

--Pocion
data Pocion = Pocion {
  nombrePocion :: String,
  ingredientesPocion :: [Ingrediente]
} deriving(Show)

felixFelices = Pocion "Felix Felices" [escarabajosMachacados, ojoDeTigreSucio]
multijugos = Pocion "Multijugos" [cuernoDeBicornioEnPolvo, sanguijuelaHormonal]
floresDeBach :: Pocion
floresDeBach = Pocion "Flores de Bach" [orquideaSalvaje, rosita]

--Ingredientes
data Ingrediente = Ingrediente {
  nombreIngrediente :: String,
  cantidadIngrediente :: Int,
  efectoIngrediente :: [Efecto] --Efecto es Tupla
} deriving(Show)

escarabajosMachacados = Ingrediente "Escarabajos Machacados" 52 [f1, f2]
ojoDeTigreSucio = Ingrediente "Ojo de Tigre Sucio" 2 [f3]
cuernoDeBicornioEnPolvo = Ingrediente "Cuerno de Bicornio en Polvo" 10
   [invertir3, (\(a, b, c) -> (a, a, c))]
sanguijuelaHormonal = Ingrediente "Sanguijuela Hormonal" 54 [aplicar3 (*2),
   (\(a, b, c) -> (a, a, c))]
orquideaSalvaje = Ingrediente "Orquídea Salvaje" 8 [f3]
rosita = Ingrediente "Rosita" 1 [f1]

--Efectos

type Efecto = (Int, Int, Int) -> (Int, Int, Int)

f1 (ns, nc, nf) = (ns+1, nc+2, nf+3)
f2 = aplicar3 (max 7)
f3 (ns, nc, nf)
  | ns >= 8 = (ns, nc, nf+5)
  | otherwise = (ns, nc, nf-3)

--Punto 2
sumaNiveles :: (Integer, Integer, Integer) -> Integer
sumaNiveles (num1,num2,num3) = num1+num2+num3  

-- sumaNiveles (n1,n2,n3) = sum [n1,n2,n3]

diferenciaNiveles :: (Integer, Integer, Integer) -> Integer
diferenciaNiveles (n1, n2, n3) = (max n1 (max n2 n3)) - (min n1 (min n2 n3)) 

--HACERLO MAS LINDO

--Punto 3
sumaNivelesPersona :: Estudiante -> Integer
sumaNivelesPersona (_, tuplaNiveles) = sumaNiveles tuplaNiveles

diferenciaNivelesPersona :: Estudiante -> Integer
diferenciaNivelesPersona (_, tuplaNiveles) = diferenciaNiveles tuplaNiveles

--Punto 4
efectosDePocion :: Pocion -> [Efecto] --CUANDO HAY QUE REVISAR TODO MAP          AL FINAL SIEMPRE PONER "SIGUIENTE" ingredientesPocion
efectosDePocion = concat.map efectoIngrediente. ingredientesPocion

--Punto 5

pocionesHeavies :: [Pocion] -> [String] --CRITERIOS MAP+FILTER
pocionesHeavies = map nombrePocion. filter ((>= 4).length.efectosDePocion)

--CONCAT SOLO LO USO CUANDO LO QUE TIENE QUE DEVOLVER ESTA DENTRO DE UNA LISTA LISTA

--Punto 6        
incluyeA :: Eq a => [a] -> [a] -> Bool --Si habrá que hacer una func generica para comparar  entonces usar Eq
incluyeA lista1 lista2 = all (flip elem lista2) lista1 --all saca y pasa cada elemnto de lista1 

--elem: un elemento 'X' que lo compara con una "lista". por eso tenemos que hacer el flip porque estaría  pensando  como si la Lista2 sea el elemento 'X' flip para que los argumentos se den vuelta
-- el ultimo lista1 es siguiente 

esPocionMagica :: Pocion -> Bool --uso variable pocion porque tengo que "ir para atras" para ver otra cosa
esPocionMagica pocion = any (incluyeA "aeiou" . nombreIngrediente)            (ingredientesPocion pocion)
   -- Any porque dice "ALGUNO"  incluyeA le doy el elemento 'X' tipo string          *siguiente* 
   --                           nombreIngrediente le da el ingrediente 
   --                           (1° saco el ingrediente y comparo)  
                     && all (even . cantidadIngrediente)                            (ingredientesPocion pocion)
 -- All porque dice "TODOS"  Even porque "pares" cantidadIngrediente saca el Int       vuelvo para atras, salgo a la lista anterior

--Punto 7