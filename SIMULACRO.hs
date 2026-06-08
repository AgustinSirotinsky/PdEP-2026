import Text.Show.Functions

--PUNTO 1

protecctionEfectiva :: Persona -> Int
protecctionEfectiva p = foldr ($) (valentia p) . inventario $ p

--Ventajas: Funciona, es efectiva y rapida
--Desventajas: No sufccientemenete desscriptivo
--Conceptos: Operaciones avanzadas o de orden superior, listas, uso de record Sintax, composicion de funciones y
    --precedencia de funciones


protecctionEfectiva' :: Persona -> Int
protecctionEfectiva' unaPersona = protecctionEfectivaInventario unaPersona (inventario unaPersona)

protecctionEfectivaInventario :: Persona -> [Int->Int] -> Int
protecctionEfectivaInventario _ [] = 0
protecctionEfectivaInventario persona (objeto : inventario) = objeto (protecctionEfectivaInventario persona inventario) 



--Ventajas: descriptivo, muy claro para entender.
--Desventaja : esta mierda no funciona, nunca llama la valentia
--conceptos: recursividad, llamado de funciones, listas, el uso de  "_" , record sintax


--Punto 2
data Persona = Persona {
    valentia::Int,
    familia::[Persona],
    inventario::[Int->Int]
} deriving (Show)

--El tipo de la funcion es Persona -> Int
--Los posibles Objetos
mascara :: Int -> Int
mascara numero = (+) 20 numero

rifle :: Int -> Int -> Int
rifle balas numero = (+) balas numero


brujula :: String -> Int -> Int
brujula direccion numero
    | take  3 direccion == "Nor" = (+) 10 numero --La otra ess con Data Direccion = Norte | ....
    | otherwise = numero


{-
    Punto 3
        opcion1
            juan = Persona 50 [elena] [rifle, mascara, brujula]

        opcion2 
            omar = (70, [], [mascara])

    La preferible es la primera porque la segunda tiene el formato de una tupla, que para que sirva
    es Necesario agregar una funcion lo cual no es eficiente.

    Podrian convivir? si podr´ia, pero no seria comodo PARA NADA y al trabajar juntas seria un engorro

    la primera no funciona porque le faltan a algunos de los objetos unnos argumentos como para rifle unas
    balas y para brujula una direccion (string). En el caso de la segunda es necesario usar una funcion tuplaPersona
    que con esos elementos de la tupla grabo un data

    tuplaPersona :: (Int, [Persona], [Int -> Int]) -> Persona
    tuplaPersona (unaValentia, unaFamilia, unInventario) = Persona {
            valentia = unaValentia,
            familia = unaFamilia,
            inventario = UnInventario
    }
-}

-- punto 4

salirAlExterior :: Persona -> Bool
salirAlExterior persona = all (>= 80) (map (protecctionEfectiva)(persona:(familia persona)))
-- Podria tener un poquito menos de parentesis peroooo por miedo

--Moddifcadores
modificarValentia :: Int -> Persona -> Persona
modificarValentia numero persona = persona { valentia = valentia persona + numero}

modificarInventario :: (Int -> Int) -> Persona -> Persona
modificarInventario objeto persona = persona {inventario = objeto : inventario persona}

modificarFamilia :: Persona -> Persona -> Persona
modificarFamilia familiar persona = persona {familia = familiar : familia persona}

--Lugares 
centro :: Persona -> Persona
centro persona = modificarFamilia infiltrado persona

infiltrado :: Persona
infiltrado = Persona {
    valentia = 100,
    familia = repeat infiltrado,
    inventario = []
}

campoDeMayo :: Persona -> Persona
campoDeMayo persona = modificarInventario (rifle 12) persona

farmaciaSaqueada :: Persona -> Persona
farmaciaSaqueada persona = persona {inventario= []}

conferenciaProMercado :: Persona -> Persona
conferenciaProMercado persona = modificarValentia ((length (inventario persona))+ (cantObjetosFlia persona)) persona

cantObjetosFlia :: Persona -> Int
cantObjetosFlia persona = length.map ( inventario ).familia $ persona

visitarUnLugar :: (Persona -> Persona)-> Persona -> Persona
visitarUnLugar lugar persona 
    | salirAlExterior persona = (lugar persona) {familia= map lugar (familia persona) }
    | otherwise = persona

--Punto 5 

--No se falta que funcione en cada failiar porque si funca en uno listo chau, en los demas funciona
tourConveniente :: [Persona -> Persona ] -> Persona -> Bool
tourConveniente lugares persona = protecctionEfectiva (visitarTODOSLosLugares lugares persona) >  protecctionEfectiva persona 

visitarTODOSLosLugares :: [Persona -> Persona] -> Persona -> Persona
visitarTODOSLosLugares lugares persona = foldl (flip ($)) persona lugares

--Punto 6
--Depende! si la persona ya tenia familia con, al menos el o un familiar, un objeto en ese caso Si. si
--nadie tenia objetos, en ese caso, no.

--Punto 7

data Escuadron = Escuadron {
    nombre :: String,
    grupo :: [Persona]
} deriving (Show)

escuadronOrganizado :: Escuadron -> Escuadron
escuadronOrganizado escuadron = visitarCampoDeMayo.agregarMascara.gritoDeGuerra $ escuadron

gritoDeGuerra :: Escuadron -> Escuadron
gritoDeGuerra escuadron = escuadron { grupo = map (modificarValentia ((length (nombre escuadron)) * 3)) (grupo escuadron) }

agregarMascara :: Escuadron -> Escuadron 
agregarMascara escuadron = escuadron { grupo = map (modificarInventario mascara) (grupo escuadron)}

visitarCampoDeMayo :: Escuadron -> Escuadron
visitarCampoDeMayo escuadron = escuadron {grupo = map (visitarUnLugar campoDeMayo) (grupo escuadron)}