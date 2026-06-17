import Text.Show.Functions

data Serie = Serie {
    nombreSerie:: String,
    actores :: [Actor],
    presupuesto :: Int,
    cantitidadTemporadas:: Int,
    rating :: Double,
    cancelada::Bool
} deriving (Show)

data Actor = Actor {
    sueldo :: Int,
    restricciones :: [String]
} deriving (Show)

--punto 1 

estaEnRojo :: Serie -> Bool
estaEnRojo serie = (totalSueldos serie)==(presupuesto serie)

totalSueldos :: Serie -> Int
totalSueldos serie =  sum.map sueldo.actores $ serie

esProblematica :: Serie -> Bool
esProblematica serie = cantidadDeActoresConMasDeUnaRestriccion serie > 3

cantidadDeActoresConMasDeUnaRestriccion :: Serie -> Int
cantidadDeActoresConMasDeUnaRestriccion serie = length.filter (>1).map length.map restricciones .actores $ serie

--Punto 2 
type Productores = Serie -> Serie

conFavoritismo::[Actor] -> Productores
conFavoritismo actorFavoritos serie = serie {actores = actorFavoritos ++ ((drop 2.actores) serie)}

timBurton :: Productores
timBurton serie = conFavoritismo [jhonnyDep, helenaBonham] serie

jhonnyDep = Actor 20000000000000 []
helenaBonham =Actor 22222222222 []

gatopardeitor :: Productores
gatopardeitor serie = serie

estireitor :: Productores
estireitor serie = serie {cantitidadTemporadas = (cantitidadTemporadas serie)*2}

desepereitor :: Productores
desepereitor = estireitor.gatopardeitor

canceleitor :: Double -> Productores
canceleitor cifra serie
    | (estaEnRojo serie) || (cifra >(rating serie)) = serie {cancelada = True}
    | otherwise = serie

--Punto 3 
bienestar:: Serie -> Int
bienestar serie = (bienestarTemporadas serie) + bienestarLongitud serie


bienestarTemporadas :: Serie -> Int
bienestarTemporadas serie 
    | (cantitidadTemporadas serie) >4 = 5
    | otherwise = 10 -((cantitidadTemporadas serie) * 2) 

bienestarLongitud :: Serie -> Int
bienestarLongitud serie 
    | ((length.actores) serie )> 10 = 3
    | otherwise = (-) 10 ((length.filter (>2).map length. map restricciones. actores) serie)


--Punto 6

controvertida :: Serie -> Bool
controvertida serie = not (cobraMasQueElSiguiente (actores serie))

cobraMasQueElSiguiente :: [Actor] -> Bool
cobraMasQueElSiguiente (x:[]) = True
cobraMasQueElSiguiente (x:xs:xss) = ((sueldo x) > (sueldo xs)) && (cobraMasQueElSiguiente xss)
