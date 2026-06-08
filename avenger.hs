import Text.Show.Functions
import Data.List

data Heroe = Heroe {
    nombreHeroe :: String,
    vida :: Int,
    planetaHeroe:: String,
    artefacto :: Artefacto,
    villano :: Villano
} deriving (Show)

type Artefacto = (String,Int)

data Villano = Villano {
    nombreVilano :: String,
    planetaVillano :: String,
    arma :: Arma
} deriving (Show)

--Punto 1
ironMan = Heroe "Tony Stark" 100 "La Tierra" ("Traje", 12) thanos
thor = Heroe "Thor Odison" 300 "Asgard" ("Stormbraker", 0) loki

thanos = Villano "Thanos" "Titan" guanteleteDelInfinito 
loki = Villano "Loki" "Asgard" (cetro 20)

--Punto 2
type Arma = Heroe -> Heroe

modificarVida :: Int -> Heroe -> Heroe
modificarVida numero heroe = heroe {vida = (vida heroe) + numero }

guanteleteDelInfinito :: Arma
guanteleteDelInfinito heroe = modificarVida (-(reglaDeTres 80 (vida heroe))) heroe

cetro :: Int -> Arma
cetro porcentaje heroe 
    | (planetaHeroe heroe) == "La Tierra" = modificarVida (-(reglaDeTres porcentaje (vida heroe))).romperArtefacto $ heroe
    | otherwise = modificarVida (-(reglaDeTres porcentaje (vida heroe))) heroe

reglaDeTres :: Int -> Int -> Int
reglaDeTres porcentaje total = div (porcentaje * total) 100

romperArtefacto :: Heroe -> Heroe
romperArtefacto heroe = heroe {artefacto= ((fst (artefacto heroe)++ " machacado"),(snd (artefacto heroe) + 30))}

--Punto 3
sonAntagonistas :: Heroe -> Villano -> Bool
sonAntagonistas heroe suVillano = ((nombreVilano(villano heroe)) == (nombreVilano suVillano)) && ((planetaHeroe heroe)==(planetaVillano suVillano))

--Punto 4
heroeAtacado :: [Villano] -> Heroe -> Heroe
heroeAtacado villanos heroe = foldl (ataque) heroe villanos

ataque :: Heroe ->  Villano ->Heroe
ataque  heroe villano
    | sonAntagonistas heroe villano = heroe
    | otherwise = (arma villano) heroe

--Punto 5
sobrevive :: Heroe -> Villano -> Heroe
sobrevive heroe villano
    | alMenos50 heroe villano = (ataque heroe villano) {nombreHeroe = (nombreHeroe heroe) ++ " Super"}
    | otherwise = heroe


alMenos50 :: Heroe -> Villano -> Bool
alMenos50 heroe villano = (vida(ataque heroe villano)) >= 50

--punto 6
vuelveACasa :: [Heroe] -> [Heroe]
vuelveACasa heroes =   map repararArtefacto.map (flip sobrevive thanos).filter (flip alMenos50 thanos) $ heroes

repararArtefacto :: Heroe -> Heroe
repararArtefacto heroe
    | (sacarLasUltimas9 ((fst.artefacto) heroe)== "machacado") = heroe {artefacto = (sacarLasUltimas9'((fst.artefacto) heroe), 0), vida = (vida heroe) + 30}
    | otherwise = heroe {artefacto = ((fst.artefacto)heroe, 0)}

sacarLasUltimas9 :: String -> String
sacarLasUltimas9 nombre = reverse.take 9.reverse $ nombre

sacarLasUltimas9' :: String -> String
sacarLasUltimas9' nombre = reverse.drop 9.reverse $ nombre

--Putno 8
drStrange = Heroe "Stephen Strange"   60 "Tierra" ("Capa de levitacion", 0) thanos

listaInfinitaDeDrStrange :: [Heroe]
listaInfinitaDeDrStrange = infinitos 1 drStrange

infinitos :: Int -> Heroe -> [Heroe]
infinitos numero heroe= (heroe {nombreHeroe =  (nombreHeroe heroe) ++ " " ++ (show numero)}) : (infinitos (numero+1)heroe)

--Punto 9 
{-
    
-}