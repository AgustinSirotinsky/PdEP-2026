-- =========================================================
-- SITUACIONES
-- =========================================================

data Aspecto = UnAspecto {
  tipoDeAspecto :: String,
  grado :: Float
} deriving (Show, Eq)

type Situacion = [Aspecto]

mejorAspecto mejor peor = grado mejor < grado peor

mismoAspecto aspecto1 aspecto2 = tipoDeAspecto aspecto1 == tipoDeAspecto aspecto2

buscarAspecto aspectoBuscado = head . filter (mismoAspecto aspectoBuscado)

buscarAspectoDeTipo tipo = buscarAspecto (UnAspecto tipo 0)

reemplazarAspecto aspectoBuscado situacion =
    aspectoBuscado : (filter (not . mismoAspecto aspectoBuscado) situacion)

-- Modifica un aspecto aplicando una función a su grado
modificarAspecto :: (Float -> Float) -> Aspecto -> Aspecto
modificarAspecto f aspecto = UnAspecto (tipoDeAspecto aspecto) (f (grado aspecto))

-- Una situación es mejor que otra si cada aspecto de la primera
-- es mejor que el aspecto del mismo tipo en la segunda
esMejorSituacion :: Situacion -> Situacion -> Bool
esMejorSituacion situacion1 situacion2 =
    all (\aspecto -> mejorAspecto aspecto (buscarAspecto aspecto situacion2)) situacion1

-- Modifica, dentro de una situación, el grado del aspecto de cierto tipo
-- aplicando la función f indicada
modificarSituacion :: String -> (Float -> Float) -> Situacion -> Situacion
modificarSituacion tipo f situacion =
    reemplazarAspecto (modificarAspecto f (buscarAspectoDeTipo tipo situacion)) situacion


-- =========================================================
-- GEMAS Y PERSONALIDADES
-- =========================================================

type Personalidad = Situacion -> Situacion

data Gema = UnaGema {
  nombre :: String,
  fuerza :: Float,
  personalidad :: Personalidad
}

-- vidente: disminuye a la mitad la incertidumbre y baja 10 la tensión
vidente :: Personalidad
vidente situacion =
    modificarSituacion "tension" (subtract 10)
        (modificarSituacion "incertidumbre" (/ 2) situacion)

-- relajada: disminuye 30 la tensión y aumenta el peligro según el nivel de relajamiento
relajada :: Float -> Personalidad
relajada nivel situacion =
    modificarSituacion "peligro" (+ nivel)
        (modificarSituacion "tension" (subtract 30) situacion)

-- Ejemplos de creación de Gemas
garnet :: Gema
garnet = UnaGema "Garnet" 8 vidente

amatista :: Gema
amatista = UnaGema "Amatista" 6 (relajada 15)   -- nivel de relajamiento = 15


-- =========================================================
-- LE GANA
-- =========================================================

-- gema1 le gana a gema2 en una situación si gema1 es más o igual de
-- fuerte, y la situación que resulta de aplicar su personalidad es
-- mejor que la que resulta de aplicar la personalidad de gema2
leGana :: Situacion -> Gema -> Gema -> Bool
leGana situacion gema1 gema2 =
    fuerza gema1 >= fuerza gema2
    && esMejorSituacion (personalidad gema1 situacion) (personalidad gema2 situacion)


-- =========================================================
-- FUSIÓN
-- =========================================================

-- Baja en 10 todos los aspectos de una situación
bajarTodos :: Situacion -> Situacion
bajarTodos = map (modificarAspecto (subtract 10))

fusionar :: Situacion -> Gema -> Gema -> Gema
fusionar situacion gema1 gema2 =
    UnaGema nombreFusion fuerzaFusion personalidadFusion
  where
    -- Mismo nombre si las gemas se llaman igual; si no, la concatenación
    nombreFusion
      | nombre gema1 == nombre gema2 = nombre gema1
      | otherwise                    = nombre gema1 ++ nombre gema2

    -- Produce el mismo efecto que las gemas actuando en sucesión,
    -- luego de bajar en 10 todos los aspectos de la situación
    personalidadFusion s =
        personalidad gema2 (personalidad gema1 (bajarTodos s))

    -- Son compatibles si la personalidad fusionada produce una mejor
    -- situación que cada una de las personalidades individuales
    esCompatible =
        esMejorSituacion (personalidadFusion situacion) (personalidad gema1 situacion)
        && esMejorSituacion (personalidadFusion situacion) (personalidad gema2 situacion)

    -- La gema dominante es la que le gana a la otra
    gemaDominante
      | leGana situacion gema1 gema2 = gema1
      | otherwise                    = gema2

    -- Si son compatibles: suma de fuerzas * 10
    -- Si no: 7 veces la fuerza de la gema dominante
    fuerzaFusion
      | esCompatible = (fuerza gema1 + fuerza gema2) * 10
      | otherwise    = 7 * fuerza gemaDominante


-- =========================================================
-- FUSIÓN GRUPAL
-- =========================================================

-- Fusiona a todas las Gemas entre sí hasta que quede sólo una
fusionarGrupal :: Situacion -> [Gema] -> Gema
fusionarGrupal _ [gema] = gema
fusionarGrupal situacion (gema1:gema2:resto) =
    fusionarGrupal situacion (fusionar situacion gema1 gema2 : resto)