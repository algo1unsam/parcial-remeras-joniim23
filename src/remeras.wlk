class Remera
{
	var property talle /* numero */
	var property color /* cadena */
	var property costoBase = 80
	var coloresBase = [ "negro", "blanco", "gris" ] 
	
	method recargaPorTalle() { 
		if  ( 48 >= talle and 41 <= talle) return 20
		if ( 32 <= talle and talle <= 40 ) return 0
		else throw new Exception ("Talle inválido")
	}
}

class RLisa inherits Remera
{
	method autor() = "vacio"
	
	method recargaPorColor()
	{
		if( self.buscarSiTieneColorBase() ) return 0
		else return 0.1
	}
	
	method buscarSiTieneColorBase() = coloresBase.contains(color)
	
	method precio() {
		var costoTotal = costoBase
		costoTotal += self.recargaPorTalle()
		costoTotal += costoTotal * self.recargaPorColor()
		return costoTotal
	}
	
	method descuento (sinUsar) = 0.1
	
}

class RBordada inherits Remera
{
	const property cantidadDeColores
	
	method autor() = "vacio"
	
	// TODO Mal calculado el recargo, no coincide con el enunciado.
	method recargaPorBordado() = (cantidadDeColores * 10 ).max(20) 
	
	method descuento (sinUsar) = 0
	 
	//TODO Esto no funciona, tiene problemas con el manejo del efecto, deberías calcular el precio en el momento.
	method precio() =
		costoBase + self.recargaPorTalle() + self.recargaPorBordado() 

}

class RSublimada inherits Remera
{
	var property ancho
	var property alto
	
	// TODO Los costos por derechos dependen de la marca, deberías modelarlo como un objeto.
	//var property marca
	var property autor
	
	method superficie() = ancho * alto
	
	method recargaPorSublimada() = 
		self.superficie() * 0.5
	
	method recargaPorDerechos() = autor.costoPorDerechos() 
	
	// TODO Grave: mal manejado el efecto	
 	method precio() =
		costoBase + self.recargaPorTalle() + self.recargaPorSublimada() + self.recargaPorDerechos()
		
	method descuento(hayConvenio) {
		if( hayConvenio ) return 0.2
		else return 0.1
	}
}

class Copyright {
	var property costoPorDerechos
}