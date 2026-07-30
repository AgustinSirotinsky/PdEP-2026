import Text.Show.Functions

data Material = Material {
    nombre :: String, 
    calidad :: Int 
} deriving (Show, Eq)

data Edificio = Edificio {
    tipoDeEdificio :: String,
    materiales :: [Material]
} deriving (Show, Eq)

data Aldea = Aldea {

    poblacion :: Int,
    materialesDisponibles :: [Material],
    edificios :: [Edificio]
} deriving (Show,Eq)

--Ejercicio 1 
esValioso :: Material -> Bool
esValioso m = calidad m > 20

unidadesDisponbles :: String -> Aldea -> Int
unidadesDisponbles snombre aldea = length. filter (snombre ==) . map nombre . materialesDisponibles $ aldea

valorTotal :: Aldea -> Int
valorTotal aldea =  (sum  ((map calidad.materialesDisponibles) aldea)) + (sum ((map calidad.concat.map materiales.edificios) aldea))

--2
type Tarea = Aldea -> Aldea 
tenerGnomito :: Tarea 
tenerGnomito a = a {poblacion = poblacion a + 1}

lustrarMadera :: Tarea 
lustrarMadera a = a {materialesDisponibles = (filter (("Madera" /= ).sacarLasPrimeras6Letras) (materialesDisponibles a)) ++ mejorarMadera (materialesDisponibles a) }

mejorarMadera :: [Material] -> [Material]
mejorarMadera materiales = map  (aumentarCalidad 5) .filter (("Madera" == ).sacarLasPrimeras6Letras) $ materiales

sacarLasPrimeras6Letras :: Material -> String
sacarLasPrimeras6Letras m = take 6 (nombre m)

aumentarCalidad :: Int -> Material -> Material
aumentarCalidad num m = m {calidad = calidad m + num}

recolectar :: Material -> Int -> Tarea
recolectar material cantidad a = a {materialesDisponibles = (replicate cantidad material) ++ materialesDisponibles a} 

-- 3 hacer consultas

edificiosChetos :: Aldea -> [Edificio]
edificiosChetos aldea = filter (any esValioso. materiales). edificios $ aldea

-- obtenerListaNombresComunes :: Aldea -> [String]

--4 

realizarLasQueCumplan :: [Tarea] -> (Aldea->Bool)-> Aldea -> Aldea 
realizarLasQueCumplan  tareas condicion aldea = foldl (flip ($)) aldea (filter (esValida condicion aldea) tareas)

esValida :: (Aldea->Bool) -> Aldea ->Tarea -> Bool
esValida  condicion aldea tarea = condicion (tarea  aldea)