/* 
RESUMENNNNNNN==========================================================================================

metodo es la forma que un objeto entienda un mensaje

Mensajes es lo mas importante

conjunto de mensajes que entiende un objeto es su interfaz (incluyendo los subconjuntos de mensajes)

self es la manera de comunicarse con el objeto mismo 

tiene atributos (var const)->
    - var: puede cambiar su valor
    - const: no puede cambiar su valor
    

un objeto es mas que un atributo, son mas importante los mensajes.

getter y setter son metodos puede mostrar


UN OBJEtO TIENE UNA IDENTIDAD (Propia, SAbe QUIEN ES), por eso entiende el self, sabe quien es 


CREAR UN ARCHIVO wollok init nombreRandom -n nombreRandomads

:r recargar

NO PUEDE HACER UN METODO DOS COSAS O RETURN O EFECTO (Modificar una variable dentro (creo))


PRIMERO PIENSO EN EL METHOD, nO EL ATRIBUTO

K.i.s.s -> keep it short and simple  NO SOBRE PIENSES. Hacer un metodo directo que de el resultado No matarse por agrupar o derivar

CLASE 2================================================================================================
PEPE

estas son las preguntas que me hago cuando quiero resolver un problema

De quien es la responsabilidad de .......? 
Quien tiene la informacion Minima indespensable?

TAMBIEN HAY POLIMORFISMO -> Es cuando un objeto cuando puede usar otros dos objetos, sin importar que sean (inditistamente)
    

ASignacion de responsabilidad


 En el momento de  hacer un if para preguntar el TIPO (este caso categoria) de un objeto, 
    NO CUMPLE EL PARADIGMA. Los if son para > 0 y asi.

    Es mejor que sea un objeto que asuma la responsabilidad de hacer calculo 


Cuando quiero crear un objeto  NECESITO  SABER QUE QUIERO MENSAJE ES EL QUE LE QUIERA MANDAR


    import src.categorias.* Sirve para crear una carpeta Categorias y tener las cosas ordenasda

self es una referencia que tienen todos los objetos asi mismo. Se puede mandar como parametro

el .wtest permite hacer preubas automaticamente, osea yo le doy porejmplo que sea igual a x resultado y bum

            test "Nombre" {
                assert.losMetodos(...)
            }

        1 dado un escenario 
        2 cuando hago algo
        3 espero lo siguiente
*/

object pepe{
    var categoria = desarrollador
    var anioAntiguedad = 5
    var cantidadFaltas = 3
    var bonoPresentismo = gnocci
    var bonoResultado = gnocci

    // haces los setter de las var y gtter tambien ya qu estas

    // ACA IRIAN LOS GETTER PARA QUE ME DEJE USAR VAAR va, para que me los de

    method sueldoTOTAL(){ //el puento sueldo() se va a encargar caluclar todos los sueldos
        return  self.categoriaSueldo() +  self.bonopresentismoSueldo() + self.bonoResultadoSueldo()
    }

    method categoriaSueldo(){
        return categoria.sueldo(anioAntiguedad)
    }
    method bonopresentismoSueldo(){
        return bonoPresentismo.sueldo(self)
    }
    method bonoResultadoSueldo(){
        return bonoResultado.sueldo(self)
    }

    /*Caso mal
    
    method sueldo(){
        const  categoria
        const anioPresentismo
        self.sueldoNeto() + self.bonopresentismo() + self.bonoResultado() // esto esta biennnn

    

        POrque mal?  porque significa que tendria un 
        method sueldoNeto(){} =  if (categoria) elseif (otraCategoria).... // esto esta mal, porque si surgue una nueva categoria tengo que modificar TODOO
        method presentismo(){}
        mehod resultado(){}

        De quien es la responsabilidad de saber el sueldo neto según su categoria?  Este caso esta  mal porque estamos exiuiendo que pepe lo sepa
            y no es quien deberia ser
        Quien tiene la informacion Minima indespensable

    } :v >:v
    */

}

object desarrollador{

    method sueldo(anioAntiguedad){ 
        return  1500 + 50 anioAntiguedad
    }
}

object manager{
    method sueldo(anioAntiguedad){
        return  2000 + 100 anioAntiguedad
    }
}

object gnocci{
    method sueldo(empleado){
        return  2 ** empleado.cantidadFaltas()
    }
}
//por faltas y blah blah   PARA EL porFaltas ahi es bien usado el if

//para no repetir  self puedo crear un const = self.blah blah
// el return de wollok es muy piola. El if es ACÁ se puede usar return if(...)....



/*

=======================TEST===========================================================================
  en la terminal wollok test
  
    los test deben existir dentro de mi DESCRIPCIOn

        Arriba van los import

        describe 'NOMBR'{
            test 'cuando Y le doy los parametros del caso'
                pepe.categoria(desarrollador) //es el setter
                pepe.bonoResultado(nulo)
                pepe.bonoPresentismo(nulo) 
                pepe.cantFaltas(0).... //los demas setter

                assert.that(pepe.sueldo() == 1000) //"Asegurame que se cumple eso"
        }



Si queres podes cualquier cosa meintras assert.that(BOOL)

Otra cosa que podes usar es "equals (iguales)"  en ves de "that(Bool)" Para una igualdad


RECOMENDADO QUE SEA UN NOMBRE ESPECIFICO EL TEST, para saber que hiciste para el orto

Uno suel testear los distintos flujos y casos borde

    Casos borde es cuando hay if en teoria


otro como equals tenes notThat, entre mucho mas

el test no asegura que esté BIEN hecho, solo que Cumple la condicion que le doy

 %%%%%%%%Utiles%%%%%%%%%
    equals
    that
    notThat
 %%%%%%%%%%%%%%%%%%%%%%%



 Dentro de un describe puedo dsesarrollar un metodo.
=======================================================================================================

MUY ATENTO AQUIE TIENE LA RESPONSABILIDAD PORQUE UN OBEJTO AJENO NO DEBERIA MODIFICAR UN OBJETO AJENO LOS ATRIBUTOS DE OTRO. lo que 
    si puedo hacer, es una invoncar un metodo que lo modifique eel mismo objeto. No desarrollarla en el ajeno

    CONLSUION, NO CAMBIAR DE AFUERA, como mucho llamar el metodo que ya tiene el objetoa modificar


obj.mensaje().___ es muy probable que sea jurisdiccion del otro. NUNCA ROMPER ENCAPSULAMENTE



EN lso test esta mas permitido


LAS TRES PATAS DEL PARADIGMA ES ASIGNACION RESPON POLI ENCAPS



*/