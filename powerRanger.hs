import Text.Show.Functions

data Persona = Persona {
    habilidades :: [String],
    esBuena :: Bool
} deriving (Show)

juan = Persona ["Sabe caminar"] True

data PowerRanger = PowerRanger {
    color :: String,
    habilidadesPower :: [String],
    nivelDePelea :: Int
} deriving (Show)

rojo = PowerRanger "Rojo" ["grita el color de su traje"] 9000

convertirEnPowerRanger :: String -> Persona -> PowerRanger
convertirEnPowerRanger color persona = PowerRanger color (habilidadesPotenciadas (habilidades persona)) (cantidadDeLetras (habilidades persona))

habilidadesPotenciadas :: [String] -> [String]
habilidadesPotenciadas unasHabilidades = map ("super"++) unasHabilidades

cantidadDeLetras :: [String] -> Int
cantidadDeLetras = length.concat

formarEqupoRaanger :: [String] -> [Persona] -> [PowerRanger]
formarEqupoRaanger [] [] = []
formarEqupoRaanger (ultimoColor:[]) (ultimaPersona:[]) 
    | esBuena ultimaPersona = [convertirEnPowerRanger ultimoColor ultimaPersona]
    | otherwise = []

formarEqupoRaanger (color:colorSiguiente) (persona : siguientePersona) 
    | esBuena persona = (convertirEnPowerRanger color persona : (formarEqupoRaanger colorSiguiente siguientePersona))
    | otherwise = formarEqupoRaanger colorSiguiente siguientePersona


colores = ["Rojo", "Azul", "Amarillo", "Rosa", "Negro"]

p1 = Persona ["Sabe caminar"] True
p2 = Persona ["Sabe correr"] True
p3 = Persona ["Sabe dormir"] False   -- no es buena
p4 = Persona ["Sabe saltar"] True
p5 = Persona ["Sabe llorar"] False


findOrElse :: (a->Bool) -> a -> [a] -> a
findOrElse condicion valor lista
    | any condicion lista = head (filter condicion lista)
    | otherwise = valor


rangerLider :: [PowerRanger] -> PowerRanger
rangerLider rangers = findOrElse ((== "Rojo").color) (head rangers) rangers

rangerHabilidoso :: PowerRanger -> Bool
rangerHabilidoso ranger = (length. habilidadesPower) ranger > 5

alfaCinco = PowerRanger "Metalico" ["repar cosas", infitosAy] 0

infitosAy :: String
infitosAy = cycle "ay"

data Chica = Chica {
    color :: String,
    cantPelo :: Int
} deriving (Show)


