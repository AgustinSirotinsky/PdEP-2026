import Text.Show.Functions

--Modelar Personaje Guantelete y Universo como tipos de Datos   e implementar chasquido

data Personaje = Personaje {
    edad :: Int,
    energia :: Int,
    habilidades :: [String],
    nombre :: String,
    planetaOrigen :: String
} deriving (Show, Eq)

type Universo = [Personaje]

--Para Desarrollar el guanteleto tenes que leer la segunda parte

data Guantelete = Guantelete {
    material :: String,
    gemas :: [Personaje -> Personaje]
} deriving (Show)

chasquido :: Guantelete -> Universo -> Universo
chasquido guantelete universo  
    | length (gemas guantelete) == 6 && "uru" == material guantelete = take (div (length universo) 2) universo
    | otherwise = id universo

--Punto 2
aptoPendex :: Universo -> Bool 
aptoPendex universo = any ((45>).edad) universo

energiaTotal :: Universo -> Int 
energiaTotal universo =  sum.map energia.filter (((1<).(length.habilidades))) $ universo

--PArte 2
modificarEnergia :: Int -> Personaje -> Personaje 
modificarEnergia valor personaje = personaje {energia = energia personaje + valor }

remplazarEdad :: Int -> Personaje -> Personaje 
remplazarEdad num p = p {edad = num}


mente :: Int -> Personaje -> Personaje 
mente valor = modificarEnergia (-valor) 

alma :: String -> Personaje -> Personaje 
alma habilidad personaje 
    | elem habilidad (habilidades personaje) = quitarHabilidad habilidad.modificarEnergia (-10) $  personaje 
    | otherwise = modificarEnergia (-10) $  personaje 

quitarHabilidad :: String -> Personaje -> Personaje 
quitarHabilidad habilidad p = p {habilidades = filter (/= habilidad) (habilidades p)}

tiempo :: Personaje -> Personaje 
tiempo personaje  
    | (edad personaje) > 18  && (div (edad personaje)  2 > 18) = modificarEnergia (-50).remplazarEdad ( div (edad personaje) 2) $ personaje
    | otherwise = id personaje

laGemaLoca :: (Personaje -> Personaje) -> Personaje  -> Personaje 
laGemaLoca  gema personaje = gema.gema $ personaje 

--Punto 4
guantelete = Guantelete "goma" [tiempo, alma "usar Mjolnir", laGemaLoca (alma "programacion Haskell") ]
thor = Personaje {edad=1500, energia=1000, habilidades=["usar Mjolnir","programación en Haskell"], nombre="thor", planetaOrigen="Asgard"}

punisher = Personaje {edad=50, energia=200, habilidades=["armas","punteria","sigilo"], nombre="punisher", planetaOrigen="Tierra"}
--Punto 5 SIN RECURSIVIDAD
utilizar :: [Personaje -> Personaje] -> Personaje -> Personaje 
utilizar gemas victima = foldl (flip ($)) victima gemas

--Punto 6 
gemaMasPoderosa :: Guantelete -> Personaje -> (Personaje -> Personaje)
gemaMasPoderosa guantelete persona = gemaDeMayorPoder (gemas guantelete) persona

gemaDeMayorPoder :: [Personaje -> Personaje] -> Personaje -> (Personaje -> Personaje)
gemaDeMayorPoder (x:[]) p = x
gemaDeMayorPoder (x:xs:xss) p 
    | energia (x p) < energia (xs p) = gemaDeMayorPoder (x:xss) p
    | energia (xs p) < energia (x p) = gemaDeMayorPoder (xs:xss) p 
    | energia (xs p) == energia (x p ) = gemaDeMayorPoder (xs : xss) p

--Punto 7

