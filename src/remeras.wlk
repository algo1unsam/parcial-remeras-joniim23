class Remera {

	var property talle /* numero */
	var property color /* cadena */
	var coloresBase = [ "negro", "blanco", "gris" ]

	method costoTalle() {
		if (48 >= talle and 41 <= talle) return 80
		if (32 <= talle and talle <= 40) return 100 else throw new Exception ("Talle inválido")
	}

}

class RLisa inherits Remera {

	method autor() = "vacio"

	method recargaPorColor() {
		if (self.esBasico()) return 1 else return 1.1
	}

	method esBasico() = coloresBase.contains(color)

	method precio() {
		return self.costoTalle() * self.recargaPorColor()
	}

	method descuento() = 0.1

}

class RBordada inherits Remera {

	const property cantidadDeColores

	// TODO Mal calculado el recargo, no coincide con el enunciado.
	method recargaPorBordado() = (cantidadDeColores * 10 ).max(20)

	method descuento() = 0

	// TODO Esto no funciona, tiene problemas con el manejo del efecto, deberías calcular el precio en el momento.
	method precio() = self.costoTalle() + self.recargaPorBordado()

}

class RSublimada inherits Remera {

	var property ancho
	var property alto
	// TODO Los costos por derechos dependen de la marca, deberías modelarlo como un objeto.
	// copyright
	var property autor

	method superficie() = ancho * alto

	method recargaPorSublimada() = self.superficie() * 0.5

	method recargaPorDerechos() = autor.costoPorDerechos()

	// TODO Grave: mal manejado el efecto	
	method precio() = self.costoTalle() + self.recargaPorSublimada() + self.recargaPorDerechos()

	method descuento() {
		if(marca.tengoConvenios()) return 0.2 else return 0.1
	}

}

class Marca {
	var conveniosSucursales = []
	var property costoPorDerechos
	
	method tengoConvenio(){
		return contains
	}
}

