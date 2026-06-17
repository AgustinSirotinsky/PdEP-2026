data Sustancia = Elemento {
    nombre :: String,
    simbolo :: String,
    numeroAtomico :: Int, 
    grupo :: Grupos
    } 

    |

    Compuesto {
    nombre :: String, 
    formula :: String,
    grupo :: Grupos,
    componentes :: [(Sustancia,Int)]

    }

data Grupos = Metal|NoMetal|Halogeno|GasNoble deriving (Show, Eq)

metalHomosexual :: Sustancia 
metalHomosexual = Elemento "Metal Homosexual" "HOMO" 69 Metal

hidrogeno :: Sustancia
hidrogeno = Elemento "Hidrogeno" "H" 1 NoMetal

oxigeno :: Sustancia
oxigeno = Elemento "Oxigeno" "O" 8 NoMetal

mercurio :: Sustancia  
mercurio = Elemento "Mercurio" "M" 12 Metal

agua::Sustancia
agua = Compuesto "Agua" "H2O" NoMetal [(hidrogeno,2),(oxigeno,1)]

data Conducir = Calor | Electricidad  deriving (Show, Eq)
conduceBien :: Conducir -> Sustancia -> Bool
conduceBien criterio sustancia  = esMetal (sustancia) || (esGasNobleYElectricidad criterio sustancia) || (halogenoYMetal criterio sustancia)

esMetal :: Sustancia -> Bool
esMetal sustancia = (grupo sustancia) == Metal

halogenoYMetal :: Conducir -> Sustancia -> Bool
halogenoYMetal criterio sustancia = (criterio == Calor) && ((grupo sustancia)== Halogeno)

esGasNobleYElectricidad :: Conducir -> Sustancia -> Bool
esGasNobleYElectricidad criterio sustancia = (criterio == Electricidad) && ((grupo sustancia)== GasNoble)

--Punto 3


esVocal :: [Char] -> Bool
esVocal ['a'] = True
esVocal ['o'] = True
esVocal ['e'] = True
esVocal ['i'] = True
esVocal ['u'] = True
esVocal [_] = False

nombreUnion:: Sustancia  -> String
nombreUnion sustancia = (++ "uro").hastaVocal.reverse   nombre $sustancia

hastaVocal :: String -> String
hastaVocal [] = []
hastaVocal palabra 
    | esVocal (take 1 palabra) = hastaVocal (drop 1 palabra)
    | otherwise = reverse palabra


--Punto 3
combinar :: Sustancia -> Sustancia -> String
combinar sustancia otraSustancia  = (nombreUnion sustancia) ++ " de " ++    nombre otraSustancia


--Punto 5

