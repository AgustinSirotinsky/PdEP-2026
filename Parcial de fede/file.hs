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



--The chosen one + others
type Estudiante = (String, (Integer, Integer, Integer))
harry = ("Harry", (11, 5, 4))
ron = ("Ron", (6, 4, 6))
hermione = ("Hermione", (8, 12, 2))
draco = ("Draco", (7, 9, 6))


--Ingredientes
data Ingrediente = Ingrediente String Int [Efecto]

felixFelices = Pocion "Felix Felices" [escarabajosMachacados, ojoDeTigreSucio]
multijugos = Pocion "Multijugos" [cuernoDeBicornioEnPolvo, sanguijuelaHormonal]
floresDeBach = Pocion "Flores de Bach" [orquideaSalvaje, rosita]

--Pocion
data Pocion = Pocion String [Ingrediente]

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
