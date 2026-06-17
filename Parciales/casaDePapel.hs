import Text.Show.Functions

data Ladron = Ladron {
    nombreLadron :: String,
    habilidades:: [String],
    armas :: [Arma]
} deriving (Show)

data Rehen = Rehen {
    nombreRehen :: String,
    nivelDeComplot :: Int,
    nivelDeMiedo :: Int,
    planContraLadron :: [Plan]
} deriving (Show)

type Arma = Rehen -> Rehen
type Plan = Ladron -> Ladron
modificarComplot :: Int -> Rehen -> Rehen
modificarComplot numero rehen = rehen {nivelDeComplot = (+) (nivelDeComplot rehen) numero}

modificarmiedo :: Int -> Rehen -> Rehen
modificarmiedo numero rehen = rehen { nivelDeComplot = (+) (nivelDeMiedo rehen) numero}


pistola :: Int -> Arma
pistola calibre rehen =  modificarmiedo (div (length(nombreRehen rehen)) 3).modificarComplot (-(5*calibre))$ rehen

ametralladora :: Int -> Arma
ametralladora balas rehen = modificarmiedo balas.modificarComplot (-(div (nivelDeComplot rehen) 2))$ rehen 

disparos :: Rehen -> Ladron -> Rehen
disparos rehen ladron  = (compararArmas rehen (armas ladron)) rehen

compararArmas :: Rehen -> [Arma] -> Arma
compararArmas rehen (x:[]) = x
compararArmas rehen (x:xs:xss) 
    | (nivelDeMiedo(x rehen)) > (nivelDeMiedo(xs rehen)) = compararArmas rehen (x:xss)
    | otherwise = compararArmas rehen (xs:xss)


hacerseElMalo :: Rehen -> Ladron-> Rehen
hacerseElMalo rehen ladron
    | (nombreLadron ladron) == "Berlin" = modificarmiedo (length (concat (habilidades ladron))) rehen
    | (nombreLadron ladron) == "Rio" =modificarComplot 20 rehen
    | otherwise = modificarmiedo 10 rehen

puedenRevelarse :: Rehen -> Bool
puedenRevelarse rehen = (nivelDeComplot rehen) > (nivelDeMiedo rehen)

modificarCantDeArmas :: Int -> Ladron -> Ladron
modificarCantDeArmas cantidad ladron = ladron {armas = drop cantidad (armas ladron)}

atacarAlLadron :: Rehen -> Plan
atacarAlLadron compañero ladron = modificarCantDeArmas (length (nombreRehen compañero)) ladron

esconderse :: Plan
esconderse ladron = modificarCantDeArmas (div (length (habilidades ladron)) 3) ladron

tokio = Ladron "Tokio" ["a", "b"] [pistola 9, pistola 9, ametralladora 30]
profesor = Ladron "Profesor" ["a", "b", "c"] []
pablo = Rehen "Pablo" 40 30 [esconderse]
arturito = Rehen "Arturito" 70 50 [esconderse, atacarAlLadron pablo]

ladronEsInteligente :: Ladron -> Bool
ladronEsInteligente ladron = ((nombreLadron ladron) == "Profesor") || (length (habilidades ladron) > 2)

conseguirUnArma :: Arma -> Ladron -> Ladron
conseguirUnArma arma ladron  = ladron { armas = arma : armas ladron}

intimidarUnRehen :: Rehen -> Ladron -> Rehen
intimidarUnRehen rehen ladron = disparos rehen ladron

intimidarUnRehe' :: Rehen -> Ladron -> Rehen
intimidarUnRehe' rehen ladron = hacerseElMalo rehen ladron

puedeEscapar :: Ladron -> Bool 
puedeEscapar ladron = any ((== "disfrazarse de").take 13) (habilidades ladron)

laCosaPintaMal :: [Ladron] ->  [Rehen] -> Bool
laCosaPintaMal ladrones rehenes = promedio (map nivelDeComplot rehenes) > ((promedio (map nivelDeMiedo rehenes))*(length (concat (map armas ladrones))))

promedio :: [Int] -> Int
promedio niveles = div (sum niveles) (length niveles)

seRebelan :: [Rehen] -> Ladron -> Ladron
seRebelan rehenes ladron = foldl (flip ($)) ladron.concat.map planContraLadron. map (modificarComplot (-10)) $ rehenes

planValencia :: [Ladron] -> [Rehen] -> Int
planValencia ladrones rehenes =(*1000000).length.concat.map armas.map (seRebelan rehenes).map (conseguirUnArma (ametralladora 45))$ ladrones