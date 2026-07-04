codo(codo1,rojo).
codo(codo2,azul).
codo(codo3,amarillo).

caño(caño1,rojo,3).
caño(caño2,azul,4).
caño(caño3,amarillo,5).

canilla(canilla1,triangular,rojo,3).
canilla(canilla2,circular,azul,4).
canilla(canilla3,rectangular,amarillo,12).

cañeria(codo1,caño2,canilla3).
cañeria(codo2,caño3,canilla1).
cañeria(codo3,caño1,canilla2).

precio(Pieza,Precio) :-
	codo(Pieza,Color).	


