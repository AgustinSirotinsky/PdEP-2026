import Text.Show.Functions
import Data.List
import Data.Char (isUpper)

data Plomero = Plomero {
    nombre :: String,
    cajaDeHerramientas :: [Herramienta],
    historial :: [Reparacion],
    dinero :: Double
} deriving (Show)

data Material = Hierro | Madera | Goma | Plastico deriving (Show,Eq)

type Herramienta = (String, Double , Material)

data Reparacion = Reparacion {
    descripcion :: String,
    requerimiento :: Plomero -> Bool
} deriving (Show)

--Punto 1

mario = Plomero "Mario" [("Llave Inglesa", 200, Hierro), ("Martillo", 20, Madera)] [] 1200 

wario = Plomero "Wario" (infinitasLlaves 1) [] 0.50

infinitasLlaves :: Double -> [Herramienta]
infinitasLlaves precioOriginal = ("Llave Inglesa", precioOriginal, Hierro) : (infinitasLlaves (precioOriginal + 1))

--Punto 2
tieneHerramienta :: String -> Plomero -> Bool
tieneHerramienta herramienta plomero = any ((== herramienta)) (map fst3 (cajaDeHerramientas plomero))

fst3 :: Herramienta ->  String
fst3 (nombre, _ , _) = nombre

tieneHerramienta' :: String -> Plomero -> Bool
tieneHerramienta' herramienta plomero = any ((== herramienta).fst3) (cajaDeHerramientas plomero)

esMalvado :: Plomero -> Bool
esMalvado plomero = (=="Wa").take 2.nombre $ plomero

puedeComprarHerramienta :: Herramienta -> Plomero -> Bool
puedeComprarHerramienta (nombre, precio, _) plomero= ((dinero plomero) > precio)

--Ejercico 3

herramientaEsBuena :: Herramienta -> Bool
herramientaEsBuena (nombre, precio, material)= ((material == Hierro)&&(precio > 10000)) && ((nombre == "Martillo")&&((material == Madera)||(material == Goma)))

--Punto 4
comprar :: Herramienta -> Plomero -> Plomero
comprar (n, p, m) plomero 
    |puedeComprarHerramienta (n, p, m) plomero = plomero {cajaDeHerramientas = (n, p, m): (cajaDeHerramientas plomero), dinero = (dinero plomero)- p}
    | otherwise = plomero

--Punto 5 
filtracionDeAgua = Reparacion "filtracion de agua" (tieneHerramienta "Llave Inglesa")

reparacionDificil :: Reparacion -> Bool
reparacionDificil reparacion = ((length (descripcion reparacion))>100) && (all isUpper (descripcion reparacion))

presupuesto :: Reparacion -> Double
presupuesto reparacion = fromIntegral ( (length(descripcion reparacion)) * 3)

--Punto 6
dineroNuevo :: Double -> Plomero -> Plomero
dineroNuevo numero plomero = plomero {dinero = numero + (dinero plomero)}

agregarHistorial :: Reparacion -> Plomero -> Plomero
agregarHistorial reparacion plomero = plomero {historial = reparacion : (historial plomero)}

reaparacion :: Reparacion -> Plomero -> Plomero
reaparacion reparacion plomero 
    | (requerimiento reparacion) plomero = dineroNuevo (presupuesto reparacion).cosasAdicionales reparacion $ plomero 
    | otherwise = dineroNuevo 100 plomero

cosasAdicionales :: Reparacion -> Plomero -> Plomero
cosasAdicionales reaparacion plomero 
    | (esMalvado plomero) && (reparacionDificil reaparacion)  = plomero {cajaDeHerramientas = ("Destornillador",0,Plastico): (cajaDeHerramientas plomero)}
    | (reparacionDificil reaparacion) = plomero {cajaDeHerramientas = []}
    | otherwise = plomero {cajaDeHerramientas = drop 1 (cajaDeHerramientas plomero)} 

--Punto 7

jornadaDeTrabajo :: [Reparacion] -> Plomero -> Plomero
jornadaDeTrabajo reparaciones plomero = foldl (flip reaparacion) plomero reparaciones

--Punto 8
