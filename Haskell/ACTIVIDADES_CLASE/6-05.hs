lista n m
    | n == m = [n]
    | otherwise = n :  lista (n + 1) m

doble x = x + x
-- doble 7 = 7 + 7 = 14
-- doble (2+3) = 5 + 5 = 10

{-

tieneNombreLargo mascota = length (fst mascota) > 9 == True

poderDeEspada largoDeHoja
    | largoDeHoja > 10 = 50
    | largoDeHoja > 20 = 100
    | largoDeHoja < 0 = error

sumarEnergia (Persona _ energia _ _) = (Persona _ (energia + 5) _ _)

triplicarLosPares numeros = (map (*3) . filter . even) numeros

sonTodosMamiferos animales = all (map esMamifero animales) animales
sonTodosMamiferos animales = (and . map esMamifero) animales

abrirVentanas :: Casa -> Casa
prenderEstufa :: Casa -> Casa
encenderElAire :: Casa -> Int -> Casa
mudarseA :: Casa -> Casa
miCasaInteligente ::Casa {
    direccion = "Medrano 951"
    temperatura = 26
    reguladores = [abrirVentanas, prenderEstufa, mudarseA, encenderElAireA 24]
}

esBeatle _ = False
esBeatle "Ringo" = True
esBeatle "Jhon" = True
esBeatle "Paul" = True
esBeatle "George" = True

sumaDeLasEdades [] = 0
sumaDeLasEdades lista = 
    edad (head lista) + sumaDeLasEdades (drop 1 lista)

abrirVentanas casa =
    casa { direccion = direccion.casa,
           temperatura = temperatura.casa -2
           reguladoresDeTemperatura = reguladoresDeTemperatura casa }
    
    j r (sum (map (*3) filter even r))) < 100

-}

tieneNombreLargo mascota = length (fst mascota) > 9

poderDeEspada largoDeHoja --Invertir el >20 con el >10 asi primero revisa si es mayor a 20 Y DESPUES si es mayor a 10
    | largoDeHoja > 20 = 100
    | largoDeHoja > 10 = 50

--sumarEnergia (Persona a energia b c) = (Persona a (energia + 5) b c)

triplicarLosPares numeros = (map (*3) . filter even) numeros
triplicarLosPares numeros = map (*3) . filter even $ numeros

--sonTodosMamiferos animales = all.map esMamifero $ animales
--sonTodosMamiferos animales = and . map esMamifero $ animales

{-
abrirVentanas :: Casa -> Casa
prenderEstufa :: Casa -> Casa
encenderElAire :: Casa -> Int -> Casa
mudarseA :: Casa -> Casa
miCasaInteligente :: Casa {
    direccion = "Medrano 951"
    temperatura = 26
    reguladores = [abrirVentanas, prenderEstufa, mudarseA "blablabla", flip encenderElAireA 24]
}
-}

sumaDeLasEdades [] = 0
--x sumaDeLasEdades lista = sum . map edad
