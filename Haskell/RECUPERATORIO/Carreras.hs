import Text.Show.Functions
import Data.List

--TIPOS PARA PRUBAS

a1 = Auto "rojo"  100  50
a2 = Auto "azul" 80  55
a3 = Auto "verde"  90   20
a4 = Auto "negro"  70   100
autox = Auto "Naranja" 100 50

carrera = [a1, a2, a3, a4]

--DECLARAR TIPO DE AUTO Y CARRERA Y Desarrollar unas Funciones

data Auto = Auto {
    color :: String,
    velocidad :: Int,
    distancia :: Int
} deriving (Show,Eq)

type Carrera = [Auto]  

estaCerca :: Auto -> Auto -> Bool
estaCerca unAuto otroAuto = unAuto /=  otroAuto && distanciaEntre unAuto otroAuto < 10

distanciaEntre :: Auto -> Auto -> Int
distanciaEntre unAuto otroAuto = abs (distancia unAuto - distancia otroAuto)

vaTranquilo :: Auto -> Carrera -> Bool
vaTranquilo unAuto unaCarrera =  all (not.estaCerca unAuto) unaCarrera && all ((distancia unAuto >)  ) (map distancia (filter (unAuto /=) unaCarrera))

puesto :: Auto -> Carrera -> Int 
puesto auto carrera = (+1).length.filter (not.vaGanando auto).filter (auto /= ) $ carrera

vaGanando :: Auto -> Auto -> Bool
vaGanando unAuto auto = distancia unAuto > distancia auto 

--Desarrollar funciones necesarias para manipular el estado del os auyos para que sea posible
--AUX+
modificarDistancia :: Auto -> Int -> Auto 
modificarDistancia auto numero = auto {distancia = distancia auto + numero}

modificarVelocidad :: Auto -> Int -> Auto
modificarVelocidad auto numer = auto {velocidad = velocidad auto + numer}
---------------------
correrPor :: Auto -> Int -> Auto
correrPor auto tiempo = modificarDistancia auto (tiempo * velocidad auto)

alterarLaVelocidad :: (Int -> Int) -> Auto -> Auto
alterarLaVelocidad func auto = auto {velocidad = func ( velocidad auto)}

bajarLaVelocidad:: Auto -> Int -> Auto
bajarLaVelocidad auto numero 
    | velocidad auto > numero = modificarVelocidad auto  (-numero)
    | otherwise = modificarVelocidad auto (-(velocidad auto))

--PowerUPS tenemos la func  afectarALosQueCumplen :: (a-> Bool) -> (a->a) -> [a] -> [a]

afectarALosQueCumplen :: (a-> Bool) -> (a->a) -> [a] -> [a]
afectarALosQueCumplen criterio efecto lista = (map efecto. filter criterio) lista ++ filter (not.criterio) lista

type PowerUp = (Auto -> Carrera -> Carrera)

terremoto ::  PowerUp 
terremoto auto  carrera = afectarALosQueCumplen (estaCerca auto) ( flip bajarLaVelocidad 50 ) carrera 

miguelitos :: Int -> PowerUp
miguelitos numero auto carrera = afectarALosQueCumplen (vaGanando auto) (flip bajarLaVelocidad numero) carrera

jetPack :: Int -> PowerUp
jetPack tiempo auto carrera = afectarALosQueCumplen (auto == ) (flip modificarVelocidad (-(velocidad auto)).flip correrPor tiempo. flip modificarVelocidad (velocidad auto)) carrera

--Eventos! son basicamente [Carrera->Carrera]

type Evento = Carrera -> Carrera
type Color = String

simularCarrera :: Carrera -> [Evento] -> [(Int,String)]
simularCarrera carrera eventos = map (flip posicion (foldl (flip ($)) carrera eventos)) (foldl (flip ($)) carrera eventos)

posicion :: Auto -> Carrera -> (Int,String)
posicion auto carrera = (puesto auto carrera, color auto)

correnTodos :: Int -> Carrera -> Carrera
correnTodos  tiempo carrera = map (flip correrPor tiempo) carrera

usaPowerUp :: PowerUp -> Color -> Evento 
usaPowerUp powerup colorAuto carrera = powerup (encontrarAuto colorAuto carrera) carrera

encontrarAuto :: Color -> Carrera -> Auto 
encontrarAuto colorBuscar  carrera = head (filter (buscarAuto colorBuscar) carrera)

buscarAuto :: Color -> Auto -> Bool
buscarAuto colorBuscar auto2 = colorBuscar == color auto2

carreraInicial = [Auto "rojo" 120 0, Auto "blanco" 120 0, Auto "azul" 120 0, Auto "negro" 120 0]
eventos = [correnTodos 30, usaPowerUp (jetPack 3) "azul", usaPowerUp terremoto "blanco", correnTodos 40, usaPowerUp (miguelitos 20) "blanco", usaPowerUp (jetPack 6) "negro", correnTodos 10]

-- 5
-- Sí se podria agregar sin problema como una función más misilTeledirigido :: Color -> PowerUp
-- y utilizarlo usarPoweUp (misilTeledirigido  "azul") "rojo" 
-- La función del 1b si sería posible usarla "vaTranquilo" puede terminar sólo si el auto indicado no va tranquilo
-- (en este caso por tener a alguien cerca, si las condiciones estuvieran al revés, 
-- terminaría si se encuentra alguno al que no le gana).
-- Esto es gracias a la evaluación perezosa, any es capaz de retornar True si se encuentra alguno que cumpla 
-- la condición indicada, y all es capaz de retornar False si alguno no cumple la condición correspondiente. 
-- Sin embargo, no podría terminar si se tratara de un auto que va tranquilo.

-- para la funcion "puesto" no puede terminar nunca porque hace falta saber cuántos le van ganando, entonces por más 
-- que se pueda tratar de filtrar el conjunto de autos, nunca se llegaría al final para calcular la longitud