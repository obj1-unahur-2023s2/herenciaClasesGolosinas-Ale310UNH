/*
 * Los sabores
 */
object frutilla { }
object chocolate { }
object vainilla { }
object naranja { }
object limon { }


/*
 * Golosinas
 */
 
 class Golosina {
 	var peso
 	var precio
 	var sabor
 	
 	method libreGluten() = true
 	method peso() = peso
 	method precio() = precio
 	method sabor() = sabor
 }
 
class Bombon inherits Golosina(peso = 15, precio = 5, sabor = frutilla) {
	
	method mordisco() {
		peso = 0.max(peso * 0.8 - 1)
	}
}

class BombonDuro inherits Bombon {
	
	method gradoDureza() = if(peso >= 12) 3 else if(peso.between(9, 12)) 2 else 1
	override method mordisco() { peso = 0.max(peso - 1)}
}


class Alfajor inherits Golosina(peso = 15, precio = 12, sabor = chocolate) {
	method mordisco() { peso = peso * 0.8 }
	override method libreGluten() { return false }
}

class Caramelo inherits Golosina(peso = 5, precio = 12) {
	
	method mordisco() { peso = peso - 1 }
}

class CarameloCorazonDeChocolate inherits Caramelo {
	
	override method mordisco() {
		super()
		sabor = chocolate
	}
	
	override method precio() {
		return super() + 1
	}
}


class Chupetin inherits Golosina(peso = 7, precio = 2, sabor = naranja) {
	method mordisco() { 
		if (peso >= 2) {
			peso = peso * 0.9
		}
	}
}

class Oblea inherits Golosina(peso = 250, precio = 5, sabor = vainilla) {
	method mordisco() {
		if (peso >= 70) {
			// el peso pasa a ser la mitad
			peso = peso * 0.5
		} else { 
			// pierde el 25% del peso
			peso = peso - (peso * 0.25)
		}
	}
	override method libreGluten() = false 
}

class ObleaCrujiente inherits Oblea {
	var cantidadDeMordiscos = 0
	
	override method mordisco() {
		super()
		cantidadDeMordiscos += 1
		if(cantidadDeMordiscos <= 3) {
			peso -= 3
		}
	}
	
	method estaDebil() = cantidadDeMordiscos > 3
}

class Chocolatin {
	// hay que acordarse de *dos* cosas, el peso inicial y el peso actual
	// el precio se calcula a partir del precio inicial
	// el mordisco afecta al peso actual
	var pesoInicial
	var comido = 0
	
	method pesoInicial(unPeso) { pesoInicial = unPeso }
	method precio() = pesoInicial * 0.50
	method peso() = (pesoInicial - comido).max(0)
	method mordisco() { comido = comido + 2}
	method sabor() = chocolate
	method libreGluten() = false 
}

class ChocolatinVIP inherits Chocolatin {
	var humedad
	
	override method peso() {
		return
		super() * (1 + self.humedad())
	}
	
	method humedad(valor) {
		humedad = valor
	}
	
	method humedad() = humedad
}

class Chocolatinpremium inherits ChocolatinVIP {
	override method humedad() {
		return super() / 2
	}
}

class GolosinaBaniada {
	var golosinaInterior
	var pesoBanio = 4
	
	method golosinaInterior(unaGolosina) { golosinaInterior = unaGolosina }
	method precio() { return golosinaInterior.precio() + 2 }
	method peso() { return golosinaInterior.peso() + pesoBanio }
	method mordisco() {
		golosinaInterior.mordisco()
		pesoBanio = (pesoBanio - 2).max(0) 
	}	
	method sabor() { return golosinaInterior.sabor() }
	method libreGluten() { return golosinaInterior.libreGluten() }	
}


class Tuttifrutti {
	var libreDeGluten
	const sabores = [frutilla, chocolate, naranja]
	var saborActual = 0
	
	method mordisco() { saborActual += 1 }	
	method sabor() { return sabores.get(saborActual % 3) }	
	method precio() { return (if(self.libreGluten()) 7 else 10) }
    method libreGluten() { return libreDeGluten }
	
	method libreGluten(valor) { libreDeGluten = valor }
}
