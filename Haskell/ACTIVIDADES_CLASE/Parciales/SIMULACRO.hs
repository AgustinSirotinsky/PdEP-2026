import Text.Show.Functions

--punto 1
proteccionEfectiva :: Persona -> Int
proteccionEfectiva persona = foldl (flip ($)) (valentia persona) . inventario $ persona

type Obejto = Int -> Int  

data Persona = Persona { 
    valentia :: Int,
    familia :: [Persona],
    inventario :: [Obejto] 
} deriving (Show)

mascara :: Obejto
mascara numero = (+) 20 numero

rifle :: Int -> Obejto
rifle balas numero = (+) balas numero

brujula :: String -> Obejto
brujula direccion numero 
    | masOMenosAlNorte direccion = (+) numero 10
    | otherwise = numero

masOMenosAlNorte :: String -> Bool
masOMenosAlNorte = ("Nor" ==).take 3


salirAlExterior :: Persona -> Bool
salirAlExterior persona= all salirAlExteriorUno. (: (familia persona)) $ persona

salirAlExteriorUno :: Persona -> Bool
salirAlExteriorUno persona = (proteccionEfectiva persona) >= 80


type Lugar = Persona -> Persona

centro :: Lugar 
centro persona = agregarFamiliar infiltrado persona

agregarFamiliar :: Persona -> Persona -> Persona
agregarFamiliar nuevoFamiliar persona = persona { familia = nuevoFamiliar : (familia persona)}

infiltrado = Persona 100 (repeat infiltrado) []

campoDeMayo :: Lugar 
campoDeMayo persona = agregarObjetos (rifle 12) persona

agregarObjetos :: Obejto -> Persona -> Persona
agregarObjetos objeto persona = persona {inventario = objeto : (inventario persona)}

farmaciaSaqueada :: Lugar
farmaciaSaqueada persona = persona {inventario = []}

coferenciaProMercado :: Lugar
coferenciaProMercado persona = sumarValentia (reglaDeTres (puntosPorcentuales persona) (valentia persona)) persona
 
sumarValentia :: Int -> Persona -> Persona
sumarValentia numero persona = persona {valentia= (+) (valentia persona) numero}

puntosPorcentuales :: Persona -> Int
puntosPorcentuales persona = ((length.inventario) persona) + ((sum.map length.map inventario.familia)persona)

reglaDeTres :: Int -> Int -> Int
reglaDeTres porcentaje total = div (total*porcentaje) 100

visitarUnLugar :: Persona -> Lugar -> Persona
visitarUnLugar persona lugar 
    | salirAlExterior persona = (lugar persona) {familia = map lugar (familia (lugar persona))}
    |otherwise = persona

type Tour = [Lugar]

esConveniente :: Tour -> Persona -> Bool
esConveniente tour persona = (proteccionEfectiva (hacerElTour tour persona)) > (proteccionEfectiva persona)

hacerElTour :: Tour -> Persona -> Persona
hacerElTour tour persona = foldl (visitarUnLugar) persona tour 

juan = Persona 80 [] []

