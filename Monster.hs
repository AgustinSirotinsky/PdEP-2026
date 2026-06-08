import Text.Show.Functions
import Data.List

obtenerEnergiaGrito :: Grito -> Int
obtenerEnergiaGrito (grito,intensidad ,mojaCama) 
    | mojaCama = intensidad * intensidad
    | otherwise = (((*)3.length) grito) + intensidad

type Grito = (String, Int, Bool)

type Monstruo = Niño -> Grito

type Niño = (String, Int, Double)

sullivan :: Monstruo
sullivan (nombre, edad, altura) = ((gritoConXAs (nombre, edad , altura)), div 20 edad, (3>edad) )

gritoConXAs:: Niño->String
gritoConXAs (nombre, edad, altura) = (replicate (length nombre) 'A')++ "GH"

randall :: Monstruo
randall (nombre, edad, altura) = ("Mamadera", cuatasVocales nombre, ((1.2 > altura)&&(altura > 0.8)))

esVocal :: Char -> Bool
esVocal 'a' = True
esVocal 'e' = True
esVocal 'i' = True
esVocal 'o' = True
esVocal 'u' = True
esVocal _ = False

cuatasVocales :: String -> Int
cuatasVocales nombre = length.filter esVocal $ nombre

chuckNorris ::  Monstruo
chuckNorris niño = ("abcdefghijkmnñopkrstuvwxyz", 1000, True)

ositoCariñosito :: Monstruo
ositoCariñosito (_, edad, _) = ("Uf", edad,  False)


--Ejercicio 4
trabajoEnEquipo :: [Monstruo] -> Niño -> [Grito]
trabajoEnEquipo monstruos niño =  pam monstruos niño

pam :: [a -> b] -> a -> [b]
pam funciones valor = map ($ valor) funciones

--Ejercicio 5
produccionEnergetica :: [Monstruo] -> [Niño] -> Int
produccionEnergetica monstruos niños = length.concat.map (pam monstruos) $ niños


--Ejercicio 6
type Risa = (Int,Int)
type Comediante = Niño -> Risa

capusotto :: Comediante
capusotto (nombre, edad, altura) = (2*edad, 2*edad)

produccionEnergeticaRisas :: [Comediante] -> [Niño] -> Int
produccionEnergeticaRisas comediantes  niños =  length.concat.map (pam comediantes)$ niños

--el de produccion energetica seria con ese formato