import Text.Show.Functions

data Auto = Auto {
    marca :: String,
    modelo :: String,
    desgaste :: (Double,Double),
    velocidadMaxima :: Double,
    tiempoDeCarrera :: Double
} deriving (Show)

f50 = Auto "Ferrari" "F50" (0,0) 65 0
diablo = Auto "Lamborghini" "Diablo" (7,4) 73 0
modelo600 = Auto "Fiat" "600" (33,27) 44 0

estaEnBuenEstado :: Auto -> Bool
estaEnBuenEstado auto = (chasisMasCuarenta auto)&&(ruedasMasSesenta auto)

chasisMasCuarenta :: Auto -> Bool
chasisMasCuarenta auto = (fst(desgaste auto))> 40

ruedasMasSesenta :: Auto -> Bool
ruedasMasSesenta auto = (snd(desgaste auto))>60

autoNoDaMas :: Auto -> Bool
autoNoDaMas auto = algunoMayorAOchenta (desgaste auto)

algunoMayorAOchenta :: (Double,Double) -> Bool
algunoMayorAOchenta (chasis, ruedas) = (chasis >80) || (ruedas >80)

reemplazarChasis :: Double -> Auto -> Auto
reemplazarChasis numero auto = auto {desgaste=(numero,snd (desgaste auto))}

reemplazarRuedas :: Double -> Auto -> Auto
reemplazarRuedas numero auto = auto {desgaste = (chasis auto,numero)}

chasis :: Auto -> Double
chasis auto = fst.desgaste $auto

repararAuto :: Auto ->  Auto
repararAuto auto = reemplazarRuedas 0.reemplazarChasis (reglaDeTres 85 (chasis auto)) $ auto

reglaDeTres :: Double -> Double -> Double
reglaDeTres porcentaje total = total - ( (porcentaje * total) / 100)

curva:: Double -> Double ->  Auto -> Auto
curva grado longitud auto = aumentarTiempo (longitud/(velocidadMaxima auto)/2) .dañoAdicionalALasRuedas grado longitud $ auto

dañoAdicionalALasRuedas:: Double -> Double -> Auto-> Auto
dañoAdicionalALasRuedas angulo longitud auto = aumentarDesgasteRuedas (3*longitud / angulo) auto

aumentarDesgasteRuedas :: Double -> Auto -> Auto
aumentarDesgasteRuedas numero auto = auto {desgaste = (chasis auto, numero +(snd (desgaste auto)))}

aumentarTiempo:: Double -> Auto -> Auto
aumentarTiempo numero auto = auto { tiempoDeCarrera = numero + tiempoDeCarrera auto}

curvaPeligrosa :: Auto -> Auto
curvaPeligrosa auto = curva 60 330 auto

curvaTranca :: Auto -> Auto  
curvaTranca auto = curva 110 550 auto

tramoRecto :: Double -> Auto -> Auto
tramoRecto longitud auto = modificarChasis (longitud / 10) auto

modificarChasis :: Double -> Auto -> Auto
modificarChasis numero auto = auto {desgaste = (numero + chasis auto, snd (desgaste auto))}

tramoRectoClasico :: Auto -> Auto
tramoRectoClasico auto = tramoRecto 750 auto

tramito :: Auto -> Auto
tramito auto = tramoRecto 280 auto

tramoBoxes :: Double -> Auto -> Auto
tramoBoxes tramo auto 
    | estaEnBuenEstado auto = tramoRecto tramo auto
    | otherwise = aumentarTiempo 10.tramoRecto tramo .repararAuto $ auto

pistaMojada :: (Auto -> Auto)-> Auto -> Auto
pistaMojada tramo auto = aumentarTiempo ((tiempoDeCarrera(tramo auto)) / 2).tramo $ auto

ripio :: (Auto -> Auto) -> Auto -> Auto
ripio tramo auto = tramo.tramo $auto

tramosObstruido :: Double -> Auto -> Auto
tramosObstruido metros auto = aumentarDesgasteRuedas (metros / 2) auto

pasarPorTramo :: (Auto->Auto) -> Auto ->Auto
pasarPorTramo tramo auto 
    | autoNoDaMas auto = auto
    |otherwise = tramo auto


superPista :: Auto -> Auto
superPista = tramoBoxes 800.curvaPeligrosa.tramoRecto 970.ripio tramito.tramoRectoClasico

