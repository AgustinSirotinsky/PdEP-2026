--EXAMENNNN

type Artefacto = (String, Int)

data Heroe = Heroe {
   --- nombre :: String, no lo usan
    epiteto :: String,
    reconocimiento :: Int,
    artefactos :: [Artefacto],
    tarea :: [String] 
} deriving (Show,Eq)

xiphos = ("Xiphos", 50)
rayo = ("Rayo de Zeus", 500)


cambiarEpiteto :: String -> Heroe -> Heroe
cambiarEpiteto e h = h {epiteto = e}

agregarArtefacto :: Artefacto -> Heroe -> Heroe 
agregarArtefacto a h = h {artefactos = a : (artefactos h)}

pasarALaHistoria :: Heroe -> Heroe
pasarALaHistoria h 
    | reconocimiento h > 1000 = cambiarEpiteto "El Magnifico" h
    | reconocimiento h > 500 = cambiarEpiteto "El Magnifico" .agregarArtefacto rayo $ h -- upuedo usar $
    | reconocimiento h >  100 = cambiarEpiteto "hoplita" (agregarArtefacto xiphos h )
    | otherwise = id h -- sin el id

--Expresividad, guardas, record syntax, tuplas

--Control d para todas las simmilitudes y cambiar
--CORRECCIONES POSIBLES H--- DEBERIA SER HEROE por la expresividad

-- Tarea son funciones que reciven heroe y devuelve heroe
--rareza = snd a
type Tarea = Heroe -> Heroe
encontrarUnArtefacto :: Heroe -> Artefacto -> Heroe
encontrarUnArtefacto h a = h { reconocimiento = reconocimiento h + snd a , artefactos = a : artefactos h, tarea = ("Encontrar un " ++ (fst a)) : tarea h}
    --ganarREconocimiento (rareza a) ((agregrarArtefacto a h) ---CREAR FUNCION
escalarElOlimpo :: Heroe -> Heroe
escalarElOlimpo h = h {reconocimiento = reconocimiento h + 500, artefactos = filter ((> 1000).snd). map triplicarRareza.artefactos $ h  } 

triplicarRareza :: Artefacto -> Artefacto
triplicarRareza (a,b) = (a, b*3) 

--MEJORAR FUNCIONAL; SE REPITE MUCHO EL PRIMERO. SI SE REPITE FUNCION QUE LO HAGA PARA NO RESCRIBBIR 

ayudarACruzarLaCalle ::  Heroe -> Int -> Heroe
ayudarACruzarLaCalle a 0 = a
ayudarACruzarLaCalle h a= cambiarEpiteto (modificarGlorioso a "Gros") h
modificarGlorioso ::  Int -> String -> String
modificarGlorioso a s = s ++ (replicate a ('o'))

data Bestia = Bestia {
    nombre :: String,
    debilidad :: Heroe  -> Bool
}

--matarUnaBestia :: Heroe  -> Bestia -> Heroe
--matarUnaBestia h b 
--    | (debilidad b) h = cambiarEpiteto ... 
--    |otherwise = mapArtefactos (tail) h... 