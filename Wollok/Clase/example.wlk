// wolok init --help para ver como hacer
// .wlk
// Objetos puros, Java quizas no sea tanto peor una explicacion
// ":r" recargar
// =========================================================================
// Objetos 
//     Repre de un ente computacional que exhibe comportamiento
//         cosaa que hace cosa, Un objeto entiende mensaje  (METODOS)

    

    


object estudiante {
  var energia = 50
  var miTermo =  termo // const PORQUE NO VARIA, NO CAMBIA EL OBJETO
  //Var es como variables, como deccir el struct

  //definir un metodo (mensaje)
  method saludar(alguien) {
    return "Hola " + alguien
  }
  method cebarA(p){
    p.tomarMate(20)
  }
  method tomarMate() {
    miTermo.servirAgua(50)
    energia = energia + 10
  }

  method energia() { //getter --Metodo para que me de su energia
    return energia // me muestra el var
  }

  method pedirTermo(){
    self.termo(termoCeit)
  }

  method termo (unTermo){ //setter para setear
    miTermo = unTermo
  }
}
// Extiste mayor igual += (Creo que se  refiere como era el auto sumarse)

object termoCeit{
  var agua = 500
  method servirAgua(cant) {
      agua -= cant
    }
}

object termo{
  var aguaDisponible = 1000
  method aguaDisponible()= aguaDisponible //OTRA FORMA, ESTO ES SENSILLO PARA UNA SOlA lINEA Y RETURN
  method servirAgua(cantidad){
    if(aguaDisponible-cantidad< 0){
      aguaDisponible = 0
    } else{aguaDisponible = aguaDisponible - cantidad // -= sirve  para ahorrar}
    }
  }
  method volcarse(){
    // aguaDisponible -=500 Reoite codigo!
    self.servirAgua(500) //igual, seria bueno cambiar el nombre SELF ES PARA MODIFICARSE  A UNO MISMO
  }
}

object profe {
  const suTermo = termo
    method tomarMate(cant) {
    suTermo.servirAgua(cant)
  }

}

//PENSAMIENTO TOP DOWN, LO MAS GENERAL A LO ESPECIFICO
//similar a c, es mas el return se usa para saber que devolver.
//Lo que estamos  haciendo es desarrollando los metodos para que despues exhiba comportamiento (Hacer cosa)


// wollok repl (read evaluate print loop) es como el swipl
// si queremos hacer qye haga algo estudiante.saludar("Tati"),   parecido haskell 
//                                 OBJETO.METODO(ARGUMENTOS)

/*
Cada objeto tiene una INTERFAZ, Son los metodos


Los dibujitos son circulos (objetos) y flechas ("Conocen") Es por ahora UNIDIRECCIONAL
=====================================================================
  object
  var (Atributo) / const (No cambia)
  OBJETO.METODO(ARGUMENTOS)
  Metodo Getter
  LOS METODOS O DEVUELVEN O HACEN ALGO, NO LOS DOS
  Self
  Delegacion
  EXISTE EL IF() Y ELSE
  ===================================================================

Cambiar puerto "Wollok repl Archivo -port X"
*/
