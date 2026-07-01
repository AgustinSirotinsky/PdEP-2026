import Text.Show.Functions

type Persona = (Int, Int, Int)

edad :: (Int, Int, Int) -> Int
edad (suEdad, _ , _) = suEdad

peso :: (Int, Int, Int)->Int
peso (_, suPeso, _)= suPeso

tonificacion :: (Int, Int, Int)->Int
tonificacion (_, _, suTonificacion) = suTonificacion

type Ejercicio = Int -> Persona -> Persona

relax:: Ejercicio
relax minutos persona = persona

saludable :: Persona -> Bool
saludable persona = (peso persona>100) && (tonificacion persona > 5)

modificarPeso :: Int -> Persona -> Persona 
modificarPeso kilos persona = (edad persona, peso persona - kilos, tonificacion persona  )

bajarDePeso :: Int -> Persona -> Persona
bajarDePeso calorias persona
    | esObesa persona = modificarPeso (div calorias 150) persona
    | ((not.esObesa) persona ) && (edad persona > 30) && (calorias > 200)= modificarPeso 1 persona
    |otherwise = modificarPeso (div calorias (peso persona * edad persona))  persona

esObesa :: Persona -> Bool
esObesa persona = (peso persona>100)

pancho :: Persona
pancho =(40, 120, 1)

andres :: Persona
andres = (22, 80, 6)

ejercicioEnCinta :: Int -> Ejercicio
ejercicioEnCinta distancia minutos persona = bajarDePeso (promedio distancia minutos) persona

promedio :: Int -> Int -> Int
promedio distancia minutos = div distancia minutos