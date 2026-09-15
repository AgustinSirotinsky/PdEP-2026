object pepita {
  var energia = 1
  var ubicacion = "Buenos Aires"

 method come(unosGramos) {
   energia = energia + (4*unosGramos)
 }
 method vola(km){
   energia = energia - (10 + km)
 }

 method viajaHasta(lugar){
   ubicacion = lugar

 }
 //getter
 method energia () = energia
 /*
 method energia(){
    return energia
 }
 */
 //setter
//  method ubicacion(lugar){
//     ubicacion = lugar
//  }
}


// object buenosAires {
//  const km = 0
// }