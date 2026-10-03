
//============================CLASES=====================================================
class VagonDePasajeros{
    var largo = 10
    var anchoUtil = 0

    //getter
    method largo()=largo
    method anchoUtil()= anchoUtil
    // setter
    method cargarLargo (unLargo) {
        largo = unLargo
    }
    method cargarAncho(unAncho){
        anchoUtil = unAncho
    }


    //calcular
    method cantidadDePasajeros () {
        if (anchoUtil <= 2.5){
            return largo * 8
        } else {
            return largo * 10
        }
    }

    method pesoMaximo(){
        const suPeso = self.cantidadDePasajeros() *80
        return suPeso
    }
   
    //llevarPasajero
}

class VagonCarga{
    var cargaMaxima = 0


    method cargaMaxima () = cargaMaxima
    method cargarCarga(unNum) {
        cargaMaxima = unNum
    }

    method pesoMaximo (){ 
        const suPeso = cargaMaxima + 160
        return suPeso
    }   

}

class Locomotora {
    var peso = 0
    var pesoMaxQuePuedeArrastar=0
    var velocidadMax = 0 

    method arrastreUtil(){ 
    const suArrastreUtil= pesoMaxQuePuedeArrastar - peso
    return suArrastreUtil
    }
    
    method velocidadMax() = velocidadMax
    method esEficiente (){
        pesoMaxQuePuedeArrastar >= peso * 5
    }
}

class Formacion {
    var locomotoras = #{}
    var vagones = #{}
    //1
    method agregarVagon(unVagon){
        vagones.add(unVagon)
    }
    //2
    method agregarLocomotoras(unaLocomotora){
        locomotoras.add(unaLocomotora)
    }
    //3
    method cantidadVagone(){
        vagones.size()
    }
    //4
    method totalDePasajeros(){
        vagones.sum({vagon => vagon.cantidadDePasajeros()})
    }
    //5
    method cuantosVagonesLivianos(){
        vagones.count({v=>v.pesoMaximo() <2500}) // probablemente deba estar DENTRO DE VAGONES
    }
    //6
    method velMax() {
        locomotoras.map({l=>l.velocidadMax()}).min()
    }
    //7
    method esEficiente(){
        locomotoras.all({l=>l.esEficiente()})
    }
    //8
  
    method arrastreUtilTotal() = locomotoras.sum({ l => l.arrastreUtil() })

    method pesoMaximoVagones() = vagones.sum({ v => v.pesoMaximo() })

    method puedeMoverse() = self.arrastreUtilTotal() >= self.pesoMaximoVagones()

    //9
    method kilosDeEmpujeFaltantes() = self.pesoMaximoVagones() - self.arrastreUtilTotal()

    // 10 
    method vagonMasPesado() = vagones.max({ v => v.pesoMaximo() })

    // 11 
    method cantidadDeUnidades() = locomotoras.size() + vagones.size()
    method pesoTotal() = locomotoras.sum({ l => l.peso() }) + self.pesoMaximoVagones()
    method esCompleja() = self.cantidadDeUnidades() > 20 or self.pesoTotal() > 10000
}

class Deposito{
    const formacion = #{}
    const locomotorasSueltas = #{}
   
    // method agregarUnaFormacion(unaFormacion) {
    //     formacion.add(unaFormacion)
    // }

    method agregarLocomotoraSuelta(unaLocomotora) { locomotorasSueltas.add(unaLocomotora) }

    //10
     method vagonesMasPesados() = formacion.map({ f => f.vagonMasPesado() })

    //11
    method necesitaConductorExperimentado() = formacion.any({ f => f.esCompleja() })
    //12
    method agregarLocomotoraParaQuePuedaMoverse(unaFormacion) {
        if (not unaFormacion.puedeMoverse()) {
            const faltante = unaFormacion.kilosDeEmpujeFaltantes()
            const candidatas = locomotorasSueltas.filter({ l => l.arrastreUtil() >= faltante })
            if (not candidatas.isEmpty()) {
                const elegida = candidatas.first()
                unaFormacion.agregarLocomotora(elegida)
                locomotorasSueltas.remove(elegida)
            }
        }
    } 
 
}

//======================================================================================
const vagonDePasajeros1 = new VagonDePasajeros (
    anchoUtil=2
)
const vagonDePasajeros2= new VagonDePasajeros (
    anchoUtil = 3
)

// const locomotora1 = new Locomotora (
//     peso = 1000
//     pesoMaxQuePuedeArrastar = 12000
//     velocidadMax = 80

   
// )



