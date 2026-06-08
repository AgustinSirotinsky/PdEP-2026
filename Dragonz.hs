import Text.Show.Functions

data Guerrero = Guerrero {
    nombre :: String,
    nivelKi :: Double,
    cansado :: Double,
    raza :: Raza,
    personalidad :: Personalidad
} deriving (Show,Eq)

data Raza = Saiyajin | Humano | Namekiano deriving (Show,Eq)

--Punto 1
gohan = Guerrero "Gohan" 10000 0 Saiyajin Perezoso

--Punto 2 
esPoderoso :: Guerrero -> Bool
esPoderoso guerrero = (nivelKiMasQue 8000 guerrero)||((raza guerrero)==Saiyajin) 

nivelKiMasQue :: Double -> Guerrero -> Bool
nivelKiMasQue numero guerrero = (nivelKi guerrero)>numero

--punto 3

type Ejercicio = Guerrero -> Guerrero
modificarKi:: Double -> Guerrero -> Guerrero
modificarKi numero guerrero = guerrero {nivelKi= (+) (nivelKi guerrero) numero }

modificarCansancio :: Double -> Guerrero -> Guerrero
modificarCansancio numero guerrero = guerrero {cansado= (+) (cansado guerrero) numero}

pressEnBanca :: Ejercicio
pressEnBanca guerrero = modificarKi 90.modificarCansancio 100 $ guerrero

flexionesDeBrazo :: Ejercicio
flexionesDeBrazo guerrero = modificarCansancio 50 guerrero

saltosAlCajon :: Double -> Ejercicio
saltosAlCajon centrimetros guerrero = modificarCansancio(centrimetros/50).modificarKi (centrimetros/10)$ guerrero

snatch:: Ejercicio
snatch guerrero 
    | nivelKiMasQue 21999 guerrero = modificarKi ((nivelKi guerrero)* 0.05). modificarCansancio ((cansado guerrero)*0.10) $ guerrero
    | otherwise = modificarCansancio 100 guerrero

fresco::(Ejercicio) -> Guerrero-> Guerrero 
fresco ejercicio guerrero = ejercicio guerrero

estaCansado :: (Ejercicio) -> Guerrero -> Guerrero
estaCansado ejercicio guerrero = guerrero {
    nombre = nombre guerrero,
    nivelKi = (cualEsElAumentoKi ejercicio guerrero) + (nivelKi(ejercicio guerrero)),
    cansado = ((cualEsElAumentoCansado ejercicio guerrero)*3) + (cansado (ejercicio guerrero)),
    raza = raza guerrero
}

cualEsElAumentoCansado:: (Ejercicio) -> Guerrero -> Double
cualEsElAumentoCansado ejercicio guerrero = (cansado(ejercicio guerrero)) - (cansado guerrero)

cualEsElAumentoKi :: (Ejercicio) -> Guerrero -> Double
cualEsElAumentoKi ejercicio guerrero = (nivelKi (ejercicio guerrero)) -(nivelKi guerrero)

exhausto :: Guerrero -> Guerrero
exhausto guerrero = modificarCansancio ((-(cansado guerrero ))*0.2) guerrero

realizarUnEjercico :: (Ejercicio) -> Guerrero -> Guerrero
realizarUnEjercico ejercicio guerrero   
    | (cansado guerrero)>((nivelKi guerrero)*0.44) = estaCansado ejercicio guerrero
    | (cansado guerrero)>((nivelKi guerrero)*0.72) = exhausto guerrero
    | otherwise = fresco ejercicio guerrero

vegeta = Guerrero "Vegeta" 25000 2000 Saiyajin Sacados
piccolo = Guerrero "Piccolo" 15000 0 Namekiano Sacados
krilin = Guerrero "Krilin" 7500 200 Humano NoSe
bulma = Guerrero "Bulma" 100 45 Humano NoSe
yajirobe = Guerrero "Yajirobe" 100 45 Humano Tramposo

data Personalidad = Sacados | Perezoso | Tramposo | NoSe deriving (Show,Eq)
--punto 4
armarRutina :: Guerrero -> [Ejercicio] -> [Ejercicio]
armarRutina guerrero ejercicios 
    | (personalidad guerrero) == Perezoso = descansarEntre  ejercicios 
    | (personalidad guerrero) == Tramposo = []
    | otherwise = ejercicios
descansar :: Double  -> Guerrero -> Guerrero
descansar minutos guerrero = modificarCansancio (-(factorial minutos)) guerrero 

factorial :: Double -> Double
factorial 0 = 1
factorial 1 = 1
factorial n = n * (factorial (n-1))

descansarEntre :: [Ejercicio] -> [Ejercicio]
descansarEntre [] = []
descansarEntre [x] = flip (:) [x] (descansar 5)
descansarEntre (x:xs) = (x: descansar 5 : descansarEntre (xs))


--Ejercicio 5 

realizarUnaRutina::[Ejercicio] -> Guerrero -> Guerrero
realizarUnaRutina ejercicios guerrero = foldl (flip($)) guerrero (armarRutina guerrero ejercicios)

--el 6 arriba

--3l 7

