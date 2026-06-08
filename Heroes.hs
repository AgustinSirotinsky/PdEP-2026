data Heroe = Heroe {
    epiteto :: String,
    reconocimiento:: Int,
    artefactos:: [Artefacto],
    tareas :: [Tarea]
}

type Artefacto = (String, Int) --Nombre y rareza

xiphos :: Artefacto
xiphos = ("Xiphos", 50)

rayo :: Artefacto
rayo = ("Rayo de Zeus", 500)

--Uno de los cambios que haria es cambiar h por Heroe, asi es mas descriptivo! 
--otra forma es pattern matching para evitar usar guardas y saltear el otherWise
pasarALaHistoria :: Heroe -> Heroe
pasarALaHistoria heroe 
    | reconocimiento heroe > 1000 = cambiarEpiteto "El Mitico" heroe
    | reconocimiento heroe > 500 = cambiarEpiteto "El magnifico" (agregarArtefacto rayo heroe)
    | reconocimiento heroe > 100 = cambiarEpiteto "Hoplita" (agregarArtefacto xiphos heroe)
    | otherwise = heroe

--Otra cosa para mejorar es tercerizar el > con una funcion mayorA. para no reptir

cambiarEpiteto :: String -> Heroe -> Heroe
cambiarEpiteto nuevoEpiteto heroe = heroe {epiteto = nuevoEpiteto}

agregarArtefacto :: Artefacto -> Heroe -> Heroe
agregarArtefacto artefacto heroe = heroe {artefactos = artefacto : artefactos heroe}

--Punto 3
type Tarea = Heroe -> Heroe
--agrego Tarea al data heroe
modificarTarea:: Tarea ->  Heroe -> Heroe
modificarTarea tarea heroe = heroe {tareas = tarea : tareas heroe}

modificarReconocimiento :: Int -> Heroe -> Heroe
modificarReconocimiento numero heroe = heroe {reconocimiento= (+) numero (reconocimiento heroe)}

encontrarUnArtefacto :: Artefacto-> Tarea
encontrarUnArtefacto (nombre,rareza) heroe = modificarTarea (encontrarUnArtefacto (nombre,rareza)).agregarArtefacto (nombre,rareza). modificarReconocimiento (rareza) $ heroe

escalarOlimpo :: Tarea
escalarOlimpo = agregarArtefacto rayo.filtrarArtefacto. triplicarRareza . modificarReconocimiento 500

triplicarRareza :: Heroe -> Heroe
triplicarRareza heroe = heroe { artefactos = map triplicarRarezaArtefacto (artefactos heroe) }

triplicarRarezaArtefacto :: (String, Int) -> (String, Int)
triplicarRarezaArtefacto (nombre, rareza) = (nombre, rareza * 3)

filtrarArtefacto :: Heroe -> Heroe
filtrarArtefacto heroe = heroe {artefactos = filter ((>= 1000) . snd ) (artefactos heroe)}

ayudarCruzar :: Int -> Tarea
ayudarCruzar cuadras heroe = cambiarEpiteto ("Gros" ++ ( replicate cuadras 'o')) heroe

matarBestia :: Bestia -> Heroe -> Heroe
matarBestia (nombreBestia, debilidad) heroe
    |debilidad heroe = cambiarEpiteto ("El Asesino de " ++ nombreBestia) heroe
    |otherwise = heroe {artefactos = drop 1 (artefactos heroe)}


type Bestia = (String, Heroe -> Bool)


{-
punto 4

esMejor unHeroe otro = reconocimiento unHeroe > reconocimiento otro || sumarRarezas (artefactos unHeroe) > sumarRarezas (arte otro)

sumarRarezas [] = 0
sumarRarezas (x:xs) = fst x + sumarRarezas xs



Cosas a mejorar: mayor descripcion en los nombres, typear las funciones, es snd no fst ( quizas resolverlo son map y sum)
derivar funciones , quixas usar max

-}


--punto 5

