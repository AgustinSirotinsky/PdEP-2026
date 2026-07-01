data Aspecto = UnAspecto {
  tipoDeAspecto :: String,
  grado :: Float
} deriving (Show, Eq)
type Situacion = [Aspecto]

mejorAspecto mejor peor = grado mejor < grado peor

mismoAspecto aspecto1 aspecto2 = tipoDeAspecto aspecto1 == tipoDeAspecto aspecto2

buscarAspecto aspectoBuscado = head.filter (mismoAspecto aspectoBuscado)

buscarAspectoDeTipo tipo = buscarAspecto (UnAspecto tipo 0)

reemplazarAspecto aspectoBuscado situacion =
    aspectoBuscado : (filter (not.mismoAspecto aspectoBuscado) situacion)

--Punto 1
modificarAspecto :: (Float -> Float) -> Aspecto ->  Aspecto
modificarAspecto funcion aspecto = aspecto{grado = funcion (grado aspecto)}

situacionMejorQueOtra :: Situacion -> Situacion -> Bool
situacionMejorQueOtra situacion1 situacion2 = all (flip  (mejorAspecto) (buscarAspecto(situacion2))) situacion1

