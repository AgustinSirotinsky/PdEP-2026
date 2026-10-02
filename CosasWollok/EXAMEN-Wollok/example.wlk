
class Persona{
   var enfermedades =  #{}
   var temperatura = 36.6
   var celulas  = 3000000
  /*
    HAY DOS TIPPOS DE LISTAS!! lista(COLLECION)puede haber elementos con Ordenrepetidos y colecciones no, ademas las colecciones no tienen orden
    luego tenemos un SET: #{} no se puede repetir ni orden
  */
  method contrae(enfermedad){
      enfermedades.add(enfermedad)
  }
  method estaEnfermoDe(unaEnfermedad){
    enfermedades.contains(unaEnfermedad)
  }
  method temperatura() = temperatura
  method viviUnDia(){
      enfermedades.forEach({enfermedad => enfermedad.afectarA(self)}) //similar a un map
      // cada enfermedad es un elemento del conjunto enfermedades ESTO ES COMO UN LAMDA

  }  


  method celulasAfectadasPorEnfermedadesAgresivas()= enfermedades.filter({enfermedad => enfermedad.agresiva()})
      .map({enfermedad => enfermedad.celulasAmenazadas()})
      .sum()
  method disminuirCelulas(cant){
    celulas -= cant
  }
  method aumeh1ntarTemperatura(cant){
      temperatura += cant
  }
}
const logan = new Persona(
    temperatura  = 36
)
const frank = new Persona(temperatura = 36)

class EnfermedadInfecciosa {
  var celulasAmenazadas = 500
  method celulasAmenazadas() =1000
  method reproducite(){
      celulasAmenazadas *= 2
  }
}




const malaria500 = new EnfermedadInfecciosa ( celulasAmenazadas = 500)
const malaria800 = new EnfermedadInfecciosa (celulasAmenazadas = 800)
const otitis100 = new EnfermedadInfecciosa (celulasAmenazadas =100)


class EnfermedadAutoinmune{ 
  var celulasAmenazadas
  method afectarA(persona){
    persona.disminuirCelulas(celulasAmenazadas)
  }
}

const lupus10000 = new EnfermedadAutoinmune (celulasAmenazadas = 10000)  
  /*
  CLASES!! nos simplifica para no repetir logica!
    class Nombre{}
    va la mayus 

  para crear un objeto es const = new NombreClase


  un conjunto PUEDE SER un const porque si


  Puedo pasar un Bloque (funcion lambda) Como parametro! usando var por ejemplo

  En un colque puedo pasar mas de un elemento
  apply permite que se aplique el lamda a algo

  DIAGRAMAS
    de clases hay una para cada uno y una flecha (llena) indicando con uqien se
    relaciona. Si la flecha tiene un "*" significa que tiene muchos 
      ______________________________
      |(c) EnfermedadesInfecciosa   |
      |_____________________________|
      | celulasAmenzadas            |
      |                             |
      |_____________________________|
      |esAgresivaPara(persona)      |
      |afectar(persona)             |
      |reproducir()                 |
      |                             |
      |_____________________________|


      En el momento del examen tengo que hacer los diagrmas de clase

      PARA cuando se repite la interfaz hago un cuadrado afuera qeu tenga una (i)
      la cual se conectara con la persona (en este caso)

      Despues las clsaes con la interfaz repetida se una al cuadrado con flecha VACIA


      RECORDAR QUE SON DISTINTAS!!!!!!!!



*/