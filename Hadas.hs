import Text.Show.Functions
import Data.List
data Chico = Chico {
    nombre :: String,
    edad :: Double,
    susHabilidades :: [String],
    deseos :: [Deseo]
} deriving (Show)

type Deseo = Chico -> Chico 

timmy = Chico "Timmy" 10 ["mirar television","jugar en la pc"] [serMayor]

--Punto 1
--a
aprenderHabilidaes :: [String] -> Chico -> Chico
aprenderHabilidaes habilidades unChico = unChico {susHabilidades = habilidades ++ (susHabilidades unChico)}

--b
serGrosoEnNeedForSpeed :: Deseo
serGrosoEnNeedForSpeed chico = aprenderHabilidaes (jugarNeedPasadasYFuturas 1) chico

jugarNeedPasadasYFuturas :: Int -> [String]
jugarNeedPasadasYFuturas num = (("jugar need for speed " ++ show num ): ( jugarNeedPasadasYFuturas (num + 1)))

serMayor :: Deseo
serMayor chico = chico {edad = 18}

--Ejercicio 2
type Hada = Chico -> Chico

aumentarEdad :: Double -> Chico -> Chico
aumentarEdad num chico = chico {edad =(+) num (edad chico)}

aplicarUnDeseo :: (Deseo) -> Chico -> Chico
aplicarUnDeseo deseo chico = deseo chico

wanda :: Hada
wanda chico =  aumentarEdad 1.aplicarUnDeseo (head (deseos chico)) $ chico

cosmo :: Hada
cosmo chico = aumentarEdad (-((edad chico)/2)) chico 

muffinMagico :: Hada
muffinMagico chico = foldl (flip($)) chico (deseos chico)

--ejercucio 3

tieneHabilidad :: String -> Chico -> Bool
tieneHabilidad habilidad chico = any (== habilidad) (susHabilidades chico)

esSuperMaduro :: Chico -> Bool
esSuperMaduro chico = ((edad chico)==18) && (tieneHabilidad "manejar" chico)

data Chica = Chica {
    nombreChica :: String,
    condicion :: Chico -> Bool
} deriving (Show)

noEsTimmy :: Chico -> Bool
noEsTimmy chico = (nombre chico) /= "Timmy"

trixie = Chica "Trixie" noEsTimmy
vicky = Chica "Vicky" (tieneHabilidad "ser un supermodelo noruego")
